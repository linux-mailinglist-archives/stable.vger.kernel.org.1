Return-Path: <stable+bounces-132636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0A7A88663
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 17:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297901907527
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719642749E7;
	Mon, 14 Apr 2025 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hm0Mzpzy"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60E71747;
	Mon, 14 Apr 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641262; cv=fail; b=RNkumBf1wD9B9TWQ7dS8LzJgonz98OWo3+i9k2cNqWCUkVmet2mSPYZbCEORRI4lT5M9t2OdjqgNi2bXPggl3iKV2mSE4w7HOPCoQ0uKywmFLEdlfcpZGtbphvYo6vH0mo12xS6Ip/dajzCkcLh8u3tns5M3Mwd2BrXYPfwMXE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641262; c=relaxed/simple;
	bh=V6xTsTV6U0FhPYGbusQTMtFQpSfvp79Q8L+1+NDvuos=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=Jgn2M2sR4jjjhwvMMlwXe87AkBVNJ0vlIG8YrzxJjao8OiB9qNExJWWXjYzgukMwYE6IVR9Zs+5WDcEX39/t9mzsTQwlkh40Mky3g3tnulyE8HCMZ2pCYTy94FKUSzZSZIsSYGrOqDhebpEQqu08+iAlcikpNwuZESlTePUSXWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hm0Mzpzy; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZ6yLQseWKOussHaY4EQ5PrCM5Fo6PI3UVn/Sc/BeGeg+uYwadBlCxng4IANoHifGpvePqLLcLXFzHmKIHMPRixpNPioRcllNIGumOCeEiux027u2HKoI69VRJ+ni98vfrmZAnjywNKXSQZRjxoIb6eRsmrIfDOBaxP6IETNToycOYcDCheuGhjvgWqI5gHaiqCJzNuxEGm/ALWXtM/sgtq2zsQVJbJGmXUZ86VoB8e/0TQ0si7m6b8R/SAnsNH3t/rHt57xc9MGHSr/uBpzQnSAozWMv2SULMT9yXaVCTCG6U494WtoUyaZe6ENb8Ug22cFH+dBMPvmR9J5dSqYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q1EmSxi2G/KhTp9cc7zrsYBeyD1gV6F/7hmiy1rsqE=;
 b=M8VFoE7Y7LjffSlRXV3WqQawxiND7fgnJYR0vtAbtRBqhZ4NK+ljR4iS4Xfv5g13JSapg1r1yRbGbPJUJ+Qz1ZncPr63XVJ3OB0+H2maC8a/MvTaNL9kPB5p5JRY0E5PWphNr00Maj8mgUt2aaSBdKFJYW/stGdYRQ1XGg3Kw6ajH31C0Obl8yvesgLZ+iMccaG9jZOfi4ndNxK4WgUJuvcrFAgfpxq7DKElW19kZs/GsDZXkouQANpx/4EmBXWgLPbdv0thsoV+0O8/1B9Vj9AW+9MI9boOcbs3s898Sid/vhyicU6x0szQ4u4hnaeaXpg3lU2YKH3vDpy9jr6Syg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q1EmSxi2G/KhTp9cc7zrsYBeyD1gV6F/7hmiy1rsqE=;
 b=hm0MzpzygCaNZNE+iUR+WIs45JhsKwTEM32IUc4OGDT9HzoC4cBUsmh/1GmFVSdXcotQiZvzSW+3B5jf37mUfsLHdqNTWOtWEWMcsPNDua4KQJhZydtZdllXgl68EQjkAeDtW2MQpzmcp9JdL03zlaqwoeOBRctZmiehcAml0iQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 14:34:16 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 14:34:16 +0000
Message-ID: <22ddcfd9-d3b8-204b-6ada-7f519143a261@amd.com>
Date: Mon, 14 Apr 2025 09:34:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Vishal Badole <Vishal.Badole@amd.com>, Shyam-sundar.S-k@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250414120228.182190-1-Vishal.Badole@amd.com>
 <20250414120228.182190-2-Vishal.Badole@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH net 1/2] amd-xgbe: Fix data loss when RX checksum
 offloading is disabled
In-Reply-To: <20250414120228.182190-2-Vishal.Badole@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0198.namprd04.prod.outlook.com
 (2603:10b6:806:126::23) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CYYPR12MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: cf398e30-9726-4c13-ab55-08dd7b616ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTFCOUxsRDhkRE9sV3J6UjQrbit4YldRVno1Y2EwNkVkc3RCUE1JZEI5alQ2?=
 =?utf-8?B?WVovblNrT2NpcjBlblJURFBxSDJRNFA2dDNzY0RKZVJUQzJMUk9sdzBiOTNN?=
 =?utf-8?B?SjlmNjBpMndOVWhScjJNbW9VdWx4K3BKNnI4bXh3QU02SzNMTlBDZFRKSmlt?=
 =?utf-8?B?czdrODAzRythSGx1bzlySzFYY0Vwd0ViYXN4aXpVanl1RURXQVdnVW9JNytD?=
 =?utf-8?B?cmJGbEF3N1A2REUrbnRSNXZuVFNNc3RpMXdLQ1ZhQjhzWlFwVTZTV2cxL3NQ?=
 =?utf-8?B?MmZpWUJwT1drSmhXY1NYZ2ZLaW01c3JIYVNNemZiaW1NWERKN2ZuV2hjZzF2?=
 =?utf-8?B?MjlrZExPVjFiOXhqdlRNWnY3N04yMzNNQW9xOVNwWWxrZ1VsaElOc29qTEhz?=
 =?utf-8?B?TG0yV1FYZWRFNzJPLzlBMUE0Rm9SdzdZVkJ3YTZKSElzbW1UeEZoTDlXK0h1?=
 =?utf-8?B?V3htQUxSRWtuTmVLS0QyTDJXdWw1SWY3K2RwcG01Vk5RVjBDWXVNN25oVFhk?=
 =?utf-8?B?bHZ2RlhvUkpVNWxzRldLY3hSMDVUa3BoRGZtU2VoUnJuNGUvc3hNOTkxSE5W?=
 =?utf-8?B?TVp1UElkU1Z5aXBCdFo0bytqbFlhNU03MThCdjZLK2NobWd3Z0t5WFZnV0kr?=
 =?utf-8?B?YTUvSDAxWmEwbTJPL09rbHNuQy80TDJRVndXRnZnbUgybVBZa2x6RDlqUmRZ?=
 =?utf-8?B?clAxSng5bDVwVUpMVG13YkdpN0VkY1NRNjhOdmFjN2F6Mkw1TlVlU0dHZ3JW?=
 =?utf-8?B?MkFxNzZJYnFBazl0cE81L3pCMzkvbVczVGNlbWhvWHlkeXR0TFgzSVlPV1VT?=
 =?utf-8?B?bUcwSjh2YmRMUm8wWGo3UVptc2dQcFp0RU0wc01kK2VHRzFxaFJGUDJaREFo?=
 =?utf-8?B?RWJEU3Nycnc2TmczV1pObVpCTXhxWEtFRWFFWEF5bVJCWHVZNG1VdTZkWXF2?=
 =?utf-8?B?cW82Zy9aMzRVVzhrK3IyQzJpclZtdmhFQUVrVzRzWlBqK2ZhSHlQV2RXSTc5?=
 =?utf-8?B?RDYyT08zd0F4b1Vxdk1RMzgrV2RLUmd2eUNkSmZjMXJocVpaMUEvRktFL2h6?=
 =?utf-8?B?a3BWUkVBazBjeHhjRmcxRXhXWTd5VDBSVkFnVVlXcmMyMVAyUU45RDIyNG5R?=
 =?utf-8?B?RUExRVpTdUs4VXpyN3I5ZzNsMGlsYWpGcEJPdTV1cUxnbXYvcCtKNVkzTWI1?=
 =?utf-8?B?cE4xTnV0Y1ZTKzU4c2wrTTUvYS9DUnVpekt0ZkNqTElyVlllR2M5Tjdqcnky?=
 =?utf-8?B?U3R3dDNiTzZZZXYzU3VLTkxPcjU4ZTRkc0FSNFprcHVuUm9LVHVtM0RxTlg5?=
 =?utf-8?B?R0piNkpJYXFuVFlpVU1HS2tTeWpBbjcxckNkM01ScWNnS1dibzM2bHRadUtp?=
 =?utf-8?B?c0o2UnhhNmV6aXlVT3ZQelNxcVluWkRDVTVWRThaczZDcGE4NmlLZzRicmFx?=
 =?utf-8?B?ampQN1J1bnJ5cFJBOGZ5bTRNZVJJUUgvcXlHT1F1WDVoWitvRWFuYVNHT0dV?=
 =?utf-8?B?RTBid2NOSkRxcWhIWG5YcHI4Z2R1ejFZeUlkUlYzaW1XUDUvdXpQU0VwMkFi?=
 =?utf-8?B?WW84YjZMOXdrVGtzMm1tN1dQM3NlWUs0OWJ0cWhmZjZzT1JvRVdYSHZHY2lN?=
 =?utf-8?B?WE1KTXF5NjRUY1YwSW1BdzVHaFZwZjB2Q1VETFJzQTRNejRkUzdkcUh0UkhM?=
 =?utf-8?B?b0txc0NDbGdtY0tNMG5kbXVXQm8xbWRFTTRBNVNNWEtFRFpSOFNiVEJTTkdZ?=
 =?utf-8?B?eWlKUGtqRmpiK3RvME16SDl6eUEvREJ2a2dPRWlNM1VhVUZvU0FRZ29nWW9h?=
 =?utf-8?B?SHNRUjlDT1pGUHp3ZFVEeXhtMWJqWjErRldaaTBXQ3hGUzBxZjZmWXhMVVE5?=
 =?utf-8?B?aHFoTUZqaWhuVFdJRGFOaW15bzZlOHh6TmdzUFQ3QlpIb0ZjdXlwUkJWT01x?=
 =?utf-8?Q?csu4+nDgsCI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THhQVVdWYkdjVnJZc0JhcjZPRWVxb2hEd2RidXlwdThjbWxUVHBDNGxIN29T?=
 =?utf-8?B?Qyt4YmNJbFdMNzZNOVFtTnl0amxUZ0ROUkxtWjM3ZXlyc1NXcmRRU0RQQUhE?=
 =?utf-8?B?dHFlV1hONHVXQ3YxU2lHUWhBa05TNEZITWlwK1p6dGFOMXY0ekpHZnNYaHNi?=
 =?utf-8?B?VkZzWXhPNW5XQTlpMXI0MDArcUxsT2JLYUxtdU95R2twQ1kzS0g2VlpIZ3hG?=
 =?utf-8?B?ZHowZWZFZlVNQVQ1dU9zT0FPL2lhUW1WZkZnWk1jVDIrRVNFRjB2L1VhOWxU?=
 =?utf-8?B?MDNSN2lzbytLNG9TcktXUWJVSHVoNzJsMlQwWE42N3ZZa2JITnQ0RkIvQUt1?=
 =?utf-8?B?NldncytsU1gybDNBeW83enpFRlJ4dlpYRVpXOW9SWXZjeFlUWGx0OGROa3M4?=
 =?utf-8?B?eHJSVHo3eTNFTi9tS2pEODFuTmpwc2NSUEVxUzlyaUIwbFF3dTRySEFaS3hx?=
 =?utf-8?B?OHdhZDRxYlN1THd5LzBFbXNNSWE0NktWR3BHcHFEdHU1MU5iOGNJTUlsa2c0?=
 =?utf-8?B?Wks0c3BFZ0E3S29XcFgva0VLNk54YnN2NXBNSjZNenVmOXFZbjg1YjdSUnpN?=
 =?utf-8?B?NURuQ0NZd0dCUysyWm9kNlF3djhUR05JS0llUWpoNi9SMHVOMHNDT3ovZmV1?=
 =?utf-8?B?M3VxeVQwMzJlOUZjMTVUckw2b1F4SkJDRkIvdURaNno4N1FjeFN5cHNUUzlK?=
 =?utf-8?B?Sk9iTWdiSVo5cDVUVTFQOEkzazloRnU3eTRpRTI3TFhlOWlHRXVYdUhHdVNX?=
 =?utf-8?B?VE0wQ2phQVBnOXNDNHprSGk4Yi9jUGI2R2FGYUQ2Z3VtVHZnTEJLZHdhWkFL?=
 =?utf-8?B?bWZpL1lIZWVETndwKzBCblRzbDRsbkZ3SGVNem1kNUpzMlN4ejB5ZEhSUjlO?=
 =?utf-8?B?dUUya3NaUEhXWGNqL1lkQjRSMlNrZ2g2QmxGbGxyMW5jejJxcEpwN1V4MWpJ?=
 =?utf-8?B?T2Jwdk14ODl6a0VKeVFjbzZlL1BNUXlSQ09odlM1SFFDUFoyWnBOdzBtZzl0?=
 =?utf-8?B?QmcvNEMwTFk2VWxWWkR4RnZrM3VkSmJTYkQ0WERnQkkwRzczODNqZHNzdjky?=
 =?utf-8?B?ekdwUVU2MS92dE5WdDgyRjZ5SUVUVjZIeGtsS1M2bnNIUVVraTNmQUo1a1Vw?=
 =?utf-8?B?WEZBQyt3ZkxFSlhzVEFOZ2pSSjFERXpGTFRteDk3ZXpMSzBNL1JYaXVhS0Ns?=
 =?utf-8?B?dTZKWEErcUNBRUwxQWkzRWNBU3ZsRnVOMzVxRzNYT1BOMEY0bjd5bmd4U05W?=
 =?utf-8?B?b3NTbFFUME9IaEZ2d1lIcDZwNEp4Vmhlenc4ZXF1TTVEMStiM1lsZCt6bmhF?=
 =?utf-8?B?ZjI3SVNKU0FwekNjNjBqWUlMbjh1MHVsTldzYjZUYWVtMDBIakU0K1B6L1lM?=
 =?utf-8?B?MnlJQ0lWeElJWFcwa1hrSm5wNThZTXR5U0F5NTZSUXUxbDVVc05ETm9sakJq?=
 =?utf-8?B?eHNQK0loUlhOdXRUN1RQOWEwRENqdUtTbmJHbWtldmo3K1ZkZjhlTllKbjFk?=
 =?utf-8?B?REMrZEFWTnFpakVJMHJ6WEJnaEhkdEJSQVJJS0VpYWc3WmNlbGk0a2dmeC8r?=
 =?utf-8?B?aHFxUld5WTZWaDVSRHdEN0daNWZKd3J6M0ZHTFFjaDBFTTlHN21BWFcvTlhS?=
 =?utf-8?B?Qmk5bGJMVzh5amxhZngzcmhSZjdtQTBROEwwTUZoQmwxT3pRV1FweDlXQlBZ?=
 =?utf-8?B?QmpXR3JFT0pVQW9GL0Q3NDBqYWMzcTcwT05RbjVmaHNzbVJkZlhmelR4Smpk?=
 =?utf-8?B?S3puRFhwbEZPM1l3RFpyUXhEbnV0bVlWaW5PMFhTSDFIeXRrZmlGaDNJbTRV?=
 =?utf-8?B?SmVFUGRIWXJRWk1XUWN6WnlmK0VEUHpIc21JTDFTaWppaDk4VXc3cnBTcHVy?=
 =?utf-8?B?d003UXdtb3p4Y25TcEVxVlp2aDJZeDZ3VnNlOEg1TXVEYWRENVZNZ2xUNy84?=
 =?utf-8?B?aSthZFFpYmc2SWsxVjkzY0l5cmNLV0hkeGdLL1hSRVpxTFRCS1Jhb2dML2xY?=
 =?utf-8?B?Uzl4ZXhtQUgxSnc4aXo3dTFPajlNWURvQ1g1ZTE0djMvczRWV2xocjJheEJr?=
 =?utf-8?B?OGtrd0pUOU5KUjhXRjJrZUhhTVp1Y1B1dWlleTJEd29OZ0U4Mm5zVTFxamE3?=
 =?utf-8?Q?XO6Z3xkIgm6q9OEz71yZ1mpZh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf398e30-9726-4c13-ab55-08dd7b616ee8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 14:34:16.1618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wiyJNu2QQNOVNJTb5rHojitN16/zdJDf8/ZHV+9cp22KDS86Rgta4O6ogbCvGw/Kt/A5eVkNvxsZHlMKfy5Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922

On 4/14/25 07:02, Vishal Badole wrote:
> To properly disable checksum offloading, the split header mode must also
> be disabled. When split header mode is disabled, the network device stores
> received packets (with size <= 1536 bytes) entirely in buffer1, leaving
> buffer2 empty. However, with the current DMA configuration, only 256 bytes
> from buffer1 are copied from the network device to system memory,
> resulting in the loss of the remaining packet data.
> 
> Address the issue by programming the ARBS field to 256 bytes, which aligns
> with the socket buffer size, and setting the SPH bit in the control
> register to disable split header mode. With this configuration, the
> network device stores the first 256 bytes of the received packet in
> buffer1 and the remaining data in buffer2. The DMA is then able to
> transfer the full packet from the network device to system memory without
> any data loss.
> 
> Cc: stable@vger.kernel.org
> Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")

Arguably, this patch doesn't fix anything as all you've done is defined
some routines that aren't called by anything yet. You can probably
combine this with the actual fix in the next patch and make this a
single patch.

Split-header support wasn't added until commit 174fd2597b0b ("amd-xgbe:
Implement split header receive support") and receive side scaling wasn't
added until commit 5b9dfe299e55 ("amd-xgbe: Provide support for receive
side scaling"), so you'll want to double check your Fixes: tag.

Also, the ARBS field wasn't always present, so you might need to
investigate that this is truly backwards compatible and earlier versions
don't require a different fix.

Thanks,
Tom

> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-common.h |  2 ++
>  drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 18 ++++++++++++++++++
>  drivers/net/ethernet/amd/xgbe/xgbe.h        |  5 +++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
> index bcb221f74875..d92453ee2505 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
> @@ -232,6 +232,8 @@
>  #define DMA_CH_IER_TIE_WIDTH		1
>  #define DMA_CH_IER_TXSE_INDEX		1
>  #define DMA_CH_IER_TXSE_WIDTH		1
> +#define DMA_CH_RCR_ARBS_INDEX		28
> +#define DMA_CH_RCR_ARBS_WIDTH		3
>  #define DMA_CH_RCR_PBL_INDEX		16
>  #define DMA_CH_RCR_PBL_WIDTH		6
>  #define DMA_CH_RCR_RBSZ_INDEX		1
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> index 7a923b6e83df..429c5e1444d8 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
> @@ -292,6 +292,8 @@ static void xgbe_config_rx_buffer_size(struct xgbe_prv_data *pdata)
>  
>  		XGMAC_DMA_IOWRITE_BITS(pdata->channel[i], DMA_CH_RCR, RBSZ,
>  				       pdata->rx_buf_size);
> +		XGMAC_DMA_IOWRITE_BITS(pdata->channel[i], DMA_CH_RCR, ARBS,
> +				       XGBE_ARBS_SIZE);
>  	}
>  }
>  
> @@ -321,6 +323,18 @@ static void xgbe_config_sph_mode(struct xgbe_prv_data *pdata)
>  	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, HDSMS, XGBE_SPH_HDSMS_SIZE);
>  }
>  
> +static void xgbe_disable_sph_mode(struct xgbe_prv_data *pdata)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < pdata->channel_count; i++) {
> +		if (!pdata->channel[i]->rx_ring)
> +			break;
> +
> +		XGMAC_DMA_IOWRITE_BITS(pdata->channel[i], DMA_CH_CR, SPH, 0);
> +	}
> +}
> +
>  static int xgbe_write_rss_reg(struct xgbe_prv_data *pdata, unsigned int type,
>  			      unsigned int index, unsigned int val)
>  {
> @@ -3910,5 +3924,9 @@ void xgbe_init_function_ptrs_dev(struct xgbe_hw_if *hw_if)
>  	hw_if->disable_vxlan = xgbe_disable_vxlan;
>  	hw_if->set_vxlan_id = xgbe_set_vxlan_id;
>  
> +	/* For Split Header*/
> +	hw_if->enable_sph = xgbe_config_sph_mode;
> +	hw_if->disable_sph = xgbe_disable_sph_mode;
> +
>  	DBGPR("<--xgbe_init_function_ptrs\n");
>  }
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
> index db73c8f8b139..1b9c679453fb 100755
> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
> @@ -166,6 +166,7 @@
>  #define XGBE_RX_BUF_ALIGN	64
>  #define XGBE_SKB_ALLOC_SIZE	256
>  #define XGBE_SPH_HDSMS_SIZE	2	/* Keep in sync with SKB_ALLOC_SIZE */
> +#define XGBE_ARBS_SIZE	        3
>  
>  #define XGBE_MAX_DMA_CHANNELS	16
>  #define XGBE_MAX_QUEUES		16
> @@ -902,6 +903,10 @@ struct xgbe_hw_if {
>  	void (*enable_vxlan)(struct xgbe_prv_data *);
>  	void (*disable_vxlan)(struct xgbe_prv_data *);
>  	void (*set_vxlan_id)(struct xgbe_prv_data *);
> +
> +	/* For Split Header */
> +	void (*enable_sph)(struct xgbe_prv_data *pdata);
> +	void (*disable_sph)(struct xgbe_prv_data *pdata);
>  };
>  
>  /* This structure represents implementation specific routines for an

