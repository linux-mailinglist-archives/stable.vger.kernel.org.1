Return-Path: <stable+bounces-64779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7AC943251
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 16:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494741F27346
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 14:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4B41AE85E;
	Wed, 31 Jul 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RmK7GQRA"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AFA1BBBC5;
	Wed, 31 Jul 2024 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436979; cv=none; b=ZSvj75IWMbokewGVs5KCa+FQlxy2dFVwtpNk++wp4yAVEKxqE/iuKUSMmpVq8XkyWlB1drMegelHFJ1Y7AT2rNtKxwSg/uZ9Lcd1PfmXnEkyVFXVY64K8zGcq0+tTnn+1AvxukO2Y5Q0PsDwOHdEA4Nsqs8hIXdxRi6ZW6M5IhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436979; c=relaxed/simple;
	bh=03o06WRPMECBH8cNLsTZ+D+b1SXhalEQ2Hoe+OeZjbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bF+FcPYFzdecnK96YWxHHYzbLu1o42MgpcPSe8v+amrZd+2cg5ijxRhUuGzin8dX4IoHG5J+8UOwSMxyND9LfyzDCdSP7CZFTdHzTAnjFp+NC9QSe2GhKz2Z2dhVBOJSskYrQpnGfAqV1wKGVnzSnV3GP//FmZdKdxV5Io97dRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RmK7GQRA; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so72470181fa.2;
        Wed, 31 Jul 2024 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1722436976; x=1723041776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7+eaS7WmK/h+AxO7xK0Tq5m6QMfSwjAwlMf/qchy6iw=;
        b=RmK7GQRATtmefFbwvqygIrm4KSXjT7RIGXgZuVl7dxEoYi0whGTVQ5zBwce4Z25T9i
         WAQReh+mc3IPFEJtoWF2RTh8C5EAK0EwOLJC37RovkHRYf9MBIRzVM08O+dfa4gMKG3k
         /N8XWdKm30JLcKrIIsCHGyDFGK1EVwk0DqsbbcaVXLnYPrHh1+/mm3fhJzTyBUL+aEYy
         dTGaYhf9krBMq2FN+BEgaL2EYHfJvboyB9uwYparNall+hGQisTgpUFPMPPJWy6q7fTH
         rmntLYlP5spX700gbzW5usl0TCJa6DvWtAnXSAthI02fAfjR5ATwDwJfqUSlW2S93rvS
         P4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722436976; x=1723041776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+eaS7WmK/h+AxO7xK0Tq5m6QMfSwjAwlMf/qchy6iw=;
        b=eiL84ZLxVfZQATdne8C80P/JCeol7qgtm8v3CipKYBn3N9k4IgCEVvaxyVBr31aoX2
         /7QhP/mJ50l+ugK4m3eM7c/IeesEKBJ7rgLq2Vs+gZaCAg6wbJzYmCKva4+q1juRtDL4
         REVkjLcunIlztredvgAajynnIXSBJSxWGC79oeAZeyTrDIl+ndCJe7b+4BFnOnkUl5Qz
         sSL1NQTh1Z+nmMSu9z2LqNHeVB9wm5KoobJHhaBH05yQL4ZANXtM9MS622L6sjGGyVeu
         XzY9FjU9arl0F9zy+KeyQq7klka+bsDFZZpZxKe08s5bnXsvdXTdpPlRYAro33eTT+kb
         ss8A==
X-Forwarded-Encrypted: i=1; AJvYcCV7/UbdNSAywANsN2mGQ6ynHKBWjbeOQxuUdBXHTaojpaJarEQ6iYcK4Dwj3bGPQ2nAloRCNMNhOfBrMgx05o+eHcK1Ae2hvodSDbSe8VhujF1GU9CjlRsbLUp7v5VrG8OrXLBf
X-Gm-Message-State: AOJu0YySNdY64dXaMnEGmcNlq1zUkFKWC3weLeVubexfdNmjdYl1urvj
	gIFFT9ayu9+55wGVouBfXioU5BKBViVoxjVIn7iBRAvZ88Ac2/M=
X-Google-Smtp-Source: AGHT+IFXclmu5DEIX5SRJTwTFkq5JFNwJWu6kCEgvQ/1i3mVfeno0N3amnMwKWgaIPb8PCQESr5PZQ==
X-Received: by 2002:a2e:9609:0:b0:2ef:2a60:c1c1 with SMTP id 38308e7fff4ca-2f12ee1663bmr90480651fa.21.1722436975606;
        Wed, 31 Jul 2024 07:42:55 -0700 (PDT)
Received: from [192.168.1.3] (p5b057724.dip0.t-ipconnect.de. [91.5.119.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb6403bsm24239425e9.35.2024.07.31.07.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 07:42:54 -0700 (PDT)
Message-ID: <018c2396-3a00-47db-be60-4a49e3668a9d@googlemail.com>
Date: Wed, 31 Jul 2024 16:42:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240730151615.753688326@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.07.2024 um 17:43 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.103 release.
> There are 440 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 Aug 2024 15:14:54 +0000.
> Anything received after that time might be too late.

Just for the record: this builds on my 2-socket Ivy Bridge Xeon E5-2697 v2 server, but 
fails to boot due to a kernel panic which others have already reported.

Looking for testing -rc2...

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

