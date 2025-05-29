Return-Path: <stable+bounces-148114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E5FAC824E
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 20:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108BD4A6001
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 18:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4F323183F;
	Thu, 29 May 2025 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iRnrMcCh"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B740227B94
	for <stable@vger.kernel.org>; Thu, 29 May 2025 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748544560; cv=none; b=fjy8lwWpv8R3+KTakNUjsuFLUhGC1dzrtDo1OnuyrNscHsW/WKQtX+tY4apl0LMKPSQDcfC64V34rDnPUa0EvuLWct9+RUD1HparrnmYzA90Rb7k68ocGhc4NQ524kRToOcFE64hnEg/M8r5TE3J5wes2MAFD8fSzav7KlwqERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748544560; c=relaxed/simple;
	bh=xJyRDDYcv20uqVtmo+sDTTcu2JWML4/vfIqEHh27NfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmYPfeQ84xoNOAOq4uTq7FDEMXPS47LrFXHSFXRa0kv4Ubvt5rCAmDPAfKQ9bmuv1KceugUwiTgeLVMpjDO+CaOc+7kztLTur2zE5LiLQHeVUQJ8TUAXrpGD2ElxyJb631hIi+WagwTPmpxHvsmnQYF2SL58SaZBbL1vhsNLqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iRnrMcCh; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-401f6513cb2so1282561b6e.0
        for <stable@vger.kernel.org>; Thu, 29 May 2025 11:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748544557; x=1749149357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gy3S3Fn/j6b8e9AaQveHk+8wC1o4OB+toc8/xWPhOCw=;
        b=iRnrMcCht6VU+szI+LYTdhQg94qZsjin0qOZwcPXGByODJJj0e6SCZhxi0msSwMaHm
         5B8WVAJhWBTGqbijDsTmRl7NZxQ6JTJ9hcDL7MEmK9dOMISZE5P5EPYhVxKJt0qCtI4Z
         t6aKC6qODPMOXzcL2xpuqdsn2J195bTCLa29nL4aC7liMeQG+stfdyxKX/CGbEdhPJGs
         GznKPbghbVKmqbjd3MkWtyIRSk7FyiUHdineFwE5uJgg2JTAfQKNtqinU9DNZNzunjN9
         1MkbjrM/LK1ULICDRQ5Ua/XgbAXNS9Jpopxc83XjA1avsxSm8iVT8nSU7D2IVytQ0BAb
         gYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748544557; x=1749149357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gy3S3Fn/j6b8e9AaQveHk+8wC1o4OB+toc8/xWPhOCw=;
        b=WdPERDqKSVadC81LKQBQT084ULFyHWyNFiSMfeVigQw0epmX3xZZmr9QN/BFoRxsjO
         5xad/e2kiSImKEYPB9unz65OUUz81wAadE4HKvgF5N9Vgqm6iTDE68Rn+VyZBZRlx2Yb
         3dqjHpHLwfp72GLD/+G4OBFQi2t8jcfwKdn5zzFdDlm0CH4w6UzxXb8wGrLAPxAcgnsh
         VGrUB/DHEAYT6QkmGYrnu8Cgrfq1hib9REYSGfoj/cnI/2xWRxySVRVaSw85ASlpW1/z
         8RdmOS9lKLS9RkgWlgla0NbQxnWj5O5tA62MdpF/RoqiCfVKVCF/yHmdXiJW/Uee1Wyn
         W8jQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9ybpEctnyfIW9pJmfy6NBZ8ovT0dtasiOOHhYoCpNksziaKRSyKsZb9w2Eh68h3fBT6quUxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvw7qkiZ5rD6nHCRNh7L55ElPsfXuKmTYRTKtThG0w3uENbudt
	PZzQAOOVxYs6DehLWGzHKj06dNNnEtotEZ/sEXA6E5QOTAwXHnosGHGLrlDrfdPfLJY=
X-Gm-Gg: ASbGncsO/lNwElJenF0R5Wcts+jzOcm7dWrth4MDqCNV+TOmxCODCI25D0QFaEkoIwp
	gMNBRks4+XaXZ0XATVC8wY8sPmcAWnjG7ul5xg0ZyyvxOJ0xaACJVCylfUPkRlojxgw1L2ZERve
	voonvNb6nLGIIswpPBPsrenslmKt1/xmkq2bo/HZBOyI1MoLBvChcXScn/B7vwsz4WLPpMs/sOC
	ebe805BBuSksDSAdgXz/MkzfnxhBRp4wvfW/S2dt14NBQls46SKjCe2gTJjvq06FkaOmTiTjmD3
	QNoS/BssXpLaVuCRS4IeK0mh66iG+6VmQLSDVvrRu/dn3wThdxxA7jj72rb61j6QR0hws2fQ6Se
	Jvbj3WtKw4gotKmVmvOFI65Z0eQ==
X-Google-Smtp-Source: AGHT+IEyyz+oXXz7Z8GDgMD/9k40e0l32wPzvtqCZnLWspB6lRn1ogv34ZVW2mVeIvxYbrHYa7OYIg==
X-Received: by 2002:a05:6808:6a87:b0:3f8:18a3:b1cc with SMTP id 5614622812f47-40679fd1c7cmr289416b6e.12.1748544557292;
        Thu, 29 May 2025 11:49:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:928b:5d5c:6cd9:1a4? ([2600:8803:e7e4:1d00:928b:5d5c:6cd9:1a4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40678ce8304sm92905b6e.32.2025.05.29.11.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 11:49:16 -0700 (PDT)
Message-ID: <67c33f11-0196-44f4-9cdd-762618cb88be@baylibre.com>
Date: Thu, 29 May 2025 13:49:16 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: fxls8962af: Fix use after free in
 fxls8962af_fifo_flush
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sean Nyekjaer <sean@geanix.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250524-fxlsrace-v1-1-dec506dc87ae@geanix.com>
 <ed40509d-9627-43ce-b209-ca07674988ff@baylibre.com>
 <CAHp75VeAOFXuxsiAEwJ=dMJ8NZsyA7E-h4L=2ZgpprdUXU2EUA@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75VeAOFXuxsiAEwJ=dMJ8NZsyA7E-h4L=2ZgpprdUXU2EUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/29/25 1:16 PM, Andy Shevchenko wrote:
> On Thu, May 29, 2025 at 7:02 PM David Lechner <dlechner@baylibre.com> wrote:
>> On 5/24/25 5:34 AM, Sean Nyekjaer wrote:
> 
> ...
> 
>> fxls8962af_suspend() calls enable_irq_wake(data->irq); before disabling the
>> interrupt by calling fxls8962af_buffer_predisable(indio_dev);
>>
>> It seems like the order should be reversed.
> 
> AFAIU the wake capability of IRQ line is orthogonal to the interrupt
> controller enabling (unmasking) / disabling (masking) the line itself.
> Or did you mean something else?
> 

I don't know enough about how suspend/wake stuff works to say for sure.

I just saw the comment:

	/*
	 * Disable buffer, as the buffer is so small the device will wake
	 * almost immediately.
	 */

so I assumed someone had observed something like this happening already.
If an interrupt occurs between enable_irq_wake() and actually
going into a low power mode, what effect does it have? I ask because I
don't know.


