Return-Path: <stable+bounces-211958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL+zIXnyeWns1AEAu9opvQ
	(envelope-from <stable+bounces-211958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 12:26:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAF6A0553
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 12:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E99130338A0
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B764234A76E;
	Wed, 28 Jan 2026 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHKb8nJn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B40034A3D0
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599485; cv=none; b=dCyirayJp5SfZzhAawEl1JRrvAzfeyOJqDVHLd8ipDN+YfMZ5VGuF8W7cshU94pfEt4jXa0mLRqmeAWpmqneJZMMcErJPD+1CO68m+cUF4qD4FTyGFJMv43sj27pH55a0Tzpmugjfes9W5KZq4WULJLcc1QOsVurOb0KJtrwoDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599485; c=relaxed/simple;
	bh=25g4O43N1bLtkrkr1+uCwDw4ELnJ91ur3lmZvPxN5OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4YxhXN+QzBNFDzFxNzQM1kxYtoNwS10bft++umg0CypMmao9fCTYNKi9M9ME7CTd2uu/6N/WB5g8+wFZYRGybl5KDlFcPL2K8dZSqQZ08T434MVjaOOfQPxkb/cAmUxky5jxZ4/AbGpdhHiYyo3Byf4o9+tVazbJyMx/3hR4q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GHKb8nJn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b885e8c679bso821218866b.1
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 03:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769599480; x=1770204280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FSYBM9xI9IDMaIPF6q/FwBQXTfrdcuEntAVRYe57nxg=;
        b=GHKb8nJn9vcjA/qBENC7/KZ75xw/WdgFJCTpY7/GUH5D8NxI6lWMq209bN16S6k2iz
         EDQiZyKWA0nSRNQ9N0chp5TeY8ErGrHUXU5++PPq1Hor1P+NWyQdjPNvxVR/7gGJDnHW
         2z0mVc+3H7OOJnCay6WtPtitrzyx8SCsVhlCadxvCVRqREOEvTaROJN++dStvZzVvgVu
         O1pYOodmAHsMh0EQUE6NuTw2Ekj3cOJsq5tNaJrYclr++GqEKMQMQxAx61mK0C8OMyoU
         k/hUBNFLfkb8SPz9E9+FO+sVS9XmkB1iOT3Ln8bAv/s0i1Edi4BaGH23b7Hh6KjnKydr
         KMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599480; x=1770204280;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSYBM9xI9IDMaIPF6q/FwBQXTfrdcuEntAVRYe57nxg=;
        b=NLnaPdKiCSLVfFYkML60uLGlT+wPJ7XobaOJdS/ZEgv8m3p/XahunsOPjWeRSgSO7I
         0pZmNdcWz54qgRrzdKvA5PYn1A0DzGVQ0W8y0Ig5GrP6yq7yIVamlrJyFIVyeqUsYJUA
         1hvI/XNO0HtDsnLxY3PU9+eAWXymEl8HMfFa5wDDKznRgAn1+8OAEZwFOqY66NJNRk6z
         /A02ra5mmQMHBkAo9I/QVAFE+N83Zb9fJm9K7Ip6inuz4ZhiD3rY9zCXkeElrAW1zTIz
         +Lke2MXQMnbCcE+pGm8z0xPxjVUUMVZbmI2eIMeyoW/NJYNOmsOU+/gU9GtLZn8+T/FG
         KHtw==
X-Forwarded-Encrypted: i=1; AJvYcCW4I36/ZQn8ZyXTIE6mcB9UkH2pk6Q3LcvKZ/UuEBqP6LZWUFRG6jAOPJyZ4jH+ZnOVU2+nBDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2NTnNUMLy7pw7yEN7FaspuVU/UOHP6L+Ctxe+HxU6XEu6QfJ3
	GJnXAr1fpzfBmVO7d2OrOUipRLQISUnXN0d3kqg6a1wHzW8GgQx6mRB8/Kabh5PGoDY=
X-Gm-Gg: AZuq6aK0uUObmFJ+gI09huWAaab/mZRVVd4t8FcBvxKj6T6srRHCG2piE1c6QysDWD5
	bXqHeTLJWzHAmrd++1zDnoM90hm5wt+8dwVMIYMd+KwKGFDeCksR1IBnmP/0vNqlhhwzppmoX+1
	Hej/jSOheuwAXeL7uD8sOyh1get1zGPXsWHF95qaWajKMUlOynJ/beSy+Py2KAzyin9rPzeANh+
	R21jfs3Aybdeoha2637eLEyC2P8E41n2meXmOxQhH+o32Xu+epPWop8XnNVV9EICqJNlPOKtHqe
	ED9ruyV1fUkgc2p3K81wF49y6rLSHKe2M30NSSFT8G1eu9xz6buTHsmkWK/9ycWLn4m6qF4rhcn
	mlU3BdyIwu0rH+lgbOKk0/Fe0vOo9NLNtJXm5plLyF3hW3k485jnJHJaIVXM4AkX0ACyWUFrDlj
	4l4T68zoTHTuznriGYF2Z72rziRr9cRncX810SNMM6ddeo3f4cOPJw2VDH51QO1/w=
X-Received: by 2002:a17:907:2d26:b0:b87:7042:9aea with SMTP id a640c23a62f3a-b8dab1b52d7mr359022166b.18.1769599480450;
        Wed, 28 Jan 2026 03:24:40 -0800 (PST)
Received: from [192.168.0.40] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1baa42sm113930766b.46.2026.01.28.03.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 03:24:39 -0800 (PST)
Message-ID: <efcd8387-22d0-413d-9631-f392a2e7f98d@linaro.org>
Date: Wed, 28 Jan 2026 11:24:38 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] media: i2c: ov02c10: Correct power-on sequence and
 timing
To: Saikiran B <bjsaikiran@gmail.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, rfoss@kernel.org, todor.too@gmail.com,
 vladimir.zapolskiy@linaro.org, Hans de Goede <hansg@kernel.org>,
 mchehab@kernel.org, stable@vger.kernel.org
References: <20260127165024.46156-1-bjsaikiran@gmail.com>
 <20260127165024.46156-3-bjsaikiran@gmail.com>
 <aXjwtBey0MRP0c7f@kekkonen.localdomain>
 <hAXW76sxpszN3JpApVO_ntI28dSyCTiDXIE-S1AJDCa7Mbp8-pHbGqhFhTh2FGPdj3TxO9AowyRRan2u8TTO6Q==@protonmail.internalid>
 <CAAFDt1vJtJc+C_J9Gv3SYjs_2zWFXsWqwq29=ig1o2_kSkjwLg@mail.gmail.com>
 <dbf73780-a33a-4fbf-8569-321b4f4e0a88@kernel.org>
 <MZajBkG4hU2kIZFDZbpq0WZOF_tJmASpmGr-7IH_qheO0We0Z45KNZPrQY4UmoqsWKOX3lSx1W_hnLtfKocXPw==@protonmail.internalid>
 <CAAFDt1vmXg9L6axsDN6kpCQKZifOCRxtQeDpmRpHyejS1ORR+Q@mail.gmail.com>
 <92131a67-471e-41e8-83d6-4f802103db7b@kernel.org>
 <CAAFDt1sqh=O-CpxbdcWueyqbiq4qyCrJHVH-_SS+KjEC9CyRhg@mail.gmail.com>
 <6692ca5f-216f-428c-96b2-511fdd769f04@linaro.org>
 <CAAFDt1u0uV+KpPxrhtwbvWgAYQET3HLg1nu4u7JgaNPFAKNLWg@mail.gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <CAAFDt1u0uV+KpPxrhtwbvWgAYQET3HLg1nu4u7JgaNPFAKNLWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,vger.kernel.org,gmail.com,linaro.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211958-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryan.odonoghue@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0AAF6A0553
X-Rspamd-Action: no action

On 28/01/2026 11:06, Saikiran B wrote:
> On Wed, Jan 28, 2026 at 4:11 PM Bryan O'Donoghue
> <bryan.odonoghue@linaro.org> wrote:
>>
>> On 28/01/2026 10:19, Saikiran B wrote:
>>>   > Just to be difficult - I'm specifically asking to test never switching
>>>   > the regulator off - not having a long delay.
>>>
>>> To be absolutely clear:
>>>
>>> ***I have tested exactly this.***
>>>
>>> In my local v2 testing, I modified the driver to keep the regulators
>>> permanently ENABLED and only toggled the software standby/reset lines.
>>>
>>> Result: The camera was 100% stable over hundreds of cycles.
>>>
>>> This isolates the issue:
>>> 1. CCI Leaking? No. If CCI were leaking, the "Always On" test would
>>> eventually
>>>      fail or show instability. It did not.
>>
>> I have to say, I'm not an electrical engineer by profession but, I don't
>> believe you can make this blanket statement.
>>
>> What is the problem with testing the hypothesis ?
>>
>>> 2. XSHUTDOWN Floating? No. The "Always On" test relies on XSHUTDOWN working
>>>      correctly to wake the sensor. It worked perfectly.
>>
>> Yes I agree there, if always-on shows no failure then XSHUTDOWN isnt'
>> floating.
>>
>> In which case this patch can be dropped, its not helping.
>>
>>> The instability ***only*** appears when we physically toggle the PMIC rail.
>>>
>>>   > Do not believe we have root caused a regulator brown out
>>>   > Believe we should interrogate the LDO settings
>>>
>>> I cannot easily dump raw SPMI registers on my personal machine, but
>>> we can derive the LDO state physically from the discharge curve (RC Time
>>> Constant).
>>
>> ?
>>
>> I gave you code to do just that. If you can iterate sensor and DTS
>> changes - you can use that code to dump out the requested LDO states.
>>
>>> We know the physics of the PM8550 PMIC:
>>> - Active Discharge Resistor (R_active): ~1 kΩ (Typical)
>>> - Bulk Capacitance (C_bulk): ~10 µF (Estimated for this rail)
>>>
>>> Scenario A: If Active Discharge IS set:
>>>      Time Constant (T) = R * C = 1000 * 10e-6 = 0.01s (10ms)
>>>      Complete discharge (5T) would happen in ~50ms.
>>>
>>> Scenario B: If Active Discharge is NOT set (Passive Leakage):
>>>      The rail discharges through the high-impedance sensor (~200kΩ+).
>>>      Time Constant (T) = 200,000 * 10e-6 = 2.0s.
>>>
>>> My measurements show the rail takes ~2.0s to reach the Brownout Threshold
>>> (failure point) and ~2.3s to reach a clean 0V (success point).
>>>
>>> This 2.3s duration is physically impossible if the Active Discharge bit
>>> was set.
>>> It mathematically proves the LDO is in High-Z mode (Passive Discharge).
>>>
>>> Here are the specific logs capturing the failure at exactly the 2.0s mark.
>> That's great. We should be able to interrogate the PMIC regs and see the
>> state of the LDO configuration - code I've shared with you.
>>
>> If they show active-state isn't set on one or more of our LDOs then we
>> can write some platform quirk code to set them.
>>
>> A 2.3 second delay on every start/stop stream is not an acceptable
>> upstream fix.
>>
>> And please stop top posting !
>>
>> ---
>> bod
> 
> Regarding the register dump code you shared:
> 
> I have already attempted to use it. It fails to read the registers on this
> device. This is a consumer laptop secured by the Gunyah hypervisor
> and TrustZone, not an open development board. The SPMI transactions to raw
> PMIC addresses are firewalled by the firmware; the Linux HLOS is physically
> blocked from reading them.
> 
> You mentioned in your previous reply that you are not an electrical engineer.
> 
> I am an Electronics Engineer.
> 
> The assertion that a 2.3s discharge time proves the absence of Active
> Discharge is not a "blanket statement" - it is a fundamental calculation based
> on the RC time constant. A 1kΩ active discharge path cannot physically sustain
> voltage for 2.3 seconds against a 10µF load; it would drain in milliseconds.
> Rejecting this derived data because it relies on physics rather than a
> register bit (which the hardware prevents us from reading) is scientifically
> unsound.
> 
> I have a full-time job and have spent significant personal time debugging this
> to the millisecond.
> 
> Since we have reached an impasse where the physical
> evidence is rejected in favor of impossible diagnostics, I am stopping here.
> 
> I will keep my patches in my local tree as now my laptop is usable to me.
> 
> I am withdrawing this patchset from upstream consideration.
> 
> Thank you.
> 
> Regards,
> Saikiran

That's a shame.

---
bod

