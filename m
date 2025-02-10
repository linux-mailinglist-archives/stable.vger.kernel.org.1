Return-Path: <stable+bounces-114606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DE8A2EFD5
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB943A34B1
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2567252912;
	Mon, 10 Feb 2025 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d/N4U5sy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eYcIgTWG"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DE02528FA;
	Mon, 10 Feb 2025 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739198077; cv=fail; b=ES2deDnaFEhMgXfejWgnhOJW36Cq2PRD/wjLjkH0jHT7a6dn7T6esSN1j/mzCCaEzMz3mWYLLjFweex3T086O1bdnxdPF233i6xv+uBOx8Op6N2xGZkpIYD0SSl4f7kujofbfLrrz2iBm7Ir3NBr+Vo9/RNNS+3VxC8AvkmveEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739198077; c=relaxed/simple;
	bh=rEznYEnOuovV3xZaFFiIChf/MhReMTMd7XjJ1d4Uvp0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HoE6CLsK0H5JZPZNHyJiOk+prqgi5y/JRGguw2KJaFWajQ0Ye3q1/Oinju4qzwP9ESmvFXKSVkpEtBrq0+47wbDiWzwTbNLe6Qa5hKXDgy4szNp7LCjRLkAkkfaH3xuYf+q49g99gYWRgorHNF+sAHL1eIsq3pAqXGtoPRT/z54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d/N4U5sy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eYcIgTWG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A7taKi026318;
	Mon, 10 Feb 2025 14:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Wfa1H4gNidi/FMRmUSvDaP8sJ9c/KUiTm4iYAYmr7FA=; b=
	d/N4U5sytU96CcoDgA5W7ApGmdt7mvmYP6QG4DYHmiiqp7SUlQX2rduBVZN7ZqNs
	X3DA5xh7zMpq2ZD+FpsxLzHKBVcoPhxi+E6JXXDwoUyoHEYLMatKE/HjrKf7kPhz
	hQtMp/5FIH8Kqd/6aBUU9PiTJod8JgQXlCa2aNmuLkA56khAfkYBwGTMPqcibALo
	HjVX1bAlT6cWnYCerLjJl27g50khMYHkueVBMM1CNJMOXYtjib0J7NsRD8PQ5Ddo
	Fp0cSX8RU4BxkMerC3SyRdVtd1r4q9pzu8tTIPER5qjpwcw9j8X3Pte3o11pCVzn
	Tfi+YLj/eZrkxt+YLIce1g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t431b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 14:34:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51ADD3pj009787;
	Mon, 10 Feb 2025 14:34:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqdqh5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 14:34:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tG0AVuwOGDFGqbFF/O+zs1Jp1BVPiMFZYsEYaUmqi4WxaQ/a/Uo9Ixu5dJtCzPnb9NGoVNaksDr7LZpScndf6RWzI31WJIi7KcCWGixWvH4VKhSIoaGK9KRPoLp+r0Cax33o/Ltt04bQy3mgQmQyeR13mxkH4qc2jUUeiyuPmHUrNLMsFKz8mVFxteYfxT3noyaD3d4NN/0FPY9qD7/8WgdPR2X6CSlqZ/BA7kewlfQvMmUhOUuvCFn35A/w1Ya2tB4s1TMCBYklWhmvT1OZWHla0jP+8btmiODhIhZg9McNu1Q7yyMvUFpilVldTZx3Ei+YGXSe3wftYd3lyQk2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wfa1H4gNidi/FMRmUSvDaP8sJ9c/KUiTm4iYAYmr7FA=;
 b=mN6dMCt+aPWHmpoia2o1K9duOqNzTEfrkteJRBaYwb9Za2goAY192HrqrA4lT9ifurLRb1VGooZejvPsgzSWZZLjxk+aiucKbEClknS40i2OybZR29+jY3HuutMdzb/N+Qn2PzeyaUSZ+wY93C4TjoXg2tau8+eTOvWB/+DLE9nC3/YUuwqzsV4UrCE9pOjXUzUzOkNxfv0EVAHsbBX6pn4NJG4qgG2BUbvxQtTrEDuYEQNfDuWKeSixL7V3hAU9aYagx72XbvWBmVAO7VAJaeO044SssapTfBGlvcsANwW2jRbvg2R8RU2077tEaZYXO0d+PVYNenEsm8/ZKe5E5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wfa1H4gNidi/FMRmUSvDaP8sJ9c/KUiTm4iYAYmr7FA=;
 b=eYcIgTWGXasyjpQtCQgviLphHON1VpfIJSICfi/XLoMi6O9iWDONsyNuauGORVBVn3fU8EZJtKHhedNVYPYYjpunSs5lKCLT1wa+J8GVCRxFg4DXd6keeyfZ2tCE+Jdkae6yWBhO5A9sBi4kfdDl7Ineo//ARFkCW2OgujqJEG8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4299.namprd10.prod.outlook.com (2603:10b6:5:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 14:34:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 14:34:28 +0000
Message-ID: <f8fb4f61-55a1-4d84-bfdb-6ca2533b6a52@oracle.com>
Date: Mon, 10 Feb 2025 09:34:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: queue-5.10: Panic on shutdown at platform_shutdown+0x9
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, "stable@vger.kernel.org" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <231c0362-f03e-4cef-8045-0787bca05d25@oracle.com>
 <2025020722-joyfully-viewless-4b03@gregkh>
 <0c84262b-c3e2-4855-9021-d170894f766c@oracle.com>
 <9657c561-a147-4143-9e64-42fdd68f9dcd@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <9657c561-a147-4143-9e64-42fdd68f9dcd@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b5ce48-a18a-44a7-dfe5-08dd49e005a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTUyR1BQY0l6eFFrVXJ5aWl4NlFnaUJiRW1Dam1qRTNHUmxLZjh0VWtGSlZO?=
 =?utf-8?B?TVV1L0xSd3F0cDB0YnFUUGNORzhmWDMvcWlEKzZMSXljV3Q0VHV3MytKYTBp?=
 =?utf-8?B?ZkRYMzNxWDkxMVBNYmxkd1ptSUdNSGtZd2x5NDNseGJzSWhaSlJyU0dlbnVU?=
 =?utf-8?B?N2VkODZyZjRaUXE2OSs5RnVKM2xRSkRmMFEzVTdMYktqZkFXVFdXNFN3VHhk?=
 =?utf-8?B?bjlQbisrMEFRcEFvZVNZTmFrSWVXZlNpUTVKVmdSaDZrOXo4R2pIUThtVnlx?=
 =?utf-8?B?MmJGQXdaWnFhNXMyUFNMY0xvNWMyS1Y0VWppQTQyOTVINVFST2JqMDd2RDUz?=
 =?utf-8?B?UWlwTWJtWWsvWTBIWXVPRXdOS2ZVMENoYjVaZ0lQLzVrODdjcUNPMTd3eTZz?=
 =?utf-8?B?YzRYMnRmQm1ydFBiWWlhQUwyUCt1TnNFV2tmSHU1U2NlNWljRkVuYys4c1Nv?=
 =?utf-8?B?dEM4T3dyV0tBV0l3T3ZrMDdmNVpQL2U1c2lhZ3ZBTHN5RExXZVlYR0o1ME9L?=
 =?utf-8?B?OG9VNUtQbzkreDIwQnFQNk9GaDBmYnUxSlQySVRRQ1pueUZITnpWNmZkeFVP?=
 =?utf-8?B?TEFvS1ZGdTlNd21oZjF0U2drSDVQeXRueDdGc3lFbjA4bU0xWnRlV2VpT0dh?=
 =?utf-8?B?RGNFRThuZk8rNkxsQjNBRzFWYys3eHYzWDdQNlQ1L3V1bUlrVi9Za2xwa3U5?=
 =?utf-8?B?b3p5cWxEazAvSGdITy9vMGpGKzRUODZUSnZ5M1pxS2trNFM4YlFxczhodnMy?=
 =?utf-8?B?UlVRZURrTXUzZVVWQWZNbkh6aVJhd3hVVkRhVkVZa2dpQmxYeGU5NFNOcG5Y?=
 =?utf-8?B?cEI0anBneXlFbjhUdWpSZHFaamZaVmw5NTB1SzIrd0s2ZTMxSllkZFp5YzJ3?=
 =?utf-8?B?WlNFOHFaM3JaMUdVRjArQUNGTy9vcXVyZkZGRTVmN0tkbHdvWEVzYStuUTh6?=
 =?utf-8?B?akRkUGJvT3ZKS1BoVThRVVFJaUNaSE5sbUVMcCtXUVlyc0xJNS9qejZiM0o1?=
 =?utf-8?B?ZGJrTUZvNGh6ZC9BWitUTjUxbmxMTndTeVUzK0xnamhkZVI2WThPSEtMRE1B?=
 =?utf-8?B?aHVIZ1ByN2NTOGhady9yTTlDelAwa3JpVTZ0ZC9oM01xand6VTd0TVl6L09q?=
 =?utf-8?B?eXN5UnFkME8xS01ZL25zMnY5ZTBlTHN3ZThWdEZUUy9WRGQxMytNUFNZU3Iv?=
 =?utf-8?B?WEpROEY0Z09lM0lMQ2d5KzltdkIrN0NhTFFzd1V4S0NpWjBmL015bDdPWUlz?=
 =?utf-8?B?WDVqUVN6N0ZTWFE4QjBScDRMODY0T0UydGE5Q2kwOUhXbnhzVGFlR2IydnJM?=
 =?utf-8?B?b2s0OXZ0d2RBM29UUzMvY09tVkdDQzRvM3F4SHdCTlRJNzVtTnlkdFROOWk1?=
 =?utf-8?B?d29rYzVrbWh0TzF5czFiQm92UzJTMklldlVsVzhsYVlVdlIyM3pwQVNiT2VW?=
 =?utf-8?B?aWdOZG00dFI0Wm43UHkzcmVrZGcvWjVybjU3VThvdmJKUFFJdmZoa2JUSUlQ?=
 =?utf-8?B?dWVlQjBpNDZ1cHU0bk9PcmJRQnV6TGJhUlM0cS81cC85SldkU0N0M1Jpb1Av?=
 =?utf-8?B?djNEcHh2ZHRJMWZIYWMwbXlZMWMzd2FPSXdmK2gxNDM4cjdtMUhKNU9va1lZ?=
 =?utf-8?B?aG9YdFMxSXMwRGtqOEwzSjdwUDNIR09iUnQxMjNCWmhKemdOZStMa2JzRTM2?=
 =?utf-8?B?UnVkdW8xdjAzR2VZVG5kYmZLSnhCa0RGT1FRdGJyYU9MSVErMzBlNFlpRHE0?=
 =?utf-8?B?aTFGcG1QdDVxUGZoenlWUjBzRmljZlpHdEIyK2R5eTJ2aDMwbXVONXgzM0F1?=
 =?utf-8?B?RmFCWG1uWVc4eGtldWx0b1BocFpTdndEOVc3Vnp2eVVHS2ZHY1NJVnhoMXRj?=
 =?utf-8?B?MnVvdWJValdGcFlTRExMR202N0lVUjFINS9QUjNPNmd1cnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTdwVFZMQitkUlhpRll5WlZrcEg5M2lkbmsrVmNMUlBETVM3MFNPSUpsN0ND?=
 =?utf-8?B?aStEQm5KQ2xidEExem5oZXNtL01JSmVPVXozZ1o2MEhmd0Jxallmd2RGT0Vy?=
 =?utf-8?B?K2NlVEVPTmpEOEFrdDEwdUNadjVxSVJML3E5WThwL0lmRVp2MWtZdFpUUG1I?=
 =?utf-8?B?VkpmTjdKVzVQZVd2MlZtYStwQzlKaGwwODI1QVVRdlZjWlFIRmtiUXBBY0xs?=
 =?utf-8?B?TjJZTDF3QnkzK3RJenU2Nlo2MVRYYTlsK0pTQm9aQkpiMFRHcVNxMWV1UmVv?=
 =?utf-8?B?YTAxaVJZOGovUWVMamZsRGhhSEFSemZVaGFGdmNSYWNkL1VlTXlmL1JrYTJE?=
 =?utf-8?B?MFNvS3AwZ0tlVUxnbnpKbTUwODlxclZDYzNZdDQzd281UHNlSk5wL29MUHRX?=
 =?utf-8?B?NHJ3aGl3MjJhRkpBQ2t2SURtU1NKRGdNbVNCNDR2aXFiVGVRdC85N3k3Ti8r?=
 =?utf-8?B?N3Q1ZnJTbDUvNFJSWTNXYTljY1VGNDZzQWZETWxvZjVTOEo2dlhMQXJremg2?=
 =?utf-8?B?aG00bzNwNXkwV0VoUGdWUUFkcmZ2N0Y2UjR4QkcyOTNTb3NFS0lhUDJqZm9r?=
 =?utf-8?B?NzdqUldMQjhGVnV4NlJKNWI2enlQWEI3azhoOG00eDFFVUp0NzJvS016cFVi?=
 =?utf-8?B?MUlubUNMcUpsY2ZNVGk0VGhMTGc0NlF6elBnRzBTQlY0ZnJQUHhoUVpCcFdY?=
 =?utf-8?B?eFZBaHVRRjNOM21RMVZGamVnQ2RXVm9Ja2hvZFhRUzcxV21VK2Q0TWJ6bHlv?=
 =?utf-8?B?cSsrcXdjck85ai9SR3JEbDVybngvVlIzU3lVdGdkcEMrSit2YlRveWtoakJJ?=
 =?utf-8?B?aG9pNlY1YlFscjN6Tjk1VmNBRXFScUU2Y0U4dW1YZDg4MmRBWlRmTzBjd0JM?=
 =?utf-8?B?Myt3amlvb1U2ZFhRNUpBNEkrY1hrMC9LVDlnTXprWjhWWWhVUERjaDd3YS8r?=
 =?utf-8?B?bFpPTkJKQWVpdHNkbXdCUnFMczd3Z1RKTHdKM2pDc1o1T2R1UFd6bE1QWkhj?=
 =?utf-8?B?NjRqQ0V4WThnWlBRMG00UTl5SDMzZE5IWi9tbHc1RkRHbGs3ME1XWTYwMTdE?=
 =?utf-8?B?QnR5c25PWS9lZE83SzVBV1NRM3VJaldMaXFCZm1xaWlxZTI3U29GTU16c3Zv?=
 =?utf-8?B?OGxQaEpiOEEvdGtucFRZZmJkek54T1ovV2Jsc3JpK3FrSTNYd0dMV0dheFh3?=
 =?utf-8?B?ZXlUUUNYR2xsNDkvNldvWmdzMEhvNDBBa2x2eFpIcWgvck1GUVdYSy9KQmpQ?=
 =?utf-8?B?VlFSTHpwSnBzTmJCTzdUUmtWcTJEQlpFZ0RiYVBKTHZaYXJ6S28wVjNqeEtq?=
 =?utf-8?B?RnRZRDY1UmFqekJYL1U4dmQ1V2RuL0Z2b0JCNEtMSWlXVmZmeWltdDdTK3dJ?=
 =?utf-8?B?TEREVTJhTHlhcWFyZXBXMHRBZ0J0UlFzeW15cGd1QUhvckphY0lySjZ1OUJB?=
 =?utf-8?B?UktvUG55MnJFYW83alRPN3dsTG51YktlMEI4bXdjd3YyK1F5RzR0TFZGV3RK?=
 =?utf-8?B?T3dHMHpOc1dGZ24rdmRHOUtybnF2SmthbGMzZThWU1lqdzl3VTdjNmcxK0k5?=
 =?utf-8?B?OGd6T0U3RmhtS1BTVEJKNzFya3AxSmpWOHZOZmoyYS9ST1lWNUV4VTBPdXNl?=
 =?utf-8?B?aUVLejlYMWpka0xXWWF1ckt0anRXN0dTak9MYWNqcm81OWJHbXdVSDkvVUtX?=
 =?utf-8?B?QWR0Q1IxaWRxN3hPb3QyKzl2Wkh5N0dxLzdGYXpSMEMrckZUL0hjbFJGdi9P?=
 =?utf-8?B?MXk0Qk0rNVE4U3l4T3dPZVZMQXI5WFhRNUJrN052WWs2R3BiMEF2RHBEVGIy?=
 =?utf-8?B?c05CejRvNEVwS1FHc0xYdEgrbWFXMFpyRzNLQ0Y3dUJkMU5WS2RmU2RhNVRM?=
 =?utf-8?B?a20xOS9Zd2xWcmRDanFnc3gvdTZvbWRNaWU4em9UUFBxUW5aN3JDSnRLeGJZ?=
 =?utf-8?B?bXl4ZTcwa2ZMYWRXL0dCWHdXK0kxVTJqZ0NaVGRXVzVzQWlDRVpFbksvWjAw?=
 =?utf-8?B?cmZZSkZpUVpLN0c3TTNUajIwb21JdHM5ZW55cVdpTHE1Wm9KSmhkMmtVR0hU?=
 =?utf-8?B?czNLOXdwbkNSUGsvR1NlZHNDbWJWM0swcHB5eHA1Zi8wWnZ6dldGY0Nxd3Zw?=
 =?utf-8?B?SWVCUkVQMC9iSjFrdnRtNzA3a201NTk5YURjWUNJUVZOSDMzTmlpVXBtNmFX?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bWndH4IqMKtfXRcaiS/7LecRXjDx5o3mFa7zj+HAy1F5uM+21i61UGmt5CBimxwI9X+NqQtM/ORwnIv5Ijdh1MdNcfS0Nxqg6JjfqZboR0IaASRomyKAmIzePjADDZiizcGqyMd+iuuZQQvhgsFtSs4UmKRb8do/dN8ySMO2nc/aTNxhfJdOVtA6b4cWicY5IYOl8iS1vYk451uWVK5rTwYNMmcVU8k6ozjwnD2MW8X8rxVe8/BnU8LFlHTXcsmkR9r5Jq5UCvMyMlzpRDM+sku5V9PcYyb6BBIso3+HyqJqQC/y2lOKNY/MJiY63bq0k4eBfx1QFzTBudFx5jBwxMvI0BC/a/G/X5TQ5K8mVWNXYKPcylDzhqmpXgXOY2gJAbgPNCrgNF3DbEzigDjJpO27jCUrL4bHXUNG0LRye+cDHZcaIOGoH/rbqNXLZtu8eYCgibw4d3vgkRAPCs7YAuBaPSNyRR70HIPq8D2plPKi2V7ks9dYf9QAsPauj+mQyHzIoQY2FhQWA81XyaIfuhNUyMVVtEfJ8OiQtrET2nhWhwQD2lVOfCgOOe3qQDd371D0BosbGrILYVfZCqQ+OaNuEl0ByWhqPT/sW5+cIGI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b5ce48-a18a-44a7-dfe5-08dd49e005a1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:34:28.1293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roVeKnoaMb+GOLvayFkuLtJ2YdtxP/YcfkQGMLRPXZPl1RB3yQ3vBw4893EadtypMa3aG45ZEhlf0WlVveWEGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_08,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502100121
X-Proofpoint-ORIG-GUID: IHEze9--C-UKIFtgNphnDUD_B_IgGIQw
X-Proofpoint-GUID: IHEze9--C-UKIFtgNphnDUD_B_IgGIQw

On 2/9/25 11:32 PM, Harshit Mogalapalli wrote:
> Hello,
> 
> On 09/02/25 21:27, Chuck Lever wrote:
>> On 2/7/25 10:10 AM, Greg KH wrote:
>>> On Thu, Feb 06, 2025 at 01:31:42PM -0500, Chuck Lever wrote:
>>>> Hi -
>>>>
>>>> For the past 3-4 days, NFSD CI runs on queue-5.10.y have been
>>>> failing. I
>>>> looked into it today, and the test guest fails to reboot because it
>>>> panics during a reboot shutdown:
>>>>
>>>> [  146.793087] BUG: unable to handle page fault for address:
>>>> ffffffffffffffe8
>>>> [  146.793918] #PF: supervisor read access in kernel mode
>>>> [  146.794544] #PF: error_code(0x0000) - not-present page
>>>> [  146.795172] PGD 3d5c14067 P4D 3d5c15067 PUD 3d5c17067 PMD 0
>>>> [  146.795865] Oops: 0000 [#1] SMP NOPTI
>>>> [  146.796326] CPU: 3 PID: 1 Comm: systemd-shutdow Not tainted
>>>> 5.10.234-g99349f441fe1 #1
>>>> [  146.797256] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>>>> 1.16.3-2.fc40 04/01/2014
>>>> [  146.798267] RIP: 0010:platform_shutdown+0x9/0x20
>>>> [  146.798838] Code: b7 46 08 c3 cc cc cc cc 31 c0 83 bf a8 02 00 00 ff
>>>> 75 ec c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47
>>>> 68 <48> 8b 40 e8 48 85 c0 74 09 48 83 ef 10 ff e0 0f 1f 00 c3 cc cc cc
>>>> [  146.801012] RSP: 0018:ff7f86f440013de0 EFLAGS: 00010246
>>>> [  146.801651] RAX: 0000000000000000 RBX: ff4f0637469df418 RCX:
>>>> 0000000000000000
>>>> [  146.802500] RDX: 0000000000000001 RSI: ff4f0637469df418 RDI:
>>>> ff4f0637469df410
>>>> [  146.803350] RBP: ffffffffb2e79220 R08: ff4f0637469dd808 R09:
>>>> ffffffffb2c5c698
>>>> [  146.804203] R10: 0000000000000000 R11: 0000000000000000 R12:
>>>> ff4f0637469df410
>>>> [  146.805059] R13: ff4f0637469df490 R14: 00000000fee1dead R15:
>>>> 0000000000000000
>>>> [  146.805909] FS:  00007f4e7ecc6b80(0000) GS:ff4f063aafd80000(0000)
>>>> knlGS:0000000000000000
>>>> [  146.806866] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  146.807558] CR2: ffffffffffffffe8 CR3: 000000010ecb2001 CR4:
>>>> 0000000000771ee0
>>>> [  146.808412] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>>> 0000000000000000
>>>> [  146.809262] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>>> 0000000000000400
>>>> [  146.810109] PKRU: 55555554
>>>> [  146.810460] Call Trace:
>>>> [  146.810791]  ? __die_body.cold+0x1a/0x1f
>>>> [  146.811282]  ? no_context.constprop.0+0xf8/0x2f0
>>>> [  146.811854]  ? exc_page_fault+0xc5/0x150
>>>> [  146.812342]  ? asm_exc_page_fault+0x1e/0x30
>>>> [  146.812862]  ? platform_shutdown+0x9/0x20
>>>> [  146.813362]  device_shutdown+0x158/0x1c0
>>>> [  146.813853]  __do_sys_reboot.cold+0x2f/0x5b
>>>> [  146.814370]  ? vfs_writev+0x9b/0x110
>>>> [  146.814824]  ? do_writev+0x57/0xf0
>>>> [  146.815254]  do_syscall_64+0x30/0x40
>>>> [  146.815708]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
>>>>
>>>> Let me know how to further assist.
>>>
>>> Bisect?
>>
>> First bad commit:
>>
>> commit a06b4817f3d20721ae729d8b353457ff9fe6ff9c
>> Author:     Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> AuthorDate: Thu Nov 19 13:46:11 2020 +0100
>> Commit:     Sasha Levin <sashal@kernel.org>
>> CommitDate: Tue Feb 4 13:04:31 2025 -0500
>>
>>      driver core: platform: use bus_type functions
>>
>>      [ Upstream commit 9c30921fe7994907e0b3e0637b2c8c0fc4b5171f ]
>>
>>      This works towards the goal mentioned in 2006 in commit 594c8281f905
>>      ("[PATCH] Add bus_type probe, remove, shutdown methods.").
>>
>>      The functions are moved to where the other bus_type functions are
>>      defined and renamed to match the already established naming scheme.
>>
>>      Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>      Link:
>> https://lore.kernel.org/r/20201119124611.2573057-3-u.kleine-
>> koenig@pengutronix.de
>>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>      Stable-dep-of: bf5821909eb9 ("mtd: hyperbus: hbmc-am654: fix an OF
>> node reference leak")
>>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
> 
> While one option is to drop this, maybe we apply this below fix as well
> instead of dropping the above as it is pulled in as stable-dep-of for
> some other commit?
> 
> commit 46e85af0cc53f35584e00bb5db7db6893d0e16e5
> Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Date:   Sun Dec 13 02:55:33 2020 +0300
> 
>     driver core: platform: don't oops in platform_shutdown() on unbound
> devices
> 
>     On shutdown the driver core calls the bus' shutdown callback also for
>     unbound devices. A driver's shutdown callback however is only called
> for
>     devices bound to this driver. Commit 9c30921fe799 ("driver core:
>     platform: use bus_type functions") changed the platform bus from driver
>     callbacks to bus callbacks, so the shutdown function must be
> prepared to
>     be called without a driver. Add the corresponding check in the shutdown
>     function.
> 
>     Fixes: 9c30921fe799 ("driver core: platform: use bus_type functions")
>     Tested-by: Guenter Roeck <linux@roeck-us.net>
>     Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>     Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     Link: https://lore.kernel.org/r/20201212235533.247537-1-
> dmitry.baryshkov@linaro.org
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This commit talks about fixing an oops in platform_shutdown()
> 
> Thanks,
> Harshit
> 

I was about to test this idea, but 46e85af0cc53 does not apply cleanly
to origin/linux-5.10.y. Someone with more local expertise will need to
have a look.


-- 
Chuck Lever

