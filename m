Return-Path: <stable+bounces-143091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F44AB2797
	for <lists+stable@lfdr.de>; Sun, 11 May 2025 12:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDA21762BC
	for <lists+stable@lfdr.de>; Sun, 11 May 2025 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4783F1BD517;
	Sun, 11 May 2025 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="o7cChpLR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD21D90DF;
	Sun, 11 May 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746958016; cv=none; b=NmMYpBKgCgl35MhO/HSPff/OHIB+0s4Vj1h+YDeEUkUoTqiptbyyZAFghrC3Dg+ld1DR9MCXEdmvD/3S30H9KRdmeV/WUAcaaS3etGj1EvRlyvWISRJMCTJzvyx7kl5sKG7GakeMnyzQR8h4QoxEd7uXdGTdHSvkDrokuecfLu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746958016; c=relaxed/simple;
	bh=ecMx789F5Vg/RPQ5wRdMN862Uy0ijh2j4WeM5uJzVUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMp5AkdrPBsXc+X7szxFj/A46YTuMHvlOP6bGr2Ifqd5ekPDaalMx3lDhVZ3XYcIw103f8yvviJlTvxpKs3G5/0hRUwmXNN8kQC5aSeSLwgM+/K0RWuidVTPgrZfPhMZO2R0Th9pVhP64Bt5G+YkxMdeY8Onm6FrIzFk685Qs3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=o7cChpLR; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id E3ZuujUIDo5ZmE3Zuujbjy; Sun, 11 May 2025 12:06:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1746958003;
	bh=2b7cv2yWBNFADmDj+Itq0PcA/9RDLFx2AiUfgzSCs3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=o7cChpLRtUolwURdh3f7hQMO2rPRpncmPxXq4eZ8W9TMydCzpT78+HidFdeIakzG7
	 iMF2u9K64YLA+4ABN6XYaNAC1aRUxJHrKRCXK5D++7CQZQJsoeYRnpMRaLKxSLs01R
	 DHjqfJTnNtfoSvfZFePa5CoLYRCSdFzWVucIbcnHFWVVqPHeSZKsrR0B5WrQD/UzYQ
	 vUav5y7wCUhosRPsSQXXsszDu4pBomkpUESW7LOE+ar+oXdsropv7pcdwbpfByttFZ
	 SZylaTQV6/MUq6HV2XSYB3mvLwl5gUiNVAHtIF/eRM8DxSmuUZJDXqBrWZXIrlfOrn
	 giYJRV454JDDw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 11 May 2025 12:06:43 +0200
X-ME-IP: 90.11.132.44
Message-ID: <e5a4fc33-4fe2-4078-83e5-596dff96bef9@wanadoo.fr>
Date: Sun, 11 May 2025 12:06:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] net: phy: aquantia: fix wrong GENMASK define for
 LED_PROV_ACT_STRETCH
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250511090619.3453606-1-ansuelsmth@gmail.com>
 <aCB0dkhiO49NJhyX@shell.armlinux.org.uk>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <aCB0dkhiO49NJhyX@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/05/2025 à 11:57, Russell King (Oracle) a écrit :
> On Sun, May 11, 2025 at 11:06:17AM +0200, Christian Marangi wrote:
>> In defining VEND1_GLOBAL_LED_PROV_ACT_STRETCH there was a typo where the
>> GENMASK definition was swapped.
>>
>> Fix it to prevent any kind of misconfiguration if ever this define will
>> be used in the future.
> 
> I thought GENMASK() was supposed to warn about this kind of thing. I've
> questioned in the past whether GENMASK() is better than defining fields
> with hex numbers, and each time I see another repeat of this exact case,
> I re-question whether GENMASK() actually gives much benefit over hex
> numbers because it's just too easy to get the two arguments to
> GENMASK() swapped and it's never obvious that's happened.
> 
> I don't remember there being a dribble of patches in the past
> correcting bitfields defined using hex numbers, but that seems common
> with GENMASK().
> 

There is a compile time check, but in this case
VEND1_GLOBAL_LED_PROV_ACT_STRETCH looks unused. So it is never expanded 
and compiled.

CJ

