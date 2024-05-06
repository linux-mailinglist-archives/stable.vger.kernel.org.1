Return-Path: <stable+bounces-43140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC79A8BD64F
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1857F1C208D0
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60CD15B0FF;
	Mon,  6 May 2024 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t3SJnMTL"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EF115B100
	for <stable@vger.kernel.org>; Mon,  6 May 2024 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027848; cv=none; b=i4A5Sk7ZEl8Hh76CziBgqEZ/BHmrWaW3IM86unP6sFbEc/yePnDsBIBF3Lw4R226IclvsAReI2psR8Uuag5CsmXtxVkrMMp4id/ruVHz/MXxzSbG+lRoRbaMIDHjaCrot88ZiGfFV7FZ7f31wnYrOVZFqO5s6nSqRyt/iXU5ug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027848; c=relaxed/simple;
	bh=84uRjeVpl7nMVsxBmtocYrgS5sJyPykCv4QCavwqjDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSHI4zwzF7VUIUM6zrA/AovHrvd1N3UH1gri7lntjGv0zTx6UYqhBOM3H9pw0SwxPVCjydkPjtRRXe3UUxquDstfC+HDAJwgw1LIZ/AIEZfs7/QYF5f8RCX1pAXbBdG8iIZty26vtIW4x/TwhG23d/5bx3vO7pMRYiT7POewM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t3SJnMTL; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c96be1ef20so838314b6e.1
        for <stable@vger.kernel.org>; Mon, 06 May 2024 13:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715027846; x=1715632646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5XDAtMkhH8zFzLRTLFq+k36k86aoan4ykJV8JLJfn4=;
        b=t3SJnMTLDFXh7oqlb03xyOEXzR5htF/iOl9b705le41Hx/2PPVTs72QJTfU0EyPhrv
         aiUf/VUju7uvGYZs5kJBCXLHr+6nrJ170wAxhNbeRbQC/rcGUU9PTKzKjDoiCGArJkMB
         khHl2qEpFUzyu4fXxfvZPvurA+XbC6OoCdPPMzR/LrmZze3QwJLsmOlk6ppMH8ImdyIe
         dnLoqNswql9igYfoJ9jGMkGKLKLrT5xxb4or0sCxFTpWMexUTLjNqtHwqv6a7kIFR60L
         3PnHlqb/1NOiAPosgX/K0WnveiVmTBIBqMhjXHAy+Js39vVS9YlBYXpHsi+cmH0I2k1C
         Y4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715027846; x=1715632646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5XDAtMkhH8zFzLRTLFq+k36k86aoan4ykJV8JLJfn4=;
        b=FzVO3ahFalX2Lk+5zLIK1z2YWmSWDEy2yAKR/dipzjT37BoPZTtTnkg8hC0GciQ+EX
         IERUHHOGN9784DTTeYijtxBP5+1zR7RtRdbELTqoGZPZCtmwCV7am/1olKlBUPheZECJ
         IrM8MZVAYpH94ax8ZQqahSkSvDrBFmZf3HVKVJzLkhmWg0hYb1St+TPBYlnEnTwI1pSP
         RFLouqxqfq2heUAWG67nda1B0TlXEbfh+mwN4BMnRxBI4ngbH7sPVc9qqe4xY+Aia2r6
         CAudqHkxYY2I1k3LrX/2Ef9T8uiNtPzWNqxmppe+RCnwQVNzYiCW549mp3lzFm/mCyh6
         bsIg==
X-Gm-Message-State: AOJu0YxTpsyRVHGUnBxF5D987w84Yp5MLXoMa1zMjv0e0F3Qu7F5LPIN
	w5W0XW6s2TM/GZiuw7bxCSaihuBhs4cPC9/0OK1kqKrQs71R1ptCSNh0fpr697yLIHKymfWG1eb
	HEss=
X-Google-Smtp-Source: AGHT+IEYbwuOrh+DmCNf0ZD1K9KFY1UVe2kddsHy7US8tqV0uPW07LWA6kD8yq+zgttrnTWBGywh9g==
X-Received: by 2002:a05:6808:6194:b0:3c7:3af4:6081 with SMTP id dn20-20020a056808619400b003c73af46081mr11915327oib.16.1715027846017;
        Mon, 06 May 2024 13:37:26 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id z16-20020a544590000000b003c8532a443asm1574501oib.58.2024.05.06.13.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:37:25 -0700 (PDT)
Message-ID: <07ae432e-9ac5-4d35-81bc-8b27dee0dfcd@baylibre.com>
Date: Mon, 6 May 2024 15:37:24 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: axi-spi-engine: fix version format string" has been
 added to the 6.8-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>
References: <20240506192417.266542-1-sashal@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240506192417.266542-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/24 2:24 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     spi: axi-spi-engine: fix version format string
> 
> to the 6.8-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      spi-axi-spi-engine-fix-version-format-string.patch
> and it can be found in the queue-6.8 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 

iffy for stable since this is fixing a theoretical problem, not a real problem


