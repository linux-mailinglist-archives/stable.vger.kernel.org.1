Return-Path: <stable+bounces-69791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DAF9599F9
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 13:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E6F28194F
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235E4157467;
	Wed, 21 Aug 2024 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR7B+FAo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1261531CF;
	Wed, 21 Aug 2024 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724236996; cv=none; b=DG1l24nSxsVf3AbZJbHy1WdPEOQzuxHnHdPBvmDFuEyparIrmVunBKLAwYKkSCTXys7yEb7vF5TgluJePbjsvWsNlSYMR2TsRvVWE7HLehdGxhKnh0kniGf2a3jJ2y4oTBSpwzYhWn/EI/Q5k52vjYpJ5CQllFbdjicqIOtfuSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724236996; c=relaxed/simple;
	bh=dpMJmjks5mr2og5tU8dXwUueg+OMt9vvp2I+Pg377Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ae0tbsgwaNEEOA5aSrxOl9ZrJ0Yru86g1aNLO2ugB3pwHcY7r2EtKbSFL57ct9lxU6trwHOqBtzZjksPR2ZUL3eBqhVXaYaAsvEW6bdMBHWmBAhkx1leVtQ8SpvemhKLHhWV7mZv/aeVjeZRUneGy68m32+7f6v99k3YuyvFraw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR7B+FAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478C9C4AF09;
	Wed, 21 Aug 2024 10:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724236996;
	bh=dpMJmjks5mr2og5tU8dXwUueg+OMt9vvp2I+Pg377Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bR7B+FAoX7Rm5Qng94wfqY1lphuv9falVbzT8Gmry6lKTw+5XVHA8+hUuISGRWiT2
	 aO6Dm128vRmRFAhj0EjFJUD8x1AhHEaNa44ofH/qfJWufENNGv+g8Y3YA5OPY2+7rk
	 wUR2cd9srcir9Hil8Z5iqhuOBlOBPxQiQyC9ChkCCd6Xu6SCqGazCDq9jYxJDmBbsU
	 jrnGcLOtqJgltqD393Hkc6Jc1dE5c41aI/rFCAOHSfdJipm8pO06oQu2k6D7eyOLI3
	 cPgxvuYDosx2Ugf/rIqiwh2GOKOy1qABIIQ1gSHPyaZ8L7t5EIBDxBHLu6jXYTgApO
	 3+ihPzYzQXsdg==
Date: Wed, 21 Aug 2024 18:43:08 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: cdnsp: fix for Link TRB with TC
Message-ID: <20240821104308.GB652432@nchen-desktop>
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

You mean this issue is: the transfer ring is on the LINK TRB
when stop endpoint command is going to execute?

What's the use case we could find this issue?

Peter

> In consequence empty transfer ring can be incorrectly detected
> when EP is resumed.
> NOP TRB before LINK TRB avoid such scenario. Stop Endpoint command
> is then on NOP TRB and internal cycle bit is not changed and have
> correct value.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: <stable@vger.kernel.org>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
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

