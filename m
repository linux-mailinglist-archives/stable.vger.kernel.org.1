Return-Path: <stable+bounces-98868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 372309E6195
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30541884CE5
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B192815C0;
	Fri,  6 Dec 2024 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2I1aQnU"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C2819
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443459; cv=none; b=Nj320zl76eQrZEi6erV0SP+XEfCsCPm3YSurtPCLyvCz+ySxNdwRsGsf5+R5gVGos175humEK+Yi2JBXMezgFlHIf/PkSz115+V8jJoXmOVoVMz/es3ZJJ+8Z9fueUUe/xerlkUFhoCUwfjoXiavyjEvrxpq4vl7griLZDDP0RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443459; c=relaxed/simple;
	bh=cem6YOoyp7AZDcfsQKGmNgPJ/G6o5juYqAiM9Lb2GhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buCViCHKK4NiRRo5brKv0RxLGptnsaWD9nEuknM0VtxD0Q4XJvkLrcV5YPl+yULuF0eqF85wMrWlXMRGUCEl6DwZx8QR3m2p8Zf/ArG+QSFnx3mzGf+87zGjU0D5Vfu1Wgp6kbK8ytD47/tGL5ntvXtZxK15XTpO6ImnwqBtft8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t2I1aQnU; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53ded167ae3so1497390e87.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 16:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443455; x=1734048255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xwj/agv7HQLTwHjDmPbArm4lVXi5bkqm0hUb9PKPpxk=;
        b=t2I1aQnUI87eUU2ZCbyFKnkIWrCJ34k7BlxsgU8fOSRY1pE8mD3pmN1TW50zdPoP2m
         oEQFL2SF3iqwYUahqh4UxFCM51G/XRFWkcFHrOlkoaiIpS//x49/Q0+55Kb5PmwnYHIg
         cuEE+GvJYrTkP/NrXIlAkfaYWPw9SvQ4EcCDn3U82iqeAvSc7kZZWVEBD1B7oXjXMi5y
         +5znvAM2CBzwUJLEMijJa0hd7H86lMpoPKVFBDtAnLp3uTNuM3y1sdXamLfxnpmJS2Yk
         QvmjdQw60wncqthBlszvuPpoIDz0/lkcvkZi9eGEVQkDzT5bW6I/veqB5zkLAQaCQq8x
         6bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443455; x=1734048255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xwj/agv7HQLTwHjDmPbArm4lVXi5bkqm0hUb9PKPpxk=;
        b=D81eK6KsgdFWUF3Pz+2Ev/R9TDanN5T4YVXe2BFeFXhKhVXBBuji1DJAMb6Crx5c2d
         VWPMzKVR+GBTPIbZ58jfg1YycLMvEFRXga28Q+SHQ/FEkA5MsdW139KZbufT9wbLNszl
         D0S1ZpsZLGZxX405LubZTv6Sq1vHD8S0UgyrzZxnxR24kYmRmmwY0A5Vn9TuO7vQ7hNE
         q+Gj4V9Q8xwfg/5WAYafhvtl2upnii5C8pgHpN1dxsdPOUJAjDdcMCco4lyyQj7tDGwW
         T4hyIkIEFq9zWFDiwYiDBP1PnnfOGsLKhyIXjyt2cKWpLL5cSApkLTSsf9P6E2NXlb6R
         lmdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUBPoLde+uT/xOYMa4gGMSkPw1FOl1y/QXaVGv5Y+dMeK7IoCWgYKO8qhxw4OLWFEukWRc7FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwdckR11QRcr0GA9G8Wpb6uvx8hVisHWp1ZyxFXBfo35N0UPHH
	CRKXMR8eTun9ZZcA2RvdiSRnDm+eqySFCSWZ9I2V4EMuaK5gbxqfUzj/mn6+eNxiaeQlvm4lbaU
	M/zNKfszd3aJUbofg9KRgYvQGGnXf1er9tKUf
X-Gm-Gg: ASbGncvCL8FNWhVJBO8grsXzAk9NJQQkEdw+8Udv0XHIZBI5z6RkO+/r/UsoBzOroos
	QE5B89hl7EEFYgCfo/BKLZiTnIhwdEQ==
X-Google-Smtp-Source: AGHT+IGl2G+ZtrZsi0Il70DwFniDP6/Jpy6f/54NvatI53Q8jXo3yQ6cXcDsZ/Inpw7JimLVPKqN2Ay8N4V3sAFXdcc=
X-Received: by 2002:a05:6512:2316:b0:53e:1c46:e08d with SMTP id
 2adb3069b0e04-53e2c2b1a75mr166757e87.2.1733443455261; Thu, 05 Dec 2024
 16:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204222006.2249186-1-sashal@kernel.org> <20241204222006.2249186-2-sashal@kernel.org>
In-Reply-To: <20241204222006.2249186-2-sashal@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:03:38 -0800
Message-ID: <CAGETcx-a-+ktU8rzVwP_GN2pM8-_vaWd7OiqFJCwiNpyQMETpg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 2/3] phy: tegra: xusb: Set fwnode for xusb
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
> index 17211b31e1ed4..943dfff49592d 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -519,7 +519,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_por=
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

