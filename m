Return-Path: <stable+bounces-152757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA345ADC514
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 10:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47EA11893D4A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 08:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D611228F51A;
	Tue, 17 Jun 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9L/oFFW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983B1DE3DC;
	Tue, 17 Jun 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149222; cv=none; b=tyKWQkYxgHnoALqtRKjaKYzaFb9XsARq34Ya3/PFbyr4NYzxfmu2BgWPnFEWT+vF94yWE7uWFTo4ZL2HLfgyj4UgrR5sv3KBseLknG8O2aD0yeeecq9rQ9WOyWLh5lz8Ldu25bbgwNcqJNmgNNabXft3/4Oe6rUOauPficpkEBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149222; c=relaxed/simple;
	bh=m+8n+ffzJd8l66Jfjz0sF6qoqRZzq+G/9rK+epTI7eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmWVhXyGu72MsCE5COiQJckraL2JGUGTCGOsCpNVSZSQrYFAynEQDzoU6Z85OJyPIoi4erxrs0iPghxC3eehvlSx3HPFhrp4kXTiy1tW2wwSZsOzHu3AHYt/ThzrpBb50CT869kqlIm9lK3PVY8GE3XKMYWVqRV/tEGucAVxo/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9L/oFFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ABBC4CEE3;
	Tue, 17 Jun 2025 08:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149222;
	bh=m+8n+ffzJd8l66Jfjz0sF6qoqRZzq+G/9rK+epTI7eY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P9L/oFFW8YoxSHlypTtC+3V7rn4DKoCckU5vZfuR0t8yEr15sgPD+yHTK1brHcXh4
	 vLq1NJ7Mq85O+DKEqOj/SibGhDt29q2Eo7+MZrCQnMhD+t1Hn8j2dHTQU6LfbiuiI6
	 YNryJ4LSnMwQOyojT23EIKIv8PksqBFYE6SbYwyUxUCFUzABaEnIevjjSC5DSC5zs+
	 w/8XR7RpntPVW4e1jHohM07ZjnjSi3AdgzEIHpYNA/yArsngClzegwE+oj58S2J++J
	 8yG96lGgA9Jnvp0gjOxymvaBuofbrQlID5DyIWtMl4gBESYmRSuNtNxhhZXA8jxocA
	 po9WUij+bkzNw==
Date: Tue, 17 Jun 2025 16:33:35 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: cdnsp: Fix issue with CV Bad Descriptor test
Message-ID: <20250617083335.GC1716298@nchen-desktop>
References: <20250617071045.128040-1-pawell@cadence.com>
 <PH7PR07MB95388A30AE3E50D42E0592CADD73A@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB95388A30AE3E50D42E0592CADD73A@PH7PR07MB9538.namprd07.prod.outlook.com>

On 25-06-17 07:15:06, Pawel Laszczak wrote:
> The SSP2 controller has extra endpoint state preserve bit (ESP) which
> setting causes that endpoint state will be preserved during
> Halt Endpoint command. It is used only for EP0.
> Without this bit the Command Verifier "TD 9.10 Bad Descriptor Test"
> failed.
> Setting this bit doesn't have any impact for SSP controller.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: stable@vger.kernel.org
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/cdnsp-debug.h  |  5 +++--
>  drivers/usb/cdns3/cdnsp-ep0.c    | 17 ++++++++++++++---
>  drivers/usb/cdns3/cdnsp-gadget.h |  3 +++
>  drivers/usb/cdns3/cdnsp-ring.c   |  3 ++-
>  4 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debug.h
> index cd138acdcce1..86860686d836 100644
> --- a/drivers/usb/cdns3/cdnsp-debug.h
> +++ b/drivers/usb/cdns3/cdnsp-debug.h
> @@ -327,12 +327,13 @@ static inline const char *cdnsp_decode_trb(char *str, size_t size, u32 field0,
>  	case TRB_RESET_EP:
>  	case TRB_HALT_ENDPOINT:
>  		ret = scnprintf(str, size,
> -				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
> +				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c %c",
>  				cdnsp_trb_type_string(type),
>  				ep_num, ep_id % 2 ? "out" : "in",
>  				TRB_TO_EP_INDEX(field3), field1, field0,
>  				TRB_TO_SLOT_ID(field3),
> -				field3 & TRB_CYCLE ? 'C' : 'c');
> +				field3 & TRB_CYCLE ? 'C' : 'c',
> +				field3 & TRB_ESP ? 'P' : 'p');
>  		break;
>  	case TRB_STOP_RING:
>  		ret = scnprintf(str, size,
> diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-ep0.c
> index f317d3c84781..567ccfdecded 100644
> --- a/drivers/usb/cdns3/cdnsp-ep0.c
> +++ b/drivers/usb/cdns3/cdnsp-ep0.c
> @@ -414,6 +414,7 @@ static int cdnsp_ep0_std_request(struct cdnsp_device *pdev,
>  void cdnsp_setup_analyze(struct cdnsp_device *pdev)
>  {
>  	struct usb_ctrlrequest *ctrl = &pdev->setup;
> +	struct cdnsp_ep *pep;
>  	int ret = -EINVAL;
>  	u16 len;
>  
> @@ -428,9 +429,19 @@ void cdnsp_setup_analyze(struct cdnsp_device *pdev)
>  	}
>  
>  	/* Restore the ep0 to Stopped/Running state. */
> -	if (pdev->eps[0].ep_state & EP_HALTED) {
> -		trace_cdnsp_ep0_halted("Restore to normal state");
> -		cdnsp_halt_endpoint(pdev, &pdev->eps[0], 0);
> +	if (pep->ep_state & EP_HALTED) {
> +		/*
> +		 * Halt Endpoint Command for SSP2 for ep0 preserve current
> +		 * endpoint state and driver has to synchronise the

%s/synchronise/synchronize

> +		 * software endpointp state with endpoint output context

%s/endpointp/endpoint

> +		 * state.
> +		 */
> +		if (GET_EP_CTX_STATE(pep->out_ctx) == EP_STATE_HALTED) {
> +			cdnsp_halt_endpoint(pdev, pep, 0);
> +		} else {
> +			pep->ep_state &= ~EP_HALTED;
> +			pep->ep_state |= EP_STOPPED;
> +		}
>  	}
>  
>  	/*
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
> index 2afa3e558f85..c26abef6e1c9 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.h
> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
> @@ -987,6 +987,9 @@ enum cdnsp_setup_dev {
>  #define STREAM_ID_FOR_TRB(p)		((((p)) << 16) & GENMASK(31, 16))
>  #define SCT_FOR_TRB(p)			(((p) << 1) & 0x7)
>  
> +/* Halt Endpoint Command TRB field. */
> +#define TRB_ESP				BIT(9)
> +

Please add comment it is specific for SSP2.

Peter

>  /* Link TRB specific fields. */
>  #define TRB_TC				BIT(1)
>  
> diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
> index fd06cb85c4ea..d397d28efc6e 100644
> --- a/drivers/usb/cdns3/cdnsp-ring.c
> +++ b/drivers/usb/cdns3/cdnsp-ring.c
> @@ -2483,7 +2483,8 @@ void cdnsp_queue_halt_endpoint(struct cdnsp_device *pdev, unsigned int ep_index)
>  {
>  	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(TRB_HALT_ENDPOINT) |
>  			    SLOT_ID_FOR_TRB(pdev->slot_id) |
> -			    EP_ID_FOR_TRB(ep_index));
> +			    EP_ID_FOR_TRB(ep_index) |
> +			    (!ep_index ? TRB_ESP : 0));
>  }
>  
>  void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int intf_num)
> -- 
> 2.43.0
> 

-- 

Best regards,
Peter

