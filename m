Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3617A4C66
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 17:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjIRPcl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 11:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjIRPcV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 11:32:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E468BE58
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 08:30:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F393BC116B3;
        Mon, 18 Sep 2023 14:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695045610;
        bh=Mp0t6xBRp7GW/lv/lW+8V80MZSvPRsEKKvnE+N19w7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sIV/8fDG3ItQTJzMKfYLydwi9r+iO8MJkUcbMl0nsxmdRgKOx3o7DSF1s/ZD1Byp0
         Nio/lwQNQt5oJ3mu3Hhjc/jxjwcIglmA+ufQa7F+5/Gd2K+LX6ESMGXUW50hdGdvbe
         cN0ABIX7+RyAD/HJYwzFcdoOmiFpedOCgCrmz79MXzftr+Ja27Hcfw7PlFtpJLB++o
         WN5HieRLMs+e70V7kch1q3eObCFcX6mhQzQGSiRkaI+W0OFQq+Tkz3GOws7jMWxMiG
         iMjhcnp4of6xUItvajD8Jo+bwzuDGMocHvzAIWHBJ3D2dA3FBgCQrWowt8m2jzG9tU
         XYYoy9cSv4O3g==
Date:   Mon, 18 Sep 2023 16:00:04 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 261/406] leds: Fix BUG_ON check for
 LED_COLOR_ID_MULTI that is always false
Message-ID: <20230918160004.3511ae2e@dellmb>
In-Reply-To: <20230917191108.094879104@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
        <20230917191108.094879104@linuxfoundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greg, please drop this patch from both 5.10 and 5.15.

Reference:=20
  https://lore.kernel.org/linux-leds/ZQLelWcNjjp2xndY@duo.ucw.cz/T/

I am going to send a fix to drop the check altogether.

Marek

On Sun, 17 Sep 2023 21:11:55 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> 5.10-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Marek Beh=C3=BAn <kabel@kernel.org>
>=20
> [ Upstream commit c3f853184bed04105682383c2971798c572226b5 ]
>=20
> At the time we call
>     BUG_ON(props.color =3D=3D LED_COLOR_ID_MULTI);
> the props variable is still initialized to zero.
>=20
> Call the BUG_ON only after we parse fwnode into props.
>=20
> Fixes: 77dce3a22e89 ("leds: disallow /sys/class/leds/*:multi:* for now")
> Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> Link: https://lore.kernel.org/r/20230801151623.30387-1-kabel@kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/leds/led-core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
> index c4e780bdb3852..2cf5897339ac1 100644
> --- a/drivers/leds/led-core.c
> +++ b/drivers/leds/led-core.c
> @@ -425,15 +425,15 @@ int led_compose_name(struct device *dev, struct led=
_init_data *init_data,
>  	struct fwnode_handle *fwnode =3D init_data->fwnode;
>  	const char *devicename =3D init_data->devicename;
> =20
> -	/* We want to label LEDs that can produce full range of colors
> -	 * as RGB, not multicolor */
> -	BUG_ON(props.color =3D=3D LED_COLOR_ID_MULTI);
> -
>  	if (!led_classdev_name)
>  		return -EINVAL;
> =20
>  	led_parse_fwnode_props(dev, fwnode, &props);
> =20
> +	/* We want to label LEDs that can produce full range of colors
> +	 * as RGB, not multicolor */
> +	BUG_ON(props.color =3D=3D LED_COLOR_ID_MULTI);
> +
>  	if (props.label) {
>  		/*
>  		 * If init_data.devicename is NULL, then it indicates that

