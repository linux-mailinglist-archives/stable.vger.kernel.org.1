Return-Path: <stable+bounces-212288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJVhFskyeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:01:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF05A4EE4
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A76B73040C0C
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEC5310774;
	Wed, 28 Jan 2026 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lha5LU0T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689A630FC1B;
	Wed, 28 Jan 2026 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615017; cv=none; b=tgDV4WEv1BqWYsv2RuUfVdfrllEJSRMqApezLVzi33a15wddoXalF6hdZSmzhp8whxf5UKHrecb92S2Ri11Qv27/Cc8epEFjKC24aAocw02ytlrB5pO1mKVyMcDQtTSJTupMxYPgX5LWfLsyF5ie6aNK3uAI5I+OP402gfXURKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615017; c=relaxed/simple;
	bh=sBf1R5SchPsXqpaQGuDwzTIlyG+7KQzBgFHbpjStzIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nli6mXjPN5n1Jg/RR3dKuYFI3XugEiSyljQqK6YhbMdmkauPq9i3bKNfW9WMi7fx+9THmStiytK03mZKo3Y7Bcqy0oABV9NOCjxyIgGvCTpbjk0MnwlOcKbWz6i9YdkWuoDFyuX2Dgdhm8jlLxn3syqDeoI0xIoJt/nH3xt6UhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lha5LU0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFBBC4CEF1;
	Wed, 28 Jan 2026 15:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615017;
	bh=sBf1R5SchPsXqpaQGuDwzTIlyG+7KQzBgFHbpjStzIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lha5LU0T6HS4WuG+aoChsuT8DyJ8lBIjF/A4g416ZJN5/aoJBEPfKXGfJjgFpZBl/
	 uVQ5X8fNx24lLiW9/JA8FYkUwq1NMZgPlB8kpord1+QSrK4suX7c335zLxI5EyYvpN
	 zBwNxK+9DvbNRH3e3kMHzpL/vAVvWPMI00w9J2n4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 054/169] x86/kfence: avoid writing L1TF-vulnerable PTEs
Date: Wed, 28 Jan 2026 16:22:17 +0100
Message-ID: <20260128145335.958425389@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212288-lists,stable=lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[citrix.com:query timed out,intel.com:query timed out,zytor.com:query timed out,linux-foundation.org:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RSPAMD_EMAILBL_FAIL(0.00)[dvyukov.google.com:query timed out,andrew.cooper3.citrix.com:query timed out,bp.alien8.de:query timed out,glider.google.com:query timed out,mingo.redhat.com:query timed out,dave.hansen.linux.intel.com:query timed out,akpm.linux-foundation.org:query timed out,elver.google.com:query timed out,tglx.linutronix.de:query timed out,jannh.google.com:query timed out,hpa.zytor.com:query timed out];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BFF05A4EE4
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Cooper <andrew.cooper3@citrix.com>

commit b505f1944535f83d369ae68813e7634d11b990d3 upstream.

For native, the choice of PTE is fine.  There's real memory backing the
non-present PTE.  However, for XenPV, Xen complains:

  (XEN) d1 L1TF-vulnerable L1e 8010000018200066 - Shadowing

To explain, some background on XenPV pagetables:

  Xen PV guests are control their own pagetables; they choose the new
  PTE value, and use hypercalls to make changes so Xen can audit for
  safety.

  In addition to a regular reference count, Xen also maintains a type
  reference count.  e.g.  SegDesc (referenced by vGDT/vLDT), Writable
  (referenced with _PAGE_RW) or L{1..4} (referenced by vCR3 or a lower
  pagetable level).  This is in order to prevent e.g.  a page being
  inserted into the pagetables for which the guest has a writable mapping.

  For non-present mappings, all other bits become software accessible,
  and typically contain metadata rather a real frame address.  There is
  nothing that a reference count could sensibly be tied to.  As such, even
  if Xen could recognise the address as currently safe, nothing would
  prevent that frame from changing owner to another VM in the future.

  When Xen detects a PV guest writing a L1TF-PTE, it responds by
  activating shadow paging.  This is normally only used for the live phase
  of migration, and comes with a reasonable overhead.

KFENCE only cares about getting #PF to catch wild accesses; it doesn't
care about the value for non-present mappings.  Use a fully inverted PTE,
to avoid hitting the slow path when running under Xen.

While adjusting the logic, take the opportunity to skip all actions if the
PTE is already in the right state, half the number PVOps callouts, and
skip TLB maintenance on a !P -> P transition which benefits non-Xen cases
too.

Link: https://lkml.kernel.org/r/20260106180426.710013-1-andrew.cooper3@citrix.com
Fixes: 1dc0da6e9ec0 ("x86, kfence: enable KFENCE for x86")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Tested-by: Marco Elver <elver@google.com>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/kfence.h |   29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/kfence.h
+++ b/arch/x86/include/asm/kfence.h
@@ -42,10 +42,34 @@ static inline bool kfence_protect_page(u
 {
 	unsigned int level;
 	pte_t *pte = lookup_address(addr, &level);
+	pteval_t val;
 
 	if (WARN_ON(!pte || level != PG_LEVEL_4K))
 		return false;
 
+	val = pte_val(*pte);
+
+	/*
+	 * protect requires making the page not-present.  If the PTE is
+	 * already in the right state, there's nothing to do.
+	 */
+	if (protect != !!(val & _PAGE_PRESENT))
+		return true;
+
+	/*
+	 * Otherwise, invert the entire PTE.  This avoids writing out an
+	 * L1TF-vulnerable PTE (not present, without the high address bits
+	 * set).
+	 */
+	set_pte(pte, __pte(~val));
+
+	/*
+	 * If the page was protected (non-present) and we're making it
+	 * present, there is no need to flush the TLB at all.
+	 */
+	if (!protect)
+		return true;
+
 	/*
 	 * We need to avoid IPIs, as we may get KFENCE allocations or faults
 	 * with interrupts disabled. Therefore, the below is best-effort, and
@@ -53,11 +77,6 @@ static inline bool kfence_protect_page(u
 	 * lazy fault handling takes care of faults after the page is PRESENT.
 	 */
 
-	if (protect)
-		set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
-	else
-		set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
-
 	/*
 	 * Flush this CPU's TLB, assuming whoever did the allocation/free is
 	 * likely to continue running on this CPU.



