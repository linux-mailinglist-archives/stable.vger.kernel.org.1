Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4126782B0F
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 15:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjHUN6o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 09:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbjHUN6n (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 09:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E515BE
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 06:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A9F263839
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A0EC433C8;
        Mon, 21 Aug 2023 13:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692626321;
        bh=hgue6o9Zlf1z3e4E4yr6c0TL2oCRtiNeU/VBnZLozTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pf9YE66wRg062qLUwdofihkJ6sHLTdQY/m9KhdNuSwnKqi5Pbzd/fwmj1wHuMr3dN
         HQbDLcyWKFJAaY3Va9lWtaQqBU0cB+Xfzx5YjsJsQ6Kk6A7QL/6zbXcgsSaybk0KMx
         TWN2hCYZgLL/qupYZ2nxq70kkSneSSnALl1bHCeD3sttx9Pb5RZRB56s2/GoBhdRxZ
         GmJN5VGLkfS0i7QExwtC303ir/x1ll0+eKYNVgFxa3JR+dXo/+TrLNXs2awTMLqulK
         dj9jILXK59dhwmWRMM9eo1hEk11pQu4cexv4whKrVqUoh5xsFHP4G3Au4VoXy1nvTT
         kN1bf4282A9ew==
From:   Mark Brown <broonie@kernel.org>
To:     stable@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        David Spickett <David.Spickett@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.1.y] arm64/ptrace: Ensure that SME is set up for target when writing SSVE state
Date:   Mon, 21 Aug 2023 14:58:33 +0100
Message-Id: <20230821135834.216609-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2023082121-chewing-regroup-4f67@gregkh>
References: <2023082121-chewing-regroup-4f67@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4793; i=broonie@kernel.org; h=from:subject; bh=hgue6o9Zlf1z3e4E4yr6c0TL2oCRtiNeU/VBnZLozTU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk422JjBUZhmNMXQjIj+IBDIj1vqvvdGay2y0tCM3s d3XqXciJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZONtiQAKCRAk1otyXVSH0CIIB/ 40EyPuZ5SUA1jR0no2649AXwvZ7R0OW+SBDiF9Ymlgb1id3e5Ih2PbcNJT8o/u8k3w0EVvkAvot+aU f0+8GhazsfRSIk6xC9ugJKCnQwvHJVNayFPd5zv1EovZmufBljxVxVOAwiylioqbiFU75deLc2Mc9l 75nkTT4GbRj0CN1R67xwfKbQM8jEf+LU/ttIN+aAleI1Zt4EF6E3qsOZOfwou/AAV39PqarKja9deK qtjU1venYGZp7wC8g69T636e/VO3KPlq4Y9ZPMJ10hd8kzKBgdNsZnhuT8IS0MgDk7/n5IVBYHe5uk 2i49SKjkpghxcHWhNonprQJr9jwibS
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
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

When we use NT_ARM_SSVE to either enable streaming mode or change the
vector length for a process we do not currently do anything to ensure that
there is storage allocated for the SME specific register state.  If the
task had not previously used SME or we changed the vector length then
the task will not have had TIF_SME set or backing storage for ZA/ZT
allocated, resulting in inconsistent register sizes when saving state
and spurious traps which flush the newly set register state.

We should set TIF_SME to disable traps and ensure that storage is
allocated for ZA and ZT if it is not already allocated.  This requires
modifying sme_alloc() to make the flush of any existing register state
optional so we don't disturb existing state for ZA and ZT.

Fixes: e12310a0d30f ("arm64/sme: Implement ptrace support for streaming mode SVE registers")
Reported-by: David Spickett <David.Spickett@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # 5.19.x
Link: https://lore.kernel.org/r/20230810-arm64-fix-ptrace-race-v1-1-a5361fad2bd6@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
(cherry picked from commit 5d0a8d2fba50e9c07cde4aad7fba28c008b07a5b)
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h | 4 ++--
 arch/arm64/kernel/fpsimd.c      | 6 +++---
 arch/arm64/kernel/ptrace.c      | 9 ++++++++-
 arch/arm64/kernel/signal.c      | 2 +-
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 6f86b7ab6c28..d720b6f7e5f9 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -339,7 +339,7 @@ static inline int sme_max_virtualisable_vl(void)
 	return vec_max_virtualisable_vl(ARM64_VEC_SME);
 }
 
-extern void sme_alloc(struct task_struct *task);
+extern void sme_alloc(struct task_struct *task, bool flush);
 extern unsigned int sme_get_vl(void);
 extern int sme_set_current_vl(unsigned long arg);
 extern int sme_get_current_vl(void);
@@ -365,7 +365,7 @@ static inline void sme_smstart_sm(void) { }
 static inline void sme_smstop_sm(void) { }
 static inline void sme_smstop(void) { }
 
-static inline void sme_alloc(struct task_struct *task) { }
+static inline void sme_alloc(struct task_struct *task, bool flush) { }
 static inline void sme_setup(void) { }
 static inline unsigned int sme_get_vl(void) { return 0; }
 static inline int sme_max_vl(void) { return 0; }
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 356036babd09..8cd59d387b90 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1239,9 +1239,9 @@ void fpsimd_release_task(struct task_struct *dead_task)
  * the interest of testability and predictability, the architecture
  * guarantees that when ZA is enabled it will be zeroed.
  */
-void sme_alloc(struct task_struct *task)
+void sme_alloc(struct task_struct *task, bool flush)
 {
-	if (task->thread.za_state) {
+	if (task->thread.za_state && flush) {
 		memset(task->thread.za_state, 0, za_state_size(task));
 		return;
 	}
@@ -1460,7 +1460,7 @@ void do_sme_acc(unsigned long esr, struct pt_regs *regs)
 	}
 
 	sve_alloc(current, false);
-	sme_alloc(current);
+	sme_alloc(current, true);
 	if (!current->thread.sve_state || !current->thread.za_state) {
 		force_sig(SIGKILL);
 		return;
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index f19f020ccff9..f606c942f514 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -886,6 +886,13 @@ static int sve_set_common(struct task_struct *target,
 			break;
 		case ARM64_VEC_SME:
 			target->thread.svcr |= SVCR_SM_MASK;
+
+			/*
+			 * Disable traps and ensure there is SME storage but
+			 * preserve any currently set values in ZA/ZT.
+			 */
+			sme_alloc(target, false);
+			set_tsk_thread_flag(target, TIF_SME);
 			break;
 		default:
 			WARN_ON_ONCE(1);
@@ -1107,7 +1114,7 @@ static int za_set(struct task_struct *target,
 	}
 
 	/* Allocate/reinit ZA storage */
-	sme_alloc(target);
+	sme_alloc(target, true);
 	if (!target->thread.za_state) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 43adbfa5ead7..82f4572c8ddf 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -430,7 +430,7 @@ static int restore_za_context(struct user_ctxs *user)
 	fpsimd_flush_task_state(current);
 	/* From now, fpsimd_thread_switch() won't touch thread.sve_state */
 
-	sme_alloc(current);
+	sme_alloc(current, true);
 	if (!current->thread.za_state) {
 		current->thread.svcr &= ~SVCR_ZA_MASK;
 		clear_thread_flag(TIF_SME);
-- 
2.30.2

