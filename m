Return-Path: <stable+bounces-118684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3812A40DBD
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 10:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB354171D43
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 09:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA28F1FF1BF;
	Sun, 23 Feb 2025 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbfh7obw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC87198E7B;
	Sun, 23 Feb 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740303762; cv=none; b=DQ1k0Z+Pbarv0gx8fdzt/hLndAd7c7BWlnOTfMPnBSk6khfjS9ydAm14GPNRq/OCscyiXuYppiyBprNYGojVWeZsG4wqO24fW0yA/0Gy6KccVDcnBG3EZyK8b3boIlCb4bCgRiA/iL9na5iarbWaxTsNH9Sp8ilSAcDhwmIDE6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740303762; c=relaxed/simple;
	bh=N9Pu+FJajZYb8Ic+saF8m+zL7FY6Rlw3VvGlYSUolNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElyTcFE7HjEfDT1HWM7PdsqzFHBEX1mPvUydQHbez31Tv5+OBmzYKwSdi0B7fgto/Uz6OXpI47qUvj4r25mzAgPE3yUQDiF+9he7dYYOkDRpHAvPoBMz8fBJ3sVpzG2wnOBDlzZs/sLjWJQwefR8ne7JAUFAuyfbeOzu5MRU854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nbfh7obw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f5fc33602so1870746f8f.0;
        Sun, 23 Feb 2025 01:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740303759; x=1740908559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bX8w6VvcKxTEGnXAifeA7EJFOtJ4nitll0eTQFFfjkE=;
        b=Nbfh7obwu0X3ishZ3sfFmfRqCC/D6OoTcE47Ehlo8V+kuuZq9m9OjILoZIsdP4RZA0
         6xfG5WoXQ6IPMNFvN6LYnQk52rD9KBb+TubTf7ZP9C3lm/H22iSkO9H+uCZH0HGG1ZWJ
         UC2k8pJfqWTs6zDDdMD0oRFx8vsx89Rwi3JEGn/EEp4iffQzNjlSnd3mjX76HE/01aRK
         6t39nAAZq1SjcSYmYu0G/XRKWk9umA8hKTGGzxMjG3OOtWdVI+f7pbNqzgjLW+4kb9/i
         xwOlXj0Y81khYL5BDGP+eTf7jkUnNut4coUsj7SE7iBImeRoKLz62WvsdWZX2/2mUZgf
         jpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740303759; x=1740908559;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bX8w6VvcKxTEGnXAifeA7EJFOtJ4nitll0eTQFFfjkE=;
        b=TpE7T50dCKzPYWGhXXgrAsDLbgMfumakwRRZTGYRot6uEeFVOpaZMODwr9HCGG37Hv
         +RhRiluACopvpZT38MjbwBbWlGztpPzdaMzZ/RH0NSH/C9dOz87ZHoyk6MzDSqorpWfS
         rIYDR4v0D5suxfN1y3aHVnEroSuz02EZX6oKAaIcqnft0h8WeiiiOdAIcGppGe2isjSr
         DFATGWU7Y4HjmJqaCGgEPRSpeXhstA/mcz2u+LGlImxyBdd+DXz2lrS1TC0IbaL703MN
         x0vM5ek2tz7gpniAIERoXPbym6x9ilnJKPqsv3PnQnELQt7/QlWtpssbKkti+BeSbMnN
         pVVA==
X-Forwarded-Encrypted: i=1; AJvYcCU+srFXgebMFBjKBJi/x3jvjjXDDOmnetzZYeDZvByzUgrBO09XgdNLWN0xu3asFmIuBq84WKy7@vger.kernel.org, AJvYcCWs0uaJ74OEDQtL8wCtXGI4Mmau9WdJ0KZrnoYkmUM700EwZBXJNHO++OAtlsy4dP0XLBlls8HR@vger.kernel.org, AJvYcCXT1uaQcKPauwduci/2+fcMskD3Frsy32oxnlaPQbYDaU5VPpcd3FZtd00Sra5qhKywPPzkr5A5MItoM3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YycYYt1Sh9EaFF0n+Sw443zMLbSsyy9MI1IGZmw1OHnkTyeokMJ
	DZ/enZPs08aWCX/F25ZV0WY4wIC72AbvvUPU7IFKkJbtFRozOA1i
X-Gm-Gg: ASbGncuv6ehjaWVmA1qaJOS04VoGrPaTxc0dZTGi9FxOfTlgJREnQN5+HEOYktQGIZ+
	O3VuEI9ZCB4zEhSVklofbLz9pXpvLjPJ2usf3xu9iksXoUJDDLo7Li56uAImEiKoA5L4P5C1EIC
	74S9hLMqWMohsPvu4ffPhGIm7xyyJOtz2WOH4XybNaZhIYwY57HThJYWYYuTDMzKdqgnkv/bO8S
	qNa3QT3uDOIG8sWvy4JU7bXfQXY64WxPlbbEsQNsqv9oWcD81kYRXWEV0F2UAUUXqTmp6JXebUV
	wVpgDCCMjUwzIarDW1oNdOBlzwysvB7UuTe4UlP1tOKyf8GdFUSFn7dNFPD+zO2JLCzjne8rxQE
	oUSeeFv9qmwuAYQaBJheJAckp1ZUlnAm+2eigaVQyhBemEB21Y9wjIlEpY+5YJppjG79uTVADUD
	0rRH7Y7xtdCZSavVPL6w==
X-Google-Smtp-Source: AGHT+IFzjHpqDVW8+j1qJ/QnKTQ0fvjvKsF9cBO5hv2oESL/oOai/L95dDuOlOcukroJmzkvhMl6tQ==
X-Received: by 2002:a05:6000:1f87:b0:38d:ae4e:2267 with SMTP id ffacd0b85a97d-38f6f3cd3cbmr7316270f8f.11.1740303759238;
        Sun, 23 Feb 2025 01:42:39 -0800 (PST)
Received: from ?IPV6:2a02:3100:a5ee:e300:25b0:63c3:5128:11bc? (dynamic-2a02-3100-a5ee-e300-25b0-63c3-5128-11bc.310.pool.telefonica.de. [2a02:3100:a5ee:e300:25b0:63c3:5128:11bc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f258b4491sm28006551f8f.7.2025.02.23.01.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 01:42:38 -0800 (PST)
Message-ID: <3626cc46-c267-4f95-8346-beec2a705ddf@gmail.com>
Date: Sun, 23 Feb 2025 10:43:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.10 03/27] r8169: remove detection of chip
 version 11 (early RTL8168b)
To: =?UTF-8?Q?Michael_Pfl=C3=BCger?= <empx@gmx.de>, sashal@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, nic_swsd@realtek.com,
 pabeni@redhat.com, stable@vger.kernel.org
References: <ZrkqNUHo5rGKtbf3@sashalap>
 <6ae5e229-c440-4522-a9d9-7581a7e0ce1b@gmx.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <6ae5e229-c440-4522-a9d9-7581a7e0ce1b@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23.02.2025 01:57, Michael Pflüger wrote:
>> Indeed, I ended up dropping from the wrong local branch yesterday
> 
> So it looks like the patch was kept in stable because i hit the problem
> now after upgrading from kernel 6.9 to 6.13. It's a PCIe card which was
> cheaply available in europe so it wouldn't surprise me if some more of
> these are around and in use. So, can we keep supporting that chip and
> revert the change, or do i have to get a new card?
> 
Detection of this chip version was removed in May last year and this is
the first such report. So it doesn't seem there's a significant number
of these old cards out there. It was the first PCIe version, and it's
broken in different ways, requiring version-specific workarounds.
I'd prefer not to re-add these workarounds in mainline, also given that
cards with modern versions like RTL8168h are available new for <10€.
Alternatively you can build a custom kernel, or use r8168 vendor driver.

> Regards,
> 
> Michael
> 
> 


