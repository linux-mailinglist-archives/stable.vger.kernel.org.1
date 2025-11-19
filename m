Return-Path: <stable+bounces-195152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 418D8C6CDAF
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 07:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25C744E47BA
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 06:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631E1313525;
	Wed, 19 Nov 2025 06:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZJNE1eOV"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010063.outbound.protection.outlook.com [52.101.193.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE34E313284;
	Wed, 19 Nov 2025 06:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763532284; cv=fail; b=fvc67lC0pmQF52+bpedwlshwAnaCTIu9rllizGDHOTx6Ka/tlNuQ08+yrS1n9SsZVSSOLGhzdkCRuBU0Td4MbM/Ni8RGmsCVdiI5kXaHzdECA8s6OFG2TUlkosPdJSBXpS7tYPKkHZ+f1T5kctKG+GX0cQeLUaqGrZ09VO6Ioe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763532284; c=relaxed/simple;
	bh=WQqvh/eLtFwhvmIIs9kKq5KiDArXTmNxvjcPfWMZy1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GcOXCK2Y9O1IHN2n7iQW+YuG1Tou9C80Z60CNHae7UidMN7eo1zFzpJqO1KnGHrVUi8jaezr4pCM19/UWHpK287MKXDTEZdtlIonI8ZZSSboxtxaN9nkQYaTZf68PLu/Qni8GqqEATHG28tqWNIZ+nE9gU0YzdoVIcx+HdOK5qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZJNE1eOV; arc=fail smtp.client-ip=52.101.193.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPx92fDUCEZOWjxB+lILUQBdy1fka3TUsIMTiscB6Wrjc11LyJbbkOSg9bmZ5qEuqwoIFL4RiXVj2jLNT8dksBqYotY10sn3D+EeOBs+rItGjUqTHwdiMgszlUPDxsOI4LKZUpa9+vvRHUKbF67IdqE2YNdUyghAN6qMG3SHLVe3KZR/MW142r5DdPS9yPetTtNwfLMdOS8BhLeNpMUkoB4HPeoiRFDHejY33IEnuWIOr5ziAVuFfiagb2HFFs7fCUv9naE6A+4deXSebfjWi/utimjYempc/cXiWU+WMiv0jfmN30xcAGYN9x5S8/07c2DPlbvOVanFtLwGT1fKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X34lwOveGxGf8hIQBxBifjTAZUdkGb3OASnRJ+2QeHk=;
 b=aCnkxIH8towBQJeDl2ljNRRq/bymOhgwmVb+lDJsrSkY9D4jywvjJynIQLwWsQwlb4OQ3QHDUvjtXXGAXXg5aiyosJkM1ftoZWDwJ2Bi0NLOAbF+ZiFDxfF+g3Z0xInw3SmcXy8OmWJqCtOFtXxQoU3yfBXrWe4Bi/a7iNbOzd//JSU4t0v6Nqk5mylgtuvbH/EIz22BqVefa2LuLOkJUVh/+OMDuHPXXgZI8s/UN2wPbDr429yHbpCg4PO87ibrRmA1+qGqN7pWjiES3bIZsgWAEcZnPu+kZo4V83BQ11VtdX8VTUKGX1YVmqJBQK/ON7/4IcX25W99i42i/C/67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X34lwOveGxGf8hIQBxBifjTAZUdkGb3OASnRJ+2QeHk=;
 b=ZJNE1eOVh6u+LIK6DFe0sAPJ68r/1GOEE9ugTFCQuBIfmSaeHLFVdgkab2s4PG3xF40x/+hJODH/xLDg/SPPKdj06Eiuysd+tZUI0v4RtHB1qzxwUqj/qYxNoyw96CLj1rSdUeV/j9KFg1QR6iocasWIrgNcCU6J1LwuXOECFzY=
Received: from SJ0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:33a::33)
 by CH3PR10MB7680.namprd10.prod.outlook.com (2603:10b6:610:179::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 06:04:37 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::92) by SJ0PR03CA0028.outlook.office365.com
 (2603:10b6:a03:33a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 06:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 06:04:36 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 00:04:34 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 00:04:34 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 00:04:34 -0600
Received: from [10.24.68.198] (abhilash-hp.dhcp.ti.com [10.24.68.198])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AJ64U0D1379437;
	Wed, 19 Nov 2025 00:04:30 -0600
Message-ID: <b61aea84-f77e-499e-be1e-3441987fa460@ti.com>
Date: Wed, 19 Nov 2025 11:34:29 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e-sk: Fix pinmux for power
 regulator
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <u-kumar1@ti.com>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>
References: <20251118114954.1838514-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
In-Reply-To: <20251118114954.1838514-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|CH3PR10MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c91eb63-61df-4c98-ec14-08de27318478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWtEVkw4cUhFUmYxTDVvVElhWHRKRXJheUJ5MFhhN0tFVmJCdWs3aTJaUTRp?=
 =?utf-8?B?Znp1U3JOc3FvQVlOalJwenJ2a1dmaTBOZnFjdDNuNjRkMmpnVCttQ21IRVFM?=
 =?utf-8?B?M2p0RlM0Sy9mMytIaTRWWTN3bER4R0hpMGdWM21HM2hqVTFBRWFpUDRsQlpW?=
 =?utf-8?B?Vkp1N2VqY2xkQWx5Z0ZHdlovRkRpR0lRTGRVNExnSVYzV1JVM1lZMGM2Zjlq?=
 =?utf-8?B?cExaNFRlbk1LQktGbkp2emhEMmVQY3E1bXp3Y0pTZnBxdDNod1BPMklQWWhy?=
 =?utf-8?B?cUU4Uk9rMkxiTm0vVit3a3YrTDM0TnJQTXcrcDdzNVZUWlROTmFXZ0NWU3BJ?=
 =?utf-8?B?MHU1cEp3Ynp2ZVRaZ3ZCbWpRVE15U1pWYWpYY1NvVXRmL24wZDJvOE40Si85?=
 =?utf-8?B?ZklUa1B2Qjk5WFZOMFozUk5UdnJjYlVwT1lpR3FLazNteElIdXhYME13bTdQ?=
 =?utf-8?B?UG4yeGo3bnQ2YTg3NDh5ZnhVeE10eWVMdzJ6bXVhVnFCTFQ3R1JOcEtucHR1?=
 =?utf-8?B?T3BXMmxDaFFvUWVBa2NCY29FZjhTSHpmemdtcitTdkRlTGsxZXExdUpLcWEx?=
 =?utf-8?B?dDAzZmRiSDNrS044NkhUOUtzSThhZkFOQWtBYTMyUkkyV0k0a2VGbHVPQ0ly?=
 =?utf-8?B?UjN2RkZvTnFtNVhqQ2VMdk95M1FDVGJJWkZlQ3RGcE80S3ZUaTVDblllejZm?=
 =?utf-8?B?QkQxcXhRbDNHV01ZWnVncUhYQ1Mvb2ZTR05MRXIvbVNvWWoxaTUybWVMVHRs?=
 =?utf-8?B?M2gxR1RhU0d4eHFuMk5jaThFYjBrclJZdnAyNTU5TEFSSm9XVFlaa2ZUSUY5?=
 =?utf-8?B?N09yTFFLdm52Y1AxYkhXd0xYa2RUanRFcUVKQzFmZk5EKzVQYVNTVGh6M2Yy?=
 =?utf-8?B?ajQzb0NYZWdvbEp4V0dKOWFScEZ2cEU3L1F0WkFRejVOOGVac0xYeU1yc1dC?=
 =?utf-8?B?bitwSmFzdXlYTHFacTlEMHQ0OHkrOEJoQ0ZJSGM2OWJ5YzhzNlpaYUpKSnVj?=
 =?utf-8?B?YW9YdkRBSndJajBNelRWN0pDNldLbWczTDYrQnBrR2lQNnYwQ3NOVEpIUVlK?=
 =?utf-8?B?Mms2aEsxU1I4bWtHd3hENTRVa0xoQkhPamhLd2duZHluQ0orTjlmbmdRRjhS?=
 =?utf-8?B?OEE0UXNqb3lPcERhUmFFM3gvd0NmdTcxbDhJWFZGY3o4UnRYTXMzUVVpbjB0?=
 =?utf-8?B?QmEzMmY0a1g3dVlRQVdWcHQvWE9jSDNNb0R5SmpVT0x5WVl0ZENhWEdobXNV?=
 =?utf-8?B?RVF4c0dnc0hPSVJvNE04WWU4cEtHZ243eEowZ2hYVUt4WUx4NVhUREdwclV4?=
 =?utf-8?B?b3FUZ3NIOU5KQTlVd1Qra2xxSlY2VzJGOWg0T3hLQmUzQ25rZFh1b05QOWdx?=
 =?utf-8?B?SnM1Sm90KzhmZXlYTFFQZ2hOenJDcE1CK28xVG8yWVdCNmVXM2Y4R01MdytI?=
 =?utf-8?B?cTVDVm5PcHNXMmY0TnpjUjFaWWJrcys0Rkp3aXRTWUhzSU1seFVCTkNyRlht?=
 =?utf-8?B?OWJPYXIxdmovNzlZYitSdHFBbmtDbDJqQTIvcHZVSW1BclkrTkRvSDlCNlJF?=
 =?utf-8?B?enVpYWx1MWlLdzFLVXA0SGhJNVJpMHRqMnF0TWU3dk9lTERRbmh6QUtRUk5L?=
 =?utf-8?B?RHNab2h2UUkzT0JZQ09VV0VKWTJqa2xsYURESnpQbm9qendLaHljSWVoL3BY?=
 =?utf-8?B?TUlQV0hsUkUrc2I5ZVhNK1R3R1B0b09hS0Q5U3dtWkUzL1BsTlN1WGJ4N1d5?=
 =?utf-8?B?Z1NYTCt0Q2cxbU1ya0tOR0p6UVpEWUFyK01JYUxrNUUvcm1zamJzWjVCVnFw?=
 =?utf-8?B?c2pVRnpsc1VnOCt4V0F4d0RIbnZJak9hUU1OVXpobTI2SGg2NW1nQkUwSSta?=
 =?utf-8?B?dHRtaWluYzRUbUJESWFWZFZnMXpGY2dhR1JFWXlGbG1lcnNWdGJ6K3FvMDRF?=
 =?utf-8?B?OUF5QlE1RkptL2JwcUM2dWVyZndxQmk4azdtMGIxUEx1cHVnb0JLaSt4SS80?=
 =?utf-8?B?V0diUlI1ZkxIUmhxZ2tzamo5bzFvV3hob3BzZGI2MzU2Z1B1bnRPMENLSFF6?=
 =?utf-8?B?YUNvOHVxdTAvSktxdWlSWnlmTDErUUFGa2JJQkVtZUpodFNCMTBnbitMRGls?=
 =?utf-8?Q?qWfc=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 06:04:36.1208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c91eb63-61df-4c98-ec14-08de27318478
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7680

Hi Siddharth,
Thanks for the fix.

On 18/11/25 17:19, Siddharth Vadapalli wrote:
> Commit under Fixes added support for power regulators on the J721E SK
> board. However, while doing so, it incorrectly assigned a non-existent
> pinmux within the WKUP Pinmux region (pinctrl@4301c000) instead of using
> the MAIN Pinmux region (pinctrl@11c000). This leads to the following
> silent failure:
> 
>      pinctrl-single 4301c000.pinctrl: mux offset out of range: 0x1dc (0x178)
> 
> The datasheet for the J721E SoC [0] specifies on page 142 that the
> pinmux of interest which is Ball Y1 is PADCONFIG119 and the address
> corresponding to it is 0x00011C1DC which belongs to the MAIN Pinmux
> region.
> 
> Hence, fix this.
> 
> [0]: https://www.ti.com/lit/ds/symlink/tda4vm.pdf
> Fixes: 97b67cc102dc ("arm64: dts: ti: k3-j721e-sk: Add DT nodes for power regulators")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>

Thanks and Regards
Yemike Abhilash Chandra

> ---
> 
> Hello,
> 
> This patch is based on commit
> e7c375b18160 Merge tag 'vfs-6.18-rc7.fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs
> of Mainline Linux.
> 
> Regards,
> Siddharth.
> 
>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> index 5e5784ef6f85..77dcc160eda3 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> @@ -474,6 +474,12 @@ rpi_header_gpio1_pins_default: rpi-header-gpio1-default-pins {
>   			J721E_IOPAD(0x234, PIN_INPUT, 7) /* (U3) EXT_REFCLK1.GPIO1_12 */
>   		>;
>   	};
> +
> +	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x1dc, PIN_OUTPUT, 7) /* (Y1) SPI1_CLK.GPIO0_118 */
> +		>;
> +	};
>   };
>   
>   &wkup_pmx0 {
> @@ -536,12 +542,6 @@ J721E_WKUP_IOPAD(0xd4, PIN_OUTPUT, 7) /* (G26) WKUP_GPIO0_9 */
>   		>;
>   	};
>   
> -	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
> -		pinctrl-single,pins = <
> -			J721E_IOPAD(0x1dc, PIN_OUTPUT, 7) /* (Y1) SPI1_CLK.GPIO0_118 */
> -		>;
> -	};
> -
>   	wkup_uart0_pins_default: wkup-uart0-default-pins {
>   		pinctrl-single,pins = <
>   			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */


