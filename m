Return-Path: <stable+bounces-206062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DED66CFB69A
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 01:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC0B030262B7
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 00:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB2117D6;
	Wed,  7 Jan 2026 00:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m7jyeCar"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057BFDDAB
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 00:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767744293; cv=none; b=U/k5mQpKxxQw/BXga2qc5zzGoiP2/5gtA+95qYxrwbIlkCRf9Wvny0GbZw7bngsL83fzUZPqTkHgDuqr8s7SXWjDehuC3+tXTvqfbwFeBsFzzyiakotNZdiZI0tmA6/X00rMXZ6vcibeOYWF20UnhiGMVxB+yPv1fMnHgbmU66g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767744293; c=relaxed/simple;
	bh=8qJPx+kC5MLS3XV6h2sWuTOwf1eMrgy6GAS9eEFlKx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e93E4CGnqe/y1MCLAMy/6nnD5wKWKGHGVhPxv8yJ/uSIOkqFpyaJNhh+oXjlaBdAPxnhSCAor6X+K6hXvmZS+OI88nOBArLBCjNnNeBbFJk35Ddt2tCujCed6dBJdgYce0r0QFtfv3K17F/X5McuR+acRfoWFwFMlMZfhJwO6yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m7jyeCar; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b6f52eea8so176633e87.3
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 16:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767744290; x=1768349090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKyvUh+QhrMURKxvdZgbCSxanf920aeudQdpSlc4NpA=;
        b=m7jyeCar2XW6474ewzj23dhvhUSZZ5yi+Du+ZcJtRBHORqtXILfv5xvYytrrGWCqkD
         P5+vk9389JMZGI6IbmrkSkkmVzuWTRmn7wwhpcoIqq4+6W/855SyFxlrHDdLxVBZxAPn
         KMJhK/29GDBOK+7ySYNTsWTA1IfyzJ2b3Sa3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767744290; x=1768349090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HKyvUh+QhrMURKxvdZgbCSxanf920aeudQdpSlc4NpA=;
        b=VVpdBiTPdIB8xAWJzmUb0euxzMOIIfSeHiP+JYupRoQCDu1PAFhRCRJBW8qcLoX3T9
         V+iQeDGaImQ9fSL/jEVKKyutXabuYeax6/Eat3u0tgsmNHyS+nUotFr0ZFi/QaEgV2/G
         /fZ9UG1bG0tUaTb5NDkfAkYQVUBcylupOPryoaQe8sI2z0MWILNHki3aVSEkUzEl1oP2
         uO5iG0vKNFkG++yX3NnptHuXL3+4Ukfm8aGIcUElV08h4ut9BtU3Wra6abIbhlhYrjjZ
         pYa7yz6Dhz4BOEHFqPagy9Fx/Us+K+THLgU7DXDwPddHaBna9yb/6hkAYVnbcqYv13iq
         tgzg==
X-Gm-Message-State: AOJu0YzxcDBggahMA4Pw5JD00RAT2T/55xC9PRsPcWW90CqdY6FSjrLE
	4T4L/EgUCi4IjA+fDgNX/Z7eJjUUcAFBBsQ0GQBW2w2mNhR/Z+86+PTTzXo4LMsTox3x+NApk4+
	ON/702tE7AZTziohk1f3hiVp1Uw8VGwIPZNDkxl4=
X-Gm-Gg: AY/fxX5YBlG0imLL7FZU1ywlPcHxSHTgFvrPZ9AapsgiiplC2Aij9UGElluMQPrBBOF
	lG4B+Q711XHVyP3pbdhHG8Ho/+hxZ6xNv2v/bYCgk+H5VLDxQ/bqTYpn50h2AlOBq88CXcvAUYN
	nb8P3tXZvujDBeUwx8KacVBPW5yEc3j7qj7XkHlyoBkQMSvLR+4GpsOvGGK0h7NHNsfhkKtmgU7
	ZVWtPkVjFIZgoK3dh215MAN0NZ3ng5+nWQ65NrvMf9XdI8/x1mK2fSKB3t3Ffxakuc=
X-Google-Smtp-Source: AGHT+IFQdy/+2J9uOSYpxLDewV04a9J0eyKjqcf1U3V7EFffmr/5C+V3f6woXruTS5TnVHp7er13+RW98nO287n4HrI=
X-Received: by 2002:a05:6512:3dac:b0:598:e8b7:665d with SMTP id
 2adb3069b0e04-59b6ef0698bmr282600e87.3.1767744290137; Tue, 06 Jan 2026
 16:04:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106170451.332875001@linuxfoundation.org> <20260106170509.599329945@linuxfoundation.org>
In-Reply-To: <20260106170509.599329945@linuxfoundation.org>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Wed, 7 Jan 2026 01:04:37 +0100
X-Gm-Features: AQt7F2oZgW6rINda_2dA-YwksISTYezoZCKXSbhdQxy3iradySpgB4CCqOninEU
Message-ID: <CALwA+NZCSz26m96R0gjKP7=O3Z_kWmnt82SiaqvOukR9vFxv2A@mail.gmail.com>
Subject: Re: [PATCH 6.12 493/567] xhci: dbgtty: fix device unregister: fixup
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	stable <stable@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 6:43=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.12-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: =C5=81ukasz Bartosik <ukaszb@chromium.org>
>
> [ Upstream commit 74098cc06e753d3ffd8398b040a3a1dfb65260c0 ]
>
> This fixup replaces tty_vhangup() call with call to
> tty_port_tty_vhangup(). Both calls hangup tty device
> synchronously however tty_port_tty_vhangup() increases
> reference count during the hangup operation using
> scoped_guard(tty_port_tty).
>
> Cc: stable <stable@kernel.org>
> Fixes: 1f73b8b56cf3 ("xhci: dbgtty: fix device unregister")
> Signed-off-by: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> Link: https://patch.msgid.link/20251127111644.3161386-1-ukaszb@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/host/xhci-dbgtty.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/drivers/usb/host/xhci-dbgtty.c
> +++ b/drivers/usb/host/xhci-dbgtty.c
> @@ -522,7 +522,7 @@ static void xhci_dbc_tty_unregister_devi
>          * Hang up the TTY. This wakes up any blocked
>          * writers and causes subsequent writes to fail.
>          */
> -       tty_vhangup(port->port.tty);
> +       tty_port_tty_vhangup(&port->port);

The function tty_port_tty_vhangup does not exist in the 6.12 kernel.
It was added later.

I sent updated patch
https://lore.kernel.org/stable/20260106235820.2995848-1-ukaszb@chromium.org=
/T/#mb46d870145474d04aaabeccc76aaf949b34bbf86

Thanks,
=C5=81ukasz

>
>         tty_unregister_device(dbc_tty_driver, port->minor);
>         xhci_dbc_tty_exit_port(port);
>
>

