Return-Path: <stable+bounces-83113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E030995B19
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 00:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1887E1F23EEF
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 22:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589A921A6FD;
	Tue,  8 Oct 2024 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ERUsqzFi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y84tVgX+"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A8219CBA;
	Tue,  8 Oct 2024 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427543; cv=none; b=tIG5lszUMqajHUCC0C0KvoaDox+d+YlWSZrYz7oDVFmJMFwKdlraSieX0lRiyXeRJbzTiqlBYbevyv1zA7VUL33Ec8rd5eHJ0JtER28IgBeKrCi3chaZwvXIOO8jLXXfWOvjfWnyqoVTDBPzJPDA/2DHFuJawmJByKF4beOhVAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427543; c=relaxed/simple;
	bh=TQQX8Csg4kP6lybog7K7pewGEW6T8xqdqpF8ZqELGEQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=FBXIbe5QsAJHk5lqFcNm6ejfvWd8PgeIxHcNTErcBV8E2ya3+hAwnCEeI9sS7qw0et1qiTr5Hj+iJkhDQWdDysb/5tnNBgnar/Rz09PSwa/3dKQ4oN7OtEgBqzxq3ViJsg+6QjuT2sUlkw9R9h6ppHEaFDu3dJ10i1eDIw8DpHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ERUsqzFi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y84tVgX+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 22:45:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728427539;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Mt4yy3RuYZhnpIR2LUoOy19zX2CRq0snwn2ZZpXFDgw=;
	b=ERUsqzFif0k0h3gMzdkuqsssTz5mz/qIE3B4aL95zrfrzx8CbiCxLpD+AvxWyWhiujccuj
	nfI4x1uGw7FeL8yNBqQ/IpFfPz+WX0xYlLTeBD95yxJlHqODwEVCvR77Di6/VXL83MCmd3
	uVsaCGhBY9XlG2ZqpuP+BaTowQTfjMBA7mwU8ew7RQgK7ADr9AO8Opvj9HfUYTdgj/iX95
	SoDs3VXczymjPllkH/uLD78Jut+V9Z5InEKh8J/Q6GOXEZoovrXb61DPdL7eh49RC7MaF4
	CpDyHNPw3BXw2y/WSre8DDJlIS4b7cf6Sjx3++g4DTav8VAYXAL58XNymtJb6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728427539;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Mt4yy3RuYZhnpIR2LUoOy19zX2CRq0snwn2ZZpXFDgw=;
	b=y84tVgX+ZZZhG5P3eyYwUJPy7jnWoQCmmHA4UQ5tIztXEijcLAgBikPWeCyMMKa3vKN+dT
	I3aMVAl3A5xVaDDw==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry_32: Do not clobber user EFLAGS.ZF
Cc: Jari Ruusu <jariruusu@protonmail.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172842753839.1442.13022117843861983618.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2e2e5143d4868163d6756c8c6a4d28cbfa5245e5
Gitweb:        https://git.kernel.org/tip/2e2e5143d4868163d6756c8c6a4d28cbfa5245e5
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Wed, 25 Sep 2024 15:25:38 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 08 Oct 2024 15:16:28 -07:00

x86/entry_32: Do not clobber user EFLAGS.ZF

Opportunistic SYSEXIT executes VERW to clear CPU buffers after user EFLAGS
are restored. This can clobber user EFLAGS.ZF.

Move CLEAR_CPU_BUFFERS before the user EFLAGS are restored. This ensures
that the user EFLAGS.ZF is not clobbered.

Closes: https://lore.kernel.org/lkml/yVXwe8gvgmPADpRB6lXlicS2fcHoV5OHHxyuFbB_MEleRPD7-KhGe5VtORejtPe-KCkT8Uhcg5d7-IBw4Ojb4H7z5LQxoZylSmJ8KNL3A8o=@protonmail.com/
Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Reported-by: Jari Ruusu <jariruusu@protonmail.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240925-fix-dosemu-vm86-v7-1-1de0daca2d42%40linux.intel.com
---
 arch/x86/entry/entry_32.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d3a814e..9ad6cd8 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -871,6 +871,8 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	/* Now ready to switch the cr3 */
 	SWITCH_TO_USER_CR3 scratch_reg=%eax
+	/* Clobbers ZF */
+	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Restore all flags except IF. (We restore IF separately because
@@ -881,7 +883,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
-	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.

