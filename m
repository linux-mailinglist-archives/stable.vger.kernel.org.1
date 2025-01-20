Return-Path: <stable+bounces-109557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2FEA16F0D
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 16:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52CD1887F5E
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47A01E5705;
	Mon, 20 Jan 2025 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dfv/XI87"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278C1B4F02
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737385964; cv=none; b=bmfzAu3VRLvq/X996TpYGNYArmtExJiAK9ZtJzJZjkBnsk2c2DpwSPH3lN+cKUipdEbJtUPCv/OPNVfV32SG0z4Ih5f7Aym+kSj1odA1U0/mLVie9tB5jKK5T5hJ3uVOOEceewi/KEblHzeMwW+akpk6TEchWtWS+XdIH4xWlgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737385964; c=relaxed/simple;
	bh=QlhSkcAl1M7PmNCAnKIs8xjgzuLF4J/vugDv2A5x/do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXYXLknke+OBLtoXgwYiHxRg+KS4tHJObkiKJB2gimYqHkCXwqdQECCEdpQhJVQwSxRx7qOrXYzpyHFb1yj3vzyTxB7DBKabqrAotxJkxcDcEhVJrzEhrVLAt5ODk/gqec+MplqHIsCFRsfjNiFvSyvFhLBnPVN3FSXzWRv9FUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dfv/XI87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80966C4CEDD;
	Mon, 20 Jan 2025 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737385963;
	bh=QlhSkcAl1M7PmNCAnKIs8xjgzuLF4J/vugDv2A5x/do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dfv/XI87B/t8H6VMAUxA2lcWGbxkWA1NxAHTwg1ROzXnDyk4IKfNfuchYRwwLLFUJ
	 biFawu/X0j7Ja19fnRGHrDzpGM52crYHRp9oaTWcNt8dfKVaYYw6v92QEqj5Gg/y72
	 /+KUaHCBMfdfZMTQB8vIOonSEHcn1iC/g2tHWkZ4=
Date: Mon, 20 Jan 2025 16:12:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: inv.git-commit@tdk.com
Cc: stable@vger.kernel.org,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5.15.y] iio: imu: inv_icm42600: fix spi burst write not
 supported
Message-ID: <2025012012-drearily-bonding-0904@gregkh>
References: <2025011348-amaretto-wasabi-3e96@gregkh>
 <20250113131918.128606-1-inv.git-commit@tdk.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113131918.128606-1-inv.git-commit@tdk.com>

On Mon, Jan 13, 2025 at 01:19:18PM +0000, inv.git-commit@tdk.com wrote:
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
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 12 ++++++++++++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  |  3 ++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> index 995a9dc06521..f5df2e13b063 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -360,6 +360,7 @@ struct inv_icm42600_state {
>  typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
>  
>  extern const struct regmap_config inv_icm42600_regmap_config;
> +extern const struct regmap_config inv_icm42600_spi_regmap_config;
>  extern const struct dev_pm_ops inv_icm42600_pm_ops;
>  
>  const struct iio_mount_matrix *
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> index ca85fccc9839..a562d7476955 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -43,6 +43,18 @@ const struct regmap_config inv_icm42600_regmap_config = {
>  };
>  EXPORT_SYMBOL_GPL(inv_icm42600_regmap_config);
>  
> +/* define specific regmap for SPI not supporting burst write */
> +const struct regmap_config inv_icm42600_spi_regmap_config = {
> +	.name = "inv_icm42600",

Why does just this one have the .name field set?

I've taken the backports you did for the other branches here, if you
really need .name set please let me know.

thanks,

greg k-h

