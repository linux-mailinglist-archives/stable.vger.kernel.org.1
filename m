Return-Path: <stable+bounces-106065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DA29FBC6C
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 11:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11A3188D1BB
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 10:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825F98C1F;
	Tue, 24 Dec 2024 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Qwkcoc3z"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1A1B2182;
	Tue, 24 Dec 2024 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735035875; cv=none; b=g7YBazdxb1jDbKMl3xOY0tPoHpOVVDV0pzUvkQkT5go7gxDW3WSp3zM0L81rGzZR36ELXckjjJ24fbcg/IjXxvaiJv0FSQgKurhi1WORtKWI64cahYmOqHFd0baruoQaiKSTP6IOqBtcDj/Ph4EyyXJgmSRljET/PphZEmhK5m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735035875; c=relaxed/simple;
	bh=/CA7NP/ZnP3IwCHSo95O1qm/7KGv2E/O4+51jpt0foU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j32Dsq3Idy3LISrf+sN9oELRvf/9DElwOfkFS55WivTWN6mYw+7Drs+7r8kAHmPkRGGLl23/pNJ9dRTH8GI8+dBeIuzuVTC7DL+NWfDi0PhtGZT/kDaVK2ljTuEGAm9awZHeXL63ScIWKZeKODbI2wB6rca+FQErxDBlUU59+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Qwkcoc3z; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aab9e281bc0so902532066b.3;
        Tue, 24 Dec 2024 02:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1735035872; x=1735640672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A0n78WpQljE2rbLAC4m2xEeIo/FCq72TLzeQgA1nLoA=;
        b=Qwkcoc3zFbkvN69oK6m5+DqBxteSlk44iE4n0maXkmYwNo3s+n2AsTpMwyFWbfOgy0
         9YOxZMe2NXyRxNYRMLK0tvxSiGZ3wKpmRnD+dGBPnFnbKW50PhOYhfvkrItDQgWTNic/
         FQCrodxcqnhX52oflg6NpT6ae4RSjxOSjV766LmfAHz8gLBxfiqnsAN+yvOoNS0ULPjA
         Zplf9gDlCahvetBfKbde9lU6H6IUTwTul9meLkeTGeiGZB8h1YsW8vj4LSe+lOL29tyz
         YWwAsHUYJZOTU4FShIwGsUGj2+IacR7GEyYMbpzeFo1mCF6WEz+hhjASezvLl7DBIK+F
         ZGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735035872; x=1735640672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0n78WpQljE2rbLAC4m2xEeIo/FCq72TLzeQgA1nLoA=;
        b=j49mYdp7CctffzXLG2gMzaXjIK4BHfg+vdJTPAwJyk0NTr8ko5B4O8a0xWTjnXgYzY
         5G1sJ8nP0Yp8p70MfKIYmfJUoagLOi3BxAu6m6St4l0THGArFT75HufSLwJ5a0Zq16Y9
         AW4Om9FY0/DIXL48KqEI5YicDSs3wqJ8WJ4eqFR/w04v/WqA6m3NZXJ0Jp+ZVd+r+ET4
         l7dSzFGW/CP5Ix4JxnIjqBd0nDa0NiAh3j3QHT2faRj0yInH/9Baa0xY+iSW8cE4Spvz
         5smpw2uHr1vJYVDNe6M/VSACFmlVFsZJWec6E1udFt+NejjPTLpa5+/FyMCUBXuo3iIt
         o0Ug==
X-Forwarded-Encrypted: i=1; AJvYcCU2qJdnCNJ6ALfP3a7LPUyMWtbwu0maH0oc91JjpXJq6ZOCEfNv5CQ9jXZNWkM1vR6M9D0ypMhcke37KZE=@vger.kernel.org, AJvYcCWZCfLP+P+ESv7h6S3aEOYR9yLYn+8AFhUuux7annF6pjxcHEV6VjC4PBEGmDIvR1mPS27NZwLp@vger.kernel.org
X-Gm-Message-State: AOJu0YzNWhpenE0twykRGJPLDe8IxOmy0sCMdATrQTdEVERSPxvZqaZD
	qkfIn5ph9fMZVx46gop8xr6wNxNuFnb64EFDejEqCLFemYEs/Cg=
X-Gm-Gg: ASbGncsAAEnTkSKxaov4H3gzHwlls0/dmw9RL5Y32K0OMsVGDNLFs3EpYcBdxG4ya+3
	lO4AXVdGLKEdbdMSbc0dXd3eUo6JTMzBjlBHuEg9RRrs4OllKellZ3anwTjDvmFLvh7866Pn5Sx
	gkNhnB5qheMO6i0zXpJOSPQf/TzX+4ocU10PGfc7bU+CRXKWUl9jlKfCVpImKW0iM4Rpc4RY/8R
	ZJD0mceOb/rU2qtSISkZCuhLAo7PyaxZVZIGBe6/R0tMhw/gkSL1Gcp+stzJKPSHW8jZdqZvAse
	U7jsVwCp0J7Xb4yH/afh1lQOmZCoD/kkbg==
X-Google-Smtp-Source: AGHT+IH2Fu6UrfuoQYzd/8BSulBII20PjE61FFFezoEMOZlUroC5nNqnJi8yGge3Oeksh/Ss8h2HFw==
X-Received: by 2002:a17:906:7311:b0:aac:278:98fd with SMTP id a640c23a62f3a-aac2ad80073mr1512834266b.17.1735035871723;
        Tue, 24 Dec 2024 02:24:31 -0800 (PST)
Received: from [192.168.1.3] (p5b2aca5b.dip0.t-ipconnect.de. [91.42.202.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f066130sm638624266b.183.2024.12.24.02.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 02:24:31 -0800 (PST)
Message-ID: <ba78c121-5952-4cc7-907b-9ba74dbbec53@googlemail.com>
Date: Tue, 24 Dec 2024 11:24:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/83] 6.1.122-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241223155353.641267612@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241223155353.641267612@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 23.12.2024 um 16:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.122 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>

Happy holiday season!
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

