Return-Path: <stable+bounces-227152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHdtFyUJu2nEeQIAu9opvQ
	(envelope-from <stable+bounces-227152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:20:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD1D2C26FA
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 21:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3996303B4F9
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ADC36C59E;
	Wed, 18 Mar 2026 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaWt2gnC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF848254B18
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773865240; cv=none; b=LQf4ZVNsuPaQWzcEtR/GzenoK/Orw/ADPloL5vZTvgRD4yYC0yhLoJT1hYFF+06iUE8EB1398UlWlNIJnze99Fnn6y9JPprS6k3+TAdUcDPgQGe78GUAuZsXsrY1euegnLsAHdTVsjHn+8LWAMOU+1d8wWlCqA78gFOwu9hoYDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773865240; c=relaxed/simple;
	bh=p12yy0f4g8Mtf3zJ6FM5DG5zprWTPjAYHz209DX9/T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNBA6iXU3RKwCLrce87p54NvzFZfbppdQmohMDN1hODVpvPMLvoQAIYzKglqcYdfqqh7NS1VUUvmjkJ9yuwCYv0VS4/4UwL/OZK+4QL+3Am9PqOY37nW/eBF+bJvTP8aqcbqmPUR++OTMkvncspgWq1O5pi1NLZjwPmPV2Wl9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaWt2gnC; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35a04d6aeb0so246849a91.0
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773865239; x=1774470039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CW70/xxfLi68rSnAskwg4XChX2bmrTWuZZHh8hh8PjU=;
        b=UaWt2gnC7TPLYUl0FW1H5OJEG7i8VlGyA1/5F6rBF5sGANNRNOxyDJYaUEIIkuwtor
         g1ku27h8zdkiDQyzOXUyQWie+e2faBJQkP5cAk9qFDOqM7W22srxGt6egGiGy7h2aSkc
         urSArp/3fxK+jfcvyyq9P2/R2TUkodiW0IhfaTEhASNnnlRsEZvibkkwr/kBJZs88SVF
         mGco/wlY07V/uV7kDtqIBwt10Vf6mOc5yMjTF2GsYN7VRc0sfeJ+C3jgPr8Nink7VVQ4
         uHPC7YPDzmNMB99OnObhhdu5WPFv9iEuf9NZ9Se7AIpn9qsZieU1GM5Pf853e/uoU9Wt
         mpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773865239; x=1774470039;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CW70/xxfLi68rSnAskwg4XChX2bmrTWuZZHh8hh8PjU=;
        b=pRvDljCCmfrQkYDqca8n3bZcZEXIwX6fviUVp+R/CFDI3hRGRP9U42R8wvdklGjtbk
         deL+ZAxxYvaipYMS1K/Uj6sCpaQZtsLDeJkLCuGBiCdHcAHgnTPagsjqryBgyZyiSFAs
         9symU3CRFPRaaa2GuB1eUO5GjY63BHQ7C9sIwTX3pTYa6cYF8430ul9K9gnmVzYzFf0R
         RKyMksd8eBSNt+pTm8c4/jjPHEqVTyDriIF1Z2jHHVwxj7D0l++XCn+jFjPV6LB67GZg
         7D4soAQTfzj3xFzi2RIyTzUQ7JbxRu6RtC/P1UsX47rd0H5Y59OxJ82bcIaAnHmUq8eR
         5clw==
X-Forwarded-Encrypted: i=1; AJvYcCUBTQmY4Bb0DYU4z8jkkRZYawny+O8cChplZAiAw2RgYhJHzq6N1wC+35eapRGc91KU8eALu6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlSDkYEujJ/bSdhSHpSn+bz39HAzh+h0czfL/ACxG6TEaTQvm3
	MVTXhOHtUyW6bEpCKLa7Ie8y2dKh3EDVYsQQVhGYTJIXegx1stPUf9O0aZojfA==
X-Gm-Gg: ATEYQzwJpac3efPRXq/aZnhH/DBcQ4cu1Bh/gCHAJ4YDGhP/Ig57kQwRXfDmeKfx+bb
	yJ8Dlcmg+g8W9jSAyLEera3OIX9XnxPwoJnprRV+TtseD2uycXCOIyCJcQRqY4SLnw6yyPj17If
	8z7vZ+/HCAz3ZHrjvoWvtRJ0H5QydLwt4xBZrKWm7KwvJ2Bn1zJyi8QYS19F3orW2Egzx0w0uyw
	aRmzE41cM0cfnx/YOds2GDxzBVxB+bqTkEZqAAdx847sclVZsLkhiKVey0zsoaAPHJ77uUGOH/6
	dn+IAwM/x4G9fRJtgiENeiKD9Zk7CnNT09NJRMeYDs2kbHhDcHMPFxSz16QHkSbPgLoujJPXjdN
	aK+aQlJyBI9HZk+J6D32IuVYwg+0Llb7mten8H2JSG7t7RY3mBFt42LNSB7jppJY/msO+yr+l9+
	cTXm1mbgQxpkcRVNHCXZSRZwSpQtXe3/RzwjsvyqwjIBw9y80BrAwzP02y3Sl+t+G2shJtp/AG
X-Received: by 2002:a17:90b:35cb:b0:35b:a44f:b82 with SMTP id 98e67ed59e1d1-35bb9e51084mr4491544a91.11.1773865239052;
        Wed, 18 Mar 2026 13:20:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bbae5e139sm1127992a91.8.2026.03.18.13.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 13:20:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a3f02648-9e6c-4a14-922f-13fb27f87354@roeck-us.net>
Date: Wed, 18 Mar 2026 13:20:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: (pmbus/ina233) Handle sign extension for
 negative shunt voltage
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sanman Pradhan <psanman@juniper.net>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260318193952.47908-1-sanman.pradhan@hpe.com>
 <20260318193952.47908-3-sanman.pradhan@hpe.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260318193952.47908-3-sanman.pradhan@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227152-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:mid]
X-Rspamd-Queue-Id: BCD1D2C26FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/18/26 12:40, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> ina233_read_word_data() reads MFR_READ_VSHUNT, which is a 16-bit
> two's complement value. Because pmbus_read_word_data() returns an
> integer, negative voltages (values > 32767) are currently treated as
> large positive values, leading to incorrect scaling in DIV_ROUND_CLOSEST().
> 
> Add a cast to (s16) to ensure negative shunt voltages are correctly
> sign-extended before the scaling calculation is performed.
> 
> Fixes: b64b6cb163f16 ("hwmon: Add driver for TI INA233 Current and Power Monitor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>
> ---
> v2:
>    - Added (s16) cast to fix sign-extension for negative shunt voltages,
>      complementing the error check fix applied in v1
> ---
>   drivers/hwmon/pmbus/ina233.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/ina233.c b/drivers/hwmon/pmbus/ina233.c
> index dde1e16783943..819f4e8aeab61 100644
> --- a/drivers/hwmon/pmbus/ina233.c
> +++ b/drivers/hwmon/pmbus/ina233.c
> @@ -70,7 +70,7 @@ static int ina233_read_word_data(struct i2c_client *client, int page,
>   
>   		/* Adjust returned value to match VIN coefficients */
>   		/* VIN: 1.25 mV VSHUNT: 2.5 uV LSB */
> -		ret = DIV_ROUND_CLOSEST(ret * 25, 12500);
> +		ret = DIV_ROUND_CLOSEST((s16)ret * 25, 12500);

This may end up reporting a negative error value to the caller.
Should the result be masked against 0xffff ?

Thanks,
Guenter


