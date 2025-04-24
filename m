Return-Path: <stable+bounces-136511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D454A9A0E2
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CEFE19461C4
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 06:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB5D1C9B9B;
	Thu, 24 Apr 2025 06:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A77Dnssm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7096E2701B8;
	Thu, 24 Apr 2025 06:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745474877; cv=none; b=TdEGD9wv1Pfnw0FOht7seKch1SAEqW+P4sFCFtmO/2nItGY3sl7ZfpyE8pVuPrNRV5GTtS1lDjqlS8NdGwIS+OrolF3G8LZ4npYW8dc0dXKMlvvkIPH1P9ipT4F5X6UNH+SQmxDsdQCDtn+FHq0D1BtHDpq8q2Yy9wr7MeNgzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745474877; c=relaxed/simple;
	bh=5osYtgNZqYJ3oPCPLcOb3dhOi+jBurB8qngiR9eNzKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qx4Jx3Hdv/hKe4SVDeZlpm4JZFetycP8sKcuKejkh5PA9ei8+SaprZGJIK5dQX8tvm/x/4a1lfbdkKEwYpGSIF1FS3YIVkP4XWKdUKYa2teBDLovmyMNdjo+FMy//PKTM9nJY41GXgEDgPkPxcfhF2C5jqfBkMzbLnNd2Qm+hSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A77Dnssm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E27C4CEE3;
	Thu, 24 Apr 2025 06:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745474876;
	bh=5osYtgNZqYJ3oPCPLcOb3dhOi+jBurB8qngiR9eNzKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A77DnssmFDqKpKFZlg9xu3nTuC0itF5FyohwGnHStHqBIazQnIOAgHcjZ7apjXdQk
	 SkPBH/3YKJLHEHM+jg4HUe7Pp07KoulvsJZa2v21uM2q6sQJb2i/Yz9eQW3dknaEkK
	 vw3S+sCcWKmdYImWcvtUEgtWKF2xL+tb3hv5arYn9ZMS8adK48TJHIipW4i9lzvt/j
	 nqK7+psrEtWWNNmIfFdqztrsUeoNIyhiSAW3+bjgFcAAwAsCHJFfK1S/FxZG3FHVIR
	 MVHGuqWAdICrTrXDyT9/EDwzI8HuKKxCZGq7Mw99P7jgC2bOG2lafEE6flKEmuOyOv
	 tMLP6HSFjTIWg==
Date: Thu, 24 Apr 2025 14:07:48 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: cdnsp: fix L1 resume issue for RTL_REVISION_NEW_LPM
 version
Message-ID: <20250424060748.GA3601935@nchen-desktop>
References: <20250423111535.3894417-1-pawell@cadence.com>
 <PH7PR07MB9538D15B4511A76BF9EE49DEDDBA2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB9538D15B4511A76BF9EE49DEDDBA2@PH7PR07MB9538.namprd07.prod.outlook.com>

On 25-04-23 11:43:03, Pawel Laszczak wrote:
> The controllers with rtl version greeter than
less than?

> RTL_REVISION_NEW_LPM (0x00002700) has bug which causes that controller
> doesn't resume from L1 state. It happens if after receiving LPM packet
> controller starts transitioning to L1 and in this moment the driver force
> resuming by write operation to PORTSC.PLS.
> It's corner case and happens when write operation to PORTSC occurs during
> device delay before transitioning to L1 after transmitting ACK
> time (TL1TokenRetry).
> 
> Forcing transition from L1->L0 by driver for revision greeter than

%s/greeter/larger

> RTL_REVISION_NEW_LPM is not needed, so driver can simply fix this issue
> through block call of cdnsp_force_l0_go function.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: stable@vger.kernel.org
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/cdnsp-gadget.c | 2 ++
>  drivers/usb/cdns3/cdnsp-gadget.h | 3 +++
>  drivers/usb/cdns3/cdnsp-ring.c   | 3 ++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index 7f5534db2086..4824a10df07e 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -1793,6 +1793,8 @@ static void cdnsp_get_rev_cap(struct cdnsp_device *pdev)
>  	reg += cdnsp_find_next_ext_cap(reg, 0, RTL_REV_CAP);
>  	pdev->rev_cap  = reg;
>  
> +	pdev->rtl_revision = readl(&pdev->rev_cap->rtl_revision);
> +
>  	dev_info(pdev->dev, "Rev: %08x/%08x, eps: %08x, buff: %08x/%08x\n",
>  		 readl(&pdev->rev_cap->ctrl_revision),
>  		 readl(&pdev->rev_cap->rtl_revision),
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
> index 87ac0cd113e7..fa02f861217f 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.h
> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
> @@ -1360,6 +1360,7 @@ struct cdnsp_port {
>   * @rev_cap: Controller Capabilities Registers.
>   * @hcs_params1: Cached register copies of read-only HCSPARAMS1
>   * @hcc_params: Cached register copies of read-only HCCPARAMS1
> + * @rtl_revision: Cached controller rtl revision.
>   * @setup: Temporary buffer for setup packet.
>   * @ep0_preq: Internal allocated request used during enumeration.
>   * @ep0_stage: ep0 stage during enumeration process.
> @@ -1414,6 +1415,8 @@ struct cdnsp_device {
>  	__u32 hcs_params1;
>  	__u32 hcs_params3;
>  	__u32 hcc_params;
> +	#define RTL_REVISION_NEW_LPM 0x00002701

0x2700?

> +	__u32 rtl_revision;
>  	/* Lock used in interrupt thread context. */
>  	spinlock_t lock;
>  	struct usb_ctrlrequest setup;
> diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
> index 46852529499d..fd06cb85c4ea 100644
> --- a/drivers/usb/cdns3/cdnsp-ring.c
> +++ b/drivers/usb/cdns3/cdnsp-ring.c
> @@ -308,7 +308,8 @@ static bool cdnsp_ring_ep_doorbell(struct cdnsp_device *pdev,
>  
>  	writel(db_value, reg_addr);
>  
> -	cdnsp_force_l0_go(pdev);
> +	if (pdev->rtl_revision < RTL_REVISION_NEW_LPM)
> +		cdnsp_force_l0_go(pdev);

Pawel, it may not solve all issues for controllers which RTL version
is less than 0x2700, do you have any other patches for it?

-- 

Best regards,
Peter

