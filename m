Return-Path: <stable+bounces-189206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4A7C04DFF
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 09:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907F7188121C
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 07:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930C02F7AA0;
	Fri, 24 Oct 2025 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pRJ0DTQl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w8eg4On3"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B12F1FC7;
	Fri, 24 Oct 2025 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292572; cv=fail; b=F1JZBJu4YdpSqzKKY67CPrpkcHYOu/W3TT27apx3nc/tD8cmX6hr0cDsQqc0IgSVc/4S9iNKT7QPCVuuvjWonjVJhrdseafhUrBA8kYamEWel0UViT0Pc4ZIzPlze59Bg21NThPlEpO6TGHS0gKGVClAeyJwWzjzpjCeOPs2Pe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292572; c=relaxed/simple;
	bh=anIGRVP8gfb6mgPudjQedJnDhB3Y02o9KWgRDgQZIgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XalHQac3E9VBGbSxlkov5BdtLYPISdMe7skUPlHRet47MdPy1q0BNIjdXA5R9ZExyiSkKVjG0TgzLDDr26oaPROaUt4VqPui22q4ONC0MbKB7ExUXQAOuPbBmZbq6LekLJ7TjrSPREqC0fSvRwHWKkCZdJeDKFBZN8OyJVK4D3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pRJ0DTQl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w8eg4On3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3OgOV002494;
	Fri, 24 Oct 2025 07:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FOOA9T16TAz1qFFfkZj8I+W8/dIrCG38L7cj4XjxX0M=; b=
	pRJ0DTQlLB7GFgZv62VVaaVODtDUcJiixc3DbfrGuPc1i2lRRPoF36HPTWjg9E9h
	sfaWaCiFRqOHy/20vr5NWM6NltHnOk/pS4vQLylqQWS0/Iec8PTNlAch2RB7UTjb
	Vstsl/zRI4r3eL4SBhUBEaJhpXRclRJ67pp7oWJQJ/MCSlmSCsxo7ZKzCnTwa8A2
	hsY7ejrZJGAW6N0gFp/IUIKTrcvG20op0pa3agKp2BfOd83lHYjV0W2euGSocuIE
	i+wvwNxlEbEUqiJj27ovCKEnIz7xu/oKjcCRAwwk/EVJh0UJjpwCwukhdZEuVEl3
	59qT6HQSLB5L4iZPkhizqw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv3kv3vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:55:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O7dUEk022260;
	Fri, 24 Oct 2025 07:55:46 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgmr60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:55:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKYV8bTX6YQ7UDEr7W8lKjZ9eR2TeCnYTDh5YENcPD7t4UDMXDId8gge/7Be0rh+u+8hqhZaWgXCdU38Rl0mOfjD2cru1FODieNQYn2S0tpWlFmtMH56zwEvUmgxk4ZKAXCFLvcvoc7IdvzeJH54gsM+sRN5mPeRfSh6uJbxHSAS9eNb5cuaVPpegLlrIlmSdzHMfTiHV8hjWfczwvMVfCoJH6aNGimG6D0hzkP5AWxd4m+se9k5rbxONNWX9oXubgmqnE9cD0vY6vhILmgJS03RiAUfclIlTGcvMuxPiCqEf1iS0p1vw6TYAsLvAejVtVXZmE01ccfMWeshDvuXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOOA9T16TAz1qFFfkZj8I+W8/dIrCG38L7cj4XjxX0M=;
 b=O02nPeERHdxFJP4xsuvNGQplk30QTE+SwNfM7fDhvjfVJUouoxtgmF9HsY8WCgOnww2h+laElFsB4oKXtKT+GUeEDB08iL0QRFb2LKPL71sdhCiwPk1xmsNLpbI7GR/nyJQmzsk5g9H3qJOWNyPf0RZ2P+4hw3q3+finC/7poxZzedLioHtGi1JBvBZ1hMpMuNrMgZVb219z6PfmDwmQlvUrBiC9SWt1vZNPVFcO9BO2wBfrP0qdk5R1pelaPK6UYLNhS8B+J1k3dMQI3b3CFbrGiaBAAk5ncnSidX1cSTjPbbz9NqeRtTlujNE80FxpMdFiXbHvT4P1Ton8KaIC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOOA9T16TAz1qFFfkZj8I+W8/dIrCG38L7cj4XjxX0M=;
 b=w8eg4On3zMsZzQLJrCsfhNI6Ui5VwXl+71EyjRt/nZxjBa7i2klUsVZQuOe15YH4bZ330UWYsv8L9+uIzBPoAD8BzleBvAYfdXQwH2pke/S3U/0JwlVWGC6b3/w0PLqJT7mp6OfFOVSrzhaNPteBf7oQ6bilvDokTdn8RsxUt6w=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS4PPFFE8543B68.namprd10.prod.outlook.com (2603:10b6:f:fc00::d5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Fri, 24 Oct
 2025 07:55:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:55:43 +0000
Date: Fri, 24 Oct 2025 16:55:29 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>,
        Alexander Potapenko <glider@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Feng Tang <feng.79.tang@gmail.com>, Christoph Lameter <cl@gentwo.org>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: ensure all metadata in slab object are
 word-aligned
Message-ID: <aPsw8QJfRyNWQGIc@hyeyoo>
References: <20251023131600.1103431-1-harry.yoo@oracle.com>
 <aPrLF0OUK651M4dk@hyeyoo>
 <CA+fCnZezoWn40BaS3cgmCeLwjT+5AndzcQLc=wH3BjMCu6_YCw@mail.gmail.com>
 <CA+fCnZdkWnRpp_eXUaRG_HM7HSDm4fLATpsqJhaxT_WGjhOHLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZdkWnRpp_eXUaRG_HM7HSDm4fLATpsqJhaxT_WGjhOHLg@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0203.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c3::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS4PPFFE8543B68:EE_
X-MS-Office365-Filtering-Correlation-Id: f6286c41-651d-4aaf-19c3-08de12d2bb46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnViOG5wUFBtQjRXNkJjRlE0ZXQ2SEtDUVh3TTlrZmsxVG4zdWtTelJobFBI?=
 =?utf-8?B?QURaRWNPT0lkNHhSWFJ4aWppRHVOUGM2a3ptclh4akxJaS9obXVYa1o1WGl4?=
 =?utf-8?B?WS80akhYaE1Gc2FkQ0tIVmVjbWVYeUIrNmg3WFRBUmxkN1pLbTd5d2x1RGdx?=
 =?utf-8?B?R0toSWpIdXpYcHZVRVQ0c2xJV2dRTGI0VmVkeU5SNlY5TG80eUd3QWxnN29a?=
 =?utf-8?B?cHdEUk5wNmQxSFFjWkdoenJ6c0FSekROWjRJWURGNGdjYXNQL1ovMm1IM1kw?=
 =?utf-8?B?SGhFL0w5a3NxZDVpeGE4ZHdvWHRPeGFzU0c0cW1mNk9JWXJhdkZaRm90TVEx?=
 =?utf-8?B?b3BvS0hjT2ViL2pBMUFBL2JHaTJ0SGw5UjI5VC95MWdGS0RjbG5IWVUraUpF?=
 =?utf-8?B?ZEdUNWpNQjEwRFdkTjNqQUVkQ0hlREc1VWZzSTZHNWRmMGoxdVplQnBEcUpx?=
 =?utf-8?B?STRET3ZlaUpmU2Q5dGFCYis2S2JKMUJJMGhwWWFmV0JoUDRISjB0OE1kNWtj?=
 =?utf-8?B?d0EvVGZnTGEyUjhlUzhHa0FQNFRPM0tPSzdRc2NGUjJ6cEpmNmROM0JIcUZk?=
 =?utf-8?B?SXN3cTNaQjVJRC9WUzFIMS9iblN5VU9QYy9Ic25kM2xrZjlJWHFmaC9yYS9u?=
 =?utf-8?B?TzdSMUZhMUd3RS9NOWZib01aVHlKa2pUM3I5WExZYlJuVkJiZFVyaGh6bzFp?=
 =?utf-8?B?QkR4b1NTZXJOVjlxeVdpLzYyS3A5ZXArRkV0S2YrdE9OSGZCQ3dtQ0FrQjA0?=
 =?utf-8?B?cHV5SVZieXZSNlVzZ1JOY09oaXN4U0IzbEhHcGlrQTU2SjNvWERsS2dvcEJP?=
 =?utf-8?B?MzZKeCsyd0lqclRQSy9WdG1KZnhRZ2JZWFNkSnc3T1VoaDdlZHBTeCtQbzZ0?=
 =?utf-8?B?bllJSW9RbEhRMEYwNjhqeERKUkUvM1Bka25CaktZa3VOZlFaYjBTajQ0cWl6?=
 =?utf-8?B?VzdUMzY2VS9xTTNyWC8rdmc1ZWpqT0NaUFNKT2hWTmlZZzBvOXlxbHRXa1Ev?=
 =?utf-8?B?VTM2eXRRTnFIb2Mvd0c4UkJmMUc0R21MWGVXblBmUmlxMUp2bzJuTythRnRo?=
 =?utf-8?B?YmZMU3VuNHZ1dUN4K2ExQ1RQY2hpWFN6TWJ3cXFXMUhoOERxTmhiazdibVF4?=
 =?utf-8?B?Y3B4MXd0eXlYVTFmZnhhckdWVkpBMFJWSXFSeGVZNG1TY09BZ0FTb2lZYlNJ?=
 =?utf-8?B?RE9lTE00NTRodHhFNXJKTk02a2RWN2hhZ0FtWGNhank4SHpFVUszYmVqOGsz?=
 =?utf-8?B?OVRyY1RjTmVWWEFyNWdMM3RWa04vVDk0L29IemM3RUhKMEJ1ZFROS0hzeFUy?=
 =?utf-8?B?NEpZQSttQ1FyQmdpNWhPUk4vV0tBOWo5NE8vQTJXaUpvdDZZUC9ZcktEZ1pN?=
 =?utf-8?B?eWlJc3ZKT284MDhIMHBwcFhrOThLU09SUWlwdWVpeU16ZWsrRTliZHZsVmdN?=
 =?utf-8?B?MGppcENMZDYrakxqSnR5NHRUUTVtVlVoMG9pMXlkaGRFb2x4Z0FvN2pyWmJu?=
 =?utf-8?B?Q0FqTGVsRUh2MERzandtYndNYTNQc1lzdGk3V095OSs0WlhZd1RNS0F5NHBL?=
 =?utf-8?B?UnBBTVNlOWswL3Bqdm44RW0vYUczVXFRN3BFQndURFZWZXFwNlJ2RU45ZkNq?=
 =?utf-8?B?SkdrRWI2MXFxOVR5TzFEU2R0M2tHeGtoQmNMUWVJQ0l2Rk8yRjlrV2txUXR3?=
 =?utf-8?B?TWVETU9PdmFQK093TkQ5MmZ6eHJFZThMcXFhaGk3SXZZQlZ0N3ZESGJ3djdB?=
 =?utf-8?B?R2NnT0tSQzBJM2pSMUp1NGtDc1UvTjk1djF0R0JCZ1B3SjFOcE9BM3dXSGty?=
 =?utf-8?B?MjduZnZ4SzZMVWdocUduVk5WUkJLQkxlN2VWRWZWN0hCNlk4VVlLWldpUjIx?=
 =?utf-8?B?RjlDZXVNT0JGdGlFaUFGbFBwNHdCc2tPcDhOMzlzY0NXRmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGEzc2ZCdVg0UkttWENVVVMyQzdMQmdIenlnOHp6Wm9mNXRBUFUrdkV5RDl5?=
 =?utf-8?B?MU1VQkwvaHoxSi93Y2k1eUkrbnYvY0pFVWRJVFhDSmMrb0x5WVJtY1J3eVk1?=
 =?utf-8?B?S2JobTZNMXRwWkJ2cDBNZk9RYTBKZGQ2RE53MFV6NUNOMzJldG10dys0NHJr?=
 =?utf-8?B?YzZWU2s4VWlKaHpRMTIxMTZSTFVYMklZa1ZCdWx6RVJNTS9uZFRSMTZwckIx?=
 =?utf-8?B?cVM5aTRoQmdrRkFvNFh5WTlCaDZlclB0L1RzekxqazFXZmFuRk9XOVZMbUN0?=
 =?utf-8?B?QUJVZnFwTjVrWWV0dnpXRjlGbkRqTkZybkl5eGtGRG45d2Zac1pSUUJySGp2?=
 =?utf-8?B?YzdpRVdnR2w5eFU1UTR1S0NsUE9CaDZzczFFYXFwTysvOEdMZWg2WXNtVGlV?=
 =?utf-8?B?b1lEaVJLTkRURDF0Vm9CLzBLTkNibkdIdHlLZUY5NkRIUEFzaUIvZy9WYW5V?=
 =?utf-8?B?WUxFcUhGdU5sbnRiRjFvalZMZGVwNkV6UWpaUGdMak40U0hHR2VRNjBHOGh1?=
 =?utf-8?B?blF1SzhqUEpkQ09iLzF3eHNWcmdhREpYSEFEN21JYWRLdW0xNCszVWpXL3k4?=
 =?utf-8?B?TGRORDRhQUw5NnI2NktRZk9BMEgwUDlCMXFibmNVV3BXMWNRS3RsVnNQaU5O?=
 =?utf-8?B?RUVmM2ozbzk0aVErUDlwaXQ2RzgyeXJyK2hEWHZ5aWtRYmtYdDdIMlhUU2VW?=
 =?utf-8?B?MWYrM2tSMUN3MmtMRnB5aERyNXc2VFF2bkNvSVNudit4aVVkclZKdTM2VWtE?=
 =?utf-8?B?b3VXR2s1bmJOQ1dsbTNVWVJuelQ4RTZSeUkwbG1FZkF5eDZxRGNSQkM3OTUx?=
 =?utf-8?B?ZERkdjhKNGpBaTF1c3NkWjJWakM1STNDNHQrZkM1VFJoekVOS3BwWDRNalBh?=
 =?utf-8?B?VnNqSFhpb2Y4TWFpSkxjZmUrc0dPT01XOUJEQmFGbnM5ZGlmRlhpRXlNMEZI?=
 =?utf-8?B?ZEtENG9uUVorR3RuM2owbm0wOHMxdTJ4em5rZE9CaG1vT2p3S01NVEtVSDdQ?=
 =?utf-8?B?RkNDUVJ6QmxRL0xGN0FZV25rek52MElKb2dnL1JWT3BNdUN1NitpbXlac1lH?=
 =?utf-8?B?d3doMHlwVElDSWM4cTR5VHFjUnoyS1R6SlVjWUhrK3l0Z2lIdUNWS3diNVp4?=
 =?utf-8?B?bkJHb2YxNTkxckVPS1VWOEQ5ZWZjZndKUXdBMTVpRVpUczUxUEN3bDI1S0xh?=
 =?utf-8?B?MVpUKzJFaXB1Q0hyMzdjZ1hRenZJWFkrdFZrN1BUT3p2aUV0bkl6MmJWWllq?=
 =?utf-8?B?Mm55NmRTdm9xT1F3TWo2eDAzSmUxRGR4dk5WaG5KT294SGx0R0N1czJYb2s1?=
 =?utf-8?B?WlVzbFZuUDl5UWRxYjJzOE5sWnNGUkdJc2FIUWp0NVJaZXVXdklSeDJBU3Ey?=
 =?utf-8?B?a3R4ZGlqcVQ1NHVsZC9TNWd6T2VxZnVzNFJ4YjNXaDJnQmx2SDBjUmVxWVV4?=
 =?utf-8?B?Q3NDdXlKcm45VnpUaE5wQkVwTlptaFR2QWFZZDAxeG9kd251aEVNc1lTRzJx?=
 =?utf-8?B?cVczNU83ZXIwWkluaFRZS056b295eitWbmF0K1VLelBhakJBblF3dFAxd0ph?=
 =?utf-8?B?ODlYVnlSZjE4SEN2YkZDZzRneFB6bUNuclFORk1kcTVUdlp0WXBHOFJtV2pp?=
 =?utf-8?B?aStWQVJkVktHR0hKbitmQURsREUxQjQrVVExSWRrZDJEYnFsbEZ1WEw4Q1JB?=
 =?utf-8?B?UG9BWG1XRlJhcHlVa0EzU216T2lSWVh3dHB2cng2UDNveG5yamFLUExvWXFG?=
 =?utf-8?B?QTBRUTc0MkNIV2JPTVZiN09OYk1iOXNiaDQzSEVoU2hpelFwN3hIajhsRmhu?=
 =?utf-8?B?dXpxemRrSEZLeUcrUjN3TXlEbGZtQnRNbHdBN3dIbkJJc1pEVTVsNlluckgz?=
 =?utf-8?B?SmtoNXlOTWgxNTR5alFmdDdoQ3h3Z2pMM3JRK2RwTDcyUUgwM2Z4NG5aMEVI?=
 =?utf-8?B?b0hmaWM1MEgxaCtMMVRRSExGendBZjA3bzVHOTFmQ2JKVjk2REdxTFZubFlJ?=
 =?utf-8?B?eTloeWdOcENCWnJiQkU5MGtNY3ZNUjY4T0lYYWh0cHFWUWVDaVZaaDNKZ0dT?=
 =?utf-8?B?YzhRM2w0V0ljWGhuUTlpVGY4ZmQ4cDliRStrb1p3eDVVK1FreExpTTY3eDU4?=
 =?utf-8?Q?qtVE1K5H4eml5MFO9y5D1WSF9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9EYaG2vH1V040DZMlN9WMdebVGpiTtsBFodLb3WLW7oIUEykatft5c3Km+YUMNY7PFmsxumDsocRQhTQNsVLEveYAfRNJZk15f/lRcW7s4xFt/bxnNp5GOrLkfGfFTqybwPv4x19+O0d2UWfTyKEYvarSMq8fjfIklpfrKAyhj2DpkZRb7Lu3ydEqOnVEcGExPG1yaMzJ+oVWydX5zW1QRhlaB1Mg0aIEg/JyXZjJ+wL/JRsTPEEq9hF9O/8mYoQQAOwP1klt54UtQE7j5QhRmdQaF8qGHv9oAKGqgS1fvRF7D1GmVrZBJhAH0WhGMkncoLvpRdavTGCqI9XU7Oe8hVM0PgJ+PUxfXStPtBqQuMguMrkGBWFrySe8F99e+9SvmYEkBiS8BYQWNjMkTumMFO34qjxNl0Y833CbHcL3+XSADZZFUD9JvbGL73fvthK2gHQAE3QNvGTFrwN3asFnS+Bgb+APA/hXzwuDuRTMfoRNNZpumiRhRz7uW6uFuTb1ZAupBtYFDKSXK3sRrVjCKKXYUd/PhpiyO8WSX2oQ8HQ7Mn5ui+qDPPGuXHuTOsbyXbX63gPx+PCuUT1MEmbL1iQRMGa0NiBANGXugb0tXQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6286c41-651d-4aaf-19c3-08de12d2bb46
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:55:43.0748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9eyVB9mRViQYmzTaIkzqrA1E5f68odSL+lp0Rw97qe1esP1NBc6a2DPls4CCIW8WNfA27wmB98snwgG6aerOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFE8543B68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=979
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240068
X-Authority-Analysis: v=2.4 cv=acVsXBot c=1 sm=1 tr=0 ts=68fb3103 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=phoBJEqNIwkefCOIV2EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13624
X-Proofpoint-ORIG-GUID: D_ZQ6ZL4sc5kWTkUVUnGixtkZTTcP0Qv
X-Proofpoint-GUID: D_ZQ6ZL4sc5kWTkUVUnGixtkZTTcP0Qv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfX6gCJwXhoGVLP
 XXHUQ8N3RhK2KBQbboQAtXDWpQptnfz9TVmI3Fq7OWOkp9QXbxJJOFYpRCmJbJN8sN1Eq5OiF66
 GtzPmSgVY00E6kO2uNq1MwniGW0KaV88DhqR5nqo3WuT/b190dER/QKzX6twK6uAEj4tPZe0Zqr
 rOD16dw3HoasBQhAetKyPOHj3SKC/qUISvXpmo4G9INbIjpTsJ3oMeEDo186eMHnxBIMP3t1Ams
 Gm/YpssZwi0Nz5bbpTswym9v1jdrWetiXVxuW4HWvxSdakPnePIu++DOj3PKdurFN78vmjyeZiE
 3FGTPjKkqtv2NJ5XfKcvHkQ49FSOuGzlaDgExe0+wah4qKK859hcKjauqCKYLe2VZUqkdPgswqS
 9MEwdGfm1kaiC7/vcDz6sWEE4aJ2Ga9YMeTQNTNDQ9YVV/BIKh0=

On Fri, Oct 24, 2025 at 03:56:29AM +0200, Andrey Konovalov wrote:
> On Fri, Oct 24, 2025 at 3:19 AM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> >
> > On Fri, Oct 24, 2025 at 2:41 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> > >
> > > Adding more details on how I discovered this and why I care:
> > >
> > > I was developing a feature that uses unused bytes in s->size as the
> > > slabobj_ext metadata. Unlike other metadata where slab disables KASAN
> > > when accessing it, this should be unpoisoned to avoid adding complexity
> > > and overhead when accessing it.
> >
> > Generally, unpoisoining parts of slabs that should not be accessed by
> > non-slab code is undesirable - this would prevent KASAN from detecting
> > OOB accesses into that memory.
> >
> > An alternative to unpoisoning or disabling KASAN could be to add
> > helper functions annotated with __no_sanitize_address that do the
> > required accesses. And make them inlined when KASAN is disabled to
> > avoid the performance hit.
> >
> > On a side note, you might also need to check whether SW_TAGS KASAN and
> > KMSAN would be unhappy with your changes:
> >
> > - When we do kasan_disable_current() or metadata_access_enable(), we
> > also do kasan_reset_tag();
> > - In metadata_access_enable(), we disable KMSAN as well.
> >
> > > This warning is from kasan_unpoison():
> > >         if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
> > >                 return;
> > >
> > > on x86_64, the address passed to kasan_{poison,unpoison}() should be at
> > > least aligned with 8 bytes.
> > >
> > > After manual investigation it turns out when the SLAB_STORE_USER flag is
> > > specified, any metadata after the original kmalloc request size is
> > > misaligned.
> > >
> > > Questions:
> > > - Could it cause any issues other than the one described above?
> > > - Does KASAN even support architectures that have issues with unaligned
> > >   accesses?
> >
> > Unaligned accesses are handled just fine. It's just that the start of
> > any unpoisoned/accessible memory region must be aligned to 8 (or 16
> > for SW_TAGS) bytes due to how KASAN encodes shadow memory values.
> 
> Misread your question: my response was about whether unaligned
> accesses are instrumented/checked correctly on architectures that do
> support them.

Haha, I was a bit confused while reading the reply, turns out we were
talking about different things.

And yes, I was asking about the case where the architecture doesn't
support it.

> For architectures that do not: there might indeed be an issue.
> Though there's KASAN support for xtensa and I suppose it works
> (does xtensa support unaligned accesses?).

Looks like 64-bit architectures without HAVE_EFFICIENT_UNALIGNED_ACCESS
are assumed to require 64 bit accesses to be 64 bit aligned [1]?

[1] https://lore.kernel.org/all/20201214112629.3cf6f240@gandalf.local.home

But yeah, the combination of

(architectures that do not support unaligned accesses) x
(enabling KASAN) x
(enabling slab_debug=U)

should be pretty rare... ;)

> > > - How come we haven't seen any issues regarding this so far? :/
> >
> > As you pointed out, we don't unpoison the memory that stores KASAN
> > metadata and instead just disable KASAN error reporting. This is done
> > deliberately to allow KASAN catching accesses into that memory that
> > happen outside of the slab/KASAN code.

-- 
Cheers,
Harry / Hyeonggon

