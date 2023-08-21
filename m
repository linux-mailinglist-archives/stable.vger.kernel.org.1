Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADBA7831EC
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjHUUBB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjHUUAy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:00:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1E4128
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:00:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1A196454B
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E11C433C8;
        Mon, 21 Aug 2023 20:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648052;
        bh=omgmah/6V8IykbrHp1i8bRAcr4/6bLO2qoNIvbmh8HI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SzALY+wdQq92xUTu7gX6E3zt1TK0+k6RYmA465cZKr7djf8Bjf3QuOmXIiEs2Vu/E
         Y20OyQdP+Muk88lgy+5jYFTz1ppCYN7kxH6wHy1iR2qJTfIyCYoxGPSuwoVFMCaGb0
         V7Qz5EVNp+GCg2ZDFc1hJHsdZckP64QhCw75TkBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 038/234] RDMA/bnxt_re: consider timeout of destroy ah as success.
Date:   Mon, 21 Aug 2023 21:40:01 +0200
Message-ID: <20230821194130.401560350@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
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

From: Kashyap Desai <kashyap.desai@broadcom.com>

[ Upstream commit bb8c93618fb0b8567d309f1aebc6df0cd31da1a2 ]

If destroy_ah is timed out, it is likely to be destroyed by firmware
but it is taking longer time due to temporary slowness
in processing the rcfw command. In worst case, there might be
AH resource leak in firmware.

Sending timeout return value can dump warning message from ib_core
which can be avoided if we map timeout of destroy_ah as success.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Link: https://lore.kernel.org/r/1686308514-11996-14-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  2 ++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 16 ++++++++++++----
 drivers/infiniband/hw/bnxt_re/qplib_sp.c |  8 +++++---
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |  4 ++--
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 2c95e6f3d47ac..eef3ef3fabb42 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -179,6 +179,8 @@ struct bnxt_re_dev {
 #define BNXT_RE_ROCEV2_IPV4_PACKET	2
 #define BNXT_RE_ROCEV2_IPV6_PACKET	3
 
+#define BNXT_RE_CHECK_RC(x) ((x) && ((x) != -ETIMEDOUT))
+
 static inline struct device *rdev_to_dev(struct bnxt_re_dev *rdev)
 {
 	if (rdev)
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index ebe6852c40e8c..e7f153ee27541 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -614,12 +614,20 @@ int bnxt_re_destroy_ah(struct ib_ah *ib_ah, u32 flags)
 {
 	struct bnxt_re_ah *ah = container_of(ib_ah, struct bnxt_re_ah, ib_ah);
 	struct bnxt_re_dev *rdev = ah->rdev;
+	bool block = true;
+	int rc = 0;
 
-	bnxt_qplib_destroy_ah(&rdev->qplib_res, &ah->qplib_ah,
-			      !(flags & RDMA_DESTROY_AH_SLEEPABLE));
+	block = !(flags & RDMA_DESTROY_AH_SLEEPABLE);
+	rc = bnxt_qplib_destroy_ah(&rdev->qplib_res, &ah->qplib_ah, block);
+	if (BNXT_RE_CHECK_RC(rc)) {
+		if (rc == -ETIMEDOUT)
+			rc = 0;
+		else
+			goto fail;
+	}
 	atomic_dec(&rdev->ah_count);
-
-	return 0;
+fail:
+	return rc;
 }
 
 static u8 bnxt_re_stack_to_dev_nw_type(enum rdma_network_type ntype)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index b967a17a44beb..10919532bca29 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -468,13 +468,14 @@ int bnxt_qplib_create_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 	return 0;
 }
 
-void bnxt_qplib_destroy_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
-			   bool block)
+int bnxt_qplib_destroy_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
+			  bool block)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct creq_destroy_ah_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
 	struct cmdq_destroy_ah req = {};
+	int rc;
 
 	/* Clean up the AH table in the device */
 	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
@@ -485,7 +486,8 @@ void bnxt_qplib_destroy_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
 				sizeof(resp), block);
-	bnxt_qplib_rcfw_send_message(rcfw, &msg);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
+	return rc;
 }
 
 /* MRW */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 5de874659cdfa..4061616048e85 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -327,8 +327,8 @@ int bnxt_qplib_set_func_resources(struct bnxt_qplib_res *res,
 				  struct bnxt_qplib_ctx *ctx);
 int bnxt_qplib_create_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
 			 bool block);
-void bnxt_qplib_destroy_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
-			   bool block);
+int bnxt_qplib_destroy_ah(struct bnxt_qplib_res *res, struct bnxt_qplib_ah *ah,
+			  bool block);
 int bnxt_qplib_alloc_mrw(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_mrw *mrw);
 int bnxt_qplib_dereg_mrw(struct bnxt_qplib_res *res, struct bnxt_qplib_mrw *mrw,
-- 
2.40.1



