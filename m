Return-Path: <stable+bounces-127333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD8AA77CC8
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 15:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938833AFE6B
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 13:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7E82046A7;
	Tue,  1 Apr 2025 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oKwEO6Pv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C913D1E51E7;
	Tue,  1 Apr 2025 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515452; cv=none; b=Bg1OZYsgRKWZF7EeTyLiPE1rEU66VTGsynTGaQqz7nRWODII3U70Jeh3tRsVDEbR1ZnKEIE39TnTuBJwktVjTGyarZS6toHBrNyZfhM84P/0g6BxBLQuzr+4tJEFJAoXT3VoTDly5EPaZTzGKeXwg8Fdf+LqXXKHbsEFwr2K+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515452; c=relaxed/simple;
	bh=tcKWq9EH3QuriWsMczl+cF4GVPGvlxBbpqMwgXsKe8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TP6kaz/LQRF6yAAU9P43a12AY1EmaaL0R6w5RxBhiV7fleO6Tv5yJpETtvZZ3wv7+WCE9vng5uu3wnQyzW/ip+YwH+77KIIcSvGv46ektJ7xMad4PI7CLwuw/dJD6UHvPks7oW7gBRlNdi8aZvQWfawr2GqArnHCpgY+VPW69/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oKwEO6Pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5125C4CEE4;
	Tue,  1 Apr 2025 13:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743515452;
	bh=tcKWq9EH3QuriWsMczl+cF4GVPGvlxBbpqMwgXsKe8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKwEO6PvQ7s3exAburEZp6UMShJuSUtMjwaCtzyUAlP3LO+4qXHL5/EpsrVlizG8Z
	 9sy46oN4lFDyjchK3/Dv8WqqnwPtlh3b3Wv+dYkqT12T8Kn2+YMubUo+2EIeb3PXDs
	 c37oTmsHttzjgH7M1GFr4Avd+AuCNJoLfeUg4MKA=
Date: Tue, 1 Apr 2025 14:49:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Frode Isaksen <fisaksen@baylibre.com>
Cc: linux-usb@vger.kernel.org, Thinh.Nguyen@synopsys.com,
	krishna.kurapati@oss.qualcomm.com, Frode Isaksen <frode@meta.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: gadget: check that event count does not
 exceed event buffer length
Message-ID: <2025040141-ferret-junior-4549@gregkh>
References: <20250401125350.221910-1-fisaksen@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401125350.221910-1-fisaksen@baylibre.com>

On Tue, Apr 01, 2025 at 02:53:13PM +0200, Frode Isaksen wrote:
> From: Frode Isaksen <frode@meta.com>
> 
> The event count is read from register DWC3_GEVNTCOUNT.
> There is a check for the count being zero, but not for exceeding the
> event buffer length.
> Check that event count does not exceed event buffer length,
> avoiding an out-of-bounds access when memcpy'ing the event.
> Crash log:
> Unable to handle kernel paging request at virtual address ffffffc0129be000
> pc : __memcpy+0x114/0x180
> lr : dwc3_check_event_buf+0xec/0x348
> x3 : 0000000000000030 x2 : 000000000000dfc4
> x1 : ffffffc0129be000 x0 : ffffff87aad60080
> Call trace:
> __memcpy+0x114/0x180
> dwc3_interrupt+0x24/0x34
> 
> Signed-off-by: Frode Isaksen <frode@meta.com>
> Fixes: ebbb2d59398f ("usb: dwc3: gadget: use evt->cache for processing events")
> Cc: stable@vger.kernel.org
> ---
> v1->v2: added error log
> 
>  drivers/usb/dwc3/gadget.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 89a4dc8ebf94..923737776d82 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -4564,6 +4564,12 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
>  	if (!count)
>  		return IRQ_NONE;
>  
> +	if (count > evt->length) {
> +		dev_err(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
> +			count, evt->length);

Is this wise to do in an irq handler?  If the hardware goes crazy, will
this just fill the logs?  Why not rate-limit it?

thanks,

greg k-h

