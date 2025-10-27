Return-Path: <stable+bounces-191342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E37D2C1209B
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 00:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EF4188AA39
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 23:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B96D330328;
	Mon, 27 Oct 2025 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="YUq8R8B+"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B28232E754
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607831; cv=none; b=doqiRA6uWVAxe3ZfykU1b01zTlTWthbfribsf7JrwSwwa3ECdXhmNl2Vr2KcsBPAqjOg+1ynkBxmu3V70LuAv/HwuRxG9YPnVa8N/bnhzA21OQg0R+YVpGM1TtQ7jBWG/C23o2RAyh9ccxWfb+rVUFjl+LsRY1tavt+w2Cp3g5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607831; c=relaxed/simple;
	bh=Nnl4wmOlmjdjQpJ1AMKKTFq1A3BB/KMrnObJW1VIWVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfl7vV7S8Mhk6UTxkGDL0L3iRUKzmHgzlQI/7uLqwiIfbpCD5SRYBEfUOsb0kNXV5Lj2DmD3zM04Cm562bJJmzicIoHovvDj8YM/Utqt9P9iBDbpnORmUeAoN/GpsJnjG8QNJoRV9hkxNYvxJnzFwooZDO1+t1Ba+IFA7jixndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=YUq8R8B+; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-430d4cf258fso20213215ab.0
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1761607829; x=1762212629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ldkibGRw4ckwZl2hrIKXdODRudH3hWdiwAG/LBXeHR0=;
        b=YUq8R8B+hhdEjQWZtki8XnxAHSp+KQm/nCEapsb9InbTxA///yo8/4L3Ys1YAvr8T8
         ymTYIPGOOq5TcMsN/I1uaYNEhn2GFE9Cwu3gY4EVM5r9Pv6dy29OMbmcWBS8GdcfGIZM
         rKTw49F52Q8CvUNVcl3o04M8TrFCIRbiyBsRF39yYvUC7ZtyJCkvMfhx9BGqauwiSk5E
         Bhl/WKGIG/mjFp2zP3uxbrfc9W4mHG8yKyyXAqa45y5MxUvxGYLy+HPzQpy9zE7kE44g
         lOOiL8niKTc0degt7AbBVemgs8l/Z60vBfp4CtCfC1lW3G4xbxSp/0qm4y97NBTlE8vI
         NZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761607829; x=1762212629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldkibGRw4ckwZl2hrIKXdODRudH3hWdiwAG/LBXeHR0=;
        b=jRefHMR6wNL2aN+4oH7NTn3V1lygKJEysJkblnefjIV3ZxGmG9sZttJdQyzKV6nS8i
         XuP7bv2tMugii9xAkghpYgb4WyWpSlMGBYYIqDiUG4frUe4PDEIS6PCIC3ExdxNqfWCc
         3Xo69RBTrpoZSBRxlu1cLp8RVACE1Qt650emJvfrdafSJuP/hPMFMpi/ONYIzyWNgU8r
         TFuYGsZbqFRl9eSjnLMiSseHKQ+e5/tsn8HRSueUWywwi/oe/zxzolifctG3ouRwff4R
         dp/j+4+p1Ev8Vh0+AfjkSlQ53in6OeRfyvBCBuGNhLksMt5LAslxYTnu8BuwKZMcZncZ
         3kTA==
X-Gm-Message-State: AOJu0Yzjq4RBR22ONPOHSbGnnaazZvoDLMohhAA7MiYUtiumuHtMR8b2
	YYVHFm44fWVIs3eI8qNz6HUxIXtlqg4l5ojBsB9lxmRkyK2NrlGQREOd8PE63y8Pmbs=
X-Gm-Gg: ASbGncsURqYDqvsLMMQE3W9odL2uIE8X+fguGRkz8W2CD7Twul+FJXWG/5MdM1riyWE
	AXO8Ux5BdKyBdHqU4NndKChkjFbuoe2Ci75VB2JmjVFe5ExxvRuE3Y6WSel2xmDck2GFrxgMrV9
	ilZwBCGJkHTllMFbcZ7Ni9+v4EgS+rwdhqArcsCwnMNQfupXd3muJmF7KaNHhdg+9b+g8flqL36
	e2IuKKcRWQEmXKaH1WqunwCisvZjSsRA3l9vI4Ote5ayioSkSwgIoRUVY90fx0hecy6llKIjJDH
	ffryKe6YAKCZ5jSXXSdIfiAOoYufI0c9i14tmbrYsx2tLI/jw4M48O18yZKyQ1r5f13egecxC6M
	B+wYekW6fd+Lpu9cIIQDUF/6CPDJtUoDJ7c63C+bv/jVB8G9Jz4MI2npp8XTab9xyEAyKZrHj81
	4RH/olIXSgJB3aMjFC0spK6ruipQ==
X-Google-Smtp-Source: AGHT+IGvzhXXqslGv9MZEWsvITO+9e9W7hE2kfZZMLHX7/6QstVZpa1/aFSE39Xoa1TpQ7YAxXkmsw==
X-Received: by 2002:a05:6e02:174f:b0:42e:72ee:4164 with SMTP id e9e14a558f8ab-4320f841931mr25299905ab.23.1761607829334;
        Mon, 27 Oct 2025 16:30:29 -0700 (PDT)
Received: from [192.168.5.72] ([174.97.1.113])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f6874a1fsm36049655ab.18.2025.10.27.16.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 16:30:28 -0700 (PDT)
Message-ID: <a4ae843e-d401-4e25-af83-ed16ce80c2d3@sladewatkins.com>
Date: Mon, 27 Oct 2025 19:30:26 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/157] 6.1.158-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20251027183501.227243846@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20251027183501.227243846@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/2025 2:34 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.158 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.

6.1.158-rc1 built and run on x86_64 test system with no errors or
regressions:
Tested-by: Slade Watkins <sr@sladewatkins.com>

Slade

