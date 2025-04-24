Return-Path: <stable+bounces-136515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B753A9A251
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7DD1885A69
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 06:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E401B0439;
	Thu, 24 Apr 2025 06:34:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8C19CCEA
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745476464; cv=fail; b=HDY7o3y1+9L50n2FNJ+HAZrmpFUw0Mecot+IskGdh88/xF3I0WLcRUH81o0bQXxhf4NGrOVGryNnJZQoJ4qW4fHbjPn8SVzYy/r1+hhPXEWvmcNOLuNIWRmODkXYOMFmcJhOA2UH6GdwRee384y2PZ+dHiFHZvycC0VlIu4Tfkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745476464; c=relaxed/simple;
	bh=lPUALcIDtL7ime+Svpj/0sMOuQNByAzCCRf+OjIxMwk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZJgfw9yBzHND9veST0G6W3HaoNE4J+rB9Jah4/05Sw5Fhw4eOW36osIx4rgY3Fsx9qAKC+qU+gMxBG2AFEWZLl2kHehZZJgD29cuoLxlT2NzgBjjKchScwLpSmfHTG4GlMUCLfU+XNBHNbMSQMRwjFYBS5ML7/6o5LQ5njIgQpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O5o2mp019978;
	Wed, 23 Apr 2025 23:34:07 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 466jhasuwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 23:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d58tswPEj2Pend42wzo2JJojh0SjQN2J54wvwFDxn4oZaNcTCSiSHopYb5i4sDYZpzry9tF7LZSEy5lbWhIlZyFnSDI/Hg4WQMqIB+bvrHsnz+ozJK9bih6Q8L1WL78/Fdyoi+IAVEixa9yzqhNLJmW6u4ezUikmm2JhkWQS49mcdRgP7e+XJOfEIKWekfajSedLGirTFc3LRJvOL9gO2jXPEgcjDo2OvAHaoR5+W3HmC81C9y1VMnCeqVZK4ll1doOBUgld8fbwYt5WMU7z8Qa/5k6DpCxbqHka2mLa0Sowzd3bBAzIqNNVu+DwAsGrFQGF8Lmvsx3u9d60A0IRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyYgay9oTdLJDk7cITZhB6g3Oov5r2wm+I/9Xhrzaug=;
 b=W+2On3KVwUv66I+nYDI/IShaJnKiO7XLhXUnmIu9W/SrvsMh0mA6ZvvDQiOLtb3is/4GiUl6glKT/+NiK1sdjPPwsBi4mXNBtcJZn1V7KTJ7x7ymrn+Z3kYDt3NWCwiGhRaM2ihv3xEx9Uf3gx+XKKpi8bgLc9K0lS9xB8LIaIzeJwkEmwl5zwDAZqUxLt2XqqZvaNHEFMvih4mNfANZ8KB9ZrFvxwHkuuCLZ9hhDJ8pIaffZLNpWoRUmMknT79R6zFr7bJ+tH/EMBiArA20crgj5v9RjoymgdEtFB6BK+kx3tqhSkWQwQECBmbJEZq7C8gnuBpA6XJzwgh1Dr8Q0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DM4PR11MB6550.namprd11.prod.outlook.com (2603:10b6:8:b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:34:02 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:34:02 +0000
Message-ID: <741b7850-9d5f-469d-971d-c2548481651f@eng.windriver.com>
Date: Thu, 24 Apr 2025 14:33:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y] perf: Fix perf_pending_task() UaF
To: Greg KH <gregkh@linuxfoundation.org>
Cc: peterz@infradead.org, elver@google.com, stable@vger.kernel.org,
        zhe.he@windriver.com
References: <20250408061044.3786102-1-xiangyu.chen@eng.windriver.com>
 <2025042351-glade-swimmable-97e2@gregkh>
Content-Language: en-US
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
In-Reply-To: <2025042351-glade-swimmable-97e2@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DM4PR11MB6550:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc6a68e-6919-49b9-9502-08dd82fa00bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b25OZXZMOG1tRHo5TnBhVTZKV3ZoQkhTSXJQYW8yS0psWi9EV0NrTFBidm5Y?=
 =?utf-8?B?QkVXUW1QSXBwaGl4TVhIQllzSTUvb2Fvb2RHLzcyZVVVNFRBRzk0bUJVSEw3?=
 =?utf-8?B?TjlNV2dKTlRUVUxFb3dGNnYvOVJrYlVvLzdLa1crbG05YnVENmUwQ21NTUtM?=
 =?utf-8?B?NGd1SUt3b2VXSWxCVnZGQW5vY2pWUUMwQ2NvUE9BL29Tem1jSUZwNGxLczhI?=
 =?utf-8?B?bE05elRWUDhxOWFEcXNOSXhBUGJPU2ZUWEkzWDU0NHhqcHBlS00rbUtia3VG?=
 =?utf-8?B?cWVjazcyYmdncldoNXIxckRhWjh0TXFRK1ZqRnlFSEVRcTd5YlR5ZzU3ZkRI?=
 =?utf-8?B?TXRCVEJubnJ1ZE9CbnE1UFR2NE9Rd1dzN29oZzNoek9rRWRpZmtsMmc5VGlQ?=
 =?utf-8?B?N0pDNEFrUjk2YkdXUUJ5aW8xUEJXTEFYTElRMXorM2FOWVRIQVVlV055L0Yr?=
 =?utf-8?B?K0k4ZEM4OWZ4a1BBbXdMaFgzdm01L0h6d0k2UTFXdTlySXBabHFhZklFTEJB?=
 =?utf-8?B?TCtiaTI0WXZMaysyRWlVZkpqUlRlZEppc3BBcktLTUlJVElrRXZ4bVRvQWxB?=
 =?utf-8?B?Yk9ERVdQYXI3eVJGYU1oSEp5ckh0QkxSbVJ1bmsxeGxZT3Q2VldSRG1iUTBu?=
 =?utf-8?B?UWNUMGY5OXh2RDFmVmhkQmkrVWtCcDJpVXJhSlp0NGphMnJUQmswVFdraGFv?=
 =?utf-8?B?MjZaSXZUQWQ2Q1A0aTB5NStiMGhJd1BKbXlyQmVISWhORzZvVkNaOXlkdWxV?=
 =?utf-8?B?UEgwVG5rWXhNaC9JdHJoTnR4YzlDTU1tVjBnaGlUaWJrQ3hSQ3RKeFRyQk5i?=
 =?utf-8?B?Y0hRdWFrRE9tdE1OOTZJYTh3OHdBK3N5S0NKbnFMcGJXTFNwOFFSSy9FZnZh?=
 =?utf-8?B?VkdFZ2dKc3pOWDc3bHl3MWRiYlJ6VngvSE5uRytUTzR6TGZZYXJuL0RsRjFu?=
 =?utf-8?B?d1NMNVZVM0x4M3RWc3owNXdpVjc0MXRMTjFCZXBVQ24xUjBkMWRFUkpNWURx?=
 =?utf-8?B?MWZGVFYvcC90a2RlZUR4eStVRUIvNDBMYUVhbmF6OFh3V210anZ2N1RCSE5G?=
 =?utf-8?B?NzBxcDZya2h4SytNRWlCMzE0ZUsxdmQxdndMdGNQVUM0djJmRERYSjNqbVF4?=
 =?utf-8?B?TUdMU2p3WjJJY3ZzZ0ZsK1VGMXJLT1JLN25WOTJWZkVRRnNNbjJGU2o2QzdC?=
 =?utf-8?B?ejZnTXBTRTZGWVJDK2Y1QUNsYTRNYjRqMUVTd0FkM2Y3dWMycStBYlN6R1B4?=
 =?utf-8?B?aUZxa0R2SDdFcVZHZFgxdGE4aTZYdmxPZ0MvZ3kxVHg5UEdwdXFuUUZOcDFz?=
 =?utf-8?B?VFUyMWx5U1Y0VWhOZkRvbmU4em1LVkV2bFF3UElqTmhOMmlrQ2hSeGpCTm4y?=
 =?utf-8?B?VDFuYjFNcDVERVdraWlnS3F0ZEY4K2FmMHZ0TVVFcFArMGhudzJldUJjWjlt?=
 =?utf-8?B?VFhvNThrWXNsOTZqbXp0Y2dJenhyNS9aN3BGaHgvcnZtL3d4bEhVcmJnSXds?=
 =?utf-8?B?OFN6Zng0VU9oQTByRVpqOWVXd2pnSThHT3M5bitOSllBQzlZeVN6enFmK25k?=
 =?utf-8?B?c2tXQjA1U2VLWGl2SUZYTktZbE02WXladE1tNW1kemRxT0IwMlMwTTVTdXlT?=
 =?utf-8?B?aFlmQnkwUVJneUMvT1pqaW42Tm1MWGtQbm1CVkI1enBiV2REVVZLWi9neElW?=
 =?utf-8?B?N2wyZmgvRk9LTWYwa2pEVUwrOUlaaVByRlB4MERvUHlyeGp2QTNiTWZGZGsw?=
 =?utf-8?B?NWtBbnJxN1dGSmJKM3VCSkZNSGpkNFBDTExHRzZkZGtpSWpXSURhZmdLSjBR?=
 =?utf-8?B?UHYxaXVUVXZUS1oyMFNVVXVEbGJJYW5VRHMvbWNpamhLN0lJVnRDb1Izd2M4?=
 =?utf-8?B?OENSRzA2T1locm9aZmZBNWJvYlVqMlRIOUZuekpWRmFwbXZmbnBSQ1pXR3NX?=
 =?utf-8?Q?eUZzZoE8/DY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWlkZW5SY3c3Zll5aUZvNU1FWHNCTldmZnFCc1Y1UmI0aEdiaWVvSmJldDJz?=
 =?utf-8?B?R0xjVHhKZEJtOVhpVUVPamc2Q1IyQVk2M3ZudFpxSkNvYlFMS2hJeDU3SnJu?=
 =?utf-8?B?dDYxMzJMQytkelptS0t4dkQ2eWFHMzVaY3ZwRWo0VWg2T25EL1RzVnBmYnhi?=
 =?utf-8?B?Ty9XbE5KQW9EWERBcHRPeTNBTjlHU1VQWjRWY3VjZVBwLzVqWHBoVlpueVA5?=
 =?utf-8?B?bkdvWkpZdG5pek1PV200ZkRDMGU5RVBFS3V4ci9LdSswV2t4d2lIR0FldVJt?=
 =?utf-8?B?QmxibFo1M0QwTWtLSDhCMjRqNG5wTjU2ZExnbEt4VG5oUU8xam9XaXBCSlph?=
 =?utf-8?B?ZmlyQU0rR0tzRklEOXlra3Q3UUdPamFzeTRRQ1Z1bzZKN2h1U3lUZnc3RE50?=
 =?utf-8?B?TmNRbTlmZWtnRHNNanJxaXQ1ZUJZQnNGQms5L0pCN2hraTczYzZNMUtmTTBp?=
 =?utf-8?B?YW1CQmhPVkxVTEl3MWdHUUhUZFdvNVB2a1hSYzBMRXNnNlZ5OWI0Y0sweDEx?=
 =?utf-8?B?T3Mxbnd0NVVVdENidFg0TllYNUhhR3NNWUpYVEtSQUpoWWtnSWk0QkdYdmM0?=
 =?utf-8?B?ekdLbVF4Q001QkhNTlJuUzdvRjc5emE2Nk00WkdjTEdJTm5DQmVub2w4aWxP?=
 =?utf-8?B?SysyT1NiZURUNUR4RjEyc0VFNHE0V2paRWIvUnNKRkhiektFSExJL0FUaUI2?=
 =?utf-8?B?QVAzK2VjMW53SmY2QWFKK0w3UmtWUGNPQUoxdm1vQzhXa2lwOTVsTU56QWdZ?=
 =?utf-8?B?VXExcExIMllCSU90M1kvUjRTbUhJTGlvS28vY05OQ294MHRSSUZ5ZGowMmlF?=
 =?utf-8?B?b0padGJmS1RTK21IZ3V0L0xnemdlV1dSSWlTbDFzT3VkUHNyOFhNT3g0ZG1P?=
 =?utf-8?B?TkZ0dTBmeWk5RmtkU3kySXFHZThndGhPM0NPOUs3Kzl5UFJ6TytzYklJTkNj?=
 =?utf-8?B?T3poK3lrSjJWZVZWNzUwcjU3U0VwQ3V5azdCbWh0UnE2b2JHVTRIcnlFbmt3?=
 =?utf-8?B?S3UvcEdYZzBGcklKdDVOWVgzRkFDaUNicVVyQUlydktUS2ppcFNaZEhYNkRS?=
 =?utf-8?B?blFzR0VoaURvTE1nMmk0bk1sL1NhU2NQVGc2M3U5SC9NVjc0MmhMbGduQjA5?=
 =?utf-8?B?TkNxc0Y0SjhWeHNsWlo0Q1Y4b3BSOUc1Z2wza1IwODROdXUyQXhXRmw5d1hP?=
 =?utf-8?B?LzdSRjAvaXlURVFNa09paG1CWFlxU1lzS1pWb0F6WWZ6ellJaUZiYjduU08x?=
 =?utf-8?B?QURjZHZ4USsvbnhVellnUmxxbG1ETG5XWnc4azNTN0kvbGh5WU1mSWRaUVIy?=
 =?utf-8?B?SlNhMnF3eloydFVka29TZkhpV2I5VzRUc0FYNjRaUm0rUHBQMkk3bG5zb2FD?=
 =?utf-8?B?amVWT0hmclVYRXRrSWRNY3VmKytua2duU1czd3U2Rml0WXZkaXJmSW5ZZkdV?=
 =?utf-8?B?V2VaMkc4WUJJZEY5U0tMVnlGcVliMHpCTGpWRDRkMGlVMzFKOGJqdmtkSHlC?=
 =?utf-8?B?RDZPdmhsczdZeXRkL3hYZmVuUDdMbkFhRVFOU2xRcFpiMVNmVDhpMTFQbkhQ?=
 =?utf-8?B?R2R2OElmV28wU0pBTVhOSzgreFF5TmlIa3lqRCt1MUFGZ2xzdThBazZhenow?=
 =?utf-8?B?M0tqK3I4RXUxeUdzak5JZjVyZFpCWXhRYkZGN3pwajZtMDZQOVlUeVRkWU1p?=
 =?utf-8?B?dGpMTUhhbmNnaUgwTWVZZ01nVFdLQUkvTzlXSURwZmgzSXlHZVBjV0lHM1hx?=
 =?utf-8?B?a1BYelpuQUxFT0VzeUNla1lzcnNySktuc1BPNUJVZDgxQm5RQVRrRVU1Q2lT?=
 =?utf-8?B?eEhnejNLSHcvZkcrWDlJelRLRHRQWk1QQklmWEkralRlN3lzY1RTKytTTEVk?=
 =?utf-8?B?R2JROFM3bWdacm83RktZQW1COW0rRm9rRGkzcy9tV1o1TU9XQzBnMm9CYVFv?=
 =?utf-8?B?eC9ScHN5SFl5MG5HN05GeGxBOWFhSDlqMnRQVzdwaUdxMUZMVG5vdWVETVdJ?=
 =?utf-8?B?WGpqcDRwN0pUYkZtdnJlTDI0enVsVW9EaENHdmEvZVdTbmhrWDVLY1BYZjNV?=
 =?utf-8?B?eWQ3a1VMMmJEOVQxRDZUWk5oMVZ4RzVYSWw0RGZsNTNyYmdKNHBWL3JhckdJ?=
 =?utf-8?B?WGVJREtWbTU5aHdNQ2hUV0tUWEhwRWhtSXN5UzhzVFJDZVNRYmxJSWV0S1p6?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc6a68e-6919-49b9-9502-08dd82fa00bc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:34:02.4004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6n6yzy8mxMChqW0Olw+YJUvJHrF9NeDMW3A2VO2x9tdGEnuRIeZiL4E3GL7bcDRDEU06hDKJedcZPGwgseb0UjG5shP/80nNNDlpb43Xsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6550
X-Proofpoint-GUID: yXl0aFSPAbakgxN-zFlyfD5M8M08274d
X-Proofpoint-ORIG-GUID: yXl0aFSPAbakgxN-zFlyfD5M8M08274d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA0MSBTYWx0ZWRfX+WhM8MY/vnft Pw9vGb9WghBVYwdeGq1InEP95PSuyFCYOKcmr8ZEs9IbBsuHsk2AKwjRYeqC6GbZRIFYYkM9caW 4lrgbsd48yvQDgyNbWRlXmt9iqpf63kdD4fBnWf8moyPN4V1gtBzqSwlLIhp61Skw2L5EJIWPx6
 081o9vgFJUf1pUvqFhHzxzsLyAaNWIWy3pnA4siud1vekgUYzupdYbSNTUrnRaLIOo6V0/d5WDK LZKldaxqDg7aYRs5ZkriLf9BlQafXlzPwDFqUNPGPZxqUu+qa4f/kplfZ09JWvYAdA9l8woVwx+ +9NEQV0Sm+ldABp0hMsiCvxdLP7/uEiawFUA1k0OCQ6mM47axYQmiwr/jRfxo1SIe+yTEiy2zYq
 8V0eQ6H/ETXLCVoT6ph6K3oa/2XOVwPmbceG4pOJQ2Yi1mjp64W7vOTwnmxDgVIwqxUSP3RU
X-Authority-Analysis: v=2.4 cv=Sa33duRu c=1 sm=1 tr=0 ts=6809db5e cx=c_pps a=Bc47kgIQ+uE7vzpOcRUeGA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=JfrnYn6hAAAA:8 a=hSkVLCK3AAAA:8 a=1XWaLZrsAAAA:8 a=t7CeM3EgAAAA:8 a=lT-utWL-DES3DCTn1ZAA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_02,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504240041

Hi Greg,


On 4/23/25 22:15, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Tue, Apr 08, 2025 at 02:10:44PM +0800, Xiangyu Chen wrote:
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> [ Upstream commit 517e6a301f34613bff24a8e35b5455884f2d83d8 ]
>>
>> Per syzbot it is possible for perf_pending_task() to run after the
>> event is free()'d. There are two related but distinct cases:
>>
>>   - the task_work was already queued before destroying the event;
>>   - destroying the event itself queues the task_work.
>>
>> The first cannot be solved using task_work_cancel() since
>> perf_release() itself might be called from a task_work (____fput),
>> which means the current->task_works list is already empty and
>> task_work_cancel() won't be able to find the perf_pending_task()
>> entry.
>>
>> The simplest alternative is extending the perf_event lifetime to cover
>> the task_work.
>>
>> The second is just silly, queueing a task_work while you know the
>> event is going away makes no sense and is easily avoided by
>> re-arranging how the event is marked STATE_DEAD and ensuring it goes
>> through STATE_OFF on the way down.
>>
>> Reported-by: syzbot+9228d6098455bb209ec8@syzkaller.appspotmail.com
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Tested-by: Marco Elver <elver@google.com>
>> [ Discard the changes in event_sched_out() due to 5.10 don't have the
>> commit: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
>> and commit: ca6c21327c6a ("perf: Fix missing SIGTRAPs") ]
>> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>> ---
>> Verified the build test.
> You missed all of the fix-up patches for this commit that happened after
> it, fixing memory leaks and the like.  So if we applied this, we would
> have more bugs added to the tree than fixed :(
>
> ALWAYS check for follow-on fixes.
>
> I'll go drop this.

Thanks for your info, I have checked the full log and there is another 
commit to fix current commit,

Please ignore this patch , I will try to backport the fixes to 5.10 and 
resend the review to list after local testing.

Thanks.


Br,

Xiangyu

>
> greg k-h

