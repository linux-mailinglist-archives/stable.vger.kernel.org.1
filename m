Return-Path: <stable+bounces-206064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E60F2CFB6D5
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 01:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E18F8304F514
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 00:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D1E1862A;
	Wed,  7 Jan 2026 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZNBxa52K"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F495DDAB
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767744535; cv=none; b=Bdk/mDZ6BO0dQQivMxDGwKD+hnHBrfDAh5ovxi2pUq2TuhcwiiRUFMmU5uPkkrKjDREtZ6nIh1LvFGJ4dVMj/GqHTE9sel5Ar1jzpK9lnLJuEfqsINS6dZW4o/8IqiDxBKe4Hhh8LPvlN8o45MRgITG85KbEO4yJzKZADfmtkYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767744535; c=relaxed/simple;
	bh=H3MbywnQYhF0q6ImBRYUa3nHk8f7OIc5U1hW6sgdWB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXnqd7HNkeEJQ606+kxktrbmh3KzkjJG6HzoWeJhwNIO02LdwCHvOMtmPj89TRhaTZj5OTlj5l16QIBxaDoC+tFmOfffz4kxYOqaEcz+O4qZyNk8GrEE+dwtZOQElCSKg4eFd33qtMr7LSWy00WFIpLh6CK7bKo18+ptXk3GX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZNBxa52K; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so15500905e9.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 16:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1767744532; x=1768349332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pr1oJOK8kea7KVLXItQEa17CoUJ7+nYGQ16AB9nPTIg=;
        b=ZNBxa52KvBSFBIgOyooxCry3JQPc4CBjuuA+d/FBsJOSNc41mRmjcBcytEEgPs8x2K
         IGWtq7MCS4Kr14FT8qEfl6hL0GHXzF4/D0bws2tn6t5EE2xLpVQQ5Q+SWLc8t/wtRP3z
         L4c4LPd8DUvSWPUwqcWfTSabtLseo+1JBRUlv6q8NB8OWubi90+db6tGM4QTPXlFJJrG
         Ab9wEXbpI29AChTCzdekAO+AzGkGI6bPtZhUWDOUnI/1G1hFRHT2XJRXowfprPDU5pQ+
         NG7kppJHwYeN6WRcktVkofWEsKshmCtqol/GgQiFICyWD4f7B/umWXMT9XW7NVw75rlg
         pjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767744532; x=1768349332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr1oJOK8kea7KVLXItQEa17CoUJ7+nYGQ16AB9nPTIg=;
        b=hObhVsdjCBl3bNX41lpgqMPCwqrd7CVG/czW61mWmM9yrfic0xTWbye/A5je/OnwTf
         MjUM2jeFV5VGSo9yt3OwBB2dLnAWDtMnAgOKQ1ajwsw2/GbVk9lKaPJb3KxpLRWjrk44
         Q1MVaQvZnPYiMls0/8FLp7cXHjXP/Zkj4uoxSDBn+KxKFG4CEpDKWFbEeVYUJsVP6p0T
         VzczYuxj9pCwt4oWmqX2qbQAj4R9sKeBpFXfZZ7o4Rec+WuRmk3bAmkiG71+Ve0s3hLK
         8om7aU35/hPIN4iK5mo+a8w08/Hux4VZr3FRCSTF+kHj+z6MSNA1otGseL8GcRUmanE9
         K2fA==
X-Forwarded-Encrypted: i=1; AJvYcCVDIwKN4yksXa8HV6kyp90n3n32Cjnz11+tzvcdYmDIsLlIOQqZP7B/Adho71st54M7n/6uOuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFzL7n40z8TE+PnLIMO1DwUDG0wo7qtBoKk4MMp0VnAvGmAN1
	5UGAvuQ6FVJ3kweOfkHB3sy9sboSUmWICS15x5tC7MBffNTn0/3mbe8=
X-Gm-Gg: AY/fxX6RrP4l7NHDNo2D/Zod8EfTtsgUlTex2+iJhb0GG/vRLi4fJTJ97LxMk7RUjCJ
	KySDAO69wrkpGZAFttRWLdxONCCSC0fIZhGjfYLbwXp9qjvLIef7wzl85uOSTtEAZZVEoNH71WV
	CIiYDnCVrDX7OFsFrBOPpLqkHJG+mfNC1YhSdipXdIS7Rb6lpAnI0W2arz0wINrsUTtC6eQPvef
	VnIU8LeZASsaTaawvukdw2IN4NO7tizZMS9ieVdG3nWfQe4zYvb+OQH0UY527itcFA2mrgx5FZP
	EhhVRoC4q+AHtJZLcsSI9VtwK+JFyxMm9MtaomuL7PcXg9DCMOSBb4l46jeUMfZ/5NmNFoj7lBV
	h/NsftPkaIRxU7i80r8o7KCO39hDySpilYGgCClkjrG5wzc997xRNkrRnwrhjUi3qdQbdgf7RUp
	G7t7Xcc53QkygjR9kk7JUygDWutfMp/TAFAWTzjUUWwJRt7YqbF84841MHNfMBiA==
X-Google-Smtp-Source: AGHT+IFodAh3c1ldVuGJj2GQ5Lm+26co3P0nLxGONfOCg661GssmZiIcn7t24GF4KU3m0/mXJ/ukFw==
X-Received: by 2002:a05:600c:a102:b0:477:7a53:f493 with SMTP id 5b1f17b1804b1-47d84b32793mr4673325e9.23.1767744532330;
        Tue, 06 Jan 2026 16:08:52 -0800 (PST)
Received: from [192.168.1.3] (p5b05725e.dip0.t-ipconnect.de. [91.5.114.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f668e03sm70321465e9.14.2026.01.06.16.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 16:08:52 -0800 (PST)
Message-ID: <43e64d0c-6b4f-4aa8-811d-4dc108344b43@googlemail.com>
Date: Wed, 7 Jan 2026 01:08:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/567] 6.12.64-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260106170451.332875001@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.01.2026 um 17:56 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.64 release.
> There are 567 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

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

