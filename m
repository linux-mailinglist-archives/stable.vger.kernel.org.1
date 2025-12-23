Return-Path: <stable+bounces-203326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D5ACDA411
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 19:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EF393018913
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 18:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F1920FAAB;
	Tue, 23 Dec 2025 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ob8OBSZs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K4E044n5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96A01E7C12;
	Tue, 23 Dec 2025 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766513885; cv=fail; b=qJfzGzCFrALnUMEAiD1st60het+4Jj46leropPPlLQ2oUuDmPLXV7atcDU9oZ/FdqiBdSvbezzldi4MnbUZrECy28UZNsrZxAXiBQJnftoAA9Byvi+6EJS3aqalJsd3QwJNEKYFoWc72ltGFws97OUB1HhmqC3nb7CLKFCE/BGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766513885; c=relaxed/simple;
	bh=9G1b6dfvlJaaH00bkGoP5Dw8vaqkmhLkaP4+U+A/azk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jM298va/JibvguCm0MYTMrCzi+SzwnlFOhxc7BhXUb8KVMIow/PABMAUBtt14QEDAf3vQKeCVAY6PyfEXPEgmFjwgvlE2KRiLLQYkwzCXv0esg9ctIACse6zzxwo1W9bSV7ww9OPwP+T+EeTHgaOXAejTkJUOv+7scXQNpkka3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ob8OBSZs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K4E044n5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNHLet9847665;
	Tue, 23 Dec 2025 18:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=a4crhULe0vw0myu4t8V79uV8C4zSSRTR/aoKLO7GbkQ=; b=
	ob8OBSZsDcpeVzUklon+2nRIS2TJYJzfDftQBNLV/iv1q4aXAWcUPKJMwhuLAXXA
	3JeFkQTZJPH/nq8B/+Q19FJml2xL6N+VfG7c4kAWbTp421JBrx18rAiu6W/iZMsF
	H07tyzLoeYmEYZ0FYPHJFT493GbsTYQl7VxnIZrlm8GOPjBGLsmi5tzBLjghST0K
	5LpfXbW7mEtyeDCtOy3U1STr01El0/31EfkrSg90ZD9Ywm+dQ9p/aJZN2YeSn9vc
	rcwv5ZzctJCBpSOUjoFQ8eYgSZSg3ivSMqwJHPX1HM1ySBdVKx074br1oC97ogZq
	jc+SMzjIJUnzuNrrY3ILnA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b7ydkg204-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 18:17:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BNHu7AP032660;
	Tue, 23 Dec 2025 18:17:36 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j88pued-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 18:17:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IO90g0rmgRsi233dZkB8oR3hBWX67b44ZLiY0cXi40lfy6afTttU1mb3EVQxwzCzHlMRfbo43nLGU8H6v93TkJ3Hvs1Ls5iFSi8wk9EZYnFxzBM212y6D6ukipUJL0yR+Iq2Axm+/A/Hc+qGXHOaL1ysLqhCDmK1T9NMxmg9Rb+ZIXXhWwx/be2TdoG9tJ4L2JXCZd4AoPMDQRoWWqM9zUp1Eh6F/+V8Tk5oZfN/UvgLYC3itXJXXHYSpzGHqIz0M5kTxiBcfofMKPlqM2HZQrwMlEs7upnjWgX+LUmpDYPDYe8Q1ymGIuaUIGNORbkIaYUCTn6wXqNTpp1G4dmuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4crhULe0vw0myu4t8V79uV8C4zSSRTR/aoKLO7GbkQ=;
 b=xfNJ0L7uDS8hnxwzKqFnIYTei1b2eLdZei1jd3w8Q2B0VwnfBWrYrMedoD4SloDB4FIPU4S9Ih7CDszw6Phxe3wPEiueVBC22XFMPuR3bzxtrbVfBUDdUInnk7PZcyUlziSAcmqkrYyESrKLKwKnwPfGKqd3a19M1OTwbZD61acqlaqWwf//WpmlE6OeiSz2gRmD1a+KFjq6JYCzsWS4l2DEkAvpi0bFMJ/MP9qs84sBhXOPrIj5bf4qVarCcV2jKaOJqPfshYz7hRHdpBCC5f9W2o67OBiRob90htYuVpHRUq7OEN5gXUrLqHXRsxFvetFw12iVIe+avFpEnzBwSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4crhULe0vw0myu4t8V79uV8C4zSSRTR/aoKLO7GbkQ=;
 b=K4E044n5pzPUbbyQ0yC7CC8qwuo4AWoeEPbx3Q5eqRQQAj2zsj/iO3pw6Mvq1jNp6JrOIiuuL4xQ44BXLNAZSWAWbvGTbFg07HlgEtabpgZPYH0VtcY7Oc73HKDlxRKPYOS7LQcTCmcsoRr6AVDBfGGZV0hlPnnGf6q88lZrs98=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 PH0PR10MB4536.namprd10.prod.outlook.com (2603:10b6:510:40::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.11; Tue, 23 Dec 2025 18:17:33 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f%5]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 18:17:32 +0000
Message-ID: <f3ea133e-7160-4149-ad69-d11c6bfc213e@oracle.com>
Date: Tue, 23 Dec 2025 10:17:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm/memory-failure: teach kill_accessing_process to
 accept hugetlb tail page pfn
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
        linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, stable@vger.kernel.org, muchun.song@linux.dev,
        osalvador@suse.de, linmiaohe@huawei.com, jiaqiyan@google.com,
        william.roche@oracle.com, rientjes@google.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@Oracle.com, rppt@kernel.org, surenb@google.com,
        mhocko@suse.com, willy@infradead.org
References: <20251223012113.370674-1-jane.chu@oracle.com>
 <20251223012113.370674-2-jane.chu@oracle.com>
 <12032402-b541-4776-a716-c93f16ec7eca@kernel.org>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <12032402-b541-4776-a716-c93f16ec7eca@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a03:505::6) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|PH0PR10MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d2113f-ec68-4301-379c-08de424f8a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K25teTlQRmc4YnNhaVN1WkxSVXlZQjV5bFRBcFNWeTRCRzJNVmRxNVByWnU3?=
 =?utf-8?B?TG0xUnpDRFRMSDRES3doSGxRc0JCNlNEa3FvbDdwd0R5NFQzRXd2OWNkQWtE?=
 =?utf-8?B?bGM3M1FqdWZkclpnNGZqL2VJcUdJalZJdHR2WjdueWFIVHE5YWJIS1d3UDg4?=
 =?utf-8?B?eUN5S1luSTlRNEJMbi9mM3dYeTcrdUNQOVVYaVhiNmhid2M3UjEyLzZyaUVH?=
 =?utf-8?B?TXRsZ0NmUFdLT2tVM1F4TndvUUs1L25pN0hMSEg0aFpuNE9jS0dZMWlvUGtm?=
 =?utf-8?B?NmZETlFjNEtDQnVFMzdWeFZGUjdqNk0zb2QrWXgvcTA4YVAyRW05ZWhaQ0Uw?=
 =?utf-8?B?allRazRSK2NzWFF0dURLU0FsbDIyb3Y0bUtDbDJXTnZ5bk5zZ01qL1FLaElS?=
 =?utf-8?B?N1BsMEF4UzlxK2lBL0lnVE16eEt2akJhUzI4OWlqZTNHUTUwckN5aER3Rldh?=
 =?utf-8?B?NktHT3Z5QXh4N1FLWWxIMGxtY0NVTi9vS2ZhUXpyVjZKanBGOTM1Y21yakxy?=
 =?utf-8?B?L3duUnBod013TVk0ZW9aM1oxZVVwbnhKMC9RRlVHbnAwRnZXcFNRWU9hR0J4?=
 =?utf-8?B?djZzODNOU0xUbzRGVGE2N0YwQWFoYTFycStuUnpUS1ZrRkF0U0puclBOTUJx?=
 =?utf-8?B?allaK1NTd1FheXo3MlhiQjBhQlJHRUFFQlNDM2pTWW00RWQzYlFUN0Z1Qmpn?=
 =?utf-8?B?UjRnWmFVdDhJQ0EwWGs5aG5WSy8rNC9KZW9DVm12c00wSlRNanIzR3JYdW85?=
 =?utf-8?B?VmZDVDB6TlpzcVBUTS9sUzBzd2NnL0RwT0hGbmUvOEo2NHVzTHlCanlYamk0?=
 =?utf-8?B?VUFrclJTRmY3dWtmVDd6RlptZFVqcjdzdHNUZkM4LzQwa0M1RDh0UGdhV0RX?=
 =?utf-8?B?bk4xZGptT3A1Vk5ndjVhc0dQT1ppMTU0OXU0WkhhZzVxUCtQYXU4SW1ObVpo?=
 =?utf-8?B?alFIZm5oMGF4Tmk4UHdybXdnbk5kTUxra3R0WVVIYUZoOTc0L1A3dTV1am9G?=
 =?utf-8?B?WWhFSTZrUFB6NVJXZFBGczFhRVNtWU5sNDVBcEtCb05PN1VEbWRCOHhJdjN0?=
 =?utf-8?B?dXR4NGhjeHFhbzRuaFNsclVwMkE1YnF0YXRIek1QZWt5YjBubDRvbXFvbGRN?=
 =?utf-8?B?VTgxWHNMejJRQnlqeHZxUjh2U2U4ZFN2b3NDdXVSNTB1Nk5YWFIzRTBYcUNx?=
 =?utf-8?B?NGgvVWZ6SUlWNm9Idk1IVlp3UUwzOEc4UXk1KzhKbWk1RzZHaDlyRTJSQStO?=
 =?utf-8?B?RkE3eXBxMzhrNjJxUU54eFRHZGRzZ05GbENDTVR6OEdUUC9rTnc3NTE2T1Ri?=
 =?utf-8?B?NWhydE5ZUHRKYnRYOHU1L1g3Y1B6NnBlbGJBWjlxeU5CTExlS2hoYzA4RFMx?=
 =?utf-8?B?MExLcG9NVVkxWlFvNW1kNW9obnkyZ2dVV29zT1dXQmsxU01yYm9MbmV6RU1S?=
 =?utf-8?B?RC91RGMxL2o3RlJPNUY1TEYrWU4yL0FydHFQTkNWemFEdEtHNmZ5ZDkwbFpi?=
 =?utf-8?B?Q2l1REhHanQ4ZXpmdzFoM0lpNWhIdGMvVlpSVzlOVjZLNWJMQzN6cThmbjdY?=
 =?utf-8?B?Z2VxekpTWjVNNXVWVWVPRGRiU2RRSGZ6OXpoeUlDU0VQcWJDWWhzRmdBOElM?=
 =?utf-8?B?cVlLU2MvUjdFQ29kaHl5aUx6dUNmbFR6WWgzVGVRb2hlMFg5N0dHQTB4MG9W?=
 =?utf-8?B?bmFzVS9BNG4wVUt0a1p0bzhrRW9lanpzei96OW9hb0VFVXFrNTJ5N0RBaUNI?=
 =?utf-8?B?QzNJaWFSZFZyeno2ZTdXd3FHZ3EvV3JveFcxYVJ5VnVCcDdLRDZvZThWN3E4?=
 =?utf-8?B?ZnUxRUc1amdjWE1XNi92S21hak05TzZqUGlZVEFtdTZPN3FvSExSVElxRTVC?=
 =?utf-8?B?SjNOcWt5Z1IyK1F3cE1ueDRDNnAzdHFHM3FMYmRReitDY3d0Tm8zcmxXTG5l?=
 =?utf-8?B?NzRTeFlTK3puZTFoSnJmVzJvdm41L0s3UERYNUU1c0MzNjJyYVdJaGdZZmls?=
 =?utf-8?B?NmNmRE5YUUx3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWRrN2hoNndjMlZ0NXkySG1WU2JVc3JWemNBL1NHcGh1T1RkbW4wajVWeEhP?=
 =?utf-8?B?dVFJazdNT1U5bVdMNFFueWJTSXJlV0ZjQ1ZvWms3ZCtYR0p0S3lmUWFLOFVP?=
 =?utf-8?B?MkRZQit4UTJtRFRKRmZPSHJNNGJyem1kZ3FTWVJ6eXpTMFMyaXdja3NqWmJ4?=
 =?utf-8?B?bFZkcFhyZ3l4NmVZUm45cEFLM3VHYUZvUmVHMit1UW5tQXZ4NFpRQUoyN0Fr?=
 =?utf-8?B?VmV3Q3NIU2FBVzgzWWp3eVJaNTgxU3Z3Q0dEOVNIUG04UmU3aFdwbFpvckhC?=
 =?utf-8?B?MVFNT3FkSkh2TXlpenZoRW9HcE1GbkdESTRJUDdCRnd3OGptYkZYRHYyVUd6?=
 =?utf-8?B?ZzJvWjUvM1dpNnVzRTNHV2F4NHNsVFNzTDhLdUx6OU5hbU92ZS90eHB1S1gx?=
 =?utf-8?B?SGh1NDc5NWtIRlhQMW96bnY4V25icHFOWTRoNGFPbDZpcXNiMG1mWU80OGV3?=
 =?utf-8?B?dlEwREFKTVNreXlGcWJOb1RXL1hmcHI5NURCVG5NNzZ3MUFZRlhvL3ZTSUZN?=
 =?utf-8?B?MGpQTUREdVRucmwzdlEvb1ZNV281VVpWS3ZXdFhSQXh3U2dBb2RxTHY5STVB?=
 =?utf-8?B?SGlFY2hnakJ2Z1V0UUloWjlOdlhITXlzVFlHcVgrMnhLR0dZRHg3ZHcraDc5?=
 =?utf-8?B?UW1ZcE8wY25ZZkhKcHYvOGpHUGJJS1gyNThxUUswOGJBazBUV09tYkk3bERh?=
 =?utf-8?B?dnlkMmp6L09nSlJCS2tyWWxMOWNaUXhoMWJmQ0xNY2U0bnBGUGZKYm1lbU1y?=
 =?utf-8?B?SlVRdDh5dmNTMWNhS0hxLzRwTXF2dTROeStVYXE3c3ZmUU5DMldiSDNtbFRV?=
 =?utf-8?B?QjcrYjYvVFluZlZkV0ZYbldMOEJWRGJ4cVFiNXBIUWk4THZmYXFNVEJGbXJu?=
 =?utf-8?B?TnQzN0dQMno2ZFJJRUlaOXN4VXpnbnRhWFQxUmhtYjMyam84N3oxeExha29n?=
 =?utf-8?B?YStSSHRWMkw4SFo4MTFpMGtSbVFaWmNBdmw1blF6Q0FNaUFLYnpxVnpyak5n?=
 =?utf-8?B?MVEyMkVmYWEzNUxBK1ptZFhYR0QwTFFQamhWdU9PQkFPNjhNT0gvS3c3dmZW?=
 =?utf-8?B?UlRNbnJWSFhRcytVb2wvd3EyZlhLQ2NiUndudzA4WDRqTHVYUzRLbnVOU3Ur?=
 =?utf-8?B?UUR3a3I2ckErcFN4cWUvakx0TW9UNTBNQ1ovOHpOUWU2R2x3dzI3UUpDV1A5?=
 =?utf-8?B?MEQ5aW12L20wbU5RbTVIS3VuR1E3V0tyY3JWS01kcXJHOXp4ay8ySVhoTjhV?=
 =?utf-8?B?SU9NSXZTbXlqWWV6UmJmMzFwMkZNTm8vSnFrYlR5L2JkQ1pwMEkrV0N4UCtw?=
 =?utf-8?B?RUwyUWMwNVQ5RHkzMzc5d1ZkdmVjV01Oc1I0SUt4QnRXZ1J0Vk9Gc1JGalNw?=
 =?utf-8?B?QVlGanpqbUZ0Ulc3amZCV3cvSnFJMlgzVis4WEhlVDViUTUwc0IvKzZ5cE9C?=
 =?utf-8?B?eDBEeGh1MWlBWTNKUTJjRWJOTDJpekZSbDMrSlVrRGt0cVRiV1I5ellhYWFH?=
 =?utf-8?B?a0hGTFJucGtvclFtbDBFZW5WUG9SazlxVTIyNVo2TEQ1NjhVQVRxQ0V0R0xB?=
 =?utf-8?B?SlV1ZTc3M0dWT2t0aUhrbm9iY1FITk8zRHhCQmt3b0tRUCtCVW14SGVZbWNw?=
 =?utf-8?B?RFNhRTZWelA1SXQyb0xyU2hTM3drSHMxR2RBcGVDODBFWHFtQ0pwNzJoZThz?=
 =?utf-8?B?ejdwVCtmc1Jma0t6ODRrVlZaV1RrSjVkdGlqNnhKWERTdWt5Y2VFT3Q4TCtC?=
 =?utf-8?B?THVyMUtiZHFHbHlXck8zcU9SRHpqS2xTRnRHRW1WbzlidVFiUFpESnc2Y0lX?=
 =?utf-8?B?UHFQSVVwZEZaTlpnL2E4NmEwZXA3dzdwbmR3SmI5Y2ZMRFU4YlBUY09MYjhM?=
 =?utf-8?B?Ym0yQVZMY0IrWnlkbXRIeTExaFVDcDlUalpvS0t4QWxJRWVFK3VpM1Rhbmpi?=
 =?utf-8?B?a1ZhQy9LL3ovcnNXNVVZeWFnREtZaHIrMGJPeFpDcThPdkFKdjUrTzBuY2VL?=
 =?utf-8?B?TjR4Z1UrcytybG1vNDJDYjNpY2JoVm9mSXE1L1FzMXpaVkR4bE5RZ0JhUFR3?=
 =?utf-8?B?cXpZWUtUNWJrV3VzQkNXM3I5MEZOZkNtQW9SRHY5ZkZFWDRWVjBXMVBmVzhr?=
 =?utf-8?B?ZkJjWVJPaTc1Qkw1M3UxdWg3ODhhK0U1Q0p4OWhnV0k5UXRyN1FNV1ByZ3JU?=
 =?utf-8?B?WUdNMk5JQWR3R0hOMXpJakJUM2Nmd3YyRHhYcjIzTG1ycGpUU0lLNVhJYktM?=
 =?utf-8?B?K2xZQld5Q2x3VUZKdzByWVRGN3FnMSs4dXY3TlJiaDU3Y202SzRCV0lMUnpD?=
 =?utf-8?B?SkpzWEV1V0plQkZwMldKc245OUZSUXNreXhSYklldzY5YjlDaDI5Zz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DJGHikfRSanzefIGkEVf5Qk5L++IWiIu7rjtQygmZe4Rx7DAbdSg2X8/drbr/vAByDK1atN0PH+2+HWGUCq1oFd5ykXTLif4J7++V4ByXGYVtU7BQg+JfsnwVos7RbEN+1oFrU3AUGZ7y1x8SLsT3IL3FkdtwX2fQTWNZU1fSRBZaMAZ2luIQBeH5JKiEyoN0BcuGbi0lx1/6stEhRlqKP0n7k5s71IRV9Z3oKhV81Z3lZp4mre5OJSuy3xIpdNZtFy4tERmeoxYchqzkfUbC+Z2ypPuUEv/sYHXo4L5cZZ73dlBbIZXgyGrWO5wIozLBn4XK5b+FUqhnmjUQbHZ+UAcX+75CYkHJLQ/9X+QVFoaCI+k817psIcQOdLjjmVnc6rhZvSEt6Zo9O1rXMXgw5+ULzbdQv2U1o83aQcdkgz1ghNEWWTZElWHjhUtzjUSOfHBIHyMzV3X1HIkfXEqpimKEuvYWUSrNUP1vnz51o+6+WFZwZhG5FxInQL7IVpThQMlvPL9ghtCnHmjw5kxwIEAv00gPOG5Rmxnl0nmJMH4MBEajtRg2ftAxZp3Z2VqxideUMmhtOar5YJ0JUI3abIU1MTknbyngBmLrnHPkvI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d2113f-ec68-4301-379c-08de424f8a74
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 18:17:32.7976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZ5L7uDeggsTyLg309AQ7q5prlIj/cbfq3lvI2OMhHqtIvXX4vtYmQp4Xa1zvd1KteyxDoV6l8CYbIur1sRN5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4536
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512230151
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE1MiBTYWx0ZWRfX3HJaC3eQ7S4X
 GEHoo4ofkH0a5I75zqp6onNFvfI4kvbe5dbtVpy0SKS0H235fxKpgSfi/O7P1JCnT+39sPlpiY1
 aB26SiSWTYQPIUMyDFDEvUmB+8fJI8V9r9QywzuZNC+x/jcpUf5DcMcq9pkAp+jDS/WwZPFKwCF
 yDDMXwrd/nbnVi1tORGmJpD2iM1OUg+TbnELhReqi9W3dMvVagb6319Zfgp1TRhcqiFSO3PD4lO
 vVqrf1ZBgymbSKGV0PcdYB/ONHxYwd6pJytYKfahKYsn5AE+yz2CPYEUzf9GegmeRy5fWafkpQq
 c/XNqB3A1u/3vNzpY5Se/sg5IXQZA6mIHGbqws7sjLEv0iUTYGWieN4hZDCLvL9NMGbVmi8z1hO
 lH3sa2edZkNGT75wb8NVxh0CQG6O8JxhWSb9L10cZxOXeWqe4ilLEwijVtRIvG5Blm5a3zOE3DY
 Q4tRzEAbXpLNn22H6qA==
X-Proofpoint-GUID: tsfMMXHWcXf8dbhmaf0pzb32qwhuq1xu
X-Proofpoint-ORIG-GUID: tsfMMXHWcXf8dbhmaf0pzb32qwhuq1xu
X-Authority-Analysis: v=2.4 cv=OpVCCi/t c=1 sm=1 tr=0 ts=694adcc1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8
 a=vBR0NHDhCEYoLYn4nDwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22

On 12/23/2025 1:13 AM, David Hildenbrand (Red Hat) wrote:
> On 12/23/25 02:21, Jane Chu wrote:
>> When a hugetlb folio is being poisoned again, 
>> try_memory_failure_hugetlb()
>> passed head pfn to kill_accessing_process(), that is not right.
>> The precise pfn of the poisoned page should be used in order to
>> determine the precise vaddr as the SIGBUS payload.
>>
>> This issue has already been taken care of in the normal path, that is,
>> hwpoison_user_mappings(), see [1][2].  Further more, for [3] to work
>> correctly in the hugetlb repoisoning case, it's essential to inform
>> VM the precise poisoned page, not the head page.
>>
>> [1] https://lkml.kernel.org/r/20231218135837.3310403-1- 
>> willy@infradead.org
>> [2] https://lkml.kernel.org/r/20250224211445.2663312-1- 
>> jane.chu@oracle.com
>> [3] https://lore.kernel.org/lkml/20251116013223.1557158-1- 
>> jiaqiyan@google.com/
>>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>> ---
>> v2 -> v3:
>>    incorporated suggestions from Miaohe and Matthew.
>> v1 -> v2:
>>    pickup R-B, add stable to cc list.
> 
> Please don't send new versions when the discussions on your old 
> submissions are still going on. Makes the whole discussion hard to follow.

Got it, thanks.

> 
> You asked in the old version:
> 
> "
> What happens if non-head PFN of hugetlb is indicated in a SIGBUG to
> QEMU?  Because, the regular path, the path via hwpoison_user_mappings()
> already behave this way.
> 
> I'm not familiar with QEMU. AFAIK, the need for this patch came from our
> VM/QEMU team.
> "
> 
> I just took a look and I think it's ok. I remembered a discussion around 
> [1] where we concluded that the kernel would always give us the first 
> PFN, but essentially the whole hugetlb folio will vanish.
> 
> But in QEMU we work completely on the given vaddr, and are able to 
> identify that it's a hugetlb folio through our information on memory 
> mappings.
> 
> QEMU stores a list of positioned vaddrs, to remap them (e.g., 
> fallocate(PUNCH_HOLE)) when restarting the VM. If we get various vaddrs 
> for the same hugetlb folio we will simply try to remap a hugetlb folio 
> several times, which is not a real problem. I think we discussed that 
> that could get optimized as part of [1] (or follow-up versions) if ever 
> required.
> 
> [1] https://lore.kernel.org/qemu-devel/20240910090747.2741475-1- 
> william.roche@oracle.com/
> 

Thanks a lot!

-jane
> 


