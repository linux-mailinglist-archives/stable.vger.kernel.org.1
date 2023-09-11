Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685A979AC99
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjIKVFf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240980AbjIKO6t (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:58:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEFD1B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:58:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E26BC433C8;
        Mon, 11 Sep 2023 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444324;
        bh=EmTNqJgdAVOJvuBFCBGKgbecdn2m07FDd4O/J5s7hC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bVk6d1M0nlalL6YmwSDDxJ1aSzn8tz4pgMeM13rw66sLQUz4ooa8tT9Wl4KQwudzy
         nr5Ik152dG8lH4RazxZF5dRO3Iwy71NesRUzLmn8fMeBbO7zyPfrzh1YbiaFIiSGHU
         E9fsWNSsyv3hcNFBYcFYq7NYCBvqI3L1aCvj5peE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6.4 689/737] misc: fastrpc: Pass proper scm arguments for static process init
Date:   Mon, 11 Sep 2023 15:49:08 +0200
Message-ID: <20230911134709.777298533@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

commit fe6518d547fc52ba74201018dc9aeb364072ac78 upstream.

Memory is allocated for dynamic loading when audio daemon is trying
to attach to audioPD on DSP side. This memory is allocated from
reserved CMA memory region and needs ownership assignment to
new VMID in order to use it from audioPD.

In the current implementation, arguments are not correctly passed
to the scm call which might result in failure of dynamic loading
on audioPD. Added changes to pass correct arguments during daemon
attach request.

Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")
Cc: stable <stable@kernel.org>
Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230811115643.38578-4-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/fastrpc.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1322,13 +1322,18 @@ static int fastrpc_init_create_static_pr
 	return 0;
 err_invoke:
 	if (fl->cctx->vmcount) {
-		struct qcom_scm_vmperm perm;
+		u64 src_perms = 0;
+		struct qcom_scm_vmperm dst_perms;
+		u32 i;
 
-		perm.vmid = QCOM_SCM_VMID_HLOS;
-		perm.perm = QCOM_SCM_PERM_RWX;
+		for (i = 0; i < fl->cctx->vmcount; i++)
+			src_perms |= BIT(fl->cctx->vmperms[i].vmid);
+
+		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
+		dst_perms.perm = QCOM_SCM_PERM_RWX;
 		err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
 						(u64)fl->cctx->remote_heap->size,
-						&fl->cctx->perms, &perm, 1);
+						&src_perms, &dst_perms, 1);
 		if (err)
 			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
 				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);


