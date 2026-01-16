Return-Path: <stable+bounces-210034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D9ED3062A
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 12:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A51C4300C6E1
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 11:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485C536D51D;
	Fri, 16 Jan 2026 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IwRCivuU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF484309EF9
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562612; cv=none; b=U/gDzoakpNQiV35shp0sEOg2bnxa/S//gDtcIuUji1zDyTGxxKaotQl+sT0uI+fYCWjQMmv8C+silbCx6K3ux9g5eA5+uQlKXq5hNLiB9vjpQ3ipHiEywktWFvrVgGLP0eKgTfaEUqlTY4U6RBufJWicKLd55k1pJWDkMP+EOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562612; c=relaxed/simple;
	bh=DU57XOxJdlBprV6mgMT57VeEOn/qjLaetAEwP0bfBSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYKV73GxuoX0zNJLlNgIxcHQryC0ftN9eQqeFLQ/ITo4CIJxqzXvuPeJh0O07iVW48M7HpeI2hyt3PTXTGpsjpWceA5e2yQTEwd0+A48W74XDgHm/AD4sv8nSPhJMIq2mVPGXM2mQydhGccXIhmoH+TelsT0ITMz7xE2IYC9Zts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IwRCivuU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432755545fcso1154673f8f.1
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 03:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1768562605; x=1769167405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kVre84BNbV/mzkw8hJClwy3HqMHWh5/7KfER72W09Tw=;
        b=IwRCivuUq0V13+CYmn5DJ5Hk1rToY4TOJ3loLZzOxY4zfOPPjFrXufCnV06Dx4RJU0
         aND9a+hGZewr1+AubyA4wgZT+bU/jRPkW+pGzCRKh7xzTnXDMEGR+M3pnGzKLeCPZpMY
         T/Vg/4VqLIUsaEk5Qzn6UqKbGjYx5cW6AsQFLF6uv0eSHsWaQbmtwqgeVdhQT2HuV/gT
         OYdQXlUnBoR1r7S7S5oCbmrlRxiRczhXgl5jWJzFsfy+A7zTaaZaUT9LRiRrAUlqCtNn
         Tnrm7PeWxLpU/gJNiqbBNfXBq5YoC6eHaEwCublqdCwRkCt3pa5lRjLgCzeh+0AmDv+y
         fdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768562605; x=1769167405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVre84BNbV/mzkw8hJClwy3HqMHWh5/7KfER72W09Tw=;
        b=X9URUSlo/5MnvJybxUuckezqL2bjVrP/Lc130gRIj0DZYBqETD2mflOwSS5ee3/8n2
         ZAbpnyj0PUBVEdMJMAtsZNfFFAXENAhGbUz4Rvt4CSO8C/ndAO1dPuYhyQWpA4Sh2Cuk
         CHywZTYjD5g0Rt1u8a+OolJZuD7GS1f7X6w9eefzLsHvrS84yKI04pl+92CnPYzYyCGl
         y/cVVMsYJbqeRgPW7EDcOZy4Vpyup5bodY82hAz+UqPJzBbxR6x+CRJ40CWlksLg6OST
         4ufTjx/8adkyGq9ndpfBGwJK8HGEl6sagNx7DYSzh1StokIbMSXaM9Q0b2XWUGjKly0w
         JgiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Un6gt85nl6RiVGcqBWndIB4haKZaG4GWR+jBU3z9UCj4ADmFxf9KhgBXvqXO5pIxMgcevQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUaTona/taFNdynQt0EViG+lha/HP78pV7IU+IH8K8ln/YVKQ
	aMyx2l+DFWGK0vFcqocaA1O6U9IHQYDbkTngglvbejklWsqz6f0DVBFAvn8iAQ0=
X-Gm-Gg: AY/fxX7dC3EZUY/i0HwebfnpahIUXLBlfZBlcMS5T+IX2dzb18pvxTMxwfETNco6ecg
	EWmOPeXQaf12OofwIFfsCFY3jaTuCn6nwaAvmDLET3reX5kswlwLuB9uHsr+KJBh1y0/0hg4rtY
	7SEkdc8+boVBkzM77iTEATK4jNmopGEp3ETCFNrERY/pYJbK/mx5kMeAv6IvZg3qJ4KgkaCm5jE
	jjMFGJrEQxNtojhLvb1Rg7DRgwpToVS3cJXof4lNtrNf3MOBgJ2alX3u9fcvaKs1ayc6zF9trsV
	aUueFJVUzj/fgdMeBIykP9eFa7HpR/d31BSQ8TlSzd+Df14xQDJlAjTcjpqK5sJQxpxIECjjqqa
	+Ijv3Roymov28Px/2hs2rHgVHQDnSLp9y5Fwha3L1/7icq6BxTa/ou9NkYDDhmrkpwSU8Cnuqx2
	o0OUj5UI6OHKtx4r1Z1UT7tWAm7vVlTDeOEiFuCFKRjrsRjAiLoRzKbKF3U8UaxmG/
X-Received: by 2002:a05:600c:1c13:b0:477:55c9:c3ea with SMTP id 5b1f17b1804b1-4801e34fab4mr33658435e9.35.1768562605138;
        Fri, 16 Jan 2026 03:23:25 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac8bd.dip0.t-ipconnect.de. [91.42.200.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996cefdsm4617486f8f.24.2026.01.16.03.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 03:23:24 -0800 (PST)
Message-ID: <520a8e4f-35bd-4b49-8b7e-78b2552961af@googlemail.com>
Date: Fri, 16 Jan 2026 12:23:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/119] 6.12.66-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260115164151.948839306@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260115164151.948839306@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.01.2026 um 17:46 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.66 release.
> There are 119 patches in this series, all will be posted as a response
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

