Return-Path: <stable+bounces-136604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3721AA9B23E
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 17:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F581B85ADA
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 15:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E391DF994;
	Thu, 24 Apr 2025 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OznU3JCD"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A71AF0B7;
	Thu, 24 Apr 2025 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508577; cv=fail; b=MJDKcB+ovn0q0XcA46oAg94M/hLIFp5aK//wh2KDg1pkfVovBnGQbsY2tN+3KAAoGytrlgcBWfYjqU8ZNYyIE8zGme5ZNDSW134mfBP5gOMzUR29nNjCTVrEFyYRZ++Pxa998Vj3M7zT9VQ//+eFOI4zvMoEJELy07m2v5ah1C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508577; c=relaxed/simple;
	bh=Yol9qaC0T2yJSBKnA3aZMyGFFV67/6EY4e7buBVmpIA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WZzLWj5Ngek8DDEKtOkSHQCszM/HhEV9pzHrS5QbKyopUSbQ9aXgZJvG1paz2uifIuWHW0LKmKgLSpX+iHJAr718+s7iXi7HgVG2yVpcHlELSFLtKGXVGqbrPU3Y0Egkwd7o3Xt7uKkM9sK9mm5mFHdntordxy4wq7Q/iBOrn1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OznU3JCD; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoHNxy2XJ6In/eCCHvZrs1fbfItFAwuLRyFJsIpQT1zelHHGwZG2mFm2vMbYLGw9fzQowkQem2wCBaKz1U0DdHzQS4+CnADzeviHDt4FUWncQBllNDcUxGIy6Nq7QRkX5hGmGpWJdnqoBmx06dxDcQB5LSzp0Wm9hwqoorcJ9SUufTWJRevyX9ZvFKzTy2Hrm/8QPdIEyy4bcU+OR4JIm8MKeMBpp+4b4rYYPy16BHrqt9DJi6CYMfkt2YPq7zJ0dtXbXV3NJlbqqn3Be+uokYIsgyiAbTvVqdQ35mdeoF2Zh+l5HafoCfbvGsEzAyr//L9uqSCM/eel3tylNXKotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMPQq9rlMvEBtl/c4RKyZZCVBw+wB+xb2/7/oyvlebo=;
 b=FTodX6iWlZTnJiFXWfTe2HBsJb1GpEZCui1f4OJ2Ms07WPi2EIKtPXgFeXU0JfGT0gKA1PtJ3gForr+7Y0/MxoDJfEN5w6uv+Vjxp+QS6ZwnHYfE+HpB9Tot4iQs2CWEKVhZkL6pFZH8P3tQvJXf96og3JFLJ0jd1mqPgYcg3zHuCHu8v0eYoTgunP7l6ay+pFeejqv9gHB13awz1XW61cpbxSzlcs7ynoPzABJQuPZFHFIAgsgqx8woTkD4xgxPkQBluZ8aCMQPOdJ8VrzbJVGR8WKF9Tx5AvRqgaXKJql6R/cu1i2l/7u+ZBnTy0+alz7DK2zhw2jD+xgKG0h/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMPQq9rlMvEBtl/c4RKyZZCVBw+wB+xb2/7/oyvlebo=;
 b=OznU3JCDwTectlyljKqpw5UMkDRiaGBM1EXnfJMCmWcqMG+Bl2mQbtuATjbgMpMtw8tIfavIlFcRDOBO6B4XxMgGPoRl804wXN3yXU4P2XWf07akMNu81sHci2/J2M/Fm2k+LOTWFAeh0Lq1i0JpuKuENT1wXKhs3Oabt/y/jPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 15:29:28 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8678.023; Thu, 24 Apr 2025
 15:29:28 +0000
Message-ID: <4311dbc7-efb5-ab6e-046c-87e833119236@amd.com>
Date: Thu, 24 Apr 2025 10:29:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/sev: Fix making shared pages private during kdump
Content-Language: en-US
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, bp@alien8.de,
 hpa@zytor.com
Cc: michael.roth@amd.com, nikunj@amd.com, seanjc@google.com, ardb@kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev
References: <20250424142739.673666-1-Ashish.Kalra@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250424142739.673666-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0197.namprd04.prod.outlook.com
 (2603:10b6:806:126::22) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: 05843476-8796-4180-cddf-08dd8344cd5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3BRNThRSGJOa0M4RDRIUjVneDh5TnI3N0JGYkVNM1ZBcEVpejF2dkFlTEtT?=
 =?utf-8?B?VUJCajJETmsvSnFoaGpBUi9vWFBtSzlwZGpLbXZRV3k5aUJ4ZFQ0aE5pdWJi?=
 =?utf-8?B?cmFxdXpEZCtlcFV5RElzVFVwN0tJdi83emFSMXJRSmN1b0RmMUNldytpM2Vo?=
 =?utf-8?B?M0dsaThjUjZUOTBaUjcvUG5nTUFhK3MxdUNRL1YyT0pHenppbXlUcnBXcmF1?=
 =?utf-8?B?V1JneE9lc3BORG5DUzB6amJGVGhVOE94QlpJZkV0ZDQrUXR5N1AycGZVcWFE?=
 =?utf-8?B?OUFRS1NzQlRCODl0Qm1hS3Uza3BRdkVWYThCZDF0ZjRNVW1tMTBYUVE2OUdB?=
 =?utf-8?B?dWdJY1VkMXc1WnRjbFovWkNEV2plZFB1ME1uT29Wc2NrZldHcTJZbGZVWlda?=
 =?utf-8?B?WnVkN3dSM2lLeU9paDBtcnhwR3hTdFIwMUdmV3NkVHh6aGl5dTJNdEt2VSt4?=
 =?utf-8?B?cUtsNE5yQVFKcDJkVnMyb1pPVTB5aWdHUk5TcmRVRE82TExFRVV0NzdhbEpG?=
 =?utf-8?B?VU1Eek9CL09qbUdpa3piU3ZXbzNaTkhpQ3lDVTlocEsyT0plSlNRZWdWb0N1?=
 =?utf-8?B?c1JQZnVLelphYzgvTzFDM1JBYXVENE15eXRIT2NrbmFTSEl0VnZDYW5zRmNm?=
 =?utf-8?B?SkIzRCtkbHB2Y2pSaEd3NUtzOURWWUdibnFsZjl4ZGsydXJYMmhDZHJaY1Jz?=
 =?utf-8?B?bWFyQVliY1ZHM24rQnh6MmlEQ3pUZ3k0UzhpZ2tRcGRxZ0dna1Nad3dUUHA3?=
 =?utf-8?B?M3psM1pTNitTUkFmVkI2OC9FTXRRYmdSb1ByaitmeHplTmFsdHN2ckgzdjJL?=
 =?utf-8?B?YjV0OW03NnUrRG1QNUtQakc4ZmlPM3F0bE52RFNZRUlKeDdjWUlWOEZZcSts?=
 =?utf-8?B?clB6SWxFVitDTGY2enJCcFZRWjZjN21saHJQVlZrNnhlUisyaDlVVjk4Q2JL?=
 =?utf-8?B?UnQ1UUVUaUN1U1B0WE1sN3RLNmEwM0tCVElDZ05tbkRxbTdJTVdsZk5yQld3?=
 =?utf-8?B?NUh3T2ZBSC9scVdzVEhYUkw3SktEYkIraldvdnlPYjBtZU9MaTlmOU05STJl?=
 =?utf-8?B?ZjJ3UGJjK0J5Z0E5NzZTbU4rZnFOcTZ3dlFXWG1kNmNpcmpFMmhNRHlXWS9q?=
 =?utf-8?B?cC84U1YzN2JsNjRHMjBBaHlMMlkycFp6MTVXdjhyL3pwUjYxVkIzQU1ld1kv?=
 =?utf-8?B?d1FiU3hpZ3ZJTnVKbmpDWFc3cW51UHprTnZXWDNSWUpjbmlITUlLZ2F0Q0l3?=
 =?utf-8?B?STE0MkJWalMxKzVtTk1RVStUYUJ2MG1jNnp4ZDJSbjE3YWx3TzdtelBkM3VC?=
 =?utf-8?B?cGl2NFdYbzU3dXVZSVphSGFEeitpVUdyNHJiRXFid3FZS2QwL3BDalRQSDIr?=
 =?utf-8?B?UW96VFY3dS96MWR3MkpKN1VqRVM5R3lNM0h1SHpoMklvZldCZWlFM09oOW50?=
 =?utf-8?B?d1hkcEh4Z0tPZXk1elpaM0d1Y003QWdiVjBsYVRoRS9qZWVMTmpZK2RveTVF?=
 =?utf-8?B?UnVnMGl2eE5rV1FOVjF2WUlqTjg0dnlzV1gvTWZjLzlzakdpcmlobTJmYnI2?=
 =?utf-8?B?TDY3RlpXWEZKVjRhcjVsN2MxSjA3TXp6cnV0aE5aV2twOHlGS2s1R0NoYWtt?=
 =?utf-8?B?TExBbDJsdUZFelpNYTFxVVM5dTBOQ1lDaGZGbVRSampHVG1kcTdvNUlwTDFP?=
 =?utf-8?B?eGFmSkw1WXJVcnFJNW5hbEVzVnhxaWwvTXRWQzN5V1p1cThsWHM5cVhlbyt1?=
 =?utf-8?B?Ny9TOHBRbTFxNUN1MHBzU3FMeW03OXN4d0dBbk5HOTR1N2E5V01KYXVlWUdU?=
 =?utf-8?B?V0w5NGtXVzRsZ2dWR3RuYm11Z0FHOWR5ODl4dmdXY0hJeG02eHBzeXdabFcw?=
 =?utf-8?B?QlJVOTN4WGhJc3U2cUhaK1lqaE1qcFhHbmZiRDFLdXJwenJ1WXlWZHBOTG91?=
 =?utf-8?Q?cl6eGz/LHbY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0NJTlJGN29rWnVnbnB2dnI1YXpyQy9sNGpmMUNpWHpLV1BnMjhNcyt6MWRE?=
 =?utf-8?B?STlNNG43YTk3Lzh0YkR1U3VxTVdpSnFqU3MxYTdqaEp2OXRlcDlsbzhQQjl4?=
 =?utf-8?B?cG9XQ1FoclhxRURaaUt4bVpIc1J5WHBOcUNPYUUrNDhyYXhjQk95Yzl5K0hm?=
 =?utf-8?B?VnEyaGtSUmFEV1NBMzhZK3p1TjVEYzBJMWRPSy8zR09pNlJDZ2FaNDIrc0tT?=
 =?utf-8?B?aWNHZERkb21hbXNVYmw5bW4vN3VTbVRVMjBCL1hvQ3pIdjMxNUJnejNlT1lF?=
 =?utf-8?B?dER6Vk13SEpOc0U2RzZ3am9aenYrYWtuaXNhOEJGSG1vT1FlK2JBNEZVNGVh?=
 =?utf-8?B?Z0JDOGViOERVZ3RVSFpwWENyZCs1SFpDWFBLLzMvTzZ2UUFnVHJ1SFFZUGVv?=
 =?utf-8?B?QytIT2lmT0hLcVpmc0ozaC9GSWMrMDRzbHBjeERPL0E5dTRONkJNR1JLZFVR?=
 =?utf-8?B?eGIyVmpVZWZya09YemtqVjd2RDRLdHViVlZJcHVXMUYrbnBsaUFoRytsRmZ1?=
 =?utf-8?B?QzVhZVlIMHFqcm9wU0g3ZHM3SVF5NmN0dlk2cjF3dmpONDdxNHdScDdlNmVN?=
 =?utf-8?B?czdKaDM1RU5RMm1aMm1qNUxudzlNRmd2R3BzM0hmUDdXTHJpbE9jZ3dha1BJ?=
 =?utf-8?B?TjNJVFIzVE1EUVVXUFh1bWVCME5uM3V6d0dpT2VBZEh2dm1XWEdJK2hkS1BD?=
 =?utf-8?B?YzN3ZDVEQnhISHMvM3kxbW9Bd1lIeWo2eDY2RS92VXdDMHZNaXEvL01BUncw?=
 =?utf-8?B?QmszOHl3M21yVFZtSElkWTlaZXNaZFdDQmFXMlhaYzg4UG1BdHBhd3kxYjJs?=
 =?utf-8?B?SkFFVGpkKzU2ay8wNzIvcWNiQWp4UWRkS2RuN2gvcEViaDd3OEtObnYwV0FU?=
 =?utf-8?B?M2V3RHBkWmJ3MURCcm1xZUN4ZkZrN1pVU1Bod1J3VjhMTlZoY09haEtSTFNt?=
 =?utf-8?B?R2Y5Q0F0ZmdDZ3lwOG1MaTFNdXJiVTcwODlZNjVlbndJQlUveWl1NzhTUmtl?=
 =?utf-8?B?MFlFL2lFVDh5N08xT1VYUXBpbDFMYzk5S0ovclBEdFVVN2JzaUVFYXpjMC9z?=
 =?utf-8?B?OTNSNG8wV3dCUGRXK1dQT2FibXF5VVJLakJaU2xQYVFGeGlBWVdyMDBXZ25L?=
 =?utf-8?B?VGw3cVcwdnJlZ1kxR0Fhc0o1ekNNVFpLK0QyZW14YmFibHNSb3BaYkVtcFUy?=
 =?utf-8?B?bkxpNzV1RWhEODRUbUxBekhSdEw1VmlKb3V2K2hycUxYelRSaVhsWWpHZzBy?=
 =?utf-8?B?TC9BMmZuTisxZWNaek90akpRRDFJNEF3NmQzRTNTUTN6Ny8vMUhPeWJYMS9P?=
 =?utf-8?B?OUxIYklsdWF3cUF5YjhQdlU0UGJmWXJWcFdiekllVlRJRVZrNzJYNlNsMXBv?=
 =?utf-8?B?TWkrN3hTd281RUFUMkdqdWc3UVc5eERicDJ2OG55R1dlVnVDRnc1MzByUHMz?=
 =?utf-8?B?MjN2cWpQbHpOaGpDU1orNGFMTERvUS9weEJwVGk4OWVvNGJrMWRaeCtXRG5G?=
 =?utf-8?B?WU9lRHVXdEFyUmZVQ0ZxU3A0MGNFQ1BrTWRmdmZEd0w5WnBiekwxQ3hiZ0Fo?=
 =?utf-8?B?MnhJbnc2ejlUUi9nNHFubFEzOG1LYnlxNFB2WnpnbEhGUlJQYW95ZnNIL1A2?=
 =?utf-8?B?UVAwYXkxcGVEYVZXY2g0aFB5bGh1c0JkeXVEQXFzMkhBQ1l1NTJlRWNzQVFv?=
 =?utf-8?B?SWI0WWxsdHNucHhOV3k2SHk1eEtxa1pxb1FkdndiV3lzQVZjQ0tXeEh0MXNF?=
 =?utf-8?B?QUU4QU44ZnkyUUFEUTB4NHZTOTlPdnltVUY4RGRiVVJvUmp2dzlSa3ZQTDNH?=
 =?utf-8?B?OGx2d3M4bndocVVEd09JUUluSCtPTVpVcDIwMmdmRTBiQnBEaHNiL242Z1NR?=
 =?utf-8?B?RzhiS2QybmF1WXNlWVZFVUN0cWRhRU5ZUENOWlBLYUx3dDAzSERkWVVKQnl4?=
 =?utf-8?B?QWNEMTJYa1hKT3cxRnFieUtkaTVRTXdKL3N0aDVnSnE4bUFOdlhvcDhuemFC?=
 =?utf-8?B?ZEFleHNlQmVGTGY5S2dUMDVtNHVMbTFNRFRJOHlIQ2kyVCs1QndrMnptUWt2?=
 =?utf-8?B?VFNLTmdOL3B5SUY0UDkxRGNZOTBwdFM3ZUE4SFNvSllJckIzUG1lU3R4Q0s3?=
 =?utf-8?Q?C4xO6otb6MIVoh2M7/jP8buR6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05843476-8796-4180-cddf-08dd8344cd5f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:29:28.4618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W69fKAVs+pbbVMH0FWNwj6/x6yDq7BrPovJKMDq8ov50IfjwlDe5Y6uCTiOwPavGXG/gRr53NOx30Bs45nUOYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038

On 4/24/25 09:27, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> When the shared pages are being made private during kdump preparation
> there are additional checks to handle shared GHCB pages.
> 
> These additional checks include handling the case of GHCB page being
> contained within a 2MB page.
> 
> There is a bug in this additional check for GHCB page contained
> within a 2MB page which causes any shared page just below the
> per-cpu GHCB getting skipped from being transitioned back to private
> before kdump preparation which subsequently causes a 0x404 #VC
> exception when this shared page is accessed later while dumping guest
> memory during vmcore generation via kdump. 
> 
> Correct the detection and handling of GHCB pages contained within
> a 2MB page.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/coco/sev/core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 2c27d4b3985c..16d874f4dcd3 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -926,7 +926,13 @@ static void unshare_all_memory(void)
>  			data = per_cpu(runtime_data, cpu);
>  			ghcb = (unsigned long)&data->ghcb_page;
>  
> -			if (addr <= ghcb && ghcb <= addr + size) {
> +			/* Handle the case of 2MB page containing the GHCB page */

s/2MB page/a huge page/

> +			if (level == PG_LEVEL_4K && addr == ghcb) {
> +				skipped_addr = true;
> +				break;
> +			}
> +			if (level > PG_LEVEL_4K && addr <= ghcb &&
> +			    ghcb < addr + size) {
>  				skipped_addr = true;
>  				break;
>  			}
> @@ -1106,6 +1112,9 @@ void snp_kexec_finish(void)
>  		ghcb = &data->ghcb_page;
>  		pte = lookup_address((unsigned long)ghcb, &level);
>  		size = page_level_size(level);
> +		/* Handle the case of 2MB page containing the GHCB page */
> +		if (level > PG_LEVEL_4K)
> +			ghcb = (struct ghcb *)((unsigned long)ghcb & PMD_MASK);

For safety, shouldn't the mask be based on the level/size that is returned?

Thanks,
Tom

>  		set_pte_enc(pte, level, (void *)ghcb);
>  		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
>  	}

