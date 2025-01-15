Return-Path: <stable+bounces-108705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91424A11FC1
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FA81883764
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B2323F26B;
	Wed, 15 Jan 2025 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ulKwubRW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E95C1EE7AC
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937131; cv=none; b=ACrAGYOu5HHxNIZcbL44/bArVbzN/FnagTHt1BnSSv4CScLpAr+3igVkvbL+xr+Paygw4wGYSPlo+SOl73ApygDpUGhyvEA9Gc85gMkRZQb5d0KQWs09V+HRnMrpvB5IaTRYaKmxFVkvy8hym70yd6JqZhY5j0SotAxvDpCYCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937131; c=relaxed/simple;
	bh=DsNV5Y5jTgosV+mfs0LRtUDuLg4m1DiVUjFO3tqRuPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFEQn9lWGWAom7GrIGwcqZzzp0HsHeooD7/4DHOEG2oXkwZjSWy/67amzBZnRLqwhTD4Lki5RIlibXxGorHHPJSe2r53aoaKsPrP0P3r0PEE//ikwkL6+fAns7+V2vyZjLG8f3/Pa6M8rPoVMxnJ1A1CYIVV3VtAM54VgTPX94k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ulKwubRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB21C4CEE6;
	Wed, 15 Jan 2025 10:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736937130;
	bh=DsNV5Y5jTgosV+mfs0LRtUDuLg4m1DiVUjFO3tqRuPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ulKwubRW9fDN4xqhwFLl6cc1dZHpQ0dgi2WNowxpq30BH+hyl5/7QOlOiVby+nXy8
	 uisDH7zNrChq1ob5cE3lvllPha2FQCL6uKAVxXZU9w0EOR4lTHC1h/Ig0qgD/6IDV8
	 Jqgwwx92sMuihVIr5tffrxdHjHzyhagaAcd4swQk=
Date: Wed, 15 Jan 2025 11:32:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: inv.git-commit@tdk.com
Cc: stable@vger.kernel.org,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 6.6.y] iio: imu: inv_icm42600: fix spi burst write not
 supported
Message-ID: <2025011500-unmixable-duplex-9261@gregkh>
References: <2025011346-empty-yoyo-e301@gregkh>
 <20250113124638.252974-1-inv.git-commit@tdk.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113124638.252974-1-inv.git-commit@tdk.com>

On Mon, Jan 13, 2025 at 12:46:38PM +0000, inv.git-commit@tdk.com wrote:
> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Burst write with SPI is not working for all icm42600 chips. It was
> only used for setting user offsets with regmap_bulk_write.
> 
> Add specific SPI regmap config for using only single write with SPI.
> 
> Fixes: 9f9ff91b775b ("iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> Link: https://patch.msgid.link/20241112-inv-icm42600-fix-spi-burst-write-not-supported-v2-1-97690dc03607@tdk.com
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> (cherry picked from commit c0f866de4ce447bca3191b9cefac60c4b36a7922)
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  1 +
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 15 +++++++++++++++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  |  3 ++-
>  3 files changed, 18 insertions(+), 1 deletion(-)

Did you test build this?

