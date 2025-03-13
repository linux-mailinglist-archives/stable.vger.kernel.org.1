Return-Path: <stable+bounces-124353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 952B4A6019B
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA703BF12F
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 19:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29AC1F3BB3;
	Thu, 13 Mar 2025 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ugWmxNpk";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="eObs6KGf"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB41DDC3B;
	Thu, 13 Mar 2025 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895530; cv=fail; b=cjuduAdQ7akWxG5LQgBwgO34muCtG2Rijt5NBtwspt8HkBf/dRpn02pJLDc/GNu429vA3CB4ugPUZ//mUdwT9Hnshd3e0NpmjRFbYSo0fObDa5FnVtDVI/L8hQ5qaHacC8b6s0kNfoLvRCGuwlW3QU6snc6D2FQJEzGj+MyaJTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895530; c=relaxed/simple;
	bh=aGaOd07dkRbmT1iy8NV2P4ob+R5n6kpOwdInFNHajm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bSksC8zLXHs/kkFJ3JMbOQV/cEPjYy3uxRW4qoDfbj3udl9hBzwKaSfiyActT2EblBIf5/dgxO96Qh5GNhRa60SZHOwcnTEEIz8YwAEHMD4NaAcQdE8l3+/kD3AIx0lc5Ux+llmeAY0uB8J3cM2294JTuvOnPNJQiQU4T6E6B6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ugWmxNpk; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=eObs6KGf; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DEwHs6009317;
	Thu, 13 Mar 2025 12:38:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=aGaOd07dkRbmT1iy8NV2P4ob+R5n6kpOwdInFNHaj
	m0=; b=ugWmxNpkNkkxoG6RJMn9Zql1h7uC6AAgViVnlGglkubLDR+P1fp9Xi8w+
	wFisz+CAK3lWqJDdURGr4hXyxu+cTKa+Wj/x+6VOJCNRFUozd79ep9I/94BX7r7q
	pfnojLY3gPCD8vR5c3iAOUUY846AdFuci+QvVnHvPY76ix9xYLsUOBeIsTdtlNgm
	tpfwB+nBl2382A7CD4f0GZih5/ts2mX0GD3QY9cQ+fH2g1o9sqrRM3i/jbu1UkVA
	m7Y14NsXW1y+g7v9y87lV93DqP7EpIKs784XiBZQ/iSe3na6iGNglJnSWy0x0XOW
	U63LBhDdqA9nIkao0FhM8K1MNrGOw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011027.outbound.protection.outlook.com [40.93.12.27])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 45au9gp74f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 12:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrGSkAPpbgAcUkvvhYBW5jfo3imPe03W5YwEjxm8Vm51yi6+0/RRSqNS9Hp7WzMIPCuJk9tAKy+NVa/d81kphSbbCM0jEEtSBgwZp9NZ6eO6ZJjETJy2/M+tBldfLcVIM3nzZ/AOsb/YHwbcOWDu/eyaRJwoltPD4EyKnfDtoAJM0ZCu/5FU+8qqkfcBuc5wPvgKaCO9xC++dr3g/Sn6i7vrfH0MKuL3aqpaLu4FRrZNMih1eIJPteU6X22HGUhRgsYQfNFxxBxaqdwBGUgFIMJ4bmmwI+9b5ZsL+1ZJivjJDEfKjzucvFlt2iIr/sdZPsRKBSwGaLVP+DMNgcGeSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGaOd07dkRbmT1iy8NV2P4ob+R5n6kpOwdInFNHajm0=;
 b=ITR0ZTeWu2ryLhsmvR7zuriebHYHVK6SJp0whL+R+illQx2OYUDp/kq/d7K8uXwFm8gb5g5UA1aSYtJgAK7N5PMyuZMZdySAPUHZn0t2nQz8iI4U9ksNTE00FY43uw9NzFC3sSkmfy60a93qjwXQpJpnjTVDBrxT4ap9Y1nL7IMdrx+NmuSa+nOfvGEsBssphZp1ZcqsV4KCYUaJ8sHhUhuJVbMtE4Idt4Za6L+224A3PFTzsFwNOTEIv+8q3wmF4rGWxOrNkz+AtCLNLvIWqt5tq6Clo6q09/EvaV0ihuPBeJJNBb7V68lOjALS6fJlbY32GJyw7u8URqoVCxH0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGaOd07dkRbmT1iy8NV2P4ob+R5n6kpOwdInFNHajm0=;
 b=eObs6KGfsJ6N2KZP6fLFOO1l0/8KsSOIenVeIIjnQJoxYl6tuIft98QRFw9s0na92Siblf8LFGOBZqlsy2qDXNuW76TN9QSw8m4aLPiDLJzGZwRZ/uIse4AWVIb0E5HC2Lh/EtvAn4MaehFFh2Wnc4r8hDXuM6twos6VIDO3kU6c27L3nBCuu6PNX779NQOYB71ndzXpNp9zE41DxAhxNOt2TIG22jGrONCuzl9BwcH4imxxb9S8nkpGjmaFc0cZTJwTvAmCf9pQlXKjN2FUdyKtzFSnUHaIkf22s/01jSooNjjm0m/TYU0X21mQocbFLk78G1ggny5P4r7JyoPKgw==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by CO1PR02MB8491.namprd02.prod.outlook.com (2603:10b6:303:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 19:38:40 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 19:38:40 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Juri Lelli <juri.lelli@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann
	<dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider
	<vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] sched/deadline: Fix race in push_dl_task
Thread-Topic: [PATCH] sched/deadline: Fix race in push_dl_task
Thread-Index: AQHbj6GHm67dhCATrkil96yyudrYd7NvRueAgACX3YCAATetgIAAaUmA
Date: Thu, 13 Mar 2025 19:38:40 +0000
Message-ID: <59E10428-6359-4E0A-BBB2-C98DF01F79BA@nutanix.com>
References: <20250307204255.60640-1-harshit@nutanix.com>
 <Z9FXC7NMaGxJ6ai6@jlelli-thinkpadt14gen4.remote.csb>
 <8B627F86-EF5F-4EA2-96F4-E47B0B3CAD38@nutanix.com>
 <Z9Lb496DoMcu9hk_@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <Z9Lb496DoMcu9hk_@jlelli-thinkpadt14gen4.remote.csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB8861:EE_|CO1PR02MB8491:EE_
x-ms-office365-filtering-correlation-id: 740dd832-95bb-4f30-9128-08dd6266a812
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUZSUjYxWVY1eVV2WFRpYUowNkx2WTczTjg5TEViK2x4cUJvOWg0T2FkWmEw?=
 =?utf-8?B?QWV1eGI0NXkvRnErNDRIcFY4Q2ZXVHNhYXNhNTRHZ3c5bmZBUnZzdXhaQTNN?=
 =?utf-8?B?d056VXFaVHVCS3FCZGt3cGNYa1lxRHBLdzJQSXVjQlBLaG5LTzVrOWUrNUJz?=
 =?utf-8?B?SXV4bXoxN1dwNDBBMlROckRtSUZyc01LNlBQdXk2UUs1UUVQR3dPVWVZWnk2?=
 =?utf-8?B?RVVmbExBOG14WUdTSHpEV2NGMkRoQUlGVlBva1V5L2FPRGdpRnBocVpaNVFR?=
 =?utf-8?B?VForZnVvWW42Sk1iekVWeVNwVE1sTlkxamhmaE1mQlJaa3FhcjJuNmdyb2pY?=
 =?utf-8?B?L2QrVUJRL283S2RycmEwakhMWkFjYnVsaENmc3dtY3p2TTdSSGZYTk44Q1Ju?=
 =?utf-8?B?NHlxcFpUL0dPcDFqSnRSM3pQbXVKZ1JZdlFHN3hubjZVcmhMbVZrSlREeW1X?=
 =?utf-8?B?RDZjd0p3MERnbHFYWjhkc1pOWU1wbEhiL3JybWdnSXRoK0pXMENoWi9DbG03?=
 =?utf-8?B?OGROSjB2czRaUFNuTjRscTh5M3RJZTlRYVFDRU9jTGxCMW1ud0p5NTEvSllW?=
 =?utf-8?B?UldWeEQ0QVphUnBpK0tRYTdQMVc3eUJaWlNDNTZRemdDOWhSdDNpMHQ4ZHIr?=
 =?utf-8?B?SXpSNENBcnpSeFpDVzRNUk9ublBjaXpIeXJpbHBGazZGMTRURjZwVFJJUTZX?=
 =?utf-8?B?S3NFSGcyQWtha296WkY0eUlBdDYxejdWdlQwVEpmdnUweXUyeEpvWkpQSS9B?=
 =?utf-8?B?V3ZMb2JpOUo3eGJNTmkwQXR1WGVMZmZhSXZGRHM3S09mVzg4SkVEb2NsSExG?=
 =?utf-8?B?ZlJNd1BmQ1d4MndQM0hDSkpGL0w1MmhGdVlmWElwalVlT0dDS3lXeG1xZGtp?=
 =?utf-8?B?a094dGpmbmtES2dPZXczUFF6OFc3QVJSbmRiYndDQ09IT0dwWVBGWktBMFJi?=
 =?utf-8?B?UG16RnFBUENUYTZBMVM3cnNHSlRYYnhvNUNGajBkdE5mbnNxRWRESUZwN0Qy?=
 =?utf-8?B?L0pveU8vSjdSbEJaZGxYK2REbVNFZkoraC9USmVvbmNjOXkxR1BYdWcrVGEv?=
 =?utf-8?B?T2o1U3ZVcnZLVUJpMjNxaDcydC9mRWxKbTBqTjNNSjIyYjVHcUN6bWptY2NC?=
 =?utf-8?B?MjZlUmtHU05oUmxoQ3MwVk90U3pwMk9lbk5CWVpnOGZqdmhrZXcvdjVoYUFs?=
 =?utf-8?B?ZlVkdWpnTTl4YndsOTZUa0RERnFVNEJjWHNZZFlTQi96OW5vYy9HbVdBckZL?=
 =?utf-8?B?eHNCQ1RHREZuVTNYK0JsbktOWGJqeWpqbUFiNG93L0RQVzNMU2FMc2FaMkI1?=
 =?utf-8?B?YVVYK21FQlh4Qmh6SS9GeDIyZGwrZ3grQlhkUWY3VnNOS3h5ZG00c2pObVRo?=
 =?utf-8?B?MFFaSTNwMnJDNnZSVVhyL2hNL1JlVlRLcFgrYUFzQ25lYUhOelBwYXRMVHRp?=
 =?utf-8?B?cUhFeU5hOFN3K2JPYndLUGg5L3U2MFg5bC9iSmpvMG1SMVZPSm5oaTlsMkxZ?=
 =?utf-8?B?bFJKS20wcFZuUGZUbDVrQ2g4UWtlRnA1Ulh3TWtLWXhSeE1OZjdPTGhSbG85?=
 =?utf-8?B?RFEvejZMZnN4SStVZHJ6UmVzcTNzWjAvTG1nUHNISG5HckJEUURxYWkvZzlp?=
 =?utf-8?B?Z2FUOUtNTWF4QnBXbUp3T2JZd3VCeTJwWTEwaWlGUXRmMFhqaGZIOSs5cEZV?=
 =?utf-8?B?VFZOQ3E5NkYrRXE0ZHI0dzFjZVpWSGs0VWxadmVoMkdhYW8vNXU0cU9vSU9G?=
 =?utf-8?B?Y0p4SkpDQUtnRWl5bHRKdDJUUG51S2xFNjNEcUYvVjhwNXo1a1VMVXAzNHhU?=
 =?utf-8?B?TmdhRnhoVWhCTW5jRG5pVVYxYVNnZUNUc1JQaWpkaHU4Smk0K09XTzdOTHlh?=
 =?utf-8?B?TVRlK2VjR0M3Q1pUVytOYVBuM29hRzAvWmpkZGZRd1ZHbEJ4SlJFcStJejVR?=
 =?utf-8?Q?/y+TNnIfI2a0oHDczYutU1M9kHKkc9Cb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVh3RzU4VDlQbldLN0lKdmlCMWVzYnR2WWFZRkZjeWNQc1RCWGhNUWtlRDJ6?=
 =?utf-8?B?cHR3eEFDYmRWdTZVSXhLUTRneWJaSHlMTEF3OEY4TzEzQjlXa0s3aEVzSnll?=
 =?utf-8?B?WHVHQzNpSTAzRW1qRlFQcUw5dVA0andBNm0rUHlhMGE0ZDA1ZEZ1dVhpYnFV?=
 =?utf-8?B?YVFTT1JBMW03TUFDRTlnd2dBT040bXlCekRKNXdZaGU0Ukg0RlNZRlo5R0lx?=
 =?utf-8?B?Tkt3VTB5THRmdWRiRk56K1ltVXBGRTM1MEVFOUROV2JlWnRPUy95UGxkaWxH?=
 =?utf-8?B?SzZzb1B5Y2tUTDZMQlRtOGRHckR5STJRRytQR2VrdkdxZjI1ejdUMVVYMEox?=
 =?utf-8?B?UGdJZ2trd3ZhN0oxK0pkZW1GdGxxTVc5OUQvME9CYnFVck0rb3lESlExdzJM?=
 =?utf-8?B?TkpnZmxSQnZsOGd6QXlGcVNoNXQ3OWxKQlVLMFExbkdyNlNrZzRLVTRnN0NT?=
 =?utf-8?B?YXhjSk4xOE1GblNoWWp0bmhqckhmN09XdUdtNEY0MVpqcXc4em1vUENMYnB0?=
 =?utf-8?B?cnArTlJ3Y1YzOVd3U2JWWDM5aWJoM1dhSFR1dWQ2LytJN2RvdGhzbEVyQTJ5?=
 =?utf-8?B?cFlzMGppcFZ6aWFlNWl1djZtSlkyNmo2Y3gxUGIzcERpUjk1RTZSWWRkYzNt?=
 =?utf-8?B?akt2Z3A1eDZMcytlU001RUR5RmUvMC9idmRMck9ZblNMTk1BQ3JqbzJ6TFNk?=
 =?utf-8?B?NlE1eFNNV2d1MGN6OUpnMlNFOVpIa2w1ekgwb2FabWhDYmNibklteVptWVRn?=
 =?utf-8?B?dkx2RkNDKzNCRWYwSysrczJaTlkwaTFDUmJuTHJmVjhPeXVHN2k1QXJhcHVW?=
 =?utf-8?B?RGZVS2UzWElJTjYxdFBmTnZTMjZoZzYycFRJNGdmWi85UnBwa0xuYTFjN2tk?=
 =?utf-8?B?UFpidWlkWEFOUWNHKzBsOXhkb29sOW1wb0dNUGovZzBHVEowYmJ2TWFUSStU?=
 =?utf-8?B?Y25nY2hYNlFhbzRwSnE5eXZqSEtqQkxDQlJUUlE3MVRGVzBVYXk3bnFQZytX?=
 =?utf-8?B?eWNKS2RWVk5rL1ZKbUpuUUFCWHZRWEpxS1VlcTgwSjUyc1FnOUxvZlNjTnlR?=
 =?utf-8?B?cUsreFBUQ1ZoSVZVZm5DbXhzbUN5OTVkYk5iSEVIY25MV25XRkZ1WTlET0hh?=
 =?utf-8?B?NzhMMzlaMC9BSHpyMDFINEh6R3Brb3JOYzFaS2pYdkJLY2tTcERlclR1SmhJ?=
 =?utf-8?B?bkVySVVkUG85N3lPREVCZ0lwbEtHOE1xak1KZUlTeWRmNjV4Umc5K08vVkNi?=
 =?utf-8?B?aHk2eUlsYndpeTNGUVhyM3VwbzZQcFduN2tLQWRqQ25udFZERUNGM05IQ2NZ?=
 =?utf-8?B?L0pOLzZzcHhKTlZwVHJqMEk4L09SeFRsemhHeFVOa2ZNbGw3N1BGemV5NDk2?=
 =?utf-8?B?UUxmWllERURBazN3Q2h2eHgrV094UnNxbXc0V1dBM3drZ1dQY0ZCMzcwN3NX?=
 =?utf-8?B?V3ZsMkM1R0NaMzlsNjZSYW1qSlZTcUJ2UWRnREYwelhtTlM2MlNUbEJGbmsy?=
 =?utf-8?B?OUIxRTZQclY3QzFKcWdTNWJZZlkxRWdtSkhmUndIdFJYZlVsOTVUTitFTlI3?=
 =?utf-8?B?ZkgvYkQwUzdOL1pQUkhBYUFMVEZ2TS9zRk9LbnczN1lHaDRpUzc1WlZ0NW54?=
 =?utf-8?B?b1dIZkJNRmI5Y29Cb3dXdk5GMXpzRVkrQVZNSE5EQUdTUFJLRFE1aHlVa1FH?=
 =?utf-8?B?SGFiQWJjYXE0M0VPYUNvcnhWU3lYcFN6WCtsREJ6U3JBQ0RvQk5oUkI0NkxP?=
 =?utf-8?B?ekM0WVB0aGdQd2V6TTlUd1FBTnlQMHZMSGxEQUY2cnpoaG56ODR5ZUlsRlRU?=
 =?utf-8?B?WGxObjF6bDJXdkRWREFSV1REWEdFNlNOOEZSQXVBUHZScW04enJPbEFnWGZT?=
 =?utf-8?B?ZTduZVE1VlJRWXN6dldOYmtUUFlNRVBtUXBHN1JjNUZ1WXZ1eGZPeUdBTTd4?=
 =?utf-8?B?V2ozcnd3ZTBFdHB4NTV3SkJvOEllQkNBZUVFVjFzcDgyaVZtTENHeS9ybzdk?=
 =?utf-8?B?TkVNTFpGcWpnUmp4M0R0UVZadWNqQU1LS3hYUElpTDJnNmYyek1SWXQzb0NZ?=
 =?utf-8?B?U0xjN1NtaklEamVUMXpEMEY2QTU3NVpCZUdQNGQrVk0yUE1Valc2enhEUVNM?=
 =?utf-8?B?UXdDazAvdmk3czg2SUJES1k0bnFEL2NEYlordnhXalpQa2tWZUFyclIrQ01B?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4EE1EAEB8F1D64C8F8574A06899379C@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740dd832-95bb-4f30-9128-08dd6266a812
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 19:38:40.1952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ZdPzexqyufOhAq5AaeOW4HNHPsiNRRA2VXK3aquQQ17ssXYh/RcaIIVFTVPGOLvCVprTU38QfF0MRs0gNjhOKfoXxvrQPEZUEfvOkrIVaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8491
X-Proofpoint-GUID: eZtvfvbvpvb0C0xhS-PeOGvQff7wmpJb
X-Proofpoint-ORIG-GUID: eZtvfvbvpvb0C0xhS-PeOGvQff7wmpJb
X-Authority-Analysis: v=2.4 cv=WMl/XmsR c=1 sm=1 tr=0 ts=67d33443 cx=c_pps a=k6qe+EuqS5agFzeLFj3oqg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=0kUYKlekyDsA:10 a=xly65L2S6jMyCSx-BlUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_09,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4+PiANCj4+PiBNYXliZSB0byBkaXNjZXJuIGJldHdlZW4gZmluZF9sb2NrX2xhdGVyX3Jx
KCkgY2FsbGVycyB3ZSBjYW4gdXNlDQo+Pj4gZGxfdGhyb3R0bGVkIGZsYWcgaW4gZGxfc2UgYW5k
IHN0aWxsIGltcGxlbWVudCB0aGUgZml4IGluIGZpbmRfbG9ja18NCj4+PiBsYXRlcl9ycSgpPyBJ
LmUuLCBmaXggc2ltaWxhciB0byB0aGUgcnQuYyBwYXRjaCBpbiBjYXNlIHRoZSB0YXNrIGlzIG5v
dA0KPj4+IHRocm90dGxlZCAoc28gY2FsbGVyIGlzIHB1c2hfZGxfdGFzaygpKSBhbmQgbm90IHJl
bHkgb24gcGlja19uZXh0Xw0KPj4+IHB1c2hhYmxlX2RsX3Rhc2soKSBpZiB0aGUgdGFzayBpcyB0
aHJvdHRsZWQuDQo+Pj4gDQo+PiANCj4+IFN1cmUgSSBjYW4gZG8gdGhpcyBhcyB3ZWxsIGJ1dCBs
aWtlIEkgbWVudGlvbmVkIGFib3ZlIEkgZG9u4oCZdCB0aGluaw0KPj4gaXQgd2lsbCBiZSBhbnkg
ZGlmZmVyZW50IHRoYW4gdGhpcyBwYXRjaCB1bmxlc3Mgd2Ugd2FudCB0bw0KPj4gaGFuZGxlIHRo
ZSByYWNlIGZvciBvZmZsaW5lIG1pZ3JhdGlvbiBjYXNlIG9yIGlmIHlvdSBwcmVmZXINCj4+IHRo
aXMgaW4gZmluZF9sb2NrX2xhdGVyX3JxIGp1c3QgdG8ga2VlcCBpdCBtb3JlIGlubGluZSB3aXRo
IHRoZSBydA0KPj4gcGF0Y2guIEkganVzdCBmb3VuZCB0aGUgY3VycmVudCBhcHByb2FjaCB0byBi
ZSBsZXNzIHJpc2t5IDopDQo+IA0KPiBXaGF0IHlvdSBtZWFuIHdpdGggImhhbmRsZSB0aGUgcmFj
ZSBmb3Igb2ZmbGluZSBtaWdyYXRpb24gY2FzZSI/DQoNCkJ5IG9mZmxpbmUgbWlncmF0aW9uIEkg
bWVhbnQgZGxfdGFza19vZmZsaW5lX21pZ3JhdGlvbiBwYXRoIHdoaWNoDQpjYWxscyBmaW5kX2xv
Y2tfbGF0ZXJfcnEuIFNvIHVubGVzcyB3ZSB0aGluayB0aGUgc2FtZSByYWNlIHRoYXQgdGhpcw0K
Zml4IGlzIHRyeWluZyB0byBhZGRyZXNzIGZvciBwdXNoX2RsX3Rhc2sgY2FuIGhhcHBlbiBmb3IN
CmRsX3Rhc2tfb2ZmbGluZV9taWdyYXRpb24sIHRoZXJlIGlzIG9uZSBsZXNzIHJlYXNvbiB0byBl
bmNhcHN1bGF0ZQ0KdGhpcyBpbiBmaW5kX2xvY2tfbGF0ZXJfcnEuDQoNCj4gDQo+IEFuZCBJIGFt
IGhvbmVzdGx5IGNvbmZsaWN0ZWQuIEkgdGhpbmsgSSBsaWtlIHRoZSBlbmNhcHN1bGF0aW9uIGJl
dHRlciBpZg0KPiB3ZSBjYW4gZmluZCBhIHNvbHV0aW9uIGluc2lkZSBmaW5kX2xvY2tfbGF0ZXJf
cnEoKSwgYXMgaXQgYWxzbyBhbGlnbnMNCj4gYmV0dGVyIHdpdGggcnQuYywgYnV0IHlvdSBmZWFy
IGl0J3MgbW9yZSBmcmFnaWxlPw0KPiANCg0KWWVzIEkgYWdyZWUgdGhhdCBlbmNhcHN1bGF0aW9u
IGluIGZpbmRfbG9ja19sYXRlcl9ycSB3aWxsIGJlIGlkZWFsDQpidXQgYnkga2VlcGluZyBpdCBs
aW1pdGVkIHRvIHB1c2hfZGxfdGFzayBJIHdhbnRlZCB0byBrZWVwIHRoZSBjaGFuZ2UNCm1vcmUg
dGFyZ2V0ZWQgdG8gYXZvaWQgYW55IHBvc3NpYmxlIHNpZGUgZWZmZWN0IG9uDQpkbF90YXNrX29m
ZmxpbmVfbWlncmF0aW9uIGNhbGwgcGF0aC4NCg0KTGV04oCZcyBzYXkgaWYgd2UgZ28gYWhlYWQg
d2l0aCBtYWtpbmcgdGhlIGNoYW5nZSBpbiBmaW5kX2xvY2tfbGF0ZXJfcnENCml0c2VsZiB0aGVu
IHdlIHdpbGwgaGF2ZSB0byBmYWxsYmFjayB0byBjdXJyZW50IGNoZWNrcyBmb3IgdGhyb3R0bGVk
IGNhc2UNCmFuZCBmb3IgcmVtYWluaW5nIHdlIHdpbGwgdXNlIHRoZSB0YXNrICE9IHBpY2tfbmV4
dF9wdXNoYWJsZV9kbF90YXNrKHJxKQ0KY2hlY2suIEJlbG93IGlzIHRoZSBkaWZmIG9mIGhvdyBp
dCB3aWxsIGJlOg0KDQogICAgICAgICAgICAgICAgLyogUmV0cnkgaWYgc29tZXRoaW5nIGNoYW5n
ZWQuICovDQogICAgICAgICAgICAgICAgaWYgKGRvdWJsZV9sb2NrX2JhbGFuY2UocnEsIGxhdGVy
X3JxKSkgew0KLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KHRhc2tfcnEodGFz
aykgIT0gcnEgfHwNCisgICAgICAgICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseShpc19taWdy
YXRpb25fZGlzYWJsZWQodGFzaykgfHwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAhY3B1bWFza190ZXN0X2NwdShsYXRlcl9ycS0+Y3B1LCAmdGFzay0+Y3B1c19tYXNrKSB8
fA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRhc2tfb25fY3B1KHJxLCB0
YXNrKSB8fA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICFkbF90YXNrKHRh
c2spIHx8DQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaXNfbWlncmF0aW9u
X2Rpc2FibGVkKHRhc2spIHx8DQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IXRhc2tfb25fcnFfcXVldWVkKHRhc2spKSkgew0KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICh0YXNrLT5kbC5kbF90aHJvdHRsZWQgJiYNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICh0YXNrX3JxKHRhc2spICE9IHJxIHx8DQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdGFza19vbl9jcHUocnEsIHRhc2spIHx8DQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIWRsX3Rhc2sodGFzaykNCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAhdGFza19vbl9ycV9xdWV1ZWQodGFz
aykpKSB8fA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICghdGFzay0+ZGwu
ZGxfdGhyb3R0bGVkICYmDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0
YXNrICE9IHBpY2tfbmV4dF9wdXNoYWJsZV9kbF90YXNrKHJxKSkpKSB7DQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGRvdWJsZV91bmxvY2tfYmFsYW5jZShycSwgbGF0ZXJfcnEpOw0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsYXRlcl9ycSA9IE5VTEw7DQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KIA0KTGV0IG1lIGtub3cgeW91ciB0aG91
Z2h0cyBhbmQgSSBjYW4gc2VuZCB2MiBwYXRjaCBhY2NvcmRpbmdseS4NCg0KVGhhbmtzLA0KSGFy
c2hpdA==

