Return-Path: <stable+bounces-196487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C34C7A1C8
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D4D6628A27
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F278B34D4DB;
	Fri, 21 Nov 2025 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O7tUaikd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DED33CEAC;
	Fri, 21 Nov 2025 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734720; cv=none; b=PSVJQJU49d2ZOM/y+SO0x+BKeuWORAVUBJiQk0KcS/YPlpZjv6H2Rw6YtAAbF+4zAor+w1VFBqsiiQ737ZEObPhxA3hWErfEi90Pm4Grw2AjQx+rIW0LSOy6YWXUvHj4AiM7rzGa0xj1lN/w0XSch1c8qMdg93zY6J9ji3Q1CMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734720; c=relaxed/simple;
	bh=VkEqqNi9ARSCs/POUxakTo0knEY5XxygD1qU145lOoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIJAfy+P+ZAvZRVv4I2bUt/zed+sAYI4b/PZQ/8Nt6fD8u+PcsmAZX0DPSc4zNEz6wle3Ft7O0a24k2Ez64UunEod/9nvgY9AzkTdwwts54JBUzU2NWSyBVj2LaLhcsnMnLeeXF9lAFbQ6KDEEkHp0YjNZ5SBxUqHa41Z3UpaxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O7tUaikd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE965C116C6;
	Fri, 21 Nov 2025 14:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763734720;
	bh=VkEqqNi9ARSCs/POUxakTo0knEY5XxygD1qU145lOoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7tUaikdB6BfBOBZesmIXzby5jXNpAUlxyplLjiLP6TYPXekt2qioRyqdE4NSFjXZ
	 dywmGijw7Ji67AAxCEkGeT789vUYdMGJL6z76W3Qs1uhI2G0TL537RGrY9vuE5t6xN
	 WM4M6LcJIKULCcV1P8wbTM4DiXPeubSmG10WPi1c=
Date: Fri, 21 Nov 2025 15:09:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: phy: Initialize struct usb_phy list_head
Message-ID: <2025112139-resale-upward-3366@gregkh>
References: <20251113-diogo-smaug_typec-v1-1-f1aa3b48620d@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113-diogo-smaug_typec-v1-1-f1aa3b48620d@tecnico.ulisboa.pt>

On Thu, Nov 13, 2025 at 02:59:06PM +0000, Diogo Ivo wrote:
> When executing usb_add_phy() and usb_add_phy_dev() it is possible that
> usb_add_extcon() fails (for example with -EPROBE_DEFER), in which case
> the usb_phy does not get added to phy_list via
> list_add_tail(&x->head, phy_list).
> 
> Then, when the driver that tried to add the phy receives the error
> propagated from usb_add_extcon() and calls into usb_remove_phy() to
> undo the partial registration there will be an unconditional call to
> list_del(&x->head) which is notinitialized and leads to a NULL pointer
> dereference.
> 
> Fix this by initializing x->head before usb_add_extcon() has a chance to
> fail.
> 
> Fixes: 7d21114dc6a2d53 ("usb: phy: Introduce one extcon device into usb phy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
> ---
>  drivers/usb/phy/phy.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
> index e1435bc59662..5a9b9353f343 100644
> --- a/drivers/usb/phy/phy.c
> +++ b/drivers/usb/phy/phy.c
> @@ -646,6 +646,8 @@ int usb_add_phy(struct usb_phy *x, enum usb_phy_type type)
>  		return -EINVAL;
>  	}
>  
> +	INIT_LIST_HEAD(&x->head);
> +
>  	usb_charger_init(x);
>  	ret = usb_add_extcon(x);
>  	if (ret)
> @@ -696,6 +698,8 @@ int usb_add_phy_dev(struct usb_phy *x)
>  		return -EINVAL;
>  	}
>  
> +	INIT_LIST_HEAD(&x->head);
> +
>  	usb_charger_init(x);
>  	ret = usb_add_extcon(x);
>  	if (ret)
> 

Shouldn't you be also removing an existing call to INIT_LIST_HEAD()
somewhere?  This is not "moving" the code, it is adding it.

thanks,

greg k-h

