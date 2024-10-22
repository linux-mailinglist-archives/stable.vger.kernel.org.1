Return-Path: <stable+bounces-87670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF409A99F9
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 08:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339F01C210AD
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 06:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64879145A1E;
	Tue, 22 Oct 2024 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfV37RsH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C6B145A1C
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579055; cv=none; b=QYTiJ5NimUZfFWxpZHhLRZHXy69PHmEDDUjGfSYpq3+Q9r8HaGlTTMB/YJ1e8wZJIOYDZ1hiVsu9dWnHuDZVv6Al19Sgm86dc/hIoiw9OLrxHrFX/2xY7Qy3WnCrFE9re7P+zXvn+JkLUXtLrtEGvNMIeuzCa66xU01ZGe4tGhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579055; c=relaxed/simple;
	bh=JiPEBzOSObIr2OfqtvgZd0Dr/wruVmc5sa1b+Mt+1BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPLuCBPQVwXXRsTmdzOTEMY5Sj0jQ1iX7OsOpM9lv0b+TM5GvnKvFZBwod9tSwPetP152UJkH/BtK9cH+asbp+lhvASK65IIA7KyZLH9u7rBD2ztpsBMIrX2t9HMGZFZPJLBZ9YFnD09UzAeJlM8YSF3hpnq6rm+7eRqACEnpEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfV37RsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF02C4CEC3;
	Tue, 22 Oct 2024 06:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729579054;
	bh=JiPEBzOSObIr2OfqtvgZd0Dr/wruVmc5sa1b+Mt+1BA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EfV37RsHfKs2clTFPZuNeEWnuCfnMbZJOhaF/Vzb+jvjFiV5Z3ofn5q0g411RAfVe
	 iq3ausosB8LsAfNwrhIqYmc8WXfQHBIA+7nv7r01Od8ujga2QshFjF5IEmAceoxuWa
	 eVI9/kjqhs6dpH/XUTHhlDdFpys0fZCwufHNhFAqygaCO1FMka6QjE3bgaNr1mJTNh
	 hwq7mWfVx14laBSAndj6qK1EttpYMj7EY3vWejTL4+CPG0Qy+2XQv2qQ/+5mT/m6iE
	 JXy+5apX8XYCklRritp1gShQfVh8r+KYg2GADsReILaM408BrOPuKxFW59BmNm0sX3
	 nLGq2sJ5WTlpw==
Message-ID: <c8c33676-d05b-4cbb-974e-398784cb8b8a@kernel.org>
Date: Tue, 22 Oct 2024 09:37:30 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] usb: dwc3: core: Fix system suspend on TI
 AM62 platforms" failed to apply to 5.10-stable tree
To: gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com, d-gole@ti.com,
 msp@baylibre.com
Cc: stable@vger.kernel.org
References: <2024102152-salvage-pursuable-3b7c@gregkh>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <2024102152-salvage-pursuable-3b7c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

Patch was marked for 6.9+ but I added a 'v' in the tag and that's probably why it
was attempted for earlier trees.

> Cc: stable@vger.kernel.org # v6.9+

cheers,
-roger

On 21/10/2024 10:52, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 705e3ce37bccdf2ed6f848356ff355f480d51a91
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102152-salvage-pursuable-3b7c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 705e3ce37bccdf2ed6f848356ff355f480d51a91 Mon Sep 17 00:00:00 2001
> From: Roger Quadros <rogerq@kernel.org>
> Date: Fri, 11 Oct 2024 13:53:24 +0300
> Subject: [PATCH] usb: dwc3: core: Fix system suspend on TI AM62 platforms
> 
> Since commit 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init"),
> system suspend is broken on AM62 TI platforms.
> 
> Before that commit, both DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SUSPHY
> bits (hence forth called 2 SUSPHY bits) were being set during core
> initialization and even during core re-initialization after a system
> suspend/resume.
> 
> These bits are required to be set for system suspend/resume to work correctly
> on AM62 platforms.
> 
> Since that commit, the 2 SUSPHY bits are not set for DEVICE/OTG mode if gadget
> driver is not loaded and started.
> For Host mode, the 2 SUSPHY bits are set before the first system suspend but
> get cleared at system resume during core re-init and are never set again.
> 
> This patch resovles these two issues by ensuring the 2 SUSPHY bits are set
> before system suspend and restored to the original state during system resume.
> 
> Cc: stable@vger.kernel.org # v6.9+
> Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
> Link: https://lore.kernel.org/all/1519dbe7-73b6-4afc-bfe3-23f4f75d772f@kernel.org/
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Tested-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Link: https://lore.kernel.org/r/20241011-am62-lpm-usb-v3-1-562d445625b5@kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 21740e2b8f07..427e5660f87c 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -2342,6 +2342,11 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  	u32 reg;
>  	int i;
>  
> +	dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
> +			    DWC3_GUSB2PHYCFG_SUSPHY) ||
> +			    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
> +			    DWC3_GUSB3PIPECTL_SUSPHY);
> +
>  	switch (dwc->current_dr_role) {
>  	case DWC3_GCTL_PRTCAP_DEVICE:
>  		if (pm_runtime_suspended(dwc->dev))
> @@ -2393,6 +2398,15 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  		break;
>  	}
>  
> +	if (!PMSG_IS_AUTO(msg)) {
> +		/*
> +		 * TI AM62 platform requires SUSPHY to be
> +		 * enabled for system suspend to work.
> +		 */
> +		if (!dwc->susphy_state)
> +			dwc3_enable_susphy(dwc, true);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -2460,6 +2474,11 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>  		break;
>  	}
>  
> +	if (!PMSG_IS_AUTO(msg)) {
> +		/* restore SUSPHY state to that before system suspend. */
> +		dwc3_enable_susphy(dwc, dwc->susphy_state);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 9c508e0c5cdf..eab81dfdcc35 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1150,6 +1150,8 @@ struct dwc3_scratchpad_array {
>   * @sys_wakeup: set if the device may do system wakeup.
>   * @wakeup_configured: set if the device is configured for remote wakeup.
>   * @suspended: set to track suspend event due to U3/L2.
> + * @susphy_state: state of DWC3_GUSB2PHYCFG_SUSPHY + DWC3_GUSB3PIPECTL_SUSPHY
> + *		  before PM suspend.
>   * @imod_interval: set the interrupt moderation interval in 250ns
>   *			increments or 0 to disable.
>   * @max_cfg_eps: current max number of IN eps used across all USB configs.
> @@ -1382,6 +1384,7 @@ struct dwc3 {
>  	unsigned		sys_wakeup:1;
>  	unsigned		wakeup_configured:1;
>  	unsigned		suspended:1;
> +	unsigned		susphy_state:1;
>  
>  	u16			imod_interval;
>  
> 


