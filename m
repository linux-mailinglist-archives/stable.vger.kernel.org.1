Return-Path: <stable+bounces-82755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C35B994E4B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1320A1F21539
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB68F1DEFF3;
	Tue,  8 Oct 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QQqINEbx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632B1D3653;
	Tue,  8 Oct 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393319; cv=none; b=gKqG0lON80aa5DqU3vYE9tVS2ef/VyxJQG+7DHtGs8gy7NSvDf0Oy3MdOI5IQfof5lGiESji+blpiQeQQvDboENT15ebpdyhcI9KP1kgUcg/M6axfOr/sxmE5gjFkQCKrK8xsnd136zx71+tgaJrXV8f/GzvMmWokTImr+lQvgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393319; c=relaxed/simple;
	bh=BM+LgGwU71X9VPdp2HY+jHaiB7zWJPxTueMr0W66GE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5hAqTA27p9oou45xarPgV65O5mjT4w8YSAuTeYXdgiU6hljvZYaryY7kpyjZDYVFH1qJYwnHz9ediUnQlX59HZ/E9Htx4Z7gtYXo2vo9V7jksir9q06uHPZJAlTK4GEHVJLoX4ZYI4jRnh5cw5BPvNjCqNqINvnnzEX8ZyJspU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QQqINEbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BC0C4CEC7;
	Tue,  8 Oct 2024 13:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728393319;
	bh=BM+LgGwU71X9VPdp2HY+jHaiB7zWJPxTueMr0W66GE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQqINEbxQHENVA052MCOp/Jpm8EYHTwrWLxb+NekGNJ1Ar8HfW0OmmPkbmDrbXI8K
	 tMyTQLsVQpU60Ba/mweAxbxbLXADV5crl8XdFmknjVrKO1mEyFaiwl0aceo6yqm+E7
	 dBqKSQdEF11lmwGv2etasauuuAU8aYG8b5ebkuW0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 116/386] x86/pkeys: Restore altstack access in sigreturn()
Date: Tue,  8 Oct 2024 14:06:01 +0200
Message-ID: <20241008115634.007507328@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 23d8aaf8d9fd1..449a6ed0b8c98 100644
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




