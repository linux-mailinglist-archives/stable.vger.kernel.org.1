Return-Path: <stable+bounces-73694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0F096E722
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 03:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121B51F24667
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 01:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5AE17BA3;
	Fri,  6 Sep 2024 01:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhLx8kpE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671181DFCF;
	Fri,  6 Sep 2024 01:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725585153; cv=none; b=Fp6DVspP4wjvy7Q1vTPer3IIcDL/dv3fjQj5LYxaLnSv2H3yU39k1IRkee2t7D1wqurSFZizUbOWBjhDnF9hiz8ELQhX6TsqWrNylpycYUu2Y51EkplIhuYSBT/qk+1TgVIBZGYQt6YHYFzq5b8+T5k6IrgOt0ldrABPv0xt2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725585153; c=relaxed/simple;
	bh=tajvxvjnOiEA5fsVw+UnLHqK+urb541csY0X9cR0iU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U97eDd7VeREYbjlf3QsNzWxu853O+yr6S3xMDY1k0ulqdEkDRl+vrYTXqNMklPLSdCgDSsqD5Hpmsry+h7DB19FIise9vTvjRLNg0oFjFn+Yo9oYWTNrK063F82OKwA0W7KpELWQBNqi6UH28DK16CERVduQ3FJia4ERWl2aYQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhLx8kpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C353CC4CEC3;
	Fri,  6 Sep 2024 01:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725585153;
	bh=tajvxvjnOiEA5fsVw+UnLHqK+urb541csY0X9cR0iU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NhLx8kpEp0nenjDFHDZlrvUdZU6o6yg/H7umqYZhpaoC+4iMaksv4tCI4vuArh2Ud
	 78J8Dt70gIbURuImyRfVnurlEcz1gOz2XpPIGMpxmpIrfxKe24R+mo+BUQr3y0XZhB
	 Hc4AsqZpmS8g8KdYqTuRhimz7GPcOoKzxarmTBfUChG9MTFQ7ezbZrh8oDGFF/USMx
	 S1OmKWYuigqBtRvoHQoYob1c3rvxnyeK67A8c55YYmcmKdU+UxCCtqxQeFe/Jmsevr
	 YYMUfT/UdVDQ4cPx/POof04qctPRl8DIoJz0XLxYI5p01HcG3BhAPc3i2R9Oray+eB
	 EsvIDfQvUnVQQ==
Date: Fri, 6 Sep 2024 09:12:24 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: cdnsp: Fix incorrect usb_request status
Message-ID: <20240906011224.GA357232@nchen-desktop>
References: <20240905072541.332095-1-pawell@cadence.com>
 <PH7PR07MB95382F640BC61712E986895BDD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <20240905080543.GC325295@nchen-desktop>
 <PH7PR07MB95383CF665431DBDACD73B65DD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB95383CF665431DBDACD73B65DD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>

On 24-09-05 08:45:59, Pawel Laszczak wrote:
> >
> >On 24-09-05 07:31:10, Pawel Laszczak wrote:
> >> Fix changes incorrect usb_request->status returned during disabling
> >> endpoints. Before fix the status returned during dequeuing requests
> >> while disabling endpoint was ECONNRESET.
> >> Patch changes it to ESHUTDOWN.
> >
> >Would you please explain why we need this change?
> 
> This patch is needed for UVC gadget. 
> During stopping streaming the class starts dequeuing usb requests and
> controller driver returns the -ECONNRESET status. After completion
> requests the class or application "uvc-gadget" try to queue this
> request again. Changing this status to ESHUTDOWN cause that UVC
> assume that endpoint is disabled, or device is disconnected and
> stop re-queuing usb requests.
> 

Get it. Would you please update commit message with your above
explanation?

Peter

> >
> >>
> >> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
> >> USBSSP DRD Driver")
> >> cc: stable@vger.kernel.org
> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >> ---
> >>  drivers/usb/cdns3/cdnsp-ring.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/usb/cdns3/cdnsp-ring.c
> >> b/drivers/usb/cdns3/cdnsp-ring.c index 1e011560e3ae..bccc8fc143d0
> >> 100644
> >> --- a/drivers/usb/cdns3/cdnsp-ring.c
> >> +++ b/drivers/usb/cdns3/cdnsp-ring.c
> >> @@ -718,7 +718,8 @@ int cdnsp_remove_request(struct cdnsp_device
> >*pdev,
> >>  	seg = cdnsp_trb_in_td(pdev, cur_td->start_seg, cur_td->first_trb,
> >>  			      cur_td->last_trb, hw_deq);
> >>
> >> -	if (seg && (pep->ep_state & EP_ENABLED))
> >> +	if (seg && (pep->ep_state & EP_ENABLED) &&
> >> +	    !(pep->ep_state & EP_DIS_IN_RROGRESS))
> >>  		cdnsp_find_new_dequeue_state(pdev, pep, preq-
> >>request.stream_id,
> >>  					     cur_td, &deq_state);
> >>  	else
> >> @@ -736,7 +737,8 @@ int cdnsp_remove_request(struct cdnsp_device
> >*pdev,
> >>  	 * During disconnecting all endpoint will be disabled so we don't
> >>  	 * have to worry about updating dequeue pointer.
> >>  	 */
> >> -	if (pdev->cdnsp_state & CDNSP_STATE_DISCONNECT_PENDING) {
> >> +	if (pdev->cdnsp_state & CDNSP_STATE_DISCONNECT_PENDING ||
> >> +	    pep->ep_state & EP_DIS_IN_RROGRESS) {
> >>  		status = -ESHUTDOWN;
> >>  		ret = cdnsp_cmd_set_deq(pdev, pep, &deq_state);
> >>  	}
> >> --
> >> 2.43.0
> >>

