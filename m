Return-Path: <stable+bounces-126783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF48A71DF9
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 19:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83AD517585A
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B495424EF75;
	Wed, 26 Mar 2025 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="UUTFq1Gn";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="izojgOZN"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8659B219317;
	Wed, 26 Mar 2025 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012371; cv=fail; b=hLN2eXlrBWisWUB2lzvgpUzGTwTzUTu1oFOkhuo8PpTde8AdWQLZ52UqklJBjG30BBV0jRqUh7z/hmYjvKFCBleQn4qFknBvkFgLAlFniZkdik8mo8U/nG8vysV/g8y2tE5yTYu0H0OJ458xXyVXrOuPmhaBfwcLzP9jA7oa3us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012371; c=relaxed/simple;
	bh=gylYvec0l5uExiwqMCex2io+ir4ht/H7+XyA5gcdTOs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rMIFmC+tcxxOk+rSDonG7EIweQgKt+153ZLIp25s493Zuf48e5JblIDlIlJqZgLxdbW6Fc0CllksrIAUQkmUK8lXbuKn/ScNSeJvZIFkdXR0PJAAsvb8MP4J2Ec9mwD9xIDfvt2rb8LNw3Lbrg/+0VuhkvP53n008V0lA9+fyJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=UUTFq1Gn; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=izojgOZN; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QDrKqZ027416;
	Wed, 26 Mar 2025 10:57:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=gylYvec0l5uExiwqMCex2io+ir4ht/H7+XyA5gcdT
	Os=; b=UUTFq1GnhaDK4v0dCfWJ8/0ujtEdAu98bWNF1khfMFKTPX3sai/AVs4Jc
	3uZ+vsGHjAC+A39CxbNBp2oUdnaTohMyC6Mgl2vuaZGECr7g3UqKkUqF5Lib0Uk6
	U+0PqLxL0cut+PFTr0P+OQvO1squBxIGI5ZM5ZToO7bJrRBEnf1NMFXIzA7ryoSB
	RIVGp715eFQ4WH71noKMZB0H9hFxxYrL3Z8xEl/SRI3hXfB6kR6acUkCuOjFonuR
	1+t5DsgI+KGKYovszlHxzBgH41Cmfbkpt4iMyqPiMNT6OiXGLFTBFVfjgeL0cIdB
	ogJZV+fqeZS0p7TP4tWbTGhYHXgSg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45mjv10krx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 10:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDOVGTfJQXUFkTuGAD2cI/9MoflmDLNZ9TUz/tOepNTzqtMCgUUP6AiLgMICCP6Igpt9SZjQZIMk5U4PvEV/hFmZFcPmdueNz6P1sL9/Jk76EneJextvisUR/iPE6YaTimhgk1eF/o4tfJxipt4hHvoRzJVXZPGM3tbHZFgkKjDaNZwjel8EJjdDfThlHEne/bSnmYMc7Lse/D6i0lgHGKEfVTGnmxvOH11RBAHlbbX2vonP05Za8RAxdlLa7cvb6J66AObpkbPq6P48XBpM48MMWV5cWiNzLNWcU3VCgVED/rsnTmFsn2CgH86qSyUAn+uecqH9+UOL5KMR2Y4OFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gylYvec0l5uExiwqMCex2io+ir4ht/H7+XyA5gcdTOs=;
 b=KHP+81rx9VLg78qu9Yx7CXx+hu40aAAib/9PGvclHnVKb0wZZgIGh2uZ3Nkdm1u56N0qAy8MJg07sGyeZxcRnpWVL0psyTGyg05A2gQfgLOp2vMCvmglZ9aFkcM/AcQzKfvrKw2YDY6ipfQwF/bVljthUGL/Qw/X+3qqT60rn9NQQ2tr4K3/daYFQoo8h520KDrqDy6o8YohsiCzfctcDiW9E4YOiXYsqlcdN+/7UrbQ+HwR/OxViVTaF7+Y27fWBoMYMvLiMr8Lz282Ckv/DgOHxDyj7LT4kde2LQ2bWMON23li/GzCyyYb3AraWrY3tGfLoCEgDyrmOsxg5pVhuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gylYvec0l5uExiwqMCex2io+ir4ht/H7+XyA5gcdTOs=;
 b=izojgOZNzubImVGkkqTI41IVKgr+aqB36WvUa+or2nhQY8Z8rBqyfCE+n69HmQ8fQ8wNenjDKQM9vLxCyrDWStgB8kCaqK0a5q88M0ujXBF5UPcx+SfzKBgUHY6qNyKtnSknGaT8Lt3KlXPVo8uNCQsgPtWbT2WZI9i11BWs5GCD2zFu9H5+y4GulG+BNHGEZkQVjbqqHV1NvtzN/PBVK+SfRQYta8nFOrL3sUqK1+qnPj/ohsvmv9gJmjz0gbweqcoTSWQHctzBkYButBScnb6gw2gjYoo+Es1oUz5SXabHjy9Vt329bxpJ0f3rUAfscJ6crqRV+eY5pS+mNJdkwg==
Received: from PH0PR02MB8859.namprd02.prod.outlook.com (2603:10b6:510:df::8)
 by SJ0PR02MB7647.namprd02.prod.outlook.com (2603:10b6:a03:320::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 17:57:23 +0000
Received: from PH0PR02MB8859.namprd02.prod.outlook.com
 ([fe80::7f71:8568:357e:30e4]) by PH0PR02MB8859.namprd02.prod.outlook.com
 ([fe80::7f71:8568:357e:30e4%4]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 17:57:23 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Phil Auld <pauld@redhat.com>
CC: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann
	<dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jon Kohler
	<jon@nutanix.com>,
        Gauri Patwardhan <gauri.patwardhan@nutanix.com>,
        Rahul
 Chunduru <rahul.chunduru@nutanix.com>,
        Will Ton <william.ton@nutanix.com>
Subject: Re: [PATCH v2] sched/rt: Fix race in push_rt_task
Thread-Topic: [PATCH v2] sched/rt: Fix race in push_rt_task
Thread-Index: AQHbfwMjpI0XBHuxBEiICk5JRhiKxLNLuxmAgDnp+ICAAE3ngA==
Date: Wed, 26 Mar 2025 17:57:23 +0000
Message-ID: <801794EB-9075-4097-9355-76A042B62FB5@nutanix.com>
References: <20250214170844.201692-1-harshit@nutanix.com>
 <20250217115409.05599bd2@gandalf.local.home>
 <20250326131821.GA144611@pauld.westford.csb>
In-Reply-To: <20250326131821.GA144611@pauld.westford.csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR02MB8859:EE_|SJ0PR02MB7647:EE_
x-ms-office365-filtering-correlation-id: 241983ea-9e5a-4212-4962-08dd6c8fa95c
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WTRpenNnODJUbisxdzhzQWpkMWkwNldYV25PeEJHTmx5cmVPb2c0VDhGMGVs?=
 =?utf-8?B?YS91aVBOT0MwN2xWQUJ3bS9TbzZhTWJwb3FCWFhvWkJXM21BK3g0SXZRVkI3?=
 =?utf-8?B?UjhES3JDNjNTbnBGY2g2RGtlNXg5dU5HSyt0UktXdE5ldFZ3d3BPVndlZFQr?=
 =?utf-8?B?cFhZa3RQL3hsQ1lCejErMXEreHJmRnRIQXB0S1lYNllycDlsR0NzQmdsWGNx?=
 =?utf-8?B?UmZVWHdwSUYrdjgvSVRsUlNJTVBpVzRUa0VyNHRQdm9wRXo3ZnFGbURaU1BO?=
 =?utf-8?B?VGRIbWVVeE1sV3ZhVVJDK1dHSWZma1h2b2k3WU9PWDcydHN1c01WeEJHOHBJ?=
 =?utf-8?B?ajBUSlJXaUU0U0loTjkwSExDcENjTXhKRi9oMGIvcXYraWF6b2I0Q3VxQmh4?=
 =?utf-8?B?amk1aTJ4SW5GL2l0R3l5RkJpSlVyUU9oaEpVVGs3Sy84SmF1aFhkV24rUVdG?=
 =?utf-8?B?ZDNsSFdaWjdyYm9FbFYyTCtadllGbGZ4WDRlalQ1UWlZaFNhVkxEUkEzZUd1?=
 =?utf-8?B?UDhoNXljZFVsSjREVUJ6TURwYlVnVDFCRzJHVm91RzB1L3RneDlBSEVPQ09j?=
 =?utf-8?B?NHM0NzNxRWdsaGZwdVNjUW1DTnJNZG5HaG9Kand1QTArYWk5SjVtaDlNWllw?=
 =?utf-8?B?cXMxdEtCYzh6MUtvYmRya3lPb2JGdzkzOHhNMjlGUUdvbDJhRDhWU1RBY2Jn?=
 =?utf-8?B?OEtVamlCdVcwaXZ1VG9IVGZvY3RuUEk4T2Q0UjVVcldQbWd5dTVqRVR5Tm9K?=
 =?utf-8?B?V1F1RnRqUzQwbnh4dlcxN1JTNzcxUmFBV252MXdER2tIRUI3WnlGbVJyZWNq?=
 =?utf-8?B?M0ZxNTA2ak0wZHMya2lITFBjOStDemx3bjBwQUdSOTgrV2xmMnNPbmtRNXpB?=
 =?utf-8?B?Ni9yVDJ0V3BQUEZPS21wWGpuNWFuWGVGOU83K09nVHZ4KzlnVi9pREh1eW16?=
 =?utf-8?B?MWc2Z2I5Y29JQ2VKZkxxUmRNZE5Qclg3aVVzU3B4WUFqZzZFYVhyVXBzaTVs?=
 =?utf-8?B?UDVvc0RLWXFkQ003Z3ZEVjA5a2IzU3hpTXNTemZhU2Y2MUpheTFWemMyVE9N?=
 =?utf-8?B?MGV0MVNlM1pVN09kZzM1Q0NNYjdpenMwQ1Jmak9TdjlQbFFDWXJoTjhHSDFP?=
 =?utf-8?B?OXdRejRmblY0ZjlaWHNhUGVHSXJ2YzVrcDQ1ZUN1encrbUdZWW1VT0RFWFRy?=
 =?utf-8?B?clQxOXgrOE54NkZoV2lScHRRWVN2K2JGK0l3ZFBMWWxlTVpEVG1ybnVFNitk?=
 =?utf-8?B?cG0rQlluZHJjVWQzZWZZVjVCME9xNVE0aXRFQ29nVnhhMkxkOFhRZExpeWUw?=
 =?utf-8?B?K0E0NDBxdHZYb3pBSUZwNndaaHFUenk5WkxJVGYzaXFWWlVJb2h3TEFXcHk3?=
 =?utf-8?B?elBVVkxxSjNHUlBnL0R3NndaamZZSFpzSFJxT1oreDNid1d5RER0b1BRVWxp?=
 =?utf-8?B?cUpUVCtxMHAyNTEySWtPZDBCak80VkNTVkQ2RTZrOXZFc1R3Q2hjNS81bkt4?=
 =?utf-8?B?ekE0WDNReHY2QUd3Wi9GYmxKWm11YUFadzZXRTVrMHhRQmJ2R3V2TlVmQlRV?=
 =?utf-8?B?Rmh5aHB6RnM3bTM1TkJBUG54OXQ4ZHZyU2loNldxS2tCMEU4MTdFM0NxQm9P?=
 =?utf-8?B?K0FDSk9UMU1lVENyOUc2UVE2SVY5eFNBdzI2WlArNEJDdHJXZFVraGtWS3VY?=
 =?utf-8?B?YmtKcGpxUWh1N2dacFo5MitCNW9FNjFkTk5SL2hPSDdWOVhUQjNENlh6Mlkx?=
 =?utf-8?B?cmxMR3hrWEdkVEZoOUFaODhITVV0VE9BR3dmTHB5VUhkYUF0MWRUS2JDb1Ft?=
 =?utf-8?B?eWFzTkZsdEx2M3lFeHdLUEdCam5lQk1sUElNTmlUSk9WNVBKZkJaTDUrbmFM?=
 =?utf-8?B?L0VqdWJSMUY5NXpiNE5WcU5jUnFEbmROdlRYRlVkc1M0VlQ5c2Nzc1JBV1Qx?=
 =?utf-8?Q?5ItYC0u1We4xIrKQ6rS4Sv/eB3bTLU6b?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB8859.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGt0S1JMM0dBQ1lFdEZSQjBSU1RFbFdrdXRmTUE5QXBUa2ZWeHJRN2FpajJs?=
 =?utf-8?B?KzdWZlg0bmVkRHFudnZzZ09hL0JlUWJmNjNUS0RVYW1GaWRTcEp3TFBvRjM4?=
 =?utf-8?B?c0ltTDJqNGFBWCtycURqa0ZQSmRrQW11aWpoOUNaejBrOEZZVG1mUWxrVkhK?=
 =?utf-8?B?eW5mL2ZJM0orSi9TSE0yZXovQkxDOFc0OCt3d0FhVVZuRnFqbFVpVUhHUFU2?=
 =?utf-8?B?NStydjRIRmdyeERHVm9ZdHppTVhKVFRiSC9WdCtkM1FDVFdjaXZ5ZW1jNHgw?=
 =?utf-8?B?cE04bTRXQW83RTRDR3VWM3pyVWRDMit6Mkt1WCtzUWN6Rk9HeDZSK3ZQMXQ1?=
 =?utf-8?B?V3JlRWgrSHU4VDJkK09FYnlkUUhNYTR5YzdSM2diMkFlVGIxcGpWNHpLcU9J?=
 =?utf-8?B?MmF4NWFySFBYSFduRXdkTmZ3MDhsd2I0eDU4VDJ0K0g3cXBMb1gvOXE1d2ZL?=
 =?utf-8?B?VzJhdjBMZEJvRkVSN3ZNTEZuWjc4T0FGZEFwa2J2MkhjOVJvV3BHYU5raWty?=
 =?utf-8?B?UGwwSkU5cmlabTFyYUpQTXJOc2N0bldLWC9Fdit0YXl3K1JwTDRYRTBDYmhY?=
 =?utf-8?B?YVpPTGpsMEpRd01wZEs0ZEZLRW8zakIwS1pNL2FPckdaejgxViswZWxoZ2Y2?=
 =?utf-8?B?VDQwc1lKWmhXVm4vLzZvMkk2a01UQW5DOUl0UmZuMDVDaWZWN2dlUkY2cGZa?=
 =?utf-8?B?bWRxZkcxVEZJOTNKVGFvZTBWQ29GNHRFbjRna3FZZHo3Z2FDZEVFTlEzdHJW?=
 =?utf-8?B?QXhvYmZIakRPWDE1RW1RTWFqQ2xUQjJ6U285WWpPd1VObmxsZ2Q2T08yTTIz?=
 =?utf-8?B?cGl3VU9aWjFEM3RScUM4WDRMVDFUV09pTjhmMjc0YjJEcnQzdWttK0hoUFk1?=
 =?utf-8?B?ZVVVT2VFUVVzRjJBblVqK1BLZFgxZUJNUmNsc1cvUjVJdWJUSFcvR0hNNlpK?=
 =?utf-8?B?S3JkMm9hazVMaTNpQUdhUmNFWHFxL3VlOGpVek03VDJ3TjZ2NjhmamtKOVY3?=
 =?utf-8?B?Tmg2RThEbURrUUJXUmpnci9JTFBUcDBla3NxcE1nZ2Vtejd6UmdWYlRxVXlX?=
 =?utf-8?B?UDN4Wk1jd05tOFZjWGI1ajFpQTJvTVY1cVpBTGJNNnFZMjdndDc0R1dqMVFs?=
 =?utf-8?B?a1JyWldvK2ZEM2R5SmpVL3ovR09WUVd2RE1DMi9TMzMwWHdLMkFwWHFxY0l4?=
 =?utf-8?B?WXpNaCsrdEp0Szh4d0xvQ0Myeks5NUc0REliQ2xKb2dEWDFCZlJ6SjJHUHk5?=
 =?utf-8?B?RkhWaXlBV1dtYTBlTEdaU3JEUzhIWUN4VW10TnNKazE0MVY5WnBlZkQzaU1s?=
 =?utf-8?B?cm1KTGNaM1pSNnNsajFOSGdwSWpRQ0xwNzBBK2x2WG1ab0sxZTc1cWZ3bHhP?=
 =?utf-8?B?dTNmZzV2czJneEhwRC9PNkowbzg0dDQ3ZVlFci9Sa2ZacTJDMnFtSkU5cjJG?=
 =?utf-8?B?MVRVWURFSmxXRXNCS0pIaHVneEtCbkVxMk9DOHNHYTkrblI4ZFkzYzVjcTFV?=
 =?utf-8?B?c0dXTWN5eG42MHh4OGtQYVpxd2txejJVQlhrajR5dnlBUlpTenJXSlY3T2hP?=
 =?utf-8?B?NmZnSG9OUmlNSStvWnBXTm5NODNXOC9iTXRkSWp2Smtyc01NL203MEZJOXdy?=
 =?utf-8?B?a1Q2VVlncGYrWjZrajFjbUthL2ZaZ1hjTW5mc0ZMeXdQV0NaYUZ3T28wWEJ4?=
 =?utf-8?B?RFhTMzBCdTRwV25NUCt0eFRqQnNIcFVhUmtLMkFiNVcwZnJDN3Z6WEFDd3ZM?=
 =?utf-8?B?aDRuNTQ1a3hMR1YweDExRFRuSThYdkFuUlM5VDh1U3BZakpXTDlRWnRkS0Ju?=
 =?utf-8?B?N1I3OU1SQUt5eXcyYzJHUURvZFpqZEZkVExNNDl5WGlTZi9qMnV5dWszcHBu?=
 =?utf-8?B?NEc4UFA0N0RWM2hNQmhNV3AyUVRuelhtd2p3ZXcxMmd4bkVBV0M4Y3RFQ0k3?=
 =?utf-8?B?cHdHbkhaMGlnTkIrVDFYN24zY0JKVkRNV2FYZktFc0tmUTlOMWRVK0FUaHJU?=
 =?utf-8?B?M0RLbi9Jcnhmam0yVm42RTRFVGEyNVZ3UHJ6KzFjU2VyRjIyMUMrbWwxQlow?=
 =?utf-8?B?SUM1dzdSSlFDV3A3SHpzR0pDSTlReEJTckUvdFloODNQMktoMk1vWEFWR1o1?=
 =?utf-8?B?NzVlTWlUaDJGM3dobGllVW5NRHVrWlZXMkVUNURlNzZSSk9LOUVCblJTZlh0?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B12C9B8E564AE4999743188F94586BB@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB8859.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241983ea-9e5a-4212-4962-08dd6c8fa95c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 17:57:23.3373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lHo14e/VTZshfF5baDgwpRyV0luiES3ksobrkUCJuhzj6Erx8AlQIG4ouDPABmQqrBg0zqsSS5r/6uqZ4FbpxfjwAmAJet2aQgng6FMI6M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7647
X-Proofpoint-ORIG-GUID: kBu0ynPP_qtdkkCnH16JGXXYnS8kwmsM
X-Proofpoint-GUID: kBu0ynPP_qtdkkCnH16JGXXYnS8kwmsM
X-Authority-Analysis: v=2.4 cv=bJAWIO+Z c=1 sm=1 tr=0 ts=67e44006 cx=c_pps a=yF+kfS/uWKtSACHbTM5LMQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=TECLu5cFoRZISPo3-MAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_08,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWFyIDI2LCAyMDI1LCBhdCA2OjE44oCvQU0sIFBoaWwgQXVsZCA8cGF1bGRAcmVk
aGF0LmNvbT4gd3JvdGU6DQo+PiANCj4gDQo+IFdlJ3ZlIGdvdCBzb21lIGNhc2VzIHRoYXQgbG9v
ayB0byBiZSBoaXR0aW5nIHRoaXMgYXMgd2VsbC4NCj4gDQo+IEknbSBhIGxpdHRsZSBjb25jZXJu
ZWQgYWJvdXQgdHVybmluZyBzb21lIHJ1bnRpbWUgY2hlY2tzIGludG8NCj4gQlVHX09OKClzIGJ1
dCBpbiB0aGlzIGNhc2UgSSB0aGluayB3ZSBhcmUgcmVhbGx5IGp1c3QgZ29pbmcgdG8NCj4gdHJh
cCBvdXQgb24gIWhhc19wdXNoYWJsZV90YXNrcygpIGNoZWNrIGZpcnN0IGFuZCBpZiBub3QsIHBp
Y2sNCj4gYSBkaWZmZXJlbnQgdGFzayBhbmQgZG9uJ3QgZHJvcCB0aGUgbG9jayBzbyBpdCBzaG91
bGQgcGFzcyB0aGUNCj4gQlVHX09OKClzIGFuZCBmYWlsIHRvIG1hdGNoIHRoZSBvcmlnaW5hbCB0
YXNrLiAgU28uLi4NCj4gDQo+IFJldmlld2VkLWJ5OiBQaGlsIEF1bGQgPHBhdWxkQHJlZGhhdC5j
b20+DQo+IA0KDQpUaGFua3MgUGhpbCBmb3IgeW91ciByZXZpZXcuIEp1c3QgRllJIHRoaXMgaXMg
dGhlIGxpbmsgdG8NCnYzIChsYXRlc3QgdmVyc2lvbikgb2YgdGhpcyBjaGFuZ2UgDQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjUwMjI1MTgwNTUzLjE2Nzk5NS0xLWhhcnNoaXRAbnV0
YW5peC5jb20vDQpObyBjaGFuZ2UgaGVyZSBpbiB0aGUgY29kZSB3LnIudCB2Mi4gSSBoYWQganVz
dCB1cGRhdGVkIHRoZQ0KY29tbWl0IG1lc3NhZ2UgdG8gYWRkIHN0YWJsZSBtYWludGFpbmVycy4N
Cg0KUmVnYXJkcywNCkhhcnNoaXQ=

