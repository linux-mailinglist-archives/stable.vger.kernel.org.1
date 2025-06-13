Return-Path: <stable+bounces-152621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 221B8AD8D2B
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 15:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D757017EB12
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 13:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB7E18A6DF;
	Fri, 13 Jun 2025 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsKDBui+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277E14D2B7;
	Fri, 13 Jun 2025 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749821774; cv=none; b=jalA437TsEL7UaEsewQ3tyyxAAKqqFd3jSVIB9XzMN1Rd3QU+OV+KP/KZRS4GseRXPQVCzI+lQWUv2gsqKaSmfC+oPaFf9WDi5BYRPTonne2+zIt36zz70xISj7xMaycr4/7rSTBY9v5mFCTBvJ4cm2h7VryrP6utubBlbQcbKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749821774; c=relaxed/simple;
	bh=9SdAV1IzVJqJeu3b1IS5tXD6bXFiTIoEnAT8XdsDnFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrcdtBQDeYdVIhqQpAyuXGA3OMu0nxiGaGkY8nA6f90kDcKNRxADlCFO4Yq6yyfRiJksKCwkagOieqYjolxL/dn4Wfu1LBs3AJWcjyBQkhStih8g2bs/AYhylGDlCCDProAloXtiPEm/JZbPF/JFExSnzD37kni3mZOjIsBpFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsKDBui+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8797C4CEE3;
	Fri, 13 Jun 2025 13:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749821774;
	bh=9SdAV1IzVJqJeu3b1IS5tXD6bXFiTIoEnAT8XdsDnFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KsKDBui+jwcthfxtzu+dyVSEaItRtuPnZOdd7xuJcJUeM/yr/bHhqaQjiGXB7Ahg6
	 wCZwZAPtdzixsCvjyqP5cNHgjIEs6pdFz9gvo/IoJGii3MeWw8w67PhYVQmVNlyaHL
	 hIccovWszX822mrp2SwLSFE1cuDD2i8+ruRkwcnhA29UHVn0ol0Vyb1Hn9QEc91phI
	 n3G/TXDb/DyAJwy29WoeEQfJFVX3CSMZ4VhPVNaPlCL51Xk5TfF9Mr6xuFGO/aNTN8
	 QfAPdbWvW6urFSxUbTvKNtyADHN3JC3ySdzNWj4h603nVW/zmGfYu3tDX7SdVxR6Js
	 kE1HmXITCleDg==
Date: Fri, 13 Jun 2025 14:36:10 +0100
From: Lee Jones <lee@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Tom Vincent <linux@tlvince.com>
Subject: Re: [PATCH v2] mfd: cros_ec: Separate charge-control probing from
 USB-PD
Message-ID: <20250613133610.GU381401@google.com>
References: <20250609-cros-ec-mfd-chctl-probe-v2-1-33b236a7b7bc@weissschuh.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-cros-ec-mfd-chctl-probe-v2-1-33b236a7b7bc@weissschuh.net>

On Mon, 09 Jun 2025, Thomas Weißschuh wrote:

> The charge-control subsystem in the ChromeOS EC is not strictly tied to
> its USB-PD subsystem.
> Since commit 7613bc0d116a ("mfd: cros_ec: Don't load charger with UCSI")
> the presence of EC_FEATURE_UCSI_PPM would inhibit the probing of the
> charge-control driver.
> Furthermore recent versions of the EC firmware in Framework laptops
> hard-disable EC_FEATURE_USB_PD to avoid probing cros-usbpd-charger,
> which then also breaks cros-charge-control.
> 
> Instead use the dedicated EC_FEATURE_CHARGER.
> 
> Link: https://github.com/FrameworkComputer/EmbeddedController/commit/1d7bcf1d50137c8c01969eb65880bc83e424597e
> Fixes: 555b5fcdb844 ("mfd: cros_ec: Register charge control subdevice")
> Cc: stable@vger.kernel.org
> Tested-by: Tom Vincent <linux@tlvince.com>
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Rebase onto v6.16-rc1
> - Pick up tested-by from Tom
> - Also Cc stable@
> - Link to v1: https://lore.kernel.org/r/20250521-cros-ec-mfd-chctl-probe-v1-1-6ebfe3a6efa7@weissschuh.net

Whoops, I already applied v1.  However, I did all of these things manually.

> ---
>  drivers/mfd/cros_ec_dev.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 9f84a52b48d6a8994d23edba999398684303ee64..dc80a272726bb16b58253418999021cd56dfd975 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -87,7 +87,6 @@ static const struct mfd_cell cros_ec_sensorhub_cells[] = {
>  };
>  
>  static const struct mfd_cell cros_usbpd_charger_cells[] = {
> -	{ .name = "cros-charge-control", },
>  	{ .name = "cros-usbpd-charger", },
>  	{ .name = "cros-usbpd-logger", },
>  };
> @@ -112,6 +111,10 @@ static const struct mfd_cell cros_ec_ucsi_cells[] = {
>  	{ .name = "cros_ec_ucsi", },
>  };
>  
> +static const struct mfd_cell cros_ec_charge_control_cells[] = {
> +	{ .name = "cros-charge-control", },
> +};
> +
>  static const struct cros_feature_to_cells cros_subdevices[] = {
>  	{
>  		.id		= EC_FEATURE_CEC,
> @@ -148,6 +151,11 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
>  		.mfd_cells	= cros_ec_keyboard_leds_cells,
>  		.num_cells	= ARRAY_SIZE(cros_ec_keyboard_leds_cells),
>  	},
> +	{
> +		.id		= EC_FEATURE_CHARGER,
> +		.mfd_cells	= cros_ec_charge_control_cells,
> +		.num_cells	= ARRAY_SIZE(cros_ec_charge_control_cells),
> +	},
>  };
>  
>  static const struct mfd_cell cros_ec_platform_cells[] = {
> 
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250521-cros-ec-mfd-chctl-probe-64a63ac9c160
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>
> 

-- 
Lee Jones [李琼斯]

