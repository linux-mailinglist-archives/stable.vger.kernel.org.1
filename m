Return-Path: <stable+bounces-98870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C489E619F
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0092842FF
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2B32F32;
	Fri,  6 Dec 2024 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1cSwBwwf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7AD4689
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443488; cv=none; b=GJiPGWQ3DL0rpoRAS+20nQUGgwB8tnwoeBhYxeoc+LvPUkgwj9IPHADhLDMaFRkEjKpBCKGk8akZOIadqMXCFzzkhWMwiKfDTVSxRPKftRPPejDjKOuqAiAl6zcfkxBYMl6O+lqdIn09B27RS9ARKUNMLjnP4+VELrzQnOSUEaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443488; c=relaxed/simple;
	bh=Tvn36FuiWfVJJKwvwkybfuYf/nBnm7Srci3co3kdlRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=im7Jsn+r1QOP/zmk7z5o1uAhqlVH1RizdRuHJrucOIs1DudF+B6IuGvc3xONuJDGf2UXPywBCAarGLLhw2B2/3Htc1KwmgcTRdd+rdVfxLDL/8LZ1YiaHcx7ZNsu65FG06303DADLIDo5T827aMzdz02yYh5tMurl4a5oE+KqOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1cSwBwwf; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffc80318c9so12653661fa.2
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 16:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443484; x=1734048284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyJdJJn57+pQZInRZeuVGIN7AV1JUnt9vsohwzqk0TU=;
        b=1cSwBwwfDG9quBHgMgzP21wnDWBK1FLvv5bdnSl7FrYQbp6/gOnltSJXhqnIUD0EoE
         YjdOIWPTf3SrP2/Q/dt0jVDjhytTYx/C2tcRFN8Wm6io1IAY/yWUYi8CkogPVPv2LmKB
         7rR4V/1+75r6fspiHB4erZ3/P772sl1K0m7fsTmS2G1QCor8pCAjchodGFfDBEM/okY4
         q9/8D5mncDyNaz04LG0T44t37HUvTH0uvXH65XXbc/e18uwh//0Cp82boZG+D7SScSbK
         iJL2HtONV8WJd5Oc9bVe+LW2/7dA6foZXdjgQKtUx7kco5nFDOu75Ty1XG6CdUhW0BGZ
         lkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443484; x=1734048284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyJdJJn57+pQZInRZeuVGIN7AV1JUnt9vsohwzqk0TU=;
        b=Xyp7p2b3/rcrbtJslNwb5iYTlpoGfa/ZuOzqqk/hXMOrIyCWiaMwHdHEg7OHnPGYJE
         PVIH4D/bSmk4eR50cNQFR+2E/faEKOd5eYvFw+1XcQGdw9BzYdtnYLYUbZHlyssW+sqK
         lrtQ+29cY5LILppFC5041nhMUtPvZGWWqv4RGh7uRzwmFkhtzHx5jSzdYVM3JWEbdiyT
         IjT6kh7IqqX8SMVkC7v5EnWGYcjPSlyojbQXLOrU45ddXwyJwGPWzYQMSvAe6+/uCOir
         oFY2H6rEymvSRq7RHCZuIddpLd/Xrgy4cBoPItof2lvFoPUx265pyjNOL5A+4IUBS6CQ
         gdoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsgVRUv9KYXTB6YOZUEvjqzmjqD8mg8JgKqCnKQtvlQTatr/adXGjbDgqNC9VlSOrlUKYBMgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfyebugAmzRauZoNSi4unBgpdoENHrhKHaMNguynC9ADXfcLXo
	CLF0SUm8L7GS0m3VS29CQIR2lEfCMlBjGKn4I1wRImAPmaxjnNQmtDaUpH5Sa22NZGD9NtJ91bF
	mInL+81N2G1tND7/5xYQV+LHnYDBftR9pKgtg
X-Gm-Gg: ASbGncuDui5JsS7JPixa2KTJlhKbCn2iCMIilTcD4TbeqIbrf/cz+aKw+hr67G0TOXs
	2WX2HvdW1h8MEZjcMUIm1DwN8syLvaQ==
X-Google-Smtp-Source: AGHT+IE92QurkCXbpPhW39S0T6DV3d1ZwkHiDAPalNEAhWDdnG9gboTXRwPqobgb8OqDtVbK6JdEhdq9iaiE115Ad5o=
X-Received: by 2002:a05:651c:1a0c:b0:300:1947:a28c with SMTP id
 38308e7fff4ca-3002fcec223mr1919581fa.26.1733443484316; Thu, 05 Dec 2024
 16:04:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221942.2248973-1-sashal@kernel.org> <20241204221942.2248973-3-sashal@kernel.org>
In-Reply-To: <20241204221942.2248973-3-sashal@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:04:06 -0800
Message-ID: <CAGETcx8vU60Rypu1TfGfKSNUuoikGMQYydqEYDQNsNPfoKt9fA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.10 3/5] phy: tegra: xusb: Set fwnode for xusb
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

On Wed, Dec 4, 2024 at 3:31=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
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
> index 856397def89ac..133f504dfe9a7 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -531,7 +531,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_por=
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

