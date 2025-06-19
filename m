Return-Path: <stable+bounces-154721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601D1ADFB33
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 04:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0AB11BC0B9C
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 02:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBAA21ABD5;
	Thu, 19 Jun 2025 02:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYXTEdHJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5919D07B;
	Thu, 19 Jun 2025 02:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750300041; cv=none; b=L5Yn+PKX/7xH6V13gWamsKT19Eq2FAv/C/r0bJaBVUHCbIg7qW0HwVYo7XTdwCGl2dwcAtdsJ9ki1LyUXjbTIKBhhb8xBUNafsjuevJUTluBYrm4skDUaUMTLeG6FYM4aRl63/fr1i5mida+YIgfPWiYqDvFbHiLmMtY/lVZiZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750300041; c=relaxed/simple;
	bh=1x7x4NWqMUt2c8JTKHmXWQofJ+8/NIysaVeljVLRocQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ22fsmSgbmyvoe5EjDBlwKtlBTMNNku+QOMSnYlywRSGK6+X1K2TNnWNUnrhi2jbdghRfr1ZPwlHLJiW+agLwwhi8mvxyWkwM4p6Y4inYCEVDgwP917GWCG2IljmFj6mqrcQlbBW4Z4KMrCHNRv0CKMBSURrGz9435/ogQYs8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYXTEdHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3CDC4CEE7;
	Thu, 19 Jun 2025 02:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750300040;
	bh=1x7x4NWqMUt2c8JTKHmXWQofJ+8/NIysaVeljVLRocQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYXTEdHJ7KSSK/VxDAfnvEujP1pjhGWb3+Fum4qYew0QVzvy++7E67hZhAwWqVSOP
	 H6LiX5jLnYmfLOgTITdkW+0UVU4VQklZqvViL+aK0oVGhiwhUbn4jJ5WrEJwgiMhAt
	 x5aJ8BIB12pRgf1SKbgcxCw+7AxQQZvHu6txa0mVEdXphKrpfhC2WB7kcPpUEJ4593
	 D9Lnl6tYR9MWVNG61DTqiMAHGaMwhU3QxrxFkqLZ5gquilnOkjIldYU/PdaueXHGUR
	 3+MRckG1ghCMCCDxP+x85Qy15LOHpdvuMqxJXXzha9mPsmvYfkm1MsYH3M3ZuAlZiq
	 CKPSxezvbmb5A==
Date: Thu, 19 Jun 2025 10:27:12 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: cdnsp: Fix issue with CV Bad Descriptor test
Message-ID: <20250619022712.GA36288@nchen-desktop>
References: <20250618053148.777461-1-pawell@cadence.com>
 <PH7PR07MB9538574F646FD0664C05B055DD72A@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB9538574F646FD0664C05B055DD72A@PH7PR07MB9538.namprd07.prod.outlook.com>

On 25-06-18 05:39:27, Pawel Laszczak wrote:
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
> Changelog:
> v2:
> - removed some typos
> - added pep variable initialization
> - updated TRB_ESP description
> 
>  drivers/usb/cdns3/cdnsp-debug.h  |  5 +++--
>  drivers/usb/cdns3/cdnsp-ep0.c    | 19 ++++++++++++++++---
>  drivers/usb/cdns3/cdnsp-gadget.h |  6 ++++++
>  drivers/usb/cdns3/cdnsp-ring.c   |  3 ++-
>  4 files changed, 27 insertions(+), 6 deletions(-)
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
> index f317d3c84781..9280a7b97e20 100644
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
> @@ -427,10 +428,22 @@ void cdnsp_setup_analyze(struct cdnsp_device *pdev)
>  		goto out;
>  	}
>  
> +	pep = &pdev->eps[0];
> +
>  	/* Restore the ep0 to Stopped/Running state. */
> -	if (pdev->eps[0].ep_state & EP_HALTED) {
> -		trace_cdnsp_ep0_halted("Restore to normal state");
> -		cdnsp_halt_endpoint(pdev, &pdev->eps[0], 0);
> +	if (pep->ep_state & EP_HALTED) {
> +		/*
> +		 * Halt Endpoint Command for SSP2 for ep0 preserve current
> +		 * endpoint state and driver has to synchronize the
> +		 * software endpoint state with endpoint output context
> +		 * state.
> +		 */
> +		if (GET_EP_CTX_STATE(pep->out_ctx) == EP_STATE_HALTED) {
> +			cdnsp_halt_endpoint(pdev, pep, 0);
> +		} else {
> +			pep->ep_state &= ~EP_HALTED;
> +			pep->ep_state |= EP_STOPPED;
> +		}

Why else {} is needed?

Peter


>  	}
>  
>  	/*
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
> index 2afa3e558f85..b1665f9e9ee5 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.h
> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
> @@ -987,6 +987,12 @@ enum cdnsp_setup_dev {
>  #define STREAM_ID_FOR_TRB(p)		((((p)) << 16) & GENMASK(31, 16))
>  #define SCT_FOR_TRB(p)			(((p) << 1) & 0x7)
>  
> +/*
> + * Halt Endpoint Command TRB field.
> + * The ESP bit only exists in the SSP2 controller.
> + */
> +#define TRB_ESP				BIT(9)
> +
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

