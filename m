Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1420726C0B
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjFGUa2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjFGUaR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43628269E
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AC5F644AC
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B3FC433D2;
        Wed,  7 Jun 2023 20:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169786;
        bh=pvKmf3n0fXBvmrXDPWVd8WoBFNnQWRVhKHqqCyBcX20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aLefI3uFZnn1LqGSD60JpIdq0UWQO042j8/xF3Y2l3SlUJj5xj6RZxCBBumGI9gy6
         6xzw2F8bIbjnvDcVV/T5V9W4E2guTdmYXY1qPgcRYNhcFwLuJzwWfmOdFRgzrek/i/
         6fK2BC5bm4H4qHG4PgN0AFe3sQ5SxrMHomGfyZSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6.3 213/286] misc: fastrpc: Reassign memory ownership only for remote heap
Date:   Wed,  7 Jun 2023 22:15:12 +0200
Message-ID: <20230607200930.210199708@linuxfoundation.org>
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

commit 3c7d0079a1831118ef232bd9c2f34d058a1f31c2 upstream.

The userspace map request for remote heap allocates CMA memory.
The ownership of this memory needs to be reassigned to proper
owners to allow access from the protection domain running on
DSP. This reassigning of ownership is not correct if done for
any other supported flags.

When any other flag is requested from userspace, fastrpc is
trying to reassign the ownership of memory and this reassignment
is getting skipped for remote heap request which is incorrect.
Add proper flag check to reassign the memory only if remote heap
is requested.

Fixes: 532ad70c6d44 ("misc: fastrpc: Add mmap request assigning for static PD pool")
Cc: stable <stable@kernel.org>
Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230523152550.438363-3-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 32a5415624bf..a654dc416480 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1904,7 +1904,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	req.vaddrout = rsp_msg.vaddr;
 
 	/* Add memory to static PD pool, protection thru hypervisor */
-	if (req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
+	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
 		struct qcom_scm_vmperm perm;
 
 		perm.vmid = QCOM_SCM_VMID_HLOS;
-- 
2.41.0



