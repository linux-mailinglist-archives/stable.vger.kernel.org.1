Return-Path: <stable+bounces-197969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDF9C98A46
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 19:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D8184E28B3
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 18:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7994B337101;
	Mon,  1 Dec 2025 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OaFsETWI"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE01F3B8A;
	Mon,  1 Dec 2025 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764612162; cv=fail; b=uw7ABekyylcoAtuYOv6AeKw04uYQ0e1aZzyd/KEkzDhUfgIE7juJtwDdMq2Lz9GOglKwMef9kBGsaYzVeYHZpLtiggGrHWSGUS/rUP2qjLX3TQkndzOqu1OQdkYB34B2NSYhvMmWJzCKbQlP4aXEyGCEEN4Ml5aOCkFoCPGf7oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764612162; c=relaxed/simple;
	bh=u9se2XLVuouGA5ptYAHM4EjMcxw4NL7QwXPq35aaKV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Nb41vixzpBLU/qHH2gYuuazKXag++N6widjBoVpWuPI8N/4dM3WV6hc0v4UWt1lmQkgWCCP4hYCw3hNrouCWMOG48O87Upg67/U5ubUjd1lyrle/yr4gDcZavNAwg3YEI/mWwBNaR9q/DUIqLGxcTxiYk6qpkR+q0TS2QoamSa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OaFsETWI; arc=fail smtp.client-ip=52.101.193.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFH9aGDgDUX3GxoJafvjYNeIfZJ2qnkdV42zp1xDEXyv/pnu7WlrdmeF/pPVrndBeiDziJxRE3HMSQcM40FbTjX022Jgd/4oJoMVprd1O7gZM/waWrHye66pKn9iDv/njzwelLz0hoM3Bo2ghHI4tns/lDkZU2xMRGeBmT7i+9Barf+NESVOE2wws6L7KUR40MRTfcOnEyBI03kg35pwvsCuz72Nsvpqx/aGzlerSoal8ZnhTMWgmfKVeXzl7FnEvnrGMA0LwZdQA/7LMILHMgi2iKfLt/BKeotUPAk7dvEKNqcHRqJe1ojUvFWIYpARN+Ps4S18u1VbIqcKYvw/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zbu6K4N1tyY54XfNDyeIXAXYPdjjBbuz9B5hsEmK6Y=;
 b=nvJd9umq5L8yxluIvZWOLALDZT2GKDaXDZ4clv8VtnMF1woe7EOa5z//QgOd6xcqki5V08nHbklCOfStLQXPGNkM+bhTg9VCZRrikgQ0/MLg3ZATzhI5YV+yEwYkX5lXnclVrWt27T8sqaU2f2/mNUDUpsat7hrXlfr8tQJOQCCCBNhSIcFVgMCS9jmFz0YCLjB4RUTznW6NspN3F86M0G/Qi7DrHuyJYKdTPfrs2sROdCcMAnGmmColiiK0j56/2Eqozh61kb3GyN37N084dhLw/vrv2YwLA1Ci7Or1Ylnb0lRwnO/HUxSWjlwb+fAIMHGfHMjewoTjwFORVBm3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zbu6K4N1tyY54XfNDyeIXAXYPdjjBbuz9B5hsEmK6Y=;
 b=OaFsETWIqKJBpp9lnraWZNKfifeWZE5Se/bTco5XQqv8SFBShVmDFRz8wePtNcecayy86kntKdpuMXg0dSL/jl+kknX/aVZYOmoUKqzklelnwhFCPZS/v9UepWNEpGOtCfJA5Al33oB6vIpRltoDJj6Nhbrb3+skyGzQycUkFak=
Received: from SJ0PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:33b::32)
 by DS0PR10MB6053.namprd10.prod.outlook.com (2603:10b6:8:ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 18:02:33 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::86) by SJ0PR05CA0027.outlook.office365.com
 (2603:10b6:a03:33b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Mon, 1
 Dec 2025 18:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 18:02:32 +0000
Received: from DFLE20.ent.ti.com (10.64.6.57) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 12:02:10 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE20.ent.ti.com
 (10.64.6.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 12:02:09 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 12:02:09 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1I295n869208;
	Mon, 1 Dec 2025 12:02:09 -0600
Message-ID: <5380725e-9f94-4340-9234-986ed21cb07c@ti.com>
Date: Mon, 1 Dec 2025 12:02:09 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mux: mmio: fix regmap leak on probe failure
To: Johan Hovold <johan@kernel.org>, Peter Rosin <peda@axentia.se>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20251127134702.1915-1-johan@kernel.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251127134702.1915-1-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DS0PR10MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: ffad8848-38a2-408c-5fc2-08de3103ccd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1pFTkd3QVBpS1N5bDdLcjBRUjVQd3hoNUZMRDcrY3E2WVZuUndhTERpSDNB?=
 =?utf-8?B?SlM5b295bW9MQkxOclVJdklTMTV4ckZoQm55WUtGVHBRVUZiRXk5eStkR1B3?=
 =?utf-8?B?MXNmTklWWFVJbVhSTENxbWVXa3Y4cGRLcUxwOU41bHJHSTdRT0lzV2hBY1dC?=
 =?utf-8?B?NkkyOGRVMmhNODJEcHY4OUJBbUQxeWlsMUxQSDBCbjRhUnI5T29PTzFHLytC?=
 =?utf-8?B?S0wxUlZYTm03TmNDdGlNd0ZiY2RXMVIzMVpFcDUyQ0xKRWg2UUNHWm9nZzVW?=
 =?utf-8?B?V0VDeE9ock1MTkl3R1VKWlB1MUFCWmhJSHhQRnlsT0U3ZjFSR3VlMUU3ZHBU?=
 =?utf-8?B?blcvajkvYjJINDdGaUczUjhnQzRjTi84RGN5Snp3NUJMaXZsNUZRTUZhSHJv?=
 =?utf-8?B?dUo3aW1SNElCU0c5dFBDS1h0bkkyQ0Y5WUVnSHptNzUxTmRPeWNKYVIrN21p?=
 =?utf-8?B?SENPakZNTDVFSkNnK3pCK0lnWXdNRnJFZTVkQVNsR09aMHhsNklNdXJBVEM4?=
 =?utf-8?B?RUZieCt0bVY4cWJoS1pIZEJjU28wSUw3OFkwcFQxSjJrWWJxd1dSeTVYTzNu?=
 =?utf-8?B?bEF4S2tuZXpaV1B0eDFJNnhZbVZmL0UrdzdCVFdlckdIZFZ4ZENyUG5OZys2?=
 =?utf-8?B?bjhtbkVHNHZPMzlNYWw3QU9VSU43MXA2LzdGbmg1emtWc3lySjN5NnluTWZ4?=
 =?utf-8?B?ZWFwMnU0MERDTWJzVTJMS1BsRE5vTXRDS0k5MTIvbk9zRi9WYkJycjVneXFj?=
 =?utf-8?B?SFgwemRzVVY1TFZhQk5TYnMydU1XOHg5TUxDOENmT0IweExhY0JjTHVXTGx0?=
 =?utf-8?B?YnJDMTNqUG9yYTVHYjhnd0hHWXFrcTNFOUJhVmd3NnBGbzJmSi9pWXZhREJI?=
 =?utf-8?B?aUkycUtEbWZyN2NiT1lTUzJ6MXgyMDQ0Mk1DZjdZa3BFMjBaY0JnZm5KQVpu?=
 =?utf-8?B?d1NVYkJKdEdKbytDMGxzQjM2dVdtZXMweTh4dmduWnRRQ3hMMTVHNWxodFoy?=
 =?utf-8?B?VFBFTUJ4NlZtMkgrbVhVS2lDMWdSMTl5Skdud1p3eEk5RkFHZlNKeVIxcW1H?=
 =?utf-8?B?YXNmY3lJRkxpQ1M0YW9Qeng2Ky9Yc3BpTm82NHRKMEdlZ2d2SzdIVi95eGl3?=
 =?utf-8?B?aEV2UmZ2eWRSNUs2SVdVQmRhTmxaWmZJZWkxZGdTaksyc0tlUjZsa3dwN1M4?=
 =?utf-8?B?UTZ6eU1EdU9tejVvZ3B4allBL0UrRVlKQ3hjNTlSSDJLSVRybnRYelYvTHhZ?=
 =?utf-8?B?UEF5ZTZNaWV3cXBkOW1GWVJZa05QV292a3JEOEdvUGZVbzhLNHN3VW1SK1FC?=
 =?utf-8?B?c1ZhT3djaXozak9PallxZFMzSHVBOTVWYWp6WnhCeHpTVGlSOC96eWYxK0Fh?=
 =?utf-8?B?OHQzSTBJaCtFNWFPWWYyM2Z5SFBHZzJnY2FtZ0ExWVNDNTQ3dXJxUGgrYXQ3?=
 =?utf-8?B?MmVxUXd5NlVkcVJ1cnE5NDBia3I1SVdvb1NTZFM1YnlJeVdML1dyMXNiVXZN?=
 =?utf-8?B?OXFqVlNscXhoV2ZZNGF4ZXl2ZmlOOVRmL2JHN3lyb1hVUVBXdGFaOGpzdnJh?=
 =?utf-8?B?ZzZnd2VwSVJiU2VEVlk0R3RGdFBBd2VacXFwd0QzRkI1b2RoMWlBZ2w5VGQ0?=
 =?utf-8?B?K2RZUlc4dkpmTU94YVRGenhkSlJkcWNwU2xLQ2t0bkU1WEswTkxoWWg2d1NI?=
 =?utf-8?B?N1I0UERSZnF3YTk0ZzNmSXVQR0ZPVDBuZTBLYlZvUlljelUvQXdpRVhCWDdi?=
 =?utf-8?B?b043UzlPczZ5cGxQK05yM2hHM1Aydmc1UDhRZ1N4Z2ZOQnBFektGWThmYlJ6?=
 =?utf-8?B?K3A2OHlpT1V2eENJY01UWndKRVprMUpNenZXa0hXMHFFZVZ2WHNhOG4zUEI1?=
 =?utf-8?B?d0twNDRqeWEzaVpiRU82bktYWGZ0YVhqcmY1NmQ1aHE2QUdDVUNPVzdVeXd2?=
 =?utf-8?B?NElSOEIyVDNFMXJhQ2djRlBFaUZjdnNrRlR3c3p2bDZCbWNXRXR1cEhLU01h?=
 =?utf-8?B?Y2dINFZRZnpYSlBOTkZRekdjRUN0Z2ZyMmZDbVpCRzZGL0t0N3RlVlZxd3pT?=
 =?utf-8?B?b2tmVDBSa0hFWWFiK1FVZ1g3VFdKUi8wVXJ6bm1ZVnJjeUxVdTdLd01KOHJB?=
 =?utf-8?Q?knjs=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 18:02:32.3697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffad8848-38a2-408c-5fc2-08de3103ccd5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6053

On 11/27/25 7:47 AM, Johan Hovold wrote:
> The mmio regmap that may be allocated during probe is never freed.
> 
> Switch to using the device managed allocator so that the regmap is
> released on probe failures (e.g. probe deferral) and on driver unbind.
> 
> Fixes: 61de83fd8256 ("mux: mmio: Do not use syscon helper to build regmap")
> Cc: stable@vger.kernel.org	# 6.16
> Cc: Andrew Davis <afd@ti.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Acked-by: Andrew Davis <afd@ti.com>

>   drivers/mux/mmio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
> index 9993ce38a818..5b0171d19d43 100644
> --- a/drivers/mux/mmio.c
> +++ b/drivers/mux/mmio.c
> @@ -58,7 +58,7 @@ static int mux_mmio_probe(struct platform_device *pdev)
>   		if (IS_ERR(base))
>   			regmap = ERR_PTR(-ENODEV);
>   		else
> -			regmap = regmap_init_mmio(dev, base, &mux_mmio_regmap_cfg);
> +			regmap = devm_regmap_init_mmio(dev, base, &mux_mmio_regmap_cfg);
>   		/* Fallback to checking the parent node on "real" errors. */
>   		if (IS_ERR(regmap) && regmap != ERR_PTR(-EPROBE_DEFER)) {
>   			regmap = dev_get_regmap(dev->parent, NULL);


