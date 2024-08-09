Return-Path: <stable+bounces-66117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6986B94CBAB
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 09:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E97284495
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 07:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83445155725;
	Fri,  9 Aug 2024 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UeoDu0bN"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC20B1552EB;
	Fri,  9 Aug 2024 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723189933; cv=none; b=Ko8C7NI/dfOiD6v7g4bUdPgfqs/TdE2BZq44yxsYSMbI79JuGrHUmaqTt4EY+eNHeX1nvi1lasz/TVT4rSH1M/nG/9LiHyS3OwfyCEkC8vgymf2vhZrqB62y0P6PIDPfqWwZJ5Z6v1YNNh2DSB/jv3pxbfLtumVaCEFU+3x3V0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723189933; c=relaxed/simple;
	bh=WE7k6D28IPiuVNuNF0yk/oEv5frGPz8PpAqNeBAcOQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=meeMx0j7vHAEYPGhxVT/qo6t3lawyVX2wkGi01RFCOXorHV4Qs6BuRI5gkpenmShoPhA19MWh09Pd4pRnjjizDUAWcPFGrg2Rk4bVzX4Uyj/RxpDbnnVG6eqNPCeI7P3gtx85YCVMmq5vQVtbzQHAU2WUvIZWsBP7L7GhX3PebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UeoDu0bN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5b9d48d1456so2826518a12.1;
        Fri, 09 Aug 2024 00:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1723189930; x=1723794730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qfWLL5imiDz9F+CxuIwiH+imn9QnZVkp2UmzuD56ox8=;
        b=UeoDu0bN32pZymwlahUy0RcUIhW/Fyrjf5dc21eUpwAZNEcJfwEova0xwqKab4nkXD
         Jr4e8lNaPxMKCW5EAqWgG3TMswSaiUFcRalV5yIitUKg7Soh+SkqIZ4+2Ca75mZV9J2r
         bPYq9L/DAAy77vv7Tzbwy8pa00tZd/ZX90rE1E1ai9EBwoYIozC9bn1pPCgzSnXCnlUm
         VHdw/ASk9ajemte1qJH1Zs9Syl7h4OoGWMK3inMy0cIz1/R1tEI7jkAu0wIbZRXxoJWh
         rPrBes0rNp1tAo0sDl/LV8o7B8bdiUNk1g82x85sg3ZjHJYCoVxwz7NeusPRjGZYunUJ
         1HDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723189930; x=1723794730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfWLL5imiDz9F+CxuIwiH+imn9QnZVkp2UmzuD56ox8=;
        b=DK/3JTS5FVmrZfkRpnTvrjLa2Iob/Ge35nUcO0XqPmgsxetHdePS+p0s4D7Ft2BUqy
         srJcKAyR7DKyds0NLegorXJ3A8dD6IE06daqoVE8EBQXK5PjhJH7OYSQkNfZxzxb0f8k
         fUtMoOa9036mRu0GonbHCnoXaryDRc1MiX0yTs8JVcDEXluecSRZW0z6lEdIe8+3DXSo
         Xg3Y/g2bJb4+BjcMWd04YXg4PUs1DST3s561+3x75J4rEmxpee33yKEexrR5DXjhl0ad
         hrHsXZUKCOFMmnUtGOG3Ijqm3w8hdycY2ydsZFhrywT0Q8krZ2vNyHqwIhwQJopkWPiP
         BxqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpajz5FU2jIUxzoNuXkv941APAGk5ljUq9dkrFWG6dosVHF68zwZcom7OZRe76CMXAZd7BZVnTPfmiGGsSDpeh8/uXsEZHfFPfy2mDfS5zkpeqsPM9g5lC56DYlkV2bSQfCNI5
X-Gm-Message-State: AOJu0Ywvb2KuaaZZNPL6eMqe5EZ+ztXVVwN1MMXinCRE450fNLyysVNO
	YM3JGublWjpvZUyVJXKe2qZ1Vg4vn3VfrO0rbyKCbq2+L3AdbrE=
X-Google-Smtp-Source: AGHT+IHo9lOLj5SORUWn1SV2NnWTBLGCiC+vS/GL+OIQBNDL0KUifCX7RaGI+mujFCYv2Rs2wCJglg==
X-Received: by 2002:a05:6402:1d4f:b0:58c:b2b8:31b2 with SMTP id 4fb4d7f45d1cf-5bd0abdc414mr601773a12.17.1723189929644;
        Fri, 09 Aug 2024 00:52:09 -0700 (PDT)
Received: from [192.168.1.3] (p5b05740f.dip0.t-ipconnect.de. [91.5.116.15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c2019bsm1303945a12.31.2024.08.09.00.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 00:52:09 -0700 (PDT)
Message-ID: <3c61ccd8-38be-4da1-bef1-0738c3593a15@googlemail.com>
Date: Fri, 9 Aug 2024 09:52:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.10 000/123] 6.10.4-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240807150020.790615758@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.08.2024 um 16:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.10.4 release.
> There are 123 patches in this series, all will be posted as a response
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

