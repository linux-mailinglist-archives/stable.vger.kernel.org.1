Return-Path: <stable+bounces-209934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DECD27F3B
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 20:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8B92302EAFC
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3153BFE3B;
	Thu, 15 Jan 2026 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rpUQVAcC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FlSM3fns"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E32D6E7E;
	Thu, 15 Jan 2026 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501041; cv=fail; b=gL+0oGap+IiAdXhU0NlUJQvLDtLdCnvDMM/rmT2v0CdF6ifQ7LaT/oMlBD61F42WU99Di15uUbllrEGXEhaWeZKlyDDoRtGIN3uhgOyNPHEzW4ta9JdbY9N30q4DBMyyEG0NGS/IphaahYd1lNU9TP2o11opCLTDfw4bp/qNz7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501041; c=relaxed/simple;
	bh=BTlUZfTZYAW8T37t1gY2gRKWy4ei5QK5VVcOm4EowS0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eZp/xHFpkniJk3Ta5JHBwmbSAQph+tUouKVjK2b3c4taEW0fE6zeAPPU6ulpZLVww0U702zkbVMhMbP3Vmy7bZoSt2j5yu5AvJvV3p1JL4/tdQsqqGmhriwt4TZEnV8OlkRiTxSoEaD4AIjCG7LVLlGUTunsJZc2fCwcSnWmp/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rpUQVAcC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FlSM3fns; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FEfmur1362564;
	Thu, 15 Jan 2026 18:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hv/aFMxd4qY/Uk93b2jtOJL108Da4ADECt+qWuTpX18=; b=
	rpUQVAcCoWv4uGHNi06B44S1drxtoG7T6vcy2xYAADUHF5hn4S29u6MouX3tg7mW
	mfSZW2Odf4LV9NMF+tT3xzVfLhKkOg644Ikz2DvPrb+ipVdM/Do99PzLgARRFX4e
	bVNuo5Sr0g2MewCg0Qie0fkCgD+uacV6pAooaT+xyYMisNmn2LdGA3kTOjwvSn3W
	9kVL+FPEZWRDZydrG4lopv2fnuzehpaZlee8dovp0oD2rhMmgieCma8KfTkMNoam
	CZtAfZrvNuny9JLesa1IROiu5cHynvgrtLKX6RpVu10PnSJNb9QIEvWm6i297otk
	DOzkrrun5oMAxV+BlXzZ/w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5vp3mt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 18:16:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60FGeeYm032680;
	Thu, 15 Jan 2026 18:16:38 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7bmwxw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 18:16:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSHJUSmKRQxJvsrZylSlFo2rpzCRFkFjEhElTftTTauw3RGoO/SwiAAmbENKOjBwUNaS1bTIDXmRWePME9VfTpPxrD/fxru/3UzBeXfXiWdWf2HEDIrk5pSXOZxM1xaXAPpBftHHRELLlwKyIeSoSNXKKW4w6QXB99Ea7Fgs/eQNsV4HlyhgVOw7LPaYJCKouhGM371WIry0AKrKPnMMMYQf9uThiD+M2w6HwQX0Xp+J3CK4B1KMDAELj88uR82X0XWpogVY5flQoeVgCSEJW4O7Vh3oEqH9Hj/5TaTmRlW2phNCXVnadluw/mZoSrgcokqcu1rHgJzx9w9iEuqtDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hv/aFMxd4qY/Uk93b2jtOJL108Da4ADECt+qWuTpX18=;
 b=Jtg7Yq/IQR6Wrxt6MASkNjZMqT9MNj+EJUCoqR588OBkq8CzR2a6ywXClEnrIrW5ipQnKw4jU/w3P84G1C+X8sdrIydvPnYOEr/2i09Yrkfs+xfG5fJGcYdPL+IB7UXTHyshYhKMsfikqS/N1dWDkcDXlkDr/egAl44MrQd8ug9CzdfloF6HzmSguKBsYcRyI2WHUoOCyx/4j8dz/HiyDbcrz6EjocaGXENlMzxxHCvPQHNFL6YuPa/mUM08quyN4zLE1xnoOHZNDN1uErCyWN2VBRWcGnbRZvof4RooPFRa9rEghBJA6G8mAABCHIFcpAA7JdudAyEiFF2oOOVmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hv/aFMxd4qY/Uk93b2jtOJL108Da4ADECt+qWuTpX18=;
 b=FlSM3fnsMylHuoDOXBegYKIhmLfhy27OV17lBdkrpH9Lccce6cFldbvf7JaosJNgtG5iGi6y2mgVAVv5XBnCq4XyUQR3zb7WxYq+xcUzTJVtSicK4zU0O+AG+7HhWwNxwLoeW4bHt70lJ2fjccUaN6b+sskeqkpgiO5YiC+mg2s=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 DS0PR10MB6149.namprd10.prod.outlook.com (2603:10b6:8:c7::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.4; Thu, 15 Jan 2026 18:16:33 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f%5]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 18:16:32 +0000
Message-ID: <b2c3d764-5869-4b5e-8496-0ab3de2855b4@oracle.com>
Date: Thu, 15 Jan 2026 10:16:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] mm/memory-failure: fix missing ->mf_stats count in
 hugetlb poison
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: linux-mm@kvack.org, stable@vger.kernel.org, muchun.song@linux.dev,
        osalvador@suse.de, david@kernel.org, jiaqiyan@google.com,
        william.roche@oracle.com, rientjes@google.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@Oracle.com, rppt@kernel.org, surenb@google.com,
        mhocko@suse.com, willy@infradead.org, clm@meta.com,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20260114213721.2295844-1-jane.chu@oracle.com>
 <e3b0033b-0506-2ec2-239c-93a7ac7b0c2e@huawei.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <e3b0033b-0506-2ec2-239c-93a7ac7b0c2e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:254::31) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|DS0PR10MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b17905c-e90d-402f-b0c1-08de54623637
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OUUyN3JDZ0VYcnFhbkk1RFgwNTFjNkxyZ09QSXh3S2RDa3U5aVkwNnRDK0V5?=
 =?utf-8?B?Wlk0ZHBZdzJ5aDI1T1ZsSmVFeTh2Zmh6M1pCQUFSZlk1UmRBcmVWbDFHeWVO?=
 =?utf-8?B?cW4vRm5GN3FqcmRMN2xjbjVTdVkrUlpjU1hmZ1BqdmJISUxHcGZCN3FEYWhl?=
 =?utf-8?B?NzY4Q2o0bmlDR2s5MkdYV2lWRFZMemdoZDl0VmY2SlZCYUVlYWFDUzhRN0Fm?=
 =?utf-8?B?aXJMNmE5SmJmc1BKZ2g1ckp2VXFhOWNGYSsxZ0l4Qm1qei83NFFsYkxMSVF6?=
 =?utf-8?B?Z2NYQmdndkpHNUZNVDgyUGRod205enpCUTFnWlora2JrZHNnMUtuejNiRUpD?=
 =?utf-8?B?ZXJRNTdmNy9LUUN3N1FjaTg2WDVoNDVoYWkyZEIxVFJkd2JKelMrQW9HbHRX?=
 =?utf-8?B?ditJTGt6NE9XcDh0c1lnZEtWYWdjTE96RWhONE5GWmVPYUtidlJKNEhxdlkz?=
 =?utf-8?B?TjZEMHlXQkk4MmF2MFI2bkVmSUhCYmlrRGRtTlRyQzZJRUFvOVpTaFg0R1Ry?=
 =?utf-8?B?M0huZXV5ZWhRN0ZBY1IrOW5ZbVp1b0lwWFB6RGhkZXNaUDB2WjJpZGJHNWps?=
 =?utf-8?B?MXdESjR5aDFzZm5ndGpyajV3OXdsZ3VLTWZVa3pYWnEyZlIvem9Pa096R0tX?=
 =?utf-8?B?UGdsWGorT0VNalNuMnJQSTNick5TOGo5bTcvQjNGbGE0NjgyTEtKQ0VlQmpZ?=
 =?utf-8?B?TmdVNWNHMHpmalhDQnAvRUFmeVAxb0NzRTVtQVZXMFZKZ3AyQ0U2Z1pkMkE5?=
 =?utf-8?B?NytlZ3BodWxYd3BiWGRsbnZKdGxQbjZLcnRaclBNWlhoSm96UWpGdG1WRVZv?=
 =?utf-8?B?a1dja010eTAwaWwva0pneEhNZmx6V3FmUlR6cnV0N3pCcFQ1aGVCK2dXMVRR?=
 =?utf-8?B?UWE5bTgzSFl5Wm1vbnNaOUxJR2h6UVB0RGNzU1M5U0FhamRiQUhMcXAzRmlm?=
 =?utf-8?B?QmR6bGhXb0xFZUFHbmlvMzlBMGRyM08wc1k5Z3AzTUpIZnB4eVNwZ0I3UnZT?=
 =?utf-8?B?L1ZNcCtuQWhzUlpyMDB2d3NBQkd6dE5TUFUzSWtsZU9oS3hmTElVQ2xGODdZ?=
 =?utf-8?B?cHJ0ekVBUFR2RlllQ0ZCd0E4TjhhVHMyZ1d4UE5FbUJEaGpTZGIxWDN3aUNm?=
 =?utf-8?B?c0gzcmVBWURXZnluN0J0OTYycHRybXVEVjYyb2NVbk1LWEtuT1ZzRlBHeG56?=
 =?utf-8?B?STlDM0xsaEg0K0FXenFsWHNtcUxxQkpVcDhpUjAyS2RVZWNvcmdnR0R0cTV3?=
 =?utf-8?B?bG5WV2RKSnh0UUZjUWFKMHhIMDBXblRmUXd0cTZXMTgxSlZZT2ZhL1M4cXQ3?=
 =?utf-8?B?WUJhS1crd1k2R1V2ZC9yUitoU2FLN2ZqOTFvbWgyN0pqdWtDN3puZGNwRFB5?=
 =?utf-8?B?QzFwMVgzVVB6ZnkxVVNhalZTTkZkZU9LK0llWnJwZGtCNDlqVVdHVTRJWVlr?=
 =?utf-8?B?TWpJV1Z1SU9WMTI1bTFYeHFTNEIyK2ZJbDAvelZGUnRpMzNnZVYvbjNEM2Ra?=
 =?utf-8?B?bFNkR1AvUHk2YWw0ZlAvc2xSNVFVYWJySHl2WFdWalcwMEJRb0lVRTFjTTBT?=
 =?utf-8?B?bGhMVGY5T2tCcTcyZzN5bE5Sd0ZsTTkzVHFZOC8vcHE3SUJYdGVBNVZDOUNK?=
 =?utf-8?B?amxMRkZIR09lbzJIOXh0aFJKSzkyclR2cU45aElraTdXSmFyRTlCVEp3eC9s?=
 =?utf-8?B?R1pWMWx0TE4yNVd4VXhyWmFHSFBoNW9zNVpHSFgrd2hqQzNSWWFKNlhHU0VO?=
 =?utf-8?B?SklSQ2lEVy8zVXA4cDVVNU9yMkQ3aXFLVklZREtqQ29UYjZjT0VnSUozVHpM?=
 =?utf-8?B?U2p5bHc4Zkh4YVZ6cXJaS0hIUDVWUTRIRC9aamMzMnZrRGtpdW5oYnZEajQ4?=
 =?utf-8?B?Z2M1bmkrcXhUQjNya25iaFV0Zyt1RjJHdXRuTzhKVForcFdabG42UHNxWHZn?=
 =?utf-8?B?b3VNbzR5WWl5MVRtOEVwcmhqZXVOZXZBZnNTbFZoQnFTeW1pSmVBM2dGYjA2?=
 =?utf-8?B?bS9rRVc2cWxadDhBRVJpa3J2MXpIUjd0aklJZmVRZ2pBWVF0ZWcvQnk5Vytl?=
 =?utf-8?B?cWxGMU5VSVFIaXprN1lJY2hUMHEvVzJTUnhBMExqKzRITnFKcGdnc3hnRkJN?=
 =?utf-8?Q?EqTo=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NkFseG56S0xObTV2ZFRwNjlRYmh4eVJBaXE3eHkwdzV6QzFLNmZsYnVpRFpY?=
 =?utf-8?B?MjhRVXFhQ0dZNUs0aThFZExmMUIrMGZNK3J0VmZJYk13aGtLSjcvV1UyM0dj?=
 =?utf-8?B?d205OXl1dmtPRWd2L1NtVTkvUHJNaFBPbXJYWW5GeTc5U2RPWFl2c29CWTEx?=
 =?utf-8?B?c2Vta3QxMmtpUW5KQTBIbjUweTE0QWdYMVhGRkNNYTBZTGx1c2hIZ2krSDJ3?=
 =?utf-8?B?ZWM5TVptcVJvS0FMTWRzRDEzSFJHZFA1cnZKTnNodHAxdHl5RE0vR1E1ckQ3?=
 =?utf-8?B?WmlIU1lOUkFSU0tKTnN5QzVSZFNYUHVkU2t0K1NrWmplV3lzem9QM2lQOUdw?=
 =?utf-8?B?RVFFSjZQMTdVK3pWNTJhU3NWU0J1WUpwZW5oQTVwMXYycVgyUG1rSzRJZ0hO?=
 =?utf-8?B?S3pwbXVyK2JPSXg1clhGcUV5Rkxpa0ZZOEp3N3dlbU5VbWNKNlk4ekxTYitC?=
 =?utf-8?B?Y1FYV0xnNzBlckFUeVhZOXp2UjdNdFltYVlFTWlkbVYyUFlPb1VFeEhsdkZX?=
 =?utf-8?B?eXM3WXQwVjA4NDQzdC9NcGd2NmVLSVR2ZGpCeXJnamdhLzlvYU9sTktEd1RT?=
 =?utf-8?B?TVR1WGpwUXh3cG5ZalQ5Ynl6RE55UVFieG03MFFFbWE5ckdhd1BZdGZCM2M1?=
 =?utf-8?B?YW9aSU5pYlJxMXdGK3ZVZGsydFdtWFFsdkJhWUw5aFBWWnNmYjhzdXVxNnZq?=
 =?utf-8?B?SjQ4cVJaaWUrNVA2MU1OTWlYdXAyWmQxOHRld0FBNTIrWUpUZmRZU1RzajdF?=
 =?utf-8?B?ZXNOR3diUmVGbysyRE9FaHgvbnZiMjBvbzc0LzFQcGYvRm9PbUNWRDdvZ1pv?=
 =?utf-8?B?MDI4TUZWMzBqeFFSeVA3OXY3OS9iNkFvT3VpbXZIYnJUczg3YjM3MksvaC8y?=
 =?utf-8?B?UzRHeFN1SjRiTDY5UmsxREdQOGh2OUhzRzUweGEvOHU0MHpHQlBOMDl3eUV3?=
 =?utf-8?B?cG5QalU4TzIxQ01QQzlzYS9JY09XWnBaRUdyT2N0cUV0dlZIOTJNcDZIRnZY?=
 =?utf-8?B?eHJHdFZBa1I4MnROYWJBcjJtNDBqaVZLYy9HUHk5UVprM3BBNGoxNWFJSDdE?=
 =?utf-8?B?T0ZRaTZ1V2YrOGpwa0UwdEhmRXdjQmZiaGRRZUowMi93azI3QzFlc2o4ZERt?=
 =?utf-8?B?YUptVSs2UXlFdURjSXZDL0FLSGpYbkF6cmt5aWw2MlRYOEFxb2l5VkJ4OUM3?=
 =?utf-8?B?cFAvN1VwQlR4N0xWT1lRaDZYMk9JbTEwam5KRGJXNlF2eU84UmVFd21LTXhh?=
 =?utf-8?B?c1N5eThrOFduMER0bHZDcHRTdyt0Q1RwalE0MnhBbmJxNllPM3oxanBNQVhK?=
 =?utf-8?B?YldZeC9xVjhkSnB6OWdKK1l0WFNVVjJFUWlYOU9TTSsvQWJvWFdWRG1PR2N0?=
 =?utf-8?B?aFk4d012MmI0cW9FQmpLMzFIMXVhYklUeExSaXZoWjJGMkcrbmpXMU9XY3Nn?=
 =?utf-8?B?NDI0b3o2RFhvUFE1UDd0ZmVLclVpV2VQZWxieXJOMDhzR2VlVFoxL0NRa1NY?=
 =?utf-8?B?TXJVQ3hidWRPUTVNNXNMWHRxREVIdXlKZDVaTS9wd3ptaHA0MWIyUVlLOStG?=
 =?utf-8?B?all6dVVEUStRYkxIaEd1cDlwdEIwZ3UzdlhFUHd1Rmd6b1p0TjgzVGFvY1Vi?=
 =?utf-8?B?djhYQnQ2NFpnTHE4RmIvam5ndlhRMnB4WWRDVmYxbVlIVlNRK1pDUEh6RWgv?=
 =?utf-8?B?ZFFqendyV25JRitrOFBnNzFPTllGc2c5UGVlZktUOWZpK1hMUnc5bkplcW5O?=
 =?utf-8?B?NzBMT05wNkF2dGcrY1MwanZnTUFkRWt1SzZPbTV1QUhXb0V3a3hKc29Db2Rz?=
 =?utf-8?B?dVRTbHlhOXhlRVBHTkgxODFNTFRGUjFQQlVUZnBxbitod05YQnNYNzZQYnRN?=
 =?utf-8?B?bnU3ZU5qaUlPMkNGWG4wM2FWZjVqcXkyY1prb3BHNEZqSkVkSStyYVFXTFlD?=
 =?utf-8?B?R2xRNFpBYjFkOWEvN3hkRm9MaG9mYitjYnhuSXFYZ052NkpOMkl4M0dOaEF2?=
 =?utf-8?B?R3crMGFjMkFqTllkalRZNmJpNTczQnpIYXNCS0xZVFExOFFtTkFKMmI4VTNF?=
 =?utf-8?B?T0w0MnVycld3MkpJZXNRRnNVdzgwMitNUHhzcGVzU2VCYkJvR0Ewa0RFZlhk?=
 =?utf-8?B?Y0JNL1pyeVJwMDRFOW1JR2JBQTZTRjE3WFphZStKb2g3WFVUNWJucTFYb3Ay?=
 =?utf-8?B?SEFSbHE0S1dvL0xIWFpZQVFtbHlKYXQ3K1Y1c2k0amc2bDZJdmhRK3JEak94?=
 =?utf-8?B?cHRDOVB3RXRkbmM5WGhJMElqaFI1Z0liVEFXUXM4VUFwajkwTlZqN3ZhQVgz?=
 =?utf-8?B?NjhjMzNCSzV0L2UrMW5zbzdBUExYQ3NvcHlDYWZNVElNNzhWbEpTQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1Fp6HgRFLBDys9wtmRGLro16ZuuKyvzBEIv6EL+FzW5BRytZHpEOLDSnau+jYpW4scAAX/Mw6ICfFYc006CGEpagt3ER+2Sl+AgmETp7kBPAjwQ5tC/DInPuQZ8H4tjbMrGhNnPHW3sed0pY3+c6cSxj4FRkl5lNsZoyUcKQZoaZF3/bXOg3ghG0VboQEPVi9IaTYzwaSJkWXNBZ5o+/dKdxjUhUZK8Wkc2p425pitpIMyEruCWjvKtl4ceRMXZ+UZyIfw6B7EdI/u85s1qcwf63PIsB6X7+awh0FDWwU1FthaCyQEvcRLuHHiTdNWLZQjlGMtEQlhHtdyHXx+Ur1AfmpGk1FmiA5Nap7YAfIWcawp3wT89JkU0gunsuJWTVkiGZN0W+3T7C09sgxDDEFZOhmyuJuRFygHGzujNOLbmcEszjkctFTDaQtk3krfEC3yDYnFhKiVTSl2Gq2RKZhZK6yn07u9BvHIadBpWZyBNgIcT/Iacunx75H7HA88hM93ISRRMqqk16+7baDBAFi3qNcNubo8JtTYeFn3Azw+Y4/kyPS8oRBv1cnvuHFgL89nshDDSwsZymPn8bXe8bMUXft+EAViG8eYy4XsLZkNM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b17905c-e90d-402f-b0c1-08de54623637
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 18:16:32.7869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmJQUPnQnmjNpoMU5fRkLV3LH50ez+lNVB8iVLfcOJyEdy5qqwJRPJOK833FqvTg7tJTL4/F5AOAmyquLXLU+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_05,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601150140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE0MSBTYWx0ZWRfX9uSXJM/i1hxN
 5BSpUllHMOMjJjWMCjwIaiyYtmtCPbNSy+AYp/sSy2aSbYT+zWOQYjkCv/Q36ZqX45KqnACp9NM
 Wz4yhnWEZCnQGGNo13TzH/9XTskHKab/XHT/ATxsebejnZCmN2wYHuy17l7yCk4eGT7oJHE/514
 Zl1N1dSDvw6yn8J12T2wO45BX4h1D6XH8bxNC9UfmHVOAwzQaQqp6/gLpAB6qpj0ozBq9UST/yr
 cAqdGznJ16yTOMMe2XYzjY4R8prJ2GDX7x0z0tprA5zSIyUtg0mtITFJGtDvnT/sVIsQsS13yF5
 VbdStMTvy8NljxuY8NoQZLavUqvTINQNFQSAUuqpy+g9Vq9vIv0iKprgiKxU/lmVdttGmvQZ9HE
 FrWnjtqApSut7gGQJAQUrXUANfxztnIgiOysHXGftyOP/JCj4SU9BNuxYf81sVK0wgWtaxETFvm
 ClxckTKaj4sS3xwhF+g==
X-Proofpoint-GUID: N7kZx_Ul_nj2WgtIzG9ykkYrQAFkskDO
X-Authority-Analysis: v=2.4 cv=aZtsXBot c=1 sm=1 tr=0 ts=69692f07 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=-CVUfUxe_pqqSKCYcoMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: N7kZx_Ul_nj2WgtIzG9ykkYrQAFkskDO



On 1/14/2026 11:31 PM, Miaohe Lin wrote:
> On 2026/1/15 5:37, Jane Chu wrote:
>> When a newly poisoned subpage ends up in an already poisoned hugetlb
>> folio, 'num_poisoned_pages' is incremented, but the per node ->mf_stats
>> is not. Fix the inconsistency by designating action_result() to update
>> them both.
>>
>> While at it, define __get_huge_page_for_hwpoison() return values in terms
>> of symbol names for better readibility. Also rename
>> folio_set_hugetlb_hwpoison() to hugetlb_update_hwpoison() since the
>> function does more than the conventional bit setting and the fact
>> three possible return values are expected.
>>
>> Fixes: 18f41fa616ee4 ("mm: memory-failure: bump memory failure stats to pglist_data")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>> ---
>> v5 -> v4:
>>    fix a bug pointed out by William and Chris, add comment.
>> v3 -> v4:
>>    incorporate/adapt David's suggestions.
>> v2 -> v3:
>>    No change.
>> v1 -> v2:
>>    adapted David and Liam's comment, define __get_huge_page_for_hwpoison()
>> return values in terms of symbol names instead of naked integers for better
>> readibility.  #define instead of enum is used since the function has footprint
>> outside MF, just try to limit the MF specifics local.
>>    also renamed folio_set_hugetlb_hwpoison() to hugetlb_update_hwpoison()
>> since the function does more than the conventional bit setting and the
>> fact three possible return values are expected.
>>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> 
> This patch looks good to me. A few nits below.
> 
>> ---
>>   mm/memory-failure.c | 87 ++++++++++++++++++++++++++++-----------------
>>   1 file changed, 54 insertions(+), 33 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index fbc5a01260c8..2563718c34c6 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1883,12 +1883,24 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
>>   	return count;
>>   }
>>   
>> -static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
>> +#define	MF_HUGETLB_FOLIO_PRE_POISONED	3  /* folio already poisoned */
>> +#define	MF_HUGETLB_PAGE_PRE_POISONED	4  /* exact page already poisoned */
>> +/*
>> + * Set hugetlb folio as hwpoisoned, update folio private raw hwpoison list
>> + * to keep track of the poisoned pages.
>> + * Return:
>> + *	0: folio was not already poisoned;
>> + *	MF_HUGETLB_FOLIO_PRE_POISONED: folio was already poisoned: either
>> + *		multiple pages being poisoned, or per page information unclear,
>> + *	MF_HUGETLB_PAGE_PRE_POISONED: folio was already poisoned, an exact
>> + *		poisoned page is being consumed again.
>> + */
>> +static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
>>   {
>>   	struct llist_head *head;
>>   	struct raw_hwp_page *raw_hwp;
>>   	struct raw_hwp_page *p;
>> -	int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
>> +	int ret = folio_test_set_hwpoison(folio) ? MF_HUGETLB_FOLIO_PRE_POISONED : 0;
>>   
>>   	/*
>>   	 * Once the hwpoison hugepage has lost reliable raw error info,
>> @@ -1896,20 +1908,17 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
>>   	 * so skip to add additional raw error info.
>>   	 */
>>   	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
>> -		return -EHWPOISON;
>> +		return MF_HUGETLB_FOLIO_PRE_POISONED;
>>   	head = raw_hwp_list_head(folio);
>>   	llist_for_each_entry(p, head->first, node) {
>>   		if (p->page == page)
>> -			return -EHWPOISON;
>> +			return MF_HUGETLB_PAGE_PRE_POISONED;
>>   	}
>>   
>>   	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
>>   	if (raw_hwp) {
>>   		raw_hwp->page = page;
>>   		llist_add(&raw_hwp->node, head);
>> -		/* the first error event will be counted in action_result(). */
>> -		if (ret)
>> -			num_poisoned_pages_inc(page_to_pfn(page));
>>   	} else {
>>   		/*
>>   		 * Failed to save raw error info.  We no longer trace all
>> @@ -1955,44 +1964,43 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
>>   	folio_free_raw_hwp(folio, true);
>>   }
>>   
>> +#define	MF_HUGETLB_FREED		0	/* freed hugepage */
>> +#define	MF_HUGETLB_IN_USED		1	/* in-use hugepage */
> 
> It might be better to define all of them together. e.g.
> 
> #define MF_HUGETLB_FREED		0 	/* freed hugepage */
> #define MF_HUGETLB_IN_USED		1	/* in-use hugepage */
> #define MF_HUGETLB_NON_HUGEPAGE		2	/* not a hugepage */
> #define MF_HUGETLB_FOLIO_PRE_POISONED	3  	/* folio already poisoned */
> #define MF_HUGETLB_PAGE_PRE_POISONED	4  	/* exact page already poisoned */
> #define MF_HUGETLB_RETRY		5	/* the hugepage is busy (try to retry) */
> 

Will do, thanks!

>>   /*
>>    * Called from hugetlb code with hugetlb_lock held.
>> - *
>> - * Return values:
>> - *   0             - free hugepage
>> - *   1             - in-use hugepage
>> - *   2             - not a hugepage
>> - *   -EBUSY        - the hugepage is busy (try to retry)
>> - *   -EHWPOISON    - the hugepage is already hwpoisoned
>>    */
>>   int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>>   				 bool *migratable_cleared)
>>   {
>>   	struct page *page = pfn_to_page(pfn);
>>   	struct folio *folio = page_folio(page);
>> -	int ret = 2;	/* fallback to normal page handling */
>> +	int ret = -EINVAL;
>>   	bool count_increased = false;
>> +	int rc;
>>   
>>   	if (!folio_test_hugetlb(folio))
>>   		goto out;
>>   
>>   	if (flags & MF_COUNT_INCREASED) {
>> -		ret = 1;
>> +		ret = MF_HUGETLB_IN_USED;
>>   		count_increased = true;
>>   	} else if (folio_test_hugetlb_freed(folio)) {
>> -		ret = 0;
>> +		ret = MF_HUGETLB_FREED;
>>   	} else if (folio_test_hugetlb_migratable(folio)) {
>> -		ret = folio_try_get(folio);
>> -		if (ret)
>> +		if (folio_try_get(folio)) {
>> +			ret = MF_HUGETLB_IN_USED;
>>   			count_increased = true;
>> +		} else
>> +			ret = MF_HUGETLB_FREED;
>>   	} else {
>>   		ret = -EBUSY;
>>   		if (!(flags & MF_NO_RETRY))
>>   			goto out;
>>   	}
>>   
>> -	if (folio_set_hugetlb_hwpoison(folio, page)) {
>> -		ret = -EHWPOISON;
>> +	rc = hugetlb_update_hwpoison(folio, page);
>> +	if (rc >= MF_HUGETLB_FOLIO_PRE_POISONED) {
>> +		ret = rc;
>>   		goto out;
>>   	}
>>   
>> @@ -2017,10 +2025,15 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>>    * with basic operations like hugepage allocation/free/demotion.
>>    * So some of prechecks for hwpoison (pinning, and testing/setting
>>    * PageHWPoison) should be done in single hugetlb_lock range.
>> + * Returns:
>> + *	0		- not hugetlb, or recovered
>> + *	-EBUSY		- not recovered
>> + *	-EOPNOTSUPP	- hwpoison_filter'ed
>> + *	-EHWPOISON	- folio or exact page already poisoned
>>    */
>>   static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb)
>>   {
>> -	int res;
>> +	int res, rv;
>>   	struct page *p = pfn_to_page(pfn);
>>   	struct folio *folio;
>>   	unsigned long page_flags;
>> @@ -2029,22 +2042,30 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>>   	*hugetlb = 1;
>>   retry:
>>   	res = get_huge_page_for_hwpoison(pfn, flags, &migratable_cleared);
>> -	if (res == 2) { /* fallback to normal page handling */
>> +	switch (res) {
>> +	case -EINVAL:	/* fallback to normal page handling */
>>   		*hugetlb = 0;
>>   		return 0;
>> -	} else if (res == -EHWPOISON) {
>> -		if (flags & MF_ACTION_REQUIRED) {
>> -			folio = page_folio(p);
>> -			res = kill_accessing_process(current, folio_pfn(folio), flags);
>> -		}
>> -		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>> -		return res;
>> -	} else if (res == -EBUSY) {
>> +	case -EBUSY:
>>   		if (!(flags & MF_NO_RETRY)) {
>>   			flags |= MF_NO_RETRY;
>>   			goto retry;
>>   		}
>>   		return action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
>> +	case MF_HUGETLB_FOLIO_PRE_POISONED:
>> +	case MF_HUGETLB_PAGE_PRE_POISONED:
>> +		rv = -EHWPOISON;
>> +		if (flags & MF_ACTION_REQUIRED) {
>> +			folio = page_folio(p);
>> +			rv = kill_accessing_process(current, folio_pfn(folio), flags);
>> +		}
>> +		if (res == MF_HUGETLB_PAGE_PRE_POISONED)
>> +			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>> +		else
>> +			action_result(pfn, MF_MSG_HUGE, MF_FAILED);
>> +		return rv;
>> +	default:
> 
> Should we add a warn here?

Yes, added a WARN_ON.

thanks!
-jane

> 
> Thanks.
> .


