Return-Path: <stable+bounces-164388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C86B0EA4F
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 08:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6713AB664
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA350248864;
	Wed, 23 Jul 2025 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jm7LvRfV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC10920D517;
	Wed, 23 Jul 2025 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753250958; cv=none; b=pXj+10MGdhQrggO7Zr49iDH+WQkfMMTTLnix9BlA2KQdEgh35Ko25Ayu8jrXzUxJA7Kkmmpsz/zcBtOo+GfH7Ix7Vy+VvbKjW8tdlFB9nkTD7kPsm12Knn8pvCa2IzVo9cCB5taXqOxw5FKMRPp02IQfnMP7Nc8oXV9/QNjmAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753250958; c=relaxed/simple;
	bh=18W9NYETu+o1FTtCXbfu0Hspkb64WessU+rabhwWnTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5C2K+fy3Uw9m+SKORo0uxZ5T9IT4SSW1cfi5SxFHIC7bVIOcOiYMRObqryyONR+Ysco/s7NzWNghjD3QRl+PdqXXxHacYODFA848478Motipv6Llx4wxXOsjUpOBqNu+krTOE8RKFVJGdVuYOYojgjJe+s9lAsxSLo5w4fFNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=jm7LvRfV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b611665b96so3532606f8f.2;
        Tue, 22 Jul 2025 23:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1753250955; x=1753855755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5hyH8mAVdQ/h1Za7Ty1QmGUR3EU99QudQ/Z9Zpd/LM=;
        b=jm7LvRfVqO3QgfReNsbu3i+W8+8SYIIC4ghBPrUKKCEo22OaA/12567Fuli05Tv7zu
         ZuZP2qb5Qs5FyZXLubDxmdhhficm6Wt7LxquqKxmqY+Wy3NlYTcXqjL5+imM6Hi3zdUf
         l9ZLthYjxP/Oe5ySU/TZRFHKgP9L+0wOyiLaVep3fuyfWJ5K5AXAGCj7z/spZ+8tIU+u
         TcwMvYCXVcWG9d/J1vjvAHV4FhY1Xs44WNfgrYFqPJzbIYbwFbNnkie6f+YTOy3OiERm
         g3ECcp2CJeicQYKx+AKGM04rrNWuToPr+6nS6bV9V7E5Y1I60IyaixpEcu80i4cUYCLH
         a1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753250955; x=1753855755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5hyH8mAVdQ/h1Za7Ty1QmGUR3EU99QudQ/Z9Zpd/LM=;
        b=r8WNUPFAiA44eqn5hneh8NOc0WLB1yUEUH8Emu8GRLuzO8v2dzq7S2uYN5Kku554KZ
         kfC6H4fLl+T5Iz3Rhz0iczyzsoToos/aNBhfgUHpR0aBCjtWnKe5ap1AgJwvM7e/M/m3
         dZtA+hze7O8YjdNuc44ORRAB3eMT2u3umGuM3NIhB/yxm4MeOdXRXw7j4AQ2Nt6/Fxjt
         zqel22I63q6QQeh+mgD20qYhn0jCKmXssnq/AQh8CCLD/EzjQlJR/KE6DFCh41OnHqq5
         xZIcXXD0EzyjkA1FBSJv2gZI5yrJwKh76OdN2ez6hYd0sZqg9irha3cpXqb6YkvJzbb4
         v4Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVaMUCU2yFKHie3K8l89NY1u5hMQPwh6dvIRscb0KMW5LvSIm3bxG1vtJBqK1aAMzgO174qkwQz6JxNITE=@vger.kernel.org, AJvYcCW5pUcKkaBQ+erJ0K0vkrDGlQWcbI9Rr3VbmiHGifPdVSry/S/fImysMrYFj6xgAi4jKp36/Hu3@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/1kz2idRDRvNw8KlHsFL+p5Vrx5pZO24Qbb8cFkeha9K7Xva
	oXZIzhZARhAuoAs52YPqDskG90Hr7DN5Im6Ybe01WKJrDWksUxBSlnQ=
X-Gm-Gg: ASbGncvonSlZinPnkPrKe3wVF8ahZLZMqU+TABtsMxgcB7I9NDSLgfPsFWV1/m0+uXz
	b8pdVzgtjrdVpx01MtOnEThhUocUt43Pv0pjQvoiF8mDOawHy3y0Pg5YPoTVVDfPDblfyTbxZSG
	/VevQZ3wYSbrNQLO9O20sUKv7s12wcrnZaZRbWOTBm+3M7Nh9mZXzsvnciZqPkEfRYWF5DK82Ue
	rX9eevsiiwtJDHgBW8ViZQtyKVLlbJ73uf0KlRK+I/Ly2G1HoQ0flh8BHu0Hz60kXUZN3Dfxlrf
	ohLb6nK2Go25hdq0Z3jJoZuwlPg0jrIY0aVCjA5QdxMx+upcqUpsXiuCnGHqp3yzcmOyKI66zrj
	azfpy/QMM2LgFNVKI7SOfkNqtJJnfdm9uB1HkArXJOHDXigzTsoCfVUghFE3runE8paj9ktcuXG
	gJ
X-Google-Smtp-Source: AGHT+IFItRiz5qph4V+LyeVHINY5CxZH4aTFO7Eq4z71uFasfv2pqOzNSspL7yNZ+s7Le9ULr6mMUA==
X-Received: by 2002:a05:6000:290c:b0:3b4:990b:9ee7 with SMTP id ffacd0b85a97d-3b768cb1b11mr1166177f8f.22.1753250954802;
        Tue, 22 Jul 2025 23:09:14 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac7d3.dip0.t-ipconnect.de. [91.42.199.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458691a1afasm11873505e9.21.2025.07.22.23.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 23:09:14 -0700 (PDT)
Message-ID: <47f2ade6-c86b-4408-be19-d8db81f3c6fb@googlemail.com>
Date: Wed, 23 Jul 2025 08:09:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/111] 6.6.100-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250722134333.375479548@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250722134333.375479548@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.07.2025 um 15:43 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.100 release.
> There are 111 patches in this series, all will be posted as a response
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

