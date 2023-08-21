Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B806B78331F
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjHUUI7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjHUUI7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:08:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE91E3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:08:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2619764A15
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3778EC433C8;
        Mon, 21 Aug 2023 20:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648536;
        bh=M+g/UnpP6LNzYTgLF7CLv3PQtgaxXMZ4/DkAxgZcfOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WqZmT9lw2+vkbawcFXe/xGIAbpqUqti42dvpEdLQz4vxP/jtQFt/kyD99WeolQMBG
         w7tS7N4JQR2TYiL5xl8lZ7XCfBXXyaBrweGAgoWlM2SQop8dgmeeXiJtGiW6bhijWu
         7T7hZarW1CGioleQUYA42VYwoLsdQTAxhtjeWtnY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Spickett <David.Spickett@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.4 210/234] arm64/ptrace: Ensure that SME is set up for target when writing SSVE state
Date:   Mon, 21 Aug 2023 21:42:53 +0200
Message-ID: <20230821194138.145326925@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

commit 5d0a8d2fba50e9c07cde4aad7fba28c008b07a5b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/fpsimd.h |    4 ++--
 arch/arm64/kernel/fpsimd.c      |    6 +++---
 arch/arm64/kernel/ptrace.c      |   11 +++++++++--
 arch/arm64/kernel/signal.c      |    2 +-
 4 files changed, 15 insertions(+), 8 deletions(-)

--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -356,7 +356,7 @@ static inline int sme_max_virtualisable_
 	return vec_max_virtualisable_vl(ARM64_VEC_SME);
 }
 
-extern void sme_alloc(struct task_struct *task);
+extern void sme_alloc(struct task_struct *task, bool flush);
 extern unsigned int sme_get_vl(void);
 extern int sme_set_current_vl(unsigned long arg);
 extern int sme_get_current_vl(void);
@@ -388,7 +388,7 @@ static inline void sme_smstart_sm(void)
 static inline void sme_smstop_sm(void) { }
 static inline void sme_smstop(void) { }
 
-static inline void sme_alloc(struct task_struct *task) { }
+static inline void sme_alloc(struct task_struct *task, bool flush) { }
 static inline void sme_setup(void) { }
 static inline unsigned int sme_get_vl(void) { return 0; }
 static inline int sme_max_vl(void) { return 0; }
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1285,9 +1285,9 @@ void fpsimd_release_task(struct task_str
  * the interest of testability and predictability, the architecture
  * guarantees that when ZA is enabled it will be zeroed.
  */
-void sme_alloc(struct task_struct *task)
+void sme_alloc(struct task_struct *task, bool flush)
 {
-	if (task->thread.sme_state) {
+	if (task->thread.sme_state && flush) {
 		memset(task->thread.sme_state, 0, sme_state_size(task));
 		return;
 	}
@@ -1515,7 +1515,7 @@ void do_sme_acc(unsigned long esr, struc
 	}
 
 	sve_alloc(current, false);
-	sme_alloc(current);
+	sme_alloc(current, true);
 	if (!current->thread.sve_state || !current->thread.sme_state) {
 		force_sig(SIGKILL);
 		return;
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -881,6 +881,13 @@ static int sve_set_common(struct task_st
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
@@ -1100,7 +1107,7 @@ static int za_set(struct task_struct *ta
 	}
 
 	/* Allocate/reinit ZA storage */
-	sme_alloc(target);
+	sme_alloc(target, true);
 	if (!target->thread.sme_state) {
 		ret = -ENOMEM;
 		goto out;
@@ -1171,7 +1178,7 @@ static int zt_set(struct task_struct *ta
 		return -EINVAL;
 
 	if (!thread_za_enabled(&target->thread)) {
-		sme_alloc(target);
+		sme_alloc(target, true);
 		if (!target->thread.sme_state)
 			return -ENOMEM;
 	}
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -474,7 +474,7 @@ static int restore_za_context(struct use
 	fpsimd_flush_task_state(current);
 	/* From now, fpsimd_thread_switch() won't touch thread.sve_state */
 
-	sme_alloc(current);
+	sme_alloc(current, true);
 	if (!current->thread.sme_state) {
 		current->thread.svcr &= ~SVCR_ZA_MASK;
 		clear_thread_flag(TIF_SME);


