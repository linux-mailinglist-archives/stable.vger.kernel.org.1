Return-Path: <stable+bounces-20169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF18885485D
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 12:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935C81F2758A
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 11:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9541946C;
	Wed, 14 Feb 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="M08PfnFe"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4DB171A3
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910216; cv=none; b=l2qgBggAalYwEIK8IjDldtf3XWGc6YDU/TY03kdlq71Q3Pr6T93xu12cr/yMHT8/NloaLaQGwRUGiZpY3gjq0WdVHe6Rbo33UwAW3IJV9DLKDucBP719PxoiDXXJKbQxvBnfGy5gyg6biAYywKlpW4lelLUx+vXHcYVe2j9y0JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910216; c=relaxed/simple;
	bh=2SesfAQnpRJoWRG8I4sddPr2uCF/d6k9jaVexrEyhDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gx9SgEZh0m9CaV+UC2IfhoyGyZzjEq9wiSY/JPQHDB2ktewXF2gCDy24P5Y5FIK3aBB/3UkoTB5FGKm2VHO5Ortt2rbU0elT5E9w8JG2X96zc3JWfr0YvaSR2TwFWJxNjiFI/aF+RwchHnR78SpSjHKELORz9ggdyBahl0zE2WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=M08PfnFe; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id F0816228F6;
	Wed, 14 Feb 2024 12:30:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707910211;
	bh=FUWd4PUVb0ug/H/pPw02cchmnSxRMsJhZBkIIlvDAC0=; h=From:To:Subject;
	b=M08PfnFe8mCFcIs82C3CRX45PPSAR1qb5UHo505/w7RG+5y1rLxthlOeQztwh7d82
	 G2rAq2zF//0j2J5855ISmpu28E+eG86XwmXJXBbJ5mR7CEdEp1MPY3yhNH9qfoIsPC
	 BXdFZdNa0beGfRMVeH9s9DDOLKZaGRIPGYJ1gqYS1YOkPbwiSueNlXpNtXVhGEeca0
	 QlBFqIxTuIV1XImLK5ePx4jUfgNjPumbLeJQFnkYaJb0f1Zj26m9nsPqBMaOZk8Rnq
	 sFmBdFYdY4yspBSy/7fja9Iq0jfo01qXuE/ukbnR+Sv63/7QZRaNq2KyX3MKDpFEgu
	 TmQAQVyvhx/1w==
Date: Wed, 14 Feb 2024 12:30:07 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Fabio Estevam <festevam@gmail.com>
Cc: shawnguo@kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Restore
 CONFIG_BACKLIGHT_CLASS_DEVICE
Message-ID: <20240214113007.GA88408@francesco-nb>
References: <20240201180054.3869350-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201180054.3869350-1-festevam@gmail.com>

Hello Fabio,

On Thu, Feb 01, 2024 at 03:00:54PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit bfac19e239a7 ("fbdev: mx3fb: Remove the driver") backlight
> is no longer functional.
> 
> The fbdev mx3fb driver used to automatically select 
> CONFIG_BACKLIGHT_CLASS_DEVICE.
> 
> Now that the mx3fb driver has been removed, enable the
> CONFIG_BACKLIGHT_CLASS_DEVICE option so that backlight can still work
> by default.
> 
> Tested on a imx6dl-sabresd board.
> 
> Cc: stable@vger.kernel.org
> Fixes: bfac19e239a7 ("fbdev: mx3fb: Remove the driver")
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Toradex Colibri iMX7


