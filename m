Return-Path: <stable+bounces-144464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6A9AB7ADC
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 03:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D023A6FF7
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 01:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1802690F4;
	Thu, 15 May 2025 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mql/u/g8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F27242D61;
	Thu, 15 May 2025 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747271478; cv=none; b=BKjG0eWll4yXX+Q/UxQuhcLphF7pnraPSi23micrth0Qi+ZTRM9tlO42TKZWaZmpwnKVBBRaISWk7gIrXXUinHVnCydXC2mHOedtFdMRETyHLcB20hIIdTwZQ5fYH2V6fLw+yGa4GzRkLYmuprIY2xJAtkWS78nID9u8jKhapRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747271478; c=relaxed/simple;
	bh=aYYX6/Kut38IE4Ji3iGpvGGHrQkkirCFw/76I17L7yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yhoo8G3HtDNRAUVSOFQx16JQ4fB1qj18i+Ba15XgH0mzvvcunbDUEAcLwv0HSSHUbhUW0RQZOAj4hGKLJeiWXOpkU0M5MBnTJuxYuLCB/2EF7BnYGwyfoN0hBM+8mG7WKe3hLdW6n522PRTR0vRP04Il/v7j7YJtydWGB4d1K64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mql/u/g8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9690DC4CEE3;
	Thu, 15 May 2025 01:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747271476;
	bh=aYYX6/Kut38IE4Ji3iGpvGGHrQkkirCFw/76I17L7yI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mql/u/g81Ki2TNHN/Dnx1n/a7aZS6SnZhNp43wHsJZiWeTzgEpTxREhOEDpvWuCxc
	 l3VbObvhq20ZOjKoNhbz24rlJR8Ghj63kfATOjkQaRWwe+gek02JsNWBYvibY10LE3
	 R9nM88WPm8H92abqqWicD9WiaAVO2nDXwZstl+K/GWWAEK88nURceqrJjEcWbtrcS9
	 wOp304UPiE0zANUhCZKsgWfI2Vqqo6mxpKvfTWe/d6FHz68HznxCgcKQgLWFQdAINh
	 5ivazcPfWOHs8P/Jxxu4+VAaTBH4BF+dKe7H8q7HkqyETq0ewySy6foyJZkwITWWXK
	 FMOADm6aKBbcw==
Date: Thu, 15 May 2025 09:11:08 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: cdnsp: Fix issue with detecting command
 completion event
Message-ID: <20250515011108.GA684089@nchen-desktop>
References: <20250513052613.447330-1-pawell@cadence.com>
 <PH7PR07MB9538AA45362ACCF1B94EE9B7DD96A@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB9538AA45362ACCF1B94EE9B7DD96A@PH7PR07MB9538.namprd07.prod.outlook.com>

On 25-05-13 05:30:09, Pawel Laszczak wrote:
> In some cases, there is a small-time gap in which CMD_RING_BUSY
> can be cleared by controller but adding command completion event
> to event ring will be delayed. As the result driver will return
> error code.
> This behavior has been detected on usbtest driver (test 9) with
> configuration including ep1in/ep1out bulk and ep2in/ep2out isoc
> endpoint.
> Probably this gap occurred because controller was busy with adding
> some other events to event ring.
> The CMD_RING_BUSY is cleared to '0' when the Command Descriptor
> has been executed and not when command completion event has been
> added to event ring.
> 
> To fix this issue for this test the small delay is sufficient
> less than 10us) but to make sure the problem doesn't happen again
> in the future the patch introduces 10 retries to check with delay
> about 20us before returning error code.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: stable@vger.kernel.org
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
> Changelog:
> v2:
> - replaced usleep_range with udelay
> - increased retry counter and decreased the udelay value
> 
>  drivers/usb/cdns3/cdnsp-gadget.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index 4824a10df07e..58650b7f4173 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -547,6 +547,7 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pdev)
>  	dma_addr_t cmd_deq_dma;
>  	union cdnsp_trb *event;
>  	u32 cycle_state;
> +	u32 retry = 10;
>  	int ret, val;
>  	u64 cmd_dma;
>  	u32  flags;
> @@ -578,8 +579,23 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pdev)
>  		flags = le32_to_cpu(event->event_cmd.flags);
>  
>  		/* Check the owner of the TRB. */
> -		if ((flags & TRB_CYCLE) != cycle_state)
> +		if ((flags & TRB_CYCLE) != cycle_state) {
> +			/*
> +			 * Give some extra time to get chance controller
> +			 * to finish command before returning error code.
> +			 * Checking CMD_RING_BUSY is not sufficient because
> +			 * this bit is cleared to '0' when the Command
> +			 * Descriptor has been executed by controller
> +			 * and not when command completion event has
> +			 * be added to event ring.
> +			 */
> +			if (retry--) {
> +				udelay(20);
> +				continue;
> +			}
> +
>  			return -EINVAL;
> +		}
>  
>  		cmd_dma = le64_to_cpu(event->event_cmd.cmd_trb);
>  
> -- 
> 2.43.0
> 

-- 

Best regards,
Peter

