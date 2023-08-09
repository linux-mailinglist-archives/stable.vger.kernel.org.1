Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1B87759CC
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjHILDO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjHILDH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:03:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A837E2130
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B53662E69
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA04C433C7;
        Wed,  9 Aug 2023 10:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578524;
        bh=y1RiN+GXWaunW3MqOSQioh/w01gt51yEBy4jutM+LhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b62GYtqJx/xKPyeMLXE6k43eOBB1uDlpoSkrZROr2e0B3jv+AHMLMyfu7eTVwtcqn
         TGWPtTjnGN2gA3EBulmHAoE0Eqm49cKiZ0MfOy2WplOWSWb2XZAwzUbco3RQjfW6s7
         DvYmg3P+r5Zmk4Bkq81U1Cr/d2VswGDFRf9GjK5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.1 090/127] arm64/fpsimd: Sync and zero pad FPSIMD state for streaming SVE
Date:   Wed,  9 Aug 2023 12:41:17 +0200
Message-ID: <20230809103639.627823359@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Mark Brown <broonie@kernel.org>

commit 69af56ae56a48a2522aad906c4461c6c7c092737 upstream.

We have a function sve_sync_from_fpsimd_zeropad() which is used by the
ptrace code to update the SVE state when the user writes to the the
FPSIMD register set.  Currently this checks that the task has SVE
enabled but this will miss updates for tasks which have streaming SVE
enabled if SVE has not been enabled for the thread, also do the
conversion if the task has streaming SVE enabled.

Fixes: e12310a0d30f ("arm64/sme: Implement ptrace support for streaming mode SVE registers")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230803-arm64-fix-ptrace-ssve-no-sve-v1-3-49df214bfb3e@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/fpsimd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -791,7 +791,8 @@ void sve_sync_from_fpsimd_zeropad(struct
 	void *sst = task->thread.sve_state;
 	struct user_fpsimd_state const *fst = &task->thread.uw.fpsimd_state;
 
-	if (!test_tsk_thread_flag(task, TIF_SVE))
+	if (!test_tsk_thread_flag(task, TIF_SVE) &&
+	    !thread_sm_enabled(&task->thread))
 		return;
 
 	vq = sve_vq_from_vl(thread_get_cur_vl(&task->thread));


