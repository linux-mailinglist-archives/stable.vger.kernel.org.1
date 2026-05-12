Return-Path: <stable+bounces-246683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEWhBKudA2rr8AEAu9opvQ
	(envelope-from <stable+bounces-246683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:37:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 784D552A66E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C837F3047DDF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 21:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F051386554;
	Tue, 12 May 2026 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k/JrJtlD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oCegvFLV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DwWCaDSd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/oXPBfFy"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E061F3822B4
	for <stable@vger.kernel.org>; Tue, 12 May 2026 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621858; cv=none; b=OSRwaBuvJSc7uRTSzzzvy+HCoQlWRwPF6eF3uwlThP8Fbu7TXX8sqYUQ909uLbNQU/UOsW2mqsz+kRdw9bAgdBZxLL3d+VJ36xiWyEBI8wAAwhSo+vvhBc+G1bYccDehyrNJ9FFIBe1r6/tQjigYeYxXAVJ8vS35dlf1hSFYjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621858; c=relaxed/simple;
	bh=qGhetvw8/qiNI22y8XLXztl/MOWRXxK7B8fh7ij6z9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oqQaHLMMeFkcHb5U79VE7V3WCsy8f4k/tZQhHGeZxf3t04H2IuCsCMSry3eVQFMLJHCja2pV7LSY7od8auwZLE+D0ltpuRC3B0Vl9+FQJ2sQj8A90E6E9Rj2FZX/cv64gSN19jixygs5Sc89Pg7TTAfrrh4ar7drczHYv4z9ohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k/JrJtlD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oCegvFLV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DwWCaDSd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/oXPBfFy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7BCF66AAF8;
	Tue, 12 May 2026 21:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778621855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oBAYXJUrFg63Z6RvOCmvjgi5tAtmT8m7Pzftepqd5aA=;
	b=k/JrJtlD/NsIePuwTQzI4rEy1mBYisPW4AZOqyt1UoORyg/S2l2Lm4bK6PWM9pH6LcEh4d
	ev7qvSUy3Yay/FWdSUGAlp7iKJJFnUmUcxi7Mcd3dmBXEcNXf6QKJ1yPMf2HCt789ei1zt
	5hf6Fbed6Li9KxpRy4yUU37znJS9YTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778621855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oBAYXJUrFg63Z6RvOCmvjgi5tAtmT8m7Pzftepqd5aA=;
	b=oCegvFLVRawbDU3Bg7vneUP0SR3TBJsgo4QGYcuqvzQyNQ9iNHSnHvl+m1ZLjnSslepg3p
	OexTajrtOffS95AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DwWCaDSd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/oXPBfFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778621854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oBAYXJUrFg63Z6RvOCmvjgi5tAtmT8m7Pzftepqd5aA=;
	b=DwWCaDSdZWWxp+ygnkSg0WlLNYgtRV12MqurvwNSF6zacncgQDwhAO1Z8Zy1ol7dJVaPrK
	/G+QbMdKnupG7je2BeBANAqYaClYXPp2SezorOPoOLiUE3AijjixUGW9sJx7V4tUNI+B4W
	pDtl3vYtTpHqHUr7WJEg+XjHOrOK3N4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778621854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oBAYXJUrFg63Z6RvOCmvjgi5tAtmT8m7Pzftepqd5aA=;
	b=/oXPBfFy4y2IOUmLsKnMctUnnRGalFPQHrzbGs7fNVcLOKtzP3WhmuUANMmukySaMAOQCJ
	30/uXm/oKCCwNFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABB38593A9;
	Tue, 12 May 2026 21:37:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bYI2J52dA2p6OQAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 12 May 2026 21:37:33 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kas@kernel.org,
	rick.p.edgecombe@intel.com,
	x86@kernel.org,
	linux-coco@lists.linux.dev
Cc: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andi Kleen <ak@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	kvm@vger.kernel.org (open list:X86 TRUST DOMAIN EXTENSIONS (TDX))
Subject: [PATCH] x86/tdx: Fix zero-extension for CPUID emulation
Date: Tue, 12 May 2026 23:37:19 +0200
Message-ID: <20260512213719.20974-1-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 784D552A66E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246683-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clopez@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action

In the x86 architecture, 32-bit operations zero-extend the result in the
destination register to 64 bits. This includes the CPUID instruction,
which writes 32-bit values EAX/EBX/ECX/EDX.

When handling the CPUID instruction via #VE, copy only the lower 32-bits
provided by the hypervisor for the output registers, and zero out the
upper half.

Fixes: c141fa2c2bba ("x86/tdx: Handle CPUID via #VE")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos López <clopez@suse.de>
---
 arch/x86/coco/tdx/tdx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index c8b9e86d0488..a2fe1ae019bd 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -543,10 +543,10 @@ static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 	 * EAX, EBX, ECX, EDX registers after the CPUID instruction execution.
 	 * So copy the register contents back to pt_regs.
 	 */
-	regs->ax = args.r12;
-	regs->bx = args.r13;
-	regs->cx = args.r14;
-	regs->dx = args.r15;
+	regs->ax = lower_32_bits(args.r12);
+	regs->bx = lower_32_bits(args.r13);
+	regs->cx = lower_32_bits(args.r14);
+	regs->dx = lower_32_bits(args.r15);
 
 	return ve_instr_len(ve);
 }
-- 
2.51.0


