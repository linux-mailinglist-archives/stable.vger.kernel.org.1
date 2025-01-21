Return-Path: <stable+bounces-110072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E0FA18786
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 22:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0743A5120
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 21:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437871F8901;
	Tue, 21 Jan 2025 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEIBH00e"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E941B85C5;
	Tue, 21 Jan 2025 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737496635; cv=none; b=ea4UB/0pupXCCMvclAtJUOP18BuJaP9CgCX1iaF5vgF/wHX4dAfL/Tdw+xdZYAUBMJh7Dfp5mLixYDjAsGmqyJZfIWoL4AyGz3hnNlbfr35CjuWw24frFXX1/H/b9CI/Q8RxB8Esbk7ysAQNwouTsNuXjjPrBiZt4q64F97LfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737496635; c=relaxed/simple;
	bh=GOHjZrdx+5J3OV+KNYZN9SaSqHV7RronhTFCYvpWXfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUIRK1t6NukJOn6V4XgTz/kzMh8nkgmOjUBMXzOlmx4U0hchdkY48hGuVvfjTuQ1ohQj1e/TIII3NM+nyW/k/gM0BlWK/KXK82NqFirFa8TAzWhMXDEXt7KW4nxP2w3iKy/x8FMhq4k8bNrvb4MuArxK3x5YW2KCpQ0bVIsvgpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEIBH00e; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab651f1dd36so58013966b.0;
        Tue, 21 Jan 2025 13:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737496631; x=1738101431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5YOtinlKIQcBOdKFHM/q6wdfeRS3f/aMXRUpTGEphI=;
        b=AEIBH00eeXSeHD79eATxZJe/a3ItOXwK2i3uAKfoJv4X51Jg14/zif1iuJwS5inh1E
         QYTbib6YAiVtJx7fjKy+xnTBvksEAG0bNxdzw8ZYNxNyGB6bUAxW8MbdjHDZhmyvlB4g
         rorxUToH9rXa3RQ457syV4ZXlDkaXEDckNrY3IGFqwG2IkoZzB1Hw4MCA4Lnc6zt1xvd
         Czs8gsDaYMQdjK15Vkl4NrV3ZSyrkjTbIKg140EOgD21t89jWDSX3gOHOiTtIpwQgex3
         SInUCNDicCUdNcPK3d1ePMFK/9+ccY/S3iqcgdGcueanE3eXyaYzPVHlhKs6O/5GXJNx
         633Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737496631; x=1738101431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5YOtinlKIQcBOdKFHM/q6wdfeRS3f/aMXRUpTGEphI=;
        b=rcd9VmGC/5eU5XCs0haU1k0hDNCtceVYnW+vkP898K/Jnm/snt7cZPGCI7PwHDOF8t
         W2wkUSJj+2YSA0sd3O3Ry7FUi/zBJxXwCJ92TEgdbDLT0ldg6PBrak8GuMW+eky9l5zy
         GcYr/brRND0vPx2ZAwuB6+jK4SjMjZ5c5s5PEshDX151hk/M8g7iFJmvZZUREYf6K5Er
         bZSuBAa6AvLTZR1m/Jv2PDM9u0ud8nXDwXj+3Q77gcvadyA8Dpml9ZpEEFXEXndcQVCs
         JFATVaHyVYu9mB3mvNNcnj0IMf8QgKItxk9LiZOfv8VS/FUb1ZEgZW/xg6OGWA+QfRVM
         wgHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcubwadGAbT9+M76JWKCAV2kjynV+yBS5lLV/P6M6dQJp8NiYou01fM/89a0p0RU5Dqo+FnN0n@vger.kernel.org, AJvYcCX1W9P0clYztQIymXSMSWN+e6ZaJtQqW/qarx9E0MoEjbTcnbIST0sbb0xILxMm3u7x/Bb3JUZ1oFBSndc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyviQ6RLWeIMTK5cqOjCQfjSB9Qks2ooir0dXVijO+zZjc3rNqM
	QCMPVJoqNmz6q3QSgAijqVr9jwiS67fXYHSnd98L7HR8t9qk/gLa
X-Gm-Gg: ASbGncv+AL0lVPD0UjVIrVSAR4RttVfXcPnLrhV7L61BFPbj2QpxtGVvcXfbWK9MM1y
	Cy6/m1mMX6NSqSCdH1dPy4qVkrU+mlA2tRIBdPVyT/YDwsTq6djsuh8VMrMDTzwd7xrDLmNWruL
	2CyXStl0KYaMBj2U8SL2AlZHRwrhntzmNK/36nsjmzsp8We4NeeQxY1gwVAyYm3cCM/arB17XIe
	MbGUCZjg+D6nwUYvP7zrGUAYx8EwlSAqUCqbUFjpARLpWT8U3o21pr+kF7QKeB30HwV7UUTh8MB
	ocwwzDi7muuKxaXYy/ylN4lyJD4=
X-Google-Smtp-Source: AGHT+IE4LJkfhcAMnZo3rroqxamUV2ROsiauNTWDdyhouPCMGma/ueNsQqxJypcf1fu2I0NSj8qkdg==
X-Received: by 2002:a17:907:969f:b0:aa6:18b6:310e with SMTP id a640c23a62f3a-ab38b429787mr1999288066b.38.1737496631424;
        Tue, 21 Jan 2025 13:57:11 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f1e404sm815579266b.98.2025.01.21.13.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 13:57:10 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id BABC6BE2EE7; Tue, 21 Jan 2025 22:57:09 +0100 (CET)
Date: Tue, 21 Jan 2025 22:57:09 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/64] 6.1.127-rc1 review
Message-ID: <Z5AYNaxIm-SwmUHb@eldamar.lan>
References: <20250121174521.568417761@linuxfoundation.org>
 <b5f7b88a-0f6a-4815-8344-bf6bf941bc91@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f7b88a-0f6a-4815-8344-bf6bf941bc91@googlemail.com>

Hi,

On Tue, Jan 21, 2025 at 08:32:01PM +0100, Peter Schneider wrote:
> Am 21.01.2025 um 18:51 schrieb Greg Kroah-Hartman:
> > This is the start of the stable review cycle for the 6.1.127 release.
> > There are 64 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> 
> On my 2-socket Ivy Bridge Xeon E5-2697 v2 server, I get a build error:
> 
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn303.o
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn31.o
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn314.o
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn315.o
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn316.o
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn32.o
>   LD [M]  drivers/gpu/drm/amd/amdgpu/amdgpu.o
>   AR      drivers/gpu/built-in.a
>   AR      drivers/built-in.a
>   AR      built-in.a
>   AR      vmlinux.a
>   LD      vmlinux.o
>   OBJCOPY modules.builtin.modinfo
>   GEN     modules.builtin
>   GEN     .vmlinux.objs
>   MODPOST Module.symvers
> ERROR: modpost: module inv-icm42600-spi uses symbol
> inv_icm42600_spi_regmap_config from namespace IIO_ICM42600, but does not
> import it.
> make[1]: *** [scripts/Makefile.modpost:127: Module.symvers] Fehler 1
> make: *** [Makefile:1961: modpost] Fehler 2
> root@linus:/usr/src/linux-stable-rc#
> 
> I have attached my .config file.

Reverting c0f866de4ce447bca3191b9cefac60c4b36a7922 would solve the
problem, but then maybe the other icm42600 related commits are
incorrect? Guess it's a missing prequisite for that commit missing in
6.1.y.

Can confirm the failure as well in a test build for Debian.

Regards,
Salvatore

