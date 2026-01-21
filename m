Return-Path: <stable+bounces-210693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAwRFlx0cGktYAAAu9opvQ
	(envelope-from <stable+bounces-210693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:38:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EAA52248
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 495A74C4331
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 06:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3CE44B681;
	Wed, 21 Jan 2026 06:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ObStfdrN"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35F936654A
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977391; cv=fail; b=NOXqBz+4Tf0JqADT1BdoowOinHnW+7JTiRMzE17MpfIuRLJkmCJXUmijvwxurGb/BB3YbO16GiJXrP9Ym+A8gBaXhUAt9R0ccJ8rerQXLvq9fktXk58vEXfzIHf4TBVDgP1SXE5dzT6BNVlhP/t3BTobHEMfSd3nZKZhEuD5I8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977391; c=relaxed/simple;
	bh=bBok+FyIvdDkqecBF0c5DhMJ+hjWfUsENBTchGxssRU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ph3sJhmwT9IiuOJJv+mZDCEQT84YPk7e8vgnz8AkSY/KvJ1R8Gf1L1BeKwufStuQd3NV977shDLA9+8J+3w8TyoC4zlQDREzyevu3p5RIxZYilxB9YBFeBeJp5Yw0KH/f9VR2K6hgEZaN1zMqY61XD9Efyb5gIWhoP7NoSyUfTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ObStfdrN; arc=fail smtp.client-ip=52.101.46.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5lgpTGOL/Y4gXuXjsdoe5aY/q/EEMQ/cUZFATdFVDSXvd2jvqUpoy1Tl4Nvkq9NTnv32xiNMKdzsPTL+C2+yAHEmYU0WNQiQr0vQ/AAw/8IKH0MQojUf1nc+wOahVJQqvRb92azQFDCrRk055U3RgODks/Tyam0oWR2NtSUfdVRvPrPRjXJ41VBsL66ZD9mrE6Sgvrkg4bwcUi38HhhsQ39YbMbYTKoZCjVkDcMko9ax7J4IHhCzSxCrcmPrgNSYzC1cvTCfbtn2xVBULQ34iilQOcTyfnJ3PXB0Fp7dM++tG3OIbYg/7KM4gVGUzaQpTStTA9B2Y/TRyniCI0+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXOe2hFL7h8JSWawGM4yoH0MYv3AbBcOGHSMwqt2bdg=;
 b=n80Za1mZBmv7O90A2487mgIRoHAATdRrusOl/jNnkFOtCL2lmTBxGGVK4VZ6URf87v4i8zU80RQXOKNT6pgAln2dbUvoV5l6CS+WhPhOO8cX457KSEQbKsyo8bplakvP0wBnMBr333tsv8QwhlpgD4RcCIYWBWxx5AU9CfmXxN1l51YRtkbV21TcoSLJaHTyMYLTmdeVEM7WhdXh49WgKtK6bPqQnoibtm/fJh3LY3YvVmfPSPZXxbxLBOQgUvqB4PgG1TSC7bTK7L9JaK+zzIHgtGCnuHQ4FcZLCj038oKCpWJ+OyQmltF8qAt8pLeNmLtoihji/t+lb9rJ2uizWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXOe2hFL7h8JSWawGM4yoH0MYv3AbBcOGHSMwqt2bdg=;
 b=ObStfdrNmgj6AVivHRcXp4AC2wVdKpw7zKKadzuxD1oLblnCrZuh35ZZfrQ9sMMoum09GDIqWCQ1j7tYMkQxs/oNuC6OiBVA7fHsH0N4mAucKD5jknEAI+5mr18UNuL31D4d8KCXKgEDCZBmr4PnIJog59O+5bZlp/MtZDD2eBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 21 Jan
 2026 06:36:14 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::8434:dc50:a68d:7bdd]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::8434:dc50:a68d:7bdd%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 06:36:14 +0000
Message-ID: <0b5fa253-1c2d-45ae-a6bd-0373e27af64c@amd.com>
Date: Wed, 21 Jan 2026 12:06:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/buddy: Prevent BUG_ON by validating rounded
 allocation
To: Matthew Auld <matthew.auld@intel.com>,
 Sanjay Yadav <sanjay.kumar.yadav@intel.com>, dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, stable@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260108113227.2101872-4-sanjay.kumar.yadav@intel.com>
 <20260108113227.2101872-5-sanjay.kumar.yadav@intel.com>
 <654f40ab-8402-4bb1-88ff-742572a1b251@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <654f40ab-8402-4bb1-88ff-742572a1b251@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::15) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce6b7ee-1dfb-4cad-063f-08de58b75fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2dGU3puZ0djWGsydHZFZHBJYzh0WVNCRjNkUEhYSXBGQllVbGZ6MWgzQnlT?=
 =?utf-8?B?Vm9SeFdvVjVuNGJ5R1ZLZHdSK0QrZFNwQ2tRaGd1SkFoTHQwMWNBN2FXYTli?=
 =?utf-8?B?bzRwekdhd3VHajhIeDNheEhIMUY1YmkyNzRMaG4xWlBvQndCVC9QOWx2c2Jq?=
 =?utf-8?B?VS9QNU40YlBxMlhsQ0UrQk9tMkZXUFBSSjlCcjIxWVl2eTkxbVJIYnNVMWMy?=
 =?utf-8?B?UTNIUE1IZXFEWG9iMEI0U2s2dG9oYStwbWdjeGpTa2V0OWZYNkJaOTY4WVZZ?=
 =?utf-8?B?ekZ3VmdlRjBLZ05KeUxiRmNETVJGSTB5Tks0QW11WXdDbGxhLzJ4N0NqdVI1?=
 =?utf-8?B?QWxqNDhtTUxIdkZVL0tzSG1pdy9IK1FuVUtMQ3l4bEVCMFowdHBROEkySysx?=
 =?utf-8?B?WFFnbFR0RmtRdjhsWFYxaHJ6ZVNlT3dvclgxSThIWXZDd01nUjk0V1F3cWQz?=
 =?utf-8?B?RjMrMytMcHllLzUrU095QkU0WHozTkRsbkNGTGJHcVBBUVlCUzVoVUVFYjk2?=
 =?utf-8?B?RXlPdGNUNE1MTTV6SHZnbU9KNEhwNVNaRGd6MElVb2pCOUR1d3FEajVmZlZz?=
 =?utf-8?B?bkRMNDZZQ0ZOaWFyY29XcEN5eXIreXZodDNQdGs4bSt4b3VKYitVK3dTMTBI?=
 =?utf-8?B?TE5GMEJCSGs4VE4zaTRDZGEyamJhUDFiNmppNVNwazBzNEc3UHpvQ1lsTytE?=
 =?utf-8?B?N04ydHJCVGR0ZlJnK3E5ajVsc2xMYW03YTRma1VpSGRaMHY4dUNLUHBweG9s?=
 =?utf-8?B?TGFKbmw4S3FnaXQyamRKMDFzTVVaU2NaMmlzeWF1aTg0MjRObUJoQS83ZERM?=
 =?utf-8?B?YWhCMkdjTk13dmlHTmRUY0tGd2xtS01XV3puVGtqK0JXODhDdm9UNjlyK3B2?=
 =?utf-8?B?eDQxTzhGYWRGUmhKZW05V2VBNHl4VTR0ek1DNlA5bGlMT0RuQlNnUlJnWVpv?=
 =?utf-8?B?SnNWYVdQVVRRc25WZ2JPQ2V6NUF5VGVITTVaekxUb2ozZ3NZOTR2SnB2bnk2?=
 =?utf-8?B?TzRQa0VlN1pMVndRdFlVRHNMalE1MWVYeFpuZmhEOUsxQzNvYk1LMEh3cS82?=
 =?utf-8?B?NU54Qktwc1lPcEREbGliWStWVEVmWFJjYzFKNFlKNWdaU09oNHJYMmJUajEr?=
 =?utf-8?B?aVJkdnJRb1pPQXF1YklNb1VIVWs1MFlXY1lycjhNUlp4SUllZmFSd2g3eEFI?=
 =?utf-8?B?U094Q3FmUmdieW85VnhvK0tFdGpsVXI0Y012Y01lNGlqa0J5czBBT0NkTWpl?=
 =?utf-8?B?aElHQXhpbDIyUjVOdEJKUEZuWHFwaEVmWDVmOGp6TmNsWmZWNUgxZG5GQmpV?=
 =?utf-8?B?NmxsSzFwYStqOHhSVVk0WXloaVF6RTN1d0tZU1c0T2JaVnYvdU1pVzM4OGtQ?=
 =?utf-8?B?cFhvTllXTWhVSkp2UytXb1I4ZXNsMk50UUxlUkJjV3o0ZWl4VzhyZzZFY1Z4?=
 =?utf-8?B?VjhCaC9sREI2Y2lxemhjbU9oaXlJY2Z2MnJqN3JEaTlkcDcwWWgzWmZ6VlRu?=
 =?utf-8?B?M1B3ejZzM0VWNktsQUx4bWFoZW13UUtUeEIvb2tyQTZrVDdOMWhNVUcwMFhi?=
 =?utf-8?B?eDJsT1o1dHpRTDV1dWNaVmhTczhnL05ONTFJV0drbEpKR3M0QXA5UVluOWQ3?=
 =?utf-8?B?bGZBWFhTVFE5WnIwelE2ZWloNVNJejJ5aHNCOWg5OGV6TEFVNkVabk8rN0Jv?=
 =?utf-8?B?dUxUYk1qVExsVW9WK29PN1prcjNnUkp4cGpHVnp1aUgzdlowOWVSYTlrVm14?=
 =?utf-8?B?RTdEUzhYOFd3NEVpUEVRRlZHTUZ4NFUvKy90Y0V5bVR2RGlnNFI5Y2FHUGw4?=
 =?utf-8?B?NzlaLzZiZ1g1a2dEVndROTUrekU0Rlg2OEZpNlJsOXByZ3c2Qld1d05yYnhh?=
 =?utf-8?B?a0RtUHNFYnNqOXM3eFo1eFQ1M2dmbzNkTkFadkJ2cStWdGxMUlZCaktpOUp4?=
 =?utf-8?B?Sit6b1ZyVCtNNzRmeC8xZlU5NUUxcGhjVlFxbElQMCs3S3NhQUlPWmFvbjg0?=
 =?utf-8?B?WDBWaWJGZk9IT0syZk1EUGl1QnlJWE9OOEczRlRNcjJxeUM5TnJvbkdCZ1JR?=
 =?utf-8?Q?NzSNvM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7301.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG54MjJYSE5qbFNZL1oxMkExNnB3dHU2RU9nYXpOcUdhaTJyYzFXMFRFRmlv?=
 =?utf-8?B?YVpOYmJHNUl6Q3J6UmxPWDV3SVI4MERNNXdIeEMyWXNsR1QyK0NzcmNXU1Bt?=
 =?utf-8?B?ZXNVY2VXOWY4UW1OQi9tL21Id1ZiMzdKdTVDY1ZiVWZVUGFXTzhJT04ralpD?=
 =?utf-8?B?TG5NeU4zeXNYRDEycURUQnV1bjAvTWVjK2hUNDFucGxXVmJKTmpLSDJYUDJJ?=
 =?utf-8?B?Nnp1MDFXVzdyTDEwTzdEQXBpZ0dqV04xcktlcjhBeDhmaWtOcGxxMTJLUDc0?=
 =?utf-8?B?NlBDMTlxYy9MbmYwc0Jsckd3QmYzOUdKamppcmFIeWhXK3hVYitmS3lOaGZa?=
 =?utf-8?B?MFY1VVBiRzJ6ZHo2SHU0amY3b1pYTllyWHdVMHEraTlNK2lwczM1VlFDRWFp?=
 =?utf-8?B?SC9lRVJ6WmF5cFg3OTJsY0pXTG1oRDlPRU4xMzRZMTNxcjIvZ3BKMUNJN2tL?=
 =?utf-8?B?UkdyWkNCNHo1WEhQQTFGbGtwK0ltNUxsaHJLU2V3U0tpbjZJNGhXVDcxa3Nn?=
 =?utf-8?B?eVZQTkpPejVHSTIrSVJJMVNLYUxsQ21JczJrWVR3V2J5UVY5K3NIa3VqZyti?=
 =?utf-8?B?RXdFbE1LZHk5eGR0V0Q5VnUzRGx3LzJkVzhsNFduaFJiL3pmYy9VSnd0RjNW?=
 =?utf-8?B?V0paNjFid2R0aHN2ZDJ2aHJwZTNhOWI2QkFVTWlseW9DeDkyWDNYUzdoN1BN?=
 =?utf-8?B?Zm1PdktHT29kNmxKWi85UHo2b0lNSTE2Z1hvck9zeTNhWHFCY2RiQmFjRVBG?=
 =?utf-8?B?OEhnWlFBLzBvSlZYNHRUcmd2NzZQcnEvRW5yRlNFSDJJL2pad2ovenhTb21J?=
 =?utf-8?B?Rjg5eit2NFhLVDZGNjc5c1N2Sm1SVHlBZ1EzZmJXT3lJVG9USkI4N3NvYjhj?=
 =?utf-8?B?RmxQVHFsSk15MDJGcER2VW9wL3FKc0pJakZFN3NxcjJOcmlNbjN1cGdHWEZB?=
 =?utf-8?B?cGRlc2o4T0tJUUplSWxEMDhOUVNnYTBvcmx6ZUtGVjkwYnNWUXpQTXdFZzR3?=
 =?utf-8?B?a0cxbHpNcG12N3NmYkhMMittRlFxZzBKVEE3TjhvQ0xoRU1nZWdQVTlLSVI2?=
 =?utf-8?B?RGNGdU1ZdjFIRU9QNHlxV3JvNFZRVXpzeGdrVDBOSVZlb1pBdkgwaGhlUE83?=
 =?utf-8?B?aWdWaTN1MTV0WUlzUHZueHArWEI4MUNRN2Z4Nkh1TDdkcWd5OFJ1KzBpbTdo?=
 =?utf-8?B?eHhndDVYdTczV0FPMk40QjArUFhjVC9PdUU4Z0RUeHhiK01jNTU3YTZoRUNV?=
 =?utf-8?B?cWFLNm9EQTFHSzVWOU5XV3MzeW1mY3R2MER6Ukd3R05sR2JES2hTcmVZR1BD?=
 =?utf-8?B?RFRWenFqN3B4Rjd2ekJ2eUtPYUFKZW9zT2JtVFd2dzhCV255N3VZR09abndZ?=
 =?utf-8?B?ZzdzTzF6TnNLbDU5UW9PVjB2SFM1V0ZFV3RNSEpVNCtjVExDU3MwdHVZb2R4?=
 =?utf-8?B?cnFzNEkzZmRqUTlMTFAzTmZOSDZ6OVRoM0R0R3hlQkdzKytCY2ZjNjZYVEhq?=
 =?utf-8?B?bkt3QUJyY3VIZ01xQnYrRWZBQmxhVURvb2JyVUJlWXJnVDVKcnNVK3pZU1Bu?=
 =?utf-8?B?cXZHMjE5ZVJXeHVLTnp6OTNySmtUemYyeFd1UWRzblpMSjJWd0Z5WEVGTlJC?=
 =?utf-8?B?cmpEZVVaU3pxcjlOSlpPdVhodWNGVERCenBZbnZnTmtmTWRNT3RUZVJwdmdB?=
 =?utf-8?B?Y09NZ2QwekRPbGIxQnRvZGpWU0dFQzJGOUxLVkZmOUkwcGtqY1VnVVRiUS8x?=
 =?utf-8?B?ZDV1ZjRIbVJkUm9oWDZEOHFVckRSd2lWNUZwV1BRRTczU0JlZldUeXVGdGta?=
 =?utf-8?B?TTVPeTFWL2JuamhpWUc2QXIwT0ZaenA5emFCM1pjRkNoRkdCL2hkdFIvS2tR?=
 =?utf-8?B?MjdwK0xPT2hsR0Q0ZzFzZTNRSFd0ZzJRNXRKRnRrYm9kYlZpNGZBQ1lVU3Fv?=
 =?utf-8?B?Ykd1bWJKNUVRMzU4VzNiN29kcWpUaTZWWFJ6dGN2UCs5NGdDL0FlMWw5R0J6?=
 =?utf-8?B?SzNnZXplczBRMnUybzNuNHBZWEM2ODNWaGN0cUcydXlMaEVCRE9SVm9RRFha?=
 =?utf-8?B?aXFDNmRORXF1bGhrZmd3VTZrNy9oME4rRUdyUnFRTmtlYm1aaFJzTjQzcjNO?=
 =?utf-8?B?M0ZWUzhPN2hjN2dkRDhENEtXWTRCK3h4Nnl0ZUttdGV1M0hRZnFOOXVISUlv?=
 =?utf-8?B?bU5jd0tmVVgwZjBjMnE0Rm1OU0FzWGw5UHhOSzNFMjJ0ekNEdkd2K010TEhX?=
 =?utf-8?B?aFY0WDB5N0Fac0tBTngxTVlRZStQZ3VyVDdadG92QkNYSnR1Q0kyRHB6YXhZ?=
 =?utf-8?B?emx5YXlhQVptSDVkbTBrcXp2b0MrTmpkWEFCQUJaOU5xN2NmLzZkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce6b7ee-1dfb-4cad-063f-08de58b75fb2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 06:36:14.5274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRrPE5FBRwoVsUmz+6NUJKdblzCddYBdTH7syiJWZnRBDjCknalDm0TOvc4RLY2Km91mjhjdURnwK6jPk9oiXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210693-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arunpravin.paneerselvam@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,gitlab.freedesktop.org:url,amd.com:email,amd.com:dkim,amd.com:mid,intel.com:email]
X-Rspamd-Queue-Id: 06EAA52248
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 20/01/26 16:11, Matthew Auld wrote:
> On 08/01/2026 11:32, Sanjay Yadav wrote:
>> When DRM_BUDDY_CONTIGUOUS_ALLOCATION is set, the requested size is
>> rounded up to the next power-of-two via roundup_pow_of_two().
>> Similarly, for non-contiguous allocations with large min_block_size,
>> the size is aligned up via round_up(). Both operations can produce a
>> rounded size that exceeds mm->size, which later triggers
>> BUG_ON(order > mm->max_order).
>>
>> Example scenarios:
>> - 9G CONTIGUOUS allocation on 10G VRAM memory:
>>    roundup_pow_of_two(9G) = 16G > 10G
>> - 9G allocation with 8G min_block_size on 10G VRAM memory:
>>    round_up(9G, 8G) = 16G > 10G
>>
>> Fix this by checking the rounded size against mm->size. For
>> non-contiguous or range allocations where size > mm->size is invalid,
>> return -EINVAL immediately. For contiguous allocations without range
>> restrictions, allow the request to fall through to the existing
>> __alloc_contig_try_harder() fallback.
>>
>> This ensures invalid user input returns an error or uses the fallback
>> path instead of hitting BUG_ON.
>>
>> v2: (Matt A)
>> - Add Fixes, Cc stable, and Closes tags for context
>>
>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6712
>> Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
>> Cc: <stable@vger.kernel.org> # v6.7+
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>> Suggested-by: Matthew Auld <matthew.auld@intel.com>
>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>> Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>
> Arun/Christian, when you get a chance could you also merge these two 
> please?

I have merged these 2 patches as well.

Regards,

Arun.

>
>> ---
>>   drivers/gpu/drm/drm_buddy.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
>> index 2f279b46bd2c..5141348fc6c9 100644
>> --- a/drivers/gpu/drm/drm_buddy.c
>> +++ b/drivers/gpu/drm/drm_buddy.c
>> @@ -1155,6 +1155,15 @@ int drm_buddy_alloc_blocks(struct drm_buddy *mm,
>>       order = fls(pages) - 1;
>>       min_order = ilog2(min_block_size) - ilog2(mm->chunk_size);
>>   +    if (order > mm->max_order || size > mm->size) {
>> +        if ((flags & DRM_BUDDY_CONTIGUOUS_ALLOCATION) &&
>> +            !(flags & DRM_BUDDY_RANGE_ALLOCATION))
>> +            return __alloc_contig_try_harder(mm, original_size,
>> +                             original_min_size, blocks);
>> +
>> +        return -EINVAL;
>> +    }
>> +
>>       do {
>>           order = min(order, (unsigned int)fls(pages) - 1);
>>           BUG_ON(order > mm->max_order);
>

