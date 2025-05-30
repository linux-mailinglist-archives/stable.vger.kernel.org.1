Return-Path: <stable+bounces-148324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D079AC95F8
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 21:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA29504EEC
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 19:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC35323D28E;
	Fri, 30 May 2025 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0PITlNZT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7051423E35B
	for <stable@vger.kernel.org>; Fri, 30 May 2025 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748632476; cv=none; b=iD7umRWA66n1E+H4HYXRGwSxi5i296qcPiJvvbbLy/VpxHYKulvooyNZlPfmPfLMtXH0yUaR6nCeeiD6E8GrL8eUc2JwvhmSgWj+qD2dC4GeSvsaV051YMpvuRO91GZ7wF0tt8ejVmvFXRMl6YMq/uslE0mFXUdSE97LG8WSSUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748632476; c=relaxed/simple;
	bh=n0bPzSDW+HlaSAhgO1u0Y2tk8Tz3wmhJR1U+ZzeshEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYoTlsljMKNzoJKB09jdz3tGdRkBABQvgIVaZIuSSefmZpAKHPmOgs2lA+iRJcwmYpND5QgfcoXfXt5YfsYZ7cuyfEcKZPOHknsqwzsssjJn2hMlDxLRCAF2skisDSVM5pizuZmJa6GeWPCP5SmY3NhCRKk6rcRaQD4/vXz9BKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0PITlNZT; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72ecc0eeb8bso822137a34.0
        for <stable@vger.kernel.org>; Fri, 30 May 2025 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748632473; x=1749237273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lHHqZAsVpviFayOBzyBP+5p9wWvjbFoN8P1d5tfq8pE=;
        b=0PITlNZTk9EPbpGwyLacMtZMl6g8zuflihzfy5Wjtko//4KsuuUnHuNvDR5CCMkbxB
         CmESIVHgwcl5dMCNdlPMbBYkONHpG00Dss8akuWlb8u7cNPskQJRL3rTOHMsfgp6nZOL
         0gaQyi2tMRuD4qeOUKYpKtQ+HBkG+QwkB5hZ3PMMlPezWWGKIRuQwpQdEKmXWAnG038h
         6NEhM45bcmJ+hWu5B5sZaqtsjmHLCrPOKsk/OeilnYb60ZzNyXWLQncK6kNKGdeqDQ7s
         Ja+H94OLtE5uSc7HOlHosK4APizZHjRmKaS/b3YW+DfVN5F0vZXpzUTA6CkO8EKO5jul
         RyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748632473; x=1749237273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHHqZAsVpviFayOBzyBP+5p9wWvjbFoN8P1d5tfq8pE=;
        b=F5Ivfx+/DlF7rIsCLhl6e5UqyPdXdfRHqM6JNjNuOGUgqqyNwPlj0ctQoDBU52dkLn
         x0UyJuVsIYrroCrRmoAERFT3LPl2EYF/Mm1xr4i+ASXFhSGhrPchJelO4yxtaiHotcST
         ajjXVLc2Goso6pTll+OM1L8xjD746b/FJOvakDXEbvoOt5HFzWjxWacRNXPLCdwhPWmP
         djQ3UtDGZUZHeP1Ignj5BElb6v+kKeqsP9W4lzi8ejXJjj3mERV7zdkh2QzDOospiC5Y
         wvZ2nLRWPKbXsTKZBS33An+CNXmuW1/6bt3+Cpr3CcKoZ9teyFHFfdk5+Dy5yWZ5srtP
         31SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb4cPONrmn+AACI/25nqtXT036W29Zw8945Qvqrow3idqsJxYn3o/5pI9E4nNWtuF+HJvF9eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXoeM/VNDP/+kW2L+9iBqdgVpGaJkGfOBOqtYK2G8Kgczxm+4E
	mljTBqoSQuYcMz6FnrsYUmw1OrDrbAkKDPAUGUxXK8HHPaIEWBYGEe7hE6JweNMPcMU=
X-Gm-Gg: ASbGncs2VTOBv0JjybOcZHHe3d8FvwOoYM5UGdSTqKjrQVO7WNXtQuYlzqHX6hV81V1
	XFdNSJW1t7ys06gQfrp/u8u1YWGB3lRjZP6FaAG+x7ptrsl9CKBLhcupttBxYgE1+RzgEkxjQun
	IVrXWipNaWrL9HUSKIcDIJC2ig3RI3Y++56DOkDbDMtd7TvLogdYpBYyNG7xL51G9zkwDzvCdCS
	GNQkX905KXiNaqtzS6s93yksFZPQrd+wu59ySJvcQOM6XBFl9zqMBbmTAwmtg7VQsVUP+sFX6VQ
	6oTc1Zq/pr9RVBIdMVXZNWs/RAwy/bqXU0HvAatlIOx0Zbc1tLA+lL3kn/LNIQZjeYZGMPNqtvj
	lSTNVcu2Q7cdkksh79kQ2Z44bF9hZ
X-Google-Smtp-Source: AGHT+IHPxI3UBPpTmwRtvH3AUGD4B8Qbyg+V45TvwOxwL3NJO9g1RZBHm35gXZgxpvqaXtWJbZSWDQ==
X-Received: by 2002:a05:6830:6a15:b0:72b:9a2e:7828 with SMTP id 46e09a7af769-73670cd6814mr2983963a34.28.1748632473479;
        Fri, 30 May 2025 12:14:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:29cb:b1cd:c8f4:2777? ([2600:8803:e7e4:1d00:29cb:b1cd:c8f4:2777])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-735af82d4bfsm692406a34.1.2025.05.30.12.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 12:14:33 -0700 (PDT)
Message-ID: <90226114-646c-4af7-bd38-361ac383699f@baylibre.com>
Date: Fri, 30 May 2025 14:14:32 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: adi-axi-adc: fix ad7606_bus_reg_read()
To: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Guillaume Stols <gstols@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250530-iio-adc-adi-axi-adc-fix-ad7606_bus_reg_read-v1-1-ce8f7cb4d663@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250530-iio-adc-adi-axi-adc-fix-ad7606_bus_reg_read-v1-1-ce8f7cb4d663@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/25 2:09 PM, David Lechner wrote:
> Mask the value read before returning it. The value read over the
> parallel bus via the AXI ADC IP block contains both the address and
> the data, but callers expect val to only contain the data.
> 
> Cc: stable@vger.kernel.org
> Fixes: 79c47485e438 ("iio: adc: adi-axi-adc: add support for AD7606 register writing")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/adi-axi-adc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index cf942c043457ccea49207c3900153ee371b3774f..d4759a98b4062bc25ea088e3868806e82db03e8d 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -457,6 +457,9 @@ static int ad7606_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val)
>  	axi_adc_raw_write(back, addr);
>  	axi_adc_raw_read(back, val);
>  
> +	/* Register value is 8 bits. Remove address bits. */
> +	*val &= 0xFF;

I just found out that there is ADI_AXI_REG_VALUE_MASK we can use
here instead of 0xFF.

> +
>  	/* Write 0x0 on the bus to get back to ADC mode */
>  	axi_adc_raw_write(back, 0);
>  
> 
> ---
> base-commit: 7cdfbc0113d087348b8e65dd79276d0f57b89a10
> change-id: 20250530-iio-adc-adi-axi-adc-fix-ad7606_bus_reg_read-f2bbb503db8b
> 
> Best regards,


