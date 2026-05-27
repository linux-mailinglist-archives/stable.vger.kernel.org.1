Return-Path: <stable+bounces-254644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MboFo8uF2rd7wcAu9opvQ
	(envelope-from <stable+bounces-254644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC275E8813
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AC1D3077723
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 17:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D383783C1;
	Wed, 27 May 2026 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsY7bihV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DB72566F7;
	Wed, 27 May 2026 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903965; cv=none; b=E5zFLrEfnvcre8Bf7Y3I9P37sNSVoYYNIr/d0xSGCV0omuWleE8ii6L7COtZH1j39St0Go7B1V14L1Fg8lEtdUUU45U/nRynRaNxr9pafVM0BXeF7eJeY2oyWJ/eKeISjuJWWIzjg65+01egXfkwtywlXtXIiKmKKfPQWbF9Jx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903965; c=relaxed/simple;
	bh=0ThiOYWvoBP+x61ngBsl19TSjuAMKJt5lb2/LI++YMc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=foEM6MHJplN2KUWk4EuSk/Bk6N7MXotQb4BMSWI2yX456xFLpEYVaXfraQm3jKpaFhsN7ud+iVZXbgZiB8+Q6ESb0/sNLkXZHwEFPLUz2K/hGmLyTvsbF3MN+SlCwh8Y9yFHRD5ozOECbarNxH5U7bLXihHVaFIN5RfrrDAA9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsY7bihV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779903963; x=1811439963;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=0ThiOYWvoBP+x61ngBsl19TSjuAMKJt5lb2/LI++YMc=;
  b=TsY7bihVySzTYKM/EIpePu/WywDhHHN+7XRrMidO+tirOmgaYcHOHAAp
   G0IDHq2UcrkaWT5/YtyxNF4ov8ZEBtwXu9UhEatwl8J9XoJbpIKvvAviL
   3E7ZfsChDoNcZypkAjvMcdPbURHSaAGrMHPHTv5baJYAJfJjgzpE+00HR
   oJReExL4fxVeW7IUgsEIev3Ppf/ggITQqEh+CfIjJApMGpHd3LieVQC9k
   qbsI2Wpw5utqEAddA/QOi18TFpA50Sha/0GNM02AHBrHwh9CCEE+KKx44
   sl/cG786E/nGTxwOGJs7bcpPdmIu67i+jZbKQpStmPXWX2bRcKq3DWXnL
   w==;
X-CSE-ConnectionGUID: 0QKfts6lQ9WMCn69ZzwYjg==
X-CSE-MsgGUID: NspLnTXKRCaNyIXQPY9U0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="79893337"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="79893337"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 10:46:02 -0700
X-CSE-ConnectionGUID: JihalDBCS721iENI+MVomQ==
X-CSE-MsgGUID: Vqbx2Z5dSy6GzF6RTTz6ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247258093"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.27]) ([10.125.111.27])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 10:46:02 -0700
Content-Type: multipart/mixed; boundary="------------qh7EUZpxDlywN8WehcLGDAQL"
Message-ID: <5ed6121c-314e-4cf0-9a11-b0661c87c694@intel.com>
Date: Wed, 27 May 2026 10:45:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Sean Christopherson <seanjc@google.com>,
 Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, stable@vger.kernel.org
References: <20260527120544.2903923-1-kas@kernel.org>
 <20260527120544.2903923-3-kas@kernel.org>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzUVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT7CwXgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lczsFNBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <20260527120544.2903923-3-kas@kernel.org>
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254644-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[zytor.com,intel.com,linux.intel.com,google.com,gmail.com,vger.kernel.org,lists.linux.dev];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.hansen@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: ABC275E8813
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------qh7EUZpxDlywN8WehcLGDAQL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/26 05:05, Kiryl Shutsemau (Meta) wrote:
...
> -	/* Update part of the register affected by the emulated instruction */
> -	regs->ax &= ~mask;
> +	/*
> +	 * IN writes the result into a sub-register of RAX. Only the
> +	 * 32-bit form zero-extends; the smaller forms leave the upper
> +	 * bits untouched:
> +	 *
> +	 *   insn  dest  size  bits written     bits preserved
> +	 *   inb   AL    1     RAX[ 7: 0]       RAX[63: 8]
> +	 *   inw   AX    2     RAX[15: 0]       RAX[63:16]
> +	 *   inl   EAX   4     RAX[63: 0]       (none, zero-extended)
> +	 *
> +	 * 'mask' only covers the low 'size' bytes, which is exactly the
> +	 * range affected for size 1 and 2. For size 4 the write also
> +	 * clears RAX[63:32], so widen the clear-mask.
> +	 */
> +	if (size == 4)
> +		regs->ax = 0;
> +	else
> +		regs->ax &= ~mask;
> +

Is there any way we could do this with fewer comments and more code?

I mean, there's only three cases. Why have;

	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);

When there are only 3 possible cases:

	1 => 0xf
	2 => 0xff
	4 => 0xffff

and one of those cases needs a special case on top of it.

Maybe something like this?

	/* Clear out part of RAX so part of args.r11 can be OR'd in: */
	switch (size) {
	case 1:
		/* inb consumes lower 8 bits of r11: */
		regs->ax &= ~GENMASK_ULL(7, 0);
		args.r11 &=  GENMASK_ULL(7, 0);
		break;
	case 2:
		/* inw consumes lower 16 bits of r11: */
		regs->ax &= ~GENMASK_ULL(15, 0);
		args.r11 &=  GENMASK_ULL(15, 0);
		break;
	case 4:
		/* inl is weird and zeros the whole register: */
		regs->ax &= ~GENMASK_ULL(63, 0);
		/* But only consumes 32-bits from r11: */
		args.r11 &=  GENMASK_ULL(31, 0);
		break;
	default:
		/* Probable TDX module bug. Illegal in[bwl] size: */
		WARN_ON_ONCE(1);
		success = 0;
	}

	if (success)
		regs->ax |= args.r11;

It might need a temporary variable for args.r11, but you get the point.
That's basically the data from the comment but written as code.
--------------qh7EUZpxDlywN8WehcLGDAQL
Content-Type: text/x-patch; charset=UTF-8; name="tdxinX.patch"
Content-Disposition: attachment; filename="tdxinX.patch"
Content-Transfer-Encoding: base64

IHRkeC5jIHwgICAyOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNo
YW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK

--------------qh7EUZpxDlywN8WehcLGDAQL--

