Return-Path: <stable+bounces-121298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BFFA554FC
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562E73B31AC
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 18:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC53B25CC96;
	Thu,  6 Mar 2025 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrQU4/9k"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F053025C708;
	Thu,  6 Mar 2025 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285650; cv=none; b=VtWwyRkdk7NVaWkZpmr5kmxugSWOqizGd9Dos9V7wf9b06SPFXfSesOlNbUuN4Jjq40MIkFOdwJaEpygqD6OM9C8kSZQT8LL1+fnuXtf2em9SrjnKi9r4jGr8yNE6BfcQgp5859GqSH/wrqHDAeH56jk9FGPvK34/IcmTzaDXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285650; c=relaxed/simple;
	bh=u17mTQN+8NGjgTrzhenTMjvDiTCI7qT/Uu6sUKAN49A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OzAqRy4G0+K2OonSfYdA8po96GzBqlQ49iFJSLlDvR1bl4ZMc8g2B18+M3YCFErisn/awgfcVDCm+9Z67L5+CSZmH7WC6IBdNP6izKAJlFdWcIO59jnq6OeJWfvMHfAkBGzW70ow06RWEGZe3tfz5OhSB4ZpritqnpswNS8SVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrQU4/9k; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f66dfc205dso659008b6e.3;
        Thu, 06 Mar 2025 10:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741285647; x=1741890447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dxq9TpE0nVpJ4LjErwwMJdonTvvCHuk+jzxyXFO4lsE=;
        b=VrQU4/9kiMEFMQpjvaAta/sG2q/d2n9YwkEuPw5Lze+ZVUAQSjZzDYOJGgmnV0uvfy
         OnpAizVXsiYxN3IPyShEsQkQdvhtB7AUZAKcPVjEeGbUuaL2Q+W9F3eV+KoNLAoAeY33
         Aio3pI/Cy3zjO5tMYlNrphSKIISEnY8/KVQRnpPsQZ7aeM/tczcGxNR9zLtW/h/muPME
         mhFf/1xqmKlrbUB4DZSAzrabfaoEeYDil+OkQcRBrmkWBq7Fi2qPVcTppQ0RRKghuM8m
         +HvA4aKnNTNaDzohoDHypHHTjdl4WH68EPIPgDQ5hZf+rvUd9q51evW/9n8DSFQmnLhA
         u/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741285647; x=1741890447;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxq9TpE0nVpJ4LjErwwMJdonTvvCHuk+jzxyXFO4lsE=;
        b=qbunnADjFoBw7vK6hiYfJ5eO2z6Ng+3aGG/3l32BV0GV+R73hhIeihSM/E0mJFn/hb
         ADUeFxCTGu80pphx1zT1S1kKgL5vT/YJesRmZn0ukPPsmSHTUzEm+7QsOgFSo1ffov8y
         IJXrLpR7fItnjZ4d1Qb+OIY7rPqAE8JhfRsfSvt6ze0bZvtrZnVi/Nbl9MSuXJ0PlWd1
         a5AyWWLTVQoLet8zBpMRNWyZB0MH/Ok3VzO3Ge8+IcarGYUW9omRiJSDf0IU8b4Xb0MT
         AHjc+wtVE7rhnhFdDNScU7c3q+zZVTLi+5RYmPjBzwUeLHZdr4fzpOL3rwrujz2T+FHP
         rKrA==
X-Forwarded-Encrypted: i=1; AJvYcCU8gGNN5+bb67OBtUllK/oez6XtaZznZaIyahUBbZHwHJKxlNE0KFO5Hsqjw4bTta7NZTu6AID3@vger.kernel.org, AJvYcCWme2kP0rkSkAxAU66HuuwijgfEfmIRLvQAIqAJ2als0sHxpaXR0uctJA/ORUHWJ9Ok+MAIV9Sv3aPY5c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8bfzuqHby1oVkU7G3XMpQZMheERmECM5OOVid82qtSVDbenx
	80SBtuL+skYxCQD1NG6j3vj5jzO9KtbWZUi4xjkRtxV8GREH+5F+
X-Gm-Gg: ASbGncu+nhoEsmCMa5TgpDbWaFsSlVl1Jw9UN6UAKLd8I7aixLVc05J4lkEbWOxVPXl
	WJ0gK3Dxy9puQBFKIx9f2UsDEYkOSECcb52HpRpwACNlY09eiWw7cMctqvNQggdyUA/PMDzxtGq
	EHrdAnEa6lVrfER6z0ze+F/FsOGW7+6wGSO5670HOA1pbXiNuNq3LnbBxuh6BqMcRhAXE/lU5uT
	JKOqzDKtAmhQvdTNBN5Ez6vfuAJf7adRRuXq22Ekb5Z3rrqmZBCW2jUR1B5kuJMkw6MptVCs/TE
	ntXwAxh8FB2M3C7gA3D77aiI9zjuw2QO1BwAgumbGSV09dZcsaZ8XVHj3X/Oxj5fh+Ew/iYd
X-Google-Smtp-Source: AGHT+IGESmuRrzHfywIuQCgSLLcA7xP7MfEHE/ovN+Dnqjr0GlXyblDPYRx8+ijjlyLbRfzNs/WByQ==
X-Received: by 2002:a05:6808:190b:b0:3f4:d61:3709 with SMTP id 5614622812f47-3f6978487ccmr258828b6e.0.1741285646957;
        Thu, 06 Mar 2025 10:27:26 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f68ef9d93esm347003b6e.5.2025.03.06.10.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 10:27:26 -0800 (PST)
Message-ID: <9496fd88-d58d-4c68-8ea5-04387e83bc66@gmail.com>
Date: Thu, 6 Mar 2025 10:27:21 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.12 000/148] 6.12.18-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250306151415.047855127@linuxfoundation.org>
Content-Language: en-US
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250306151415.047855127@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/6/2025 7:20 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.18 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Mar 2025 15:13:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.18-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian



