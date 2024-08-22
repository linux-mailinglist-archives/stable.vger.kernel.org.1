Return-Path: <stable+bounces-69877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE3195B3A6
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 13:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8A91C22D37
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117C11C93AC;
	Thu, 22 Aug 2024 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw6uEk4u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3411779BB;
	Thu, 22 Aug 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325605; cv=none; b=MZJxt4QSnsIl3WDVeU53dVZWTZK7vBFhBKUvEtx5hmFAZm2e+I4fMWJRdez8+5HCNIWydzg3t+Aoxb6cGdV/GcLF40wOh5Ez6vmq57Rw7bC0bJTJFdMg8obL96u7xUs2Y785GRZMdqNv6mkYXnemLkmvar/RvKYbzplw5EVXWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325605; c=relaxed/simple;
	bh=hwSpFaqpeuGl3qZPQ50oAYaSciVFPkcvEDwgd+BtA7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS1Zx807EmYS01C7SarzFppdvcoXK2C4oPrzqxq68D4uwX9WtPEflps2YnBWjVjenWsxNpejbjDno1eLD7nDQEi4xLwcs/q0CQFRYvlFLwVCm8D1G/QIp77clokHYe/0C3lereIgaQpbb5VO+SbwM8w3gArXePF4Q5oEpEKY30Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw6uEk4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DC5C32782;
	Thu, 22 Aug 2024 11:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724325605;
	bh=hwSpFaqpeuGl3qZPQ50oAYaSciVFPkcvEDwgd+BtA7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aw6uEk4uYQvyuKFKiZ59WtsnZUlq7WwoSVqk499WafQ06X6DkE+pEKVdUoBbjlZwE
	 IZG9aA8/G2hn1J7yJTZNmL+z9g9GO2BDClZtdWZMx/i36doVWKWc5JQ9xOJUCsydci
	 suHgZtWMqeJ89PPKDVXRg2RuEI3RYe61vM2E52TBc9CgpwLjQ8NKy5ACRqIuEeQD2b
	 o9jY1k9lB8jqeGZYzQm7G7+cFeIwWAOA4+L3k2wfu6Tg5O9lL+WGMW18qzKb/prnKb
	 TW9iQWKltknpczArJMj7p99B8JpYf/gNcVK+iVlA8DjZvIUtm7DLIEZ8J65X/NnrHm
	 ZjW1K968pAe2g==
Date: Thu, 22 Aug 2024 19:19:56 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: cdnsp: fix for Link TRB with TC
Message-ID: <20240822111956.GA783015@nchen-desktop>
References: <20240821060426.84380-1-pawell@cadence.com>
 <PH7PR07MB953878279F375CCCE6C6F40FDD8E2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB953878279F375CCCE6C6F40FDD8E2@PH7PR07MB9538.namprd07.prod.outlook.com>

On 24-08-21 06:07:42, Pawel Laszczak wrote:
> Stop Endpoint command on LINK TRB with TC bit set to 1 causes that
> internal cycle bit can have incorrect state after command complete.
> In consequence empty transfer ring can be incorrectly detected
> when EP is resumed.
> NOP TRB before LINK TRB avoid such scenario. Stop Endpoint command
> is then on NOP TRB and internal cycle bit is not changed and have
> correct value.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: <stable@vger.kernel.org>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Reviewed-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/cdns3/cdnsp-gadget.h |  3 +++
>  drivers/usb/cdns3/cdnsp-ring.c   | 28 ++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
> index e1b5801fdddf..9a5577a772af 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.h
> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
> @@ -811,6 +811,7 @@ struct cdnsp_stream_info {
>   *        generate Missed Service Error Event.
>   *        Set skip flag when receive a Missed Service Error Event and
>   *        process the missed tds on the endpoint ring.
> + * @wa1_nop_trb: hold pointer to NOP trb.
>   */
>  struct cdnsp_ep {
>  	struct usb_ep endpoint;
> @@ -838,6 +839,8 @@ struct cdnsp_ep {
>  #define EP_UNCONFIGURED		BIT(7)
>  
>  	bool skip;
> +	union cdnsp_trb	 *wa1_nop_trb;
> +
>  };
>  
>  /**
> diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
> index 275a6a2fa671..75724e60653c 100644
> --- a/drivers/usb/cdns3/cdnsp-ring.c
> +++ b/drivers/usb/cdns3/cdnsp-ring.c
> @@ -1904,6 +1904,23 @@ int cdnsp_queue_bulk_tx(struct cdnsp_device *pdev, struct cdnsp_request *preq)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * workaround 1: STOP EP command on LINK TRB with TC bit set to 1
> +	 * causes that internal cycle bit can have incorrect state after
> +	 * command complete. In consequence empty transfer ring can be
> +	 * incorrectly detected when EP is resumed.
> +	 * NOP TRB before LINK TRB avoid such scenario. STOP EP command is
> +	 * then on NOP TRB and internal cycle bit is not changed and have
> +	 * correct value.
> +	 */
> +	if (pep->wa1_nop_trb) {
> +		field = le32_to_cpu(pep->wa1_nop_trb->trans_event.flags);
> +		field ^= TRB_CYCLE;
> +
> +		pep->wa1_nop_trb->trans_event.flags = cpu_to_le32(field);
> +		pep->wa1_nop_trb = NULL;
> +	}
> +
>  	/*
>  	 * Don't give the first TRB to the hardware (by toggling the cycle bit)
>  	 * until we've finished creating all the other TRBs. The ring's cycle
> @@ -1999,6 +2016,17 @@ int cdnsp_queue_bulk_tx(struct cdnsp_device *pdev, struct cdnsp_request *preq)
>  		send_addr = addr;
>  	}
>  
> +	if (cdnsp_trb_is_link(ring->enqueue + 1)) {
> +		field = TRB_TYPE(TRB_TR_NOOP) | TRB_IOC;
> +		if (!ring->cycle_state)
> +			field |= TRB_CYCLE;
> +
> +		pep->wa1_nop_trb = ring->enqueue;
> +
> +		cdnsp_queue_trb(pdev, ring, 0, 0x0, 0x0,
> +				TRB_INTR_TARGET(0), field);
> +	}
> +
>  	cdnsp_check_trb_math(preq, enqd_len);
>  	ret = cdnsp_giveback_first_trb(pdev, pep, preq->request.stream_id,
>  				       start_cycle, start_trb);
> -- 
> 2.43.0
> 

