Return-Path: <stable+bounces-27451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F074B87931F
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 12:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801FB2831BB
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 11:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF16579B84;
	Tue, 12 Mar 2024 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZC0yDgLv"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE179B8A
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710243424; cv=none; b=L03eB+lNyGwAZCGA0Hbx+pdtXLWlOZpq1Y3o+G3yAzDI13AwWByKtYV8b5hvqX3Xvol/9c3TifM+gFU1BVUDHZU5phcfXvLeTI/AkFZMRruoWuTdiD7kcZM2n4dAbh9x+B1joTYGj99BRCHPV1jhLL/ZCIOaHXNd3Lc3Pqdwm7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710243424; c=relaxed/simple;
	bh=wLuEOn4MRfEXLqMKokUO6LrKjIHhAUNLDf14/x5iGUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUMeE1zFTXbq1SoSceLeNvLgiyko7VlEzsG64Sel/c39XB2duuYSXZqM/ZR+NmOZvmSijy+Ea0kYxv9ZfWPdIqPUkpqa/LAeoN6AGJAHtzggNcQMPkXH4KcNLA5BfN9PHEqjemyCUshJhlVmDa8zkqJuN04w6mRWU5A6K3ntCRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZC0yDgLv; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51320ca689aso4580030e87.2
        for <stable@vger.kernel.org>; Tue, 12 Mar 2024 04:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710243421; x=1710848221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16Pvmwv0MWEhVvp6t6zzlci2YOqrb9UlyBWbPUe9jNQ=;
        b=ZC0yDgLve/iqSgGi9eamdyWszNca96BUTyfr4nK2COkj+yifbIQWiqxsPn2pzPNq3b
         RU2fp74PTmZ+xxDu9r5WscKnyWkmxSTzoj+r0jfcI0qiWDU7zqOoEGOCovETsptrxVFa
         gfqXacVGwrbuFR10ELIbDIcOKuk5v4BKBEqEJW7GCMHcoYz/u5M1tXalS501I9ZKvhli
         ReLK7T9LxHsN3dWY/U/GWFT2pCLCSte15N+ZH4bvMni9qHNUZmAgDC8+znT8T+W5osvi
         j0KaF7P0BnB8OpbgjMleSC0KUwMTX4lkjO/fyG7SaC4Na+gzk/nXq+4C3gwpRS7cqwkp
         OkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710243421; x=1710848221;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16Pvmwv0MWEhVvp6t6zzlci2YOqrb9UlyBWbPUe9jNQ=;
        b=VHGioIM45uTJrOdggk4VFurAnG8J6zhONp8FOXOy5uLtwr7IZDhtu8BcBBi4LdayCO
         WV0t25n7PNcxBULAAAIppIe0mcZwp9QegQoXDEkgfrv03eo3EAapU6Caz5qU28JXHvia
         +UeSIKA/c8f40omS8B5ROCm/kSU7drwWzbskNrz0LQqrF12G9eCl+SMuE7NAPL85i5fq
         NCtSZ8x37aoQfXSW2NdbP2etCnC2YHbuUO10V3tBPN2MacgW+BmBTmzWsZ50P81UoZFB
         VVQcRtmiu064lVMNPQXSjUFCjjD9fhDCPStgLNvYMsohM+sWKTM+e9p6hx/H4bcCd+Wd
         dbVw==
X-Forwarded-Encrypted: i=1; AJvYcCXAuKFck+hRPz4E3kAnKVn+VOgrg99qNE/7G+2YdjI95vZbSD9kV2GfcyOrQNvmQk3KomKJdZtGEj/BeXk0c85oBreBwRD6
X-Gm-Message-State: AOJu0YwIT6BbVpazTlwk4AOh7JrtGDBMa219Wo0gyXTGS69NtAuICqob
	LPjfleAEQWUe+OgCCawdN65tM+4y4rjBTdB4WvgPFwmdhr1f4ONcA5c6em8n0OUTOjVbmQ1VK/z
	W
X-Google-Smtp-Source: AGHT+IEoGDvKeh2AzwWyrfAGgjcTEwTmOeusiwR5rm32Awm22i+vi6HPAvC+HP2PXtuS4cmXb7xAWw==
X-Received: by 2002:a05:6512:308d:b0:513:1f2c:328d with SMTP id z13-20020a056512308d00b005131f2c328dmr7283158lfd.69.1710243421159;
        Tue, 12 Mar 2024 04:37:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id bt11-20020a056000080b00b0033e9186f043sm6240224wrb.41.2024.03.12.04.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 04:37:00 -0700 (PDT)
Message-ID: <dbdce27e-f33a-4597-b978-965c395c7169@linaro.org>
Date: Tue, 12 Mar 2024 12:36:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] arm64: dts: hi3798cv200: fix GICR size, add cache
 info, maintenance irq and GICH, GICV spaces
Content-Language: en-US
To: Yang Xiwen <forbidden405@outlook.com>, Wei Xu <xuwei5@hisilicon.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Alex Elder <elder@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240219-cache-v3-0-a33c57534ae9@outlook.com>
 <SEZPR06MB695952078B51C4549191F8AB962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <SEZPR06MB695952078B51C4549191F8AB962B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/03/2024 12:19, Yang Xiwen wrote:
>> Yang Xiwen (3):
>>        arm64: dts: hi3798cv200: fix the size of GICR
>>        arm64: dts: hi3798cv200: add GICH, GICV register space and irq
>>        arm64: dts: hi3798cv200: add cache info
>>
>>   arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 43 +++++++++++++++++++++++++-
>>   1 file changed, 42 insertions(+), 1 deletion(-)
>> ---
>> base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
>> change-id: 20240218-cache-11c8bf7566c2
>>
>> Best regards,
> 
> May someone apply this patchset to their tree so that it can land in 
> stable at the end? This is a fix, not adding new functionalities. It's 
> been 2 weeks already.

It's merge window, what do you expect to happen now? Please observe the
process timelines.

For arm-soc usually the cut-off is around rc6. When did you send it?
Week before rc6, so a bit late.

Anyway, I bookmarked this patchset, so if no one applies within some
time after merge window, I'll take it.

Best regards,
Krzysztof


