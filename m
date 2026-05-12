Return-Path: <stable+bounces-246693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJNTBM6sA2oO8wEAu9opvQ
	(envelope-from <stable+bounces-246693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 00:42:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1486552AFEA
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 00:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2767630910B2
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA3F3A6EEE;
	Tue, 12 May 2026 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="clGrhNtv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DDwcESNJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="clGrhNtv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DDwcESNJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4AA3A3E6F
	for <stable@vger.kernel.org>; Tue, 12 May 2026 22:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625212; cv=none; b=t+/zDBe908qV89jYkt4+yEecoxKRWlDbiooYOtwF0Ml6KDLoJD0aZOITVtFa8R7HWpCXW+UAsvJgKbrozrXDC1ZdYWMBMBDK+luP/WRaaajzqgD9PDVi7Tbnco46etMXb4x/xQqVflF8M8kpfk+7buySn60po4H4F50RPOdlYKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625212; c=relaxed/simple;
	bh=53wmpcPfrKQ0zFGCoerDj8Qv22zPlfWlMoWBAuUW8yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQqS2nQKFO0fKaxM+rTRSLR1A0WRccFjl2f0PxRR+wfzIx0fvaA86I8LAM10Ib6461AxLz3VTq/M1aGN88QAjLmFNF1H9vumxR0CQ+KLJbUoqRK2haVb+Pal+BXWZ1rOCgpfoVEL2qmye3Let9De7IicfQlv2oj2SWQQOfsy8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=clGrhNtv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DDwcESNJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=clGrhNtv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DDwcESNJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 183127644A;
	Tue, 12 May 2026 22:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778625208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WFkmO9/Hg46T4+uOWPRO9VbdMs4vEsM2bHlhcsm3ln4=;
	b=clGrhNtvMXQ9MLzLZtfYlwDDB5s1nizYRqiAdH3GWzk9aK2uTtHt4m5jx3nibKo6o+gIn/
	NtOJS2gpq0530cY6RGiRQI7W9iKuQcHHqKFHITvvzrhBglMYMcknGiA7U1B5Ici5b4ppxW
	IB6EE0Ng4zWkfHcCwS5mkb4O4dFMESc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778625208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WFkmO9/Hg46T4+uOWPRO9VbdMs4vEsM2bHlhcsm3ln4=;
	b=DDwcESNJ0kmeKzCZUTaOcA267pC7NJWIvfxuUS8uhol9cHVYjnIPIwqNqsRd+ic/1iDgXL
	NazkMDqH46HrQHAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778625208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WFkmO9/Hg46T4+uOWPRO9VbdMs4vEsM2bHlhcsm3ln4=;
	b=clGrhNtvMXQ9MLzLZtfYlwDDB5s1nizYRqiAdH3GWzk9aK2uTtHt4m5jx3nibKo6o+gIn/
	NtOJS2gpq0530cY6RGiRQI7W9iKuQcHHqKFHITvvzrhBglMYMcknGiA7U1B5Ici5b4ppxW
	IB6EE0Ng4zWkfHcCwS5mkb4O4dFMESc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778625208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WFkmO9/Hg46T4+uOWPRO9VbdMs4vEsM2bHlhcsm3ln4=;
	b=DDwcESNJ0kmeKzCZUTaOcA267pC7NJWIvfxuUS8uhol9cHVYjnIPIwqNqsRd+ic/1iDgXL
	NazkMDqH46HrQHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57DDE593A9;
	Tue, 12 May 2026 22:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZPLAEreqA2o5bgAAD6G6ig
	(envelope-from <clopez@suse.de>); Tue, 12 May 2026 22:33:27 +0000
Message-ID: <9c82ba06-ed70-4914-829d-f5d9f8e35ff1@suse.de>
Date: Wed, 13 May 2026 00:33:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tdx: Fix zero-extension for CPUID emulation
To: Dave Hansen <dave.hansen@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kas@kernel.org" <kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>
Cc: "ak@linux.intel.com" <ak@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Luck, Tony" <tony.luck@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20260512213719.20974-1-clopez@suse.de>
 <81343db56b8df8f70a2e13a17e62c620bee36897.camel@intel.com>
 <7f7b8bfd-f39e-417c-991f-d224d58cb52a@intel.com>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Content-Language: en-US
In-Reply-To: <7f7b8bfd-f39e-417c-991f-d224d58cb52a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Rspamd-Queue-Id: 1486552AFEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-246693-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clopez@suse.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action

On 5/13/26 12:14 AM, Dave Hansen wrote:
> On 5/12/26 14:48, Edgecombe, Rick P wrote:
>>> -	regs->ax = args.r12;
>>> -	regs->bx = args.r13;
>>> -	regs->cx = args.r14;
>>> -	regs->dx = args.r15;
>>> +	regs->ax = lower_32_bits(args.r12);
>>> +	regs->bx = lower_32_bits(args.r13);
>>> +	regs->cx = lower_32_bits(args.r14);
>>> +	regs->dx = lower_32_bits(args.r15);
>>>  
>> Can you explain the impact here? Why should the guest fixup what the VMM
>> emulates?
> 
> Oh boy.
> 
> args.r12-15 come from the VMM, right? So the VMM Can put whatever it
> wants in there.

Yes, exactly.

> CPUID (the instruction) is defined to fill in eax/ebx/ecx/edx. Those are
> 32-bit registers so the normal register rules apply: "32-bit operands
> generate a 32-bit result, zero-extended to a 64-bit result in the
> destination general-purpose register."
> 
> So a properly-behaving CPUID implementation will always end up with the
> top 32 bits empty on the four CPUID registers after a CPUID is executed.
> 
> The VMM here obviously might be naughty and might put gunk in
> args.r12/r13/r14/r15 that gets copied to ptregs->ax/bx/cx/dx which are
> 'unsigned long' on 64-bit.
> 
> The end result is that a TDX guest can use CPUID and end up having bits
> set in rax/rbx/rcx/rdx that are architecturally impossible. This patch
> is effectively fixing up the VMM naughtiness before the guest CPUID
> instance can see it.
> 
> Does anybody disagree with any of that?
> 
> Do we *want* to fix this up silently? If we catch a malicious VMM trying
> to stuff garbage into the guest, shouldn't we be a bit more upset than
> silently papering over it?

Okay, how about this (on top of the changes I already sent)?

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 831475cf4313..cd33781c8d61 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -538,6 +538,13 @@ static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
        if (__tdx_hypercall(&args))
                return -EIO;
 
+       /* Emit a warning if the hypervisor tries to inject architecturally
+        * invalid (non-zero-extended) output values for CPUID */
+       if (upper_32_bits(args.r12) || upper_32_bits(args.r13)
+           || upper_32_bits(args.r14) || upper_32_bits(args.r15))
+               pr_warn("detected invalid CPUID result from VMM: eax=%lld ebx=%lld ecx=%lld edx=%lld",
+                                       args.r12, args.r13, args.r14, args.r15);
+
        /*
         * As per TDX GHCI CPUID ABI, r12-r15 registers contain contents of
         * EAX, EBX, ECX, EDX registers after the CPUID instruction execution.


