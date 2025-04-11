Return-Path: <stable+bounces-132246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EF0A85F56
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE899C50EF
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE7A1D79B8;
	Fri, 11 Apr 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xl2sU1NQ"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F9713AD1C;
	Fri, 11 Apr 2025 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378612; cv=none; b=O3RRzekuNXJqt1geHGuR3/Rk+MLbwHC8JZ+oOduw70jrlz1ohdY5yNqmTdQCzQB5EQPEzK0ncZhNbidozEBcsvx/HfpvFG74IsB9UoUcIHHoTsT1HsM5Ot44NgEsdZbX+zOVkWLSSj0B0o23A2gpMJgDP2LCO5dkqE1WesFO9ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378612; c=relaxed/simple;
	bh=2WoG5QbFhLPkFnSAl8HNWy0ssox+zGp1y7NHPDM2HmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hE94RsrSJiJ9/uOT5ziCAiJEV9fngoa7pF5xAoZKqqccj0oCOcjpX5nNip5pIvA46F03MClODDdby3lUN0p2kgny4hFajQPr9xsqqWtb4FVQOwulxjAw2BkXOpwuvpSBR6V9QUt2D2dKMU2u71R41vkH6Rx9mVSvDjozMVzsBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Xl2sU1NQ; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDaNJQ2136636
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 08:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744378583;
	bh=xDUMCTXFu4uLKL+OFwJXlFB+AWT2Hkl0QAnzYqKMYGg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Xl2sU1NQHPutSZTWoY7f/RrdwqYNc6FLamyMo95w99jELXr3CCZDPPJ0lzE70Aasp
	 LcY2yTBorG9bEMJ54hbAiWZ1tTQp3I4hY4LSXs7UFuuiQdr8YrP/WdPNDlObHGNu0Y
	 6Uvg5/x4IVo3N4lIwtcAPNPFfVmvVZ1cF8zKSKrw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BDaNL0023224
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 08:36:23 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 08:36:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 08:36:22 -0500
Received: from [10.249.136.157] ([10.249.136.157])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BDaGkJ112287;
	Fri, 11 Apr 2025 08:36:17 -0500
Message-ID: <0aedae21-b8dd-420f-af1e-ec609de3b0d5@ti.com>
Date: Fri, 11 Apr 2025 19:06:16 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] arm64: dts: ti: k3-j721e-sk: Remove clock-names
 property from IMX219 overlay
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>, <jai.luthra@linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <stable@vger.kernel.org>
References: <20250409134128.2098195-1-y-abhilashchandra@ti.com>
 <20250409134128.2098195-4-y-abhilashchandra@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20250409134128.2098195-4-y-abhilashchandra@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 4/9/2025 7:11 PM, Yemike Abhilash Chandra wrote:
> The IMX219 sensor device tree bindings do not include a clock-names
> property. Remove the incorrectly added clock-names entry to avoid
> dtbs_check warnings.
> 
> Fixes: f767eb918096 ("arm64: dts: ti: k3-j721e-sk: Add overlay for IMX219")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso b/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso
> index 47bb5480b5b0..4a395d1209c8 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk-csi2-dual-imx219.dtso
> @@ -34,7 +34,6 @@ imx219_0: imx219-0@10 {
>  		reg = <0x10>;
>  
>  		clocks = <&clk_imx219_fixed>;
> -		clock-names = "xclk";
>  
>  		port {
>  			csi2_cam0: endpoint {
> @@ -56,7 +55,6 @@ imx219_1: imx219-1@10 {
>  		reg = <0x10>;
>  
>  		clocks = <&clk_imx219_fixed>;
> -		clock-names = "xclk";
>  
>  		port {
>  			csi2_cam1: endpoint {

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis


