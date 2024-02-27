Return-Path: <stable+bounces-25183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C4986988C
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02EE2B2E502
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68002145B0D;
	Tue, 27 Feb 2024 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r+heiPdi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28175145B0B;
	Tue, 27 Feb 2024 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044095; cv=none; b=lZU81HkSIcoj7wZ2Q/7lHWidwgGHXLAvbP4+Q6mPLCSu3nz2iqmUOJ4HTioDZickYWy5Df7nEUgzZzwhDu9O/b9eakZoCYiTCLKYL5INJGwXH74w1z6hTRWCwHXMj53VadH6qywo4OR0HDnO2pSXGqeAz30WDVN9t8d8R70NlJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044095; c=relaxed/simple;
	bh=8HwEkuRgXD2ksPH81p0RCLNaD1aYKfALWpFq8ccu+KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDjLDHHQWh93ZGEjakZ3soxwYPsbO7QwAywBJdUucCAiV36iVKgMpIC24rCscMX0GaKp1mEnLJjtTqSs6eSPKbXMnzn01tJBMHZZoXUNLEA9zs8egebytGzox5/0tg8hMt9Eu/qy4feSFbWd0fsd3liIt7XZ6O5YdGfQLAbuduI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r+heiPdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6180C433C7;
	Tue, 27 Feb 2024 14:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709044095;
	bh=8HwEkuRgXD2ksPH81p0RCLNaD1aYKfALWpFq8ccu+KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r+heiPdiFs87hTeZIqZDm2VfdCoQ7QQLn4RZRztEWBOvYxsJHV/JEwjNDme4ddWK+
	 4fBe4YK9o7hBe9ulR51YFtTB2VLI12aJdml68N/TF+WGdV4UOJ5tEwBd/vCFc2oqQH
	 VRz6uiw+iOHpRNvZL00JU2ykvwu7KANsabdBdG1M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Borislav Petkov <bp@suse.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 060/122] task_stack, x86/cea: Force-inline stack helpers
Date: Tue, 27 Feb 2024 14:27:01 +0100
Message-ID: <20240227131600.670336905@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131558.694096204@linuxfoundation.org>
References: <20240227131558.694096204@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

[ Upstream commit e87f4152e542610d0b4c6c8548964a68a59d2040 ]

Force-inline two stack helpers to fix the following objtool warnings:

  vmlinux.o: warning: objtool: in_task_stack()+0xc: call to task_stack_page() leaves .noinstr.text section
  vmlinux.o: warning: objtool: in_entry_stack()+0x10: call to cpu_entry_stack() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220324183607.31717-2-bp@alien8.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/cpu_entry_area.h | 2 +-
 include/linux/sched/task_stack.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index dd5ea1bdf04c5..75efc4c6f0766 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -143,7 +143,7 @@ extern void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags);
 
 extern struct cpu_entry_area *get_cpu_entry_area(int cpu);
 
-static inline struct entry_stack *cpu_entry_stack(int cpu)
+static __always_inline struct entry_stack *cpu_entry_stack(int cpu)
 {
 	return &get_cpu_entry_area(cpu)->entry_stack_page.stack;
 }
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index f24575942dabe..879a5c8f930b6 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -16,7 +16,7 @@
  * try_get_task_stack() instead.  task_stack_page will return a pointer
  * that could get freed out from under you.
  */
-static inline void *task_stack_page(const struct task_struct *task)
+static __always_inline void *task_stack_page(const struct task_struct *task)
 {
 	return task->stack;
 }
-- 
2.43.0




