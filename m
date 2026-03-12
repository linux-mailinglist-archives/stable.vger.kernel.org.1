Return-Path: <stable+bounces-224883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ1xD67ismmWQgAAu9opvQ
	(envelope-from <stable+bounces-224883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:58:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B652750B6
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55CAF324E186
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4624D374171;
	Thu, 12 Mar 2026 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjk2LRgw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9135B651;
	Thu, 12 Mar 2026 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330747; cv=none; b=Rped4syx3/Bg0KXCcQpClxKq0fAUv6FzzCtpeKS0XbxtUQQ5PUxYE6OLaEJ+fUqe9CRYLH8EStzHDT9hjQGuFodsAu8KLyUjpvZcAXjgjs5SZ+uTcbc9ewBWRHkz2K33XdMqM0Er8EO0u+y5yKIxkvOGJPozcjqNgqFAWpk+XxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330747; c=relaxed/simple;
	bh=gMmde2pTAnMM3kpKmwV4MbbmGIN9MPit4jJoBeyFyyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUyR28KyxwhuqMuKYhEXcCumyXvtA3Hf/teXqfHZTWWOPzxeR7vC4CGDAGNnEnbvKom/Huf/bawgtGkDy0YzWyQ3Af+kT2Lh4oOEr1olZ4ufks+jQoRtvdf9Yh/9XQEWFUBp6D6vau7Py605FgSZmSUa4e/cg4eTfa+n2RzMOLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjk2LRgw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773330744; x=1804866744;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gMmde2pTAnMM3kpKmwV4MbbmGIN9MPit4jJoBeyFyyw=;
  b=bjk2LRgw6RYwTI21m0S7gnu4CGWssQSZ2rxvRU2HLOAX4ZHeBOJloB6g
   l3xF36wh42vXQgzBzsecKLf7WG+nq10Isy7hAN4ZrN+H0so9Ewsao2QF6
   VkgqoIOLg030Vb7p/xTkmJUS60kRkH/kgvGZ4Od+Hf8Yjnw8TMu+J0oWU
   CCX6ceeM3hns3RxOQJo3Y2SPlWBu3D/g4WNQOHSGIbBeC5uPbxI1S7Ohv
   2Ob7tho37rLrG3rtpoZO8mBvp+VBYsrYtPxl80MQuY+o77nvpFFRW7e8e
   /qZSG7fWN3NIuIzQgEa7RDWYsmpybFojVJy0JVuQT6eX0aoGsk0mKB2hd
   Q==;
X-CSE-ConnectionGUID: 72q6fz3tRq+JEmW+cu4qOQ==
X-CSE-MsgGUID: CeuZD3VfRjiWoBOdE35tAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="62002476"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="62002476"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 08:52:23 -0700
X-CSE-ConnectionGUID: 5TwKcQXfRaGyUWJxFxtPTA==
X-CSE-MsgGUID: p65BddDAQJO3Qoz1kXxlNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="251356200"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.110.129]) ([10.125.110.129])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 08:52:23 -0700
Message-ID: <03a03ec8-4309-42ac-a13d-2fcc8396d547@intel.com>
Date: Thu, 12 Mar 2026 08:52:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, me@ziyao.cc
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
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <b16bda4b-c7cb-4e7f-ac71-57c0032c6633@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-224883-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.hansen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2B652750B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/11/26 19:14, Tony W Wang-oc wrote:
> 
> 
> +       if (c->x86 == 6 && c->x86_model == 15 && c->x86_stepping >= 14) {
> +               native_rdmsr(0x1232, dummy, chip_pf);
> +               chip_pf = (chip_pf >> 15) & 0x7;
> +               c->microcode = intel_get_microcode_revision();
> +
> +               if ((chip_pf == 0 && c->microcode < 0x20e) ||
> +                       (chip_pf == 1 && c->microcode < 0x208)) {
> +                       pr_warn_once("CPU has broken FSGSBASE support;
> clear FSGSBASE feature\n");
> +                       setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
> +               }
> +       }

So, I'm sorry but that's not really consistent how we're doing things
these days.

The model needs a symbolic name.

The MSR you're reading is completely undocumented and unnamed.

"chip_pf" is nonsensical and unexplained.

Code is duplicated across the centaur and zhaoxin files.

Once you have all of that fixed, you should have a simple:

#define CENTAUR_MODEL_FOO VFM_MAKE(X86_VENDOR_CENTAUR, 6, 15)
#define ZHAOXIN_MODEL_BAR VFM_MAKE(X86_VENDOR_ZHAOXIN, 6, 25)

in a central header, plus:

struct x86_cpu_id *naughty_list[] = {
	X86_MATCH_VFM_STEPS(CENTAUR_MODEL_FOO,       14, MAX_STEP, 0),
	X86_MATCH_VFM_STEPS(ZHAOXIN_MODEL_BAR, MIN_STEP,        3, 0),
	{}
};

void check_fsgsbase_bugs()
{
	u32 fixed_ucode;

	if (!cpu_feature_enabled(X86_FEATURE_FSGSBASE))
		return;

	c = x86_match_cpu(naughty_list);
	if (!c)
		return;

	chip_pf = ...
	if (chip_pf == 0)
		fixed_ucode = 0x20e;
	if (chip_pf == 1)
		fixed_ucode = 0x208;

	if (intel_get_microcode_revision() >= fixed_ucode)
		return;

	pr_warn_once("Broken FSGSBASE support, clearing feature\n");
	setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
}

Then check_fsgsbase_bugs() can pretty much be called anywhere. It can
even be in generic code.

We are also getting some new matching fields in 'x86_cpu_id'. I suspect
'chip_pf' can be stored in there where Intel has the platform_id right
now. But you don't have to do that now.

Could you please go this route rather than copy-and-pasted chunks of
code sprinkled with a healthy dose of magic numbers?

