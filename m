Return-Path: <stable+bounces-125938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D327A6DF0C
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 928237A38F0
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C7725F979;
	Mon, 24 Mar 2025 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FZrWm8p4"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14071F4295
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831579; cv=fail; b=On+B/+tU4YOLxZQFim3jiCr0u6Ya3ZcWnIRGvQFVYKW6nJHSz4QuDsf/aM01km0fTsQfTQjyjBZqf2P5zjfpHWbzZyqFdCNSimQod860T1NysCxUKE1sjqNRjbmYmxejPWQIgdIJ7zO9ME2A4NdpKjJZVi5Vp74IJTkNih+k/ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831579; c=relaxed/simple;
	bh=676KZ8Pk94mG21lwOIQm8RvuQSjwJuyjnSMt4kBAB+0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FF4qPgONf3ax4rYGBz8SkMNVs4j6fb8yMEn1PYa2xb4OOQE+bSmljIIxGMjDMefh+QfpzfezcyGidWJj9/27yhOB2+j3xmuzGnClLvLNZ4BtTVJ3T+7pPsVS2AoVf0rhyJwzCXBekTriBGYehlaRKjDZkhuCxwJw4XcdJ5+pCuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FZrWm8p4; arc=fail smtp.client-ip=40.107.101.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmHWm1D3Jb1fgvxAJwLWKlaOKpexKfSglSu/hR/TYlujIzcbXsvlhbo4+smRGYLkLOlTRkKkTwsDYZ+RDfcZRc6cHu4FmHfyrkVOGqgV82ypKTH4JBR2wpV1Sdb9zDgGCNG+4imMh+nqCnQ3+XlxJMtkTJ0s8lBog99qaZaID3Sb9L3yOjnWucIFLzJ8ixnwKatE8Q/BW6xB7MvOeSJgu/s7+zKoactT+g56+KlLbEwzfynNIzzpUmPW7+LkT/llaO4PPm7DFEtyvPVJYsBzr4OiYGGEO5x8w38iIPGhuZ4u9CDDKqvbJAaJXx7K91BQ20pLkLvz1VI04DY2N6nd5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iASbnQrFBbCjMCJaOtAOV9+ZWmhuHIdTYb1X4zenmDw=;
 b=nCmuXCoi4ZG4IkmUtxHYAOpb1o87Kkn8Zw5PCH1y7oJKMGivrEEJQCUvR1uFjqbmpNB+PwnTVa6XTRKWUDqLIlE+xstGs1X6Njftn40Vfy55ieB/M2NJns/TJA9jHedQQEP7nm3+6HBZm9QQrqQZKRI6f6zyHXjdQhTZvb5ccFaAzEQNNeNzB0F8dFd1RADqyOYML1f41xf+5+DLz7TPe8KhZyQjZYtRM8O55It5kNmWYpAsWO8CfZgeaErr9ejCCADsZ0BYRLvEgXoyvAOUCNas2qy71VNxyTHqAbUYbhnsZbg+KtfI9Rc5Ba2yNNntx2oce+DWAfIhY5+Gz8H/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iASbnQrFBbCjMCJaOtAOV9+ZWmhuHIdTYb1X4zenmDw=;
 b=FZrWm8p4d3Pl2F++Gx9xpVzeNN2hQNOzaWhi49wbSBaP8yY1SSltCV8T5vFhND4EnXOtEew4fnWDDqCrA5GSONre4wrti9zOfD+HbUmShGGQ9dnrwuJE8hSCTZiDeiKSflTahOrSeJ4jD8y44ld68PhOx8GZv6Owxe5DqaMy3tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 15:52:54 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 15:52:53 +0000
Message-ID: <69bf7189-358b-40ca-9b4d-60b61e1b89d7@amd.com>
Date: Mon, 24 Mar 2025 10:52:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] drm/amd/display: Use HW lock mgr for PSR1
 when only one eDP" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, alex.hung@amd.com, alexander.deucher@amd.com,
 chiahsuan.chung@amd.com, daniel.wheeler@amd.com
Cc: stable@vger.kernel.org
References: <2025032441-constrain-eastbound-09d8@gregkh>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2025032441-constrain-eastbound-09d8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0049.namprd11.prod.outlook.com
 (2603:10b6:806:d0::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: be898223-8862-47a3-93d3-08dd6aebf02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGhscHp5OTdtbVNHRkNhaWt0akVxLzJYOTJsT1R1Tlk0WTRWSXo2VU93UmFo?=
 =?utf-8?B?MENLRkV1emQ2SmZYSDBoakdPZE5MVlB6REpUYjB1Qzh1Uys3QUhoSndKQjhx?=
 =?utf-8?B?VkRWWk9KaVRRb0xOS3plMzgyY1hSYmFCZnJaRnRCS1ZjQnduSmVkTzg4MUVL?=
 =?utf-8?B?MEpxeCt4Q0FpSzJSTUhXSEUyRGt6YTRnSEF1SVFnc3pnSktobU1KRDRTbzVI?=
 =?utf-8?B?ZjY5T3J4SWpsUnpjRExpcXVLYzFrTjI1WTBVdDExOTJlWFVxU2liOXpNMXNa?=
 =?utf-8?B?ekZFZk5TTGxDcmFlZmM3ckp2OFlkbVZ6Sm5kdlgvOFlxOGNST2M4ZnBpSkhI?=
 =?utf-8?B?MlF1SDkwOVQzKzJpdFZVWWJwZ243bXZXL21DYnJKNzR2QTBLdFVQbmxVL1pI?=
 =?utf-8?B?bzltcndLOGU1RkVVVW9teDkvaXYwR2xReENSRlJ1dFpaeEtPNTdQRWU3aE16?=
 =?utf-8?B?ejNpbVJJakFGOTN4SG9rWG9hRkpmbVdZYTJvcC8vTHNpVGVzRStuMXBOWDdy?=
 =?utf-8?B?VC92b0RBdy9MbU5UckJXU3hGWFlkQVZGWU5uNlhpc0RBNW1ZUS8zcE1RSzEr?=
 =?utf-8?B?VFE2dUJUVnpPR3RGUExMd3pTRVZveGhrblVsem1aa2JPSjhxanlYL3pSc1hV?=
 =?utf-8?B?ODNrWTlmYUsrMDFadDV6R3VOSUswYjBMaTI4OG5peUNoM3o2YkNWeUpYR2VN?=
 =?utf-8?B?anUrN1ZrZkM5aU1QM0kxWThiQlBiaWtqSHNNZmNxeFYwdW5DdzdORjB0elhw?=
 =?utf-8?B?U0R6T2tnMStoZnpzcExTV1FXR0N3RDg3MFcyQThtekw5eTNybUNyRm1NaFRx?=
 =?utf-8?B?UFh1amwrajNqeHFOY2t2ZThOZnhzMllMeFdCM21VaHhESmJ5VjBGbHdjNkVC?=
 =?utf-8?B?aEpvSGlBMkpmM2w3ai9zV050SHNlbWZ4eUM2S3pYOC9ER3RQZVFhWVRwZkRR?=
 =?utf-8?B?UGtPWnUzSHdaeHY1WktJK3R1NWtIdXNkdXFNWVdtUUJFaklrdlZWRkVRZmR1?=
 =?utf-8?B?RUVXd1dPbGNRSlZzY2gyUEtmVlN2MEg1aXlnVkd5Wm51TFFibkc1T3Fmek1W?=
 =?utf-8?B?TGNMVGRMMFZuSVpWK1BBR1BtTmI2WE5tQzAzR1BHTWY0bTY5U0k2aTd4RzZ4?=
 =?utf-8?B?aUVXSDZoYWFaZmpQRXF1T2NGdFVPZVZEQXdqM2RxcWNoaXEyblJVaWVrdjJ6?=
 =?utf-8?B?azRTcTJtSDFMLy9GVzNXVkNwcTJoR2ZlcWxmdThpeEs4NlQzZmZvdU1rN3NI?=
 =?utf-8?B?ODRJNVhIWllIdlpyM2RpTkRaRjAvUWNjc1I2dzBOcUd1dkhKVVN3bTg2V2Ux?=
 =?utf-8?B?a2t0RkV6OEQxSGFOOG1UU3ZvUkQ0LzJBMDQ4c1BhWTlrNGF2S2kvYWFldmNC?=
 =?utf-8?B?dDJUaGtVS0NVYStOM282dFZBMG40VEVndkdVOU9nRWxuUXU3U3B4bHpKNS9H?=
 =?utf-8?B?b3lPdU0yeU5zZW80dmFINjZ4TEFQYmMvK1NhcW1pS1hZd0h4UXc4d0U2U3l4?=
 =?utf-8?B?cSswUSsrZkFiT1lNSjE1a0JVOFQ3aVg4ZkJ3NXpCaUp0cFowZEhyKzZMT0tN?=
 =?utf-8?B?cmNPRnNnck1ibHZuYnpoa1ZoclAvT0JPYXBPSFBqYUVoblg1K1R5L1dlRGwz?=
 =?utf-8?B?bVpUV3dNNm9sUE1WdE9HQ3kzTjVJazZSOXcrelEwQkdmRjhzRFoxTERPMVpN?=
 =?utf-8?B?QzJ2V3JXWFZZY3BJazNvTFFqRnFLMFF4WXErZmVTTlRjazdieDRqVHhXZVlP?=
 =?utf-8?B?Z3VabUp4Y1VlRUxPclk2Z0tOWktsSkx6WlIwbGpGSlpIdks0d3JQZFFqVmZC?=
 =?utf-8?B?b2xSTFJKR1FnR1RrWVZjUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDM3WVhkNXdXbFMxc2NBdlJ5dDE2aFZ5MTdQWE9Ldk83emQxWDNYTlFsM0Vq?=
 =?utf-8?B?T0IzSGFtbHhwTDhWbzdNMm91T1l5cStacHJyMHZsN0NJdmNLQi9sUm8yVVpn?=
 =?utf-8?B?b3loN1g5c0dxOGlzR2ZkNnpSQ01hOEFkOGVGemQ1cU5ueWcxTGhwcVFwc0k4?=
 =?utf-8?B?cGFDU0l2THBtR29JcVBRQmtsOXR3T1N2emJHZ290ZzlIQVNZclMrUTNrNEw4?=
 =?utf-8?B?QmNXRTErRlZOVjFDWDVNU3lDVWhQdHl5TXg4WisrQ2Rsem5pLzlTSjdJTFNX?=
 =?utf-8?B?MVF5OSthZUd3Wm1lSHpYYjBva0VVUGErbnRFUEdBalcvQzgwenVpU245TGhH?=
 =?utf-8?B?VkY1YVgwUWdBakhlaUdxOE1KWE9XRzk1clJYVkZjMzhOdTlnR1FMV1RZSHRC?=
 =?utf-8?B?UEIrV1p3bEZIVWV0VkVEQklGNUh2ckY0WHFUaGZzZlFFZjhVNm9OQ005MWxL?=
 =?utf-8?B?UTlrbG1qeUlZY1dEZGdMTnU4SzZOUFJJMGRhNEhKeHBLUk1NUGtVa0lWbzZv?=
 =?utf-8?B?RWhiMDRpQTZzUWY4eGFSN2lVcTBnMjZOZGM2eFgyT1ZSUDAzVHRwYVA0L1Zx?=
 =?utf-8?B?UmprQzVQTVZSN3Yzb1EwMjdPVkl4OE44WkJPZVlMalIyVnBSVzIyV1lRTmZK?=
 =?utf-8?B?Vm1NbDFnS3o3MHlLOEtGakM5RjhIL0pFNFB6cDJ1bXZYS1NUVlI4WnJESlhB?=
 =?utf-8?B?VHhCaFArdGNCTE5NR0p5UEJLOGNyNmpMUjlocWZFQ2ZOdkpqVXdTWUpNcWtw?=
 =?utf-8?B?RlNOQTJscXY4QlZqQVRHQ2gxOS8rOHg3QU0ySm1JZytJYlFPRHd5MnZPeEFF?=
 =?utf-8?B?eXNLdXZlY0VWU3hmUHBtcGMzKzAxYVhRTFdUVkNtNEVPUFpnMXY4QVV4VElE?=
 =?utf-8?B?Q3hNcFpyTTZXS28yTEFnM0Q0MHZNRkdFTDk3UGhUdzhjenRIYWlYeExkMjNx?=
 =?utf-8?B?OVpoUzdDcFdCRjliZmt3aDVwcVpzYS95VElWRGlNYTc3TVl4Nmp0UHFiaDBl?=
 =?utf-8?B?ZFF0K3k3NnFIb1N1SU92OVRKZzVwZ2c1TGIrdm1pMEREN0xhbFNIZTZSbEZl?=
 =?utf-8?B?ajFkZmFldjFsREZoMExFUDJpTVh4MG1GblJwckFwOUp5UlR2SlJDRzh4a2ht?=
 =?utf-8?B?dkZIcE44OUpBNGUzY1k4V0U0TFhqTVo4QjNFRzdPRDhoV0RFajNPSFhDVHJJ?=
 =?utf-8?B?b1hrTnUydVpxaWh4UitCYTQ0QzNKNHA0T0dJLzNYTkNHQ1pFOG9PMXQ5YUo5?=
 =?utf-8?B?b29KRnB2RUora2pGWGhnckNjNGZ4UmxDVlpSemZpUVhiRjZmK2FKWlQ3YXBh?=
 =?utf-8?B?cDRXMHBEL0RKUFAyaU9MdlRwWUlFdnlUYnp3ZGhGZnpmVjFmYlMzUUVNTHd3?=
 =?utf-8?B?ZHNiOTdCRFlyL2dYQ0xVOHdWOHZTMWpNTm04Y05BVU1FTnFCd0hySER5VW04?=
 =?utf-8?B?dnZpdDRFNTZ1dVczOTMxbGpxck1wZXNwSk5EaUxFbjloaXRETjZrOFdqaEJL?=
 =?utf-8?B?c0Y5RzFZUjRaRW00cTlSWldsRTNJZ09UbUJXNThIOHMwZDR1MGNIR1NCM0hn?=
 =?utf-8?B?MTFpb0tyYWwyNktSM0dZeDRGNEhnWkU5MjBjLzllYnpSMGorQWZTcDJNbGtL?=
 =?utf-8?B?QnFsL2lHOTBLRGZTM09zM1BXTTUwQ1VnRVppS01UZDh4YytzVUp4eWNEMGtJ?=
 =?utf-8?B?RTdYd2FaL083blZaVWtTRFhkeTRpeWJza2dFYW8vZnN5ejRBdllYbGF5VEY5?=
 =?utf-8?B?TGRhNEhoN1ZwS3ZvNy9sbE9yMUFZVEhrN3JLSkxubSt3OXRmcVhzcEs3OU5T?=
 =?utf-8?B?bW5pUU5jd2M4ZjdMQnZLVjI2Slh5cHFYbGFqSTVueVFNcEtxakd1d0NVdEls?=
 =?utf-8?B?UHJENzFRY1o1N0FLbzBWb0NvaUZxbG1PS1ZVS0E2b3ZIamNRa3FkTVpLOWtt?=
 =?utf-8?B?YXpzOThRbktsa3JwRi90K0J6OUZ4MjV3TytUUHRNTDBseXA0VVk1N1hrOXVL?=
 =?utf-8?B?a25xWTZ4eEljMXV0dUVQMEJoUi9iK0FkYkVXdEJoZ2ZTS1NlcW1TdStSQXRa?=
 =?utf-8?B?aDNQL2ZIa2JoSklMb09Fd3MxQVpHck5Ba1ZQeU5JL1pEMXYyMzVOaHNCVVBL?=
 =?utf-8?Q?cmIp8g3dg820JcR50rvm8WY+G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be898223-8862-47a3-93d3-08dd6aebf02d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 15:52:53.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kahKSHlFCcr6IOco8WqZxkF5sZRVmstMLauNb97EaaFEn8VtR75jqp8+MvIZEPxd85u8H45SFSTtBQMWSuJwOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307

On 3/24/2025 10:37, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x acbf16a6ae775b4db86f537448cc466288aa307e
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032441-constrain-eastbound-09d8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 

Hi,

Here is them missing dependency commit.  Cherry-picking this first will 
let the fix apply cleanly on 6.6.y:

commit bfeefe6ea5f1 ("drm/amd/display: should support dmub hw lock on 
Replay")

Thanks,

> ------------------ original commit in Linus's tree ------------------
> 
>  From acbf16a6ae775b4db86f537448cc466288aa307e Mon Sep 17 00:00:00 2001
> From: Mario Limonciello <mario.limonciello@amd.com>
> Date: Fri, 7 Mar 2025 15:55:20 -0600
> Subject: [PATCH] drm/amd/display: Use HW lock mgr for PSR1 when only one eDP
> 
> [WHY]
> DMUB locking is important to make sure that registers aren't accessed
> while in PSR.  Previously it was enabled but caused a deadlock in
> situations with multiple eDP panels.
> 
> [HOW]
> Detect if multiple eDP panels are in use to decide whether to use
> lock. Refactor the function so that the first check is for PSR-SU
> and then replay is in use to prevent having to look up number
> of eDP panels for those configurations.
> 
> Fixes: f245b400a223 ("Revert "drm/amd/display: Use HW lock mgr for PSR1"")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3965
> Reviewed-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit ed569e1279a3045d6b974226c814e071fa0193a6)
> Cc: stable@vger.kernel.org
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
> index bf636b28e3e1..6e2fce329d73 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
> @@ -69,5 +69,16 @@ bool should_use_dmub_lock(struct dc_link *link)
>   	if (link->replay_settings.replay_feature_enabled)
>   		return true;
>   
> +	/* only use HW lock for PSR1 on single eDP */
> +	if (link->psr_settings.psr_version == DC_PSR_VERSION_1) {
> +		struct dc_link *edp_links[MAX_NUM_EDP];
> +		int edp_num;
> +
> +		dc_get_edp_links(link->dc, edp_links, &edp_num);
> +
> +		if (edp_num == 1)
> +			return true;
> +	}
> +
>   	return false;
>   }
> 


