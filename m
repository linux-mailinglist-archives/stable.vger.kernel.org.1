Return-Path: <stable+bounces-83291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D37997AC7
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 04:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B3A5B21A1F
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 02:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA811885A4;
	Thu, 10 Oct 2024 02:53:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B4513D8B2
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 02:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528830; cv=fail; b=soUyLlyX2oxTMaXk4DTH3H9xjDZU8tOftFKYkpL4g3FyO6CZvN2SyzirLNkU3wO0WqPrOFyZcYmR/g8uibHn4PA1bxuqO+S7XiqEH9ONkD/cLzFB/OsJaq4Bsa4IvWW/mEeS1wtIkprgo7AkHuMML/Q5asMa2IR9fZaUZ2fIvVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528830; c=relaxed/simple;
	bh=NWWx2QieQGCGvxUUTIm6mkgtQsq0sLckKUFH8I5SprI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oOa1iDSrZ0SvEOmE53APRBPlFqjFw1YgQQfNnm1ve0gMXt1Wl7KWnhTzo0ZUMXPsN2It0dPKAUO5B+miU0oJ5QlxShua+VSOuxryIrvZC/9mIKmxb0sjtIFRtUhC8Wlntyg8tc96haAYzI7InYGIsauoWIE0Bs7aYI3kyfL6DeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A2JwFb023173;
	Thu, 10 Oct 2024 02:53:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 422tp459d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 02:53:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ls69BkGTOEm/+T1surSmylMrCzZ+drkf/1edhUZExiLRANrmGitw4U+LhEA89zMQxusTbUzZ6ktM7EHTWbaYNL2Xx8lTcGPOPUHrb4evcGjLxrg665oweD/WW+B++5B1QDfSLEY5wTyc8I6Dk3ZVjeYlswC7GQ+ypJa75jQZFM7Ci2/osiQFEpostK3npH/AiaceknzMrrSo4aK7GB3czYliG731AFo2Ls3La5htzVtYw+DjirIkaWSl22OAoxG4DuICBoNv31GJP8tKJ2yoW3b2TscYYPGwAtmo27t14dIE0ZvBInYGaWC8ppAblzQc5b+NilfVDSPeNYqTJjGGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFuS9lk9M43yosiSsVD6wgRZnbkdsra5oh1ie+5yRdM=;
 b=cBI4bP0Fq5kZeVMtFhXxqSLtyT7xDV6szR2A21cJI7EGq8YXPPj6dsC+BMQfYuraTnEkVdTv5JGoQwREDeNK5QeuVAHiBWrUNXmeK3HRU4SPU/bf5tuQ48F6s07Zxgpa6rOB+fodSbSgV0lqDPDQCqofthLIQqx/nv5piOM5NF4m96P5vOS/jsh4bVa8Mkd/McIyoukK/CNl0V+feoYsotul03aIDdRQglwPkKjJ7z6EZZBBKKXNVT/fBX0rqlUHno5ILkGqPaCly2LY4ypcgYMypzCXKoonXGr0/FJ1lSGP4a4eQjPmJ+ant3Srhr6n/kGKF4YRk3zxNhAQKsbMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CH3PR11MB8362.namprd11.prod.outlook.com (2603:10b6:610:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 02:53:37 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 02:53:37 +0000
Message-ID: <7cc2aa37-d7d0-4a46-bd9e-cccc03a2d295@windriver.com>
Date: Thu, 10 Oct 2024 10:53:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1] Drivers: hv: vmbus: Leak pages if
 set_memory_encrypted() fails
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <20241009081627.354405-1-xiangyu.chen@windriver.com>
 <2024100900-lavish-implosive-4107@gregkh>
Content-Language: en-US
From: Xiangyu Chen <xiangyu.chen@windriver.com>
In-Reply-To: <2024100900-lavish-implosive-4107@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR0101CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::27) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CH3PR11MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: e27fad22-0581-479c-13cb-08dce8d6bd08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHY0Nnk0WUVDbis3QXRWejhNUmkzRSt4NFlTdU5NanB5OXFMSTQ1L3l0YWlo?=
 =?utf-8?B?RG9yZWFJdlFQTlRiZFVwdzFBaWU0Z2Fld1o4VVBiQmtURml4NE4wbFdVR3lv?=
 =?utf-8?B?NEt3MmJIZ2RTeHdZQ2dkTHY3TWlGc05pYkFaR1V4ZWxyYTRnVjhMQUhwS0dH?=
 =?utf-8?B?SVRnYmd4Y0NNSkR0S2dvYjJWRTZDUlRHbVRFcnZKUTVkU2hkbGQvcnYxQnl3?=
 =?utf-8?B?dEdqeUc0VnpvcnhoVWFJdmMyYnU1L1ZKSHVRRXIrcWlqQmo3d01KOUJoV1VB?=
 =?utf-8?B?bHErck93TncrMlI2TmRzbStkWWhKS1duOGMrYnozOXgyaUt1THVZdW5RSWd2?=
 =?utf-8?B?eWZKTWJzblliYm4zNytSblJQVmpNbTZ2TmNjZXNxdUVxTTFtUTByUEF0dFlO?=
 =?utf-8?B?MFZJN0RvbGh0SGliYVVMeTRQMFM5eGJ5c1NLNjdFQ2o4RlA2OEJUWTQ0U3U1?=
 =?utf-8?B?c3plZTZ5S1JPaUw1ZkRJOU53VkZqZTFXY2lGKy82eHpUT1VUZE56NEZSOVlJ?=
 =?utf-8?B?RmFERU9vaFpRTkk2TEJlOVo3R0dYcVVKZkQ2Y2llZElzMUtsQ3Fub0hqUVR2?=
 =?utf-8?B?U1dSMGtReWxJUEF0SFp3SWh5TWQ2S0o5ODErTjRMRHo5NGVITU15TEd3UnFP?=
 =?utf-8?B?QU5GdmJxTVRzVGFKWW8wUUxpMDVuNkZodVFVNGVJMG9RRkVycktuZldmRWpC?=
 =?utf-8?B?SmxCUkRQRTljMlFlbXcxcUorQmpVMkxNdU1jb0ZoVTV1SWhMU3hudlJaQXVh?=
 =?utf-8?B?ZStIVXc4MkJoL2I5bVdCNFZTb3ZXZGl0bUt4SU9UajhSRTd5MEpNTW82ZkEw?=
 =?utf-8?B?THQxaEx2L0d2L1prQ1FISmtoNlRRSnJiNDByU2tSb0daYkdqQ2syWndoUkRo?=
 =?utf-8?B?Vy94VVM2anNyYSs2RExkQm9kTDRiNGRSRjFJaFNRaTVPTy9QZVVMNml0M0Mx?=
 =?utf-8?B?TzRLRklaSVl5WTkrRmt1R1oxdEh5TkZhZURwMUtOdTluZlV2Qmc2SkVLbHhu?=
 =?utf-8?B?UnpwM3ZvRmhSdHNRNW5ZRlkvbkI5QWRySmlzcXJsOGlVaGJXSDRkaG9TQU1D?=
 =?utf-8?B?OVZIMDJYUGVWdzh4NmI2NjB3Y2RZRWtJOHpUNWZUNVFDRllXd0FoUHl6bXda?=
 =?utf-8?B?UEUvYkN6Q2lqMldyT0cyTm1qNXc3WnVUTUUyZUNDZXNXSUsxNnZiVExxL1k5?=
 =?utf-8?B?MVBCZWhIclFlQWVjNXB0T0cydzBwcmx6ZnRKM1hUNkhYa1BEdFRQazZEZVJU?=
 =?utf-8?B?alRkSHpsT0pCQmpVaC9GWTBDSFp0aGJscm5QdjNSaDRpSHZRL0xnMkxaZXV2?=
 =?utf-8?B?NTlsTit2MDVjNjVyN1ZRSVlWS2xMaUh2M05GZU1Ed3VqVzJZVFViN3NmUjF0?=
 =?utf-8?B?OFR4ZTZMTVpadXNsRi9GT25hVktSdk13YXJXV1F1Y2p5UW9EdkhlUUlid3I3?=
 =?utf-8?B?VFJCMjF2WXEwQndUQ0w2dlBrQkNOQStsaXJET0t5UGR0djFqb3lqN2VWN2Ux?=
 =?utf-8?B?My9JVHFiY2sxTGxJeFlWb0taNXoyU0JSaXJMRmkvVWhIVkVTRUpwNzlQMHBI?=
 =?utf-8?B?dUZiaG5VWWtjQ09rV1ZwbmJSclZ4eUZYVFF1VW1mQnkrb0pIVTdwRjY5YzZa?=
 =?utf-8?B?b3kvQXozT1NINXhzU1V6dWE1aUNtZlc5UnRqMmVnZ0h3SEJvaDgwQ0dJRVRh?=
 =?utf-8?B?NU4xYnJEUWpheDN0N294aE9ieWFtc2V6RFF4VnRTTnlsbVo1MGlBWkJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzJzZVcwZWpnczhhYUlFRmpGV1dRcTFtWGdacFY1WnVjYkp1QnNWd0Rjb1Nu?=
 =?utf-8?B?eHZsSGdHTGtBZkRDcytQZEhrWmNZdHFvZHpQRVNybzZ0MkNvNllHN3V3NHBB?=
 =?utf-8?B?RkdVSS9YdlU4UHBSTmVBRmsyRDJ5MzFBN01TU2dlSXVIYzZUaUsvdjdCVjAw?=
 =?utf-8?B?eHVOQVVXVEU3SXhTYmRxNDdXNmhLRHVIZjVIUWkydVQ2M1ltZmJObDdmc1lj?=
 =?utf-8?B?dVZCWDlTbGFFQ0Foa0c4TlMzaGd1ZGhncmx2cXNpZXVkWkZUYzNnOVo1TDN1?=
 =?utf-8?B?WTU1ZUx3dVhPRERmWkZPb0NjekYrN0piRnUrV1J6WmF6dFExc1JhVlIxZ1BJ?=
 =?utf-8?B?UDlTbjJZK2Y2djRBanE0NHZzaEdLY1NLZm4zNnZNSXZ2ekdmK1BZbUxIS2FP?=
 =?utf-8?B?TmFsWWsxa0R1WUczcVNrK2RsQ1pLcm5OdnZTSHdTWlhabWpJcnVIQjkvcE1j?=
 =?utf-8?B?Skp4MXhNQkxQY0ZzLytZaHNjeEJJa0xrU3ZWeWQ4MEducWEyZU91NTRBMytQ?=
 =?utf-8?B?QVVVOWFCS2FOb0hPMWJhMEF1ajh5MWFlWFRSVDdHTG1YZitYZXRLR0FyYmlo?=
 =?utf-8?B?cXBRSUxhTHlNRFppVTJidk9BNXFuUUpzS0l6aklSK3VHWGw1azI4SVE5cUZL?=
 =?utf-8?B?MkRmeEpjM1RkUW5CaDhFcEpMdE1vdGRQKzdlS2R4b2N0cG5oR0lxZVlQdzM4?=
 =?utf-8?B?MDVzdUZSNmVoZUlNUTlkSE1nblZodnlWL2U2Y0hkSCtSQnNOV3k2L21KVVE1?=
 =?utf-8?B?ZHNSNk1JVVB6Z3hBYWhuWUtzdks1MTlua3VZeVVHbUFvazVCS0drQTZKaGQv?=
 =?utf-8?B?TDRrcUJNczFpWlk4OTZwWVFjWEUxWE1JdDNrNlNQMENXR3pFS0lYVVdZcGJT?=
 =?utf-8?B?ZHNMUmVNVW03R2J3SWFLczFHeFdML2hNU2ROakdWUEtmUzhDbSt5Q2F5ZW9X?=
 =?utf-8?B?VlN2cVdGVGc3S25XR1UwcS9RZzhpRnZ4b3dGNjNoVml1YWZlKzNWdHQ5aits?=
 =?utf-8?B?T0hDdU1uQ0c4aTYxejI0cDVpeDRNcjJsMnZXREpKaXJYWWNLa3dLM1NpZFQz?=
 =?utf-8?B?NkpQenRjUjdkNlAxb0pNdlNpZmJJclNZaTFkWVZ3Q0FSUFhKQTl0SnMrSWZI?=
 =?utf-8?B?YSsxa0xOcUVoSDBnRUJKWWh1UXd3MnpGSm5Ea2d0UjR5VnYzTFB6Z29pYWZD?=
 =?utf-8?B?N1VQZDhyRmpRNlQzek85ckpBSVYyc2xPbU1VY0tnV2RsNHN4Y2d4WXIrdllS?=
 =?utf-8?B?djcyZmxzNXhBYlZ0a0FqeHJOeFFDaHZabzl3M3VIZlBNRnNZSGdZYks0bzBn?=
 =?utf-8?B?bnJUaVhLblFuYTVId2M2RUFmeE5nR0JrNzhwa1g1SzlURGxwRnRNWkRwVW9t?=
 =?utf-8?B?S21rYmpDYzBtTjNWL0RLVmZ2aVVnRGdTbFdwNGF0U2M4YUprb2dMMnNNWWk5?=
 =?utf-8?B?cWVqWC9CU3AybmRtbWtEK0hRd3RXZ0FOVWs0TWE2QWp3RUtrQUIzVzQ0T1VT?=
 =?utf-8?B?bG1wT2tzSy94akxjYkFPVkFxemo1b2JPc1FCb0tERHREWXpCNW1HTXZsMUQr?=
 =?utf-8?B?L3k4WDJjUEVxMW9qdXI2cnMvdDRiT213TkRKbmprNkx3bERBUTEveTNDQkNJ?=
 =?utf-8?B?SDJicTRMdGlzbjBPS1RTQzVQUXB3TjdjWjB4MUhaSnR0NXpENmdONVpGdmdh?=
 =?utf-8?B?UWREczFYdHpYallaMWcvYUFnWG9EanhHZmE5NnVFbVVIQm9sUFE4V21aTjRZ?=
 =?utf-8?B?N2lLSUN1UUxGRnRYamlVRFBVMWMxNWVVRkR5bXZuYmZBK3JLMEVXZkowK0V4?=
 =?utf-8?B?Q0FRb045ZThQMFM5aHlXb3BqeTNZd2srSStOMWt0REZldTBoMUxHNjcxRDht?=
 =?utf-8?B?NFdYZ0xqUk9UYlc1M0VXMXJUODJweUxreUNMaWRLSENIUWVjTTMxc0VYeXBP?=
 =?utf-8?B?cXBYajNydzQ5NXpPSFkraDZNcUY2Q1dzUkJLT2RNUWFUYlBEb0pFdDZsZ1A1?=
 =?utf-8?B?VWpReU9Xa2dtM0U5LzB4d2ltZDVYQ1gwNHp3SXMyRlZTOXE4Q1ptYXdweWlv?=
 =?utf-8?B?SGZ3amljM1VyRE5GRTNybWxtWXFwQlB5V25qcUVFbjZnTk43VTdrTXVvVDFj?=
 =?utf-8?B?WXRPSmZWeWQrY1lMbGNoOWM0WkpmcEVmK2lWVm9XUVpubzV0cXRMcXhEUnJ1?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27fad22-0581-479c-13cb-08dce8d6bd08
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 02:53:37.3055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /aj+IgNQADeDKdjT6HpNCjXNENKskFFVEIvTBEsZsi0SDFtAt25WO+mOnptk846ZAJf0VkvFGpdfYPvlaPHlq1p0mACwSZDrVv1qDOb9SFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8362
X-Authority-Analysis: v=2.4 cv=XPtiShhE c=1 sm=1 tr=0 ts=670741b6 cx=c_pps a=/1KN1z/xraQh0Fnb7pnMZA==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=QyXUC8HyAAAA:8 a=UqCG9HQmAAAA:8
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=aXlCLAlfp_2NdpviTv0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 7k5xzShzEGB8DLYvuhtC7FAygZE97RRm
X-Proofpoint-GUID: 7k5xzShzEGB8DLYvuhtC7FAygZE97RRm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_23,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410100017

Hello Greg,


On 10/9/24 21:33, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Wed, Oct 09, 2024 at 04:16:26PM +0800, Xiangyu Chen wrote:
>> From: Rick Edgecombe <rick.p.edgecombe@intel.com>
>>
>> In CoCo VMs it is possible for the untrusted host to cause
>> set_memory_encrypted() or set_memory_decrypted() to fail such that an
>> error is returned and the resulting memory is shared. Callers need to
>> take care to handle these errors to avoid returning decrypted (shared)
>> memory to the page allocator, which could lead to functional or security
>> issues.
>>
>> VMBus code could free decrypted pages if set_memory_encrypted()/decrypted()
>> fails. Leak the pages if this happens.
>>
>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Link: https://lore.kernel.org/r/20240311161558.1310-2-mhklinux@outlook.com
>> Signed-off-by: Wei Liu <wei.liu@kernel.org>
>> Message-ID: <20240311161558.1310-2-mhklinux@outlook.com>
>> [Xiangyu: Modified to apply on 6.1.y]
>> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
>> ---
>>   drivers/hv/connection.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
> Are you sure?  This is _VERY_ different from what you suggested for
> 5.15.y and what is in mainline.  Also, you didn't show the git id for
> the upstream commit.


This commit is a fix for CVE-2024-36913,  currently, if we fully apply 
the commit, we have to backport the

following commits from upstream:

a5ddb745 : Drivers: hv: vmbus: Remove second mapping of VMBus monitor pages

d786e00d : drivers: hv, hyperv_fb: Untangle and refactor Hyper-V panic 
notifiers

9c318a1d : Drivers: hv: move panic report code from vmbus to hv early 
init code

a6fe0438 : Drivers: hv: Change hv_free_hyperv_page() to take void * argument

03f5a999 : Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails

Some of them are features, it might not be merged to current stable 
branch, so another solution

is modify the connect.c by manual.


 From the upstream commit 03f5a999(Drivers: hv: vmbus: Leak pages if 
set_memory_encrypted() fails) we can see that

the commit aim to check set_memory_decrypted() result, if fails, the 
encryption of memory state is unknown, so leak the

memory.

The commit modified 2 functions, vmbus_connect() and vmbus_disconnect().

In vmbus_connect(), when set_memory_decrypted() fails, marking 
vmbus_connection.monitor_pages[0]/[1] to NULL.

In vmbus_disconnect(),  checking the monitor_pages[0]/[1] is valid, and 
checking set_memory_encrypted() status, if fails, free and

leak it.

On current v6.1 branch, vmbus_disconnect() will free those memory 
whatever set_memory_encrypted() is success or fails, so we can just

add a monitor_pages valid checking in it.


Could you please give a suggestion that which solution is following the 
stable-branch rule, I will resend a V2 patch, thanks.



Br,

Xiangyu

>
> Please work to figure this out and resend working versions for ALL
> affected branches as new patches.
>
> thanks,
>
> greg k-h

