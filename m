Return-Path: <stable+bounces-222908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMs7FDAOp2k0cwAAu9opvQ
	(envelope-from <stable+bounces-222908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 17:37:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 134B61F3E8A
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 17:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CADA301DA72
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 16:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AC24F796D;
	Tue,  3 Mar 2026 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ShGOIDRv"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8514F7971;
	Tue,  3 Mar 2026 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555804; cv=fail; b=X5yeSnxlHnXETNMpLE49IebXiKwiMdGlULBMKWhw5RiA5rtxrv3c1HrZ3TvVz3ajZ8c39zkSTfvNVxcSeB0Mzwf4GagfT+hzqEIsRZbd58zQSXU1+JpPf3kfAF86OgTgT/JNF4N3mys2hB3w1Lfe9wXW7knqiiJ7oqBRWsIf7ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555804; c=relaxed/simple;
	bh=ydWkXqBppfgzi2ybWs8bp7HA3HYrmX4QaOOv1lNsQqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BxQYl0IxRbmrpTJCK2lmt0s2BcLZI8eTzkhdTYcAdHcoSK2cvOxp9MkWIsD0OdGPwoARnA3rsrcQwS+UfDrgBxyWL+mx2dvzsfwzZt5jzS7GTgVssuqgOVzUOfuiRZSiwedKLyuj0t9/A+5lNbkadZHcgUzbQQPbhr0Y70VBdS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ShGOIDRv; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTBVt7uX4+8FTmApvZZ81uss4jYI4fWrqmjDziBsdszcs9qo68QxkIgPKxjXI04CxfQGcqWeoc5eLurJbr2qaFS15Kddil5WRmpjgIP4jvHEvBBQae5CLmfIj6SOsuALw3idEwgId7vjpkDbTrluaFP07Cy59vuEIN0SASRN0CL/nBxG/EpBu7BNIUEJ981bufkS/G9vnGt75MLRLSlLko5lCA/8yuLkYPAfOKDAmyy9RrxzkH9ugDHqHMmIgBJqFFeIGLD2Hgm9hDj3zEf7cDHqOL4wYpWMKz+Hr7U5WDSY2gTniQQAcTc7F7DSw6SeUmykMz+HkP2GlnIhUGa5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSJ/LqL9F7vLzB7f0vJCbvix4YPeTSl77YE7feAOTFE=;
 b=E9bfXUvcymp1tWWHzjtTlBRAlgWn2O8xM2Gpk6hloJ9YpMWZAqmeeF+/KUseP+WbDKU0acykiAHOMDbzs54R3RuEadMrprwCGafoZ5YfsXy5BtmIh7vrF3kxk2zTZeOQ/w1hiSXyFKK2qjIttoBDJ4DROWUArq2cj52OmaFPfbzhiLxo9gavgjNUwB3A8s/9pUxgTYjCUnHR3SslSiCpUQa+7a5ShPYI6z4CMRUJLh1rhwSH76lElXefcJQDP/gb2jsBnMw1LM5or1xpzCOyATO706hnTeTCBaxgzQ9aJypU/QA5dAtq2rqhQgWrpO+mtRwQ6VRyjsVKLmU+R9kfuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSJ/LqL9F7vLzB7f0vJCbvix4YPeTSl77YE7feAOTFE=;
 b=ShGOIDRvN3HE6RVWnLIhXgPNiO5fqQf7zOCrC7eRIWfICpUA7hw28v78pK2mvC2sf1eOh6RxTnGVBGliMveUjMt95dR25gloO+auAdsgvPHQ9Nv05ErAMaALY80Yx5IoLtzuNruH0Kabq7LSY4KNR+XzQzutpUXuglhHSk1AcYE=
Received: from CH5PR05CA0024.namprd05.prod.outlook.com (2603:10b6:610:1f0::29)
 by BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 16:36:39 +0000
Received: from DS2PEPF000061C4.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::f) by CH5PR05CA0024.outlook.office365.com
 (2603:10b6:610:1f0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 16:36:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS2PEPF000061C4.mail.protection.outlook.com (10.167.23.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 16:36:36 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 10:36:35 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 10:36:34 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Mar 2026 10:36:34 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 623GaYaC2453259;
	Tue, 3 Mar 2026 10:36:34 -0600
Message-ID: <0633e48a-27a3-456a-8b9b-32e88d417560@ti.com>
Date: Tue, 3 Mar 2026 10:36:34 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a7-sk: Fix pinmux for pin M19 used
 by sdhci1
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>
References: <20260212130843.1054100-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20260212130843.1054100-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C4:EE_|BY5PR10MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: 904ea5ae-6dfe-467e-4e1e-08de794309e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|34020700016;
X-Microsoft-Antispam-Message-Info:
	US6jwP98kDl570g+5KBRUiQPNGas3UnPdYroqChYaAKiEshYLHzKAODM3ydp5M33pAkDE7MOdM8JNaMG8eku9LPr0hyS51BSQLkoJOFdbmVhCrm8WR0lbR2zi8R+x6rMzT5uajt2/HxxaJCqG4Ia/0ABh7i/NEko9HcGdjP7xFYGgcBqk7B4t1JaHt7rQh+/GPGLe6owSNZ3y44r4gM7/ZsoCjMg2EPHmL6IXqS8UKiJPdVluJz6pZRo3VPedLdt+Lyw7GLY72w+wk9G12h+YFSe4NMkrMIAAQTn8asWeim1+G2351XwwtS4pVtfV9ll26kuyaKNunJzgfBwRgeyA8Xb73/MKpYdu+KMFsgAwzRnI+UNu5zC4ur9fZReXBqbF+piZyHe9TcWtrePg2FNGkuRTPxKoVFy474i//+R0NqijLs50xJkjdQaqpaGW6HiAimBVXLUH+gEzg0GxrfNSrW3h9IJVPP9DEwLsCGZMHfzmFuQfy0cNuGKd4uR/mNo7dTYEOm/xlJEDlctDsajM4c66tTb75PqMhMLfE3o293KTuHJwkCbnLwJohHVIW7b6I5nCkfPBzhJDva4cajF4P82OUs8P5GKFAv7G9uckdlk30WKduO6Kf0U7o4JPQvLRSuLC+RjmHhQxwT18vQFgQ/aGV3S8zG/wzWA+cEM0txSh7H4gmfuawAqXk5O6zhbvpuU5MWx6Knw/YTn85XQvukKYQAaQ6z0mW8E0tSkR4VgADy302ruSxXxHxVjjA7DEh8BNUgdRo/IdGEmcgP8O3MNXoQw1GanN7Kg1+gJqoH/kXObnQAnhvdRkXFMjJPfcDoJUGRbzaDDkQuhhOQwEA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(34020700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ka526NF0zwRpJbOC1qf1C0EQoay8lfI33Sh81m8q7pUIqN5PqWOBtIUp0Mi+wWWwxF6Eh9fqw/ZROpN9n85BKbBCbYDnwcbo9Es+6aMdiizKfE39niNdd4u/uT6r9GXEnUmmHaBfdIduMaQ1cZVtOXCRiy7kF6yFlGHYno38WBAvA7F+ALOqcATNXI+9BtqAnM7c92RvReGVF2Z2AJsMP27IhmmMp3g8awt8VoHzWrMSmZ1mUALFq+2DdjShGXIrpqKvCX0OPnY99Awqx5MYc8S5Ivmcscu95BrkueftQz3ccVtEv7gQ5XQ9fenGVQanPHVrC7bAhVR5TYZRvYx6EJr+fTPSHTMG+bEx6fV68TBObKG3Fm8Bc4y382bqFCUt8Xj/rjYUfsXR0Sks0VJqAEazLUmgTXeZSFojYdm+CkmBKW3nrcOAKrhUhDk3Hvo1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 16:36:36.8282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 904ea5ae-6dfe-467e-4e1e-08de794309e6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4371
X-Rspamd-Queue-Id: 134B61F3E8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222908-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jm@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Hi Siddharth,

On 2/12/26 7:06 AM, Siddharth Vadapalli wrote:
> According to the datasheet for the AM62Ax SoC [0], pin M19 has the address
> 0x000F40A8. Therefore, the offset to be passed to the AM62AX_IOPAD macro is
> 0xa8 and not 0x07c. With the existing incorrect offset, the following error
> is seen when Linux boots:
> 	fa00000.mmc: deferred probe pending: platform: supplier regulator-5 not ready
> with the SD Card being unusable and the boot process halting due to the root
> filesystem in the SD Card being inaccessible.
> 
> Hence, fix it.
> 
> [0]: https://www.ti.com/lit/ds/symlink/am62a7.pdf
> 
> Fixes: 8f023012eb4a ("arm64: dts: ti: k3-am62a: Enable UHS mode support for SD cards")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 37a93dd5c49b Merge tag 'net-next-7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> of Mainline Linux.
> 
> Regards,
> Siddharth.
> 
>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index e99bdbc2e0cb..9cfe7e7b317b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -398,7 +398,7 @@ AM62AX_IOPAD(0x01d4, PIN_INPUT, 7) /* (C15) UART0_RTSn.GPIO1_23 */
>   
>   	vddshv_sdio_pins_default: vddshv-sdio-default-pins {
>   		pinctrl-single,pins = <
> -			AM62AX_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */
> +			AM62AX_IOPAD(0x0a8, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */

What! I don't think this is right.

Looking at device tree, regulator-5 is using main_gpio0 31 to control SD
ENA with PMIC. Which is GPMC0_CLK (N22 pad) and VSEL_SD_SOC. Which is
0x000F407C address in the device datasheet. So as far as I can see, the
original address is correct and just the (M19) name is wrong. Did you
test this patch to see if that fixed the failure?

~ Judith

