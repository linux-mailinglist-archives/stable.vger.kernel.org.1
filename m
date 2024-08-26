Return-Path: <stable+bounces-70135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE36C95E9CB
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 08:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DA42810C4
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 06:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CCE945A;
	Mon, 26 Aug 2024 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBhFWRw1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FB52B9A1
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 06:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655564; cv=none; b=sPvcfFRFvd/0zZK5X9aMvYP5XouD88V7mDHvl2jBRKCZylQit2hbNSr27Z4x+TxhuXzzI8fsR7CKsoVj809CFCv2svX4jOVnqUnJaUAksuf2fMKQGex9nN9hhtw+4Aq99SEgthdDmO1TGrUgCbablcOzzvP+83EtF7CbcPysXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655564; c=relaxed/simple;
	bh=mJLirSJWzeg4h8aXB0WVH5kVs9qnKGSO8rbuVUCKC4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onJ14PkEOZVZqFiW8qqzVfGqeTnbBn76xy54nEKIR7o2FXwsLWxBVR6YVWsMgvvHqiU9g6lXOB2k5kgW9VG975F2M3WLsNYXPWBm9PCDyp7k2mPjePhCREvKU/sb8NsqOWXp0t/TjWQ33iPZe24E0+3VWDD7Dt+XsGf+A1tpWOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hBhFWRw1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42803adb420so4898875e9.2
        for <stable@vger.kernel.org>; Sun, 25 Aug 2024 23:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724655561; x=1725260361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXC8LPaGlFKAb1lVhb8Na89DQ1wSRPlOox9E5ezA6WU=;
        b=hBhFWRw1ux9w6LyayUEJAmOiYyAMnhdGPldSCQFh3ah+jvQo9OYEOwxlKYXUPtVkLj
         lfMj7VYHTgj9CHB6oSirlDfQXL0+xf+KD6JxURWojXDnCJhjFPDa5GY4HYcrI/gafBd7
         x7Hlj9HNQ2G2IEmvXeTA+jthMkR2xaGli8K6GkQsCE40MtsPytcJrE9zID1reys0J8nT
         pp59MdRjLRS7pj8+LicYTYHM9vQ9cIDE4xP7WACz8WEVVDofV1siulkRi4E6dBwOmiRU
         MMr/KJ7IIUrLFRcORkt4xjEXGb1xm+2jWzDeDepCgu0gq9m/5zf1lm20CaYdNFvnrxJt
         u0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724655561; x=1725260361;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXC8LPaGlFKAb1lVhb8Na89DQ1wSRPlOox9E5ezA6WU=;
        b=EWFif0Otve+n0thxRPTzG4QBSH+t6bnVsE14NiIsLWogRoIyAAnAUXqBTtKOYjjcFT
         MsqditmITrpgbDuQEzN3Su2UpJY6kPcyWBMB52dc+fdpYkrEzhFsZkyiE/w59GCq5VhR
         uBdBnh3b/3x4mjCbSd/HHQUcSFnZBpvrgmSZ3wNgbo22RPEBYMBcTbHfSGWu0kYij/S+
         NxVb0c2hOTZ+OFNv/Vyg77hkTof84HMjYillc1V2754eKWeXpBwBeY103DFUFvWn/R2e
         sknFa4LSN2qPFwXJnRWBdss6KehWTouA2LCjcn2FpCH+KyPO6cDj8em6+CPIMdxy/h5P
         vdGg==
X-Gm-Message-State: AOJu0YwlmIui//FJ+Q9A4OJ8KuhNThcNY46uTT39cFwjJqAJeyfP/HwL
	eMJ6dTagfemJB5kNyaw43txxcg27/jmae1V7UcCgLBZeebTrxgQdH45piVVDwfk=
X-Google-Smtp-Source: AGHT+IE+npQyzlIhtY9p1H5I6YfZb8gMIw1B9G+EDUhrVf2mwH77kiroEH+GVACuESM/uiF8DXQg+w==
X-Received: by 2002:a05:600c:3b8b:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-42acc8d50f1mr39288345e9.1.1724655560609;
        Sun, 25 Aug 2024 23:59:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac51860e8sm142360175e9.48.2024.08.25.23.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 23:59:20 -0700 (PDT)
Message-ID: <391cc2f7-4a88-4565-8653-e46bd77e28f8@linaro.org>
Date: Mon, 26 Aug 2024 08:59:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: at91sam9: fix OF node leak in probe() error path
To: Markus Elfring <Markus.Elfring@web.de>, linux-rtc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Arnd Bergmann <arnd@arndb.de>, Boris Brezillon <bbrezillon@kernel.org>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Johan Hovold <johan@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20240825183103.102904-1-krzysztof.kozlowski@linaro.org>
 <675f1e34-784f-44d2-9774-2652b919eecd@web.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <675f1e34-784f-44d2-9774-2652b919eecd@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/08/2024 21:35, Markus Elfring wrote:
>> Driver is leaking an OF node reference obtained from
>> of_parse_phandle_with_fixed_args().
> 
> Is there a need to improve such a change description another bit?
> 
> + Imperative mood

I have enough of your stupid emails.

Commit msg is fine.

> 
> + Tags like “Fixes” and “Cc”

Read the patch.

PLONK.

Best regards,
Krzysztof


