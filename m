Return-Path: <stable+bounces-231416-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGnTAO28y2kwKwYAu9opvQ
	(envelope-from <stable+bounces-231416-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:24:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8FE3696DE
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F51430A3C87
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460233E1D05;
	Tue, 31 Mar 2026 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hujSxz4T"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E311A6826;
	Tue, 31 Mar 2026 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959561; cv=fail; b=ty8L6cjOB8Pboc8q7FyRnqCngjAUf8xvPpITRMY573jaiG2Uh/PkCLkNmzA4+/pye3Ox/Vkv3rpFb9u1KVmFzSBcSKa03GOYG45FrTw5/5slEZgPPx/KPC6q4w7+HJpQGH3Uoyx222yLXE5wF3fiNru4Jk4h9Y4oKF8HSBgi0PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959561; c=relaxed/simple;
	bh=zdHp+vzdyMRbVEdAuA1cfvzY3ayE6FRIsaWRrEjd/fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JgKWszQtHwmfuHLDGRO/eYcVsigLFQmX39qFUKlVZD3lvkCz3xSvi/KKuSioarvhDgB1p+9Up1zS534zUAAvKoFfSNDY29h/BJY/+xoyJy0bZmHB4Th6YWs7qw4slo6DZxCHsnJVYZNn36+A7axYQ0+2ChkrwEoVyeCp2NMBJbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hujSxz4T; arc=fail smtp.client-ip=52.101.46.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npEhU/BoNnKcpahuD0xn5vd6QeyTv9xmrpUymnVEglkckme9+9YohNGZq3nr2BHGKnn2vLSldFHP/4nv1ZiR5S+zvHf0q3kge/ovnGn2n6aCrpTkG2DM/LgeNN/DWBc64058MNG+kgkUIeXVt9pNy2LMexX/0XAwVH2zlUo3093wO8g3MDxXhyhKez1s1Y8Ysa8VmfZyGc4897evRNuuM10lGLLaGUOKmPi+X5/uSp+6Qi5bbE8VhN+pd4tfHpX+bLDP7evgzHZC/zxcglvpxm5HEh5xBCGiLK5HzHmLGADiHn4vkLutP/npwm4byF7juSuEx5cRIfNCdvpE1kUi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJkXpP31qfsrEm+q5zIu8YXx4jAqFbEaXndk6NE+lpo=;
 b=GujBUK8cQIKLXkOULVG/BlbK4CKFjnkoOju8K1Z6+UamcUFDg6iby6HYyfUs6qYRegknlsXohboy+l8helZFUamOo6JPVGOMG8pO9citLq2H5RVssqovEaLN6d6JYWakq9Afjs6hUsFTeEeBMVgpvvF6g/jxGqQG1j0Ntd+LH88SlwN+Hugab9scZHZgoLVA1EQX9RstHBa4e2z+PT5wzNFMP2gp9AELQ/U4KBh9xcNrvCXtnx0AHc97Dwhj9ymw9irT2DfUbWuPajgNsmVWu1uNyYYJMQOn2GV3x1rNSboViQDwz35v8DbV1LW5/6HJGw5620Az3CRPUlb10gCbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJkXpP31qfsrEm+q5zIu8YXx4jAqFbEaXndk6NE+lpo=;
 b=hujSxz4T7M6uER5kAz+lpKKW89wPATQhk4M6rIfpLYuXzzaDyJ8E4rnPe+tKavUGHhCUIi1svwmGCRClZG3TQge32ZYArqzNK4tSayBiivddSua13QePU+YJCXp0in5OhDfCcvPTGLl2HL/u355uuFLDt+0mgRb47CcEh78gU98=
Received: from BL1PR13CA0181.namprd13.prod.outlook.com (2603:10b6:208:2be::6)
 by CYYPR10MB7625.namprd10.prod.outlook.com (2603:10b6:930:c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 12:19:17 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::a2) by BL1PR13CA0181.outlook.office365.com
 (2603:10b6:208:2be::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 12:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 12:19:16 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 07:19:14 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 07:19:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 07:19:14 -0500
Received: from [10.24.50.20] (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62VCJBLW2736751;
	Tue, 31 Mar 2026 07:19:11 -0500
Message-ID: <8d4a2839-5b1e-479e-a462-dbbc3d016020@ti.com>
Date: Tue, 31 Mar 2026 17:49:10 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e-main: Update delay select values
 for MMC1/2 subsystems
To: Romain Naour <romain.naour@smile.fr>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-omap@vger.kernel.org>
CC: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>, <stable@vger.kernel.org>
References: <20260218203823.1825554-1-romain.naour@smile.fr>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <20260218203823.1825554-1-romain.naour@smile.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|CYYPR10MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ac821a-90b6-4091-7baf-08de8f1fba1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YDZY9pS2mxUv2NlCjHnkHzMyjZFXtF8isjMajp/vKg9e9JhoVP4XWctsfL//dGLKG3IUBxtz3irQgd0ycvt97tS27uip2fPj1ZfR6blbRE2+Q1kFuASn0wb1rF4FGwgcvjXoMhZnltkARymMMTa3GmcH+UE93iKKgxi+vMrhYMQb3Rqjfxjkjw9VkZZpbf4/vBkXq3nFbIK0ul266lX7Y8knzmmZ9ykpY1YutOYYnjnbsQLbE2qI9YFM4hshcYI/y/Nnxtgx3iUbHDtjFr6sN6T6g22pdmnkMVUMIZ6p4/hIuqiJI6PbMo4N3nbdFeWhuwdGLwWTOq/msimdiG1ODOgbSOWlfsX70YV5GwD8/dRBqXcoSbF2o/c5wJ29VznFnGZzMBYLlI2IZCOTlZW6Uwen6xFRBiV/AvGhrEFDWda0tDsjgS3LYrGGYHWILbzGCUW6xMiY8BImjvBnPnXUgQPy9eizKA8gQLJAEBsxaRb6v3zLTNqF1ot/jwCwJi3gCRukTjjgRDSxaJk1ojWzXH+PFsC/e0L6VivNTyL6VjyGBxcIjU15V8+/hAccqJKfGpUks2vxTiqSrtg6HBUl52d8GVjOV3Of7RQ/3+1rj0hIKxyDy1fk72XhIQ9MTC1oH3WKx7scKpblzl0686Xb9kdvDwOF+UrahdSJdD7/iZQyj7//sXrQ3tv9foL8KLrD/bR/zT67R3eRjOM7tjeRyGnewQnjfOFJQMEZEBlDF6d9WOTILRfz0F3i3pGkiyyTf8cnd9D84TEaPe1US2V5yQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tQqvZtFt/UtwILKsaZETGYJ1Baed85dQjXHWEe4XeoTsyPUM0+cTDtZyqWw6yDYPZagTJywNqaZFDDrYr5jyYuu7QBeIEhgUfevG2pVDy5qUwGFDDLvj6kiKOcrWoxy5I0XL0BmD8gyiCSG+HXNiId4qpJtzYk/2TH4D9c2z6cres1NVGp7txM2OP6TdDTqMk5vDxb5Pv2dt6C3Pw/rJShJp8Ba9ouPhnDneTF00q4BD0nPbPwznWVybA4X8td806hceaW2ariWdf+7Z0aykkNKQJq6C4BKjUzbwuo2gNNJ6THcTyZ9toMR2Vk+6GTLztb6/1gSsfm8ol7vc+GcaOWijFD7O2yw1MMlEt7IzLdbgpJyw3ojRmsf+c25YIncv7YAVaE/2iRS5nozRQ2wOSKSU/43f4lEpmzhud/vR6+FpMU1oFiploIwisZzPbxnc
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 12:19:16.1192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ac821a-90b6-4091-7baf-08de8f1fba1c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7625
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231416-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[4f98000:email,4fb0000:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-shah@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4E8FE3696DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hey Romain,

Thanks for the patch

On 19/02/26 02:08, Romain Naour wrote:
> The previous SPRSP36J datasheet recommends to set ti,otap-del-sel-sd-hs
> value to 0 for MMC1 and MMC2 interfaces. These values were updated in
> kernel 6.5. As a result we have some occasional regression with ultra
> high speed DDR50 SDXC cards while mounting the rootfs:

This error shouldn't be limited to just DDR50, were you seeing similar 
behavior with other speed modes?
>
>    mmc1: error -110 whilst initialising SD card
>
> A similar issue may occur with u-boot after a reboot while
> initialising the SD card:
>
>    mmc_init: -110, time 67
>
> Update the delay values for legacy and high speed modes, based on
> the latest revised datasheet SPRSP36K released in April 2024 [1].
>
>    (MMC1/2 - SD/SDIO Interface): Updated/Changed the
>    "OTAPDLYENA, DELAY ENABLE" and "OTAPDLYSEL, DELAY VALUE" for the
>    Default Speed and High Speed modes from "0x0" to "0x1"
>
> [1] Table 6-86. MMC1/2 DLL Delay Mapping for All Timing Modes, in
> https://www.ti.com/lit/ds/symlink/tda4vm.pdf,
> (SPRSP36K – SEPTEMBER 2021 – REVISED APRIL 2024)
>
> Cc: stable@vger.kernel.org # 6.5+
> Fixes: af398252d68e ("arm64: dts: ti: k3-j721e-main: Update delay select values for MMC subsystems")
> Signed-off-by: Romain Naour <romain.naour@smile.fr>
> ---
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index d5fd30a01032..418e6010ef1f 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -1643,8 +1643,8 @@ main_sdhci1: mmc@4fb0000 {
>   		clocks = <&k3_clks 92 5>, <&k3_clks 92 0>;
>   		assigned-clocks = <&k3_clks 92 0>;
>   		assigned-clock-parents = <&k3_clks 92 1>;
> -		ti,otap-del-sel-legacy = <0x0>;
> -		ti,otap-del-sel-sd-hs = <0x0>;
> +		ti,otap-del-sel-legacy = <0x1>;
> +		ti,otap-del-sel-sd-hs = <0x1>;
>   		ti,otap-del-sel-sdr12 = <0xf>;
>   		ti,otap-del-sel-sdr25 = <0xf>;
>   		ti,otap-del-sel-sdr50 = <0xc>;
> @@ -1671,8 +1671,8 @@ main_sdhci2: mmc@4f98000 {
>   		clocks = <&k3_clks 93 5>, <&k3_clks 93 0>;
>   		assigned-clocks = <&k3_clks 93 0>;
>   		assigned-clock-parents = <&k3_clks 93 1>;
> -		ti,otap-del-sel-legacy = <0x0>;
> -		ti,otap-del-sel-sd-hs = <0x0>;
> +		ti,otap-del-sel-legacy = <0x1>;
> +		ti,otap-del-sel-sd-hs = <0x1>;
>   		ti,otap-del-sel-sdr12 = <0xf>;
>   		ti,otap-del-sel-sdr25 = <0xf>;
>   		ti,otap-del-sel-sdr50 = <0xc>;


Reviewed-by: Moteen Shah <m-shah@ti.com>

Regards,
Moteen


