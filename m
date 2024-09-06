Return-Path: <stable+bounces-73706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C34C96ED24
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C753F1F22279
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA24157495;
	Fri,  6 Sep 2024 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdWV2Y/j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA4F208A0;
	Fri,  6 Sep 2024 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610000; cv=none; b=NpqMsCdP6NkrsQSZJMdK16h0VyzoD2yufPk84PikkoIxj7xqs090q+yZJq+DZHwXrKW+MLEv1lmYeai/iNSMzinBuXNVOmFrNV2U6GzbJGPncIcqPukZcWYIvbCC+EqGXv2UJ9EzF2COV/WGdw5HKXwD0/8srTmcG5nJkTpx0iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610000; c=relaxed/simple;
	bh=mxkUdqDQRDmpXkwejmdT8UroiLSt811uYfUtusdSIB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEfxNncqANRbRo413zCX3KeU7nN9CMlnafEECAoASDs2IVNhVZ7wUy+hsnb8sa+2IgMN2OCRJHtvfsQo89Zx5qxodv/SRaSxgskS0ic3PxxL1hkrnjR6hGy4NiyDwisiDGMTjm/QnP/lv9dppxSxEyTyyjQhw73MB3xysNkfML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdWV2Y/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595EAC4CEC4;
	Fri,  6 Sep 2024 08:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725610000;
	bh=mxkUdqDQRDmpXkwejmdT8UroiLSt811uYfUtusdSIB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OdWV2Y/jxvc0Rhuhcj88TeO6xoDap9rxV/WAUVHTaYXYfkMC4hjoW9dByfSS4F9mu
	 um/1E1ZHYggJ+wguuWHlw/OADJR4dOcgIN35YJKoyl9vaF8TSq5zVkUCWtV/V8pIpH
	 Yb2lH09pG1ugIOth+CSALWZte1d6p+xfRLKX27wKXBhj7NrdQNWDo+MYmqBnage7HX
	 w87jfrWWa+2yf/ksgk5L6g40YkK6GSCHIQP9nmdSe9hoA/YG5P52Gyyz6ekrKmjcot
	 f4cv4i1xPPKkndcwJbestgbACNHyAr1Pf3wRjrK2IImQYZPuznJV+i1WWqIb8KMjgH
	 vvyj4Le5/9gKg==
Date: Fri, 6 Sep 2024 16:06:32 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: cdnsp: Fix incorrect usb_request status
Message-ID: <20240906080632.GA389470@nchen-desktop>
References: <20240906064547.265943-1-pawell@cadence.com>
 <PH7PR07MB9538E8CA7A2096AAF6A3718FDD9E2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB9538E8CA7A2096AAF6A3718FDD9E2@PH7PR07MB9538.namprd07.prod.outlook.com>

On 24-09-06 06:48:54, Pawel Laszczak wrote:
> Fix changes incorrect usb_request->status returned during disabling
> endpoints. Before fix the status returned during dequeuing requests
> while disabling endpoint was ECONNRESET.
> Patch change it to ESHUTDOWN.
> 
> Patch fixes issue detected during testing UVC gadget.
> During stopping streaming the class starts dequeuing usb requests and
> controller driver returns the -ECONNRESET status. After completion
> requests the class or application "uvc-gadget" try to queue this
> request again. Changing this status to ESHUTDOWN cause that UVC assumes
> that endpoint is disabled, or device is disconnected and stops
> re-queuing usb requests.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: stable@vger.kernel.org
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Reviewed-by: Peter Chen <peter.chen@kernel.org>

Peter
> 
> ---
> Changelog:
> v2:
> - added explanation of issue
> 
>  drivers/usb/cdns3/cdnsp-ring.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
> index 1e011560e3ae..bccc8fc143d0 100644
> --- a/drivers/usb/cdns3/cdnsp-ring.c
> +++ b/drivers/usb/cdns3/cdnsp-ring.c
> @@ -718,7 +718,8 @@ int cdnsp_remove_request(struct cdnsp_device *pdev,
>  	seg = cdnsp_trb_in_td(pdev, cur_td->start_seg, cur_td->first_trb,
>  			      cur_td->last_trb, hw_deq);
>  
> -	if (seg && (pep->ep_state & EP_ENABLED))
> +	if (seg && (pep->ep_state & EP_ENABLED) &&
> +	    !(pep->ep_state & EP_DIS_IN_RROGRESS))
>  		cdnsp_find_new_dequeue_state(pdev, pep, preq->request.stream_id,
>  					     cur_td, &deq_state);
>  	else
> @@ -736,7 +737,8 @@ int cdnsp_remove_request(struct cdnsp_device *pdev,
>  	 * During disconnecting all endpoint will be disabled so we don't
>  	 * have to worry about updating dequeue pointer.
>  	 */
> -	if (pdev->cdnsp_state & CDNSP_STATE_DISCONNECT_PENDING) {
> +	if (pdev->cdnsp_state & CDNSP_STATE_DISCONNECT_PENDING ||
> +	    pep->ep_state & EP_DIS_IN_RROGRESS) {
>  		status = -ESHUTDOWN;
>  		ret = cdnsp_cmd_set_deq(pdev, pep, &deq_state);
>  	}
> -- 
> 2.43.0
> 

