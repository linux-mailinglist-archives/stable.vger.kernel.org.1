Return-Path: <stable+bounces-195389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D72A7C75F03
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 660DF357AB6
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF483358DB;
	Thu, 20 Nov 2025 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2Jfmxol9"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE035368267
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763663751; cv=fail; b=bgQ1xtCa/ulElVfj4jb2ZtrBau5rwuSxxFBiuYnNq/9xOVUP7ktrMt1MY5/kIQ3jO4o5maS28sOTQ4JXzCn0Bquz03evPGwTpV5ghWvTveov6Xc0I65vfJnCGGG/piuRkadirI7Q4ZPQfMzIrJOsayGhDuZ0WowuHu6VPPzjNV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763663751; c=relaxed/simple;
	bh=k95tIeusHKz6PckABJHkVFz+oTmRJa0xXm3vdm5jQ6o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b7xxbFt+kCa+pyUZSJmZOMopOtMgFqgiBkdqChw9lX29MPuJ8pytqVJJjO4SE0LeeC4HHjwCl1p/280kbawFbNzWSDRSWjmnp2ytoi+v1FQkOKgAv7DGHTvNU05HNdi1TPqtAslKvAyqaAzzsUWAX/l5Gs2gycgU0BF6lePWo24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2Jfmxol9; arc=fail smtp.client-ip=52.101.61.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFhpGkNUt3KJs40sE5n1Xj5y2VkzmsGBtZh+WwEuL8mhJSqd6ZEdQ4qXK/u9wY6/8PZ5eRaF43+k4l7VZPKEfK/oZPe0yf4c+m05Sg5KBt6IfGJoVLrw9jWe/7DegkUPgbwUpi8ocxV7zcYk+1jOqyJUfi8Q4lp4fR2+bMHzNSdOkQvWLGw5Ze4TCkpgxM4PSoZhghM/SfbdlkLdRDmQZ5hHaBL/59+BdmVIGphUsnA4zK73Bcj2fKCzt5icpNY1U30vH391R8TsQHNk8u+GyKQwR3nE0WtQggwfC/5cOB3hriG9HLkLVipAFk9TypI20qq4gwBqCnf1LXxUp77G/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dy0SRWwN2m3Fql3LEW7k7fNElwFZ4CE1/tVG3vOTkpc=;
 b=iNSVv2hvBXr/jQck8xnHGvBSiS+ZEvmAIpeM8AD7r9uOgGufvyCZz5goxVINIxYCc7sTnD5ojJXxO1fCa/FIwYDy8Pms+3UODq6EUodJ3dKxF9WuW5++KVJD7QkSYtcCUfmLfqZu6lNvSlk9hDSE4fQKi8zeWHXPsEZekzNDbvAvOviHc+JHPZAgCwnCG43iHXQ2tRw17JeHu4yeHY6DkkK0+5prUgrhokDX2IDIj7iZ3eN9vHjmNip1BbDmgzZJFKBKM13sCad2QzzYyLB0Ll+26cwGCwTv8NgDWyHWr7gMqXKf7l+kSbUkVkBO9xcif3+FLZCB50YD7MywHrfQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dy0SRWwN2m3Fql3LEW7k7fNElwFZ4CE1/tVG3vOTkpc=;
 b=2Jfmxol9wWJUIqtE23eq2N04AczQZtIRSiP/kHFUlzNh2L6V/DEZmWSsSKym4rNbhwFHox4pbMl1DLmid/KziDYpKqemXKf8YmzBQ17qMRODD0ZcYTm4l6G/tD/ytH5wm1VbX3Q5ksOnYh4w4sqTu9d4Q7nDtesdpqx3XX0PAW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ5PPF183341E5B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:35:44 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 18:35:43 +0000
Message-ID: <1a10e80d-23a6-4b35-bced-7b55cc6a5966@amd.com>
Date: Thu, 20 Nov 2025 11:35:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/26] drm/amd/display: Correct DSC padding accounting
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Relja Vojvodic <rvojvodi@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 stable@vger.kernel.org, Chris Park <chris.park@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
 <20251120181527.317107-24-alex.hung@amd.com>
 <49c24aad-90cb-4d87-afe2-1a65d2d85e80@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <49c24aad-90cb-4d87-afe2-1a65d2d85e80@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:303:2b::24) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: 09796a8a-c5c9-4f42-3671-08de28639c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3lZQ0xTVlA5VUhDUGRiT283Y1N5WDRhTGV0dWFlL0pPMVI1Q0F0RCtYUUM0?=
 =?utf-8?B?MjBJYTFXTVpBVUxxcnpxOFU1QllwV09oeUwzNzVtTTc4anllSlBRYXpKdGE2?=
 =?utf-8?B?aFhLWm1zdit3YlBQQXpnM1pCSnBrMnFmR1FzeGNrSVBrbnR2Y1dNWmdPTHlJ?=
 =?utf-8?B?N1Q5Q0Q0d1lOb3Exa3k1anAzY3pWQ1VsRG9rWlBrMHEwNW92Ty9DbFdjcTNL?=
 =?utf-8?B?K2NOdm9VRENYdVZZc3VSSUw4WUVSOGdHNFF4NExJUGxLMkRyaklFK1V2TCtE?=
 =?utf-8?B?MVAwMFM3Qis1dUgyOXN4eWRWeWY0emRnUUhnaG91YVhHUWdLZmVrSTZmZ3Zw?=
 =?utf-8?B?SEdLdThKcExwd2lPWXBtakhEWGw4L0xIeFVFc3dEWUp2NnNtQzYzM0pzaklp?=
 =?utf-8?B?ZENRZDVqY1F1M1FkNlVJTEpEdU1WM1pSMHBrQmlSaWRqaFhTbG5McmpieHRQ?=
 =?utf-8?B?OFZ1dXhweXl4eTQwRHRjMWtGMVVTcG5teTNreVJXQUQyOExCa05JTHUrMmtW?=
 =?utf-8?B?UTFjZW9nNHF6VExrcjdtMjYvS3ZFd1RoNlRMUkp6SHFqTWJSUUR3U3ZDT2g0?=
 =?utf-8?B?TXZJNW41dzdBY0FXc0l3TklVM01mSkRrc3JUYTdFb1JXUlhkUFdKMUh6U1BX?=
 =?utf-8?B?bVBRYldReVo3NmR5VEhRNytUQ1VHSUMwQmVlcXpqdGpJUHBFZitrY2c5Rk1W?=
 =?utf-8?B?QXpvSE41R0h2Z2FEdThrOG56dVhQS3piWE0rWkpacHdBM1lpRXkvNUNqNWF4?=
 =?utf-8?B?ZEpZR2luenVMaHl5ZFZSRE1ZSldRcDJFSEJ6cXlMTWwxblhRZmFPLzFvajd0?=
 =?utf-8?B?RDBXcFhQY3hiYjg2RW11bUt1NWlWMHY3S3dxc0k3dDc5bDNJcXBQUlArOXVE?=
 =?utf-8?B?UHB5bndYTXU1NEhSanBtVnBzODgwL2Z3bCtXcXh4Q25ldFZrdFlpKys2Zkpm?=
 =?utf-8?B?MFQ0NWtxbCtwTWc0cGQyOVl1NzBldTVPS2ZMWkFEdGRDd2JGTEdKcVlxQzRH?=
 =?utf-8?B?VFE4c2p6eEMzWWxwZ0FqanJ0ZG9vM1NSWForZEVxY3RMSm5pZTFuZTJ2QXln?=
 =?utf-8?B?Y0lEUzV3eTZ5ZkcyYnU5SEpBQ0U3akpTK05sM0xEUHFNMXlaR1k2dnYwcnZH?=
 =?utf-8?B?TlN2RW5CbGZTNlNwamdta3IvS3RrZEE4U0tRSEFXTVlZdTNOaWlqZ0h4b09S?=
 =?utf-8?B?R0VNUWZ4ZDM0TzZqaTN6azBLYzdrNG0rZ0JUbnowYVdyZTVIT3c4S2RwQWZa?=
 =?utf-8?B?dEpVc0xZRk40VTZsTlRQdlZEMlVBME4xa0VnM3JWVzk4U3d6VnFXVkNMcHJD?=
 =?utf-8?B?UFNVK2xGS0dVUXgrYS9YUWNUMTJEK3RGZmdFaDlWWU5LdWRoWjNweFpjeGor?=
 =?utf-8?B?eUsvd1pzRngvYjFSeVJMcHJLako1Q0VzaGpNU2VUd2xYUy82N2NjZWNWcWtF?=
 =?utf-8?B?U0w5N3VRQ09SdmtBenZWR2Q1b0w5NHlWOHdPbDRjZzFUYXdtb1E2R04rUnRC?=
 =?utf-8?B?NktIZ1RvUmhsbHhnTFg0VmJRZllpSDBjdWhxWlZaLzF3QXl5c1BlaWVSdlI3?=
 =?utf-8?B?KzhLQ2s0RVJJVVpLT2NYZXZZRGU0UTBQNTVJNjB0WG1yM0ZDdnV5ZUZWeGJa?=
 =?utf-8?B?dGdJbC9YdkVtbDBrVnZMKzlRc3FvMmFBZkJyRGNWY0UvNmJ3T0tiSDZzbjE5?=
 =?utf-8?B?VDFRS1dDS3B0U2VONGFxZDJkRmFLK05OajNVNi8rRXNVSFJ0NVlhVDZ3eHVt?=
 =?utf-8?B?dyt0SFdTMlFGTGlKSU8wRlVZem41N0c1TVdEVnF3QkgvOHJ5NmVLTkJXUVZM?=
 =?utf-8?B?NDNKRWVjbDNLV2xYY05GWVl0VFZSRlFGNzZ5OGprVGxyWTF0bXhCckV2cDNz?=
 =?utf-8?B?eXcrMnVQL2RHVnlDWHRjVnlSUDZLLzQzZUsvemp4Sk5raHY1aEdNR25UOWpB?=
 =?utf-8?Q?dUprJ67anLEb7h33nyo13Fmwisr28Ass?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnhQN0ZlNmR0aHNVRG1NOUFpN2xlckYyS0hGZWFjNkJQazNxQm9VT1BDSWI3?=
 =?utf-8?B?RlFiaGcrOERmamFLNWp3NERnUGdCMm9HbXhCMW56TE1uR0lXQTlSSm1yTll4?=
 =?utf-8?B?dWphNjMxNnFSVStvT09aeVBSdVhKSTJQbW85VXhGS2dSQWdJM0J0eWRqblc1?=
 =?utf-8?B?dkx3OTFlbTVuU2JhU3VyWW96eEVIQUU5OGN2WG5HUkRRTFovaHgvZVR1MHpK?=
 =?utf-8?B?a3Y0cVJlWUxsNjBkTjBKYXFuRjVTRzhvQXQ3OUY3NjMxcmRudEl3YW9jbnVV?=
 =?utf-8?B?TFJtbWVkMDdXQVRJRFMwYjF0ZkdIOTZLVEYzL3MyM0orT2p0clpvbUhVRjNO?=
 =?utf-8?B?aHhJMWhCMHM0TFlYVm5HdXpsOUdjTGFtdlpZTTJCN3ZVK3pVaENuanlCRmNO?=
 =?utf-8?B?bXNYQzk1dmdPLytCeTFKeVIzSU1LaVltVEtuSlhGVWUrS2VxdmcxLy9aVm5w?=
 =?utf-8?B?c1g4cFFsTGk5Yk54SDlxNXBZQVdpaVJjQnRkb1hqbWVpaUFTZEpkRnJxWnJH?=
 =?utf-8?B?TkJrMFJ6eGJpUVFMb2hqWHZmSU1HSzN0dHI1c2ZBdTFvRjFSRHpzV1hzRk9O?=
 =?utf-8?B?ZG9wcVZpbTJnZ1YyazNMdkRoMzRmMEdOSXV0akJ0cXFCRmlTSHNWRzhOdXRV?=
 =?utf-8?B?dmZBZU9sdmE2OUU3bEttdHlwaTFWMlNZVlJicnlqaDhhQlNZWmpZT1IzcC84?=
 =?utf-8?B?WlJKcStrU1hWeVNVVy81Tk1jZWgwZHJGNjROUmcwVTZwMml0bmF6WDFYSjNt?=
 =?utf-8?B?U0IvVVhITXorSWVxZjRNNjB3ckFBN3BlbDlZWHA3UzlsYmRyYzNNQzNiWjNi?=
 =?utf-8?B?dWF2d2xESXRqRXBvNHlnbVV1VDByK1dwSC9KZ2xIak9id2pTOEx4WXV2dGRy?=
 =?utf-8?B?VDhGTDZQZ0lsTkE2OVRIV2VzL1dOa2V6M0tBWnh1Qmt1Y1lCbkRwWDNqRTBn?=
 =?utf-8?B?LzhUMDViSmlISXlRSzdtbXJMUHAvSXVwc3FPekhpQ2RvY3hLL2dvaSs5WHdy?=
 =?utf-8?B?OWkzZmI0QTR1cGxJelZUbzZxdU1VS1JLS1YwM1p1b1V3NU8yU0gzV0FkWUw1?=
 =?utf-8?B?VXU2WFNkcDE5QmprL0lwY2RndGRjSjZDZHBLYWRDSElVNWR3dnJYS1gwa1hO?=
 =?utf-8?B?TysybUlzSjhmdjBWZE9ZVmZnTVBRY1VWamp4dkpWMjJhd3NVQ0RDZ3F6S0xO?=
 =?utf-8?B?QlR2NVpZcmpvOEtpNkRqZ2o2cUhNN2VNU0ljeG9vSUQrZWduODlsUGZ3SEhi?=
 =?utf-8?B?b1JSUHFjcGx0RXlvTWlrc2dkaVJFOGx3eCszV1ZvNTdjOEpGOUJOQUFtQjFi?=
 =?utf-8?B?STNHdU9uTmJEcXprNkVhQTBjS1Q5V0tmWlFtZ3VGcEdhRUtuOXl5em1YM2Ji?=
 =?utf-8?B?VVBiN21qaXR4bHlaYVhibWQyWHFuL3pwdDlqRldSV0dwZlAzWFB4S2RHYXBI?=
 =?utf-8?B?OTl0dTVvVVpYUTBIWHJQZi96ODE2TWlNVnZMQVlzeU9pN0FIcUNvb1ByL2F0?=
 =?utf-8?B?VDRoZCtHa1J1M01JUzJpbmhNMWFMVkF0V2xNK3MvejJzNWVEL1d5WTRLOGtx?=
 =?utf-8?B?NjNYRFhodTFsbjJTS2hHMzhWTjJHcUFVcktFemNPSExBM0kvWExLS0I0L1VJ?=
 =?utf-8?B?NUphNGNUSzI0SVdRcW1lY3AzSnB6aWxQYm1GLzlwQldUakhNWW4zMWhBL2lC?=
 =?utf-8?B?dk1HZ0pPc3JpQ01rbkViUllaZGw3QVJUcFE1UEtsMDErRVlCOEY4bjV4ZFFu?=
 =?utf-8?B?UEt0MGRJekx4NldDVTBMcndRR0ZhcHJtcHZhcTU2RkNPRHp3OXQyaUk2eDN3?=
 =?utf-8?B?eC9KZzNMODRoMzBpYmhUWEdmMVJnc0ExUlR4SVFkblZTZU80RjFwT3lVdDQx?=
 =?utf-8?B?NFhVSzNDRnJpUU9ST2R0UnorVkFCc0JiSEwvcFU2YzhTQmxRajg1K2RvVzVi?=
 =?utf-8?B?aTRQSjlUSndBdW45VGtud3VhUFFmY2U4K3JQR0JWUld0QUhGT3ZFQ05zbzVu?=
 =?utf-8?B?SWptQUd3Q2lyRVh2aVVMZEhaNGVWYkcydS9reisyUXRlRGpxNjU5cXYzOXpm?=
 =?utf-8?B?RXhJZFY5ZFl6eXljU0RDM3pRQU5UckdjYnVuK3RXcWZiTWtKWC9WZUdwWTkx?=
 =?utf-8?Q?AEENa1W0RmOlV38b3SNP6t/NH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09796a8a-c5c9-4f42-3671-08de28639c82
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:35:42.8482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LeBvCg9Z9F2X/b30+cXbAnxOipUeHyauG+OOCrdr4xPUGodzjiuoNa4OY5woel+uLREQaGHP8I7HtZ8DFlHiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B



On 11/20/25 11:33, Mario Limonciello wrote:
> 
> 
> On 11/20/2025 12:03 PM, Alex Hung wrote:
>> From: Relja Vojvodic <rvojvodi@amd.com>
>>
>> [WHY]
>> - After the addition of all OVT patches, DSC padding was being accounted
>>    for multiple times, effectively doubling the padding
> 
> Can you double check when the OVT patches were submitted and if they 
> were CC @stable?  If not; I think the stable tag should be dropped on 
> this patch.

Thanks. I will remove the Cc stable.

> 
>> - This caused compliance failures or corruption
>>
>> [HOW]
>> - Add padding to DSC pic width when required by HW, and do not re-add
>>    when calculating reg values
>> - Do not add padding when computing PPS values, and instead track padding
>>    separately to add when calculating slice width values
>>
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Chris Park <chris.park@amd.com>
>> Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
>> Signed-off-by: Relja Vojvodic <rvojvodi@amd.com>
>> Signed-off-by: Alex Hung <alex.hung@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c   | 2 +-
>>   drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c     | 2 +-
>>   drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c     | 2 +-
>>   drivers/gpu/drm/amd/display/dc/link/link_dpms.c             | 3 ++-
>>   .../gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c  | 6 +++---
>>   5 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c 
>> b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
>> index 4ee6ed610de0..3e239124c17d 100644
>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
>> @@ -108,7 +108,7 @@ static void update_dsc_on_stream(struct pipe_ctx 
>> *pipe_ctx, bool enable)
>>           dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
>>           ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
>>           dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
>> -        dsc_cfg.dsc_padding = pipe_ctx- 
>> >dsc_padding_params.dsc_hactive_padding;
>> +        dsc_cfg.dsc_padding = 0;
>>           dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
>>           dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c 
>> b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
>> index bf19ba65d09a..b213a2ac827a 100644
>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
>> @@ -1061,7 +1061,7 @@ void dcn32_update_dsc_on_stream(struct pipe_ctx 
>> *pipe_ctx, bool enable)
>>           dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
>>           ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
>>           dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
>> -        dsc_cfg.dsc_padding = pipe_ctx- 
>> >dsc_padding_params.dsc_hactive_padding;
>> +        dsc_cfg.dsc_padding = 0;
>>           if (should_use_dto_dscclk)
>>               dccg->funcs->set_dto_dscclk(dccg, dsc->inst, 
>> dsc_cfg.dc_dsc_cfg.num_slices_h);
>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c 
>> b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
>> index 7aa0f452e8f7..cb2dfd34b5e2 100644
>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
>> @@ -364,7 +364,7 @@ static void update_dsc_on_stream(struct pipe_ctx 
>> *pipe_ctx, bool enable)
>>           dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
>>           ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
>>           dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
>> -        dsc_cfg.dsc_padding = pipe_ctx- 
>> >dsc_padding_params.dsc_hactive_padding;
>> +        dsc_cfg.dsc_padding = 0;
>>           dsc->funcs->dsc_set_config(dsc, &dsc_cfg, &dsc_optc_cfg);
>>           dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
>> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/ 
>> drivers/gpu/drm/amd/display/dc/link/link_dpms.c
>> index 1b1ce3839922..77e049917c4d 100644
>> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
>> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
>> @@ -841,7 +841,7 @@ void link_set_dsc_on_stream(struct pipe_ctx 
>> *pipe_ctx, bool enable)
>>           dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
>>           ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
>>           dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
>> -        dsc_cfg.dsc_padding = pipe_ctx- 
>> >dsc_padding_params.dsc_hactive_padding;
>> +        dsc_cfg.dsc_padding = 0;
>>           if (should_use_dto_dscclk)
>>               dccg->funcs->set_dto_dscclk(dccg, dsc->inst, 
>> dsc_cfg.dc_dsc_cfg.num_slices_h);
>> @@ -857,6 +857,7 @@ void link_set_dsc_on_stream(struct pipe_ctx 
>> *pipe_ctx, bool enable)
>>           }
>>           dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
>>           dsc_cfg.pic_width *= opp_cnt;
>> +        dsc_cfg.dsc_padding = pipe_ctx- 
>> >dsc_padding_params.dsc_hactive_padding;
>>           optc_dsc_mode = dsc_optc_cfg.is_pixel_format_444 ? 
>> OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
>> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/ 
>> dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/ 
>> dcn20_resource.c
>> index 6679c1a14f2f..8d10aac9c510 100644
>> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
>> @@ -1660,8 +1660,8 @@ bool dcn20_validate_dsc(struct dc *dc, struct 
>> dc_state *new_ctx)
>>           if (pipe_ctx->top_pipe || pipe_ctx->prev_odm_pipe || !stream 
>> || !stream->timing.flags.DSC)
>>               continue;
>> -        dsc_cfg.pic_width = (stream->timing.h_addressable + stream- 
>> >timing.h_border_left
>> -                + stream->timing.h_border_right) / opp_cnt;
>> +        dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx- 
>> >dsc_padding_params.dsc_hactive_padding
>> +                + stream->timing.h_border_left + stream- 
>> >timing.h_border_right) / opp_cnt;
>>           dsc_cfg.pic_height = stream->timing.v_addressable + stream- 
>> >timing.v_border_top
>>                   + stream->timing.v_border_bottom;
>>           dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
>> @@ -1669,7 +1669,7 @@ bool dcn20_validate_dsc(struct dc *dc, struct 
>> dc_state *new_ctx)
>>           dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
>>           dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
>>           dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
>> -        dsc_cfg.dsc_padding = pipe_ctx- 
>> >dsc_padding_params.dsc_hactive_padding;
>> +        dsc_cfg.dsc_padding = 0;
>>           if (!pipe_ctx->stream_res.dsc->funcs- 
>> >dsc_validate_stream(pipe_ctx->stream_res.dsc, &dsc_cfg))
>>               return false;
> 


