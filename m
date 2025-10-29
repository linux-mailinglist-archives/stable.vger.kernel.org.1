Return-Path: <stable+bounces-191641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140AAC1C303
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 17:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA413646BE0
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3413358DB;
	Wed, 29 Oct 2025 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Qgvfddvi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FBE329C52
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751761; cv=none; b=S3fkurDh0R64VtAWMCt/u6i2aF1ev0F/iwSpfZH49rBC282fUivxUOY5UzsdfknZxRTYcsFLfwHjcbdbj9UW5BmQIoIRnZqwGC7ZAHlNzhvyzlFKDmYu8gKM/wpsr7FnGb0zBtrRQGsVvN2t6dELIo/bqvwrjiB0V/bCQxrSwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751761; c=relaxed/simple;
	bh=TmGjDwl2biFKFoDG5SxYDx3zPkhg2VZY+lBriMDwGx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTerltXzj7ghn3OCEDhnfupsX6tsKMwBR9gXWNcGuq4bVeKyStVC9VTrKVdU/Eg0VljBT/ZBe3eYPgvGxIveR6xUYK8hm1vkI1HAa9aMHVyZDZcpki3Ch4KzFYMrRfEVou48ss9MeqG7XaIbyDmkTngoFnPg6tsButnSmnZdLtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Qgvfddvi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47112a73785so47433675e9.3
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761751758; x=1762356558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ctrvyyDmJlg0kkSAOlpyChaeCX1qtmxwTU/oEiWOUXQ=;
        b=QgvfddviuL4U1MV5cXmGqID6ZQRTMgk/pKJAyTedB4yKgt/5I7fYI3uX2K28xRIB1f
         niJcAZwrL8bGENW0ANzIaHDk6lt7dEYnHlidgcroyHA5fvQPekk7AUVysieHtMK29Mfy
         nbwyR790XFJp3ZQK1xKKIY1IpWQq2TsTgtJUNbtY9+JdEoUwPUz2IDOFLVP/Kvu1rNOh
         /Xr/XrD3Q3QHDgHwF0MVAFuVK9oiiZWAcI9t/oM9LAOfGhiBNE4ock+UeXE4t0Sr/ZHL
         MQsOzXr3W/C7B9HqiV1HKo6+ItlZlJSkLZzgClPUyqfGkUpXBBMeOeaUsvEfzzS57SIG
         9/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751758; x=1762356558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctrvyyDmJlg0kkSAOlpyChaeCX1qtmxwTU/oEiWOUXQ=;
        b=DorKvgd/mjrbsoAn34aufU5HFBF3+WFF83arMmRvyxFbdUJ/KmU1hAjwOE33FcfOs3
         VYwmOOeOe356qZWZUfOnY4I3ezbQL6nlkp8EWdZCYesm35jMnoHvfuaQXA5/VOTgEOR2
         wbiIcEB2U73zSgrN5QDWcumelNXWF+pbB8kejsQ6tdKDnhQdOu+EbhiqKbW2jf7GDySa
         IALApPCxm2CiEwc3+w4wcqY+iW+kMP76WDSWj0iYIzWFfkhSvn/rEMDgXvGWeHXj7j2s
         BpY/UFxeP/pAff6YIWGTkvguwsXAsvGDujvB37Vjd6EDemtNitmAtFZUmF1hZHKmllHS
         oG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyVx06Svxj51WBt7ddtqE2h3TPNv8gvHatst0dPxyryG2Vnqo6AYfXUb5UD/orfO9AxNmrZ1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFGFGq9bJtFSc2Z80wX3OZW5SXaZcXXgmqSNCbp/CypdfceAp
	LiX52vPM2pKNJuBZqkRTw2ctip2REo6uOW0LeXKRgECLGvQMOUhdmr3M9VsJy/zjFsA=
X-Gm-Gg: ASbGncsZgIwLDpw0xwEUNpBXZfkTSL+OeoY+JjwJYzTkaWU9db8XYFiXiDS74JFFrTZ
	Z2b4s9tQWNjwtZKLQryO8Es6kDqBQrPCRB/PtIYa5R9b5QmCPJ35DTcpR39oyvlG0FB5ZwPeX5O
	g1eb+OCSugHjSyAyDzte3XcLyofXyLAXN3P/Ixuy0opFBG65fZNKY41/xvadmXvjzVyC9VS6egu
	5XGNqikxbMGjM1jeya8k0xqyAntXN1shUOIGiNdwVIRhD9t2PSflEcUxkPV9Lai8J+a5Y2ahmCX
	kyneKqcmpF+Jb3U4afw/AcJEBSvKErzEQV7WOhDy111FuyC2kgAXuraNvZgZJ08R+SiElbHT76j
	90afTt9kb9wIJVI6cLblT3j020WBiZWLxPskYd52zfRJMgElhdkS6J/rt2DULtQ9CI8zxmXxD/n
	PU/OYTTdfgyGNEWyvKZFZvia7nhCNi4nTrGwyd0vXt7dKnJHNSGP6Yo6PBCNGMEuBc7g==
X-Google-Smtp-Source: AGHT+IGzKqIEUwGf7yC1EsnKLvYTprAHG5oxW1NDlfiVKv2vlfeP0rhWW9WukDhz1d/BkHuM2+I88A==
X-Received: by 2002:a05:6000:1787:b0:40f:5eb7:f24a with SMTP id ffacd0b85a97d-429aef77707mr2833160f8f.12.1761751757674;
        Wed, 29 Oct 2025 08:29:17 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6302:7900:aafe:5712:6974:4a42? ([2a02:2f04:6302:7900:aafe:5712:6974:4a42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cb55asm26959094f8f.17.2025.10.29.08.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 08:29:17 -0700 (PDT)
Message-ID: <9d254e18-2e2f-49ce-b785-ef0f16117550@tuxon.dev>
Date: Wed, 29 Oct 2025 17:29:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: codecs: Use component driver suspend/resume
To: Mark Brown <broonie@kernel.org>
Cc: support.opensource@diasemi.com, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, biju.das.jz@bp.renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20251029141134.2556926-1-claudiu.beznea.uj@bp.renesas.com>
 <20251029141134.2556926-2-claudiu.beznea.uj@bp.renesas.com>
 <84aabf5e-c782-4e40-8e34-c8e7101188fb@sirena.org.uk>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <84aabf5e-c782-4e40-8e34-c8e7101188fb@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/29/25 16:37, Mark Brown wrote:
> On Wed, Oct 29, 2025 at 04:11:33PM +0200, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Since snd_soc_suspend() is invoked through snd_soc_pm_ops->suspend(),
>> and snd_soc_pm_ops is associated with the soc_driver (defined in
>> sound/soc/soc-core.c), and there is no parent-child relationship between
>> the soc_driver and the DA7213 codec driver, the power management subsystem
>> does not enforce a specific suspend/resume order between the DA7213 driver
>> and the soc_driver.
> 
> Oh, also:
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

I messed this up. I'll be more careful next time.

Thank you,
Claudiu

