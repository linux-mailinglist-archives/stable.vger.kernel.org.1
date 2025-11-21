Return-Path: <stable+bounces-195472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BBADBC77A4D
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 08:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7179B4E8DD7
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 07:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C85C3346A9;
	Fri, 21 Nov 2025 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XvLWK3GU"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F3F296BA7;
	Fri, 21 Nov 2025 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708694; cv=fail; b=TaBXFF1li1AnJS/mc+06okiQ55/1dbzXFFDNKvPcxU3E0PzD/OMSrTBpNybvqeFKA0Pu4gdpfqWiJshOTU0c2I/azU0gZKl715mFIfoclexjJyYOCYSsrD8TxRWjWThjRZcvW24fGYvlreYSxldUHRAVm7DAQqxSwOLqfm9Q5Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708694; c=relaxed/simple;
	bh=h5a/HS+EaKZ9GgnTWURwXRPlZG9P4nq+txP9lftYZts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oR640W4RCMWWZVX798ORZVJ+PZpNzTw9crAIUyVz40LWjoXzUgHlJOjpmOb9K5KLjhveCDKMJs/Efn9pzcfr0+WXd9ul2DJJ5uWjMwOE+9iUgwWc9LN8AETF4Eu7JHWO/9xB7CNaQrDBib+jfj+h7dozTjh7WpUxHAOK2XancQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XvLWK3GU; arc=fail smtp.client-ip=40.107.208.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwFpg+r1qYAIz5tXiybk8g5DU5Qe91pShs/tn5ceLi2x/KKDPH13OGg3ovfYocbndHdnw7mY457Ie9Z4uJVykB4n5teT3dgRLCvpBMml0W9QC4fdlX0bEU22nRCEptuN+BFPxhXqX51bg/KI20g8C2CphSb54q7tv4zsCjDTPIjA7Npt1NYCbBvyvgGWGL/vqz1Hvy0wrDcfEUbIYZI3sggNsKqFZL2kruaHdEyuo1CP6n5kfBieQHiHaSXNnkE2aQTuqLSmhE5PEWQwKy2QGxyGs/h4GoJLOpwRBYZ5hHluDsKyG0fd7gcwptHBbSl+LjyM+7ZIl1ih9q95mconHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fNTvE1rZ/EbYqm4wL56KtZOac8rROg2RPklt1xt9Dk=;
 b=iG+p1rkwZ9YG3Jqv4ZVMore9+8VrKTLfo7OrMW4tpBRXEA0oO4NCRghYl24mdLv/MDqk1VHQHeloJwWKIKbGpk4Z7vlII5xLH4jBEFjgd3azfPqJaGmLHzCJzI68TNNOiDlBToDuJmB2/yQGzpEbg2/nWIoOUlsvkkbPdaGRXcXsBsJO+Vc9Tu+lVwrynUVTeRywWSuDO7lExygrIEKo1zSTZLJPFD/8u8KoXtBKbadc4ucWgv8DYWMwx3j/jl5w/g7J7UppE/4f7Etbdm8y9uCIlFFJVT9ytSgzJBaMbGX4J2SEb55gvoFV1NSZOqF9mi7WXO+do2coc8OQ2AKtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fNTvE1rZ/EbYqm4wL56KtZOac8rROg2RPklt1xt9Dk=;
 b=XvLWK3GUOm4ofJK5xdEiJ/b4AR6i6/7MKMnukAg83Gt2Ss/TYVtYq2vGOvEsEUVMea2pCA+jofVMbSVhv1wh8XJ67yp1VP6qiOxNr+ScBIDGCZQK6yreIuZF8ePLUW2gQCKByfeYiAgVM+CjeeiXbw7MFJFWTRPZ6LzFHiLIAuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9684.namprd12.prod.outlook.com (2603:10b6:8:281::11)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.12; Fri, 21 Nov
 2025 07:04:49 +0000
Received: from DS4PR12MB9684.namprd12.prod.outlook.com
 ([fe80::3328:ba1f:4c87:4eb5]) by DS4PR12MB9684.namprd12.prod.outlook.com
 ([fe80::3328:ba1f:4c87:4eb5%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 07:04:49 +0000
Message-ID: <15355297-4ff3-4626-b5d5-ac50aea87589@amd.com>
Date: Fri, 21 Nov 2025 01:04:47 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH] x86/mce: Handle AMD threshold interrupt storms
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Tony Luck <tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 Borislav Petkov <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20251120214139.1721338-1-avadhut.naik@amd.com>
 <2025112144-wizard-upcountry-292d@gregkh>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <2025112144-wizard-upcountry-292d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR01CA0020.prod.exchangelabs.com (2603:10b6:5:296::25)
 To DS4PR12MB9684.namprd12.prod.outlook.com (2603:10b6:8:281::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9684:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e98fec-0237-4ff3-a0da-08de28cc42b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXFDdVd4LzFFL2p4VjNVam9GRzdHK0Y5a0wzcDhIeUZZVWQwQkJlL0Joa2hF?=
 =?utf-8?B?TmZ4VVRyNUxiQmhCdGlJMm40MGQwa1dJWWZBcWNrVWVsYytxS1N3Slk4U0RC?=
 =?utf-8?B?d3F3Ni9LV2o3Ym5jMkJTN2l2ZmpMVTVQUWw0K1lJc1pjMURtZUt0RjJ1dFdS?=
 =?utf-8?B?Yk5ldGsrYVdqVFhEeExTUzcwYmZQblRGZ0x3bGlaSkp0L3Qxd3BQTlR3ckpz?=
 =?utf-8?B?SEVuU0RXbVBRWHFoczhKZ2tad1M2TVFSWVlISkthQjJpVWVTdkZqOG5Ya0gy?=
 =?utf-8?B?ZXNYQ0lVU1BiaWtleHdzTklpM3J0Y3pJMElLcDNDNGVGMklFSWRxUlE2V2RU?=
 =?utf-8?B?eVJqUmZwVWo2cVkxejdPb1MyeVBKZFdMdG9mUlN2TkpYWEtHbVROUU5Ba3I2?=
 =?utf-8?B?OEJuOFVQcFNOaGdyYjdxQ1hDcWUwd003N1M1SXFBMzUwMTFSeUxYdmt0REl3?=
 =?utf-8?B?S0kwcUlBTkRTMHgzaUF0VjZNd0E0NldJNFcvOG5YaGdCVUt2M1ZYb2xEWmNa?=
 =?utf-8?B?b1Y2c1l4OVFxUjZEeWY4TE5HdUR0ZnpNWU5mZjN3bEdaNjFnOE5VUm5aalNJ?=
 =?utf-8?B?ZUg3K1I4cEREVGwxWk9qMFc0NWtLUU9CME9Ra0J3VWg2blR2eUdrMlNyb1hX?=
 =?utf-8?B?c2pmMlVUZXJURExIbk1nSHNCTFBFZmhUeU9qaThCbW5vMFErQXlib0V6eFJB?=
 =?utf-8?B?SG5pbk9jY3lLSm9VaGx1WTlqaDR3dWxDbVNVNk9OMEI3eElweHRCRVd2WDdv?=
 =?utf-8?B?K09NMm53N2liQ3lVdzRFVm9ITXB3L1VjbDgwd0g4alVmV24rRG5hR0d6akQr?=
 =?utf-8?B?K2NnKzVueWJkYk9rMnpqV2hMc1oxTXhwekZ4ZXZTbFRtdmJXcXRoeXNLRnAw?=
 =?utf-8?B?TS9qeVRuSXV5SEljVHpub0ViNlQxdE80R2kzdS9vYjFiWXJhRnFsc3M0Mk9C?=
 =?utf-8?B?aTBpNlQyc0MxRUF0RWZRY1RNcmpTZWhIMXFNdkpMZVM2Z09aU0VCYWVOa2Fk?=
 =?utf-8?B?d29rVHhFT1hTK1M2cXZ5S0VXaUhKM05UTDQ1TjdSSXVjcnErS3h2Y01UWWIz?=
 =?utf-8?B?TGc3V2w1YnlnMldxNElMZVRPZzVJU3VQOHRodWpIUzA0NEtoWjVJd3gwMm1i?=
 =?utf-8?B?NVZuNWpDalVUd2VBR2MyS1VrUVNCSktyZ3JOZnhLbXFtLzBjYXVhQUZIelVz?=
 =?utf-8?B?dG9vRHRacHF6WWwzUnhhcGVZVTY2Rkp0YUs1QlphOXNRQi8wRXJmZndEaTdm?=
 =?utf-8?B?ZW11eE9pQ01MQUxvZC9wUm50a2V5ZXR0RXcxa244MDBaZkdOc1VCTnZuc00r?=
 =?utf-8?B?bHRFQVBoYzNacU5HRU5VT05IY3VtYVI5SDlwNmhZS3dtRlZCM0JJL0lnK04w?=
 =?utf-8?B?YnRxUmNaNWM0eHNsVkVtZ0ExbzhEQ3RHQWY1bnl3TUVHUFVkazVhT09BeWNG?=
 =?utf-8?B?VmI2a01vOEcrYlh2VnhRTFpuY2RqSHNBYlRQSkRyQ1dFdm8xanJXMmhaZWJL?=
 =?utf-8?B?Q1RwSG1pNUdVcUc0Uk1rbzE3Y21IcWs3bGV6Q01zYjVSczNlbXlzaHhmWWE2?=
 =?utf-8?B?N0FWb2RmTlBOa0Q0YVpDSjBOMjNkOUtXZE1EeTlQNUZQYTlvVzluWFB2OGx5?=
 =?utf-8?B?MzNXVmF3UGFnTnlIUzI1Y091Qy9Jb1IxQlRjbzhGUWswVzV1ck9aQVFrODlE?=
 =?utf-8?B?N1huRDV4cDBhSmgrKzlseVRXL2lOa1BHT01HcG5ZYzVjU29BaGkyUHlOU0lx?=
 =?utf-8?B?aVR3RHZsUTlKVzZzU3RsYVhTdXI0M2xVbXpNdXJZenNraFUzUUxUTDMzTjRm?=
 =?utf-8?B?Q3h2WjF5cm1qVXBGZ0xSZ2FITlpWN0tKbnFNKzZicWZxR2VYQUFGMzJmSnlh?=
 =?utf-8?B?aHJFaXM2Y0dwbm0wcW14WjdFVElDTVUzM2NzWXFPVWphSjdleFdEdHNVN08v?=
 =?utf-8?B?RmFrK3U4WGFScjR3MHV2RUdLaWxKZmxkUE5IcDh3UjFaKzFqc0ZXQ043cmFC?=
 =?utf-8?B?RWt4and3b2dRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9684.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFFkblAxV1poR1VWaEE5bVpwWUpab0FqOXFlMzFvNDd6MWJnUnRncitkWkZB?=
 =?utf-8?B?SWtBd1BsVFFCYU40aXpOeTJEc2RrL3hUbmdIQ1hsMHZ0ZVpmK09CRHpaMHcz?=
 =?utf-8?B?b0xlRllTTWJtcSt5cnM1NURYWDM1UmQxUHlBdytGQUV1T2kyVDhmU0c3QXhs?=
 =?utf-8?B?MEtqNUJ1Qk91MkxYaStLYWZyZTZ1TlJsR1VzcHFMbnQ0UjdUNUdXeVhqRkdi?=
 =?utf-8?B?YTEwOVFuVzlGSHBPbjQ1aUNTRE1FVFhQMXd0Zkp3S3FXbStpVnRiRzJKa21B?=
 =?utf-8?B?SHRXOFNMZm03ZlpDRmVkcFV4VDI1dGN5R1NaSnMwRUYybHpFREdOc2FkdnRq?=
 =?utf-8?B?ZEhLNVBFTHo5OXN4cU9veGVseEJObG13b2tmemp6MGljWFI2QnlXNFkxNWNR?=
 =?utf-8?B?elNsM3NwYjVvQ2VtSDdoWXFKODVsRUpRL2Z6RkcvL2ZlOXpyWGhDdnJLTjdo?=
 =?utf-8?B?Tnl2NHp5dXJvMXlObExxcjdNMzY5cHFtZGtLSys4aXhPM2FQcTZndjk3dHNy?=
 =?utf-8?B?aXIvOEpPQTR6OG5Gc2czRnVZRVlnbXROQ1Z1UkdTempkSU9yQ0JwcEtKWnZj?=
 =?utf-8?B?VmE3UkxLdzQ5THUvdXl1TFE1ZHVLSzRFaW82UmNNMlJGdzIyVEcrUFdOVTM0?=
 =?utf-8?B?N1E1Z1ZNTVRwdmN1RUhRY00rQmlpRzg4c2RjV2FsdVFxbko3Vjh3UGNRK1Y3?=
 =?utf-8?B?eGQ1UlJwTFVqUEZ1aFNsREo4VU1qMFpkK3dpbjNEMEx6bG1HMGovc051ZEFo?=
 =?utf-8?B?aytYTFJxdnhuQUNmU29wVUMxZkhWQ0l2UWJEK3JvMW53OUxSOFJkMFFRbWRz?=
 =?utf-8?B?RUMxVm52ZFpYVXJMUVQrM09BUk5pNy96b2Z1R291bUFHLzdrQ2RIbkRmU2Va?=
 =?utf-8?B?MVY1RUtBM2swYXFZLzZDQ1g2YzNMeFVCUWZCUXl0Z3lCanRIUzFsbVU5OUVz?=
 =?utf-8?B?UENYZ2hPeGlJMkNBWEk2blhtb21mcnE4R1dMRkFxbXBQQ1h6aGFPc2Q2OFg2?=
 =?utf-8?B?bDc1VXZBT1VuK2tma2lCZlZJaTh4YU4wZ2RpRVNLNlQwVGpkK01rbE1hU1pt?=
 =?utf-8?B?OCtweDFzRFJ5YkJaQ3JJb1lUQ09LQ3hYbWxZbzJlN3ltbUY4ZWpoSithY2Jp?=
 =?utf-8?B?ZXBBT2FwcWFJS3NBbnpCNVR0dVJNcXh6ZDZpc2dwNkczSzBrM3g1UUpPWnZV?=
 =?utf-8?B?WmxyanN4MmF5WlA5MUdtZU44NngwQkozQ1g1Z0JaVmF4eW05STFXdS9UYWw2?=
 =?utf-8?B?OHc0K0EwZ0I1OW9NTTlxUnI3MjVxQzFUdURwN0xUZnZCTkxkQUEvTEdPTWEy?=
 =?utf-8?B?eitSRVZNYTJDOUFZdGQ5bFZ2VHBQUGhMaUxCWmhjYUFnWmo2alV3aVdZY09H?=
 =?utf-8?B?QnZRNnh6K2Y5WGF6KzBwMmx4cWFTQzhlazh2S2lVUlJhb0Mzc011VG5RczNt?=
 =?utf-8?B?cnBoeTBON3lJVmJIKzFBZ1l0T1dnWXc5ZFk0L2s4RWxlWEpveEFxR0NTWjBv?=
 =?utf-8?B?OGZTRWNKdXBhZ0lka2pwUDlHMS9HY1Q1UHpUV25mY1RIQTU5WjdnRFU4NUJI?=
 =?utf-8?B?MTI2cklQclA0eVZ1ODZTSkZpZ2Q2SVdHdG43MHRSSUNycTI1cUJ1V1hkNUFM?=
 =?utf-8?B?OC9TQ3FTaTd2WFJEaFRFczRHTU8rb3ZxS0ovUWUxU2NPMHlEYS84NTVHOWs1?=
 =?utf-8?B?QmNTSVpXRTF2cStOT1J6U05FUEJaTVdwZytGZHNrSWM1ZWxPMHlZcllxNVJm?=
 =?utf-8?B?eng1N1djT3ptcVlBMFFCY29WYUxPcFZSRy84UUFldzZpbHJnSmFsSGtqTXJl?=
 =?utf-8?B?cXhBeEcraXhWUm9NWVVRbUNwWWw3TUtKVll4Wi9TMFN1ZU9zWmk3bDdRdklG?=
 =?utf-8?B?UUg1bUFoLy94bURtd3ppcEc4ZWdyZDJ5ck9xbEhEZ3hNMmpHdVJERitDd3Fk?=
 =?utf-8?B?OWpWRkNkREkyOUptdHU3WjQwd3ozS3JOTFN5bklhQm0rL2tPQnNUN1dyRUo1?=
 =?utf-8?B?T0QwSHc0NE94Ykt5ckhHMGJUS2pVM0FYamNTWUVsd3piVGhjRm9rOG9rVHBx?=
 =?utf-8?B?dDh5T2ZjNGNzbCtraVB0Mi91YXQwdExJK3pBZU9rU0hyclRZTTE5ZitYMHIz?=
 =?utf-8?Q?bPcQcPrKDJJ0GJeZqpcLpAD8C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e98fec-0237-4ff3-a0da-08de28cc42b9
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 07:04:49.2708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aE3vkaK42qhiH2aGk3vrXpdb+bIZ75YcoXrGHm0D4g+ZHIyFReNOkyWB7GSRVDUeTX6507kSg8j6ahgLz52BjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110



On 11/21/2025 00:53, Greg KH wrote:
> On Thu, Nov 20, 2025 at 09:41:24PM +0000, Avadhut Naik wrote:
>> From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>>
>> Extend the logic of handling CMCI storms to AMD threshold interrupts.
>>
>> Rely on the similar approach as of Intel's CMCI to mitigate storms per CPU and
>> per bank. But, unlike CMCI, do not set thresholds and reduce interrupt rate on
>> a storm. Rather, disable the interrupt on the corresponding CPU and bank.
>> Re-enable back the interrupts if enough consecutive polls of the bank show no
>> corrected errors (30, as programmed by Intel).
>>
>> Turning off the threshold interrupts would be a better solution on AMD systems
>> as other error severities will still be handled even if the threshold
>> interrupts are disabled.
>>
>> Also, AMD systems currently allow banks to be managed by both polling and
>> interrupts. So don't modify the polling banks set after a storm ends.
>>
>>   [Tony: Small tweak because mce_handle_storm() isn't a pointer now]
>>   [Yazen: Rebase and simplify]
>>
>> Stable backport notes:
>> 1. Currently, when a Machine check interrupt storm is detected, the bank's
>> corresponding bit in mce_poll_banks per-CPU variable is cleared by
>> cmci_storm_end(). As a result, on AMD's SMCA systems, errors injected or
>> encountered after the storm subsides are not logged since polling on that
>> bank has been disabled. Polling banks set on AMD systems should not be
>> modified when a storm subsides.
>>
>> 2. This patch is a snippet from the CMCI storm handling patch (link below)
>> that has been accepted into tip for v6.19. While backporting the patch
>> would have been the preferred way, the same cannot be undertaken since
>> its part of a larger set. As such, this fix will be temporary. When the
>> original patch and its set is integrated into stable, this patch should be
>> reverted.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Link: https://lore.kernel.org/20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>> This is somewhat of a new scenario for me. Not really sure about the
>> procedure. Hence, haven't modified the commit message and removed the
>> tags. If required, will rework both.
>> Also, while this issue can be encountered on AMD systems using v6.8 and
>> later stable kernels, we would specifically prefer for this fix to be
>> backported to v6.12 since its LTS.
> 
> What is the git commit id of this change in Linus's tree?

I think it has not yet been merged into mainline's master branch.
This commit was recently accepted into the tip (5th November).

Following is its commit ID:

a5834a5458aa004866e7da402c6bc2dfe2f3737e

Link: https://lore.kernel.org/all/176243356968.2601451.11559805061162819633.tip-bot2@tip-bot2/

Do I need to send another version with this commit ID mentioned in the commit message?

-- 
Thanks,
Avadhut Naik


