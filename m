Return-Path: <stable+bounces-214640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNBcK7LJhWnAGAQAu9opvQ
	(envelope-from <stable+bounces-214640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 12:00:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D96E1FCEEB
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 12:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 109D6303B4C3
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D6E32F748;
	Fri,  6 Feb 2026 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QlTC4L6Y"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FFB29BDB0;
	Fri,  6 Feb 2026 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770375571; cv=fail; b=ZiywTTO8wTSfd/5wia/88VHpCMnjKUlKNha1LGsbiWGf7NnD91NetPOwfqtewZF57mYQ+VAibU9yS2cjj+UYF+IbMym+jMklK35ybxHRAkl3NSfd7HTGfFSF/PtCRewqXRGzTEIo4axPuqWg9ISiT1VCqF4uQ+nxSRD2dfWokaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770375571; c=relaxed/simple;
	bh=pVRTOasVuLiBOQkrV71l3Su+XH2mR2OpeDY51j9I2RQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID:Date; b=ZYnmy2xhg60HwXgG9zpV1GaTpAaOjJjeGl5cCVoXRvD3rrG95U9dPlWkFqN9Un7XfYOJ/aJrVdysbZT7INPCSHZBVjPdg8CPBbSW5NQdodxJy0O4e7ehLspQyyq6W4Q0scZQMMgPX42U209MiLYCRfnF9A1iCn98FPUxnDH27MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QlTC4L6Y; arc=fail smtp.client-ip=40.107.209.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ob4q3tuZTCH5EoqiHU8fddqqDIYTJPZlhXR6SzjBoVZThMnbhGFumRzpk26dxf5+SWZF5CdUkvndoz+Ov5JyZ8I/dBnSPz7sMrc/p/m4VmFOHK0g23kpu88KtyDrdjj7QrSBSnOmsv/5y4ikq77MN9AjVlm1/AiHQiBr7NnUt/IBI05YWUV7ElojzAIE+AUiCn3su5o/+7hdqo94VsTdFslZmGM4mUQwreERwH5yoW59cfJPaiNHF/DVFGxCZWllgY1EmNaxVPpyROLaUT4htzTj44g9ilEmNbvfkJ4yAR0GRQdxK6hTY2l6moNFHhy8cQuoUSjvhKDFFWq1PurrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poTJnKHb7kKVGEgXE++7Aj8PnFv53a87uXo3q9ME1kk=;
 b=gfI35CxeVV0Z4wNo1LcZAT8WJSjS0pG+ZeCt+BWzkwteWxIoJ7p8VF3X9UtMrk3/BUAgEWECeDCokHzetcjsPH6ttTyMHGULwzMl3vXdbAh8ReD8Qfc3aaYS1a4N9Hp/VJPcSlnZSCJ9LZrFXDasJfJasmByfO3FDSf5xcQqyXVA1buL1sftcnBWLi2BS7eOXh6QvECJoTsGKKDV/Zk3oF39YyCim76e5oA2XIZWVWURsFk2a6ULT9Kxh+zFUSr05T7Uud+tF+sis1+Imur+2vmd1arTW8YkWFAMy3I3HEjtzdTmGj5lu6zHMVHzEsFcPi6fSooZsqaYlzgqLjuhFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poTJnKHb7kKVGEgXE++7Aj8PnFv53a87uXo3q9ME1kk=;
 b=QlTC4L6YVTeLITo5gPWtalEyIetzuEqOBfS9f1Baj/9S6VHTYJ1KS5kCwtHBptB+oDKtIpjZgQczvUe509UE8mk1+J0LzrqgUcpTp8AJueNk34IZ/m2QTYThvfhbQ/L4ok8UIgYfwFJRnwvzc+henNP2cXsxGRiyVjpAdLVHWfL9YLNHRIxVZ7l//VEIw61yKifavFa9HX/uiHSD7Sji3Tgpc3ls8uR/Dv1oOZbCyfOBD8siKH6NO3Xmti6cvhUy1rlZEQSxaKekIEm148Zdp0JZj7xGUpEoAVuKyYpLljARy1g7pDuGQ/ORfZjvnbJlfCXG8hjq7ZJIwI/TRPEzYw==
Received: from BYAPR06CA0072.namprd06.prod.outlook.com (2603:10b6:a03:14b::49)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 10:59:25 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::52) by BYAPR06CA0072.outlook.office365.com
 (2603:10b6:a03:14b::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 10:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 10:59:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 02:59:15 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 02:59:14 -0800
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 02:59:14 -0800
From: Jon Hunter <jonathanh@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
	<lkft-triage@lists.linaro.org>, <pavel@nabladev.com>, <jonathanh@nvidia.com>,
	<f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>, <rwarsow@gmx.de>,
	<conor@kernel.org>, <hargar@microsoft.com>, <broonie@kernel.org>,
	<achill@achill.org>, <sr@sladewatkins.com>, <linux-tegra@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH 5.10 000/160] 5.10.249-rc2 review
In-Reply-To: <20260205143430.733102763@linuxfoundation.org>
References: <20260205143430.733102763@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <d17d6ac7-9b5e-421a-b416-c3e278eafd28@rnnvmail202.nvidia.com>
Date: Fri, 6 Feb 2026 02:59:14 -0800
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ba5b79-3753-407b-bd07-08de656eca8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG11cVBqZlJOcG5YczlxUjVsM1JNRnlBSGNtcDN1Z1BvY0dUMis0QWZqUFoz?=
 =?utf-8?B?cGNTZGRCd2gxdktNb0dUYWg5K2ljNzdxQnRNR0NYbmNTVXhJMks2d21wRkJk?=
 =?utf-8?B?dEFnU0ZBWU5UMTdqSnh4RnVUNE1WYzFkN1ZJVEZnMlN1QlQ5Z3pvYjdNUVpp?=
 =?utf-8?B?b1FLb1hxdm9KRGRkNlQrb2xDeW5Ma0J2ZEZlY2dXN0E1c09HbEYrU0xCRlVq?=
 =?utf-8?B?b3lFaXNuai9SV0RUUmMvQ2FXTTR3Z2xjem14VWdmcXNaQ2l0RDEyZklOWE9F?=
 =?utf-8?B?NS9RVWVXMWxXalBPTVlqbExzeGVDNk9WUTVIN092aDlWTW1maXZSejFweHRm?=
 =?utf-8?B?N29Xd1JpellodmQ1TUpRUjNhbXI3TXNRdUcwTDBmd2M1RElkbHNVZ3lKWVJm?=
 =?utf-8?B?dXU1eGthTGV1QVFmejhpdTg2RDVaSW96RmhPRHNoaDIrY25lNll2VGt2djRP?=
 =?utf-8?B?eFhkVm5MUkpMQ0ZJSkRRY0lEamZKYjJVdTlsUm12clBCTnk0QjQ5b3Z3RU91?=
 =?utf-8?B?SzlvL01ETGI5RnBESkMrSVRLWm9OY1pybFZIbnFYSUlKZnYvUnZIa1VxcWNl?=
 =?utf-8?B?ME4ySnZXRXNPV1lNckxwZDdraWgzaVZpRXlWTzdMZ1VPcTNLSlVITllQNEtO?=
 =?utf-8?B?YzhyZW10R0dadU9JYzNudWtsMTBGeElKTVA3eWMrTnZoamNVOTgzcW1wc0h4?=
 =?utf-8?B?S0ZvN3NKanRuVW5IdUdLREJJK04zSWhSU1luUEczd3J5R1BDUXluczBmQ1ZU?=
 =?utf-8?B?bDg5bGFNbVhQWENPK1Z6OGxqc2swZCtCNXJDY2NsZkVNbXJTbnFyZ2lOMWN4?=
 =?utf-8?B?Y2xGVE9SZnFPU01JOHExSzBiZ3BjVXJ0ME81VzdiTXNwQVo1Qmd2Zjc2bGZ5?=
 =?utf-8?B?YjVHeUFYWXNzRUp1N0hhd3g1L29qaDRweEttVmRVb3hic2hkaEdUcjkvYnd1?=
 =?utf-8?B?YVhjazFYQi9yb3o0c0RzVGg0Y0ErNWhnWnJIVFBUWnF3Rm1kSW11K09WOUJi?=
 =?utf-8?B?bHdZMTdkNHZyYjRFTEtjUUZzMW80N0pMTnJCTTF1UFBMRG56Y3RFVnp4cmJz?=
 =?utf-8?B?MUUxOEtGMHRrTUJ0aDlWL0JJS3daRmc0N3ZwKzRVWkE4Yk42Y1FQUjNyZnJr?=
 =?utf-8?B?aVNRK1l3RW5lWEYxVjJaVEJWaC9DNkhNVWdiY3ZWTWF6T1NCMEhmMDU1YXdM?=
 =?utf-8?B?dXNDSktKaTZnay9zMk9mUlA1ei9mcnI4RGZERUNwZE9udityOU1nNWR3Yit0?=
 =?utf-8?B?U0IvcGpjQnFycExpMDc5NnZNNGNUL1B3SjZNdUJRRU5FNUpWb0E1WTU4Yi9I?=
 =?utf-8?B?cDVKMjl6OCtKazVLMnA1RTQ0V3dCZkdqcngxTVQ3VkpsdWpWM2tOL0xZaFJx?=
 =?utf-8?B?b0kybmZtZmlYd3IwTDA3UERGc2gxb21TZzV4TFRGN0p3MlROVEhaczBYdzUw?=
 =?utf-8?B?VDUwU1NrMDV5MVc2Y1hPSXo5cVhQcHlkK1lPZE5MeXUwTTYzU0xKanVGa1FH?=
 =?utf-8?B?dHVGeEJlcU9EKzVheXViVVNEcFFCYVZkaUlXc3pTRk1iNG1KQVRLQmZicy9Z?=
 =?utf-8?B?eWhnZnpmb3UrejRSYWgzTlNtcmhsL2F4TUpTWjRPRm15WWFYK1BjSEJiWWJo?=
 =?utf-8?B?aXg0dzJzd2hxcDhlKzRLTHdWMTV2a2QySHJzS2ZLb2VHL2hHTzFGRU5aaExv?=
 =?utf-8?B?Q1hIV1V2bkhIWEZzNXhuL091ckxWUUNUM0dCY0tBcTFyWjNyU1hLMEUzbVg1?=
 =?utf-8?B?WjVnd0hzN0cwL0hLMnhsUGgrRGt6QktibUJVSVp1bEpEM01HQUNCWjJYc3VU?=
 =?utf-8?B?Q0hpWGd3engwdjR1b3QrWXdiaWxFZFBjTlo1QTBOWEYzS1I3Z2o1RURmbWdC?=
 =?utf-8?B?aHBWMkpkZXp5d2tEUThsQng4RVh1RGswelcvMmROMWdGb0d6eEh1eUQyTEVN?=
 =?utf-8?B?dmxXYWRsazZOcXdkNDN2V3FoN2ZzZmRrdEduU0pKMDdwWHlONUVuY1BUQndi?=
 =?utf-8?B?a1Bvc2x6aitZQkl0SGdWZVVMV3hxSGl6VnNnRmpUcnNJanZ0bmdxR1YvRnZL?=
 =?utf-8?B?WmZVM3VHTTRicUhWNm9yS2RkbDl2S1F2RWNMeWE0U05TUmdlN09SNUpCaENz?=
 =?utf-8?B?Vm9BR2M4WllkVmdyWHBEZ1BsMjR2WmYrNitidWdJMDRQdTg1OGh3eHhVM3Fs?=
 =?utf-8?B?Y2h2RytlQi90RHFIZ0RLTWdLaUxEZXNNc1pWTWxxNlFNaHJMS0MvMVdRY1dt?=
 =?utf-8?B?V0hIMjh4Mkc4Ni9GclJSSmU3TXV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EQEk2FAb9a48ri1t7w3TTaqHAuRYPOkMtWSV+GtOFw9ClC5kluCapdD5vCAhZo7ukQ/0BOXw/g9Gh+Do14gBo5seBZTmxX2HRyKVhmmoGQ77ziYYGIicNhHGVQZdWEU4ZkEKt64coN8awkwoJm6E2O9WeuIp0mStgFPte67xrIwyIYTdRgn6NKNxEUuUKa2GTv6yrn7nbOrLeW1nOwvtKowmRoMOVEkmjCMzYSeYH4xDZR1oCD+4dGUZL4UOmnS+bZbaPAOJLRF6/OwurmRaygan3MLMnICcgTXnUnU9WqYR64st8EmdFC6P0WgS55YqhHCrUQO+9RaLq4mlb9h2gjsO+uKG+4xBtPgo4WFjaMrbGDla8HWtLZZg4kbQsCR9TUWbnctG8/zZ30QK/Lr9rDzk8HnkgdN5x/aWaoO4kiHLtvDGjMu83ytpGMHFGsGX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 10:59:25.2114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ba5b79-3753-407b-bd07-08de656eca8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214640-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,rnnvmail202.nvidia.com:mid,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D96E1FCEEB
X-Rspamd-Action: no action

On Thu, 05 Feb 2026 15:44:19 +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.249 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 07 Feb 2026 14:34:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.249-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.10:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    80 tests:	80 pass, 0 fail

Linux version:	5.10.249-rc2-g06b76f52e06b
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                tegra20-ventana, tegra210-p2371-2180,
                tegra210-p3450-0000, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

