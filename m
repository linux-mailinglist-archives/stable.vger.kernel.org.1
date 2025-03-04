Return-Path: <stable+bounces-120370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B05DA4EC13
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 19:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6E07AEBFE
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5893280CF3;
	Tue,  4 Mar 2025 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="sFWhGuRx";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="v21ojfSn"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07037264F8C;
	Tue,  4 Mar 2025 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113157; cv=fail; b=DE9Qi8ttqUmy7+GklAWsDcHImopaieafGiCNc4qC/kLYBr3QP/Eqt/apNxX686i75oYnVWMnqMhoZtoNAn2bWgT6A8/EFkrf+/vQTHundcW4HAw6Pf1x4gSAXJ20y5yBOyGZqoNAt9HT/6lO0kUjReMX1iC4f0euVyTfHOO4IbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113157; c=relaxed/simple;
	bh=GJ73Fi1ntHNNipKwmmc6xlPEng3Aa9+EiZeoMA+fvGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WJexMCc6wdaW5pzf/jfZ/FoGvmrZlvKL8ckXNI6MRSr3ekWah0U4AAOzDJCrkAbisP1lKp5YKFdQy25WS/Vk3g0LIhvfKkw+HsY6L7BGF23HkIguf1JKNek0Nphj9OGHf4WMwwWiuEv+8yNbz0YF+om2keWphhRiJR9b1f/3JsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=sFWhGuRx; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=v21ojfSn; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5248xPol003390;
	Tue, 4 Mar 2025 10:32:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=GJ73Fi1ntHNNipKwmmc6xlPEng3Aa9+EiZeoMA+fv
	GU=; b=sFWhGuRxwMnauavLeWhqkiBNm9XFj28wxqfq57O0VxLYWlS21mMhayPFg
	mXYL/VQ/hDMvLMQOtHqkO61gjoadz1zAe23TbY5XLmaIJguFY/jdKyA78jop+H24
	hopQj9SB2GJ08zis32r5Ikc6b5MrFfC7t9nuc4pbVuvDHJVA7jsy+Mej4NbmF7Ux
	jU68lwDKI8rLZ2NQb64x97X95TaIL50rxunkGAQthucdAXjMJg8agg0sSdEXR1HL
	jPYjbm8BrZyUipaw3LhrHdwIUZy+Djzif/MPYQezFbr5qVwhtTbCGrHK6Az03KsH
	4K8nPRoxPRZY5NYdEFU+Ejpa4KGWQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45417nj5ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 10:32:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAugLA56Am64bDYa04Fl3Bzid1avb1f3cLpoPTLcVRh5vcE6xpaIW/xa9k/MAHN/TtK3KIZpfMtzv+o09wenVsjl4elSDqp1X2OEUQnmtQlvSGKSpKqpgZSFI3WQp//YPm82LVr9nTaXb9tNJS7VzVcsinlYk3fIctMO0pQemCV6s8GLe9DT3SGFAN/Zp7UxIpEKhXCcfvbmB+UAXwF+dFvsuQhjfwNkge0cY1NAH/NSFCQMVQ9BYrCPHpSrjTCFYqJz2rZTqY3uycrR88J2miFiY0eioHhT+FhOm9KvX3GbPtFCca0psInYu3sjCd2sq1qO0CyfZk8uFkbZl6JX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJ73Fi1ntHNNipKwmmc6xlPEng3Aa9+EiZeoMA+fvGU=;
 b=Ql2KlktYDC5XaXioIf4Hg5EB0ZyZWu15A04NBJS8a/O428GSEnAeJmJD0jFqyAlh7p1cteX7t53KUwSHtFWOTFvMoEh8LwRJMQMYA0OMi0AK+TKETNWXlgV5JaTk694QQMqTZ7bqFgKZrPcY53IgJvTfb8FtAtl8hH6lYQtsQJozwYP0mIyxxiwAwgrw5TewhrumrVscLnTTnZQE6hLKgM2GCD05XiKxJ9msBh9V9uADrxti0d+ipoxpt1U3LBG0KOeH5Ca2CRH7KkOJO+oPs/a/XmHp4QAM6xEVWVoDi4z7fkBFdnIPjGrUVZgfUcZtcFjbpWsZUd69DCTPDILyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ73Fi1ntHNNipKwmmc6xlPEng3Aa9+EiZeoMA+fvGU=;
 b=v21ojfSna0LtuKGheP1RiBStFjPAfJ6Vt6YfcEKUFnUMJEbBWpVHF/m+4MKksmHa8w7fRPEOUrtHk3qW6JiwaxlBzUNOkIKfEU8He9T0GZxPOhyuASTMpax+Fk032Cx9TuAcYVwqpfnaFrr4pIGhmqyQrKVZ+yATIT9G5hha9TFrwjioulFMHjEQgqb9Q5+yvN61QPWztpS2Fdoha3HXx+WbQ1eTGJWNUoEHwPct/nEYoQZf/ycFpsTiJequxg4vjzIhur0xI1sS3Ea8lC1H54Pqn99XMnd1iEzEs/Hj717BF50ANuUrjhKCzNMfjt4fHv+vnXLGMmVJlCUmhLSfhA==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by PH7PR02MB9385.namprd02.prod.outlook.com (2603:10b6:510:276::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 18:31:58 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 18:31:58 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann
	<dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jon Kohler
	<jon@nutanix.com>,
        Gauri Patwardhan <gauri.patwardhan@nutanix.com>,
        Rahul
 Chunduru <rahul.chunduru@nutanix.com>,
        Will Ton <william.ton@nutanix.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] sched/rt: Fix race in push_rt_task
Thread-Topic: [PATCH v3] sched/rt: Fix race in push_rt_task
Thread-Index: AQHbh7ASF98xRUPde0yBoaYiJ5HLYLNivLCAgABohoCAAA1zgIAAJAAA
Date: Tue, 4 Mar 2025 18:31:58 +0000
Message-ID: <8A79962F-9B22-4F28-9A7A-F9DB1D855966@nutanix.com>
References: <20250225180553.167995-1-harshit@nutanix.com>
 <Z8bEyxZCf8Y_JReR@jlelli-thinkpadt14gen4.remote.csb>
 <20250304103001.0f89e953@gandalf.local.home>
 <Z8cnwcHxDxz1TmfL@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <Z8cnwcHxDxz1TmfL@jlelli-thinkpadt14gen4.remote.csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB8861:EE_|PH7PR02MB9385:EE_
x-ms-office365-filtering-correlation-id: 7a9733f0-8489-48a2-7784-08dd5b4ad946
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NHNibWtjdTVlQXMvY291Ui9JV2NZa0UwSFpwVENsdldLdEJSNjFBQXN6V3NX?=
 =?utf-8?B?OGJ4ZHpzazF3NWJ1V3NPYVkwOUxGZTRYYmtidlprTkJyblBjTEZvdStveDk4?=
 =?utf-8?B?T2FZdVp5RTErNGxXL1RGeitPMTczdjc0SGJNcGc5SCs4b0owMFdSaGZrQUt0?=
 =?utf-8?B?eERtZmxTb1VuUnRUbGYxR1lLZ2JLNkZEZjlEM0pMQXpwcVplWHlpS09wSzQy?=
 =?utf-8?B?SERjYVdIYStGOXc4dmZ5YWUrM3NHWENQWUtRNmV2YitMZzdadi90WUUzU2xp?=
 =?utf-8?B?WkdyeVZTZkw3THA1cHZrVytFOWppRjFwZVlCVGhsQ2g2ZjQ2dEJpQ1ZEWGxj?=
 =?utf-8?B?WUhlYWZXaXBBNC9LbCtZMmZ3bE04NGcveVJvZ3pkTUNwM3FUZHJ6RE1veDRR?=
 =?utf-8?B?THlXa3VaSjBnaHR6dEhoTTBlZUloTzFpazZXL3U2dndsbm54aUpWNUhEREY1?=
 =?utf-8?B?TkU5YjdmYjhnbFBVNUp3aTdVMEF5a0Z0NGhydjFVWGpCWTEwYVdIbjZKcjJI?=
 =?utf-8?B?eEJndXdnbVZ3NUlSWjZlWG5aM2FjTVUrRnkzSktWTk04dGw0R1RDQjNXcndu?=
 =?utf-8?B?VFkwck40aCszUTJTVUNLSTFkR01CWk5Ba0xHYVp6OGFnRWVISngzVGQzTkdl?=
 =?utf-8?B?M0l6N1NiRDA3RElGYjQzQnBmaHF1L2owVGxLNFphSTAvd1RhVm1nUTVpYmZJ?=
 =?utf-8?B?WEpsZ1hnRDlnOW13enp6R3o1Q0NOUHZGZHlGVWYraWk3eE1xNVgzZ2premVU?=
 =?utf-8?B?RzVlMWx4NXBmOHF4RkxTaDdVcnl5UzFCTlV2SnNkaldBNW1ZajFmMTlMRitX?=
 =?utf-8?B?VUFTV2RGTGRMRzlpUlZybXFhT00xN0RDMTRjTzR0TlVsVUJ1NEZ1dUZJaWgy?=
 =?utf-8?B?dWZRQy9HeTg2SUhxMzdhNkZxVndqb0NhNHdTOVhwMDlNcU11ZDgrd2JLaDJm?=
 =?utf-8?B?NG51MVQrTG9aZWFnTUNQS0dqVk92THZMOFNnUlFuOVFBTDNpdEtyTzNHRFZH?=
 =?utf-8?B?MklSTW4wN3FqV0xNUnRsblNIWkF2ZWxHS3dRWXRSYm5FSk11WU8veW9GVmQz?=
 =?utf-8?B?NGF5SWxOZlJNUVRCYVpzM1lWcFpJdFFVMGVJZEk5SGhWZlVGQXJaR1FwbHBE?=
 =?utf-8?B?V3AvRnMwaCtvY0xjM2hUbGhGUjk2cmoyd293ajJTZjlrc0RGV2sxSVk3ZDVW?=
 =?utf-8?B?YmQyc1FQQ0VJYnBJN2N3clZ0NkZhbXhocS9penBmVzV6Tmc0RjVQZmFlZTZq?=
 =?utf-8?B?aWdBN0MwQW1LZm5TZStLS21EUmlMdkVxZFVHcnNsSVZBd1FwQ1JvNjI1S0ps?=
 =?utf-8?B?TmErdUtuM2VBZHNqUU8vcTdGUjhkWVRuUjhSN05IVGIxTDV6aEpoempTTUQ5?=
 =?utf-8?B?M1RyUzlBck8vdUVTbHQzWmxZS1RyRElJOU9HNzdBWFViZzBhb2p5R0tCd0ox?=
 =?utf-8?B?bGdXUE8vQmtBaDEydTc4NjFHaHZuYi9mRFh4QWJPWXNIYmpiWFlvRlB2KzRT?=
 =?utf-8?B?THNoU2xabkw2VUp5aHg3ZnZJSy9DVmZRcWZva1pCcGdxNjNjdzNkVzJIQ0tJ?=
 =?utf-8?B?OUFCczlCT2MzQnlBUStFTUs4S0F3d2ZJbTRHR3luUVU4L0llZ0F5ZStUTWVX?=
 =?utf-8?B?RHhvZS9jUlZHS2pEUFIreStTMmZZcldmNlhSTEZJUSsxVFJoQ0FXbHpGelJN?=
 =?utf-8?B?cHJtZFBxNStNRmdjVjh4c29lN2dWZnZLQnhwbUFyc2Q4WlM3blBvOVkzbFpn?=
 =?utf-8?B?WXlyd2pERFcrUmM1c3REaVgzQWZ2aEpLQ3lJYUx1bTBycUJCeHRWVGdKK1Iz?=
 =?utf-8?B?UVdJYnJDalpRazNkUWYwNjloQklWdXRqbm42NWFaUlFXQjlYQ2cwRWwyWDlr?=
 =?utf-8?B?TlJFdmFTRU9ycTRNZHp0N3BkV0pKR2ZkMm1aRndWZnRnZ29WTDVoRjk1d1FS?=
 =?utf-8?Q?bo+rPUHlnGI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXdCTmRKL01EY1hBcEJQWFpSNFU0KzB4L29SQ1VyemlhWnUrTVZPci93UHRk?=
 =?utf-8?B?SUtsQ0tETTM2MUtIN0JyTHYwZGU5K1lSUnFyVWVkbFNmYWVHNE9EazdWUjUw?=
 =?utf-8?B?T01WWWYrOGp0dmdybEQvQzV4cUZRSlBXczdKZ2wwS1FvdkVLb2EwWXZQMDMr?=
 =?utf-8?B?T29MYmJSK2pQRlFUSFV6c2ZrRndDYXcrN2VyL1IyZ2ZxakJVMGVhOHdpQjI3?=
 =?utf-8?B?Z0ZFUVUzeWZIYnczNVZmOVlNeHNDRm5Na1hDeUdSL3ZBWjdpWkVZcW8vL3Az?=
 =?utf-8?B?L3dXblc4TldjWFJuVFE0amJHazlPYi9GK0dzelVhZHRIYVZCcUg2NWQrTTV4?=
 =?utf-8?B?eGcrbm82ZXA3K0QrWFJjSDNIRDhKYXpVUVRqeVJJMldMZDlQRnVGK0g2SnZ0?=
 =?utf-8?B?SFArR3VTVEVEakFZNU1wdXZjRy9FckszMEw1VjViL2pyeEpzUDZBTXllUFVs?=
 =?utf-8?B?UVJRd3ZpdTE2UVp2RnAzSG5tZzVXWk1kZW02eXMvYUI2YTBBNmxBbk01cVJk?=
 =?utf-8?B?NXF0N0YvRWdYQ1lzMVNWZkpGUFhScEdKcU1odWNFdFN5WmdUK1ZOalZEK3U4?=
 =?utf-8?B?eXRBQ0tlTHA0K085a25Pa2JuSTFKRU5IZU9BVVlpVTArM3o2aTl0aVJ0UlN6?=
 =?utf-8?B?ZU1tTU8rTjJwbmQxZHk1UGZQcmVsSzJ4SDJiVzE5TGhvYzA5cjVVV0xlNGhH?=
 =?utf-8?B?K2pjTXZZa05VVWlKeVlIMW1EQmFlRkZ1MVNJUlFaM3Z6VUIyZnRVY3M0MGV6?=
 =?utf-8?B?NDVqYjc2Tk1tY0tnUmUvNFU0ZkNvZjhqcm5VUndmS1JJalRQWDlUNGtmdlRV?=
 =?utf-8?B?dzkvN1JCVm9sYlhrdTVCSlFIVkU4L2Q5bVpaZWZxWTVDRXhaQ1JSMWpLQjBY?=
 =?utf-8?B?NEtmK1N3Y2VuM1k0NmJkcURuNXNrZ083Q0dMZjAyZDZkbDZhRkJ1UEM2bTVn?=
 =?utf-8?B?UzJuY1o1Z0NjSDl0VVc5Z3hydm5Ob1ArakJCNzJoaVdaWlN0U09uR1dBMGUv?=
 =?utf-8?B?MU5sMUIweVBxcDhTUWdOeWkxcTVEQk11TGZBYy9ZdVZUdmc0am1PbldVUjVX?=
 =?utf-8?B?S1dIYXNheXc3U3NINDVIaUdzTGxna2hMbjl0cGZjMS8zaDFQbWdmOTQ1MDFw?=
 =?utf-8?B?cG9kUFFQK2VGd2U5ZkdKUlR5Qzg4bFl4ZW9QcHV6dlc3S2g5YXV1ZllBSUNV?=
 =?utf-8?B?T0srOGE0eWZkNFpvdWZUS09UUHplbWdBSVpqZDVML0VwMVhiOWNYUDF6TmxB?=
 =?utf-8?B?YlZ5TysrbURDcUR5aVJ0cjZ2dEZrOThVMXBwdnhpaGYvMEdkMTErZmowbDNa?=
 =?utf-8?B?d3EyZWtLeEkvd3ArV2IrU0RPK3BkdWtSc2NqdDZKUXNhMEt3YVVvbURIdzdX?=
 =?utf-8?B?a3hjU0MyR25tV3BEMVRveTJxUlp6VnNWYUpDbGlrcWFOalpWR3Buc1NJaDFZ?=
 =?utf-8?B?N3N6eEZUY3JrQkdRMFNSaUpxb015NTVpMzJzMittWi9Mc2NENllQWDZPN3g0?=
 =?utf-8?B?UnNGc1hkMHRxZHd5QXAxTXFybjZjU3FFMWt0akI4cE56dEZHWFA2VThZc3RO?=
 =?utf-8?B?ZWxacFgvVTV1OVNJeW1abmNwYWtZRFloSG5MZXZ4RHB3WFZGRGM2YzNPOUlW?=
 =?utf-8?B?ZVZmVEVSSVZpYXZ4UzNNSW5HMXFOemlyMXUwRktkV29wVjJUMnhDdnhTR2R4?=
 =?utf-8?B?Y09FM3AzaFltdlptL0lLQVV2ZTlhWG8vMzNJR2Z2bUJFcU5BZUV1aHk3dTgy?=
 =?utf-8?B?NmNwNU01MFF5dXZYbjVhaWhKamx0L1JPQlFkalRBNlE0RXgvTXFHSW9JczZt?=
 =?utf-8?B?ZUMwc3JoZ1k4Yjh0VVhxelkyTFVxZHJ5NC9Dc2gxb0JBUzE1UjdnOUhiMm5E?=
 =?utf-8?B?NlF1RWRYeWRRZlZTdjhxS1hjYytpVzRub0tFMDZLRmQ5QXZMZjJhR3p4WGRP?=
 =?utf-8?B?R1JXYmJIYWoxWUxQeDkxVUQ0b1FQU0hkb2NmdUk1Unk5Q09ZS3IxZXRYckFL?=
 =?utf-8?B?eXM3RHNiR3lNcnZCb05IczR6c3NicDFGK1BTQlM2U3hwRk1kQnRIbmVrZitl?=
 =?utf-8?B?U1dNOUl1ZUVtMkh5TWthNXZYc2tnVmxFMXJmMTUxZG41eW16dHhxR0U0K3ow?=
 =?utf-8?B?QjdKMTNmdlNZaVBraE5DeWxXTUpoMDZGZVRzR0tPVEVCUlplUU9iSk4zQVRx?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8C421B8EA9D0B4DA6B5EF2097AF80B9@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9733f0-8489-48a2-7784-08dd5b4ad946
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 18:31:58.0252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3NV452uoQuGDsljWJ3GllFBDxQYiqj2veI4/GCzTxjjAMf9501L+CXOyx5SJt+VoLjNhyZr5rLL6LPwRC3ruXC+DJDASxI6m1pF/88mvaCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9385
X-Authority-Analysis: v=2.4 cv=Ltxoymdc c=1 sm=1 tr=0 ts=67c74732 cx=c_pps a=NZTPE88KBhpz0z3fOSYQ1w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=kmqNutOhmeH8vT2Rin0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CdoX002Jc8Ie88-sns_rmImZN6qHyq6l
X-Proofpoint-GUID: CdoX002Jc8Ie88-sns_rmImZN6qHyq6l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_08,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Reason: safe

VGhhbmtzIEp1cmkgZm9yIHBvaW50aW5nIHRoaXMgb3V0Lg0KSSBjYW4gc2VuZCB0aGUgZml4IGZv
ciBkZWFkbGluZSBhcyB3ZWxsLiANCklzIGl0IG9rYXkgaWYgSSBkbyBpdCBpbiBhIHNlcGFyYXRl
IHBhdGNoPw0KDQpGcm9tIHRha2luZyBhIHF1aWNrIGxvb2sgYXQgdGhlIGNvZGUsIEkgY2FuIHNl
ZSB0aGF0IHRoZSBzYW1lIGZpeCB3b27igJl0IA0KYXBwbHkgYXMgaXMgaW4gY2FzZSBvZiBkZWFk
bGluZSBzaW5jZSBpdCBoYXMgdHdvIGRpZmZlcmVudCBjYWxsZXJzIGZvcg0KZmluZF9sb2NrX2xh
dGVyX3JxLg0KT25lIGlzIHB1c2hfZGxfdGFzayBmb3Igd2hpY2ggd2UgY2FuIGNhbGwgcGlja19u
ZXh0X3B1c2hhYmxlX2RsX3Rhc2sNCmFuZCBtYWtlIHN1cmUgaXQgaXMgYXQgdGhlIGhlYWQuIFRo
aXMgaXMgd2hlcmUgd2UgaGF2ZSB0aGUgYnVnLg0KQW5vdGhlciBvbmUgaXMgZGxfdGFza19vZmZs
aW5lX21pZ3JhdGlvbiB3aGljaCBnZXRzIHRoZSB0YXNrIGZyb20NCmRsX3Rhc2tfdGltZXIgd2hp
Y2ggaW4gdHVybiBnZXRzIGl0IGZyb20gc2NoZWRfZGxfZW50aXR5Lg0KSSBoYXZlbuKAmXQgZ29u
ZSB0aHJvdWdoIHRoZSBkZWFkbGluZSBjb2RlIHRob3JvdWdobHkgYnV0IEkgdGhpbmsgdGhpcyBy
YWNlDQpzaG91bGRu4oCZdCBleGlzdCBmb3IgdGhlIG9mZmxpbmUgdGFzayAoMm5kKSBjYXNlLiBJ
ZiB0aGF0IGlzIHRydWUgdGhlbiB0aGUgZml4DQpjb3VsZCBiZSB0byBjaGVjayBpbiBwdXNoX2Rs
X3Rhc2sgaWYgdGhlIHRhc2sgcmV0dXJuZWQgYnkgZmluZF9sb2NrX2xhdGVyX3JxDQppcyBzdGls
bCBhdCB0aGUgaGVhZCBvZiB0aGUgcXVldWUgb3Igbm90Lg0KTGV0IG1lIGtub3cgU3RldmUgYW5k
IEp1cmkgaWYgdGhpcyBwbGFuIHNvdW5kcyBnb29kLiBJIHdpbGwgc2VuZCB0aGUgZml4DQphY2Nv
cmRpbmdseS4NCg0KUmVnYXJkcywNCkhhcnNoaXQNCg0KDQo+IE9uIE1hciA0LCAyMDI1LCBhdCA4
OjE44oCvQU0sIEp1cmkgTGVsbGkgPGp1cmkubGVsbGlAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0K
PiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLXwNCj4gIENBVVRJT046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSENCj4gDQo+IE9uIDA0LzAzLzI1IDEwOjMwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToNCj4+
IE9uIFR1ZSwgNCBNYXIgMjAyNSAwOToxNTo1NSArMDAwMA0KPj4gSnVyaSBMZWxsaSA8anVyaS5s
ZWxsaUByZWRoYXQuY29tPiB3cm90ZToNCj4+IA0KPj4+IEFzIHVzdWFsLCB3ZSBoYXZlIGVzc2Vu
dGlhbGx5IHRoZSBzYW1lIGluIGRlYWRsaW5lLmMsIGRvIHlvdSB0aGluayB3ZQ0KPj4+IHNob3Vs
ZC9jb3VsZCBpbXBsZW1lbnQgdGhlIHNhbWUgZml4IHByb2FjdGl2ZWx5IGluIHRoZXJlIGFzIHdl
bGw/IFN0ZXZlPw0KPj4+IA0KPj4gDQo+PiBQcm9iYWJseS4gSXQgd291bGQgYmUgYmV0dGVyIGlm
IHdlIGNvdWxkIGZpbmQgYSB3YXkgdG8gY29uc29saWRhdGUgdGhlDQo+PiBmdW5jdGlvbmFsaXR5
IHNvIHRoYXQgd2hlbiB3ZSBmaXggYSBidWcgaW4gb25lLCB0aGUgb3RoZXIgZ2V0cyBmaXhlZCB0
b28uDQo+IA0KPiBUaGF0IHdvdWxkIGJlIG5pY2UgaW5kZWVkLg0KPiANCj4gVGhhbmtzLA0KPiBK
dXJpDQo+IA0KDQo=

