Return-Path: <stable+bounces-151618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B308AD02DE
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 15:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2107C3AED92
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 13:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49606288C81;
	Fri,  6 Jun 2025 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfhTfHcc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2EC20330;
	Fri,  6 Jun 2025 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749215528; cv=none; b=IrEtsJCvJsUCE+37AGmdYeByXHGLs3aF+PVi5JEwd1gs5YErcOcthuoe+rsGhFsS42JE8V+HDhy0TACkev47yU0PCVthngDUIbSuCrTmLvoyTzrzeBTyGOuKDN9vr5V0tcC+P1MHBbW7+LHkwtmt+072Ser60HdHXOwWDjWHan4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749215528; c=relaxed/simple;
	bh=rGZRqJph/AYEM9AzQLAgB41QMOJBZx9aYxw1lu4xNAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elIe0JzzHeuz4cJLz0Xeh3IzcUtvt3NTr1HrWjcQ/WYrNqM1ttnz81Swhi1OOUm1epN5fwSoTX9A1w0Qb3UczXJKY8fnyuvBN2ngzq/QZj9uWGXRhAZaMvVp2G4PYxDLUT/S8b9GH8diBwTeUfcmpz66jWYQe4J9TNSLmlhSE+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfhTfHcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95875C4AF0C;
	Fri,  6 Jun 2025 13:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749215527;
	bh=rGZRqJph/AYEM9AzQLAgB41QMOJBZx9aYxw1lu4xNAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cfhTfHcctqgAwVeOqIbGC/R/W/7BnjHIglya57cJl2vhkPKiPzj/EFm8DZt678gm8
	 7TQhclnrpXmWkM9DR7ahAcoxB1TteyGiT3dObYylKMZsLpOd54fMFeiTEvPvcoFfCJ
	 LleorvyPfpPt/wonuhD7+A2hz4+7qZzkc/p7Qe0Sp9FWLRDxtBk+ZlISxE2TrOHBQj
	 HfYcdCXSJEjLHWOrvlJjZPm+pHN7RFb6o8onIcjckbpX4aTes012TmjKAJuUDYBvje
	 51FQZz6Uax8RqzgGVLjQnUKHpwApXXrZEbvoKVwhzJgR1UgJaddxjvKMDNyXQfvBH6
	 puwgeeBmQ4tvQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ade326e366dso38909466b.3;
        Fri, 06 Jun 2025 06:12:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFEcs3OekLEsXKqSTgS0NDtAsoWkQj232ZO6KQb5RMxtwihrz4bemB/MEaEJN8SX9kaFgX7hYWsZPXLZk=@vger.kernel.org, AJvYcCXUvow9hxW/QSdAWZvj55hLnQ1z4xrWdHVNf7PCL/hWyqISKS9qTZPXMvJJXdzMoCi3iaKfx6r1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi17A0m6MHCN53rsMRs18e7fRU9/cokcAEEhkmrMzVrSYu7A3C
	/pwii9R97OPNQcy26gaKPnaDg8zVaMrEA9SYffaen8njnqgkH5dDMJUR5qWxquOCfgpvZnjA3yg
	r+LeFByE1mi0Hpde/Hh/0wLWbDyFXmUU=
X-Google-Smtp-Source: AGHT+IE3pzzutoVEt+xG7WoH2SCggVL9nueRxZ/i2LyieJigkTr1b5rrWQyRf4BgAOIe/icLjS3SlRApkbSvZUQGZz0=
X-Received: by 2002:a17:907:7f9f:b0:ad8:99cc:774c with SMTP id
 a640c23a62f3a-ade1aa4743fmr302174766b.58.1749215526167; Fri, 06 Jun 2025
 06:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605055546.15264-1-ziyao@disroot.org>
In-Reply-To: <20250605055546.15264-1-ziyao@disroot.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 6 Jun 2025 21:11:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5B22f3bJ38F16vs208pZA80oQBrqrhaGTQqeU7xkrXNA@mail.gmail.com>
X-Gm-Features: AX0GCFuSfHSPLUWXT3X6Z-gVUN1k3vC627BbcSHCLmYtH_uyRJoe269rQgrWQqQ
Message-ID: <CAAhV-H5B22f3bJ38F16vs208pZA80oQBrqrhaGTQqeU7xkrXNA@mail.gmail.com>
Subject: Re: [PATCH] platform/loongarch: laptop: Unregister
 generic_sub_drivers on exit
To: Yao Zi <ziyao@disroot.org>
Cc: Jianmin Lv <lvjianmin@loongson.cn>, WANG Xuerui <kernel@xen0n.name>, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Thu, Jun 5, 2025 at 1:56=E2=80=AFPM Yao Zi <ziyao@disroot.org> wrote:
>
> Without correct unregisteration, ACPI notify handlers and the platform
> driver installed by generic_subdriver_init will become dangling
> references after removing loongson_laptop module, triggering various
> kernel faults when a hotkey is sent or at kernel shutdown.
>
> Cc: stable@vger.kernel.org
> Fixes: 6246ed09111f ("LoongArch: Add ACPI-based generic laptop driver")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/platform/loongarch/loongson-laptop.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platf=
orm/loongarch/loongson-laptop.c
> index 99203584949d..cfe2cf79dbbe 100644
> --- a/drivers/platform/loongarch/loongson-laptop.c
> +++ b/drivers/platform/loongarch/loongson-laptop.c
> @@ -611,11 +611,17 @@ static int __init generic_acpi_laptop_init(void)
>
>  static void __exit generic_acpi_laptop_exit(void)
>  {
> +       int i;
> +
>         if (generic_inputdev) {
> -               if (input_device_registered)
> +               if (input_device_registered) {
>                         input_unregister_device(generic_inputdev);
> -               else
> +
> +                       for (i =3D 0; i < ARRAY_SIZE(generic_sub_drivers)=
; i++)
> +                               generic_subdriver_exit(&generic_sub_drive=
rs[i]);
> +               } else {
>                         input_free_device(generic_inputdev);
> +               }
>         }
>  }
>
> --
> 2.49.0
>

