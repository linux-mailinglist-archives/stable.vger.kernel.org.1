Return-Path: <stable+bounces-272112-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d5dVGNbzSmrBKAEAu9opvQ
	(envelope-from <stable+bounces-272112-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 02:16:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 530B770BD22
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 02:16:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=fJrc6xKC;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272112-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272112-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A3B63006D73
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 00:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F23186284;
	Mon,  6 Jul 2026 00:16:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD1DB672;
	Mon,  6 Jul 2026 00:16:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783296974; cv=none; b=paI/x6oB15QTXAt2QvrnDvusAPpMhBJf27SgwEWQT0AxKxSj2BUcKalfVzvDJUrR1maCJ8aaE11D3UvVdk6iROCgLe1JV7Z5NrYFCyRpQnHln4nzTMwPacl/zx1Ow7IFvHmdsXGTMjS1XXZenOepWW7kLWlMBbsllmXOHXw6bjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783296974; c=relaxed/simple;
	bh=vqQ2mVHSPsqe7qkFwtrg4bb9or20jVEqW3VBB3OxRdg=;
	h=Date:To:From:Subject:Message-Id; b=X85TuRa2dfcpZxyxeRFxxsxb50wRj0C2DqKcYkI1fGZqQ/dY62rsFv8q/rSKR8uyTSOMd5VTb7XiyQ9ZeHOwmljoJrezCXpGMigme0KgEB065HhjQY4Gl7/U3GRwb8zV0pAwxILS2dGomCwnQ/0JQllznKN/oq1Q+qlnpRlVyl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fJrc6xKC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70B81F000E9;
	Mon,  6 Jul 2026 00:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783296973;
	bh=ZJzs087eHBwFc9QEWX/zlttM8ZxPq5rrurtn2qsfcN0=;
	h=Date:To:From:Subject;
	b=fJrc6xKCCXGEZf8oVU664fbbEoMYZXAaYf5+gWZYyJfggiuUKwkfnaeRrNYmPdZ9z
	 Qt6L0uK5qNuQA3/0z/wmzWyHXdQPVK6Wl1ITX6XXgQiV+S+aTqqRId0F83Q0s7z0xt
	 fqum2+tkw6yBw+HYt7nerElHiOi1nUKBvldRyDLI=
Date: Sun, 05 Jul 2026 17:16:12 -0700
To: mm-commits@vger.kernel.org,tglx@kernel.org,stable@vger.kernel.org,mingo@redhat.com,kdesler@soohrt.org,hpa@zytor.com,dave.hansen@linux.intel.com,bp@alien8.de,osalvador@suse.de,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [to-be-updated] archx86-skip-setting-align_offset-for-hugetlb-mappings.patch removed from -mm tree
Message-Id: <20260706001612.D70B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-272112-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:tglx@kernel.org,m:stable@vger.kernel.org,m:mingo@redhat.com,m:kdesler@soohrt.org,m:hpa@zytor.com,m:dave.hansen@linux.intel.com,m:bp@alien8.de,m:osalvador@suse.de,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 530B770BD22


The quilt patch titled
     Subject: arch,x86: skip setting align_offset for hugetlb mappings
has been removed from the -mm tree.  Its filename was
     archx86-skip-setting-align_offset-for-hugetlb-mappings.patch

This patch was dropped because an updated version will be issued

------------------------------------------------------
From: Oscar Salvador <osalvador@suse.de>
Subject: arch,x86: skip setting align_offset for hugetlb mappings
Date: Mon, 1 Jun 2026 14:50:15 +0200

On x86, arch_get_unmapped_area{_topdown} set align_offset in order to
avoid cache aliasing on I$ on AMD family 15h when 'align_va_addr' is
enabled.

Prior to commit 7bd3f1e1a9ae ("mm: make hugetlb mappings go through
mm_get_unmapped_area_vmflags"), we did not have to worry about that
because hugetlb specific code did not set align_offset, but the above
commit got rid of hugetlb specific code and started to route hugetlb
mappings through the generic interface.

Doing that has the effect of handing non-aligned hugetlb mappings to
userspace, which is plain wrong, eventually leading to a BUG in
__unmap_hugepage_range().

So, skip setting align_offset if we are dealing with a hugetlb mapping.

Link: https://lore.kernel.org/20260601125015.216110-1-osalvador@suse.de
Fixes: 7bd3f1e1a9ae ("mm: make hugetlb mappings go through mm_get_unmapped_area_vmflags")
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reported-by: Karsten Desler <kdesler@soohrt.org>
Closes: https://lore.kernel.org/linux-mm/20260527143643.GO31091@soohrt.org/
Tested-by: Karsten Desler <kdesler@soohrt.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/x86/kernel/sys_x86_64.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/sys_x86_64.c~archx86-skip-setting-align_offset-for-hugetlb-mappings
+++ a/arch/x86/kernel/sys_x86_64.c
@@ -157,7 +157,12 @@ arch_get_unmapped_area(struct file *filp
 	}
 	if (filp) {
 		info.align_mask = get_align_mask(filp);
-		info.align_offset += get_align_bits();
+		/*
+		 * Hugepages must remain hugepage-aligned, so skip adding an offset
+		 * in case we enabled 'align_va_addr'.
+		 */
+		if (!is_file_hugepages(filp))
+			info.align_offset += get_align_bits();
 	}
 
 	return vm_unmapped_area(&info);
@@ -222,7 +227,12 @@ get_unmapped_area:
 
 	if (filp) {
 		info.align_mask = get_align_mask(filp);
-		info.align_offset += get_align_bits();
+		/*
+		 * Hugepages must remain hugepage-aligned, so skip adding an offset
+		 * in case we enabled 'align_va_addr'.
+		 */
+		if (!is_file_hugepages(filp))
+			info.align_offset += get_align_bits();
 	}
 	addr = vm_unmapped_area(&info);
 	if (!(addr & ~PAGE_MASK))
_

Patches currently in -mm which might be from osalvador@suse.de are



