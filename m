Return-Path: <stable+bounces-71494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDF696472C
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 15:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01A51C223CA
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 13:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CD31ABEC0;
	Thu, 29 Aug 2024 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nuo3IXBF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC38118E046;
	Thu, 29 Aug 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939368; cv=none; b=Q0k3SgV/Uz0/y7eNiWQdZTkjEGCF9S40OI8LxB5teTAEtFyJe1psrDsM4qqcsB+Xi9rXD/G+iX07vdSEB3a4/wuF8WgYXdkvBCKxRu2xdGpcKVDWKzCm3QmGh3u095xQ2g7uv+t5P4HNfLhXyL8deH3WpdnZX7VK+QpaMpLOPI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939368; c=relaxed/simple;
	bh=ZjlvTB1aaAO4hOFWRp43KPAA2JHxRKrYqvPBK3Z63+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnU3TBKa3imBf1Y/Kzgi6bQEE8UzzNmmpGHGP0F8xAhxHcvjeUQI9Br86yFE95m0xossaas/rm8p0mg7YpUEOSJzkZ/IP+tV4pBVXmDzpftuwMv1d26rRviGoB46bREl50hUmNUIHbKg2+Y0cgROcThihNxznT+Ju68f89inLDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nuo3IXBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD47CC4CEC1;
	Thu, 29 Aug 2024 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724939367;
	bh=ZjlvTB1aaAO4hOFWRp43KPAA2JHxRKrYqvPBK3Z63+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nuo3IXBFh/EVtO+Ynd3eBbehx7JayOaIGaZyqFAvumXGCvt7Sx8Ik+twDj7sKJ0+F
	 FW9+kXMiV1AWQGAfEMFW0x4twRt3iKAuTa0vcMGeGUFb/X3vEriZMTWGObOjhy75jH
	 WZlLtedw/8LlkRnvqZZrmN+akyM1obYLUF1dgwAg=
Date: Thu, 29 Aug 2024 15:49:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Markuss Broks <markuss.broks@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: amd: yc: Add a quirk for MSI Bravo 17 (D7VEK)
Message-ID: <2024082917-jockstrap-armored-6a14@gregkh>
References: <20240829130313.338508-1-markuss.broks@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829130313.338508-1-markuss.broks@gmail.com>

On Thu, Aug 29, 2024 at 04:03:05PM +0300, Markuss Broks wrote:
> MSI Bravo 17 (D7VEK), like other laptops from the family,
> has broken ACPI tables and needs a quirk for internal mic
> to work.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
> index 0523c16305db..843abc378b28 100644
> --- a/sound/soc/amd/yc/acp6x-mach.c
> +++ b/sound/soc/amd/yc/acp6x-mach.c
> @@ -353,6 +353,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 C7VF"),
>  		}
>  	},
> +	{
> +		.driver_data = &acp6x_card,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 17 D7VEK"),
> +		}
> +	},
>  	{
>  		.driver_data = &acp6x_card,
>  		.matches = {
> -- 
> 2.46.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

