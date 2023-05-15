Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245FC70346E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbjEOQs0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243016AbjEOQsX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:48:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109565260
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29BAA62925
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA09C433EF;
        Mon, 15 May 2023 16:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169284;
        bh=xNOXRCWgfnAYfImjNtYYaDmHq3W8p9M3utCo1WQo9NQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBGxbX4D3Bj0oyy24IftwmDuwD+Z223YO8EUXPFCz+7cRPQzYyNx4Bg4xB4eeNYRc
         lWYG97tZgoSCNCr+wvnxqD1daMFngR8yuABuocfOLfA0BpJm2acsv99mUKdnCQHyRO
         SxlgHrq0CS/IcTpBsGj1spF3GTK6mCeIyzOoIeSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 010/246] RDMA/rxe: Change rxe_dbg to rxe_dbg_dev
Date:   Mon, 15 May 2023 18:23:42 +0200
Message-Id: <20230515161722.926119386@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bob Pearson <rpearsonhpe@gmail.com>

[ Upstream commit a9fb3287211e64b94ceb2b6b4791cc2b829d0d56 ]

Replace the name rxe_dbg with rxe_dbg_dev which better matches
the remaining rxe_dbg_xxx macros for debug messages with a
rxe device parameter. Reuse the name rxe_dbg for debug messages
which do not have a rxe device parameter.

Link: https://lore.kernel.org/r/20230303221623.8053-3-rpearsonhpe@gmail.com
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Stable-dep-of: 78b26a335310 ("RDMA/rxe: Remove tasklet call from rxe_cq.c")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe.c       |  2 +-
 drivers/infiniband/sw/rxe/rxe.h       |  3 ++-
 drivers/infiniband/sw/rxe/rxe_cq.c    |  6 +++---
 drivers/infiniband/sw/rxe/rxe_icrc.c  |  4 ++--
 drivers/infiniband/sw/rxe/rxe_mmap.c  |  6 +++---
 drivers/infiniband/sw/rxe/rxe_net.c   |  4 ++--
 drivers/infiniband/sw/rxe/rxe_qp.c    | 16 ++++++++--------
 drivers/infiniband/sw/rxe/rxe_srq.c   |  6 +++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
 9 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index a3f05fdd9fac2..d57ba7a5964b9 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -187,7 +187,7 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	rxe = rxe_get_dev_from_net(ndev);
 	if (rxe) {
 		ib_device_put(&rxe->ib_dev);
-		rxe_dbg(rxe, "already configured on %s\n", ndev->name);
+		rxe_dbg_dev(rxe, "already configured on %s\n", ndev->name);
 		err = -EEXIST;
 		goto err;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 2415f3704f576..0757acc381038 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -38,7 +38,8 @@
 
 #define RXE_ROCE_V2_SPORT		(0xc000)
 
-#define rxe_dbg(rxe, fmt, ...) ibdev_dbg(&(rxe)->ib_dev,		\
+#define rxe_dbg(fmt, ...) pr_debug("%s: " fmt "\n", __func__, ##__VA_ARGS__)
+#define rxe_dbg_dev(rxe, fmt, ...) ibdev_dbg(&(rxe)->ib_dev,		\
 		"%s: " fmt, __func__, ##__VA_ARGS__)
 #define rxe_dbg_uc(uc, fmt, ...) ibdev_dbg((uc)->ibuc.device,		\
 		"uc#%d %s: " fmt, (uc)->elem.index, __func__, ##__VA_ARGS__)
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index faf49c50bbaba..519ddec29b4ba 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -14,12 +14,12 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
 	int count;
 
 	if (cqe <= 0) {
-		rxe_dbg(rxe, "cqe(%d) <= 0\n", cqe);
+		rxe_dbg_dev(rxe, "cqe(%d) <= 0\n", cqe);
 		goto err1;
 	}
 
 	if (cqe > rxe->attr.max_cqe) {
-		rxe_dbg(rxe, "cqe(%d) > max_cqe(%d)\n",
+		rxe_dbg_dev(rxe, "cqe(%d) > max_cqe(%d)\n",
 				cqe, rxe->attr.max_cqe);
 		goto err1;
 	}
@@ -50,7 +50,7 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 	cq->queue = rxe_queue_init(rxe, &cqe,
 			sizeof(struct rxe_cqe), type);
 	if (!cq->queue) {
-		rxe_dbg(rxe, "unable to create cq\n");
+		rxe_dbg_dev(rxe, "unable to create cq\n");
 		return -ENOMEM;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index 71bc2c1895888..fdf5f08cd8f17 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -21,7 +21,7 @@ int rxe_icrc_init(struct rxe_dev *rxe)
 
 	tfm = crypto_alloc_shash("crc32", 0, 0);
 	if (IS_ERR(tfm)) {
-		rxe_dbg(rxe, "failed to init crc32 algorithm err: %ld\n",
+		rxe_dbg_dev(rxe, "failed to init crc32 algorithm err: %ld\n",
 			       PTR_ERR(tfm));
 		return PTR_ERR(tfm);
 	}
@@ -51,7 +51,7 @@ static __be32 rxe_crc32(struct rxe_dev *rxe, __be32 crc, void *next, size_t len)
 	*(__be32 *)shash_desc_ctx(shash) = crc;
 	err = crypto_shash_update(shash, next, len);
 	if (unlikely(err)) {
-		rxe_dbg(rxe, "failed crc calculation, err: %d\n", err);
+		rxe_dbg_dev(rxe, "failed crc calculation, err: %d\n", err);
 		return (__force __be32)crc32_le((__force u32)crc, next, len);
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mmap.c b/drivers/infiniband/sw/rxe/rxe_mmap.c
index a47d72dbc5376..6b7f2bd698799 100644
--- a/drivers/infiniband/sw/rxe/rxe_mmap.c
+++ b/drivers/infiniband/sw/rxe/rxe_mmap.c
@@ -79,7 +79,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 
 		/* Don't allow a mmap larger than the object. */
 		if (size > ip->info.size) {
-			rxe_dbg(rxe, "mmap region is larger than the object!\n");
+			rxe_dbg_dev(rxe, "mmap region is larger than the object!\n");
 			spin_unlock_bh(&rxe->pending_lock);
 			ret = -EINVAL;
 			goto done;
@@ -87,7 +87,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 
 		goto found_it;
 	}
-	rxe_dbg(rxe, "unable to find pending mmap info\n");
+	rxe_dbg_dev(rxe, "unable to find pending mmap info\n");
 	spin_unlock_bh(&rxe->pending_lock);
 	ret = -EINVAL;
 	goto done;
@@ -98,7 +98,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 
 	ret = remap_vmalloc_range(vma, ip->obj, 0);
 	if (ret) {
-		rxe_dbg(rxe, "err %d from remap_vmalloc_range\n", ret);
+		rxe_dbg_dev(rxe, "err %d from remap_vmalloc_range\n", ret);
 		goto done;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index e02e1624bcf4d..a2ace42e95366 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -596,7 +596,7 @@ static int rxe_notify(struct notifier_block *not_blk,
 		rxe_port_down(rxe);
 		break;
 	case NETDEV_CHANGEMTU:
-		rxe_dbg(rxe, "%s changed mtu to %d\n", ndev->name, ndev->mtu);
+		rxe_dbg_dev(rxe, "%s changed mtu to %d\n", ndev->name, ndev->mtu);
 		rxe_set_mtu(rxe, ndev->mtu);
 		break;
 	case NETDEV_CHANGE:
@@ -608,7 +608,7 @@ static int rxe_notify(struct notifier_block *not_blk,
 	case NETDEV_CHANGENAME:
 	case NETDEV_FEAT_CHANGE:
 	default:
-		rxe_dbg(rxe, "ignoring netdev event = %ld for %s\n",
+		rxe_dbg_dev(rxe, "ignoring netdev event = %ld for %s\n",
 			event, ndev->name);
 		break;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 13283ec06f95e..d5de5ba6940f1 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -19,33 +19,33 @@ static int rxe_qp_chk_cap(struct rxe_dev *rxe, struct ib_qp_cap *cap,
 			  int has_srq)
 {
 	if (cap->max_send_wr > rxe->attr.max_qp_wr) {
-		rxe_dbg(rxe, "invalid send wr = %u > %d\n",
+		rxe_dbg_dev(rxe, "invalid send wr = %u > %d\n",
 			 cap->max_send_wr, rxe->attr.max_qp_wr);
 		goto err1;
 	}
 
 	if (cap->max_send_sge > rxe->attr.max_send_sge) {
-		rxe_dbg(rxe, "invalid send sge = %u > %d\n",
+		rxe_dbg_dev(rxe, "invalid send sge = %u > %d\n",
 			 cap->max_send_sge, rxe->attr.max_send_sge);
 		goto err1;
 	}
 
 	if (!has_srq) {
 		if (cap->max_recv_wr > rxe->attr.max_qp_wr) {
-			rxe_dbg(rxe, "invalid recv wr = %u > %d\n",
+			rxe_dbg_dev(rxe, "invalid recv wr = %u > %d\n",
 				 cap->max_recv_wr, rxe->attr.max_qp_wr);
 			goto err1;
 		}
 
 		if (cap->max_recv_sge > rxe->attr.max_recv_sge) {
-			rxe_dbg(rxe, "invalid recv sge = %u > %d\n",
+			rxe_dbg_dev(rxe, "invalid recv sge = %u > %d\n",
 				 cap->max_recv_sge, rxe->attr.max_recv_sge);
 			goto err1;
 		}
 	}
 
 	if (cap->max_inline_data > rxe->max_inline_data) {
-		rxe_dbg(rxe, "invalid max inline data = %u > %d\n",
+		rxe_dbg_dev(rxe, "invalid max inline data = %u > %d\n",
 			 cap->max_inline_data, rxe->max_inline_data);
 		goto err1;
 	}
@@ -73,7 +73,7 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
 	}
 
 	if (!init->recv_cq || !init->send_cq) {
-		rxe_dbg(rxe, "missing cq\n");
+		rxe_dbg_dev(rxe, "missing cq\n");
 		goto err1;
 	}
 
@@ -82,14 +82,14 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
 
 	if (init->qp_type == IB_QPT_GSI) {
 		if (!rdma_is_port_valid(&rxe->ib_dev, port_num)) {
-			rxe_dbg(rxe, "invalid port = %d\n", port_num);
+			rxe_dbg_dev(rxe, "invalid port = %d\n", port_num);
 			goto err1;
 		}
 
 		port = &rxe->port;
 
 		if (init->qp_type == IB_QPT_GSI && port->qp_gsi_index) {
-			rxe_dbg(rxe, "GSI QP exists for port %d\n", port_num);
+			rxe_dbg_dev(rxe, "GSI QP exists for port %d\n", port_num);
 			goto err1;
 		}
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 82e37a41ced40..27ca82ec0826b 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -13,13 +13,13 @@ int rxe_srq_chk_init(struct rxe_dev *rxe, struct ib_srq_init_attr *init)
 	struct ib_srq_attr *attr = &init->attr;
 
 	if (attr->max_wr > rxe->attr.max_srq_wr) {
-		rxe_dbg(rxe, "max_wr(%d) > max_srq_wr(%d)\n",
+		rxe_dbg_dev(rxe, "max_wr(%d) > max_srq_wr(%d)\n",
 			attr->max_wr, rxe->attr.max_srq_wr);
 		goto err1;
 	}
 
 	if (attr->max_wr <= 0) {
-		rxe_dbg(rxe, "max_wr(%d) <= 0\n", attr->max_wr);
+		rxe_dbg_dev(rxe, "max_wr(%d) <= 0\n", attr->max_wr);
 		goto err1;
 	}
 
@@ -27,7 +27,7 @@ int rxe_srq_chk_init(struct rxe_dev *rxe, struct ib_srq_init_attr *init)
 		attr->max_wr = RXE_MIN_SRQ_WR;
 
 	if (attr->max_sge > rxe->attr.max_srq_sge) {
-		rxe_dbg(rxe, "max_sge(%d) > max_srq_sge(%d)\n",
+		rxe_dbg_dev(rxe, "max_sge(%d) > max_srq_sge(%d)\n",
 			attr->max_sge, rxe->attr.max_srq_sge);
 		goto err1;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 6803ac76ae572..a40a6d0581500 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1093,7 +1093,7 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 
 	err = ib_register_device(dev, ibdev_name, NULL);
 	if (err)
-		rxe_dbg(rxe, "failed with error %d\n", err);
+		rxe_dbg_dev(rxe, "failed with error %d\n", err);
 
 	/*
 	 * Note that rxe may be invalid at this point if another thread
-- 
2.39.2



