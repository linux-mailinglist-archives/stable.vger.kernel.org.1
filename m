Return-Path: <stable+bounces-238657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id P5QPEJ455WkGfwEAu9opvQ
	(envelope-from <stable+bounces-238657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 22:22:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB1442571E
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 22:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BAA83006B44
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 20:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933222F12A1;
	Sun, 19 Apr 2026 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vK7UZk2U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676D40DFBB
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776630169; cv=none; b=DWw52X+UQzYtl72TAhkNC9YGGZbNhYj/VbSlZJfsQxnWjR7YyRi0htGN3RN34kLlA8HSK4RXrqLntG71DTIfQhJF3KLJWiPq4Tla5r8EhlG03K3bxaKfEPZ5YQS5jrSbQ+ZoPw1HRhOItFcbjI1oQJ2XRD2EUDbBb2vINCZvXZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776630169; c=relaxed/simple;
	bh=9DkN4UJECtm0IFZQ7IDjwr8Jt5qlKg5Pn6HXQqREXsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsSAHMUnVW8+zMzBykLkkkeQ10OgcgLvYsMLUBw7GXnLH552TGLBQCIhjnW2YF/bR3nQelBCuEuAH8Cvu3bVS0XZ9u1er7CoU9pc1q9A8M/SI27tsSMVLqBSnaXEs8cM/vleMVapE5Bkmmi0TnV5OhZTEwf/SdMxF+Ry7LqqE48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vK7UZk2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8ABC2BCB4
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 20:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776630169;
	bh=9DkN4UJECtm0IFZQ7IDjwr8Jt5qlKg5Pn6HXQqREXsk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vK7UZk2UyG2Jz0oLDq53e2PvG0I4WWUNVC6bjR2qL6aL7weGb9athuVfk8h6iuWuN
	 PlfKOmWibQC9V0CsrCZHZV4WG+ad0M7QNhe2LUmWpyQ29P6r+ZA0vilEMoVS+jWJKa
	 CRnQ71mwtMsj2NrqktCsYrJvLAlNWN07BUPBz9N2weCwd+OQOfy37E5x10MK/e8wvj
	 lM/4i+hPZGvMkUlcxJS+qbNmE1N2IMcv4WAc1/kSQGpg1XGB2bjdqbEZMD7zQUxd7W
	 qtk8MDSjqlz4Fu8TsgS7f/LGRILXDfFJGspor3W8Gik8mqLmjaYOd5ELljP98bfLnp
	 za95zo8EfUtiQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a2c7427ad9so2306381e87.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 13:22:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/v8iwXDmJbbPmHv/BzoAZ5dTRAytOjWIm/eh7ijSsxPDK9Ird7an5m2CyGX5zSuiBadMsgWQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx46t5EjROC0DQd8irhhZVVFMjfqQSORIGAlJJPVCoT6RxZXNUq
	mLTZIEXkHV3I6DlBCaNG/a3jqXhIkUVPoJnfHNw7OGebICB6mUmKR0PZMnPBU9KjRlwxObAgPC8
	h1ZwZcPN82g8Q8xxUzmoqb8uJLSPKVR8=
X-Received: by 2002:a05:6512:3e05:b0:5a3:fcb2:c6aa with SMTP id
 2adb3069b0e04-5a4172bfee7mr3442408e87.13.1776630167775; Sun, 19 Apr 2026
 13:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413154727.3051321-1-lgs201920130244@gmail.com>
In-Reply-To: <20260413154727.3051321-1-lgs201920130244@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 19 Apr 2026 22:22:34 +0200
X-Gmail-Original-Message-ID: <CAD++jLnC5MGg1e_Suv6BD_=XKbsn1aLxHxRfCdD3Nos+2XRzfw@mail.gmail.com>
X-Gm-Features: AQROBzCDUCdqQVnjQAyYtn99zG1zFrnsiXSLX3a_nvy_WJ_NdEcr9JskY4IufVw
Message-ID: <CAD++jLnC5MGg1e_Suv6BD_=XKbsn1aLxHxRfCdD3Nos+2XRzfw@mail.gmail.com>
Subject: Re: [PATCH] watchdog: ixp4xx: fix reference leak on
 platform_device_register() failure
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Imre Kaloz <kaloz@openwrt.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238657-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8BB1442571E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Guangshuo,

thanks for your patch!

On Mon, Apr 13, 2026 at 5:47=E2=80=AFPM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:

> ixp4xx_timer_probe() directly returns the result of
> platform_device_register(&ixp4xx_watchdog_device). When registration
> fails, the embedded struct device in ixp4xx_watchdog_device has already
> been initialized by device_initialize(), but the failure path does not
> drop the device reference, leading to a reference leak.
(...)

> -       return platform_device_register(&ixp4xx_watchdog_device);
> +       ret =3D platform_device_register(&ixp4xx_watchdog_device);
> +       if (ret)
> +               platform_device_put(&ixp4xx_watchdog_device);

If the problem in the description is indeed there, it seems the bug
is inside platform_device_register(), surely a function returning an
error code is supposed to clean up any resources it takes before
returning an error. It seems wrong to try to fix this in all the
consumers.

Yours,
Linus Walleij

