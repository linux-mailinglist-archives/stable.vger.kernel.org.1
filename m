Return-Path: <stable+bounces-50313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99908905A5F
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 20:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22602B20DEB
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 18:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8051822F3;
	Wed, 12 Jun 2024 18:09:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 326A717DE0F
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718215740; cv=none; b=V9p8Rbgv+vbYhFFRWt9DJDBTuBtTvdwJD+ykA5Wz6jUCEq6Xkt7HsuwbHxXoxKxbvYGFOPnHPlZmmZNvFC4S0hSzkiU/YdiOLmVyzex8Kopp690c8/z2BRKn6QEi0XuBQJ8g7tk8EddMmPnoWCnzeJf1WgfQp9nsbqW91Ih6zMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718215740; c=relaxed/simple;
	bh=kJwyERfwNOZD+GZqO0LbVnEX+kZVoxa44FxB3xy8SFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVj99nZIe9CUZnDwegrtQaA/RInJrgAvCkKHGLtYi63H6emjiIVC1qvpcGA5eaij4+Y5Y9EYCF3H94U7hFkrH4H/V6vwQWAX9t11qeoZPLuewVmo7QuJh35mtpa3XGD7JiTqQCJVGHj+JjQneYDHBjqLod06rcaf+6z8P3nvE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 232593 invoked by uid 1000); 12 Jun 2024 14:08:50 -0400
Date: Wed, 12 Jun 2024 14:08:50 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
  linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
  Joao Machado <jocrismachado@gmail.com>,
  Andy Shevchenko <andy.shevchenko@gmail.com>,
  Christian Heusel <christian@heusel.eu>, stable@vger.kernel.org,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] scsi: core: Do not query IO hints for USB devices
Message-ID: <de4492b5-a681-42bf-99d7-e9ba30dabeb2@rowland.harvard.edu>
References: <20240612165249.2671204-1-bvanassche@acm.org>
 <20240612165249.2671204-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612165249.2671204-3-bvanassche@acm.org>

On Wed, Jun 12, 2024 at 09:52:49AM -0700, Bart Van Assche wrote:
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
>  drivers/usb/storage/scsiglue.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
> index b31464740f6c..9a7185c68872 100644
> --- a/drivers/usb/storage/scsiglue.c
> +++ b/drivers/usb/storage/scsiglue.c
> @@ -79,6 +79,8 @@ static int slave_alloc (struct scsi_device *sdev)
>  	if (us->protocol == USB_PR_BULK && us->max_lun > 0)
>  		sdev->sdev_bflags |= BLIST_FORCELUN;
>  
> +	sdev->sdev_bflags |= BLIST_SKIP_IO_HINTS;
> +
>  	return 0;
>  }

You might want to do the same thing in uas.c.  I don't know if UAS 
devices suffer from the same problem, but it wouldn't be surprising if 
they do.

Alan Stern

