Return-Path: <stable+bounces-197968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 724B8C98A3F
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 19:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 637B14E21F3
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 18:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4AD319604;
	Mon,  1 Dec 2025 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TFhWGQj3"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8831F3B8A;
	Mon,  1 Dec 2025 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764612153; cv=fail; b=MZ/6D6giE7SS1Nbu7SdOxxYRF9xxzQYpkYGFFXGIj6NaAelhg8okwWQulKvaVKErscPTxiGy4+W++C4oDoDfUA0cwgaLgYh6AR3ods3cgyXKRe6envUFIqfPRWGq9oCmZjZSBzFRG84ceX1qEU7L1rgKdJrQg0JgelUIGpW3P8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764612153; c=relaxed/simple;
	bh=diUyMl/IGf/Pr+9LmbhXPdk15AXD6p/+tgRSK9FlE/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A+pX32ifumt0LN4BOhsewOmoRdWN9e9wL3XC8E8acYbDpJpohtrL57iHtSrnVpvGefTV6cwtfqgoMfXjJuG3uNnlkc8nZQtDyLN2zjGZIKH7mQg8rmziot+Ym9HWBcvFAqUpG9NvGa/T/xC5qBhQvTTxGfoO5t70dhnD6xQp1Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TFhWGQj3; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9NsMCRSzvoPCc0M2AgPZqZBI0fDVm0ABUg/GSupOcUqOCCZEfk9MRivZMV2Bbi9UehIYUivjB6/xLw6KBjW5pKxS7Of+7vs4OWYHohAfKPnvxIALo9aARqk/ExkQjs+2Te0BJTFTueuQeFrLijg0Yen4Qz8OO41n/Z9uaINz5zFTgcSnWpP+h4cYP7r0RkvBRgtLYguZtCohicSDWgWdXSqfU8Y0ZRbXM1podJ2tiBCdJfWIvJY4pOHx3qm2q8H4pawuKcxMzJpqSerNDu6sBI92NeeZAcIQe0SBwrrktrW46XtJV20vPN6P3VPsUW2YXLmtODnYvPu0HoUc/V7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kSudVzgAmRRD7vjKPkuAkRAaB6dhhZeP1wYM/K5Fxg=;
 b=P9Rij0XOENXa0h1u+wv2IaqCImF8SXQtcd0h3ppqN4RkmHo9T4XYvdYbGT1knKq8G7RhJR8Zq0YI2q1SOoVu6AMmv0GQPcVAcjpxGeZSoPbqTRRkRIH+/9NJwanElwDK7Y8EhY6+mBdi00nlvCw0a7RFqjDA3dLYLzywb+8oc8CeBb/TQm6lynNsx8qO2+K2cBqJejAqtIYs+QV9eA63jcAdO3/Kead1dVFAtgKWEWRYT/aK9t8PoG2OLGQkIwtS7ZdIzKYWVUmewfioNcdpQeipNXrwVjL3OP7txC1jIkh0X+vdPd0ZUH4zuebHDUlFaf/i+hlpAgv2i1OS63yu+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kSudVzgAmRRD7vjKPkuAkRAaB6dhhZeP1wYM/K5Fxg=;
 b=TFhWGQj3mNBBon+bGyG29YpNBwNUz5h+J5XqEo5M7zm2jY33/mAP9ClbNIlCfp+Y333+2U7kFIs6may8SPdKob5AAWXUOB9gjskFpgdODU9bTu6xzOsy3oRy8+Vi84I4jFqvOYx0Q1meQqDtIM3a/FP9mQGqtS3BisyigP6exRI=
Received: from BN9PR03CA0127.namprd03.prod.outlook.com (2603:10b6:408:fe::12)
 by BY5PR10MB4179.namprd10.prod.outlook.com (2603:10b6:a03:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 18:02:26 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::29) by BN9PR03CA0127.outlook.office365.com
 (2603:10b6:408:fe::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 18:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 18:02:24 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 12:02:19 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 12:02:19 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 12:02:19 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1I2JWF869456;
	Mon, 1 Dec 2025 12:02:19 -0600
Message-ID: <3ae82d10-a9d6-4ef9-91dd-4d0f6de56089@ti.com>
Date: Mon, 1 Dec 2025 12:02:19 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: ti: gmii-sel: fix regmap leak on probe failure
To: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>, "Kishon
 Vijay Abraham I" <kishon@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20251127134834.2030-1-johan@kernel.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251127134834.2030-1-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|BY5PR10MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: a95d1fa2-58f4-44d8-2319-08de3103c84f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzFwQ2lWWFUvMVd5NTIzTERPeXVHM2YxNjBNSkxNUUdzVXZkdzJvdEJIR1hh?=
 =?utf-8?B?YVhjQzk0b2tCRkdpNFN1dG5NbzB2U0RyN2JEUzgxVExWbTNHNkFEK2c3SnVO?=
 =?utf-8?B?bGlLOVJmZjFVUkorNmZQaS9sWXdXSk84NXVjMVgzcVRzUy95N3NqYVMxWlI2?=
 =?utf-8?B?ZDRuempaKys0bkFCSkhVSWx2TW9DN0s3WENQL2JVUTNaQmF4UnBoNE4zYUpY?=
 =?utf-8?B?azlwRkZsK1JCYWovVTVZdDFPWW1QbkU3VjA1S2JSblI4bS95V0pSWVBsMC9R?=
 =?utf-8?B?QWJkNXN4NGNJMHdpVEdTMi9xanFqSTk4c2ZLSGZPWmtkVjVFNEV3MGY2dXBX?=
 =?utf-8?B?TXRqOEF3ZUJ0V0crYi9JQzlPS0llNlJNU3FNZkd6Y2UyODRRcStnWmFzdExW?=
 =?utf-8?B?TDRoMHRXMXgyQ003anRFblpqRTJQa1hxV3MxVDh3dUkvUW11WXVEaHNhcGxn?=
 =?utf-8?B?cG5tUVBoaGh4UDAybUJIdXJNRTRBQXV5aE1WUDMrSGl4bkhTaFA4d0R6QS9U?=
 =?utf-8?B?cWgrVWRSdGN6QzFxajMyNHdlU2J1QUVtMVFRWUFIWGRXdUU1RGNwN2tLTWV3?=
 =?utf-8?B?UzB1VXV4Q1JWeVdSc2IybUNzVFFITWJCbDM3bkE0RHB3YmVCL1ViQVdYMmJO?=
 =?utf-8?B?YWJMdDZyRW84WWc3bjlNVnZQZmNOZnBrUVFaMWFHcnNvU3FUakV3UFljK2pN?=
 =?utf-8?B?N25CUStabVBRbHJLWjVDWnNWQjgybDlhRk5IYURxTUx1QVFVRWw5UFE4and3?=
 =?utf-8?B?T2h3cnJCdlFaVGs1VVEzNnpJdDFXVHJqVThrTk5aVjhTc1lCMExPTnh2ejR6?=
 =?utf-8?B?eG8yMnc5Uk1PRkgxZVlSK2dHdStKSHFBSjRhUmtoTzNOa2FjVlBtbHRFbnNC?=
 =?utf-8?B?RnVWU2g3dHA3WHd3RHprUDhKcjB1aGVtYVQyTjVLM1pVWGhXM0dROWRrUmkx?=
 =?utf-8?B?bTdGdzRIU0tGL3BjWXRhS3R0c1MzSDBGZUN0blBiYjMzUUxwQjUxSVNPcDEw?=
 =?utf-8?B?VkZRWWF2TkQ2ZlNhLytvcXZyT0plQ25MZzFMQ0ExY3gwUlRwMC8zYUhHRElG?=
 =?utf-8?B?Y1lHbFEyV1BWbk5hQWY3RkkyOGVKaTltNUlSTjJHQ0dXZE5xNXZJWXBNWnhE?=
 =?utf-8?B?bTNyUHcrdzd3R1B1cmZiVW94RlVrNGdvUzdIaTkrbHBpYS9raDNFZDF3MG9T?=
 =?utf-8?B?L2xWbE9OdUJVVlYwRkFDbUcrdktWREZvb2l1YVBSTDRnYU9YdERjTUxKMTVa?=
 =?utf-8?B?YkRvRS9haGE1b3o0Sk9RSEJSTmlIcktHQ0c3clo5RGF4ZjQ3UzNEMkRDVjNy?=
 =?utf-8?B?S0RjWlRkWTE5NVI1eTg1RVpNenljeE5PMHd2M1RFMWtRbzhQSXI5UnFGcWds?=
 =?utf-8?B?N3F2cHdNNCtBZnNodFRVQ0hNZFdYQWZ0TWMzWEpST2d3akFvSWdRQmMyMjlB?=
 =?utf-8?B?bDlXWTlXK2VscVNqTERURW1reU1YVkN5ZGFqZnlkTkVNRytWeXdDMjFmZ1V4?=
 =?utf-8?B?eGJBSzVIaGxrMXIvdVBpNWIreGhVZUpXOHdRTGRIMCt4RWUzRnVDSjFEb3Ft?=
 =?utf-8?B?bUkyNHpnSnBIaVk4UGs4ekhuWXprc3A0bW5YL01STzZWL1VseWlpdUNrUHVt?=
 =?utf-8?B?Yk5oNkFVSE5QVE9KV3lWMDg2TTNzMkgrR2wzZmpBaFlZUzUxMy8vd3hKTVRn?=
 =?utf-8?B?bzE4VGVkZytnaXEzajdmMkNKd1V0dzlOeDNpQSt3RXc0dzMrWHAzQk1OdzRJ?=
 =?utf-8?B?Z2ZON3NKUVpyWVQrSlptWWpVYm14U2g0QlFmNjNOaVRMaFhwbWNDYk5LMkhv?=
 =?utf-8?B?R3c4eDBBbE14eXNpZk96REJtQVdRRUIrUU5nNHFkWGRySDhDOW44QmJrNjlj?=
 =?utf-8?B?dnBDcnNWYVdRZWE0SE1oNVBodkNQSkJXY2ZIUVZOVHRMakR2UHExWm9YN1RH?=
 =?utf-8?B?MFNQNXBIUzZrZE9QZjhqS090eTU3UU1xcm5zSy9XTGs1TDJISE4xWlJGcFZB?=
 =?utf-8?B?U3dOdHRnQlExemFCWVBmbk9ISExSR2lFSXJUK3pUSG5ZTkExQUV1OGpURVI5?=
 =?utf-8?B?dWRNK0xzT21XUU8zcHhKcGVLQnZaOU1haG9hdEMyR3FTdCswWUthZzdiRUh4?=
 =?utf-8?Q?EUkg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 18:02:24.7260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a95d1fa2-58f4-44d8-2319-08de3103c84f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4179

On 11/27/25 7:48 AM, Johan Hovold wrote:
> The mmio regmap that may be allocated during probe is never freed.
> 
> Switch to using the device managed allocator so that the regmap is
> released on probe failures (e.g. probe deferral) and on driver unbind.
> 
> Fixes: 5ab90f40121a ("phy: ti: gmii-sel: Do not use syscon helper to build regmap")
> Cc: stable@vger.kernel.org	# 6.14
> Cc: Andrew Davis <afd@ti.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Acked-by: Andrew Davis <afd@ti.com>

>   drivers/phy/ti/phy-gmii-sel.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
> index 50adabb867cb..26209a89703a 100644
> --- a/drivers/phy/ti/phy-gmii-sel.c
> +++ b/drivers/phy/ti/phy-gmii-sel.c
> @@ -512,7 +512,7 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
>   			return dev_err_probe(dev, PTR_ERR(base),
>   					     "failed to get base memory resource\n");
>   
> -		priv->regmap = regmap_init_mmio(dev, base, &phy_gmii_sel_regmap_cfg);
> +		priv->regmap = devm_regmap_init_mmio(dev, base, &phy_gmii_sel_regmap_cfg);
>   		if (IS_ERR(priv->regmap))
>   			return dev_err_probe(dev, PTR_ERR(priv->regmap),
>   					     "Failed to get syscon\n");


