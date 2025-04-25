Return-Path: <stable+bounces-136706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C219A9C9C8
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 15:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87B61BA75C6
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 13:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EFD24E4A4;
	Fri, 25 Apr 2025 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pzyOup1Q"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2560124C07E;
	Fri, 25 Apr 2025 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745586317; cv=none; b=IzwLAvafO1u2UoGxAdEipBX2KZc9XXEI2tLdc9+s3+IoNOqFIFYi8h6qvnkMenndN2Dq7zUWwqX53ClPiY80W2QTEwZsMAb9xCrpZSbz/tihpPyEfC1nB/Thl0Au3M6peEEofVlayzdhBP1ACtVGSLsMm1k6Ugny5D4PIaP0tlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745586317; c=relaxed/simple;
	bh=4knc6zk55EjUi7YvMPgbHvB69e8SXVuYN6cNjQD8WVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QEFNHLPMYsm9LdL6R2ck+I7SbRC+/ZEZNskglp5aMu3FD8FE2eEjGkf6PP/tQQxlPpYguw3BvyGBvC/Pkq2CE7xvOfaVgYPAKltFttZoD1fJiY7Mdio6OLVhQ0gPHX5yhh1icHq7vLQ2dHeVXKut0b+zqCa1s9iSkqiax/dl0io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pzyOup1Q; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53PD57E12176482
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 08:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745586307;
	bh=NFP2W2jmPvIjX4SKsg8ordEsFDwm2ltfl5D0WhF7rH8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=pzyOup1QdVC49a8w2KlyxMfn+vrDnXsxZuqzZe98WNl+tSjvQ21J90l3ZpYDAl571
	 +DiVrH0vDyLyfE/VmdJ45ePkh7oEmMP+S95EazUktqr0ejM4EdKlg5if0oiCXWrGFT
	 RIdQiKOH91Du2txW5oQ4P/OuLX0Pdk++YSSh55Aw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53PD57Mb019281
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Apr 2025 08:05:07 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 08:05:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 08:05:06 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53PD51Bn053981;
	Fri, 25 Apr 2025 08:05:02 -0500
Message-ID: <c63cac69-6cfc-48b9-81a3-42a88dcd74f9@ti.com>
Date: Fri, 25 Apr 2025 18:35:01 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-j742s2-main-common: fix length
 of serdes_ln_ctrl
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <u-kumar1@ti.com>
References: <20250423151612.48848-1-s-vadapalli@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250423151612.48848-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Siddharth

On 4/23/2025 8:46 PM, Siddharth Vadapalli wrote:
> Commit under Fixes corrected the "mux-reg-masks" property but did not
> update the "length" field of the "reg" property to account for the newly
> added register offsets which extend the region. Fix this.
>
> Fixes: 38e7f9092efb ("arm64: dts: ti: k3-j784s4-j742s2-main-common: Fix serdes_ln_ctrl reg-masks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>
> Hello,
>
> This patch is based on commit
> bc3372351d0c Merge tag 'for-6.15-rc3-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> of Mainline Linux.
>
> Regards,
> Siddharth.
>
>   arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> index 1944616ab357..1fc0a11c5ab4 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> @@ -77,7 +77,7 @@ pcie1_ctrl: pcie1-ctrl@4074 {
>   
>   		serdes_ln_ctrl: mux-controller@4080 {
>   			compatible = "reg-mux";
> -			reg = <0x00004080 0x30>;
> +			reg = <0x00004080 0x50>;


Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   			#mux-control-cells = <1>;
>   			mux-reg-masks = <0x0 0x3>, <0x4 0x3>, /* SERDES0 lane0/1 select */
>   					<0x8 0x3>, <0xc 0x3>, /* SERDES0 lane2/3 select */

