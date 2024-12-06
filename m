Return-Path: <stable+bounces-98874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E20A79E61A9
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7563718850B2
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB411FDD;
	Fri,  6 Dec 2024 00:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICuYsex3"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B56781E
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443550; cv=none; b=CltqkYma1du4wbwmWjXZlcZufiTxqJ2Daqmb1qXyifYi8V23f5KZZD7SYLQEJ2xuZN1zAGS/4bJEJhCLB04ghPaqCoLG4kEvBc8nR4zd2HnNkzMmubV96f1z0/c233/Dwir/fsTu0e/qKKD1mJahi6+gF/aUipuD7cij7YVXR4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443550; c=relaxed/simple;
	bh=IZa1TwuZ0fRCXZHnUNYF7MN2+UwYZmw9P75FhGdbfJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtqssTdDR0INeUuuL5qchwaTBHx7lhx0hxOwXMeD/MwgcKwWmqjWM/XsaywM6TAwMgYLTBgAt2F0Q9AZoF9Og8DZl/zBowQ7PAZkUKANJENNhdAR6eDCfY1VmCg7G1pb3sJls8tSWMo6tACZUPWCI/HpBXFMFJ8iQ5MMBrn249s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ICuYsex3; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffc357ea33so13696181fa.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 16:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733443546; x=1734048346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3/q1ekefyKSw21VhHKqxx/fV6+Xb8BjKlvjw8MK6pw=;
        b=ICuYsex3FatpBJPBHT3r8Vz018vxszEEKhEGY+aQ/pk2Aw9QQGyI/DbycsW63s5Bgj
         llJLCzUu+QHb6aqgHTkg1J2qGzmeq+SvtFE6xLhQA7xclKZSHumkxXjE5MltFIpv/mzv
         YpKKkXAxWGrv0KoK6U+nAs3nbGppCkjVJEpCcjeKSr6Nf4lo7Z+5Sjf+TSnc5Ogbors9
         iTDGxqzkfGi+bFlr3M1KLnOKbfyARSHZ/F0xL4pZ10vJPiLUZrD29UoZhCcotOJ1ukK8
         shUcNgd4edZ1DHCdHwnUs/1gd4JbB8Rf+dAnGX3R9yj1Zn7MdsXfENYti8nTQso569iR
         z4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443546; x=1734048346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3/q1ekefyKSw21VhHKqxx/fV6+Xb8BjKlvjw8MK6pw=;
        b=UG9kczoVmLBCjBn04d+KHhEbZkRWxRmt4S87C49VlPxP1Ed0tdynbqG4yRuJfKKCDA
         3QdR6PKBfLqLR9rg9+tD+Z3dS6Sf4sXBhOmlF+zl804qlWwe9lZTR90zsurq5W4zQcTJ
         WtdYB6v9UEc02X1US9yY19YtRRm0AoAUUB8dPGTYjSaVDJ3ZxCJKZ2G5DLEIIiLJ49ng
         fJYHNSYOqPW3gP30QREQC10llraKXHjkozcey65/L5gtV3Z0w1mD+Y7el6UAubuyDdzw
         rGfbJ5N17X7vEybVJs2PnbHHaV4G9ZUHlE2ev9Ml3ygXhCN7+CXPoSe7/EOACBM5GN05
         SQUg==
X-Forwarded-Encrypted: i=1; AJvYcCXAJGoMVGW08NI0tOO09hOQ46ANNkFeDL+FXJ0tg/5pdBeDghNY+g7ALQTmL9LlVAWNSljPxlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3of4TX+wpCC2Jy9P3lXu7CiEBeTDhwxSRoSUdQ1fLUf1hSQdy
	L6DrmlPtK3Q6aikLNTSn4HQHEHa/AobGyhjOkThJ481Ot5APiWcXultgEM/6gRzePVqhN6iU/U2
	VbCKr2awI3Cj+NTFH/U+E8cehsKfS6GQvU6Ei
X-Gm-Gg: ASbGncsLeSk/U93Rk5hurqKIUaKGpa+WKyMVnNSp4FMFlJEra7L7dj1fmIxk3xrK/Y3
	IPHFjGyudH0dhDIiCrQhMicQE0ToBFQ==
X-Google-Smtp-Source: AGHT+IGD47hfGvANCdu/H98cv4C8vaKdOhudEJLTzTOk1DJNMSQxpxDwRVMeaHp270RuqHTe3e6FAhnpSV68P4d69tg=
X-Received: by 2002:a05:6512:3b06:b0:53d:ef60:ca9d with SMTP id
 2adb3069b0e04-53e2c2ededcmr230836e87.55.1733443546368; Thu, 05 Dec 2024
 16:05:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204221820.2248367-1-sashal@kernel.org> <20241204221820.2248367-5-sashal@kernel.org>
In-Reply-To: <20241204221820.2248367-5-sashal@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 16:05:09 -0800
Message-ID: <CAGETcx-RPvWq1DMGcuEneovA7Gs2WRp=pVQ9W_+A_Ywriq7UBw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 05/10] phy: tegra: xusb: Set fwnode for xusb
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

On Wed, Dec 4, 2024 at 3:29=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
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
> index 983a6e6173bd2..765ae53c85664 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -543,7 +543,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_por=
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

