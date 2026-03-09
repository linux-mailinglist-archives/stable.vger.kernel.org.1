Return-Path: <stable+bounces-223635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB1PIXHErmn2IgIAu9opvQ
	(envelope-from <stable+bounces-223635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:00:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C31D239547
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A892A3010B40
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 13:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724B034C14C;
	Mon,  9 Mar 2026 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hvJn90D2"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C43AEF2E;
	Mon,  9 Mar 2026 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061228; cv=fail; b=Uz3grdXvppNcDvdEteOpY1IS/ot7Y4vjciXyAn7u/8nMjC0YjP+B8OKVm06cHN/2vrDE7trAEpiSGBB90WJ9sn9B575+WuWALJtY305JzWsN+zqrsCttAMP3YR5C2/kQ/ikzshAURrpmNojLHqSx86HXMx+iJjY7Zg5yZ7NZRts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061228; c=relaxed/simple;
	bh=JX4MhOGom+PlDuFhugirmZde/smaxQlWxwtMkwOvm/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L8iPpDSIQWTtRTpU+tEeMyxQW1NBYLG25RXDg/rX5qiB8qgDaGzPe6uBPehdMqpTuy54iDlli2ZKzgnGmtaVitFD1IW9P3qNJJPPsU2q/BVmWB9ZdB/+kJNWkYRg1jaVE9XcWnoccOROLNOT5QUSe5Itgd2VhduG1dhT9qpjNEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hvJn90D2; arc=fail smtp.client-ip=52.101.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSfS3Uz9aeqdTMQ3P2Gh30VxDh9aBcbC2H+Io0ZBRtv8/UpLQUTYsh2eASq+hdL8Tp5AGMFCcn83KypPVsm5MWTeordoIs14J+Wjxj4yLUogFfEsonfgw2sqonN0f8nIBwrBH2pU5rY2fVGBgEXwBIbrylbiUt8q0F/rw53KAWYjegyhqqB57OebLloxkbeQ/A0PLD0suidnJNBHx8GzWrLxaNJDXYxfR7m0ImMzlOMR/TfaNi45HQi4w7kwr2FSSTNUUKtCYyCq3gE18TOq3gWe02ISyLBMnG0553DcCrracMAfyxSn6Crev5oNxk5hbf0LbvgcJVaf6I2dYxkfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zu7Nl1Yk8xxQlmJCGM0pFvX38CPzUnT1TAzJsYFYhQ8=;
 b=AbryZn+qatH+BBAgBaD+4zUFxYJsVtlW6VDtafTUFcmTICQ6yGWcuIsydWQIPZwAdnomqOuTGoiWpSwOdfECIynr4rvGERt4MT3QclGriPsW3Kw3v9gB0FOLmj6oIj18SfsSmU+fLQ+k8o+gsGYhIFtXouCTnmrDvGOujhiOwYcgPxtEh8a8Bl8NKTtLarwc6ws2nCfbv3hT5nOY6iXLCqb5lpnUR4klOghCYxS11zDriAK6OuUjd2dPZYEeEebP5bIkioqqkZmDduFHXrU6sb6j75rhzSwKWfm6k1acnXT7TdxAgU+QEoyyKWb2vTntt9AeGQXjejWDHeQm3N1pbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu7Nl1Yk8xxQlmJCGM0pFvX38CPzUnT1TAzJsYFYhQ8=;
 b=hvJn90D2N6xEPBQWax2r6kFZNATsz2MvQZrBlhnY3EoWTc8wJSSooXi6/Ubb6UI5xlSx7ckKUjCeBE6aA96N7mmB2Yfur4N3rcwZkPkbDHAq3wGFHIuhRmaFyIUC7cpxSGuTFIMK7AtHcHl4v8q4PzQNcovQe308lXZHFfchMdU=
Received: from CH0PR03CA0282.namprd03.prod.outlook.com (2603:10b6:610:e6::17)
 by SJ0PR10MB4638.namprd10.prod.outlook.com (2603:10b6:a03:2d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 13:00:16 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::1e) by CH0PR03CA0282.outlook.office365.com
 (2603:10b6:610:e6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 12:59:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 13:00:16 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 08:00:15 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 08:00:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 08:00:15 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 629D0EXp1130425;
	Mon, 9 Mar 2026 08:00:15 -0500
Message-ID: <765b5e47-0092-4373-a4e9-c42763aeb4e9@ti.com>
Date: Mon, 9 Mar 2026 08:00:14 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62a7-sk: Fix pin name in comment
 from M19 to N22
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <jm@ti.com>
CC: <stable@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>
References: <20260309045539.2070793-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260309045539.2070793-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SJ0PR10MB4638:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b8d536-d8db-4998-e7ef-08de7ddbcf60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	xAicWDJf4ez08Rci0SV3gZyqSVsMSuowjtbZv2OWUXWDqvH1SGWIIiyrzVeJMDV6F8DLHH6pG9XpZ0h8KsWftEqwc3BvOPRUwvxRCUPdlYOi1ff4l3ZZ1+VuhFgnIqxMVDxVv8EfFm3jLUuGwR5s8MTRWN+B/6uh0zR1u+qtDvQCuZ4bNS9o+8epLroJdvOTVxuQ1m0DFguprXN+kvNVH6iKfjpgabcSReX2xZ+TinfjCU2gMOFceirKe65F3s2ne+i8yH+uorlJktMyYhy4fKuGbcrVyr5DrKAWle/ACsbEjRLWQ/mJNbyKQEDOi1DjHg9fKXdOCTuZVqR4BQU721PMjNFXWRmQoCeKCGV8+MGLllESb/vVV3cVlnEpP9LbaJE8t8TflA9PR/AwnDu+7xadORunnYVgMJHDa7IZB0M4Nlt5H8+Mqi98h3bpRoXjQpsj3/cDK6Xr4heaS9rtvXKLTMqCVh1ImLUpZbc1DPqlLoJdH6gBl9qXB3atlScFp9/QVkY+6v+1oIKXuTrE8fyIBoWThk46AVxSir3ZqQo+1/vCAcqDd//E+usI4zZCyaOtIq4sU0eJutvz+Dll+xdXr4BJDFTiR3nB4hLy5qsW6UMC+GqboD4UsVoxRuiJHeRxyk/b/vJsINZCyZipPzaIqs9hC2fDk0HlQ5BomJiyN7mp1yQYliO6oPt5TW05WFG/pMGzHpzpGwFxbsC06BPHcr7KU8vzxKPGP1ay09ECf2vP+34y+n4D3M/9FxQKT9aVKmoAbfmPujrHne+U4A==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gXF6Td1U+LboPILL6swNMTHY4Y3KKwek05wyknyjynG0efKn2LwH4WxjTUBHWQa4ZEKGLeFUbDv9Ycm8XeQRFNwUK826SbyjsRtVU5/+Kr5BSRvSq5l5e7J+fGBJWauR4uN2pfXsUUQJAVpgKWvi2TnZ9r0+zxb1oPz+OEUA7RIaaIInpi5euIfETeCEED+YaGf2R281C4ORl2JA8EEH+uwcGiMM+jEsTwjtYqB1R6Jyc/OdSDFtL9+1sAE8gmOstn3Jp2+i6OWawg5RsHwwd+O66EPrYmBRAwAUdOT9Fu4LP2+IWI4HjL4maxcINuSO9mAXFxbiMzH54XhvWLAvQO8wzj5Ldm+TH307/b2gCKS6ujMV7FeBGSkoXQbQPvO8dDrzfG5WJ54iUHSCQuIaBWH/yY19ahk+IZXo4W+HogxRzW3McBdotHEBOSAbjWqt
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 13:00:16.2753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b8d536-d8db-4998-e7ef-08de7ddbcf60
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4638
X-Rspamd-Queue-Id: 6C31D239547
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223635-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ti.com:dkim,ti.com:email,ti.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[afd@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 3/8/26 11:55 PM, Siddharth Vadapalli wrote:
> The pin for GPMC0_CLK.GPIO0_31 at address 0x000F407C is N22 and not M19.
> Hence, fix the pin name in the comment to avoid confusion.
> 
> Fixes: 8f023012eb4a ("arm64: dts: ti: k3-am62a: Enable UHS mode support for SD cards")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---

Reviewed-by: Andrew Davis <afd@ti.com>

> 
> Base-Commit: 1f318b96cc84 Linux 7.0-rc3
> 
> v1:
> https://lore.kernel.org/r/20260212130843.1054100-1-s-vadapalli@ti.com/
> Changes since v1:
> - Corrected pin name in comment to N22 instead of updating address to match
>    the incorrect pin M19.
> 
>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index e99bdbc2e0cb..b1a6f10adf26 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -398,7 +398,7 @@ AM62AX_IOPAD(0x01d4, PIN_INPUT, 7) /* (C15) UART0_RTSn.GPIO1_23 */
>   
>   	vddshv_sdio_pins_default: vddshv-sdio-default-pins {
>   		pinctrl-single,pins = <
> -			AM62AX_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */
> +			AM62AX_IOPAD(0x07c, PIN_OUTPUT, 7) /* (N22) GPMC0_CLK.GPIO0_31 */
>   		>;
>   	};
>   


