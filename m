Return-Path: <stable+bounces-36289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F40FC89B372
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 19:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05F51F211B6
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 17:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130363BBE6;
	Sun,  7 Apr 2024 17:55:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7883BB24;
	Sun,  7 Apr 2024 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712512554; cv=none; b=KWtcWqcriUx8ir4PKRwZfAw2HxK2CC3ncvx1Oe9RVcWWG4hH0FuJUZvkYEzAal8P8NcC7gRHnez/Ar30LMcy/a7vSOhgR4f0AFEA/75zkriFOiIqEUsTqM3RrRznlBdoTzEMqk/HcPuFts/VKDe3CR6VhHdXahczIy9Rz3vyMj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712512554; c=relaxed/simple;
	bh=JTesdcXINXdFVkFqDbF4+Y2kCRj7DafKp2yGFq1fM38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aE0S1Ox90hm0hK7lnXRu35u9joyYDE+LYDhKngGJjOHf+fEMzt+Vi5okUhetClvJDSNBQ0nZvsGBsJH3O8llPWptios+afxs9+3gNjpIXYCB6SbCfuC0VbnEe7wydsmt3HhFPliwiiSt9LNKbgSh+TfksZjJYe+q1lrvoti+46U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id CF52F140186; Sun,  7 Apr 2024 19:55:41 +0200 (CEST)
Date: Sun, 7 Apr 2024 19:55:41 +0200
From: Christian Ehrhardt <lk@c--e.de>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Patch "usb: typec: ucsi: Check for notifications after init" has
 been added to the 6.8-stable tree
Message-ID: <ZhLeHTUM31ZOy9Mr@cae.in-ulm.de>
References: <20240407125341.1022877-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407125341.1022877-1-sashal@kernel.org>


Hi Sasha,

On Sun, Apr 07, 2024 at 08:53:40AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     usb: typec: ucsi: Check for notifications after init
> 
> to the 6.8-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


This patch contains an out of bounds memory access and should not
be included in the stable backports until a fix is available.

A fix is already queued in Greg's usb-linus branch.

Please drop the above patch from all stable trees for now.

Sorry for the inconvenience.

> The filename of the patch is:
>      usb-typec-ucsi-check-for-notifications-after-init.patch
> and it can be found in the queue-6.8 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 903bfed719f3e87b607956bbe4d855c71831a43a
> Author: Christian A. Ehrhardt <lk@c--e.de>
> Date:   Wed Mar 20 08:39:23 2024 +0100
> 
>     usb: typec: ucsi: Check for notifications after init
>     
>     [ Upstream commit 808a8b9e0b87bbc72bcc1f7ddfe5d04746e7ce56 ]
>     
>     The completion notification for the final SET_NOTIFICATION_ENABLE
>     command during initialization can include a connector change
>     notification.  However, at the time this completion notification is
>     processed, the ucsi struct is not ready to handle this notification.
>     As a result the notification is ignored and the controller
>     never sends an interrupt again.
>     
>     Re-check CCI for a pending connector state change after
>     initialization is complete. Adjust the corresponding debug
>     message accordingly.
>     
>     Fixes: 71a1fa0df2a3 ("usb: typec: ucsi: Store the notification mask")
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
>     Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>     Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
>     Link: https://lore.kernel.org/r/20240320073927.1641788-3-lk@c--e.de
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 0bfe5e906e543..96da828f556a9 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -962,7 +962,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num)
>  	struct ucsi_connector *con = &ucsi->connector[num - 1];
>  
>  	if (!(ucsi->ntfy & UCSI_ENABLE_NTFY_CONNECTOR_CHANGE)) {
> -		dev_dbg(ucsi->dev, "Bogus connector change event\n");
> +		dev_dbg(ucsi->dev, "Early connector change event\n");
>  		return;
>  	}
>  
> @@ -1393,6 +1393,7 @@ static int ucsi_init(struct ucsi *ucsi)
>  {
>  	struct ucsi_connector *con, *connector;
>  	u64 command, ntfy;
> +	u32 cci;
>  	int ret;
>  	int i;
>  
> @@ -1445,6 +1446,13 @@ static int ucsi_init(struct ucsi *ucsi)
>  
>  	ucsi->connector = connector;
>  	ucsi->ntfy = ntfy;
> +
> +	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
> +	if (ret)
> +		return ret;
> +	if (UCSI_CCI_CONNECTOR(READ_ONCE(cci)))
> +		ucsi_connector_change(ucsi, cci);
> +
>  	return 0;
>  
>  err_unregister:
> 


Best regards
Christian


