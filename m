Return-Path: <stable+bounces-61939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AD893DCCC
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 03:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE975283F80
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 01:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E044F15C9;
	Sat, 27 Jul 2024 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ShcPXY79"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B8EA21;
	Sat, 27 Jul 2024 01:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722042348; cv=none; b=JjPbrrsxKNxFN9rVlng4Xw2IH43OfQrbySntKjK4Mk6nDkIZRjTDG9G3AIOQBj/K/8eReoaTWzm87rjPq65PDtjncQ/lYapxqTEOKDygILPD/SsIYJxZbSBD0T3e8zODzulXd8k8sI2usuwcoZ1+MZwvN6SSRc9QHw/+h44oL8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722042348; c=relaxed/simple;
	bh=eBM00HPHPHHPgnKiqzyJspcHdFqwmz4Hw91GAOe7BsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6YA3y3FuIO32kmYoNkN3ueyhwejPVf8MA6Jln7BYDGlhdeoU/1Hz7TBm+GCRQkbiw4B7ze1fFQJeCYb5TgDnUuxMoFhilK5ZAYJQ1lazbeZViJbH1rwo5QKDC7oRjjftuAKi89AWchpjH1h+tCY62nWM41EN8kvyG+NBSOaUhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ShcPXY79; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f035ae0fe0so19860111fa.3;
        Fri, 26 Jul 2024 18:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1722042345; x=1722647145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCpYlMHHYU/MQ6aVrJgbcTOmXWPj7kp1NEbwn6nBdTQ=;
        b=ShcPXY79dDRT+81ZSQpryuZvdbC1+eL15wq8cVYlc7aJhTwQKgq4yDLvbxhjWKUdve
         Z3YzNxw5Ehjv4EXerLaIJ3iz87X2ZPrGVW4UE61n/z8Kj3uE43ixFCN8Xr1eOrTkJnsn
         ehlXCFYegss9SdVpJa5jxHh2/ajmiWzDxi3Hm6vHgGCBzFt65Cs8+4S7UhWBTbuNobX5
         cFevPEllLFGsv+sGsZncOEy8nFBW44IGPRiYlGL7Y0avzSLP/kDjc4L1kCM/6ZeskjO7
         rLOeIXT329rtMNQGwrzHCIIZ0/AuNPGAlUpArQNp/O+ZxoRcx5EU8XHp/UNcXyYmp79n
         euTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722042345; x=1722647145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCpYlMHHYU/MQ6aVrJgbcTOmXWPj7kp1NEbwn6nBdTQ=;
        b=NVePkXhBfQt6qkAl5GsOneB05UQ48vvrZ+B+PpOG/CzkXr9ylrSopEfLZAWo+F08MD
         fqLFG5IGf6zZcr6AeTRugUVHrAxPIfsLWjrq3sO0gv9R2DLfI5QT1ekpnUSwADyOVHcE
         tuwcqst/ieyLRbQY37UK69GGw8hgxRXDdgTNfZwTaJTsfQJLpp+2mEXDfLy5U4CR6vv5
         lLEYN0UimQ1l7147lnkXIHEDaQges0uJxKXSnGX6GJVk7mAmhgAvR7L95MAtBrTfiFD1
         4iIjh2oVLnfr8XXX/QvnTryoKlzAfY5V2iLdS7sTi7WjV6Qqu8hQoUCneu3klmcQT54p
         ZARA==
X-Forwarded-Encrypted: i=1; AJvYcCVrN/4/aATAF8q4T6jgsa8ujkIX68F3kAek1mBgOSPU31eUwi+lUIMwSPGFPos1QwPUrlUZOnpuDTmy4+1GPJKbM8qInHUsmCfYzhaQymbBfNyIjiZQ6EZSFBeFbhmx9oqNvE+b
X-Gm-Message-State: AOJu0YxqbxuIqBNOcCuKfjHPrqVD4aJnJiGIAjwo7I9ycFmiPWhh2j2p
	qz+Y2eGWjvV1khtB88Qw/H5zZ071y4xTyvuqShLC3dWKveQq6kQ=
X-Google-Smtp-Source: AGHT+IGtGvxhQRAK565ipUYI/VEWvAFVhGLiYkiIBm6tZ/FoMfehv5V035vAuked77InbdG60d2IfA==
X-Received: by 2002:a05:651c:128d:b0:2ee:7a71:6e3b with SMTP id 38308e7fff4ca-2f12edd8349mr6462661fa.27.1722042344897;
        Fri, 26 Jul 2024 18:05:44 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b41a8.dip0.t-ipconnect.de. [91.43.65.168])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590cedsm2496802a12.29.2024.07.26.18.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 18:05:44 -0700 (PDT)
Message-ID: <4fd87233-ad60-48bd-a6bc-fc14fc8a45f9@googlemail.com>
Date: Sat, 27 Jul 2024 03:05:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.10 00/29] 6.10.2-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240725142731.814288796@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240725142731.814288796@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.07.2024 um 16:36 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.10.2 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>

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

