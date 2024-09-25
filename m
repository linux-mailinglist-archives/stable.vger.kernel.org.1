Return-Path: <stable+bounces-77431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32023985D29
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02AB1F24464
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159381DB554;
	Wed, 25 Sep 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roHeZABn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754691B143F;
	Wed, 25 Sep 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265755; cv=none; b=PG07jp1rHXxkHewVWP72NOUatnSGgMsTjTskF1HDhIW2i0/oG9e5mBrqPnQhYd5RnZe1EvnMXjMOEDeGb8A7xdzzleXrGitnnrNBrgB5Zeg3z96eusMe8ZKPBTolrH/AHAtCQTkgoZrD+5fC9i3MTpXGqzdrT0zNaG72b5Tfrvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265755; c=relaxed/simple;
	bh=ZYESEMUpErJ4ayIMU3hPmisXks/BT9GQ4NHkdXkKUlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFzyMrmRqRWgFVoYgLz9fL93GNNIAZLa/k5Cep3Y7wVjpYbkk6p/xCMqLLmsVo6tFPD4tgksXcU0FNa2apQr4QWtYXNNEDWszIgEJOoQd2UMSQG3AmfVWWVVOZTjhTI1f9iTbo4Gs5pOItv/2J5k8Vr2R5YnLxSc0qCGtPb+ioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roHeZABn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9418FC4CEC3;
	Wed, 25 Sep 2024 12:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265755;
	bh=ZYESEMUpErJ4ayIMU3hPmisXks/BT9GQ4NHkdXkKUlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=roHeZABnUn6ryQod8XfnyenaKzUcnLWjLywJmmKa9c4/4Cv1jB1BKqr6RqeMkpnr7
	 5HI6sqoe0K4WiAfFXUaao5QS/TKQ5gGw/iWInVjgdXOvlysVT2e4Ybt8Go5pg5kHqk
	 HpKESq9VICH5Uh7XouoetwxQWfdvTwXgUXpZ3sMyQuD0cNxRMZeKrlpJ9DiCM3HcAw
	 rMKUiZhGY0zFyy0pFPOFnVN7fhnXmbPUHmRES3B1rjIb5MwXrMKtZukPxJmCYo8T4s
	 TEGM8fM4Jc/4C6i7Ezyt1affGa9WLZy54eMcVs/JZ70CILxu7V+rzQKesEqGl4DZOs
	 I7Y2dcBZX/CwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	rick.p.edgecombe@intel.com,
	hjl.tools@gmail.com
Subject: [PATCH AUTOSEL 6.10 086/197] x86/pkeys: Restore altstack access in sigreturn()
Date: Wed, 25 Sep 2024 07:51:45 -0400
Message-ID: <20240925115823.1303019-86-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>

[ Upstream commit d10b554919d4cc8fa8fe2e95b57ad2624728c8e4 ]

A process can disable access to the alternate signal stack by not
enabling the altstack's PKEY in the PKRU register.

Nevertheless, the kernel updates the PKRU temporarily for signal
handling. However, in sigreturn(), restore_sigcontext() will restore the
PKRU to the user-defined PKRU value.

This will cause restore_altstack() to fail with a SIGSEGV as it needs read
access to the altstack which is prohibited by the user-defined PKRU value.

Fix this by restoring altstack before restoring PKRU.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240802061318.2140081-5-aruna.ramakrishna@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/signal_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 8a94053c54446..ee9453891901b 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -260,13 +260,13 @@ SYSCALL_DEFINE0(rt_sigreturn)
 
 	set_current_blocked(&set);
 
-	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
-	if (restore_signal_shadow_stack())
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
-	if (restore_altstack(&frame->uc.uc_stack))
+	if (restore_signal_shadow_stack())
 		goto badframe;
 
 	return regs->ax;
-- 
2.43.0


