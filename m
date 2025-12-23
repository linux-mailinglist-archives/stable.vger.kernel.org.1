Return-Path: <stable+bounces-203328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D603CDA454
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 19:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E899130115E6
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 18:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C693D2F6920;
	Tue, 23 Dec 2025 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WsVZCRI+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dcj3aQHQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA62F5473;
	Tue, 23 Dec 2025 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766514551; cv=fail; b=tNbCAehB9FBi8xSRRhG1pu5YEp6lo8UoL9aPH40Q1x2pN71kTCg4qG+nlsPGhDtA4AOXI4AkdxaOwhJzfnprpihq4nI1xDwexXOn/qcArpUkPViulOrywQDwmGtjLnM/k8yJQdY/ViTxIb9D/d8ZE1jv1McLc5d3xu+jk6T1mGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766514551; c=relaxed/simple;
	bh=2xC1bKUoorFGKTLdL7zB5mD/XjRKFPznjau99CU6XJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1L7sxovSXU3Oqgo/Rc3W8GjdaULEyTksDBUERNEVPqbLb3yPli75zndGIEtO3uQBpAYKpwlsS+n65uYh5BIe6HlCihrUsCj+ovwVm/Nr/Mcn2cImYS25XhQc+OyVl7UNyhmDV1YEj4Xk2zCLxau3zhcNrg3lFldAFp1E1qD7q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WsVZCRI+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dcj3aQHQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNIBMP21284617;
	Tue, 23 Dec 2025 18:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=59XPS2lOI7LDmXclWnIPn7ccOgeW6eIrCH6n1tOlvGg=; b=
	WsVZCRI+FC2vTinYeJ6i4TRC5o9gjwt4nqgcVb539XU78k7gtWtTdGfcJ3zU7TqX
	gRfmDp2rTxH9aNBduO6fTx3ZzStZggRQisUUgd0ESIIOqpniGSJGz33OHVhLK1Rc
	3NMP/C+2fzQbKLpzVAEReYFegUfHjZGfbEXzw7+N/rGrmt3MI3ev29Mro5Mx2+tI
	jkvielLU5x7BhBEQpI2PwgRhVO9Cm6f3Bm/zPZv3iRIUon8qD/coz87RMGv2eMHN
	e6ZlAMTSdNSM43kWzjxq39P2U4R1FPO+aJAFV5It9LB+HRgo64VcjGkDGAo4C6NO
	KCn4/GSWyfKQCsjHpq7Vmw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b8051g0nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 18:28:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BNGCdTx023599;
	Tue, 23 Dec 2025 18:28:28 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010045.outbound.protection.outlook.com [40.93.198.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j8cqra3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 18:28:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lC+dJMtRlWzLbSY/Ao8LgVitkfVqD4H3VnmplrWUk0Noft5C8YH3oi5bcbf+wFRyGfAV1+4CjXN36GQHD2/X/i74anHbYuExY80CNTHenJvLp5TI1nzyXXe2JHaDOLco1R46sxIp/caLfTmdtB0g1MHalTs/+4tbJ0s3Owp3Chi6FM7yrqMxePEVjexKpMbHL5KL56TSYfJIcPSu9YktQ/VtbSY89VzQtdAxbQlFucHxVLyE1tm3q2A308VXzavHp+QPE6Q+DNaAVyGOyPeGzNaXsrl4op1oL8KmmDu8cfaYJdZcPhg14VZaD2hOgvZfTs0KTeN4v+06AIFF0XUUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59XPS2lOI7LDmXclWnIPn7ccOgeW6eIrCH6n1tOlvGg=;
 b=ldG3Wghy/BzmcTG5NNVID5g7oKAH0nvsGmx8rpIe2Epa5nPExwrA/X044eIE16DS3vbnZO2RItAic0bdhTJE3AqDQBVRQ9755UA43ZmazO9gkk41MZPvWFx24zLGXmAij/qaMVPmymI3k7xK/OtL52SGldWRjAP78/SfL3hDyM7oeluNDIYXttp3/fDbBfGkilVvbxnsj19oaS0zrGYqimMQe8DWyxZuMNVg6LIkH6M/xHTMRdihgDwHZYtnAKiqnkebr789fDOXLRCcfEDvVZv1Udq5J4+6Dk5D1ATU03W6ugFeNtb/nFBtJdc36cBnBHGqnSCsFyXNnrhwModNdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59XPS2lOI7LDmXclWnIPn7ccOgeW6eIrCH6n1tOlvGg=;
 b=dcj3aQHQhdrWbNrF89rnFtjiJgSb1E0OXJWCp6dTmKQ8lu9bP+z7ne3cgzlR01sLs8bnHH3pu/VZ7ioQIK5lmaihV+OTrYJYeJ+1/f4g+1IjY/o1At12uea+z+FE1YVCfvoi6VmC+rdu6kxNm5lGv9l95NiAmtvP94jpYz5lazE=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 SJ5PPF912A858AF.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7b9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 18:28:16 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f%5]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 18:28:16 +0000
Message-ID: <f2ec1578-bdc7-414c-9d6c-ae8fbd7cd54f@oracle.com>
Date: Tue, 23 Dec 2025 10:28:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm/memory-failure: fix missing ->mf_stats count in
 hugetlb poison
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
        linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, stable@vger.kernel.org, muchun.song@linux.dev,
        osalvador@suse.de, linmiaohe@huawei.com, jiaqiyan@google.com,
        william.roche@oracle.com, rientjes@google.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@Oracle.com, rppt@kernel.org, surenb@google.com,
        mhocko@suse.com, willy@infradead.org
References: <20251223012113.370674-1-jane.chu@oracle.com>
 <d9e09523-2b61-4280-876e-95be787258f5@kernel.org>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <d9e09523-2b61-4280-876e-95be787258f5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:a03:331::33) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|SJ5PPF912A858AF:EE_
X-MS-Office365-Filtering-Correlation-Id: d83c7c91-dd4a-4dc8-194e-08de425109e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUNhZnhJcVZHSk5KbjJseTROaEY3QkJyUHBMR21VVU9WQ1JTT1daYW5VOWRB?=
 =?utf-8?B?dkhyeW9jK3V1VHpFSThscDFLR2tTcDZDZzdTYU4zdFlkc3A0K09yNnhMMDdJ?=
 =?utf-8?B?TzE1d2s2eUREUTE5N0ZPTllSUEpqWHpaOXUyL1J3Y1dVUHFPSFBCdGZtb0Rk?=
 =?utf-8?B?Vmh2cUx4eE85cjJVM2RPYVE4L1J5Y0pmQXE0Y3JEU2Raa1hJWTZDK0h4cHJZ?=
 =?utf-8?B?RWFtYTZaK0pVdUx1MGlmOXcvV3NsSzdYdmZjdkl3U1B6SnIvaDE0VHdBQ1hL?=
 =?utf-8?B?UHBzazlZV1JWU0xtOW8zOTNSMUdCdjFGSWlzbURtQ2NJMkhDSVRkYnNQNWxJ?=
 =?utf-8?B?ZWgxUjVSSXhjYlUraVJ6aHEzbHZMN05tYlRCZ3BDK2FLK0xXcTZzWExoUjVm?=
 =?utf-8?B?alFMM0MzS3VTcDBvU0d1RlBsZW55Z0t4cGdjRStnck1FemhBR3pteW4rNHRF?=
 =?utf-8?B?SHNYeURiemZoemtVeGlUNVp1aU5qbTZGblBjdzJsYXZiSUJ2MjJOWVY3WUJW?=
 =?utf-8?B?TXI4TU5SVCtSR2s0UDZqV1RiZHR1N3lDS29pNW9kVFNTM1RFQkdUa0E5dzg0?=
 =?utf-8?B?aXgrbUJKSkhNRUpBbi9tbE9sTXRFbUFWZDNLV0lZZFFBOTFkL05FdVhWYWRu?=
 =?utf-8?B?clozeEkyem1hRXBGTHZaQTQ2ejc4Q3FBYmR0VHB0YUFFdzEzWEp3VnNGcjdI?=
 =?utf-8?B?M1pWdXhHRW9tT2h2VW9TUU5OTmp3RVhhcEJINDBTMkpIN2pSbHVuVTUwSFRR?=
 =?utf-8?B?d2MrcHZKSjEyK3BmajBFcXpoYlpQTCtxQ1BwVnN5K1VEUHRlVDRJNjYwMFc0?=
 =?utf-8?B?bFJyNUc2ek8yYjg4a2t4VDU5WDlJTWpVdFZ5d0VFeGk3RWptQ1hNckkyTGhG?=
 =?utf-8?B?N0RrYzE0L1JIZkRnMEdUbmxVRXNJc2VjK3VlMWdsRkJRTHg3bzNJY2Z1VnYx?=
 =?utf-8?B?UFpWeFU5N0tWWkx1MGU2Sm9SSk5QTFpiUGowTVBza0hRMzFzb3gzVG5EN1hK?=
 =?utf-8?B?Z01IV1FuSVZTZkg2NDRnZGQreUtFbHZHWkRMcHl2VXJTd2E2YXpBVDRtcGZJ?=
 =?utf-8?B?T2d2WUUvZit2Q1FBVytTN1VRdkZBc2ZEbVFvMXJ5QjBmTXlwSm43ai9qUTVJ?=
 =?utf-8?B?REtCTndmSUJnc012MDh0YTFWcCtzMDFtYmt5K0hISTlDOFBVQittTVdJWUNC?=
 =?utf-8?B?OHlMWEtGbWVtLytlbytLSU9vMmFmTkhib1NIclR4N1c3aDl2WlY1Q2VDQ3FG?=
 =?utf-8?B?UTU3SWMxWGl4UFF0WXBqZ2VrNTBpL20xa2NwQ0dLb0M5VmQ1dTI2dDAwWEFY?=
 =?utf-8?B?TnM2bEQzYTRSbVV2RnZzV1l2VDFNaWJLekNLd2Jsanh4WWZpV2U0c0JveE5Q?=
 =?utf-8?B?KytONnZqam1SZUNnZ1hlVHhSazNLcUJSajZPK0xYcG9iZE5GelRZUzR6NjBv?=
 =?utf-8?B?bGtkOUpSS0dYamlWa3RuZmtnU3o1WGtKMUp1T0IxNmhyKzFJRTZBOWN3Vi9L?=
 =?utf-8?B?aFp6OEt2elQxODJwUk5hRTlTVGJQS0l6bFFLbVJnWmJ2WWhEYTFGbU5hUmRM?=
 =?utf-8?B?end2bWJ0bnRCdFh4UEo0Kys3c1ZGSkNjK0NmRndNQkFxaGs0SHowYk91VDdy?=
 =?utf-8?B?b2h5OWppbWFleDUvNGZtVWkxQzZmOWpiYkRUOUFycjQ3Y05ERk16bjBZUnhF?=
 =?utf-8?B?TERCcmVBVmp1WDdqU1NZSkhXeXpZeVZNTUtIQnNWTDZTcnBkTUllRmhkRkNW?=
 =?utf-8?B?dVc3N3lGTWRacU5FMFprOGNzZUJwb3dqb3V0S3FsejZqOUJYdGtMeHhac0hO?=
 =?utf-8?B?SU9uemJYY1hWTWdrOGt1TnByQWYrNXdIS3gwOG9neGF5S2l0TFZTODBlQWJX?=
 =?utf-8?B?SENLOFM3c3VQSjArbzBydzZCTmtZeGZFOGdtdVRQNXNlRE0wVzc0NjlkY212?=
 =?utf-8?Q?IAyRwvh/U25P5ka0cYCqzU9u01nsqvxP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFhpRHhlTDVITDMwdXk4M24xczdsc2JGR013OTA5L3Q3eHBZd3JNRTNBL09p?=
 =?utf-8?B?VldMK0N6cGZlMXpFdDMxS2JSVXEwNXlxZnBNQ0F1b2doZWZtVXZya2hxZENQ?=
 =?utf-8?B?dGo1Rndod0ZsYTZQYTNWckx1ZEFDb2c0WDZDL0tqTUY1OFUwSTN1WlhEL1Ey?=
 =?utf-8?B?eWFxTkRRZEZaSDQrQjh2OS9aNmhobE5XS1N3N2tCL3p3UFgvVlVXNHE4WFhB?=
 =?utf-8?B?b1lBaW1PRENQYnJOSjVtZlhCNkFLalc2NTFDU3BSSkZBZm9QK2R4Q3J5c01w?=
 =?utf-8?B?TTUvb0UvNkxHdWk4cS9ibGhpcHlmRW42c1cxU29XZCtZZ3lDdmxxdDk1RGxi?=
 =?utf-8?B?aWdsdUEzRzRRZVdJU3JuTTMxTnNocStmdTZLMnkvUDVST3JybXRnOXBrSzU2?=
 =?utf-8?B?QjBoOFFieEFqQkI0bDA1ZGQyS1E0MjUxY29uTEU3UVU5bU4wQ0pCOTdkV0d3?=
 =?utf-8?B?TnY5a2JTSzZqVUJGM1JNMkE1a1ZZc1NNbWNZbnhlWmVYT0U5UVovTWRMRGk5?=
 =?utf-8?B?TmxzcEhOamZHNGp5dEpvNHREalQ4bjc2VjdZS3haZXpCZTFXdWRWL2V0Mnl2?=
 =?utf-8?B?c1ZKU0tQLzNWaEJtMEJRNklxbnl2RjBLUW1kNHVMQS91WlFzWXFENTJHMVlL?=
 =?utf-8?B?MUt5VThnWUtnajFyYnJ2S010Mk80RHVCd3dKTmw3Tkg5dVJncjZFV2JRTlcy?=
 =?utf-8?B?QnQ0a20zNzc1QUMzTzA5SXd5RVB5YzRoaVRoR2YyVytkSENCNkVnU0wzeVF1?=
 =?utf-8?B?bFZNZy9OQWp3UisrdlUwYVhaU1Y1Sm92aTRhT25nTUFWbExtMUE4MjJRNity?=
 =?utf-8?B?QTQyWlF0eUZzSzVIbGk1VjBTRTZKSFJtaW9pUDlsLzZ1S29xYTEycmJ6VGZG?=
 =?utf-8?B?SlZYUE9wSm1zdkxtNHhMQ3VPK1JpcWI4bDJDVUl4QVFmVDllaWdoMDFQZC9x?=
 =?utf-8?B?bDFmNUJIbm1FRWQ0Q0NBY1djUnNsVFQ4M0ZkZE83UDg4WXBoYUJSRnBqbkpW?=
 =?utf-8?B?MUkvaTRvN1pzMHFsOGhDTkIrOVdWNFRYWFdXaHJHOEViOWl2S1R2ZHZROU5h?=
 =?utf-8?B?NVMwczRpV0NUT3pDMHRMbXdSUUoyZnRySStGcDJTemZ2aGFORTQvbnJicHRm?=
 =?utf-8?B?aFUyY0lXOC9IdkRlbnUrajVDamJTU0lTMWZGVTVFQTdBbWZTVzNwYWU5OVUx?=
 =?utf-8?B?VDJQTzlZWkxZSDlHQzRYcktvajl5OCt3aG1oL250c25tZ3FiZjNTQWtQZ1RV?=
 =?utf-8?B?UFFqeDZZQkUyc0g5MUxIQVlRbVZtblU1eHVadVQ1VlcxSTZMRzl5aFlJNElR?=
 =?utf-8?B?YUpoK0VIRTJXWDBxejBjbXQvdDkwc2hjZTFHcUsvRHU3ejl6SFlTZElJZWo0?=
 =?utf-8?B?azhvZFo1TGVWZnNQT1pvcFpSb0JPSlZyRXdNK0xRUmhtRGZBSjIzR3dUL0Y1?=
 =?utf-8?B?dXVxdFNkV0NZMW5SdWNGbVFqMm9OT1VFalBObVVCTlJkVUZNZkdSdmxzaHNi?=
 =?utf-8?B?Y25yUk1HWDdCTWRxK0twRVF6cUtyeUhQNHBPeVFXWXl3bmVxS1RUbGZhaENk?=
 =?utf-8?B?RklkTDZHNG5PSW1lWDdtT2t4bG1TR3lTVGczOUYrakluQUNja2V4M0VkVXZs?=
 =?utf-8?B?aDl3SzgrT1F6d2V4ZTQwVXRkMWhSY2E5cWVxcG5CQ05oT0pMNTNQOGRacWU4?=
 =?utf-8?B?WTErN3RZZkNuOGpLUm11VGF5ZzVuQkVtbWdPZnhtV1ZBNDZpZHFTbENOQW1j?=
 =?utf-8?B?L3NMa0JHWVltRkM3Uk5jalVnRnEzeklJRndJblJ6TjJGZVY3c1RRQmZiaVJp?=
 =?utf-8?B?eDZQNktqK1Q4R3pvOFZ2eVlwZjd1Y1lYc2VHL2p4VWRrU3dXb0Z3RXgvWEMr?=
 =?utf-8?B?bGRLa0M3RDZNNkFRMHVTekJoQWxZZEpPK0dldzVWN0pSQjlPWlVlRC9CVVh0?=
 =?utf-8?B?SXR2Qkc4RXYweCttTmVmWnBROWJnQVR3K2thMG9pU050YXpZV3Rwc3lMSWdM?=
 =?utf-8?B?dlVpUCtBcXRJSW1kQ1N6TndDN1NCaXFpT1loYVhBZHJEYjlFdW1zWTUzdUI0?=
 =?utf-8?B?TkNUOXV3cHVZbzVqUFRtMEQrUHFkWGZWODZ5ZXJ5Q0pRbXpKejNGbjVJMEk0?=
 =?utf-8?B?SGtVZjkySHdFT0J2RmFUenk2OUowMnRTZkJHbUVRZVFrNGtlTHU3RUNLcTVH?=
 =?utf-8?B?SjYya0NqUmp6bHpaK0NTeEpqZzluMzQya0JJN09BZXZyaGpUd0xVRVVZNmE1?=
 =?utf-8?B?a2xITXZiNVFwc0hhbit3RkF3c0hpeVJSdkpSWlN0NUtvaTFrQTUvU1ZTL0Vp?=
 =?utf-8?B?NWJuRTI2R0R1dWtNNGlwQ3FjaWdxaGMxZ3ducFRzbDZ3RXYxNy9xZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p6ThYRpdMp4rwUoKGHoj3mnmkHPd+wAO7C1Q2vQ/P5zr4tREJwBWNdWukFE9cdjLW+zZvS31cXKMt7w+353Dutf/14QXqET1xTzbFudFs41IdNFvkaYWGtG7jwb1iY8GLnJ/9ACF6Qk9qJoNYyEofD2OwKMTqO8ZtGAsWSUQ4kYGYQv5DZb+qAeJ3HP3wSxY7ozBJfBGVuOIO7Tc4JxoCiyP8aBLvx8gEaOEiH0TsEHFb21mjZ82o94iiDbQA712ABensYNiGyzfb06dAgGIWoadeDy9NU3aBrwlCZ38o1xQmcY9jUxan3VB1J5ukZp1eofDR3R9QTiKigMvQI3MlrIuk38Ji5LNHm6edXBsgdyK+18bfkCb3ky28ywe9IOUKGA5ENcr2CrtIO4aQBhvfBy63mRz4Mn7jP776xaYGl3iq6iPSVIwGi43AM1RPSoCpNjnr/10ddfLHRxVZkBWrpPLHFRUM1OADFiPQ9xhnwrTmbzqgE7UpwmzD0/b9gVPFkRT/t7jFc0GNzIB7WF3MCUVrtPMRBMbaKcXpMm5JuHh3OYORjz1orp/5pjHuwpy8voBRyOY1WHt6ZwBvCdm2TMXCNvVaLyygzE+CRnskw0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83c7c91-dd4a-4dc8-194e-08de425109e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 18:28:16.0919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKvufTSzF8hH84h0ITsArfKnCs2oJY2EWeN2AEpi7e6KLNqg//qxbtDsu2SsbrmZkOx5NyLTDStrcsawMS38lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF912A858AF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512230154
X-Authority-Analysis: v=2.4 cv=HtB72kTS c=1 sm=1 tr=0 ts=694adf4d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=yFNrg0jVBaeHGcGyo1wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654
X-Proofpoint-GUID: DMH0Hav7YJUphSQQTxOegqpwHuGHDW_o
X-Proofpoint-ORIG-GUID: DMH0Hav7YJUphSQQTxOegqpwHuGHDW_o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE1MyBTYWx0ZWRfX85gkx+qyi2Nj
 z2ROqch56bPWCUFz3srLZfiPQHUemCm+lQss6trbtGRAsqhKg27fYGSOZtvoOf4QUXd9STX46rz
 RVxSjjRt151c2xoljVMvNo1GvkHALQvvgcnZ5kEMO84Tzv6yRsL8x/YwSPI29v+qDXfkBVOC84X
 1ytk/8r4GosK+fv0mKLIPMzEeYI8tY2CzlbdajEsDNYSfuDOfZvi0YAY30BhPX1rLzyDuNEUSGx
 wdzhm3p69J27+jsSx3iwhBym6GuGV2ISeK5IIB98HJHjhee9rxXM5ZQO7lo8BZYkQ43n+JWK6bu
 qg3tQT+oACFk9ApmrM+kPGdSk5axxZNeex6qEpjPuSa/xlrJVqJrZfeCniOdmahyVmlHzO6SeRs
 wrGu/4GztIHWrAud+Zg9Jf6D7or0iRF4Zv6xoBX3++wwgx33rKueHw3+n1tPCB0UE0IrjAAi7we
 zfdpzVXtZLl70IMvgDXuC58OebcU/Cagu8LoHHqM=


On 12/23/2025 12:50 AM, David Hildenbrand (Red Hat) wrote:
> On 12/23/25 02:21, Jane Chu wrote:
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
>> Fixes: 18f41fa616ee4 ("mm: memory-failure: bump memory failure stats 
>> to pglist_data")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>> ---
>> v2 -> v3:
>>    No change.
>> v1 -> v2:
>>    adapted David and Liam's comment, define 
>> __get_huge_page_for_hwpoison()
>> return values in terms of symbol names instead of naked integers for 
>> better
>> readibility.  #define instead of enum is used since the function has 
>> footprint
>> outside MF, just try to limit the MF specifics local.
>>    also renamed folio_set_hugetlb_hwpoison() to hugetlb_update_hwpoison()
>> since the function does more than the conventional bit setting and the
>> fact three possible return values are expected.
>>
>> ---
>>   mm/memory-failure.c | 56 ++++++++++++++++++++++++++-------------------
>>   1 file changed, 33 insertions(+), 23 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index fbc5a01260c8..8b47e8a1b12d 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1883,12 +1883,18 @@ static unsigned long 
>> __folio_free_raw_hwp(struct folio *folio, bool move_flag)
>>       return count;
>>   }
>> -static int folio_set_hugetlb_hwpoison(struct folio *folio, struct 
>> page *page)
>> +#define    MF_HUGETLB_ALREADY_POISONED    3  /* already poisoned */
>> +#define    MF_HUGETLB_ACC_EXISTING_POISON    4  /* accessed existing 
>> poisoned page */
> 
> What happened to the idea of using an enum?

I briefly mentioned the reason of using #define instead of enum in the 
v1 -> v2 comment, more below.

> 
> 
>> +/*
>> + * Set hugetlb folio as hwpoisoned, update folio private raw hwpoison 
>> list
>> + * to keep track of the poisoned pages.
>> + */
>> +static int hugetlb_update_hwpoison(struct folio *folio, struct page 
>> *page)
>>   {
>>       struct llist_head *head;
>>       struct raw_hwp_page *raw_hwp;
>>       struct raw_hwp_page *p;
>> -    int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
>> +    int ret = folio_test_set_hwpoison(folio) ? 
>> MF_HUGETLB_ALREADY_POISONED : 0;
>>       /*
>>        * Once the hwpoison hugepage has lost reliable raw error info,
>> @@ -1896,20 +1902,18 @@ static int folio_set_hugetlb_hwpoison(struct 
>> folio *folio, struct page *page)
>>        * so skip to add additional raw error info.
>>        */
>>       if (folio_test_hugetlb_raw_hwp_unreliable(folio))
>> -        return -EHWPOISON;
>> +        return MF_HUGETLB_ALREADY_POISONED;
>> +
>>       head = raw_hwp_list_head(folio);
>>       llist_for_each_entry(p, head->first, node) {
>>           if (p->page == page)
>> -            return -EHWPOISON;
>> +            return MF_HUGETLB_ACC_EXISTING_POISON;
>>       }
>>       raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
>>       if (raw_hwp) {
>>           raw_hwp->page = page;
>>           llist_add(&raw_hwp->node, head);
>> -        /* the first error event will be counted in action_result(). */
>> -        if (ret)
>> -            num_poisoned_pages_inc(page_to_pfn(page));
>>       } else {
>>           /*
>>            * Failed to save raw error info.  We no longer trace all
>> @@ -1955,32 +1959,30 @@ void folio_clear_hugetlb_hwpoison(struct folio 
>> *folio)
>>       folio_free_raw_hwp(folio, true);
>>   }
>> +#define    MF_HUGETLB_FREED            0    /* freed hugepage */
>> +#define    MF_HUGETLB_IN_USED            1    /* in-use hugepage */
>> +#define    MF_NOT_HUGETLB                2    /* not a hugepage */
> 
> If you're already dealing with negative error codes, "MF_NOT_HUGETLB" 
> nicely
> translated to -EINVAL.

Agreed, thanks, will make the change in next round.

> 
> But I wonder if it would be cleaner to just define all values in an enum 
> and return
> that enum instead of an int from the functions.
> 
> enum md_hugetlb_status {
>      MF_HUGETLB_INVALID,        /* not a hugetlb folio */
>      MF_HUGETLB_BUSY,        /* busy, retry later */
>      MF_HUGETLB_FREED,        /* hugetlb folio was freed */
>      MF_HUGETLB_IN_USED,        /* ??? no idea what that really means */
>      MF_HUGETLB_FOLIO_PRE_POISONED,    /* folio already poisoned, per- 
> page information unclear */
>      MF_HUGETLB_PAGE_PRE_POISONED,    /* exact page already poisoned */
> }

enum is nicer than #define for sure, the only concern I have is that, 
this enum as a return type from _get_huge_page_for_hwpoison()/
get_huge_page_for_hwpoison() will leave footprint in
   include/linux/mm.h that declares _get_huge_page_for_hwpoison(),
   include/linux/hugetlb.h that declares/defines 
get_huge_page_for_hwpoison(),
   and mm/hugetlb.c.

Is there a neat way? or, am I nitpicking? :)

thanks,
-jane




> 


