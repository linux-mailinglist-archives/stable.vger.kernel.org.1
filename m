Return-Path: <stable+bounces-50469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E618D9066EC
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B56283D27
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D11E1411CB;
	Thu, 13 Jun 2024 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zrFe2az5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8513D523
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267558; cv=none; b=HyNTIQhXF28TFsDQuEPUOqOr3h4Vh2eVM6Rm7E0SV/R3Th348yAy0PXXmR/G1mKfnX645tAIUXwGhbDrFkdcMrpr7IXSM1zz7zWJeca97XZJNWXe2c0g7ViOI55fpi5QcjFMaU66/9aAbguWnxLlJAlVyAUhsRKUIkXbFZc4Ai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267558; c=relaxed/simple;
	bh=y3OKQe8Xesd2C9X9E8jFyuVSBQ3UohhWnTdvvPxH47c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhEljZF8q6ISDeJ4/6V+yiUesdyIz+GkVV04Hi8PNXAknLHW2ZaCFqE56Z2PrkXpNV+Vhz3lm0Y0CzHKkfujka9t+LctCyHez7dryWo4zN6eXtrsfWS4cvC9e3BYZHEkjaZUSLCiyO57zrprxI2ORGRfT9+fLIM+OIBeqsmpnas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zrFe2az5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7987DC2BBFC;
	Thu, 13 Jun 2024 08:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718267557;
	bh=y3OKQe8Xesd2C9X9E8jFyuVSBQ3UohhWnTdvvPxH47c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zrFe2az5VnxVVKXBkd4BCnwd14P3feDwn0IpGncBIq+pwPm3AihWhHh3Bsq0GNkro
	 Q7ZS5STCz+tuhTSDUxPK8EhtzuxZIfNrxh9lg4tF3x/na+9CZ32UiZTfc/ACf+nmCd
	 C1giqA65WxiN5JeY5XOXvSTYT+FeyQbAVzs7LaLQ=
Date: Thu, 13 Jun 2024 10:32:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: stable@vger.kernel.org, ulf.hansson@linaro.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 6.1.y] mmc: davinci: Don't strip remove function when
 driver is builtin
Message-ID: <2024061322-sliceable-pucker-418c@gregkh>
References: <2024061227-zit-rupture-640c@gregkh>
 <20240613055540.2284309-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240613055540.2284309-2-u.kleine-koenig@baylibre.com>

On Thu, Jun 13, 2024 at 07:55:41AM +0200, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Using __exit for the remove function results in the remove callback being
> discarded with CONFIG_MMC_DAVINCI=y. When such a device gets unbound (e.g.
> using sysfs or hotplug), the driver is just removed without the cleanup
> being performed. This results in resource leaks. Fix it by compiling in the
> remove callback unconditionally.
> 
> This also fixes a W=1 modpost warning:
> 
> WARNING: modpost: drivers/mmc/host/davinci_mmc: section mismatch in
> reference: davinci_mmcsd_driver+0x10 (section: .data) ->
> davinci_mmcsd_remove (section: .exit.text)
> 
> Fixes: b4cff4549b7a ("DaVinci: MMC: MMC/SD controller driver for DaVinci family")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20240324114017.231936-2-u.kleine-koenig@pengutronix.de
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> [ukleinek: Backport to v6.1.x]
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/mmc/host/davinci_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

What is the git id of this commit in Linus's tree?

thanks,

greg k-h

