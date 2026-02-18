Return-Path: <stable+bounces-217211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBhvGMk1lWnfNAIAu9opvQ
	(envelope-from <stable+bounces-217211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 04:45:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78895152E31
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 04:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE6E53009E3C
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 03:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEAF2F0C7E;
	Wed, 18 Feb 2026 03:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ClV0Adsa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550827381E
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 03:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771386308; cv=none; b=TB49fBWG9CcYGfoOCnLkEotCzgoG4hL0oeaGTXgiRPUrlcQqcBnZcUEBr7bzOgIkUA2CzZTwibY3SzFvKcVyaQBd666Eannyp5yKg7PUckyN34fhWFytDbOITPHuADbV66k0fCzoRthZpKfOTz12fqePSPoCfz5899gELkrWIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771386308; c=relaxed/simple;
	bh=dMA4ZOIcC9gE71pxUT3mhKMQM9zq13MqU8rVY3q0k6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjDfnsR1TAfestS9qRVFuT49f9aJ6lMoI4QZ1qkdyNXCfXejH1plGXQa1pJxOn5VlAq7nQKpdIUwRO/dJTWS1mgMb1fLmF3EHDva3kccknhmNOaFhT/cf/xC7luRwUs65UFawGDtBuasiP+UQS6luG8HckCHbuTwg0uAd+8HiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ClV0Adsa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso2424225e9.0
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 19:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1771386305; x=1771991105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cUIuMgMYT34LDNMJkmYdB/Yzp4mCe6KCutQrOT8Nnsk=;
        b=ClV0Adsaq8L/2o6OW6dj8I0GO9gWH5ShwlrfoV65PKlnfx4xQtv1U43AXMdvoXd+3O
         p2QKHRJvDZOQL6qFdxBMidkaAPgMD5cGoCiNu6wFbpEQxXRyD0YBi1OzzHX0tT0aZid8
         XqfY/GUo6Uy2bcX9fqIXiYtY961nRR0XAFKPX1owlpKA76UtKvexwpJAGgnj6vD2TRFY
         etOKc5bH6+BkMwRSTbqHCnN5Xi5yvMR9nzULh0wdP6hPjfw9fKIayRGXFeJdyx1GLIsi
         23IRfCQVsiTJLvuOkIgE4sRNXhPrHqXGxjCrnZc2cMArn2hiRSB/WEbEwmqKQDy0n9pm
         pHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771386305; x=1771991105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUIuMgMYT34LDNMJkmYdB/Yzp4mCe6KCutQrOT8Nnsk=;
        b=i0w33xUtkgo66+KeYhrmZ5U+qP3mjnewdJr4GTx6q5OEqoxeDnURBTf+fipX2Og3JO
         +VLQQiY+ou24DGZ6mav4O/lrmZSIvuohaERpwEmGaOd0zs5nupkmVplMHfKcR5H36jsc
         JqE2aayu2l4eXhM5GCGqfAgvPfrYzN9esOrb8H9JZtZOIfKLTg6PQKdaU4NFy4aw8lya
         PxgnVYQ3E+GdPLhRw0k40AiQ2rY0SeSfOIn3VdeFyfqVJV7qfsxFeAxmOY/xl+9p1/rP
         l9HoL4Fs++UVTTyXEeZYkQrWN4JMNZVN307Bry6vgmkg3waKDXS6jV0ya0cMrMAWLmMC
         o5qw==
X-Forwarded-Encrypted: i=1; AJvYcCXSMgHlOyLHHe6Axe4awkqx8n0FF+ay3mONn0SQo7JVgvecoOkCpxrQYzU08kuVm2qxjS97dOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5/kA4gQhiJpHYcJ5YIfWbW75jsJkLppXs28ut4Yvoc4jYCUEs
	oC41z5/o1wPHdRSvpLiDdp16j/l6EUgQax188GangZZDRMy5dFYj7Ks=
X-Gm-Gg: AZuq6aImXWwntNkPE//wJSsUQsrLGj0GINpH45gpK7hwHIUToPOyTYA9Wtq8Sb/Ninc
	Kwn3bykRrz+DaGdEGqVR6cTwunNNfpz5Ev3FwAMQkJBf2XoFcKozWND8ZXxYPyEhW807GEgvYGg
	lGx2VtWFI6XHEvAhEOmcWpAjSdFEURMxgTa8p3yOdK6Vj8qsIIY/lLM8feMkDvWy+WOu5kKupBj
	HB/5I03IGMVs6eTkWVaOTUaV/6L8K4nr7IG9rIiPd4ERCRg0eoAsPNKUB9wJfbtNlOBjpI5oElB
	zTAvgO2JWEMeoEk9KPIWaaWUta9ICSF4/PrR2uQxJ6KNGVDsdYtkZz/S3owXrBiYfF2ekbEHADV
	y+k1ghAZYlqRKISJwOxJz+6Z8b7XcHJlgY1FYHZeNwBGLANK6EqQrDShHTueEfm/oDQhOys2lD+
	FBEhnbwZD8/utiiW59iNDbYwqAGQ63jW6Ur2bTWoAx7SYQ5dUOL2oJqBWBs79uh0Msheq464wlw
	f0=
X-Received: by 2002:a05:600c:3e15:b0:480:1c1c:47d6 with SMTP id 5b1f17b1804b1-48398c6b10cmr8806155e9.6.1771386304960;
        Tue, 17 Feb 2026 19:45:04 -0800 (PST)
Received: from [192.168.1.3] (p5b0574ca.dip0.t-ipconnect.de. [91.5.116.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd1bsm616334795e9.6.2026.02.17.19.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 19:45:04 -0800 (PST)
Message-ID: <1d506537-48cb-4440-8042-f65f78cf597c@googlemail.com>
Date: Wed, 18 Feb 2026 04:45:04 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 00/43] 6.18.13-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260217200006.470920131@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260217200006.470920131@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-217211-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 78895152E31
X-Rspamd-Action: no action

Am 17.02.2026 um 21:31 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.13 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

