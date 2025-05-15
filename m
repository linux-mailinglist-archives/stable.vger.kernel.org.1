Return-Path: <stable+bounces-144525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF84AB8672
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 14:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB0E3B3D9B
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 12:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621F12980B7;
	Thu, 15 May 2025 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYUrfDvw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94761BC07B;
	Thu, 15 May 2025 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312483; cv=none; b=VkDY9aNQILLaQjUqXRx2+hexKg9MQQTSma40Bht1cVQ9eXsvr17yPJTQGmSd0bnHmU4c8vXT8cjsn7ZH+riOjfmCul+rjxYlH+0D3g8SIea2rC1pJgtxL7xZ9YhMYsSD80K5vXNUTtzBEEUbS/yf0mZeEhTqOu8Eu4DbOcPZJ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312483; c=relaxed/simple;
	bh=TuMvFeK/rCaVdJKjJAwerHfl5Z00/hhg+xzHSyAPKjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMNiEpVv75of1SMM/qfG4r/2YgrN5FDv7qytnsE9WQ5pHID8azEwPQSkL5q34R8cO72msCQJ48am7Xsctnq9CoYAFZaXyLRpsvJY4nniv+nVdszBrDmJGEmd2bfFyUSvoDFdMKybUeCI/7EdJZhhX6zWmG5fl/8QPx5EWsjuMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYUrfDvw; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso807669b3a.2;
        Thu, 15 May 2025 05:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747312481; x=1747917281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8g14WITKUispC4svi3eKXIDjFz402ZwoIsie5uvpbTs=;
        b=KYUrfDvwWCiwuK2VeELXBi5M0rRf1V5cxAj05IW9mbxX7Ue1u3zgmbuzwXt7uaOhy8
         0c0VFgzMCB8BXTNTXU/vS0dAvxcaHEgRn4mxqsYbZoKJdpQ2zK5Iu3mkWnBaBNH0Sg1u
         nUZNHnLHBznvqIQpnPjQlpesbhjyNzWdqJf0why62wp3gnofGRINyuVjCi5xWhC6Y6UT
         OuxD0wYwm7QzE0xb/eH2lR02HdW4xVunRtOO0u58nDqwAr2F7SLxjtgPtAIl72qg6J+a
         VnG1B267O2ybZLd1lVxVyeaZ79WYuwXXSlvTdKZ55m0lAnQPpwCzutk74/XmyGXGIsfz
         iNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747312481; x=1747917281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8g14WITKUispC4svi3eKXIDjFz402ZwoIsie5uvpbTs=;
        b=PcwPy5Bycsh3rfHCltXbwEnvGj5+V7GjlaYfGfE0MZeXVgsV5ZPOhKszz+ZIaUYoJ4
         JIplqq5HOqHMs/PKuQNxO/ug4jGhmrLNeLRfQQwJdZBRjWb7//vPSfof2KaeIf1O5FaO
         xu98HRTBKLIFD1zHuGUxmD7iyw8uv00SFd6/Yxzjh29qD1RulaC/B4IPy5C80SB0tT99
         CSyjybjtRRDhBb57H/KGr1p0iileJYHb/gZ0bY6hBrftOKPuV0zXWeRKAwlXi1Yb4NbY
         w/BXQrJmW7S0yIOGITMf8ptr7NOjqfNDUlsimmlBh2nauSRHFFgv215n1RtBNgoBcGwV
         mE5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP5W+G6ZCubW7B+v28lX2LTni/2UX9asrXtuSFoUT5C8BiunEc4b0IYXy74oOKMbk8PFaxj7EJ@vger.kernel.org, AJvYcCWH9TRq9q1iY2BtFcb7ZIaU/5b6ARO0YPoXqROJeUHjeGXwor8zaEI4pYHX1HROuJHLW1eaeVJYeHKBuec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzydZl2GYh7sfqO1876NmBTWZVt2uLTO98wkgVRYujQgPRkh5wh
	NeutpP51YGlmzDrYu7rOjev/dpSwQmhFuH/oNAE3Awsjj1iEw9AGaJc7J4lAX0trr2ealPC60S/
	YTjOvFyahAi9rgzQgAaMRV00ES7M=
X-Gm-Gg: ASbGncvh8p/o2ch1c9S4R9FgOWA9tuSLsvbHV2WLaaWZoP/jBUvvCb/flAL3C5BgoF8
	tWwvIrW6Iqc/n8348LO4ZE03dBbc3YDoRLuF7ML82/Kaf2X3wOQCYhhAIV5v+vugkKKIAZGwJf9
	ulOaT8heiaUFnFKJdMbE7K3aqsWBc4Pu8TNYzpIa1cr+Qq7hYmaW+g0o2q0Q==
X-Google-Smtp-Source: AGHT+IHXGOzKeRRJE9zCbbAu4uWsVkFOc5cXh630pg+5rvqSiHBSlbECsaOkM/ZnkgB8uWM5JjirYQ87jqOKcJCGzEM=
X-Received: by 2002:a17:903:191:b0:215:b473:1dc9 with SMTP id
 d9443c01a7336-231b601e84fmr31085845ad.46.1747312480861; Thu, 15 May 2025
 05:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512172044.326436266@linuxfoundation.org> <32c592ea-0afd-4753-a81d-73021b8e193c@heusel.eu>
In-Reply-To: <32c592ea-0afd-4753-a81d-73021b8e193c@heusel.eu>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 15 May 2025 14:34:27 +0200
X-Gm-Features: AX0GCFuQNAmSsVkTFc4Edf3mppYs7UrTKvOfYgP_G21yvSE2cDUBtmgakrnqAXw
Message-ID: <CADo9pHgq2jzeVO4PFW6ObBj2bT9FSWcJUC5fRA9kVjMVah0J0g@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc1 review
To: Christian Heusel <christian@heusel.eu>, Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Ray Wu <ray.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Same problem in rc2 just tested

Den tis 13 maj 2025 kl 07:26 skrev Christian Heusel <christian@heusel.eu>:
>
> On 25/05/12 07:37PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.14.7 release.
> > There are 197 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> > Anything received after that time might be too late.
>
> Hello everyone,
>
> I have noticed that the following commit produces a whole bunch of lines
> in my journal, which looks like an error for me:
>
> > Wayne Lin <Wayne.Lin@amd.com>
> >     drm/amd/display: Fix wrong handling for AUX_DEFER case
>
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX reply command not ACK: 0x0=
1.
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX partially written
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX reply command not ACK: 0x0=
1.
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX partially written
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX reply command not ACK: 0x0=
1.
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX partially written
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX reply command not ACK: 0x0=
1.
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX partially written
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX reply command not ACK: 0x0=
1.
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX partially written
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX reply command not ACK: 0x0=
1.
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX partially written
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX reply command not ACK: 0x0=
1.
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX partially written
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX reply command not ACK: 0x0=
1.
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX partially written
>
> this does not seem to be serious, i.e. the system otherwise works as
> intended but it's still noteworthy. Is there a dependency commit missing
> maybe? From the code it looks like it was meant to be this way =F0=9F=A4=
=94
>
> You can find a full journal here, with the logspammed parts in
> highlight:
> https://gist.github.com/christian-heusel/e8418bbdca097871489a31d79ed166d6=
#file-dmesg-log-L854-L981
>
> Cheers,
> Chris

