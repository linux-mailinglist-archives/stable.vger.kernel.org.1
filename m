Return-Path: <stable+bounces-203528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 540F8CE6AC3
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD8083007C6A
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1F82F5A35;
	Mon, 29 Dec 2025 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N612hSIS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464522BE634
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767010925; cv=none; b=Mpvsz958OtRQY61g+n5Yf7GN6I+IXhTTd+ip4NxWSHR6BruVRW4vA2bMukPOXbnIouMNGmzipPCQxnGMwV5TTVGfnRm90RKPSedBz/ugakFI4n9tDZzU+dlUY2ce8yUzFzxJeoGZi1MHajzml6KMz5ZjyEPj+7CMourjXVa6hr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767010925; c=relaxed/simple;
	bh=+AvOBIsE4krpZyP/Ji61+mCd/yiWaRXqTnRPs1WO28Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEnLIy50LMAjlVEE/6bexJRbolgdYJpFM5YOgS3kTnm1zPPJ2mpYQPtsSsJ8JVoMpUTgxN7TT1yN4utbONy86izvJS/+NuqNlqQQrrjlDdctxggD5WF047j/xQSW3bJlVTzgODZIaAMJR7x/sdInd/jiYokZ/dnPf0+ewBX7OIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N612hSIS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5943b62c47dso8610625e87.1
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 04:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767010921; x=1767615721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QhdQD9sez4u9PrqF7TTQ4EApIGtLGMe+4rm2lt3vjQ=;
        b=N612hSISdQ4dWpOjBT39HOZT5oEMyHd4Q2tL5VFu5+q6qjNoHcjzZcEE3p/uBJqWF3
         nAv8xXHmwFUS4CK/KlX+QAZYdnojGTvID8bwbPt5ATKPb6zs42Jnj3Ii8yIF4CY+56Vx
         ys0tX98wgJIaBsjQ2VmyMn9ojVnm2lidSf2jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767010921; x=1767615721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9QhdQD9sez4u9PrqF7TTQ4EApIGtLGMe+4rm2lt3vjQ=;
        b=dPldOB1GcMXVcbJqGjT7reukiqt66AeKRrr9gk/hMEdyruC8GvNDtXD1Gtwwd3r/0m
         uaZcm/SUBsN4QPix7iF/dkRdcjg3OX7jofa+DJ93OHB/Ei0/bLB6jaLkETAEn4f/NsYJ
         UVELb5KjbUa7510amnzO012Vjsq2czV8w8VlGBuUFlcF6xEGt6dRfQG6VFqNulOOpftb
         FHPwQOIcHORbY1oMM1QOHCfELvwitfXxTfmng3WMZY2sX5HkuypBVyAk7TocFUov5Ch+
         R9jBuMZCWpQDL0IUyz23ZpIbel82EbpyFwXtQ6kj2Zi5WGwZ3rWMuR/EtL2bwtqBrfgg
         sWxw==
X-Gm-Message-State: AOJu0YzcLoYeEXFN6IDC+iVTLX+Xh79VaHLHxz1LI5dmj//RvP6hzuGf
	jeuuog0Zfc8bX9ePTKrK3pf2cTsaumcmpBmcNoi9/O0j2O81bJq9CEJLN5pqIZzK0fuJNM6GMPC
	KJ0Voar0jUA/ZxEEIZVImOnnE1rHFkE5WzFVv3vh18rZKRCkV8NSO
X-Gm-Gg: AY/fxX7ZuxoowhxGVf5WA0PfgjLjQuSTTob7jufacVVMi/iSGZuNjFZA0ekBDyvzTxh
	WGE6F5rU1cHVXy7bhEVxXuHPPVsZ5PXiokU5RLCEaqEwHyLpFY2tMRt6wZTU28WaD4L0oqC5Ef0
	a9KdBteX+zyrDQ8yQWFd2ADGHERlwx9sSzzlaSdfP3YeKEk+sUpsmzzyHALdx5Kl9NJZSMPnoKV
	/MTod4BGxXDhCwzOXJGO62uTySBjg8lOhVURgEn2LAvJ9fiAyZvGBfXm7GKxMeWWomPsqluuJbb
	/eA=
X-Google-Smtp-Source: AGHT+IHonvcgrl4/HTercFRzTIm1AzMSSRNazJgOgixzZP6/QrEYuJWc1Z75wLVIAAjYWxBnXvezKrrG5633hslKDS4=
X-Received: by 2002:a05:6512:2241:b0:594:51bd:8fcd with SMTP id
 2adb3069b0e04-59a17d0aedbmr11401147e87.16.1767010921341; Mon, 29 Dec 2025
 04:22:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025120110-coastal-litigator-8952@gregkh> <20251208130137.296454-1-sashal@kernel.org>
In-Reply-To: <20251208130137.296454-1-sashal@kernel.org>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Mon, 29 Dec 2025 13:21:50 +0100
X-Gm-Features: AQt7F2pg8N6QRtKjtThB7OLHxF65pmwu0-R1l9859NxTUnVM9aqZ4q-YIAOO9Kg
Message-ID: <CALwA+NbCx000Cw8tJWMsP4WnM5-ZNWrGnAt3hHwjLDEAsagezg@mail.gmail.com>
Subject: Re: [PATCH 5.10.y] xhci: dbgtty: fix device unregister
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable <stable@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 2:01=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: =C5=81ukasz Bartosik <ukaszb@chromium.org>
>
> [ Upstream commit 1f73b8b56cf35de29a433aee7bfff26cea98be3f ]
>
> When DbC is disconnected then xhci_dbc_tty_unregister_device()
> is called. However if there is any user space process blocked
> on write to DbC terminal device then it will never be signalled
> and thus stay blocked indifinitely.
>
> This fix adds a tty_vhangup() call in xhci_dbc_tty_unregister_device().
> The tty_vhangup() wakes up any blocked writers and causes subsequent
> write attempts to DbC terminal device to fail.
>
> Cc: stable <stable@kernel.org>
> Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
> Signed-off-by: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> Link: https://patch.msgid.link/20251119212910.1245694-1-ukaszb@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [ Adjust context ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/usb/host/xhci-dbgtty.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtt=
y.c
> index 980235169d811..d03eea7beeca0 100644
> --- a/drivers/usb/host/xhci-dbgtty.c
> +++ b/drivers/usb/host/xhci-dbgtty.c
> @@ -468,6 +468,12 @@ static void xhci_dbc_tty_unregister_device(struct xh=
ci_dbc *dbc)
>
>         if (!port->registered)
>                 return;
> +       /*
> +        * Hang up the TTY. This wakes up any blocked
> +        * writers and causes subsequent writes to fail.
> +        */
> +       tty_vhangup(port->port.tty);
> +
>         tty_unregister_device(dbc_tty_driver, 0);
>         xhci_dbc_tty_exit_port(port);
>         port->registered =3D false;
> --
> 2.51.0
>

Thank you very much Sasha for resolving the conflict for me.

Regards,
=C5=81ukasz

