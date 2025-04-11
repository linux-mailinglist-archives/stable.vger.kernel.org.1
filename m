Return-Path: <stable+bounces-132250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667D8A85F81
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744B74C1A81
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8653D1DDA32;
	Fri, 11 Apr 2025 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wIVUIrAC"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F351AA786;
	Fri, 11 Apr 2025 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378946; cv=none; b=j4g7SH+UdEI13XOrJ6raW5fl2mTDNjvNuLyLy3QyX4Jt14GTSF6mPKVQqGGdkQDm9IXYfqYp3L+KvaRmmpyxZ5L+ji10ZhbERoMzuSV13o1nQDl6Gkz9v9NkbR2sSZYOMj1Ul9nDukc3gU3XuBVqSRZI7/tMO9kR3ulk041UJrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378946; c=relaxed/simple;
	bh=znPDB0MoSmT8PCpb3xg8cBUu9Za8ut3SUaA/1vEtbRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FX+tIsUzRPxhj2AoU//UNyZqeb3RErtFNlBdiL1s/cWIIcbNWoMKs7HkZIcu00EMC3RHP8T4Iopbe3dvnzCDhnzYJkL83paJQ0GUvXfXWZqosxQi0JcMhZl3YsrGSreU4FeuRjK/WBlOmgvdjg8NwDg8qJer5wMJAedx0pbZjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wIVUIrAC; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDg8aD2137750
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 08:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744378928;
	bh=v4UJPNnOWudFJocURSS5csRTh7we/bdm3q/LWnIuJSU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wIVUIrACHs8GQ8ru01wDzPMjGBKWgr/XbgniA/LgxGKt9bW6bBICgE9F3Emah8+Ts
	 0Ytj1Wvyhn7Gscpc3ShFHFxQ7uMVe7KLC0vy2DsP69U32x2hPh3WcXHCgfmAVwQcEE
	 CeoGtWJTRXJlzboIbewbyHISvvPL7AyiPufy5q0U=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDg8J8026772
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:42:08 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 08:42:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 08:42:08 -0500
Received: from [10.249.136.157] ([10.249.136.157])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BDg2Nx119834;
	Fri, 11 Apr 2025 08:42:03 -0500
Message-ID: <a05e2a39-b000-4c9c-9c74-49a9941b4801@ti.com>
Date: Fri, 11 Apr 2025 19:12:02 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] arm64: dts: ti: k3-am62x: Rename I2C switch to I2C
 mux in OV5640 overlay
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>, <jai.luthra@linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <stable@vger.kernel.org>
References: <20250409134128.2098195-1-y-abhilashchandra@ti.com>
 <20250409134128.2098195-8-y-abhilashchandra@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20250409134128.2098195-8-y-abhilashchandra@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 4/9/2025 7:11 PM, Yemike Abhilash Chandra wrote:
> The OV5640 device tree overlay incorrectly defined an I2C switch instead
> of an I2C mux. According to the DT bindings, the correct terminology and
> node definition should use "i2c-mux" instead of "i2c-switch". Hence,
> update the same to avoid dtbs_check warnings.
> 
> Fixes: 635ed9715194 ("arm64: dts: ti: k3-am62x: Add overlays for OV5640")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso      | 2 +-
>  arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
> index ccc7f5e43184..7fc7c95f5cd5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
> @@ -22,7 +22,7 @@ &main_i2c2 {
>  	#size-cells = <0>;
>  	status = "okay";
>  
> -	i2c-switch@71 {
> +	i2c-mux@71 {
>  		compatible = "nxp,pca9543";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
> index 4eaf9d757dd0..b6bfdfbbdd98 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
> @@ -22,7 +22,7 @@ &main_i2c2 {
>  	#size-cells = <0>;
>  	status = "okay";
>  
> -	i2c-switch@71 {
> +	i2c-mux@71 {
>  		compatible = "nxp,pca9543";
>  		#address-cells = <1>;
>  		#size-cells = <0>;

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis


