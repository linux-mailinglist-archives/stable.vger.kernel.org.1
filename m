Return-Path: <stable+bounces-109498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF4BA1663F
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 05:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02001886EA7
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 04:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1962C155A52;
	Mon, 20 Jan 2025 04:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HmPpUp4i"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE684A2B;
	Mon, 20 Jan 2025 04:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737349169; cv=fail; b=E6bzdpeKcet13certdCTH3TXljEEUGW4JJj0kbj6DAk+mMSnS55vSmXxqMX72vmx7COE5Q3908Uml5BB87REJOTOtm6TTXpXz4A2rR/A8c/jspPYK87S/bvWDDdA2y9lZ8MXdHG4c3VVZkAE5F9y+JPelj60aWLA6lNeHb7yhUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737349169; c=relaxed/simple;
	bh=eXiMe10K/uirvnDoVSGVM7jrNyboQ1/g9kvKU/T2wzM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fY5LUpPI05Nh8X4v7mpWAT8sVRxoUOP+eQybzZomPr3KvEgXPhvyX+qGg9PyUgkPQZMqfr2uuuKjn3G6fCxTOQbCO0YshKI+emZAhYPDNUGnGPWdVrD7PiYps5gMg+V5UOzBsoQ/FA9jue1g6I1TRiVL838HsYR+PnxJSLzwhMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HmPpUp4i; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghnBPg8cxLtt8ZANTCqEAW2RVMzQqRGv4h9EVwVyDBdwMdprPuDjHckk5vtzzWDRpDLjmen+g8Mbn8U/+RWDr2NQlE164Nsin+krZ/viz616e4qN2S+IHX9+njGr+mbtrSFPcb4BRj5+KBzVHN5e70RbKQNlRNXwPc6eqiQiF4jcssGOHtAybw5yFEdU0It9ZbxoSYqzvdO+hnMyvMLQ+OesJuXW11FEwG+ikZxG4JSjwdTW0xsa3/rRCyvRwkDObbsyJmWSjgs1SdAZLFCZPGlZsA8L2xiLr/fcvW9ju8/qp1o42FtmuE0ae1PjiA1noNNTWgeE7DbtVQ1Z62C2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuCbQ5GCmeE5afSiodl3TBS6dqiBtiOXMTGMb/AveyY=;
 b=H9ixpdschjRCB/lzbtimX9ZEk3pKsjxORE1jlWA+wblVh4Hi5pz+1bdox1e2KqbPeQ/xb6isWQfXUvJMx3JyXonxsC8+lsplrqg0U21iET/Lp6ymTrDdRZegFVb99yIwoClMHPOpHJHM0Hxx3QgDyruiJVL3ICXoG+LYbSQBzu1w3sFAQPNyI+d9Wbk3XG1v7TiBehL6XBtDA2+5eoyk0jn+q7mRjrOyaeNQ9Pr0lbum/Enm1C6U1R6AXy+nd7YiTxEm0E74WjppihSxm2JnUQTk7Lnp4/0Ejv6YhP9N2pYqXdESqFnM3ylS1QW7lqlBl699ngahm/jviZ2sIzZJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuCbQ5GCmeE5afSiodl3TBS6dqiBtiOXMTGMb/AveyY=;
 b=HmPpUp4iXNSZ5cUlQv6cT26kS3JMJce7UvXcmW0mDWSIVeYAgPK6x3vBibKQW4VtoCEJwDjNtO+1neqNOm0KCewAhUanBLN96ffdmreWXK6FRfCcN7KoPBO5+zTpn4jWAFehJljsjAh02cstcSEH66s5XFko8npxlYdru4qh7Qs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Mon, 20 Jan
 2025 04:59:23 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.8356.014; Mon, 20 Jan 2025
 04:59:23 +0000
Message-ID: <2fa8372e-41d2-4b0d-a549-cff9ab208bf2@amd.com>
Date: Mon, 20 Jan 2025 10:29:14 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH 2/3] perf: Fix low freq setting via IOC_PERIOD
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: ak@linux.intel.com, jolsa@redhat.com, stable@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250117151913.3043942-1-kan.liang@linux.intel.com>
 <20250117151913.3043942-2-kan.liang@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20250117151913.3043942-2-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd74277-b3fb-4a9b-43f2-08dd390f350a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFRVTlpZQlllOFROK1RiNU1lWU92Tm9vai9mR0ZwZG5GU0oxYjJFU0ZxK0Fm?=
 =?utf-8?B?WUxsOTVjOE5FakNRbVQvUHlRTWtGeUZqcHlwc2laSU9FQnY3QmRucCtNL3Qy?=
 =?utf-8?B?ZmkxSkhMY25xaFFWeHBsNjY5UHN6bS8valhEVUR1Vk9ETThaVzRXT1RVR1Vk?=
 =?utf-8?B?VUxaanZwYlR4S0UvRUt2UThWSURJOWExWi95eXNyOGtNYU5CbGNXc0RYRFcz?=
 =?utf-8?B?ZWZXRHRKazZjWG02SUtuQmhLYWlLWFgvbHJKSjVGdno2dUVIRVZMMkNUOGxC?=
 =?utf-8?B?ak90T1MybXdYSDl0clpuSXdFV0YyMjlWQmZ6NkU5dXZnWE15RC9WM0hTOUZG?=
 =?utf-8?B?MTBPczRDU3g4WGxWQzZyYm9kTXJSQkI5TnhXam85OHJ2NmQyc1V6ZjV3LzFD?=
 =?utf-8?B?K0c5VkpJQU83SldEN1hIam1OVGZ0Tis3NjVRVEJ3NlZlN1ZYSmEySitVd3Jh?=
 =?utf-8?B?TVovNFo0YnRLems2QUlCeFpoWklhYWlSckVJalJWV1VqRm9ZeXVNK3ByaFhL?=
 =?utf-8?B?NDBYSy9UdFdTdnMzKzVmRHhDODA4cW5NRVFnek9WcHRhS0MvU0VlOThxcU01?=
 =?utf-8?B?WmQ0QnUybW9Ma3VnRU01eHJJUWtRaHF1WXRaUHBxdXVQRm44TElJTXBqemtL?=
 =?utf-8?B?MDlpS3RSYnM1RWpjb2VIckNxRHpyTGx4bW50YWpFM2dnUks4NGV0eUFDNVNC?=
 =?utf-8?B?RHcxaHZBSXJsV2M2NEhmV1JVWEJON1dWK2dJYjEvcTdTRU1mY295c3diUlRT?=
 =?utf-8?B?RzRYS29LUmJ3Vm56OFZzZk9yVlh6ZXVxMDhlbWxpNDBkMEdxMWUyZXEyN0VK?=
 =?utf-8?B?UGxUTUthQXMyeCt3Z3c4dlh0ZE95UjlXaUJYMlVsUHZReHJNODMzZU9KaWs4?=
 =?utf-8?B?c1NjYytOc2s2enU0dXA0ZUlTTFp3emlmQUdubjRiNnlSOVFzaDQ4UUlBeE83?=
 =?utf-8?B?MVRldjZad2pxNEZKMnVidU0wOSszYzAxcmpCdGtNY2drSjhHU2lzMkJQMmk5?=
 =?utf-8?B?UmVZUWVJMUdQcE1zcUtBZmNCRnRTNU1UbDgxci9LMFpRNVNEZC9EZW1rWGFm?=
 =?utf-8?B?UEd2Z24yL1pVOVZJOWgvWm1BZTZKWkZ3QXgvd1RpVU1nZDFaTjZDUEppVXpJ?=
 =?utf-8?B?bmZUaFEwMzgzTE1iMXY1ZnlyaUliY2QxM2RLNTdnM01qeDRMcXFJZDNqOHk4?=
 =?utf-8?B?bVJWcVJDRHJhZDlXMy9QUGJJcDdNTlEwZ2JNSDNIa1J0Rnpya0xBanA0UlZh?=
 =?utf-8?B?aHdRMmxJdERLQnpOTm1ieUFPa3ZHQU1xWmJoK0hoUG5BdTJoNkZUSUo0WVJ5?=
 =?utf-8?B?TXNMYk1aaTQ5TVh1d25lYjlIMG5nQXZuUmI4UHVLSHVZT2E1ZWxjVjJidFhC?=
 =?utf-8?B?MUxsVk1jK3BJbEs2MTNScUhvRHhOYmFrL1o4OVhRc3Q4ZkVldjRyRThRcmhD?=
 =?utf-8?B?VFFKbTB2dnFZZ1ZjS082a1pvVmEzYkdnYlF4NHJFdXFMRGFGUzR4bDU4SWVh?=
 =?utf-8?B?b1VWMENaQkZKbE5UamhvcDl1eUh5SHlCUDZ0N3ZQM0xFYS9wRHVsclB3MWV3?=
 =?utf-8?B?VHJ4akwvcnhNYy9XNjdJOHgxVTRWSUdRSUtlcDlnTHFuYVp5bmRZa1Z2azlR?=
 =?utf-8?B?YnlMc1ZhcWRnZFFVcWFjNDZEcHk1VEx4ZHpwZ0RBVTRsQk9YczN1dUlhdVRY?=
 =?utf-8?B?czRCVldwMlFWdVBmY0hMalJncmJNUm9ZeGFUSFVFb3hMb0szU2l3c1lLck9M?=
 =?utf-8?B?Ykl4WWhuSk53NkFDMm91bnliWHB2alcrVC9xN0hvTXl2S2FLc3BMVnNBL0No?=
 =?utf-8?B?RWZLQXJ2SkJIVC9PYW1OQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WCtIejRMMG9peUFsUHN3T29WRGZ4Sk5MZUExTi93azZxMkowcHQyZStoV2M1?=
 =?utf-8?B?ZThEeW5DRWdhVkxXb2FFemZRaXhQRUlmbk1zTm84bTRFeEU1NGovcC9aTGg3?=
 =?utf-8?B?V2d4YjZueUNtNC9lMURWUDVVeG4waGlRcmFHbDJ1KzhXTmtwZEw2R1R2KzhI?=
 =?utf-8?B?SzdEKzVzK2xzOFNJdmNqQ29TQ1ZaakVzMWRXdWpGVEZ0R3Z4WWs0elV5VHNY?=
 =?utf-8?B?ZnlJNHd4Mnp4MjNIZWFRSHJKNWZXREJIeTRMZ3MrY1gzZDR3QXArMWJnMDhQ?=
 =?utf-8?B?bmVBS2k5MXJBZ1JYcVBXSFhCM2tOOVRXdGRiYlR0YWNzYUFxWHFkTzVuTWRK?=
 =?utf-8?B?Zzc1Vlkrc0RhMUlXeXdPcEt3QnhtcXRYMXZ0U25IU2REc2ZmNmlVNllISEM4?=
 =?utf-8?B?MnhPR1VHT21ibFN1TEFyblZnTkxWL3p1aWtDVW00aStoYmRaNHF0VUxudzZy?=
 =?utf-8?B?U2U4dmNlQnR0V3FOSVFlS1B1WERMMHNFMUxUZDYrVGhzc1BNUy9zaVJndnh3?=
 =?utf-8?B?VTRCOXRXUzM0VGpxVE5qaHpNWWxaU1ZwYjg4czREdENDZWFtSS9RQnpmSHdI?=
 =?utf-8?B?czJ0Zm5UaWhHRmNpSjhVaDRNaUhWQWQxSFlGS1JjaUVwU2ZNVS92TExHdHJO?=
 =?utf-8?B?a1ZhNjFyRU1WcDN3aE9Sa1NyWmovcnZENnRqZGtDRXlibTBHUS92MGZKYVpn?=
 =?utf-8?B?WFE1S1UxdlFua2dGN1ltcnNzanpYNXNqZ3d5Q2l1SmFZYUQyYm9BWndPek5z?=
 =?utf-8?B?c2JmcXhPcWpYUERnRjhLWUs2cHJPSmFUalIvNjdma3lLM0VkRUEweFNjYnY0?=
 =?utf-8?B?MVpzdXNNMTAzWEJWY2VtOEtRMGJJcHlKalYwL2libjQ3RnAwemx4OWxmZFhQ?=
 =?utf-8?B?WE9wak4vbmxpWUg2RFg0MHp3cnRrQnk2QklTYUNwNTRZalVxa20vc2FvWCtH?=
 =?utf-8?B?ek9UeGU0MjlQd0lHN0h2K2xwVTFsY1JjbXhGMkdLUDZhdCtEd3BNSk1NZlBF?=
 =?utf-8?B?SGNIZ09vamRicFV2U0R6MG5KZEVFU1c1bS9SdFJXWUJMN0Y1MTlJWGk2SGdT?=
 =?utf-8?B?NFdiMitGRDZDQlpPcDRmbnlKSDFvWDl2WGtZZml5L1daLzB2R3kvanJKNnV3?=
 =?utf-8?B?dm80RnY3dktJSGczQ2pTM3o4b1lSNGdhbVlzQmV4OXdDUmQ1Y043S3kyZ2dN?=
 =?utf-8?B?VjgxWmo3YzhTc2g3T1VnbGUvTTVIUW9aMkVJMzBpcXFMbEZnd080b25sR0xB?=
 =?utf-8?B?MmpHQUYzNDQySFczNU8zN2tqUllLOFJEb1cranZRNU81UDRodWI0UnMzZlZK?=
 =?utf-8?B?bk5BdVBZa1VRYVJ6cGVpVHBGek9ZZ2xTSXIzZGhXVXZFaDg1TCtKSEczYkxp?=
 =?utf-8?B?SVBwNzFCMWFkQ0hkQ29ZMkRsS2VobG5iL09acUlaZTBJVEVnUEVjYmNKT3pO?=
 =?utf-8?B?S0NNTTV2bEJPc2w0M0pmU1Z4RmZPMFh6UFFmd3F3SmNwOHpxM2JJaE1IenRq?=
 =?utf-8?B?bW81dnhkQ1NZaGROZXFESXlCQytqLzgxUnVib01nY1JWOEh4ZitxaExEVXU4?=
 =?utf-8?B?YWZBdTdFeXRsQ3RCRUUvWEl1Y0NQaDhCK1J2MFdlTm51akcyZjMyTXNrNWJm?=
 =?utf-8?B?QlVOMHZlOTdsZ3FTOVk1cEYrdVlHdkUvVEFiYXp1ako2SVQ4TEc3d1luZDJF?=
 =?utf-8?B?U2c3UW9tQW44VTRKSFpiV25rc2pTa3R2QmRsdXhvL1RBL2FaSnNsNUNYeFg2?=
 =?utf-8?B?SmZXcTI2L2I2RXNNTzZweWhLU3hxdWZ2bVhmZkxGTUdWdndhS3RoV2lPUkpH?=
 =?utf-8?B?VFlWUWJ2dVdEamdjOVd4eHNiNjdzWVkzTytUZkNndVNLRFNNSE1pSDZNbldu?=
 =?utf-8?B?S1k3NFhDL2IvNkI3YVhqdFlrZVJpWVhxdHdwbmJrbzR1eElEZHVuTWxBVjlC?=
 =?utf-8?B?K1JzRm94SE9iN2c5WGRSSEVrd3J1STNKY3BkWHBxOHFaNVBzNmp5Y3lhNGVM?=
 =?utf-8?B?YkMzVVd3N1pGYkRpQU5LbFdBTXUwa2xZNERCZXBHWG9YY2UyR3VVWU5XVDNj?=
 =?utf-8?B?SHptRXlLTDZzQTVCN1FuUDFRU090TGdsNDVVcVhyMXpkQVg5U3RWZktteHpT?=
 =?utf-8?Q?FA7jYjf8IXLnYs6yL4wneVhpa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd74277-b3fb-4a9b-43f2-08dd390f350a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 04:59:23.7265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWPBMM0Q52D1MlEdQPzpMUESIbCNLoaHaAm1rK9QeljYDkAUp/7WA1tFTCcCGC410bICyq3HvhDfOREoURjptQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188

On 17-Jan-25 8:49 PM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> A low freq cannot be set via IOC_PERIOD on some platforms.
> 
> The perf_event_check_period() introduced in commit 81ec3f3c4c4d
> ("perf/x86: Add check_period PMU callback") intended to check the
> period, rather than the freq. A low freq may be mistakenly rejected by
> the limit_period().
> 
> Fixes: 81ec3f3c4c4d ("perf/x86: Add check_period PMU callback")
> Closes: https://lore.kernel.org/lkml/20250115154949.3147-1-ravi.bangoria@amd.com/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks,
Ravi

