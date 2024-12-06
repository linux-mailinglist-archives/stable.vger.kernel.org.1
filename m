Return-Path: <stable+bounces-98872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EBA9E61A3
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE635284464
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A666A819;
	Fri,  6 Dec 2024 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vnlldfJL"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFAC2F30
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443526; cv=none; b=iVSaqE0NdxIDwT5vWCuNF1uqKjiJZiGNFP2GNsrJ8kNMkkSY5Uw7avMZrH3HbOyOpBjKDZ1OkYeNeyYWVxbfv+L7Ek/55CdS3WYfbdwP4t9P+D9NuOTDrZ5VPCbhckJ8HA3XW/me0no6rNonUBr9AAy40+RBuMjz7Yv0k6iA3to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443526; c=relaxed/simple;
	bh=/6/GJCZORmmW5zwY2wzRU1IME7Ylq02ZiwRlWEjx+oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNY/Q3E4BCZQEZ4/2Ss1cKjGzxNQpq0XabASGCAheFJggHJ9ZzKZlMhAIf9Ox2ToCqHTcA5fAg+ivWQR3O2/W8ojmRupzKtBAPbNKx+dcebT/Ildk7yHuoB6PQJTxf2ilQQQXJUZU0TaODDh3yqm8QZU0S39TCYtyd+sUEBZ8lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vnlldfJL; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffa8df8850so16802881fa.3
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 16:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443522; x=1734048322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5RtrZRI/1Z/nEZqE6L75MMu2O/LqxV0qtQGfh6HrqA=;
        b=vnlldfJLNpMAzSunC/nn5xcxNyO7xgSd+dqRH23GhQKM/ZZKR52nrZ/ewsHUvXEK0G
         sy7h5LjCsBzfGxu8noWQ+Y99bOhmoxTrNjnm5JHkp4v3weMWDdt6h8nmMsUXWnF4QHRb
         qg3zr760Yha008EQUiWiv3TZS+1Wzb4Fb5KLvWIj/uRa7ovrf7B2H2iiBeG8KxvDtilg
         e3E2O8TZrCaLuD7ZJJf3bNV07zCEn/n71ULH7LYkS5SO6aAijRGIOlt6MikeiETdYgP+
         0wBIFcLYuQoBP3OkBsIZ9lVzxQrD7Klu6Rc/3n3Hq1IAujabkJZmCvndKPGlSoCATDxk
         uFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443522; x=1734048322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5RtrZRI/1Z/nEZqE6L75MMu2O/LqxV0qtQGfh6HrqA=;
        b=Xp6kd9QFmKSO+cLUWTphBFbQ7M072OpN5pBC/aMMgSyu2CKjcdVoVeNaRfv/45Jz3D
         4GbfmvTLrKnQlhJOh2BJn3C58kFCDkU4V64lEKLpubIvwbKVmHOuoL5ysenEFi42OQh5
         S8V/Ks2HD9I4dnPq4eIL2bNoKADTH6uZJ0hXfO2Ua0X54DLOjsQuJP/0C/wUQnRtW5zE
         OuM7omlBP8e69TYo76gC+chBYTVP92KI2O00sfw2LXqNPM4ep5u6BkhVOpDsx+SSWWT2
         XQMFtNEynyZZTGorCONjYltdgr2T/OmWiECR47lehovflq6ugc5XIZLrYnKn4dIlOI+5
         uPkg==
X-Forwarded-Encrypted: i=1; AJvYcCV2dtp8oCFSjUlu8mgMF1ahlegybuziIjQ+zwlfx+QsrgyRpswjvrB42ucR3Fuy/vC5fT7s6LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpPb060rVrupn8b1f4jGsOO6wr/2T7RDd6YioGRsNEhu/BM1uc
	nojOyYKJVJefCT4M0hBG7GJ4/toAEe89atNFA5ce0tjTt6SY9ao44ru4mx+4kqvw6trkoCFGsju
	DwI6BoIRxEgRaANN50EerWj8hHe4LjRVPwFJ2
X-Gm-Gg: ASbGnculFwT9p1WROCC/yx8ePbNFZfLdKRL5ecP88ic5rS6g0G98Pkhsn/FGKNh70xG
	m/5WBIJcypfFN7yN0WlZDeLVuFEfr1A==
X-Google-Smtp-Source: AGHT+IFWOhrrumLva06Fo2cZYMRAb2M405YCAEMmk5ILPh80o6m8HUDKsIjwa29hzHHjQIZ46RNwRiWk4LAYzA6au4A=
X-Received: by 2002:a05:6512:68e:b0:53e:1f14:f6be with SMTP id
 2adb3069b0e04-53e2c2e8a9cmr367734e87.38.1733443522467; Thu, 05 Dec 2024
 16:05:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221859.2248634-1-sashal@kernel.org> <20241204221859.2248634-5-sashal@kernel.org>
In-Reply-To: <20241204221859.2248634-5-sashal@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:04:44 -0800
Message-ID: <CAGETcx_tdhb80X0-sWSBTskY8dMsRr0oV08-=Z_j_yPocWf7cg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.1 5/8] phy: tegra: xusb: Set fwnode for xusb
 port devices
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jon Hunter <jonathanh@nvidia.com>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Thierry Reding <treding@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jckuo@nvidia.com, 
	vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com, 
	linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:30=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Saravana Kannan <saravanak@google.com>
>
> [ Upstream commit 74ffe43bad3af3e2a786ca017c205555ba87ebad ]
>
> fwnode needs to be set for a device for fw_devlink to be able to
> track/enforce its dependencies correctly. Without this, you'll see error
> messages like this when the supplier has probed and tries to make sure
> all its fwnode consumers are linked to it using device links:
>
> tegra-xusb-padctl 3520000.padctl: Failed to create device link (0x180) wi=
th 1-0008
>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/all/20240910130019.35081-1-jonathanh@nvid=
ia.com/
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Suggested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Link: https://lore.kernel.org/r/20241024061347.1771063-3-saravanak@google=
.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

As mentioned in the original cover letter:

PSA: Do not pull any of these patches into stable kernels. fw_devlink
had a lot of changes that landed in the last year. It's hard to ensure
cherry-picks have picked up all the dependencies correctly. If any of
these really need to get cherry-picked into stable kernels, cc me and
wait for my explicit Ack.

Is there a pressing need for this in 4.19?

-Saravana

> ---
>  drivers/phy/tegra/xusb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index dc22b1dd2c8ba..aa050aea2df58 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -537,7 +537,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_por=
t *port,
>
>         device_initialize(&port->dev);
>         port->dev.type =3D &tegra_xusb_port_type;
> -       port->dev.of_node =3D of_node_get(np);
> +       device_set_node(&port->dev, of_fwnode_handle(of_node_get(np)));
>         port->dev.parent =3D padctl->dev;
>
>         err =3D dev_set_name(&port->dev, "%s-%u", name, index);
> --
> 2.43.0
>

