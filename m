Return-Path: <stable+bounces-111245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C54A22730
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 01:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE881885C9B
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 00:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB1A935;
	Thu, 30 Jan 2025 00:28:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE120DF4
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 00:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738196893; cv=none; b=ezfLbGpiDPLdAh1epqrQd3ozExmZ+8xPRPvk5i+Iu32WvfDF5OaAwIw3TvifiRpBuHm16o3oBhLlioswtsZAJGRHIVx04F3LE5SP6p1Fj6F+K2IhPwEFpmsPSEm88DjR20bZLCZn2mW/j8hw+g3xaml66p2s0/YWgJB/PQOsR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738196893; c=relaxed/simple;
	bh=toB7x1IISXKuanTTsb6Z7yUpf9vwRHoRfQlfnWN10Qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WpSnnUiikjxKau85xSus+KzI/1PNHCfMpmRJ90XajSdxUC/epjHWNxN6kZ6s713XBgGRy/W6s5ptCJ0t8Jbl9NGqo34ya6+ZxASIINLW9CtvMkJ0yrhiag8pkornRbxwqyWA0wNGKosM/abOjzFJPUGKRkHz85iw/c+thbTrgv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 952E8233B8;
	Thu, 30 Jan 2025 03:28:03 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH v2 5.10/5.15/6.1 2/5] x86/mm: Recompute physical address for every page of per-CPU CEA mapping
Date: Thu, 30 Jan 2025 03:27:38 +0300
Message-Id: <20250130002741.66796-3-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20250130002741.66796-1-kovalev@altlinux.org>
References: <20250130002741.66796-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit 80d72a8f76e8f3f0b5a70b8c7022578e17bde8e7 upstream.

Recompute the physical address for each per-CPU page in the CPU entry
area, a recent commit inadvertantly modified cea_map_percpu_pages() such
that every PTE is mapped to the physical address of the first page.

Fixes: 9fd429c28073 ("x86/kasan: Map shadow for percpu pages on demand")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Link: https://lkml.kernel.org/r/20221110203504.1985010-2-seanjc@google.com
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 arch/x86/mm/cpu_entry_area.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index d7081b1accca64..c24f33c11421b3 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -60,7 +60,7 @@ cea_map_percpu_pages(void *cea_vaddr, void *ptr, int pages, pgprot_t prot)
 					early_pfn_to_nid(PFN_DOWN(pa)));
 
 	for ( ; pages; pages--, cea_vaddr+= PAGE_SIZE, ptr += PAGE_SIZE)
-		cea_set_pte(cea_vaddr, pa, prot);
+		cea_set_pte(cea_vaddr, per_cpu_ptr_to_phys(ptr), prot);
 }
 
 static void __init percpu_setup_debug_store(unsigned int cpu)
-- 
2.33.8


