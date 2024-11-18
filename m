Return-Path: <stable+bounces-93806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26189D14E2
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 17:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D21F285012
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 16:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FA61BD9D3;
	Mon, 18 Nov 2024 16:00:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF451BBBE5;
	Mon, 18 Nov 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945637; cv=none; b=otUQGbuNwItT8JKjeqdOGzqWKGcrg3X52E3I2CNkxuBiFzPvyjUVCNXUsoMuufQJS5xOhLNCYoYLDlhme3W6IVkqxk5l87SLaeFN/M8IL14QVwSAmCjPKTtMz+S6NjCav10lXhy7wf8o+xaikezS5FY3mDlcynWi06RavRyGbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945637; c=relaxed/simple;
	bh=Zb7WTimXNAmtjSJ2AjvonPJRWoVTRctyLlR21r3QJlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiTeU/YYdYJ39lYtYnN11sfRF5N7rCaQPu/Y1AHhhxq4muQOO1fOk0uQZFssTL6UHRy51eM5oVs9BQvr9E5h+bHi377/c64V32Xv4BGyHdYkSZBvRxv1URUXCchS2Eg5EYLgal/jijxRKXKlVqDKsUfz8vwo+OyQW0N0COEKDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B72082000B;
	Mon, 18 Nov 2024 16:00:30 +0000 (UTC)
Message-ID: <a35ba8dc-fd4a-41ae-9ad7-7702f4f48980@korsgaard.com>
Date: Mon, 18 Nov 2024 17:00:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: xilinx: make sure pipe clock is deselected
 in usb2 only mode
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, michal.simek@amd.com,
 robert.hancock@calian.com
Cc: linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com, Neal Frager
 <neal.frager@amd.com>, stable@vger.kernel.org
References: <1731942491-1992368-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Language: en-US
From: Peter Korsgaard <peter@korsgaard.com>
In-Reply-To: <1731942491-1992368-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: peter@korsgaard.com

On 11/18/24 16:08, Radhey Shyam Pandey wrote:
> From: Neal Frager <neal.frager@amd.com>
> 
> When the USB3 PHY is not defined in the Linux device tree, there could
> still be a case where there is a USB3 PHY is active on the board and

2nd "is " should be dropped. This sounds a bit confusing to me as the 
PHY is on-chip on zynqmp, maybe you are referring to a reference clock 
input to the PS-GTR instead?


> enabled by the first stage bootloader.  If serdes clock is being used
> then the USB will fail to enumerate devices in 2.0 only mode.
> 
> To solve this, make sure that the PIPE clock is deselected whenever the
> USB3 PHY is not defined and guarantees that the USB2 only mode will work
> in all cases.
> 
> Fixes: 9678f3361afc ("usb: dwc3: xilinx: Skip resets and USB3 register settings for USB2.0 mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> Changes for v2:
> - Add stable@vger.kernel.org in CC.

Other than that looks good, thanks.

Acked-by: Peter Korsgaard <peter@korsgaard.com>


> ---
>   drivers/usb/dwc3/dwc3-xilinx.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
> index e3738e1610db..a33a42ba0249 100644
> --- a/drivers/usb/dwc3/dwc3-xilinx.c
> +++ b/drivers/usb/dwc3/dwc3-xilinx.c
> @@ -121,8 +121,11 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
>   	 * in use but the usb3-phy entry is missing from the device tree.
>   	 * Therefore, skip these operations in this case.
>   	 */
> -	if (!priv_data->usb3_phy)
> +	if (!priv_data->usb3_phy) {
> +		/* Deselect the PIPE Clock Select bit in FPD PIPE Clock register */
> +		writel(PIPE_CLK_DESELECT, priv_data->regs + XLNX_USB_FPD_PIPE_CLK);
>   		goto skip_usb3_phy;
> +	}
>   
>   	crst = devm_reset_control_get_exclusive(dev, "usb_crst");
>   	if (IS_ERR(crst)) {
> 
> base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c

-- 
Bye, Peter Korsgaard


