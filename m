Return-Path: <stable+bounces-46183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C0A8CF01B
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 18:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD8B1F216C9
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3180E85953;
	Sat, 25 May 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjsVisRI"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E64EB39;
	Sat, 25 May 2024 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716654401; cv=none; b=XmohnhYd0r69j6azWxjhUiuhWDhxu0c0itLzlHlh27k1TgDAdkvZpudZTZROipOgG/WNT1qD609TQ24cuOYpqTXUy0RfyUNhtf+i4/MrjL6A1CsGPijchNSJON4zGU5Gaii4P9xAYM2tZYCxyyKTn3Lz3nJ+6ObuBtj6/lCDMMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716654401; c=relaxed/simple;
	bh=0tlMPX6pKVegbdDRsC5185TnEuGv0EPstndADHcDnVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXhp7mfDvErZHuBYp5HxFuWhR1KRc5ftyaR0nsn5t69lvQggj36VwQiBk3yu1NxIaFG5E8n46S9SxWiMRTV8zfr+PrO62WfkYOitZzRlpXfTaCLNWhN2wIgbmmuTe0tmZToUT5czOh73rkyBbG2klRog6IlWp9laqjn5QC5I0C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjsVisRI; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-488e8cb86c9so2414168137.1;
        Sat, 25 May 2024 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716654398; x=1717259198; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mKf5sUaP65S0QiB6MPT5XlN7Ji2S0ts+rReTIXBK/9Q=;
        b=kjsVisRImLFzjJkDBiVrTk97ja4N4JhlKn16TXC3Ar5oRPQ0GjI7o2L28mWB0V5akU
         MwdsFAQZljlLa790M2oOFpvJUB4quVTm0kSvyZBkEhMHcL9VGdWWAEfzqboHQ7/aGtLm
         ywlKbvbOqO00RnBz7423Ij45G1VgZtj68u1WU33oeJ8oPqok5J1ENQnydO9uVwnFWq91
         gq06vNxSiXq0HcMBVPuPOA5xAIOUKVVYrmGPwlUYpbZxJbzNOcyqfHTcA8PF7u57YRvm
         TCMttpkt13dCniX6wgmrp3FjJhzLS5XAp0kNtdoIdGIenc+MTXKcT/gGetTDCCYkJkgH
         65zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716654398; x=1717259198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKf5sUaP65S0QiB6MPT5XlN7Ji2S0ts+rReTIXBK/9Q=;
        b=a+pWdTwHGjFlL0tOTAdNTRgHzQS99DLr5+CYZ+0WE58PtA/0Z2yLAuSljBp6ORR3dR
         daxD45M/HE+iy9ZQ3nuMPH9hdOnt1SRBCHoCvvldbat8nKk+5m94xneIjRU1yn9jzKia
         ex1RxDVlJuUAt5iyrFt33TbYFw9vYVjJ9EKaDGkMN9aaVVJRdfMixCq+/DaRF1OqvBB9
         ayD3/F/WWtuKFMJYfu4GKzczah/RYVXm1JBtgeSodFm74paE/4AY1V52HGNtNFcAo7jQ
         F2RZsdu+9AjlIq3WwC4pyaAtWmnrP/j1KOiANF2zwQ6UeVMoxshHzlrI5iVatcJvMA0e
         51UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHoh4SOQV7YqArdeWqO2Udl4Oq8fisIM0COx0OF8umQwcNkusGJWtYk1qDiaPLRfNy0Lc9Mrn6+oaFF5tyANfH6rzb7MpVcfAwHrzB
X-Gm-Message-State: AOJu0YxK5jcNOtSLPwuAKZ74FC+4abFImk/yVyXNHIbJMgaLmbBf7nnl
	4lbRWMNltvGq8qC6zsgMg0ldnL2P0UBbaj/NYtdU/uRzDR3PA+3PJFcW9bmSpSLVKer8vuQ4kW+
	4PZaZjT/EzAS16AzSw1I7LiHZzV0=
X-Google-Smtp-Source: AGHT+IGH6zvOvxdG02BDd4XJMmzu25FAulQG0edcfbV31ZUG8F3+QqEbE4GVxagFz3kYZ/ptgWy5QIUU1Qa2tcAildk=
X-Received: by 2002:a05:6102:50a8:b0:47c:549c:d6a3 with SMTP id
 ada2fe7eead31-48a38516f78mr7186945137.2.1716654398560; Sat, 25 May 2024
 09:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130330.386580714@linuxfoundation.org>
In-Reply-To: <20240523130330.386580714@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Sat, 25 May 2024 09:26:27 -0700
Message-ID: <CAOMdWSKZPBvDmzSsVdrJANaNeo525B5keoqPMod9eu0uTy0MAg@mail.gmail.com>
Subject: Re: [PATCH 6.9 00/25] 6.9.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.9.2 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

