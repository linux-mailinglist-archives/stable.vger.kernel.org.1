Return-Path: <stable+bounces-69392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A66A9558E0
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 18:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DE2282743
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0471154444;
	Sat, 17 Aug 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9Ooym0V"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CFB4C97;
	Sat, 17 Aug 2024 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723911743; cv=none; b=NJzZ42gEPiO5qQYMqbtnkiKxFH+b33vbjaxMrxM06THo+AS3cvwvcMNEtUJAqz3Uollz5MAD7Sjw4Pc8d/s8drv6SHmalx7dI7Au8+7DVz9z+1qy5xuKq4KvNoqP2g9Mj4qZNCNE4Nkmr0zkdHB8RRgLJIQaSNnK77g1eO9P+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723911743; c=relaxed/simple;
	bh=eHPTgf5wRj1IVdjxkVYmpqaT5IAXgAF4Sg/kOLkGvXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsmHmZxD4Wa1cfE0DUesZIr2O+hNNQuJLCm0Oc2KAOgShrBRwxYkiIVpXWdjBi60biiiT4/+4cTyJ2K4gcfa3TsfepZPi1rQhr36GCi4S5hv+4Kl5d80XS1tr2bgg/Qv/6p4WPFPg9HoBqO8ttkCqT4LxwUUHMgqsb9vatOPWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9Ooym0V; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4928d2f45e2so1101872137.0;
        Sat, 17 Aug 2024 09:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723911741; x=1724516541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t12/vKBQ+BTOwmEU28CoMcUpgMEMzkHiojh3S4o8A64=;
        b=P9Ooym0VCuCgwlX24mhjS8bPiRdTxC5b8EzlLCFEQU0BOCEU37ZOTlpc1kNrx1hVHM
         csko1s/6TYsnuv5OyV/9kvmWCygNpFgMDdNfKhqJOhGv/5Om0lGgc6ADSKa/rVVQ8jS+
         Dl3f/7iQ2/SYvHpfoQuGNt+OYR++yDhrJ5yQV6sTK9sbz8FVeWCVvYh8OyTpmGNFtpaQ
         NViyQIemfODhtauWjF1LFGLRFTcc/iv4aumk6KgQX4BwEGWTOuB3bhM+4NXaQ+qImSzj
         yPRC4RmRoGuMAJlA7ya9k0iV4VniHkn4n/9bpuxJ2ox8SZJ1FUz7pmhJW4DNY4BGJwU2
         lGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723911741; x=1724516541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t12/vKBQ+BTOwmEU28CoMcUpgMEMzkHiojh3S4o8A64=;
        b=DzaTjeY/Q6N+lq2vDlT4tNjn55LpcWdmSQ068D22nv5+sxIntqEnh1KeyWj/EpUq/5
         Ghzc4JPnvHkkonmDzMMcNCD6YB1K/02UMsFaRB3kZ+xqhkb2OTFRpYOaH7BHN8iliXiG
         nSIDjPVL5bAzFWOXxjDgltcPdpAtuXUI8IDKg0vvK+TMb8QnuF4N2c71rIhWUPs9R9I6
         3JNbvSaKU6Lo2EN3N/Sk7c8w5CyEJrtTwn8jV/7aYAay4hDF7PXn7to7KhsQQebbrchd
         T4V/fN0DjOA/r2sKhpbKkyQHXRVPhh3PlznTDIm2DFDeiqU0xMwswMQJXxJm2smKCbtA
         pJTw==
X-Forwarded-Encrypted: i=1; AJvYcCV4JGFyhGDhvpi0UUE9fESDce7Id9V6a6CokEi1MCL92MUtJ13W5FOyr4ol3pa4P+vfFcAoHOeRonV2PFHG/CCHHUJkPjt/T5l5xAI4
X-Gm-Message-State: AOJu0YzP9d2pQM3dSP1Ktbaf55IdDCL6VtVputJ4VyZpOC+tmWwt9MdR
	I5Rzi9k5gt7c+i3ppZSq84ltOlH0KQBTu7luSOH6rSiCLBvYyvs5szVCOxcL15KCFqVx+vu38gN
	EoNF0wG7uBWTBl/rUS3ETUXESXjA=
X-Google-Smtp-Source: AGHT+IGGYMDNINV6tzu1edYqfq60zKD89vxmcioB62e6R3vGJZzREKM2WCQ8g+oP+MeoG5ozLwEKe/lqkBgOUSJnSSE=
X-Received: by 2002:a05:6102:5487:b0:48f:e57a:e2f6 with SMTP id
 ada2fe7eead31-4977989a328mr7027949137.1.1723911740752; Sat, 17 Aug 2024
 09:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812160132.135168257@linuxfoundation.org>
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Sat, 17 Aug 2024 09:22:09 -0700
Message-ID: <CAOMdWS+OiSaHXQsChisvGJAJSAi4b6A2BcAVECXFdkjiK-yOfw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/189] 6.6.46-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.46 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Aug 2024 16:00:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.46-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

