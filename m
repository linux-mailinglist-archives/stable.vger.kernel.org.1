Return-Path: <stable+bounces-119891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E862A490E6
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 06:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB3E1881CAC
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 05:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CDA1ACEAB;
	Fri, 28 Feb 2025 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LsKAWzhi"
X-Original-To: stable@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889871EEE0;
	Fri, 28 Feb 2025 05:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740720815; cv=none; b=dNuFqZagbykUiOJtio+oQJkyvSeWRX3Gn/cuBRgYKax9ZpmZUUDcNghbGAwlr1QPZQydRmhW9/VRwCGv5V1lr9b+WQhxjYOQJhx/jq6BSdKgF2CiockRztN+wBoUM1TFUY+6hby4S7HuyZQQ7t0DRGlWf6OWu1LQVjPPOYMlYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740720815; c=relaxed/simple;
	bh=hlrgWTDZE96RrdznOc4Y4p/u3TvfGfQxDspHqGzMwH4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/AR5uDNOydFj/aARvPwm1ORXgvsxnndJfAp+YxGwJxXqpNZpH8bDaxGocjiLJDEe5+DU/4OfAQmkju8oI2Ds3w1JQMtnPR2gwBJe+K02zxatc/iSJu3NWV4Gfy9+n5I7mrwT28gpCwDJyBDKKFyT/jDtUNcabqo3U/4TeY88VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LsKAWzhi; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51S5XOIT1964122
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 23:33:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740720804;
	bh=v+xos08V2sWXcFWLKiVVATbXyOouS4eSGAsrdc2THPY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=LsKAWzhi6SZ11jwjd7NbfKpZiC6vNJeI3ggFOkbfytK+pEF3a5JVlAMjuLU1rWMVk
	 JMom3ntAt+eOjcpOnOl/K666GJUTeRsS6TXln0bMM4gNEOoBBzo8XwESCQIEkfTAI4
	 5zFCFbxtC4G2MgKeX+c9d4GRKRm8ulyU3fAivmus=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51S5XOGt019559
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Feb 2025 23:33:24 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 23:33:23 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 23:33:23 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51S5XMrJ064044;
	Thu, 27 Feb 2025 23:33:23 -0600
Date: Fri, 28 Feb 2025 11:03:21 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <j-choudhary@ti.com>,
        <rogerq@kernel.org>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-j742s2-main-common: Fix
 serdes_ln_ctrl reg-masks
Message-ID: <20250228053321.pekdadgl4ebscsc2@uda0492258>
References: <20250227061643.144026-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250227061643.144026-1-s-vadapalli@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Thu, Feb 27, 2025 at 11:46:43AM +0530, Siddharth Vadapalli wrote:

Kindly ignore this patch. The register offsets should start from 0x40
since SERDES3 is not present in J784S4. I will post the v2 patch fixing
this.

Regards,
Siddharth.

> Commit under Fixes added the 'idle-states' property for SERDES4 lane muxing
> without defining the corresponding register offsets and masks for it in the
> 'mux-reg-masks' property within the 'serdes_ln_ctrl' node.
> 
> Fix this.
> 
> Fixes: 7287d423f138 ("arm64: dts: ti: k3-j784s4-main: Add system controller and SERDES lane mux")
> Cc: stable@vger.kernel.org
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> dd83757f6e68 Merge tag 'bcachefs-2025-02-26' of git://evilpiepirate.org/bcachefs
> of the master branch of Mainline Linux.
> 
> Regards,
> Siddharth.
> 
>  arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> index 83bbf94b58d1..a5fefafcba74 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
> @@ -84,7 +84,9 @@ serdes_ln_ctrl: mux-controller@4080 {
>  					<0x10 0x3>, <0x14 0x3>, /* SERDES1 lane0/1 select */
>  					<0x18 0x3>, <0x1c 0x3>, /* SERDES1 lane2/3 select */
>  					<0x20 0x3>, <0x24 0x3>, /* SERDES2 lane0/1 select */
> -					<0x28 0x3>, <0x2c 0x3>; /* SERDES2 lane2/3 select */
> +					<0x28 0x3>, <0x2c 0x3>, /* SERDES2 lane2/3 select */
> +					<0x30 0x3>, <0x34 0x3>, /* SERDES4 lane0/1 select */
> +					<0x38 0x3>, <0x3c 0x3>; /* SERDES4 lane2/3 select */
>  			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
>  				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
>  				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,
> -- 
> 2.34.1
> 

