Return-Path: <stable+bounces-272582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W1AiCdATTmqhCgIAu9opvQ
	(envelope-from <stable+bounces-272582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 11:09:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0467237A7
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 11:09:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="nEt/Orn1";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272582-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272582-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D916D3002B7B
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FA43FE37A;
	Wed,  8 Jul 2026 09:04:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A559407CC3;
	Wed,  8 Jul 2026 09:04:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501481; cv=none; b=ptkS9YIrn/IYeEk5bVxSjyW7rm/sWXGTFLBkkRASwVWxuRLDe5m8w7gfn+FThGWlRzOQTp9q9ADeNvaJWNySzdxLd1aWNuihuO+3gOiPy6f9/BbL47bHco8WhWiOGLXna0PMZMHwJsqKL6gQ85IzRBrCo8pgwalsQRP+8QopRfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501481; c=relaxed/simple;
	bh=OKIOzLvBrmKffP3gSyvy9iH0JqK3+WVLlH8Nq1mARYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7hurTMMEGWeD/zoGBTQO0b/Dgh/R3Y+WIWQqds/kI+q1NFNPTdOHlbf/nWRH3cdPAwPPDOHm5BP4+oglJkMGgIshrUC2oF+IypiQ69A7muu4uECQHWjJnxiwLGVyjVXwvCzDxAwFH5yL9+CjhOrJvALtIo6Rzdcjwxw85R2YUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEt/Orn1; arc=none smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783501480; x=1815037480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OKIOzLvBrmKffP3gSyvy9iH0JqK3+WVLlH8Nq1mARYw=;
  b=nEt/Orn15vi5dNvCvOy0aRS4sGcsLw9fXgxvxwtYA1rVEA86l8hH1mwc
   3s0qN4ZTQRErYrLlb8sBWxAuqicVLbvRvySW3mrQ6ScFn5DxIBEe8jQGa
   VSI8BMnFNkzZW96YLB4XIUD10SQTl9HM4DPcsUdFerGOx2DRBy6cbingo
   IIBKXIGtrBb0JKYiPrVbdDNu2WujoxPH5cquKA2EaFKfb8BIxvh7Yv7Da
   Kc1k+P852GvwqRyMdfVfvqDyqlAFV+5nmEG7ZUJ9i9spjwrhpC5q6b+2Z
   r39h3/g2008q3YOJ9hTnJZ262J10FFqwm49YzoAJY46mXWuNBOlbF6cto
   Q==;
X-CSE-ConnectionGUID: nys7WCfgRZmoIph27p9Brw==
X-CSE-MsgGUID: kIPqdY+FTC2BvPvenKtnDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="71678395"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="71678395"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 02:04:39 -0700
X-CSE-ConnectionGUID: een7jxLVTguQCqAZF2idfw==
X-CSE-MsgGUID: lO6rMi6wSRWOZ+BFLGnS+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="250878999"
Received: from unknown (HELO [10.238.2.244]) ([10.238.2.244])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 02:04:36 -0700
Message-ID: <315e969a-4ab1-433e-91c5-2308f1975281@linux.intel.com>
Date: Wed, 8 Jul 2026 17:04:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: TDX: Use validated CPUID entry count for TD
 init
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 stable@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com,
 kas@kernel.org, rick.p.edgecombe@intel.com
References: <20260708022937.2465796-1-binbin.wu@linux.intel.com>
 <ak4NdJSK60zKD8Uy@linux.dev>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <ak4NdJSK60zKD8Uy@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272582-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[binbin.wu@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:thorsten.blum@linux.dev,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,m:seanjc@google.com,m:pbonzini@redhat.com,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[binbin.wu@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,linux.intel.com:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B0467237A7

On 7/8/2026 4:42 PM, Thorsten Blum wrote:
> On Wed, Jul 08, 2026 at 10:29:37AM +0800, Binbin Wu wrote:
>> Use the validated CPUID entry count when parsing CPUID data for
>> KVM_TDX_INIT_VM.
>>
>> tdx_td_init() first reads user_data->cpuid.nent to size the flexible
>> kvm_tdx_init_vm copy.  The copied structure also contains cpuid.nent, and
>> that field can differ from the value used to size the allocation if
>> userspace modifies the input concurrently.  setup_tdparams_cpuids() later
>> passes init_vm->cpuid.nent to kvm_find_cpuid_entry2(), which uses it as
>> the array bound for the copied entries.
>>
>> Overwrite the copied nent with the validated count so CPUID parsing is
>> bounded by the number of entries actually copied.
>>
>> Fixes: 0bd0a4a1428b ("KVM: TDX: Replace kmalloc + copy_from_user with memdup_user in tdx_td_init()")
>> Reported-by: Sashiko:gemini-3.1-pro-preview
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>> ---
>>  arch/x86/kvm/vmx/tdx.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index ffe9d0db58c5..b658b03e7750 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
>> @@ -2802,6 +2802,12 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
>>  	if (IS_ERR(init_vm))
>>  		return PTR_ERR(init_vm);
>>  
>> +	/*
>> +	 * Use the validated entry count, as user_data->cpuid.nent may have
>> +	 * changed.
>> +	 */
>> +	init_vm->cpuid.nent = nr_user_entries;
>> +
> 
> Maybe it would be better to check for a mismatch and return -EINVAL?
> 
> 	if (init_vm->cpuid.nent != nr_user_entries) {
> 		ret = -EINVAL;
> 		goto out;
> 	}
> 
> That would make the mismatch explicit instead of silently accepting an
> inconsistent userspace snapshot.

I chose to use the snapshot value to follow KVM_SET_CPUID2's style.
KVM_SET_CPUID2 kind of uses the snapshot value of entry count.

But returning a error code is OK for me.
Let's wait and see what others prefer.


> 
>>  	if (memchr_inv(init_vm->reserved, 0, sizeof(init_vm->reserved))) {
>>  		ret = -EINVAL;
>>  		goto out;
>>
>> base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8
>> -- 
>> 2.46.0
>>
> 


