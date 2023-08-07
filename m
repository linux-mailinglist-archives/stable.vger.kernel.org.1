Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DC1771B1D
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 09:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjHGHHT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 03:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjHGHHS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 03:07:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8AAE78
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 00:07:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E67361207
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 07:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F729C433C7;
        Mon,  7 Aug 2023 07:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691392036;
        bh=U5hP/KqzvgcA7+69FLX8yGAUOEe1VWjCtiGn86FcOFo=;
        h=Subject:To:Cc:From:Date:From;
        b=P6Q1+qWzmyECn2IQAN3GbsG3qn1vMuck091bseitImsYyOgXTNmR5mp96nrfJ6YAF
         wACME+kQNmqg4szbYDLk5zDP6HPvnzJLoFdThN0mXmZBknqbk1KQ5BrCIHdKA3qW6M
         YkOHEa+DwYNSvbkOnbiKftIcUTEPS+C/KjiUD7cg=
Subject: FAILED: patch "[PATCH] arm64/ptrace: Don't enable SVE when setting streaming SVE" failed to apply to 6.1-stable tree
To:     broonie@kernel.org, catalin.marinas@arm.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 07 Aug 2023 09:07:13 +0200
Message-ID: <2023080713-schedule-tuition-b3a5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 045aecdfcb2e060db142d83a0f4082380c465d2c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080713-schedule-tuition-b3a5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

045aecdfcb2e ("arm64/ptrace: Don't enable SVE when setting streaming SVE")
baa8515281b3 ("arm64/fpsimd: Track the saved FPSIMD state type separately to TIF_SVE")
93ae6b01bafe ("KVM: arm64: Discard any SVE state when entering KVM guests")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 045aecdfcb2e060db142d83a0f4082380c465d2c Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Thu, 3 Aug 2023 19:33:21 +0100
Subject: [PATCH] arm64/ptrace: Don't enable SVE when setting streaming SVE

Systems which implement SME without also implementing SVE are
architecturally valid but were not initially supported by the kernel,
unfortunately we missed one issue in the ptrace code.

The SVE register setting code is shared between SVE and streaming mode
SVE. When we set full SVE register state we currently enable TIF_SVE
unconditionally, in the case where streaming SVE is being configured on a
system that supports vanilla SVE this is not an issue since we always
initialise enough state for both vector lengths but on a system which only
support SME it will result in us attempting to restore the SVE vector
length after having set streaming SVE registers.

Fix this by making the enabling of SVE conditional on setting SVE vector
state. If we set streaming SVE state and SVE was not already enabled this
will result in a SVE access trap on next use of normal SVE, this will cause
us to flush our register state but this is fine since the only way to
trigger a SVE access trap would be to exit streaming mode which will cause
the in register state to be flushed anyway.

Fixes: e12310a0d30f ("arm64/sme: Implement ptrace support for streaming mode SVE registers")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230803-arm64-fix-ptrace-ssve-no-sve-v1-1-49df214bfb3e@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 740e81e9db04..5b9b4305248b 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -932,11 +932,13 @@ static int sve_set_common(struct task_struct *target,
 	/*
 	 * Ensure target->thread.sve_state is up to date with target's
 	 * FPSIMD regs, so that a short copyin leaves trailing
-	 * registers unmodified.  Always enable SVE even if going into
-	 * streaming mode.
+	 * registers unmodified.  Only enable SVE if we are
+	 * configuring normal SVE, a system with streaming SVE may not
+	 * have normal SVE.
 	 */
 	fpsimd_sync_to_sve(target);
-	set_tsk_thread_flag(target, TIF_SVE);
+	if (type == ARM64_VEC_SVE)
+		set_tsk_thread_flag(target, TIF_SVE);
 	target->thread.fp_type = FP_STATE_SVE;
 
 	BUILD_BUG_ON(SVE_PT_SVE_OFFSET != sizeof(header));

