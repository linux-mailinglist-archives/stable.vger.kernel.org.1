Return-Path: <stable+bounces-231313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDAMGG1Ay2k9FAYAu9opvQ
	(envelope-from <stable+bounces-231313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 05:33:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFE8363B29
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 05:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DA003040A90
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 03:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF4529C35A;
	Tue, 31 Mar 2026 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kC91+TF4"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF6E2E63C
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774927951; cv=fail; b=Pnx7tz7Y5Y5pXiYROcGdbrcmfcgzhsJkTzAWMMj1aQd1DT7qesom/TFdlAL6ptRq3cvPI21UkCKUo9E16HYorz7zgn1eWpx3LA46mKbcLKGC0BWyBEbqlon9VUH0XF/uulOSx6BjaxnjvZDbRNVdjrMBDXT+NNzWMb1u5dGE1Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774927951; c=relaxed/simple;
	bh=HfQH+yfL2Gnykt/Pv3+1SqedeQc6jz2PHhPP4dklrrM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mKzD2X0du5r4SPE1HUwAFj9UedvlFJ+THRDKMJjDAk7jCtvIhKoECFB891aJqDNVVYJZ65tK+yBcRjTktAC0JtEg7LS86HdNAUJHk8To7JjREB1SaLow2Q2wtqZ/wgwNftFB77UZb7vlJIZUpUnObuu3GjS1yE8CHJ0G/E0XIuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kC91+TF4; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlHl/uhV3uPb8zPcw+UshCuygR9ofS0xlqcL8qvT/t1ri0C+JsAV4jlQRjwdXAurZ3VHrRn+HbWKvLa4nnXFtnSLtcR07h77X/1lILGudCHudXWWkNt6S/rHMD6kL72SBNG087PuuLIqe2gyO81rzFLJPxpfiBXGSUv9Fzq/BWycJ3i61ol6lo48lAmOvp92P5IgNhnRmmrMzek9vWQnXvnOKosSrBt76HcwKrRtgW/RhFT1PUkeykaD5HtgNEHbe7WTXRg56C/342Nb0yAdrkBg8Vdx8jIm2SMY5o3VPHtvnuWyKawRQb+eUVryF+ZkGtSfh/lKpTTG/TJb2d3ARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N98xGPFa74qbzJPXC+bxihMdJphkItKY7Wy1qG7uhBg=;
 b=gB1EEq3hXSltj2D53chY+Dbf18AOIjuO9h6DBjOKWmJ8MRE08H6V2M2QCBQzcxwNI/5qW4t+eWOhhrfQ0TBmvgLWTL9ccyefJ/Qr0cgZ80urOKiVJaAi7fIZmZq19CkS6kdWro2xjSLrs62gwmTv/7J2df0UQzMKhbs2i3RcklJ0V7H2G7xVdTRz3hNkMEN4MUi7i4A2neqcYP/VCKSJOBUrVuYmLbOVfYQrr9BdgXcZ+T4hZtZRStn6qlL1mJKarKvYEXUn+B9XaeVKJCb02fysRWa3GfMIzXfg8ZnjE/4BK2Sth616VeUorqtqFgn02S77Rp2HH/kn+ho2Dh9lgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N98xGPFa74qbzJPXC+bxihMdJphkItKY7Wy1qG7uhBg=;
 b=kC91+TF4vyKIBVBeQNW3UEFNfwqm1OPKokQm065573MzWCMPUIooPVKBbU6H9v6dXVRYULgO3h9/jExRkisjgoUKHpu2HHy/fHpnqwPWJAMEqdhn5iuXSlDBIikUYMa0oEXwydmMRmSvlO/AiQ7bXoEKvKn5U4rmgJpZBIROp7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 03:32:26 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 03:32:26 +0000
Message-ID: <a6c89ad6-66f2-405a-8ab5-5b50ff609657@amd.com>
Date: Tue, 31 Mar 2026 09:02:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdgpu: replace PASID IDR with XArray
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20260330191120.105065-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260330191120.105065-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: fc66f690-1cea-4c8e-51a6-08de8ed620f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	00mQd91Vu1zEUVUgJXOU0q/qI7Bx16OvLYnWCQorcAwYpLaITOdS6njhI6Tw2cMGM5Jlcl84Dtl3KzLH81UVw+XbrlPlTKYfbGaqeu9qW1oj7wAHbnRxIOe6yCGYzuCGcc4Ak4fnuL9t3qrY2NV78P9+VfgDKX8iXba3eT+GGN8pfD0Ipo0bJmw7SPbFQnr/H7JIEESFLoFRaXWDOnSQ6opLkaZj3KYDi1bJYrh6fma5Ai2SDwDfNc6yT2/3phErz2ym5DQ/93n7VSxndXbxGxzuwAb+ClYT1U9/nrhiLftHhudX0jQiPf6Ct8zoPh+zfqzfTG7XArk/7qYmCS4uS4YTNpBRJg6Re2A+0xcwZVHdcsOjRrj+ZWwjN/Nsg7N9DgYkN64QEEFTglddpNxU5LWeo1dF8+kVmvZga2Yy/sFdL3Nu/8JiqmsJzb/06+61jop9DKY/jl0TQB8S+KIMj3PVYwN+xzq8xsEgQXvV+sYPHWl9vxCISqqKhE5IdByOoGV6Jt/cestkt3eLieR/Xxo1H66N+3sbktQJ70bgdgBhO+rKy2rAzYa+ntMKAmkxwTF7bhdZCURuyBluNAttES/DBuCMtoxDwHPhhR4LZLKSl13NAc0pCUKC4bwTYlcSFpmyR0yeuMvVqWIIIBragB6hS1U/ozIEukd6og/Diwnx4Fzi9LuRFuny5OJv+y9hVzY7vx4l/k5cY4DQDLLZYjS2jYqPONh+LXZq0sjOmDoZQ4f6krLbd2eicDuob/63
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7091.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVNKbm5DQ2FzYVA1MFN6OEhpMUwwbXN0ellycUllemQxbFdGbFZ1bUpRWXFr?=
 =?utf-8?B?RGhVN1JMbUovRURrbW45RUtnYk5pbmZHMjZiVVRNeC9MQWtzbFVCNzFqS00r?=
 =?utf-8?B?Z0NBa2szcklFZU1wU2VWWTNycFNqblJVSDRDTFA4Z0ZSUnVGaDFkblBWUHhD?=
 =?utf-8?B?czYzeVhFWGxBeVFVTkVUSnRiUDhhanpjc0VXRU1lL3Q0UGVRWm1ic0JlaENO?=
 =?utf-8?B?TDVSWWl5RTF1bXkyS1I0Nkd4Q24yT1lDY2VtUGFJTnUwSU5mRVYvSlc1NnR5?=
 =?utf-8?B?NVF3emM4SmdBYm1sc21sdFlCMU9WZmpQQlFOMHZlT05VRDdlYml6SHJ6MHFB?=
 =?utf-8?B?aHlLd0JVbkE0ZEFIU2Y0S0M3a3NjajdWYVBvTTEraVJLL3JRclJtWThlRTAv?=
 =?utf-8?B?bHBBb216SmF0M1ZHRk01WGJHQmRxMXFKM1prVWlCM1NXOG9BM0ZsbG9hUzI5?=
 =?utf-8?B?cE5xaUFaUW5YNlJnNHZWT0dqbm80REFuT3lvTlFWK1RySWhIM2Rva2lGNDZ3?=
 =?utf-8?B?Z2w1MCtpQ2gzSmtQMEg4YTJkYUdMUzJhS2o1S1ZId3p4Z0VhME14ZnQzNkNl?=
 =?utf-8?B?WGg0SUtTc1VPbktJSEVZVDk0ZWNORmFUdDR2WkhvVmNLZDlxTlkrd1J4WHJw?=
 =?utf-8?B?WkEwUHk3ZDE5M2NTNTRXa1NES3dMVGRkN2lzYWtIeEtVeXBVcmk0NmExZ3Zi?=
 =?utf-8?B?d1dDQnZYYkRGdGFxN2xJKzNhNWFEVWJhRnBXSjFGeUpMMTB5aUgrLzZQUDNL?=
 =?utf-8?B?MmwxTFExcHQySjRQODFJU2NRVmlMUmRVcjUxNytRMlFwNGhRMEFOMkprbXly?=
 =?utf-8?B?dnBwSDdRZUZ5bi9IeitybUt6UnJVazZJRGlNcGdldHp1b1VjQjN4eG1zeTdr?=
 =?utf-8?B?RmVwcFNRMmVQdEhQZDFjVlFIV21lL1NDenIvM09wYzVLbkVBdFFKeWJjUFBN?=
 =?utf-8?B?dlZ3Y0lzWEt2RnZrelFBV0ZwM2FOZERURmhpZmU0V3ZIOW1jSkpFdFM2S2hi?=
 =?utf-8?B?Q0ZBNGVTZ3FSbkRFUm9sYVNiYW9SenNLcXN4eWZESGZPMGNPdDlSVjZOR0ZV?=
 =?utf-8?B?V2xXQU12V1lINCt2dlRUTjBDT1owTHRvWmlETkFTZ1ZoZmVES2VMMmliMUV4?=
 =?utf-8?B?NHFyU3pQMExoVWdHUmJMSUNZb3V0M1dsRDc0bUhVR2JXMWFEdDZ0WTdDd0Zi?=
 =?utf-8?B?L2lmM2gwWC9zbC83YnZjSUFtdzFJY2tFc2JtM3hYT2NYOWFjeGpkcUswa0Q2?=
 =?utf-8?B?ZE1CelpGQktWRmRXbkgyODNqZ0dLa3lROVdpUzc5MUVkYU9uazZMOGZ5c253?=
 =?utf-8?B?WTZEREI5STRLazRJSFVQOTRvdTdpeFlIYkJTUUpoK0lEWGZhUzFZckpKcG9L?=
 =?utf-8?B?MHQ4Ulhzc1F6RkU5S0lLaTd0T3J5UVQ4N0FmbHN2NEpkTEt4cHdyb2pYRGdx?=
 =?utf-8?B?K2x4RFQzNTNzSk01OHl0ZndHc3IzSmJ3d2IwZkVQMnVXblplaE90Rmp1QmFu?=
 =?utf-8?B?R21xNnpUQ1dqMmR5RmEzK1lFZm5BNGpKWS9nb2pqaTJsT28zMEFMYmNLbkEz?=
 =?utf-8?B?TlVZZ3FNemg5MFF1Uld1OFNmSksxVDQyZ3JKODhiaFlLTmNWc2hqbktxa3c5?=
 =?utf-8?B?d3RYM2YyeGdXZ1VET1JtOFUwZnZXcVFNQUdoOURRams0dTkrTnFFMDd5OEVr?=
 =?utf-8?B?bjFvMElUT1V6bHcrZDZLQTZ5NnozRFVlMHU4YVdXN3Q2UTNTdHNsMlFQUU5m?=
 =?utf-8?B?Vm9raG9WNDExbVJTd0l6K1kyRGlyQU9sNUNTSGNBblpUWDl4Nld5L0VZOURC?=
 =?utf-8?B?ZTBCMTZRQ3pHaGRGVU9aTGJ3SWJlSGhxTVQ4Y2xTZ2VWYitYeXEwUHFPZlJs?=
 =?utf-8?B?MlhnSWlDb1BHeG45c0ZQMHk2QUJkRkM5NjNHS1lXaHlrMWd6S0ZqV3ZZVnBY?=
 =?utf-8?B?ZEhvZFpFa3c5S0RQNDNFWFVyU0N0RzFwdkpZUXgwSTNqOHRQbkJ3OEI1WUJl?=
 =?utf-8?B?eFA2TmlvMHZvZkVzOEpGMzN5cVJsY1lGQ3BVRE1Tb1RJeitJSTNMZGUvRVhy?=
 =?utf-8?B?Q0VnZnZuOWJMdUg1SG9xbzNOWDFwNmdWNlEvN0g0N1hIS3MzOXN0cUtkMkp0?=
 =?utf-8?B?b3EwbUUwdjhaeGlGdmVTKytlUVBtUGowK2NLSkRGQmxFSUVRa2p5VU1NVGxm?=
 =?utf-8?B?NHlHWjk5VERPMVVMNURBbmdVdExmUE1iamk2MHNsWDVIN0p0Ym5lRTQwNzlC?=
 =?utf-8?B?M3pERjUvWWZydllxb3VaUjNLamphUk5lWkJFTDhhMlkwWmZqdTBnZEsvTlhF?=
 =?utf-8?B?bEtKQkhQbkQ3UmZTNjBkN2NZUkRpSW5uOUc5ZXdSRXZkQlhVUW1GUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc66f690-1cea-4c8e-51a6-08de8ed620f2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 03:32:26.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TVDMiAYnrmwNaDzxr1Kb9mzP5v5I66cEQeQwXENSI6cQbixTAhLsQ0sUYOz5HLs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	TAGGED_FROM(0.00)[bounces-231313-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lijo.lazar@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFFE8363B29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 31-Mar-26 12:41 AM, Mikhail Gavrilov wrote:
> Commit 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
> converted the global PASID allocator from IDA to IDR with a spinlock
> for cyclic allocation, but introduced two locking bugs:
> 
> 1) idr_alloc_cyclic() is called with GFP_KERNEL under spin_lock(),
>     which can sleep.
> 
> 2) amdgpu_pasid_free() can be called from hardirq context via the
>     fence signal path (amdgpu_pasid_free_cb), but the lock is taken
>     with plain spin_lock() in process context, creating a potential
>     deadlock:
> 
>       CPU0
>       ----
>       spin_lock(&amdgpu_pasid_idr_lock)   // process context, IRQs on
>       <Interrupt>
>         spin_lock(&amdgpu_pasid_idr_lock) // deadlock
> 
>     The hardirq call chain is:
> 
>       sdma_v6_0_process_trap_irq
>        -> amdgpu_fence_process
>         -> dma_fence_signal
>          -> drm_sched_job_done
>           -> dma_fence_signal
>            -> amdgpu_pasid_free_cb
>             -> amdgpu_pasid_free
> 
>     This was observed on an RX 7900 XTX when exiting a Vulkan game
>     running under Proton/Wine, which triggers the fence callback path
>     during VM teardown.
> 
> Replace the IDR + spinlock with XArray.  xa_alloc_cyclic() handles
> GFP_KERNEL pre-allocation and IRQ-safe locking internally, so it is
> used directly in amdgpu_pasid_alloc().  For amdgpu_pasid_free(), which
> can be called from hardirq context, use explicit xa_lock_irqsave()
> with __xa_erase() since xa_erase() only uses plain xa_lock() which
> is not IRQ-safe.
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Fixes: 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
> 
> v5: Use explicit xa_lock_irqsave/__xa_erase for amdgpu_pasid_free()
>      since xa_erase() only uses plain xa_lock() which is not safe from
>      hardirq context. Keep xa_alloc_cyclic() for amdgpu_pasid_alloc()
>      as it handles locking internally. (Lijo Lazar)
> v4: Use xa_alloc_cyclic/xa_erase directly instead of explicit
>      xa_lock_irqsave, as suggested by Lijo Lazar.
>      https://lore.kernel.org/all/20260330162038.25073-1-mikhail.v.gavrilov@gmail.com/
> v3: Replace IDR with XArray instead of fixing the spinlock, as
>      suggested by Lijo Lazar.
>      https://lore.kernel.org/all/20260330110346.16548-1-mikhail.v.gavrilov@gmail.com/
> v2: Added second patch fixing the {HARDIRQ-ON-W} -> {IN-HARDIRQ-W}
>      lock inconsistency (spin_lock -> spin_lock_irqsave).
>      https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
> v1: Fixed sleeping-under-spinlock (idr_alloc_cyclic with GFP_KERNEL)
>      using idr_preload/GFP_NOWAIT.
>      https://lore.kernel.org/all/20260328213900.19255-1-mikhail.v.gavrilov@gmail.com/
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 47 ++++++++++++-------------
>   1 file changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index d88523568b62..3fbf631e67c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -22,7 +22,7 @@
>    */
>   #include "amdgpu_ids.h"
>   
> -#include <linux/idr.h>
> +#include <linux/xarray.h>
>   #include <linux/dma-fence-array.h>
>   
>   
> @@ -35,13 +35,13 @@
>    * PASIDs are global address space identifiers that can be shared
>    * between the GPU, an IOMMU and the driver. VMs on different devices
>    * may use the same PASID if they share the same address
> - * space. Therefore PASIDs are allocated using IDR cyclic allocator
> - * (similar to kernel PID allocation) which naturally delays reuse.
> - * VMs are looked up from the PASID per amdgpu_device.
> + * space. Therefore PASIDs are allocated using an XArray cyclic
> + * allocator (similar to kernel PID allocation) which naturally delays
> + * reuse. VMs are looked up from the PASID per amdgpu_device.
>    */
>   
> -static DEFINE_IDR(amdgpu_pasid_idr);
> -static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
> +static DEFINE_XARRAY_ALLOC(amdgpu_pasid_xa);
> +static u32 amdgpu_pasid_xa_next;
>   
>   /* Helper to free pasid from a fence callback */
>   struct amdgpu_pasid_cb {
> @@ -53,8 +53,7 @@ struct amdgpu_pasid_cb {
>    * amdgpu_pasid_alloc - Allocate a PASID
>    * @bits: Maximum width of the PASID in bits, must be at least 1
>    *
> - * Uses kernel's IDR cyclic allocator (same as PID allocation).
> - * Allocates sequentially with automatic wrap-around.
> + * Uses XArray cyclic allocator for sequential allocation with wrap-around.
>    *
>    * Returns a positive integer on success. Returns %-EINVAL if bits==0.
>    * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
> @@ -62,20 +61,22 @@ struct amdgpu_pasid_cb {
>    */
>   int amdgpu_pasid_alloc(unsigned int bits)
>   {
> -	int pasid;
> +	u32 pasid;
> +	int r;
>   
>   	if (bits == 0)
>   		return -EINVAL;
>   
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
> -				 1U << bits, GFP_KERNEL);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
> +			    XA_LIMIT(1, (1U << bits) - 1),
> +			    &amdgpu_pasid_xa_next, GFP_KERNEL);
>   
> -	if (pasid >= 0)
> +	if (r >= 0) {
>   		trace_amdgpu_pasid_allocated(pasid);
> +		return pasid;
> +	}
>   
> -	return pasid;
> +	return r;
>   }
>   
>   /**
> @@ -84,11 +85,13 @@ int amdgpu_pasid_alloc(unsigned int bits)
>    */
>   void amdgpu_pasid_free(u32 pasid)
>   {
> +	unsigned long flags;
> +
>   	trace_amdgpu_pasid_freed(pasid);
>   
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	idr_remove(&amdgpu_pasid_idr, pasid);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
> +	__xa_erase(&amdgpu_pasid_xa, pasid);
> +	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
>   }
>   
>   static void amdgpu_pasid_free_cb(struct dma_fence *fence,
> @@ -625,13 +628,9 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
>   }
>   
>   /**
> - * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
> - *
> - * Cleanup the IDR allocator.
> + * amdgpu_pasid_mgr_cleanup - Cleanup PASID manager
>    */
>   void amdgpu_pasid_mgr_cleanup(void)
>   {
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	idr_destroy(&amdgpu_pasid_idr);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_destroy(&amdgpu_pasid_xa);
>   }


