Return-Path: <stable+bounces-273776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gJfOCRfsVGohhQAAu9opvQ
	(envelope-from <stable+bounces-273776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:45:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDCC74BD3A
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:45:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shutemov.name header.s=fm3 header.b="S nxlMej";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=KVZ4xmzq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273776-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273776-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF9DE30705D3
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BBB4314A5;
	Mon, 13 Jul 2026 13:38:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6D4314A4;
	Mon, 13 Jul 2026 13:38:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949887; cv=none; b=qy4Aes3VK1WIX07lFa/4hW6uw9FMB4rKPPa8R0WVdptDM4VgltpE6ctyPU8ryEWUpiDb9SkcZeOFEMI4CZL5u1mI8ayOtXCwy00x84ub3oHORR/sKgabF7K5tHe7igcfQgz3YAxIoSFLOXbK1K8WI8R+Ti2NMF4X3bDIUMzKsGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949887; c=relaxed/simple;
	bh=zbfTA2VJjWQfugM0y3HKDpUMdj5msjiIH2TZdK1WrjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ie9frmCWcQgmKY75xMnwUdEl5Bnw2U8nDZm3dhjjwcG38eZ30rJCb2RcPtQFLWlETUuc5Yb91osb9KbIClsApeCTRZduGYaz+Frg8OQOPvNhFWEjcFtymCgfEVrPL0d12QLlYI+wAPTr4MoSS5wegwB+Q5i4XRLKPVZHAjHwHbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=SnxlMej2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KVZ4xmzq; arc=none smtp.client-ip=202.12.124.139
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id D5F5813000C4;
	Mon, 13 Jul 2026 09:38:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jul 2026 09:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783949884; x=
	1783957084; bh=112Yvu8MDmd9GxnWgYRo8OOQeNBIsEEGqTciWSFqlIs=; b=S
	nxlMej2TTJEJdZQwyjy/QgeFh9+k1ounA0jahS6aksRxAnCMkuwOn6chkBxI6WzQ
	5BhoUBci/xVzsuMMCCMnLzhikutgaZV+tMBfhRDgmXzFwJ5mwRpzwpgl90jAAUNT
	aR1vH3HbN9gmbrmatrNiWHd51a43tLLdrMDqgD67/VkwA6Xz0lyP+1a68jDJgec5
	vi6ViS1aNO8WV2sXi5I9xE+8/EyIf1RNE0aV4oEeTFzRHSCerA09CJeuejAcmBcW
	XM7JoZt+b4jcYsA1nWCsvHdk/OxrbpHMZBqoj3kiu4y8WRHJCRrY0AdGm134J5o1
	YxeqRTtozOZ6I2k25i9HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783949884; x=1783957084; bh=1
	12Yvu8MDmd9GxnWgYRo8OOQeNBIsEEGqTciWSFqlIs=; b=KVZ4xmzq8D226ZBsQ
	4asGgbRqztjojoG9K+Ptvr2ESLfysvQV6Kx7pCaZL2e3+M96I6rCsX3b11vBTtQO
	hdCtdaqg0RUj5uHD+CTmT2h9fwNDA8kYSz16RjdlxKUtvERTpIl0Bpp6APD/Jt4x
	Mxf2+aKek2okYGMXzlkKQUmwJa+8cjJYsWyZWYKbnNKEX6VU7nKoUfdk4iplvCdP
	jqoGS4vl0PIhd+1HvOstCbN17CwMm6TnIhk6ET+IcXz2pgBIqLXE0zH91BfEOWWN
	y5m0cJ6PEsNNoaTdCoFAZIDJO+t0m+n0mdCGlXoVkTMsyDJ3Nh7yodX1RUwczJqj
	rI6Nw==
X-ME-Sender: <xms:POpUasU3WfQ8J9utIdv7h02WxmF7UFzfBh0w1S95h3nAhlEIcLcjzA>
    <xme:POpUatwT7Ic0t1evl1iauSQcPG93VK1WXlJInLwd96rx-H_ndpa3zNtIbOWx8WRhk
    fCzem0pMURg-amNBIrmTyy8lfSZUPyj1LE4a3K8-I2kvvy9jOwDLMTN>
X-ME-Received: <xmr:POpUak6V4wf0DWDLByovSxtF0ZeaZqI1OguWuXp1GK23K1XnONjDDjqbqXZ_Vg>
X-ME-Proxy-Cause: dmFkZTEW6S1SvXSlZs4OOnc4VahxjW69aaGDPVJd2EBjsmGIohL3aDaqbSu+8YkVanPFjR
    tgfQDCCpmX969bn/U9UO+n3QFXz0q323naPF4jWiHMmRntzGcQhp3Vx2KAhMBucKBrMoVj
    X5CwYvbDFJlTUkQTRAgKvI65LvTaLY14waW97LrBigSnkpE1VVt9mBrvLTUpmoEfS6d4eG
    NKQd5S3QFjNq4Gy3l1vDGekWs+36+zmLytr+byevjqc4klRvGFU3gjURfoh9Tfq4eVG+a+
    Cgqgl3n6aDHjUo+YCrNUfd8of0qgvvgGYEP4z2EH+IhHTWSStBT7XqcjOnyMOC1DkjQYMX
    vH8zgGWR2ixyB/rEh8253RHKpjrS43SzwQtSH3LB3AZh6xNQY5gfxF4nBCzMk/8YR8HSoQ
    fwW7D76ifB2ndnjsAGRCAZ6Xb26kxKS/6hOm30U77TwPv2NTc95nQQU2lzlkuW2z3qpd+I
    JK3yXRpiyOtPFeS7RQ8K9pipl7bQDoiWczd/zPW2ao1maFXFG6lOiFrufnMqsxrBrskx95
    CLTU1eJgfYwkBemJ6Sotnv+ZipxtQr5KLX9BjGTWdCKjL/ZLyGzzsGfObNSLwQhoByAGRq
    82aKz2LNjMrhaG687s+bRC42Voc4QEgx3DqvsxcPq1HB2QzMN8ZZahDWNQhQ
X-ME-Proxy: <xmx:POpUanituzHeGoASJzvZGmbF1FDFL8eayck3XMFWWm4HmaYHbCGjYQ>
    <xmx:POpUaniRJCzRSBf63msiFbFX6_Bv4TlBbdLeSHf9EIekOk245ne_kA>
    <xmx:POpUavlm9ZY5usq_RsqUkfFB8FhIZZ2CDwrtH_tcia48nEK3grP-2Q>
    <xmx:POpUanEqh2oW6gQ6C8y_yzJ2TOTOZ6eCyXN4EOrze4C-FKriq0SnqA>
    <xmx:POpUakt10YhM7s9lJZuMNT-i_znUd-TPIXPdsWCpCL48SSHrLRezflge>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 09:38:03 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	David Laight <david.laight.linux@gmail.com>,
	Andi Kleen <ak@linux.intel.com>,
	Dan Williams <djbw@kernel.org>,
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v6 3/3] x86/tdx: Fix zero-extension for 32-bit port I/O
Date: Mon, 13 Jul 2026 14:37:53 +0100
Message-ID: <20260713133753.223947-4-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713133753.223947-1-kirill@shutemov.name>
References: <20260713133753.223947-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[shutemov.name:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273776-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[kirill@shutemov.name,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@linux.intel.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:seanjc@google.com,m:pbonzini@redhat.com,m:sathyanarayanan.kuppuswamy@linux.intel.com,m:kai.huang@intel.com,m:xiaoyao.li@intel.com,m:rick.p.edgecombe@intel.com,m:binbin.wu@linux.intel.com,m:david.laight.linux@gmail.com,m:ak@linux.intel.com,m:djbw@kernel.org,m:tsyrulnikov.borys@gmail.com,m:kvm@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kas@kernel.org,m:davidlaightlinux@gmail.com,m:tsyrulnikovborys@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[shutemov.name];
	FREEMAIL_CC(0.00)[google.com,redhat.com,linux.intel.com,intel.com,gmail.com,kernel.org,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kirill@shutemov.name,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[shutemov.name:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,shutemov.name:from_mime,shutemov.name:dkim,shutemov.name:mid,vger.kernel.org:from_smtp,instruction.io:url,intel.com:email,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEDCC74BD3A

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

According to x86 architecture rules, 32-bit operations zero-extend the
result to 64 bits. The current implementation of handle_in() only masks
the lower 32 bits, which preserves the upper 32 bits of RAX when a
32-bit port IN instruction is emulated.

Use insn_assign_reg() to write the result back into RAX with proper
partial-register-write semantics: 1- and 2-byte forms leave the upper
bits untouched, the 4-byte form zero-extends to the full register.

Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com/
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index b8bbd715fb62..f904a636d449 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -694,8 +694,8 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 		.r13 = PORT_READ,
 		.r14 = port,
 	};
-	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 	bool success;
+	u64 val;
 
 	/*
 	 * Emulate the I/O read via hypercall. More info about ABI can be found
@@ -703,11 +703,9 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 	 * "TDG.VP.VMCALL<Instruction.IO>".
 	 */
 	success = !__tdx_hypercall(&args);
+	val = success ? args.r11 : 0;
 
-	/* Update part of the register affected by the emulated instruction */
-	regs->ax &= ~mask;
-	if (success)
-		regs->ax |= args.r11 & mask;
+	insn_assign_reg(&regs->ax, val, size);
 
 	return success;
 }
-- 
2.54.0


