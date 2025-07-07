Return-Path: <stable+bounces-160363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D47AFB267
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 13:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9881F3B6A66
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03444299A85;
	Mon,  7 Jul 2025 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEYN/3TO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B005619D880;
	Mon,  7 Jul 2025 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751888298; cv=none; b=FOtXENjgwoe/Zl7dy4th34dX5ZLB+2F5aOoeZ8khJ76JDNuhL0fm989Y/0NRix/2dJvleFxFunic+65CvO3Ljx4N0HIE2JulVyVHh3mFFAU5vt4TaWfV6C9lEa+KMnUIfrQKuxiKAvcHes+g7fisAkjlKhDxicY+0yN6sRxYxyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751888298; c=relaxed/simple;
	bh=bDGBshhWVEbKiUmgUMYBXO4823TBNdoRisTLs43p5UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFvPpHJ3yTS/PZ3Q1hbV3zJ7XWj03Pc3W4DTwK6MPDoABgXt4VBocdDwKlUcJ0PMzWqvRGsC1/a1kU/RlTzNyGhE2bRZm2ClIf5sSiXHHPhX74j7SKbnuWHSBFAKLYbCCkRunvk67ppT7+BwlEkLtBHN9/M+sN/lrVaj/2Yl/JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEYN/3TO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D99C4CEE3;
	Mon,  7 Jul 2025 11:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751888297;
	bh=bDGBshhWVEbKiUmgUMYBXO4823TBNdoRisTLs43p5UM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oEYN/3TO4BgYGcUczM5YqLT7kVqpLIHfNLwcqYbjSRp2muBNf7+GqaTilzZy6Q6s3
	 A6zl2hZMcakBRi47FIXAMokeOzrAdf8Uoi7G+WeiXGEsvNzK1588XXsx9cxAma73HC
	 5dySzDErMvwv36VlsOwm4Zt8LjwFF2MaPj7Za8AN5Jz4+OlgYKd2XRHfCneRsdjRma
	 MqjuAxfcStkQfuX/zAF7PO1NZ38VayNmO+kEyFC8W3f4nzrZ4HBmpDsOnW4DPGjjyI
	 AM5xgXNsTWvg86qEX1J/7KhqP5opb0qmqOpEkfNAXQnpuiNDl0gMM3vIFOkewFOHID
	 TFulluCACs1MA==
Message-ID: <6912ca9f-c633-4a37-b917-b1522f406f07@kernel.org>
Date: Mon, 7 Jul 2025 13:38:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: alienware-wmi-wmax: Fix `dmi_system_id`
 array
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Armin Wolf <W_Armin@gmx.de>, Mario Limonciello <mario.limonciello@amd.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250707-dmi-fix-v1-1-6730835d824d@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250707-dmi-fix-v1-1-6730835d824d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7-Jul-25 08:24, Kurt Borja wrote:
> Add missing empty member to `awcc_dmi_table`.
> 
> Cc: stable@vger.kernel.org
> Fixes: 6d7f1b1a5db6 ("platform/x86: alienware-wmi: Split DMI table")
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/platform/x86/dell/alienware-wmi-wmax.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> index 20ec122a9fe0571a1ecd2ccf630615564ab30481..1c21be25dba54699b9ba21f53e3845df166396e1 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -233,6 +233,7 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
>  		},
>  		.driver_data = &g_series_quirks,
>  	},
> +	{}
>  };
>  
>  enum AWCC_GET_FAN_SENSORS_OPERATIONS {
> 

Thank you for catching this, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans


