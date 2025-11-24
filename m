Return-Path: <stable+bounces-196752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EB5C81199
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 15:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9357234212D
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B3B27FD76;
	Mon, 24 Nov 2025 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="SweMuW6T"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCC4280A29
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995420; cv=fail; b=NeA5Yxlhc9Np+N1I3MT0znmGBdR20dA6EJm1CiiO7nK8jWns9gv3f/4vSA0mlqg3wQciCYSr/WrxaOrehLm2Y+k8O8mVt7suosl/uS9qJtXy8MqDLrdwNZJQHqN2T+sJG3BnPQ3HR26SlhSqq2ED9CFWV2uMyxxYUsr0djwhzDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995420; c=relaxed/simple;
	bh=5Afbmr0meP3XUt/QQNu8QXjcjEwB5eWTnU27ZB/PLOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QbPzIBYWmAvNAWfo1FyYd5fWP/2q7TmbxvGRGRaONz+GGKwQzDa2mqdLN4s3H8ovlRO9jVbO9ZdVIKpiF62Km0Asqa9gLyJGmVDHW22f786iYMp1mG5FRnKmCuP31eSydihUPC7ltwpr5omhob15BDuUDHBrvKpa1Dfo7fiOCEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=SweMuW6T; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO8FX5m2083734;
	Mon, 24 Nov 2025 14:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=fpQGZlFl/nILmN2YuHaX0+IPJyiXghEzEUJbjS8ZdZ4=; b=
	SweMuW6T04st2EcO+CcPwgPL+9RYBKRiwKeCB1sQ3mAul+S8dRK/Fuxq6SMjZGjL
	huOlCnGVtunt/e7glp/5kAS22GRdw4Eyc4nMOCb3W7B7DeSAdZnXbgzdOzHC2Al2
	jwBXc0PLzdFWEVV6Tfy+bvdesfx8Yhb984tQKxYu+92j5fTOUMdUfY3+3cMEbQ1F
	rhqV+QVSYKbsZH0NwArBBWVnym2SNYh0/s6idMNbc8YsLs3Jo4TSy/m10aJOF4C0
	BMxi3VpQS8k7P2WYJREYSkvF0kDbGE1OjcQOrmmylhkEo9FmLsd4bQ+NHwp2SYhx
	JVR8weo/l2VegzUr1vwT4g==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ak455j12c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 14:43:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGxSIwxsHVIsFq2qoEMpqUsrnY7BySS3A/ipj7acY6FVSIK0fIUyKe7pLx1JT9hZlTCevbfOwpy3xaJyylD+T8eYjBJlK2Sn6J/HqmXAjYc1hD1lT5wEKuUfPZKaV6EYnANGsfuLs1b+mLs0GeqK5lBXwsMoehQGdZ2Ex7dbJOmbe4DjgwL0vM+LzZ1CE6lVxKblpNLLyAZy9owyKNNoMpZ1IOvUOmOsCcwkmiW6n/Ryx4ZMKdo2jqSlDjEM6yt43PKAmo8AZl1cdi7qQ3vrE48X7JEmsIkYwKSkkFYd9fUNM72Jn/RNmvFA1l93QhEQh+/QjAK2BZ60yD9jdfvBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpQGZlFl/nILmN2YuHaX0+IPJyiXghEzEUJbjS8ZdZ4=;
 b=LXw3MkEbs3JI3RhdPgpbER86i1GZl13761CGYdGj0lFka8WV9mB07oVqTG9zF8cIQl22BZljxzKasb79AwC0rUV/GdLzP+w7iJ7XhCIKsLhGb1jJ0RcAFw7J7esFVVYIxPkoA3wQ5dawq/9HGlTlvxjzEzQYMKPfs1zYMIaiWhEPGjg1LeKk9cEIuahHxeAbBJbBT+K2Q6Jkw4Uni1beM64OdqaukoS36B7xOozodV/Tp3t47ugTT+oZiYPWkIXh5caV48EGfd4M76tfAMo27+JaCvI+G8ILvBwRN56q5CO8O/x/5VZQ4u3s4J4Xcu2z0bXE4J78UTZ2zutHpSRNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CY8PR11MB6866.namprd11.prod.outlook.com (2603:10b6:930:5e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Mon, 24 Nov
 2025 14:43:19 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%4]) with mapi id 15.20.9343.011; Mon, 24 Nov 2025
 14:43:19 +0000
Message-ID: <93fc6d93-afaf-4539-a44a-79077fa3ea27@windriver.com>
Date: Mon, 24 Nov 2025 22:42:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y 1/2] f2fs: compress: change the first parameter of
 page_array_{alloc,free} to sbi
To: lanbincn@qq.com, gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, Baocong Liu <baocong.liu@unisoc.com>,
        Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <tencent_1630890D7DB4D635EB1F549270D611385108@qq.com>
Content-Language: en-US
From: Bin Lan <bin.lan.cn@windriver.com>
In-Reply-To: <tencent_1630890D7DB4D635EB1F549270D611385108@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0203.apcprd04.prod.outlook.com
 (2603:1096:4:187::22) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CY8PR11MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bcba002-abdf-4b87-e9d9-08de2b67cec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3dtMlFYY3JIWkNmd1ZnV2FaZCtHOHMzcDh5VnBMNFNPYmF0YVAwYmpaU3Vs?=
 =?utf-8?B?SVgvTFlhZmtJdVF5Y1FaTEwyZzF4YTZNTVQxZzVHMk1oWXFJMmgwZmEvUzVJ?=
 =?utf-8?B?SHQzNzg1dVVJak1ZRGF6ejdTS1lwK2c5ZHFsY1ZtUjQ1QUptT2UwbzBYMjlu?=
 =?utf-8?B?d2Zya1hXR1hNWE9wUHBxbFZMTmltQ1Urd2NQU1dtdVo0TTlEaU5xWk82ZGcx?=
 =?utf-8?B?aU84cmwxWENMSzhJNXZ1MXczVjV6L0dGU0hoeWhBMmdCL2RIQy9pUU5yRnNo?=
 =?utf-8?B?ZmpuMkk4K2V3S2MzQjlmOWd2NFRQcUlqYmFFWmV1ZHgrRmFHaXlheVZOU2Iw?=
 =?utf-8?B?dG5Ia0s5ajRXRExFdm9oVzFGenJYNWdsY1R0cWJjdFZwQ0d2Tm9wMnhKdFdO?=
 =?utf-8?B?UWFsSk5LWXBkNGxaeG9xc0lxRm5uU2Z3aUVvRjh1M3dYZGlneHFxMFlzd1R1?=
 =?utf-8?B?eE5tcUE1Q1BtNDNxUERpVHluVGFrVjR1YmZHTDhPcmpZR0p4dXVheE4yVWxG?=
 =?utf-8?B?b3owRGhpYjVqci9NckZyNldXbjZCRWFIeUdaY3hia1JRUGZkbEJrT0lvelo4?=
 =?utf-8?B?YXVCQWNSbkpZMjlrbDNiaE44Y1NrZjNYWm1TNG5teUs2dmE4RDg0SUNta2dF?=
 =?utf-8?B?bWtxNlJkWkQyTDg5WGgyTVNaa0ZlNWFsSTRITDdjeGNQdkpHTUZNOG5SS0lU?=
 =?utf-8?B?c2M4Q1lNamZiaFVtRTZrVmxlSytJTS8xMEREeTE3citaMUcwZ0UvZ3lHakZD?=
 =?utf-8?B?aE9QL1U2RlN2Zks0Z3E5MDhzYmxtUVB5cGVsVSt3Y1VYaDdVNnNiWDA4ODJp?=
 =?utf-8?B?MFF3dkFmR3pETXZ4aUNtMDNhQUlHWmkrZXFuMWlUNHFONWRIQXN2cDhyVWZM?=
 =?utf-8?B?RXdZVDVqN0lNb0xDejBOaTV2RWNDdWtlQWVWejViM3NNd3NHbENwNHJ5UlI2?=
 =?utf-8?B?VzRpSWNaVFdMWElkU3RQcERVbFBWWk0yekRNQ3AyVHZJd1IyZVRGcFVHZkR4?=
 =?utf-8?B?NjBPTTVIN0ZrMUZ0TEdUdFdzYXo1ZE1HaHhISE4xT2VmQWFycHRvSGZUeity?=
 =?utf-8?B?anFmSkQ2OHJnc1R4bk4wQzIwVWM4cElhWlNCN0FoejZIb3FNYTF0NGpZQlF6?=
 =?utf-8?B?cnlNeDhXb09TT0VhZ3FKMVlhMUV3Q3ZMNDlTOGpiSU13dzFvcW1jUjJsUWp2?=
 =?utf-8?B?bTdBNEJlZkNPYm5UaVlwVTJ4MGxGanc1ZHo5M01rU2o5ODBSenBuanNONWNu?=
 =?utf-8?B?UDRCUE91cXRyR2JNS2s1RXZCVXhhWUVxa2NaL01GQ2JWZGdQUjM5N3RGcHpT?=
 =?utf-8?B?Q1NjblBxajJodlBVbXo0R0ZYbUY2WUtHeFZNQzdqOTc2bndBNzAxOGU3Tko5?=
 =?utf-8?B?MGNGTFJPdnhwYlhMWG1VZUxraGwwa3U0RTRxQzJnZnpyNm9OeitYZW1wUzZp?=
 =?utf-8?B?NUlqZWVsVkZnWmI2U2ZEaWFvdk9ST0JmYk5QandBU2s1TGFtMEIrS21OUVNZ?=
 =?utf-8?B?ZFBVZmoyelJqN040VFJwbmNMSlQxNmtjWFhnUmhubExqNTJGNk50RlVaNmd2?=
 =?utf-8?B?anQ2Sm05cHZYZ3NVVDBieitLMkczVzQyUXN1SDBBUTVhOWtqaU95bmZlZ3lt?=
 =?utf-8?B?UnladGdnNElhMkRQeUh1VTdpK2RXcUZ1MXNlNEEzY3BuVDVOT096T0REN0lh?=
 =?utf-8?B?ZWFFcGRKbHdpSFcwaW5IRjFJNFdwcEZvNUNOeVFaUzN4MUdYSkR0ZUdTV0ZD?=
 =?utf-8?B?OWo2QmtUZHdlYTF1MElVbmVqekt4Z2t3dDBSUUtEb3FQYkZ1R0hKUmpPZ0Yv?=
 =?utf-8?B?elVaTFhYWEVlL3B5elJVd2lYNU95QWFRRGR1L2NBTExyUk85ZmNiNFpKTTlG?=
 =?utf-8?B?OWpmM2NsekEzVTZJNEk4QTJNZmhRV0h5S2xHWUhHQ0RudGMzcG5QYkJJbDhq?=
 =?utf-8?Q?KEa5ZtxQLKllKAgebvjlGUXdbKrp6d3O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEFYQnZFNGxnc2hidUc5Q3dOV1JUOVZxWEpCai9NZlNqaEY1K3FkdFFlcWpm?=
 =?utf-8?B?c0p3R3VNb0J0KzQyajNLN3BSNXlnRjZXMVJTUUtNRDVQSnN3YVIvZ3g3Z0ta?=
 =?utf-8?B?UThZZFJ0UHc4Zk5PaFM4TWpiMHpxMmhmU1BWUmplYlcvNTlpcDF0YmozSGN3?=
 =?utf-8?B?ZGlCY1B1Q3o4WkJudGxIL2ZkYzFxdFRCUmRhTFhRR09SSjZKcjB3MHl4Mm1T?=
 =?utf-8?B?Y3g5RXdhNk5tYU1CYWxNelpzaE5FdEFpV0pCVVBtK3RQSGxYUWR0K0FPcUxM?=
 =?utf-8?B?QmFDVGcvMTN6YnhON1pERDhoZ3dKTVFRK0ZFbFdEYWorZXcxYUZPTU5OYk5E?=
 =?utf-8?B?NzB0N25qbkk2WSt1TEJwQ3FuUXd3QXFkVDlidVpYeXRrVlVOZW4vaGNhR2Zz?=
 =?utf-8?B?aDVYdXlycHJCRjJRUjlScUlrNTZNT2dId1ZtN3NxSGQrcC9yL1J1dzVKL3VM?=
 =?utf-8?B?aW9xQ1J1Z3pHT01JV3p1VkNDRlp0Y3d1YXUwRGVUbU55Y3FKRW1VMnc0akJs?=
 =?utf-8?B?R1ZZaG1Wa1FKdDdEOGFvT09OeWdnOEJVM2ViK2IzWWlRQ3UvdC9qWHl5Rjll?=
 =?utf-8?B?ZjFLeEZBdW9oZHJZWVZrdUpZOEZxeXNLNnNoNkVRNTdPZCsyYTlIUVZqNllR?=
 =?utf-8?B?SEtYVHRKd2lhZGFBeFBlVW5iWkV4T1dqNnpGTmpnZGdlZ1crU0laM0ZOMm1k?=
 =?utf-8?B?RFV6RTdRN0xjSC93S2F6ODFwM0U5MlZaa3FzUXhYZUFhRkVYdkVxN1pKYTBh?=
 =?utf-8?B?czczdTlKakNnMVIxcEgwam85TkFUeGhmdFZYTm5Zbm9NUndmcDdvR2xKSzR6?=
 =?utf-8?B?bFF5RUwzQ1R1ZkNLNExpN0YwdWswL1AybWs0WUN2Q01BN1YrUFQxQVdyZ3RK?=
 =?utf-8?B?M2w0cW9KNnlITkZCTDVhWlVKd1NYL2swM0RrZDBmOVYzSFQ2SUhMWW90Q0Rj?=
 =?utf-8?B?ZitlQ1hLellBb3FTUE9rSGpjYXdCMFBBVXdjbE0rM3JtaU51UE1Zc0QvWFNG?=
 =?utf-8?B?RnNGQVVtZUZmUU0yWXVLNStoMW1mNjJhOE5PZjNiWlVtNUIzTU5ZU085azJ1?=
 =?utf-8?B?cHhiYmozZjBBWjEzV1hTa2N2TkRuRkdRMHAxZ01uRVJMcTIzVEtjWmU0KzFI?=
 =?utf-8?B?MUlwenlaL1FQLzF4bnZjWGM4RXJiOG1KZytXNTBIWXlvZ0xjRit1MFpMT2NX?=
 =?utf-8?B?SllUdk9tVURIMXRiYVZjQjZ3NDVrOVNLZGhVL1cxbWZTTHdDWS9KRDY1b0hi?=
 =?utf-8?B?aTJjOXNDSmhZZFE4L1BFaWhCZzdMSVk3bllud3lMZGFZQVBYdlYyRDlENWRn?=
 =?utf-8?B?L1hBeDlabEdzVzVERDFENU5QSXFqTU4vWjFSbTZyd2c4NnNjZWRxUWl5MGJX?=
 =?utf-8?B?RW9OMjI2Z28zazd4Q3JzZ3l1bFVYcmdRNnZtYUhtSThwRnA4bDcyYkx1d0Fi?=
 =?utf-8?B?TWVYZDJMblRrRW9jTldDZTB4VVA0M2JRQ1RpSmZHYUxxRVliWDBwQTNmbDRk?=
 =?utf-8?B?QVNNT0YwMjVSOHptREZZY0RJTEVtMjM3WUFkeWdLNTgyVHlwdGV1SE5wMjhq?=
 =?utf-8?B?cFQ0UmtLemkybjJ4VzhTcldDU0o0d25pSzhTUWVwYmFQZ05BVU05NVNvZ25C?=
 =?utf-8?B?aWhxL2hkTlEzc3BKRlRVSmlzdzNseW5oQmQrRVVsWVVSRnJDQ29PMDRIU0lO?=
 =?utf-8?B?MFVXakhDdDVBSkIrRVU0ZUJTNk1jeVJINDVwWlFyZ2tZZXdFY0VNaytPWkxZ?=
 =?utf-8?B?SmMxV0ZOYkF0dm5USTFyZHB6WTFwckJzd2Z6WE5nTkE1d0Rtb3pSRUlGZkJ2?=
 =?utf-8?B?R2RxRDMrOWI1c05wRS9BOVptNWRtaDJuYXNWWk9hN00rdjV6K3hyVUxvNTBs?=
 =?utf-8?B?VW9NVnkxZWx6TlpoZHZOOFVXNzlvK3lUWVZQcm9aU01ZYkROQVQ3Nml1Z1pa?=
 =?utf-8?B?STY5NXFmb3FtTXJTalpwZ3B0aVdKYSt3cnk1dFJJM0pPZWl6eFhzam9TSmhC?=
 =?utf-8?B?U2ljTHhYdUxzY1FhcktCNXM1cFovdUYxUGEreTQxNjZ3WXUyYlFqa2JYb0Jy?=
 =?utf-8?B?RDlyVXBvTnNpREJValRycmV1QWxVSkxjcmozdVhaWE10cDVaQXo3QjE0U1Rj?=
 =?utf-8?B?emRteU5vY1ltUW55N3BUbWtmakhEODIyNWRYOTRxMVFTN0swbzczT0xTT1I3?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcba002-abdf-4b87-e9d9-08de2b67cec8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 14:43:18.7753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0eXlS6nmNbKhyF2OdPlM6WWPIdrJf5TxL/xdEBxkoVsi4wNnUpiqPSQLarht1MkuY88Fp9ch43t4CD7NSYSvtYUZt0pJ5R+bkjr8jAW99w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6866
X-Proofpoint-ORIG-GUID: wCPXgBkY301tp3gjk4WSAhb0Pc2aXp80
X-Proofpoint-GUID: wCPXgBkY301tp3gjk4WSAhb0Pc2aXp80
X-Authority-Analysis: v=2.4 cv=T6eBjvKQ c=1 sm=1 tr=0 ts=69246f0a cx=c_pps
 a=dVriaH61pmWkicxGRshTTg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=dZbOZ2KzAAAA:8 a=icsG72s9AAAA:8 a=VwQbUJbxAAAA:8
 a=o0ti4Wj4rO4h2MG_sqYA:9 a=QEXdDO2ut3YA:10 a=T89tl0cgrjxRNoSN2Dv0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEyOCBTYWx0ZWRfX8BEKcFncoSWA
 De8FIY2pvBku+tnEAmHvhFuaebK6cNUXzstix5mDpcfgwL+CjC22v40NQSGjtR8yfTy0ka6ZQ/c
 pBsubf7USRnPTB2uxQnx9r4sGRUGuqreTfccjqXGWvXAEtqVoNOAtWfeXVUeoAQl35DyMps/OJ9
 oQFs9zeqg7hMnsi1+kmR9uWu815wCdvyir+fZkXy3Gz/m4McfeYF4aGaRdwCnbLclJrekn8OoaJ
 VdTOhPDlOgqWkDoQo7wg69HALHzfobTE/CBjl9V03RWsHuonR0hh9njDJxEafljvUDtmwQXIL9B
 7Q6Vh8DfBZkAoR9wTXWSFZi7XEaRSDLepdNaqBErFiyx2B2G0HAh0v2G6RYEBqmzIBrDagD2fK/
 3qF3xsLB2ewqMBI0DfwkVYT0DRtEvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_05,2025-11-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240128

Please ignore this patch for the 2st patch is not sent out.


On 11/24/2025 10:28 PM, lanbincn@qq.com wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> From: Zhiguo Niu <zhiguo.niu@unisoc.com>
>
> [ Upstream commit 8e2a9b656474d67c55010f2c003ea2cf889a19ff ]
>
> No logic changes, just cleanup and prepare for fixing the UAF issue
> in f2fs_free_dic.
>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Baocong Liu <baocong.liu@unisoc.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Bin Lan <lanbincn@qq.com>
> ---
>   fs/f2fs/compress.c | 40 ++++++++++++++++++++--------------------
>   1 file changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index e962de4ecaa2..3a0d0adc4736 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -23,20 +23,18 @@
>   static struct kmem_cache *cic_entry_slab;
>   static struct kmem_cache *dic_entry_slab;
>
> -static void *page_array_alloc(struct inode *inode, int nr)
> +static void *page_array_alloc(struct f2fs_sb_info *sbi, int nr)
>   {
> -       struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>          unsigned int size = sizeof(struct page *) * nr;
>
>          if (likely(size <= sbi->page_array_slab_size))
>                  return f2fs_kmem_cache_alloc(sbi->page_array_slab,
> -                                       GFP_F2FS_ZERO, false, F2FS_I_SB(inode));
> +                                       GFP_F2FS_ZERO, false, sbi);
>          return f2fs_kzalloc(sbi, size, GFP_NOFS);
>   }
>
> -static void page_array_free(struct inode *inode, void *pages, int nr)
> +static void page_array_free(struct f2fs_sb_info *sbi, void *pages, int nr)
>   {
> -       struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>          unsigned int size = sizeof(struct page *) * nr;
>
>          if (!pages)
> @@ -145,13 +143,13 @@ int f2fs_init_compress_ctx(struct compress_ctx *cc)
>          if (cc->rpages)
>                  return 0;
>
> -       cc->rpages = page_array_alloc(cc->inode, cc->cluster_size);
> +       cc->rpages = page_array_alloc(F2FS_I_SB(cc->inode), cc->cluster_size);
>          return cc->rpages ? 0 : -ENOMEM;
>   }
>
>   void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse)
>   {
> -       page_array_free(cc->inode, cc->rpages, cc->cluster_size);
> +       page_array_free(F2FS_I_SB(cc->inode), cc->rpages, cc->cluster_size);
>          cc->rpages = NULL;
>          cc->nr_rpages = 0;
>          cc->nr_cpages = 0;
> @@ -614,6 +612,7 @@ static void *f2fs_vmap(struct page **pages, unsigned int count)
>
>   static int f2fs_compress_pages(struct compress_ctx *cc)
>   {
> +       struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
>          struct f2fs_inode_info *fi = F2FS_I(cc->inode);
>          const struct f2fs_compress_ops *cops =
>                                  f2fs_cops[fi->i_compress_algorithm];
> @@ -634,7 +633,7 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
>          cc->nr_cpages = DIV_ROUND_UP(max_len, PAGE_SIZE);
>          cc->valid_nr_cpages = cc->nr_cpages;
>
> -       cc->cpages = page_array_alloc(cc->inode, cc->nr_cpages);
> +       cc->cpages = page_array_alloc(sbi, cc->nr_cpages);
>          if (!cc->cpages) {
>                  ret = -ENOMEM;
>                  goto destroy_compress_ctx;
> @@ -709,7 +708,7 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
>                  if (cc->cpages[i])
>                          f2fs_compress_free_page(cc->cpages[i]);
>          }
> -       page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
> +       page_array_free(sbi, cc->cpages, cc->nr_cpages);
>          cc->cpages = NULL;
>   destroy_compress_ctx:
>          if (cops->destroy_compress_ctx)
> @@ -1302,7 +1301,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>          cic->magic = F2FS_COMPRESSED_PAGE_MAGIC;
>          cic->inode = inode;
>          atomic_set(&cic->pending_pages, cc->valid_nr_cpages);
> -       cic->rpages = page_array_alloc(cc->inode, cc->cluster_size);
> +       cic->rpages = page_array_alloc(sbi, cc->cluster_size);
>          if (!cic->rpages)
>                  goto out_put_cic;
>
> @@ -1395,13 +1394,13 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>          spin_unlock(&fi->i_size_lock);
>
>          f2fs_put_rpages(cc);
> -       page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
> +       page_array_free(sbi, cc->cpages, cc->nr_cpages);
>          cc->cpages = NULL;
>          f2fs_destroy_compress_ctx(cc, false);
>          return 0;
>
>   out_destroy_crypt:
> -       page_array_free(cc->inode, cic->rpages, cc->cluster_size);
> +       page_array_free(sbi, cic->rpages, cc->cluster_size);
>
>          for (--i; i >= 0; i--)
>                  fscrypt_finalize_bounce_page(&cc->cpages[i]);
> @@ -1419,7 +1418,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>                  f2fs_compress_free_page(cc->cpages[i]);
>                  cc->cpages[i] = NULL;
>          }
> -       page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
> +       page_array_free(sbi, cc->cpages, cc->nr_cpages);
>          cc->cpages = NULL;
>          return -EAGAIN;
>   }
> @@ -1449,7 +1448,7 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
>                  end_page_writeback(cic->rpages[i]);
>          }
>
> -       page_array_free(cic->inode, cic->rpages, cic->nr_rpages);
> +       page_array_free(sbi, cic->rpages, cic->nr_rpages);
>          kmem_cache_free(cic_entry_slab, cic);
>   }
>
> @@ -1587,7 +1586,7 @@ static int f2fs_prepare_decomp_mem(struct decompress_io_ctx *dic,
>          if (!allow_memalloc_for_decomp(F2FS_I_SB(dic->inode), pre_alloc))
>                  return 0;
>
> -       dic->tpages = page_array_alloc(dic->inode, dic->cluster_size);
> +       dic->tpages = page_array_alloc(F2FS_I_SB(dic->inode), dic->cluster_size);
>          if (!dic->tpages)
>                  return -ENOMEM;
>
> @@ -1647,7 +1646,7 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
>          if (!dic)
>                  return ERR_PTR(-ENOMEM);
>
> -       dic->rpages = page_array_alloc(cc->inode, cc->cluster_size);
> +       dic->rpages = page_array_alloc(sbi, cc->cluster_size);
>          if (!dic->rpages) {
>                  kmem_cache_free(dic_entry_slab, dic);
>                  return ERR_PTR(-ENOMEM);
> @@ -1668,7 +1667,7 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
>                  dic->rpages[i] = cc->rpages[i];
>          dic->nr_rpages = cc->cluster_size;
>
> -       dic->cpages = page_array_alloc(dic->inode, dic->nr_cpages);
> +       dic->cpages = page_array_alloc(sbi, dic->nr_cpages);
>          if (!dic->cpages) {
>                  ret = -ENOMEM;
>                  goto out_free;
> @@ -1698,6 +1697,7 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic,
>                  bool bypass_destroy_callback)
>   {
>          int i;
> +       struct f2fs_sb_info *sbi = F2FS_I_SB(dic->inode);
>
>          f2fs_release_decomp_mem(dic, bypass_destroy_callback, true);
>
> @@ -1709,7 +1709,7 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic,
>                                  continue;
>                          f2fs_compress_free_page(dic->tpages[i]);
>                  }
> -               page_array_free(dic->inode, dic->tpages, dic->cluster_size);
> +               page_array_free(sbi, dic->tpages, dic->cluster_size);
>          }
>
>          if (dic->cpages) {
> @@ -1718,10 +1718,10 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic,
>                                  continue;
>                          f2fs_compress_free_page(dic->cpages[i]);
>                  }
> -               page_array_free(dic->inode, dic->cpages, dic->nr_cpages);
> +               page_array_free(sbi, dic->cpages, dic->nr_cpages);
>          }
>
> -       page_array_free(dic->inode, dic->rpages, dic->nr_rpages);
> +       page_array_free(sbi, dic->rpages, dic->nr_rpages);
>          kmem_cache_free(dic_entry_slab, dic);
>   }
>
> --
> 2.43.0
>
>

