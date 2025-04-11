Return-Path: <stable+bounces-132256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE39A85FC2
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7895F173850
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1281917F0;
	Fri, 11 Apr 2025 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FP/LHciK"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9D2367B7;
	Fri, 11 Apr 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379809; cv=none; b=Z4w+PNrrTRKn/U4K2q9gYqtWTfLiR4OLmpNAt4fHy3QKoXJ3dEzkbnwiMPAAFzK0iIU+gjwxZVBBMFDWQrheQYr8CY81e+bppAKyvfcmXpTGxmnkcywHUNwlpM5hEugQfSGbJofAzcXbuWbF2lgrF5usRmfSpMqQoY4YNiuw7kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379809; c=relaxed/simple;
	bh=tXYZh8z7ILgkW3X+Yd6ejw+mkN0PDn5U4WMcYfRUhms=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gdy0UJBEVawnS8DhoFpoJqTe6s0RbuCiLxIfgxjT82rF3w65XC8ckOIA4mWSxxU7UKmZIXv1qUv4yCGNgs3vIGbPQTm/lmPjdIMYana/ifQtIFGOtq4Ki5NbBg24USKsTTnHwPMdyuY1z/hzkctcoCQzaNqIpRp7Jzdau56cPqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FP/LHciK; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDuebR1457292
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 08:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744379800;
	bh=dh6bE3XEbiTa0mmTq1+LWP9AAzh6deTQmR8XrrWXPSI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=FP/LHciKb+kFVsE/9VAjEQwtM1lOXleR/rP4eUPFWF51epfLWamq+9ykFFT523ZtA
	 rrdUBHyQ6519dkEZLCnjar0aUUpys03i7kAr9ZzzSh4yQYBxdnVRAsHoamx4PKwiAz
	 Lf5a3XC3xbaF0FLbuOxOJesxtKfyi2rIKhz/28j4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDuedm093360
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:56:40 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 08:56:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 08:56:40 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BDuZCB124896;
	Fri, 11 Apr 2025 08:56:36 -0500
Message-ID: <b6cae091-caa8-41fa-97b1-fb243386b0b5@ti.com>
Date: Fri, 11 Apr 2025 19:26:35 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-j722s-evm: Enable "serdes_wiz0"
 and "serdes_wiz1"
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <u-kumar1@ti.com>
References: <20250408103606.3679505-1-s-vadapalli@ti.com>
 <20250408103606.3679505-2-s-vadapalli@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250408103606.3679505-2-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 4/8/2025 4:06 PM, Siddharth Vadapalli wrote:
> In preparation for disabling "serdes_wiz0" and "serdes_wiz1" device-tree
> nodes in the SoC file, enable them in the board file. The motivation for
> this change is that of following the existing convention of disabling
> nodes in the SoC file and only enabling the required ones in the board
> file.
>
> Fixes: 485705df5d5f ("arm64: dts: ti: k3-j722s: Enable PCIe and USB support on J722S-EVM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>
> v1 of this patch is at:
> https://lore.kernel.org/r/20250408060636.3413856-2-s-vadapalli@ti.com/
> Changes since v1:
> - Added "Fixes" tag and updated commit message accordingly.
>
> Regards,
> Siddharth.
>
>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index 2127316f36a3..0bf2e1821662 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -843,6 +843,10 @@ &serdes_ln_ctrl {
>   		      <J722S_SERDES1_LANE0_PCIE0_LANE0>;
>   };
>   
> +&serdes_wiz0 {
> +	status = "okay";
> +};
> +
>   &serdes0 {
>   	status = "okay";
>   	serdes0_usb_link: phy@0 {
> @@ -854,6 +858,10 @@ serdes0_usb_link: phy@0 {
>   	};
>   };
>   
> +&serdes_wiz1 {
> +	status = "okay";
> +};
> +

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   &serdes1 {
>   	status = "okay";
>   	serdes1_pcie_link: phy@0 {

