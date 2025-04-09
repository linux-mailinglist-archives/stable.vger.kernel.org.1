Return-Path: <stable+bounces-132015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6FBA83465
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 01:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4701B19E7C28
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 23:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034E926ACB;
	Wed,  9 Apr 2025 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HB6hMWN2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC981B6CE4;
	Wed,  9 Apr 2025 23:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744240416; cv=none; b=IsvvZY9+BlUnvYj9mWT2EzApOUjUXvCVmo0Lr6oliMDfIwFsMhdAkRKAZHbC60J0oG4Sc79jdgX11jGq3ih1mbOpF96YavaWwqwindb6ztggPrJp2+pSYmBU3ZsDumUFXCCqHiCNasHfCjsEWpQdQFDkGezMD4LJIEpQgy7K5QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744240416; c=relaxed/simple;
	bh=gwk9OrycqkKVdhpm87tobsijpdGkykWCrAcP3S79gRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHUKDfv4TBkDrdOlnousKMteizWNTeBY77pCnbRg482JGVxmHyIEfYpwW2RF7RkIpHAOjfwac451DpDT0yCbtgH3wZ3M4FAJ19qdhqwUqQNKwSt5/gTz14i/SpzSDUkAu3XLFw/GGmUCtwHMXK0AFg+jF+0uOQymEgkzaAxgPnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=HB6hMWN2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfe574976so1503205e9.1;
        Wed, 09 Apr 2025 16:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744240413; x=1744845213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JW74z6cHpNu60kU9OE2aazhTFE9YDkFOWDJkNNru92Q=;
        b=HB6hMWN21r3OPO7HiiCWqlUpWPcOv8rfNMA6mXhaDk27IjinAYPLFqZ2EVWjlr+kGV
         h2TKOY4xxmDxubvdB5Bff66TLcatKA/PAXc6WONmbkAat0NpvaKZYKnnwej9LeJkT797
         TZerTYyVMvk7v8rluR8QerybEnsYjQ7aPcMl05ve9u0kNFqysE/QFmBXua6hSbYY+JHy
         NaSrJ8bV9AoCO4jmWawjQNI5DnjeJwNfkCXStC3BUj21BSk4X4XMHjgzdgj8Gj92cKtK
         8arm2divHhW/XYV3JCQ4bmGP7/nRL/FlJBVTMVQOAcpWuXHtbeOIuNWMia5AFmKn1wev
         b9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744240413; x=1744845213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JW74z6cHpNu60kU9OE2aazhTFE9YDkFOWDJkNNru92Q=;
        b=SuzP2QlCeY3S3wxCsfSH9ODPInlwjy5QJLqxhlFEYLICnOQK5NnnFPi/Y/FTFnOc8X
         cg+j65eMzp5hgqC9PhlOSpO25xm4JDFmsur6o2Zoga7V/4uhDQUJ1huE69Q/WLa5M73N
         RFgjiG5lUoRyJ1l73sGlQNKcrCIg8f6xgqffqysusgSjrrTKVJPcUUGrXojOKgrZwHoN
         dR/O0vRP4bRuG3zCt8AhcIUVtC4yA0sjjwsMo4jppnjnwgDoGfsDDwJE+7E6U/a+nA8r
         oW8RDLv2KNRFzc8g++u6E1I/UlHFQZIXxAOYibaOh5IY1J4/EdJkzEtQkSOsnhL2pznP
         ADEA==
X-Forwarded-Encrypted: i=1; AJvYcCUu42yH/tKug5Yo73i6GmbtCtnxAh9tvVlwwt6/gWmknW9PH17m6PPxpzJLYukGqhcVKGVgdFiKCQL6hLw=@vger.kernel.org, AJvYcCVcZ7TguVSTAGYm9w2Mcnes70ki7Jr31blnQDPWHksRhDZYIQYYuStCJNWDH1BAkqChP2yi80gH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ipVAVzIeezSpC9lHUzM5uFsVWOxa4LU2djnHQ6hzJiysVz4m
	YVN/YM/dcF4UbNpn0RDL/MhxF5z9IXBoL8892h5sx+rLelV1Diw=
X-Gm-Gg: ASbGncstI1DMDRBWtrIDK4h8H2hkmUKKiAzzkm2RJyGuvd5n6I0NxLUzTuwoIOQPAlU
	M8T8E/yMEymSGXl8FrP2C7JdSUNxLpLtSWF/Lyq4FgH2bAFyYqv1a8YLSN9GlEgyMozOZv3SjwO
	RS87mvJsZ9y6FQA8udDmiRd+Lxz9OYRzQbGurUhBpA1OCvSKj0Rim8MMWkoYoD3NDD88LWwgogW
	FHSTd+0gue2bWUpfkeqrWDc/sdd6mIgWqCs224VjCgO5gvOGFRIfWbXtY3OwN+bzcGbnTI/CD4+
	n4qXEB0D4bWaTBInsqT63V5g4UB/2dbHZMgFzwhCwyPAO7/GRGWqxYyYq7xvjY4vasxn+LjNzm8
	WveR4IKnOVdS88liuvAtu/IZbArA=
X-Google-Smtp-Source: AGHT+IECp8SZn0v3pCPADW9jULXwJGPBFrCS/fIc9I+DpPyMRE88HI4kqXtXrTxOosCltUSPuXtrYQ==
X-Received: by 2002:a05:6000:2586:b0:391:39fb:59c8 with SMTP id ffacd0b85a97d-39d8f4744a3mr335672f8f.25.1744240413129;
        Wed, 09 Apr 2025 16:13:33 -0700 (PDT)
Received: from [192.168.1.3] (p5b057855.dip0.t-ipconnect.de. [91.5.120.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f23572ce4sm31128885e9.30.2025.04.09.16.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 16:13:31 -0700 (PDT)
Message-ID: <5e8d7416-3666-4a2b-bdc9-8cbc2a761b8a@googlemail.com>
Date: Thu, 10 Apr 2025 01:13:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.14 000/726] 6.14.2-rc4 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250409115934.968141886@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250409115934.968141886@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.04.2025 um 14:03 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.14.2 release.
> There are 726 patches in this series, all will be posted as a response
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

