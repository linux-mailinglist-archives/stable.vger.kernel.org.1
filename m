Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1522C7036FF
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243660AbjEORP4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243910AbjEORP0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:15:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BCF6A79
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ED3362B9F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75020C433D2;
        Mon, 15 May 2023 17:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170852;
        bh=WBQ9hH3nxmTiJJgOZHvBVBhVH2U49nOnCXS4krNfZu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQiS8y/OwX56m2WTeRo7c30iVq3tKH5no+FDplwCKRC94wOLIFtvnPK4xdiKkYpPV
         SzhXcH2QRSwp7CRgNAE216GdIlFETmLrucjZX1vTkL5c4Z7T7QChYgPvV7YfOR6IPZ
         00+cUhQg7gcAXtizVwZImK1iss/c5tgonIMp+e+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 022/242] RDMA/rxe: Extend dbg log messages to err and info
Date:   Mon, 15 May 2023 18:25:48 +0200
Message-Id: <20230515161722.597355728@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

[ Upstream commit 9ac01f434a1eb56ea94611bd75cf62fa276b41f4 ]

Extend the dbg log messages (e.g. rxe_dbg_xxx) to include
err and info types. rxe.c is modified to use these new log
messages as examples.

Link: https://lore.kernel.org/r/20230303221623.8053-4-rpearsonhpe@gmail.com
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Stable-dep-of: 78b26a335310 ("RDMA/rxe: Remove tasklet call from rxe_cq.c")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe.c |  8 ++++---
 drivers/infiniband/sw/rxe/rxe.h | 42 +++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index d57ba7a5964b9..7a7e713de52db 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -160,6 +160,8 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
 
 	port->attr.active_mtu = mtu;
 	port->mtu_cap = ib_mtu_enum_to_int(mtu);
+
+	rxe_info_dev(rxe, "Set mtu to %d", port->mtu_cap);
 }
 
 /* called by ifc layer to create new rxe device.
@@ -179,7 +181,7 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	int err = 0;
 
 	if (is_vlan_dev(ndev)) {
-		pr_err("rxe creation allowed on top of a real device only\n");
+		rxe_err("rxe creation allowed on top of a real device only");
 		err = -EPERM;
 		goto err;
 	}
@@ -187,14 +189,14 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	rxe = rxe_get_dev_from_net(ndev);
 	if (rxe) {
 		ib_device_put(&rxe->ib_dev);
-		rxe_dbg_dev(rxe, "already configured on %s\n", ndev->name);
+		rxe_err_dev(rxe, "already configured on %s", ndev->name);
 		err = -EEXIST;
 		goto err;
 	}
 
 	err = rxe_net_add(ibdev_name, ndev);
 	if (err) {
-		pr_debug("failed to add %s\n", ndev->name);
+		rxe_err("failed to add %s\n", ndev->name);
 		goto err;
 	}
 err:
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 0757acc381038..bd8a8ea4ea8fd 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -58,6 +58,48 @@
 #define rxe_dbg_mw(mw, fmt, ...) ibdev_dbg((mw)->ibmw.device,		\
 		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
 
+#define rxe_err(fmt, ...) pr_err_ratelimited("%s: " fmt "\n", __func__, \
+					##__VA_ARGS__)
+#define rxe_err_dev(rxe, fmt, ...) ibdev_err_ratelimited(&(rxe)->ib_dev, \
+		"%s: " fmt, __func__, ##__VA_ARGS__)
+#define rxe_err_uc(uc, fmt, ...) ibdev_err_ratelimited((uc)->ibuc.device, \
+		"uc#%d %s: " fmt, (uc)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_pd(pd, fmt, ...) ibdev_err_ratelimited((pd)->ibpd.device, \
+		"pd#%d %s: " fmt, (pd)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_ah(ah, fmt, ...) ibdev_err_ratelimited((ah)->ibah.device, \
+		"ah#%d %s: " fmt, (ah)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_srq(srq, fmt, ...) ibdev_err_ratelimited((srq)->ibsrq.device, \
+		"srq#%d %s: " fmt, (srq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_qp(qp, fmt, ...) ibdev_err_ratelimited((qp)->ibqp.device, \
+		"qp#%d %s: " fmt, (qp)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_cq(cq, fmt, ...) ibdev_err_ratelimited((cq)->ibcq.device, \
+		"cq#%d %s: " fmt, (cq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_mr(mr, fmt, ...) ibdev_err_ratelimited((mr)->ibmr.device, \
+		"mr#%d %s:  " fmt, (mr)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_mw(mw, fmt, ...) ibdev_err_ratelimited((mw)->ibmw.device, \
+		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
+
+#define rxe_info(fmt, ...) pr_info_ratelimited("%s: " fmt "\n", __func__, \
+					##__VA_ARGS__)
+#define rxe_info_dev(rxe, fmt, ...) ibdev_info_ratelimited(&(rxe)->ib_dev, \
+		"%s: " fmt, __func__, ##__VA_ARGS__)
+#define rxe_info_uc(uc, fmt, ...) ibdev_info_ratelimited((uc)->ibuc.device, \
+		"uc#%d %s: " fmt, (uc)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_pd(pd, fmt, ...) ibdev_info_ratelimited((pd)->ibpd.device, \
+		"pd#%d %s: " fmt, (pd)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_ah(ah, fmt, ...) ibdev_info_ratelimited((ah)->ibah.device, \
+		"ah#%d %s: " fmt, (ah)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_srq(srq, fmt, ...) ibdev_info_ratelimited((srq)->ibsrq.device, \
+		"srq#%d %s: " fmt, (srq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_qp(qp, fmt, ...) ibdev_info_ratelimited((qp)->ibqp.device, \
+		"qp#%d %s: " fmt, (qp)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_cq(cq, fmt, ...) ibdev_info_ratelimited((cq)->ibcq.device, \
+		"cq#%d %s: " fmt, (cq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_mr(mr, fmt, ...) ibdev_info_ratelimited((mr)->ibmr.device, \
+		"mr#%d %s:  " fmt, (mr)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_mw(mw, fmt, ...) ibdev_info_ratelimited((mw)->ibmw.device, \
+		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
+
 /* responder states */
 enum resp_states {
 	RESPST_NONE,
-- 
2.39.2



