Return-Path: <stable+bounces-212809-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Bs/Kmyre2kAHwIAu9opvQ
	(envelope-from <stable+bounces-212809-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 19:48:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13548B3B32
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 19:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 496C9301CCE7
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 18:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5B2302146;
	Thu, 29 Jan 2026 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTVPK7TN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxxFiA+a"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6BE26E6F9
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769712428; cv=none; b=b9N2GnXXh59limTYn1KihtMaG6vpVqwQaFJek30ZF+SmzvQ9UO6nSBakTwFJ8h7Hsxbbcp9tFFJsYEpZwRH0oz6kPCfVqQw8zFDxJ5XURj6pZaWdKm2FInbFze1+iVq5FW1/sXV2IkyiZo252f7ussJjB0WrooI2YWGGQ6E7rJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769712428; c=relaxed/simple;
	bh=zwCpm9Zfi/rbukqXF+DTC/LB1K9zumi5IVKOILSSAp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DU2L8l3cGMNy95I1GLqSb4em7/xKhnu7+0kdcj2n7Hwimlf1XERRMSHksktPzA2+ys9bXbB1fIDj57NACBe0HIgmRvn6uW1ff4b3dPdbZcgOTrEW5jI202YagEdxcowtUe1ktUW4e4YMdEN2TELaYxsV2Yr04YNiOf8u0QG5F28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTVPK7TN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxxFiA+a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769712426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h4+j/1ESYhDBOc0/ySW5KbZLWXBWumy70U4Psq4VqS4=;
	b=KTVPK7TNtRq9K4TTsG5ea+L44bHI2xSfpOUTypJ39vWG+bHj5FSGN/bqsSBgpjIJwu3Rtf
	wZ8wnTW2rHIZjzDzCatmrH59BvMrpcl8w1xFunSJgNQdelFe7qyafKpKXfZkeus0WWtsCs
	O3qenWe8gExYWhhS4BS4FgiJG+MxF98=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-zmvqCV_ENVq9fGWhbRrXZA-1; Thu, 29 Jan 2026 13:47:05 -0500
X-MC-Unique: zmvqCV_ENVq9fGWhbRrXZA-1
X-Mimecast-MFC-AGG-ID: zmvqCV_ENVq9fGWhbRrXZA_1769712424
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42fdbba545fso1297116f8f.0
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 10:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769712424; x=1770317224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h4+j/1ESYhDBOc0/ySW5KbZLWXBWumy70U4Psq4VqS4=;
        b=TxxFiA+akqMi6U4EtDaU880Kte42O63AyQNoPVD170m0j8PrL2Y4tdtxA4QiMfxTWz
         it7dP+qMuRTFTrATtcOzE0cl7rLXjKxPGEJaZEnuh+8s11HHOHbpQyvqi0lWikN/jE8y
         Mk0Lwl94viFVcnCVZQiwhUyoOlx0NQ0f+BD8wMMR9xn9zlmbzZxG43KAxZbjHhX4RXw7
         Msek+Czues+CKsT1AwbNxIzQzdDb/2vWh3mpWHhQoG4/ToRCBFeug/lQWlgqDQM9uvMd
         4ceHmSE62EZtUGNco3nMPQMKaAO8YUxshU+bw+QyJr17cp0TSf6OktHSKYNRBRqG6Ek5
         yh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769712424; x=1770317224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4+j/1ESYhDBOc0/ySW5KbZLWXBWumy70U4Psq4VqS4=;
        b=UiWqQA08UIxkBRffCdutD72OXvNji5ztMAX9BhUZSLoYXpuTuuBmHpoj17/AOoMJBg
         oKJclJWLPjLtzXXyj+I2VP/shhVfiNqhVcD2dzey95f9Zlh1nsB7NxRvjMpcIq/oFC/M
         R1UQ9DtkQExlsBL90PJ1L17lgD6CpdFs5VRXiaYxpNqt9uktrTGLC0pnxOnzGO8lsDZh
         6d2lmBrjvdqiHeisEu19hXzu85K1U9yc76tQSm1Oyq6+yk1FuiLO54Atlh4JOHij0ArJ
         6jEw1J7I7WQk5Qt2YPTxsI9m0Wkjj0xD0ZGO4BYTM+3GwgLJAI9bu6PHsPyveJZHx/vZ
         sSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyy4KD0H7E5yBJfGUKNTb7rJi9d99qR6g7jwIHXHI6BcRsMKAdmb9hGCesscqMUN/Fkbwflsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eZ3gWI4Fq12PSEBXX4sIuAaDeZqaMx2WvrFy2TMsRpJhgp/z
	rTgjWMHzDXGC2E0zucAFCsb8ZSohBNoPO4G4JaN7cc1wBNA2wTZkPAa4QNFwKOcDDA7pD+FWbZU
	LHOeVqqzhD5DdQPZzsLIrG0jwBi+7xEaWSv1MamGwm3Vo2Bx/OrzC6hFFpA==
X-Gm-Gg: AZuq6aIiAEqqAbMWyo/zUFGb++4T7I4xRE8okwPJPPWw90f2G1t19QKHk7CwBYO+oC9
	qlvidOW5U80SUek7G9C/M9YTQgurFHQ5XgOxj1LQ1Fo5Q2cwSK/5EafNyIQpP59UONgvs2LqJvH
	CayUIAQCQU846kUjx6yCbWYQqkjIj26DUvDwjy1gf1qyK0aDMoRSQhfRKSSnNKYOPlxoAkJtFaP
	59QtDYdA2M7B2Y3X4rApMGPdc8GMVhcJtepx5QVzvxqJT8Kzx3kw27l4UhPJmQAaewzwVpi+bFh
	U2Qde5uh4WbHKKduT6wLD07Z7OrVAdTxAJVOV/DY5oM/SNJs6GNVE0ehj6w08Oy3tNxAhAD/Kv4
	xKXhEQgXq+3Y5Uwg12LFIqk4C5orY94J0AzhwT5q7zagRtRJ61Q==
X-Received: by 2002:a05:600c:1e24:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-482db44866fmr2367705e9.5.1769712423608;
        Thu, 29 Jan 2026 10:47:03 -0800 (PST)
X-Received: by 2002:a05:600c:1e24:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-482db44866fmr2367295e9.5.1769712423207;
        Thu, 29 Jan 2026 10:47:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-481a5e1842asm2907485e9.16.2026.01.29.10.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 10:47:02 -0800 (PST)
Message-ID: <27af79a8-ee84-4845-a737-82d3883536e7@redhat.com>
Date: Thu, 29 Jan 2026 19:47:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mgag200: sleep instead of busy wait for BMC
To: Jacob Keller <jacob.e.keller@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>
Cc: Pasi Vaananen <pvaanane@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260128-jk-mgag200-fix-bad-udelay-v1-1-db02e04c343d@intel.com>
 <338ff7cf-1c7d-48da-b1b8-37aac440fed0@suse.de>
 <88f33e4e-5d0e-4520-a399-5be2901a3281@intel.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <88f33e4e-5d0e-4520-a399-5be2901a3281@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212809-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jfalempe@redhat.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13548B3B32
X-Rspamd-Action: no action

On 29/01/2026 18:35, Jacob Keller wrote:
> On 1/29/2026 12:15 AM, Thomas Zimmermann wrote:
>>> diff --git a/drivers/gpu/drm/mgag200/mgag200_bmc.c b/drivers/gpu/drm/ 
>>> mgag200/mgag200_bmc.c
>>> index a689c71ff165..599b710bab9b 100644
>>> --- a/drivers/gpu/drm/mgag200/mgag200_bmc.c
>>> +++ b/drivers/gpu/drm/mgag200/mgag200_bmc.c
>>> @@ -1,6 +1,7 @@
>>>   // SPDX-License-Identifier: GPL-2.0-only
>>>   #include <linux/delay.h>
>>> +#include <linux/iopoll.h>
>>>   #include <drm/drm_atomic_helper.h>
>>>   #include <drm/drm_edid.h>
>>> @@ -12,7 +13,7 @@
>>>   void mgag200_bmc_stop_scanout(struct mga_device *mdev)
>>>   {
>>>       u8 tmp;
>>> -    int iter_max;
>>> +    int ret;
>>>       /*
>>>        * 1 - The first step is to inform the BMC of an upcoming mode
>>> @@ -44,28 +45,20 @@ void mgag200_bmc_stop_scanout(struct mga_device 
>>> *mdev)
>>>        * 3a- The third step is to verify if there is an active scan.
>>>        * We are waiting for a 0 on remhsyncsts <XSPAREREG<0>).
>>>        */
>>
>> Either these comments or the original test seems incorrect.
>>
>> The test below is supposed to detect whether the BMC is scanning out 
>> from the framebuffer. While it reads a horizontal scanline the bit 
>> should be 0. That's what the test is for, but it gets the condition 
>> wrong.
>>
>>> -    iter_max = 300;
>>> -    while (!(tmp & 0x1) && iter_max) {
>>> -        WREG8(DAC_INDEX, MGA1064_SPAREREG);
>>> -        tmp = RREG8(DAC_DATA);
>>> -        udelay(1000);
>>> -        iter_max--;
>>> -    }
>>> +    ret = read_poll_timeout(RREG_DAC, tmp, !(tmp & 0x1),
>>> +                1000, 300000, false,
>>> +                MGA1064_SPAREREG);
>>
>> The original while loop ran as long as "!(tmp & 0x1)".  And now the 
>> test stops if "!(tmp & 0x1)" AFAICT.  This (accidentally?) fixes the 
>> test and makes the comment correct.
>>
>>
>>> +    if (ret == -ETIMEDOUT)
>>> +        return;
>>>       /*
>>>        * 3b- This step occurs only if the remove is actually
>>
>> Since you're at it, maybe fix this comment to say
>>
>> '... only if the remote BMC is ...'
>>
>>>        * scanning. We are waiting for the end of the frame which is
>>>        * a 1 on remvsyncsts (XSPAREREG<1>)
>>>        */
>>> -    if (iter_max) {
>>> -        iter_max = 300;
>>> -        while ((tmp & 0x2) && iter_max) {
>>> -            WREG8(DAC_INDEX, MGA1064_SPAREREG);
>>> -            tmp = RREG8(DAC_DATA);
>>> -            udelay(1000);
>>> -            iter_max--;
>>> -        }
>>> -    }
>>> +    (void)read_poll_timeout(RREG_DAC, tmp, (tmp & 0x2),
>>> +                1000, 300000, false,
>>> +                MGA1064_SPAREREG);
>>
>> Again, the comment and original code disagree and the original test 
>> condition appears to be inverted. It whats to test of the BMC has 
>> finished scanning out the final frame. The bit should turn 1. Instead 
>> it tests if the bit is already 1, which is likely true. Hence that's 
>> probably where your 300 msec delays comes from.
>>
>> Best regards
>> Thomas
>>
> @Dave or @Jocelyn, any chance one of you could help me figure out 
> whether Thomas is correct here? It does seem likely that the conditions 
> were originally inverted and thus forcing a wait for 300msec every time 
> regardless. That does match my experience... But I don't have (and web 
> searches failed to find) any relevant datasheets...

I will give it a try tomorrow, on my test machine, and check what this 
register value is in this case.
Regarding documentation, I've only seen the original documentation for 
the Matrox AGP card from 1999, but I never seen one with the BMC registers.

 From what I understand this code is only there to wait enough time. As
mgag200_bmc_stop_scanout() is only called on hotplug, we could even 
replace that part with a msleep(300);

-- 

Jocelyn

> 
> I guess I can switch the conditions back such that we match the original 
> code and sleep.. but it does seem likely that we really don't need to 
> wait for the 300msec, but actually just that the scanout is done and the 
> conditions were wrong..
> 
> Obviously we need a v2 with either the conditions matched to the 
> original code or I'll need to re-write the commit message.
> 
> Thanks,
> Jake
> 


