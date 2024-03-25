Return-Path: <stable+bounces-32144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D2388A172
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 14:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22E61C36F54
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 13:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7640129E6A;
	Mon, 25 Mar 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vz9d9D50"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3CA18B5F7
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711354637; cv=none; b=ejr4NGCcFyL2ziDCYCKnE405u+aRlBb4wGS+bzc2GzfmPkRfdGhvst2P5/YwvS9LsQW8NKwFWw8FR5Ms/zFRWRoRwsRN5aLsq9nwjZUslGSbentAGYcbuXWzFBu3cWS7FyPleg/pUYlpOQkyqpdn7xf8Y6NfsCPgomNaOHV7QG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711354637; c=relaxed/simple;
	bh=Cdc2lgu11HCTc3NOvQt4Wx11RtkZGRvsRmErAIMTOtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BspLGAZ1Xpj0FU8MNef8TrGRXft7SwcqBapV/T73CwOOZx4A1qLduhn6O2lHlZKzk+kXf+OgWz7Y7cKciZkQcN935n3+ApybHDG5LhHwyeOg/BSbxmRVqTsgkKCMVwXAebeEjBySWYF9gmEo35MV/KOVG3gAYCEtiefhiTkYTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vz9d9D50; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7e03e591693so1463490241.1
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 01:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711354634; x=1711959434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ut2Z7NylC1ZjYh0t1gpTkNMYaB0PuQ5lzXOkX20arzk=;
        b=Vz9d9D509wJCjCcxF/b5OBrp4xTbEoTG3WTyVB32zgG2/i0AQPBnohnwSl7iN35geP
         CuoIPfk5XMKtw3xz3WwVdvusNrQtDzeGhGnWh4ps2/Azdw/wYwzHO/e8qO9sC16ciGbb
         BAmmldagosLTULCeEj06LCHyhVVVgZrLa+w298T6qyXCD2MVF4i3ocothKW1KpIM7MKu
         ZPaJNWkcchmR18ZzBQSJfGl4IXaqjxf2VY1xtx4Rh4QlX8baF13hoVziHesrEH+MHWBm
         tpW+qtxC35IwFIWw8qecthk75V5IWeh20tRBzEt64nvNmDKsLpkzHs/t/RNMCJL5B8aP
         mT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711354634; x=1711959434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ut2Z7NylC1ZjYh0t1gpTkNMYaB0PuQ5lzXOkX20arzk=;
        b=uWPAF0Z3ceqR2VczrqU06/tHYmlq21NMrOzmAhelSrpMaWXWgPLsuN4ffwLo3FVtFh
         xFTmxn5YnXigmNJ9dFB3Qlj249sH+n4j295ucXdc75BggHvFjJSaOXvWU7oTKVjqlloX
         ThWyIOdwqOvUSRrHus/PnN52OVDYfYhQ2zEpBy3UGfpiCe+M9gku287kECCvgSkcsuyH
         oeAbEtzKzXSpoe6SulhMfGZq/MssG5hepqQ7UhHmDp7EfYOQ0hlerxreTj43UZnOx9JW
         CFbJyQhdTuWxLg8tC8SHq1Rk8sxn3O5P+lfMSeUanyDxC+DCQJOYnluk2a20yf/Edypz
         j1VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYw2zYMWtj6rVPGlDU58Ddq9+LhQ1zDNlNccmqgPgNkxj7/owO/SwjPl17QLH6q3NyKcKQInNenFeilc0INd+0YCp5sPqB
X-Gm-Message-State: AOJu0YzCrcN5Y6W/DLLAWVONpkK4spdGyK0BJlJMroN2QqhU9pfcotdT
	+5UePkODI8dfEBIch5uDTBFPN0G3J3NmY+TcxUoR6/BAQcicu8jzuuyh/T0ebwJckHCKq09/5u3
	MycKeTpcbkbGH4DysLIMBNs6FUxKNLzXJNSwgKA==
X-Google-Smtp-Source: AGHT+IHY0fAqHGBuW15a+0qMrjktrDhlfxmxsDUXlC9QCdnmnXZsac9XicGScXZlK0/6xd6Eba/2rMRPS4c5hleF/5Y=
X-Received: by 2002:a05:6102:34ec:b0:476:de63:c6de with SMTP id
 bi12-20020a05610234ec00b00476de63c6demr4404256vsb.24.1711354634277; Mon, 25
 Mar 2024 01:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324234027.1354210-1-sashal@kernel.org>
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Mar 2024 13:47:02 +0530
Message-ID: <CA+G9fYu33d-SfUuHcyxJQZdPXARYjBVUaqbTBc+5k9HZYFjUqg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/238] 5.10.214-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de, 
	=?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Mar 2024 at 05:10, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 5.10.214 release.
> There are 238 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Mar 26 11:40:23 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-5.10.y&id2=3Dv5.10.213
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

We're seeing regressions while building PowerPC with GCC 8 and 12 with
 ppc6xx_defconfig.

> Thomas Zimmermann (1):
>   arch/powerpc: Remove <linux/fb.h> from backlight code

-----8<-----
   /builds/linux/drivers/macintosh/via-pmu-backlight.c:22:20: error:
'FB_BACKLIGHT_LEVELS' undeclared here (not in a function)
      22 | static u8 bl_curve[FB_BACKLIGHT_LEVELS];
         |                    ^~~~~~~~~~~~~~~~~~~
   In file included from /builds/linux/include/linux/kernel.h:15,
                    from /builds/linux/include/asm-generic/bug.h:20,
                    from /builds/linux/arch/powerpc/include/asm/bug.h:109,
                    from /builds/linux/include/linux/bug.h:5,
                    from /builds/linux/include/linux/thread_info.h:12,
                    from /builds/linux/arch/powerpc/include/asm/ptrace.h:26=
4,
                    from /builds/linux/drivers/macintosh/via-pmu-backlight.=
c:11:
----->8-----

Bisection points to:

   commit ee550f669e91c4cb0c884f38aa915497bc201585
   Author: Thomas Zimmermann <tzimmermann@suse.de>
   Date:   Wed Mar 6 13:28:20 2024 +0100
       arch/powerpc: Remove <linux/fb.h> from backlight code


Reverting that commit made the build pass again.

Reproducer:

   tuxmake --runtime podman --target-arch powerpc --toolchain gcc-12
--kconfig ppc6xx_defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

