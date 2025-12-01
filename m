Return-Path: <stable+bounces-197970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE72C98A4C
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 19:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 179454E2693
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40B0338917;
	Mon,  1 Dec 2025 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YwFvCcaC"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757A319604;
	Mon,  1 Dec 2025 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764612163; cv=fail; b=UkOMj/4oxcNqFbCwbeVLIo9XtyjJCRcuqc0qhDB+VNTUoi8xwNGFOXithmdNUeFYgqwj84aKehH4pO09kPE4JCuu26f4sNQo9fEvPzyRutvXIeUC2im4e7hb7I4wulgB0X9zX8WUfwaQMLofDN10dg2zI+lVtJc7fLlLIe2Mrys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764612163; c=relaxed/simple;
	bh=kUioQdvSDaeO9YmhXKELLsUQYXMD3JbQ+F2JmnOYQEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jP2fwrLMq/G7c7ed5EFHfZJ9tb9cTsGy0Bgw/5pGjPYDAxWH4beL9sAFfRqQiR6vahKZHw7EUW1OQLM6W3vuAAeqfxxMxSH1MZf7WG74En5vGke5naMC7b6UP9KNHboy9lHf7mm87lrJx44XSajDgbDh2hif7oDgeKSgCEq2jKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YwFvCcaC; arc=fail smtp.client-ip=52.101.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FF5mIzJB5lbEJQ7ITiSFEiKrGHu/fKsnfHkEcrn+LFjUFJg+6J75CSMRYBtF7IjMETGNQt69+1BO1oY5alDUbciyPhGq9BpIRS5IjRwbxSP64hXWZnvwLdK5Wq2MtBBbn2kiFTwtF1nD4Xh8tOFKbtV7yaws/yK5XX6i33bHvFnTfsDOL3dtF6GHutn+jBKoyLCJylSnt2bivSO5tzrhuRmoz76y7DzX6TK/ki1wQSy0dq/ksUuuK+CqsN1/0GqQRM0fwxQTyVUHHFFb9Rj9pY09dWXGhayS1W+N7nKttzA7xUydDejWX1bQuIi1+v833G3Rb/HoXC/V5HUitC3Dnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDAD7cUBbknSg/Oh3wCPCcIlM1Jrsr0iR6k82+V6Poo=;
 b=XHTh4nsce4Bjx9j69u7wbcmCWVtyPynwtan9LKnguu+iHNV3wWu0JIB4eMAb/gY4dnSkwfH88ImdJf+qHbxugvDP7DkfV7wHHXHEt7eiSEG9+/LGt06gow3q6KcTMdM0rzVhmuFFuZR3hXMi/sElv8tCO7Wt2D8QLaSjoO01700O9d35i0273SAoCFnYAbRm4onvMmPzPdlg0lt+YkVic+sI9ZmUG0Xz9k6bmZMoJ0ZE9e1wrZlrqExNxYqz7pkc9aPNeTnTrq/I9zeJagXSzIhLlUmWSCPniPbi1nhlqaCbGCDY5HKxBOkdyKRiAqf2XahSfHXAW50HcCgQxgOvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDAD7cUBbknSg/Oh3wCPCcIlM1Jrsr0iR6k82+V6Poo=;
 b=YwFvCcaCO8RN0LsbAaPF8aYkZf7E8VCWPSjMG605hhQunAJ/duYDuPtgip8Sqq29cVPgzRFML5oqtKOVL9/KVKCOWemnxwYFCVtl5QANvUzKX5Dsa0W8I6Bf2+ib23nJ9yAoY9kQbPO/HFa1C0tDktOz/tc4ZoejerfbEttLh7I=
Received: from BN9PR03CA0124.namprd03.prod.outlook.com (2603:10b6:408:fe::9)
 by BLAPR10MB5075.namprd10.prod.outlook.com (2603:10b6:208:322::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 18:02:39 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::9d) by BN9PR03CA0124.outlook.office365.com
 (2603:10b6:408:fe::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 18:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 18:02:39 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 12:02:34 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 12:02:34 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 12:02:34 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1I2XPG865445;
	Mon, 1 Dec 2025 12:02:33 -0600
Message-ID: <f8859e4e-b1e0-40ac-9e9b-dd30ab9d6d0b@ti.com>
Date: Mon, 1 Dec 2025 12:02:33 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: ti: k3-socinfo: fix regmap leak on probe failure
To: Johan Hovold <johan@kernel.org>, Nishanth Menon <nm@ti.com>, "Santosh
 Shilimkar" <ssantosh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20251127134942.2121-1-johan@kernel.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251127134942.2121-1-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|BLAPR10MB5075:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c38ec0a-7aa9-49df-1971-08de3103d139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlVBTEYycVRta1pFTHhSeUlEWkV5cGxxNHVyeC94TjlVbkM2K05jUkZ4QjhC?=
 =?utf-8?B?TnBPcG8rT2N2NTNMM1lNQ0x4QUVNa2l0dXRkMEhUKzdxSEZYdUtSWGVpMFFo?=
 =?utf-8?B?dXQ0K3VBSUI2VGVabCtVdmwxcGNETmdlUUNDRURORkJzZUJkOENDOVhBZmpj?=
 =?utf-8?B?cktCVWlTNlYxcXdoTXZlcnZUaURZSVQ5RW5jRXNpelYwYzFJTUpjcnc3VWRa?=
 =?utf-8?B?MzFmT3hlVCtRZmc4S0FYMmdJcndoS1FFUzlFZXBxQ3lKRWxCTXhFQkRENnpL?=
 =?utf-8?B?SGhoR1NSaGVjZ1p6eG9wUDNFb0I4dDE4Umc5N0JUNy9KWTU0YWJYdVBBVjQz?=
 =?utf-8?B?amczWTRjVUJTSm1EQWRjNmhhYVhySnJuQXBXZ2JnRmU2ejNUSEYwN1ZtMjFT?=
 =?utf-8?B?SVIrVjloS29DaGFQaTJpd2o0Zmd1dy8wZGZHSkpxMlhhUCtEZmd4ZXZzU0Q1?=
 =?utf-8?B?dlJBZjN6alEwWTVROHZiYnV6Tk5lNnBPdXBnd2ZKa2pjVjNvZUQwQUtDVS9E?=
 =?utf-8?B?MzRCRjhjS0xhb1hsRGRPNFJOczJCVDBTeVFjQXkwY0hLYkpZZkNZc0Y0VTZK?=
 =?utf-8?B?SURkMlAya3F5OFhtZk9UK0tPc2czQm1FcmVmVmt6TkYvTU5DZUxpM2toNi9L?=
 =?utf-8?B?MlRweFhpbFdZeFNuMmlUZGZnUzAxUFdnSW0wNHpvMWFxOG1qRUM4NXBNZjYx?=
 =?utf-8?B?c0FaUVY2UURGRGt5Y0ZVWE9GY3ZGNUliQ0NlYTQ4M0g0eEdsdTN1ZUlReXJp?=
 =?utf-8?B?d2w4UEUrS00rKytuYVE4TlVkUi9MS0VRQmhiM21td1d2aTRkY2YycXBFUWxJ?=
 =?utf-8?B?M09zNU5OdmtleXI4SjZqOVB6ZHB5eTk2SmFrTWNXT2l5VzJKeTlXUm5DZTg4?=
 =?utf-8?B?ZHptZ1ZUdnNHL2xMMEdtZXdCYmRJUTR5eHdaNlJvdTBtVFJ2dTBLeENza2E2?=
 =?utf-8?B?V2ZLb0tBZVY5UTZHcGk4eHhZUXExSERNbmdhNVV4aC80T1RrSXZYQmROWHlW?=
 =?utf-8?B?RlliZS9hbGdBYTdZS0hFbngweUhtdHR5eUs5b0Y5Z2EwUGE3Z0dwN0Z0V3pr?=
 =?utf-8?B?cjhDeDZZTjRqU1BOL1phVVVpSSs2MjBaYzhJVks0VWJaMmw1U0FzQ0FtYmhu?=
 =?utf-8?B?amhTVDJ3QVM5aGIwNVBqbDhrTS9EUFRVaEhvRUltK2dXMEtCcEIzY2ZoUnhC?=
 =?utf-8?B?NzJiOGswVGlFaEErL0tmaUtzQ0V2S29LYTdSS3J6bTUwMENiSmRQMEcrbEto?=
 =?utf-8?B?RTQyaTlYNC9ZLzhtd1ZGNzZhYW1pSGxLK3Nib2xLNGJGSW93VHozSmRwcnFj?=
 =?utf-8?B?M2pkaWtMU1hDNTFSR3kwNkd6djdoNmtUY3RBcVhKN1AwNnlBajJiVUwwb1Jx?=
 =?utf-8?B?RzFYQU0zUnhxckNsQ1M4a3FWWGo3dFozeUcyczVFYXZRYSszY3hlSmtQV3pt?=
 =?utf-8?B?RzU2T3RQbTllNkoxelVSOUptMnVkcDNSMk5CWEt2ME40MjZQOFVpMitQQ2di?=
 =?utf-8?B?OFJSdnNybVljdVZwTnZNTVQyS3QwTExORmRlQldRZzJCdEE1QWpCcS93T042?=
 =?utf-8?B?a3QwYVFYbmRwOG1vdUdpSnVTLzM5ODhmbjNGNWRwVkdZWnh5RjNINXZIZDdo?=
 =?utf-8?B?T0xTVEdvOTFLekZUUXFja2VxNU5zelMvbE5YejRIMG8vckdEQ2p2Y2psa2Ir?=
 =?utf-8?B?ankwd2VKeUt0UkM2OTVpRldLWjB0clBrWm5hTXNxNkJKWmFsS0Y2SlRmdzdV?=
 =?utf-8?B?Njh0MFJIdDdIUzJBZ0NhWXF3bG5INGM2OXBLZkEzaDNiMWl6UmRKR0cvMUxQ?=
 =?utf-8?B?Q0lqL3FnVncvMTBqVHZ3WGxtN1I4WnNqRXVuWVFmTU9zVG54eXMwUzV1TWx4?=
 =?utf-8?B?S0dhQnorRUo1YWRZRlVWMjhnV3dXV1FSdnB4d1JkMDZHTU0vZHEyOVNweEow?=
 =?utf-8?B?bTRLWGxlMS91aWVYaWVWNTQwRnVoUzY0YU5CdVczcEVMcDFLRnEvcitVamdv?=
 =?utf-8?B?a09KcHZVR051bGl5TzMwQ2MvdzdtOUJYRytBZVEwdldMeWJKVXZTbGRIMU1I?=
 =?utf-8?B?dDVaUm9KczdyNXk3NTVVMWs2ckdNQXkzL2JzS3hIRU04S29xT25qWVZoall1?=
 =?utf-8?Q?cCKk=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 18:02:39.6820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c38ec0a-7aa9-49df-1971-08de3103d139
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5075

On 11/27/25 7:49 AM, Johan Hovold wrote:
> The mmio regmap allocated during probe is never freed.
> 
> Switch to using the device managed allocator so that the regmap is
> released on probe failures (e.g. probe deferral) and on driver unbind.
> 
> Fixes: a5caf03188e4 ("soc: ti: k3-socinfo: Do not use syscon helper to build regmap")
> Cc: stable@vger.kernel.org	# 6.15
> Cc: Andrew Davis <afd@ti.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Acked-by: Andrew Davis <afd@ti.com>

>   drivers/soc/ti/k3-socinfo.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
> index 50c170a995f9..42275cb5ba1c 100644
> --- a/drivers/soc/ti/k3-socinfo.c
> +++ b/drivers/soc/ti/k3-socinfo.c
> @@ -141,7 +141,7 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
>   	if (IS_ERR(base))
>   		return PTR_ERR(base);
>   
> -	regmap = regmap_init_mmio(dev, base, &k3_chipinfo_regmap_cfg);
> +	regmap = devm_regmap_init_mmio(dev, base, &k3_chipinfo_regmap_cfg);
>   	if (IS_ERR(regmap))
>   		return PTR_ERR(regmap);
>   


