Return-Path: <stable+bounces-81456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F95F99351B
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A31A28314D
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E971DC079;
	Mon,  7 Oct 2024 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q10MGRDT"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E3192D6F;
	Mon,  7 Oct 2024 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322440; cv=fail; b=JVIGEFwcLQV2uhZzHkndpETT0KRpDaPDq9+2QRUJnbCLfx6eUT//9ynGHeJ1Y4c3/34dPMqT62TcPXj3EX8ogVvdNjmRdPrcbb/F5tPXOopYAX8oukKhZKTJjuGn0bWEsBUY8h0UpvZVP85VfFFgs9sAdEhdhGZkdIEFIgMuqkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322440; c=relaxed/simple;
	bh=2L14+KNdA2y31DHtmS3OcwSg10+2nIOzpmDqQJaF59I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F6rGCTgBfK2n4qY9u10VILrtWFk3poOLnoMYh4khQLOzuiH91SeqvIX+7tljDPG1bDlrZLqQi0pLTAoETMeoJ9Yf7qJL56rEuta29n6YT3g6VNm8TaWp1O8aNKiwfHnhH2biwAHL6gQMoqW5iLbkWGLszErmS/WwPbu72aWgO1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q10MGRDT; arc=fail smtp.client-ip=40.107.96.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOM3VklfRICSf/qZ30u//iw6yc/Njf1X1Qb481/yQb9CxUdtJH/5HCauCtESv9UpVP+muvyanH0vLj0E+wAzetAqQi2mXHFhWnST9Tl87MVs7AqK7gQheAuP6NNPbTiQisOLdoVvM2jB45it1DOa+jzhlQ+E9pePQaDXyf9e0h/qtLcVeCK7KepGaEK4s9jZw+pIhMMs9WshTExbZJRUkEMbiafMJQWllMDIKAGpgDjoYr92pQz0Og8vI8q7Tv+n+LHWf2iI0d1yRe7ZVkfQFY0pWt07X2oIe0kIrrkX/udzr9E2K1WRLnRxb0g1bBCsnzrwMDKNmDbPQAQQzG7RxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMsfpZ3tOj8riEHj+pCrpJbdaatlv/i7YCwrTf5L5+I=;
 b=WMY1ozOXYYEsHhEV5RMGPGsyI87TWCsSPRV/wFWfIbJwOnr/pKmxM01+AeW0Lan1d+lX1DXXMQkcWFX0tylXaiRDlasVDKM5jFz24kF71YRYuvySyZsyOkv2BQCN2ZzVYrKmzOskeNH3paCw6DXkvb47B4idT94lQxkP0ABXaCjkjT4r5bT3n+t2pLXmMbvDleoJ0DboFrzTU3nEd3xKNF4JVQTK6wUM7Vh5J295jwAhrE1AdeUo2RMOsDCTzc2NeHTZao52vpOdZRlgBWyc9urd91qB/wBcizCzh/CPb0ZjEKAbKmDwnut1++VgmVAnNb6QmM42p41KCunfnk+u7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMsfpZ3tOj8riEHj+pCrpJbdaatlv/i7YCwrTf5L5+I=;
 b=Q10MGRDTsCioZvKC2uGFGK1LH1eXlObmA9bMFH2+Tc88Z78SOs8RugV8i4MQf8GPa20R/+Y6yNIVk6mykjbL4wM44MmCD+gMu1vqK+pxOkPVEHWXzXFVnhHyJP3d7uXDDn4rBdxxPfvW8oCX2KNRUjAgxoesCnUTdZf7TT4D63o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 17:33:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 17:33:56 +0000
Message-ID: <5192a3c3-29dd-4249-9a69-fc4845ad419c@amd.com>
Date: Mon, 7 Oct 2024 12:33:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
To: Christian Heusel <christian@heusel.eu>, =?UTF-8?Q?Fabian_St=C3=A4ber?=
 <fabian@fstab.de>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "S, Sanath" <Sanath.S@amd.com>
References: <CAPX310gmJeYhE2C6-==rKSDh6wAmoR8R5-pjEOgYD3AP+Si+0w@mail.gmail.com>
 <2024092318-pregnancy-handwoven-3458@gregkh>
 <CAPX310hNn28m3gxmtus0=EAb3wXvDTgG2HXyR63CBW7HKxYkpg@mail.gmail.com>
 <CAPX310hCZqKJvEns9vjoQ27=JZzNNa+HK0o4knOMfBBK+JWNEg@mail.gmail.com>
 <1c354887-c2a5-4df5-978c-94a410341554@heusel.eu>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <1c354887-c2a5-4df5-978c-94a410341554@heusel.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0055.namprd16.prod.outlook.com
 (2603:10b6:805:ca::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f099271-59e3-4a04-e1bf-08dce6f63897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alBhQVlPOFZ6VlYyUDBjcFRFYUdPbk9kUHRPRDV3TEpXTFZPZnRFSThFYzZM?=
 =?utf-8?B?QnZ1NDBSMnRkM0pKelNrOUQ5VVgvdm5FVnpUaHhxMmpzcjRGZzJubC9uemIv?=
 =?utf-8?B?NUR1d0VPTmhFMVB3ZndYUE5ndTJDM080T29WZ0tOWStHbW5qbEZ2Qjh0UEsy?=
 =?utf-8?B?cHZiN3BBVnVoMkZ3c3BnUGVCMWtzSEVWK3Btc3g0YjJpUGd2b1VXcGdLckxX?=
 =?utf-8?B?TzFrOUlNelp0Qm9rNmNobDhMSWpacjRuMWZycXl3YTA1U2pSZDRDZjFZcU5t?=
 =?utf-8?B?WlFlSFl5RGF4Y21pZS93Z21jR2o3OGJZMkxycTQvNHVYUmNnZng4QWhxOGI5?=
 =?utf-8?B?K091VUo0VDZTZ2htMjNLNVVCci9icEJhZUM0WkRHQ2EraGd5WUVycmZ2VEQr?=
 =?utf-8?B?S2NNcmJQaVlCU0VUbURsRkN1UUlScEdUNlByVFRnZi93b2o3SlMvcy9MYktZ?=
 =?utf-8?B?UHlKMWdDS2tpNndWSXhZZzBTL3dtRlBweXMvMm1rK2k5UVdkc1BadHhxYURJ?=
 =?utf-8?B?cWpoYkRVNFJJQVlaK0tvOVBFVFNHT1JNZnF3enBzVzExL2EwbERWbWdvUjhM?=
 =?utf-8?B?RnF2RHdBSGF4MTVrQ0xBcUNZQ01pTDBhelJxaGZrYzVPSXBQU1hMSGw0aE1i?=
 =?utf-8?B?eXVXMWN2L2JyYlFzOUliM20rYlphK0VLTUZLN3JjNVNYTUhCREk4WXRYK0tP?=
 =?utf-8?B?WjFNU3VCOWN2ZTJmcHNKNXJxZm8wZzZlZlc5WXVQaXpqRkQzbHY4LzBOSXhD?=
 =?utf-8?B?YmU0bk5pUUlQL2JuVWI0MTY3anphV3BHZW52Wm5GcGoya0NVbmx5QnFMQnlW?=
 =?utf-8?B?TVNQNVZ1YWR4anRIRmxQL08yWVc1YjhreFJUeHVxVm0yUk1JQi9XVnpqUjhT?=
 =?utf-8?B?aERBNnlSM2czL2Q4Z2hpbjRUM0dTNW1pUGpTMGk0R3Nsc04zN0tlZXorNkVh?=
 =?utf-8?B?M25sM2ZNcG52Y1ZVWkJZSWpuaTcyTitEdjlyM2pXNzBGdGJEUjk2a2J6VUtH?=
 =?utf-8?B?ZEc5WnpXb1c4MkFHcUNpY0RtcWtGNFB1djJ0T1h1dldob1l1V3dqUFVFbjVq?=
 =?utf-8?B?QklHaXZNdjAwZnpaQU8zTEhDTlpLVnV5MWxKUnJrSERnNU9HeE56enYwYXVw?=
 =?utf-8?B?SW5xbi9xMVBRUmZZOWE1QmRhajA1WDZsSTFwdVc1VkFsUGE3NlE3THg2bGRl?=
 =?utf-8?B?amZSaVVNb1g5MUVXclllS0cwOUloY3hWb3FPYTlzM3RDN1B0NDJpSWZsMTlT?=
 =?utf-8?B?T043TTh2VzZtZFJrOGNpWHFQWFdZQ1EyRi91ODhOWTV6M1ljU2tkQ3JvMld0?=
 =?utf-8?B?dlo5VmllK2JSbGhlcmg1MTBPbDVjejR5Yldkem9jS1A5STFrUUdXV1FDbmh1?=
 =?utf-8?B?ZFh1OVNrMTVROCtwM2V5RndtRVVEVVVINVlzNkJiZFIwMUYxYWdlRm1FRnJ2?=
 =?utf-8?B?R2E0dERiWVBqQ2lRVGpDV2paQzB2eTB0aFlpK3hFSjJZSkhIT09UeHh1L0Fn?=
 =?utf-8?B?NFp1R0pjNVhIVEZaVGZyZWdTb2E1cVBPRTQ5ZEhrTk5wYUw4SVVmd2VIWGJC?=
 =?utf-8?B?SjhBbEQ3MFM4WExRVDVkenhwa3liMHV1K3dWc3BCeTdZL20rSFFCUWI0dm1I?=
 =?utf-8?B?TW9QeUQyUUJCREc2QjF1WWZOR244R2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDVnRjR4RlduL1VuT2M2MlA2Um5mbGx1RjNqbzFHNUZTTE1xYlk4MENsNmtm?=
 =?utf-8?B?VkVwVGQwOHJsSmlWc0dqd2VoMnYxY09XdVBLRmk5T1lLNnlHYkFycStIcDhC?=
 =?utf-8?B?RkhFRzNHMzFrOTdQVjM5NFJsNmhoRmF4ZHZiZ0lGK0ZxcjM0OGs5WlppU2NN?=
 =?utf-8?B?ZWZjSTVsZEdUdlR0cXhoME1rbGcxcnB6YTBwRkF6RnFDdU1nY1lqakltWEVu?=
 =?utf-8?B?eDQwMGFldDU3OWorRmhSRXhPZDFxK29JZlF1ZEVST281SlMwWDZTZDYwb2d0?=
 =?utf-8?B?ci8xN1BBNmFWS0hLY2xqYnc2d2hOa1J1d0dBWnhnMkpncTZGZGVkU1d3WlZq?=
 =?utf-8?B?QlEvMzBzc1lqSkdRUkJhZUJDbjRYRTZ6NGVPNUNhMy84Q1NteXhEZ29WeDh2?=
 =?utf-8?B?UFdibWhlL2I0WUtRWTNvZ0V1RktDWHhIMTBaV1dmaUtXeVBiTUxJNWp4S0k1?=
 =?utf-8?B?S1Y1K1FaTTFSc3QyVUpVYkRJS21DWkt2dVVhbXdZdWRadUlrWmM0MGpGWjc1?=
 =?utf-8?B?R3NhcHRLeGovUCtxR1VEM3RxQmhhSzFmcHFZT2Y1VEpZWHhUMkpyUWNyVUlJ?=
 =?utf-8?B?WEJZUzVHM29JM1FMR3lkNlFhWEZ5ekNMTWFHN3Vna3JwaktlU2FQQms1VUZY?=
 =?utf-8?B?YjFRbDNOYmNzQityOEZXTkpFdXF1TGl1ZTdjV2tHa0VHN0xUaEtZV2RxS1lL?=
 =?utf-8?B?MVI3Q0NlbmNCMVRBNnZoQncyeEpuM0VmdlF3cVpSaU9raXRVQ0ExWVl6MXVG?=
 =?utf-8?B?TTdGcFJoZlJvMDJNRWwyY0pWQjdtM0pjT1haejM2TSs1dGJ4QlAxdUdNUlRU?=
 =?utf-8?B?dGdMaVAwMlBLYWNjaElWYzJ4dUEweS9SLzFWMFplbGxpS2IyZDNLNENVcXpV?=
 =?utf-8?B?bURCdW5iY0NWdlppYUZCdDBsVW1pcFpsQVNLeEdSVUpYb1ZGbE4ySitnWm9u?=
 =?utf-8?B?am5Nc2Q0OUY1UXhQOHdPN1A4aExKUFlBSmQ5SEdRWkNWM3lLVVlEYXplanNz?=
 =?utf-8?B?YnZoeGowaUUvTW1ZOGVGNlNYMlNEL0dPdm54cmVQYWJ2ZE5DWEhkdExSdUI1?=
 =?utf-8?B?UVV1TVBIRWNUckZuSHRrbVNHdmNNeGx6RmhwdmJGMmlBZGZ3YXNuVUljZEhK?=
 =?utf-8?B?VE9Cc25ScHd4QzR5UWZkQUEvQ3VVS1JYdEZTSGRNU1hqb3ZwWjd3L3ZPQ3Ir?=
 =?utf-8?B?aDVYTGI1U3Z5T2QyNVp6c3drY1VSRU5BSUE3OURNeUNCK0pFZFVtV1FacXA0?=
 =?utf-8?B?QnFOSGNvbHcxeHFieU9DTHFha0MxU3l6a2lpUThCc2hnbzQ3ZkYrdXVsVUhq?=
 =?utf-8?B?aUhYWnNTdHhCQ0VIcW5zQUpYZFBTMUtvSXFIK2huK1IwQ1liL2l2NXEyVmF1?=
 =?utf-8?B?cUZmRzMxQlpEMW5mN2p2TnJ1UUwzbzdhMmgrQ3dSSm1wWExXRWVOM3p5S3RN?=
 =?utf-8?B?RG5BeDhDdG5NVjQwLzlvUWhLeWpMb0pIZXMwSmw0Tyt6akw3NHhONEdwMGY5?=
 =?utf-8?B?Y3czRlVvVy9SNzY2VDZmc1QwQ3lCdy9DYXc3SmpMTXdUd1pVek1zejlSUmZ2?=
 =?utf-8?B?NXBRUlVsSDY1cEVCZFhZRVJod2E0ODFGcml6ejhkSW9KL1RnbktYeE5DM2RB?=
 =?utf-8?B?L3NiK1owZ0gxdEplRlhFcThnZ2VvdG5sSGpkbmMwbVZHWTEzcXMrcGhVRWx0?=
 =?utf-8?B?d0tLUDVEQ3FXQld6RjYwU3BiZjlXclBybjR0RjRYV0o4K2toejhubDZnZVln?=
 =?utf-8?B?RUtZbk1ZaVQ3VnYzbFZwYy9mb3hIVmw2YmNvSkpjSDFYcXhyY01mYmVBSTdo?=
 =?utf-8?B?aU1OakVSeCtxMkFvcVlNVks4eU52V2F5cWpZQjBGbEFQbUwyUmt2d1dMZStN?=
 =?utf-8?B?OGdQV1VjWlRFckZmNGsvc0g3TFM0dS9kd0kraXF3TEFsdlZjRDhWcmZpS2Ez?=
 =?utf-8?B?MW5LUFpuaDFJK0YyU1JWWHJRUnM4SkNkQjlEMEJvak1VZW96ZUFNZmRpNjJO?=
 =?utf-8?B?enhKd3lpZVoyNTdXYUs4U1EyekozYi9GVm5ueGhlK0VlSVlJUXlKa2RsVEZt?=
 =?utf-8?B?RTQ5QVNPUEo3eDFxbU1lUG84UW9DRnU3aTdoaDlGWk5nNmhVdytaYTk4OFoz?=
 =?utf-8?Q?rLY8R/PKaMjJi69MhaZTP7VQ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f099271-59e3-4a04-e1bf-08dce6f63897
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 17:33:56.6806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJxrDQ4S6dYOMHAFLXl/sp5R8PSxf/yaQbEBTLmpV6sr3nn+YtiCCcLe1msJIi408U73MhvDodloEx9ZKVMm0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226

On 10/7/2024 12:21, Christian Heusel wrote:
> On 24/10/07 06:49PM, Fabian Stäber wrote:
>> Hi,
> 
> Hey Fabian,
> 
>> sorry for the delay, I ran git bisect, here's the output. If you need
>> any additional info please let me know.
>>
>> 3c1d704d9266741fc5a9a0a287a5c6b72ddbea55 is the first bad commit
>> commit 3c1d704d9266741fc5a9a0a287a5c6b72ddbea55 (HEAD)
>> Author: Sanath S <Sanath.S@amd.com>
>> Date:   Sat Jan 13 10:52:48 2024
>>
>>      thunderbolt: Reset topology created by the boot firmware
>>
>>      commit 59a54c5f3dbde00b8ad30aef27fe35b1fe07bf5c upstream.
> 
> So there is a commit c67f926ec870 ("thunderbolt: Reset only non-USB4
> host routers in resume") that carries a fixes tag for the commit that
> you have bisected to. The commits should both be in v6.6.29 and onwards,
> so in the same release that's causing you problems. Maybe the fix is
> incomplete or has a missing dependency 🤔

You mean mainline commit 8cf9926c537c ("thunderbolt: Reset only non-USB4 
host routers in resume").

> 
>>      [...]
>>      Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>>      Signed-off-by: Sanath S <Sanath.S@amd.com>
>>      Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I have added Mika, Mario and Sanath to the recipients, maybe they have
> inputs on what would be useful debugging output.
> 
> In the meantime maybe also test if the issue is present with the latest
> stable kernel ("linux" in the Arch packages) and with the latest release
> candidate (you can find a precompiled version [here][0].

To double confirm, does thunderbolt.host_reset=0 on the kernel command 
line help your issue?  Based on the bisect I would expect it should 
help.  Yes; comments on both 6.6.y as well as 6.12-rc2 would be ideal.

Also assuming it helps can you please post your dmesg from 6.12-rc2 both 
with thunderbolt.host_reset=0 and without?  A github gist or a new 
kernel bugzilla are good places to post it.

> 
> Cheers,
> Chris
> 
> [0]: https://pkgbuild.com/\~gromit/linux-bisection-kernels/linux-mainline-6.12rc2-1-x86_64.pkg.tar.zst
> 
>>
>>   drivers/thunderbolt/domain.c |  5 +++--
>>   drivers/thunderbolt/icm.c    |  2 +-
>>   drivers/thunderbolt/nhi.c    | 19 +++++++++++++------
>>   drivers/thunderbolt/tb.c     | 26 +++++++++++++++++++-------
>>   drivers/thunderbolt/tb.h     |  4 ++--
>>   5 files changed, 38 insertions(+), 18 deletions(-)
>>
>> On Tue, Sep 24, 2024 at 8:58 AM Fabian Stäber <fabian@fstab.de> wrote:
>>>
>>> Hi Greg,
>>>
>>> I can reproduce the issue with the upstream Linux kernel: I compiled
>>> 6.6.28 and 6.6.29 from source: 6.6.28 works, 6.6.29 doesn't.
>>>
>>> I'll learn how to do 'git bisect' to narrow it down to the offending commit.
>>>
>>> The non-lts kernel is also broken.
>>>
>>> Fabian
>>>
>>> On Mon, Sep 23, 2024 at 8:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Mon, Sep 23, 2024 at 08:34:23AM +0200, Fabian Stäber wrote:
>>>>> Hi,
>>>>
>>>> Adding the linux-usb list.
>>>>
>>>>> I got a Dell WD19TBS Thunderbolt Dock, and it has been working with
>>>>> Linux for years without issues. However, updating to
>>>>> linux-lts-6.6.29-1 or newer breaks the USB ports on my Dock. Using the
>>>>> latest non-LTS kernel doesn't help, it also breaks the USB ports.
>>>>>
>>>>> Downgrading the kernel to linux-lts-6.6.28-1 works. This is the last
>>>>> working version.
>>>>>
>>>>> I opened a thread on the Arch Linux forum
>>>>> https://bbs.archlinux.org/viewtopic.php?id=299604 with some dmesg
>>>>> output. However, it sounds like this is a regression in the Linux
>>>>> kernel, so I'm posting this here as well.
>>>>>
>>>>> Let me know if you need any more info.
>>>>
>>>> Is there any way you can use 'git bisect' to test inbetween kernel
>>>> versions/commits to find the offending change?
>>>>
>>>> Does the non-lts arch kernel work properly?
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>


