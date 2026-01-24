Return-Path: <stable+bounces-211452-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOpuDvyddGkw8AAAu9opvQ
	(envelope-from <stable+bounces-211452-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 11:25:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA987D3D1
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 11:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C888F300B458
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 10:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB0E1DF25C;
	Sat, 24 Jan 2026 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Lx3ieygl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3821220B80B
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769250278; cv=none; b=b8adZP36/ag/t3RV2NrmoxoobS83kqaNRRFsDQ/RyTzhx6BR8OSjGcdxzLc6VV7Y5XLxW5iJZ5IZo4gXz8goUZYJrzsASeYV+45KD7pdIwGOg4lxL3nTdlYhp5Lz03LIbD7fp/qiJrkgy7TJewx53b0Rm2H7D9pOLsoBnjnVhWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769250278; c=relaxed/simple;
	bh=SsIOscoc4kxZ0+X5vINR23gFekLWS36exm5VqIWN7ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D31jsPs2Gssq86gVjObheQtlM5GOXDCescfjiM9OCSb49/cVrrUImx6C0xqDCwQB9D9YI/ppundsUBqa0FRHfokj0DOfYg779zPwKX7jfR4pA6mzlJPe//xq9+ceBAUj57WqQWCJLkLdbKTEurlmyTjxMFfjG92UHyb1AsSnYr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Lx3ieygl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee974e230so26512805e9.2
        for <stable@vger.kernel.org>; Sat, 24 Jan 2026 02:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1769250275; x=1769855075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6KeuWtNDinjaFnZinUuAvPa1zdf4IDBNYyQ0smSyMs=;
        b=Lx3ieygl3ijotffRo1OJkk/3ZfMlNYxbrpJN4NEKR1Clb0Jqb7ZR5GMHZkmtxJEIFn
         tbNcfpcg0lioh7LlFc+4yDp9+3DpJVcplgZseMjABHStumeRqAn6pceuAGymEK9bCtCj
         z/0B2YGBZMs+52RPtuW+WMiQ0D/cEQgRY8laprvSTrC3R/7hmr63cAhyr5YUQo5W9bOe
         P8lHsTFbIqobYE/FIFWDWFD3uzqEHuLggqSi05rCtN8spwD2FJtxykHAiwx147mgdqcJ
         W2g689wH8t5FAnKVSDV3Uso5GBbBz62GGnckPlnhPnP7EjWJ3u06VxaOdjYFWLOVQ1Na
         LvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769250275; x=1769855075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6KeuWtNDinjaFnZinUuAvPa1zdf4IDBNYyQ0smSyMs=;
        b=fKidMZ2m+oiyXkZREPB+2RZJKX6zfLtSoqTtISNy5W0DLPFnQD1MQRxK+BAYTfIbNC
         kQYN7ztUE68Cg5aHluKzXGADi3+vjvaxaWV4VXeBvmHmAkytqqRv8/Lw3MPyOYr+y+Fj
         y8R5gUk/ffVPVvqhp2447fsiJqqDsfsaBDfruOSgBw8vVXu5CFVIjjAfj/RbP/t1NvmJ
         bMp07yog33eMtL/P1K+dnMZNmSwlxpqXrkhp0thkpEjPzio7Pjc0/ZsgmFDI6D6GLHc9
         0phHWH/V7ahmUXvZsQos5+5EMKcbEtv9GKGk7bGmZCvqf098sadY/DoakAAzb3szJUHo
         pFKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRUvK6uuVhczpf/uTQNMcNQrr23X+3Wp1ikdAK9XSspY8xSH/3Yqqr1IXLVnWJ3S3301nhzeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxVWssSHzmDLxhXVvgrf5B8o7hT5Xrlm9PTZMyc8oco7YEcPjX
	YBBr9WeEz72MP7gi6hjlQzNlTWlMknifyy6HH8zq6obZJgILIoywKabE719fQP/YTk8=
X-Gm-Gg: AZuq6aLS0ltP/UB/YzQj4GJOk5RZLXh4JHY81TdGc1cywh8pEdugrSqY5g/S0Gm0oVn
	g4HB9Z40OIMjafZ8NMN7yo21eXzw1MA5EsmUeOwME0gcFNFOGqlAm6yP1v95S/QNJ3qzAKPkOJC
	3b+lfYFqjBu8xe5Uh65ina9x7kykm+w8K216gtl1WAwrlEfpSU0YPRIMLt3MMG419m7bdiwM0Dj
	z9hVVplF1SkXWCiLFSC9MLMEucc9ck6AK8O1Wica3h9S2KAruJj4kCTPMaLmUd3A+XsD4Uv4j1g
	fZ2rWRDLDNb8f2kHSKes/ZWvDMzd3qPGLRHHcD59ZKomp8B/Oi0TTHj9LARSRE5nRC+hP0epWit
	nUNP1uyctofKYimVl9U7QHg/p6knqkz4bys9zjc2NXEEs9sI80YYohfc56MbbAVL+Yurm6/ra0M
	b9nFQvS2PqhCoZ7FYz7sKTN/uw5DxsaUrg/Z1igbHrvMoJQeGbMXwwqVNiF6VavzV7F6JYFZ3xJ
	2ST6d9byHsXd6K7k8tmXFid5i1J8/ib8l3IiSohuA==
X-Received: by 2002:a05:600c:5308:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-4804c9b834amr88128575e9.32.1769250275201;
        Sat, 24 Jan 2026 02:24:35 -0800 (PST)
Received: from [192.168.3.32] (cpe-109-60-82-187.zg3.cable.xnet.hr. [109.60.82.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02cd8sm12647198f8f.8.2026.01.24.02.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 02:24:34 -0800 (PST)
Message-ID: <55f7c157-c624-4b1f-ac07-f70aa3668b34@sartura.hr>
Date: Sat, 24 Jan 2026 11:24:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] i2c: pxa: fix I2C communication on Armada 3700
To: Gabor Juhos <j4g8y7@gmail.com>, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Hanna Hawa <hhhawa@amazon.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Imre Kaloz <kaloz@openwrt.org>
References: <20250827-i2c-pxa-fix-i2c-communication-v3-0-052c9b1966a2@gmail.com>
Content-Language: en-US
From: Robert Marko <robert.marko@sartura.hr>
In-Reply-To: <20250827-i2c-pxa-fix-i2c-communication-v3-0-052c9b1966a2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sartura.hr,reject];
	R_DKIM_ALLOW(-0.20)[sartura.hr:s=sartura];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211452-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,sang-engineering.com,linux.intel.com,armlinux.org.uk,lunn.ch,amazon.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sartura.hr:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.marko@sartura.hr,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sartura.hr:mid,sartura.hr:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FA987D3D1
X-Rspamd-Action: no action


On 8/27/25 19:13, Gabor Juhos wrote:
> There is a long standing bug which causes I2C communication not to
> work on the Armada 3700 based boards. The first patch in the series
> fixes that regression. The second patch improves recovery to make it
> more robust which helps to avoid communication problems with certain
> SFP modules.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Hi, I see the series have not been merged so far.
Without it, I2C is completely broken on Armada 3720 if I2C recovery is 
used, and
without I2C recovery, certain SFP modules will also cause the bus to hang.

Regards,
Robert

> Changes in v3:
>    - rebase on tip of i2c/for-current
>    - remove Imre's tag from the cover letter, and replace his SoB tag to
>      Reviewed-by in the individual patches
>    - rework the second patch so it does not need changes in the I2C core code,
>      and drop the first one as it is not needed now
>    - Link to v2: https://lore.kernel.org/r/20250811-i2c-pxa-fix-i2c-communication-v2-0-ca42ea818dc9@gmail.com
>
> Changes in v2:
>    - collect offered tags
>    - rebase and retest on tip of i2c/for-current
>    - Link to v1: https://lore.kernel.org/r/20250511-i2c-pxa-fix-i2c-communication-v1-0-e9097d09a015@gmail.com
>
> ---
> Gabor Juhos (2):
>        i2c: pxa: defer reset on Armada 3700 when recovery is used
>        i2c: pxa: handle 'Early Bus Busy' condition on Armada 3700
>
>   drivers/i2c/busses/i2c-pxa.c | 35 ++++++++++++++++++++++++++++-------
>   1 file changed, 28 insertions(+), 7 deletions(-)
> ---
> base-commit: 3dd22078026c7cad4d4a3f32c5dc5452c7180de8
> change-id: 20250510-i2c-pxa-fix-i2c-communication-3e6de1e3d0c6
>
> Best regards,

