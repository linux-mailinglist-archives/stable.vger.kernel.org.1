Return-Path: <stable+bounces-110198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2192DA195C1
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 16:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364B11882EA7
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B6C214812;
	Wed, 22 Jan 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="K2vijbwb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8ED214809;
	Wed, 22 Jan 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560932; cv=none; b=OIq+W0fKq5m/LH+f4D/R5ECWK+NfEXJQ7Crm6XUAdYJ29SEWtEj5TTkROF0f9ZJMlXo8ZoPHAuuKIyMioNeUSwU+hoXowxaBIzQl2I53Mj+Ag6piWAE888sfDfKcPMzgMnlivP101RHwM70JQyzI9AFkTIQ/JvHRyufHv6p8I0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560932; c=relaxed/simple;
	bh=dc+GqdrGn3daNaaZ4C2Z/pJ6G4ucN4JtXuHEYvQsj0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUISHkytiw1iXOdCE9pj0uow7+22vkYG2DCYsnQBFfPj3tim2bobhh3+gOaDSNxYfmPW1Mor5h/VzAJze9pJVaH7Wu5nqbKVTQINq+W3E0wpMNea2lvrIUtbhcWW8VeHxahmUmKNo9nWWUiQR6htRb7gK0cTuPE2x4uyl6jsi00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=K2vijbwb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso49426635e9.3;
        Wed, 22 Jan 2025 07:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1737560928; x=1738165728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsDcFrsPme3l9DX9UB35yNaxrFvwCBk6agQsq7R+/iI=;
        b=K2vijbwbzd/Cbw+oOEjY7RtuhhPHHZKMIav1H2cijVnFrP7f13Z6gS69l8kWHOS/Fr
         MRbAY/bYesqEcH/B9RVAyzdR2ey7btApq94D+vN+kM737m3EFmtCajEu4GPl6qZIHK5h
         Moduq7ImwM0Ei2TOnVvHiy+BPM4nR4ozmM8kZ+G64clEvbIkf04/z5yqPWCkDZwaGdXI
         tfNnGWswK9VoHxfSSK9SaVijSGR/a/Azxi0buAPE18DlC7r/I6y3kBHvUATCdV2ppGI2
         aZvRAQoaBLRuOhREcl5y02I+GvjGQIqAFDi606SWce5QOHocR59trB7/ARbwMQ0FbmEa
         M+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737560928; x=1738165728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsDcFrsPme3l9DX9UB35yNaxrFvwCBk6agQsq7R+/iI=;
        b=bLdmGrjZr6voSZyRS2SfVA3Vl02mei/FmX75e3LZMPZTbPB2mwvGbya0Vvvt4GcQdG
         /DU26pCpfB0LpB1fRLFJxrAYT9m1hUdvOlecgjY5lhN+wBAMOEgatBZO2vPitsRtyL+9
         TowHdk1fBjcixZD7MDvjgkYoLQFkeo8zEGLXMAda923VkKWkHw2bUxEHJYuo+ArKd3ok
         uWNDnX7Qn7p4GKda0tGhbwCmOyB8E093kjXqneaBhy5MZZDKA1h58dpBtn/2Aq4/+wo9
         0AQkPpQTs0NxkmLxzSDReCLZqjRT708NzVKuZAd7ZOdKvVYIGB2MwJeBwZDJuObxLKRP
         TPog==
X-Forwarded-Encrypted: i=1; AJvYcCUUMPkLQrCJgsk/vQbx5zhYtCPxRUrIOek05noATSEY7IFbAA/PbZt8PTzr5NZMiZtI722lP5cH@vger.kernel.org, AJvYcCVOTiKFxyrMOTldBFSQVg1PutGGMa5pV768u/mlvEw0imOVd/FQiZ7J/ouKZVCY8s23n4IGUNodyZORK8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr2fpsWmBiSGOlNkmL8qzBAY6iODT+Toa5bGa5CLbQq6mrqYRc
	qkW9BhRLFZJeFY6R/Yoxu7sQoSnP596rZ2voNmDvrPo1859jzTk=
X-Gm-Gg: ASbGncurwfdBhPk0xIVp6PrQSdxZ8Q9w7WiW+AFERDjDnmiulwmAPhqKi7nJhYfdl89
	aFFplCMtDdy5SDu2Z//jl8KvIxthmrsaipqWgiyZsLgKGZ4c695IjTc0RtmHVMU08z/Cv7r6qAI
	dnWK/ifEb4+hINCTSQJwGCUuJzh87/cBTn+nTnO1//9EEAUJXs17U/vJDsCPstGZkuy7hgpRH+i
	z/aXQ16BmxqC2IcwTui90XdJdnmzfXpGSUV9t2vR7V3P3fNEvpJaZyTM7t33u4fJO8kYfRvnta7
	yRozBzW3IM7Szgd543PqBFgk1vAB0fntkOEv5N0uK8nTGGv12H0IdSYghQ==
X-Google-Smtp-Source: AGHT+IEKxgxW69fSv39uqAq1GmoVXiT0kxTzQy0QL2ylYV6T+j+9vNHPLMq18A7CHF9to+mRJnLs3w==
X-Received: by 2002:a05:600c:138a:b0:434:9d62:aa23 with SMTP id 5b1f17b1804b1-4389142e88dmr185142395e9.20.1737560928309;
        Wed, 22 Jan 2025 07:48:48 -0800 (PST)
Received: from [192.168.1.3] (p5b2b407b.dip0.t-ipconnect.de. [91.43.64.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf321537dsm16871670f8f.13.2025.01.22.07.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 07:48:47 -0800 (PST)
Message-ID: <d3b843ee-edbd-4577-af04-1f6cfca89661@googlemail.com>
Date: Wed, 22 Jan 2025 16:48:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/121] 6.12.11-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250122093007.141759421@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250122093007.141759421@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.01.2025 um 10:30 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.11 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

