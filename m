Return-Path: <stable+bounces-207917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AEED0C646
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 22:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F670300EF43
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 21:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71BD33EB0A;
	Fri,  9 Jan 2026 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="M6xf+MRg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59EB78F3E
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767995605; cv=none; b=F/JXVPvXfyokNShEVFGR5+94J9Z3ysS9v+t1OCC/wKG/04BAcMzidgCiyn8c/XHd8p/DRZ0J5mNfQ43MUVIlXqsJleyFEME8Oaau8503NKw5Jok9d/v4b+6ITdfjoZAQmAgC/A6SvPbBoPHBfRUCrBgEGLlM1Qj3r/KacLaA9tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767995605; c=relaxed/simple;
	bh=2Bta09AKk/xhCzmB4Qub480XAxzJRUA3eXVNEHVQ99E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaC/n6xW/ihTR/KT7b4S4bFn5e7kPyuwVMeTbBOUWZ7bKogNCcxp8l0/dOUETMt77fSTBdwHvP7+QqNKI55hk2C48+SirERPTuopWvkhpgt180/MStPsDW0cTQ1angM6x47Q1cwfRyTPbxEiHovUecUny3heuqboGbR9K6xMZB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=M6xf+MRg; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8888546d570so57139606d6.2
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 13:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1767995603; x=1768600403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMGPJXBv9iAz3mtOwHOHzrPmXSH9aBsNL5t0HMDT9k8=;
        b=M6xf+MRgUb/3xXa+yubFNji+Njl+C2yBfm2lTuQB11FMV5sfMSjMWwRO+iDJ1USHVg
         BH5MB9Coc+I/O6BzYZkvJpsfpETaELF0ogqgMf2+1DN8TsicX6dEIccykd4vlNu7uFUF
         aqiPf+9dFVrwj44E2G7w1mEhy02ahzTR6BZ5YA4oJNynyz08PEJb6L9VduTIcyE3HVEd
         /17RkjtdKkeD1LIQ1kLGqnPOqFjUnX5OeEvzVkX1yXQQWyRJvVAco7HPHwG+buy+cCBy
         gALDH/ndOz7LT3AFy2Paismc5LBoq8wULy7SVGbrvs3c4kysFwDK6siZtdYfnuTKOSEN
         kSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767995603; x=1768600403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dMGPJXBv9iAz3mtOwHOHzrPmXSH9aBsNL5t0HMDT9k8=;
        b=Si6BfXBwsoCc9BP61nKjUSRyopb8903dFQgHW9ZU1gpoC/CARPy5K70ncgEbBwBTQ4
         bNRnNQvCoWkjFAmxeQq2KH5vCMskSSyVsqHsBsarQJxOmeWZHGntpk42BHNM7mRuV7p6
         A5VMqMCEYZdxf5mBoNuxQxXUdGQYNTFZc+M0LSL9urguT96GtqGi2P/cINPkgMhaOjYm
         f8AOCflhTqSxuQ2uotcZ7iPYiAUdFTpCGkqCP+OdX0j3LL7CfsoVP5nKsHZPwn8v/v44
         lksUy7clDp21hwALBphtMdqQvq0jPPwIRy0jmOQxPl7MoevIYKAzxBcPnwPO1bYuZl/8
         GpLQ==
X-Gm-Message-State: AOJu0YyR2n2DDiufBJMasc65kPAs5O4hMjRx/d/yMWRirklJnJ2d+SJd
	ttRzsfcdgih3v/OsvpGkyFE2u/XyJxwOs29vbxlJl61kDrdzObdypHPNA+ntVwVGVWNqfY3VGx9
	j6dNoptf0YwNc9eP3B75ACszEmFSw0S9XIulNQT3AeQ==
X-Gm-Gg: AY/fxX4HH9Xh2vLmkFCwjeIVMBh9RIymoK5UAA6O7Te165OGriXt9PhNWVUQkG3carG
	9uLbeH7BnCvPFINP4w/HAP8IFZ+vsTp7H570Vfta8tJ+ZGuGPhD/MZb+P2z0neg0P6iCPHxTWYh
	fNtFD41SkynVTLyvQ4Wf2wx4MMP72dy8BNFRwHpteHxEwh/Bs5Gif0UHh+1GISHTFiZUiq36euP
	VDU/FonXCYCJsmMZj8AvHtcaPBuvCfs6+hhtqeLaZ8w0ilCl7ExyCYoW02y1Pf2l74u6sxt
X-Google-Smtp-Source: AGHT+IEW/p4hixWV9BeGx5tJBaWuU20DuVGaz6lXqZdluaCzfoOXJqtTS7dfgfkGvtmZzUC0WWwbe3BHmZeiYKe8xgk=
X-Received: by 2002:a05:6214:d0a:b0:890:3f6a:fab2 with SMTP id
 6a1803df08f44-890842f028dmr180587156d6.68.1767995602667; Fri, 09 Jan 2026
 13:53:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109111950.344681501@linuxfoundation.org>
In-Reply-To: <20260109111950.344681501@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Fri, 9 Jan 2026 16:53:11 -0500
X-Gm-Features: AQt7F2o9Z-zBNlx3Ur5NvDt9MJb_s5zvalgo5BFYow1fp8ySN-yb_rpE2erqYeQ
Message-ID: <CAOBMUvgjai_47tfHe7dpbSSq75JkGOdf4wja_RX8CEXcmg62_g@mail.gmail.com>
Subject: Re: [PATCH 6.18 0/5] 6.18.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 6:45=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.5 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Builds successfully.  Boots and works on qemu and Intel Core i7-10810U

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

