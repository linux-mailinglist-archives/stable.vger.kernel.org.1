Return-Path: <stable+bounces-194837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 333DDC6069C
	for <lists+stable@lfdr.de>; Sat, 15 Nov 2025 15:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81B33B4C2B
	for <lists+stable@lfdr.de>; Sat, 15 Nov 2025 14:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E282F4A15;
	Sat, 15 Nov 2025 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="q3xlIJ4l"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00DA2F5B
	for <stable@vger.kernel.org>; Sat, 15 Nov 2025 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763215468; cv=none; b=L5AS/iInKHS0QQp6f+czApF8X1L2UFW0JvonoZACswKpa2KfEMvlcD+2VKFlBptl/j1uROLrWOrcOZz2gFLaLy5VFfUUNifjOfqpsYdpjCNxrZ03F+kxfETvb0vbeKEq8xGfQnldL9wwoyvbY1UvU23XcG1NjnoYykoQ3P0Zy/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763215468; c=relaxed/simple;
	bh=xu/rQIhP8Tjy1ZIXs7CbAY6P/QQy/hxPWPEdylu7yko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POMig8SVhosKhGQ4tqT1KgdXGwILjxKAoG98P8YvUr4mn2VWgFUX3iWaNwZespGdYATLjyurFTCkU63VyZwLCzfJTFPMQtqXLCGV/ULIQ67Hkmo0TxlCaDlMMcUukuYZRqhRvYMDMw3LVFWtR1UApq47sBfTaPtd2z8EVsXSrdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=q3xlIJ4l; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so20720865e9.0
        for <stable@vger.kernel.org>; Sat, 15 Nov 2025 06:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763215463; x=1763820263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pKvYUG6QyuYwze0pX76iQK1U7NhM2svZNXWBkQgxwp0=;
        b=q3xlIJ4ltdPAretAnz12hbXPVc26XmXLMkzA/X+a+0uHczJB3dmMN8h/ryALkaoXoE
         UScseosOuNqMJ6coBai94hBnIFL8qwgjMjGgDLb4RavANL5Lm9uuH6vDtsIfdeiU8jV1
         2IMiPO5Es/vIsHAY8glS5HjCTAOAUtTPo04rvK01h4UNBe9qadlGLgDf0okus9AbO3Zt
         TaZb0kzhic9D7GWK1P4isuI5xg1fxMD5FqsvOmJswNx346SveJTMWpD1DyxHCx/TzYSv
         O4aMpvgFbUOSc2t6/qgPZOve+YQ42XyYTFJsDRSzuIzxn0t0nLjqIlCpA9ZPM/2RXMco
         wP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763215463; x=1763820263;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKvYUG6QyuYwze0pX76iQK1U7NhM2svZNXWBkQgxwp0=;
        b=Zuo60fDtRXsQZDRD9HR/awfIfhU2uJPEU5GpQ9qDGY22kte4Mo58VbHxaCqCZb/OLn
         RTqytc+FwYZfRwCSlw+59f+YGAvyKtlIclfoMFU9W12jlDTbIQBqs6b8MBMiUST9ZF3V
         tl+kwH+zzzv1y9qQnjy9zx5+9G/MYKhVQl5/9xB3VUv/S3B6PehX0egzReFIvXzGrB2t
         nmWQgomRjYVYJ46Vxm1WoYamky0kRvmNcL9vSUgforY4z3EMoqPvEkTPdLnSLFdS2v1N
         k1gAhz5iZUy9aBTg+NJdOb9Sqq24sx+dNBOrNKx8yGp0bEnXb6BuqjoNR0P4/g5cSL6B
         ud2w==
X-Forwarded-Encrypted: i=1; AJvYcCVrXR5iO2beswNJIEsd7VZZCR4zRXzi31IHmf0c0KWWwSf/DJ/f33ikkIBvOn+fspZzaZc0DbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJuwW9aT0Bk3aRhXrQwchqPQdsDAZgbTO311JHzIBX1hvRu6DD
	f5/um6DvGFc6AdGfrNCoxQf2p23ZMoV57WfIcJDjHxbdsOEG3N3qaJSqT3NH6MIWaqERouMzHJK
	vu6GEbGY=
X-Gm-Gg: ASbGnctxQSkv/PuVsc+ypSef0XgZ6pZqLFnXgxYTQ0rQwsoRGv7W6IgM/+WAfiZvT/F
	tyW8AUfbM9yubFwoOdcXXNdCPZKl5+iag6CQso76l5Yx5CkCEX20gzBmN02oF87qtXKXnd9MUNp
	4YDFJYIcNsj/QW2hFDb2uPgOcwqXZQstSJoydKGHHGtinc1VYT3H8vYw9rGSFSRWLo+uIs5A9jy
	AqB0xJhvlC9VG0UMeL+2JprIFC+h6KV48GceWvt9hzccaQGd+lG8FUmMOb9D9Bw9CZ8L8YsPxCe
	4Ui0z1UCdFNSaEPpM5m8ulJX2dIEJ9ucP4fa1ZwNoXEV8/Nt5NoAodb/tIby8Ako/iCtCCa+2DU
	PViduOEgNmDdXpiZMYt/5AN//vlBHzS5eeIfcKnPpAu/YL/dKXwKaGCbrrlpNhdUyddRzgu7Efc
	bqhVfuwDsKVzVCnUeNsZ4=
X-Google-Smtp-Source: AGHT+IFngBuo06OnXJJuUDkq4i3N5EO3BmBgXJQN+Zh3JAeA5AwDW+ND3ORBOMBIncLe0W3XOIS7Yg==
X-Received: by 2002:a05:600c:45c4:b0:477:8a2a:123e with SMTP id 5b1f17b1804b1-4778feaf9bdmr67343465e9.33.1763215462926;
        Sat, 15 Nov 2025 06:04:22 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477988060e8sm17748445e9.5.2025.11.15.06.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Nov 2025 06:04:22 -0800 (PST)
Message-ID: <446ed1ed-7541-4e49-b777-72e3c3de5a98@tuxon.dev>
Date: Sat, 15 Nov 2025 16:04:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sama5d2: fix spi flexcom fifo size
 to 32
To: nicolas.ferre@microchip.com,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ryan Wanner <ryan.wanner@microchip.com>,
 Cristian Birsan <cristian.birsan@microchip.com>, stable@vger.kernel.org
References: <20251114140225.30372-1-nicolas.ferre@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251114140225.30372-1-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/14/25 16:02, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Unlike standalone spi peripherals, on sama5d2, the flexcom spi have fifo
> size of 32 data. Fix flexcom/spi nodes where this property is wrong.
> 
> Fixes: 6b9a3584c7ed ("ARM: dts: at91: sama5d2: Add missing flexcom definitions")
> Cc: <stable@vger.kernel.org> # 5.8+
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied to at91-dt, thanks!

