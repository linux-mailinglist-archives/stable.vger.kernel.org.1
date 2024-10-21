Return-Path: <stable+bounces-87594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D899A6FEE
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 18:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC57B1F21EB6
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA621D0153;
	Mon, 21 Oct 2024 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3RY4IRvg"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2511DF754
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529033; cv=fail; b=VyLgfB2J+nu54b/yCiRbbtpqkriDe1qtzS5KbLHGI5tphBTdXg06505Bezv8Y9X3IKWvzn03jgptplZO0xfOH6bbVow0qNoNuRUWmSc5sZp9XS5Z9O6tudpQcno5Gz/3WLYveISdnglOC06ZrcgARQlhRCJRAzAl5YxLkTr5ask=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529033; c=relaxed/simple;
	bh=kvpsoKFWebFshbRxiOG3rW22T/r/q32lzQCXYBjxSMw=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=YPKlOW8M/dauc5G6LNqUvzAygsZ3FKbQAV0QTAfVgTZb+RV27RMclijobkE6r3lwd5K0Ouqyugvg6/GiUjFYAFhigjJudIxj0mXZedpIsy7i9b0mTFLD3Tk0ygBYbk8irvPXVhA5e76+MfIltpbWEgOeGI96ZY9cdmWTVJZA5TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3RY4IRvg; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYcwFp7GQyP+swS/1xyWxSiabhWDxpig7mkAUrd+FC7yVwl/6Qa9JVLu8ZXNGlO67Wt0oi2/pCtw9ChY+fBhLnp0+aYpLB+MrFb7uMxBWZX9Xy/DqilGNVBqwXfrzJduhr/ONbplYz/vZs55KcdT3LvclSLsbhuSkmRagyUUX8IUPMFqXB9JWdnq6eQwC6avNxZa8LHvuPux+r8kDjSfgqbOyRF+zojZhoLjGgs+gMS6ByjmvxOEpMv9OqKrFAtADA+DRnLEQJ30yAcFFJJNqER84C9V0EM1zcB2e5IUAxk+ac145R3CswTW1zxMUuHvxGCuI4o3t82dD2vCeih9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvpsoKFWebFshbRxiOG3rW22T/r/q32lzQCXYBjxSMw=;
 b=vvRBSxddoPqCSaRq35zY/NkAAcoDg8ZVQZZH/y8YacCw9tLK61rr62Eox55ScR6oXfj+hQoRHF77M8mXSMudq8flXYrwfxE/soOHgRAziBV/8cdmUD/ZWycvw5QZ1a3HW1eSw/qxq49TR8e+BLbnUHdhJRyOoSyPVkAcU+hKqUbfHKCmNC8DeCM83spLqTYCPGFkF5pL2lkN6BJsBBadS54ws+ISxBM7JNOespdSPOY4KfcUzdtB5XEfHkNd3p4FFN//WChGgKt4pOJ3M3VQx9Ve6yRezk4EXPRC4tyfkj0eooP3C0tZ6ZZFg+5d03JA2bA6L6JZgwFAork6lR/HbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvpsoKFWebFshbRxiOG3rW22T/r/q32lzQCXYBjxSMw=;
 b=3RY4IRvgoE/H/YM6Eldsu5RrJ2GaCqWENvUK50ccyAWwPcjLdShkv4XCDXW25BqR1L9oV1o2z8oXXxIu0aY7bMKlEp+UKpLqrQCbodjvJBuee40CedWvCBlOFTcar/yhfOetrZafWy8FzLckwznrHLyhxV2yAJru6YntlJlLqoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) by
 PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:43:48 +0000
Received: from DM4PR12MB6253.namprd12.prod.outlook.com
 ([fe80::53b9:484d:7e14:de59]) by DM4PR12MB6253.namprd12.prod.outlook.com
 ([fe80::53b9:484d:7e14:de59%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 16:43:48 +0000
Message-ID: <481fc86d-4ff1-41aa-9476-11be73e6cb45@amd.com>
Date: Mon, 21 Oct 2024 11:43:47 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: "Gong, Richard" <richard.gong@amd.com>
Subject: Add 2 commits to kernel 6.11.y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::21) To DM4PR12MB6253.namprd12.prod.outlook.com
 (2603:10b6:8:a6::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6253:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1ea70f-e5e0-40ee-ac37-08dcf1ef8930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVUybzZ3VEJBTXltakZqMUxuWmp0REVMZWwvb0lwSEY2dnlPcFFnZHdXckJr?=
 =?utf-8?B?elM3TXRtUDdTVTRBSU5UeEFEcC9qa2lSa3J4TjVZWG85ckVkRm8zR0lTWnUv?=
 =?utf-8?B?K3p6alJtREVjbFQ2d0NubC90ZjNXU0VjakVLcFpPaEVwbGQ3Q0E5MmQwb3lC?=
 =?utf-8?B?SFBHVm5PWkpNdXgyMHNueVNFRHpmYk5GRHVFMHlWb0xIVXQ3M3NkT1BTM1Qz?=
 =?utf-8?B?WGhraXd0SUVxYkRkdVQyNVJkdmVUQ1VTNFJMbCsvLzZiYm1oNUduMFEvcVNs?=
 =?utf-8?B?clo4ZXgvL3RRSXRVclNoR1V6ajNBZWtaSGZKMFR3dlBrQTkwVUp2cTR6TW1N?=
 =?utf-8?B?UFBQODlqVTREbEJRNCtrbFpTR1k0K0JtMTNNWHRxbkxEZCtxYlg3Ym1LMUNQ?=
 =?utf-8?B?eFM4cVJzaWhaQmNiZDFGZHFWWnRReVZFSHVTNTc4ZUpnZXBMKy9JaGN5MTlB?=
 =?utf-8?B?Q09vT0RiRUk4VU8xM1JUaER4elhOWE54NnpDVUs1NlZoVkJKRkRUUUdHZGxq?=
 =?utf-8?B?a2krdTFmMjI3WXpZK04rVTdoZGxHYkx6eE5FRGNJbVR6ckVXU3YrN0h6UUVD?=
 =?utf-8?B?WnhhMHY2L2xiUkViNHpVZjhNNks2Q0NQRStIYyt4MHBoWjNLVjVkTUttNVBq?=
 =?utf-8?B?RVN1elc5L3hQOVVJbEFHTmVTTjFwYnJnVTNiTzdRajlhL3E0dXMyejd0Nyt1?=
 =?utf-8?B?OXNtOXVxVm1NRUU4SXVGd0MyeGQ5c3NEdVNVbWhVS291cXhCZy9SakxMTGpX?=
 =?utf-8?B?NlMyMWhNZnByd1R6UFhSZVh2MnlTUGJsbmVlc2k3aC9ualJMeGEwUmE1dDZM?=
 =?utf-8?B?aG9KVTh3Nlc2eldnRE9LQ0EvMmhBNjYyL3JGVW96SHlMMS9aTHdBQWI2Vk1z?=
 =?utf-8?B?S3Q0ZEYrclVnMGlnMmoybUdZd0NBTWVyTThUQVdyQWZuV3pxZVdKa0dnY2N1?=
 =?utf-8?B?cmJTcEwxWmdRaU1qdFRTNi9hZXBBbzRiNXUwWWI0ZWZzKytXcnVLY0RnVnpC?=
 =?utf-8?B?YUE4WkN3dmp3NHVhbTBYR1E3VWdHVFFOZmVTOE42RjFCNVBPb0Fxai9aLzR5?=
 =?utf-8?B?RURHeVZzNFFaSDhyRFIzZUEyQmI0NHh0TTg3MHZtNHpFT1JMR1FkQXJDRlp6?=
 =?utf-8?B?NUFadkg3bFdXT3Fhc2pHdzErY1dPeC8rMUZtNE8wczNralcyTEpkTmdmd0po?=
 =?utf-8?B?cVZyQjNSM2Z6SWQyVEhvdmxHK0dYRkFxTHp2emY5aUlHWlhzTDhTN2xmZ2hk?=
 =?utf-8?B?UGhIQU5pUnBiaWZEUHNOSjhod2o4VTN5MEtGb253T0FIdGhHSVJWTzM2Q0Zn?=
 =?utf-8?B?WUV6V2JhcG4wcGhMaFRjMkxxMWxTVUg5MEZDMElyWllzT0VWKysybVBNb0o4?=
 =?utf-8?B?TDJwdW0wWXYvSlViUzIvOXhTWnRnc2RNazNxWms0OVpqUmVibTg1WjUxaXRx?=
 =?utf-8?B?ZFpaVHhDd1M3U2FLa09zMTVBZDdiRWF3L01jbVlFUGZHNk4ydVIveXhQeGli?=
 =?utf-8?B?RUtyTWhOWWZBK1JsSzdKSUozV3JqRlltSlMrQ0htb3NMc0tSaGowM3UyVGx1?=
 =?utf-8?B?RWxzUUZWNXNyN09JV3B0SzllNFdtZFpOZm5aZ0pyVzRpTzNQcFlmMFhqenRw?=
 =?utf-8?B?SmRKL2pNd0I3Mk1jWDNzTktjS2tSUkhlT2ErS1h5SXpHeW43VzVSYlVuUGgw?=
 =?utf-8?B?K0VRcVN4TkJ4OGg3KytLSTBzaXd6NW5NNzJzV2RvS1JlbTFmQXJ6WHJabmhG?=
 =?utf-8?Q?TJuPPnDR73uB1x/Futw8DqW5+N7wPZNSoUvlUY1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6253.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVluL2I5V3RESUhzYmFnVFNaRFlpSXRzczRlVk9zYVB5aUF3aTE3Y1NscnJp?=
 =?utf-8?B?dlEzUzhBclhLNWowTFVYKy9SVzJIT2NhMGVUdzd2N01kVWFmTm9NYmtHclF2?=
 =?utf-8?B?dHZHaDlvQk5WMW9UejZzUnVGYzhLVzdQdGRFNW1qWGpGeXgvdmV2YlRIbkIr?=
 =?utf-8?B?bTNZelZscEpBelJ1eVpJcWloKytvZU5COVBrWjRXb2xCMWlMcGkwWmlvRGt0?=
 =?utf-8?B?TnNCTHI4SmR5VXloNE8yUFhxYnExSDBqYXdZVHRCeFU5Um1QSnk2eUlLZEtl?=
 =?utf-8?B?RUU3QWM1cEJyakRoNHFGOUNjSWhVUVJxbDVOWGJqdndUVmRrT3JjYm8xcERW?=
 =?utf-8?B?S3hETGxSVXNYQ2pyTVQwYngxS1I2SU4vWlo4SVIzZlVpeDAzb3NESE5NY1Ev?=
 =?utf-8?B?b0FiOFlmR1NkYW9uY0UyUFpoaERNb1h1SUxPcTlpcEtkY0VHS0lpZkVhRFpC?=
 =?utf-8?B?R0lLTkplVlRRZDRXUjNJUTIvMlRtcDlDTE5uM2IxNDR2dDRDSGEyeTRCOTRU?=
 =?utf-8?B?UEhlNE1BNVVpYXBvdDErbStqRTRPMElaaGVUaXJDQSsrNG5RYWFLY0dUOEpo?=
 =?utf-8?B?Z0txNC9LRFRQc3QyWUxmMlZ6WkRZR09YK0NMaW44RThJWTNnUGxEUzVFRVBi?=
 =?utf-8?B?VjVsNDJiU3dUcCtJTEllSVRTNjdoZ0VDSjQ2bk15ayt6R0EvSnBWN21VKzdI?=
 =?utf-8?B?RUFDSnpPS1NkbXBDaS81dXpBVHh5U1QyRUNPeWtaK0NPcmZZaW1Wak9tNERG?=
 =?utf-8?B?QXBpbXlIbTVacWJwNk1Rc1JoZjNWeHZiU29sQ2drZm85dC9DbVNYT0UzejJE?=
 =?utf-8?B?cnl2VVQydGFRb1Y1cmJIK2UzaE5wZVArTGV4YUZZQmlHZWJFaWVPdXRHY2Ur?=
 =?utf-8?B?elJPUTJwL1l4THRqeGhKd0dHa0Z6d0xxNnNCNFRqYmkwOCt3Umo2RDBudk05?=
 =?utf-8?B?MXNXMzZ1WlZDS244RHdlYWZ6ZWtlc29tajhVOVZFTzlDOGZ6eVZRRXR2U3dp?=
 =?utf-8?B?Z2dXaDBaUlB0blVBYW1NdUhIT3FXdll1QnVZbCtJTEhOWDk4YkdQNkdodmFW?=
 =?utf-8?B?NU9IdmlYWm90cGxTNDM3aVFTazBTYU95SWozRnZualBqQk9Xc1gyWGd2SnVQ?=
 =?utf-8?B?cEgyeStpalFiNkNPdDVHcUhRRmxEMGxnWWcyUWhCb2d6bzA3Tmp0K3QyT20x?=
 =?utf-8?B?Qys0eHpYR3czbE9nbndZMjlDd1N3NElSUmp2ZVl4bXJiL0R0UWpTTmU3RlNq?=
 =?utf-8?B?RkpHcDdRQUYrR2RROVp1Zi9KNVZvTkdOR3p4dWlKcjBnWXd1bjgzWjMvYTRs?=
 =?utf-8?B?bHoxN214N1pwUHk0ZFA3bVFUdExzRnpadlF1TGtPVFJ2dWNKTngzYlJVb3lV?=
 =?utf-8?B?SjZqbTJqZ0VSYklIQXJiNy8yenhRclQ3TzZDejNraWxuTUxoOUcvNjdqRUdE?=
 =?utf-8?B?NTRhalpuM0N6Mll6clNVbkY2anJ1cVl0SjNQNjM3V1hzRHFDS2dqTy9kMGZC?=
 =?utf-8?B?bUJJaVgvYTZyVmNzRlNKMjcybWV6SnFTcjRmMlkwK3NGdWt4VWNWYmpVVVYz?=
 =?utf-8?B?QjhKRERaMEIxWVd3UjJoU3oyV0FMSDlTM0FOVWdMWVdZNjhRcGprbkNVeVVT?=
 =?utf-8?B?WmRucDBOZnJIWURKNGs3K2h3eFVBbktVZkJNYjJRUnpST1hVYVpmUWpBVCth?=
 =?utf-8?B?ZHZOTWYwbm9jRVRzSzBYSEZ2ZzJBVTREenhkOUk2MFdWRVFtUEdncWE1ZHZm?=
 =?utf-8?B?SCtmeUJleXZTMkdLd2FXWlhPZi81QXdiVDdrdERKQ0VMRkIzWDhkNlRtSzlV?=
 =?utf-8?B?bGVqaUIrVmRLNnh1elB2Y1B5VW4vUWRHbDFjVDdWTXdVcmlRNzNUdzB6MU5X?=
 =?utf-8?B?VnJxaVNsRU93MDl2S25SejlQb3dJQ2t6ci92MEJjNXlPWHlQd3NackdWN0N1?=
 =?utf-8?B?UnpMdG9xS21ZZXZ5bHBZaXlDeWJ6TThNV0tvS0o5M1lXRDdRRkhJRUdWeHFH?=
 =?utf-8?B?VVdpb1J0VHUybENrYVVRYzZCTHlBNXFPYUZjNi9QSE9XWEozV2hMUFpGMXNC?=
 =?utf-8?B?c0JmQXFFVi9nbCtsYmJoK01vS2Y3aEMwUFNTb1lmRDBiaGtpZjJkaUc1ZldT?=
 =?utf-8?Q?fzz6yeSronpU2814sPBFvCxfd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1ea70f-e5e0-40ee-ac37-08dcf1ef8930
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6253.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:43:48.3165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/4zIOUrOME5Kxc1XUqS1gxJdpDajPQwIhARlwUlTcms4tym0bRGATeITVbypIyyfM1rqFVcLc/SXBasA9fQRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833

Hi,

The commits below are required to enable amd_atl driver on AMD processors.

0f70fdd42559 x86/amd_nb: Add new PCI IDs for AMD family 1Ah model 60h-70
f8bc84b6096f x86/amd_nb: Add new PCI ID for AMD family 1Ah model 20h

Please add those 2 commits to stable kernel 6.11.y. Thanks!

Regards,
Richard

