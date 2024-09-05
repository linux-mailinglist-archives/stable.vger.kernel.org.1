Return-Path: <stable+bounces-73148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91E396D0D9
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8666D287E96
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 07:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741D8194147;
	Thu,  5 Sep 2024 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZjrlTIi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B40C1925B5;
	Thu,  5 Sep 2024 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522763; cv=none; b=auMZj6ZXES1g5hF59OFDfYKNoVXbj+NuzjNmFGA3TqWFqYGBz18mhQ33U3S/e6tLr1v7D8TmS7UW9jy6+Iop77xvLGMME+dm3N+0onLH6EHJArgfWTSKjWfZCqX4RYkaqHYbHkpjwyITkmQ80gyIF4YnHDOIK6s4CjbC/T/dxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522763; c=relaxed/simple;
	bh=1w/DEc4Hg4y0fdNyNzind01KPDVGipnFjRZPtt8ca10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHDdleQPVJy3PW6FTmdhhGmuWL10YF4mp1k8OPQPzaJHvjeiBMQC9t21JYwXiC6B+9rjvEAzUomvEUd/uvOjJlTuamksVDqSeWWvz+un8Fr8OMgEP/WRgfHrUxrHVCv9Yi4NZdMUmkAMnBIA9f8BOybFFaxvHTazEdIlgVlJ4yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZjrlTIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B765C4CEC3;
	Thu,  5 Sep 2024 07:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725522762;
	bh=1w/DEc4Hg4y0fdNyNzind01KPDVGipnFjRZPtt8ca10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZjrlTIihvgnrnv9ZJbwzCxYksy0vYij2huAmMf6Q1+pRI1lDYM1XNpxfwd36lloy
	 QVF/0ASW11I1dqeofBFl6VQWpHQcfu2mN++sNVZubWKrnJ9qDvmxL/H/LkON0LM07c
	 r5HcnUQvlJL8CRihL250rMZ6+YjP/+eMi1U1Ji/7/2G459tCwAF/wXNx+E1M5ktHyw
	 rsPv7124pOwURK/ZC0fJuRyNCHbQzp5W03uampYTdzQK4CwNwyXDOAr+OVHD2PZeCv
	 nViqVFyN4Kqna95qkmjJ8g0V4RykdYaJOoAvg1nOFaaAI1BJmqWIWeDnZEv204+a1N
	 kGVMplaqhVxRQ==
Date: Thu, 5 Sep 2024 15:52:35 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: xhci: fix loss of data on Cadence xHC
Message-ID: <20240905075235.GB325295@nchen-desktop>
References: <20240905065716.305332-1-pawell@cadence.com>
 <PH7PR07MB95386A40146E3EC64086F409DD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB95386A40146E3EC64086F409DD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>

On 24-09-05 07:03:28, Pawel Laszczak wrote:
> Streams should flush their TRB cache, re-read TRBs, and start executing
> TRBs from the beginning of the new dequeue pointer after a 'Set TR Dequeue
> Pointer' command.
> 
> Cadence controllers may fail to start from the beginning of the dequeue
> TRB as it doesn't clear the Opaque 'RsvdO' field of the stream context
> during 'Set TR Dequeue' command. This stream context area is where xHC
> stores information about the last partially executed TD when a stream
> is stopped. xHC uses this information to resume the transfer where it left
> mid TD, when the stream is restarted.
> 
> Patch fixes this by clearing out all RsvdO fields before initializing new
> Stream transfer using a 'Set TR Dequeue Pointer' command.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: <stable@vger.kernel.org>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Reviewed-by: Peter Chen <peter.chen@kernel.org>
> 
> ---
> Changelog:
> v3:
> - changed patch to patch Cadence specific
> 
> v2:
> - removed restoring of EDTLA field 
> 
>  drivers/usb/cdns3/host.c     |  4 +++-
>  drivers/usb/host/xhci-pci.c  |  7 +++++++
>  drivers/usb/host/xhci-ring.c | 14 ++++++++++++++
>  drivers/usb/host/xhci.h      |  1 +
>  4 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
> index ceca4d839dfd..7ba760ee62e3 100644
> --- a/drivers/usb/cdns3/host.c
> +++ b/drivers/usb/cdns3/host.c
> @@ -62,7 +62,9 @@ static const struct xhci_plat_priv xhci_plat_cdns3_xhci = {
>  	.resume_quirk = xhci_cdns3_resume_quirk,
>  };
>  
> -static const struct xhci_plat_priv xhci_plat_cdnsp_xhci;
> +static const struct xhci_plat_priv xhci_plat_cdnsp_xhci = {
> +	.quirks = XHCI_CDNS_SCTX_QUIRK,
> +};
>  
>  static int __cdns_host_init(struct cdns *cdns)
>  {
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index b9ae5c2a2527..9199dbfcea07 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -74,6 +74,9 @@
>  #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
>  #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
>  
> +#define PCI_DEVICE_ID_CADENCE				0x17CD
> +#define PCI_DEVICE_ID_CADENCE_SSP			0x0200
> +
>  static const char hcd_name[] = "xhci_hcd";
>  
>  static struct hc_driver __read_mostly xhci_pci_hc_driver;
> @@ -532,6 +535,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
>  	}
>  
> +	if (pdev->vendor == PCI_DEVICE_ID_CADENCE &&
> +	    pdev->device == PCI_DEVICE_ID_CADENCE_SSP)
> +		xhci->quirks |= XHCI_CDNS_SCTX_QUIRK;
> +
>  	/* xHC spec requires PCI devices to support D3hot and D3cold */
>  	if (xhci->hci_version >= 0x120)
>  		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 1dde53f6eb31..a1ad2658c0c7 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1386,6 +1386,20 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd *xhci, int slot_id,
>  			struct xhci_stream_ctx *ctx =
>  				&ep->stream_info->stream_ctx_array[stream_id];
>  			deq = le64_to_cpu(ctx->stream_ring) & SCTX_DEQ_MASK;
> +
> +			/*
> +			 * Cadence xHCI controllers store some endpoint state
> +			 * information within Rsvd0 fields of Stream Endpoint
> +			 * context. This field is not cleared during Set TR
> +			 * Dequeue Pointer command which causes XDMA to skip
> +			 * over transfer ring and leads to data loss on stream
> +			 * pipe.
> +			 * To fix this issue driver must clear Rsvd0 field.
> +			 */
> +			if (xhci->quirks & XHCI_CDNS_SCTX_QUIRK) {
> +				ctx->reserved[0] = 0;
> +				ctx->reserved[1] = 0;
> +			}
>  		} else {
>  			deq = le64_to_cpu(ep_ctx->deq) & ~EP_CTX_CYCLE_MASK;
>  		}
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 101e74c9060f..4cbd58eed214 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1907,6 +1907,7 @@ struct xhci_hcd {
>  #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
>  #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
>  #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
> +#define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
>  
>  	unsigned int		num_active_eps;
>  	unsigned int		limit_active_eps;
> -- 
> 2.43.0
> 

