Return-Path: <stable+bounces-80665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC6D98F40B
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 18:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500F41C20A51
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 16:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC0F1A7248;
	Thu,  3 Oct 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="C3OhWqtb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0A412F5B3;
	Thu,  3 Oct 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972121; cv=none; b=KUfP8z4pT8cmZqL1MEP0NriG8fvzlxfp9tBSzTrEkykeLgJK0MuOvJACD6H5wubzGNhfB8i14lMagfo9zTiS20fuI9AinKLULzk/tWTQ5f35/ySLEx6ElY/8uH7LyQlkyqv+QKewKPacGa8wYuCBkDC5mzkoENMT6rCILHUhIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972121; c=relaxed/simple;
	bh=YUNppPO/cOH//1Ehkehu1ue8+aIJzkVhMeWCKqzTRic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtkLFQDLKcPyp3I5CN+CG0ZloaqiX26kweXKNHU8w3Pyg0kuFNacHSWVZzH5Xqa+pfrN6G/1WB55rdiefSL2JQl+rQPh1uVclxm2UKTZnmO7H5CaJOsu8CcdxSqK7u96a2mWSlU5sOS2YkXZoU+bYIxFKnO/tXEzBMO5DFJ5rIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=C3OhWqtb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so11625645e9.3;
        Thu, 03 Oct 2024 09:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727972118; x=1728576918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNrQYa8R60fTxvWUk/afRy+xx37ZXVxha5xqKTzH35M=;
        b=C3OhWqtbn9qtkKzKG5bGaEY1fLGSxipeZpyb2ajCOziAh2QMi7SBliYhDn4/Jrjdse
         SxIc626n9R6iln90niHkLlFDmpbXEBjJ4k+kMmbJIU8ZyEh5rtcQ0cPEi3vBgBSrLUaf
         INJfP/iIFqChSMZdq1ibxsXJOFdGSjbWDCrYhIQ2+fdywBNeyaHeQ5OLlxLojXDmQk16
         RqVIi0pqvnlSEQXhuC2TMPHTbHzOrNseN4rcEduY3mh/xwigip5cfF1+7BdBythGOETX
         IZrOlLMETX/UdHM4b6S6Hvu2iMIfmMCdKKpjT0q+AcHjXuCMx2K9xNYneBGy/1uBrSJV
         MtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727972118; x=1728576918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNrQYa8R60fTxvWUk/afRy+xx37ZXVxha5xqKTzH35M=;
        b=nmWy92j6HmdYj4n5OHHiaoMe5jQody8twBc9YMzufNGEsIDI4wCaskNEAm7IzKk8iJ
         5hj6YKq/2sj2LSfzZsNmfp/Y51QCFk85rBcWoxbSzbYGtCQEljmurMzMQlH7bcY+C0sO
         XZEkqdqI6ijw8hjlVmXIX2p0NWS0ra+n8OVHQ/sXf4fy0ZXhVzx/eDZimWHusQ8OZxQd
         B38YXxHDBHI/UqjunJnM5bXsT2AGSPKRI9OiRA4OtbTA4SRsiBYZ+oqB4yP+nXPw3Mxq
         HyN+pga35hfIAXjVyFIhD9h0vdTy1C016cIIK1QQaxyvC42/kuRS7q3c9YADGsmrg3Ld
         bv6g==
X-Forwarded-Encrypted: i=1; AJvYcCXUX3/dBAeSzNAvBqwykS5VHAaTSfPY94O0OFvE0WVZlBs0QpkYwLk5tBlLmPIh5RuG/5an/+r/@vger.kernel.org, AJvYcCXflj/rEANkLtUy6c4nNcsDLVSnf7wPYcpfPnaAtqqU5eBr6nQ2rNW+Pruxlpld9hmMqeR72uLOLGy02Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ5bYkc7IDZEtyBXImpY8U11UcBXuAdW8pOpL008Lw/SOrsUIp
	QpvvnG5xPQy+6KSbicjJmITUMPBlrXkkyE/EhSE+QpeEwhD7ZWY=
X-Google-Smtp-Source: AGHT+IGaLzIlnDEzK/in2eQeV0K+Ol9xt3lMWUpzcjiTJ6tO5rNm1hpOMR+ia2Sh7MQHzD+/DmRStg==
X-Received: by 2002:a05:600c:3108:b0:42c:ae30:fc4d with SMTP id 5b1f17b1804b1-42f777b64c9mr56927265e9.7.1727972117648;
        Thu, 03 Oct 2024 09:15:17 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4899.dip0.t-ipconnect.de. [91.43.72.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f80255f01sm19156435e9.9.2024.10.03.09.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 09:15:16 -0700 (PDT)
Message-ID: <78ce1271-3e96-4bbe-a359-c376596a4743@googlemail.com>
Date: Thu, 3 Oct 2024 18:15:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.10 000/634] 6.10.13-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241002125811.070689334@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.10.2024 um 14:51 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.10.13 release.
> There are 634 patches in this series, all will be posted as a response
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

