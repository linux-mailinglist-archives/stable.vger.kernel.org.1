Return-Path: <stable+bounces-93507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 773B69CDC4C
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 11:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E338EB258DF
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 10:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD29B18FC91;
	Fri, 15 Nov 2024 10:15:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5518D649
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665731; cv=fail; b=fXOX/B3f6MMblhYu3r0tzr5YGz+dFjByWP+q+/1T0Vb1SSMkidBayM515WsRwYZwXrT7Kp0PiHSqQ2gr9XRQbjHsxlwBG/crX9xvLpGoCmBrJNp09C2SZL8JTK/sFDRrPJm3/VppXOOjgjBmoUuLiu9iEqiAxlQt5tZS3cbUeW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665731; c=relaxed/simple;
	bh=g9yzwXTZsxH3CwKM8LvG+P/VSBDqVfP5J4DvYSyl/PU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DafxpHzIEjC+vGLQFRg8wA60AqTxE4VVgDSOoE8TTaZFko/RAOqGHhy6DyCQ+Pn78MDdZlcM2syHZKKeyvbgh2acdVhdhUyvx+K/W9QMMkDq6MhC7qL4s6KYIMgST8HAHMZQdNIVWfi+r9SiH7WjgH7MPPCqluZJErVb/MwQynA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF8xmED020622;
	Fri, 15 Nov 2024 02:15:12 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42uwpmmyty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 02:15:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AajZ06VyS8trTHekTjaMWGRm6JCCUfYiMckCpSDlqzGsaEVQFHXnlLA+BkUGIKvQDNiliHEPbDjSPjh/bEx35rfJoWbjGzUqmpd73qX3GFy339M5sJqzwdmX1orMq08mPMpdDO7nxt8C+C/QHbMF1UY7bMhzDgq/ijrrEY3/7sS7maIa3i1ljCzc1i+09ugLS7LUoNSGYZYip8jOjWvwIEEYKwGCqTLp6Ue+DnUlSitrelfsHiiSC2VYTyiDmiV1enevg6GmJHvF7jNRKHw0jJdKUgHHNFzCGXU14TVAIZjGBetbfstqBEAN8lGSY0QU2CPaPJYUYajsicuiz/zRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5uGcJ8vBmHg09hoSA+3+323PBsFKWzFz1dib1w2LWY=;
 b=l038c+R7nvgoW3GzXlcWp5vOkOZANtDem1P/Ctf+6iaiAmeFKIX2TS5dNBI61Jcw1k8NjOw/Ls1VA8jVT70h1M1BzwyRL1I7MLIy18CJqJGGQaV08I04/hJJwjj4XXZ2IKFRBLBvCZaPHEPxJqV2qQGGYRIHDr1z/sTclU+uKSBx2t6OFI+mYO6Ezg828ukkp/Yg+M4YOqIZODTLAPtnM8CQfNjg123o9wyxRnmu49eqTPx+tqxXxUlJ601UtD/VsP5fywxzlzVhc8edHvmleykz0i+dF3oDKmelpQ1EGMIUBdUgsBY4570O10ZP+XIiYNDzCPHInCsqkWLlycYVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from PH7PR11MB5820.namprd11.prod.outlook.com (2603:10b6:510:133::17)
 by DS0PR11MB8739.namprd11.prod.outlook.com (2603:10b6:8:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 10:15:09 +0000
Received: from PH7PR11MB5820.namprd11.prod.outlook.com
 ([fe80::582f:ef5b:81c2:236e]) by PH7PR11MB5820.namprd11.prod.outlook.com
 ([fe80::582f:ef5b:81c2:236e%3]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 10:15:09 +0000
Message-ID: <9af7dec8-df57-4f8c-8a8e-07f7b9eee318@eng.windriver.com>
Date: Fri, 15 Nov 2024 18:14:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6] cpufreq: amd-pstate: add check for cpufreq_cpu_get's
 return value
To: Anastasia Belova <abelova@astralinux.ru>, perry.yuan@amd.com,
        gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
References: <20241115083338.3469784-1-xiangyu.chen@eng.windriver.com>
 <20241115083338.3469784-2-xiangyu.chen@eng.windriver.com>
 <bfad2b5e-4d7b-4083-afc8-a40d25ed9917@astralinux.ru>
Content-Language: en-US
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
In-Reply-To: <bfad2b5e-4d7b-4083-afc8-a40d25ed9917@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To PH7PR11MB5820.namprd11.prod.outlook.com
 (2603:10b6:510:133::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5820:EE_|DS0PR11MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5b588a-d50e-4a21-aada-08dd055e6218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEUxUk1qQldYcUJqSU95WWo1QlN0S1FWRDN0Q0c5aksrMmZXbFBvWVJ6aW1P?=
 =?utf-8?B?UFhoUzVsSGRJaFhMZjh3TnZHci83cVBlTlhYM09tOXhkTmVFQU0rVUtxR011?=
 =?utf-8?B?YWJaalNsQXNZbm9PaHpGYklYQS9vZ2NwMFU4MDYvQWI3eHprZUZIQ1ZCczk0?=
 =?utf-8?B?VnZVRy9nV0c4VytwNnl2OFRYSVd2UXB0emw2dWlabmd6MXIxcHVya2FFYWpw?=
 =?utf-8?B?dmFlZ1ZocGZEMU5YRGpZWHA4bEpGdklaM1M0UjU1SEhxSUtMNTBhejdySTIw?=
 =?utf-8?B?azdPcUpxMnNqbnAyM0NBSDZCbDI4bXIwaTlrcU9kVENnbGNRUEUwNUlTdlJr?=
 =?utf-8?B?MzhQeVp0bnhQQUlVMzQrWDVZMWlrRlFVRmowaXMwZS8wQ0d6WnRMeGhWWjhu?=
 =?utf-8?B?S2VzS3NDT1hQMHY1Nmt6SUd2Y09BQVA1VHZVWnpuV0ttaFNUYmdGajRhc0xQ?=
 =?utf-8?B?aC8rQk9rdHc4dGU5dWZSSzlxd0kzbU55ZUZrcHBvNjZCVGtMN1hQYnpZU2pR?=
 =?utf-8?B?eUN0cGFmcmhLSmMySysySmZpUWd6Q0Rxd1BzMjBKdjhZVWlTZzdQVjJlWnpM?=
 =?utf-8?B?bWdSV2pMTXhHWWNqU2JERDNYT1EwS2pkTXVGVFBXQ0VaQUdqanZLMWNVRk5j?=
 =?utf-8?B?QUdpY0VHTGgwSkVGRnBXQWtpMXJXN20xVXFxVFBGNnNiZVYwUGZ0ZmZ2dTJD?=
 =?utf-8?B?WklzVGVjc1VGTEZZNnYxaXNQb1FCQnYvYXhWLzlya0xTMW9DMDQrQlgrcTBS?=
 =?utf-8?B?VllJb3dhMUpFNGF2YnZDeWI2aVpZS25EMTBybTRUTmQ5TDAwWklwd2dnRlVE?=
 =?utf-8?B?NzY3L1dDTW0vQTlXb1ZzVXVkNS9Ea2ZjRkxGcGZ0czd6emlEaTNuS1JLaWc5?=
 =?utf-8?B?T3FtZTBRRW15WGVxQldsQTdGWmNiQm1nZXpnbkx2TzdWNHdSSlRzaDBVK2Zr?=
 =?utf-8?B?UjVJTkVqdnY3MlRJL3dLVjdPbmJESVhuYUoyaGdLOVBaMXpwVzc2RTNySzBr?=
 =?utf-8?B?MnAzM01jSFJRREFWZ09hMFFhQTBqdXZvUUY2Q2drVW5FbE5mVW16RFJQbFlU?=
 =?utf-8?B?YzBKYzU0UlVRaDdjMmJKMFM5bkNqWGNIQlNnU1grR25RcnNHb0ZDZ3JRRnRs?=
 =?utf-8?B?MHIvcUVTTzk1TVZpZlMyczlwTC9zQ3BXTHIzbnNuUWVlSmUwcFhiaUcrTlht?=
 =?utf-8?B?T3p4RDBURHRVRE1kcW1nclpacEJ6UHVhazg0c016Ukw1WU9nLzQySWdsZENm?=
 =?utf-8?B?ZWJEUGRRYXdkR3JIMXRwQVlFTWF1QTNlYkFwMFpSY0huR09OdWhhMVY2MXB5?=
 =?utf-8?B?UkZMUzVUV0EvVVd0a05XU3BHeGlqTVZRVzdTVHYxdTFHWWVSRE9CSVZ3WGdP?=
 =?utf-8?B?MXcybTRkMGRyUmVlcWdJcTZvUzV2STMyaHRKbHpIY2tZTlpCcDVNRjJTc08z?=
 =?utf-8?B?K3FUczFWUW5nTEJxS25JWUdtWFg2SzV5UjJlTWxhSTFqWDk0dVBBK0NxWEc1?=
 =?utf-8?B?d1dWUTNoSWZleEQvWUpNWXJOaCtxemxZRFUreTM2NjhWb1RhVVRWd1N3Undq?=
 =?utf-8?B?RTgvd0ExR0t4VzREb2h0OWZLVXMwbkJkdmIwOXZDOGdIZUlnSjg3UUZPMmc2?=
 =?utf-8?B?NFhaRUNMb0xrWk4razBteVJPcm01aklGUnU1eDBuaFNaUUE2d2lRS3daYkpG?=
 =?utf-8?B?M0lIQzN6dzJRSnlZcDNZS1lnZzJmVUxpZzNOUkVpdHpqTnREN2VkNVpPRVBF?=
 =?utf-8?Q?zR02U7v0an9Iyn9YNocuLrQ48XBELsVQWYOmS2Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVJ0eDd0R3Iwc0F3SlFENVh4MkdmTDFaZUEwSWd1bUl5VmtuRjdtU21FYTZY?=
 =?utf-8?B?R05NRFUwejNVWFdhdGsvbXBmVlRmMk9vVFovb0ZReHk5MEM1UjNTbTJyc0hm?=
 =?utf-8?B?SVltd2Y1eHg2Mmx5eHliMVB1MnlkTlpHeUdwaGhQcU1maUhrL1F1NVhiT2x5?=
 =?utf-8?B?UFgyWmw5KzNwTjVzcHNVT2RPOExEcVhpMUY0a2kyVUpDTDY1UWlLV0p1MDBK?=
 =?utf-8?B?Sm1KWGVXV0RJOGtYN0pkV1puWmh6cVJCbDJwQ3VBVWFFT1kxN0xUNHhDQzJy?=
 =?utf-8?B?SGN0OXNIbk5aSlVBL1BxdDdEd1dQTC9CME9kWjBuV3EzU2U0UURoa0RWZWZ4?=
 =?utf-8?B?eTA1T1JRTms3VmxYTzdwR3JGSDltaXRGaFpGVkk3STRoTWJRajUyZGJacG1z?=
 =?utf-8?B?akp4QmhJeXBFNm9YUGp2V3l4aDRtOXhUbUx3R04xZ09aL2E1aGhFaUxWR1V6?=
 =?utf-8?B?Z29mYTgxSEo4YTMvZllOUFp0d3BOeFFrRG5CamdqUjZSelVIdmhnb29iMEVU?=
 =?utf-8?B?UG5hWUdibG1nL21XZmhadkdpNC9tbkFkWjdaL2t5OTMvblZKbFpSOHc4dEg1?=
 =?utf-8?B?dUFYNFNyWTBTaGZQQTN4WjdzWk9TSCtBNm9ZdVRLVmJtWmdhNmpiaXdSZDYz?=
 =?utf-8?B?Zlo2RzZGajdZWUkraXNrZG5VRWJoYUdwUUEvWG5KcHhJM2NESXNKWUd1cytP?=
 =?utf-8?B?bUt2NkNaaHlTZ2NSdUNvL2lIM1RhRFNhdWxkbWorSFZvWDN0SExpZ24vTEhK?=
 =?utf-8?B?dVk1Yk9rd2gxNEZKYUpPL2FoU2JnL2NtYlZ0U1ROR2FJTWpsemdkMGJRdWFO?=
 =?utf-8?B?ZlZIWjlKV0h1ZTIyR0wrbTY4UGc5QUEvOTBjMWcvZCtudURCTHVnMjU4N3pC?=
 =?utf-8?B?ZWZOKzV1elI2U0lSM3FvYzYrZUlPTmIrMVo1OHdYdGZxNUg2djBNNHdRb0lq?=
 =?utf-8?B?RkhNbXd5dDgvRXNvODIzdFNxQnNlYUhaUm1YRUVkcXRScXZUTkxBL2ZDMGhO?=
 =?utf-8?B?SEJrTGhJZWNsQVBuS2dJeVRBd0VrcEpUYmIwUUhQSUphTUFMYVUrYVFVYUxS?=
 =?utf-8?B?TG52aGdneGlpbGd3cFpHaEt1OGxmY0lWZlNxV3BzeVNQbXRmRnVEc0RuTjBw?=
 =?utf-8?B?RTFTS280VVpBNVZIVXF3a2FYS2R6TFpiQ1I2ZUhoTW1ka29lUkxuME1EOWFF?=
 =?utf-8?B?QWFFcjhLbTBmVjZKRVBjcTRZUnRtRCtXOFZBN0trenkxNnhyOEFVNFpMZDJE?=
 =?utf-8?B?UUN5NTZ4Zy8wUC9Rb29KWWprUTFWSkg2d2VBb1c0Y2szNWJLYW9tNjk1bDBp?=
 =?utf-8?B?cDAxTlRMRU5iaUtmd3JMeCs3N2QwNEhOMytOeXE4SU11NHczTXhyNnNiMGZy?=
 =?utf-8?B?MTc1MnZxN0gwZXhnL1ZSWnE3bzdNdkp1dVFQZHJzTDQwbUdpaGJIdU9wU3Nz?=
 =?utf-8?B?cmhGdkpON0doOGRSSFNQZG41WU8wVjhSaEM1am1iMSt5dTBoZEpJRHFzWHNm?=
 =?utf-8?B?eUgxNW1ZNTFRbEJ1S2NKQWIzZ0V0Rm1FSWNKNFVHVXMvS212WHFMcDE5SS90?=
 =?utf-8?B?dVVmK2d4RGFXUElLSlZWdnQ1aVByblIzT2gwald1MHN6NTVINFVLdWgwK2xI?=
 =?utf-8?B?VGRZbSswcjg3RjNFVSs0ZDRnVnJZdDdqVHZ2NjRKYzlob0FxdTZsN29BQmFm?=
 =?utf-8?B?dzhYM254aVgyOVhVUTdiMDQrVFVDWE96QlBmZXYvV2lCa3BwQkNab3E0MmNt?=
 =?utf-8?B?QUpXOWVoUW9DallQV3hzZ2E0QXM3R1hIUkFYbXVmTGVubTkwdjlSano0OFhu?=
 =?utf-8?B?TnU4U0JVWHhJSS9CL1l4cEN1SE1vMDdaRnlwWFZXR0ppT0pkeU5ERnp5bzcw?=
 =?utf-8?B?T2oydVJwS3VnYlozMmgxaXBQS1BjT3pkMytCM01zdjRHbVl4eEtndmszQk5z?=
 =?utf-8?B?bUpnbHF3YVM1R1RxTEJuVDduRG1nVzVpWGNKRlRubHNBdUtSY0dxSzNYM2k1?=
 =?utf-8?B?cDVwT3N4aUFURFgyajNxWlpFKzVGWGdVWEFWK3dqVFJ6RmNlUVJzdkg1SG0x?=
 =?utf-8?B?WjVWQWZRdDFrMEJjeTRSSFNIemprSjhEK0lkQ3RhRUlXemRCV2d6d0F0MTF6?=
 =?utf-8?B?R1ZRRklMNTE3bnJTY0wwcEV5M1pwb0tqaEVISTBENk9EdHdqL1FpWXBwSUpF?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5b588a-d50e-4a21-aada-08dd055e6218
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 10:15:09.0482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SG4NK88b1Ffe345GaEgiaMSyuRSlmIKexTTWEnNFjGmM38WiVXO6PPVuAR5Bg6DCmxxQ0pKii3K0gUNNQmE8F2baD+HjSc51kl/bE+X91CM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8739
X-Proofpoint-GUID: tv84PgnjdOXV9odonYRG2HJwzivQ6WIm
X-Authority-Analysis: v=2.4 cv=ZdlPNdVA c=1 sm=1 tr=0 ts=67371f2f cx=c_pps a=sGbpJkUcFVeWJOR+0qTsNQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10
 a=VwQbUJbxAAAA:8 a=KP9VF9y3AAAA:8 a=t7CeM3EgAAAA:8 a=HH5vDtPzAAAA:8 a=zd2uoN0lAAAA:8 a=KKAkSRfTAAAA:8 a=MTli-LMMVSAaV9yCzVkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=4w0yzETBtB_scsjRCo-X:22 a=FdTzh2GWekK77mhwV6Dw:22 a=QM_-zKB-Ew0MsOlNKMB5:22
 a=cvBusfyB2V15izCimMoJ:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: tv84PgnjdOXV9odonYRG2HJwzivQ6WIm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411150086

Hi,


Thanks for your info, I've solved the conflicts in a local commit and 
forgot to

update the commit author, thanks, and please ignore this patch.


Let's wait for the patch you sent to merge the stable branch :)


Thanks!


Br,

Xiangyu

On 11/15/24 17:16, Anastasia Belova wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
> Hi!
>
> If I'm not mistaken, the line From: should contain the name of the 
> original
> commit author. Also I’ve already sent same back-port [1].
> However, I didn’t get an answer yet.
>
> [1]
> https://lore.kernel.org/lkml/20241106182000.40167-2-abelova@astralinux.ru/ 
>
>
> Anastasia Belova
>
> 15.11.2024 11:33, Xiangyu Chen пишет:
>> From: Xiangyu Chen <xiangyu.chen@windriver.com>
>>
>> [ Upstream commit 5493f9714e4cdaf0ee7cec15899a231400cb1a9f ]
>>
>> cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
>> and return in case of error.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>> Reviewed-by: Perry Yuan <perry.yuan@amd.com>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> [Xiangyu:  Bp to fix CVE: CVE-2024-50009 resolved minor conflicts]
>> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index 8c16d67b98bf..0fc5495c935a 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -579,9 +579,14 @@ static void amd_pstate_adjust_perf(unsigned int 
>> cpu,
>>       unsigned long max_perf, min_perf, des_perf,
>>                     cap_perf, lowest_nonlinear_perf, max_freq;
>>       struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>> -     struct amd_cpudata *cpudata = policy->driver_data;
>> +     struct amd_cpudata *cpudata;
>>       unsigned int target_freq;
>>
>> +     if (!policy)
>> +             return;
>> +
>> +     cpudata = policy->driver_data;
>> +
>>       if (policy->min != cpudata->min_limit_freq || policy->max != 
>> cpudata->max_limit_freq)
>>               amd_pstate_update_min_max_limit(policy);
>>

