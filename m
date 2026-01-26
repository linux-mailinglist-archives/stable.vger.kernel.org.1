Return-Path: <stable+bounces-211690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK2PF7Pbd2mjmAEAu9opvQ
	(envelope-from <stable+bounces-211690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 22:25:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A30998D9FD
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 22:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9CA730046AB
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F062F2E7621;
	Mon, 26 Jan 2026 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YO5dJrvv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A733C238178;
	Mon, 26 Jan 2026 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769462694; cv=none; b=jzICdpHRkon2yvnVGtdBJUnb5Dt6euNrODhKV+TnRHBk4gS5+qAckSgaVUSqb8wPOzY/BvUWX/gAdjRXeJfO5bcvdviO/iI+ttz/7V3G8/17pwltZ1zC1JZqWzcDSEqnrclJ2RrVLiV8tPfUorc3BwqTP6fMhzVlRUbUtISjWr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769462694; c=relaxed/simple;
	bh=0YQDQur0f03xloo9tSHreKMHtswvpRWzKG/U+pexrmc=;
	h=Date:To:From:Subject:Message-Id; b=mQ9hNk+hVYTMee1k4BHR4NeT5dxyfd8geXfwS4ziEESxgiuB9NRLt2UPVTELG0jpmppxPBbfOjzIsFSkw3LYgSpJClUdqGgm16Z26Rix5DPDJ3b5tYfPzygvmvHMUCBPhe1tDLw3OnAsyxGV6EYU050CgvrFbb3i0i6N56JxbIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YO5dJrvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DFBC116C6;
	Mon, 26 Jan 2026 21:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769462694;
	bh=0YQDQur0f03xloo9tSHreKMHtswvpRWzKG/U+pexrmc=;
	h=Date:To:From:Subject:From;
	b=YO5dJrvvByZ8v6ip/AIijdCdsu/qqDFQGQ3wGNHiO9QW/VmMFMBDrZ/mVSRrReFPk
	 6l3azVQYAFXDA247OIww9N4XG/FMC4klEno/TkjDi6jn4PhlDNh0gRpxkd1Eldk2Ld
	 sy39UcK407rpfPMISg0XnF/itKIkHg1rP5Vjs/Jc=
Date: Mon, 26 Jan 2026 13:24:53 -0800
To: mm-commits@vger.kernel.org,tglx@linutronix.de,stable@vger.kernel.org,mingo@redhat.com,konishi.ryusuke@gmail.com,jannh@google.com,hpa@zytor.com,glider@google.com,elver@google.com,dvyukov@google.com,dave.hansen@linux.intel.com,bp@alien8.de,andrew.cooper3@citrix.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + x86-kfence-fix-booting-on-32bit-non-pae-systems.patch added to mm-hotfixes-unstable branch
Message-Id: <20260126212454.34DFBC116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211690-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,linutronix.de,redhat.com,gmail.com,google.com,zytor.com,linux.intel.com,alien8.de,citrix.com,linux-foundation.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linux-foundation.org:dkim,zytor.com:email,intel.com:email,alien8.de:email,linutronix.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A30998D9FD
X-Rspamd-Action: no action


The patch titled
     Subject: x86/kfence: fix booting on 32bit non-PAE systems
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     x86-kfence-fix-booting-on-32bit-non-pae-systems.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/x86-kfence-fix-booting-on-32bit-non-pae-systems.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: x86/kfence: fix booting on 32bit non-PAE systems
Date: Mon, 26 Jan 2026 21:10:46 +0000

The original patch inverted the PTE unconditionally to avoid
L1TF-vulnerable PTEs, but Linux doesn't make this adjustment in 2-level
paging.

Adjust the logic to use the flip_protnone_guard() helper, which is a nop
on 2-level paging but inverts the address bits in all other paging modes.

This doesn't matter for the Xen aspect of the original change.  Linux no
longer supports running 32bit PV under Xen, and Xen doesn't support
running any 32bit PV guests without using PAE paging.

Link: https://lkml.kernel.org/r/20260126211046.2096622-1-andrew.cooper3@citrix.com
Fixes: b505f1944535 ("x86/kfence: avoid writing L1TF-vulnerable PTEs")
Reported-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Closes: https://lore.kernel.org/lkml/CAKFNMokwjw68ubYQM9WkzOuH51wLznHpEOMSqtMoV1Rn9JV_gw@mail.gmail.com/
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/x86/include/asm/kfence.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/kfence.h~x86-kfence-fix-booting-on-32bit-non-pae-systems
+++ a/arch/x86/include/asm/kfence.h
@@ -42,7 +42,7 @@ static inline bool kfence_protect_page(u
 {
 	unsigned int level;
 	pte_t *pte = lookup_address(addr, &level);
-	pteval_t val;
+	pteval_t val, new;
 
 	if (WARN_ON(!pte || level != PG_LEVEL_4K))
 		return false;
@@ -57,11 +57,12 @@ static inline bool kfence_protect_page(u
 		return true;
 
 	/*
-	 * Otherwise, invert the entire PTE.  This avoids writing out an
+	 * Otherwise, flip the Present bit, taking care to avoid writing an
 	 * L1TF-vulnerable PTE (not present, without the high address bits
 	 * set).
 	 */
-	set_pte(pte, __pte(~val));
+	new = val ^ _PAGE_PRESENT;
+	set_pte(pte, __pte(flip_protnone_guard(val, new, PTE_PFN_MASK)));
 
 	/*
 	 * If the page was protected (non-present) and we're making it
_

Patches currently in -mm which might be from andrew.cooper3@citrix.com are

x86-kfence-fix-booting-on-32bit-non-pae-systems.patch


