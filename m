Return-Path: <stable+bounces-83382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4C4998E42
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 19:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FFD1C24847
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AD119CC20;
	Thu, 10 Oct 2024 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Memwycz7"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443F19B5B8;
	Thu, 10 Oct 2024 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580742; cv=none; b=Grdu9fJJIpD5FP2AE4jcAaioGTkUAG9fj8w5ITeDz8Qh/Z8y2M38B8kDoWPsXM15x7FOTWEEcEQxMnYU6Sx2i0GYYULKnl3+6grOYjl8IhI3o1xihli3uiO+2bUHgrGbd87PXlVNln4Qoqk/iMoQanFL5x6ShkNtsKAtDZA8FP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580742; c=relaxed/simple;
	bh=7AfwBx0KrRdZE2Nc0wEtIN3SO9w69Z+D6PzQdmgv3+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjfkUgrDzbTaDM8M31pvOj+7kj8eQIMvL2tAxCCcPLeP09L7szEIwPuISil+N8vh4DuIcqJjw17Z6cCBwzSVp+lFBDWchFoWV0bbDq0aDq4l7KVt0OyuH82X8PBLdL4MHvnL1VVY3lvzIuQ42ntFyW7lRce623qp8pwGr3uUkWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Memwycz7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398996acbeso1425940e87.1;
        Thu, 10 Oct 2024 10:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1728580738; x=1729185538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLPtmjy9vjMWMTF2rCSUMPmTkeRCqgbGtEZX20lNPD8=;
        b=Memwycz7nFLh9pqmcALpBLn0yn6FAhyZWUU8QSdleTRBq0C7t9v55cinzbewt/TnE+
         r8WT8jJKnNMp6UHN4KJIFlaOie62fO+DuGEEnPSTjxqWVI35fk3Tag/51RwA/d6VSRSC
         zt5LEHMpOoEVXov8J+jZQR1GDY/jaKvui061kExvp/QLNkmMfz0/OtBBXJk6BXJu3B20
         JR6BoEGQx1k8nuOC9+I+Adgm9OA2GIP/zik82v+rkqir7QY2BdLymjjOP8EVwYNrPyqa
         EnBLWZzNpkSq1T8zUpGWyP0JX0TXLzXyfnSsN9OBMzjjalrSsMDVLkQHmI/YRFJ54gqq
         xwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728580738; x=1729185538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLPtmjy9vjMWMTF2rCSUMPmTkeRCqgbGtEZX20lNPD8=;
        b=mH4oQAVGim0bCdpZhIW9j0S5Z7ur7s0qJpji5/oYlXM4jccKlu5zdsQHXbRhIFNpfh
         QGZMeltnKbvd+Zk8e3MoxY5mMMxo4/sOnROTSJVgVKISuk9JWFZFnswmS5t3krfKuJvi
         xv0vhr/lvRs08nf3IqQ7U2R5pp1f50kHPOgdZOoI8uIF2HQKPYolyugQIpK+TkRq2GE2
         O0bC/9XQHYPTKieMWavGdZzsoROZOSmQOPsFXJR8441Hf1vBsf9fPTyoRRPzJe6gLoqu
         Ao1dFwqe9vJ3m+0UovIueC3H6ALjJ76arV9haNbRl9JiW17sGf9wrRUfC5h+fb/Ro7of
         ahXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6wGCBmqPBZmxwH2v6U+tZVblcuXCRp/tpD8v0BLkxHtuUdsDVPyzXOSzzhHt59Pg+whBVBWIB@vger.kernel.org, AJvYcCWWqkXdu77dvkLsxYoyeFHzJoFm+ZK0nYq1YpOehdf2gy19EQKxbWAmXhY1QzmX5k5Umu1XoKgXVvhm09I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRFkwhgnBD6uYPQXG3Kzl0u2mGTqNEJDgdt378Ij1e+QjsMLg
	hpiSDwgnuaQ1QxLt5qkyFlC/ZpFuVdkB9mz87xKX1xld4e5QurI=
X-Google-Smtp-Source: AGHT+IHo+T4k3kMGacfyrzoVyByXdkR+c37mFkM03i8sydsrFr+og0a5dbRThE5h2Au/GU8P0EJzJA==
X-Received: by 2002:a05:6512:b8a:b0:539:8fef:8a80 with SMTP id 2adb3069b0e04-539d4ce4bdfmr156101e87.52.1728580738012;
        Thu, 10 Oct 2024 10:18:58 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b485e.dip0.t-ipconnect.de. [91.43.72.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf51753sm53533315e9.23.2024.10.10.10.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 10:18:57 -0700 (PDT)
Message-ID: <86472ad5-6fd3-4273-be9b-e4815b54797e@googlemail.com>
Date: Thu, 10 Oct 2024 19:18:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.10 000/482] 6.10.14-rc1 review
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241008115648.280954295@linuxfoundation.org>
 <05ef1fc5-6947-45f1-bf9b-879681647107@collabora.com>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <05ef1fc5-6947-45f1-bf9b-879681647107@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.10.2024 um 10:58 schrieb Muhammad Usama Anjum:

> Please find the KernelCI report below :-
> 
> 
> OVERVIEW
> 
>      Builds: 24 passed, 1 failed
> 
>      Boot tests: 510 passed, 0 failed
> 
>      CI systems: maestro
> 
> REVISION
> 
>      Commit
>          name:
>          hash: d44129966591836e3ff248d0af2358f1b8f7bc28
>      Checked out from
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> linux-6.10.y
> 
> 
> BUILDS
>      - i386 (defconfig+kcidebug+x86-board)
>        Build error:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c:219:1: error:
> the frame size of 1192 bytes is larger than 1024 bytes
> [-Werror=frame-larger-than=]
>        config:
> https://kciapistagingstorage1.file.core.windows.net/early-access/kbuild-gcc-12-x86-kcidebug-6705246a7ef7358befb78db3/.config?sv=2022-11-02&ss=f&srt=sco&sp=r&se=2024-10-17T19:19:12Z&st=2023-10-17T11:19:12Z&spr=https&sig=sLmFlvZHXRrZsSGubsDUIvTiv%2BtzgDq6vALfkrtWnv8%3D
> 
> BOOT TESTS
> 
>      No new boot failures found
> 
> Tested-by: kernelci.org bot <bot@kernelci.org>
> 
> Thanks,
> KernelCI team
> 

I do all my kernel build tests with CONFIG_WERROR=Y, and I found that due to THIS driver, 
I had to increase CONFIG_FRAME_WARN to 2048 from its default 1024 (which comes from my PVE 
oldconfig). This avoids this warning/error. However I don't know whether a driver, or any 
function, using a larger stack frame than 1024 bytes will generally be a problem.

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

