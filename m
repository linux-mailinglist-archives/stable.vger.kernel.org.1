Return-Path: <stable+bounces-83726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E038099BF5E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 07:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE5B1C21393
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 05:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC67F13B5B4;
	Mon, 14 Oct 2024 05:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xli/a8Pf"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3EB4C7E;
	Mon, 14 Oct 2024 05:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728883344; cv=fail; b=AYTG3MioDGBBJ/7m0xeKAgHLk4WPadyi38Jk95VcoMoFH5YdB4ueOjbM2QVf0oIl/2982071Sr+XovftjLSZN1sXfwNMPN1zW9HtwWWz+/F0Eic576mLeiajsuHPd/J+hV1ENNGWkzaVyXakzCinFs2Ot+vzt3FMkNyxRKFDTXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728883344; c=relaxed/simple;
	bh=v8qLkeAC98u2wT/5PnFfwLI0aKQiTYW9O4rdnJ7DoL0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RY2T6VFid1w2LfpJE7qj5UA5DZgBhvYl7Hceqwu5ezPRc2xWBS1RT/Ryy/bhrA2TF9vP7ob1BGs6E72jTkNaCIqSJ3WCy0k/nei2RkHDInw+J/zwUazMusvPWm5hc19Od9XKnBXdizyBCXAFg4S3WMCw4qp3cS5RBCRjyAW2V6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xli/a8Pf; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1pLAPG6USGB9Imo0pRhycTIuzP/NYMFvemsT9oXk48iSy/nVlOFX2rirOt5mntt5Xd/VbZ0dhWx1AG6VBSeE3aIkrC1dBZLzl1aQVR3bbKlm0xZ12HfPKf4D8NgUbxqPK3IEF198hmMPoB2gpKSwt02hgEXNnCPyoeH6kTjQ+CADwPSnwA+NJi4RMLKMeQSXU9FmzlyYBGflM0mmaPkUz1tjkxjssbQj01GkBej3nxsRgbvByV2vphcUK3+/AonHnM8y6HjNN3MW7hpLtci+fNnprk/saWcsJ4llJLC+Z98hlfAlY9FJD07WBJei+rXgQ4WNhxTDo3Q7ITNnIWJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kd7GGQ2dXjjMJK8Hs0JIC4d9njBeTFtVEZ+byFTUW44=;
 b=pI0cFUoxEmu5Yqk2g11ER9sS3ffy9vYJjqS1s6H0+kb4quqL1yYswqjp1rMDZQbcf1CuMD9k5vpuFzP4bN2oj1pseAnFVMPPTbkeCg6oKlo5Ikr4/xVU0HQ9YdaZavkOkKEQRMO0wBkkFKELpLYUXTRUOPkEzO/7PIyyLe7xqsw+TX/wETeg6I3vgQHBj3sUXxe07AtuP/+Pzct9B4qcMTPjrYlYtYxH9i4CxtleAnFC2ajgNwdTHq4Y2/Y+PupGxpz1/Z3qhnmBqzOOg6h4ndcb4zJ0qGuuDRNhaXGcyu903sx9nRUNG8Be9e7hAiozYjQW7JdJQB/ejvUgenJQbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kd7GGQ2dXjjMJK8Hs0JIC4d9njBeTFtVEZ+byFTUW44=;
 b=xli/a8PfPQJMW9mbH29lPFfj9i8aT6ZDDNY+omFO3KN7l7qnSxkfs47wbkOAGoUerfoaBcKIbbzT16HRSb/059yYrJ50Rd1CPGj2hK1AOVJgd0p1DDb8llfmlIRNY0TPGV6RRetD1Qf8lWhJR0TUUe3x/ggiqDtZhz2nsGwQoOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Mon, 14 Oct
 2024 05:22:21 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8048.017; Mon, 14 Oct 2024
 05:22:20 +0000
Message-ID: <f2c22367-b2d1-4ba7-8d4e-adc881dac96d@amd.com>
Date: Mon, 14 Oct 2024 10:52:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "cpufreq/amd-pstate-ut: Convert nominal_freq to khz during
 comparisons" has been added to the 6.1-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
References: <20241011001952.1647600-1-sashal@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241011001952.1647600-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::16) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: c6629f92-3cb6-47ce-af57-08dcec102d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzZNdlhVS09COSsrWFV2bkt5emkrTkNwenVKTVpQR0VKT0REWlVWQ08wVEZq?=
 =?utf-8?B?VmY0ZXZJUGRhb1JSYTRkZ25LUWd5SWtWT3dTWFJ4N3YyRU5UUGlFZFpzczNH?=
 =?utf-8?B?cW4xRUtMMG5DS0lPdVB0SDU3VUhHT0VwTkJBT0ZXMUlmY0VUU0xUQUNqQUtK?=
 =?utf-8?B?bkl1SFdWN0Jxck1qZGV6aklBTHd1dS9YMFVHb0d2N1JuMDkrMnJIaUp2bHU2?=
 =?utf-8?B?WHFVRmpma3VYeFZLQXpKQUY0N1RhanVoTDVZMXprNlV5cUdnOFpVQjJ5bU04?=
 =?utf-8?B?cUcyMU1ZRi9Vbzg4dUJoVUIzMlpmTVQxU0RpOUJDMVJuRXU4TTg1c3hqcHAr?=
 =?utf-8?B?WXBrSXd1RnEvYVp1UHozZTNHVlVUeUdDeWZTNmNXeGY1cnp0dUljZSsreVM3?=
 =?utf-8?B?YUhCS0NzVVR6OXk5MXVBK0FPYVh4WWQzd2FzNGxlL040b21FUDVVeDl1eE90?=
 =?utf-8?B?aUtHVkRCQXpBZkdHMkRWb3NYNFhRc2QxSGgrN0syMlNBaVM1TEJCTThNN0ha?=
 =?utf-8?B?bmdoVHd4NFNDWUcvenlyblc4bm1pTzVWQzFaK0dDZ0c2RjdvQjI1OUFkT3hw?=
 =?utf-8?B?MGRtRjZ3b1FBOTVOZ0w2T1dQeTQvenhrNXdZRlV1bXBKSDRXUzc0R2NBL05y?=
 =?utf-8?B?MXZMQUR1Q010NE50V0J3SHhZMGpaN0lSejErZ2c0aTUzcVBmNlhlK0x6WEpP?=
 =?utf-8?B?K1czWEpvU3dERjBIcnUvcHV2azhBS0J5Wmx2b2M2ajNXU3dMY21vYTJKZzZZ?=
 =?utf-8?B?L09hM2dlTVJWMHkzM0FUZXFQVi9HWnY5d3c2UnA3VHVUUjRJK0hYalIwNzVZ?=
 =?utf-8?B?dFR2aTlXTXEzcXYwM21ma2JndGc4OVUyMFJTVHpZNUZ2Mk8xN09YSTg2ZmFo?=
 =?utf-8?B?RjlBQkxZK2lES1NxQjQreit3WjBFQ0RQSnFBVzRSU0ttNWY0YndwOFZPZldY?=
 =?utf-8?B?SG1kb1B3SG9HNkF5OFMzU243b3kzblZpbFlKZ3FHdkpvZ211S2hjV0ZlNWlY?=
 =?utf-8?B?NjQ3b0JqMS84RjhFZ0N6VVpYejE3aW5hR2EyeFV5NXlvMkh5NVJ0cVRUaFFy?=
 =?utf-8?B?M2h1ZzBVaEZjeGx2RUx6bGt1QngzVER5UysxQzJtTWh1QlEzRnk1bnNEYVdw?=
 =?utf-8?B?dWJuUENjMEFHWVdDd2JYWDNKWWQyOXk3TFhZNUlqV1piR3B2Ui9TbWJhVit1?=
 =?utf-8?B?N0tLbTJoSkt4M2J4Nmo0bE9sYUVOSWR1ZUl4a3NtNGNIcHdUVmJxck8xbWN1?=
 =?utf-8?B?cHdvNVlucmFMdFRJbWxVZmxGM3JCbFdBT0oyUnFnNnA4L1B3S25Xa0V1VUtM?=
 =?utf-8?B?VGZHMnM0M3BiRklqcVg4WDUrMkdwRmYxS2dOZFNTWkcwYzdFcHhvZ0Jub3NN?=
 =?utf-8?B?eWlQR0U3VHNNZEhxOTEya3BkalE3WmVIbXNRVEI5cW8reUhab3dCNCtiSUZ4?=
 =?utf-8?B?WXMzeG1RMnJGd3dXd2h6SHhDZXRuYkdvTC84ZWhTd0dHSWYzVlBCK1M5WlpE?=
 =?utf-8?B?ZUh2WnNvc0pqRkxpTjZ6UjZWTEEraU50Y01rdE53c3VXTEwzRGxNdGhCemhK?=
 =?utf-8?B?Ti82bW1yRStldGV0T2lTR094b2VwMkp1UjZZaGNHTjMrVDBBdi9TR2J3dDF3?=
 =?utf-8?Q?4b95btapDS7RwnW5T+ffqN/gpM1zGlOY6ZPE6uA9UvWs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVVtZjROVnY1QkV1aU1tM1hPOXpIazdEU3NNYjYvMVo0Q1lweTJrL080UTF1?=
 =?utf-8?B?VEZYT1QwSGNPTkdkdFlWT2hXTjQwdkljS21PYWRTQ3F0RDBQOGwrUzNWWXZO?=
 =?utf-8?B?V1MxNjFXZVZ3blcxWnBidDd1UVhwL0RmSURyQkxBaWtFemZORjYvYlpOcm1n?=
 =?utf-8?B?L2sxbHg2NnpYdUo4cmxqOCtUTHRHZHZTb3lXZXN4a08xcm53UzVmYk5wb0No?=
 =?utf-8?B?YWdwWkUwSnVMRys2WW16ci95Z3B1bFpuVTVHTGkvRDVYTXZ1MytZYUlDKzhO?=
 =?utf-8?B?UU9FQncvd21IVWUzaEFsaXIxKzgrZnBuSURRdjVjR2IwVmR6eFQyVHNESXBh?=
 =?utf-8?B?VjM3R3MwUkxFb2lZUGtxSEs5VEd1YnVOQmcvd0VoRWd1SWY0RHlIOUNrejhC?=
 =?utf-8?B?eWNvb0VzczFDK1BpS3ZYUTcrSTk2eHVUdGtpSHZESFYzb0NvYlBhZE0zM3NX?=
 =?utf-8?B?R1RheHNsMHNxZ0lrczBNNEovYmg3bEE4TkFxZTN5MDZBVWIwMzloTElvWFky?=
 =?utf-8?B?Nk1lOW9Ed0c0OXZWcEhsVnR3MzFrbDlxM1VLdkNHeUVPaStlc0dQZ2JTK0o2?=
 =?utf-8?B?UU44a3hyNDAwY3VGYUlXU2hMTnkvQ29tQTM5K0lBOE90dDRZOHB1SnFBckQx?=
 =?utf-8?B?c0hlR0FSMVlrNW5pVHpFdFhQV3VETFhNbi94WkxIangvZUI2RWNISXNFSC9W?=
 =?utf-8?B?alFGL3BhWGowRkducC9RVy9xRU5BMXEvN2xrYzNuYTExbWxrSjJtVDAyaFNt?=
 =?utf-8?B?TXpna1VqUFpBZENqSGtyYTFuU0RFTWtEUHJRUHV2VjRGUEdQNzJVTGtyankv?=
 =?utf-8?B?M1BseUFicHNjOE5jSTdoUDM3a0h6bXVvWGl5UzVXS3V3WHpNOWhqdWYwREZU?=
 =?utf-8?B?ejVRbmplR2NMeUpVblU3S0ZvTTQyZHNRWDFlRW9MeWpxTTFZZGJrZmFOM2JG?=
 =?utf-8?B?UVZlekY2azZZWUg1ajJ3TTI0MHlORVBqcnhmMXJXZ01hY2UwTmtndFNJeW1m?=
 =?utf-8?B?dTE0VExqTVdrNjMzeFVXTTQyYWVFYzhacVM1MWNUNG10Z2tqVU04OGVtRTdp?=
 =?utf-8?B?cUVac1lzMGR5VEpPV2paRTJrWnJKckgyRVcyU3U2NitBSzNUWkZZcjNna3l4?=
 =?utf-8?B?b1lXV095QVhYbnQ5dTFSZVRTeS9EeTNwSklJanNFSDhmbVpUbGhVdk5nZ2Uv?=
 =?utf-8?B?emFTWEU3UGluQkloUUFQUGZkeGhMRFdLR3p0SndrNDIyVUZuQ2x2bW80elgz?=
 =?utf-8?B?VVE1TFZMNFlSTXVueEFVK0xMYUZhdTl6eEZTNFNHMFJ3NDlVOW1wQ3Eya1Ay?=
 =?utf-8?B?Q1loWTJqMjlUbzdscWkrL01MWGFDRlY3OEVjU1lGbW41c1lYNHIxWlBTQXh3?=
 =?utf-8?B?YTR6bXlVWXdpT2lWNlAwOFl0bitZSEtkMlN5bEpMT2hlOTJPR3NmdTVGalZG?=
 =?utf-8?B?NnM1aGFzYU5ZeVBUdE5zM29Mb3FUYkMyaDFjSU1HRWRuNFMrWXY1Q0d6b0dB?=
 =?utf-8?B?eHhtRG1MS2FrY0JoUkxhSndOSmlxVjdCY083UEt2SysvckYvdi96WDI2eWNE?=
 =?utf-8?B?bE5ka0p2NTM0OTdCc1lDVzRRcXdTU2NyME1odTJ1YjZMWEJLYUlsM04zN1c4?=
 =?utf-8?B?RW9weU1Qdm1ON2E3ejg0bU9jbXcrVVF2bmtFczdVbVBMQzAxeHVJNjZxM2VT?=
 =?utf-8?B?aEM5TDUvUHRQUEw0d25Ea3hjZWxreUgrTE9lTDZTajdiM2pvemxBSFY5dS9o?=
 =?utf-8?B?N2tWa3Jqb09jbTVZMldpVFQza04yd2oxRkVlb3FFLzZ4SUJ5b29FTUJZL0Ix?=
 =?utf-8?B?SzQwWlAyQUJhaHpZYnF3alpiNEovalFtMHF4MG01VFFNaEwrdWQrWWNPQXRT?=
 =?utf-8?B?V1ppNW5LeU5QTnpVM215eVU1R1lCMmVGUjdQbVJ2N2NJcXQyTjd6cW8xNVVV?=
 =?utf-8?B?RzlpSUlrWUZOdzlHNWNJZE4zRzJPTVpjRlBTOVBPa3RyTnUwbVBGQXhWTFYv?=
 =?utf-8?B?SVA0ZHp3TVp5MC8rNUlINmF5K1l6Vk1TVmNXQmIwL0JVRkVMeDBhVHVTekhR?=
 =?utf-8?B?bVNpcWNER3lFYmgxd0NjMHJYRTlGQmFZSlo2ZE81U3JLSW05TEp0VnNjb2pr?=
 =?utf-8?Q?LaTyEpEjOIPBxmP8RUpdblfyG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6629f92-3cb6-47ce-af57-08dcec102d74
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 05:22:20.8913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvdzDwcGOCberfgGUGsReWJBlhG5BtUeY8r7stFyEcNBl1TJz7DtAyzIDocJy8M0bD0oJnlNEOOhlTtWUX3Vcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754

Hello,
 
This patch is only needed post the commit cpufreq: amd-pstate: Unify computation of {max,min,nominal,lowest_nonlinear}_freq (https://github.com/torvalds/linux/commit/5547c0ebfc2efdab6ee93a7fd4d9c411ad87013e). Hence, please do not add it to the 6.1 stable tree.

Thanks,
Dhananjay


On 10/11/2024 5:49 AM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      cpufreq-amd-pstate-ut-convert-nominal_freq-to-khz-du.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit f73b7329361c75898fc97abd91c86a12bfe34830
> Author: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Date:   Tue Jul 2 08:14:13 2024 +0000
> 
>     cpufreq/amd-pstate-ut: Convert nominal_freq to khz during comparisons
>     
>     [ Upstream commit f21ab5ed4e8758b06230900f44b9dcbcfdc0c3ae ]
>     
>     cpudata->nominal_freq being in MHz whereas other frequencies being in
>     KHz breaks the amd-pstate-ut frequency sanity check. This fixes it.
>     
>     Fixes: e4731baaf294 ("cpufreq: amd-pstate: Fix the inconsistency in max frequency units")
>     Reported-by: David Arcari <darcari@redhat.com>
>     Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>     Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>     Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>     Link: https://lore.kernel.org/r/20240702081413.5688-2-Dhananjay.Ugwekar@amd.com
>     Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index b448c8d6a16dd..9c1fc386c010f 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -201,6 +201,7 @@ static void amd_pstate_ut_check_freq(u32 index)
>  	int cpu = 0;
>  	struct cpufreq_policy *policy = NULL;
>  	struct amd_cpudata *cpudata = NULL;
> +	u32 nominal_freq_khz;
>  
>  	for_each_possible_cpu(cpu) {
>  		policy = cpufreq_cpu_get(cpu);
> @@ -208,13 +209,14 @@ static void amd_pstate_ut_check_freq(u32 index)
>  			break;
>  		cpudata = policy->driver_data;
>  
> -		if (!((cpudata->max_freq >= cpudata->nominal_freq) &&
> -			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
> +		nominal_freq_khz = cpudata->nominal_freq*1000;
> +		if (!((cpudata->max_freq >= nominal_freq_khz) &&
> +			(nominal_freq_khz > cpudata->lowest_nonlinear_freq) &&
>  			(cpudata->lowest_nonlinear_freq > cpudata->min_freq) &&
>  			(cpudata->min_freq > 0))) {
>  			amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
> -				__func__, cpu, cpudata->max_freq, cpudata->nominal_freq,
> +				__func__, cpu, cpudata->max_freq, nominal_freq_khz,
>  				cpudata->lowest_nonlinear_freq, cpudata->min_freq);
>  			goto skip_test;
>  		}
> @@ -228,13 +230,13 @@ static void amd_pstate_ut_check_freq(u32 index)
>  
>  		if (cpudata->boost_supported) {
>  			if ((policy->max == cpudata->max_freq) ||
> -					(policy->max == cpudata->nominal_freq))
> +					(policy->max == nominal_freq_khz))
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
>  			else {
>  				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_FAIL;
>  				pr_err("%s cpu%d policy_max=%d should be equal cpu_max=%d or cpu_nominal=%d !\n",
>  					__func__, cpu, policy->max, cpudata->max_freq,
> -					cpudata->nominal_freq);
> +					nominal_freq_khz);
>  				goto skip_test;
>  			}
>  		} else {

