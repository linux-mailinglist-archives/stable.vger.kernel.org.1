Return-Path: <stable+bounces-227502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HUpG9ESvWnG6QIAu9opvQ
	(envelope-from <stable+bounces-227502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:26:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FB32D7FD8
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 286A0305D285
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 09:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB14D36215A;
	Fri, 20 Mar 2026 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ICswiIhr"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0535233F5BA;
	Fri, 20 Mar 2026 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998730; cv=none; b=P98XLHnJytM7maOGcN3haDDyv7lfiQbuS7yFNrJtPtgM14rHCk3Pt6fCqRhuUaWMflGTBGOF2srUCFhRcBMrVCqU9Rt8hB0CyBzOs5oRME7ePvm5Vh+vV80N5ijqyMxiv1TY1/tjWJfrT6IdZ2Rs/FZCoyeu0N79nrLzO018zv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998730; c=relaxed/simple;
	bh=znPOpiEJwYLiTlYVkKoe/IHzvAviWMTzv16qtNZ1iWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+fpOWXvDyj0iHRgZW4ZY+H2M8CQoWU8jj6eS2yG7LWAmi9GIC/Mm8yTvWsA2NNCYTgqZhX3qCfzAhFM3W8X/HwvOUCFJ0nIKV0sjTdy+BlTfAoIlbumhfLqvkpelA6Pgw0Nb/U+4rtV71CoVr9GiiZxt9l1hxXuLu0JVvr1Kss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ICswiIhr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TZvSYdXSZCuJYzv6r9GmgLB94F4V1JzGvO04TEeXOA0=; b=ICswiIhrGUF0kjJS/b0HAKbMs2
	w+BiXDKduMOz57ZbWEpf+PwHPQwBneax3B6yfk1tMDiOoB47zilcBSFsF8mANjEH5bw6vwKtKaPOY
	w7uhO6NPjvXamJAed9xxGvT7vzFvBaVDPJX+K7btHVg5ovLPNFlm/jQlsGWc1LE64zs+vqjEe5PSk
	xf5BIJ+1TM34BgUocBodn++KrR5AcTOt+11enVIarL20Pckzz5jgl/SiTUaAZ3yd2bfLeYQ9vaJBq
	/w55cU6bUkAg41AYpF2ajUeHEgLsib8D7JArRAe7zthInRylTmwySPdYvuymroZ+iqWzzGfkLatl7
	DiExxJZQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3W6b-00000007XrE-3dIk;
	Fri, 20 Mar 2026 09:25:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 484F7302FFB; Fri, 20 Mar 2026 10:25:21 +0100 (CET)
Date: Fri, 20 Mar 2026 10:25:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Nikunj A Dadhania <nikunj@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sohil Mehta <sohil.mehta@intel.com>, stable@vger.kernel.org,
	x86@kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH] x86/cpu: Add comment clarifying CRn pinning
Message-ID: <20260320092521.GG3739106@noisy.programming.kicks-ass.net>
References: <20260318075654.1792916-3-nikunj@amd.com>
 <177385987098.1647592.3381141860481415647.tip-bot2@tip-bot2>
 <20260318204722.GD3738786@noisy.programming.kicks-ass.net>
 <20260318220939.GD3739106@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318220939.GD3739106@noisy.programming.kicks-ass.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227502-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,noisy.programming.kicks-ass.net:mid,infradead.org:dkim,infradead.org:email]
X-Rspamd-Queue-Id: E1FB32D7FD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Since Boris wanted a nice patch to just press 'apply' on, here goes :-)


---
Subject: x86/cpu: Add comment clarifying CRn pinning
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 18 Mar 2026 23:09:39 +0100

To avoid future confusion on the purpose and design of the CRn pinning
code.

Also note that if the attacker controls page-tables, the CRn bits
loose much of the attraction anyway.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/common.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -434,6 +434,19 @@ static __always_inline void setup_lass(s
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
 					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
+
+/*
+ * The CR pinning protects against ROP on the 'mov %reg, %CRn' instruction(s).
+ * Since you can ROP directly to these instructions (barring shadow stack),
+ * any protection must follow immediately and unconditionally after that.
+ *
+ * Specifically, the CR[04] write functions below will have the value
+ * validation controlled by the @cr_pinning static_branch which is
+ * __ro_after_init, just like the cr4_pinned_bits value.
+ *
+ * Once set, an attacker will have to defeat page-tables to get around these
+ * restrictions. Which is a much bigger ask than 'simple' ROP.
+ */
 static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
 static unsigned long cr4_pinned_bits __ro_after_init;
 


