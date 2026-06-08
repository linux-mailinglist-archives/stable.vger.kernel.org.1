Return-Path: <stable+bounces-262127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XqqdM8YyJ2rotAIAu9opvQ
	(envelope-from <stable+bounces-262127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 23:23:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B4665AA83
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 23:23:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=DDsdTSA5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262127-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262127-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F25530146BC
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 21:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B103A5435;
	Mon,  8 Jun 2026 21:23:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE131397339;
	Mon,  8 Jun 2026 21:23:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953782; cv=none; b=Pysrvv+iLsE5lElPLp7D5sLKAzNXuAVaO54+rK10xJLG/FpLbzOGsQUSvFwsYT3dke0oAkDA6A4i9eVD4Zz89unYirC49/o/vmbxD97qgkI1hgtId5mO1CdVneGvnxWC9zZH62DNrFR5nYmymJU8Bika/BeK5NHDn6Zw2es29EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953782; c=relaxed/simple;
	bh=QC3OoujatgWN+MeODp5BQpmtCSW4Sj1zoCeVL0TPIIk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aj4Rwb7DqUA/3Ihb+yaQgYPcs+1aEN3nFQKwfptKgo+V9+O8U0OIZ/fmGUk+c7TUNUYR3ol4XKPALwUQ/eXNfPgWBB8k0TOVXGH7k4sosiF7QssbHlT+N0yAUPbL2taySO+jFKEv0k4C6hFuMjuKec9wzjXTJ6aKKiE4WRumXj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DDsdTSA5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9D21F00893;
	Mon,  8 Jun 2026 21:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780953780;
	bh=5r8KYgeziJLoINJNNFem1kGIFqYvCyKRP4AgGvX1XNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DDsdTSA5rUbZKCWNzLHJo7zF5CUdBD48WlZqNC1MGpV4T7hK/jsvhF/1sImwuRX8U
	 ZRT+67GqqjbhB9yzavNdqlt7SwU9Gs+Ped/8Nw2q/45UmjeW2PNiA1DxWxm37608IE
	 lukA8HrLwC1Dw3YqC1HYPDbyQv0GeVu8uB5VR9UI=
Date: Mon, 8 Jun 2026 14:22:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrey Smirnov <andrey.smirnov@siderolabs.com>
Cc: pasha.tatashin@soleen.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 syzbot+2b5fe617654be3d8848b@syzkaller.appspotmail.com, Thomas Gleixner
 <tglx@linutronix.de>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
 <thomas.weissschuh@linutronix.de>, Andrei Vagin <avagin@gmail.com>, Andy
 Lutomirski <luto@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_table_check: do not track special (PFN-mapped)
 PTEs
Message-Id: <20260608142258.5028187b1d245b46554eb2dc@linux-foundation.org>
In-Reply-To: <20260608155758.1220420-1-andrey.smirnov@siderolabs.com>
References: <20260608155758.1220420-1-andrey.smirnov@siderolabs.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrey.smirnov@siderolabs.com,m:pasha.tatashin@soleen.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:syzbot+2b5fe617654be3d8848b@syzkaller.appspotmail.com,m:tglx@linutronix.de,m:thomas.weissschuh@linutronix.de,m:avagin@gmail.com,m:luto@kernel.org,m:vincenzo.frascino@arm.com,m:stable@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262127-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[soleen.com,kvack.org,vger.kernel.org,lists.infradead.org,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,syzkaller.appspotmail.com,linutronix.de,gmail.com,arm.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,2b5fe617654be3d8848b];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,siderolabs.com:email,linux-foundation.org:dkim,linux-foundation.org:mid,linux-foundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46B4665AA83

On Mon,  8 Jun 2026 19:57:58 +0400 Andrey Smirnov <andrey.smirnov@siderolabs.com> wrote:

> The vDSO data store ("[vvar]") special mapping is created as a VM_PFNMAP
> mapping and its pages are installed into userspace with vmf_insert_pfn(),
> which produces special PTEs (pte_special()). On x86 and arm64 (and riscv)
> pte_user_accessible_page() only tests the PRESENT/USER bits and does not
> exclude special PTEs, so page_table_check accounts these PFN mappings in
> the per-page anon/file map counters even though they are not rmap-managed
> pages (vm_normal_page() returns NULL for them).
> 
> Most of these data pages live in the kernel image and are never freed, so
> the stray accounting is invisible. The time-namespace VVAR page is the
> exception: it is a real alloc_page() page that is released with
> __free_page() in free_time_ns() when the last task of a time namespace
> exits. Across the map / unmap / vdso_join_timens() zap transitions the
> special-PTE accounting is not balanced for this page, so a non-zero
> file_map_count survives to the free path and trips:
> 
>   kernel BUG at mm/page_table_check.c:143!
>   __page_table_check_zero+0xfb/0x130
>   __free_frozen_pages+0x52f/0x650
>   free_time_ns+0x85/0xc0
>   free_nsproxy+0x7f/0x130
>   do_exit+0x313/0xa60
>   do_group_exit+0x77/0x90
> 
> This is reliably reproducible on x86_64 and arm64 under heavy container/CI
> churn that rapidly creates and destroys time namespaces (CLONE_NEWTIME via
> runc / docker-init / tini), and was independently reported by syzbot on
> riscv. It only manifests when CONFIG_PAGE_TABLE_CHECK is active.
> 
> Special PTEs have no struct-page rmap semantics and must never have been
> tracked by page table check. Skip them in both the set and clear paths so
> the counters stay balanced (always zero) for PFN-mapped pages, regardless
> of how the architecture defines pte_user_accessible_page(). pte_special()
> is available generically (it is a no-op returning false on architectures
> without ARCH_HAS_PTE_SPECIAL), so this is a single, arch-independent fix.
> 
> Note that the v7.0 generic vDSO datastore rework in commit 05988dba1179
> ("vdso/datastore: Allocate data pages dynamically") incidentally avoids
> the problem by switching the mapping to VM_MIXEDMAP + vmf_insert_page()
> with balanced struct-page accounting. This patch fixes the still-affected
> VM_PFNMAP path used by 6.18.y and earlier, and additionally makes
> page_table_check robust against any future PFN-mapped user pages.

Thanks.

The patch isn't applicable to current -linus mainline.  I reworked it
as below, then deleted it.  It would be better if this rework came from
yourself (tested), please.  And a patch which applies will get checked
by Sashiko AI review.

--- a/mm/page_table_check.c~mm-page_table_check-do-not-track-special-pfn-mapped-ptes
+++ a/mm/page_table_check.c
@@ -151,7 +151,15 @@ void __page_table_check_pte_clear(struct
 	if (&init_mm == mm)
 		return;
 
-	if (pte_user_accessible_page(mm, addr, pte))
+	/*
+	 * PFN-mapped (special) PTEs - e.g. the vDSO/time-namespace "[vvar]"
+	 * mapping installed via vmf_insert_pfn() - are not rmap-managed and
+	 * must not be tracked here. Tracking them can leave a non-zero map
+	 * count on a struct page that is later freed (the time namespace VVAR
+	 * page in free_time_ns()), tripping the BUG_ON() in
+	 * __page_table_check_zero().
+	 */
+	if (pte_user_accessible_page(mm, addr, pte) && !pte_special(pte))
 		page_table_check_clear(pte_pfn(pte), PAGE_SIZE >> PAGE_SHIFT);
 }
 EXPORT_SYMBOL(__page_table_check_pte_clear);
@@ -208,7 +216,7 @@ void __page_table_check_ptes_set(struct
 
 	for (i = 0; i < nr; i++)
 		__page_table_check_pte_clear(mm, addr + PAGE_SIZE * i, ptep_get(ptep + i));
-	if (pte_user_accessible_page(mm, addr, pte))
+	if (pte_user_accessible_page(mm, addr, pte) && !pte_special(pte))
 		page_table_check_set(pte_pfn(pte), nr, pte_write(pte));
 }
 EXPORT_SYMBOL(__page_table_check_ptes_set);
_


