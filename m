Return-Path: <stable+bounces-89286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E67E9B5A33
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 04:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63831F21C83
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 03:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90341946C8;
	Wed, 30 Oct 2024 03:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nrOOvpU8"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F184437
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730257882; cv=fail; b=P0caXdhzWsWRH/TX6wAeOHA/TbQrRppehKIzwII9qPlC8C3PF1b4sWgjvxxTOxkHMriaLCTA4E29C3Ti83i4aeiZJlumKQQuBkCk5PaweKFotkBxhlThOmSQf9wyH4ZZpWwq3Crs8dPKzBpjpm88JM1Ck/dYjORb6/I7yJe3oFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730257882; c=relaxed/simple;
	bh=YVqZfW/3+CyLfmM6Jkw7QYrdKX2rKs74c+Vue+O9Qys=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GLOB+7ggRUsihNtAFVnGbwa/0eOxqeKNJ01inUS923Tfyy//Eu/rZIDUmPFZbl1tC9AF4ych46T33t0MZH75jnUdRPGgdhf1pV9ale4Hq1svyqsBvVKEi0dSuXRobv8IdW5i+WIBWp0SrDg+Ly61TsLdiMwigCYrVxvqSIJDrJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nrOOvpU8; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ns3Oiw193ZYzQITdLjhh6JrHKiaSmKJvm1uCbChLoIZOg7YjZ7Al/p/opQ5kXK7/EXNghorTyxjMdG1QVlRxck7ReBOncH4qVoy9AJ/33terWXYL0J+n20AogHxWEMYHrAcKn1R8FXvz4TCbe2B8ztZ+CaL9+rk24gXczpq4m2lhl/0dCWmj9ZpQkTAC0PFYJjYGhQNyF3Oz4ndYxCm5gIkleY/1yFDEgmhBh/ogNSIpcG0OPxVq0K+XIY6ZQpZ8rot+/de93Y+CcFdqv5r/+mZLMuoDfDHJk3a6JvlfNzhxPMNZL9Qwk8Q+ki9ocWLzgXa+vhkmIKnMQnOs23M+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEIosCZpq9DURsvX+16k1e6jTECPKs/aO4ZQZKpY00g=;
 b=jYLD8+F2BXtlLl7/jl124JvnZ/TRwMC4A9AVXZv7hWlB9rgBXhgzHR14jABBwicT4i/953VeWRCZVtbxLh3umaItWUTISOlTRt8XvnQRxyvmAUkH26xJdpNNYSVZTsOQoV42z60Q03CO1Pi3TWwh9Amy4lno5E/g4fQslC4QQQ7KhDXYSmm99V62XDEmHsJC1XFRAn0bH7gZR2TAqROkx0od7enS7aK5XqAFepYKaIA+1yAJ80uKkWwa3v/6nsgShAQvl+G781fFHFuOffe3iPYvAn4CjuE9W3fulzedLmKqEqkLSqXQOMxLXbLK2PKPDGhDb+aRVvXP9JC1BcuO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEIosCZpq9DURsvX+16k1e6jTECPKs/aO4ZQZKpY00g=;
 b=nrOOvpU8hhZr2tMqOiFLGqZlRTD1kJdDyia/4Jjp5k05rQg2SIvhrOIHPF/qmg/gMqFJ774FuGSNlnysj9xdWItkb9g39dVrX+UzDYeNk4o4RcGdVbgfvOXquz1wUFFyB8E+Ol1VFhtIOHVDc5J/Bf56zicTEPERxGVhuuOIH3jrKZkdffFC31JVo63rmlDRE6SjpvdLnAMr2v9NKxLI6MRF3cH+/6Z1o1nUy86wanAXMhMwUQ4LcWK5TrLSU36weJuYranvnkwB5ZmKRjwvZ0mhc1x2bwHIZVOLu9Z/Rs2lqzrc7WyGpxHoSP0JUJx9oelF9I2hY0F5hUSSNXH99A==
Received: from DS7PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:3b8::29)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 03:11:13 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::a1) by DS7PR03CA0024.outlook.office365.com
 (2603:10b6:5:3b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Wed, 30 Oct 2024 03:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 03:11:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 20:10:51 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 20:10:51 -0700
Message-ID: <a716779b-24b7-497e-aaf1-bb44f3cd5d48@nvidia.com>
Date: Tue, 29 Oct 2024 20:10:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
To: kernel test robot <lkp@intel.com>
CC: <stable@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>
References: <ZyGhyDiXV1lIvIEe@433b1ac7a1a4>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZyGhyDiXV1lIvIEe@433b1ac7a1a4>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a80d41-36c3-40d8-b206-08dcf8908294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3FvdW1OVTViM0VaWXNFODlFditCaDg3TXI4Z0krYmFUUFQ2WFhEaVFBRnQr?=
 =?utf-8?B?NTdobmFzOHg3UU5jY1UwWG5QWXFLK1hEY2twem84SncxOW1JY3AvdklrYWxy?=
 =?utf-8?B?ZzN4cEE0MmFmeDlxeWRmRkNvdkFQT29QMEhtMnU5dXFvaW9uMW1nZkFNT256?=
 =?utf-8?B?WXRuaXBvSVZ3Sk55eG1uY0RlU0w4VnJHemdvNVM5Zkg1eUF6dzZzUk1EOUk1?=
 =?utf-8?B?U1g2SjNGN2ludUNzUW84WnkwRmQwUy9naE11cis0MWxDUWxXbGUvZk9UNytu?=
 =?utf-8?B?RFBKTE9QMEUxMHd4aUh1WitvMFVsa0orR1cxTmxTRDNFUFcvdWpTSEVIMTk2?=
 =?utf-8?B?NnpsQnZDQzdsRUkzTTQyZy8rQVhPN3FQSTA2OTc5VCtkVC9sVFJsUGJNYThC?=
 =?utf-8?B?T1JUSEp4enJXdlRuU3lVcXdxeWl2Z2xKTE5MQTVrajlLckVQeHE5V2xSVzJ2?=
 =?utf-8?B?aGJPaE1ud3R6SVFKdE12L1dramtkb3dpYTk1c0NDcGhIdllCbFVWT2xGY3lR?=
 =?utf-8?B?MUdLRkpuQW1HZFhTeVpHQmVVVUNpSzV5WGlrNkNoRWxua2NIUmNPMHJ3ZCsw?=
 =?utf-8?B?dVcrQnNXUWFUNnIwWTFhbzZBR2FyQ1NtZ21WSyt5b3RZWDhsMXJIR1BXdW9q?=
 =?utf-8?B?Nnl2dVMvdzM1KzRFRXJyTVpMVGhCNWNTZlpoV2NicGcvWUlFNVB6WHpaMVR6?=
 =?utf-8?B?aThZMkVBdzQ3Q1p4eDl2emFPeFJISkJFOGhiYmNhRmhJZnpDblU1aE5WcDhQ?=
 =?utf-8?B?WGpqazZ1SitxOTQrZkJWVkpSS2JaNktYU3RFWEEwUXNtQXo0WXI2VE5qcUtj?=
 =?utf-8?B?SWZYZVI0TVlFR2QrVlcyUDhTMUgvN01MRkhicGVLVjAvd0pRUTQvTFdlM1Vl?=
 =?utf-8?B?S2hCbFlkMENhK25RVDJodTFBQXN2UVRORDJRZzNIRTJNSk9rd3B5Nno5SHlk?=
 =?utf-8?B?VlQ1QVg0cW1IUnh4U0Z1aklsVlFZMnZKajA2Qm41QkpKbjlxaFptS1kxbWN3?=
 =?utf-8?B?czRUaURzUXFBS0pRRzM2N05UZS9FZ0NtNEc0b2IzU3FCNkc1c3h5UUh2V0FB?=
 =?utf-8?B?Y3ZIZ0l1NWNoZjhEUmJjbWJ4VklvNCtwQTJaNkFSL3ZLektHVVlwK1FwdlFh?=
 =?utf-8?B?SGEwakEyT2tjbmorRWpHelhoUUwzNHBhK2dSQ2g3dSs3NVdyb2RwTlFweXdB?=
 =?utf-8?B?QmdFQzdrQXRrN090ekl4b29wS3U5aEJxT2kwTjVkTGVsWWRLb0pwYitTa2ll?=
 =?utf-8?B?dW9NY0tHMDZqVjYzcVBEZ0pCWXJjRm5QK004RlBXM0NhU0RTUjdveTRNbDZr?=
 =?utf-8?B?M3FQVDgwckMxUDZNWmswSmpmZlBBc0Z1cjJNU0JZakVaS3Brejd6Nkp5TjVL?=
 =?utf-8?B?SjFWNE5oSjRyb09VNi95VGxweU9FdHN4QlZxQ2JZRDFpcmJHUUsvZDdJNGpQ?=
 =?utf-8?B?NHA5czkwRmJUTE9yckgwRWZIUnVOc0ZYcGFqVExMOEl2cGcwMGZDV3ZHTFJ3?=
 =?utf-8?B?WlZPTHdWbndUcnVjeTM2SGlaYldCUUNnR3JZWER0MXJSOGtpLzdOTjVoNk5B?=
 =?utf-8?B?Yk8yNUdmNW9ueVdGbGhSc2g2Vzk5WW96a1BEV1hBMjhqNHY5RURiRWpUUys5?=
 =?utf-8?B?ZVdJanowT0tpcE9UZWEvN1FPZlhsak1kV2trcnBWUFRqU3ltNjRKRHIwYy82?=
 =?utf-8?B?UUNQcFNZdEk0U3BrQTc1VmhNMnM5empSYm5LNGozTkp3ampSalllbEcyMWpn?=
 =?utf-8?B?UTFFMGl6QjNCcWlrZlBjSGNweFRDUFN0RXVJZ2JCay9IVUZ3MVU2MSsyRjFh?=
 =?utf-8?B?Q2EzNXp3aGhGdG11bWt0TFdFYWJqQnNONUhJaWVtdVpyMks1b1gxT3hqOHM3?=
 =?utf-8?B?S1VncG9oclFZNmF0eTFHOEUyZTZ1LzlKRG80UE9jUkpuR1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 03:11:12.8123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a80d41-36c3-40d8-b206-08dcf8908294
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696

On 10/29/24 8:02 PM, kernel test robot wrote:
> Hi,
> 
> Thanks for your patch.
> 
> FYI: kernel test robot notices the stable kernel rule is not satisfied.
> 
> The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> 
> Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> Subject: [PATCH] mm/gup: restore the ability to pin more than 2GB at a time
> Link: https://lore.kernel.org/stable/20241030030116.670307-1-jhubbard%40nvidia.com
> 

Maybe my "Cc: linux-stable@vger.kernel.org" is supposed to be right
above the signed-off-by? Confused.

In any case, I hope Andrew can fix this up, if this first version survives
reviews intact anyway.

thanks,
-- 
John Hubbard


