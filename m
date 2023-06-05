Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A00722A05
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 16:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjFEO5g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 10:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjFEO5f (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 10:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1866CA7
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 07:57:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A27C162097
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 14:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8591C433EF;
        Mon,  5 Jun 2023 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685977053;
        bh=1ITATg7vmjEyGSJ95e5qomb+ruUDKWR9x6VvWtf7Fvg=;
        h=Subject:To:Cc:From:Date:From;
        b=cX/oKleG+ZBoX/OTNXifz3LDFYLuaol3IN8yeL0afacZNUmC5rYx8z6IcU/sVdqjS
         XAypPfm2yHVRqWbK5dIVHfuzc2AIP8ziXJd/VrSLCDT14zEm2pG9lcGA2hkj7fS2ty
         0DxSTBzMRBJ9wgcsMXVY8kdr3iLXdE1lZTaR/kpY=
Subject: FAILED: patch "[PATCH] misc: fastrpc: Pass proper scm arguments for secure map" failed to apply to 6.3-stable tree
To:     quic_ekangupt@quicinc.com, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org, stable@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 05 Jun 2023 16:57:30 +0200
Message-ID: <2023060530-stammer-kitten-446d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x a6e766dea0a22918735176e4af862d535962f11e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060530-stammer-kitten-446d@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a6e766dea0a22918735176e4af862d535962f11e Mon Sep 17 00:00:00 2001
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
Date: Tue, 23 May 2023 16:25:47 +0100
Subject: [PATCH] misc: fastrpc: Pass proper scm arguments for secure map
 request

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

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f48466960f1b..32a5415624bf 100644
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

