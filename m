Return-Path: <stable+bounces-136982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9490DA9FF4C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 03:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BCA3A8EAC
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 01:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6615E20E316;
	Tue, 29 Apr 2025 01:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcKwdWrq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1EE1EF01;
	Tue, 29 Apr 2025 01:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745891903; cv=none; b=uYBaxkTfhQpnrPj5Gdi3XFv7IAv+p/IVbXJ5r+HmcJ/fj7tXPUUOeXk8BpPYlQA9+RwaRGLiDSsUO3POB1D3s36XO58sRaO18VSOaby7Itca/9nH3Xtw5nmybjQvn1D5QF09vXXN3+E5pZCdjrR3xhX8cS02Qe8IrADbvKOjc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745891903; c=relaxed/simple;
	bh=r6Eqx4vQPJ/sbEzTmwfcYb+QRd2YEHOWgQzVfEbb/cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKYRUcuOEWINOaTGt+Cs/wA2CVhHfHpMltZMw/NMiNbxkDJdHtcK9+LO3jLC2KVYM2gK9C2aAD1F6oe+FvrjQ0C4S5W7U67+W8i7h4iOWAKtfM4Cbw8NFkFwdgTIQX3DfqJ56BWIdPwjcJi6APuiPcaDTKG9FlcbNh+Rqtzm/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcKwdWrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842FCC4CEE4;
	Tue, 29 Apr 2025 01:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745891902;
	bh=r6Eqx4vQPJ/sbEzTmwfcYb+QRd2YEHOWgQzVfEbb/cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcKwdWrqcggvCNj6nHvFDtB6vzii8ZK4V/Z4ckm0LZD2LoXD/a6qjf3yjbdQu/Juo
	 tVt8odskcKO9vuCGrJxXPpmIu30KFfl/YCoC73/RmsKC+XBDBV3LueueW8v7pEegPl
	 uhSAvjYfr9LCR8yrgjvs7zQ6kKM4yoOtHK3sIe/pgDG05XORNrh6iRhikaGjXvfm/r
	 5OHY0C8/6JoaieGHQhpJnEhkEPF560doDBylAgQeGzNKPiChKiQRDhc7rv+gmkYpLw
	 aNhxcPInRY8kcOefQ7+EhUjwQWM33+QtKa04jOoL8AV0myPeFEktIxrQZdI+2eXAPN
	 ExGYZqT1N+JFw==
Date: Tue, 29 Apr 2025 09:58:14 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: cdnsp: fix L1 resume issue for
 RTL_REVISION_NEW_LPM version
Message-ID: <20250429015814.GA3615063@nchen-desktop>
References: <20250425054934.507320-1-pawell@cadence.com>
 <PH7PR07MB9538B55C3A6E71F9ED29E980DD842@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB9538B55C3A6E71F9ED29E980DD842@PH7PR07MB9538.namprd07.prod.outlook.com>

On 25-04-25 05:55:40, Pawel Laszczak wrote:
> The controllers with rtl version larger than
> RTL_REVISION_NEW_LPM (0x00002700) has bug which causes that controller
> doesn't resume from L1 state. It happens if after receiving LPM packet
> controller starts transitioning to L1 and in this moment the driver force
> resuming by write operation to PORTSC.PLS.
> It's corner case and happens when write operation to PORTSC occurs during
> device delay before transitioning to L1 after transmitting ACK
> time (TL1TokenRetry).
> 
> Forcing transition from L1->L0 by driver for revision larger than
> RTL_REVISION_NEW_LPM is not needed, so driver can simply fix this issue
> through block call of cdnsp_force_l0_go function.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: stable@vger.kernel.org
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter

> ---
> Changelog:
> v2:
> - improved patch description
> - changed RTL_REVISION_NEW_LPM value
> 
>  drivers/usb/cdns3/cdnsp-gadget.c | 2 ++
>  drivers/usb/cdns3/cdnsp-gadget.h | 3 +++
>  drivers/usb/cdns3/cdnsp-ring.c   | 3 ++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index 87f310841735..e64c8f7eb0c5 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -1773,6 +1773,8 @@ static void cdnsp_get_rev_cap(struct cdnsp_device *pdev)
>  	reg += cdnsp_find_next_ext_cap(reg, 0, RTL_REV_CAP);
>  	pdev->rev_cap  = reg;
>  
> +	pdev->rtl_revision = readl(&pdev->rev_cap->rtl_revision);
> +
>  	dev_info(pdev->dev, "Rev: %08x/%08x, eps: %08x, buff: %08x/%08x\n",
>  		 readl(&pdev->rev_cap->ctrl_revision),
>  		 readl(&pdev->rev_cap->rtl_revision),
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
> index 84887dfea763..357ddbe53917 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.h
> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
> @@ -1357,6 +1357,7 @@ struct cdnsp_port {
>   * @rev_cap: Controller Capabilities Registers.
>   * @hcs_params1: Cached register copies of read-only HCSPARAMS1
>   * @hcc_params: Cached register copies of read-only HCCPARAMS1
> + * @rtl_revision: Cached controller rtl revision.
>   * @setup: Temporary buffer for setup packet.
>   * @ep0_preq: Internal allocated request used during enumeration.
>   * @ep0_stage: ep0 stage during enumeration process.
> @@ -1411,6 +1412,8 @@ struct cdnsp_device {
>  	__u32 hcs_params1;
>  	__u32 hcs_params3;
>  	__u32 hcc_params;
> +	#define RTL_REVISION_NEW_LPM 0x2700
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
>  
>  	/* Doorbell was set. */
>  	return true;
> -- 
> 2.43.0
> 

-- 

Best regards,
Peter

