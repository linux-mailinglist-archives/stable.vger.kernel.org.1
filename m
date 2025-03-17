Return-Path: <stable+bounces-124613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C84A6449E
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 09:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7725F171183
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 08:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CBD21A452;
	Mon, 17 Mar 2025 08:01:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EEF71747
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742198510; cv=fail; b=STJ20AQ3W92vM+684hORGIlTNG5okokFBPEWiC7zOrhcgIuIp1ML/f8ZCcpyF630SKi7Urve+KhoPTgr0AYLZHUWCg54jl/a7WDBROiaee/i3H8h2sKaWL//V5ervb2NoG36fJv1FaYtJvx32VKNE1cuitUeqOoOFCzjd9JC6sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742198510; c=relaxed/simple;
	bh=2Dvk+2jBhki+HyoNPsIcYCtfzTew8rLBvS+38lFNXPk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FSKEgsfSlV9UGS3V/d1gp2RWnLHF7SMlQy7s1Bo5hd/ofkvpDn5fXXf3Am4iuC0JDtVo35VSMTtaLbwFcbVstZljZ+odw31E+F9iUPYu7fp4ISTe/I4iYIKiNukaXeyEQkKMXDvOvqlxKeDKhKYZRHzJTjL006lbpbpsG9E/Wrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H6YaGd030360;
	Mon, 17 Mar 2025 08:01:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45d0h91sv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 08:01:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1SJZzlUeVuHhMFUrhpZEQ0Di5i2kF8we1D9atg6/vGLArB9daEm6LZ3ifxltW0H/Rb6IoPVBuRA+lvPONeXmeWtzLCeR2zXMPuxD2OWVHwTp5D6RXeH0UPEee4juMH3JDdCw+7XeLsKIigDuWBmWlU1r+GRQHpjLBi64il12dqhp0ylAyR6sVdlxfuoLleIk4VF8tsu3GUDXJwEqslUvvq3owsnS5YjsH6K+LOZCEYvIPM8XLah0G5/MqwN6ThjFXJiJx8YNyBoJKJlcYOoggzdOFij1gPJpx7/8DkvjolyAHqVx3cSotMt8HfcgLxGdI3cR90NtyzhDVZu4nc7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVB6DHUAsddJSBS9VDbGf/fJeSipIPlLj7bGfj/zuZA=;
 b=CYBTPXow6vK7weLcOJNnjEAInSegYeSUj68ko94qq5stiCqfSruRODshzw0TfUKfCIMhbORYPP9Y7qPCPl0LEn/dseZpCTxagbZJ/m9vG1PybFxK/GBPkRJJ+qAj3GAUJd3REMcC91uDP+FmWLdZbkrNZ9Z3AlEwMbQg7r5D6jPqJQ2Yft74zH5bd58wKdGdEkzIG3ooq1QHyqdfYgr2qoT4+c9xQgx+Nb0M89VPJ8k2LdWBOTb/5DTCg9ajSaJYU/RrtYDy0eb0FBV+de2VUCr09UrBv44f49yNlC0NnLlkcCjVBBKo3DE+gl+mSFUPXT8Zi+lbnIsuj0lIJqNYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SN7PR11MB6898.namprd11.prod.outlook.com (2603:10b6:806:2a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 08:01:37 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 08:01:36 +0000
Message-ID: <2d09445c-33e1-4615-b67a-2f10b6909237@eng.windriver.com>
Date: Mon, 17 Mar 2025 16:01:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5.15/5.10] uprobe: avoid out-of-bounds memory access
 of fetching args
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mqaio@linux.alibaba.com, mhiramat@kernel.org, stable@vger.kernel.org,
        zhe.he@windriver.com
References: <20250317065429.490373-1-xiangyu.chen@eng.windriver.com>
 <2025031710-plexiglas-siding-d0e8@gregkh>
 <3fd37132-0162-43a3-9543-f26ecec9a7c0@eng.windriver.com>
 <2025031710-mandarin-upbeat-22ff@gregkh>
Content-Language: en-US
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
In-Reply-To: <2025031710-mandarin-upbeat-22ff@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SN7PR11MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: f63aac32-074b-4dd7-cd37-08dd6529f0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZitIOHNVWWhSKzV6T0orUGtZeUJ0elQzQUpFSTkzaGU0R2JqNVBlWWxTN2NH?=
 =?utf-8?B?b1pqTGFsenVSaUFrUFdGbDVaTU1XK1RraXhFZnZBY0RDTythOWpIRm1EL3p0?=
 =?utf-8?B?SVNTWVdIUzg0NkprM0UrTUZPL1huT3pmL0dIa3JKTmN3alJjem95Yzd4Q2VI?=
 =?utf-8?B?WkJwTmJFWjZGRy9CNVZxM05hTTVkQjljcFBhM05uNDRZK0RGeUR3b0N1WURt?=
 =?utf-8?B?M2V1TlZhUGw2RzE1U3ZpL1VDQVVsNFFxYm4xNVVmdFg0ZFVHNHpmT05KazMy?=
 =?utf-8?B?S3pjOEdnY3ZsZ3ZGTHJ5UkxhaEFkWC9PS1gzcHJtY2xjZzFqQmczdTlMMXdE?=
 =?utf-8?B?dXltUDFqN1YybHB4WXhEZ1RlcnY3OWdiZklHZjR3Ulg5SE5OU0p4TXliakhm?=
 =?utf-8?B?U25meTdIclMyTU1LalZ1TjhpSnkrQmY0RndJRUIxb0liaTdORGIwQlNCSG5M?=
 =?utf-8?B?bzM5UDdsVkxURk16VFZ2N2lpTlhtVDJueUVlbXROdFJWK2R4cklSRXZJOTJn?=
 =?utf-8?B?T3BmZ0I4Mnp4YjlRYVpmVk9jd0hheW5nbzVsK25LZnVUTjZ2Mno5ejRobTll?=
 =?utf-8?B?Nk5jZDlYV2VhckxRVDI0ZnJqTDBuN1BnK0pxM3RhVXd3bk80cUFpdFhmVm5s?=
 =?utf-8?B?RHViZlprTXhUT01Sd0RWTGZXMGh2YVN0dndzQ0xHakZTc0diS0ZudWJOdGJn?=
 =?utf-8?B?L25PZnZTT3dHb3NmbEd1ZGFHenZyS3Q1ZjN6WWs4ZEUvZHJzd2t1YW5ieEV6?=
 =?utf-8?B?NVptVmpwRWxTNHgwUThOajRnMUNiaW9iZVY1QXFRQVRPNy81NzJZaEJHSEs5?=
 =?utf-8?B?dktuQ3AwT1lsRkY3M3pudFZBaVpxVGl0UEpwMTJHYjM0eldPMkkyVmpac1Zz?=
 =?utf-8?B?NkZNTURxNjQvb2ZOUTdaMXhoMWNwbDNIUUo3SWJMSUVLcFBGdEVPdGpiVmJq?=
 =?utf-8?B?RGt6TUI1L3BaZHlUemZKZ3Y2UHNIeFgvVHdNTyttU2VyOE9IYk9UOVNBN0FM?=
 =?utf-8?B?aDRjNXRaSnJYclpHd0Z6eXVCY2I5dmNwaU5vcTE4TFVzMWVUNkUzK1hrZ3Na?=
 =?utf-8?B?NFUvMGxLbCtKNTJzUTN6bWx4a2hXSXRMTFZOajNvQUdZcWxBUGMvTEdidU1j?=
 =?utf-8?B?L3VNcWo3UXVHcWVCTms3dTN0Si9yL0l1Mi9MRHg2U1dQV3BNN3RkOHVSRWJI?=
 =?utf-8?B?ZkRUbmdrM0ZucXJlSm1kaENLWTdNek5saVhhMFhUTnZyYTlzcUNTSjJIbmJI?=
 =?utf-8?B?a1liek1DRlZOOUJMUzloUGdDV1BoUVZ3MGZDc2JTSkFaT3dZczNDY2I2dkZy?=
 =?utf-8?B?Vk1sdU9DdXBLUDZldkZIUnhDUnlpVkZWRlNxL0dSNFlGb1BWdmJMN1ZoNEtr?=
 =?utf-8?B?UFhSR08rK05iMWYvNzc4MVVYOStDZ1J1QU0yRlZPWndXd1Jxc0dkcHF2UzJF?=
 =?utf-8?B?QXpRdzFlaDdRdlRYbW1KbDd3L3ZtZlFRTnBUWnJKcWw3QmhQZEl5VnhDdDZj?=
 =?utf-8?B?NmFsYzBKWkpZcjlneWkwUnp5eXMwNkduTGJLck1TbnhiazFIUVR0ZGNTV0tx?=
 =?utf-8?B?WS83cXVJdVpoMVc2YXlybVRsMzFLNjIwQmhiUmtqb0ExckxlejN0MWhRQkE4?=
 =?utf-8?B?eFQ2cEJmSWk1WHRHdmg0THkzdFZFVzdIQmNLa1VKYVNoSjN4YzdITGlYbUxK?=
 =?utf-8?B?SXhWakRTOTVTNkFtUjZhZjF6eEhEK0ZSUUNnQmpOaDBCdzdNRWRRcC9RU3pJ?=
 =?utf-8?B?bHhRUTcxbEVSSU9QSHV4bEpXbG12UTlYSGNKTll2YmdzVW54d1lTbmVDejVZ?=
 =?utf-8?B?eUdYMW9tc0tENnY0a0hBUCtMczBRM3Y3MU9nelREQW1FZlAvQTdwd0FYWExi?=
 =?utf-8?Q?z2IFb8/3iNUtr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUhYQ1kyM3UxaXZpNUY2dyt4SU9hWHhYK0pqTnhsbXo3bVdhY2JBRnd5RE84?=
 =?utf-8?B?NFU3d2RwK3h5NS9CN1BiNm0zeUJHaUcyMlg5RlRVRlVwR3Q3cnRLVGNOUmJq?=
 =?utf-8?B?b2Y2K2M1WWd3cTczQ3g1Y1lhRXZTZWphUVdkY0V4OUQ4aHhWN1YxZVFFYUdY?=
 =?utf-8?B?NWlKN2VNN0YxeUJBSUJ2ZkpVMm50eUc2N0dPZkdGNWNRa0xFeEJ3cnVtd251?=
 =?utf-8?B?VGZ0Zjdmd0NrV0w0U3pvM0szZ21QVFB6YVVGOHpySTk1WEdsanN3aWRDSmV2?=
 =?utf-8?B?RC95VHFGdDVKKzg0M1loK2tlMzJYVjM3a0JMeHUybFc4bFRXL0xoRzZTcklt?=
 =?utf-8?B?YncwZHVMd1pEcjgrZ0ZoSWhVampPU0svMnNuR3dYZlN0WDFGOGNORkZXVnVt?=
 =?utf-8?B?a3dTMXdQdjZ1NUhXeFNqK2RyUGphMnN0MjByV3RmNk5SSW5wZVdhRnByMUll?=
 =?utf-8?B?MGhvSmxyOHNsTzBBcm82R1E5N05JeC9Md3pVVjM1ZlIrSDd1cWNlOExMYndz?=
 =?utf-8?B?djVnQmtBTXVQUFQ5NlFGMDNBaHZOcEJyZU5vVkg3S2RQdEc4SFh2SXVxUUQx?=
 =?utf-8?B?SFRNQThwUlNBQ0hheTZqOGMvd0YrSXhnN1FJZGF6azRGVThtRTBETUQwZnVS?=
 =?utf-8?B?UnphaWxJWEtCZkFHdFhQVlZjdWhWYm0rNXpJU3RhaldWcCt0QTJwK0RHZk9E?=
 =?utf-8?B?WHZpTEgzWVZOdmxUNlk4TnpBM0lVNDRheFZBRTBVY0tpaTI0OFdnUXZJRkRj?=
 =?utf-8?B?WkJrWXBwUCs2SUNKeHYrQkc3TGhlNHI4M0lCMnlsNHErNndKUzR2MlJjQkU5?=
 =?utf-8?B?OHNrZXVzT09HTHBoK1g3MGc5bVdpZktRNjFCY1lPTnRVZ1lpcmpvMGRidWpz?=
 =?utf-8?B?Vm56QUd1NEM1RjRONXk3RGk0Zi8rMTMwU3BwNCthY25saE1ITU9VdXFSZnZO?=
 =?utf-8?B?NGVQUDN1NGJxZTQ2OXV0bkVDd0tNNTVFWVhSNUtDbCtvWU9XU1lHdkREYmFR?=
 =?utf-8?B?QTBCQTcwSTBjWCtRRHV0aDloeWlqTlVnRWJGazFBYk40UWc0MTZDOG8yeUEz?=
 =?utf-8?B?bmczU3gycEprR1hTQThxTDNublFKeUF2OXN6Uml2UzQyYjUzdDlTSVVwMmUx?=
 =?utf-8?B?ZjJZdWlYMy82cmkvdnF0ZTYyR2phUHNTV1JQbUczNll1TGk0Q0pSOGd2R2ZS?=
 =?utf-8?B?Vnd3RGFvcU1zYTBGTWFZU1QwTVRqTDFMbHNzaU9mSmRpdENyUHBuako5bmVX?=
 =?utf-8?B?VWN1cTNJVnhUY0xkZ2JMOFhyOENOWWR2blRLb05MNGJ6Y1ViSEJ3QzZ5NmxG?=
 =?utf-8?B?YjJMcTJUUnhwbXZiWWdadVpFek1ZMzhpanpJKytUT1lER0U2TERPTElONnpp?=
 =?utf-8?B?YnJhQ05GQ3ZrMm4rSTdpaGc2NUVFTjlENEtKcGVVN3B4aXVCWXhPVTdlSkpt?=
 =?utf-8?B?Vi9rRW16MkdkWUIreVZRMnlUaGVjMm9UYTJZUlMyS2J3RWpKWTRIcFVHZUFu?=
 =?utf-8?B?TEdTTXFucWJMY2tPemNOSmhlNnMvK0p6UC9HbFRSUkh6c3dyS3E0MGxBRms1?=
 =?utf-8?B?N3AwOUxaMi9SYnltYjYwS1FTdlZUNVoxc25ZYmdCMWtZY050cjd2MU0zbkJU?=
 =?utf-8?B?ZUJBaytac2lIeEk5MTdYd0ZFdTYxT29DK1dhd2pEcDMvSGFTdXZDK1EwdHBI?=
 =?utf-8?B?WFdlVTBWSUU2Z2pIVkZqSTZrcG5PRjlFK2VRSEhNMG83K2VPS0daU3BlZmx2?=
 =?utf-8?B?QS9BWll4WTFjaHpmd2RmY0dqVHgra0VPL1JFYjRIS2ZCdi9SWUd6UHZPcy9K?=
 =?utf-8?B?bGF0RGlnMzZTUlRvNHVNMno3NHZxc1VPS3FKZzdzVXRveVBOaVVXMXhvRlQw?=
 =?utf-8?B?NURYUGF3OTN3NzI2NU9lbVdiUWVKZWMyM0ZDaEJPTjJIWDkzWDdsZXkyeUFq?=
 =?utf-8?B?cmlETWtOMmtDdGZzdk40WnpvZ01Jd1RXZmRPQ2d1UzljRmRPa1hpNmM1ZTFF?=
 =?utf-8?B?aFFTRGJjT3dZcVdlMWplZW0vYmx3RGRGa3krNnlQeU45UHFOaFpxQ1hoTHc1?=
 =?utf-8?B?Vk1ZLzZCSnYzOUNPRUk2eDJqRURGUTBNaDVqMGV3OU9zOUVESE55YTNEaFls?=
 =?utf-8?B?V1c2ck9XRUlUenZlY09GcjNSRm5veENmT1U2bldzVlVXNm1OWnh4dUU2Tis3?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63aac32-074b-4dd7-cd37-08dd6529f0ec
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 08:01:36.7804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8WQH0S4f31YOPvR+w9lRkj/V6hxw180vMfPT/eVW0lNlHgR9wYMIeoFxuHsSzC5lN33uDElXt+LZ4ur3/MKMUpaV3dIrkM22y2IR+ZOZ2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6898
X-Proofpoint-ORIG-GUID: f3ZTX2wRnUMsiD3Dhg5TWGmNu5mYIdaS
X-Authority-Analysis: v=2.4 cv=ROOzH5i+ c=1 sm=1 tr=0 ts=67d7d6e3 cx=c_pps a=ur2hu7Zt/Tb0cWAHmjvzJg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=SRrdq9N9AAAA:8 a=J1U6rzlL496xlnIYl-kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: f3ZTX2wRnUMsiD3Dhg5TWGmNu5mYIdaS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_02,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503170058


On 3/17/25 15:11, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Mon, Mar 17, 2025 at 03:09:50PM +0800, Xiangyu Chen wrote:
>> On 3/17/25 14:57, Greg KH wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>> On Mon, Mar 17, 2025 at 02:54:29PM +0800, Xiangyu Chen wrote:
>>>> From: Qiao Ma <mqaio@linux.alibaba.com>
>>>>
>>>> [ Upstream commit 373b9338c9722a368925d83bc622c596896b328e ]
>> Hi Greg,
>>> <snip>
>>>
>>> Why is this an RFC?  What needs to be done to make it "real" and ready
>>> for you to submit it for actual inclusion?
>> We try to backport the fix to 5.15/5.10, but some logic functions are
>> different, the prepare_uprobe_buffer() in original
>>
>> commit is not exists on 5.15/5.10,  we moved the fix to uprobe_dispatcher()
>> and uretprobe_dispatcher().
>>
>> It has been tested in our local environment, the issue was fixed, but due to
>> it different from original commit,
>>
>> this might still need to author help to review, so I added a RFC label.
Hi Greg,
> If you want people to do reviews / work / etc, then you explicitly need
> to ask for that.  Otherwise we all have no idea what problems you have
> with this change, nor what you expect for anyone else to do.
>
> First off, why do you think this needs to be backported here at all?  Do
> that research and work first, and figure it out with your own testing
> and evaluation before asking others to do any work for you.
>
> good luck!

Thanks for your advice, I'll pay attention next time, and better use a 
cover-letter to describe the detail information to others instead of RFC 
label .


We backport this patch due to a high risky security issue 
(CVE-2024-50067),  the 6.1+ already fixed, but 5.10/15 still exists. 
Since the uprobe is a common feature in kernel, so it should be fixed.


I read the fix and context commits, on 5.15/10, the original fix in 
prepare_uprobe_buffer()'s logic can be apply on uretprobe_dispatcher() 
uprobe_dispatcher().  Based on that, I have verified it on a local setup 
by manual,  without the fix, 5.10/5.15 can be reproduced the KASAN error 
by test code in commit comment, after applying the patch, the KASAN 
error won't happen anymore.


It was verified on my local setup, but the fix on 5.10/15 is fully 
different from original commit,  so in order to make sure it can be 
"clean" fixed, this need to author help to review if anything was missing.


Thanks,


Br,

Xiangyu

> greg k-h
>

