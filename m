Return-Path: <stable+bounces-128568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B89CEA7E2CE
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 16:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153D616A510
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 14:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E3C1DED46;
	Mon,  7 Apr 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZnpS64hQ"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420A31DE890
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037192; cv=fail; b=c/Jtu/Qve8SXUHcbB/oE2tSilE048ybD84fLjG3nN7aqqupX+WKBD7GK7fvh2W8bLDCVfWC23Jj9dH1kcIwATesz/7BX6UBm0MM0b/smhhZOhbCzLyKFl/yANlI6n9uDrSsbCJMflguSQnDRZ7viI2aw5gJnSA528FCvu/NRPco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037192; c=relaxed/simple;
	bh=WxQh+BasW8NfbOv0eMMFzUV922C0weQ7mgSGOWAL8So=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h6ZWkGXwIzANc3ae6WaIyKObj/qVctZcaci5il9yxvoZDouR9XxLzaKd/oQif9GNCa24Cj1fnn1IUt9QNPXmmzSpuplcdEPSpvBVhi6s+OPjc524uyldKDxIa2YSZjIB7bZiMoLT25+YqbQFgtlF/zJC9MyROYF8XXrdV6K4hqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZnpS64hQ; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2S5LSCfBrC5pCDnZBoJUDFIWW2TivPevEpeSUnL6XFL5hYe+wXQ2xJmswV1lE9CSMbJD1r2Qyq0UmyD8vl+UMEbuRzhguomW19e4SGUc0MTPakoP3Lu4/l2dLaKH0CZckswvMj7YoJONPpEyNBIFEHHOQyOXH8aYo/hadpyI/Erg2WRzIKXCTKWT+wT8xYmbSyTq9QerXhgBjeAfgAr8XYATCwKcgYnHgMTJcaQhZbD1FKibOCuFeZqfxfhm1sxPN4VtWq8Wjo+6cbC/Xfw0J8LFx9yioKvrBEscjTnfWvz0Xa4kUkoAgFKQOJyxRWsEScYev+VOhz3zYOkZl2ZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxQh+BasW8NfbOv0eMMFzUV922C0weQ7mgSGOWAL8So=;
 b=Dzu+3EfDAYSn/FDhVqahX3tUKgSoMZjBMo5vj9H/EHjyN16n0lqF1aST3+eyLx88Fp3M7SaAVhzmuZA7KFDEMdyzb6q0a3MCPlxUqkqdeqQ6lggSMTtp9rbc+u8Y/G2w5UaYhvLg4e2nEXUzH3AME0eNFZOBKdqFvngiVNJvl296q7i7OAdwsB1t+C1EWow7GMVhr0tpMQPcPwcOjiPXZ01/zKH/ivNKTa7YXcBwA/rclpsqEtgpM/bQ+t2aTPNrEPCRiFv/8qaef0qu+9xPPnDmVwp48KOwvXTEoHwdZFLyJjvqGw8ztV7/IkJRP7AkiwlyHJP4nomVhfjB8iPMRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxQh+BasW8NfbOv0eMMFzUV922C0weQ7mgSGOWAL8So=;
 b=ZnpS64hQ8m5OPrb1cJtMjiyZZXeX98+OL/XT97LP+qecubmAQEqzVTspGmLoY4Zm6iZwvnkEE0A/JQd95OQJFlLs3tc9sqWPfkQGJzfbjfL2ZVbVtpjusef+mDrZarZCb4DtMqs/hDSKxtymu9zjzquxOD/Gawr321Cb42kelIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 14:46:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8583.045; Mon, 7 Apr 2025
 14:46:28 +0000
Message-ID: <fee87af7-be0f-4bae-af1d-8c39923ec20b@amd.com>
Date: Mon, 7 Apr 2025 16:46:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/dma_buf: fix page_link check
To: Matthew Auld <matthew.auld@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 intel-xe@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
References: <20250407141823.44504-3-matthew.auld@intel.com>
 <20250407141823.44504-4-matthew.auld@intel.com>
 <a4b1190d-4d4f-4c66-9fb7-2be19d2ea3dc@gmail.com>
 <8ae9b377-5a2d-435f-8e29-ed393b984870@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <8ae9b377-5a2d-435f-8e29-ed393b984870@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a76686-b308-45b7-77b6-08dd75e2fa6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1NxM3dCK0pTZy92RTlsMGZzZ2pPbW05ZkpSc3QwbVJTdUN6a3JNZ0wzUmJV?=
 =?utf-8?B?dElHcmxEZkwwQ3Q4TzVUYWJCUlI0SnpMK2dWOGp1YnNhSVlsaEJlcXhNYTl5?=
 =?utf-8?B?SmxMZWlObEpEdUdkeVYrWVArb29IN1FpWHpMZ2pGNVBPVGhScTdMRTJxYjlr?=
 =?utf-8?B?ZjIzN1h2REpkMHRxSk1LSUJpU1YxMmpUOWh6WFhhaUh4alh3VzhPbkNlUWkx?=
 =?utf-8?B?V3JBZlRxVlJDRjBBdG54ampFenZZWjI1Wk94VlNDNmlMMXVQblVBR1JzcTNB?=
 =?utf-8?B?Vml0am1tU2RSSk9XbHlSN3NjdzIzWGRrblh0OEY1Rk9IdUs2VnYvTCtQTHpV?=
 =?utf-8?B?bjhIbmgvUSt6WnhJUjdGazg1THpPbWVEYXVrNjN4eDM3Nkp3MTNLeUV3dkhr?=
 =?utf-8?B?SGNScnVhVmJZaU5QNG9JSXNTUzFQS2RORHhUV3l1NWg5cG9jS1BqUExQUGpB?=
 =?utf-8?B?VEgxN0szdHQrdFAxY05YV2FyMFFPWFcwbkt2YjVlTExzMk8vQWU2dVNUbWVD?=
 =?utf-8?B?ZlFvRVJzbDhZcDYwQXJQU1NFZXdrRFY4a1pFbWVmdU9oZVRheVk1aC9DQW52?=
 =?utf-8?B?RW5yVTgvSnBSekh1Uk5oRmhzZTdzYXp2bUJ1cU5ZWENHczlHUmNqRUFzeXRM?=
 =?utf-8?B?Q0xjSG5McUI1bVVYZmR2cjl4Zkp0bHAzMVBJZzBCaGJoSm13S2U3R2xhWUVi?=
 =?utf-8?B?azc5eEMvbDRoVDY5cFI5cjl6UXNyRXQ4RU1VRGQxUDNzQnpKYmhMNnZCbjFY?=
 =?utf-8?B?VWphU2NLLzJZbGhPR2NtcDNRdU9Ec0lRTEpyc3BKZmorR0pEcWhUM2owZTY3?=
 =?utf-8?B?Z2xlK2FxSDBJRjBTVkYrZ0U1MzFYVk1acnN2QklvTHRXK3RrWmtXZGxtb1lJ?=
 =?utf-8?B?VVc3dENLSjZReHY1MWdpRjZzYkNuVDd5SGtEREdCYTB0KzVselNRZ2dVMUow?=
 =?utf-8?B?OFkxdnowZlR5M3I3bFl0alZONUkraVNxU1ZtNkpNM3Z4Q3pqbmpTQ3ZsbXRq?=
 =?utf-8?B?M1FKTTNuV3hJU05RRFJORE13NmtnK01ydW1UUFdYcVVXUGxxaHZvTWhCR2hu?=
 =?utf-8?B?RFY4NG1oaUJuZVQvbFdEVVNZVnZ4MXdhUFlxRXVQVHMwd0o1WWkyUS90T3o4?=
 =?utf-8?B?S0ozYkdSdUh0TE5zb2xmSnVvdGZMalF2YlhlNmVXc28zSEVqZWFtUWFodlV3?=
 =?utf-8?B?VHg1cXZCMkFWOTZzNFlVcTB2YXhRclBjeWR2Q1RyaGZZN3FGOFVRRmxvVFc1?=
 =?utf-8?B?cytLN05JOThBSmY0YWxjMkFOOFU0UzJpT2tHbXh1Qlgyd0VWV2lSVUxaK3pT?=
 =?utf-8?B?T1RVZ2tBK0s5MlhXZTh5VXBiWTl1d1pKR2FuN01oak9iV3BuK2lTRm9FRGoz?=
 =?utf-8?B?L25neTN6RTAzSFpsNGZQSHlmaEorNXVPWTMrbHhFUEorZm8xSnA0UW12d2dP?=
 =?utf-8?B?NUhqK0pTaENaWjNDZ1doSHdvZHloZDg5T3RkdXVScjdZL0N6cW5nN2ZtbWZQ?=
 =?utf-8?B?QTF4aEJQb3lXcldCbVVKekJaNmNnd0ZscGl0T002Z0haK3FGOHB1bllqNWha?=
 =?utf-8?B?VW9CK2hIa2lxVWs1Uk9EcFNCVkxSdFZQRk5uUTdkc25vSWdDUFNkZmZGTjZ2?=
 =?utf-8?B?Nmk5VUxQazNpaVdOKytqbEU4NjJqbFpIK1BJUkNpMWw1eUZWaEJCZG82V3V1?=
 =?utf-8?B?b3dHNkpqMnFTUksrbFVObjRhb3FqTENKZ2dRc0RCdGpRbzhyQUJJNlhqSmpp?=
 =?utf-8?B?VTNpYWFETkFMbENwQzYxQmdmY0M4WTQ0RHZLNUpOSGZqcm9MQ2JadEplaVRY?=
 =?utf-8?B?KzM5UWsrT3lIZzM4M3pFUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blF3U3RPOGRoeC9PUWpFRnRPYWRmbjBIOHNxT2svVVVXRktJN1NoWnZqZVVD?=
 =?utf-8?B?SS9MRnIzSGkycllWS05WcVBBSlViYUxQMmtnMkNTUUh5RzhFdDdsV2VRbTB1?=
 =?utf-8?B?d0wwbm1HY2gvL1N2RVB6blMveTN6R25tWklrMXZUT3MwVTRjV1lVUENrWjd2?=
 =?utf-8?B?ZmpONEQ2ZTRWUkgrWW83cHUzT25CaXlReUhUcWkvZkUxR1pBUTkyd0g3ZDAy?=
 =?utf-8?B?SzFIWDJ6QzR0OTJ0cTRySWFScFhDQzNlTk00VEtybVIyUnhNYlpOU2t5THNE?=
 =?utf-8?B?Q1BnQ2FoQitXVk5YMzVuQk03TUlxQWpaNFYzajFDWXd6cmtxbnVURUlpcm9r?=
 =?utf-8?B?cU16Z3IzeDE4eDJXMllMVHplN3MwOTFId05FSWJ3WGZuN0V0bEVsTm9pRnF6?=
 =?utf-8?B?RzhYK3hucXBTL3FYOUxkVHVsRENqVmxwWVB2L3NMSGYva01aR1VmSDhNaXNQ?=
 =?utf-8?B?cmRHdTdGUjdGbE9Rb0g3cWNiMWQxNDU0OG14M00ydElId2g5S3NtVjV0VHdQ?=
 =?utf-8?B?TUNqWDQvRm5nWXp2NHhuMy9KaFMvenYvQ2FtN2p4VUVqUVIrOHQ2ZTd5aGhG?=
 =?utf-8?B?Mm81cXJWOEVBdk5zNEpnSzVZWWx1QlRLUUVaelFJbVU4eWRvZjgwYTlHc0dK?=
 =?utf-8?B?OFBHQkJBNFBSUnFyamt0alVTRmpSejhST0tZek9GblB1V0UzalJSRUZVN04v?=
 =?utf-8?B?WEtFTnpqZjIzeWkyQkgzdU9QUGE4OGYxblVZME4wVmZXeXZvMEg4ODl4dGRz?=
 =?utf-8?B?TEo1dWs5eU1WV25CNXB5YlFDMXRVRURVUHBxQ1NnS3lxaVVsNnVTSmsvZFpO?=
 =?utf-8?B?eG01SFBJOFozY3pTemZpT0tML2RFSytmdHY1NU1tdzA3UVNhVWttMzZ0ZHVI?=
 =?utf-8?B?Wk9ldXdFancyN3AwYk9oU05pdDZvYTZtNnhHSzdlZklSMUVzQ1RkUi9SNW8y?=
 =?utf-8?B?RUlJdVQzMzZDY2xGVTVQZ0Z2UUxWenNFdmlWZklRMHRwdXVUVmNjcEdVbnVp?=
 =?utf-8?B?RytBTVhTZVhvQTl4TVN6TWtOWG4rWXo4MTBFSkd4bHBONU9nWG44RGFhM2hL?=
 =?utf-8?B?SmxkayszenJ6bm96eWM3MGMvYkRQMnlLcHo0bmljbWtqajB6VThMT3QrbXc2?=
 =?utf-8?B?MmNuL2tETUNoaXFBMVI3R3dXbllJWDNuSlE1NzIwQSt4UElXaERiUE0ydVBk?=
 =?utf-8?B?NlNvcFlZSjI2cUovajJOTU0rMy92MWEwdjduL2VjcVRDYUlMOUo0bjFrb1hT?=
 =?utf-8?B?Vi8zWHBrUUtpd01ReWZpU0w2cnBTTllwMnZwRGlzMldmQU0xUnJKOFl0aGpN?=
 =?utf-8?B?c2IvMlVRSXQwN2taeVhvSUZUZk9GYU00aTJYSjlMcDZGOHF5WGV3bDJqb0dG?=
 =?utf-8?B?SHJTTEFCdVdJOTZzTHZPWVhuK0FOOURveFErTHdZd2M5SWpLRWxvMWJ2WHVv?=
 =?utf-8?B?TCtGRCtUKytKYmt2eTFxcjZXRmJjWGtTMjNvaFBVYmxjb2I5elEwSVhKZ1h0?=
 =?utf-8?B?aUZweXJzSXBSQU5PSWNPdlNTb2hoZlpOUER3Q1MxVlBiYlRpV3NXRzFqS0Jw?=
 =?utf-8?B?Z0JDZU15M2ZnUFE4bGd4QmhoTnFuTWx6Q0RHaVNrSjNMMEhYWk00RjNsVzRp?=
 =?utf-8?B?OUMwSkJCNGZudnk4clZCK0JtQWhONWJ5SG9aUHJCVll2alhhaFluNG1tWjhV?=
 =?utf-8?B?OTBrTWQ2Ri9sVWJOcEJCNnVvbFNaUVdSTmFjRElYV1lGeWN0RStsKytSQ2ND?=
 =?utf-8?B?QUtHNmowdmwvdVNYdWNkS0dDVFdnNWpHYzZJTjhtUSthNEFGTXRlMjZOV3FI?=
 =?utf-8?B?a0JmNCs3alZ1NWEwV3ptTHMyaXQ1ZFZNVk5nL1NWU3NKWjVMeDlaUTlZeUFn?=
 =?utf-8?B?STBBRmUxd0RoZmJKSDdpamVKME02Um1tTW9IM3ZJZUFrK1lsUHRXdW0wb0ty?=
 =?utf-8?B?ZVlIZ2ZyMXVxSTZSNXQzK3RIdWVZM0d1ek8zeEhlWXZqSm11NXN5YXZwUGg3?=
 =?utf-8?B?RDJuTStzYm5Sa0lRYU1OaDh1UmhxZlNFTEFIaCtQUkJob01pdjZXZmJEQXQ2?=
 =?utf-8?B?c3hlMW1UQktIMkE3ek8xUTk5U2Q1cUhOMm1NUG9RVVk5YlhzRThXa09nZzZJ?=
 =?utf-8?Q?zVZA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a76686-b308-45b7-77b6-08dd75e2fa6b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 14:46:28.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuGsELzg+B8E482Tfx5JPzY+8tc4iIsZrfVNviiERkVHk3vNq7elNDpIXCQ1iB67
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951

Am 07.04.25 um 16:44 schrieb Matthew Auld:
> On 07/04/2025 15:32, Christian König wrote:
>> Am 07.04.25 um 16:18 schrieb Matthew Auld:
>>> The page_link lower bits of the first sg could contain something like
>>> SG_END, if we are mapping a single VRAM page or contiguous blob which
>>> fits into one sg entry. Rather pull out the struct page, and use that in
>>> our check to know if we mapped struct pages vs VRAM.
>>>
>>> Fixes: f44ffd677fb3 ("drm/amdgpu: add support for exporting VRAM using DMA-buf v3")
>>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org
>>> Cc: <stable@vger.kernel.org> # v5.8+
>>
>> Good point, haven't thought about that at all since we only abuse the sg table as DMA addr container.
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> Were is patch #1 from this series?
>
> That one is xe specific:
> https://lore.kernel.org/intel-xe/20250407141823.44504-3-matthew.auld@intel.com/T/#m4ef16e478cfc8853d4518448dd345a66d5a7f6d9
>
> I copied your approach with using page_link here, but with added sg_page().

Feel free to add my Acked-by to that one as well.

I just wanted to double check if we need to push the patches upstream together, but that looks like we can take each through individual branches.

Thanks,
Christian.

>
>>
>> Thanks,
>> Christian.
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> index 9f627caedc3f..c9842a0e2a1c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> @@ -184,7 +184,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
>>>                    struct sg_table *sgt,
>>>                    enum dma_data_direction dir)
>>>   {
>>> -    if (sgt->sgl->page_link) {
>>> +    if (sg_page(sgt->sgl)) {
>>>           dma_unmap_sgtable(attach->dev, sgt, dir, 0);
>>>           sg_free_table(sgt);
>>>           kfree(sgt);
>>
>


