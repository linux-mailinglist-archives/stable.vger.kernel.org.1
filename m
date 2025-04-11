Return-Path: <stable+bounces-132257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93109A85FE8
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50591BA6AD3
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 14:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7491F180E;
	Fri, 11 Apr 2025 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OTJw5ugN"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB03F8635A;
	Fri, 11 Apr 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380131; cv=none; b=bbbGvX4i9PbZO3Va9xdoydQR0/nMJb7+KX7PehxWvp0XZAUNDjHa7M129ldlU0k5FDG1jSOLhlWe07Q5VGjCNwIntIuuxPc6P4JGw0AGBqkAham0YBCN9Fd7sbjGR2dIssupcvsm0FRXuOR/2mtazOsE0WNkEPq+0DnYVi6wP5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380131; c=relaxed/simple;
	bh=q/DKf6OWuSdOgKa56EAtz9WZzfj6dx/OHtCNT2ExXeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oKtVpAoYCTnVQLgmsDks0YmxAayQWwxriMGA8Y6DW7DdLx7vbmDzmyJmeaoFsxmpdYQYt0gsLDfRUSMfWL0+4BWc5gEuPwvvYvJk/UspPoEEx6lGO9LNElZrquxs2vBLmjkLIyjuPxauckfz2UuAG3nAsa7of+P8I559VB3RCtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OTJw5ugN; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BE1w511458980
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 09:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744380118;
	bh=Genc+foR3TLZU1XFpVYp4UeiPJ0ZTyJwWiJkAOrjZJU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OTJw5ugNRiRefNzTa0I1IZ9RO1Er+xZPNrg9Pa++8XsYAQAyQi+BBXx2h+iNtuOAb
	 Wy9lOthCxRPOV33NzxIfs4r48KLgpcbwDXoAfQ+QviEhS4mxsOYZnc86kckG0zOShG
	 0NNndGpv1a9zPejSxb/wk+SPJ0PTK9rVkBGM86mk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BE1wtx097818
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Apr 2025 09:01:58 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 09:01:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 09:01:57 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BE1rOJ020355;
	Fri, 11 Apr 2025 09:01:53 -0500
Message-ID: <7b2f69ad-48aa-4aa9-be0e-f0edae272bdb@ti.com>
Date: Fri, 11 Apr 2025 19:31:52 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-j722s-main: Disable
 "serdes_wiz0" and "serdes_wiz1"
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <u-kumar1@ti.com>
References: <20250408103606.3679505-1-s-vadapalli@ti.com>
 <20250408103606.3679505-3-s-vadapalli@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250408103606.3679505-3-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 4/8/2025 4:06 PM, Siddharth Vadapalli wrote:
> Since "serdes0" and "serdes1" which are the sub-nodes of "serdes_wiz0"
> and "serdes_wiz1" respectively, have been disabled in the SoC file already,
> and, given that these sub-nodes will only be enabled in a board file if the
> board utilizes any of the SERDES instances and the peripherals bound to
> them, we end up in a situation where the board file doesn't explicitly
> disable "serdes_wiz0" and "serdes_wiz1". As a consequence of this, the
> following errors show up when booting Linux:
>
>    wiz bus@f0000:phy@f000000: probe with driver wiz failed with error -12
>    ...
>    wiz bus@f0000:phy@f010000: probe with driver wiz failed with error -12
>
> To not only fix the above, but also, in order to follow the convention of
> disabling device-tree nodes in the SoC file and enabling them in the board
> files for those boards which require them, disable "serdes_wiz0" and
> "serdes_wiz1" device-tree nodes.
>
> Fixes: 628e0a0118e6 ("arm64: dts: ti: k3-j722s-main: Add SERDES and PCIe support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>
> v1 of this patch is at:
> https://lore.kernel.org/r/20250408060636.3413856-3-s-vadapalli@ti.com/
> Changes since v1:
> - Added "Fixes" tag and updated commit message accordingly.
>
> Regards,
> Siddharth.
>
>   arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> index 6850f50530f1..beda9e40e931 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> @@ -32,6 +32,8 @@ serdes_wiz0: phy@f000000 {
>   		assigned-clocks = <&k3_clks 279 1>;
>   		assigned-clock-parents = <&k3_clks 279 5>;
>   
> +		status = "disabled";
> +

Since you are disabling parent node.

Do you still want to carry status = "disabled" in child nodes serdes0 
and serdes1.


>   		serdes0: serdes@f000000 {
>   			compatible = "ti,j721e-serdes-10g";
>   			reg = <0x0f000000 0x00010000>;
> @@ -70,6 +72,8 @@ serdes_wiz1: phy@f010000 {
>   		assigned-clocks = <&k3_clks 280 1>;
>   		assigned-clock-parents = <&k3_clks 280 5>;
>   
> +		status = "disabled";
> +
>   		serdes1: serdes@f010000 {
>   			compatible = "ti,j721e-serdes-10g";
>   			reg = <0x0f010000 0x00010000>;

