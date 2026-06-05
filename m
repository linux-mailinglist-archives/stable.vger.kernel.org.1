Return-Path: <stable+bounces-260640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r7+8CVJ6ImqIYAEAu9opvQ
	(envelope-from <stable+bounces-260640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 09:27:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F31F645F5E
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 09:27:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="CI/r7NYT";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260640-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260640-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22D8A30EDE8F
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 07:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56494657CD;
	Fri,  5 Jun 2026 07:10:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E0144E045;
	Fri,  5 Jun 2026 07:10:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643448; cv=none; b=XRQELou0AwnBSRTmPncnJoCoo5UAwBySb1l+aGnl6mUWLudhVf8hemZSD3UMLt1L51+LlbmDPVFTantZgFhm6KIL790DJNQATRRMwDlAAoAhOcCujUviScW6dxDi34Pg/jOxJ06OjEQKzEnkXbwZEIZE4fr4dIq6Kj9TzWx3hW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643448; c=relaxed/simple;
	bh=VoGt3Pe+9o+ZDLPVTFa/RzgIy1DEI/AEoscbmIlCZeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvLFrfrPZxWYv3NFmQ59qmect9gI0McKzTnwZ6eB0yWfcsgTGM+5sdfNptLXuAhyTkSdDuSoRqzQQ6MTeyIEL7+gWOC6TRNRmfpsmSN1vNdA0QVIxHoB9o9mj6JX8VG7NIPThtUPO6NDcXYh6ZzRX8uckZ34W/TxhBmMQSrLT5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CI/r7NYT; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780643447; x=1812179447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VoGt3Pe+9o+ZDLPVTFa/RzgIy1DEI/AEoscbmIlCZeE=;
  b=CI/r7NYTlw8tqfONxphCkycBQ+ua3r0txgk/B1NStWq63kqLOt+8bSA5
   7a+SZia/mGNG/L1hSm3QMKg0Tt9Kg7VsR1RwKEX2wU1sXkIjxFBugRTQ5
   qaiJaT7eoamijuEdr0BuIcoMWpZe0tWfsCHNewRdkmpLB8ymclt5AWMu3
   eP/dAA3jPepZ3D7zxjgI2OuvobSi2uHo3DzoqvTGJEfH/q3gGDJOP2/Ag
   0D5yzQTlMJZS912FOhyKk92ybAtL3ka7qKc3VzFYw1l/Zr/vaga2OElgY
   mwBrTgtWtx8zXoqZDZyRhcsvE4jnPCjEVDx192sBwJekqB8VAsSyQzHsI
   A==;
X-CSE-ConnectionGUID: Re1U7QxVSQCKPnYuNUx9og==
X-CSE-MsgGUID: J1rawPpcRbaeBG+GXdGFmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92850688"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="92850688"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:10:46 -0700
X-CSE-ConnectionGUID: Yej+Cn0pTQqOPy7Re4vtQw==
X-CSE-MsgGUID: CMtcIMHVT4yA2svic8J5Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="268702092"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.241.59]) ([10.124.241.59])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:10:42 -0700
Message-ID: <22c789c3-13b1-4c39-898f-2eec3bce98c1@linux.intel.com>
Date: Fri, 5 Jun 2026 15:10:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] x86/tdx: Fix zero-extension for 32-bit port I/O
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, seanjc@google.com, pbonzini@redhat.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, kai.huang@intel.com,
 xiaoyao.li@intel.com, rick.p.edgecombe@intel.com,
 david.laight.linux@gmail.com, ak@linux.intel.com, djbw@kernel.org,
 tsyrulnikov.borys@gmail.com, x86@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <cover.1780584300.git.kas@kernel.org>
 <ca503ae3de72d90956fcaf5dbc0760ec20f5a5e0.1780584300.git.kas@kernel.org>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <ca503ae3de72d90956fcaf5dbc0760ec20f5a5e0.1780584300.git.kas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260640-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kas@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:seanjc@google.com,m:pbonzini@redhat.com,m:sathyanarayanan.kuppuswamy@linux.intel.com,m:kai.huang@intel.com,m:xiaoyao.li@intel.com,m:rick.p.edgecombe@intel.com,m:david.laight.linux@gmail.com,m:ak@linux.intel.com,m:djbw@kernel.org,m:tsyrulnikov.borys@gmail.com,m:x86@kernel.org,m:kvm@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:davidlaightlinux@gmail.com,m:tsyrulnikovborys@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[binbin.wu@linux.intel.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,google.com,intel.com,gmail.com,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[binbin.wu@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,instruction.io:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:from_mime,linux.intel.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F31F645F5E



On 6/4/2026 10:47 PM, Kiryl Shutsemau (Meta) wrote:
> According to x86 architecture rules, 32-bit operations zero-extend the
> result to 64 bits. The current implementation of handle_in() only masks
> the lower 32 bits, which preserves the upper 32 bits of RAX when a
> 32-bit port IN instruction is emulated.
> 
> Use insn_assign_reg() to write the result back into RAX with proper
> partial-register-write semantics: 1- and 2-byte forms leave the upper
> bits untouched, the 4-byte form zero-extends to the full register.
> 
> Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
> Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
> Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com/
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Cc: stable@vger.kernel.org

I think the concern sashiko commented in patch 2 is valid.

But for this patch itself,
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/coco/tdx/tdx.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 65119362f9a2..41cc23cc63dd 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -693,8 +693,8 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
>  		.r13 = PORT_READ,
>  		.r14 = port,
>  	};
> -	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
>  	bool success;
> +	u64 val;
>  
>  	/*
>  	 * Emulate the I/O read via hypercall. More info about ABI can be found
> @@ -702,11 +702,9 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
>  	 * "TDG.VP.VMCALL<Instruction.IO>".
>  	 */
>  	success = !__tdx_hypercall(&args);
> +	val = success ? args.r11 : 0;
>  
> -	/* Update part of the register affected by the emulated instruction */
> -	regs->ax &= ~mask;
> -	if (success)
> -		regs->ax |= args.r11 & mask;
> +	insn_assign_reg(&regs->ax, val, size);
>  
>  	return success;
>  }


