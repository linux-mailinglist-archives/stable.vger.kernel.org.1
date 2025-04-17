Return-Path: <stable+bounces-132928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE1A9167D
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57E11907D4B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B5B21516B;
	Thu, 17 Apr 2025 08:33:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948333FD
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744878790; cv=fail; b=iAJSLde3qvMti63NnNngoms64sp6RpxKIt6DvnjyJgxiaP/ZRsMyfdZItLAstno5RlUBViQj3ypSPF0tgZPCfyqe7UhGxnfcojm9Da1Rjr6YWyEU7DDBWZq6GvaWHr/csbXlGFmCN+W/dR7esGkwmSGx+9lAmPWNlj4HvGj7CTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744878790; c=relaxed/simple;
	bh=pBlbOMQYGT3+8RcRbFxts8x+QumXdGXP8V8OfTdmZZk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SrTP0Y8Jd7XuxjnbXDsXUaarqKoK0Qc/dBiQ763ZZpMfpwlKgv8+g3VDCOpSSCB6g4a1CagxF5ac9b6XF4Y5zOjx1S/g8EFnawDNz8gJYweu7dpRTzG443XfoLqQUBwHU92X/XRlH7VMfy9RTsGO44JaqI4w7XBxbWVbUMxqm1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5Rajq003805;
	Thu, 17 Apr 2025 01:32:56 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ykf3nvxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 01:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTWmW1hStmoBCq7wF5FvDOqIgHdypdpF9x6tvmbCyrUMnDNUbGST/fiWh/RUJInlR/Jr2X2ONGimFpDoOZLHWwiS57iqVPznh4dJehChsSgktzZguxLpflxylAFWuRJuyRQXm9Qv461QJKHkZ7QRUBufhfvqB20BSiqsRzSPWTO4A923lCBtIALJ3fhXSuVn6QfijhDhMUlx40HmSJxnvtAeHg/2r23PQ3rygzrxnlHiH8k62izE7KjFbTGV9LRAyeqMn+GGVtqFcz3PVj0uoQE3hGKgRYZCJokhHlPnZH1J8c4ZFJvbOfCImEqSPnPeAarL97BZIxqfGvgGJGrXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUQssY7u2NOiJDtpwD1dXpPwLa0x0UEcXaT9EZ5QT4M=;
 b=mrS2XaKKp4h3gRsWMEaqo40SaSp5wBSQ69tQOQKozC/lcadICeuBYalJh3wAafVL/4UjNUgR7F1DBRCHzxYv0Dtb3v+ionGYTARJw0+SG0M7QxuKg7huwwEHqnrsKVZf6bM+VIvYd5b5lJs80zk8fxmLTlGCDr7VLJnZbvjFu/5/GcsaPt/8NhDOcRUxLlza9SMANmBY96CaJtDAEc9KJeaWK7EhGsDpO1cMew2OCDeTSDJaBJVgeOdauLbboQmn3Ju3k5iUsZWIfb9ou7setYM60CQaTYJAYbmPtCcDqghDnPBKGo3mCKpq8wascA3V+1YVEKbl6yJeNG9CQtAZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6)
 by SJ0PR11MB6741.namprd11.prod.outlook.com (2603:10b6:a03:47a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 08:32:50 +0000
Received: from CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d]) by CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 08:32:48 +0000
Message-ID: <e23fecb3-b104-45cf-b28c-3a9d90ad4c85@windriver.com>
Date: Thu, 17 Apr 2025 16:32:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Question about back-porting '8be091338971 crypto:
 hisilicon/debugfs - Fix debugfs uninit process issue'
To: Greg KH <gregkh@linuxfoundation.org>
Cc: huangchenghai2@huawei.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, stable@vger.kernel.org,
        "He, Zhe" <Zhe.He@eng.windriver.com>,
        "Bi, Peng (CN)" <peng.bi.cn@windriver.com>
References: <767571bc-1a59-4f7c-a9c7-fb23b79303a9@windriver.com>
 <4725f8e8-7f46-48f6-9869-8bf16eca6f1a@windriver.com>
 <2025041727-crushable-unbend-6e6c@gregkh>
 <205d560b-be0e-4ee4-8293-e66023e481c0@windriver.com>
 <2025041739-armoire-dimmer-4670@gregkh>
Content-Language: en-US
From: Cliff Liu <donghua.liu@windriver.com>
In-Reply-To: <2025041739-armoire-dimmer-4670@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To CY8PR11MB7012.namprd11.prod.outlook.com
 (2603:10b6:930:54::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7012:EE_|SJ0PR11MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 728f31d8-387b-4437-b030-08dd7d8a6f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU0wR0lLU0hxZ1k2aGcwa2ZJVk00MjZyNVlZdDBxVllUOE00RTBQRjhMVzhj?=
 =?utf-8?B?S3B5NWdmb0xlR2xFYUZuUVhjSmZXaTdlYXMvbGVLdnZjeUsxUWQ2M01kbkp1?=
 =?utf-8?B?YUVRVml5R1ZNY1JCempmMUxVOUNCKzBiUkVTVmI2RlJqZHZldWZKdmJRUHc2?=
 =?utf-8?B?SDFreDh3TnVCc3lBeVlFK0prL0V2U0EzL1pRUlN0RFRqMUJNMVUvdSs0bDJz?=
 =?utf-8?B?ZVhwc3NheUNUY3czYU5yRjJ4cHJGcUxnQ3hTaVphVTB4NUJaNStQTS90RVcr?=
 =?utf-8?B?cmZiQW8wYmxnWlBKb0VEM2FNVlREWTNZLzZzUFZrR0daNmI5QWp1a3Fzc2or?=
 =?utf-8?B?Ump4ajQ1bjhMRTJRSk9rL3pyeWNUUGRySTdoNFIyNVZlTEthRCtKYVF1T2F4?=
 =?utf-8?B?aklHaDhkTmt4Y012dEM0Z1hpWE9iQUdkMm4xMUxXNWI2SXlwOEZLajkzLzVJ?=
 =?utf-8?B?WnpmWGZqZWZDOGN2TXBzNjlHcVZRMjhvYW04ZGRvTXRYdTZ4TFY3VzJyUFhZ?=
 =?utf-8?B?ejUwRDVERE5idUlCdXlFTllUNlQ4VFFMMDJwOVd1K2k2Z01Xb1l5WW1mQUlR?=
 =?utf-8?B?STR1T1lBWjlKRTRsbTM1eWgxODJudkw3c1ZnbHVjOTFkb250ZkpFZDVUaTBw?=
 =?utf-8?B?SEZQWWo4OTRsMG54SU53bnVyN0h3RTJ6dzVhK3lBQW5rQkVpSUthNjVrd0sx?=
 =?utf-8?B?ekVkeGxJbUlGbmYxMzg1U0tsNERqS0FzSW1RWTM0d0xRd2dHeWcrZ1Y0YUpv?=
 =?utf-8?B?Q2lkbkdlYzBla0haUEdDZzU1dUI5by9MZk1PTG1xWFhZYTU0TW9SaW5WQTNH?=
 =?utf-8?B?QjQ0eXlsS0RqMFkyOGpiMmlpSUsyMmk5a2t1QkcyYU5jTE9nRFZGUU9kcWFt?=
 =?utf-8?B?MU5ha3dPM2Zid2hSRnJ4dGpqcmt3OEx5SDNyb2VOMGJpeGU3WlJzOHIzOWQ4?=
 =?utf-8?B?VkI2dE1kblk0cXVUb0lpTXN2Z3VHQmFvNi9LL0t3dnRtMnRQc3BaY3BOcnR0?=
 =?utf-8?B?UUNHZGpvaVJGdklyY2Mrc3JJOHdPcnJaSnRDZjhZMEc1RnZHOVJsdTRmOUxV?=
 =?utf-8?B?U2lWWFFuTW9UNFJoTE1DbFc2NFhpV0hkVmRwNlB2dDBMK1lySFZVY2l2dVdS?=
 =?utf-8?B?bktoNWxaN1NzSkloaDhaTVFneWxXWFRaRzBxaElvZElhTko4TzQ2eEFBU3cw?=
 =?utf-8?B?UUVJcXBseGdrL2dkR0QzR2xDZGVNVzI5UlZvejdPRGdyR3U1cXRZeDVvNkxu?=
 =?utf-8?B?UG1OZUlqa0tITUZGMmJKaDVtQkpXSDZiMk5mUERDSjl0ZjNTSVpwZ1AwYjhW?=
 =?utf-8?B?dUNSNkJwZ3JTQ3B6aDJ3ZFJmRVYvSzNzZ284S01WNFlvUmRZSmhkd2tzYy9n?=
 =?utf-8?B?Tk5QeFA4SVdQaHQrbk5rZnFuL1lWRHkycUZOWVk4VStqcHQ2bzk3dDJ3aTNS?=
 =?utf-8?B?K1pwL2F2Smg4dExsekR4YWtVT2RZTmRBK3FYNkk1YWNpWERYV2liU1hsQnRW?=
 =?utf-8?B?cVpXbDRrS3NLWkZBM3k4UUxkdGp3Z1VkSEhjd0dQTXJ1aTIxaExzNWE5b3lS?=
 =?utf-8?B?b1BITEhOWU8xby9hSk9pdDFodlE5NmVpZVZ6Zk5BL1V3U1NVZUl1ZmhaTEZi?=
 =?utf-8?B?eG50UGhUOWx3UURuNCtWcWZYVWJXRGJ3Q2pOa254aXN3RkFOUzhhWXNCOHB2?=
 =?utf-8?B?OTEvYnk2eks3Q0laUit2dE5IK0lQclgwTXZiN2EwVEtzVFZyNU5zVWJRQWZy?=
 =?utf-8?B?TllZMWpuVlVGK3dhTE9Pdm9IeUNDOG11QWYvcWZ3dnlaWTcvb2RNc3RhVXBY?=
 =?utf-8?B?ZWZXOUZlbnlkeXdUcTRIZ2xuRUh6RTgrLzhGT1V1a2dOZXFJZXREb25oU2hC?=
 =?utf-8?B?WFduYkljTHpGemNkV0pjRlhhemx4eStZalZnRTBTdGJtc2NtVCtJWlRlS0xP?=
 =?utf-8?B?WFpFaW5vcnh4SWpjSlNIRm9ML0wvYVNJdWJZOGRkOTVlUUFlTU1pSFl0bHI1?=
 =?utf-8?B?UVAyTHBwWDdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7012.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bitFNWlHL0NnSWN2dGpTbFVSa3ZUWTV5MWVRMzJWNm1nQWFjazJuRG5DMFBw?=
 =?utf-8?B?eFdPakJ2cVhoTHBNcnpIYkpiMkdUNWVsV3J3R0Jqb0lCUEg1Sm9PVFZUeVUy?=
 =?utf-8?B?VGN6THk3cXFxZzduSDk5ODJVNjN3dE9ZNHptWjVWUk5jbzZjRWI0bElFUzNH?=
 =?utf-8?B?WmZGY3M4Y2J5MU5KOEpHVGozTDIxOWVqVFEzUHVsa2RWWUZ6UE5hYTRMUFVJ?=
 =?utf-8?B?OXhudm1tVHFRTTRiYk5vcXZUQmNqdVEvSCs2Vy84K1lnUkllUjd1OHFMTGdV?=
 =?utf-8?B?WkJkaWs5Z1RvbmNFYUdRQkdkLzIvWEhHMHNNTmRUcVgzTEVVeVlPU2hVVUI3?=
 =?utf-8?B?TkhOT0RtM0tpNk1aanhRYVpXUFcxbVZJQ0lPdmFFL01LMUdjZmJhdVlGcEtp?=
 =?utf-8?B?bExTYnVnSHEvK0NYMUVXa0dsOFVLNVJNM0xidzVtaUNaMGVNS0QwZjVld21H?=
 =?utf-8?B?eVY5TmJQWFkwWG56U1puNzMrSTNVcldRRmpvZ2NpaVVndHp5TU55RG00NXJp?=
 =?utf-8?B?WkhZSTF3TmcxRFN5SVBJUk1OQWJkTVh2YlNmUFBacjZUSGhFbjh5SDF1NWtO?=
 =?utf-8?B?TVZvUXJiNHEvVVZrTk9MZE9VeGIzMktYdnZwQ0xWekIyT2hqc3hXdGtGdmw0?=
 =?utf-8?B?cmhKZmdOK24wTEFGMHk3SzhSMFEvazlRcFZFMCtrdEJ0TGNqd3RQM25yWHpB?=
 =?utf-8?B?SEFubDRkL001ejFtaEZRL0pqcDNTMTNCcHhnQnVrRVhmWU1XRmdOdTZiSXdQ?=
 =?utf-8?B?MXB1MUtLWjNzQW9kVTArSU5LK1UxcHNIclRsSEhqeVN1Um5iM3JKdzlZM3R2?=
 =?utf-8?B?ckRNTEZIUzNOT3V6REVkUHdjM2huOVhCMkdXSFdiRUpkM3NubG9yeWZseGtm?=
 =?utf-8?B?aHVseTFiQXFnN0kzdHFTMjcwV1d4RXpyRmoxWlRGZjNFRHM5aWtjWHhZRzJY?=
 =?utf-8?B?Rm9Qc3lGS20yUlN0eDhMSDNMWDEwbmlOZXI5ZFVjWEFGbmt6UmcyYkRlZGx5?=
 =?utf-8?B?K1VFQVlzcXorNklXbGo0ZTFHZG1LWDYvanJpbG05ZVlJTmRVYlZzdWZaaE80?=
 =?utf-8?B?NUpxRE5vLzc3c2FYSjUxaERES2wwMGVac2lNWGZNeHU2VmJuaXFvZ3JOWE5U?=
 =?utf-8?B?SWNML1lVYXpUZzd6WkY5NWoyMHlmMlo1eFUvY3REaXcwVUpTS2thVVRPWjBK?=
 =?utf-8?B?KzZEYTdUUk1rUzVyS21DUW5VNUUrTjRFdTRFZWRWc1hoNFdBWGNPZko5QlJU?=
 =?utf-8?B?R2RadFNybHVvTHhZRGJxby9ZbTVKcktQNjRMWG9YMHljMVE4V1RCZ09zNzg5?=
 =?utf-8?B?eTlNdWkwZXN5SDJtT25jbE5Ic0VNaGRmb1ozVnBYVU4vSG84d0JnenRicFcx?=
 =?utf-8?B?VVB2TjdvQWkvTlRHb213ckYyM1lySTZ1Z1J4blNIOG9PTXpHbVhkYTQ2Y3hI?=
 =?utf-8?B?YUhyK3l3a0dCck9DVW9pZURVczBnUmNNblJySmNYWkszbnBJdjRyRGxPcWxS?=
 =?utf-8?B?OFVBakJ0bkdCbFVhZUhCTEJROWlBNGI1TVJWdjJZTW02TTJ6M2xLbWtsUWJm?=
 =?utf-8?B?WURKbW1GQXcyUHEvVE5Pd1MxbytOODN1S0x3cGRrZ3pjeEpYVEZ4RXlJRFE4?=
 =?utf-8?B?ZkdJNnhVNDFvK1dOVFlwUUhGMjdPVDFoeFh4TGorUXhiclRZZitCN25UUWE0?=
 =?utf-8?B?U1h4UE1Oc3YzKzN6VkZYdXN0VitXODVMSFdUSFc1RUNtdW1HeE4rY0lqb1RF?=
 =?utf-8?B?eTZuMFVQMDNUdGthVXFTcWZWOGdWVmNGV1c1SVk1ZGVEaldIM3pFNFk4NDFM?=
 =?utf-8?B?QVlNRVlTUXEvODNyaitaMmh5V2Rnc0NiTnYrUVQ4aGw0d09mcEp4TUQyenZt?=
 =?utf-8?B?OTlUZVA5cEJ6MXh0eTJJK1ljM2g1L2UrQWloR0pIMFVFYjhINE1GMjdrdEYw?=
 =?utf-8?B?NllYck1RWEE5QUltZkduRjZiVmE5WHRhaGNtUndjTkEzZGxOZ3ZPK3A0dUpp?=
 =?utf-8?B?VDJiOW1BeUdUNCtzNnpCWUxDb1d3anpxQ3NrSHZpaEhZR1Q1b2xRc09IRnBa?=
 =?utf-8?B?dGhYejhPUkxnQVZ5SVJKamw2N0hsRE5kK1RUbkhQdUp2SWxjZ1QyQWFHbUha?=
 =?utf-8?B?OUQwQ2RXSEp6ZHpLcWFTZTRnM2MyUzlDK2J3YWNlNHFORnhIaWhYRkRHaDFY?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728f31d8-387b-4437-b030-08dd7d8a6f78
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7012.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 08:32:48.8476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/sU+sXY2ALiz4lstBtULfByvFITfUcfFY0QjDqykY9vjjk6IbFIodXhClNvY4epdNfp4qopg3ximsLSh7JwQ4KBjm9saFx41FzRvNDeka8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6741
X-Proofpoint-ORIG-GUID: AISLF4MeCnqzVjB4dwTZzyzyE1HMHLLH
X-Authority-Analysis: v=2.4 cv=Wd0Ma1hX c=1 sm=1 tr=0 ts=6800bcb8 cx=c_pps a=tyvwN2z/Y66O58r8mq/nTQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=svu2lBDfLdKgIkqdYA0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AISLF4MeCnqzVjB4dwTZzyzyE1HMHLLH
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_02,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504170065


On 2025/4/17 15:41, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Thu, Apr 17, 2025 at 03:32:07PM +0800, Cliff Liu wrote:
>> Hi Greg KH,
>>
>> On 2025/4/17 15:13, Greg KH wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>> On Thu, Apr 17, 2025 at 02:51:05PM +0800, Cliff Liu wrote:
>>>> Hi,
>>>>
>>>> I think this patch is not applicable for 5.15 and 5.10.
>>> Then why are you trying to apply it there?  Do you have the bug that is
>>> being reported here on those kernel versions?  If not, why is this an
>>> issue?  If so, find the files that are affected in those releases and
>>> apply the change there.
>> It is reported by NVD that it is CVE-2024-42147 vulnerable and this patch
>> fix it in v6.10.
>>
>> So I want to back-port the patch to 5.15 and 5.10. I didn't make it clear.
>> So sorry for that.
>>
>> I just want to get more help or information to confirm if it is applicable
>> to 5.15 and 5.10.
> Do the research to see if this is even applicable to those older kernels
> first.  Many times the ranges are wrong, or missing, because the
> commit that fixed the issue did not have that information.
>
> CVE fix ranges are a "best effort" so they will be wrong at times.  It's
> up to you to do the work to validate the range if you care about that
> specific commit.  If it is wrong, submit a patch to the vulns.git repo
> to update the range information, like many people have been doing over
> the past year, to fix these ranges where they were wrong.
>
> Also, don't use NVD, use the raw CVE records.  NVD has a "value add"
> that everyone has realized does not really mean anything.  We have no
> control over what they do, please use the real CVE record instead.

Got it. It is really very useful to me.

Thank you so much!

    Cliff

>
> thanks,
>
> greg k-h

