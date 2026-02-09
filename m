Return-Path: <stable+bounces-214942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHhkI93uiWn4EQAAu9opvQ
	(envelope-from <stable+bounces-214942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:27:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5ED110468
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC7263024A5F
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F3D37AA90;
	Mon,  9 Feb 2026 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tc/kzsYs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB7837A496;
	Mon,  9 Feb 2026 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647149; cv=none; b=FrVAcVPHJ0EV8ud6ATszs7TICLS6mY2ZftDlt79EyblDigDCx2glw3Yvle1jv4V0uveADRFvA53d/o8KwUslUF84uEV7lkb/BNBV0HCefCWB3YjBlUpqwSXHNHDkVIYpat9a49PaaLr5k/m6glHw9cCgj3rcKehmEB6zs+FJzJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647149; c=relaxed/simple;
	bh=yb4zcaW0gkYEW1zg/S9rpyDglprz2h3Gqsh9tqbgoqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUcOPmuaGHmjYhKOAwl5370C/QpRgXN2zGe2Ivkc0OkTe+qxpYzq1MXGULs39y1pOJ3y4LSYu7XpKrY1sq7TMuEkgyueMAjofsZBtfC/4k093PPx0aFTcLW1akCBxIO1II5iMfhbM8oepPcbfg1dbieMKdAM3cA0j3YSE0Uw8BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tc/kzsYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE74C116C6;
	Mon,  9 Feb 2026 14:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647149;
	bh=yb4zcaW0gkYEW1zg/S9rpyDglprz2h3Gqsh9tqbgoqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tc/kzsYsKaMr3SPH+nGLkAx2kxnLAf8QhaIwrx67wiIEf+H9R6EJ9JMlvVofK/rmx
	 cmng+B3EewLbKpxQ708gH3YId05DtjIlLM30tQtigbHPrEl8D7ZMbwwD/KhZcFVWJ3
	 VFZOmQirlLKXD0kHv9JL27BMdDwCBsxA3nTMZWnA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jann Horn <jannh@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18 003/175] x86/kfence: fix booting on 32bit non-PAE systems
Date: Mon,  9 Feb 2026 15:21:16 +0100
Message-ID: <20260209142320.601528519@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,citrix.com,alien8.de,google.com,linutronix.de,redhat.com,linux.intel.com,zytor.com,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-214942-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: DA5ED110468
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Cooper <andrew.cooper3@citrix.com>

commit 16459fe7e0ca6520a6e8f603de4ccd52b90fd765 upstream.

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
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/kfence.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/kfence.h
+++ b/arch/x86/include/asm/kfence.h
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



