Return-Path: <stable+bounces-246900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDhRJtSfBGqbMAIAu9opvQ
	(envelope-from <stable+bounces-246900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:59:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0043536A56
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33BA931FD02C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A92388885;
	Wed, 13 May 2026 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="iJ6WA420"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDEB387578
	for <stable@vger.kernel.org>; Wed, 13 May 2026 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685066; cv=none; b=FVXXI5qidoF2ai9yA3h0lAik4a9SjmcCRJUHYH7G3IqIqCIsDxgALMnvHa+9zuu4P8LYnvIcL8nOCA409Vb41MqSAPninYdngrrccm/F5nORHJ0t7LoFXQMSPRj+pv0zuuhmiadYH34OZZUn3XBTQrOlpW/8wIcN+7NsSv9r8Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685066; c=relaxed/simple;
	bh=XZwkileRecnbrwGvJinGmTK+/wq/uUIw6IB2B1HlAks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BERLUaBRU4wdyMRKC64lfm6I34Y0NdDECJsLgNTwaicPpheOIlg6UWrfHkWujOzfUvU5BUB2zxCxn2/1oMqzKd5LotdJM0DJ0I9Mz94h41vNP5NAolQFcrFQwVBTPuqGI08lAFIZ5DizmEvDU0QHj9sKURbRuaN06vFaaYDYg/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=iJ6WA420; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891b0786beso44083935e9.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1778685063; x=1779289863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7xx7YpaJm7o+t/t0AKRTj9xeoYgQ9FQh5c3bwuIiEQc=;
        b=iJ6WA420enbwvQVdkW8383TEE+6VQo4y+LG0k7R5N0z0FgpT4HE+6rAr8Qjpf1NlZp
         CfiAHYFOzuOgNILdf8C5bilzasVL3S57AhKCkX+fygnu1vRR5x7Gg95yS9xhGoxuuyua
         NWPxixHYrA90nfkcGPF7VWPxlkv3/BhUwe3NzHOlCFPHuNDbWb0gol96pQXpei9/LGuo
         9p6RGBA7/gB9HIsgpR16z4spW1R3nvz1OoAdlrP1vwEUbfebXHc5NvHQFZz2iDheaJ6U
         voITItJbXlXoFmEpB0GHz0hfnGFzpY78LyAonXDOBptXaNUiVPNj/1TAKWAMuvt8yVQF
         HqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778685063; x=1779289863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xx7YpaJm7o+t/t0AKRTj9xeoYgQ9FQh5c3bwuIiEQc=;
        b=LlmkXwQV72XBwGwn4d+HLVG7Bra7YyLuYmMQ+mit2FpKbyvIQV7BLbvxxIwH1HojGG
         HL3XNK5UUHuZs1N0WJGtnB6efClAAFiDFnuAb+ta+PO3dTtfhTTtGPoKScz0ApfIcS2U
         1VjBFzDuCmwx8/Ga/zzBFo3q5+DIoxFOF4f8iRE5Kh0DKirUUJWLerWnzLmpPbKzrNJE
         S0il58IooUVRI4UmNtkWCK1LgBhMo0nMWsZKcjffnvdHod/nNu6jpBcjRpbIlAjAgxjp
         JRqvBMMVauz758k5e7hoKaDHupKRB+xrdcB2TKHu33shz1aBxTbJSG4j2b8OqqHLatmt
         O9hQ==
X-Forwarded-Encrypted: i=1; AFNElJ/KRieuEXsVWaZKsSDaNI0ovKGZdLe6lF22MlCfwkhOHpnN0ltp04LqZTK3l34fhm8covBURxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM6Urf9aM2pHkNF+JmEwrKkfH/dxEu4XicXrSqLja98TGP/YIj
	ZDK7zowzTGB5brR6HOtlsAri8PkVk1znX+d+ecB2iw76/sbZ+TsIvbjnArsCHImYXGuy4Cffnjc
	GMQdj
X-Gm-Gg: Acq92OHfCJVWjtUwuIiMthviI040EZ+jRU0IalZmTs+6Z1GL5AuJrrdpOSrAMsjVlSd
	Rfp2WUhcp3zilQFVXs66B4IgUeGKdslH4bv7CJTeDXUvHwLjbDuNj7rO6coED4O4bpyEfVHuESI
	NpNUcYECyoQWUdZvegMdZfccuRwHA/WzDnsJ9lYkhdVh9vhVNSifljCQfTjS8RBKIBWinXFiMrA
	HiwIqdr4a3nj+pErXGdphosnql7QQdteYsxfx6L9e2fxTHq0TtVojBKZnOp92RV1axZjYxZS9hR
	lPz3n17JUWSYsZwoNr8VrcTqHGWsP9CEpbnkiZPbGxnfAM73LH7//f2POpEI59Ep/nrpHckjKDO
	xfXTPclcpe+cEgmAzxRP4x5K46QCRArC8+9+mf7+7Aeeg3DfEv7dZy8wrR6ZGEaf8srulcuBawF
	B1xvAdrhbtHZiM7f2/bhHUkEgskODoE3JjBBuHlWUQTZzC
X-Received: by 2002:a05:600c:a31b:b0:488:b187:3c with SMTP id 5b1f17b1804b1-48fd5b4f6cbmr13108955e9.14.1778685062938;
        Wed, 13 May 2026 08:11:02 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fce05e45esm55186845e9.4.2026.05.13.08.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 08:11:02 -0700 (PDT)
Message-ID: <9186ca2b-86be-4000-8903-0e64a5245280@ursulin.net>
Date: Wed, 13 May 2026 16:11:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915: skip __i915_request_skip() for already signaled
 requests
To: Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: andi.shyti@linux.intel.com, krzysztof.karas@intel.com,
 stable@vger.kernel.org
References: <fe76921d35b6ae85aa651822726d0d9815aa5362.1776339012.git.sebastian.brzezinka@intel.com>
 <c9c1270b-f724-45dd-a66d-f7b30f6c6087@ursulin.net>
 <DIHIPV1FJITR.1FJEZMGRDSR7I@intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <DIHIPV1FJITR.1FJEZMGRDSR7I@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F0043536A56
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ursulin.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-246900-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ursulin.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ursulin.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tursulin@ursulin.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Action: no action


On 13/05/2026 12:38, Sebastian Brzezinka wrote:
> Hi,
> 
> On Wed May 13, 2026 at 10:47 AM CEST, Tvrtko Ursulin wrote:
>>
>> On 16/04/2026 12:31, Sebastian Brzezinka wrote:
>>> After a GPU reset the HWSP is zeroed, so previously completed
>>> requests appear incomplete. If such a request is picked up during
>>> reset_rewind() and marked guilty, i915_request_set_error_once()
>>> returns early (fence already signaled), leaving fence.error without
>>> a fatal error code. The subsequent __i915_request_skip() then hits:
>>> ```
>>> GEM_BUG_ON(!fatal_error(rq->fence.error))
>>> ```
>>>
>>> Fixes a kernel BUG observed on Sandy Bridge (Gen6) during
>>> heartbeat-triggered engine resets.
>>> ```
>>> kernel BUG at drivers/gpu/drm/i915/i915_request.c:556!
>>> RIP: __i915_request_skip+0x15e/0x1d0 [i915]
>>> ...
>>> __i915_request_reset+0x212/0xa70 [i915]
>>> reset_rewind+0xe4/0x280 [i915]
>>> intel_gt_reset+0x30d/0x5b0 [i915]
>>> heartbeat+0x516/0x530 [i915]
>>> ```
>>>
>>> Guard __i915_request_skip() with i915_request_signaled(), if the
>>> fence is already signaled, the ring content is committed and there
>>> is nothing left to skip.
>>>
>>> Cc: stable@vger.kernel.org
>>> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/13729
>>> Fixes: 36e191f0644b ("drm/i915: Apply i915_request_skip() on submission")
>>> Signed-off-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>
>>> ---
>>>    drivers/gpu/drm/i915/gt/intel_reset.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
>>> index 37272871b0f2..b728a5171e93 100644
>>> --- a/drivers/gpu/drm/i915/gt/intel_reset.c
>>> +++ b/drivers/gpu/drm/i915/gt/intel_reset.c
>>> @@ -133,7 +133,8 @@ void __i915_request_reset(struct i915_request *rq, bool guilty)
>>>    	rcu_read_lock(); /* protect the GEM context */
>>>    	if (guilty) {
>>>    		i915_request_set_error_once(rq, -EIO);
>>> -		__i915_request_skip(rq);
>>> +		if (!i915_request_signaled(rq))
>>> +			__i915_request_skip(rq);
>>
>> I spotted this patch in drm-intel-fixes today so some questions.
>>
>> If the request is okay why is setting error and marking it guilty left?
> The request can still be guilty even if it already looks signaled
> after reset. The important point is that i915_request_set_error_once()
> will return early once the request is already signaled, so it may not
> actually inject the error. That leaves __i915_request_skip() with no
> error to work with, which is why the guard is needed.
> 
>>
>> 1)
>> How confident are you of the Fixes: target? That patch is six years old
>> but the Closes: issue is only from last year? Do internal Intel log have
>> evidence bug was there in between those two dates? How sporadic was it?
> a
> I’m quite confident the fix is correct, and it should not break anything
> if it is missing some corner detail. This is an extremely rare issue,
> specific to Sandy Bridge, but we know it was present at least as far
> back as 2022 from work item 5774. The bug only shows up when the right
> reset timing lines up, which is why it is so sporadic.
> 
>> Were you able to verify the fix easily or with difficulty and how?
> I verified the fix mainly by code analysis. In the worst case, it should
> not break anything because the change only skips __i915_request_skip()
> when the request is already signaled, and  the ring content is already
> committed, so there is nothing left to skip.
> 
>>
>> 2)
>> Is the issue only that the order of setting the error code and the bug
>> on got swapped?
>>
>> Ie. before 36e191f0644b
>>
>> __i915_request_reset
>>    -> i915_request_skip
>>          GEM_BUG_ON(!IS_ERR_VALUE((long)error));
>>          dma_fence_set_error(&rq->fence, error);
>>
>> After:
>>
>> __i915_request_reset
>>    i915_request_set_error_once
>>    -> i915_request_skip
>>
> Yes, exactly. In the old code, i915_request_skip(rq, error) always set
> the fence error first, before doing anything else:
> ```
> GEM_BUG_ON(!IS_ERR_VALUE((long)error));
> dma_fence_set_error(&rq->fence, error);
> ```
> 
> So even if the request was already signaled, the error was still
> recorded. That is the important difference.  After 36e191f0644b, that
> logic was split into two steps:
> ```
> i915_request_set_error_once(rq, -EIO);
> __i915_request_skip(rq);
> ```
> 
> Now i915_request_set_error_once() can return early when the request is
> already signaled, which means the error may never get set at all. That
> is why the new guard is needed around __i915_request_skip(). The old
> code did not have this problem because the error was set unconditionally
> inside i915_request_skip().

Hmm right, I did not look into i915_request_set_error_once() so did not 
spot it already has the i915_request_signaled() check.

Would it then be nicer if the code was written as:

if (i915_request_set_error_once(rq, -EIO))
	__i915_request_skip(eq);

?

But the above is details. What worried me more is whether with the patch 
there is scope for regressions due not zapping request in a chain, 
depending on timing. TBH I don't remember exactly how the reset flow 
works, especially on Gen6 which was before my time.

Okay, lets have this as is for now and hope it is good.

Regards,

Tvrtko

> 
>> If that is the case commit message should have been clearer on both
>> questions.
> could you tell me how I should send the corrected commit message? Is it
> enough to send it here, or should I send a new version to the mailing
> list?
> 


