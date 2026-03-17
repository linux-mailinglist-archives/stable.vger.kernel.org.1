Return-Path: <stable+bounces-226099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAHgEYZxuWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:21:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 094A22ACEB4
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A1A13012D36
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235CF3EB81C;
	Tue, 17 Mar 2026 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDYQ9qzx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940F3EBF00;
	Tue, 17 Mar 2026 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760899; cv=none; b=RgQznJzSBLMrNgVmBY2gOTqRZ6xnszjZFM8aAa+K0pYT4QN1TJy9XuRg/O9pNssAifBpYSec/agVnLCY/DNKAbQb8tL6DVK1aHnG5OoZaxZKFWbzw63BYApxKoCOdrrMW0V0krIrVXbx3ay1UWH4xp1Pvd/RMctvkO/YQNSYX44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760899; c=relaxed/simple;
	bh=g1NP7CgNafVMR4EFugJRdQUnQsw7muhvYU04XURGrEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mwk25NdE52aYD3c5uW7PHtV7rKTgMeTDLlFuqXwQRpYKFGHOg9IstuJoHO1mSZwzqPaVHIHD+ZpLWsRgMy9qx+CO8djmtToyH9PHg0so8X4uY/mJChvXbiw9gEQveyS1lz6gHiKekwBleaDziqHCQlqyi9xd+Xv6jr9WH8TBVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDYQ9qzx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773760898; x=1805296898;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g1NP7CgNafVMR4EFugJRdQUnQsw7muhvYU04XURGrEc=;
  b=hDYQ9qzxakXFSdQBgiP9cwChaZk/eOzRi0TUFKS8D6M6bWCGRbuNhex3
   QAvRyF/wwTOw+UqQtT24oG4qJYv4k6ibKO0vU/G1Uf6PjY66K6+gJj4xE
   hHub3dXaiPLEpr0HgCSFuRwQGS/DoM8hquyW9C9OfDFmbVuarcEnlayry
   3o4QBYPmAWFWIyr4TFktfwg42D0yOleJ4pcTWK97fDUgW6mdpe63wWpXS
   rBHlyEfWQ5omrCW2atbCs6AG2ylZeCOE4C+jHJPZAzB8xLGjYmFgyEe3n
   svaz9qEfx5r4rBnGKbopDdweyg2jnWzYb4gKtHe3la3WeOzGFBS6Xw7+L
   w==;
X-CSE-ConnectionGUID: Ha9wYqHjT0qeHyN+2RgOnQ==
X-CSE-MsgGUID: HnLOC+oaQUGZ5rH6GpZVZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74829023"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74829023"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:21:38 -0700
X-CSE-ConnectionGUID: obWNhz3JRdujbnFQyjP1wQ==
X-CSE-MsgGUID: vGr1VKMdSrKMYUzbTkeBpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="222521878"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.160]) ([10.125.108.160])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:21:36 -0700
Message-ID: <c7498236-1e7c-4819-881f-42b9032778c7@intel.com>
Date: Tue, 17 Mar 2026 08:21:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
To: Tony W Wang-oc <tonywwang-oc@zhaoxin.com>, me@ziyao.cc
Cc: andrew.cooper3@citrix.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
 stable@vger.kernel.org, tglx@kernel.org, x86@kernel.org, lukelin@viacpu.com,
 "TimGuo@zhaoxin.com" <TimGuo@zhaoxin.com>, cooperyan@zhaoxin.com,
 benjaminpan@viatech.com, QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com,
 "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>
References: <20260228173704.62460-1-me@ziyao.cc>
 <70139192-54e5-4a4b-bc96-1fe3ec4f7a0b@zhaoxin.com>
 <7d312ba6-58a0-48cb-92fa-d8094ddef21f@intel.com>
 <b16bda4b-c7cb-4e7f-ac71-57c0032c6633@zhaoxin.com>
 <03a03ec8-4309-42ac-a13d-2fcc8396d547@intel.com>
 <08c3f1d4-326b-4a04-968c-23dd8ed14d0f@zhaoxin.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <08c3f1d4-326b-4a04-968c-23dd8ed14d0f@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-226099-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.hansen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 094A22ACEB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> --- /dev/null
> +++ b/arch/x86/include/asm/zhaoxin.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_ZHAOXIN_H
> +#define _ASM_X86_ZHAOXIN_H
> +
> +#include <asm/cpu_device_id.h>
> +#include <asm/microcode.h>
> +
> +#define    ZHAOXIN_MODEL_ZXC    VFM_MAKE(X86_VENDOR_ZHAOXIN, 6, 25)
> +#define    CENTAUR_MODEL_ZXC    VFM_MAKE(X86_VENDOR_CENTAUR, 6, 15)
> +
> +struct x86_cpu_id naughty_list[] = {
> +    X86_MATCH_VFM_STEPS(ZHAOXIN_MODEL_ZXC, 0, 3, 0),
> +    X86_MATCH_VFM_STEPS(CENTAUR_MODEL_ZXC, 14, 15, 0),
> +    {}
> +};

Hi Tony,

This is headed in the right direction, in a way.

However, I think you might have missed a few things. Did you notice that
this structure is in a .h file? We generally don't define data
structures and variables in header files. You might want to take a quick
look around the tree.

Then, go try and #include this header in two different places. See what
happens.

> +void check_fsgsbase_bugs(void);
> +
> +void check_fsgsbase_bugs(void)
> +{

Generally, compiler warnings are good things. They tell you that you've
done something wrong. Simply throwing code in to silence them isn't a
great practice.

Remember the compiler warning you got without the function declaration?
That was there to tell you that something is wrong. You placed
definitions in a header, not declarations.

But, adding a declaration before the definition made the compiler quiet.

> +    u32 chip_pf, dummy, fixed_ucode;

This is whitespace damaged, btw.

I also prefer one variable per line

	u32 fixed_ucode;
	u32 chip_pf;
	u32 dummy;

> +    if (!cpu_feature_enabled(X86_FEATURE_FSGSBASE))
> +        return;
> +
> +    if (!x86_match_cpu(naughty_list))
> +        return;

Heh, also I was joking about 'naughty_list'. It would be best to give it
a good symbolic, meaningful name.

> +    native_rdmsr(MSR_ZHAOXIN_MFGID, dummy, chip_pf);

This at least need commenting. What prevents this code from getting
called on other vendors' CPUs? What about models of Zhaoxin CPUs that
don't have this MSR?

> +    /* chip_pf represents product version flag */
> +    chip_pf = (chip_pf >> 15) & 0x7;

Please use the GENMASK macros here.

> +    if (chip_pf == 0)
> +        fixed_ucode = 0x20e;
> +    if (chip_pf == 1)
> +        fixed_ucode = 0x208;
> +
> +    if (intel_get_microcode_revision() >= fixed_ucode)
> +        return;

It's probably worth commenting why this is calling an "intel"_ function.

> +    pr_warn_once("Broken FSGSBASE support, clearing feature\n");
> +    setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
> +}
> +
> +#endif



