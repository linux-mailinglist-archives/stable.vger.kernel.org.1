Return-Path: <stable+bounces-211756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDocExCdeGlurQEAu9opvQ
	(envelope-from <stable+bounces-211756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 12:10:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E8693662
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 12:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40121302D0AB
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 11:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431E630B527;
	Tue, 27 Jan 2026 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPuCnQYO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF3830B53B
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512008; cv=none; b=ubly/huj7/zGWbDez+dQW1eSeffVzQJUstOViUst7rnmr4WUX8bXcJVuF38NrONMsi9Rcwkq+oAcTwfIG7ixHx82+mT9obTKOTUB00fdmxZJOSSWUjiHRdelFsotHHY9gNXb0/nvheNujRJeTY2AOxWJje1xNU9yCJtlakjKFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512008; c=relaxed/simple;
	bh=TKpr/sL01QV4MWic2GIiunVHM6RKFKhy1PpakKBSvHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDJUw3qy0DX0l85WiCYRUnipcv3Z3z9ClDCoRq4qSjccgLTBmiJIM2rkrZIHxbyHvroLlXiK892eq/z6Wb8TEM9NEF0KljegJUp/Mk0JSqIQ656GrNjz7g3sHLVWmG4gkTNtRjebD0A6Itfr80qrDAXckWsG7XGZDOHAI9yzyBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sPuCnQYO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so979506966b.2
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 03:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769512005; x=1770116805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OK79rAshTBf/lhnK/AaHjJiqei5HOsVGt3FVnyetfLg=;
        b=sPuCnQYOJ89lNDtAfy9jY/fZqBY/O8NNYfNH/GQhO7bg6h0k3EO69OzCaRPChxjV1N
         J8bMqhsFQftGPD1e0purUxzasELm7wmydM2BJkpJdY6JSk9tcLzHXDNB6Uw3Q9A8PEcr
         AqXOfqhyYLLrMmAbocTVtNV5gA6oxTPUElDYrcMsfHdqxU/A5b8WIKY79QKVd3jcqotV
         NfkP0LQccITwR+TTpt2gYV0TzN2fhtYkq4WL4RmdGYzX3xzksXYYvAmMM3JSLmZFJSCx
         yMjBRl4g741fl2k92fQQ6BFGcBfaXOXbmly9QOorZ87a1kbTJtMJNZZhYpjNK86E0Zwm
         94Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769512005; x=1770116805;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OK79rAshTBf/lhnK/AaHjJiqei5HOsVGt3FVnyetfLg=;
        b=Bl2Z40TxZLrNoqc7P/mPi7gQONRsUIVOHSgy1a3xdP98tWr8ae+pchLMnsbzSBt6KW
         SrZA+VO2c8OcMuzE1zRjkUKaDqv9oiDH4s8WatdxnRHf+Z6mqn4jpoC20AhUgUeSOrp2
         7Gao4ivjjOlHm9A5ItmDxxsdsFQvGf2sxH82WuPCrC4AWvBUEZRcJvA1FLj4YDPk9uVa
         +w8zyfTPEht+uy3718RQTBDAQFDsI+ZAT4lBB8SrBP+i2H63nrDYBpl+d5sMu9kqjkzU
         JLuIqEKG6SikAPzWR7fQRRV5+dWXczo1vDdwMCCVsBpB4Yr2W6EW5rHvoHBUkA5QDLUF
         EPOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh9xspFw1bCP7+Y04TKPMU8zbtPPPHnEwkSblkX6oRPh728XhFoQeglEQUsILlk1LWe+P8GqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQIsFMCLvcTVaQUgTy9T586mCFAlpCQlQ4dvQooMl1Bw28suU
	TMQlGzjlDRSZXvDJVRjFEzZEJV+k+WS/HbevcoOZTipWY8+tuH6cUL7U0IBLtPh3tHk=
X-Gm-Gg: AZuq6aKfjvsstKVr6eSwxS355hE7b7XzORi6lF+L7EbmAYaGr7rn5aIeAItGWAIsnIq
	xYib3nq7nOypsE51sph+HVQV/mt+DtowUHpXeZ9oBgE90A+DlKtw9GpwoMnMfaxtpwLuUYF0mlE
	yPE2XjY0B/qti3BYEhKHRfvYLcHRuvoixTtnsD/aOTUP7Met9IuL03CfVSgaecOUDinVR2qD77c
	BBcdWUr466yELR3JSLcoWEzfRQthq4+iaghye2lRIiVyeNCP7P8WWoUzSklbeBmryM7ixpYmNGp
	lImWbg3oMGJUUHiIIVYhd9slJdU6ah2Xoe2Reyfs0FY5+gx+8N8HdgPnbIswftHC91FLor4rJ5V
	8e/TGS4cdFW1S0d1KjY8a8C8TkkmFV2X5au3xv/t0spdj2Srt3k06ZEplEBYgOFNjcchv7Q2B02
	pC3ujr81eGwriN9BkWOLx1mr+Gb01uNm4qGymsXsVP+XBV7D2XRiut
X-Received: by 2002:a17:907:72ca:b0:b86:f558:ecad with SMTP id a640c23a62f3a-b8dab10d265mr117226666b.7.1769512004630;
        Tue, 27 Jan 2026 03:06:44 -0800 (PST)
Received: from [192.168.0.40] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b4160f4sm786300466b.17.2026.01.27.03.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 03:06:44 -0800 (PST)
Message-ID: <571cd869-847f-4697-ace3-503f123e8486@linaro.org>
Date: Tue, 27 Jan 2026 11:06:42 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] media: i2c: ov02c10: Use runtime PM autosuspend to
 avoid brownouts
To: Saikiran B <bjsaikiran@gmail.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 rfoss@kernel.org, todor.too@gmail.com, Bryan O'Donoghue <bod@kernel.org>,
 vladimir.zapolskiy@linaro.org, Hans de Goede <hansg@kernel.org>,
 sakari.ailus@linux.intel.com, mchehab@kernel.org, stable@vger.kernel.org
References: <20260126173444.10228-1-bjsaikiran@gmail.com>
 <20260126173444.10228-4-bjsaikiran@gmail.com>
 <900cc5dd-c39d-42f6-9531-016f62da81e8@linaro.org>
 <CAAFDt1tsyvtAa84bFK2Hq5yG_F15SUUseBd5Xi-DB8GnUj7+7A@mail.gmail.com>
 <aaab1d32-9375-47d2-8524-e80e076b864e@linaro.org>
 <CAAFDt1vKn5ssoTQZduGKb5eOeN74P=FVk9f01go1d-JS71Zt0A@mail.gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <CAAFDt1vKn5ssoTQZduGKb5eOeN74P=FVk9f01go1d-JS71Zt0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linaro.org,linux.intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211756-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryan.odonoghue@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Queue-Id: C2E8693662
X-Rspamd-Action: no action

On 27/01/2026 10:56, Saikiran B wrote:
> Hi Bryan,
> 
> I understand your suspicion regarding the LDO behavior, but I lack the
> hardware documentation (PMIC register maps) and tooling to interrogate
> the SPMI registers to the depth you are requesting.
> 

So, SPMI is not exported in /sys/kernel/debug/regmap - however

drivers/regulator/qcom-rpmh-regulator.c

Lets add this to probe

unsigned int val, i;
     u16 bases[] = {0x4000, 0x4300, 0x4600}; // LDO1, LDO4, LDO7
     const char *names[] = {"LDO1(1.2V)", "LDO4(1.8V)", "LDO7(2.8V)"};
     struct regmap *p_regmap = dev_get_regmap(dev->parent, NULL);

     if (p_regmap) {
         pr_info("--- OV02C10 PMIC RAIL DUMP START ---\n");
         for (i = 0; i < 3; i++) {
             // Check Config (Active Discharge)
             regmap_read(p_regmap, bases[i] + 0x41, &val);
             pr_info("!!! %s SEC_CTRL (0x%04x) = 0x%02x (Bit7: Active 
Discharge)\n",
                     names[i], bases[i] + 0x41, val);

             // Check Status (Is it actually on?)
             regmap_read(p_regmap, bases[i] + 0x08, &val);
             pr_info("!!! %s STATUS   (0x%04x) = 0x%02x (Bit7: VREG_OK, 
Bit0: VREG_ON)\n",
                     names[i], bases[i] + 0x08, val);

             // Check Pull-down config (Secondary check)
             regmap_read(p_regmap, bases[i] + 0x42, &val);
             pr_info("!!! %s PD_CTRL   (0x%04x) = 0x%02x\n",
                     names[i], bases[i] + 0x42, val);
         }
         pr_info("--- OV02C10 PMIC RAIL DUMP END ---\n");
     }

>  From my end, the empirical reality on my machine is that the sensor 
> fails if power-cycled
> faster than 2.3s, and enforcing that delay (via software or regulator core)
> fixes the issue reliably.
> 
> Since we cannot agree on the root cause and I cannot perform the hardware
> debugging required, I will stop submitting patches for this issue.
> I'll maintain the regulator workaround in my local tree.
> 
> I kindly thank you and Hans for your time reviewing the previous versions.
> 
> Thanks & Regards,
> Saikiran
> 
> On Tue, 27 Jan 2026, 16:21 Bryan O'Donoghue, <bryan.odonoghue@linaro.org 
> <mailto:bryan.odonoghue@linaro.org>> wrote:
> 
>     On 27/01/2026 10:40, Saikiran B wrote:
>      > Hi Bryan,
>      >
>      > Regarding the 1.1s race condition:
>      >
>      > I have implemented support for the generic regulator-off-on-delay-us
>      > property
>      > in the qcom-rpmh-regulator driver and set the constraint to 2.3s
>     in the
>      > device tree for the Yoga Slim 7x.
> 
>     Yes but please listen to me. That is an extraordinary delay being
>     introduced.
> 
>     It is indicative of a serious problem we have not root caused. These
>     LDOs are used in mobile phones which are aggressively designed to save
>     power all the time.
> 
>     In fact the whole idea of voting for clocks and bandwidth is it
>     mitigate
>     the default assumption in these class of devices - switch off the power
>     first.
> 
>     What is that 2.3 seconds, why is it needed. "Brownout" but why ? I
>     don't
>     think we have really established.
> 
>      > I tested the 1.1s scenario you mentioned, and it is working fine.
>     The
>      > regulator
>      > core now correctly blocks the enable call until the physical
>     discharge delay
>      > has passed, preventing the brownout without needing logic in the
>     camera
>      > driver.
> 
>     The physical discharge delay we have _not_ established IMO. Have you
>     checked the CCI pins ?
> 
>     I think we should stop pushing patches until a root-cause has been
>     identified.
> 
>     For example - we can interrogate the LDO settings via SPMI registers to
>     see if the LDO is really switched off.
> 
>     Similarly we can interrogate the LDOs to see if they are set for active
>     discharge.
> 
>     A fix might be to make a platform driver to set those bits for the
>     relevant LDOs absent a firmware fix for the same.
> 
>     I'm not comfortable pushing changes predicated on papering over an
>     issue
>     that hasn't been root-caused.
> 
>      >
>      > I am going to drop the Autosuspend patch entirely and verify the
>     clean
>      > driver one last time.
>      >
>      > Plan for v4:
>      > 1. Submit the Regulator/DT fixes separately to linux-arm-msm.
>      > 2. Submit v4 of this series containing only the cleanup and power-
>      > sequence fixes.
>      >
>      > Thanks for pushing for the correct fix, the regulator approach is
>     indeed
>      > much cleaner.
>      >
>      > Thanks & Regards,
>      > Saikiran
>      >
>      >
>      > On Tue, 27 Jan 2026, 15:16 Bryan O'Donoghue,
>     <bryan.odonoghue@linaro.org <mailto:bryan.odonoghue@linaro.org>
>      > <mailto:bryan.odonoghue@linaro.org
>     <mailto:bryan.odonoghue@linaro.org>>> wrote:
>      >
>      >     On 26/01/2026 17:34, Saikiran wrote:
>      >      > On Qualcomm X1E80100 platforms, the OV02C10 sensor experiences
>      >     brownouts
>      >      > if power-cycled too quickly (< 2.3s) due to slow passive
>     discharge of
>      >      > regulator rails.
>      >      >
>      >      > Implement Runtime PM Autosuspend with a delay of 1000ms. This
>      >     keeps the
>      >      > regulators enabled for a short duration after the device
>     is closed,
>      >      > preventing costly power-off/power-on cycles during rapid user
>      >      > interactions (e.g., browser permission checks).
>      >
>      >     But if you try to power the sensor 1.1 seconds later what
>     happens ?
>      >
>      >     With this commit log this submission is a NAK, for example
>     why do I
>      >     want
>      >     this change on an x86 machine ?
>      >
>      >     We need to root-cause the failure not paper over it.
>      >
>      >     ---
>      >     bod
>      >
> 


