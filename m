Return-Path: <stable+bounces-76743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C4E97C682
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 11:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973D9284D53
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 09:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6F5199246;
	Thu, 19 Sep 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CesDA7wB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1621D194C8D;
	Thu, 19 Sep 2024 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736572; cv=none; b=lki5Edm70ijBa+VJL74E8ilvFMBuf6icExKAdVyDLEV4UOexk+NxL8bw/CMO1r1GtQOxn1a1dRbkOYbkm35BZtw5G7B34PwuIGIhNnYmWuinRL3n+IjIjYnoF9HqLvVDryvk8Hkg7pQJm0D54kMcT9nWERBqPbx04275OId4Rws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736572; c=relaxed/simple;
	bh=6HLRjJlhRM4me2Z49OQZVyGYqUmiHotQzHvDOlEVWsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxyKRDzApY5yHq30MjXY/4a0mbOpAsR4Ft2ckBap/aJH7CMo9Kduv/J38wr8nihyVQHeP76O/RJh8O3FG+q1cz/m2dus75HkxF142nFd4Fi3mugPcTOhVbVkaamMwyo+o/zqlCaonxwkfng/jPt+exg/hlwaleFAbT9XjBKLt8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CesDA7wB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F3FC4CEC5;
	Thu, 19 Sep 2024 09:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726736571;
	bh=6HLRjJlhRM4me2Z49OQZVyGYqUmiHotQzHvDOlEVWsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CesDA7wBUH09mO5BJRtrFuL2pNLTqmRTOxVZIlxyl/I/H4RHQGs7ld4ILbBJYpHs9
	 UWAMfZsdQ8siq4tYOEp4v95nliNhvCU9r8YAu8qJhS7Uq77oYGTbwSa+c+9BskoYYr
	 rkFA2RzWsxoDq+ufxv0Etx/GwRvIikVzw9D3B7Ro=
Date: Thu, 19 Sep 2024 10:11:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: heikki.krogerus@linux.intel.com, badhri@google.com, kyletso@google.com,
	rdbabiera@google.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: Fix arg check for
 usb_power_delivery_unregister_capabilities
Message-ID: <2024091956-premiere-given-c496@gregkh>
References: <20240919075815.332017-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919075815.332017-1-amitsd@google.com>

On Thu, Sep 19, 2024 at 12:58:12AM -0700, Amit Sunil Dhamne wrote:
> usb_power_delivery_register_capabilities() returns ERR_PTR in case of
> failure. usb_power_delivery_unregister_capabilities() we only check
> argument ("cap") for NULL. A more robust check would be checking for
> ERR_PTR as well.
> 
> Cc: stable@vger.kernel.org
> Fixes: 662a60102c12 ("usb: typec: Separate USB Power Delivery from USB Type-C")
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/pd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
> index d78c04a421bc..761fe4dddf1b 100644
> --- a/drivers/usb/typec/pd.c
> +++ b/drivers/usb/typec/pd.c
> @@ -519,7 +519,7 @@ EXPORT_SYMBOL_GPL(usb_power_delivery_register_capabilities);
>   */
>  void usb_power_delivery_unregister_capabilities(struct usb_power_delivery_capabilities *cap)
>  {
> -	if (!cap)
> +	if (IS_ERR_OR_NULL(cap))

This feels like there's a wrong caller, why would this be called with an
error value in the first place?  Why not fix that?  And why would this
be called with NULL as well in the first place?

thanks,

greg k-h

