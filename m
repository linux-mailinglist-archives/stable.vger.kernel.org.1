Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A827A39C0
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjIQTxi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240160AbjIQTxa (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:53:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8549A9F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:53:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C3EC433C8;
        Sun, 17 Sep 2023 19:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980405;
        bh=6IFN7eBNzdgsiyIOaxSkAzdOdB2GcfDlBlORgjQoKuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQNygI5KLeq5BGpCqUWuNiQ5RuTfI3JWZ8zmo10VDHgLEyNvZNwRqF1sCv+kXx3FJ
         DOEp2y6wdgw7LfA77FcTRwiAe0d3je+AOchD1DvraRas3B6ShrPWPAv5x8wL8KJus6
         POwfUka/Y+hWatX2M7UOQYYUEVOS5vGcIn+6C7zE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6.5 182/285] misc: fastrpc: Fix remote heap allocation request
Date:   Sun, 17 Sep 2023 21:13:02 +0200
Message-ID: <20230917191057.924572130@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

commit ada6c2d99aedd1eac2f633d03c652e070bc2ea74 upstream.

Remote heap is used by DSP audioPD on need basis. This memory is
allocated from reserved CMA memory region and is then shared with
audioPD to use it for it's functionality.

Current implementation of remote heap is not allocating the memory
from CMA region, instead it is allocating the memory from SMMU
context bank. The arguments passed to scm call for the reassignment
of ownership is also not correct. Added changes to allocate CMA
memory and have a proper ownership reassignment.

Fixes: 532ad70c6d44 ("misc: fastrpc: Add mmap request assigning for static PD pool")
Cc: stable <stable@kernel.org>
Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230811115643.38578-2-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/fastrpc.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1871,7 +1871,11 @@ static int fastrpc_req_mmap(struct fastr
 		return -EINVAL;
 	}
 
-	err = fastrpc_buf_alloc(fl, fl->sctx->dev, req.size, &buf);
+	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
+		err = fastrpc_remote_heap_alloc(fl, dev, req.size, &buf);
+	else
+		err = fastrpc_buf_alloc(fl, dev, req.size, &buf);
+
 	if (err) {
 		dev_err(dev, "failed to allocate buffer\n");
 		return err;
@@ -1910,12 +1914,8 @@ static int fastrpc_req_mmap(struct fastr
 
 	/* Add memory to static PD pool, protection thru hypervisor */
 	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
-		struct qcom_scm_vmperm perm;
-
-		perm.vmid = QCOM_SCM_VMID_HLOS;
-		perm.perm = QCOM_SCM_PERM_RWX;
-		err = qcom_scm_assign_mem(buf->phys, buf->size,
-			&fl->cctx->perms, &perm, 1);
+		err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
+			&fl->cctx->perms, fl->cctx->vmperms, fl->cctx->vmcount);
 		if (err) {
 			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
 					buf->phys, buf->size, err);


