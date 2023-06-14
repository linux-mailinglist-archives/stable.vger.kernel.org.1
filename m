Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72311726C24
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjFGUbC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjFGUat (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:30:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D33E1FF0
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD051644E3
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B1CC433D2;
        Wed,  7 Jun 2023 20:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169847;
        bh=IrzoZRcJ1pQ3a+wCRzrBYdXoNkbPya36QSZTwlbQHiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzXit2dReQJkDHlsVoCuLsuTnnp55WFB3kuPKoRkbRPT7Y6X2oPPecBSZFyFyb+g0
         aer/FFbxVWgt8jONz8EamzPJvY9Cv1ElssZ8YyR/5q4Fw9Al+P/2HJXFiNqhbYbKYr
         rwgjxtZeFCnQ+iNCEhHXJR5R0UsC8/1kjZalvkWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 237/286] misc: fastrpc: Pass proper scm arguments for secure map request
Date:   Wed,  7 Jun 2023 22:15:36 +0200
Message-ID: <20230607200931.038603732@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

[ Upstream commit a6e766dea0a22918735176e4af862d535962f11e ]

If a map request is made with securemap attribute, the memory
ownership needs to be reassigned to new VMID to allow access
from protection domain. Currently only DSP VMID is passed to
the reassign call which is incorrect as only a combination of
HLOS and DSP VMID is allowed for memory ownership reassignment
and passing only DSP VMID will cause assign call failure.

Also pass proper restoring permissions to HLOS as the source
permission will now carry both HLOS and DSP VMID permission.

Change is also made to get valid physical address from
scatter/gather for this allocation request.

Fixes: e90d91190619 ("misc: fastrpc: Add support to secure memory map")
Cc: stable <stable@kernel.org>
Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230523152550.438363-2-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f3f2671d7ac7c..30d4d0476248f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -316,12 +316,14 @@ static void fastrpc_free_map(struct kref *ref)
 	if (map->table) {
 		if (map->attr & FASTRPC_ATTR_SECUREMAP) {
 			struct qcom_scm_vmperm perm;
+			int vmid = map->fl->cctx->vmperms[0].vmid;
+			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS) | BIT(vmid);
 			int err = 0;
 
 			perm.vmid = QCOM_SCM_VMID_HLOS;
 			perm.perm = QCOM_SCM_PERM_RWX;
 			err = qcom_scm_assign_mem(map->phys, map->size,
-				&map->fl->cctx->perms, &perm, 1);
+				&src_perms, &perm, 1);
 			if (err) {
 				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
 						map->phys, map->size, err);
@@ -787,8 +789,12 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		goto map_err;
 	}
 
-	map->phys = sg_dma_address(map->table->sgl);
-	map->phys += ((u64)fl->sctx->sid << 32);
+	if (attr & FASTRPC_ATTR_SECUREMAP) {
+		map->phys = sg_phys(map->table->sgl);
+	} else {
+		map->phys = sg_dma_address(map->table->sgl);
+		map->phys += ((u64)fl->sctx->sid << 32);
+	}
 	map->size = len;
 	map->va = sg_virt(map->table->sgl);
 	map->len = len;
@@ -798,9 +804,15 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		 * If subsystem VMIDs are defined in DTSI, then do
 		 * hyp_assign from HLOS to those VM(s)
 		 */
+		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
+		struct qcom_scm_vmperm dst_perms[2] = {0};
+
+		dst_perms[0].vmid = QCOM_SCM_VMID_HLOS;
+		dst_perms[0].perm = QCOM_SCM_PERM_RW;
+		dst_perms[1].vmid = fl->cctx->vmperms[0].vmid;
+		dst_perms[1].perm = QCOM_SCM_PERM_RWX;
 		map->attr = attr;
-		err = qcom_scm_assign_mem(map->phys, (u64)map->size, &fl->cctx->perms,
-				fl->cctx->vmperms, fl->cctx->vmcount);
+		err = qcom_scm_assign_mem(map->phys, (u64)map->size, &src_perms, dst_perms, 2);
 		if (err) {
 			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
 					map->phys, map->size, err);
-- 
2.39.2



