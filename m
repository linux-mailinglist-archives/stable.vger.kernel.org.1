Return-Path: <stable+bounces-165186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EDBB1585C
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 07:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAFD77A758D
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 05:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7051487E9;
	Wed, 30 Jul 2025 05:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HRoxCq42";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ohGZ4+cj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5715AF6;
	Wed, 30 Jul 2025 05:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753851920; cv=fail; b=kuQNp+69jfyZOXVxcl+BhW0rN8i2u8Azpp2luauDJ/1GqcFi22hwNgIA+sHgcFUKSxsrP9PZFXlSIVi35fbqqFsvsaH6QhEPrWMZiQxmdN/rTheTQNu2hjvUB96l0Fi/gw19fO8RTvmIJDYjWLBUDENzme6QUAK6s5gqvc9zZQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753851920; c=relaxed/simple;
	bh=qbGGqegbKIjHVqO/x4ITBlUE5V1TklMVK7/poTX4Rxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uZgB3HvvhKo6f+34ZxQRp/uYgwv9MDzOn1hA1yG3NS37LW7VBcKyFDgUCckUMLeie7xSAo48T8tMVVjagSjs0o/mR/afwRbuigbVeSRphi7BPORw6VMIzDR/GvCS1kh9yB2lbgQET1kw2NNLpItetL/DybBhkPCdYb/R0kmtgj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HRoxCq42; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ohGZ4+cj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U4DhO3025291;
	Wed, 30 Jul 2025 05:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XRTR8hBUDBjzQCcv73iN2uVV8Wxy9+YJcBZR5wF4NHw=; b=
	HRoxCq42GJNENSugqlx92YmGWHI432gVVI73SmfUsAD9ecokJJX1eRcaUuRyyjvP
	Isya3kV6rpwRh7D8Er82s1cYn2dOzkuOErzpSWDn1XCDWH/rIyAdHnWptLR+BSVY
	zWsvtaflu0PVSZbwQW4EhJldU/b/nRmITtofehjlWjYkbQaRQUy4kY54oHqAq2bC
	/HU4aVIfsJGWI1eKdjElKE9SX05F0QWhPMRGfsKHf8Oe+ZdMiz/wUBfwNdWYMCQp
	ee+RsI/8sUm3/WgK4PEmN2WWi/7a/XLk96CUNRE09xqrkN8LExW22qY2yYBSmELd
	gkHHJ0qwCJlArFKiqcnsog==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q731464-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 05:05:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56U33D3a016723;
	Wed, 30 Jul 2025 05:05:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfh1jfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 05:05:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fC4meZlGNYX16VJq4lC+FjO3YGEu2syUdceThZ01wAqLaeO3L742elcDNlZjJw1Mo7R4fktSzNoaRs5Cetxn/K5ssVs5z5nAaXVIz7Sv79ayyRMCepm/meOXGExTF0gMf/Xv0aPpD/4X61pMgtfLuRU79JXjwhQyq5ySZXkOzUkuGFFOtsCH11rsUvlJoq5B3Hoj4QQhy9H0zlB4Vq+oAAAGqT7sMIL7rg+L3n5F2S4nkp/xK4D5K6XVCwhtwfNyWXbENiFKo4KErbwKKA/ETHFPJuhFv1jME6pr9DJZAwLyE4B4WQTfW+VIH1P9ycmGF8kf5UQyVrncWx5WJF0tSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRTR8hBUDBjzQCcv73iN2uVV8Wxy9+YJcBZR5wF4NHw=;
 b=hfCzNHQgFeyZQD7L/xdsb+yQXFFjDqgwygvq+RTWj/jJ9RzRJEMl1+jvkH9Mh+Dhl7enpj6OuCn3c5CKkshJGz2lK++3Du3aPTVdZx/HEH5dncTJ1LZek++9rWdThOE7Z2oMRtwn55HpU/qzoTirPbAeP6fwUTZHlIqB5eWYNVi/NxmensA8b95HahAO/Vk0DiZrlRiifuWC3SqODVLeLFnYvXD9GjHy+OXn/2cnxxsypxYdUJayzJB6XLToGlSxNNPDmPGet0Ol1J1GpuviijOur8qzjX/lyUzYiHJ4czsXPBnqXUGX9MxPEXcXfvDHZH3o3FdNG+ExT5gp9MpcVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRTR8hBUDBjzQCcv73iN2uVV8Wxy9+YJcBZR5wF4NHw=;
 b=ohGZ4+cjhawg2st3zZHbeGQQy4mnuDGWxsu7vj0qO2fvRm5A2UdRKZcO2KNPPNkzyx0urhs0IDLi5s5JUCkYrctkg82XXTvguV3vQX5N9ctcAoF2pJ/FIXpwxEP0spcoI2ZbOhAccswBKTFPfFtL03vS9f6E/tTbU5fhCFwxGBo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Wed, 30 Jul
 2025 05:04:58 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 05:04:58 +0000
Date: Wed, 30 Jul 2025 14:04:53 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: liqiong <liqiong@nfschina.com>
Cc: David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: slub: avoid deref of free pointer in sanity
 checks if object is invalid
Message-ID: <aImn9eytstNbfODq@hyeyoo>
References: <aIjPlvRyRttUDAow@hyeyoo>
 <b8ed1a62-79bd-4c86-a951-80b128223f19@nfschina.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8ed1a62-79bd-4c86-a951-80b128223f19@nfschina.com>
X-ClientProxiedBy: SEWP216CA0017.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4615:EE_
X-MS-Office365-Filtering-Correlation-Id: 7572e11a-6e73-4969-f23c-08ddcf26a167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDlKMGV3bGFVR1J0c3YyMEtHbk01RTgzb3N4Qmo2c1hVYTNpbjQyNERKTWlL?=
 =?utf-8?B?MTFlVzViVjZWOGxGbHZMaFBIN0JWcXBHdnVxbzQ0bTRGNjhiajBtTzFUQTJk?=
 =?utf-8?B?dVR5U1g0SzFTTndyVldidTVMWitacUtxRU1wMDdodldyUmZpVGxVL1JWWkNy?=
 =?utf-8?B?amt4aGpMTXovcFdpdU5IdWMwNnoyS3dNemYzMHY0VU9Pd0EwaFpYVmFwU0FY?=
 =?utf-8?B?S25SdWc1Tm5ZZmlEaThiSkZWQ1pvaloza3owWGR6eDNEVmdRcFJDTlY3U3dm?=
 =?utf-8?B?QWNGY2pjMzczckJiQi85Wk9WYmVPQVdLZkJMaWJUUzFMZkVEeHJiZVJocEdH?=
 =?utf-8?B?cmF4aWlQYUVyemkxRVB4NEVhdkJvc0xrNi8xQ2FzZm9SYmZleE5oVEE1Um1h?=
 =?utf-8?B?d2oxT0l4WE5UUGZpbUVYdUorNi9ka3AydGYxVUxZUWRBbHNZUlZOSnVTaUtM?=
 =?utf-8?B?MTErdWFxRGRrRGVHS0cxcDJnMms4Y04zS05YQmpuYXV4c2l2dEU3YW1yQldT?=
 =?utf-8?B?Y2pEeWcvMHNaM3cycUFXY2FjTndaWUhmWTYwRVJ3V0k3ZGZ2Y1RuVFJsaXRK?=
 =?utf-8?B?anFKVUlWNlk5ZTRTY3pVemorc3hZcFgwY3d3aWRraGJTYTBLMGVscW5Dekpz?=
 =?utf-8?B?TnBkcTFjR3AyK3ZZb0dEREpKNDY3eFBKem9XTWlvUHFRK0FOWWhqWWc2bGNT?=
 =?utf-8?B?alRvNC9uTkdrcmVBeko4d2N3NndqMHR6Wjd0SVAwSk03b3p3TUxXQ1B4S0pC?=
 =?utf-8?B?c0pxVVQyWldrS0VsMlhXanV2dXhoUk5ESEpEOWxqUnpCNXMzcDNsYys2aHk1?=
 =?utf-8?B?Z3liNUNyRjVJMFVjQURMQklZbnBzNllJMk1XbXdQSEF4eVJXMjc4QjQ0ejN4?=
 =?utf-8?B?ZXJuODNtR2w5d3ZEYjI1VDNQWFE1dHJ2dUZkYTR4YjFVZ0MwangvWkM3eGhQ?=
 =?utf-8?B?ekZ1WmhFZVczSHkvZTNhdXRyRnQrQjlWZldxUk5yNDhRa3h6MWFCTWJqTzVW?=
 =?utf-8?B?alg1RnZaamxPM1N0dVZJSnh0WWRxdnY2OGQ5QjRYd2xzVE9GRXVKRHhFaVl2?=
 =?utf-8?B?ZHFjMHBZOFRJQkVhbnlzOE5Hd1ZnaTZTd0xMR2Q5cDhDSWV4dUJSVzdScThW?=
 =?utf-8?B?RzlpRmp2MGpMQ0RBRklmRzBVOXdhZEcyeXd6ZVZkWEVnVU1iUjFTc3ZwMFdZ?=
 =?utf-8?B?ZGZmS0VzbmhoWDYwTnkyL0kwaDJOaFkzQSthV0tNZjZXUURUelpmNkp1bVpV?=
 =?utf-8?B?WGNRTURSM0ttOFozSHNNYjRrWkxicUxWclRBK1A5VnVRaURPanNwZS8rQjlM?=
 =?utf-8?B?OGFLSzRFaVZxM21DV0RveW1EVVpTT3FjdThCK2piU3VEemVBK3V6RlU0QjBV?=
 =?utf-8?B?N255NWtTM2p4a1pUZUFnZzZ6Z3lOTm4zOHVLam95QkR0N1dDMGJ4RG5Gb21q?=
 =?utf-8?B?TWJSSmtVSnBVNU5hYU5reEZ1ckt3bUhjM2UzVytRbUIvbHo3aGpLY1BUZW8r?=
 =?utf-8?B?eGhyMnR4dW1iV1VFNGtCTlh4ZTI3MXBqUkpEeitId2cvZERuSWtFTkJRMnNt?=
 =?utf-8?B?YjJuZFIwa0pDYU0wRDNqMWREdmZZTm5McVM2WVdyVmRjZURCQ2FVaTEreVlt?=
 =?utf-8?B?cklJTWpUSDNjWjM2bzUzNFAvdmY1VWh6ZE00S3FVZm9mK3dVdlo4bC9Ka2NI?=
 =?utf-8?B?allxYklsQ1FXZEMyRzlWTWNYWlRxVElqQnl0YlNoRGxubTdWOTNlQ2tpRE1D?=
 =?utf-8?B?UnkzUWQzU05BYm9pbTJYbG9zRkxUTkwyQWZ5NlZUeTl2Mnp2TWRMV2RVdyts?=
 =?utf-8?B?MHVWVlRuZTM5SWlTTU84dEN5ZUlCU2ZHMDhaRCtBTGZMRG84NjhOMWdOUmd3?=
 =?utf-8?B?cmZ6NjM5dmhpRCtjTWlKWXZtVGQxdzR2ZENyRlk4bHVieU5ER0FoOWNUVXc0?=
 =?utf-8?Q?/QYYcy8Yzw8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHBxSDZQVCtjQ2piUG9LZ1JpbjBVejhiakREbnptMFdOU255b1kvQ3FIV2FJ?=
 =?utf-8?B?d21obU1jblZFKzdtWWRmblNWdEV4ZmZmaFZmR1RGYmoxVE4xYkU2OEhKZVF3?=
 =?utf-8?B?M2kxNk80U0RFQ0xiZ0RML3J4OXAzdkIyVlVXZGRVbDRFUmFlNVpiWXlpSjJU?=
 =?utf-8?B?VlpSSWl3dVcwN1RZWVdGaVUzeUtMUGZzVXIzTS9na1NzVUxOKytraFcvb1Nm?=
 =?utf-8?B?NVo5d3JFVXpaREdlMFZETVVPaktBVStVT1VEdXVUdnZSTzFRbEQ5ZHFJQS8r?=
 =?utf-8?B?QTQ1U0JTRU9BdEdkT1llcUpJdXB3SXZYelJWY1JNS2U2VnNoWkdDVEFpRFZa?=
 =?utf-8?B?MTZrdlgrRDBVT0sweVAzNmltdkxpT3llVVJrV2QvS0dDUEdrV1lRNytTMDBM?=
 =?utf-8?B?Qi9RMmZKQldJeTk2L3hQbXQzQUhsaHlDaDdsRktYc2lqU0I4RU1FYjArMzJh?=
 =?utf-8?B?UVBXYWpyMEdwdWlZUVkwWW0rZmRMVVJKd2pCQ1Q0dkNFVDlJSTBZZzNJV0s0?=
 =?utf-8?B?R29YN3VnQVNsRE1tZnhldWhTQ0RsY1ZVeElObkxiS3pmbEVxOXlPbjNkYjlk?=
 =?utf-8?B?Z1RBbVQ4aDh3R01SQTJadkpURldMRW95YVhFMVJ4SXVnWXZtRk5qTitKdFRL?=
 =?utf-8?B?Lzc0T2RISEtVYXU2Z0F0YUhKMUZFejJxR1BHVWZ0L0oyL29qT2NSQUhRZURK?=
 =?utf-8?B?SDAyTHNkR0FyWEhhUy9FMHdiTVJKSlVCVzZxYnJmT1JickROOHM1UExIRnQ0?=
 =?utf-8?B?STIyVG5veEU0bjNORVBxZnpSS2JXV3htZlV5ZjlVTjVNSkcwb2hzaSt2NEFt?=
 =?utf-8?B?OFNPQjBNMWZMVG1QckNNRFovczgvR04yZ2dDK0VkcDRLMEVVNkhoV3RWUjdP?=
 =?utf-8?B?eDl0WkgzcythYmJSRU1iTmV3Vm9yRjhqRCtoVk5Oc3F0UjJjaGN3SlBDQjh5?=
 =?utf-8?B?OWwxM1F4NjJHUUhZay8xMWxEbUtVZTRNWWZEWGhUT2hrR3pTRjVOOFIxWmJ0?=
 =?utf-8?B?OGR1Q3BPQUh6Nyt1ZUJ6bi82WGhXbk44dXh4L3M3L05lUzUraUVqNCtwUnRU?=
 =?utf-8?B?ZmF3RzhCekl6MDVkMEZyVWRPQm0rZ1V2S1NTcEdicFEwNnh4a3pJUGwxSUFI?=
 =?utf-8?B?ckxiaEJJVHl6S013SVJ4ZVFScThhc0dyNjVjMlVyWWxrK0V4TmpXU3hkWnl2?=
 =?utf-8?B?aFNoc1BYVVo2OHZybjN5Q3djTmM5UHlvY1I5YTdHNEJYdC9vbm5wZ1dWYjBV?=
 =?utf-8?B?Njc1RkpSMGZ5MjBDN0FBY0NqazNrNEw4SUdueGV4cGpkaW9JcGtCSnFkM1JU?=
 =?utf-8?B?blBjWWVJbkkzV01neFVETlgyNmViZktxbTZPZlNiaER1SlptVTNERUZxdENW?=
 =?utf-8?B?YTl2eGpEdEdYcEtPME5sNkw5RC9tT2hnd0ZHeWpYR2FDUGJEZ3dHMWlFT2hL?=
 =?utf-8?B?V0dBaCt1TVNaTFk3cmQ5cStaRU5FdVQ0UHF3aEFWQy9QOGRsYzVLQWJYb2wx?=
 =?utf-8?B?cmx4RkVha0lXVlRSZ1M4MFFwOGRoVkxSUTlhUTRPeU5lbWFkc3Rtajd4M29M?=
 =?utf-8?B?SmxkRk5zYXNFaTcxUWtOWXFWQ3ViKzRNdnArbDlpenhkR3d1dEx4a1MxWnVw?=
 =?utf-8?B?b0k0bWdyYTdHWVUrdlV4bXFzL1NTRGNudXBTS29IOGI5SmV6YVpOQkNZTW8x?=
 =?utf-8?B?UG91aUxCa2lRMGtaUGtETldaZ1F5V2hteUpLTGduZlhVcXdZZEpkZHJ1NFRO?=
 =?utf-8?B?dXVWdHNLZXUvbWx6K1Y1UlFHZnE4L3pJOTN5dGprV3gzZE8yejRrcTEzUmVH?=
 =?utf-8?B?RkJmdGdvbmQ4NENZSC9xSXZMSzVQMWpiTDV2cTdiOEtWRElnakVFTHV6bDNl?=
 =?utf-8?B?VnA1dGJLRUxDb1dPemhCcy9SajRORUxPVnU0emhBQk1OOXY2UjRucWRqRGFu?=
 =?utf-8?B?WmxUY3pNUUE4blJBZnQ5UEFlSlRaV25UTmhEd0ZROXc3Ymw5OERMbkFuWUFD?=
 =?utf-8?B?T3RYOEJCa21rNlJHYkdXQVFZaFN4dzRaM29Xa0sxNTUrbkpPN2JYTXoxbWlk?=
 =?utf-8?B?dVJYdVZRYWxPQ1pvbUZrNVFrcE1tUHNwNGE0Sk9jY0FNUXU3RzlmQXp1VXlm?=
 =?utf-8?Q?/Ez7+fkn9KwZubT0aHFv1BFE5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RVG7h+Qp9wNQbDbWiFLvJliLNEp8LXnATViNZQMOYVJuRmqGK8edG4OAWhjN5FCEV+pEfvyFpGuRTPlWvOrjInW4UZcWhdUe/0bKaULnAUHH99KNOYUdA3whnM/ASwmobZj2YHmYsUZvH4oIs59ZXCwohKGIFozu0uoCEbYPfKzyP1h3ViGjOpK4N7mMa+J7XjgE0ya8FRWWsh7Grfe+lbh5Um/dVzbBpiaPAwLPGV4NCn7PbWA36/xlRZvD1fktDiBIxAxJ3h46jH94cdvrg7o8wSNZkx7PIBpjKTR9MQuyFJL7hl26Bz0UJ+bdSXtxMmUyJ1yjieYKlviV3V221IccByOuumB9C+HBdkMr650CBvDhmiZU9FZhVRBup221KRoqavcSvLJ6+3SYdxDUYvtxaGD9OIzu4O9KlGh1xMdMRj3ELo182yQpntnxx0sd+8n1LQEym53HcCHGF5R6BszjveaAwU6ExCOATLSwbJyi28KlA2yC+aztH04PwAvVgCHUcI+GGNFuU2kHpXVWidOy+190gwDITwlm2kCwxJDm6tw/IBDzC2HrYu2c27zXaLAAaRhpqtniObXu4LjVYc24BmO3U9UUt713jqwRUcM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7572e11a-6e73-4969-f23c-08ddcf26a167
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 05:04:58.3214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zI5vuxQy+g9ReOuDcsvL0ULpKpkiaT8fE+EKRPYNmLFlMTypxRnZpIIuleVKTDjdEMdRvloS7l8i93aXgw2ERA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=973 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507300033
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDAzMyBTYWx0ZWRfX1RJYSHYEP2+S
 I1WSOdaYDpV8LWWkpcNyxEUAuMbgn/s4WctOn5FSgFTC5XvsbWluzfum5NMceHzr1jixsZQmHUN
 SmXLmFPonMmMN3p0BSkNjnQQ1X3fL3Qe5wkRx+GleOus0N4g+u8ODj0VfekJSwqgYQLVfu/xLUt
 dcH5KJiHG7tjuCa24cVZf5V+JTMLKoVZTMcrlr3Y7fnWhWIB0E5i0hF5iMBRNxuROGYfX1mGgNz
 OZ/JtbvIODoy9hpnMo1S17U6uwy6rHZNx6WOP7nv4E3j2vPHvIpCK/c052woHP79AIwXF2t7ZSL
 U7oMKkWptYgbAJkJ70lU66Hhu+g+QGmtVrMbQpzM6KN4+abkba4Art7EksaZS9SXiJlCh/9+tK6
 t/F83NQ0Jy6qZ3VNqHfUM5b9lQnuPpvRpwlj1Njc4yUBRZA6s6kTLIejIeqOMdcT6ig15Szs
X-Authority-Analysis: v=2.4 cv=ZO3XmW7b c=1 sm=1 tr=0 ts=6889a7fe b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=SlVAvriTAAAA:8
 a=q-iQTzz-r6Pyo1cLn_UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=qesGs21RGGeVIEdTuB6w:22 cc=ntf awl=host:12070
X-Proofpoint-GUID: UeLp-Hvfa6-54bn3d9zMA8absHRCQSMj
X-Proofpoint-ORIG-GUID: UeLp-Hvfa6-54bn3d9zMA8absHRCQSMj

On Wed, Jul 30, 2025 at 09:46:09AM +0800, liqiong wrote:
> 在 2025/7/29 21:41, Harry Yoo 写道:
> > On Tue, Jul 29, 2025 at 04:14:55PM +0800, Li Qiong wrote:
> >> Fixes: bb192ed9aa71 ("mm/slub: Convert most struct page to struct slab by spatch")
> > As Vlastimil mentioned in previous version, this is not the first commit
> > that introduced this problem.

Please don't forget to update Fixes: tag :)

> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Li Qiong <liqiong@nfschina.com>
> >> ---
> >> v2:
> >> - rephrase the commit message, add comment for object_err().
> >> v3:
> >> - check object pointer in object_err().
> >> ---
> >>  mm/slub.c | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index 31e11ef256f9..d3abae5a2193 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -1104,7 +1104,11 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
> >>  		return;
> >>  
> >>  	slab_bug(s, reason);
> >> -	print_trailer(s, slab, object);
> >> +	if (!check_valid_pointer(s, slab, object)) {
> >> +		print_slab_info(slab);
> >> +		pr_err("invalid object 0x%p\n", object);
> > Can we just handle this inside print_trailer() because that's the function
> > that prints the object's free pointer, metadata, etc.?

> Maybe it's clearer ,  if  object pointer being invalid, don't enter print_trailer()，
> print_trailer() prints  valid object.

You're probably right. No strong opinion.
object_err() is the only user anyway.

> >> +	} else
> >> +		print_trailer(s, slab, object);
> >>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
> >>  
> >>  	WARN_ON(1);
> >> @@ -1587,7 +1591,7 @@ static inline int alloc_consistency_checks(struct kmem_cache *s,
> >>  		return 0;
> >>  
> >>  	if (!check_valid_pointer(s, slab, object)) {
> >> -		object_err(s, slab, object, "Freelist Pointer check fails");
> >> +		slab_err(s, slab, "Freelist Pointer(0x%p) check fails", object);
> >>  		return 0;
> > Do we really need this hunk after making object_err() resiliant
> > against wild pointers?
> 
> That's the origin issue,   it may be  inappropriate to use object_err(), if check_valid_pointer being false.

That was the original issue, but you're making it not crash even if
with bad pointers are passed?

> >>  	}
> 

-- 
Cheers,
Harry / Hyeonggon

