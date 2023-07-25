Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E4776126F
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjGYLCb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbjGYLCQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:02:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB2559CB
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:59:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04DBD61697
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A98C433C8;
        Tue, 25 Jul 2023 10:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282773;
        bh=gP5XlZJmOXZ0zL7RTYa3HAv27n191LhxKICx9FMrO7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/SKNURhsAJUWZ9Dth/vA2/ykA/IgdCY9MfEwkIDCG3Lb/zu2qRs1GIDwbkPLI5Rk
         uk3xb+0n6GRMZGdRqtxnpF5V5zFjTES6bWiliK1mmi8vEo8RMewfvLpSnwU8bxp4LI
         x+7WD17uhVvPpxNGrr1Rh3EQ/hAVGa53N3TzM0JI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Spickett <David.Spickett@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>
Subject: [PATCH 6.1 021/183] arm64/fpsimd: Ensure SME storage is allocated after SVE VL changes
Date:   Tue, 25 Jul 2023 12:44:09 +0200
Message-ID: <20230725104508.656615950@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
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

From: Mark Brown <broonie@kernel.org>

commit d4d5be94a87872421ea2569044092535aff0b886 upstream.

When we reconfigure the SVE vector length we discard the backing storage
for the SVE vectors and then reallocate on next SVE use, leaving the SME
specific state alone. This means that we do not enable SME traps if they
were already disabled. That means that userspace code can enter streaming
mode without trapping, putting the task in a state where if we try to save
the state of the task we will fault.

Since the ABI does not specify that changing the SVE vector length disturbs
SME state, and since SVE code may not be aware of SME code in the process,
we shouldn't simply discard any ZA state. Instead immediately reallocate
the storage for SVE, and disable SME if we change the SVE vector length
while there is no SME state active.

Disabling SME traps on SVE vector length changes would make the overall
code more complex since we would have a state where we have valid SME state
stored but might get a SME trap.

Fixes: 9e4ab6c89109 ("arm64/sme: Implement vector length configuration prctl()s")
Reported-by: David Spickett <David.Spickett@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230720-arm64-fix-sve-sme-vl-change-v2-1-8eea06b82d57@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/fpsimd.c |   33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -803,6 +803,8 @@ void sve_sync_from_fpsimd_zeropad(struct
 int vec_set_vector_length(struct task_struct *task, enum vec_type type,
 			  unsigned long vl, unsigned long flags)
 {
+	bool free_sme = false;
+
 	if (flags & ~(unsigned long)(PR_SVE_VL_INHERIT |
 				     PR_SVE_SET_VL_ONEXEC))
 		return -EINVAL;
@@ -851,21 +853,36 @@ int vec_set_vector_length(struct task_st
 	    thread_sm_enabled(&task->thread))
 		sve_to_fpsimd(task);
 
-	if (system_supports_sme() && type == ARM64_VEC_SME) {
-		task->thread.svcr &= ~(SVCR_SM_MASK |
-				       SVCR_ZA_MASK);
-		clear_thread_flag(TIF_SME);
+	if (system_supports_sme()) {
+		if (type == ARM64_VEC_SME ||
+		    !(task->thread.svcr & (SVCR_SM_MASK | SVCR_ZA_MASK))) {
+			/*
+			 * We are changing the SME VL or weren't using
+			 * SME anyway, discard the state and force a
+			 * reallocation.
+			 */
+			task->thread.svcr &= ~(SVCR_SM_MASK |
+					       SVCR_ZA_MASK);
+			clear_thread_flag(TIF_SME);
+			free_sme = true;
+		}
 	}
 
 	if (task == current)
 		put_cpu_fpsimd_context();
 
 	/*
-	 * Force reallocation of task SVE and SME state to the correct
-	 * size on next use:
+	 * Free the changed states if they are not in use, SME will be
+	 * reallocated to the correct size on next use and we just
+	 * allocate SVE now in case it is needed for use in streaming
+	 * mode.
 	 */
-	sve_free(task);
-	if (system_supports_sme() && type == ARM64_VEC_SME)
+	if (system_supports_sve()) {
+		sve_free(task);
+		sve_alloc(task, true);
+	}
+
+	if (free_sme)
 		sme_free(task);
 
 	task_set_vl(task, type, vl);


