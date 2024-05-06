Return-Path: <stable+bounces-43149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 641E18BD673
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052A51F21999
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA301591E0;
	Mon,  6 May 2024 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lWzzouzS"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD0E15ADB9
	for <stable@vger.kernel.org>; Mon,  6 May 2024 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028317; cv=none; b=o/oqk6x+eOeH5vmxFoKIC+R9vM+aNnqzMnHsliVxsgqULlwYqwnJrjcCZhtAd+nGYb+Jb0vM10bwBOtd//uxY/Zn2QI7GpEpE4aPvVYwVKRJ3F9ehzn/y554NHRQ31SPwdqpfslHfUaOhFkg4NoGB0amYfwtuF5zIrpZAzkDbvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028317; c=relaxed/simple;
	bh=z6AniLbjOP4YtPGfz0Rb5aJTSvXhx9O7MkJvlI2PjVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImqgZyvHeCYBtgBD97idb/LglFoSuxdWI4QoLXFQOuCI8OMT9c01Mi6H0Ud3ZquLgEuIEwgA6syIRequKsAhtsvTuAkQvLylRxXpGi68JEnKLX2rd7H++XRjYntw+2T8D7bFR7ywDMPk0N35OTSk15SY33yCH2ncuq/IgLtKJYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lWzzouzS; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-238e171b118so1443667fac.3
        for <stable@vger.kernel.org>; Mon, 06 May 2024 13:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715028315; x=1715633115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=daVrb9HFcmDSdSCBMDQeeiOH8QZ07YHHhr7z5wh3ZY0=;
        b=lWzzouzSxuviKXxRbudI9E+7dalLRxQ21nuIYAj/XA75jL7vhVPKrFbacQZtwjMYgX
         dsDs6v44mtWkApgzjK5PHXG05F3V/KjFVf1nRj4ZIqfnfyWmiGV8HhGM7cw2v3VaepHA
         wJ6jM09nEkuzMVO49I5AJbskEo2q6u3eKgWDemZHt8zYo+2ymbRTj1yvgdI9GqXRGIJG
         ylZV0wRPzLoiVxDI61GS8DTte524yE0RCuwE9oxhdewnuJU2bAP/wq3LdF3wFhmuYsfm
         BoxvwwJZ6p/2fz22i20wzH/SbfEK4huhnImvZvcvaaw0BJlu936VFs3IEOhdhV8LER4+
         pQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028315; x=1715633115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=daVrb9HFcmDSdSCBMDQeeiOH8QZ07YHHhr7z5wh3ZY0=;
        b=q+ilc+3FucC9PcWteRAo1vMedCJ0efHVtr8knLBXTbKWCTvh1klvVsgNJP78yhfDoL
         1JiTLt98MoFA1N1aHCFTDAzLQrHMZOCSYNBXMk3j8gP76zYn/cZ4K0EdAevyw6BgasiO
         LAJ0lboGK98EPhkZ/VQFnE8YzNR8QJe5OY3v8B8IappiKFrCMTwTlVou9hvI2nYu0cpq
         PZIchI5alWEMh6ZZzZdmDDBza9IWRKpGxJtK8vdtYDuXENNBWrmUwrJy0hlTONS/JxnL
         dZxGooPdu4G2Mfjn9HLx9DntUh9eo2CEloJ1Hii8M3L/Ezq0nZA2bvv083WY6lvkN9vK
         H/Hw==
X-Gm-Message-State: AOJu0YyQB0h3zMTAW+AnFgwsYbBBOqw1w2r2C6aSbN4wg/7vfvv2ybUH
	TsT4n+qKT2+D/CzCXFKktfLycW+MXJBhhU74ktyo2pBxzgqX+UgYO5GZX0Y+5L5/XbUq84LH9Tv
	yVME=
X-Google-Smtp-Source: AGHT+IF9ErqlzIfcm8Ta1tLFSUD+bq7ElxMSHN+rja8uBr1iUmpZXWzjWBoOTcrEsYDUH4aF4k6P0Q==
X-Received: by 2002:a05:6870:e6c1:b0:22e:c1ff:303c with SMTP id s1-20020a056870e6c100b0022ec1ff303cmr14265240oak.37.1715028314785;
        Mon, 06 May 2024 13:45:14 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id os6-20020a0568707d0600b0023c0e0e9d2dsm2093817oab.44.2024.05.06.13.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:45:14 -0700 (PDT)
Message-ID: <40a7f73f-11df-4018-962c-bc55c601535a@baylibre.com>
Date: Mon, 6 May 2024 15:45:13 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: spi-axi-spi-engine: Use helper function
 devm_clk_get_enabled()" has been added to the 6.1-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 lizetao1@huawei.com
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506193012.271832-1-sashal@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240506193012.271832-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 2:30 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     spi: spi-axi-spi-engine: Use helper function devm_clk_get_enabled()
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      spi-spi-axi-spi-engine-use-helper-function-devm_clk_.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 


Does not meet the criteria for stable.



