Return-Path: <stable+bounces-256621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJS7JLaIGWr4xQgAu9opvQ
	(envelope-from <stable+bounces-256621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:38:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E52602583
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F4BB301874D
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D303D7A03;
	Fri, 29 May 2026 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtXw/yL0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDAE3176EF
	for <stable@vger.kernel.org>; Fri, 29 May 2026 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058238; cv=none; b=BarNGtkDDJO3IjSmYnBfTYaMnCVlGgvDmuXP6Pe9W/hxDTESzCSSnsdADHzQFeE39L7nXtopWBVvKDgP2dSH/daENULF3qbB6n9dgq5V+Jo3a9dLFR86wUUPjMIZ+Hho9Udri9V+4vFCOe/gD8v8lw/ksiGA3JF3Z+mHNQADsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058238; c=relaxed/simple;
	bh=DojchXGz/KKYSE94iO1v9P4Lxh1mNKs7SpCF/Nl2JGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSnpvxtzYwZi/bo1w81z5+Aoy2mnsdedx6CeOax/WMMhKdKKmAN2/XTUaMiHnEyWw4uDmnaSYBucDPbMg92fByMXKmUoy2tb3TFLEWL4pu4jKorxjHITLbDHFVwykEPc+o9zDCCnFsPJ/ntVVvcwwRApYiirB9VJ1upZzkp+obI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xtXw/yL0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45eea4c0649so1414971f8f.0
        for <stable@vger.kernel.org>; Fri, 29 May 2026 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780058235; x=1780663035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQzxiBtnUr7ain8V9TqP5xGod1EBAScgia3DVab5ruI=;
        b=xtXw/yL0BJXLsXKDdDDkxRhQ7QSaPmFGBsCrTsSiCRbednhJqwwGJgy/1GbtEcR4EQ
         OsH4xv5X1qWVmtO6zsGi9cUoXZU9NyLEwAt7WCyr+eHbgs+XGNVVpwmJn/Y3X+XcIKgU
         ZGvxDYIhwQYzPokgGdgjsnHC8UB8tl/zG8tXBkErZxEg4+gjiMHlpYjaZfHbng/W+ES5
         +scVzVyGqVAJmWtoQ4pVVw5svdbx6KptkIRyNBP7VLHaH1VMdzcH7MNd5KqjV6aajmR7
         Xq9JNPLhwwnZE0kQMjY1+TT2jNKBBmscqEU0kwr6o7B9hEpBnnxmPFa7w1QshW93Ljbu
         1Gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780058235; x=1780663035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQzxiBtnUr7ain8V9TqP5xGod1EBAScgia3DVab5ruI=;
        b=ZGQ3d3GHOY+qnXtf0Z3bHYUD0cp3trisBVAgCV+cxPFDcMEInj3S6MQcr5HzNacWR9
         ijspuD4TVxweti6s9ma0Zv5HcTD9y8QlWwEQr9PEq+kTDyqLgKC+WH/xCTvk7qh3GGec
         OAqFRDX+uT6rPe6fAShQgyoPxSs7gGWLs30G4l1ZjZ5UcDv2u/vJCLGLsp76KrSXgob/
         r2OTfzX+rvJV+awDeVJoD4DW6+ykJMmLVJZaqeiLHtPbMw9WMjT3nVKTK7CKHXjCIhAc
         wl0tVu4pjtQCVAPygPQeNGbhvKXFlhONDZCc6rakJqwKYXKMXi/cbhbd5BPU4OxrnPJm
         vS4g==
X-Forwarded-Encrypted: i=1; AFNElJ8te6Nb51/fCQWWD4XWOudxyrhYnYSTlgptY4VJpenSQ0BnipL7bqc5z4OB9I1ahWpNnkgj9NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Qhxg9Ji7znSfFD+8i5uE+gJp/rkEOSytSB4MeRV+ZVPmNPcy
	p/cDK9CukxglF4ueoybffWYW8LawmK3OQCnqTQoMimZwwonyb5DFkLmDTEODkzCREes=
X-Gm-Gg: Acq92OHdvgRirPJF4zxEnhtFb0t5LsrL+jcmnkGOd6WEFfdQ8Y4dzYcldU7+NFLCUDe
	5LeG/blRktnC2YBWLXEBbikXKVw6mMWTKKVlWSGIXCfNF1FHT+t5xJ8tVWwTDDHiFm5nrkn1xnf
	u8zzb3TFvwG4nAYeu5MDNG+SEZjUfeAF2gR3QM6FgCI7LwHm+9I5nJ5RDMTFHGAJ8QPAd6w4OEQ
	oEp+I12U60t96fp/jZzFMfok27lq4Hcp73Try/ldqQFuIjpS0NAaO4tY6K3jSruJVo3Be3Q4JG6
	M6w8Ur0CSu4woi2Vbp33RLwkEsEBPez03L1OhQfIwrbsxH79Fz2TAPp2gdNXfsW/XxXyzb6rTMq
	GfSzlvp+9gS+VLu7zSOPBHL0LOtFb1zjuLI4yUuxBPs+yQW0OeIHD1asZau6M+fmz/ApUUzc55K
	XKG1fSOXMeK1QRdFIeYTrADq4+r16+BKNPFthUHByjJA==
X-Received: by 2002:a05:6000:470c:b0:45e:f2bd:2b16 with SMTP id ffacd0b85a97d-45ef2bd2d41mr3802790f8f.18.1780058235304;
        Fri, 29 May 2026 05:37:15 -0700 (PDT)
Received: from [10.11.12.110] ([82.76.215.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a0374sm2981872f8f.2.2026.05.29.05.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 05:37:14 -0700 (PDT)
Message-ID: <a7994860-24a3-4f87-84bf-109ed653dda4@linaro.org>
Date: Fri, 29 May 2026 15:37:13 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] firmware: samsung: acpm: Fix dummy stubs to return
 ERR_PTR
To: Krzysztof Kozlowski <krzk@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 jyescas@google.com, kernel-team@android.com, stable@vger.kernel.org
References: <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
 <20260505-acpm-fixes-sashiko-reports-v5-3-43b5ee7f1674@linaro.org>
 <03dc9ccc-d819-413e-b8fd-23ccd85675ba@app.fastmail.com>
 <6c77d706-5944-4e7d-8a4a-b3a6cac6a83b@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <6c77d706-5944-4e7d-8a4a-b3a6cac6a83b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256621-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arndb.de:email,linaro.org:email,linaro.org:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: 10E52602583
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/29/26 3:09 PM, Krzysztof Kozlowski wrote:
> On 29/05/2026 13:51, Arnd Bergmann wrote:
>> On Tue, May 5, 2026, at 15:13, Tudor Ambarus wrote:
>>> Sashiko identified a potential NULL pointer dereference [1].
>>>
>>> The dummy stub implementation for devm_acpm_get_by_node() returns NULL
>>> when CONFIG_EXYNOS_ACPM_PROTOCOL is disabled.
>>
>> I meant to comment on this yesterday as well.
>>
>> Having stub functions like this return NULL is a common way to
>> define optional interfaces, where callers still work when the
>> feature is disabled, though this clearly does not work for
>> acpm because some callers have a NULL pointer dereference
>> when compile testing.
>>
>> My preferred solution to this type of problem would be to
>> just remove the stub helpers and drop the ||COMPILE_TEST
>> from the one user that calls them, see below.
>>
>> The point here is that CONFIG_EXYNOS_ACPM_PROTOCOL already
>> supports compile-testing itself, and all (both) drivers using
>> it clearly require the support, so this just simplifies

I confirm that the ACPM protocol is mandatory for the clients to
work, thanks!

>> the option space without losing any build coverage.

nice, I didn't know this. I guess it's a "greedy" algorithm in
allmodconfig, if the dependency is met the dependents are enabled too.

>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>
> 
> Sure, I am fine with it. I'll take your patch with a bit adjusted commit
> msg.
> 

Thank you! I need to drop the devm_acpm_get_by_phandle dummy stub from:
https://lore.kernel.org/linux-samsung-soc/a59c6e3a-6092-4114-8961-c2a71a812959@kernel.org/T/#m0ac077507129c37b84443513eecadd70b5eaf8b8

Shall I send again the entire set?

Cheers,
ta

