Return-Path: <stable+bounces-120373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AA6A4EC4E
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 19:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E62A1882DEE
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403FB27BF93;
	Tue,  4 Mar 2025 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="2P2hhaUE";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="kTWp2ids"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407825F998;
	Tue,  4 Mar 2025 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113458; cv=fail; b=ZDlK65AawOjLlZq3H8TswofFMOE61JD2FLlAVuO/H7sn4pWHbUDmjUX4I+NZGl5Y9UVBd/vgTdFVv6OnG0NqHY4Ta2yUQ80ZAxxFAKhbuUaVd8f7rzHeZc9eCJ5F6EUWHGI2znWPJk+hmh59FQUTNRsn7mQNe8TrX05YrJ5SDjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113458; c=relaxed/simple;
	bh=K9ETv8QGgjnhYb6MgBz59rj9eBdKDQkIegGtqXKXqVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X00tDpOiq7Y2B2DEbYjWS6XOTwQ/DZSJugCnlHPKIlvoeIdJrsCHHHwrOGTaY5fb6hUuBxKEWVxm2EH7m68QVIIDAmcaPZjRmC62smxGymgQl4C/vXTfh/Y6E9rxpMm6QMxieblfTCjPqJtEdyOw6YC4CeZ6nTDZTnA5zmn6lnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=2P2hhaUE; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=kTWp2ids; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524HPF6J026047;
	Tue, 4 Mar 2025 10:37:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=K9ETv8QGgjnhYb6MgBz59rj9eBdKDQkIegGtqXKXq
	VQ=; b=2P2hhaUEMey02jHRlb7VHEpHhe9vlOtbd9LLrHLH/bJzKDG+aUK+lj6fA
	ZEQ8c0fxMsVlHV/A4iX1p7wqzhDxmm9CqazHRfdkKL9FyWD40LTxmowkhH+Li8rl
	FJ4x5h9h4w5KzH/+r3H5VCtCHdYBd7t3zYnAVsjAh+C8c27HwhnS1KdInW4xjRYc
	H1l3ScjQ9iHaO070OA6ysVPaS3haCuzZB3b1tFA6NLd7PFZvT0SaQYpeXPcOQ61+
	zDUrXevHvRdCzOYgnhOOeeEeWZR2Ho0yyzcUM9c56YRYIhM4bIWTsWkVW0C7MDbH
	jhCt/VeGvrETi6NEzfMYaASTN5IZw==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4542n528t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 10:37:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlacH0q7Qgae/VRvJxIa03wVCQQJJVAykNvn6ncDl/9zmHRMMblS3V7ayPXtpdlFPVUWEUkyzwjRTm9Ow8CirGS0bM24XJum8Y8k+pBGNyndWPnRis6Q8fKQII1VhikbkpMVRkk0bHlxli7fTp4+BtXG0SV1yWxpQWujBtTy/+Wl2PZFlqEL1bHFOKAe26lAVUtx4k9n5i1jNFapkU+jCekDUEBulFfz2t8hrBNZkwmXEtBW9W8Cyh9cVZmmKrmMlQZOhZhNz+nik3+9YzGg0mJ9+1u3cHD94OFFy7B6XnhmnOMDJ9fU7+62e/9U9Bhc4TWcxJFQ5yzMm2eWR8ksSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9ETv8QGgjnhYb6MgBz59rj9eBdKDQkIegGtqXKXqVQ=;
 b=uU1pF/r8OkiIgHWt2btU0yyu+inp86L8pxCZ1+NONJgFmy3dHRNsN0+OArAfkR+VnFAIYMNa+w3lGFJm4mgYTGos6/09q8nTIDOOMB7TEJyitNvaFdMJ7tBd9Ru+PrU+ZNOLmhQI1vSYpV5RbvpRJNdUNQWjF3eiY9+C76ysrROcu/qDrN140RSppkdK3Lzf8m5lD8W+ttgSLlZPIXa82x6N8IUayCxZSB026np4aVqvZ3DzzjaHmNAyZDki+LolW0BwquDkGfIQO3+5Ddu6hlKvJQEgDK8oTF5k1AHBL3r8N5Rjt9a8DMgEGKirpzvievlfH6TGIkDilxeS8+JQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9ETv8QGgjnhYb6MgBz59rj9eBdKDQkIegGtqXKXqVQ=;
 b=kTWp2ids7iXJOtxVqVUs5OPSFXBjIFIT/VFVkbTyE1O5H8PbyL1hxU4EOzclZi2aP3SYZETd5/fGeZeKIEjNPgP6wQ6sZli5Wc+deazuR/ML0lkK9pwnJRFDhLQWBq1ZuZ6aiOL5ocWb6KfID2m+zPOvnUeL71gsT5AwcNw2GBtLt97Ow1W28sem3n4byFbOPXdn+Pw5h4Z9/TJbY0KaePwqkml/E63PctpJtAhNw1oGY6qIHn7mVe8bCVg7taznIuXTe26rwfzgbaPEOIvtJBH3l44wdYkchJcFDyaAuz+FS32Z9GDaO2gkF279k3WJL7oMmOKeGO5vA02ufP27KA==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by SN4PR0201MB8822.namprd02.prod.outlook.com (2603:10b6:806:202::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.28; Tue, 4 Mar
 2025 18:37:21 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 18:37:21 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Juri Lelli <juri.lelli@redhat.com>
CC: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot
	<vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin
 Schneider <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Jon Kohler <jon@nutanix.com>,
        Gauri
 Patwardhan <gauri.patwardhan@nutanix.com>,
        Rahul Chunduru
	<rahul.chunduru@nutanix.com>,
        Will Ton <william.ton@nutanix.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] sched/rt: Fix race in push_rt_task
Thread-Topic: [PATCH v3] sched/rt: Fix race in push_rt_task
Thread-Index: AQHbh7ASF98xRUPde0yBoaYiJ5HLYLNivLCAgABohoCAAA1zgIAAJnEA
Date: Tue, 4 Mar 2025 18:37:21 +0000
Message-ID: <9688E172-585C-423B-ACF6-8E8DEAE3AB59@nutanix.com>
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
x-ms-traffictypediagnostic: SJ0PR02MB8861:EE_|SN4PR0201MB8822:EE_
x-ms-office365-filtering-correlation-id: 49683172-9c5e-45b4-246c-08dd5b4b99a4
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WjJvdExvMnVGc0ZkTUwyZjlOTE11VndCOUwyUlhJQzFWUEZmeE1sdFFYcU0x?=
 =?utf-8?B?eGVOcmFocnlCay9URnJxZSs2WjUxZmhtS044UEpmcVNrZjFDTXY2aVR2RGpF?=
 =?utf-8?B?SUdHL2JmMm5pamtSamxsV0I1bk8yVi9hbmNONjZpZnpwckNLWDhKQityUkVC?=
 =?utf-8?B?Znhwc1V3bU1BVkhSelBSQ1BpNG05b2pNSGtSRFk3bjhVbHVWaTJHbVFlZnl1?=
 =?utf-8?B?eXVJTTUxWmFvbmlLU0ZKTm5mWG5rTkxuZmM3NWdkdGd5aklOM0hCaFhxWTlB?=
 =?utf-8?B?bDZ4c2wyWXIzaVA4enNKRHVNN2hMNXRsNUM5WExQL2JoUExxZDJOTHpJbGFV?=
 =?utf-8?B?c0p4clQvUFp4dEdPM3h0bjUxVHBtTkdGOHc1N2laSTRoSXZubXJwOCtmOHVC?=
 =?utf-8?B?MDJ6TjZuMHVHUVpBNzd4WFlycW44WXhDUW1TdXhGbGJCb0Nsa3FOM2lZNmdF?=
 =?utf-8?B?MHlkOE5YS005M2NWNURNdGNrRGZETkhDT1dNZ0YwQ3Y2SUk4ZFdoTmFuZXFv?=
 =?utf-8?B?R2Z3WEY4QTR0ZGlwZGFkeUQ4d1ZBQ3BETHk2L1lacnB5SE5JaXlEWjEvakti?=
 =?utf-8?B?QmJoRFJCV2NGa0doYUtIVG4yMGJ5b0dsNWNLc3FETjZQYzNMZmxjWGxSWitP?=
 =?utf-8?B?MVA0Q01FQ2xyTkQ3ai9aLzJGOUdqakxYUVpNdnExanUvU096ZlFUQ2xVTkxQ?=
 =?utf-8?B?TnhXWUFmSnlqWVZoc0V1MWVya2pnSG1lRkluYkdaZjZVTFJGcTRiV25RRDZS?=
 =?utf-8?B?VFNISnpnYVpVSTlYdS91M1pBbFBTTEtvRkJBc1p5dWNzSStWbnZxWmFMRVZy?=
 =?utf-8?B?RG96c0lhUFJIZzl6Z05SL1UrM2hRQ0p4N1VhRnhNNTk4bmw2dGlrQjlaM05l?=
 =?utf-8?B?a0k1SzNZRHh6MEp0UDFLbXVmOC9ackNaR0Q4cG4zUnpZT3E0KyswZnpGcWlv?=
 =?utf-8?B?Ymw1UVJDZFl1R1o2bWtlMnpMNlJUanlSWWtQR3RFbWZuMmRkNG8yUWV0amJV?=
 =?utf-8?B?WFQxcE1pb2EvK1AzaTVkdFo3aWgyODM3UTBNbWVtQmxqRmFZVERsTWwwakFZ?=
 =?utf-8?B?QnU2SjlpazdmVTFQa0hZNGpoUEZHeXROMk9aNjBKSEgvVGM2TnhLZWxCS3RY?=
 =?utf-8?B?TEVXV0ZrNkJiUi9PcUo1RHNJU2FIUUZhdHlaZTBrQ3hCbDNwUkxSOVE1R0Nh?=
 =?utf-8?B?Rnl3UWFDZUVLTWVpYUhseElWRE4yRUg1Wk9EYy9DR1RLc25jalRDdzhDSTF0?=
 =?utf-8?B?dEpXREJROHBjbTFNUkNhWWx5NmFNSFZ1Mk4vVkEveWVscnJITVdPRzh6QmR1?=
 =?utf-8?B?eGFjYnk3MXZlVHZ3STRuS290MUNUZVVDNGdFSmY0cUxTbUE0N0FvWHBKUkJS?=
 =?utf-8?B?QVlWQWp2NVpUM3U2NitPQllRNWZEKytGdUZTR2x0a0c2b2V0MUE3N2lPaGRI?=
 =?utf-8?B?M25MTXVEUHFVSWFCbS8zb0x2aU83WmFOa0dRZktpZGhlSFRMc0cwZCtWSUhi?=
 =?utf-8?B?TVQxY1YvODZnOGlERG8vS0NJbUtTbnR2bkxGZ2FkWGIxSFBNZjREMlZ5MFdp?=
 =?utf-8?B?K05PaHoxRXF1bUg4K1Y2eC95SG1BNTgwZ3ZBY21ENmFFVUVUYlRIUmdNNXB5?=
 =?utf-8?B?cFdPWm1oUnM4L28xalBJcUFNVU1HVVdXT2N4SHN3T0hDWE1OWTVSOE9xdm51?=
 =?utf-8?B?MzV6bmRJYnkxMG9wVlkyb20xOHVRbm14R3BSanVaK0JZdUlZRXM4ZWVRZ1V3?=
 =?utf-8?B?N3NNbytqSmlER0pRZUFwNGJFajZHZVhMSkpsWTZyWFc1OThZVW8rcHJwcllq?=
 =?utf-8?B?WlhrY2M2bjUxVkdUbWVKRkxjZmVMbU5GVUNoVnVvZnMvZUxVc3FtOHVEVjRX?=
 =?utf-8?B?VzI3ci9nNDZqZVFVWThXNnhqYUx1eEhGWDZDMlhLM2dMMGNpRGhSbmdoTjVw?=
 =?utf-8?Q?pEoXzzZ3QSg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEx4SzJWZkpxVnl4Ulllak5ycWFJdEhkZ1I1cy9NZlRsOGptSXlVZlJFUkk4?=
 =?utf-8?B?bUI5cndhdG9NYTNxK2k3YzlvbWxoTzZLOU11Sm9RRzRZb3ZOQWpkeVZxbDZN?=
 =?utf-8?B?TUtzN3I5WXVZblRXM2JTTitLZFJ3TzN3YkRyeWIzRGQxdHY4VEl4UkhnNjVW?=
 =?utf-8?B?U1FiTTEwR2tFUkhiUzhnaGZDdHV1cHBQd2toVHdyNk1IQ2RueHhiSjN2cjY3?=
 =?utf-8?B?bW82MjU3T0pUNUdhVVRxZlYzUkhRR3BqTlJlQkdYaEsrbFFXSnpGOVdXRnNh?=
 =?utf-8?B?NHNPaDFUOHhsTi9hSmN1L3FKTFBQWVhwcXpYQ000MkZDU2FFMDlBMjU0Q0g0?=
 =?utf-8?B?OGNHUDhIMk5uNUZBTnB2WmY5NDl5SFZqK2xOT2VVY25sTWJaeklXRkVrOTN0?=
 =?utf-8?B?Y3pEa2tJTklWdTFKTytkZ1lDSTFCQ3o1ZW5sRTExZXdoZ044RVBNRGk5a05k?=
 =?utf-8?B?QmtGcVdnWnlUNGdpRGFuU3I4dzZoOXgwenhMYXVRN3FnTzZyVExWYzEvbGZz?=
 =?utf-8?B?cDNaQ3p3Z0x4Y3lVbWJkSEtjdG5hamRjcC84QVJua1NYOUwrK2o3RUkwNnM3?=
 =?utf-8?B?UTRZRTJMclUrdEQ4cDVNOWdvMWNEMFlVNzVoSXRPT2J0ekRobUVHREQ1L0la?=
 =?utf-8?B?bS9hREVkNXRQcWROa2gzRHAraFkwKzhXK1lCd2RYRzFMYjNoZFZTdWJSYm1r?=
 =?utf-8?B?VjlBSVk0bDlXRmNEdEttMmRzcTFiOXZmS0NlelBuS0ZhRWxQTHZ0S2RxTXNW?=
 =?utf-8?B?WkpPNldwbmN0TmlTcVdHNk5qRjRTeGtkR21BR3BRZkFNQzRxNHNpLzIrUkRy?=
 =?utf-8?B?L3JKQlRvSjd5aHVFMklFTHBtWmRSTTNmdU9Zb0VOSGd3K1orZmVEOE93cG52?=
 =?utf-8?B?bVF4NFZ3V2dwZWY0SjljQkp0OFh5cnBiWXRoQTNid3QxN3BoY0lvZUM3N3Zh?=
 =?utf-8?B?ZVR0OVhCVGFPRjFWa0hWNm9SSW5VanpDb1pMeVFNWGxPV2NlVnUwMUI3bXlT?=
 =?utf-8?B?Ry85MFJ3NHhDYXlPMk54M2I0SFYzNW1YV3RwbEVmbEJBOEwzQk4rc1hzMkx3?=
 =?utf-8?B?RnN3QlBQTFMydXZNTVBmK29hdElPTkl6dSthWExyczFJalBwSlpZbXIvWVBo?=
 =?utf-8?B?RkQxQ1c0Q2cxZDVCbEYxbjdCZVZMMmVyYzJmZ0tyYW5VamRQdlBqWHMvZ3l3?=
 =?utf-8?B?QlV4azVxam9jSEt0azhNWUxCbEVoM2tHVDV3M2h1TjNnVWVXcUt0RERWcTQy?=
 =?utf-8?B?b0pkQjhhNktKaVhXSTRiYXBHVXdjV01UT0c2QnZIRmRaYjhZeWkrYlc3RGk0?=
 =?utf-8?B?SzRvK2JjUDFoZzU4eGFMa3BxZit2SmI3TU12citBWm8yM0RpQnJqdWpmZERY?=
 =?utf-8?B?M3d4eW12UWVQbFZjR09TRmRzVU5VY2QxdWtzRkQ2TmxIbXV0UmdSN0ZybXhR?=
 =?utf-8?B?TkdBd0dDK1pOaHZvUDN6ckpXZkJROGJxR01sYTBOa1E0bFhJOSt6ZHozcGhp?=
 =?utf-8?B?RDQzRUZxbGtrN1duR1dQK2VUd2FpQnlkT25NVkFVZ1VDRHovV2pqbExCNkoz?=
 =?utf-8?B?NDNiZzc2d2pJS2U4cXRhTHIvOEI5Nnp5SnF0VWU3VUtrR0lnajdHYlZhb1FV?=
 =?utf-8?B?NDhPeTEvVHIxbDJLWTdoMWsyTzIxV05JcktiZGpubzhmVUxGNTZLSGU4NnJ3?=
 =?utf-8?B?dlJ3STJmcFVZWmtlakRmQk5sNk5zM2trVGFjSlBtYU4zRTF5MXViejRhSHpK?=
 =?utf-8?B?MVJLQkxYZ0g3bFNaSWljWkwvY0w2TGduYUpqWlgyTVdNaFo5Z2daVi8zN3dm?=
 =?utf-8?B?Q0JpTEFoRnNCV0dWejk4MDJjM3A4NjExV1FlRy8vTHFwdW0xWnJ4K1JFdnNE?=
 =?utf-8?B?Nk9LemFEbXRBa0pBVkdMaU5ZS1ZxbXpJQWRGZ0I3a3o1RkxJVUk4SnNrc0lo?=
 =?utf-8?B?ZlNqanRnc0ZCdGhLNVNuVEJicnFEVmFranRJVklWelNidkorYW9LSHE2SGR6?=
 =?utf-8?B?K3B4VmNqY1QzRktIQi9WQ1hTZVF2Q1U4VERKS1pzcmorOXo5aEpxR0w4dFFo?=
 =?utf-8?B?b3dzZldrUUtpT252SGxiTkM0QW5iQzBZQzdnMm1PZXhPSXYrRmZYMmY2VVBS?=
 =?utf-8?B?aUp2N2o0TzR1YllFYkkwbjF1VWZvUGlWZGIrUjdac21oMmFiYXUvc3Zhcmdw?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8119BD21EC8D864B826D9AA7FF89F154@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49683172-9c5e-45b4-246c-08dd5b4b99a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 18:37:21.4261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zd3e4TzfI5+xc34NAvoaHv+JJC10WdXlUtURrqUdz53mSzZAjYsWSOd1zqrtZI1GwWihOhFhww4n3iP2O+KuJeAVLVLvJs0PAFiaZkRstm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8822
X-Proofpoint-ORIG-GUID: MjIA1niGlEXeTAZ2CWRQ_YMJg_SFEZoi
X-Authority-Analysis: v=2.4 cv=ZM4tmW7b c=1 sm=1 tr=0 ts=67c74865 cx=c_pps a=fpyyTn7Kx2iM0+fj1eipXw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=kmqNutOhmeH8vT2Rin0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MjIA1niGlEXeTAZ2CWRQ_YMJg_SFEZoi
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
bCBhdCB0aGUgaGVhZCBvZiB0aGUgcXVldWUgb3Igbm90Lg0KU3RldmUgYW5kIEp1cmksIGxldCBt
ZSBrbm93IGlmIHRoaXMgcGxhbiBzb3VuZHMgZ29vZC4gSSB3aWxsIHNlbmQgdGhlIGZpeA0KYWNj
b3JkaW5nbHkuDQoNClJlZ2FyZHMsDQpIYXJzaGl0DQoNCj4gT24gTWFyIDQsIDIwMjUsIGF0IDg6
MTjigK9BTSwgSnVyaSBMZWxsaSA8anVyaS5sZWxsaUByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+
ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tfA0KPiAgQ0FVVElPTjogRXh0ZXJuYWwgRW1haWwNCj4gDQo+IHwtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tIQ0KPiANCj4gT24gMDQvMDMvMjUgMTA6MzAsIFN0ZXZlbiBSb3N0ZWR0IHdyb3RlOg0KPj4g
T24gVHVlLCA0IE1hciAyMDI1IDA5OjE1OjU1ICswMDAwDQo+PiBKdXJpIExlbGxpIDxqdXJpLmxl
bGxpQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4gDQo+Pj4gQXMgdXN1YWwsIHdlIGhhdmUgZXNzZW50
aWFsbHkgdGhlIHNhbWUgaW4gZGVhZGxpbmUuYywgZG8geW91IHRoaW5rIHdlDQo+Pj4gc2hvdWxk
L2NvdWxkIGltcGxlbWVudCB0aGUgc2FtZSBmaXggcHJvYWN0aXZlbHkgaW4gdGhlcmUgYXMgd2Vs
bD8gU3RldmU/DQo+Pj4gDQo+PiANCj4+IFByb2JhYmx5LiBJdCB3b3VsZCBiZSBiZXR0ZXIgaWYg
d2UgY291bGQgZmluZCBhIHdheSB0byBjb25zb2xpZGF0ZSB0aGUNCj4+IGZ1bmN0aW9uYWxpdHkg
c28gdGhhdCB3aGVuIHdlIGZpeCBhIGJ1ZyBpbiBvbmUsIHRoZSBvdGhlciBnZXRzIGZpeGVkIHRv
by4NCj4gDQo+IFRoYXQgd291bGQgYmUgbmljZSBpbmRlZWQuDQo+IA0KPiBUaGFua3MsDQo+IEp1
cmkNCj4gDQoNCg==

