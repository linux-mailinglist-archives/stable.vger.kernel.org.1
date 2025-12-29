Return-Path: <stable+bounces-203558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FD6CE6E4D
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38C4C30056D7
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42D414AD0D;
	Mon, 29 Dec 2025 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YNYWkeYD"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36733128DF
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767015480; cv=none; b=twiub+0L3xmrbP1N0ielTtzntK+RXbYgfWRoE+8HFuF1ROw10cgRGIoIu/W4YuMj0g84MV/qn1193OEnokk3MdzvDdhoBsjm4vRNXA/mw8T26TA0uMjfLrD77AwFClL7nmDSrExOGrZ3v7k9dh7pkfaYgDqSgTbo2glvvPWO29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767015480; c=relaxed/simple;
	bh=yb3VqVmKL8D40MJUoagmnByW6rjNgz+cK8XEz0cWzBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/1W4Uec/cKf8fpYcI2Dj/edUTLlQtvuWu6bniD9XR8UFlzaLra9xJV2OLVsoHNb8f54k9lHYIczfcbY6si5Rzu1gEEtuFA6vNOn4FWT+ULhEyzi6dDMPD/cwiL94bEFly3+JtFGc3qeVqAoFjFA11kulPHzgBnLZewM/jjgaZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YNYWkeYD; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37b935df7bfso77781741fa.2
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 05:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767015477; x=1767620277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rsz0gyavR3zZ8FafxzMvKtabJqoJjDNMu91I7khgI/A=;
        b=YNYWkeYDii5ppiEt+/zcrIarihjfBZVxKvFyFkQFKd3W3/rC+03Q9/yHzGV0q51Z/v
         bPBSrNpQWxOUnwv1mBuu8zfOrcnuPexbPd7Koau8BBtLvDfzGA7s/FrEE68nAZTg1Q7o
         qjDyM26tLCyMdbqOJGdlsZD7duCGR0Q5qYsDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767015477; x=1767620277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rsz0gyavR3zZ8FafxzMvKtabJqoJjDNMu91I7khgI/A=;
        b=c/k0QMJ0aHL1F/LPViSXfP6J84q44Y9ZpPtn0xwruQO7ZxYx33UeJqLZGQ1oO/Wgnw
         U3mX0KCzvUvmp25yOQoOYO5v4iblepnCSdflIswCHG+T4JgCvpbhK3ZBj4lMysr4QCrA
         jVxOAlRmdR72dZ60RYgL4NW/vniQkv5kXgX3SYeJCEwI40HblJm1SGvWwc2xv+xIzZFF
         HV0NQgGoxtRYFeKEbvdDKNm3lxMLw3OZcNKaCIqWdLNgwUqDr3R3Ez87b5r6zs9lPU1U
         4pI5otpK57zswY3IKTeNXuVH8htZlOvfAGVhcaxzZsmPEH/DPsTlTO29RO7Pxvgu8HUW
         a5Gg==
X-Gm-Message-State: AOJu0Yw18ZXObteTyCdLoip4ktQe27N+Wr3E6bnIv3GJE/vBPDfTLEVx
	QilBOfnWQiHKhU6FDhXqENWCbfRkRVVo1lbkQRPoDOPZrDXh5lVbBVe9rJwZjhnSk98jHKiPSj3
	9BZtz+uEJWiFC4jHA2Rgcwjuev/GSfFgbYKjPMT0=
X-Gm-Gg: AY/fxX7VujG3TTP8menRp2suvKYL+a8pmB/F5us8FSaYySQbn9BVLmmIVBKjkXauFt1
	yBHkI3t9BCJESbC5X23GUmdnQgblA6HMt4BpJ/v56CEZ/9RYnlsW2mAWRgw1Pt0ZCwsABj2Wns2
	Was/8Wdr9YEOVngIpuBD0+tV6NfyH2Oghv827lFRyPADd6l8VZMAK27qcUensnzOQ9MChsI4aWI
	PpE3dUdbYBGqjTkGOikZk4OfvqaMtB567dpvOJeT3RagCHZqK24F8MIlGaHALc+0ZbC
X-Google-Smtp-Source: AGHT+IGDSyi5W6VL1ubEOezGplHEmlpWxKYlcic6i9XKUDWNQ0PzXvPrAUO9tDiTHYG+UdCMTs27/K9yweaBLkO8Zos=
X-Received: by 2002:a2e:a587:0:b0:37e:69fb:cd5c with SMTP id
 38308e7fff4ca-381216b5525mr82810551fa.44.1767015476684; Mon, 29 Dec 2025
 05:37:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025120110-deuce-arrange-e66c@gregkh> <20251208065423.260017-1-sashal@kernel.org>
 <20251208065423.260017-2-sashal@kernel.org>
In-Reply-To: <20251208065423.260017-2-sashal@kernel.org>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Mon, 29 Dec 2025 14:37:45 +0100
X-Gm-Features: AQt7F2o7UpoTM74pXRRgV2QIztpAY5HQN-OmselfMtGV_b9yFlrpNNNqNJAaDts
Message-ID: <CALwA+Na-B4rkUvK6Hr-BPcKm_Q1mtoOpEpgLMEat_iq2G78VxQ@mail.gmail.com>
Subject: Re: [PATCH 5.15.y 2/2] xhci: dbgtty: fix device unregister
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable <stable@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 7:54=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
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
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/usb/host/xhci-dbgtty.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtt=
y.c
> index 20e50e559c2a2..32f8c3d40fb0c 100644
> --- a/drivers/usb/host/xhci-dbgtty.c
> +++ b/drivers/usb/host/xhci-dbgtty.c
> @@ -489,6 +489,12 @@ static void xhci_dbc_tty_unregister_device(struct xh=
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
>         tty_unregister_device(dbc_tty_driver, port->minor);

In linux-5.15.y baseline this line is
tty_unregister_device(dbc_tty_driver, 0);

Should I send an updated patch for 5.15.y ?

Thanks,
=C5=81ukasz

>         xhci_dbc_tty_exit_port(port);
>         port->registered =3D false;
> --
> 2.51.0
>

