Return-Path: <stable+bounces-203238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE09CD714D
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 21:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E86273014AC9
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 20:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A73278165;
	Mon, 22 Dec 2025 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TcRVVsu3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="owZdBkvn"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA921D59B;
	Mon, 22 Dec 2025 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435482; cv=fail; b=Psn1Gg3Qov5LzD3P+q9Oj+Y65UdFCq/sr1GZ0gL3aXthYjn4dR+JTg+gZ9mWSq6B2WN3Bjaw9IflF8B49AsjO39tmGQ7RW10pc4blROjdqyX9RnT5fTmFcDAQfq2rDm/R6nSPvEqUhOkz6Hk2oplkyVXtTU1xzcWdfp19ijDCmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435482; c=relaxed/simple;
	bh=HekEbDEEzv1jH4Yu87X9ccPqR/TdOmW0Gt42vsnVims=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n8aDlhc5UEuLh21+mexLQ3SmberVVdhT96iK55ES11VDW/aSREalfSmLWmr1bmVXcehQ5lHsUUgoL9y2YoD/P6087/RJQ4JK+z3LUcLq0a5vL4jCtcOPX1MlR/r85N1gU/IbVXmXNMMRhCZ3iWiMiiL87F5M7tvm5AE67yX7YQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TcRVVsu3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=owZdBkvn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMK6kFi2982388;
	Mon, 22 Dec 2025 20:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BdVINzzdne/SVxGtLtHVtoXeDjayI+1ERVq/R+vazKE=; b=
	TcRVVsu3JD806pfLBx94/fSu1gN4L5O6mpPtwrv2GNqE0eaCT3DKpLCSV62GfzBQ
	zWiiM3pX/WNTm0otGetEFVEeN+NHgHirxXiSCedcIl830Qg2+jdASREhnKPrsP8y
	gsmr8W+3h0F2nGukqie6l+UuOpLFtyMXbvI/jXhCil3gz2dSjx7J8SPm2p2gLtL+
	UTukItPlYdGZtbCvIALdeT0uFxC16gPtBJXJTMb0WzLvS/+zS5V7Lv7q4QhURczo
	uDrwlnYyhlqPAprFL6Ni56bSovhkxNg7Ph647kjAPPRU0JrRy1vgI5X4YnrHnzxO
	RK/GRehYgGdAaVRQ9TDanA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b7cqf81sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 20:30:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMK8Mwc032703;
	Mon, 22 Dec 2025 20:30:46 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j87qkyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 20:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1Rsjp3Ee2j3ClBby7vEL/4Hb9EBkkZqNGmQ82zDK0U9Z0iPCKAnACU6bPB8OpdWpP11PRJnVMcILAwRGXD+ped3Q9oWeH5cfKMzEdwb5SxG0o1NaZGo6pVDo0oGQY+kU18NKQcCZsM0ic4wvZ9D4hGOHGJbdNXKruHqiXdNWjODcx785kMgojbnni/CXh6zxroujC6hy1RTd1M6K1n6Ya+SjlVtyv8rU3MkxT4sEB5BLn4QQRu89IJ1sdadafBIYBMEKJ9cA6KgYTNecjYERkhmSH7nee2tP4y1wiJWFGG6iGBQ6nkMTp7ExFeM9RYDFkcYZyuI7+3HCyqLCAly+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdVINzzdne/SVxGtLtHVtoXeDjayI+1ERVq/R+vazKE=;
 b=BCjT5wUI460JD1blnHuA76D/bVJ7EKSlP8cf3oijfYzRCNnxdHnMOE1wgNK93DTvZ3qSKZ6x69TG0KaX/GILaHyB47X/8SVxHJEJI6CK+wLq5li2xf1vkIsfM/47cfKFiuAetbHqUeoFUo4Z4qsqmA9gM2LZUOKrtCppXrVLWQZ3gP06YDYkbCaYYQswypds80FZZBMl1IQL99SaCOdsdsKR94XkdldqeCFYUOiqNl/EZxUwY2Qt8NV11LHdemw1H0rAgHB3NXerhsAIh8NvM3VwVDw1O0uhGWqL90+aoTW9nW7kLUI3P1WojyBUYb3QjTWHOkHO+gvcLIwAT1Y4UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdVINzzdne/SVxGtLtHVtoXeDjayI+1ERVq/R+vazKE=;
 b=owZdBkvnrjYBIKbLgPlCBX/tJyau2R5vvcIpkYTR3aTQrMZ8vIZkUEBQ3U3g4aDSy8Xps5qAlOhGgBn2xpVz6G7y15QfCmQ7Xrou7OW+yrSc1l1SopPo48uMunnJb22EThPnWrPcJt9Adc/hheWruILujmsXRfQALGYWXcMBjDY=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.11; Mon, 22 Dec 2025 20:30:43 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f%5]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 20:30:43 +0000
Message-ID: <c5629607-274e-4dc8-b759-7a04dba390c9@oracle.com>
Date: Mon, 22 Dec 2025 12:30:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory-failure: teach kill_accessing_process to
 accept hugetlb tail page pfn
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
        muchun.song@linux.dev, osalvador@suse.de, david@kernel.org,
        linmiaohe@huawei.com, jiaqiyan@google.com, william.roche@oracle.com,
        rientjes@google.com, akpm@linux-foundation.org,
        lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com
References: <20251219175516.2656093-1-jane.chu@oracle.com>
 <aUWXAGC1028jRKEY@casper.infradead.org>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <aUWXAGC1028jRKEY@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0069.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::27) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|CH0PR10MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: 980592a1-5e26-48a9-0433-08de4198faad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHdUVnVwVGtxUVpCMVMzZ3BCSUhRYnRGOTNxTU1QbU1nMGFmeWJ0Y0hjb1Jn?=
 =?utf-8?B?OEFIUWlWNW43MEVyUXVCZXhDT0NMUGh0aXRJQVVOMEsyWG9CMnZmSU1DVHRY?=
 =?utf-8?B?eTJpajlWcGRNYTNpUkFFZTRRbmV5WGQ2byt5ZnZsWkxvV1dWQVU3djlXTnFC?=
 =?utf-8?B?QnAzQnpRYlpDaUhXQ2VIUkRKdmRqUFRDSU55aGhDR0pBZGVhUE1YaHZ4RlRG?=
 =?utf-8?B?T3M3eTZ3ZHZMOHJCQWl4TnZKV1h6NHlNTXQzZzVodTF3MFdkYm4vZG9rcmRs?=
 =?utf-8?B?UG5OazJoRzMzb0pYSTloSDhoM252NXlmOU5MK0dPOE9VWFFrdzVXTlJwTExE?=
 =?utf-8?B?eWZmckJUYzMyeENTaGl4ekg2ek4zZjR0czlvMHJkMDQ3SDAzbDdMaU83RkVO?=
 =?utf-8?B?ZU50RXl0am1BbzhIenpmVFpyL1NHSnlmaSt0Qk5TcC9DT1lzUi9oZFVpZkwr?=
 =?utf-8?B?Mkw5THRKLzlrL2Jad29GYUhQaVc0Zmp2Zk90ekNRV1c5UmY4dFpSZmRzQnNh?=
 =?utf-8?B?bHI4dWg2SkZnU0kzK0hGRExhdVk4RjhJYyt5eVgvT2xKdHltcVp6STkyQW4y?=
 =?utf-8?B?aWoweVNsa0RQdVZOYnFvMEd3KzI5N0lIL1BHb0F6V3VsWHJ1SlJObVdQVWNV?=
 =?utf-8?B?d2tXWFNnYThmM1dkWEkrR2hKY3JmQWVaNWV3akVEeUgyTE5IbVhDNkhlUXo4?=
 =?utf-8?B?eFRHdHU4NHFNbmNUamVBMDc1ckZubVBhMXk0OTlDVlN2RkVFRVNsalJYcDlZ?=
 =?utf-8?B?UW9oUTVtOHZ4bWdBN29BWWN5ZVdoTm0zWHAzRHZzdmVNblI2Ni96aHg1NGpX?=
 =?utf-8?B?bTZHVElKWDgzVmVmSnFaYnFKeWtOMFRFaXlUNlQvckdRK3FpeGtGV0E3ejRZ?=
 =?utf-8?B?dkNORCtEbk5kQlNSbHk1ZC9abU1ud1BHMU1yamlpc0xubW4yZ3ltVDMzRk5m?=
 =?utf-8?B?K1B4Z1RkbzE2V2c1YUs1OVl2eWhPbStpUEphL1BreE9UY0JKZnRmdDFPa3dC?=
 =?utf-8?B?bHVxcHVQL2ZnTGlWaDN5dWd5V2JWRmtoRWFoM2gwVDRhYXF1K3ZwVmhYc1FD?=
 =?utf-8?B?ajV5VS9ycml1bDNTcDRKcjdoRTJkOGxTWVJKV29rMDJGN0NkNGRYbG56WEdu?=
 =?utf-8?B?MXd1d1k0U0owa0FhT0w5UVYvd3VMMXlqYVIxSkplVVFXY0JTazdGaUhPUk5q?=
 =?utf-8?B?N1V6bUhub1VidFpMUUhRNk5SSGhOTmZ3Uks4MEU5ckc4MkJOVFpVNGNmOVN3?=
 =?utf-8?B?cklURlAzN3JKb2cxM2p2M3ZuRm1EckxOb0NNSVVLWTlmeTQ1Q1pXaWtBTzdQ?=
 =?utf-8?B?S1VKalBtakxnakxIN3R2aXVid0dSR3R3UThtZG5sU0MrNEc0T3F1M2dYa0lX?=
 =?utf-8?B?WXVSZlVTM1o4MnNLWjViMVJ4NUJhc2xNSTAvWGhZNHAwVXA2am56Q01qVlk4?=
 =?utf-8?B?cVdDUEp4MWtlbFJsaUl4UkFNWmpheUtUN1RzN1d2TC85U01vcDh3Zm9yY2Zz?=
 =?utf-8?B?OUlVQTJJZTJ0NG9oOGtjZDN4Qk9JR2RrYll2VW5JYXpRbmdGTlhKQ0JQVmVo?=
 =?utf-8?B?TllGRC9uMFVNcFhDbC9nQjNuNGZJUllkOGVPVHVDS1ZwMUM4VWNNRitxeGZz?=
 =?utf-8?B?dTlzSXNHR2pPQkhidGxWcnBCSVZyQXB2L1VZdG9GMy9Mb3lRR2pHeXoyb2Z3?=
 =?utf-8?B?SmNUNnExTEs3cmtoRy9lelBsVzJ0V1grS215Z0hldzR3bFlJMWx4VkxQZ1M5?=
 =?utf-8?B?aXZpdDZ6VVZkbmhHSXNYNU4zVDN1RkorMzRyODdybUdGdjNsd1NZZEZTaGlK?=
 =?utf-8?B?MXc1dXpxSTVCb1p4RjJ2ZE8vMHdjdXRaaS90TGcxNkxvMG9vTWFqVlozMkFX?=
 =?utf-8?B?UVl0LzFoMmFRQTZ0Y28rZVVVaGNrdThJK21vSW5aWWZUQmROK0VqaU9WTmlW?=
 =?utf-8?Q?BaIa+JljgmCBuYom0rAFsbc3L7mTwmt7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzRVcEVVSGU1STB3ZGJLMVEyc0s2Nkg1K3FBaXF2NXYzWXpqZ1hxSzRic0Rv?=
 =?utf-8?B?WlA1c09OSTduU3dNWk0relB0b0w3VVJjdC9NdE9SU0FEVThzL1VtcGJsbUlv?=
 =?utf-8?B?alpPRHJ2RkVUQkd4WWxPTHZlYnJzTzVLc2FVQzBzRmFHTERqeG5CdUs0bzFG?=
 =?utf-8?B?aDNSemU5UGVVd1JmalNhaXBOcnFnQ2Q5b2w3bFYrOFBnYW1PWDgwK2w4N0NN?=
 =?utf-8?B?RjZ0VXRhbEtJV3JpR252VTBvRnNuWWs3allqb1JpbzllNzhQS2NDK2o1T2dY?=
 =?utf-8?B?NEl4azJhTzRtcTExR3V0MFVpN3NxMFZTMzNhQkliTEQ5eXlQYlpzbFJpdTh1?=
 =?utf-8?B?UEZ5NlI0VUdHcS9lMnhsNUdhZGxqeUZKZTN0Qld1VG9GbWR2dVczUTN1ZWJT?=
 =?utf-8?B?dDFMSHE0YWpNaWgwMGRLT1B5emY5QkcwdmZCYjFmRWhjZHk4REsxKzJ5dWRr?=
 =?utf-8?B?ZmNNVDZXQW15NzcrTTJ6U3dlN0FzUGJEYTRGQXBhYm9OMCs0dUdtK015Nkow?=
 =?utf-8?B?WmpVOVd5NTVzdEdUNEFlMkNQcTlJaWFaWHFPMHRXRzJSeW4vdTZmcGZWYkI1?=
 =?utf-8?B?SzFScUlKcHJvK0g0ZlVieTBNTW5nWUNkUGJvZDMwTGU4aG5RM3ViU1dsSFZG?=
 =?utf-8?B?c1RxakNacnpTZS85dEdIcmZhTHl5bG5lTDI0ZVZPeVJvUUZ5ZjdJRkpqTXdI?=
 =?utf-8?B?Y1VncU1uTmI0WDJYV3NlVC9ZY0xaM1lMSmRiMzB0Y2UvS1Q0dDJCM1dIUldK?=
 =?utf-8?B?Q1lBSllSQ3VMRE01RHNSVTYyK2NMOUpVVzF5bVpvTjFHa2Nyd0RtdWQrbCtY?=
 =?utf-8?B?YjNSYWxKdWJ5bnJiZXpJVTJTTTlUcHlnUktVRHBpWWV4RE1reTV4MFREeFVP?=
 =?utf-8?B?TDM4eXBoaDFWQ3g0Q05mR2w3WXZvOVhZeWoxK1M1YkVDNEJzQ0F2b2o1QnFS?=
 =?utf-8?B?YzUyVmVieHFwajRWMnI1L1pTM0RJY1QyeUJOUktYRlF0ekdEWURCN1o5cUFi?=
 =?utf-8?B?eVFMbFdzcVJKd0NlOXlYVlJQRHozWnlNZ2JZdG4zMm0yUDVIUGo0MUQ4c214?=
 =?utf-8?B?Nk5RdlhXSDB4KzVxMHM4ajNGdkRvZTJoNHF1S1hBemdPbVZxRmxEbDNpK0hD?=
 =?utf-8?B?QUl3QXpSSGdwd1RLMGd1cmVBTFlUSXJiSmxPV3hjTnVBQllmM0R3T3pibHhG?=
 =?utf-8?B?T0FsN1B5aU5FWElvMzViU1daL0tEQy92RHlkUWpsVjQ2TG1mNEpoYnlHUWpw?=
 =?utf-8?B?N0dPaHl5ZFIvWEw0a3dhb1piaHl1MnRETWtPajVaTkxBV0VzbTVQdUJJVlVY?=
 =?utf-8?B?TGRxOVl0d0hCZFJpMVI4TUUzQ3QrNlBWdndJSnVsRXJBUzNKK0pzbThOQmIy?=
 =?utf-8?B?S0cwYVUvNUtDdHc1NjdnNHhIQnB0UWpPVjFtZDlYSzlwVjJuT2xIcTVtTGRT?=
 =?utf-8?B?ZlQxMFBQV1k1azE5d2lQTFNUSlZnMS93bVdNUGZzSVltWUg4TWhiV20rU3NJ?=
 =?utf-8?B?K0FCUys0MEo1ZHp4YTB1d3BuMzhuZWV6cHdzSTkyWmJqckMra2RHYiszODhj?=
 =?utf-8?B?S29xR0hJWUxFdllzM3cvKzdqdjdwMFZWVFhkYW1ldWJFNW0wUVlRc1BoMERn?=
 =?utf-8?B?WEgyK0JlV2xUSHkxWnoxVHVNaW9rYjEyVWFjK1QxVDZ2N3BMOEM2UXcwVWYy?=
 =?utf-8?B?TjlPZ1pDbkpXcnpuN25jRFFzNUxYcWxhaGp3NGhyVUJzd2pRZnRQbHdGaTVL?=
 =?utf-8?B?Yk1UTzVTTG91Vm9Cc1JQVks5cE0yVFU3WVJmN21Jb25Tdm53M056MnJwUWtQ?=
 =?utf-8?B?K0lTS0NaZXN2b0pMUXlPU0lkQU0zYkgzV1NRNHMrUFVHbEt2VzVEOWRaZWJk?=
 =?utf-8?B?QkxBN3V6NG93UXlwMUVpUm54ZWxWVEkvUVJLN25FRmp5bHFZT2RXKzdLVWts?=
 =?utf-8?B?TURaVnphenAzVE41NURaTlJlNHBQMHhPM1F1c3BoRDVNNzdMNU12YlM2eE9X?=
 =?utf-8?B?Z294ZVdrQm9ET3o0RFhiN3A3U3ZGNjhrOHYwSXFJOHljbUw1UGNvWmNUdmw0?=
 =?utf-8?B?L2szMHhoVmJnS2kycnQ4UCs0NngwNEIzdmJnWHBJcGhZNmRXY0ZoWk5YUnRJ?=
 =?utf-8?B?R1U4QXhyZENuek1hbmV2L0lsSDBpRXdxd1hheEc2Z3JCSWJ3NTVTeERrK1NQ?=
 =?utf-8?B?M3Z1dlRuT3M5aTVpTlo1WlJrUlZVR0RrVllDUlFlOVdLSngyTHBTdTVoYkh1?=
 =?utf-8?B?U0Y4UWtvNDU1bE0yc2VVMk5CWm5RTVNiS3RNOS9pUVQ0eDRha1hic3lnK0RB?=
 =?utf-8?B?ck5DOCswYTNZaFQ5SHVja2hwbGZTYWt6RFcwMjVHN3pLaklSbzFjQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9M6k3plHV2NnuysiRMsYi0dnmfgRYVb+/ZNsVXMxZJ69p1rdY5GwA1QxXJy1+QNKSighlEzzULwT5UaqT6tByw18iiFQQZzkJdcbSIQbGnQ86zx7xbdMGfwEoBFKFTOMsyvpJECxWA9msiKP9rFrBBufMWW2sdR9dpxCNCR8weRmbJq3EftDc9NKNVXZt9NUuO56oBpCo3FR0VBFmZnIA0Mfww0SSdZiatVdYZlg6u+UH0Od3N8JsK/FBrsIJtXZCwHrAegDa81llPDijMiyI7UcGEB5Z04YnkV6RZ/48DJCximykhZUTAQa8zu7tspbx0B6i7DUwpXzE4jYUheWYnKijEEmhhPGPRiWEQ4qHuWUkMOi7ZwhVnOcwqiM2hgtgUH8mqkjZY0xs0t+oeqeG2uU3+FWVbv9eqeqqKvcGfRJnzfY5Z/Y2EIoUuL83yz5abpij8+7UymptYCqd7MGTRgUWm8JsKbUUvrOMnU3lsTL2WrdiBGnQHVkwJehN6mWDb+32DyXd1c9GxpT5eukwVHypUNm1F9m6qVpTHj72Gtst9SS+mRzDmilFl98GJRhNqm+e1KnnJZjFrv2AdkjlzZh+1nPNrMhjRSkKWAiT34=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980592a1-5e26-48a9-0433-08de4198faad
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 20:30:43.2832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Jqf52cbnCPZbBCXDTnUYMY0VgbaoEtGVI5bgiv0wfk8ULuSoMPc+tZz+ponSHn8eSM3FxmF6aSObq75EvWdeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512220188
X-Proofpoint-GUID: lAXQBa37Mmc6L3cBqj4tFOkGlTIL6cqJ
X-Proofpoint-ORIG-GUID: lAXQBa37Mmc6L3cBqj4tFOkGlTIL6cqJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDE4OCBTYWx0ZWRfX/A0hVYz91X7t
 puTm9b+KI7m+Mbc1zKbz6sNo/eBm7PFywgNMo4p+pIkijkO3HzWEJ/XZc2KZdZfU2X06hqhIhBB
 ZR/fRcRvu0hzkaqd0zxbIPhByHwZ8RPInTQuAZKjzKcuLmCDmIPVTwn2H8A0L5HNEh9Kk68t61/
 7ImCX3WtWRDxog3g0zZ5TsF4Tan0KaOHSi2jEFw6FlnFpaWoS4RHpW/PppCEmdqsevULlrYpAD2
 tiFWuxuw+BEkeHnfTkyDWQjW6pTVxERX0B9MElQxfndPJtCKDbGQ431eU2RV7O4Ix53481gKzBG
 QXrEi9c2IjbamuJ2oxA8HsDzd4g4h6+ZT8XVncnuourmrk8mxKpNPN3/Nxx73CSnihHbqpuc2DK
 eTvq6pR8K+6zDv/0Jyh1QN/1Gx9D5X6JZt1Vigcb0dTAJ/cmnvZd60hwWkQMEGt2rCd83kBBu/f
 DlaJr+xbCfVHcUk+2NA==
X-Authority-Analysis: v=2.4 cv=M/hA6iws c=1 sm=1 tr=0 ts=6949aa77 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9vrE82yFWDa7ZM_FQcUA:9 a=QEXdDO2ut3YA:10



On 12/19/2025 10:18 AM, Matthew Wilcox wrote:
> On Fri, Dec 19, 2025 at 10:55:16AM -0700, Jane Chu wrote:
>>   static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
>> -				unsigned long poisoned_pfn, struct to_kill *tk)
>> +				unsigned long poisoned_pfn, struct to_kill *tk,
>> +				int pte_nr)
> 
> if we pass in huge_page_mask() instead ...
> 
>>   {
>>   	unsigned long pfn = 0;
>> +	unsigned long hwpoison_vaddr;
>>   
>>   	if (pte_present(pte)) {
>>   		pfn = pte_pfn(pte);
>> @@ -694,10 +696,11 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
>>   			pfn = swp_offset_pfn(swp);
>>   	}
>>   
>> -	if (!pfn || pfn != poisoned_pfn)
>> +	if (!pfn || (pfn > poisoned_pfn || (pfn + pte_nr - 1) < poisoned_pfn))
> 
> ... then we can simplify this to:
> 
> 	if (!pfn || ((pfn | mask) != (poisoned_pfn | mask))
> 
>>   		return 0;
>> @@ -2037,6 +2038,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>>   		return action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
>>   	}
>>   
>> +
>>   	folio = page_folio(p);
>>   	folio_lock(folio);
> 
> unnecessary whitespace change

Thanks! I'll incorporate the mask idea in v3.

-jane


