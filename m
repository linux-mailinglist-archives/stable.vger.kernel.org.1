Return-Path: <stable+bounces-185735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7E7BDB9B8
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 00:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF22426265
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 22:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A322B30DD08;
	Tue, 14 Oct 2025 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Lpw78URw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497BA2FD7D9
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480351; cv=none; b=G0DzZ12RenqnmHhxUJfAf/X+NFWfpgWBEzqcqdiozgZt7Ea1/XKNTDx4N2Mv0kk3je18YV90w0arisOVCTSY5LZ0V5SfTWzzdyvunQtfZhKStDI+vlm0hVDfRiqGbdLHLmx2I01yrtbudmCuKxOPzAlTI7BehyQZnaD+su+MhJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480351; c=relaxed/simple;
	bh=d52ol5jDnCqNM35j5xvJNRzYXDEU3WfnARQ/CVHCRFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqEmi24iHI/tMZc3YLRFgueIP0rY3eoIVJskF4SZAP8P1hM+iJiB1YS7foQeovx2WVymJ8wFkHpgIbg/BRI5mty5/tkU9+Tlqae26CYWPrQAFupq3gpD49rs01adGW79kHY14kyCEz0ODMyk9jFUCPjxtsn1QsUp/t4u5fESHow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Lpw78URw; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b551350adfaso4820010a12.3
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 15:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1760480348; x=1761085148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alzbq4xn+X7BhpgLRSUY/BiUcuSjAW2A5dveqJOGO40=;
        b=Lpw78URw8NIOO3BFwUNvi4J26gh2iGUWgUzY/fffexJ1ih9F4E/IzXTuX1e1NlKZxi
         fvl1XpxxK/qWZDiBAOsUAjRYnFZ9xHD/KvF31rtCm4nLRqQKA0slJIrs3mBcfTw9FVZc
         fsgHju32irJeKTZ4Y7aOqEKC4Sk9ODm/MpoEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760480348; x=1761085148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alzbq4xn+X7BhpgLRSUY/BiUcuSjAW2A5dveqJOGO40=;
        b=RURM7zpFgzaHmS5l1mkOQ5AMfD2y36cmVmfmfiRmHhkQVUnWbdju8aVm8Zv6cB+bjA
         NO5dvKAPLVrnqgiX3L2mrTX1nka5caCx74vYl8sSHsT5bXyLRcTSctIqlY82vKhYxgzc
         TaXmXEGti+xcuraLMAcdsUfKaFKZ9mHRh717e48oCcKMHENBXVRVfCPdbJ+5oDMtSYMH
         HM0xcZ7miJ+0TFU35/E9B3HfTA2xQsrPLjU+3YUq8n5ssRcjxVWkB9CLn/EhADj70+IT
         No3e6zHeZEnT/rvW06aH2rE4QgbZ/egc35qRfn1Z6//8ImiBDxKG399ZDJGnqcsKhk2Q
         4xkQ==
X-Gm-Message-State: AOJu0YyIbsA3CAdzPYc5VYyQfePRbofp5rnvuMgOTdSZ1/evPd1qXad4
	4lH5+gk5mXYnolEf2xQvAjUDv0SqKqzbxVzu0QEM09TFBSZwCrNfcwFPJ2MaHloQnw==
X-Gm-Gg: ASbGnctX26Whsc/Xl432+v9u4CAjkynTnygZiVVkZOSBRZecz9RNWHzP5zNJsmO0qKb
	LX6HYbuAyXJHpL4Z6gzzd7ENVS8vxup2bCFSB2H0SglZ2x4B9vUeOJVROtI/46Xa9+pEQOUQbKi
	67y/q1KdRAqyYmW70+x9ToOqDwFb5f/VUXQnJClmUBnXZJvAM56a7pD8F2TBYRbNwMX/i9voFPC
	wgG5KPgHCt7E5+WHfSuky4l9foqGQEYU5Lmu8CP6+avmZtYyVsF01P4U4zBUp77OwBEA7oJWFUV
	Z3CcQEXcTopRIrJIKElqvvhFQTJAV1aWdz2zEpYkaFTDSkIdQ659geR+1kL1BKd3sPb0pyBotJ5
	JqChD0b33B5Bjc9ISHLLSAYViUDPuy+CtVk5juzACUgeltdKr32Ac2D3/RCcqGwNodQ2/4dps
X-Google-Smtp-Source: AGHT+IHdeP0YjbJf85NTvomIyM0+GVcr7Wo5mJ7Nfb5UdYxRTyJTMFJyGm2BssQ8MnxvTKoUs9ugRg==
X-Received: by 2002:a17:903:2ac3:b0:281:613:844b with SMTP id d9443c01a7336-29027418ecdmr328650695ad.52.1760480348537;
        Tue, 14 Oct 2025 15:19:08 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.127.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f93b71sm175405965ad.114.2025.10.14.15.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:19:08 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 14 Oct 2025 16:19:05 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.17 000/563] 6.17.3-rc1 review
Message-ID: <aO7MWRnf7Pk023jU@fedora64.linuxtx.org>
References: <20251013144411.274874080@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>

On Mon, Oct 13, 2025 at 04:37:41PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.3 release.
> There are 563 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

