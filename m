Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67D178319A
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 21:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjHUTvn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHUTvm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:51:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E86FB
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:51:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6BB26444D
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B481EC433C7;
        Mon, 21 Aug 2023 19:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647499;
        bh=J36NlGXUopwVycdST2nC0uYi5Gjb1g39h5dQ6u7Xf+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHLaOh0aG9GK59DG799sAKO54upsEfyIVLHFVLaPoeMsAMLfNV64opLGD/rn23jIE
         WvLNEnnABJ7JOXYBgQNGDaWDHjrVkrh4278IGRCc0OIAFxzJYtJIsY3jUUWs+17reX
         4O88ovh3U3HYKI7L9PzKSkotpIj54u6sQt8LgcVQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "D. Wythe" <alibuda@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 008/194] net/smc: replace mutex rmbs_lock and sndbufs_lock with rw_semaphore
Date:   Mon, 21 Aug 2023 21:39:47 +0200
Message-ID: <20230821194123.083249090@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: D. Wythe <alibuda@linux.alibaba.com>

[ Upstream commit aff7bfed9097435ea38de919befbe2d7771a3e87 ]

It's clear that rmbs_lock and sndbufs_lock are aims to protect the
rmbs list or the sndbufs list.

During connection establieshment, smc_buf_get_slot() will always
be invoked, and it only performs read semantics in rmbs list and
sndbufs list.

Based on the above considerations, we replace mutex with rw_semaphore.
Only smc_buf_get_slot() use down_read() to allow smc_buf_get_slot()
run concurrently, other part use down_write() to keep exclusive
semantics.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 833bac7ec392 ("net/smc: Fix setsockopt and sysctl to specify same buffer size again")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_core.c | 55 +++++++++++++++++++++++-----------------------
 net/smc/smc_core.h |  4 ++--
 net/smc/smc_llc.c  | 16 +++++++-------
 3 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index f82f43573a159..f793101e0ecc3 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -852,8 +852,8 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	lgr->freeing = 0;
 	lgr->vlan_id = ini->vlan_id;
 	refcount_set(&lgr->refcnt, 1); /* set lgr refcnt to 1 */
-	mutex_init(&lgr->sndbufs_lock);
-	mutex_init(&lgr->rmbs_lock);
+	init_rwsem(&lgr->sndbufs_lock);
+	init_rwsem(&lgr->rmbs_lock);
 	rwlock_init(&lgr->conns_lock);
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
 		INIT_LIST_HEAD(&lgr->sndbufs[i]);
@@ -1095,7 +1095,7 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
 			   struct smc_link_group *lgr)
 {
-	struct mutex *lock;	/* lock buffer list */
+	struct rw_semaphore *lock;	/* lock buffer list */
 	int rc;
 
 	if (is_rmb && buf_desc->is_conf_rkey && !list_empty(&lgr->list)) {
@@ -1115,9 +1115,9 @@ static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
 		/* buf registration failed, reuse not possible */
 		lock = is_rmb ? &lgr->rmbs_lock :
 				&lgr->sndbufs_lock;
-		mutex_lock(lock);
+		down_write(lock);
 		list_del(&buf_desc->list);
-		mutex_unlock(lock);
+		up_write(lock);
 
 		smc_buf_free(lgr, is_rmb, buf_desc);
 	} else {
@@ -1220,15 +1220,16 @@ static void smcr_buf_unmap_lgr(struct smc_link *lnk)
 	int i;
 
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
-		mutex_lock(&lgr->rmbs_lock);
+		down_write(&lgr->rmbs_lock);
 		list_for_each_entry_safe(buf_desc, bf, &lgr->rmbs[i], list)
 			smcr_buf_unmap_link(buf_desc, true, lnk);
-		mutex_unlock(&lgr->rmbs_lock);
-		mutex_lock(&lgr->sndbufs_lock);
+		up_write(&lgr->rmbs_lock);
+
+		down_write(&lgr->sndbufs_lock);
 		list_for_each_entry_safe(buf_desc, bf, &lgr->sndbufs[i],
 					 list)
 			smcr_buf_unmap_link(buf_desc, false, lnk);
-		mutex_unlock(&lgr->sndbufs_lock);
+		up_write(&lgr->sndbufs_lock);
 	}
 }
 
@@ -1986,19 +1987,19 @@ int smc_uncompress_bufsize(u8 compressed)
  * buffer size; if not available, return NULL
  */
 static struct smc_buf_desc *smc_buf_get_slot(int compressed_bufsize,
-					     struct mutex *lock,
+					     struct rw_semaphore *lock,
 					     struct list_head *buf_list)
 {
 	struct smc_buf_desc *buf_slot;
 
-	mutex_lock(lock);
+	down_read(lock);
 	list_for_each_entry(buf_slot, buf_list, list) {
 		if (cmpxchg(&buf_slot->used, 0, 1) == 0) {
-			mutex_unlock(lock);
+			up_read(lock);
 			return buf_slot;
 		}
 	}
-	mutex_unlock(lock);
+	up_read(lock);
 	return NULL;
 }
 
@@ -2107,13 +2108,13 @@ int smcr_link_reg_buf(struct smc_link *link, struct smc_buf_desc *buf_desc)
 	return 0;
 }
 
-static int _smcr_buf_map_lgr(struct smc_link *lnk, struct mutex *lock,
+static int _smcr_buf_map_lgr(struct smc_link *lnk, struct rw_semaphore *lock,
 			     struct list_head *lst, bool is_rmb)
 {
 	struct smc_buf_desc *buf_desc, *bf;
 	int rc = 0;
 
-	mutex_lock(lock);
+	down_write(lock);
 	list_for_each_entry_safe(buf_desc, bf, lst, list) {
 		if (!buf_desc->used)
 			continue;
@@ -2122,7 +2123,7 @@ static int _smcr_buf_map_lgr(struct smc_link *lnk, struct mutex *lock,
 			goto out;
 	}
 out:
-	mutex_unlock(lock);
+	up_write(lock);
 	return rc;
 }
 
@@ -2155,37 +2156,37 @@ int smcr_buf_reg_lgr(struct smc_link *lnk)
 	int i, rc = 0;
 
 	/* reg all RMBs for a new link */
-	mutex_lock(&lgr->rmbs_lock);
+	down_write(&lgr->rmbs_lock);
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
 		list_for_each_entry_safe(buf_desc, bf, &lgr->rmbs[i], list) {
 			if (!buf_desc->used)
 				continue;
 			rc = smcr_link_reg_buf(lnk, buf_desc);
 			if (rc) {
-				mutex_unlock(&lgr->rmbs_lock);
+				up_write(&lgr->rmbs_lock);
 				return rc;
 			}
 		}
 	}
-	mutex_unlock(&lgr->rmbs_lock);
+	up_write(&lgr->rmbs_lock);
 
 	if (lgr->buf_type == SMCR_PHYS_CONT_BUFS)
 		return rc;
 
 	/* reg all vzalloced sndbufs for a new link */
-	mutex_lock(&lgr->sndbufs_lock);
+	down_write(&lgr->sndbufs_lock);
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
 		list_for_each_entry_safe(buf_desc, bf, &lgr->sndbufs[i], list) {
 			if (!buf_desc->used || !buf_desc->is_vm)
 				continue;
 			rc = smcr_link_reg_buf(lnk, buf_desc);
 			if (rc) {
-				mutex_unlock(&lgr->sndbufs_lock);
+				up_write(&lgr->sndbufs_lock);
 				return rc;
 			}
 		}
 	}
-	mutex_unlock(&lgr->sndbufs_lock);
+	up_write(&lgr->sndbufs_lock);
 	return rc;
 }
 
@@ -2305,8 +2306,8 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 	struct smc_link_group *lgr = conn->lgr;
 	struct list_head *buf_list;
 	int bufsize, bufsize_short;
+	struct rw_semaphore *lock;	/* lock buffer list */
 	bool is_dgraded = false;
-	struct mutex *lock;	/* lock buffer list */
 	int sk_buf_size;
 
 	if (is_rmb)
@@ -2354,9 +2355,9 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 		SMC_STAT_RMB_ALLOC(smc, is_smcd, is_rmb);
 		SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, bufsize);
 		buf_desc->used = 1;
-		mutex_lock(lock);
+		down_write(lock);
 		list_add(&buf_desc->list, buf_list);
-		mutex_unlock(lock);
+		up_write(lock);
 		break; /* found */
 	}
 
@@ -2430,9 +2431,9 @@ int smc_buf_create(struct smc_sock *smc, bool is_smcd)
 	/* create rmb */
 	rc = __smc_buf_create(smc, is_smcd, true);
 	if (rc) {
-		mutex_lock(&smc->conn.lgr->sndbufs_lock);
+		down_write(&smc->conn.lgr->sndbufs_lock);
 		list_del(&smc->conn.sndbuf_desc->list);
-		mutex_unlock(&smc->conn.lgr->sndbufs_lock);
+		up_write(&smc->conn.lgr->sndbufs_lock);
 		smc_buf_free(smc->conn.lgr, false, smc->conn.sndbuf_desc);
 		smc->conn.sndbuf_desc = NULL;
 	}
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 285f9bd8e232e..6051d92270130 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -252,9 +252,9 @@ struct smc_link_group {
 	unsigned short		vlan_id;	/* vlan id of link group */
 
 	struct list_head	sndbufs[SMC_RMBE_SIZES];/* tx buffers */
-	struct mutex		sndbufs_lock;	/* protects tx buffers */
+	struct rw_semaphore	sndbufs_lock;	/* protects tx buffers */
 	struct list_head	rmbs[SMC_RMBE_SIZES];	/* rx buffers */
-	struct mutex		rmbs_lock;	/* protects rx buffers */
+	struct rw_semaphore	rmbs_lock;	/* protects rx buffers */
 
 	u8			id[SMC_LGR_ID_SIZE];	/* unique lgr id */
 	struct delayed_work	free_work;	/* delayed freeing of an lgr */
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 760f8bbff822e..fcb24a0ccf761 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -611,7 +611,7 @@ static int smc_llc_fill_ext_v2(struct smc_llc_msg_add_link_v2_ext *ext,
 
 	prim_lnk_idx = link->link_idx;
 	lnk_idx = link_new->link_idx;
-	mutex_lock(&lgr->rmbs_lock);
+	down_write(&lgr->rmbs_lock);
 	ext->num_rkeys = lgr->conns_num;
 	if (!ext->num_rkeys)
 		goto out;
@@ -631,7 +631,7 @@ static int smc_llc_fill_ext_v2(struct smc_llc_msg_add_link_v2_ext *ext,
 	}
 	len += i * sizeof(ext->rt[0]);
 out:
-	mutex_unlock(&lgr->rmbs_lock);
+	up_write(&lgr->rmbs_lock);
 	return len;
 }
 
@@ -892,7 +892,7 @@ static int smc_llc_cli_rkey_exchange(struct smc_link *link,
 	int rc = 0;
 	int i;
 
-	mutex_lock(&lgr->rmbs_lock);
+	down_write(&lgr->rmbs_lock);
 	num_rkeys_send = lgr->conns_num;
 	buf_pos = smc_llc_get_first_rmb(lgr, &buf_lst);
 	do {
@@ -919,7 +919,7 @@ static int smc_llc_cli_rkey_exchange(struct smc_link *link,
 			break;
 	} while (num_rkeys_send || num_rkeys_recv);
 
-	mutex_unlock(&lgr->rmbs_lock);
+	up_write(&lgr->rmbs_lock);
 	return rc;
 }
 
@@ -1002,14 +1002,14 @@ static void smc_llc_save_add_link_rkeys(struct smc_link *link,
 	ext = (struct smc_llc_msg_add_link_v2_ext *)((u8 *)lgr->wr_rx_buf_v2 +
 						     SMC_WR_TX_SIZE);
 	max = min_t(u8, ext->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
-	mutex_lock(&lgr->rmbs_lock);
+	down_write(&lgr->rmbs_lock);
 	for (i = 0; i < max; i++) {
 		smc_rtoken_set(lgr, link->link_idx, link_new->link_idx,
 			       ext->rt[i].rmb_key,
 			       ext->rt[i].rmb_vaddr_new,
 			       ext->rt[i].rmb_key_new);
 	}
-	mutex_unlock(&lgr->rmbs_lock);
+	up_write(&lgr->rmbs_lock);
 }
 
 static void smc_llc_save_add_link_info(struct smc_link *link,
@@ -1316,7 +1316,7 @@ static int smc_llc_srv_rkey_exchange(struct smc_link *link,
 	int rc = 0;
 	int i;
 
-	mutex_lock(&lgr->rmbs_lock);
+	down_write(&lgr->rmbs_lock);
 	num_rkeys_send = lgr->conns_num;
 	buf_pos = smc_llc_get_first_rmb(lgr, &buf_lst);
 	do {
@@ -1341,7 +1341,7 @@ static int smc_llc_srv_rkey_exchange(struct smc_link *link,
 		smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
 	} while (num_rkeys_send || num_rkeys_recv);
 out:
-	mutex_unlock(&lgr->rmbs_lock);
+	up_write(&lgr->rmbs_lock);
 	return rc;
 }
 
-- 
2.40.1



