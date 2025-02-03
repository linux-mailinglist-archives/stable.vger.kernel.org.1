Return-Path: <stable+bounces-112022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6BAA25A10
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 13:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE9E1655CF
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 12:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC1E205AA2;
	Mon,  3 Feb 2025 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T890XfEe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="98PLDYX8"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869320550E;
	Mon,  3 Feb 2025 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738587006; cv=none; b=kVOhyJTGS6u9gcY8sVs29ARlVovasULLToSJlgtiWrzJIhhYfjK/Mzb9iiuMgJ42BusSyatPVOR+Bg01zxHY/NokR6rSUbxWoEnNA7Ag0/y5pzRTEq4cPCc8qENNtU1Sid3T//19ba6RX20ejxQOZuynitMEFFP45/GDyZgFeLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738587006; c=relaxed/simple;
	bh=T52D8yVqjNMexPh/PaPVha4hQOnbwST3/9mFXWACe1s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XT5mrkfTNtmhGABu5v7vkDyQENMNtSqSqctkg/D/1Y1VYcEHhxIiwLgdh++7SRFsMy/92QZ7aTVKTIyE/MJSqU3dVj+NmfjOnoC6/F8rbRJfJdyJVYOjsrwD286bXZ7cdiJ3lyfhfsd661uFtDS9Zu45dQDdNWdyBnsoC07//Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T890XfEe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=98PLDYX8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:50:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738587002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8eaQHekOjZfHpNgYXDkBrHaxw5CaOq8W6esUq9rEv8=;
	b=T890XfEejZW3SXnnyWuUxGInRsMx51Sw+GYOlUYD4A254uDI+d3f/LB9g59eNvgAgbFOP0
	G4SbmCnHfyGQbcFVLLZv4FtuY6ZokoDvuleooiX9mzF2EHOo7Z+sfGzqh9roHi+v8p7oel
	oHAreksjs3BHpMXphq1nAxomjjC8XgKvicsOAYuBho+AzVwOd9T148PnFBUaj6r98arm4Q
	BsPKprZczPTJ3TzLByLq7woVV7k5Ok1JLkdaynxDWoObDiByxa4kP6Rl6P5PLAVbxIppWO
	SozOZdJkwh5lZ5EbDUJhGf8ZCo2iiLd6ZBZxPX3TWti4Hb76oSJflxGimYxAoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738587002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8eaQHekOjZfHpNgYXDkBrHaxw5CaOq8W6esUq9rEv8=;
	b=98PLDYX8QXz9mM3mV19uY73KVrywl98AMtIUWVNhhgfxFmJxqRiAwsQY4+yygNC5LWZarn
	lDJnBnu8aFHLmIAw==
From: "tip-bot2 for Jann Horn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/mm: Fix flush_tlb_range() when used for zapping normal PMDs
Cc: Jann Horn <jannh@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250103-x86-collapse-flush-fix-v1-1-3c521856cfa6@google.com>
References: <20250103-x86-collapse-flush-fix-v1-1-3c521856cfa6@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858700223.10177.5958477749533350297.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     3ef938c3503563bfc2ac15083557f880d29c2e64
Gitweb:        https://git.kernel.org/tip/3ef938c3503563bfc2ac15083557f880d29c2e64
Author:        Jann Horn <jannh@google.com>
AuthorDate:    Fri, 03 Jan 2025 19:39:38 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:03 +01:00

x86/mm: Fix flush_tlb_range() when used for zapping normal PMDs

On the following path, flush_tlb_range() can be used for zapping normal
PMD entries (PMD entries that point to page tables) together with the PTE
entries in the pointed-to page table:

    collapse_pte_mapped_thp
      pmdp_collapse_flush
        flush_tlb_range

The arm64 version of flush_tlb_range() has a comment describing that it can
be used for page table removal, and does not use any last-level
invalidation optimizations. Fix the X86 version by making it behave the
same way.

Currently, X86 only uses this information for the following two purposes,
which I think means the issue doesn't have much impact:

 - In native_flush_tlb_multi() for checking if lazy TLB CPUs need to be
   IPI'd to avoid issues with speculative page table walks.
 - In Hyper-V TLB paravirtualization, again for lazy TLB stuff.

The patch "x86/mm: only invalidate final translations with INVLPGB" which
is currently under review (see
<https://lore.kernel.org/all/20241230175550.4046587-13-riel@surriel.com/>)
would probably be making the impact of this a lot worse.

Fixes: 016c4d92cd16 ("x86/mm/tlb: Add freed_tables argument to flush_tlb_mm_range")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20250103-x86-collapse-flush-fix-v1-1-3c521856cfa6@google.com
---
 arch/x86/include/asm/tlbflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 02fc2aa..3da6451 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -242,7 +242,7 @@ void flush_tlb_multi(const struct cpumask *cpumask,
 	flush_tlb_mm_range((vma)->vm_mm, start, end,			\
 			   ((vma)->vm_flags & VM_HUGETLB)		\
 				? huge_page_shift(hstate_vma(vma))	\
-				: PAGE_SHIFT, false)
+				: PAGE_SHIFT, true)
 
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,

