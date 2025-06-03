Return-Path: <stable+bounces-150714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DEFACC7D1
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 15:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59204188DE3F
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95493231A57;
	Tue,  3 Jun 2025 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cw6jC+X9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A03231A21
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957395; cv=none; b=XaaAvuifwFKf3x/7iTjePoOBAj0yKId7QUgLp1SfDCM5QzCWsiTT4HMnCw7B6pGYlilr0zxf969YhXX2Mw3mGfP732y0RjEK0dv5peI0iXGDX82PmrjIbnhAneiY8RRbVU76ZpL6EKS1gHDhZ/2KDWarBo5WVT2IoOiUQEJ6Als=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957395; c=relaxed/simple;
	bh=cALEzadqM287uTeXN80M2rgaHzMsWBb39Fvo+oH+CF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6xzR760yKLDQ5mhqd8Yd3VOVJwqpMGOYr5REhtge47Az3sWScu0eYCzw9+t6/EWTxXBLHlE07r+C/zooD6UvtvmnNrzUKDOuEciZONuU2TB+wb2IEfHURxXmKoAMjsOvoRpnbnkE2yGjDrABuIg55fNyeyFHo+/JGnqjXSsK8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cw6jC+X9; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-735ae79a44bso4561358a34.2
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 06:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748957393; x=1749562193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4074lnBbCE6o69YYHhmehNVryk0Fo/i6I6lU14MnK0=;
        b=Cw6jC+X92BlLi/wmBuOnLuUP/AdKqtDDP0eHpAV34V75HpR2Rine2TqLhJWOIkikGT
         h3JyVF9uH21kDWmI7aJPeuEpOxWzQY8VrsoUasyxU4TNI9iW93d47z++cqZLgb1x1Zxy
         2yyJFYgjIx4XMQlg8BCPa2wYywnp6CLvNw6mp9JBWzl6YQBE2OZoF8yXycqPvl3ZVohw
         zRPmNRIDeYhGPlVxXRJKmiQTVTWeJ9yLf4xAM5cIhGXFijdFnSG2nB/RuqoSSdVR8RLJ
         JCj7mCDrXKiv1FXQJHOfV2Dqk2PT2ckCkluMYs4VeGeoE+s7yA3NUBT6ttQI6iw3hgB5
         9pdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748957393; x=1749562193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4074lnBbCE6o69YYHhmehNVryk0Fo/i6I6lU14MnK0=;
        b=qgjKMXaKQgnP/UATiT2Gg67qTcN/uzCpOIj/IV4CyX041E1/vzutr9+aD1gWDLkXRn
         WMjlPcfKt9/7fpBPUDv3GKee7ch09GjwNVt/8KLoMlJQ6I26jIF4j9gptBdvIB6ClQu6
         Sl9FuVq50d+TJ8fFMQV8IYL+rwwtICUDbZBiRk8gm4+IPt1zWgZLXbJekwGPsbBlvOgt
         YAMkBstWEwQ+xz32cBl06KDly2TluSgFIqPPXA8Hl/j/o1KI0x4cQzFK5d2Za8J4t8BE
         zHhTvXNHW0cdCfXChemTmuBkVcRwa/7eNiAtxmkoOpUpbGTlQBHrC2xhWaUqptRqNl55
         UEzA==
X-Forwarded-Encrypted: i=1; AJvYcCUk15Dzb+7gojCSOKpWhuCkJNUx5FW+doGlIBX9ORhbTI3VLGYDkbTM91MkQwnzU8MQew/Pd9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmv4BP8T3LMdqlxf0w1ZJ9POPR0OWmAmG9GE70JYK9gG4zHZMn
	K2kkN/NplzzJKVzyLKOgU4gQK4/w5cJPuOqa8v8c1TNvhiTEomQuqOjGGqO/WWw11KQ=
X-Gm-Gg: ASbGncswyJ1CxM6XgRBOD9KFbCfWakHLUDzJO5owIhxzXb5dPsB6ammlUeE15BPuzDL
	lTypB5JwXrWYKKHPfu5nymlke+nYHvjp49SVtXVLDiVw6zKETpg7wcLlcuDeKfuejXvy64F+9Dw
	lZRk5DrzEIsbaN1OCAQTlZull9vZyNVPaNUrQtKZ7DH0f1QD+A//lZ0f+TjFW+ArLceoGkfMNcJ
	ZhJyiU/Xvr61EpfTjaaXsvLxwRmv57FhdiYrIkPT/KCTSbd/FQDjI0IqMaZ9E/uqbG24x/syhOB
	fNgooi90XpinU40OTLyCRRhXYfqqyz9pre448Jn5jZHyiC2hj174UMOY2CiqFIq53OH0M5wRt2K
	a8U5G0DGyNzKhlmy6rdHv/0m30lulPNY/YDkf
X-Google-Smtp-Source: AGHT+IF8kMDOg8rwg3c36JfYuMIR4bv1Il8ofYqW9P5T2sZ5z3aDyr/IKbsJ1zcRJnmWjOwA0bGxPg==
X-Received: by 2002:a05:6830:370b:b0:735:b40e:2b47 with SMTP id 46e09a7af769-73758c0ad87mr9227072a34.5.1748957392742;
        Tue, 03 Jun 2025 06:29:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:e835:af77:41c:3a1f? ([2600:8803:e7e4:1d00:e835:af77:41c:3a1f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-735af879fe2sm1962952a34.40.2025.06.03.06.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 06:29:52 -0700 (PDT)
Message-ID: <b1f0dbee-13bd-4e5c-90b9-c6d88cb15971@baylibre.com>
Date: Tue, 3 Jun 2025 08:29:51 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: accel: fxls8962af: Fix use after free in
 fxls8962af_fifo_flush
To: Sean Nyekjaer <sean@geanix.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250603-fxlsrace-v2-1-5381b36ba1db@geanix.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250603-fxlsrace-v2-1-5381b36ba1db@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 7:25 AM, Sean Nyekjaer wrote:
> fxls8962af_fifo_flush() uses indio_dev->active_scan_mask (with
> iio_for_each_active_channel()) without making sure the indio_dev
> stays in buffer mode.
> There is a race if indio_dev exits buffer mode in the middle of the
> interrupt that flushes the fifo. Fix this by calling
> synchronize_irq() to ensure that no interrupt is currently running when
> disabling buffer mode.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
> [...]
> _find_first_bit_le from fxls8962af_fifo_flush+0x17c/0x290
> fxls8962af_fifo_flush from fxls8962af_interrupt+0x80/0x178
> fxls8962af_interrupt from irq_thread_fn+0x1c/0x7c
> irq_thread_fn from irq_thread+0x110/0x1f4
> irq_thread from kthread+0xe0/0xfc
> kthread from ret_from_fork+0x14/0x2c
> 
> Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
> Cc: stable@vger.kernel.org
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes in v2:
> - As per David's suggestion; switched to use synchronize_irq() instead.
> - Link to v1: https://lore.kernel.org/r/20250524-fxlsrace-v1-1-dec506dc87ae@geanix.com
Were you able to find a way to reproduce the bug well enough to
test this?


