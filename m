Return-Path: <stable+bounces-69790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0768F9599C9
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 13:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398581C22316
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 11:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15081A2843;
	Wed, 21 Aug 2024 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBS+qe2/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658E8192586;
	Wed, 21 Aug 2024 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724235815; cv=none; b=MTT4GEtGkp0hJW8zlV8Y82P1ywX4f/F1v0I7FBsoUOWfSPbaPCQrpot4vUyWS/x/7q1nwHAbKG84jD79mo6YfNSMrTN/IMomogd4rytJV+/qzcfUpj3C4cOdekCCB5imuvkpIdD5jD+AkhMrYn1fWaGeyih5OPuOMXi0AoC2u8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724235815; c=relaxed/simple;
	bh=R7Wk+KHX3a2v3iZYSMo0dYb/TN9g9mj0aDx7OmJAdMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irw0280rGLE1zOUPueeSnavw4lYPumj5IR8QH3ZvfyDPSR3ZtD2lJo4tclD9QqL8luh79NSHq1HiZRrbqXi3+7hkzEmvn+R9/FN2S4S9WgQdy+o20ajFrshcnbzP2KBLWsJOYStPNxcpGkaKFZ+E7l7aH3HUWroPCwRhqASK0p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBS+qe2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8C2C4AF0C;
	Wed, 21 Aug 2024 10:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724235814;
	bh=R7Wk+KHX3a2v3iZYSMo0dYb/TN9g9mj0aDx7OmJAdMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBS+qe2/UrAq6dMUDPUkuO5iGxVT33i9db1qF6HugDVPbGXawJfm0sKfsXi1M+0uM
	 WMItTfLKk+lZtGLrkxsgL+KtlE1H7zmVLxIOKpGLKFVDhY1Op7yRvDu0cKNU1maEWp
	 KxYmcrehizxM0nbQ1BOkkuRv2gXgPP4GmuqVs0McwXznRh7fEB1vLsqBUI9mKX/BuN
	 4SQi/932pDCGOP83ysrWNcOl2/qBDq7Yd62zhpGnvZw7jEwdnLn5wZO6H92RSeYz5+
	 qK1O1VX4OlihDyxf61RNtmp5fIgc/xgUyzLWRWyb5F4pshIXzYucPYKeZJBsZFy6ds
	 g6zMvVb09ND8Q==
Date: Wed, 21 Aug 2024 18:23:26 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: cdnsp: fix incorrect index in cdnsp_get_hw_deq
 function
Message-ID: <20240821102326.GA652432@nchen-desktop>
References: <20240820075951.191176-1-pawell@cadence.com>
 <PH7PR07MB95381F2182688811D5C711CEDD8D2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB95381F2182688811D5C711CEDD8D2@PH7PR07MB9538.namprd07.prod.outlook.com>

On 24-08-20 08:21:19, Pawel Laszczak wrote:
> Patch fixes the incorrect "stream_id" table index instead of
> "ep_index" used in cdnsp_get_hw_deq function.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: <stable@vger.kernel.org>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/cdnsp-ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
> index 75724e60653c..e0e97a138666 100644
> --- a/drivers/usb/cdns3/cdnsp-ring.c
> +++ b/drivers/usb/cdns3/cdnsp-ring.c
> @@ -402,7 +402,7 @@ static u64 cdnsp_get_hw_deq(struct cdnsp_device *pdev,
>  	struct cdnsp_stream_ctx *st_ctx;
>  	struct cdnsp_ep *pep;
>  
> -	pep = &pdev->eps[stream_id];
> +	pep = &pdev->eps[ep_index];
>  
>  	if (pep->ep_state & EP_HAS_STREAMS) {
>  		st_ctx = &pep->stream_info.stream_ctx_array[stream_id];
> -- 
> 2.43.0
> 

Reviewed-by: Peter Chen <peter.chen@kernel.org>

Peter

