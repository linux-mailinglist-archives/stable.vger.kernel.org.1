Return-Path: <stable+bounces-89117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9909B3A6A
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 20:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6EF1F2258A
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 19:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6CF18F2DF;
	Mon, 28 Oct 2024 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QHHhlu+G"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD75155A52
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730143736; cv=none; b=NgKkKX7AantIxE8e4BWM3iYfSLXYWv/IVhpqihVoQbkBr9J3Cu5aL/nqizEtpUqFq3psylAPC0RP5jcGxgKrFL7PDbFwR7IgNpLnn2KdsepOhUkWip2JFF5Tsm8A5d7qry6gBwxoZPIkFXG3qMZPolnSS/zcwldv3DvOjonCABk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730143736; c=relaxed/simple;
	bh=zhRPxXpMYUnQtlDg/EcB2mvGN8pwmlAOQ7q9ehSkUoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtX5OIt4OZAq/QC70zxhOsI5JdBSNigtyvF3BqpCn1Qh7HUGsPW0D0L9TeDJqcNq0jW8oMTnEzujia7AwWrJbSZxmKN4JOS6lGiAGx77u/8j1HyIEHp6mDvpBjwPWifE5ybHVRYU/BuGW2CSNn8oTqnAF8a8G2ca7UziLuWYyuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QHHhlu+G; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so3486580a12.0
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 12:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730143733; x=1730748533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0T1n6fU/OspCYIpwClSLWKrMUBp9ZorJc3H+/WkDpNU=;
        b=QHHhlu+GhVRLJtiL6Hu7xltJVQmSbcfod+5OUQDFFw8xe0Tfj+wC9laFxqkVLJyhtK
         Bxf2+NK4bchFzzbMcRMS3yeTrvfoCN056eY8S6D5d71+Kx2A7zuMMeXlWUO/T8Qp7OYk
         G7sIfQgyLMI5xR1QWciJBw1Jy0lysfYQSa1OueHJbBeDmzzL1DXLIIYTDGZ8zxwHOb25
         2PEBLj4o7jj5CXCdcavAFRRoHnD95/wQj5DPn4xAbrMvfnXXMIPQPlrgjda2l/1+IoAf
         rkZRsLCeu/1/QlcK+SUNZKN+xFU1RwNpeqm87LuW9t9dsKV5SdDM+2Pwl5RuLcAehGrP
         5N3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730143733; x=1730748533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0T1n6fU/OspCYIpwClSLWKrMUBp9ZorJc3H+/WkDpNU=;
        b=gVViHDDienJcU5RTEr3DwLZa5//DWp6XzvEU8b+iXUYJgg2VD1cNT1VaBPqUcvx6iZ
         iycDlw4BFAXTnT3S2pYN69qnGxFyujZHG/KcW5MN39/6Xd0QL0ozOvye8H7NeRQ/pqbC
         kf+Y6IQjYR4L5mOZiILX3OnE0cIDvlMHN4AZR6tyOMoNZ6nqqFvJjDHMtOxJPX0XRAPr
         r8dmg4W5icMTcqn8d5G4cEby1r32owXQRo6vvpI22DQW/HSD8FytJ7wkoBE4tsJpFVtU
         ufJv+aHH3FZyrSvoc562iiHOzmO+wwnx0qwvcxWpLxLAXNLpU5NBYbZh90qHO97he6nu
         crng==
X-Gm-Message-State: AOJu0Yzsb0AHjp/fiRBokfv8A6KKpsHRYBf5vx02jh7EBL3F9I2tqEGx
	yuNQnPCjPR+KzblStmXR0fAGook8vmFzW4NOhMssrEx9L7U0Oc026yfz29+2IUwzHfOn5GmU47h
	DAjnCoYgs9gsmp4uZoswCBH2iZ/VvQ5oQ+ABtKYmUjAE3kvS7V6nO
X-Google-Smtp-Source: AGHT+IGfUL4JfHmkwexIT1dWy3Jk714LEvjyZjrFRN52GqN1249MrUze423hF7+YremtB2e0U4s6nXBRqNL8k5aS/VU=
X-Received: by 2002:a05:6a21:1798:b0:1d9:18b7:496 with SMTP id
 adf61e73a8af0-1d9a851e099mr13212445637.45.1730143732983; Mon, 28 Oct 2024
 12:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028-fixup-5-15-v3-1-078531a8d70a@mediatek.com>
In-Reply-To: <20241028-fixup-5-15-v3-1-078531a8d70a@mediatek.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 28 Oct 2024 12:28:14 -0700
Message-ID: <CAGETcx-kaXLPdZgDghT41=2uxN=Ck=kaAj5wkF_yqpjyz=6_2w@mail.gmail.com>
Subject: Re: [PATCH v3] Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"
To: jason-jh.lin@mediatek.com
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, 
	Seiya Wang <seiya.wang@mediatek.com>, Singo Chang <singo.chang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 11:33=E2=80=AFPM Jason-JH.Lin via B4 Relay
<devnull+jason-jh.lin.mediatek.com@kernel.org> wrote:
>
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
>
> This reverts commit ac88a1f41f93499df6f50fd18ea835e6ff4f3200.
>
> Reason for revert:
> 1. The commit [1] does not land on linux-5.15, so this patch does not
> fix anything.
>
> 2. Since the fw_device improvements series [2] does not land on

fw_devlink. Not fw_device.

-Saravana

> linux-5.15, using device_set_fwnode() causes the panel to flash during
> bootup.
>
> Incorrect link management may lead to incorrect device initialization,
> affecting firmware node links and consumer relationships.
> The fwnode setting of panel to the DSI device would cause a DSI
> initialization error without series[2], so this patch was reverted to
> avoid using the incomplete fw_devlink functionality.
>
> [1] commit 3fb16866b51d ("driver core: fw_devlink: Make cycle detection m=
ore robust")
> [2] Link: https://lore.kernel.org/all/20230207014207.1678715-1-saravanak@=
google.com
>
> Cc: stable@vger.kernel.org # 5.15.169
> Cc: stable@vger.kernel.org # 5.10.228
> Cc: stable@vger.kernel.org # 5.4.284
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_ds=
i.c
> index 24606b632009..468a3a7cb6a5 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -221,7 +221,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *h=
ost,
>                 return dsi;
>         }
>
> -       device_set_node(&dsi->dev, of_fwnode_handle(info->node));
> +       dsi->dev.of_node =3D info->node;
>         dsi->channel =3D info->channel;
>         strlcpy(dsi->name, info->type, sizeof(dsi->name));
>
>
> ---
> base-commit: 74cdd62cb4706515b454ce5bacb73b566c1d1bcf
> change-id: 20241024-fixup-5-15-5fdd68dae707
>
> Best regards,
> --
> Jason-JH.Lin <jason-jh.lin@mediatek.com>
>
>

