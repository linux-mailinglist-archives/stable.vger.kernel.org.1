Return-Path: <stable+bounces-255065-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI87FuFyGGq4kAgAu9opvQ
	(envelope-from <stable+bounces-255065-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:52:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B211B5F5430
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30C6F30D3448
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398B53EFFD5;
	Thu, 28 May 2026 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gB8HmZQX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4973F076B;
	Thu, 28 May 2026 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779986659; cv=none; b=StQZjbvYOY3NKm2wbKzEzCk5gv4ffXbvuaaTJTTurkq3FoL/ySCgx8tB2luAM2QPelwKn9TkU3BebDX4s4nMo0uWBj8w6biNCm7ptzMNNUXBRW05rJkXrKilVbxTE4i29UK+63s44AVjjq/vt0u6TT1Myk7sp2ewPQ+wA9gXloU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779986659; c=relaxed/simple;
	bh=nDfOi7I8EsGjEZJKW1fFpQ+3yIGjQAwG9zuzLIZCuxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTqqF4fO05nEwEHhYubLoIXbvPmTK1NFuoLrDA2OQBnRMN5IqNCHWKefdSmQaKGe2U26WOIQ1vwYXFFPGJIhcIeCoH+mRJZasVQGZFzCp8/lCwkLK9r9g8PH7eP4OQIdf/WBySh1UiL0hXjTXtzk870Q2lj8xQENifyI9ij0FAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gB8HmZQX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779986658; x=1811522658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nDfOi7I8EsGjEZJKW1fFpQ+3yIGjQAwG9zuzLIZCuxs=;
  b=gB8HmZQXxnCENrXEzEphV9MCyDFVubzevN7Q3TqKmJ2O6UfbNTKXpiPw
   NTeZ6oprcXFCNC/RVfE79t9X6WOM+6p/67Vt/gwC8WI2cLAXHUd9TtpXq
   1AJJq2F/rf8lGw8ldXLIfvBDitpry3hd8mJVe7P8vfaiSSGIPqoV8pxLL
   g5P+BcWyPG90Sq2up4T85tEP8pC0sbogH+AevUxSfCkTZOHyjAAj8sIry
   AKrhB9BLRcxgRcVnBMFAZHsIJ0rVtMgSGbpBt2Ep6EcDbDYGXfrAhEfF+
   OqHgFzrKJHHO+LX08SKbtOmrE4vqqSAkZSrLGc8KoSh6RX1MaXpXzxDyc
   Q==;
X-CSE-ConnectionGUID: mrAMdRbBQTmEpvTsKP2KYw==
X-CSE-MsgGUID: 8rI9Y3faRfmw7r9kP/sHqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="98408389"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="98408389"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 09:44:17 -0700
X-CSE-ConnectionGUID: 3h2OnGaES+Wxwk+gk4LgnA==
X-CSE-MsgGUID: 5aWX3z2wT9G5skJltP4+kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="238189900"
Received: from mvcheng-desk2.amr.corp.intel.com (HELO [10.125.111.73]) ([10.125.111.73])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 09:44:16 -0700
Message-ID: <350d139a-29d8-4ccc-ab4a-4c7c7cc73848@intel.com>
Date: Thu, 28 May 2026 09:43:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Sean Christopherson <seanjc@google.com>,
 Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, stable@vger.kernel.org
References: <20260527120544.2903923-1-kas@kernel.org>
 <20260527120544.2903923-3-kas@kernel.org>
 <5ed6121c-314e-4cf0-9a11-b0661c87c694@intel.com>
 <ahgUBLjBRGhxULu3@thinkstation>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <ahgUBLjBRGhxULu3@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255065-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,intel.com,google.com,gmail.com,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.hansen@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: B211B5F5430
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 03:14, Kiryl Shutsemau wrote:
> +	switch (size) {
> +	case 1:
> +		*(u8 *)&regs->ax = (u8)val;
> +		break;
> +	case 2:
> +		*(u16 *)&regs->ax = (u16)val;
> +		break;

Is this intentionally clever to only work on little endian, or
accidentally clever? This seems like a great IOCCC thing to do, but it's
far too clever for my taste.

I mean, it's making a pointer to a 64-bit value with an 8-bit name and
casting that to an 8-bit pointer and then assigning that to a 32-bit
value cast to a u8.

Is it just my tiny brain that thinks this will be unintelligible on Monday?

How about we just make the CPU do the thinking for us? IN[BWL] and
MOV[BWL] have the same semantics here, right? So even if 'rax' and 'val'
are 64-bit values here, the following should have all the right
behaviors, I think.

I generally loathe inline assembly. But we have a CPU that kinda knows
the rules already. No need for us to laboriously reimplement it. Right?

Thanks to the friendly LLM that knows inline assembly better than I do.
The resulting compiled assembly looks right to me.

/*
 * Use MOV[BWL] to/from registers to match the IN[BWL] behavior
 * including the fact that INL zeros the upper 64-bits while
 * IN[BW] don't zero anything.
 */

    switch (size) {
    case 1:
	// Just write 1 byte of RAX:
        __asm__ volatile ("movb %b1, %b0" : "+q"(rax)
                                          : "q"(val));
        break;
    case 2:
	// Write 2 bytes of RAX:
        __asm__ volatile ("movw %w1, %w0" : "+r"(rax)
                                          : "r"(val));
        break;
    case 4:
	// Write 'val' into lower 32 bits. Zero the upper 32 bits:
        __asm__ volatile ("movl %k1, %k0" : "=r"(rax)
                                          : "r"(val));
        break;
    default:
	// WARN
    }

Thoughts?

