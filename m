Return-Path: <stable+bounces-37784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383D389C9CB
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 18:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B65C1C23C82
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A136E143894;
	Mon,  8 Apr 2024 16:36:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93AA1428F3
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594173; cv=none; b=lLvk9e29oOtJtpDSoGsTjLNt/6jtliYXOu8b9C9y1aozseU4c4ggJnK21WnrGQk/fYmkJjzuxF7PA6a4JAN0H7CDZ8WT1qK16H61rV2exR7+3zerFe1pZzLcOPpHUJncPey2La8YE2iOJQu1ywJG8rom+HCOwXaRuQT62QM/YuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594173; c=relaxed/simple;
	bh=CWWNwMNgAzKNmYdnyVzGseCF66ItLiQl0/7FAOyNL/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIywTSsv2SV6xQiLp4qb0fn1G4bQnfND6xChXeuS4WLNsK77L+9TwrVTVNRMSck7FeMgwJaraBA7sECGV4F4xgzwNjd7PbDquoUvpdGIp6YyVXmuw28i3N8mbhnJ362CBEunJN2vAp8svGF4bXzRXnySEH1npz9BaW3CqhTZ1JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 8FDE814055D; Mon,  8 Apr 2024 18:36:08 +0200 (CEST)
Date: Mon, 8 Apr 2024 18:36:08 +0200
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 6.8 131/273] usb: typec: ucsi: Check for notifications
 after init
Message-ID: <ZhQc+AoLGkrJB1to@cae.in-ulm.de>
References: <20240408125309.280181634@linuxfoundation.org>
 <20240408125313.358936582@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408125313.358936582@linuxfoundation.org>


Hi Greg,

On Mon, Apr 08, 2024 at 02:56:46PM +0200, Greg Kroah-Hartman wrote:
> 6.8-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Christian A. Ehrhardt <lk@c--e.de>
> 
> [ Upstream commit 808a8b9e0b87bbc72bcc1f7ddfe5d04746e7ce56 ]
> 
> The completion notification for the final SET_NOTIFICATION_ENABLE
> command during initialization can include a connector change
> notification.  However, at the time this completion notification is
> processed, the ucsi struct is not ready to handle this notification.
> As a result the notification is ignored and the controller
> never sends an interrupt again.
> 
> Re-check CCI for a pending connector state change after
> initialization is complete. Adjust the corresponding debug
> message accordingly.

As discussed previously, this one should not go into the stable
trees without the follow up fix that is in you usb-linus tree but
not yet in mainline. This applies to all stable branches. Let me
know if you want a separate mail for each branch.

Thanks
Christian

> Fixes: 71a1fa0df2a3 ("usb: typec: ucsi: Store the notification mask")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
> Link: https://lore.kernel.org/r/20240320073927.1641788-3-lk@c--e.de
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
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
> -- 
> 2.43.0
> 
> 
> 
> 

