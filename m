Return-Path: <stable+bounces-76760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EB597CAB2
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 16:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5ACFB23D3C
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 14:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A841A00C9;
	Thu, 19 Sep 2024 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p4STXcoQ"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E8119F498
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754685; cv=fail; b=b06mN4lu8bnIYc4jMuJQ7XhBoooGVpS0GJZ24a+qmgFqiXXlyFFJdjsk8Teav2dnC+Xh52Cn+myFg9vFhx7ks+3WyIeyAYsFRBlmRaQLUJb+4vjf6wC0K21Y/Vy3Upb1sKz04vtr1AxTVBILdQJzop3LX4raFKUDbVAC7r8wg6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754685; c=relaxed/simple;
	bh=1MdlXjYpdYaU3qylB69C8MAnW0ZXpibPk5v1L67lhTE=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=qnr0PVoAyAOxi+lPsPvbO/d4LJlsJUwVehYpr2AG5/Lhy+xBlP/xsAYEg5FOP/OcNN8zMyH69S1TVvGLXu9CfxbRMXFOO2ZZqF1f0LXpGB2PctE/eZz3AgewckFggUqAewnxUg33LGoogr7RzKgmXVqTGS9IQyXZCYzzfsOEIys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p4STXcoQ; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WW2gSClvx33/QiaXgGEKuzJmJo1Q2sAlUO5XNqZUpYyOrA2m+27OGSDYdsSsFHxVqIwffkrtlqsIUIWUAxOVg/Tbd6Jlbo3O4cISI/su+N0TwFUWV4l9TCPdGuE2I9l8QubdEk//eM9+f4Gz52ONUBZQdstkKzodcjOvY+1uMjhRKvDvA7ohcgdcqtRnxNSLaOZT3QApiikO20fuU4Fn77BcscFGli3bq5JdquOcyKQdQcMF9OwXDRliDHXgVDBmiZ8wgRwYkTjmMVP10KT33v2KhA1drOLTelfBI/T50aw+cxl1yKNvVA1bD4v1sRrUsh+06jdigUz1DtdC6CVTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+9pTr81fuHmyfT8HrBr6w/rtFQA/eFHkr55K51vAuc=;
 b=LrFHYoLh1Qg7zDvBayXGZw9QyIUbN+20ukHZEMsEoy+FxkZzUmHt0gPXvCWnYsrvkQzc9VmNMlEBiAdglutgj8xGH/HWz9q3vqe2g9ew+JY+DGjpXUs/tmIFwcTtCnvcgwB1CLGev99RvvbZ7ffQYZG8OGEcau16tVtCb/6Ql64vNWmnHNRGHmWpIacfN024+TzV2Zy4/doohh9BHHDEiUmRHKS+fhQZd50IClJE6vWzwdjD7Q9cAmGGrfc91136kl05n0M+qu0mmdeHCgZAz+Aqo0bjucBocnSzfRvWbAYA/4sCLjjIAZR7eTzR2DA5Vt8AqGXYufWc34FUgXJwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+9pTr81fuHmyfT8HrBr6w/rtFQA/eFHkr55K51vAuc=;
 b=p4STXcoQ/AxQcGs9lCtvTFXqI4UHBw6msVR+Kxtgy4Oka52j5e2lFyi71cyUYK6/DIyUU89etCWHSVSpdYakPa6yfZPlT41Q2X/3b+la+8T3j0ZVDJ8mPwbSr/oHaMlqwqJ1K+/KdzR5QQds9+UK0LPNQJtRs4VJ/Sgb7SvqybQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.28; Thu, 19 Sep
 2024 14:04:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 14:04:41 +0000
Message-ID: <286c7953-2bdd-4d8a-918d-e31de8120d7a@amd.com>
Date: Thu, 19 Sep 2024 09:04:39 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Fixes for DRM node limits
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:806:24::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2ac4f4-dc04-458b-a973-08dcd8b401d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmJPRmVEYms0OHg2YXF0Uk82YzZ2YkpiMGIycFZmT1dVelI0c0FaK0FVVWlJ?=
 =?utf-8?B?d0lkL2dNTVg1Y00yMUxZVXNPRlcxaHpxMytnTkllZS9UckFZMEhSM3ZIakh0?=
 =?utf-8?B?cEFRK28ycXRrbS9RV21Wc1VMRENDVkNCbEltMDhCaTNMcnJNOEMwRUlFQmRG?=
 =?utf-8?B?cWplZ1BiYzhLTGRQZzdzdW5CZmRhTmZvcTRiOTZHU0tQRDVSd3NiUkd6NDBv?=
 =?utf-8?B?cFArWUJSQnZXdkFLS3dycFc0aEN4ZTM0aVFXWk9zNG5ETUhKNkR4Q1luVHZB?=
 =?utf-8?B?UmJ2Zkh0dUdpQVo0MEpJZWEyWjVLaTRwWTlwK1VVWkFUeTMyTWFHMTZaRUFj?=
 =?utf-8?B?czhtczlyZTNVUFpySEQrTGo4MWlKa0ptSTM4Nm5oSmx0RjBEL3lMWWtFVGti?=
 =?utf-8?B?NjZZMW00WFFhdVdPUzlhSGpyNVVwU29ybzlDOUVvUnVsVVRFUExTTGJyaUF4?=
 =?utf-8?B?OHJmeDdnYy9TMWNKV2FkdEs4bGJpc3lDd0NYa0xjcjd0MlhCeFNWZENhOU4w?=
 =?utf-8?B?T0JmTEZXMkwzeXlZYWttL3pFWmN2SVp0dENMWldjOVJJNXF6V3lTeHM5ZTVi?=
 =?utf-8?B?VWg1VWNUcWJtZjZ0enMzSTE1U3ZWdzVJWWFUejdIaTBsb21raUd0azdwN3lv?=
 =?utf-8?B?RlV2dWcxbTFaUVNHckdXbkJMZ1FTalllSHdzZzArc1hUUXFuQXQ2MWRDN3BQ?=
 =?utf-8?B?QnNkMmJqTVhuMFdVc3NkUUlYaGEyem5RWFNCaXlyNmFTZW1ZUVBMcGM0Qkpr?=
 =?utf-8?B?anpaMDcyTnhKckVLSlhlMGoyeHltaWhvRjI3OVBhbldpN2tpemdzVDMzWkxo?=
 =?utf-8?B?cnNYTW5CTFlWL3dSV1MvanZEZ0tLbTdyN245b1QrYmZmTHhRU1NtbGZuenJi?=
 =?utf-8?B?b3BVWVV1aVV1L2dHZEdlclQreVJiV0hJM3VmN0NZUXhkZGZLY29mTUFZYzdw?=
 =?utf-8?B?K0I3Y3pBRERaWHJHRXhNWmJXK3BEcDEwQUEwZEVpZzdNRjhkOC9pVlNyMVND?=
 =?utf-8?B?TkU1M2p5RUdtRjBHcTNSaWZ6NlRxSi93T1ZqZjFmVmR2RHljTU5haS9CSkpw?=
 =?utf-8?B?SWVmdlhwYURFUE53SXZvbE44RGZXbUVreVRYTmw2S1dxMVVZWWI0QkR4QWRo?=
 =?utf-8?B?M0tjdEhXOU1hY3JpTGNMNWxzekhPczZOZ09Fb3lkdzFwOW52Wm9IS1NZcnRU?=
 =?utf-8?B?T0IySXR2MzFwVWxXRER6VG85N2FNcEhNQy9SaWFmY1FZNy9DSnJFbjNMNS9k?=
 =?utf-8?B?NkFUeHB0eFVDZXZHKzlXL1YyVTVlS2Z0SHJMZE13ZjBYWTF5bzRuSU9TY01z?=
 =?utf-8?B?ZXZoWnJycGZ0OEgyeFdTQ3EvaHErcnRWOUQ0cTZKS09mZTdXdTBrY0kxK1Nx?=
 =?utf-8?B?VXNDektjZUZIWjNXOFZvcG4xZDd2cDZFQVJvbTZQZklIeHFFTjlIeXRPS0dG?=
 =?utf-8?B?d1NrOEdiK0hrajZaSVUrN0JGSVpUKzhUTlQrbmQwN2p6QmhOVnRoMm9ha1ZR?=
 =?utf-8?B?WjZsU0w3cldVQm9Sb2RvNXdFQmRRVTJNc1FqMkoxYVdqRW1wSlJLL3NIUlRF?=
 =?utf-8?B?UFkzaWVEVVlONGJUb3R3dzJ2cXRFOTR4NUpZT3pXZ0tST2RKRytCdHhzcU5I?=
 =?utf-8?B?SkFQemZyU3JRWWhONXZUUkR6VVlzazFXeGdpRDFIbXpodWZjSmhxaVVIeU4v?=
 =?utf-8?B?MDFlcUF1M2lvbk40Tk5IQjducGc3S2Z1bVB6RDJGOE1XdkV6cys0UExLTGg1?=
 =?utf-8?B?bCtLcW1HalRabUxmR2xXZ2FyaEFXUk8zenhLN3M3Z05BYUY4RVJvNzVBUTZV?=
 =?utf-8?B?UEhhQnErSUlYTTRwM1o4UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGRGdHRGSmdRQy9VVWlRNkRkT2xmUjFHaFQxWEZXRWpmY1RzUXEzMzVoZ0NC?=
 =?utf-8?B?Zy8yZWtEYlI0SFlmd0hEcFZCUVJFcFdFK1psZmFHa3BkWk02eWRwZ3NzN2xy?=
 =?utf-8?B?VkF6RUN2VElGNDJwS2xhRW13YlZOcTc5N2k0MlNrbG5QTzhqVEpOYkVBbzBn?=
 =?utf-8?B?TGpVVFZ2dk9IaWErVUNQM0FWNS9PUmJ1Tm1kMngzMzB4bXE3bWJGVkhSMTUx?=
 =?utf-8?B?TldFTjU4YndDMnBQenh5UWU4NnZlMnhSZTZYUGJ6cWNxNWlmd1dEcHBnOUFi?=
 =?utf-8?B?Zk5VdVVTZGs1RVZyOVRLZi95dzN0Szk3YzB6Y3BVZStwSENtQi9FQmNibVgz?=
 =?utf-8?B?ZktaT3UybWNBMStsay9oYXBXZTdZd2RXTW80cjdjMmQwZDVRQ2ZsaWk5SzJ0?=
 =?utf-8?B?Z1p0NUY2c2UxdkdGUDFKNzF1OUhnWEZ4NGNndnVqVFZmQ1N6T0FlaDlVSVFp?=
 =?utf-8?B?TGJXMUhZcVl6UStBUktZbXBUY1RRQmJXWXpCcHNib3J5NkI5WlFlcW5VeVdn?=
 =?utf-8?B?T2t5c0Q4enp5T1ZkQTBjZk1RMWhRZ0MwKzViL3Y3Q2FEZXNXc3dMUytpUXNv?=
 =?utf-8?B?cEZ4Q3pQM0x4eFZnWW1WYkNOandiOHJwejdxT2RFQ1dzVisyeklUc1lOUEtx?=
 =?utf-8?B?Qjl2citFbXZKalJXM25FcVFLUXJlUndIM3luTmJQakZod3F1Q3VNK29UanEz?=
 =?utf-8?B?Wmx4ZTV4V2xEa0t3SnEyTUZ6WDBJc2J1T3R5NTlSZGpnUHhhd012SE1MYkd0?=
 =?utf-8?B?RVlKUkFZcmRxdmtyUzhSa2huYWp6Tlp5aEdCOGZ1NzhnbGpmRDdlOE5TZno5?=
 =?utf-8?B?clNVNnQyOVN0TU1wdWRtdE5oN04yUVFKTFpzT2NJdmhaUGRUOUd0YnRCc085?=
 =?utf-8?B?OGhyYTZXVGVKbHpoTzhrYUpVTjE2MU5EUWI3VGViRlNlREt5alRVYXBubXlC?=
 =?utf-8?B?WDBhNDlVeWdhQXFkRVUyWVJMMG5abS94dk5KcXh2NzJoN3V3TjgrSDhSSmxp?=
 =?utf-8?B?TFlQZ29iKzVCTUF3L2czbGc0YzNVWDJReGRtVmNVY1hsd1FEUW9lY0tOeTRP?=
 =?utf-8?B?MzZHT054VkpZTWp0ZXI0anBVVHVBQVh1a2dMUnRZSEN5ZHNVQnA0OWZsUkEy?=
 =?utf-8?B?Tjhrb0xVNXg4dW9jd05EL1JLUXlYUzkzS09rc2JaeGY1aGRZOUJkVmlqZVBE?=
 =?utf-8?B?Q1lDdzI2M05jS05TZXBwSUphZkx4THFxVEZBNURLbHhwUUpIMnNUQWo2WW5J?=
 =?utf-8?B?b3NpL1lXTHlJWGxpNVFveEQ1WDV3RHdFNmtlejY1azN2eXNQaEltWFEzdTRX?=
 =?utf-8?B?MzZ5Y2pFYXViWEQxaEhzWG9uTGxTdWp0VFc2QzYwaFJsKzNJWnpCN1ptOXhh?=
 =?utf-8?B?b2NFWnhsTGNncVhlNXdiellWODBkSzE0c2ZpN29RRzRDT05odnBWOGJ1TDN6?=
 =?utf-8?B?V0t6cEZaMnlOeHpxbG1ucVpjTDNXdGEvb1dYNTVrMmVaSzhWQ1R5anFyTHA3?=
 =?utf-8?B?dTlHdnRJS1RhNjI0RFFvVENrTm9uNnFrWUtPUGJTeUJ4VFl3bFRjRGNLRmZq?=
 =?utf-8?B?aVJaeTZmczQveGJFNndyYjlKZUxJV0hwWHU1M1FlTXRZWHBRTGNyTWwxVkVs?=
 =?utf-8?B?Z0c2S2xFcWR6RnhrVGJIWktzZ0l0UTJSek1VSkgxcUY3SmdCcXh4QkN0VWMx?=
 =?utf-8?B?QVMyd1owN3BYSjFUY0ErRU54RjF2N1BabFBxYmVaSXJxV3UxNENLcUhRWG9H?=
 =?utf-8?B?dlo5WGVRN2RTUitvdVlwRlRwUVBBYTdMVmR4NitQWFFFdWZ1dkJLbTB5QlJ3?=
 =?utf-8?B?K0hCdkVxUGN6UGRhZ2tDQjI1T2laT3l1S1Fua1l2YlVOTzB4dnFCaTRra2VJ?=
 =?utf-8?B?WHJsRGN0ZFR4WlBtK1VGWjFGQ21rT096OVJVT2llWHgxQmw4TUhxc0R5RDJZ?=
 =?utf-8?B?dlc3N2pJRWV5aEpUcEFLOXdzWDFBeGFaQ2Q3VzgwMW5PVmpTMC90S1M0YUhH?=
 =?utf-8?B?Qm9vMmk5UjlCN2xkZ0l4VURaazJzb25CbWdyRmZqeExmZi8vVWYvK2xRdVY3?=
 =?utf-8?B?cjY5NFZ1T1hWWUtjeFBzVFVWcnE0ZkZic1BEMkNiS1pWYzVtUTVLUmJ0VmM3?=
 =?utf-8?Q?0O/cZf4LaVbDwAFrBamsoi5TJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2ac4f4-dc04-458b-a973-08dcd8b401d8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 14:04:41.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+ERxzYNAW6iNe70A5SIf6I+dn4jPcCIfwoMw01te4q7j3c8/C+MMlrH76S5Ugrk23Ia9eRMb2UwmvraO7p1Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507

Hi,

With systems that have 8 GPUs nodes + an integrated BMC, the BMC can't 
work properly because of limits of DRM nodes in the kernel.

This is fixed in Linus tree with these commits:

Can you please backport to 6.6.y and later?

commit 5fbca8b48b30 ("drm: Use XArray instead of IDR for minors")
commit 45c4d994b82b ("accel: Use XArray instead of IDR for minors")
commit 071d583e01c8 ("drm: Expand max DRM device number to full MINORBITS")

Thanks,

