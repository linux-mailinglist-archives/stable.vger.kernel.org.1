Return-Path: <stable+bounces-132248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B3A85F62
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD481891445
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D021DE4CE;
	Fri, 11 Apr 2025 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yyhPjoGo"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE51C863E;
	Fri, 11 Apr 2025 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378789; cv=none; b=tnyKggZUnVLuOaE0aHOgN6lqXLoFA27UTXBXW64syvR2b5F/MrptF19qwJ5SdFK9Ou+tW0ktKbGKrpzCf5FXYt0jlrP5YPDvOHUiBSIyoimqMX/b83pR4mQFVvNd/TNOCdIaFcoDJSiZAqnQ5C7CVX4vEghChzuOyizafOqbx4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378789; c=relaxed/simple;
	bh=MTBfFUuaknDnpEoE11pyg0/w98CA+nnxjMj+AcUfjUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GoC+7O25bF2o+6xw45owEWw4Qi7zQ0dFJBff7qldnYmi5+BRTa0Y1db9i6Mg05lIT/jA8BsSzQVr737ngX77adFfW0QzpmpBpaN1wUPoTCJjkJfj/PGoM/rjF/wPa91la73mJHLH0/We0zhwQB+HHJybtQiHJ/AuYJRv8wdlT9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yyhPjoGo; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDddgp2137114
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 08:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744378779;
	bh=9OyvleqLlN3Vcd3jJey54De9/WGKxGUsExiQtJz/ET0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=yyhPjoGoHutd1mbDtkKG1nlpLVHmPUI+dMGGeTQDeN41jbUVTohuVHakhpbCkK4Ae
	 Ru3dMoykPaydlIvSBJsrB1wmw+ZdHwukQ+ZfWFW6hW2aPQFG3v25j6HmeE4NXaGKqw
	 gZOBLvvuEsN3krvwAg9QX0+x5e1r6vsu2YuxYVlI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDdd4v112806
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:39:39 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 08:39:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 08:39:38 -0500
Received: from [10.249.136.157] ([10.249.136.157])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BDdXtR100609;
	Fri, 11 Apr 2025 08:39:33 -0500
Message-ID: <2919918b-d827-4154-8bbd-fd2de64e7526@ti.com>
Date: Fri, 11 Apr 2025 19:09:32 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] arm64: dts: ti: k3-am62x: Remove clock-names
 property from IMX219 overlay
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>, <jai.luthra@linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <stable@vger.kernel.org>
References: <20250409134128.2098195-1-y-abhilashchandra@ti.com>
 <20250409134128.2098195-6-y-abhilashchandra@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20250409134128.2098195-6-y-abhilashchandra@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 4/9/2025 7:11 PM, Yemike Abhilash Chandra wrote:
> The IMX219 sensor device tree bindings do not include a clock-names
> property. Remove the incorrectly added clock-names entry to avoid
> dtbs_check warnings.
> 
> Fixes: 4111db03dc05 ("arm64: dts: ti: k3-am62x: Add overlay for IMX219")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
> index 76ca02127f95..7a0d35eb04d3 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
> @@ -39,7 +39,6 @@ ov5640: camera@10 {
>  				reg = <0x10>;
>  
>  				clocks = <&clk_imx219_fixed>;
> -				clock-names = "xclk";
>  
>  				reset-gpios = <&exp1 13 GPIO_ACTIVE_HIGH>;
>  

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis


