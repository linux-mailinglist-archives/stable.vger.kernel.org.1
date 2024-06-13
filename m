Return-Path: <stable+bounces-50384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF29906062
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 03:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D44B1F22407
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 01:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C70B664;
	Thu, 13 Jun 2024 01:25:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A5D99B674
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718241919; cv=none; b=Gq8jzaHfKJ2tizYYr9o3T8Wi1wd2ozNk6a1uB32BH+SqApT9aLMTZACv5lqlWDJfSkZFRU0NKUjaUERWXBkmgczXy+qH5tmVRdb7KG7DcKRpfKoAvvXwzvto7DIErzfx8HyAhIlt4r/eagIrJEZIvswHuOP1ipwIiBZGev766rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718241919; c=relaxed/simple;
	bh=Dy43Ep+dfiP1wMhLybaOZNggtqTx58gNGri+jBBfQ1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJHFG2cwdvL4/By/gGM2CuvZJ25NQkA+8u53pnyjZkFrsxQIiXFksQ7cQ08obipLjz2KG6Hh0s2io4T4Ol8DhGhT3oYW0/6LH1OpdVF7FXLydQoHoI8KqAbKFekMXy7nN7gzbiewRGGaBp9RmfJPJpkpPbwrE47UMqKWF/PDV9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 244126 invoked by uid 1000); 12 Jun 2024 21:25:15 -0400
Date: Wed, 12 Jun 2024 21:25:15 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
  linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
  Joao Machado <jocrismachado@gmail.com>,
  Andy Shevchenko <andy.shevchenko@gmail.com>,
  Christian Heusel <christian@heusel.eu>, stable@vger.kernel.org,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH v2 2/2] scsi: core: Do not query IO hints for USB devices
Message-ID: <5c873978-47d7-4409-82fc-d4f3841b5069@rowland.harvard.edu>
References: <20240612203735.4108690-1-bvanassche@acm.org>
 <20240612203735.4108690-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612203735.4108690-4-bvanassche@acm.org>

On Wed, Jun 12, 2024 at 01:37:34PM -0700, Bart Van Assche wrote:
> Recently it was reported that the following USB storage devices are unusable
> with Linux kernel 6.9:
> * Kingston DataTraveler G2
> * Garmin FR35
> 
> This is because attempting to read the IO hint VPD page causes these devices
> to reset. Hence do not read the IO hint VPD page from USB storage devices.
> 
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb@vger.kernel.org
> Cc: Joao Machado <jocrismachado@gmail.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Christian Heusel <christian@heusel.eu>
> Cc: stable@vger.kernel.org
> Fixes: 4f53138fffc2 ("scsi: sd: Translate data lifetime information")
> Reported-by: Joao Machado <jocrismachado@gmail.com>
> Closes: https://lore.kernel.org/linux-scsi/20240130214911.1863909-1-bvanassche@acm.org/T/#mf4e3410d8f210454d7e4c3d1fb5c0f41e651b85f
> Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Bisected-by: Christian Heusel <christian@heusel.eu>
> Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Closes: https://lore.kernel.org/linux-scsi/CACLx9VdpUanftfPo2jVAqXdcWe8Y43MsDeZmMPooTzVaVJAh2w@mail.gmail.com/
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/storage/scsiglue.c | 6 ++++++
>  drivers/usb/storage/uas.c      | 7 +++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
> index b31464740f6c..b4cf0349fd0d 100644
> --- a/drivers/usb/storage/scsiglue.c
> +++ b/drivers/usb/storage/scsiglue.c
> @@ -79,6 +79,12 @@ static int slave_alloc (struct scsi_device *sdev)
>  	if (us->protocol == USB_PR_BULK && us->max_lun > 0)
>  		sdev->sdev_bflags |= BLIST_FORCELUN;
>  
> +	/*
> +	 * Some USB storage devices reset if the IO hints VPD page is queried.
> +	 * Hence skip that VPD page.
> +	 */
> +	sdev->sdev_bflags |= BLIST_SKIP_IO_HINTS;
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
> index a48870a87a29..77fdfb6a90c8 100644
> --- a/drivers/usb/storage/uas.c
> +++ b/drivers/usb/storage/uas.c
> @@ -21,6 +21,7 @@
>  #include <scsi/scsi.h>
>  #include <scsi/scsi_eh.h>
>  #include <scsi/scsi_dbg.h>
> +#include <scsi/scsi_devinfo.h>
>  #include <scsi/scsi_cmnd.h>
>  #include <scsi/scsi_device.h>
>  #include <scsi/scsi_host.h>
> @@ -820,6 +821,12 @@ static int uas_slave_alloc(struct scsi_device *sdev)
>  	struct uas_dev_info *devinfo =
>  		(struct uas_dev_info *)sdev->host->hostdata;
>  
> +	/*
> +	 * Some USB storage devices reset if the IO hints VPD page is queried.
> +	 * Hence skip that VPD page.
> +	 */
> +	sdev->sdev_bflags |= BLIST_SKIP_IO_HINTS;
> +
>  	sdev->hostdata = devinfo;
>  	return 0;
>  }

