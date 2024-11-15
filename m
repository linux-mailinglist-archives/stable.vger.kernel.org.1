Return-Path: <stable+bounces-93572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E64369CF3B2
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 19:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC3DB2C250
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 17:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DCD1D63D9;
	Fri, 15 Nov 2024 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BqbclHQI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469BE187561;
	Fri, 15 Nov 2024 17:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692405; cv=none; b=DUwudYy64AO8KgTnq0G6bSZ6Xdc4nOXaR2bxoOdWzcg7tFJLv859FBg9wkKX3ctYIhW38jBwC2Ze9uu5pNoE4jIfSw06CJEQHYV7Qli+zg2iLYGFlumbM6plw+LJRzA/iTEBqn1Q68gXpTe/SG9xtIfdmDfsGFuGq1yZIx+Oj7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692405; c=relaxed/simple;
	bh=p7ci1neMpIlILdwObEgt1kk2VCbDQw3dhgVddn4i4P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8s934WW++uNy8AE6JtM3emrv0FBptE3zjBqzEiCjIxsf7Dx/qzqWPKnQISpHEbXo+mxTQ4/ejmU2KFR8J16Z0XU5YU65p8Y8+Lw4Hjx+LsQ6wdfAnjyZViSfbvRO1rckJWzVYkUmN0plYmK1aXwzj9ST8BChX9hbLFZSJ9fnig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BqbclHQI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d49a7207cso1242139f8f.0;
        Fri, 15 Nov 2024 09:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1731692402; x=1732297202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4kCyeAXmUMvmTaqsw8pK2lGpYkcX3PO6zCT06T8qxI=;
        b=BqbclHQIP+ZqThsTNvBJ2WFk1gS6Pk0ssbTvAYmxCBYLnkJUsaXSb+OauubrkywXMv
         64Hd+HIAyaxnw5JGN7XzOrzJ0SEUFSJM6QEjPG4W7XA1UwUOnRQI4XEo2+WfcWa1vGKx
         x4PL0in/2FG802nvJCkA4eZ8D3O6DefSK8uJ/LWBBRY4UUxZunTVgllAlOIqic7zwAWd
         DF4mBOtGHRHYNhbbRTy8ZhzzTKmh20RzuoEpBoQmJoCHMIVE2gQ9lDMFQXlNo0TzY3Xp
         Sw/1X/G+mwpirZCxIXN3xgdeR7UvloWM3KeHmqwua06oejZpipNpiXw/b2JNjbqsHMYs
         dZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731692402; x=1732297202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4kCyeAXmUMvmTaqsw8pK2lGpYkcX3PO6zCT06T8qxI=;
        b=XPHGruUq+rgZtVmuF8AWPj+ODp2eixCgT/AYwEN2DKlrPjq5HHzXMrJj94fWFMKv5n
         iSSgRdmZgcbSrEe98U23X7HgPPjEdTUlOJ3gb2Fsb5KuDGIljnDDG98ERtPJPq0Lbo8Z
         7krFiy6Txefk4nH46K2nwbpj1AIARtZ57W5aiV7UcgDEL8Rh7MB5NNd/+7jCtw3YwNU2
         QA5cqykFVadhhqXFkSpJKQHxUPYu0nCOnWJUh9FFZpNsATLq0guhgouoyz+2JrOxfqhJ
         ZFuPz4UxjgCputniU2ckO/VAxP0+ZBGEp8CLeqEmiXKPmCN8H363EKraBrdBQ0UFsoo/
         2Wzg==
X-Forwarded-Encrypted: i=1; AJvYcCUIWMkv4EqJmDrJtWsl5dC/wj7tsRCIEItntiSBUNUUe9Gc85aETOW9v0ML6TXBWqZbgT7yTMF1@vger.kernel.org, AJvYcCXsNY09ge58g1GV75bfeUiJ7HVX2zz3gkXsJ7F7aj70+lPKW0fQ93i3G6/6gKdQQWGEkqFkarAdc6bQZzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyQntOoEDMxO9AkR8tQ67K3rtOzLIbznogCRxUyTB3o3O19Mjy
	YiUrPytlNff/Jcgt/DyEYWjToX0ojLUt0S3EAySDEKplmQqSycA=
X-Google-Smtp-Source: AGHT+IE4AS7+FhYA0CzoCHJizPCmi4kWLoQILtvYYXD+QEbI9dEEwxD6J2O1Rvu2/4LDwK5TMY6G0Q==
X-Received: by 2002:a5d:6da6:0:b0:37d:5364:d738 with SMTP id ffacd0b85a97d-38225a922d1mr2451204f8f.45.1731692402296;
        Fri, 15 Nov 2024 09:40:02 -0800 (PST)
Received: from [192.168.1.3] (p5b05792c.dip0.t-ipconnect.de. [91.5.121.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382247849b0sm2959466f8f.97.2024.11.15.09.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 09:40:01 -0800 (PST)
Message-ID: <588e886f-a626-4fc9-a49b-6767776a736d@googlemail.com>
Date: Fri, 15 Nov 2024 18:40:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.11 00/63] 6.11.9-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241115063725.892410236@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241115063725.892410236@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.11.2024 um 07:37 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.11.9 release.
> There are 63 patches in this series, all will be posted as a response
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

