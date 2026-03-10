Return-Path: <stable+bounces-223885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIMDG7z8r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E644324A1D9
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79E5B30AE78F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839EE3859E9;
	Tue, 10 Mar 2026 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heMe/Qz/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449FC383C64;
	Tue, 10 Mar 2026 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140786; cv=none; b=thZKaHZdn5jAlgV+YibgTpWh7hUMLEkQjoWVIH2MmUHvhtHfTFAYyWlmbdKxAsEykVVetXpaaZDAYiSaTo/RK/wOk2QboUHTn+F0IQ244tR24HDT5TMxkBQE0xdmLYZ0uHn2gj3A8wUdz4c28sVMUOTf+pxXpI5oreTa5UEG9ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140786; c=relaxed/simple;
	bh=HdqsFMjEn2aQ7xgCkn55ymMU1crDeX44i16zTFvMkV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukjKtkNkTtEr1BPZlobO3ntMYjMmsTc/fmv3ZpkqKxN2rvnlwCr8YGEGhfm2mBL9bCiz72xA0CT9Hkz5bT7jTqktCrHmB5FwY+Cb36TtbsNtwH1Mr6VpW5Qdc/jWDzPUFcqEis3ZGe+a4jYuMzGFPlgrvmULWreQ9f7yxNLUnXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heMe/Qz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBB5C19423;
	Tue, 10 Mar 2026 11:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773140785;
	bh=HdqsFMjEn2aQ7xgCkn55ymMU1crDeX44i16zTFvMkV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=heMe/Qz/gCMKSxrGm2+QclDohDAjY1S2dddzlsDv99GC+Tche4uxveHL9Tt+kAoRW
	 wpn/UeuCMTiuFkSC2OWJaxIgh/+JORCEFlOneM0WnlmjHf5rgNxG3J06Aw0X8quJDk
	 3bE2HdoVj0Y9nchVCeEcg+SxwrZOHAA3LBB9eLF2rec5uSyPXW90diRm34vNTxPcc2
	 iyOmtjyybZx+s5mopeq6wvXuJQvPWLRajwzPqtOAS88kwif+xGuVM3TzxTffPl/1Oi
	 Ix89K58QDa1RdcBJduQ9heft2pzk8TO4WbIHg7Dpgkcb7YMibDXUnc0frCu1N7aYOz
	 uu7sxwfnYE1VA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 021/311] x86/bug: Handle __WARN_printf() trap in early_fixup_exception()
Date: Tue, 10 Mar 2026 07:01:08 -0400
Message-ID: <89c6a1d3f88bd41bf6bac4d4dbbd388954382c78.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E644324A1D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223885-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Hou Wenlong <houwenlong.hwl@antgroup.com>

[ Upstream commit a0cb371b521dde44f32cfe954b6ef6f82b407393 ]

The commit 5b472b6e5bd9 ("x86_64/bug: Implement __WARN_printf()")
implemented __WARN_printf(), which changed the mechanism to use UD1
instead of UD2. However, it only handles the trap in the runtime IDT
handler, while the early booting IDT handler lacks this handling. As a
result, the usage of WARN() before the runtime IDT setup can lead to
kernel crashes. Since KMSAN is enabled after the runtime IDT setup, it
is safe to use handle_bug() directly in early_fixup_exception() to
address this issue.

Fixes: 5b472b6e5bd9 ("x86_64/bug: Implement __WARN_printf()")
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/c4fb3645f60d3a78629d9870e8fcc8535281c24f.1768016713.git.houwenlong.hwl@antgroup.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/traps.h | 2 ++
 arch/x86/kernel/traps.c      | 2 +-
 arch/x86/mm/extable.c        | 7 ++-----
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 869b880618018..3f24cc472ce9b 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -25,6 +25,8 @@ extern int ibt_selftest_noendbr(void);
 void handle_invalid_op(struct pt_regs *regs);
 #endif
 
+noinstr bool handle_bug(struct pt_regs *regs);
+
 static inline int get_si_code(unsigned long condition)
 {
 	if (condition & DR_STEP)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index bcf1dedc1d008..aca1eca5daffa 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -397,7 +397,7 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
 
-static noinstr bool handle_bug(struct pt_regs *regs)
+noinstr bool handle_bug(struct pt_regs *regs)
 {
 	unsigned long addr = regs->ip;
 	bool handled = false;
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 2fdc1f1f5adb9..6b9ff1c6cafa2 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -411,14 +411,11 @@ void __init early_fixup_exception(struct pt_regs *regs, int trapnr)
 		return;
 
 	if (trapnr == X86_TRAP_UD) {
-		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
-			/* Skip the ud2. */
-			regs->ip += LEN_UD2;
+		if (handle_bug(regs))
 			return;
-		}
 
 		/*
-		 * If this was a BUG and report_bug returns or if this
+		 * If this was a BUG and handle_bug returns or if this
 		 * was just a normal #UD, we want to continue onward and
 		 * crash.
 		 */
-- 
2.51.0


