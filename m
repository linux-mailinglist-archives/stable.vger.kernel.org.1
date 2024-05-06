Return-Path: <stable+bounces-43139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E848BD64B
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2AD1F2117F
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C528B15B0EA;
	Mon,  6 May 2024 20:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1Wnw4MSO"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA3215B0FF
	for <stable@vger.kernel.org>; Mon,  6 May 2024 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027779; cv=none; b=iS2iHV7NQv7aYcmPSO5aG1bDq51rp5pZmpX2oiFmPllmRSEBc4H6OSQHJ7DEMiBQE0U8GcxizfhcjRL8kDJTeDRTiIXzX8GqWvIPQ7cVJJEmWF1r53euYX74aOuADtNHfMJesZdSUlD2Cm6k4iWWAWh82eM73TMGIEYEVmzFGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027779; c=relaxed/simple;
	bh=hZYvBVt+QQHuBDJyxA5Urb6FfcqJA0UlLjngzZg3mhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oePp+9kvuRHnlEniEaGi8jQq2PqUthBdl0OfK+PYrKBUF3dEmgBDILsIL675QJXVu+FCbgZROTCqyR3h46FImy1K3EAFMaPHgGL9Gc2iW/zWALQHiR0E1k6VgdIOV7YjgDMB/+0/EpR3BqLnsZ3sjj7y82urvbTKsKcizqjwJds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1Wnw4MSO; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c9691e1e78so1025849b6e.3
        for <stable@vger.kernel.org>; Mon, 06 May 2024 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715027776; x=1715632576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1NsrM2PIh29e3rNN1XVTvTFnGXo84LuXq38e/iMqW0=;
        b=1Wnw4MSOVDBw/ivN5qkohHWKayvMgH58WnS+thPrcXy7/fljIB1DFDHNA1e7AKUARs
         r4zKqaEXyCchD/z39SmPo87V2/S78T/oVZFoi2UU6lYjVr3YiOdgSymf6syW3sQCSESE
         guQRS4eIvL9bH+uxqTBPtmydgF8kQh4FSRJDkCDiFMAkelwpY9/K5oK18KkBxH1snfc0
         ALwouZUpSLf36rCY4sht5BbTaHT3C4TTBDpHZx/wAdjdIsdYF5iwgix5ZylZhe1SFMus
         alBUHb8xVU10qgINeq2TD7PYG50TVAAbgupYacR4tQuRlrveHJP070nJoVyV2RXc5Lgw
         W0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715027776; x=1715632576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1NsrM2PIh29e3rNN1XVTvTFnGXo84LuXq38e/iMqW0=;
        b=JJ/Y27qIrfbpjmvmBser3j0DJy7W2pQ16jONi96VtOgUOtK+zSzmWNGSSVsllfhIsQ
         t0k450NweyqDqWlOnyHJbv2vF+G06V0AcPbmOUKJDLw0T5cmks8WXdMTM9cSDB6uZNtN
         cyVQYtgIAkeYYem6BxnngpUdUX/UTbYucfpBKuUmV7veXfhNcC6JERUvHnl1mH4zUoAY
         frjhCfQHloHzlmSaD7vFt2X3gyjWckPJ7t7aLCIFfu7lO/51lAlG7DMaP8z6oIepaprH
         VQgv8INrvi+1KAK3vgsbu+0heWtYqyLkSgKLGP2+twWcf4NOJOz/qNTlCrcb2wC3AguX
         n9cA==
X-Gm-Message-State: AOJu0YxP7ZgbaSHAX4xiO5ujUiv2xifhUKm/kWzWm2Qdg+O182WK0lDX
	dQQLACKxekpu4uBJ2ZCKpX8wfT9iLsBkD8moFWR00Qw0rd3uoqZFxFDEWD3gOgpPvm0xT/T6iZj
	LI/Y=
X-Google-Smtp-Source: AGHT+IHWwfqm+njgRC3t74exGvgq43icvygIP+MhFR19Yw/0KTuHAgh6L0SdTxlWIKAEQ44bz2YpgA==
X-Received: by 2002:a05:6808:1303:b0:3c8:5da4:5f7d with SMTP id y3-20020a056808130300b003c85da45f7dmr14257616oiv.25.1715027776353;
        Mon, 06 May 2024 13:36:16 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id v16-20020a056808005000b003c96907bd58sm693544oic.50.2024.05.06.13.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:36:15 -0700 (PDT)
Message-ID: <2bad5d5f-54ce-4d7d-b6e1-7f37aded7057@baylibre.com>
Date: Mon, 6 May 2024 15:36:14 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: axi-spi-engine: use common AXI macros" has been added
 to the 6.8-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506192415.266500-1-sashal@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240506192415.266500-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 2:24 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     spi: axi-spi-engine: use common AXI macros
> 
> to the 6.8-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      spi-axi-spi-engine-use-common-axi-macros.patch
> and it can be found in the queue-6.8 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 

Does not meet the criteria for stable.


