Return-Path: <stable+bounces-132898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0CEA9143B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 08:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A381D7AA4E0
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 06:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0C62063C2;
	Thu, 17 Apr 2025 06:41:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B77A94A
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744872114; cv=fail; b=DFSn5TlzoyKE722/1a2U3LrKptr2LvQGzNjBA3tqLjzEE6YQa4RijEUDApVdJzloRFfhVvrCJ144hM9oh8KZOqvj/+t9Ok01wJAKRNsqNheM+9lyzygOputsIFrCQtSruBpG/AxZF0tgLOhy4YLquRko045AgIM50Q+0QeJQN7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744872114; c=relaxed/simple;
	bh=8r4tVJRPfqfUEVt/4Rr2FB9VLCqYe5yFWhiYoT5NWTE=;
	h=Message-ID:Date:Subject:From:To:References:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=KYnerkGg5eDPXWWx4yfZC2v3ITGybTjGrGSHl4ZkeA5r/9Ok6qlXiqvHpfttoNkMw87mY97pz0mJ6xOSaW6Ro5HMnvFynaT+oWgr9X8F2MQ37P9Hn6KCm8mXS+2qmjfzDvaA8iG2EfkEEHZPmmlFz/h01UCY1azNRVpYOZRXi+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H60XQs002201;
	Thu, 17 Apr 2025 06:41:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 461u2ma5vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 06:41:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqJvwGbGmswN/TUEomlWQZxHEn9U6rPLt4A4iQQS3WOSdF0DPAVEMQ+rzjAlsP6lbpRob2Nh++dUqBaLk528OtyrD0n4zt9sCAWO1G5wQCh+q9lG68TVVZQ/BOvAfAWleOly+7cYlVmEmUbDSXvZLjw9S8trEAFsy/Vp3jmjOGj0AtYY0jsGTkPQsq62aIpjZ+C1HRGm42deXz0JnZ1owLnGCactWeQPexC5OnQxLgfcU7bBwtw5r/eTctx1BkcwSzlRPro+f5IRpmMisR/2FvLq5/IvDWjaNVdsY5U8fiwJ0s1SOdZtX0WvLg3wMikM0irmM7qJvPoSSFNTgqQT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rA5QidrIx+cZ2LNCV9GNGmiQmBu0FkxeRaArpnHgp0=;
 b=qCur0pXQocbymJUWFaAzoEKS93FJ36xB/UYbQ917XTs2paNBll6kUkjRY8ll19BS6jFJO7Qc2HJ33gsIEqB7UJ1u5gu+L+JYkvecs9rG78sNxT5l52VtMYbG7KBTz2mRdRtRFKCtvVcAxLGnwaAu4Dn90fub3ZZVZZ7S5zKmjjcYgYGSaIiTejDVoaVccRwxGmizt57rHss70fN26IIe9LcwOBR4sGLCBdDlmADGKo6UsCmwAuX7eEbPzZuObq4CRDLxpM4lu2LJGQAg0VaOsOMvc69qoUMbJrG5WdZtfAWEikrVzTW640LHjlbuJ8scspW2oE62YpYuoVDQQe0n5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6)
 by DS4PPF2F49754B6.namprd11.prod.outlook.com (2603:10b6:f:fc02::1a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Thu, 17 Apr
 2025 06:41:34 +0000
Received: from CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d]) by CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 06:41:34 +0000
Message-ID: <2072bb72-d855-4c9b-8c9c-bfeb3d79de36@windriver.com>
Date: Thu, 17 Apr 2025 14:41:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Question about back-porting '188fd1616ec4 drm/amd/display: Fix
 index may exceed array range within fpu_update_bw_bounding_box'
From: Cliff Liu <donghua.liu@windriver.com>
To: hersenxs.wu@amd.com
References: <92589528-1c16-4ab1-ab3a-82b0f67aeffa@windriver.com>
Content-Language: en-US
Cc: airlied@linux.ie, daniel@ffwll.ch, harry.wentland@amd.com,
        sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, stable@vger.kernel.org
In-Reply-To: <92589528-1c16-4ab1-ab3a-82b0f67aeffa@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To CY8PR11MB7012.namprd11.prod.outlook.com
 (2603:10b6:930:54::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7012:EE_|DS4PPF2F49754B6:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d5ef04-1ea3-4d54-d53a-08dd7d7ae516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnduRnFUQWhwTTh1MGhxRWNneDFHaERpL3BwSUE5eXZFMGRqMjh1OGJlVHdv?=
 =?utf-8?B?Zk5pYmRVZVFCWDR3aVZxUC9LeURhTmdBWm82UDU1R0g5SFF0Z3hRUFJvYmZG?=
 =?utf-8?B?Z3pDdElKeUVHQmlBbEtaRG92UVVBV2NPaDdhR0NYM3I0VFdSdk9zOHVXYkFp?=
 =?utf-8?B?THY0MVAvckY0YUR6cmRSUVQxY0gvNVB4ZjR6cDl1VFpROUYrUnZyUlArb05O?=
 =?utf-8?B?ZUZuVTlGODhVL3dZTHhER1N3YWZ6V2w1TUE3MFhORmY4T1JzbUorS2FJajNG?=
 =?utf-8?B?NjFxd0hzSkk3QkxuVmNzOXRWVXVsUW8rNzBLYW52emgyN0JvVnJqWTg3ODhN?=
 =?utf-8?B?ZE5wcVh2cWdRNk5ZcFl3bGU0MVV1ZXNsSFZ0WjFhTGVNcDRRZDZSZGhDVkly?=
 =?utf-8?B?UHQ4eGFGVUJJTDFjQzhmanU5YVpZZEZhbC9xMVc0R3hjcGc2OGN1V29Jd3VD?=
 =?utf-8?B?Uis4TllNcnRoL3pnUkIxUmpmeDdUa3Ixc0VHK2ZDYkVZOGZJSUZnVy9VUGM3?=
 =?utf-8?B?N0VLdnVhZ1FWRTJFUlRDMUFmYjhzK0JFRGgxLzNHMm9NWkdhTDU1aGRUeGdS?=
 =?utf-8?B?M2lpdXlJOVdkZDNOYmRuSUZxclluN0Z0VjB0N1NNVmNWNU1OUjZjaWw0MVVp?=
 =?utf-8?B?MzUwYUFmTzJJZXBuZ2xYeUF2dUV6di9oQlJIZmJIMG5ZRWFXT0MyMUxBa2Zz?=
 =?utf-8?B?UXZkQjBPZG9zTDBpQTV0NHVIcGNWcmRhQzV4ai9RdGdCa2sxbzhDNTdqN2lu?=
 =?utf-8?B?dEtoaVlHOVJwTVNWYnhQZStLSzNUa3VvZzdFeVZlTlY4b0prWEtyenhES2lM?=
 =?utf-8?B?RmljNXBCaDN2SHhMV1lQK0MwR3k5dUtEVWxmQytaOEtmZUphYitQUlZNblBy?=
 =?utf-8?B?M0xDQXRSa0pPSXNsWkFhWkJxZkxMODg4RGF3VGg5YmUwRnNiS2lBeFlCRERp?=
 =?utf-8?B?N3hMVThDWFhEUWdPdUxVRGl6RGljVTdtUEJBa3ppTm9pMVhCSHY3eURSUEVZ?=
 =?utf-8?B?N1JoRVB6aDYyUXMxZkRQeW8vTTZpZEVEbmRvUGtsOW9vdVVpOC9YbWZlTkJ6?=
 =?utf-8?B?bWM4cGozSFdCSmdvcUhkY2pYK3FUeXVXRVlYMUtia1RRM21DTGxWQldmcXZU?=
 =?utf-8?B?a0ZnRElpakFDc0pJUFA2WlNmYUdHcVlNL2hBbUpzenBQam5xY3F5MGtTQmlN?=
 =?utf-8?B?eC9iSnJIc3ErVmhCRUpyZXRqOVlKUVFKQi9XRXR0Q29iWDhpdjM0aXZMMGho?=
 =?utf-8?B?VkUydVZxa3NoNklzN1ArTkcvYmVGUGJmajMvM29TMHc3b2paSDhHWEVhU09j?=
 =?utf-8?B?STN3RDMwYXVWaXU5NzNjaUZjeHh1VVZCRE0xWmt3eElwL2JYTW5DMVU5NVZG?=
 =?utf-8?B?SEFqdHhtYXpiZ1RNdFdzWmdnUE0rRlk5bjQ2bnF1aWdxZUZrU0pRcGYwUGdG?=
 =?utf-8?B?NGpVaGRwR21DaXNDT3hONVQxSFpzT3hxNkI0a05PRlBPOUtmNUF1WFFWRXN6?=
 =?utf-8?B?dGkwVmlMQ21qRFdPQURyWUJEalJNWEY1VkxtNTZLUTV0NCs2WndjVHppQzR3?=
 =?utf-8?B?aUdrSzV4UnVXdGk3VUU4ZkhpTGxRWUE1YjN3bHphT25zUlFFTm5yUUFlRmRp?=
 =?utf-8?B?Z1FwcjdhZE9XRzlIU0sxNWZzdndNaklJaVJVS1BMQWpSUjlYK0x4OFF2dVdI?=
 =?utf-8?B?bStuSjBKajY3YTZQcTJiWCs3Zy84S1paS0w0RlUzUWRmeFFRVDdSSmpCTUFh?=
 =?utf-8?B?bk8xWnZmY2ZuMlNLekVIOTFCTXgrQTljMDFoeHFscnp2cTJCVHFUZzM3bFFr?=
 =?utf-8?B?TkNpVjRoYkxYdlhYcStSV0JJem5FeTBRU0NyYTRrMGQvMmJpVVkrVjIrc2g1?=
 =?utf-8?B?dzU4VVVOcjdxZ1l0V0FNMmdvaUJTR05ZM2NIVklaMHd6TmdEL0x3TUo3OUpD?=
 =?utf-8?B?MmZPNmJKMlp5RWVLV2d2WkFjZ3c5Y0g2Ti9GclFvb0d3ZUpNMlpRNUZTMS94?=
 =?utf-8?B?bjUzUzNkSFp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7012.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTFCamE4d0NQTjk5TTZQc3JCbEZnTEtPRnN3WkgyeUdFcU1zbXNVV2wvZmVD?=
 =?utf-8?B?SWJ3VFpWQzZaUFg3YnV2YWpRRTB1MzF3QjhZelBKTlZ1a0ExZlZuUmdpMjlo?=
 =?utf-8?B?cUlYOHBVcGkvTjlNSGFpamUxR2tVZTk1Z1ZjOE9qYXRkOGtNRmpYSnZPcWVV?=
 =?utf-8?B?R1FCdWh1bVkyUVZsL2h2c1lkTnpycm9kWXVRNjFuV1lGY1Y2UCtDUjd2L1hK?=
 =?utf-8?B?QmR2V0hpZEQ0aGFqakhOVW1DQ2lYNHlSTmtSUDBjWWJkRkRxV2JTdDBxeUw0?=
 =?utf-8?B?N1JCYlpRRGxYcVpEMUdaTlJLUi85NE5EV3l4bFJQcEtKcUpHcHUrOWswQWpH?=
 =?utf-8?B?NXlBUk1nMTZnWlFRZW5pNExla2R0ZlZKZ3FTd3crbTBkT09UMHdZY3hMK2JE?=
 =?utf-8?B?V2NtQkdwRmp2bWhMRTNpcFZpN0tVc0dvNTZEY25QSzIyUkt0ZUNUYWppYTlY?=
 =?utf-8?B?QlR0S3VnZnhEdDBUTVdEU3ArN1RTSHdnTytwK21NQzc1WkV1c2FVYzhYc0lj?=
 =?utf-8?B?cE9kVUlId015ajRIY1pXWjlRQ2FpTUJ3MDgxTFZGTjV2RVJvcDdhMTVZa1Y1?=
 =?utf-8?B?ZUtnMGxvcExtVW1Va1RTVHdZaTU0aXlITGI2QWN6SWZWZWJkVms5ckU3YitJ?=
 =?utf-8?B?WWRoenVjRHB2N21teDJ1b0J6bDFUcXJNbVBUc2lZN2o5OXVEOEJyMXh1M0Zu?=
 =?utf-8?B?dk9Kb2ZyRnpSOS9ZSlh0MWVCcE9ZNDBpUnJUTmdKTDc2YlVSZTAzOWRIVnpC?=
 =?utf-8?B?azZ0KzlQZzh2aENpVmRhMFczRnNScjVZQVZzY1FYbVVoTnJoRjcyME9PdlMz?=
 =?utf-8?B?c2JXTVM2YWtXczJNMGpINjZMb2Z6ZjVKZ0FZTFVJeGNBUjl5Y0U5VUVLajJB?=
 =?utf-8?B?REJ5aFBmY0RiMzNhK0h2K0txaUdNV2FkTGdmMWdqaWVjS1NaNi9aYlJKZlZO?=
 =?utf-8?B?RjFLOXRMcWVSaWNGOVMxUEhaMTIxUHhjR1YyYzN4d0RtWWhWQXV0WVUyV0Fx?=
 =?utf-8?B?KzA5M3hCSXhHSm85NkU1Q2lLNEl4dDhyMk9nQnByZmhPZXVsRmdOZ1ExdUxh?=
 =?utf-8?B?MU82QVJxdUxlWFpmT2NKNEJ3Sk13WjdZNjhPZURWVytsYWFTZ2k3NUUvY2FE?=
 =?utf-8?B?empIMTJiNW1tTjNCczQ2T25wZU9YZEovRVdzSWQzM2tPdi8yYzlRZ3dodEZm?=
 =?utf-8?B?M2ZndW5GY1dCbS80L3U0K3NoRzljaEJrZkU0RXJJdEtyeFFKalFtQ0NJNmVQ?=
 =?utf-8?B?bmp2ZkE2R1ZTRXpXQ1hhZitqMlVzcUZsRHI1aW5CSnRwdlNIN2hOVjVGNEdO?=
 =?utf-8?B?ZndIcGFGa0g4bVBIZ2o3RExSOVQ0OXpWNlNpWHRjYkRqTmVQblpMSUdXemxo?=
 =?utf-8?B?a2QyMklYa0czWU5YaHRaQ1JLQnFwTkhiRUdKVldtOWlaZkNRT2grU0Rma1Rj?=
 =?utf-8?B?UW94QUwycStuMUlxUCtTSTNBc0JOaW1tNXRkU2g0Vm01WHNObWkwQXNuWjZZ?=
 =?utf-8?B?Y0crTkZzaGxNZFhQenc3SkdqQWF2akRNc2l0WFlvMnEwRE50cDhjWGMrellG?=
 =?utf-8?B?VUp6Y0lEbVJyQkRKMjd2cThFa01PZG1mUTZtMVVzbk1RWld5SkVpZWpTZ1N6?=
 =?utf-8?B?OWl0OFdGQU5yRDlpMWtMRnFKelNOVVBZdDZHaDlaVGNvWS9HaE02Z0NYWDQy?=
 =?utf-8?B?QzRJbjVqenRBZU0weDNJRmFraWJIOE9TRzZIcUZRQW5MVzRxMlloalpnZ0tT?=
 =?utf-8?B?b0grY3FUMndHeW1RNmQ5cnplaURIbjdyMmVqY0JVak9TaDFLbi9EUlhwMVdK?=
 =?utf-8?B?L3R6YWIzSDIyZGpqaUZDYnlMVkgxdjFoQklxTjRqK0twNTNWTmVGSktQZEV3?=
 =?utf-8?B?eUNwQ2VoVWJKWUIxT1VESXVmM1EvSmNmWXVUc1RCTlI3Qyswd3EwTU5MQ05t?=
 =?utf-8?B?SjFyUGl0SjZuNUsyY0NWakxNNHNzTzhoZG1tVGVUNUczRVdaelpPaHozMEFI?=
 =?utf-8?B?dUc0azRXQms3dkJzTjZOUVF3dlJKUzFuS05JOVNNeDJ1QXo0dm9Va3FrSE1Z?=
 =?utf-8?B?UTBFQXNoMUN3czRvSXlOMFRMUVY0a1N0MnE1MlpSWVQ2N3IrdHQvZWRxQUdq?=
 =?utf-8?B?MVhKOEVTN3YwTkM5YkxWUXhvUnpoYjg1em5kQjhFbWh1T1BuazViZ0grelpy?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d5ef04-1ea3-4d54-d53a-08dd7d7ae516
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7012.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 06:41:34.2691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8W+oD9hnp56aNZl+rj30HysEdbWohs0LbbxWWIFYLjPYTIy4TYR1+yMq7W9ysNz+sHIWmHvdDtyt9fJ3b/PtLMTENtCjXapjtKHz/TB/Nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2F49754B6
X-Proofpoint-ORIG-GUID: ANeDMRNdblSEwm5GHoUNdZWj90_j8SjN
X-Proofpoint-GUID: ANeDMRNdblSEwm5GHoUNdZWj90_j8SjN
X-Authority-Analysis: v=2.4 cv=BaLY0qt2 c=1 sm=1 tr=0 ts=6800a2a1 cx=c_pps a=2bhcDDF4uZIgm5IDeBgkqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=HleGgbVjNiDpmu2vPpgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=877
 mlxscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504170051

Hi,

Could you give me any advice?

Any helps from maintainers or supporters are very appreciated.

Thanks,

   Cliff

On 2025/4/10 16:50, Cliff Liu wrote:
> Hi Hersen,
>
> I am trying to back-port commit  188fd1616ec4 ("drm/amd/display: Fix 
> index may exceed array range within fpu_update_bw_bounding_box")  to 
> both 5.15.y and 5.10.y.
>
> After reviewed the patch and code context, I found the design is 
> totally different.  All source files modified don't exist and there 
> are no dcn302,dcn303,dcn32 and dcn321  at all. So I think the fix is 
> not applicable for both 5.15 and 5.10.
>
> What do you think? Your opinion is very important to me.
>
> Thanks,
>
>  Cliff
>

