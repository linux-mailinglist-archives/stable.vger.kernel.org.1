Return-Path: <stable+bounces-83491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC68499AD1B
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 21:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E1C1F22957
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 19:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D421CFEB8;
	Fri, 11 Oct 2024 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4ZCWe3rV"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844EF19E998
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676365; cv=fail; b=a0wp74OcnTGmIVQXCmgnnYeAtsK46aQGZYPaHAyiyrkHoQaCGbrLk6DItl14j/D1WShMAUOgeNIqElRYOUKcd8mSN/DLb/oHrI/+S/oxYU/HPla1pTVY7SdfFPcaQRqytrmWIH50ppZMtXM8KADkQ7UQHq4p0q2x37UNOIGE154=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676365; c=relaxed/simple;
	bh=HiEJOwv5hfdKSKMk7RCkJT3Hd2aVK45mjGV19r4n25k=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=UPloTxe4CCM5wg+p4mpOSXUdRREdyFQg6y8oOzAJWe7l7OYzEW3N8W8SeKrNdh4YlTuLexfpfy/ZPvs+N9zIYeQPtQVmNQeP9XmfRuZaESdfap6rYPcLrb8X7q9O5XbJFdjnyz3sKY3aJHi2q6PzfVnni08nKQidL7UlMkI1dBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4ZCWe3rV; arc=fail smtp.client-ip=40.107.96.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4EEyCvo8CzFKoF1XkebHJlcUDmwSKSRDWDKIDI+7tKddPVNr29I9dnvZZS/hg9GK70ul5AoPBOm/8P9dt1z1sx5VfQLO7acYgkVrQDe5SWQ7vDn3KsaboDjKF3fMyinPn2JTN4Xt4wOpmdsj5rPcdEyLxi50RbV4ZK7fQUqIccYsEEbBo0TQaciIbxjsEvqWHmKNbjTJDOB9yrckdqP8QyCrhu2HiXewcm68LQElMi6LaA9pqZVnqbHA6Tk24TV6RXcjf09ISiz60KFghFBHSi2+/H09FtcFCVAY55Ov7dXGN9maLiAfWQ/0gowsIVbAYUHjo/7bsF2Ue5lKQXcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljh+C2zhpH8T0ts8OmC8m1Clyy1rwqajcBv54m85pqQ=;
 b=UwrSDP40EcBwnqxwJCHveam6C83wqfyuMZtvVQaArLj0dBaDLyYgcPLvwIeDhMUtu5SyQVKkAeKglGIZ6puGY6IL5pYeThSy5lyeKxavbtu7jJFaCV9ghcVxXKnk+3gtWLvmzGMQpAkjyK+18MSso7zACDnlIM/DfpOdlb8Mn3hrnZaE7YO+Peoj0l3nzFalV6REWQ/TrK507sld21rZSyQyko6V0fomgeJd3Z5s7pVs4Qvtwq5vifqqVQtzAzj2tJtx6PGTMHF44n2rbVaRgqBZV6QkpT9+LiQJIWvSt0D1iv9IhphXtckjkhXHGlb/L7LkSOWkECJrz+l363Rt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljh+C2zhpH8T0ts8OmC8m1Clyy1rwqajcBv54m85pqQ=;
 b=4ZCWe3rVqKyBI59/O9PuTGE6rZQPcj+lsEUKm+yj2xWeaBzsDBXMosqEGKfL49xB6zfec2O7wE+WF/aik4SJNyFcTTgI8qPT2kfuEBPbtTXmk8QkrNHILMI/nNmOVZGcFNpAjHOJdOvOwszJ2iP25y9Q6AeI1sVx3OFA/gcwG+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) by
 MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.19; Fri, 11 Oct
 2024 19:52:40 +0000
Received: from DM4PR12MB6253.namprd12.prod.outlook.com
 ([fe80::53b9:484d:7e14:de59]) by DM4PR12MB6253.namprd12.prod.outlook.com
 ([fe80::53b9:484d:7e14:de59%4]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 19:52:40 +0000
Message-ID: <9df38fda-5a39-485c-a9df-9e57f06d5a52@amd.com>
Date: Fri, 11 Oct 2024 14:52:39 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: "Gong, Richard" <richard.gong@amd.com>
Subject: Add commit "59c34008d3bd x86/amd_nb: Add new PCI IDs for AMD family
 1Ah model 60h" to stable kernel 6.11.y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::16) To DM4PR12MB6253.namprd12.prod.outlook.com
 (2603:10b6:8:a6::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6253:EE_|MN2PR12MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: 16935a12-fad3-4fc7-d3fd-08dcea2e439a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW5iQm1FTUtjMFBuaWcrK1piaVN6Wmk5YnFTL3pzOFlZUkRsdUFlb21haFV2?=
 =?utf-8?B?SGNHYVgrVFNjTUlHRDdzZ2FZR1BndzdvTFFvQUtoMWxFMTZGdTkrem5mRHJl?=
 =?utf-8?B?cHNXbXhYaVFNRjVBYnlldTBOdjVJTzBVU1ZyN2p3blYwRXR0NmpET2k2ZzIv?=
 =?utf-8?B?a2s3aG5jVC9rTDBEZWE2S1huQWhTRzdOM29JNFZJMVpnbHVIZ3FQRkZPT0xH?=
 =?utf-8?B?dkJnZWI0TW5taitSK1ZJV0VtSEUzd0hzM2p1a1FQeUNFMEtqWmZXZk1nUVp3?=
 =?utf-8?B?N0RNcVJacm5TOHZBR0ZnVGVjUUtaeno0YjBiRlYvakJLdk45VUsrSTlGcEcr?=
 =?utf-8?B?QlNMcXNRRmQ5dVVSZE53ZXhiUXdTTWgxd002RExYMk92d0tRN3cwejA3OXBn?=
 =?utf-8?B?M28yNXM4bVJQd2FUaGZmalFMOE5pMjF3akVsdHNSOUUycWp3R1R2NXJTU0hV?=
 =?utf-8?B?Ym11UlUzRU83eCt3eDFFOXVGU2YyRmMvaFp2TnNqTWM0RGtqZndIOWpTdk9E?=
 =?utf-8?B?d3EzUk85V3F6RnFFMVJRRVZvZmd3enFmbk5kdndSeTJTNkhoZUdyMllYSDA1?=
 =?utf-8?B?UHhWdzRkRWZqL0J0ME5hcTRQUHZ5MUlueEM3THFSZStTTGREcktoNitWN3BQ?=
 =?utf-8?B?VTZxNVNTRHB3aFZadWF2clNlb09WS292bDlzSi9mSEo2MCt5K2w0azUzVTl3?=
 =?utf-8?B?S0F3MDFkaUFEKzR6eC9JUjZ3WjhDN09IQ3hxUlFzUXY2SndsTGw4Z0d4b0NG?=
 =?utf-8?B?WWZzZGJhK0JuRk5VdXhGSEs4QUlYSHFYbFdBQU91RDczU3RjeXplbHdWRlJL?=
 =?utf-8?B?NTE1R3o1RTBldGVtS3NCRzNrKzJGU0xlS3V2dE5OWkVkZUF5VTVjUUJLa3hw?=
 =?utf-8?B?WHVjbm1YdTNJWjJqa2hNeTNvRWYwV0xTaUtxbEJKSHIva3BYWHAxTjRhejUv?=
 =?utf-8?B?OW0rdlp0Nm5MbFpnM0htVzd6NGhpTjNVSW4xdUZibFY3bjl0c2J6dWhKdExk?=
 =?utf-8?B?NzZnRW9mVFRQU1A4SzV0aWI2bGZ5LzJjbXpUQ01zdnlBdytKeHA5c3k1MzJC?=
 =?utf-8?B?M1N0RFlmZ2MwRWd3aE5pbmppbVZNK0JRMXZWN0ZUbjFidWRkUWV3RzBnZEx2?=
 =?utf-8?B?dm9tQXF4bEZCR0xvK0twdjlMM1Blbm8zaHlPU3RpaHNLdzFqdllNTnFzcmlz?=
 =?utf-8?B?SVBqTUtrZ1VJVEZ6RVVYTWRRUlY3ZUxxL1pFeEFWUkNvbzdLckRZOUJ4NU8w?=
 =?utf-8?B?ai93bFRjY3Q3aWw3NFZtMzNCR1piQUsvNGNOVVpKZG56eUhVVjQyT1lHWURj?=
 =?utf-8?B?bThZL3FlTVczcTdNTC9CMVBrN0ZJZk0vRHhiM1VJUHZ0dW4vN3RpbGgzSllV?=
 =?utf-8?B?b3l4RC9oSFU2czlQdnhGaFNvZ0t4S1FiSDJ6UStnRUZsZnRqUFpjdU5JM0Rx?=
 =?utf-8?B?RUp0R3NnODM0TWtCY09yK2VSMzJHYnNyTDZWSGEydWowNGdiaEM0bU1sM3Fv?=
 =?utf-8?B?dzl0MVZhckZjSFNTOTZzSWFHcHpmUWVHTDZrZG5MYlducGxzeXBWb2FnNHV0?=
 =?utf-8?B?Qzk3OXJtb1JBbjQrR3c1Uk13Kys4aXE1YXFWbzJGTER4dk1wOUhaWkdLbDcv?=
 =?utf-8?B?dnFwWmNNSHhkY2pYWjVXK3VjWDFnL3hHcDlIVGEwbGwwZ1k4dkJhcWNWeDhF?=
 =?utf-8?B?ZnRydWdNSlRCZmN6S25Wd1pTWFpYRTJydGdjSUNFbXByNjZhbnpQcXpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6253.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUN1OG5ic1BBR0JFek0wODBNU1NtZGEvdm1tazZFUkpLUy9HbGlTMitIaGRa?=
 =?utf-8?B?akIxN1diQ3B0eUlLSTB5K2pIUnIvVExmNXhPTkR2NlR0ODM0NDFCNkVoRDhz?=
 =?utf-8?B?SzgxQWI1Yzd1dWZkdzFVV29FeXUrMGlHOGNmR2NndkdQYmtGNVFQQlpOUWtm?=
 =?utf-8?B?dzJCMm9ZaTVRK0diRW44eXFWM2ZxRit6UGs5WDI3bXo4Z0cxNENlUjZZb211?=
 =?utf-8?B?alNXMCtVTno0Ym5wVURPd3hraTFFaXNsaHJNQ3ZxNGdISHBwZEljS1hQdHN3?=
 =?utf-8?B?bWYrU0pmdDJoS1djdzN5UFRHVEE3TDVLYzRrU2xjYlhYakYzVnFVUDl6a3Nx?=
 =?utf-8?B?bGlrbkxSYW05TGRxWjZPR0pkWEpoYUJBOFg1NkRSRVBBb25raWdQdlJiSW5E?=
 =?utf-8?B?eVpHVXBVMlRrWTYwL1pJODcyTWdYR3MrYkRTOVliVzJ1Tnp3MzVvMm40MlND?=
 =?utf-8?B?d1pidFltR2RuK0NKWFpsS05jV3M4MEk0MUhPTGowL1dIRWJtM0VlbmdaUGZB?=
 =?utf-8?B?ZmlLREVHQ3lqTG1WazBySzlVWVU3STdQcyt1M1BEQlZ6MWYxQlY3OVF6K2tl?=
 =?utf-8?B?SlZBVGJ4cnJkeVVLUzRjU1FmN0pDME00c2cxeFNISXdaMmliTE96aDU4Uk1C?=
 =?utf-8?B?RGd6Vm5lUHJ1d2F3bnVOZTZ0RE5ZWkZHeVA4bGMzWFhFNm9pdjh3Q2VYL0NC?=
 =?utf-8?B?Z2NuMjR4Q3JneExTRXpxMGNCc3NBQ0YvK0tRcmltR0ViWllPcFRHUXZ5dm9K?=
 =?utf-8?B?QW5PcnA1TVBWcVBpbWkwb09wK0hRdjByd2lFYWV5Vk9HamdtQkdrSjlJY3F2?=
 =?utf-8?B?N3hyQmVqamhqZ1F2QThOUkU0anhFL29HYU82VjBXOUJLUzBJUDRRWmFIL0hQ?=
 =?utf-8?B?NzhGQ1JyQ00yT1ZZeDM0UkpWeCtiSGR3TUUzQmJ4SjdqT1RMUE5uMHNNRzdQ?=
 =?utf-8?B?cHFRMFRHbUlRMHZBNDM2cURLcjYzZC9CamxsZlN1a2Z2WUFubGJ4bWQrUm52?=
 =?utf-8?B?SVQ3L3hpcjJtT3A1akRDSVltdU1GY3hKb1pjNTJTdFExSXZTYWxpVUlEb3Y2?=
 =?utf-8?B?TStsY1lQWFNhVjdaYllyakNEQmtFcmtQemN1NjUzbmpVQm1BSXRzcmh4NCs1?=
 =?utf-8?B?WVJ1aitxd2NFcW9SRGc3d2xFWGduWDdhRFNmV0VSckUvdFBiU05ROWU5MHgv?=
 =?utf-8?B?aFZVMVpFazNlQUJaY1o1KzFNckpvTFh1NnkraHAvek1kV09lVUxhS1E2MzA5?=
 =?utf-8?B?b0t6NUw1WTgwaWpQcHRMd0Q1N0ZNcG9FVFZlWXFRQXppVlRKL2YzYUtnMmhW?=
 =?utf-8?B?aTlBYU9xelROdDFUR0NEeXp6U2VSenFaQlhmRk1VOHQ3WHhtVVFpV01LR21V?=
 =?utf-8?B?alk0ZktNSStmOWQ3dDRBTFI5WnJPMEpBTWNaamFMV2IwTi8zYlpuUnAzdW5X?=
 =?utf-8?B?QVhFZ2JEZ2xURjhrU3piZlY3Rnh1ZVhTNU9PUlBoVWh4ZzNpTHR2KzJybkl3?=
 =?utf-8?B?VXhRV2IvZ2VmbkJUaVAydkp6cHZlLzhsZERBMjBWaFNOblovSVQ5TW4vK2pr?=
 =?utf-8?B?N2hVUzZ1THNocE4rUnMyMHdxeDUyZUhaZXNJVERQQWptSktYWVEwZjEvUmRq?=
 =?utf-8?B?WUczVDdJRGxlTC9EWXhhTU1HOEUxT1FFejFlM2NubDFBckNKTlVBZzd4YWFM?=
 =?utf-8?B?dkdFaWZ0UDhiTHV0Ylh6cHVzM0l3YUozMld4T1dMYlVPQm5jOHk5ZStoQ0hS?=
 =?utf-8?B?elA1Y1Q1NEdXeXhjQTZYTUd1enkrU1RVUXh6V2JEZlNnWVkyQ09WR1dxdmRv?=
 =?utf-8?B?aDU0ZW1TdGEwV0FJTzhadnZWcTNXUUp6OXMvR3lnUzJmNnB5Y0g1MVFFbUNQ?=
 =?utf-8?B?bnBMUUo2UmZTYmRGbFM0ZTBmd0g1cFM1a1pvaHNiZkNJL0pUcG4rWEttME1L?=
 =?utf-8?B?N3N1M2F6ZFM3M2IwenRyV0lZQWVNanMvMnNIaWoxLzlVMExwcjRSZjZoYVNh?=
 =?utf-8?B?STFuaUVUUExvUTQ0YlZ3L2VDL1dWU3duditodHBYRUlueHk0dUEycC9HZGFX?=
 =?utf-8?B?SWlBU1dlSXZKbDdYZ2FMS3Zaa2ZOUDRyaU4rYkgvNzc2U3BIRE11bkdBZG5K?=
 =?utf-8?Q?YCfxQ96gIGq+DkWCzZjygf6VH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16935a12-fad3-4fc7-d3fd-08dcea2e439a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6253.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 19:52:40.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJZfZYduGiUdxpmUBFv2lilT+qUezdZBamafzCqAJzfoErHdfVepXFPGNv5G8ow3P5wTXy8ar7NBAiwzly52ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271

Hi,

The following commit is to make amd_pmc and amd_pmf drivers work 
properly on AMD family 1Ah model 60h processors,

  59c34008d3bd x86/amd_nb: Add new PCI IDs for AMD family 1Ah model 60h

Please add this commit to stable kernel 6.11.y. Thanks!

Regards,
Richard

