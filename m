Return-Path: <stable+bounces-126917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B814FA7453B
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 09:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E572189CD60
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 08:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B5D212B17;
	Fri, 28 Mar 2025 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qG3GtZtn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4736153BE8;
	Fri, 28 Mar 2025 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743149947; cv=none; b=HMxDkoGcC4EYT2WJsnNNTnZGESNtzTiAwR2akhNQzDxBt9d2yfiBkZcr8CtYUpag3E41wxfAfil8pfpL2W83+U/qFdYEY5D++9DFd0StAJRMNMSW/rEHRgUOGD4aCaJ0CFF/exgEvnqEMulCgib0KpuCMaLtyrQKp23vmrBlNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743149947; c=relaxed/simple;
	bh=eXkyQAmWLQhgbflGuE6/2roWByAJGJzRKnWkxqKXpr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMNBQ4VrTnrLjAFReb01yREoZAiX7sD7QR2gSnwwdQNlCEwJnsE45mDs0WeOoK3pXKVo+d12HGliBmp62ECBL+WTEyqm+/GTep8bYzzKUL4QoINwED4wdoOuZLgdSt88zNu7LuMFcwhp73Qx0Ts3YIDj65bP7LwXjYX8JPXQgRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qG3GtZtn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D4AC4CEE4;
	Fri, 28 Mar 2025 08:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743149947;
	bh=eXkyQAmWLQhgbflGuE6/2roWByAJGJzRKnWkxqKXpr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qG3GtZtnCFsiKLE21GDIQj94MikZUdLpBnmZDeoZNnTD4vf6OZTlRrVb/NtZAe/TW
	 xMQySvO4HGCmmIA/+2e6Yyf97jRCGtfxzaFD9JfBBdqMCSHugcNjRSf0k0pMeWNgkh
	 JIlDAfdbTjEMPggbhusLn7HjPZRbb9ZyDaSM9gNN1uHaer1mVDimaxp4XXvlg9DaQN
	 8A9hMhvqSYBg39PkGF82aQkFCwKwLe8JRmwdXBGyenkYje5d/VayiU2KFIO1pOGS0P
	 6taEZ0fWLi6pnQqARE7alhTwPZKLy55U8x0/sD7ZVfQmljHmIx4+JjPZQI+p0rSACc
	 ps4zNQAIpwVfw==
Date: Fri, 28 Mar 2025 09:19:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: Matthias Kaehlcke <mka@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Benjamin Bara <benjamin.bara@skidata.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Klaus Goger <klaus.goger@theobroma-systems.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, quentin.schulz@cherry.de, stable@vger.kernel.org
Subject: Re: [PATCH 1/5] usb: misc: onboard_usb_dev: fix support for Cypress
 HX3 hubs
Message-ID: <20250328-holistic-feathered-guppy-5bac92@krzk-bin>
References: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
 <20250326-onboard_usb_dev-v1-1-a4b0a5d1b32c@thaumatec.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250326-onboard_usb_dev-v1-1-a4b0a5d1b32c@thaumatec.com>

On Wed, Mar 26, 2025 at 05:22:56PM +0100, Lukasz Czechowski wrote:
> diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
> index 317b3eb99c02..17696f7c5e43 100644
> --- a/drivers/usb/misc/onboard_usb_dev.h
> +++ b/drivers/usb/misc/onboard_usb_dev.h
> @@ -104,8 +104,14 @@ static const struct of_device_id onboard_dev_match[] = {
>  	{ .compatible = "usb451,8027", .data = &ti_tusb8020b_data, },
>  	{ .compatible = "usb451,8140", .data = &ti_tusb8041_data, },
>  	{ .compatible = "usb451,8142", .data = &ti_tusb8041_data, },
> +	{ .compatible = "usb4b4,6500", .data = &cypress_hx3_data, },
> +	{ .compatible = "usb4b4,6502", .data = &cypress_hx3_data, },
> +	{ .compatible = "usb4b4,6503", .data = &cypress_hx3_data, },
>  	{ .compatible = "usb4b4,6504", .data = &cypress_hx3_data, },
>  	{ .compatible = "usb4b4,6506", .data = &cypress_hx3_data, },
> +	{ .compatible = "usb4b4,6507", .data = &cypress_hx3_data, },
> +	{ .compatible = "usb4b4,6508", .data = &cypress_hx3_data, },

Why are you adding so many entries? Same entry is a strong sign these
are compatible.

Best regards,
Krzysztof


