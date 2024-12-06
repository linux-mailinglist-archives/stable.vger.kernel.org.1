Return-Path: <stable+bounces-98871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8689E61A1
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2186416847E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5212B634;
	Fri,  6 Dec 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FR8GrlTK"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78733E7
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443509; cv=none; b=AlIcGVmBGjbklPyKrxl3qwYgvj2XWVf7iDMvOvF60Pxl2STPeV+Vsma+4Qhk9uaJqj0Xxmj9vi30h3dkuP0oCX8x6NeukqneQi8BekH3m/xyZ6zVYoqC3pBd+n5DtPNm50znD9AoUPnmmdDClsz8Lk9DGhX3vp4JWRP3dqyBZoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443509; c=relaxed/simple;
	bh=BwcwkBmpq9qoP9KdrIaMsk9b+cc/VqljtaRzLZNq7Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwV7VWZjMsq7Vs37ErK3CQ8WK5cy0wWIVF2q9m47bMBDGjSJYxa384xESCQth+hWVKDoRnLDkcdDuKKEXbuINN7MmrdwXHMtEBdLS4qR4D//voQ0V1JCPOgFL3b6I5Z/fPXhcyByNh4EraPsidcyGCCJBmYbY53d2HsDz3so1yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FR8GrlTK; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53de79c2be4so1624234e87.2
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 16:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443506; x=1734048306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mffP7SIqpVqHwqmdEnMFI8Mhd4D6LAYDdX9afu8rwI=;
        b=FR8GrlTKu6Ridt8xIB0szGVtwvS5bYx1wG48fVYFMsI5R28opspFztAyyOkq6rM0Au
         2acEnLqbuT+SIbK15earmzPoShhHOSw3/bM+hWS2a1/zs6js430MM/On5ebsVpwSRozP
         +PU3uOpjK4BWfcMvI1daLUktuGLpgAvLFCh6xDOko/wQFom4bvFUAzKJCPF+Vtt+RErm
         QCkOp8h6mBmPGBfZIDSjcRpIjX1AvZqNiQrULo9GQlb+/HrwtUy1WyrpOcwmWoWlKVRJ
         HhONafIuMLkLcAHitTAhwzA+E03ZB+O17jYI98NPbgMrQ6BRHmFeIGTdYmHYTRpy9Oo1
         02Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443506; x=1734048306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mffP7SIqpVqHwqmdEnMFI8Mhd4D6LAYDdX9afu8rwI=;
        b=fcEFWfLWGszrj6+7yxszo9h6c/dwVxNsIPXhNASaMSO8ueLdznQh4yrdzS90miSV33
         XUjC/uboHUjkGVsAwyK7McUnWsxjBj4jDZSSQL7FSAECXlrPu5+Jy1bLRXpqjNzKxUxh
         Gv4GYCZNO7er4IBd1fB+yNQaDI67nuPh+RwFB22ODPnsIt7RaHmG1cVqpm4bi+mhwioC
         DQxyqVTnig6350bTuVWMIQOkF/BsK3sj7U2KwTjG0t4mbBC6xyw9LetygWxGOMg8winz
         QetWsbmA2P5iCBTnE88oVD1oRXno0GJGPdj4EaaZHqVGtAhNuJ0vU30G0h+9C+CZi0JO
         Ysww==
X-Forwarded-Encrypted: i=1; AJvYcCVHQd/D0ofX1B7ryyk1w5dahREoZ6L6ydJzIjQMh7q0CjW7lDkV10t6OEIpMTlHw+1J0D0YLlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynVQuhyYZm4SK9Gp6edLDABLaC2z43Pu/BU5g21Y5K+AfAF7xs
	sbwBcKD2hW1DdohJs+koUCoaF9IGr+J9pj7mYsWprsZYjb2uEvJiRyRD45OwgKkjoEZImzyKoDM
	ODxcciyHC5MYPY+emj+UsNfnfAgSoivmAodu3
X-Gm-Gg: ASbGnct9u6GPtDLDA8ehdxMaGDZlUS0H5hv9goLiEdJhNZHFzKX0vLbE7uT+wGOiACZ
	u/9JYMVmsoEv1n4CIYT6vF4tBIeLFWw==
X-Google-Smtp-Source: AGHT+IEphwAKG+akjlfTDJM0cFC6ySOTXKmmpvLObu98Xq16kqT8AeY48zqrBxP7D7gn8VnXD7qHI6i/RHkPxXyECew=
X-Received: by 2002:a05:6512:1cb:b0:53e:3103:b967 with SMTP id
 2adb3069b0e04-53e3103ba29mr28490e87.35.1733443505497; Thu, 05 Dec 2024
 16:05:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221925.2248843-1-sashal@kernel.org> <20241204221925.2248843-3-sashal@kernel.org>
In-Reply-To: <20241204221925.2248843-3-sashal@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:04:29 -0800
Message-ID: <CAGETcx82VRmbU-UJ3iQxipCWncJPB_N9rO702K5AoVitpLNo9g@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.15 3/5] phy: tegra: xusb: Set fwnode for xusb
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
> index bf7706bf101a6..9a204f78f55db 100644
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

