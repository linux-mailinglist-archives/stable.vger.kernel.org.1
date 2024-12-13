Return-Path: <stable+bounces-103954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4766F9F0263
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 02:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3864285582
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 01:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7591627715;
	Fri, 13 Dec 2024 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iVjTuOjM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384017BA1;
	Fri, 13 Dec 2024 01:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734054093; cv=none; b=p+z0hU/GWfaZ3UjgwnEawMc87RdlAgfVqI2tibW17Hoe7vL+4DvcrClHR9WFxHylFDbd8obl3+huluAM3B4iJ8kRa3WL+TZJ3b1SWUo8k3IVXkUhJqrrAsrlVRpUulxUDCSlgZAcJ1TT52K88nNLraS0/a+JGPppCpKHMnSFs7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734054093; c=relaxed/simple;
	bh=Pd+ekocBfu+A8T+xL7igF6cVVhFLkDF6GiCL05sUBSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1pOJw5uEdad6PkbyO1kEkqKbOS/x0vsDuLI0pJVaxClVCwwlWKXW6ITTQd5oD6xagy2kZxMfsG4On5jMBDQPuEKIkcyEB/oTciP/cX3RNk1gV+pqZA1y0el8TonCr4Hp91TVKQcC61A2EA1pgn0Nj6RkX4ePRbmFtCTa7xOyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=iVjTuOjM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862d6d5765so789775f8f.3;
        Thu, 12 Dec 2024 17:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1734054090; x=1734658890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zamzeKdqQcRbUXp/Lnf8z4704A6wdTlF28/d3lSLSWI=;
        b=iVjTuOjMQxasz7Ymdsiru7cr1pKK9F+H2kjc+bBU5SVZryzqjGn2grcfe0LT4F+lbM
         HAD5EOsOixT7ANaIjh0r5erRmuWWN2X3AidbJfs0oCOHD3tP1xvoLNOidlL+EDlOvc1s
         YNu8yyGU/ERhPu0JhocMXZwlrcdjDd5hU8Lq095UEjQ39sI+oGu8IqRGC+RdaMRvDLQu
         TF6blb7V0irX2JswY3dW+rMv3jP1syx6ZiQgwrjwR0ZVLMdfIqlCzvp8SE76jCwHUsiO
         QrRfqoyv7igPiQV2923XzsQ+vSGfcLWOUgDdXo0qOlMBF/fj2Y2OUskPaw5uG2eiYgiV
         BjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734054090; x=1734658890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zamzeKdqQcRbUXp/Lnf8z4704A6wdTlF28/d3lSLSWI=;
        b=n7wqQBnE4JLKXsceKjNYzUKgEmyfl8HF4d3c1T29mF4Zyw9ov02Mxj/uyna6/YwgJW
         X82k21dIKhdFIj72oJe29uBt4ftRDD6kTC//HzN2V3bistbnNxWga3thG3NqCliu1xvh
         Fy/yKmXDOssFMigQFsMnSiLanBH55z+J5FJH8ohYzvaaCpvCB8UTFVaLfOmMHjvhGOuG
         cTO9GAysWQGzj76QzUKljtzYE4uapL0ujcaaBfSdMTx3PSLAooYWVaeVDcPK6ktoKaUM
         Yc6k3Iw6dxWK6hSKnpHceNQWojBgzsidXRHerm0NI/pZh5i2yGRpr53Wu/cmz+hH3Rlm
         Ii1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4PS3o0bBckoVQgThyqozjniAr48atxKAVOvjVYV3A2NFH86Rb0mKfz845AaI90RlgsJNabl5D@vger.kernel.org, AJvYcCXRQoSyTax+b44o7ZHm9HCxhBoRddSMy9KD0+mnfMwFqTRaAUZj4Sf/NoZlv0RZVa9faXJcOObAhrZhoEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNJ9BaEm0+tdPBQWyuyKzWDQ+VhJCrEEL9rNLKhLo4HpStygHa
	JTzzQjPf1ilrlXBLTqogoO2B9MoHOpq5ss6pK1VPpjgH7PVQtBY=
X-Gm-Gg: ASbGncstgLqaYatWK52qUbvDfWfsm3xyuZtnqYswfbTZoDeVLZgPdoKx4rC/hPn025h
	8bmapeo+HlGOFE3RXkY9aRvqGNkIXOHJRTTUSe4ifu7E+KaFNVLheDso7p2z4ZHvy/zZAWo5XOM
	6wzMABUvfwysXIuvN/cbGVO0He0XkcmVhjpqUuFD7V4+wdqT5hDOq5kh8AsUYxBuNzIHivQPmtd
	5uTTqRaDSiGig2wLxbdmLkIft9F9bvNgqh2+Vr+ofjvhwvGage/QbMoJ/TZCEh9yAma+221zfws
	o9C1Zg2nL+uXZgXhOh2vrTfa8HiDtMRh
X-Google-Smtp-Source: AGHT+IE+hraE/ToStnNdIfVIorMIHbqJHcrUC6BBhx/UOHiUJtO3CIPdndd2MazB1dQCd3wHunCl0g==
X-Received: by 2002:a5d:6c6d:0:b0:385:fd07:85f8 with SMTP id ffacd0b85a97d-38880ad97b7mr332672f8f.29.1734054089622;
        Thu, 12 Dec 2024 17:41:29 -0800 (PST)
Received: from [192.168.1.3] (p5b057a27.dip0.t-ipconnect.de. [91.5.122.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514dcesm5451610f8f.65.2024.12.12.17.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 17:41:27 -0800 (PST)
Message-ID: <3b73538d-9cff-4bcf-bde7-312c1721dd36@googlemail.com>
Date: Fri, 13 Dec 2024 02:41:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/356] 6.6.66-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241212144244.601729511@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.12.2024 um 15:55 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.66 release.
> There are 356 patches in this series, all will be posted as a response
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

