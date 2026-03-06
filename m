Return-Path: <stable+bounces-223320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE4uDzimqmlTVAEAu9opvQ
	(envelope-from <stable+bounces-223320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 11:02:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5B021E5CF
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 11:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9AA5306AECD
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2173563F6;
	Fri,  6 Mar 2026 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PapHIcQ2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2468334DCD1
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791128; cv=none; b=YQcBZdAcZWIV7wnITXG2wxd/Sqm3qvxU0jXGYuaHmKceaV35469gQmM0YXcduJieic41QpHS3p8cxHvFRRY2kAW20aquS1pTp9YHVASYG8JDLdLI6526/KPyOGENrfTTegJTBJRg0Ss5apPSA5KHxWCwpHIfp2fO9+TMl9A5v5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791128; c=relaxed/simple;
	bh=Oz0tkBnxcTRJj7izB1cmu6eAueiEzGskMrJQw7bQjR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GT0/Vg97HZkxAKqE0wpl8RgxBlG4Ascd6b37ysxViQWUtZrKCa6QaendG3AHYxDjKiZr1zO3m2qxpG+kKTjpmygRY0XDqV8Ppzkl7RoATlyCNlO5tuyWUuGIRKfknM9nhwuwhYUmnz6aP+GYax0v6bwlYEEJT37lhJEfB6eUIo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PapHIcQ2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b94a19fdso5055979f8f.0
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 01:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772791125; x=1773395925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw3kl19f6ACjjIuebG7y0ksKLkZoZCYwkXV8XNHoJb4=;
        b=PapHIcQ2BIZNt3ACAqy5yFXDj7Jc38O0yXDLE/+tR0KYb0JW4Aqc+7KDYrU2BrGngc
         uLmDUU1ZMWJUxZGt83a7rOWVnCBRlh2+TEivq2uZ0KhusWm2Oem0+CDaBJcVRjFk9C9q
         rgM9c61iyfTnXiBFTUxLmW8hQKM9LupSPx5J0rySBAGF/8zHwVeL1UqblWnc8kiX67oF
         kaMtp/6QVekscwT+Hlknx+jK0Bbc/dI9wo4gmxMmW8al2f/himaJ7IfFjxH5KZ38syxi
         E9nIkzY2Iz7Uks9TZgq5/KM5g3WG0iKSqhUvQoToVp/N2oZvIHzo9+ZHyirxYJQ8t4bR
         A9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772791125; x=1773395925;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yw3kl19f6ACjjIuebG7y0ksKLkZoZCYwkXV8XNHoJb4=;
        b=jOiVtISPfX3O1h3TN241jeLELQEQ9dnWF2x6AduErU1V5scffOWVbyJ+8lIocp31+y
         isqEgsO/Yw7LWNg6jPjeWCj/wM/mCBeVTw3lQw4K8HnDX1gA2PO8d2lzd3B96DbdAp9G
         u2HDDOys7T96B7kob4dh550RaxmvIFV6vn19gMNPec7KbIai3tgg+rGGpP2bJ5vDzhzZ
         jF3nlqTkqHPCtzCgJ56BZ/Jo8xVqGfZJpUO/h6iWQ6K/X/rbcenI6kO+iVMXn+J5VUQM
         zYO7P4R8NSWfW2d6fOGslXsu/N43+pAvP46uPCNWqhqDn2jL5jrBhEHTOHHQSITOfb7w
         m+IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz5dgByUWLKG6YH7iPPa/DHb3RatFm74Nl9ACBTAb5lnn7wxkdRwlL9HGtdK2UbRcu7Sm/ODI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlDmtmgZRRJJOPTeOaaE8ryUt1YBoDSrlAdtAsuWDt6jCcPXWy
	E93sgH1SrB6X6B6/KJtovkNUe3P7MEK9itpkvT0pk0O9yQ7oZG9FbiTKTVWtOUv5F5A=
X-Gm-Gg: ATEYQzxgPYenOEg1slWpmVd0ImLR1Yp88ET1kjDOQfLEHYF12InvERKRPOk6wRPI4qN
	9DD7eCPRHWel0jIg9YpF7BxHyHLi4sj19I419q1QE77y8o7zvmu+o2tYEKAnRh5+TDGJ0g80W8Q
	neeOEvHREZWpaZPp/fL7hwSnXoEldj2CL8hDUGiv3KsIwwWEDBIRm1hqBLWwm41DJo+uLR3+b0+
	ybztEWzlH33ktdgMWDDaTbteigCk93OvyezxQcJEVGAhQPVANBla4ovbLthR1c0zI0p2Fqkv4UX
	GFAa/HuNlL70U5DsSgCOJRQQ+KfjDqKFBb4JWbPMkoqUwz708Y6n8cYLnBfxskOrCt+YFw4k0V8
	hr5aAPxW2e20cC0KipNo1VWJlSRN7CeuGVXpbLL+e4Hkfqkf9PXWTn3cDXB/VFUVty+d59NPHAM
	PEYjFOz452jOiymwZOgqmsBAijSLgFoFpUdrCCRXXnZbQoPFFQ
X-Received: by 2002:a05:6000:1a8d:b0:439:da0d:a025 with SMTP id ffacd0b85a97d-439da66250cmr2101323f8f.20.1772791125509;
        Fri, 06 Mar 2026 01:58:45 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.67.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9fbsm2720528f8f.23.2026.03.06.01.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 01:58:45 -0800 (PST)
Message-ID: <2db61bc6-813d-468a-8ded-018dc9dfb0cf@suse.com>
Date: Fri, 6 Mar 2026 11:58:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
To: "Huang, Kai" <kai.huang@intel.com>, "kas@kernel.org" <kas@kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "nik.borisov@suse.com" <nik.borisov@suse.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Verma, Vishal L" <vishal.l.verma@intel.com>,
 "tglx@kernel.org" <tglx@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260302102226.7459-1-kai.huang@intel.com>
 <20260302102226.7459-2-kai.huang@intel.com>
 <4a15470a-5a10-4742-9faf-f66a88105d58@suse.com>
 <51e221b9bcdeddffb95f2c39dcc285fb0e9f5951.camel@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <51e221b9bcdeddffb95f2c39dcc285fb0e9f5951.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC5B021E5CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223320-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[nik.borisov@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



On 5.03.26 г. 23:35 ч., Huang, Kai wrote:
> 
>>>
>>> The real requirement is tdx_cpu_flush_cache_for_kexec() must be done on
>>> the same CPU.  It's OK that it can be preempted in the middle as long as
>>> it won't be rescheduled to another CPU.
>>
>> TLDR: It wants migration disabled.
> 
> Basically yes.
> 
>>
>>>
>>> Remove the too strong lockdep_assert_preemption_disabled(), and change
>>> this_cpu_{read|write}() to __this_cpu_{read|write}() which provide the more
>>> proper check (when CONFIG_DEBUG_PREEMPT is true), which checks all
>>> conditions that the context cannot be moved to another CPU to run in the
>>> middle.
>>>
>>> Fixes: 61221d07e815 ("KVM/TDX: Explicitly do WBINVD when no more TDX SEAMCALLs")
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Vishal Verma <vishal.l.verma@intel.com>
>>> Signed-off-by: Kai Huang <kai.huang@intel.com>
>>> Tested-by: Vishal Verma <vishal.l.verma@intel.com>
>>
>>
>> So how exactly does this patch prevent the BUG: printk in
>> check_preemption_disabled from triggering, if the lockdep assert was
>> triggering?
> 
> There's no real BUG here.  It's just the
> lockdep_assert_preemption_disabled() is misused.

Essentially in check_preemption_disabled() the check is considered 
passed IF ANY of the preempt disable conditions is met, i.e it's more 
laxed. So yeah, makes sense!

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

