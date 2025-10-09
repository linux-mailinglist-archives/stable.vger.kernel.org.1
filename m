Return-Path: <stable+bounces-183698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2758ABC90C6
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 14:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65F53BFA1C
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 12:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EFB2C028D;
	Thu,  9 Oct 2025 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="i6hbnu2x"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162D523026B
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013351; cv=none; b=OsctsP7MKte4RmAlj9TAZoq1dDiIqAmuDt8bQCbOM32JU5HwJTZ02h5BXUbS4fKsqAKtKEXX6oYS2g0WRRx+WNZzyytrt7+5PslaKi3cPhFIwlQdWqAYoZ7NeVwgERQIudismHylmBFkvXhcI6Qr2ETfaFIg3i36Y5deToF+el8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013351; c=relaxed/simple;
	bh=vhMQd+EZ4/txkslrHVtTYwD2HG3HGPpvY+kXfq9n5zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwXRYHsbBheM4SmcLvX+Pa0tfdBYun4vfROnPfPdH7qslbrp+iwA1h21g4kXNHXVclhjzZbYbShE3wUFMMqRpm5OfiTGUjiBV5cDCXROJyOK/1dneAxTv87EYD4UzfEAO73SclZERrn4OBJFbGsrHCEkyNPQEEdAY7KESSnhAmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=i6hbnu2x; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so1806541a12.1
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 05:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1760013347; x=1760618147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebBEdrCJebc4ipLX16ljAVsp9eLsN990mimbLC625EA=;
        b=i6hbnu2xO53WERKeeSEaecuPoB3aCegP7Rsonyj9Bc2RB0TRacYBfcwwkGe/U9sTP+
         9CIrXnkF1rUbMUPJTR1ZCQODS5Z0zy82UE2w5aGpJlX0FkMb6lz81R6Jq+kbZu1txJA5
         P1qnuHtZrd0IiMY2Fzhugd+gXBxTiEDLkOlP6UW1G2t87fmzGlAqYZPUlb998u5O6yqJ
         c7+LU6eqheTQdmY0UJEJzuOy1/ChBCMIKl8ZwFsaKblVsWcZyceT5Ph5mhDfEMWJf1HE
         m9qBuTFF5DDC+8Rg5sgxWTM90FHV+aYxfCq6HFRz+A/UyB+meBJjgQFX77/0LmuVxt7Z
         3lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760013347; x=1760618147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebBEdrCJebc4ipLX16ljAVsp9eLsN990mimbLC625EA=;
        b=DBVXUKyODQDyyIv3Dy9RpcAQs3BMz3O4D/HGm1/Spe4RM1lT/UfX5pJZj2PqOs46Yy
         frcCxrquMpL97grbtjpO/VxbsXcbEAJCjRdismbha76DAqivs8ermHou2sUwE4YDu2D5
         yUlCgxxRacJXvBCH47Ri/PvoEf+q9RndK5I8759KYaZONYsiYSBYwLvsIvLSP1zdScUX
         bjWaOhPCkzFFyQ9UZaVIpRaYhGnypyAEWzfpTsov+cNOhcnAQATIX1ZLdaLT7GCy2zeD
         yVctqH3W7B8adiJb8aO4nJzjn8rnS8Ir8WusBC/hmdbbBXdgmEsBaD7UI/xUMUCQOyrd
         1BWg==
X-Gm-Message-State: AOJu0YxC6Khcwsw1ojo5Aq6atG4ZKT9ANNqOt7NLLFMR5bsLzEjHYiD+
	vxoVM7KPx89jIg0PufTn593TA7AJyRa6P3yBlpfSnqVLSq9hyZY1lO0FPJGrw10btq7GOC541V2
	XosPaulxn8CoZTgL1+mXlrouLe015XrsgWZnQL10mb4/yaPulO8VR
X-Gm-Gg: ASbGncsTp5rVQnSqk/niswTfxE3Xmwn+iRmHx3u7Q0lezCXs5/kr/xe8b3axMYHvWq+
	aOU9sbhqnslR9YfbY+72lDwa2l0OjKsEOfG0v57rksLsQk8gg0nODLTQlq3ydf9HHWkRUUQ9pTK
	ijMYQ7NiJzlJdsaGAf5cJiUJabQLVnPOW9epUuMkFChQ5k5JrHvCknkidaJDQf3gkhu0CzxLMMD
	3xFlDDtFgjkLU5Eiz1ylWHwrPPn9d54xIc=
X-Google-Smtp-Source: AGHT+IF4AbTcVLatnGLtQIBgW+s0RPzOqnw8lqVQD8oEoLZM7FAxxSbFJ1PlSUGDNxMrwzjVvMFDt5bi6tE1K3EvX6U=
X-Received: by 2002:a05:6402:1ecd:b0:63a:38e:1ddb with SMTP id
 4fb4d7f45d1cf-63a038e4c9amr1139644a12.4.1760013347247; Thu, 09 Oct 2025
 05:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512015227.3326695-1-jianqi.ren.cn@windriver.com> <20250512163207-282f1e7f1aec7163@stable.kernel.org>
In-Reply-To: <20250512163207-282f1e7f1aec7163@stable.kernel.org>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Thu, 9 Oct 2025 21:35:21 +0900
X-Gm-Features: AS18NWD_kAW4M16LYNzyPwZK-cDFQwq-ktX1C_9aM5GNMETmsnRGeRPeaad-89E
Message-ID: <CABMQnV+mjLbn62AXSp4QPG1rBY+4vTq-yFKJM+rT=YKwVwxVsw@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] spi: microchip-core: ensure TX and RX FIFOs are
 empty at start of a transfer
To: Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, jianqi.ren.cn@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HIiall,

Why isn't this patch being applied?
If you have forgotten, could you please apply this?

Best regards,
  Nobuhiro

2025=E5=B9=B45=E6=9C=8813=E6=97=A5(=E7=81=AB) 6:52 Sasha Levin <sashal@kern=
el.org>:
>
> [ Sasha's backport helper bot ]
>
> Hi,
>
> =E2=9C=85 All tests passed successfully. No issues detected.
> No action required from the submitter.
>
> The upstream commit SHA1 provided is correct: 9cf71eb0faef4bff01df4264841=
b8465382d7927
>
> WARNING: Author mismatch between patch and upstream commit:
> Backport author: <jianqi.ren.cn@windriver.com>
> Commit author: Steve Wilkins<steve.wilkins@raymarine.com>
>
> Status in newer kernel trees:
> 6.14.y | Present (exact SHA1)
> 6.12.y | Present (exact SHA1)
> 6.6.y | Present (different SHA1: 3feda3677e8b)
>
> Note: The patch differs from the upstream commit:
> ---
> 1:  9cf71eb0faef4 ! 1:  e2b7a4dc57e1d spi: microchip-core: ensure TX and =
RX FIFOs are empty at start of a transfer
>     @@ Metadata
>       ## Commit message ##
>          spi: microchip-core: ensure TX and RX FIFOs are empty at start o=
f a transfer
>
>     +    [ Upstream commit 9cf71eb0faef4bff01df4264841b8465382d7927 ]
>     +
>          While transmitting with rx_len =3D=3D 0, the RX FIFO is not goin=
g to be
>          emptied in the interrupt handler. A subsequent transfer could th=
en
>          read crap from the previous transfer out of the RX FIFO into the
>     @@ Commit message
>          Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>          Link: https://patch.msgid.link/20240715-flammable-provoke-459226=
d08e70@wendy
>          Signed-off-by: Mark Brown <broonie@kernel.org>
>     +    [Minor conflict resolved due to code context change.]
>     +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
>     +    Signed-off-by: He Zhe <zhe.he@windriver.com>
>
>       ## drivers/spi/spi-microchip-core.c ##
>      @@
>     @@ drivers/spi/spi-microchip-core.c: static int mchp_corespi_transfer=
_one(struct sp
>
>      +  mchp_corespi_write(spi, REG_COMMAND, COMMAND_RXFIFORST | COMMAND_=
TXFIFORST);
>      +
>     -   mchp_corespi_write(spi, REG_SLAVE_SELECT, spi->pending_slave_sele=
ct);
>     -
>         while (spi->tx_len)
>     +           mchp_corespi_write_fifo(spi);
>     +
> ---
>
> Results of testing on various branches:
>
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.1.y        |  Success    |  Success   |
>


--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org / kernel.org}
   GPG ID: 32247FBB40AD1FA6

