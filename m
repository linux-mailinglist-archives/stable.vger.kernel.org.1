Return-Path: <stable+bounces-273092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OxAzMwk5UGoGvQIAu9opvQ
	(envelope-from <stable+bounces-273092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 02:12:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AAB736503
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 02:12:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Yg+5MszE;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273092-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273092-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03CB93032820
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 00:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887751DFDE;
	Fri, 10 Jul 2026 00:12:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C07811CA9;
	Fri, 10 Jul 2026 00:12:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642371; cv=none; b=QjKTZEavgoxWqANyc+L0dkIHRjBo5HD+oVUBiFOL2WcAGqWVMAeBNrrbosNFR9qVK6GItDaGU6FqxWLohE/8mhk2PI2zrI8Yaf5Jci0MuXxL26t19PU2TsQbiS3C/I+WZXUuyslxCntSrAzx+s+x4rDZpb8UlTUseEfjYUckEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642371; c=relaxed/simple;
	bh=BdMrIlsnyf3bd76KcFcNhZf3eYEWTHY7rvlxtWL2mvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApfH+L2T1/T2ltzlHxOFfD9zj9aaLJGF7mxT/eOMxOdLQSgmCprzadB+9ccimaxtc25JKOnMb3zeyBocm4ngmftvuy1yEVupOhJvbojY2dE0DcXNmmQzseV/yhSgLlBGslUvwsnlzP8x1V3gCckULWxMTR3OTznUkzEWmBttt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yg+5MszE; arc=none smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783642369; x=1815178369;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BdMrIlsnyf3bd76KcFcNhZf3eYEWTHY7rvlxtWL2mvQ=;
  b=Yg+5MszEz/CQq0Oc5wpVBKml+xy0tQFQ96b+MvHMeBUcPARJyXME9/Ss
   +mpInsjtxUskUFQSoGkhwg1wySEg/3QAYv3gnFMzMNF4cQ+1nGX6kNDJt
   EizRmu1HICuiWnCcu1/E846uVjp7CvZxzrfXriuK1zxjQ2zAw3PfFdx2C
   5qHggnMVncMTUhbkhOEY4JlK+nRqaHVZSEobs6ZAoTOQY4y0hdDjNDKuZ
   KuGlxifCdskt8E6rGAaMNybQ1EP7nXQ3KdPSte1LzPb0AW7o3UN1e/qhj
   3qo8HQz+MdUd5ZmQccfHyDluF7i3MxRL4rNvchLOayXMH1nCEblmssy/B
   A==;
X-CSE-ConnectionGUID: 7ZSTWsXiTZOGQIJFlFb5Fg==
X-CSE-MsgGUID: atSQ1O3qQ1CawlZR5+8FAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="109887112"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="109887112"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 17:12:48 -0700
X-CSE-ConnectionGUID: u7FKyjn1QEuFpWAnyH0ZVw==
X-CSE-MsgGUID: E221UA5cRqWNMMADiVVBMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258345788"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.241.120]) ([10.124.241.120])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 17:12:45 -0700
Message-ID: <64baf955-76e2-4b03-b2f9-29b9830acc01@linux.intel.com>
Date: Fri, 10 Jul 2026 08:12:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: TDX: Use validated CPUID entry count for TD
 init
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 "thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kas@kernel.org" <kas@kernel.org>
References: <20260708022937.2465796-1-binbin.wu@linux.intel.com>
 <ak4NdJSK60zKD8Uy@linux.dev>
 <315e969a-4ab1-433e-91c5-2308f1975281@linux.intel.com>
 <28ec0a5ac5c46448df5983cc7f9cbc71f6014e8a.camel@intel.com>
 <9d376736-4879-42f2-b798-56fd2d1ab05a@linux.intel.com>
 <ak-lHS2edzxcmT1j@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <ak-lHS2edzxcmT1j@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273092-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:rick.p.edgecombe@intel.com,m:thorsten.blum@linux.dev,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,m:pbonzini@redhat.com,m:linux-kernel@vger.kernel.org,m:kas@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[binbin.wu@linux.intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[binbin.wu@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:dkim,linux.intel.com:mid,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21AAB736503

On 7/9/2026 9:41 PM, Sean Christopherson wrote:
> On Thu, Jul 09, 2026, Binbin Wu wrote:
>> On 7/9/2026 12:20 AM, Edgecombe, Rick P wrote:
>>> On Wed, 2026-07-08 at 17:04 +0800, Binbin Wu wrote:
>>>>> Maybe it would be better to check for a mismatch and return -EINVAL?
>>>>>
>>>>>  	if (init_vm->cpuid.nent != nr_user_entries) {
>>>>>  		ret = -EINVAL;
>>>>>  		goto out;
>>>>>  	}
>>>>>
>>>>> That would make the mismatch explicit instead of silently accepting an
>>>>> inconsistent userspace snapshot.
>>>>
>>>> I chose to use the snapshot value to follow KVM_SET_CPUID2's style.
>>>> KVM_SET_CPUID2 kind of uses the snapshot value of entry count.
>>>>
>>>> But returning a error code is OK for me.
>>>> Let's wait and see what others prefer.
>>>
>>> It does seem safer to reject input than have some implicit behavior.
>>
>> Yea, had a second thought.
>> If there is a mismatch, the userspace is probably malicious.
>> It's safer to reject the request when the userspace is suspicious.
>>
>> Will send v2 to reject the request for the case.
> 
> Rather than add a separate if-statement, I saw lump it into the existing sanity
> check on the cpuid field:
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 6ff1469e91cc..10b4db17fbd5 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -2797,7 +2797,7 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
>                 goto out;
>         }
>  
> -       if (init_vm->cpuid.padding) {
> +       if (init_vm->cpuid.padding || init_vm->cpuid.nent != nr_user_entries) {
>                 ret = -EINVAL;
>                 goto out;
>         }
Yeah, thanks for the suggestion.

