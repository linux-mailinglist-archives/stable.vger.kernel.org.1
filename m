Return-Path: <stable+bounces-138937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B880EAA1AC5
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326765A56B4
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC866253327;
	Tue, 29 Apr 2025 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UzPkPYWP"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A910F2;
	Tue, 29 Apr 2025 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745951928; cv=fail; b=j9V7qaH5xL+FwfH339wYqN+cJxTRkMHEZNDFVltsogU0T5P3i75GujiyV3DEPp2ouG+Ly8Yo5Bp4lYXa7Udm+jEJLq+/owLcmzzl0BCLKOQMndcGv27QMTsOHgQZJVoG2wovICyHntulfAIuEpEKLNNORD1E5iFJXhPXWy9l8LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745951928; c=relaxed/simple;
	bh=geuMB/Mb5ROH92xdZ8R2+0lSWmlgRFX7MFytEjBsbY4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gz6ARm7xbGweDtq6HphCFej8vkOfRv+Aurf5FdTvdjONu285O4vgIiL0ePKFuSmndJFHnqbvbp8655zaQHddzN3eLiBg8IAqKAVLzDtohZLD6kkuqK2cFTUDkU2ia3DeN3xTyRoaVFeh3k0iGULKKbpOWQRE/IYV4YyWTIs9wAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UzPkPYWP; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7z9GRoVQ6Skr6E2/DqziZcyZaPnBmq2VJOREvYLk4gVxcffeoUvTWkFni2NORU9jqYJmKyu+Z9RoOGaAdqDdptlr96GR05cnqXZ2lsctfvPXohUAEDRtQpEbMVnK6GzGgi/DHv+J5aa/KrFkZt7wZNNwHsSJp9KRi+/f/l9g8e2uRWemcDtgmjPYgbv14a9Zl3/5X2DtZ9uB2ZpntR2VoflClA0mKQpjv9etthr7isFDpbD737oMvnZOTKRyxrrh2YTDC9hwsfrHDetOhHz/ymZX7i5Ce7HHMNkWGuwv7aBNJ+NGfOJJkkXdBPvNd+jiKEZZbumT4/Khcr0ppkAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaTJZ5vqvdNdZIJi9CjSE4CE6CjnRiMAvwcSspaXZUc=;
 b=BdjLbxjTuBzNp/ihx0mhzp/wKxzqjUR0VlcWez3nMHaX6B1La+7rj95ShizRRC2YveS+QrR+GqlR+ts5lRDj4BVoJonagqcO7NvZxmmn6VztS6BnOiIpDafc69jk+59L61ECQshykJTY0g4CtVpP2NsbWyKso8c3TJz8yLlo/CTK9FxjuH18keJxHcQDC9Ovo8iqcX/7z+tSlwbwTC+3l57vZr4ozQ35BbLgeMFR0j7WLXH0OMVmEL3J70csODyJ/mSCrTiDSrABXjfugSwHFEnbJkBF0GEsY9hKWzRSKkBRi9837F2H9I5fST7/2I5ulenM9iGxVbCSAVtKfMb4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaTJZ5vqvdNdZIJi9CjSE4CE6CjnRiMAvwcSspaXZUc=;
 b=UzPkPYWPoUJrJpUjYx4MDD33iHv3WUDILJ0SU9AQe3nqG/bWFX2Ewmq25Nq1gY/YD42YeeyIkqqG2MG+2uGvLyZkgOnjMwAlVUT4p9NCMvcJhzv4+c47z4W7V/8WNZ8ETR8Ue8Wp7y2DKnKosyDeKfV6HFZjE28FGvd0CxYJxug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 18:38:44 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 18:38:44 +0000
Message-ID: <07a171bf-27b0-f273-b3cd-9c77f68d865f@amd.com>
Date: Tue, 29 Apr 2025 13:38:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] x86/sev: Do not touch VMSA pages during kdump of SNP
 guest memory
Content-Language: en-US
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, bp@alien8.de,
 hpa@zytor.com
Cc: kees@kernel.org, michael.roth@amd.com, nikunj@amd.com, seanjc@google.com,
 ardb@kernel.org, gustavoars@kernel.org, sgarzare@redhat.com,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev
References: <20250428214151.155464-1-Ashish.Kalra@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250428214151.155464-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0163.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::22) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH7PR12MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 4712170e-e281-46f7-0e08-08dd874d11d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVJ5dG9HcDhNL0E1cUVnei9CTkY2TFdoWVFhUDJwYkhGUHBaQ1dkTldXRkNJ?=
 =?utf-8?B?L3AyaitlQ1pxcEc3LzdsbXhlNysrVDJoUjhIYmpraE52OFlJT2tpdjdUQldn?=
 =?utf-8?B?VmVCYWx4N0I0ZEpmblpHSlNWL2V2ei9PMGkxOCs0YWdkaGlCVGJkdjh6TVpQ?=
 =?utf-8?B?SVpKcHZoMG5BQXQ0TVdnT0NXeW9BVEN5UnhYYXF5Z3lMbTdIV0J1OFNia1R3?=
 =?utf-8?B?d0FrM0FZVWJVQ1RXT3FLVVJSNnR4TC9pTVdYREh1NitQZXZjZ0tTUEd4NjJl?=
 =?utf-8?B?OUdaYjJ2YS9INmF4S2MxWkF2QXBNTkF3WktobTFaeSsyaEZJM3I4RU5Mckg2?=
 =?utf-8?B?UGpzV3NqZnNVbkFZckRwejZYSHUyUkg3SU5WVFQ1cy8vVGcwWXhOVEcxelpQ?=
 =?utf-8?B?NDRoc3p2eDh6R2tTbFY3NEZMV0RzWGd0QlhYMmJPKzMyellRT1ZEUUFuaEpN?=
 =?utf-8?B?Z2tBK1VoSkxPYk94c0dKNUl2Z0VibDkyd25SMEh1SzNRWnA5bVdCYmppZWJQ?=
 =?utf-8?B?bWdHVTYwdEptRHVHSnhzelFpa09KSUlXWlJwZzgyMmU3YmFwT0lPOXdFeVJj?=
 =?utf-8?B?T2JwOW9QRmxVOU9hTGt5S0U5L2hudDdLZDRWRnhSQVo5THpYN3VrU0tZb0Z6?=
 =?utf-8?B?Sm04dXJZMEFoeStuRiszUVMvL2JZakRkYmpqVlUvUzF5empGUHBYL0JGQktN?=
 =?utf-8?B?YU00RFZQWFZuWStTL0ZHckNRdDJ4ZlFWV0xidW5ua1h4ckhDVnVIWk5VcFJT?=
 =?utf-8?B?elRhekduQUZrbjREY2R3bXJ2eUpIMHVHajNyZDJ1cHpPN2dOUkFPRzA2MnVw?=
 =?utf-8?B?bVhzRkFhakxJUWQxcUt1VWlzRnRDOVR2L0tjOTFNVW9vcWJ5dVVyOEx3M2pI?=
 =?utf-8?B?MW8yeDl3QzR3TjJNUWJLVjFwSjJJS3Rqd3I0UWFGUW1DeGF1RTl3VUdqUGFL?=
 =?utf-8?B?dXJtYm5PbzJSbnN3cG54cXlsZGFzNmtvZzBMYjd4c2tnbWNYRmxZaXdWRE9o?=
 =?utf-8?B?Y1A1UnZSYXpSd2FJMEZHMHJqdEpCZjJaaC81MnhRcU00bDRYSFg1WkMwWmVa?=
 =?utf-8?B?Ump3c3ZSNUVFNmZTdnVZRjNGc3pDT1hFKy9HS2FZR1dCYTU4WkVEZWJ4YVky?=
 =?utf-8?B?cGdqY0QwNjEzclJNUnBCcTZFYU51QXVuU3hWNElROWwwQ2VVTCtuZDU5c3l1?=
 =?utf-8?B?YVQ5d3VQaTFlZEhKaWhvWHlJQ3ZCelZTb0NVWHVJalFraVpHV0ZMSlJZNzFi?=
 =?utf-8?B?VUtNUnBmWElWbXpJc0pVcTg1UXpYZDY3NTY2L2h6aWRWRW9GUnVQdUVqOStj?=
 =?utf-8?B?VkM0VjkzQ1dTc3hWRGlsOHN5Vzgwenc2VW9RbytyektOa09YMXFjTm9TZnIr?=
 =?utf-8?B?N0Y2aUF5TlltcmJWVmZack5QQkxkTUU3TFQ1RmNOVkVpaWZ0cFU4SkxreEl4?=
 =?utf-8?B?VnpTMExwVGxwSUxLckNtT01uY0pNbjl6S0VkalRUZDRaeWxVZ0czeDRtMUZY?=
 =?utf-8?B?bkZ2YWc2c2RzTjRNbkJ1Sm5LMnY3anExNUM0a3NQU1gzOERqaHN5ZTArRTNQ?=
 =?utf-8?B?bjdPUnpqZFpNWGRrQjY0QlFoTXJ2ZGwvalFzR2xWV0dwS2ZjUUpiWlNpSXBL?=
 =?utf-8?B?aWtmdnIrTzZBQWp3ZG5uV0xnbnlNUnRYU24wRVJncGF0cUJrVzZNRmpldERS?=
 =?utf-8?B?bTVlaloxNHl6QTFPMk1NMmE5V012c3I1Rjh3SHlPRldFNzI3b3lhdG11eGE0?=
 =?utf-8?B?SHY3eFpiTFZsbHh1RHRZWldSQ3dtYnJhbXFrL05vbEdTUmd5OG9TRmZESDdv?=
 =?utf-8?B?YVZIQmNuQ2hYSWlTMkRoYnFFcVBYaFZNbHQrdmxBNXVCK1dLNmpWczJ0TjRD?=
 =?utf-8?B?SllDb2ZYcGdQUDd1VVAyRFZLMWREMk5Ba3FJb3FHSisrWFVKSWdFQXFlUkRl?=
 =?utf-8?Q?qvJoCOy7Cno=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1crejlyL3FucmM3YTgvcmNBTVMyWFNrMjJjTXlyWVMzUE5lRE9wUWt6bHZi?=
 =?utf-8?B?aVFIRFRqNzNnK2ZPVUZPL0FvcCtZN01qWFhwNDRHUGpaSFF5ODcvUnhZY0dF?=
 =?utf-8?B?dVYxL3hrMUp4QWExTjZiQXRzL1p5djlDampoTnhyL1FESlFINTkrTnc3Q09v?=
 =?utf-8?B?MnVUNzZRdzdXQ1d3R3hVV0p6YjdzNGVFSW1SelhPeGFxVTZBdE0wOTdKSEIw?=
 =?utf-8?B?VnVOdWd6R1o4Tkx4eEZkcHZ3Y3pyZzJWWlB3bE16bkNEd0xZekczZEhIVXJI?=
 =?utf-8?B?SHZnaXZ5cDdJTFo2cW9lblozMDltTHlIV1hTTDRLYkpReUxvdDl1d2ZnZmpQ?=
 =?utf-8?B?MWxkYjJhYmU1QnFiMEZVU0UyZmh4VEpGdCt6MC9zVTdRcUZsS2drVGZnbFdR?=
 =?utf-8?B?Z0NWS2xFYjVXcjBXVTJKNDVrdzE2eGxvNk5Ua1BjMWd3aE1PR1krL0h5MFFt?=
 =?utf-8?B?UXl4MU5ORFhqZ0VVanF6Y3JnRkJTOWJReDVraHhLalVLdGdTWlZBTDIzdCtl?=
 =?utf-8?B?Z3V3YUYydXdwUWh1cFcyL1kwdmlDRXpIT1ZiOE1qL2luMDQyb3pPanU0N2V4?=
 =?utf-8?B?SUhLZ2xuOWVHV2xoZGUwdDN4U1h1ZldUSXJIY1JhemtEdlBucmJ6c3FqbzZR?=
 =?utf-8?B?ZGFnY1BYaVBKZDZ4bDlyRytCaWFlMjVLa1Y1ZGlqSEJkZkZvanMxU056ZVJY?=
 =?utf-8?B?aXVJRDFzSXJXN2ZhMjAwWlByTUkxOFlDQkRSYUJmdTE0VWZONCtuQUk0TnFp?=
 =?utf-8?B?Z2dqL1BPckl3UWx5eE02azYyYi9TWUk0azkvWWF5di9FM0JlR3V3QnM3L3Fv?=
 =?utf-8?B?SVVRYUFJVldlTk4xcFJlVHNzakNCeE5Kc2trOGQzWHVoODVRVTFiU3dySm54?=
 =?utf-8?B?c1VtUXAxME1FVzJUODVpQm01WmU3QWs5Y3gxeVcwNHF5YVVqL3d3bzl1SzNU?=
 =?utf-8?B?dkRjOW14MUJqTGZUZXplejJETkcrMmxrNk54K3F6azRvb1ZoQkpweW5qbVMw?=
 =?utf-8?B?SGRrekdjcmRRQTNueVBKRUQ0Q2poaWtrZHE2RklHQThJY2dJYWx2NG4rY0U4?=
 =?utf-8?B?NituVjd5Z29IY05RbG5IakNQMXhzWmVDLy9Lb3E5blNHcVhpTlFiT3o5aUNk?=
 =?utf-8?B?QnRnWUVRWERHV05iT3hpcEJLMUgvanIyMURUSURBZTh4MElmWEhnLzNzdTlT?=
 =?utf-8?B?bUNHV2xKSE9MTzN3TFVBaFp6Sm00ZHFJUmI3dEw2NFI5L1VReUhtdzdETFp6?=
 =?utf-8?B?TVJja2QySVFNSFB3R2ZLNjBFM3M4Mkt2UlZRMlN5d1V1TDdJQnNCUytwdFYr?=
 =?utf-8?B?S0ZnYmhteHp3N003azVuekFIcGFydWEwUVd0R3RVRzEvZldpRzZTMmhPQW5k?=
 =?utf-8?B?NkVBV3BtVkpaZXpsdm5UL3ZBZmw0ZG5ZcDRmN1dnQk9GQnZxd3RCVkplOTB2?=
 =?utf-8?B?alROZGZqZmJlSXU0ZHN5elVodm0ybGJpMit5YkxKYS9TMGNDMzdWMHQvYnBi?=
 =?utf-8?B?c1hQSjM3VTNCNEpKQ0ZmKzUvSE9QVkNtbXZXbElHbGRWWHNmWXVBOE1sT1hM?=
 =?utf-8?B?UE1STzJUa0VZb0RROTd2K3hnZGt0UnJLYVllYm1WV3ZLUEhHYTZCWkFuVTVl?=
 =?utf-8?B?VHNrcjRGM3NJcmhmdDJ5YVFXT3JkQ1phOUxnYkh4RWZFN0RzVTJtSDFUQmZT?=
 =?utf-8?B?RHlyZWllQmluL0tnT0RjT0c0VElIMHlpZzZYQVQ1b1gzUmtoSXJGNzlkVk5M?=
 =?utf-8?B?aUwvOVVhYnhZUldHY2NmdkF0K2dNTGtSNVNzWSt0L2g1RUQzSWwvaW1CZXJp?=
 =?utf-8?B?ZC9FcENqaTR4SGJ0bFVyVHVUN3RMWG9QZW1ZVExla2V4Q1dXQ0wxRlVKMW40?=
 =?utf-8?B?YkxPZGJMS2VqMnBnT0RnSmh1bUkyV2tQMkE4YS9yMWFVQjNiUWtYTVdYdU4v?=
 =?utf-8?B?aXkxSUFPcVdhTHJIZVBnVXgxT3B1QWNRaGEweDI3cTRTN2hEUk55bC9wSkRQ?=
 =?utf-8?B?VytoclFCbHo4VWd3dk9CZFdaVjJyVlhkV3duaWhNTmVDM3EyYjFpUHBST2lI?=
 =?utf-8?B?eVR1Tzg1YTFLU1pqL2VoV1MzS0ZSU0JzdGF6dHJFTXhDL3h4R2dPYWlGK1pC?=
 =?utf-8?Q?K7xEqMT8PKwjE73MvyxX6bXmd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4712170e-e281-46f7-0e08-08dd874d11d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 18:38:43.9379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/kzGe2utY1P4DOo/l0GJX1XduW/Z8vxsxDzg7YbjZH6FHf/pzXZ1lDl/pNpxs83s+Y7TbjE2/A7cjQzKsC7Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696

On 4/28/25 16:41, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> When kdump is running makedumpfile to generate vmcore and dumping SNP
> guest memory it touches the VMSA page of the vCPU executing kdump which
> then results in unrecoverable #NPF/RMP faults as the VMSA page is
> marked busy/in-use when the vCPU is running and subsequently causes
> guest softlockup/hang.
> 
> Additionally other APs may be halted in guest mode and their VMSA pages
> are marked busy and touching these VMSA pages during guest memory dump
> will also cause #NPF.
> 
> Issue AP_DESTROY GHCB calls on other APs to ensure they are kicked out
> of guest mode and then clear the VMSA bit on their VMSA pages.
> 
> If the vCPU running kdump is an AP, mark it's VMSA page as offline to
> ensure that makedumpfile excludes that page while dumping guest memory.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/coco/sev/core.c | 241 +++++++++++++++++++++++++--------------
>  1 file changed, 155 insertions(+), 86 deletions(-)
> 

