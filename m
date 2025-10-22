Return-Path: <stable+bounces-188892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 57523BFA107
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 07:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF047344221
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 05:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66AE2EC0A7;
	Wed, 22 Oct 2025 05:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ht7xJMnM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7352EC0AA
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 05:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111281; cv=none; b=dCHVnDrsc7wXA+GrX8+w3foPogrkoZHDxxkXD2CzI3rqR4HQge4GE+G9xyBNQitOG9We0qF3UELj8mj2b9Yjs128CpFX7kFgT7HYQA3POdaY0JRCpqaBhNI3bst7kpn0KZzNY0ekmBEEnprJi2/WGu/+KdfGesmJlUktRMRShzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111281; c=relaxed/simple;
	bh=ldk5TdLLZTFBYkEv1AWBaAyL2fYJtBrRgt1mL1omDZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCxlAI6cH7J+CZLiaYGL2mGonySgB650RK8g3F7KDDjPHy0KPp6QeFET1jK8FhQIyx2o34X7HgM2LQpZt532sc4zYnrc1vaBUqXHiDLgpJVe2LLuqZ9bqeZwFQg3dszxENoqR6oZAmrvukAc6YeaZuQch2CMKvJ/hNFm38CV3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Ht7xJMnM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso317568f8f.1
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 22:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761111278; x=1761716078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mMeiaEiXQbpugBOlm80cBlO+udw+z23IitsqxhIG+U=;
        b=Ht7xJMnMSgoSwNACiMCZskGh1NsN1jQTHJD0u97FZ2oVg3L0N2bbuRYhxyZBAQh+Ti
         GwY7ah9izoB4CnlHl8FZhYwPVIPlXr0Zwkd1J/0y8w6pzDqfLBG3O9Bp1cM5468mkQY4
         MwCYa3/Y8lpU1G+DS11Xy2ov9DTIgMjg6jUzPVyWmAcfsTi4fFPHoRGGv0TvAoAbKg/n
         mPJfP76wss1uE9SCLsK5NH7H2tQVs4m3Y5Qbd+gzCX3QwlX2HBICKMpiuBvE9qviLAU2
         XlKGBGcB93y29uP3u7X7PDHrHXjOmeDFSmvitSADD2HE5BgFemxF5M0Pcgo900QHbszL
         LJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761111278; x=1761716078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mMeiaEiXQbpugBOlm80cBlO+udw+z23IitsqxhIG+U=;
        b=ET4H5Dzj0Gd5Es3yup+OQtKJo5VVl4HtW3S0zNbMJ8HBst6Wk1HzOAKKuPXnCVO6ZI
         HWJlbXlJCYKh2FQL71sek6OUhaeRCatgqvEleGzKooJ0Zby0M5feJ7q28eGwaq1uxPkR
         g0Ak4cwIaK4u4kIWHBm6o+Ul9H+am1OEVtf6PzoZ6akoc0f61L8wdzj+Bwb1g5EZsOXU
         wNdj4O8bCIDn8eCj17sYinY9uAoh+uV+f3Y45PV3H1KIrJNSoIqMGcKHq2hTAfEyBru8
         Xw/Hy4nqObXL3WJkMSLQoS+lPa+71kJZ851egdvzrdNjFaIOARseWLp/bb1OwwSshAch
         /mXg==
X-Forwarded-Encrypted: i=1; AJvYcCWLK/pVyqVVQ1yuo4RS9Zc5NagP4S5koc2BSaTFGGmm+8W7vYzYWZ/yCEdBK/q0bnu2ACE9RQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy92dU0085vpDFC5XebsyjADWJhFdhHTf0cU6kPraF6dPj4r4WP
	wNkxlZVAAi1dj7IR2HGh4UiCniGkJmiSlY7f7uugVbdvxCop7F6wse0=
X-Gm-Gg: ASbGnctuJMf8/cQvgTegyb7rNRgKWnEUd+gO3QbkDdK5dVPEBiVUs3fmf25BCIQhpJ+
	94e7NudVAwpUkym63c1siVSOc4me9Fofe73CHY11sReWB1FKUFMa4mUEkVx9NTTHSAyL4d44L8K
	0Hwf+KIVmlGsOZ5ACWOeO8G17wtpUbsDl4S4C+L0y9cq01QCcOOtP7SsAnMSk9Ia73TX3nNH7IP
	dbH2VFaXKkMiW+hgufTbEOuCDQi2Qv22AGh5S355SMm5I7szfPPPd3j3tCv7erfYcPkiJT9O7vf
	Oa9onfOiWSq0QhagnT4gqofRmgkn3sFof3g5codD2XP/21H+Y0SLWDJ/uAUTNYribjd/izx7FZd
	OUCL/nSTlDVNwn7Ds3hbGf7jiF2VljcvtzEX1HtgV2QQrY4H4IcynpnCySfBXz1a4+1UNTyGjx9
	wVeACWFtV7Q2hzDR+OYTAN8PonTbtnhwfQcnTMOIq8T30oblBis3kK4iGJX5v5+g==
X-Google-Smtp-Source: AGHT+IElpJnBAYZBYn/zxT+dS12Du9jHuFU7OnELD9ztkVKohPHBRk6At/TgGOKVDvcl+og5FLyKYQ==
X-Received: by 2002:a05:6000:1843:b0:401:8707:8a4b with SMTP id ffacd0b85a97d-42856a47036mr132326f8f.13.1761111277947;
        Tue, 21 Oct 2025 22:34:37 -0700 (PDT)
Received: from [192.168.1.3] (p5b057850.dip0.t-ipconnect.de. [91.5.120.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c42b567dsm25916565e9.16.2025.10.21.22.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 22:34:37 -0700 (PDT)
Message-ID: <2f03d1d3-8eb1-4585-bc84-d270c4875419@googlemail.com>
Date: Wed, 22 Oct 2025 07:34:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/105] 6.6.114-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251021195021.492915002@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251021195021.492915002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.10.2025 um 21:50 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.114 release.
> There are 105 patches in this series, all will be posted as a response
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

