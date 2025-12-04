Return-Path: <stable+bounces-200000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A68DCA35E5
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 12:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB64130E22CE
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 11:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EF92EAB6E;
	Thu,  4 Dec 2025 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UqqqnnKq";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="RHu4i0+T"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7199A2E6CC6;
	Thu,  4 Dec 2025 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764846081; cv=fail; b=dNIeeK1mMd9D6reefk/u9ZFk6kI7xhhgokmLGP79NSyRx8UH0EZMUEPqO+gWlp0YoPn8PQAFK7JHGVpSUqC4UT0mu+f5GTv6feKTMkMUuXfgILEokGofMQZ5axuPKjmveluGBWtGY+iOJ1Kpl7yi96ONBn+2Q24CcUhG0uWKZws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764846081; c=relaxed/simple;
	bh=ojSukaTGfMhDV6S9DLtu43/TP1yMHgcHdj+tv2X/b8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oL+RqrVsTqLd8fQmc589LRWBQSzuiGnryZgBDr4PiYMIndjuEMfcBUQMIhCNE3NGOvGrkNkseXKlFwMTJanmXapX1lhWr4Pl/v4R/E5uLQfJbJxnXRnL1QwvghvnOjuRLh8BFuy9w63K1lGJvoOI8dSpbCExnc3zv6knZkmXH5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=UqqqnnKq; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=RHu4i0+T; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B43sKS93870567;
	Thu, 4 Dec 2025 05:00:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=RVzjj4jvafia/zUdQenCiuR37iRfJr1pJyCWfQIKHW0=; b=
	UqqqnnKqN9f8XYSqL90nUgXajJYHIbqZqGL3liyiCm1z9UnlfjQZ4uy9sNEtD8Zk
	avVC2ekD82ZtHiusGPa13SssxKWSbaA4hcG+7uM0zPNeHfaURQRsNIoTOKElIrur
	Ck6and0GIr2ulV1TMWRxpM1Jb1Z7VVqJYIH4MA6s8ZQmT9mltThRhROhAaIAEdUv
	d7R/W5/uLx5952kK9/U0L4Fpxr1VHzMP9iEHiS5mPW4kDS53rtfBJ8KLwy6CUhGO
	onC3htL1aegPqK+wgSgST3SxtqguoMSa+Qaow4CLzp72OKnJPdsMWoMySqM2QayG
	rMdVvUmXNf1HkQPAl/mkPw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022125.outbound.protection.outlook.com [52.101.43.125])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4aqy4464p9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 05:00:49 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHFPIBCRZQSwoEjtullMtthX4JEFVSE104JXCPvmmNXThTQtrqGBJse/JNUkoFEe7vDR75yrIQca7IM1iCECA2OP2bKGIOkN+UcKjy2UG4Ek1OdsT4pouvkRbtCk06hbbIbiiNURUDYTGvgHiJ2mZtU2s9kK/MSP4MBcX18r9TO9cXSXNoYVCNZsFPBr0HKGBKqmKc9DGt3Enpm7LXtX3tR/0kCnKSz5oBEFvLlkcU8F7WU+Lxc1hBvbQMNHE9ELhiaQeFL6tJd1OtrZ6HvbsH9deHnKWsuz7R1jmp77I8KOjK8vsUcqAQJ3aKT3sWh0Mc/yfxxJZdDOo+dRdTeICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVzjj4jvafia/zUdQenCiuR37iRfJr1pJyCWfQIKHW0=;
 b=G5Or/GE5jo6qo7KNvHqjppZlvI8C07t0s7BvXrOmbDFm/+awiEg+eqsJB7aig5VC3ydBmCRyWeOC75fRvb+D7WEignKOl46fV/wa1CNxXQh7YCrtl03TVyRrUkGBXd7FlC/8tQZopdEJ3uDnxIqEkiFJ5HnVtqVJITRSU7biks6aiaZmHF0QvnM7VQ96sQotxWNFe43OdYrnvKmt5aLYasNb7NIJ/nDuf8VzDVvs12dAGnRllvsADwXYLaEQ+przktCsn1OKeb34emaLGZPpjgB+H1SNPU+qOtNECHvM50HTRa8nyOc0dDT1M2dotUfqCqEBdqT5S8EMFed38JY4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVzjj4jvafia/zUdQenCiuR37iRfJr1pJyCWfQIKHW0=;
 b=RHu4i0+T5SO0eVxq0XTDq4JTU9Id+0hkmZuaa5wKsg/1LeFLSPKtLLb+6UIZQe2AzZXBeIlW/4O7iJRu3dCa6iBk1Rx+RbSLO7zDLBYk0E4vUw+eHjqEMR0rMqk6IK312dwdBbahSNu80eUBpYt7igVlUxzjS8yhbaCPu00GIdA=
Received: from CY5PR13CA0006.namprd13.prod.outlook.com (2603:10b6:930::7) by
 BL1PR19MB5985.namprd19.prod.outlook.com (2603:10b6:208:39c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 11:00:41 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::dc) by CY5PR13CA0006.outlook.office365.com
 (2603:10b6:930::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Thu, 4
 Dec 2025 11:00:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Thu, 4 Dec 2025 11:00:40 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 34022406541;
	Thu,  4 Dec 2025 11:00:39 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 193CF822550;
	Thu,  4 Dec 2025 11:00:39 +0000 (UTC)
Message-ID: <0946e25c-ed51-43c2-ba28-ff9c18178bc6@opensource.cirrus.com>
Date: Thu, 4 Dec 2025 11:00:38 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: cs35l41: Fix NULL pointer dereference in
 cs35l41_hda_read_acpi()
To: Denis Arefev <arefev@swemel.ru>, David Rhodes <david.rhodes@cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
References: <20251202101338.11437-1-arefev@swemel.ru>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20251202101338.11437-1-arefev@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|BL1PR19MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c78ce0-32da-4fdb-57f9-08de33245d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|61400799027|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW1PS0tpQkZ3ZWJpR29rdGwzb3JIL0MyMkVhNmkvaXd5R2E4SHZlUERlSzBW?=
 =?utf-8?B?RW1xN0p3VUdWNldnVERHK2p4R01HSmp5ek1RdWNQMnFXWGpzb2kwQmNiVk5V?=
 =?utf-8?B?YVQyeTRLRGR2MXBYd1ExZWE3alJEWkJBM2tRZklYMGxqbXJ4RUFSaHhLY2xZ?=
 =?utf-8?B?b2lvSWI2Tk9WdktxcmVKR1huNDgxQXhnSkU0ZER0V3V0bFlBZS92akF2YTF3?=
 =?utf-8?B?OEpPU0Q5VTBsZXZnQXF4SmR4NWVyRVZOZFVIUDRaS2xRTHB3dC95WE5neVFB?=
 =?utf-8?B?NjFIaWpvS3A5MCtPYjQ5SEk5M0g5Yi96U3NGZU55bmpXcnBGSWFpRS9NUHdk?=
 =?utf-8?B?Tk0rNWxLZHJ6NW10a2VObnRQblJNS08vUnU5Mm9Nc2l3UmdTS2pqUEdIVHM2?=
 =?utf-8?B?RGxmbCtDUy9ITWhCTzV1OWxSZklPUnE2WVM2SDhqUVVPS0FXVFVHTW1EQVQz?=
 =?utf-8?B?ZnMrLzBTeUk5UGozdmJNMzZSbUxrNHJ1cmdSc3JBMmtYMGFmMWx5Q3BpQzkv?=
 =?utf-8?B?eU0wdWV5eE01enZmVWJBM2tFVEY3a1pvZ3B6ZnNBcTZBT0hpd0g4WHdFczBK?=
 =?utf-8?B?VWhnS3ArWHgvcWhCc3g1QWQ0d3Y5UG1ZdDZ6QTFFcWxnczNGeTlDWkVxMEsz?=
 =?utf-8?B?eW9SRW5PUkZ1Sk9nSlFwaTVGMTNjNENWUnNZYitPby94Nm1TZzNLUWVZaGNj?=
 =?utf-8?B?eHZBN2c4cWx2OE0zWktkczdoNTR4eHBVRHNXRlFSeW1MbktVTEZIUmtiSjls?=
 =?utf-8?B?S0RhZXdWWDZtcjloYnZNbFEySG9JTTFGeU9rd2tJdktYVFY3ek01c1JZMmlj?=
 =?utf-8?B?RldnYUFCWnZCRVlkcy9PYnFsZVlyNTk0M2YrNWM0eG13eUxHTisxOGJETm9E?=
 =?utf-8?B?ZVljZDhjOU1XdXc5c1pSVDNPODcwd3p3ZTROVnFuVHNFVHpUd3FCSHFqVjFz?=
 =?utf-8?B?aE8zNjlza2NqSGFVWHFXRlVITEU5MmZZdmpMUC9uaUJhaitnM0x6YklwT3o2?=
 =?utf-8?B?Y2l5L2VKL1NUbXFDS0NWdVJmN2pxVmZQeEc0emZzQXcwUEpTM1IyV1l5ZE91?=
 =?utf-8?B?OGp1cGFERHVkcWxHbzYzcy91NWdHcHlHMHlHRCt3RmthNlZ6dkd3dnp6TS9P?=
 =?utf-8?B?LzBjQ2dlS2VVb3VhYVpGK3dBT2Z0OEJTeExxT215SWhldnFmY1FKcnhRbzF4?=
 =?utf-8?B?S0ZGWTlaRXJ6eWo5VUJybHQzeFJqaVpsdUh1SldzVkxwN3VwU2RpVFE3SHdt?=
 =?utf-8?B?SnBjeXVLREhKcjhOMTFnaTlIN3ppc0poY1dzM2RTZFZmMDNZT1hyT09lNHpk?=
 =?utf-8?B?bVZFbjNaMDZCWC9wRGJmcnZsZ3ZtYlJVVGZMblB6eHNPL0svWldIeEQ3WFdE?=
 =?utf-8?B?SkNXWStuWS8vS0RCZjdtS2x4WjJyRVdwR2tMajV1WkxnSktJTVpBVHZUcElw?=
 =?utf-8?B?NFozeldUa0NkSHpJMFJCclRNRk1zZnU4UE9mQkluZkQxYm42QnFyWWgxNDc0?=
 =?utf-8?B?Rk9JY1dFZlpvWGdBSHB6dlZLMnUzKzVZSkxPOXhnYVdhRnJ0cWwzWEdBWlRT?=
 =?utf-8?B?Nyt0RjROK2l3QkFmc1RFLzRDM3FYVm42aVhMaXlMcVlPY0t0U2xuQ09rTEQw?=
 =?utf-8?B?QUdkWTZucWRHaU14UG5INkxTb3ZPNGtObTZUdEgrN3dabjN3NG8xTjhmZzNB?=
 =?utf-8?B?cW9aa1FXeWFpTCt6WEhtTVJnQTNaaTdEeWpEVVhlNkJDcmZaQm1hRitXY0RC?=
 =?utf-8?B?b2RiTTFLVEM5cy9kS1kzRjBBZDM0dTZ5V29qWWZ5bG03TW1aTlJobGtxR0xK?=
 =?utf-8?B?bzd1RUYyRDhjb1Ivd01rMUo1dHZCTXJDKzNER3VmR0FXT2IvZE00T3dPN3lq?=
 =?utf-8?B?Zy84RUI1ZTBZUFViQkVLKzd3QU9RUm02OVlaWml0REVIcURuSzRxVHJtS2th?=
 =?utf-8?B?OUpZZVVnUjVQUHlPNEpIOVZlZ2gyYU5XekVpemRVSUVEc3ZMK0ljbkdQc2dY?=
 =?utf-8?B?bi9EY1h0VjIzbEFzZ3RvRjRDeHp5Mm10b2REdGNIVFpYODVGT1lHRG1ranNP?=
 =?utf-8?B?V1FBejE3c0REZ2JjVURtMHRRWjNSY2xuMEJZS2ZNNW9BOUZQcnZrbndWRFJw?=
 =?utf-8?Q?XFdg=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(61400799027)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 11:00:40.4684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c78ce0-32da-4fdb-57f9-08de33245d24
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB5985
X-Proofpoint-GUID: jRX7GLG2gf8mv7ip_f_rtC8BPjH04_Oq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDA4OCBTYWx0ZWRfX6hvLPuPuVsm7
 w2iY1iqCMnGwYTsxPWWuWUuXjrXTMrdmlX/CRcTfV4/VepPaCrBDKj+pKA0PKYnrIOntg7aZmjT
 bmzqYNVAgbSLi3h/napudQzofBvvjyXvEeD/EzcdDJVhaAyNH9yeYCU9baCmInm5JFAtemaqm2p
 Gc4+fV1E0xCcSBWQCn/GUHu1yovCtmNElClj/llvw25jpetCyKGZKIYg4xXYQFL9jVk7wOWV64/
 ie2wg73L783R7dkE1rUA+TS46bgq5BnSKKv7GimErlEcbnp/LZBYwBOknJe9pP69mCcVo2CIgn4
 e4sLudyuCsUmtof+dIch39MUtLrVnRus37S8bb6JX5JG+lbJZ3JAf+yYwbd0PKBYrNiLtRM6V1S
 PA69UaLDnCE1OPsP5K6RhUSrcSAVfA==
X-Authority-Analysis: v=2.4 cv=FK4WBuos c=1 sm=1 tr=0 ts=693169e1 cx=c_pps
 a=YMpgYF4YqoZtRZf0gxQL+w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8 a=EWWzKEDAAAAA:8
 a=w1d2syhTAAAA:8 a=w9iMS3UdBibZJB-JNhgA:9 a=QEXdDO2ut3YA:10
 a=QM_-zKB-Ew0MsOlNKMB5:22 a=8ZwbcxVZO41N_bDMix7v:22
X-Proofpoint-ORIG-GUID: jRX7GLG2gf8mv7ip_f_rtC8BPjH04_Oq
X-Proofpoint-Spam-Reason: safe

On 02/12/2025 10:13 am, Denis Arefev wrote:
> The acpi_get_first_physical_node() function can return NULL, in which
> case the get_device() function also returns NULL, but this value is
> then dereferenced without checking,so add a check to prevent a crash.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 7b2f3eb492da ("ALSA: hda: cs35l41: Add support for CS35L41 in HDA systems")
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>   sound/hda/codecs/side-codecs/cs35l41_hda.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
> index c0f2a3ff77a1..21e00055c0c4 100644
> --- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
> +++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
> @@ -1901,6 +1901,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
>   
>   	cs35l41->dacpi = adev;
>   	physdev = get_device(acpi_get_first_physical_node(adev));
> +	if (!physdev)
> +		return -ENODEV;
>   
>   	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
>   	if (IS_ERR(sub))
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

