Return-Path: <stable+bounces-59372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBF5931CEE
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 00:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0041C20B20
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 22:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CF613CA97;
	Mon, 15 Jul 2024 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkV/Ayz2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD31CA9E;
	Mon, 15 Jul 2024 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721080885; cv=none; b=MIQhNINiuca3n/HUuVwsM4zvtaIbIpN+QEXKlBJJwT9L6PYSW6kx7vf2SSy8cCJMjP0cr1m5jR6AtC3Wpj3gXrgNdq+QInDa2GHYBRYvW0IT0ixX8Uola+EqlpCzBSlUDuDrO/VrFXrqoHZvlGJmSm0F5D1EjbRGQkoEnNnH5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721080885; c=relaxed/simple;
	bh=AcdgatVBHWM0VAUnJX01KgS6GcKNZn6AlCQiWYVI2uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbN6gPIkXwfZlqgUxQqBC+lKCGOQRUZHNde8qQ6ppMi3wx6vNZwMB4i3U6Nag05uc0tid5AGzcSmMiOEFhy84P5NS+Fb+1ek+7g5XmXJtttraTxUNF2KvXA0HbPIKKfOlQ56nnO3OTixAI1LhiwPoUUe7H4Yux4LlDlQCFmBkks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkV/Ayz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3B5C32782;
	Mon, 15 Jul 2024 22:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721080884;
	bh=AcdgatVBHWM0VAUnJX01KgS6GcKNZn6AlCQiWYVI2uw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CkV/Ayz2yhg6ag2sARQHD1D0lt4D9jgd05mJ78kGJSs7vBPUqWkq5/smtDYDqD4QD
	 RJFHDWsHos+HcwepThoMYVi79y4RyamYR/WhZxPu8jNLFjbprNxJT+/OFBrTAzrE9c
	 6g/AHQT+JCXkP9bNHM+tfkhJJO71s1ZZU+NWMtuPiXT06/+MH6TMB2hpm76Nu//Js3
	 9cUBDL73w73+o4n83ln9VU26gQ5/gjlAawCISehhirK8gydyAROAzGo8w+VBv7eP3Z
	 4eClTUY14WPgoQv1DkCKPPKvljqnIldtVLoyPnhyH9koszfZ1wPkDduet5Z1C8rORw
	 y3lBIurUaN1sA==
Message-ID: <96d89d2f-0ecf-4c15-9a8a-146aa587d246@kernel.org>
Date: Tue, 16 Jul 2024 07:01:21 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ata: ahci_imx: Enlarge RX water mark for i.MX8QM
 SATA
To: Richard Zhu <hongxing.zhu@nxp.com>, tj@kernel.org, cassel@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 kernel@pengutronix.de
References: <1721008436-24288-1-git-send-email-hongxing.zhu@nxp.com>
 <1721008436-24288-4-git-send-email-hongxing.zhu@nxp.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <1721008436-24288-4-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/24 10:53, Richard Zhu wrote:
> The RXWM(RxWaterMark) sets the minimum number of free location within
> the RX FIFO before the watermark is exceeded which in turn will cause
> the Transport Layer to instruct the Link Layer to transmit HOLDS to
> the transmitting end.
> 
> Based on the default RXWM value 0x20, RX FIFO overflow might be
> observed on i.MX8QM MEK board, when some Gen3 SATA disks are used.
> 
> The FIFO overflow will result in CRC error, internal error and protocol
> error, then the SATA link is not stable anymore.
> 
> To fix this issue, enlarge RX water mark setting from 0x20 to 0x29.
> 
> Fixes: 027fa4dee935 ("ahci: imx: add the imx8qm ahci sata support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/ata/ahci_imx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index e94c0fdea2260..12d69a6429b6a 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -45,6 +45,10 @@ enum {
>  	/* Clock Reset Register */
>  	IMX_CLOCK_RESET				= 0x7f3f,
>  	IMX_CLOCK_RESET_RESET			= 1 << 0,
> +	/* IMX8QM SATA specific control registers */
> +	IMX8QM_SATA_AHCI_VEND_PTC		= 0xc8,
> +	IMX8QM_SATA_AHCI_VEND_PTC_RXWM_MASK	= 0x7f,

Please use GENMASK() macro to define this.

> +	IMX8QM_SATA_AHCI_VEND_PTC_NEWRXWM	= 0x29,

Here too. And I do not see the point of the "NEW" in the macro name.

Also, what is "_VEND_" supposed to mean in the macro names ? "Vendor" ?
If that is the case, remove that too, which will give you shorter macro names.
If not, then spell it out because that is not clear.

>  };
>  
>  enum ahci_imx_type {
> @@ -466,6 +470,12 @@ static int imx8_sata_enable(struct ahci_host_priv *hpriv)
>  	phy_power_off(imxpriv->cali_phy0);
>  	phy_exit(imxpriv->cali_phy0);
>  
> +	/* RxWaterMark setting */
> +	val = readl(hpriv->mmio + IMX8QM_SATA_AHCI_VEND_PTC);
> +	val &= ~IMX8QM_SATA_AHCI_VEND_PTC_RXWM_MASK;
> +	val |= IMX8QM_SATA_AHCI_VEND_PTC_NEWRXWM;
> +	writel(val, hpriv->mmio + IMX8QM_SATA_AHCI_VEND_PTC);
> +
>  	return 0;
>  
>  err_sata_phy_exit:

-- 
Damien Le Moal
Western Digital Research


