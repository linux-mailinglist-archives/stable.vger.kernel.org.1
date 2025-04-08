Return-Path: <stable+bounces-131767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0208FA80EA7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 16:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FB719E631F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4DB1DEFD4;
	Tue,  8 Apr 2025 14:40:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED81581F0
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123211; cv=fail; b=QJMUUkbiggep8rMm6x0UXppXhnfxf3oVA3F8OOzBzIRZjzUWJCtXmT/ate3mnQB71kdjR+gtYZMWfjR0DYYbxblFL903mO2TGcVSowg9QNd94QLEHTMN4Ch9s/q+qYubnOIYCh4KYB8bwioF2OuNjw1cZe1J7nuJwHwiVswwjd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123211; c=relaxed/simple;
	bh=iLk+B01FbIjnLEeuIRiopBpxG/JzS+W0SInKOzxpde8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u5TxhCdzVQwSQfq3JhckaBLkSvT9BCc0CVHE3UGdwOpc8FhWsTXyzbOB/vqv2/tD1EtSaR3VmHdfmxipO9fmJqz7nS4x5xEmb8XmSZhe/RmBLVSyXEmXJH3dCNBvsvNq4doSfcri1qGqW4dztumq12glwwbPubHTnwYFRYdkviU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5385Ka0I032213;
	Tue, 8 Apr 2025 07:40:03 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45u41m3pmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 07:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enotHto0A12jw3U5Rtpf0ZyLYPM/4wycribw4MRqutgkFkLmAOZY6najP92P2LMwmVpjKXxOJrBGa5i2WM75q3aaRZiw9+OXa2MkjR8nso8O30UBFZyHFKj3dtad4wd2L/jaPU/dkwwM7h3gDu5yn6d07BURUV7ec+1iHOGSA3ad7X/5Cw2pbvfZnELGz+tvUqOQ9fZf+W/H056q/8OxuKo6RYzQdD+UduFVy4zREHIe4AsgN45K8rXUBMwfvNuSEdSCRl7q9As/OE5looWNE/7lyw+P4bwlpyuEsxIdd+vczRf0dqI9ALbqJcIl58OvhxHae3FMukaeeX2WqBu5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d99mpAzb1ydh06Gwn8im8Z6jn2XDszmcLQW0ILQAWnc=;
 b=x/nnOlc7W43vXrBf0ctt41esph+t58yklMreXEvj3ItcPtKOcY1t7P2gvOhPjVRiIXR/f+8poEuTMjNhwAULalk9KUIEvHLCxezWFJqyyMYHBpkOFUAEjoi4FRtLx5q9EHSwRfA1F05u3NmU8hZmD06tOxUOQy2lECs2R7hS9LZ+YRAnmxF0teoIAwbSqpIscal+tPvAP1DwCEfCc2PfHuixvwZHOhJLH5y9+obYzwWU38MJt3AbdFrTnqf4kTkRcFEORFhkXSNKtOeyBvcK4OnwEQdmAMEvwZNmPd4ufOeNxsXguchalChvSwHvdBoY7ZMukKZCl8G+Kigjs1bgFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 MN0PR11MB6133.namprd11.prod.outlook.com (2603:10b6:208:3cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 14:39:59 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%4]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 14:39:59 +0000
Message-ID: <b806c43a-961b-46ca-ab08-cad7a36479f5@windriver.com>
Date: Tue, 8 Apr 2025 22:39:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y 0/6] Backported patches to fix selftest tpdir2
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        ebiederm@xmission.com, keescook@chromium.org,
        akpm@linux-foundation.org, wenlin.kang@windriver.com
References: <20250402082656.4177277-1-wenlin.kang@windriver.com>
 <2025040344-coma-strict-4e8f@gregkh>
 <17b170ac-aa20-4c36-a045-25d2f82e66d0@windriver.com>
 <2025040819-unabashed-maximum-8fc8@gregkh>
 <b1b8807d-f699-4108-94c1-aa89df62aadb@windriver.com>
 <2025040832-replay-trout-b9aa@gregkh>
Content-Language: en-US
From: Kang Wenlin <wenlin.kang@windriver.com>
In-Reply-To: <2025040832-replay-trout-b9aa@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::15) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|MN0PR11MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab6aa7d-6cb2-4a77-a3c3-08dd76ab3d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1hrZmY4YnRCeGFRRTRWZHNMSXFVZEcrUzkzUS9OTGtzMDgyVjV1dFUvdkhk?=
 =?utf-8?B?SUxFNU9nbWVhRm5NSFZUSVNhNlR6RnhrdEc5ZzZQUVZPUDJZTHVYclVocFpW?=
 =?utf-8?B?ais5ek5LUzluV09ud2QwTlVVNU52VnR1Z2Ftc2M4NSs4UXpLcHVmWU12eGZq?=
 =?utf-8?B?bnBpeGt4RTQ1VEdoRFVkRXJGV2JOVmRoNzI3eHpUWkhVQ1drNlVETml4U1dj?=
 =?utf-8?B?SlJuUDRna3Zoc2t1MlBJdXFJMjI4NWpjQkM5cVJBd3lPb3VYem15VmFJU2wv?=
 =?utf-8?B?ZVFjV2tMelFadTZVWXF6QlphYzZNenBNUW8vZFI5V0NwTkt2Q3VTVnFQN0xY?=
 =?utf-8?B?aWkyNUI1SG85c3R1SzVwN0w4TkhxVzVPc0xBU0U2anU0UXFjSExiSWJnZzZh?=
 =?utf-8?B?d29Ubk1DdWlkQkFReXk1YnZSMVBhU3hFeFVvOVM3WTFjbTQvaFFkNVUxU3ha?=
 =?utf-8?B?RWsxbFFPWnI5ZnhiNjlSTTcyZ1JzT0lSOTcrWW9xbjRhYVcyN096VE1kZ1h2?=
 =?utf-8?B?RnorWFREdE5GeFMyU1RpMEtRbGVvK3hEd2s1UWd6M0owb25rZThtQm44T0d4?=
 =?utf-8?B?U2RWUXpwZkFlU3p4bnl5c3hoVWlxQ29JbUgwcGJ3L0l4ZUg1QlpqR1l4dTNL?=
 =?utf-8?B?bmdFaHZBUDZ6ZldMeXRrUmFMKzRZVkM4M09aOWxyQXF1cmRDOUFHMXBzYSs2?=
 =?utf-8?B?c0I5L3FXZkNxcUJDSmErRGlIQzlESURZQ2J4RGtvZ2YzdUp2NFpYVDdFNXAr?=
 =?utf-8?B?MnFPcGIzUmZGWkxZYTBBUG1uTHQwaittZlE1dXMxd2lvSUV3YXNaeXZubFlh?=
 =?utf-8?B?NXVoK2ZENkJ2cjhtbzZrc21uWW42RVRsVnpRQmEzRm5GcDFWT3N2d0ZZLzc0?=
 =?utf-8?B?N1M4OU5kektLRlhtZHJJeWpVU21md21kOWpIZE1XL0NCcTBQSTl4b2ZESXlz?=
 =?utf-8?B?blc0V1BxMlVNdTRad0ZPeHBINm5IelRLb245aHRwNHF2SEJzZmw0Yys3ejdG?=
 =?utf-8?B?SVZqRytVcVhsV0pCdWxhOXhSeWEzUUVGNU4wdFVvQlNPRCtNMkNQc2lVRUty?=
 =?utf-8?B?WEZwVTdObmlMNkpDZEFWalF2UWl4YUZzbWtWWDlLSGk5MHFabXIxUkZzTWNN?=
 =?utf-8?B?amFuelEvTGhocWZRSXpIaWtuVVBMa01Sb211aUVmRWo1VHpCTjlOVFVSSWpy?=
 =?utf-8?B?WUFTVDQ0Y1BrNUgyWXZIUThQWXpDVTFtT2VZNklwei9NL0JROHlJUmVSNVpP?=
 =?utf-8?B?WFhUcUhQMlNHbUZqSGp1Y05PbzlYUHJqd0FlaXNaV3dBbkdJWVNoR0NKTk1G?=
 =?utf-8?B?aFZ0aUlNRU1XeXRyMUVJVVhkKzFiUVpCQ3ZHcFpzczhpNEZiSWtHMk5sOWo5?=
 =?utf-8?B?ay9mak9WVlNpTk9kOURiRzhDKzEyUm0xbkZua0lCOXpJYWRoL0xvYlR6Y2Fx?=
 =?utf-8?B?Q2ptYWhGUmpoVllHRHMvWHgyU01ybnlxbnFjTVM4aWtOVHNTM2hUM0xya0ZS?=
 =?utf-8?B?R25xaHIraitZZGlWTWVyOUJGaHhKeWl4bTJHWTBwSld3MVF4WGtFT0ZBamdh?=
 =?utf-8?B?d05RQUFQcWF5ZWhSZExXTVF1blJpa0RYTENrZ0hBM05tNytvK3lQVEQrUERG?=
 =?utf-8?B?RkJnUUJzUU9Bd1paQ2NZck1xeFdSTUxJUzVmcUh4aklxSzUrQ0t2SWtLM1I5?=
 =?utf-8?B?RG01WnNoRk5majNWY2FBRFcvbXlRMVl1ck82SStHRHBDcDJVQjdQUWRhR2dr?=
 =?utf-8?B?TkhxUnJhTFc5QWVSU2ZERXBCM1hFbnpkT3RTZzZMNWQ2TUxLa2ZrQ3NVV3d3?=
 =?utf-8?B?cXJsWUhPUkNFNXVNSXM5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ni9lSGQzd05tcENpWFhHbnFOeTZVMi9FTlFFVnZwL2hPbXBzck9xK2c1Lzll?=
 =?utf-8?B?d2NWbFhvbkR6NVZ3eHZLamtrK0xidHYyd3U2SitUdm9MZDA3V2J0eGRQTHNy?=
 =?utf-8?B?MmI4RlNoelgvam9PZ21yYXZLWnhzNVdVSTJMeU5pM3V5NTBQRmR0TUJBcjlq?=
 =?utf-8?B?Skozd0FYM3dSUUg1eFcxY2ZIajZPNWpQZDh1YitzTWlTa1lUR1VVZWRnWTFU?=
 =?utf-8?B?SDlUV3dJYXIwMHh6VlZmc2lINDVwNVJRbVIwcG1jNkxWejU3akJZdkFzRWtk?=
 =?utf-8?B?Ulk1ZDV6UGpaNzF1VGdlTjlXYmQvUGUwOVhXN1BuZTBZYnlieENsUU1GRDIw?=
 =?utf-8?B?bEE0OFVSUnRXcUlySHdxZ0t4K05PcVRzQ0pFZzNNeXJCbUtrcyswRzNXVWNO?=
 =?utf-8?B?a080NUZqZFhrNnlyQml3ZDNXUDV1SEZBZEtzOFVua3FDeW5PYTExb1ZzL1ZE?=
 =?utf-8?B?bUdYT3BaTitoc3VaWHNySUEwdkQra1dRQlp6ZzFmYUl0UEpYemltYXFtcVNi?=
 =?utf-8?B?RGhzU3ROQzhCdisxTllTczA4cGJhUUVFNjNmZWNvT282ZzFLMkx3a2ZPaFRp?=
 =?utf-8?B?RFZDcytmdHA3K0U4VWlrNkFXd0tHWHVqWXgyeU91NklvMWx6WFpValZNNnRk?=
 =?utf-8?B?TE82OWRVQTZTeGRWaHVlL2x3T1ZmZDViNHI3Z0NPZ0VERmtyUHlaanVYYzlD?=
 =?utf-8?B?NjQwYjFBait1eU1OdWUrakFxb2NRS3Z4OUZma083MHJxc3lCK3BlVG1xZmxy?=
 =?utf-8?B?WDhMcGlKOGFUd3BFdXNwOFUrNVYvZ0RlRVcvclpXNXVrZFFJdGIweS9wa0p5?=
 =?utf-8?B?TWljbzUyNmoxUVFOK0tLTysrc0xoTWc3d29RbERBRUN3VDdjWWR1WHR6K0l5?=
 =?utf-8?B?bzFLUlNrM0VmMXhNUzJjOUlCY1o3VzlSaXEzZm1KdGwyUkFUY0xVSkg2U2dU?=
 =?utf-8?B?R2c3c1NVbnRGVGVFYXNucW56RkQxODcwYXJhMmdsZHRkUXNXS2JwcHR1QzJt?=
 =?utf-8?B?WlRxQ2l3ZGRGeUZyOHUxczdWSHV1MEMvNFpjQXVTRjNYZHhyN3BvQ0x0dEZV?=
 =?utf-8?B?MmdlSXduV1RFb2dwK2JNNjRSdTlyV2c1emRxbkljSmozQlVBbFJxVnhrZ2JJ?=
 =?utf-8?B?SEZNcGRKS283WlJ4amxCaTVHOEhmSVJQZHpXT1JkRzZRZURqcjV2bFRDTGFh?=
 =?utf-8?B?MU9MZkdkQThoQnFUWnBPcXVLQ1hpUWVrUjlZa2s5RWJiOWNhdmZqTU1lUHBI?=
 =?utf-8?B?RTNWUndrZnFNN0ZZa3hCVjNucTBpL3h4L2xEM29xZ1dUK2RyZDdsTUQ0TXpD?=
 =?utf-8?B?NE4xNEpIYUdyUGFUMHVNLzZqWUVPV25COEMrWEVmQ2d2UjROTGtwMko2Wi9J?=
 =?utf-8?B?YnVuQlQveXZBRFdaeXZLZEFQeU81L1h0RmJuTzQ0QW1obmVuTXQzVEFOQ1pl?=
 =?utf-8?B?U0lpZGhBZzRwd0FpeUlKb1E3L01Dc2dCTkN5UE5lc0UvZ0NuaHR0YlgwdHFY?=
 =?utf-8?B?b3dzbzA4ckNNaURVTEU4R1ZLMEgvaDdvMHltNUs4VDhZZTNJV0hZaXJxR3cw?=
 =?utf-8?B?S3NrYUZwd0tIamxNdUordndQU2FNemhEa3ZmQkYxRWMwYWN0SnA1eENlWkNM?=
 =?utf-8?B?NHFJNFRKZ2pERDNaclo5T3I2QWwxd0swVm9DM2Q5STNiZHRoZS91SmZ6YzU4?=
 =?utf-8?B?ZElHdm9ZZmVSc3pYYUIvbEFFYkI4V1Y3UTdnRTZTSXBBU213VnBDcVRialJF?=
 =?utf-8?B?YTFlZHZzQTVFbUl4a1hKUHFHYzk3Nk16NEltWlY5T1BOaytrc3kyRVM0WTBU?=
 =?utf-8?B?WmttcGphc3E1dVR2aVZaT1MzUjV0NkZBMlMxSTlpZ1JWOTBpSzlaZ0toeG5B?=
 =?utf-8?B?TUVXTjZ3S1dkakRIR29uNm1UanR2emx3S0U4WjFQMTdjbHBudDJOeEppeVN0?=
 =?utf-8?B?V1hna0NOTEJaZlpXVmRTclh4dFdJMXRkZStKd28vblJ2U25HeFNwMjArTGwr?=
 =?utf-8?B?NnYwd2VDOTU3RkR5OXQweXVNYUZNK3VLMnNFTHpoK25aY1l0WkozWW80VHJS?=
 =?utf-8?B?YXRHUDRXVFQrekxKQ3hsbWJwZG42a2t1dUJTblpReW1nM2tWVUM5SU4zam5J?=
 =?utf-8?B?U2F1QzBVcitzbjVCTGpySmxNSDRDUmxkTUJ3dTNPRXpzYkxRbVM2YURFTUVa?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab6aa7d-6cb2-4a77-a3c3-08dd76ab3d1c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:39:59.4789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXdkiUZ3ld+YKzxMmYdYscV427lAgBrwse4XkjPQHQeFLUhbeN5k8uwGtUi26M1g8KePbjyT1RL1nE0IzZQWng1Dc5DqMxz8LQqYPZNWo7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6133
X-Proofpoint-GUID: 7_GBfggYJT41q1-5NAc-RWNIPQYQ3XHV
X-Proofpoint-ORIG-GUID: 7_GBfggYJT41q1-5NAc-RWNIPQYQ3XHV
X-Authority-Analysis: v=2.4 cv=QOZoRhLL c=1 sm=1 tr=0 ts=67f53542 cx=c_pps a=mEL9+5ifO1KfKUNINL6WGg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=VuW8G2IGCPahEAm7PdUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=845 bulkscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504080103


On 4/8/2025 17:55, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Tue, Apr 08, 2025 at 05:50:06PM +0800, Wenlin Kang wrote:
>> On 4/8/25 17:06, Greg KH wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>> On Fri, Apr 04, 2025 at 03:58:36PM +0800, Kang Wenlin wrote:
>>>> Hi Greg
>>>>
>>>> Thanks for your response.
>>>>
>>>>
>>>> On 4/3/2025 22:52, Greg KH wrote:
>>>>> CAUTION: This email comes from a non Wind River email account!
>>>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>>>
>>>>> On Wed, Apr 02, 2025 at 04:26:50PM +0800, Kang Wenlin wrote:
>>>>>> From: Wenlin Kang <wenlin.kang@windriver.com>
>>>>>>
>>>>>> The selftest tpdir2 terminated with a 'Segmentation fault' during loading.
>>>>>>
>>>>>> root@localhost:~# cd linux-kenel/tools/testing/selftests/arm64/abi && make
>>>>>> root@localhost:~/linux-kernel/tools/testing/selftests/arm64/abi# ./tpidr2
>>>>>> Segmentation fault
>>>>>>
>>>>>> The cause of this is the __arch_clear_user() failure.
>>>>>>
>>>>>> load_elf_binary() [fs/binfmt_elf.c]
>>>>>>      -> if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bes)))
>>>>>>        -> padzero()
>>>>>>          -> clear_user() [arch/arm64/include/asm/uaccess.h]
>>>>>>            -> __arch_clear_user() [arch/arm64/lib/clear_user.S]
>>>>>>
>>>>>> For more details, please see:
>>>>>> https://lore.kernel.org/lkml/1d0342f3-0474-482b-b6db-81ca7820a462@t-8ch.de/T/
>>>>> This is just a userspace issue (i.e. don't do that, and if you do want
>>>>> to do that, use a new kernel!)
>>>>>
>>>>> Why do these changes need to be backported, do you have real users that
>>>>> are crashing in this way to require these changes?
>>>> This issue was identified during our internal testing, and I found
>>>> similar cases discussed in the link above. Upon reviewing the kernel
>>>> code, I noticed that a patch series already accepted into mainline
>>>> addresses this problem. Since these patches are already upstream
>>>> and effectively resolve the issue, I decided to backport them.
>>>> We believe this provides a more robust and maintainable solution
>>>> compared to relying on users to avoid the triggering behavior.
>>> Fixing something just to get the selftests to pass is fine, but do you
>>> actually know of a real-world case where this is a problem that needs to
>>> be resolved?  That's what I'm asking here, do you have users that have
>>> run into this issue?  I ask as it's not a regression from what I can
>>> determine, but rather a new "feature".
>>
>> Thanks for your explanation.
>> I’m not aware of any real-world cases. As of now, apart from our
>> internal testing, we haven’t had any users report this issue.
> Ok, I'll drop this from the review queue.


Got it, thanks for letting me know.


>
> thanks,
>
> greg k-h

-- 
--
Thanks
Wenlin Kang


