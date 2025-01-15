Return-Path: <stable+bounces-108672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D5BA119A1
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 07:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8727F7A4351
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 06:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5CB22F832;
	Wed, 15 Jan 2025 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTFVkxSB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AB822F82C
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736922439; cv=none; b=UEMP2GjvkeJAb6cdriw5s+0cpH2gHQz4IYABXgU/XhXdhYE1SRNpUfP2rxyZBzZjFjJqZgwDvHooomep4IYQSd40PyAS/AQ52K9lvIZN0HUdKLe5zCbItO7CMg6kUtE6yV3nMRLFbqDdW75esxjsalBPg+d5WQEM501j4Jktz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736922439; c=relaxed/simple;
	bh=7bdH9utNFE6KJeqwnxFBJA5Qizh+vNGgqoqSH4K14dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDZmi0mSGWxAeSt+Ih68x61YXQrVGris1kJW7UKCwCAM2kblWEeuEbgnDUgd5WFkE8GlsWQRW858XB3NNCZElW0yL+MKYU4Bj2exR36o/PzHV8XKv5INB/Y2WZjvtoaWB9atuY41UB6dU87nX85Jen3t1yhN5EeauTCFL8xWCVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gTFVkxSB; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9e44654ae3so1010458966b.1
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 22:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736922436; x=1737527236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7bdH9utNFE6KJeqwnxFBJA5Qizh+vNGgqoqSH4K14dg=;
        b=gTFVkxSBuB0kUxrR/m16p8YcB6GHnXFc+ww7s6uUoCI7VmIe9tkDSPAkiIUeNiB9WZ
         5zuewpPFVAC5krnMJ00CB0NwH4v4DfoAyxd/JXn3cP4IA2MOSuKTinS6sixZF1QsaGrN
         2qqJnTRS3C0fuIIcUIHZHVYaJT5zRyO08A1JnuwbTZwihh5fOUssEBZ8WBd6X1LpUqqb
         EQcigHQ+CUKnrArp2RnjPX/gxXRHDxYcM659YS+0jARaSlLv3PVwE48iohnCwfX7KFc2
         MGzpQLwehqriVKUAM5LrW2h7bsm8q61c4tN7ZFuObBjHa7ZwuOT20EanCxdU91rYEQiX
         4FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736922436; x=1737527236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bdH9utNFE6KJeqwnxFBJA5Qizh+vNGgqoqSH4K14dg=;
        b=qijcmkl8q7yzPoE1OczSw8/lS2fdmD+3vypymS8mjkgzHDH6fmreQAnATf2V9+Pjiq
         cbLI4MHT/G7bHJ/GzxxPvjSmMqqiveV8n01hiUd/510yC62NK6s34Gb3Ln5U3j6Br0Yj
         A5IFLNVXquyp7unV+ljdDqGmF3XHT25ViwWxTP2DzE308jlbjZBKkhUW83Bx/uCSVT1e
         XYMKtNkYTD6Ni2wigh+HSKV614y0lwpOB4V9wFMQVybMNdI6amcuxPQQGSHtFuSADaGB
         juN239VZqRSIn7AgvP/8SiI5P5I/AbEF2PfWy9lSYXkI2ASbaGswgOHjZdasId8/b8Xh
         ahvw==
X-Forwarded-Encrypted: i=1; AJvYcCUFq4Q+458mqADHeDKVtJ5pr2WFDrQJcAEHP/6SwIg8Dqrx+2cDSftqYi6WWdUqlO54HWJVACY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziyhBaFQQjH73O3UYZiAtMSXLNWzdQP0dvQ3AzVibjdd0tsbJj
	P5WJb+1mI9ALFusO9vaNIB3ijph5HjO01exj250LrqSdHuBj8MV2T9+bYS4Bd72sIXaLJSnhmNF
	b
X-Gm-Gg: ASbGnctYYvE/1A+UfFMrcLcUIlpkdCjy6+NSWnxdbARYMizLgnPRt8jeMahBBVTpTEz
	Gg1ff2Naph6gS0nL1S0zr2Nthl7OHUXOQapVHGH2/ejVydo4AiEw8/UMy88KDnFyv8fOAIK191X
	0HfQBmFPrsprGNUwfrY8jez8H+gFKRGk46ZyQcDxbQiLFcbBWhMvtMnBB6BlFm28X0RiGwEcmHz
	tCLdPzrK6VkcU1JDZv4rLQNmtUn9Mc3Y2JYTo6KQ7nUoloJbHnhRNp9hpFYeznUSA==
X-Google-Smtp-Source: AGHT+IFA1Yjzod676tgBpT+pdawUDG6xVmkvVZy+3MR/AN2mwfOhAtphEeoSb0u6+N6EFLjRGfjdGA==
X-Received: by 2002:a17:907:728e:b0:aa6:a9fe:46e5 with SMTP id a640c23a62f3a-ab2abde568emr2595107666b.53.1736922435733;
        Tue, 14 Jan 2025 22:27:15 -0800 (PST)
Received: from [192.168.0.14] ([188.26.60.120])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9563b06sm722100566b.100.2025.01.14.22.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 22:27:15 -0800 (PST)
Message-ID: <7df1ea9b-5fc3-414a-b0bb-595296537d01@linaro.org>
Date: Wed, 15 Jan 2025 06:27:13 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: core: replace dummy buswidth from
 addr to data
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, mwalle@kernel.org,
 richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, leoyu@mxic.com.tw,
 Cheng Ming Lin <chengminglin@mxic.com.tw>, stable@vger.kernel.org,
 Cheng Ming Lin <linchengming884@gmail.com>
References: <20241112075242.174010-1-linchengming884@gmail.com>
 <20241112075242.174010-2-linchengming884@gmail.com>
 <3342163.44csPzL39Z@steina-w> <mafs0zfjt5q3n.fsf@kernel.org>
 <87wmexp9lh.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87wmexp9lh.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/25 5:51 PM, Miquel Raynal wrote:
>> Tudor, Michael, Miquel, what do you think about this? We are at rc7 but
>> I think we should send out a fixes PR with a revert. If you agree, I
>> will send out a patch and a PR.
> Either way I am fine. the -rc cycles are also available for us to

same. You could also temporarily fix nxp driver by tracking RX, this way
having both macronix and nxp happy.

