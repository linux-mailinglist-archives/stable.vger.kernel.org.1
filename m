Return-Path: <stable+bounces-186205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED06BE54BA
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 21:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA69558622D
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 19:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AF02DCBFD;
	Thu, 16 Oct 2025 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iltZFzNG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D2D28E571
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760644651; cv=none; b=H4A62jQS2mEtF7o9L2ph/MhFa18atKBuQSaboXufQiLTMNKM/MC4C3qbyO+mSh6UYAZ8FewKib0VJqVsTcU+7wrhCC4fFxNGlPmN0m9NLYbZirAvqfaxMXm0uAqaHDQU3vEklDbD9qrz10AdpFGGKa4eUiKCUxG52AqwGreipJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760644651; c=relaxed/simple;
	bh=052U6n/BfXrX/fMaOwazMP0C6ogjWT1byNbBWOxYon0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Naa7pnE46N9c+8BZ2c4mev4px76nlX9FwIEnNDImTIH2xSelGqZ80SPW/FrhKYeIFnvVX9/vPlZNj9xIxvkPNrsMOkwD18g9DyH/OlVrxw7Y0chgL3PDO5lE7OYH/soeEauaWDuFucwLPAPaaXBs7X+UQ2OgygNZcMG/uVKxQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iltZFzNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F93C116B1;
	Thu, 16 Oct 2025 19:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760644651;
	bh=052U6n/BfXrX/fMaOwazMP0C6ogjWT1byNbBWOxYon0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iltZFzNGJ0VVxV3wPYs2CCU0guaoOU3kXGeuPgS6YE7aAFpPjvnvAjWZ3CTOOfCFo
	 9I3iYth08lFDs+lSs4I5uCy4pyv1Cct+q0F6A+JIPu2qK1APwvbxnNvv5G1WogGApo
	 MJ0wAtCiZ78OFzMgNqGctyIlUkYMhHw+z3ycKeiDG190+O/Vn0CXzBuF9ZZL0mcyWG
	 I3Y2OLDZQ8z8qXgdEPF5vbthjwXVDtY3XhZjN+K4mNsoHelRc8QXXg23gNJEL37L8t
	 2zdB2sXuXxlmqjNGSaheErqExEdA0J8SBNxpvFPCvIsuOS3vdfYXnHrJyDG7fv7ZRU
	 Dv6TscI++pIZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Shi <yang@os.amperecomputing.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] arm64: kprobes: call set_memory_rox() for kprobe page
Date: Thu, 16 Oct 2025 15:57:28 -0400
Message-ID: <20251016195728.3396584-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101658-gladiator-reheat-eca3@gregkh>
References: <2025101658-gladiator-reheat-eca3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Shi <yang@os.amperecomputing.com>

[ Upstream commit 195a1b7d8388c0ec2969a39324feb8bebf9bb907 ]

The kprobe page is allocated by execmem allocator with ROX permission.
It needs to call set_memory_rox() to set proper permission for the
direct map too. It was missed.

Fixes: 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page")
Cc: <stable@vger.kernel.org>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
[ kept existing __vmalloc_node_range() instead of upstream's execmem_alloc() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/probes/kprobes.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 70b91a8c6bb3f..c0942cce3b687 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -131,9 +131,15 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 
 void *alloc_insn_page(void)
 {
-	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
+	void *addr;
+
+	addr = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
 			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
 			NUMA_NO_NODE, __builtin_return_address(0));
+	if (!addr)
+		return NULL;
+	set_memory_rox((unsigned long)addr, 1);
+	return addr;
 }
 
 /* arm kprobe: install breakpoint in text */
-- 
2.51.0


