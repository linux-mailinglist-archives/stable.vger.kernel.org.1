Return-Path: <stable+bounces-169914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EAEB29769
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 05:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8362B17E99F
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 03:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD5325A359;
	Mon, 18 Aug 2025 03:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PmbYnkhi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uyj7jCEl"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFDA21FF55;
	Mon, 18 Aug 2025 03:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755488626; cv=fail; b=diSJqa71RCeEaDh61ynGiKgCbcOyaneZT5eA4QefvOImzaaGpsPG3rjtx5Xbji8gOWe99nbPQ7vaEj43UJ4TettRSJFGN+A2NP3xBkuyXeJiR1RqNWHjp/qHSBeEh1CTp/u//fAnX8k8qjHOXle9kr0Z57X8RD34aI45SeLKgh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755488626; c=relaxed/simple;
	bh=JJ5tg2Ikjej2IEyNI+RfCZwA9fq+lLFKlglHEtiYaEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ih+AEskxYDn/SWmJTApexkAIYpguZ47jpf5prgxsCPM0DewzNOu0h3iXDOOG+ZFy8D0tNRTtBu6TbwbhHv3Nmu6tnBM0M5uJG5WpqNYrBL+e8DyawZYquJubH1fwiXhY38udNABvNd1ySO+2h0vnvDwzMbENhORCS6tzvSgbXAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PmbYnkhi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uyj7jCEl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57H2vklV003146;
	Mon, 18 Aug 2025 03:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZSesWDJQCsSXyGQjEtDj3dWrysCfUcZPyXf+UDDIx2I=; b=
	PmbYnkhi0qHhdN852G71Wo94ONI8vvO5sXIaI+TZNlqKhBX6/W+0WeUZEH3Gm4//
	U/GmC92sVp2rzTIzqbfJ0CHiojyvCB8NpFE6Vf1SUStMXb7yIxb0G87fvsH63Vz1
	V4vQUuzGu47f7rgfgnNllQ63Vio6kg40dVwhy6pXfFkrDitBjmIWRLp5VJkmnDe5
	1pzrFpq6AR1h2LiRQs0DKJCZnFDTX66t3Ed3NkQ0LAC2oTY+mFqaXmSFsRe+p+MG
	J3CBB9hMSvY67TB7u5VtvsNuhTZ0imkLYQwd0GcKT+Bm/j5r1yVyEf2JBa/9mufa
	d0vWn1OI2kjwFewou+8SYg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jhvda107-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 03:43:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57I2BFVi024459;
	Mon, 18 Aug 2025 03:43:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jge8cpdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 03:43:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ick3xLq7/LfsjpOZIGJz9HatgmpG6op6K7h7DDtp63h0mc1V8MXEtpASafGWBUehts2DasfVjf74msDjwB7bPNCpX5qE4wLZ1DiKFHLvoIS4P6OSCdrGxZaEw87Y/O8MlgpVIEmJC4Hjnw4sXWYYBR0nDXGsuE09LkO6BZ3zDoM1pVqmgtP73eIhVTBgfv8oOlhxANcBnIjArmBPQY2U2ktuy47Qj2NHSu5i7PCddSUmPmmCDLwEO+SxHCS1u+CdOFaqNLuxahJg+ugeXKVuZEjrSG5YF6bqbvPLTcVdIz28Z7HJU52vgcuuEXAWeprWVocLP1J2MFh8ILd93J7iLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSesWDJQCsSXyGQjEtDj3dWrysCfUcZPyXf+UDDIx2I=;
 b=h5D+L5ncyNqkBJ2Wsp0/EF2ly5s9S5M+2AzhK1uxD+Zsyzjkil/zL8rgwdQ3VOo3P+CruYfwcRYX758kTgRoAK3twnkeJIdaM53fe2lkyTRv2O1qJ9QrcLIqSyr/CYjmPqIwwxDF06Pf1NIr60OyhDCdb8kMxP4E7ctnvXXmzyTgXbxcrRn4Wc7dIB7xUVWbJjV4k8vVA2OONlytVAzp6mE57nGIjcYq2qcXS1y4Kp15f/WahHnrh6m2EPsykxB8XyQR+U+2s7m0cCzUa9n+SV2irdE09Z8k5Y9fbPmS8gGz5P++SgANePrJUywNJPRhwsXdYVct2CrfEEcijSSZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSesWDJQCsSXyGQjEtDj3dWrysCfUcZPyXf+UDDIx2I=;
 b=uyj7jCElY4vixEnnFSmkwOwiJRoGqylMSH6q2gSjfV9ZsqV10Y14QPNSCCpW/LiBF9Ug4kmI0B8di4Oy4sPkeh+5z9aG9eRxNtW7pRSNiukiUA36c0VfjN6MnWMf1uABmDTLDzmSvMJXOWNwsfV1zemHjTMe7Ws2XciOGOTq+os=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB5103.namprd10.prod.outlook.com (2603:10b6:5:3a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 03:43:22 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9031.019; Mon, 18 Aug 2025
 03:43:22 +0000
Date: Mon, 18 Aug 2025 12:43:14 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: yangshiguang <yangshiguang1011@163.com>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, glittao@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, yangshiguang <yangshiguang@xiaomi.com>
Subject: Re: Re: Re: Re: [PATCH v2] mm: slub: avoid wake up kswapd in
 set_track_prepare
Message-ID: <aKKhUoUkRNDkFYYb@harry>
References: <20250814111641.380629-2-yangshiguang1011@163.com>
 <aKBAdUkCd95Rg85A@harry>
 <14b4d82.262b.198b25732bb.Coremail.yangshiguang1011@163.com>
 <aKBhdAsHypo1Q3pC@harry>
 <22a353bd.1e2b.198baeeac20.Coremail.yangshiguang1011@163.com>
 <aKKObGA7TN4Vq9-W@harry>
 <29914f11.25c5.198bb06a343.Coremail.yangshiguang1011@163.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29914f11.25c5.198bb06a343.Coremail.yangshiguang1011@163.com>
X-ClientProxiedBy: SEWP216CA0036.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: 522332c2-f65f-4b32-2476-08ddde0960c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDM5eVQ3ek5IYlhrUHl1R3dLQjNqTFNYeFlaMmhYeE80KzFmOGxIRnVZcEt5?=
 =?utf-8?B?L3dTdDRJR1NKcnNBM0ZsRWs3enpjQmRQeXlnUXNmSkRQb1JCVy9qNlNza3Jv?=
 =?utf-8?B?TGxzTlRkV2E3S0NZMGRYTmd5Z3dhSThpdE4vTHhqcTNpUGlLRE5lSDBuczhV?=
 =?utf-8?B?bUhheWltRzlBR2crWVZTc1RyUktTNVlVV2tjYlRDVjNBQUYvUHhRdUs3dTVr?=
 =?utf-8?B?SVFiT2pvWDhCaUhzc0ltSExETzliMHdvSkJ1U3l5QmVrY0NLWmFRTDRkMWhw?=
 =?utf-8?B?UWtSOExkWmVOcUJTMUk1b05uNWI3U2RMMFFmeGE5cTZXODBPT0x2Z2dzVEVp?=
 =?utf-8?B?N1JBekIxVm4rdkhlY0FwT2swdG5IU2lmMmZ4c3FQdnR6Mk9wK0YrMzNqQWxV?=
 =?utf-8?B?T3ZyOHJDN0dNQjMrU1pEcitLdWUyQ3NnMnNyQk54d1NYTkViYU5FOVozakFm?=
 =?utf-8?B?R002VW56SVBOYnZDSkxVUXJqSG9WMWxpMTU0dGkxYW4wUlZuWDgxWHBpczNG?=
 =?utf-8?B?cDY0MzFTckN6K0tMdFBVaG5lSmxGUXNmYXh4SWFycVRMcXo5WUpZZzhBa3BZ?=
 =?utf-8?B?clNxTVVhZ0FyaUwxYmpTSGJLMkxNM1BTV1lrTjV3YVovekpSWEM2bjlEMUVZ?=
 =?utf-8?B?TW93cE5qZnpxVSswQU1aTnNEY2lKZFlONWdtVlFHM1J4bW84Qm0xZUZsaVNx?=
 =?utf-8?B?alFodU9rSGtvQ1gxMlI3VkV3T21KaDQ5YlJNaFREQytuMTZzenpoakJoU0Fr?=
 =?utf-8?B?QUQzbVVjZjNQa21KbjdOdHh1ODhOdVhOd0hsa1NkZ1BKS3RvdmdCNG5pZlpy?=
 =?utf-8?B?TW4yMkN2clp5MGx2akhXVFVOQXpCSHYvMzMyMjNaMEh5OXMyTUZlZ1J4NEFJ?=
 =?utf-8?B?U2RlVDU0RFNWT0dFOVhuUWl3NURhTE9SQk51VitnNTEyVWNWM284MHZRdTNV?=
 =?utf-8?B?T094QkVqT2NJWjZmdTVlZHY2RjIvNExVc2NXRjVEUDc4eWUwQXVUOWluREVX?=
 =?utf-8?B?bEJ2WmdTU1VTN1JMcG1vWDNwajBkZHFvVkFVbkZ3NlV6b0xzY3FxNXVmMG1o?=
 =?utf-8?B?Q0t2NFRnaE10MXdwalJTK09XWmVWcTFqcTdQazBzTmFXRVNYdEZFUHI3Q1RD?=
 =?utf-8?B?aG5aczFBRVVBUzZOZDc0QnZqNDM2djRUdWNJZG1CRk1DRjVkeEhpNG93cVFK?=
 =?utf-8?B?WUdyS1NGQk4yRmpIcVZMbHpWT3RRQjg4NWdlSDBoZjgwaGpwMnJnSHE5RVh2?=
 =?utf-8?B?em4xd2ZvUUkrNzJHTTQrSHZzQ2Fzd3grOXdORkFUYmN1enNYbVVMczh6a0E2?=
 =?utf-8?B?c29jMHQ2emFybHFHOTFtWXhIeUxYelVUb2dCRElNanVxTi80MmRoUVJaemtr?=
 =?utf-8?B?cXZ2aEhWUTN5T3dYSkpKcm9JTklzV29JbCsvc2R1dkNqSGJJWkVFODhNdEpY?=
 =?utf-8?B?NlA3Nm5qaXRnUEdjaDc3bjBIMks4L1lGUkl4Y0ZTZGZSUlRlVG1OdUVNNlVS?=
 =?utf-8?B?Ulh0MDJyc0Zxc2pON2VHYjNLR1B6NTkycG9JQ2xHRlZkL0RtanVmbWlwYkhM?=
 =?utf-8?B?RGNZVG45b1pIdUVoZTREQ1h2S3B3MERqVURjYkZhdzFodnFPSkNJQ2VkZ3By?=
 =?utf-8?B?VGZadldUeUdDbFd4dHpzVkI5SVpkN3I0cGJxeDR3ZVptazBESUQ1Q3JGT01t?=
 =?utf-8?B?cDF0MmlJL3IwcWlWZFF2NnNuUU00emZKaS90eEx1NlplbzNNeHNWcnpBTm4x?=
 =?utf-8?B?cHJ2QWRpUlZVcWs4aXhIcytOcElUTEdvMEhaQ1l4N0MxbXNHaW1pbmFSdksz?=
 =?utf-8?Q?muadvM1HkqPNk5QlQzvcbdVbB/mX3qAzR4FTI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlNHVGJmM2F5UjA3NGtMdXZzYlYvUWhoSXdiYVVHSE5OaS9rbVd4cnkwcXdi?=
 =?utf-8?B?SXpiWmZ6dEpTeTdZMTc1aHNNR3R4NXk2YnQ1R0FRN2tFMFpLeVgvV0E3Ky83?=
 =?utf-8?B?UmtFVXVBN1hGSEY4Tk12SlJOcXZNWC84UnNGd0dSRXp5TnNZL24yeEdkaG4v?=
 =?utf-8?B?d2I2aU9VUStsL051ZjRMbzQ2RS9IaTFyVUlsbk1DM2c4QllLUm1wcUJWa3VQ?=
 =?utf-8?B?MXZUWkFJN0JOL3lvelBqMUJUYlVqdmp3UURQUXZjM3JDQU5MYlVWNjQ1KzR0?=
 =?utf-8?B?dVIwWFdQUEhQcFpFc0dBSTMvdUNpRERuQ1p6SjltTTJCMXN1VnlDR2hXVnV2?=
 =?utf-8?B?NTI3WnV3U1lBZmNFNHdMMmxkU3RrME02OG5xWEVRL0pFRHdpTWhLaXN6MVJj?=
 =?utf-8?B?MFpOTzk1NWFMOW45WkRNNEpMWXNhdTcreHhhamN2WW1ySWtHSWNaVWJHSTNE?=
 =?utf-8?B?c3pJVUErK2NocDZSU3orRFdkYmNFcFdscW8vWkNQZFhzTVQyZmJnZEh3L09y?=
 =?utf-8?B?bkVFSzlNTlRRZmhmZ1owTGxLMDRZREZRUElKMG9FQVBTWkQ2NVBPQUk4ZkdV?=
 =?utf-8?B?aDYzQUpBOHNsZ3FKTlFxRnE4Z1FVWFcxTUczSFAyOHRzQ2c5Nk1rNmZaQkkx?=
 =?utf-8?B?K3p0UEcxTStFRWF3TUpLb3RYb3BGckNFNlNOWGRaejI5OHdheTJQOXBVZGN0?=
 =?utf-8?B?RVRZOWZ0TUZzdnlobjk3Nk1RY25NVWswUjBiTDVCTzc3M0ZrTXpTV3dBeTg2?=
 =?utf-8?B?SVhBZDhCZUg0QXU3dUpKSDlwVjhHZG8wS1NuT3pTcXFQaHpmRWhWRjY1aGpq?=
 =?utf-8?B?ZEpuRE9EZWZQa3BWbkF2SklSV3oxQ3dEb25wYTR5SkxJajBPUDRvZEZ6azI5?=
 =?utf-8?B?KzJ2eTM3OUw4RHdRc2dHZ2FCT0QzU2F4STNINU1EUXBBTFZPTXQ4ZXhRZmZ5?=
 =?utf-8?B?NEZ4cE13WTlhS05lWnBjRjgrVzM4MnNFZnR1ZVdLZm5USnVUdlh0UEtOSXYw?=
 =?utf-8?B?Y2haOWZkNUNiTGpKQ0FTanJqMlMrTlVrMndmRERFM2R3WmoxdGhsVERYN1lC?=
 =?utf-8?B?N29INnB6ZHJEbTFabUFkY05GMmdMbzE0cHhEeU5zWlBIaG9oQU1PQk1JRjU2?=
 =?utf-8?B?WktUdmJLc2dxdlZJcHVsV05Yb0hweTZWSXY2Z0JneXBPVklDZ0tCa0NyMGNw?=
 =?utf-8?B?czNUWjVUYXRKVjFBRHViVjRjeFBvWFdxa1VUSzcydEROSU5wU2ZVemJ0Vytu?=
 =?utf-8?B?QUlCOFpCS1g3Sk5ZT0pQcnZuSU45VjlJU1lLLzR2V3ZGQmJoR3MrRm1qaTJp?=
 =?utf-8?B?ZXoxU3RmeGtPVy8zUWgxT3VOZjJ5L0REUTBsQnNLUjNqQ2lRbGtwWEVZNHc2?=
 =?utf-8?B?WTlJMGdObDlxaUhrQmFONW1nU2RPWStFWFl6aTFKVkZGeTJnamJjSmUxUDhE?=
 =?utf-8?B?RXlKTzhwd25td013YmNiZEF6d1JPT2hKcGdvM29vczBySUhJYmQ3UVg5VDhr?=
 =?utf-8?B?bmpQa0E5T1FzUXZTVTJjd1Y0SG55RU9sVFhHVkRld0k2ZFllSnhGSDdYVVVG?=
 =?utf-8?B?d0FwVzgzeG1lS0dvM2E4eXBDTEtlZHY3L1hnQ2hBZXJIaC9zbTE4RVBITjQ2?=
 =?utf-8?B?UFdkL2VFZHRhQ1NWbU9kUkFlbnl4d2YyOWlEdW05Zm5rMnp4RDZpSnYzdTYx?=
 =?utf-8?B?VXBwa21CSDdtaDlTZUtqNXk4MEZtZlBwQVp3Uks4a1pTNnhWUWcyNFhkTzVj?=
 =?utf-8?B?dGJuR1VXdjBxam53b01rclFzbXhoZmxCSnArUEZEblZSZTQ4QXR2d1J0eU5j?=
 =?utf-8?B?Nm5Ha1R3WWhEM1l6TC90Q2NzV09pa085cFBNMnNOTVpJSHNhcW9oNUNiMElG?=
 =?utf-8?B?bmQ0ZWI0UWRXUklkaFBIckxzb3U1MS90OWJ3ZWZGQmkrZklWSy9mTUtyaU53?=
 =?utf-8?B?V0dIamI0K0R5Q1FhMlVjUmFnNHV1WS9IZ0hRK0JBQWtjWGtNSjMxRjh1Qk5m?=
 =?utf-8?B?bVBmTU1VVUw1UjBkbDRBRVdJaGJnODd2Vm5Lckkwc09wcVhTVFBudXNNakdx?=
 =?utf-8?B?RTk0VVRFaXJkbmlFVm1jZWRaU1ZFTTN3QlkzcFRtV0dUMVdKaDRPcktpZDcw?=
 =?utf-8?Q?YvM868wdq7yHb5w5gY9LTMbw9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z5IhL7gy77fBDQD5uNxRwmF0qo81m3geq9csagzqmeHM9QfZWafaKIna8aOFSO9jqpP8yK6BJaZnM8COjiekvdtMGO93nP9MfH/vswdymn7X7qr/MZlLL7ZuknnxC49THir/iqXeL3TSfNKrmxEXY11zaf35wnuiOHLObLJBSvxMPiHP3FI+G0MI22O5ydP+eBO6/l1XvsxQ0zNlo9L4gtFVMlj7TRAQ1EfBem2JdedvZFoB7L3BCO5kzatF0zehw0Z0wNO4talbsC7sTz6K6WpWz8Auzs/KWpUE4GEKfVR5+gwiYTeZhDf2jm2wujgsL5DPiGB4G6vTCcfVyum2lIkTwewtLLAZM1TWH8zlBNJXg6yEvKycLa2/lyeQzD1cLaXKjVZFjYvoq6X2JTAD1UbcNEgXC4K406ipsbkFHAMS1JmPQPljfdfjYLgBIzUhs/IygxpWLjngPnnOUC526Yj9ADwCr6gopJQtjIy+YtyBAqsdxkP+vHKvf4ZigeTRFEGFDqSCHK6md0o7JWo9aneWooDTHVvE7MttoxqINhhQsZOQOz58KVT8JC6UiK5nuhLH+jXc0ehqx3jJEgZlTPwD22leaCTjO4p2J7GyTWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522332c2-f65f-4b32-2476-08ddde0960c9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 03:43:22.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lih/vrDjwyrhLbRJ2m/wqJzqEKpb/DdCpgbxkEuuyQGGkUNKaSHGCIUyAxE0V37j8ZDRcdc5P0/1RO7H8xvQEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5103
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508180032
X-Authority-Analysis: v=2.4 cv=TNZFS0la c=1 sm=1 tr=0 ts=68a2a15e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=2FHxLdWbnGmy3qO3:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=Byx-y9mGAAAA:8 a=yPCof4ZbAAAA:8 a=IeNN-m2dAAAA:8 a=GVXxjlsDNwnK9fq2bxwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDAzMiBTYWx0ZWRfXylD6ZpilSmI/
 TtG50Hxf9ES0EPNShR72uqaSDn1ZnXVtVhAuGn25SC/GivQGzQ8QRHpNU6hCKYRrP2+KMJ/bGF5
 cfHnCOEUi7uQjopOg60uQPqfZumciXrf5BLJCwNdG3HJ49QpzVgjT/MLuIz6oEwfzXrjKxpJLGz
 E9EhdyyJJOwNw4HyrZhGUhesDnlgv+Vj3XEs7wF2r/IXu1gclI7c7ZBJ84ygX0HNfu8gG1cnT9F
 QRVxdeWANUHTKNBc/Ba2MqqylAWHcjcASg/k5KjtfIO3yJHifod/zF6uyDsjhUaEFFWyIIXMt8G
 7pjCEQb8TV0m8arW1R7kaS0hd0jIcRaAHmQ4ljXqAuoQRxbs75+ykL4eTMuSIBXK3sOIr1cjd2+
 4OBrsj1ikpbmQiM1qZOVfhB8aKFO55ahHP+7s0sPh+Al0Hs3b90F0h67Ey74kIT5sWK4Hd9P
X-Proofpoint-GUID: jqGd3DTYKgaU7D_AuM1n0reDjWWwNMMm
X-Proofpoint-ORIG-GUID: jqGd3DTYKgaU7D_AuM1n0reDjWWwNMMm

On Mon, Aug 18, 2025 at 10:33:51AM +0800, yangshiguang wrote:
> 
> 
> 
> At 2025-08-18 10:22:36, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> 
> >On Mon, Aug 18, 2025 at 10:07:40AM +0800, yangshiguang wrote:
> >> 
> >> 
> >> At 2025-08-16 18:46:12, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >> >On Sat, Aug 16, 2025 at 06:05:15PM +0800, yangshiguang wrote:
> >> >> 
> >> >> 
> >> >> At 2025-08-16 16:25:25, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >> >> >On Thu, Aug 14, 2025 at 07:16:42PM +0800, yangshiguang1011@163.com wrote:
> >> >> >> From: yangshiguang <yangshiguang@xiaomi.com>
> >> >> >> 
> >> >> >> From: yangshiguang <yangshiguang@xiaomi.com>
> >> >> >> 
> >> >> >> set_track_prepare() can incur lock recursion.
> >> >> >> The issue is that it is called from hrtimer_start_range_ns
> >> >> >> holding the per_cpu(hrtimer_bases)[n].lock, but when enabled
> >> >> >> CONFIG_DEBUG_OBJECTS_TIMERS, may wake up kswapd in set_track_prepare,
> >> >> >> and try to hold the per_cpu(hrtimer_bases)[n].lock.
> >> >> >> 
> >> >> >> So avoid waking up kswapd.The oops looks something like:
> >> >> >
> >> >> >Hi yangshiguang, 
> >> >> >
> >> >> >In the next revision, could you please elaborate the commit message
> >> >> >to reflect how this change avoids waking up kswapd?
> >> >> >
> >> >> 
> >> >> of course. Thanks for the reminder.
> >> >> 
> >> >> >> BUG: spinlock recursion on CPU#3, swapper/3/0
> >> >> >>  lock: 0xffffff8a4bf29c80, .magic: dead4ead, .owner: swapper/3/0, .owner_cpu: 3
> >> >> >> Hardware name: Qualcomm Technologies, Inc. Popsicle based on SM8850 (DT)
> >> >> >> Call trace:
> >> >> >> spin_bug+0x0
> >> >> >> _raw_spin_lock_irqsave+0x80
> >> >> >> hrtimer_try_to_cancel+0x94
> >> >> >> task_contending+0x10c
> >> >> >> enqueue_dl_entity+0x2a4
> >> >> >> dl_server_start+0x74
> >> >> >> enqueue_task_fair+0x568
> >> >> >> enqueue_task+0xac
> >> >> >> do_activate_task+0x14c
> >> >> >> ttwu_do_activate+0xcc
> >> >> >> try_to_wake_up+0x6c8
> >> >> >> default_wake_function+0x20
> >> >> >> autoremove_wake_function+0x1c
> >> >> >> __wake_up+0xac
> >> >> >> wakeup_kswapd+0x19c
> >> >> >> wake_all_kswapds+0x78
> >> >> >> __alloc_pages_slowpath+0x1ac
> >> >> >> __alloc_pages_noprof+0x298
> >> >> >> stack_depot_save_flags+0x6b0
> >> >> >> stack_depot_save+0x14
> >> >> >> set_track_prepare+0x5c
> >> >> >> ___slab_alloc+0xccc
> >> >> >> __kmalloc_cache_noprof+0x470
> >> >> >> __set_page_owner+0x2bc
> >> >> >> post_alloc_hook[jt]+0x1b8
> >> >> >> prep_new_page+0x28
> >> >> >> get_page_from_freelist+0x1edc
> >> >> >> __alloc_pages_noprof+0x13c
> >> >> >> alloc_slab_page+0x244
> >> >> >> allocate_slab+0x7c
> >> >> >> ___slab_alloc+0x8e8
> >> >> >> kmem_cache_alloc_noprof+0x450
> >> >> >> debug_objects_fill_pool+0x22c
> >> >> >> debug_object_activate+0x40
> >> >> >> enqueue_hrtimer[jt]+0xdc
> >> >> >> hrtimer_start_range_ns+0x5f8
> >> >> >> ...
> >> >> >> 
> >> >> >> Signed-off-by: yangshiguang <yangshiguang@xiaomi.com>
> >> >> >> Fixes: 5cf909c553e9 ("mm/slub: use stackdepot to save stack trace in objects")
> >> >> >> ---
> >> >> >> v1 -> v2:
> >> >> >>     propagate gfp flags to set_track_prepare()
> >> >> >> 
> >> >> >> [1] https://urldefense.com/v3/__https://lore.kernel.org/all/20250801065121.876793-1-yangshiguang1011@163.com__;!!ACWV5N9M2RV99hQ!JMgEQrzDS3VAAKdSyj3ge_ZLG1QWaEHA7hH5uL7_Js06GM5m1sYGVOmJHkiTuOeaiE-IizWyvPNtiwzH291FRIojhPs$  
> >> >> >> ---
> >> >> >>  mm/slub.c | 21 +++++++++++----------
> >> >> >>  1 file changed, 11 insertions(+), 10 deletions(-)
> >> >> >> 
> >> >> >> diff --git a/mm/slub.c b/mm/slub.c
> >> >> >> index 30003763d224..dba905bf1e03 100644
> >> >> >> --- a/mm/slub.c
> >> >> >> +++ b/mm/slub.c
> >> >> >> @@ -962,19 +962,20 @@ static struct track *get_track(struct kmem_cache *s, void *object,
> >> >> >>  }
> >> >> >>  
> >> >> >>  #ifdef CONFIG_STACKDEPOT
> >> >> >> -static noinline depot_stack_handle_t set_track_prepare(void)
> >> >> >> +static noinline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
> >> >> >>  {
> >> >> >>  	depot_stack_handle_t handle;
> >> >> >>  	unsigned long entries[TRACK_ADDRS_COUNT];
> >> >> >>  	unsigned int nr_entries;
> >> >> >> +	gfp_flags &= GFP_NOWAIT;
> >> >> >
> >> >> >Is there any reason to downgrade it to GFP_NOWAIT when the gfp flag allows
> >> >> >direct reclamation?
> >> >> >
> >> >> 
> >> >> Hi Harry,
> >> >> 
> >> >> The original allocation is GFP_NOWAIT.
> >> >> So I think it's better not to increase the allocation cost here.
> >> >
> >> >I don't think the allocation cost is important here, because collecting
> >> >a stack trace for each alloc/free is quite slow anyway. And we don't really
> >> >care about performance in debug caches (it isn't designed to be
> >> >performant).
> >> >
> >> >I think it was GFP_NOWAIT because it was considered safe without
> >> >regard to the GFP flags passed, rather than due to performance
> >> >considerations.
> >> >
> >> Hi harry,
> >> 
> >> Is that so?
> >> gfp_flags &= (GFP_NOWAIT | __GFP_DIRECT_RECLAIM);
> >
> >This still clears gfp flags passed by the caller to the allocator.
> >Why not use gfp_flags directly without clearing some flags?
> 
> >
> Hi Harry,
> 
> 
> This introduces new problems.
> 
> call stack：
> dump_backtrace+0xfc/0x17c
> show_stack+0x18/0x28
> dump_stack_lvl+0x40/0xc0
> dump_stack+0x18/0x24
> __might_resched+0x164/0x184
> __might_sleep+0x38/0x84
> prepare_alloc_pages+0xc0/0x17c
> __alloc_pages_noprof+0x130/0x3f8
> stack_depot_save_flags+0x5a8/0x6bc
> stack_depot_save+0x14/0x24
> set_track_prepare+0x64/0x90
> ___slab_alloc+0xc14/0xc48
> __kmalloc_cache_noprof+0x398/0x568
> __kthread_create_on_node+0x8c/0x1f0
> kthread_create_on_node+0x4c/0x74
> create_worker+0xe0/0x298
> workqueue_init+0x228/0x324
> kernel_init_freeable+0x124/0x1c8
> kernel_init+0x20/0x1ac
> ret_from_fork+0x10/0x20

Ok, because preemption is disabled in ___slab_alloc(),
blocking allocations are not allowed even when gfp_flags allows it.
So __GFP_DIRECT_RECLAIM should be cleared.

So,

/* Preemption is disabled in ___slab_alloc() */
gfp_flags &= ~(__GFP_DIRECT_RECLAIM);

should work?

> Of course there are other problems.
>
> So it is best to limit gtp flags.

-- 
Cheers,
Harry / Hyeonggon

