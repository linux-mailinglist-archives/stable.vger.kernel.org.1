Return-Path: <stable+bounces-93927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E769D2096
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CA5FB2103E
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 07:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CD014EC5B;
	Tue, 19 Nov 2024 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JLdPG2xa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ACI5zZh1"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D951E35280
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732000220; cv=fail; b=LYPU1MExlrNSWSv1gC4T+VG/e6PQEPGlMjA4gFS/kY2ZWyYANbq4yx0z5BSKdFchCArlAilpwsOEoGcIcFOGkBKkOUC0grOFO/zDr7seG4oTXmEPqQK9HkYtNB9gnTExCQ8UysZhF11vzfv/G2693X+etnMQcgTJBLTVZZlu8x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732000220; c=relaxed/simple;
	bh=AWEoZdhesZD1fyIliFAPQq9ZJAWH5l+OoNj8a9bOU/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iYItOmS+jv1HDkQGBZPJy67zJ5H/VT6vsEA9Nzz+Uht3RThzTmWeK/6bANOovpq0IEgXK2Hu5lXK+CnN/T2yiN/FYbYApiR8QkbNrPmt1ReFUsbjLf901BH4WExbYLac+7IkDCf6A0d2UK0Pu/XbJ2plIa0qpq5svyqtcSEI/rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JLdPG2xa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ACI5zZh1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ6BfYs018803;
	Tue, 19 Nov 2024 07:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bLv8iW15qhhNVZUetXEOvHNQJwkOuEZBRu2A8/J6zi0=; b=
	JLdPG2xaDGw/Tcd7g1kRSbcomNztpcFpaP+eVkfak4Y3NhHLQoBiWb/yR+I277ev
	S4nemPnx1uJI2RcfkZVeVfP1kD49h/QFLEnsYWw1DcDqmouPMBMdbnVB/4o73CXY
	5D74e5z2sjrh3bKHljdsS+SyJrv637eBWKm450H4qAyOq1++a4/p8wWwTXwy4lXM
	3X4q5nIEliSO/YwhIFVy+2AnWqOdD8R3NH0Em8N1KvUS6bmALyl1p8Af420o+i1R
	+qT5BkHpCVUPWgXRxxN9rYA6rQMeC9vfhA56X4Y/DG6wh/4sf9MmwJT3ZawUturJ
	yoRz1xhDwRIBA+qVGo/f5Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0sm9p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 07:10:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ6P8Ca008913;
	Tue, 19 Nov 2024 07:10:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8bkat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 07:10:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D29csQqmz3quIbf3H6CRBYwpmGWlCLIb1O4WDIkGjnIcK3B/oZhq+AoqqK9ttZBmUZTb8pDxJzId5q007kxMED5sDojAG8tCbUoah4IPbIpIUJpiuTeiePFLWVJFr5GPVAsuwSHifPjrb4GPpCAE/ob77UIAmUt+RbbdqpDNNCLvIWXMhDKZMjlcRikiSwz/mVbGp/CpGpzQwyFBI7aW1d85M8I3/wUqpXpHvUwr8paFZP6MfQS96HYQ+wI33fAdltugc31kas7Qk7NirJawwwY/+oJoA4fzlH5xpQ7pEMx+BwUdpm6a9LE6y6f9ZTWQNgMid3lvFiofp4b9L2Eiog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLv8iW15qhhNVZUetXEOvHNQJwkOuEZBRu2A8/J6zi0=;
 b=LL0rry+aDZLo90tVQEoG+JOGzF214SZmZWsbGAu8nqK6/ppevWkMZ6shvx/J6ay6YvAiz0J0y0LFFQI57DCWJ2/YaU5IpKZ9e3AJqFk6CgZYBj0+xNFM2ptcf4Hj/qDBt0MHW9H4GVtQM+bYD7mlbdFRfvLRTCnC3gfdhe3LzvMTdt13BUaa+/5FOB3kzUBV6g8QvfHtTSNMEarUxzpj9yToiHLaL+O7/72GfQ7mS/S+KNTpjKbFNGu7LsPsC4rfcWytbXGmwCvbaRC727wh/h/Xa78FahGANCO149aLvi9tmKd7S6x9SYLr5NQ3QQK9b+NXFD/hklLFEWGxsx9+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLv8iW15qhhNVZUetXEOvHNQJwkOuEZBRu2A8/J6zi0=;
 b=ACI5zZh1B+gz4Xh0HrCvUlQXWxcFDPxv7uNFQKsfPNBW/twuAy6NMv3Qs7t8BbZbFQ8KXUENLnfTyVT5BhJUEhgUxGDltTaqUD2YZGY7dEjeMmz+pm77gckClLnfdYUZQM++sl620khgVPBJ0kirs7gvi5EZ+yeNIpkZ1toTWOE=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by SA2PR10MB4650.namprd10.prod.outlook.com (2603:10b6:806:f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 19 Nov
 2024 07:10:11 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%5]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 07:10:10 +0000
Message-ID: <360e3143-28ed-46e4-8064-12aa03aaccf1@oracle.com>
Date: Tue, 19 Nov 2024 12:40:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y v2 3/4] mm: refactor arch_calc_vm_flag_bits() and
 arm64 MTE handling
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <fb0aeea7eb024efb92c512a873f40aa6ab27898a.1731946386.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <fb0aeea7eb024efb92c512a873f40aa6ab27898a.1731946386.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|SA2PR10MB4650:EE_
X-MS-Office365-Filtering-Correlation-Id: d349e2bb-d800-41c8-0d14-08dd086934a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Znhhb1FEVWxiWW81Z09IQU5yb2g4bHJJMmVDTUZuUEVQRUJKMXZDS2kyT1E4?=
 =?utf-8?B?Z21IYURQM0RvUTVSVGMwT1JUOUo1enN2V1RBTG9nNEhvTXVjSW4rYmlyQzhU?=
 =?utf-8?B?WTlzRytKQnZSd2Z4L3BPaU9heWUvNHNlVVhnYVoyL2ZWUEdFSk5NMXhHRmYv?=
 =?utf-8?B?cUY0SVp0dzM0bVdtNTk5ZldLbzFvVU0xRXJhN3JTL0Njalh6T2RoaVJLdHNs?=
 =?utf-8?B?UE9aSGNtNGlGaXNtN3ZpTkdPRDJBTG5ZQkVVRk5PVFhHRFhWNGdvYXU4T0pX?=
 =?utf-8?B?MEVjSTVLWHVJN1BReHFQYjVoNS9HMGU2emtpdEtTMkhWL09UbmZ4UlNEVTE1?=
 =?utf-8?B?czlTaHF2ditsWW5EVXJpRmFCM2t1djltTms2dHRXbE00VS9qK1lrOUI3a2Np?=
 =?utf-8?B?Z3pxM3gwVjExV2hjZnRHeWtmSERoTUlJeXVNMFVzR3paSjFuWlRyNnA3eS9x?=
 =?utf-8?B?cDdqS04zelZIZXZhQzkyejJzUDV1TzQxSENLcDNtVkdTVVRQN0lkTW1QRUw3?=
 =?utf-8?B?b0o3QkVtL2NqTkMxb2NhVm9EMjJ2QWhpZFJudlpRK3VyYjF3Y3BpRWNpN1Mx?=
 =?utf-8?B?b1RZems3aFVKd29qNEg1UENiRlRKK1picEUrVmpyNTV2Tlpib0x4NTJaZVdC?=
 =?utf-8?B?bXdOZGlXMWpnU2JhL0cvblhLSTd4bnpuWURVODJuakxHNWg3SEErVnJrbGli?=
 =?utf-8?B?dlBrYU10L3VHT0JZTlhJbGpDQVVMdGxjbll1TDNVSHFFU3IrMXVIamdaOWZ6?=
 =?utf-8?B?Z0pvZEFkR2ZhOFp4WFdxM3FLU0dvNExZc0RnZmxvck5weXlKUnhZbXVOb0Ra?=
 =?utf-8?B?aEVyUTQvMENrYjJJTUdRcDVEWU9kb0lPWHE1dXhVUXd6RWIvTUtXU2xtRGty?=
 =?utf-8?B?dVJuVlA0dHdOUS9DOTRPbVpCN0pQS3NVU2tOZ0lMbzFZZ0lJeXg3dE03RGZq?=
 =?utf-8?B?WnR3MWpGcXNNS01EYVZwR2ZlNCs5bWY3aEJIeXZpaFJDNmxTMmFtS1lVRjlw?=
 =?utf-8?B?UVhtQnAyUTZxK0V1aVNyZFprbGZnZ2dCbkRmRE02cU5ldkV4aWpXVkxRRjI0?=
 =?utf-8?B?SE54c255SGNzMHBqVjAzRWRIN2t2U1pnSGxsdHBsdldHeGpaN3ZVejJOUlRI?=
 =?utf-8?B?djhvazQyakVycnc2K1dyOHgwb24zVDUvdkZoVXkvbVpIdkR2QkZncnFZR2h2?=
 =?utf-8?B?Yzk2QWdqZ09oTTRNZE1KQmlqdFU5cXpCaFIrRjd5WUJGVEZVSlVNMjlJL2hI?=
 =?utf-8?B?VGtKcFcwWnlqOTRrbk1DaW0zWlNoWXJXeC93bG0zMVlydmpmNUJvZldxZFND?=
 =?utf-8?B?ZnlnWlp4S1M1ajhNUVFZbnhqUUdDZ1htZlZQL0sxZEpOYXI1Wm05ZHQ0UzFy?=
 =?utf-8?B?VElNZmxIK1RYVnlmNmRjc1U5NlNwZWtiNWhzenJZcEJTc3d6bFhPUThDaHY3?=
 =?utf-8?B?WXpXaTJMeHlTKzdSenNVci92L2FJNURNbzJhallXbVVKNVRwLzJSQUNxRk55?=
 =?utf-8?B?MDNCeEF4Zyt4Z0xxWU5id1QwOXBteXVFdHZIZ1NHenA4TGtZTExiTnhxTWxw?=
 =?utf-8?B?L3A3WG54RWVvbUQyM1RMQURlWlMvMzI1WjBMMmdqbmRjQndtMmxIMExQYS9Z?=
 =?utf-8?B?TUtZbkxad3lWUWlBRFl3OU5lRzc1cVgvSlFOOU9oTGx4RWhSM0VBcWpJSXo1?=
 =?utf-8?B?R0lEZUhOWUNQdERsRGV4MFNRUzd2OEV1emhXaTUxVUVTdzRYUG9UazNFajl1?=
 =?utf-8?Q?cNfGujtzvULFiPLGEsz27/NTLPI498ZhnTG5g9N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTZFVi9WOE5reWhmVVVyczBBeWhjN0tkTTNGdDkyK0NubUFTNDd0bXpHVnkx?=
 =?utf-8?B?WFdINWJQYTV6WTBOZWlhc3VVcksxdHA2K0UrVGdJNitkZjBtb2RLNFNydUlh?=
 =?utf-8?B?Sk5vRCtDcDVXV0U0d0lhMVp5cmFSUW1RUTBaTXRLaGdCU0J3dzEwMHBpNjNy?=
 =?utf-8?B?TmhmVGNCQnRXcitjK2N5VjdkbDVaWjNVVnRJTENKZzhuOHVESW9WK3FFaFcr?=
 =?utf-8?B?dUd1S3VUR2M2M3l6ZjBLaTdoL0wvOGhDcklOTHpEWGVXODlQSEhxWFpOWG9Z?=
 =?utf-8?B?MmRhUXFvTEp1L01HcktaRzRMTm9nbWhhR3NNejBCdE1IRXBBMFVXYVZ2b05m?=
 =?utf-8?B?OEhMbmx4WW5QbXg2QzNQWjlzMVk4M0lCUTg0MWtObEsyZVFVcERJM2EvRllh?=
 =?utf-8?B?WWZmNU5xcGRONkcycnlSQ1ZNUjUrWitDeG5zOHFVRWJFblBGNld3bWYzSThP?=
 =?utf-8?B?VjBRZmRKWTJGMzdMUW1MeVR2eHlvTVZHSGdaejI3eFlNdkRPQ2tpTmhBMG8z?=
 =?utf-8?B?b3gzSHhhSkhvMVNGZ2EzV0VyTHlrNmNySjFUNFlpQnlUampkQXZ6YktISXJZ?=
 =?utf-8?B?L1NMNTRldUxJRURBNkdNMldVaVpjRWJaYm9DcE1EbXArWWN4QWRGa0hkbmZk?=
 =?utf-8?B?OEJmVDFLWjMvT0Jodm50VXJRdXcrNk0wckZtUGZLWXRRRFRMQldoWTJTL2FP?=
 =?utf-8?B?UXZuS05PbzNrTytIYVJGaTBJWHBnKzVxZmxYK3pPNFRHQlY0MFl2dUNNcHJT?=
 =?utf-8?B?RHBBbUd0Tk94R3FVUEJBQzJMVjJWQmdyNHV4dnZob2hlWU1rTjFQdWxaUzlC?=
 =?utf-8?B?YzEreVQ3VGo2Mjk5V0JXS3B6WjhjamN5OU5sMkNYQUp5cmUvdVk4aWVhbzht?=
 =?utf-8?B?R3JpSy96V1JXZzViQ1RuWjBHRzlQK2h2QVhCMEcvNDhzNFdRNytGU3hVOUNR?=
 =?utf-8?B?MEVnOUJtTVdQZmlsbnI4ZnE0bzQrWS9nQ1pmeUVaSmt6VG5tV1BnRWwwc2xq?=
 =?utf-8?B?MThmOXFZM3EzTXBtbWpJZzhQcnFvd0xJbDcrNW4wUy9iNDNVSDRhcGNTV3B1?=
 =?utf-8?B?aXA2WkVKSkVOdXFzMCtNRkdYSy9BUHdMNnh1RmpoVVVXamd3MGdjd2xieExs?=
 =?utf-8?B?Y3d3dlNXeGhuRUFMTWxjYzIveGFVWnFMRzJsYVNSdEdDU21DZzNSbDh5c05o?=
 =?utf-8?B?enB2THdPUFlaL1hBQnhhN2wxbStYZnhzcnozaDhzbHJrcVI0cVpqYzM5enk1?=
 =?utf-8?B?NnMwZG1uQVEwSzZvdFd0dis2eHBBTisyR2lBSTNCREZnY3J0MnhqMHlZR2Ra?=
 =?utf-8?B?ZlM1M0MxTDdLM2JheW1YV3Qya0JTSlFaSEYwNk1wQnBLZ05lQkJ0dGx4SGtC?=
 =?utf-8?B?M1BBUC9NZUVxQ3ZvWGlwNDlJK05SR2lQYUIwK3MxbU5rbXhHUHI2dzl3Njdn?=
 =?utf-8?B?eSt6WUprdGFuQzdWQUQwajlFTlNIVHZmSCtiaEJ0Mzl5dk8zV3NrUWx4Q1p2?=
 =?utf-8?B?UUZlcm1CODdqRDhXRWlBYVRPYWUweHR0WnVTdlRtcXJnQXBjOEsvY1piRGcx?=
 =?utf-8?B?RE5uRUdobWhTVFNYaHMxZDJhT2J1N3NNVVRtdng2aE1rUTBLRktCKytBWTlV?=
 =?utf-8?B?WXVRMnFmZjJWa1BWZGNid3ZyWGdjdXZyTmM5SXR1dndZeTl0TENxaEZRMHNu?=
 =?utf-8?B?akRWOXNFS3lSNHZDdUQrbkduR2F0anV5UnB1aG5rdjNIN1ArYUV2YUpTekxu?=
 =?utf-8?B?SmhVWUlCTjJKeHI2UDVVOHhDMWNKektydFdPeVgwamNhZzg3bkhEMlJGZE9u?=
 =?utf-8?B?V3hnYnIzSUlpMFg2aXRZdnNmZEZJcGFuQTVSUk01Y0I1b2kvRy80Zjl4T0gr?=
 =?utf-8?B?a2wyRmxoazVmYXpsMXRlVWxKYk9SWWVERE5KakJ1OXdDUnlhaFp1YUp6NXl2?=
 =?utf-8?B?MlR6SjhGWVdBcSsvZnBNS3N0ZVdMcEFYTWJmQjNSajFxWlI0dE82VmI2Ylpu?=
 =?utf-8?B?U1dWM0ErRmMvTHl2T3pjVHBvc1RzT01JaE9MTGpjWkh6c28wYXpOT0hpVWNh?=
 =?utf-8?B?WUZNYWxPc0UyV2xCL01iSVBKWENvWEFHbkRVVi91eVF0UUMxVlVuL1g3dDdz?=
 =?utf-8?B?YVdKSDJYRU95MnlJa29tSklTalBxeHNlOFY2OFJPUjg2RFlRdzVuY1dxUUp4?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XwFbKW3t0h3wBIR3ZxaDLUJtbWGBUHOx5ceRG/5PXudePlmyjPmqIpP2iE80kiUwsJx4OXJd3NK1f5GMn8G1j8UwFiYVOK2GxCuaV77y2Wl6WihWdUITd430K2+RhHnvH0TvBx/qdrJiJR8lWEnOAHISeNhmQW2OlalImo5yjc50jW80UF6do+wsizN7V59gBWbcvMbExMdyKbt8JcbS774ISZMhL9kp8OJNu5nAVcfpX2204u139UhYVvIJ1nDTXrRyK1N6JjDCmk5eMy363lADQCUrHU7xLWb4WBhhOUJZXuhL+FJKIqgj/rIo67goFh0MK0TWb7zdOcEkOSOrglOavDNcNR+Bcpbt3eIJK62PDITcc9nGtTUQnFcKusuP3FIWrPVxFhpRTqpq5pcyroeCqfgZ9V5Sjq0owBOYUpHPUQtENw53ZILzDDeRLos6ZLTgL1Y4P/ZC68Vh5SuMAn07IgsXyaP3MzNrBoeUnMduCBpiWVY+HlT2lqC49MCZ/epQUV/1N6fCZN7PtFV4q/WUQqQs8HZwI0ZlPawvyWS16yY2K3BHw4U6iiTFOOVJ6AIIECuvupBBKfMegH0we7jthg/8AXqegs6ikHe0Fck=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d349e2bb-d800-41c8-0d14-08dd086934a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 07:10:10.7719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jT65ErrpyzTWF9Y+Dy/pcEBWjFp/OLcGOOPpW9b6XjG3MH4EEOAZ8ioSARK7qz1RB2AlkcJrWqC8MpWZt6tYQXeB7HKbfi8SbHdohJ8sEPexSNxdu7sN5C5HU51R5vdh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190052
X-Proofpoint-ORIG-GUID: TaIW9WfiKLfPFA1yQ7clGrSCXObHDy_N
X-Proofpoint-GUID: TaIW9WfiKLfPFA1yQ7clGrSCXObHDy_N

Hi Sasha,

On 19/11/24 10:06, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> The upstream commit SHA1 provided is correct: 5baf8b037debf4ec60108ccfeccb8636d1dbad81
> 

Nice bot!

Just few thoughts:

> Commit in newer trees:
> 
> |-----------------|----------------------------------------------|
> | 6.11.y          |  Present (different SHA1: 9f5efc1137ba)      |
> | 6.6.y           |  Not found                                   |
> | 6.1.y           |  Not found                                   |
> |-----------------|----------------------------------------------|
> 


Given that this patch is for 6.1.y, it(6.1.y) need not be considered as 
newer tree I think ?

Also the backport for 6.6.y is present on lore.stable [1], so the 
backport not being present in stable-6.6.y might be not very useful, as 
it is possible for people to send the backport to multiple trees in the 
same stable update cycle(before 6.6.y has the backport included) -- 
instead could we run this while queuing up(maybe warn if it is neither 
present in stable-queue-6.6 nor in stable-6.6.y ?) ?


[1] 
https://lore.kernel.org/all/7c0218d03fd2119025d8cbc1b814639cf09314e0.1731672733.git.lorenzo.stoakes@oracle.com/

Thanks,
Harshit

> Note: The patch differs from the upstream commit:
> ---
> --- -	2024-11-18 17:15:02.588328592 -0500
> +++ /tmp/tmp.LhvhUpwE7J	2024-11-18 17:15:02.577003940 -0500
> @@ -50,29 +50,29 @@
>   Cc: Will Deacon <will@kernel.org>
>   Cc: <stable@vger.kernel.org>
>   Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> +Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>   ---
> - arch/arm64/include/asm/mman.h  | 10 +++++++---
> - arch/parisc/include/asm/mman.h |  5 +++--
> - include/linux/mman.h           |  7 ++++---
> - mm/mmap.c                      |  2 +-
> - mm/nommu.c                     |  2 +-
> - mm/shmem.c                     |  3 ---
> - 6 files changed, 16 insertions(+), 13 deletions(-)
> + arch/arm64/include/asm/mman.h | 10 +++++++---
> + include/linux/mman.h          |  7 ++++---
> + mm/mmap.c                     |  2 +-
> + mm/nommu.c                    |  2 +-
> + mm/shmem.c                    |  3 ---
> + 5 files changed, 13 insertions(+), 11 deletions(-)
>   
>   diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> -index 9e39217b4afbb..798d965760d43 100644
> +index 5966ee4a6154..ef35c52aabd6 100644
>   --- a/arch/arm64/include/asm/mman.h
>   +++ b/arch/arm64/include/asm/mman.h
> -@@ -6,6 +6,8 @@
> +@@ -3,6 +3,8 @@
> + #define __ASM_MMAN_H__
>    
> - #ifndef BUILD_VDSO
>    #include <linux/compiler.h>
>   +#include <linux/fs.h>
>   +#include <linux/shmem_fs.h>
>    #include <linux/types.h>
> + #include <uapi/asm/mman.h>
>    
> - static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> -@@ -31,19 +33,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> +@@ -21,19 +23,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>    }
>    #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
>    
> @@ -97,37 +97,8 @@
>    
>    static inline bool arch_validate_prot(unsigned long prot,
>    	unsigned long addr __always_unused)
> -diff --git a/arch/parisc/include/asm/mman.h b/arch/parisc/include/asm/mman.h
> -index 89b6beeda0b86..663f587dc7896 100644
> ---- a/arch/parisc/include/asm/mman.h
> -+++ b/arch/parisc/include/asm/mman.h
> -@@ -2,6 +2,7 @@
> - #ifndef __ASM_MMAN_H__
> - #define __ASM_MMAN_H__
> -
> -+#include <linux/fs.h>
> - #include <uapi/asm/mman.h>
> -
> - /* PARISC cannot allow mdwe as it needs writable stacks */
> -@@ -11,7 +12,7 @@ static inline bool arch_memory_deny_write_exec_supported(void)
> - }
> - #define arch_memory_deny_write_exec_supported arch_memory_deny_write_exec_supported
> -
> --static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
> -+static inline unsigned long arch_calc_vm_flag_bits(struct file *file, unsigned long flags)
> - {
> - 	/*
> - 	 * The stack on parisc grows upwards, so if userspace requests memory
> -@@ -23,6 +24,6 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
> -
> - 	return 0;
> - }
> --#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
> -+#define arch_calc_vm_flag_bits(file, flags) arch_calc_vm_flag_bits(file, flags)
> -
> - #endif /* __ASM_MMAN_H__ */
>   diff --git a/include/linux/mman.h b/include/linux/mman.h
> -index 8ddca62d6460b..a842783ffa62b 100644
> +index 58b3abd457a3..21ea08b919d9 100644
>   --- a/include/linux/mman.h
>   +++ b/include/linux/mman.h
>   @@ -2,6 +2,7 @@
> @@ -138,7 +109,7 @@
>    #include <linux/mm.h>
>    #include <linux/percpu_counter.h>
>    
> -@@ -94,7 +95,7 @@ static inline void vm_unacct_memory(long pages)
> +@@ -90,7 +91,7 @@ static inline void vm_unacct_memory(long pages)
>    #endif
>    
>    #ifndef arch_calc_vm_flag_bits
> @@ -147,7 +118,7 @@
>    #endif
>    
>    #ifndef arch_validate_prot
> -@@ -151,13 +152,13 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
> +@@ -147,12 +148,12 @@ calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
>     * Combine the mmap "flags" argument into "vm_flags" used internally.
>     */
>    static inline unsigned long
> @@ -157,49 +128,51 @@
>    	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
>    	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
>    	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
> - 	       _calc_vm_trans(flags, MAP_STACK,	     VM_NOHUGEPAGE) |
>   -	       arch_calc_vm_flag_bits(flags);
>   +	       arch_calc_vm_flag_bits(file, flags);
>    }
>    
>    unsigned long vm_commit_limit(void);
>   diff --git a/mm/mmap.c b/mm/mmap.c
> -index ab71d4c3464cd..aee5fa08ae5d1 100644
> +index 4bfec4df51c2..322677f61d30 100644
>   --- a/mm/mmap.c
>   +++ b/mm/mmap.c
> -@@ -344,7 +344,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> +@@ -1316,7 +1316,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>    	 * to. we assume access permissions have been handled by the open
>    	 * of the memory object, so we don't do any here.
>    	 */
> --	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
> -+	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(file, flags) |
> +-	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
> ++	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(file, flags) |
>    			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
>    
> - 	/* Obtain the address to map to. we verify (or select) it and ensure
> + 	if (flags & MAP_LOCKED)
>   diff --git a/mm/nommu.c b/mm/nommu.c
> -index 635d028d647b3..e9b5f527ab5b4 100644
> +index e0428fa57526..859ba6bdeb9c 100644
>   --- a/mm/nommu.c
>   +++ b/mm/nommu.c
> -@@ -842,7 +842,7 @@ static unsigned long determine_vm_flags(struct file *file,
> +@@ -903,7 +903,7 @@ static unsigned long determine_vm_flags(struct file *file,
>    {
>    	unsigned long vm_flags;
>    
>   -	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(flags);
>   +	vm_flags = calc_vm_prot_bits(prot, 0) | calc_vm_flag_bits(file, flags);
> + 	/* vm_flags |= mm->def_flags; */
>    
> - 	if (!file) {
> - 		/*
> + 	if (!(capabilities & NOMMU_MAP_DIRECT)) {
>   diff --git a/mm/shmem.c b/mm/shmem.c
> -index 4ba1d00fabdaa..e87f5d6799a7b 100644
> +index 0e1fbc53717d..d1a33f66cc7f 100644
>   --- a/mm/shmem.c
>   +++ b/mm/shmem.c
> -@@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
> +@@ -2308,9 +2308,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>    	if (ret)
>    		return ret;
>    
>   -	/* arm64 - allow memory tagging on RAM-based files */
> --	vm_flags_set(vma, VM_MTE_ALLOWED);
> +-	vma->vm_flags |= VM_MTE_ALLOWED;
>   -
>    	file_accessed(file);
> - 	/* This is anonymous shared memory if it is unlinked at the time of mmap */
> - 	if (inode->i_nlink)
> + 	vma->vm_ops = &shmem_vm_ops;
> + 	return 0;
> +--
> +2.47.0
> +
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.1.y        |  Success    |  Success   |
> 


