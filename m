Return-Path: <stable+bounces-73153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D319C96D146
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 10:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60CC5B244E2
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 08:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1731B194A70;
	Thu,  5 Sep 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOXxAEgg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54B3194A65;
	Thu,  5 Sep 2024 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523551; cv=none; b=arfLgFcKZLE+NyaHqn+Et8G/+ndV6n4yg4WnGRU3UWEfewRVHP7Iz7dqTH4Bd7naid5TyEaEBCKj+3Aa1ahjoIMf5pVhSDSQvkqbvKi/lTcX4RQV4ktzWCVssmeS7pZspN42+8GCppfZQpL/Nkg4dscvpLHnnEnnlhrOZoeqvtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523551; c=relaxed/simple;
	bh=7/eXwLNfu5rsbM94H8BJjN5SvAm32E+rFszPUnVBSmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP0TZQFUAFOlRhi7Z0J6hBMU93pmxtt9hBGTkyPmpDkSapgCnTiJjdlZjE5sakyA4BL/0KzDjy6VKj3ZCjwcx3oIk6sGI9wLBYYECvn6iyqDf59AuqThctykGPGttaG4kDusT5mJIJbj/+7Bn95QnvQ8rfUOeCAoxz+fRcf1iAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOXxAEgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BACC4CEC3;
	Thu,  5 Sep 2024 08:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523551;
	bh=7/eXwLNfu5rsbM94H8BJjN5SvAm32E+rFszPUnVBSmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EOXxAEggLUI35DqCxFJvHZgmLdeRE/CaZeJ4VH5z4u8fMjqX5RJKrBfy0UwbwwU6N
	 u7atkbIYYvFJ0k+CBeNU76hTB+Zg1PVo2c82zbd+ALYuEBsonPSKLlu8QsdRPouRcm
	 WWLuUZaGjWyQ7ZV87d7MBFvLARUYdePYFMFpiznK27FhtKBzSR2QKP5OgdX9kRG41D
	 +ReFS1flmdrv8SVV36EYRua5yVksyR6F7AuoSA5aPSTvXqTQ8Ubg2UseIu13utJg3V
	 NGFUujq2Fau0Y/kEPuRE0p70H5E2X3u4luZrzJnjex8jlP2MJbwVhtUqLDtUZrIscR
	 v6W7eF+ylQstA==
Date: Thu, 5 Sep 2024 16:05:43 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: cdnsp: Fix incorrect usb_request status
Message-ID: <20240905080543.GC325295@nchen-desktop>
References: <20240905072541.332095-1-pawell@cadence.com>
 <PH7PR07MB95382F640BC61712E986895BDD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB95382F640BC61712E986895BDD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>

On 24-09-05 07:31:10, Pawel Laszczak wrote:
> Fix changes incorrect usb_request->status returned during disabling
> endpoints. Before fix the status returned during dequeuing requests
> while disabling endpoint was ECONNRESET.
> Patch changes it to ESHUTDOWN.

Would you please explain why we need this change?

Peter

> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: stable@vger.kernel.org
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
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

