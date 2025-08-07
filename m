Return-Path: <stable+bounces-166809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0322B1DE55
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 22:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D47562702
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 20:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B290E221737;
	Thu,  7 Aug 2025 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="NwcBwS/3";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="COTQvskh"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF7741AAC;
	Thu,  7 Aug 2025 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754598797; cv=fail; b=V2cHS7QNzPL1ztiuC/vs6A26msjlgWWEJGXLlF8kMGC06Pj2PKQ57/qsLkY6QkX1ALzPSYfma+Fjhy89PXR4qpMUdN1PwtI+osD+ABIRRlrUDDMzKsIsNur+CtkK/VmWcuM5fTZ9xr6B15ZzS82Wts5vjmb7FsdBA5eF+K/OKtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754598797; c=relaxed/simple;
	bh=QnJxqmIJMgzm7Bihqz6991RiWHdteg0wPnxMwjq+Pnc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dS9E02e99yXaFRPHn1gs1BuKVYOlu1sEI3Et9ErrauC5a4XuZ/UFob9weOdlhM4BPP6i5X3NZM9ttN5jXzeMDftCqWJRAW+yACyX6sGJIpg/QJqMYwgxkUaFbrxxnAqdF/j7kdtuLVZx+Fvl+s+2Oi8WHE5hbWZkYJy5Dsbw9SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=NwcBwS/3; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=COTQvskh; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577I0OJK015315;
	Thu, 7 Aug 2025 13:17:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=QnJxqmIJMgzm7Bihqz6991RiWHdteg0wPnxMwjq+P
	nc=; b=NwcBwS/3E+4Fia8qSU+9MKai3vLg8q0AtXieK+TuNxYiCAt3QDxwVVJhL
	mqc8MntK6P3sc1rih6uXZvTDY7svqN3cxaGr8SK1giKRW7EHK+k/bdykA5j1oWgU
	GbFPZQ9ngbyZQR+eGP4Ryq/RbSOJDJAmUInRllzxu6nr9R8EcIaExScBhRpHn3uG
	eTY78h53TcNKoeKCuMqEde9TKnLCxbdoVY5pSMcMQgPkdz1lEkIYdjVR3xoBfjO5
	MnwUw7gBopzxYVmmKNvHNJTICJHXTlG2xA61FvU5ned3OcbZb+HXm1aUJ5nPOmP0
	HqHb43ZUWeC7ozdFT2nm1Q2CGefUQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022080.outbound.protection.outlook.com [52.101.48.80])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48bpxr6en7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzC+6x3YCFHMlcv+Ab2RIYc02aXCndDnjGLrN+W40T/to02JhuCreoY5ubKX6+XLan5fiKLRrbFn/noNZW+OblisTsZEt5raDQW0+YpjCGmQWoI44uUrp3uPBwZ7RDraF4QEraUb58v0Ttnmk+abuL1ry3RMr9DRPreVVmj26eO3fpScgPK2a98tCq730TghjXEbmJUGkmAgl4dpxEvwa1wqud1EBj7V5BOZ7xCQ8h37uXr5VT6VTJtR1cNVeauQNXrwGrgnSRYC8eVJvWmshu9X0iCNav++n98guDP60dfgPW8aBOugBmRF/1krPUUp8aVLKDy6lr5gCIob3Rd3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnJxqmIJMgzm7Bihqz6991RiWHdteg0wPnxMwjq+Pnc=;
 b=PmkaLbYYwMj4LDR/f5k8GRXnEWbwih0qwyD1eGkJ56Lh+aNU5Z16iJL82uCWUvvP9Qehxgz3Tz7TyAuOggZuWn/rW5H53QJsMxzuc689av70SoLumQ2tLte1bYjSGE8yh7ncpAGSHR3IPUT9B0QyruYTTDloFY0OLNmjvbMqnkUThg/QscZYSWvFh1tyPD196oCKFCFfO7rqrKb/Y84B7PEYRhsEbKX8bMtyxgTZ+SqF6rTd16drEo37E/fcTnlQTGNulCBmwqLoqqQaUoUfSfsAwkq1u5wYo3nTw0ItA6rTGY7c0XHgCVufA+H8NI+ZzL0hE/4Pq4mIQvgHANBHTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnJxqmIJMgzm7Bihqz6991RiWHdteg0wPnxMwjq+Pnc=;
 b=COTQvskhp2e8LsYdn3Znjgyxiu4vdL1Hy7DrxI1PRhB16m68XHdcjgD3PARq4OwWRr1DJxvZMiXSg38NpMH5y+63D4Z7hYUDcxFSTY8RaOFw5VQszQwVMJ/khbbeWiJ00mozBWwUV6Tn0xpAJltGVkmpr0p5WqbhZlmNnlnwrsP/BcrzsbLJ5ZZsmYxNbHY4AFSY6C4DB2tRndDFXAApC+eZGRl6ccWkpckPsos9H8CqZOs/CG2mbfMY77O5RHD/f6Lnm8QRBfKjKyd+xkhBwOPGhkUWrZcXOJQAudTT/rEKzmSPYe1A1bsHcEduVZJwcX6f6TmM/Ufext5FijGXRw==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by SA6PR02MB10597.namprd02.prod.outlook.com (2603:10b6:806:404::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 20:17:16 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%7]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 20:17:15 +0000
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
Subject: Re: [PATCH v3] sched/deadline: Fix race in push_dl_task
Thread-Topic: [PATCH v3] sched/deadline: Fix race in push_dl_task
Thread-Index: AQHbqEHDoNXScEWh/EuHrNyOcSFdgbOa0PiAgL2FwgA=
Date: Thu, 7 Aug 2025 20:17:15 +0000
Message-ID: <57DC8B3D-0FA2-4836-A476-4C3104046C88@nutanix.com>
References: <20250408045021.3283624-1-harshit@nutanix.com>
 <Z_YGW8IrRQfhfdM8@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <Z_YGW8IrRQfhfdM8@jlelli-thinkpadt14gen4.remote.csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB8861:EE_|SA6PR02MB10597:EE_
x-ms-office365-filtering-correlation-id: 3cab53a2-8ef8-4703-5e15-08ddd5ef6712
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXFlSW9naVYzMmgxTmxmYWxPN3dwQ01HS3VSY0VnQ0YxR3E2WEh3R1dHK3ZX?=
 =?utf-8?B?Skx4UXlvRGdEbHRrNjdwazgyWDlnNDByeVVnVWZWaVNsOXRHY0tkUmdadUhv?=
 =?utf-8?B?RmtLa0xuRkduZUMxT0FrUzhucHFlek1LQTZlRVFOOWdSQVJmUEluWVFod2N5?=
 =?utf-8?B?VjMyV2oxSFpRUmk4TVRXQ2U5cVpzNDdnVFVBQ2JucmRXTVJVTUtBSkd4VkVs?=
 =?utf-8?B?RWlUbEh6UzRFWmRzblREaEI0VTlNZlM1YmM3WU1FNDVaTlVRKzg1ZmNNaURE?=
 =?utf-8?B?bDFzc0QxL3BZNGNaWmYrdml0elJnY2d5RTJMWTMySmRrYW12a25OWVZYNXpZ?=
 =?utf-8?B?ZHEvditJSnJaSjNEQnZDKzRrNnkvakVDQTEzd25GYjRWVlc2MVEyYURIb0lK?=
 =?utf-8?B?VG5qWjRKNlZ1YysxUjJEWlB3ck5lOXBiMExoTWtSM2NMZkpaOXhXTGFlQkFP?=
 =?utf-8?B?dG9mWXZlUHRWRlo5Q3V0eWs1Z3VsV3F1Uk9tODYzdnEyT1ZRUmIrTnpPQjFN?=
 =?utf-8?B?eUU1N0ppcTlyZnJtUFl1dWF3bDhYU2hheXdJaGszcDJMVGU4djNyMU44QUxT?=
 =?utf-8?B?Yzk2Z1gyMlpKNjh2SUNEdHVId1lYN3FIcEZWL0NoSWM1ZTZUQTFRKzBhaHJy?=
 =?utf-8?B?Q1poM3VncTA5a2xaUVFIaUlXbXpCbmtHWkhEYlkveUUvU0lQWFdWeDhzdmVV?=
 =?utf-8?B?YXNQWWJGZG9rWXVGejFIeXBvT0cyUEJhbzViaEhWV0xzejMvbWpCZ0FPdWNl?=
 =?utf-8?B?azRabSthclBqTHNyZUw2TFhTNGMydThtN0hreWZPMWJvUmxtbU5JV3M4LzJa?=
 =?utf-8?B?QnhHNlBVa2tHWkUwTmpBK25IMnUxbWY3REY1Rit5MjVOWEdNTmErWlBFd01s?=
 =?utf-8?B?aXpDNnQ4dEN6ODZ2cUtLR0dXWlpPdm5LbTJNVGNBNXRrVmtMY1hXM0dRMGlY?=
 =?utf-8?B?M2VlTy9Nd1VTWUNLS2k5KzFWRExSZnA3eHZSeG5ucjV3QWZyUFdPVXlsRE1z?=
 =?utf-8?B?ZHZzTXBjUE0ybmIwbzIvRko2ZHBqMWJOMUp3cS9kY05oYUlmOEZVMmI0S2pM?=
 =?utf-8?B?b2hIdVpuM3VxUTVxT1ZYcHE4ZWVDQlBWZldTQmtFSkVRVTNoMWt2UFVDbkhM?=
 =?utf-8?B?WWZBeVc5Y1dzZUhzQUtNRnFwdWErcGtEWEQzOGt1QlJwMnlZaCtWak9XSXcv?=
 =?utf-8?B?dnNEQ0lza21ma283VS9pYm9pR3poamh6R2trVmo0SGVHUGxnTng2cjRSSHdj?=
 =?utf-8?B?Ym5wODk3R0lRYmRlM1BQTXUzWUorS3BNVDhsd0tSMEtza1I1WEhhVlVSSG5l?=
 =?utf-8?B?SktJczllVmgwVFBETmNMVXFqRFNZc0J1d0lQYjN1RVluWnRrT0ZZNXJaTm9x?=
 =?utf-8?B?YUhuTkk4ZDJDN3Y4K2JUS2xXZU9vMmFlZlI5UUxJM3VLR05ZeTU4Rzc5Vkc0?=
 =?utf-8?B?ZWVBYmZ2MjdDTUl5UThQR3RMZjVzb0NwR2JNRXBQSEx4YjhzdU1WY2l0U0tQ?=
 =?utf-8?B?T1ltQkkwc2lrckRBcFNRaEpMUm1mMjFmNGd1VkJ6Wk5oYURISldPajJLNlhh?=
 =?utf-8?B?dVp2ZWFDdnhVT2tuY0N5K0NwR05FRmV6b3plSXhZRFpVMyswamczQnBTbE52?=
 =?utf-8?B?Z0d4OE81Z2hWK2k2YkEzSk1hNVhPRHE5Qnl5WlZpT3J6ZVBLN3Z6K2RqV21r?=
 =?utf-8?B?THQ3WGtPM05NOHZjN1ZIWmJsRG4xVTNJajM0REFoU2lnaGZ4TVhaTHduc3dR?=
 =?utf-8?B?L1lwenhIZ1l0bzdyTnA4UjVBYVcwUnlaOGdlUHlocmtQL2tTc1AyNXR3aW43?=
 =?utf-8?B?TnIrSXpYY2pxUkN0Wlp4cGhmQ0FRTlE0Mm52ZThxYzcxNE9PWWIzZGM2R1Ez?=
 =?utf-8?B?OGRQMWtScFNsd1YzRVVzeG9YdVVaSzhRMkRGNHBFSVlJN0hRUHVDM2U4U2JY?=
 =?utf-8?B?cU00QUhiSnplS1hjY3pwcy9Qb0JFdFc5UDdEUnJyL1JCa0RhLzExbHRJNnZH?=
 =?utf-8?B?cCtaeEVWODBnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bURTVGt2M3M2NnBRUkVndmRqSjVTNTRHSTJXZkF1bmd0NnhzS2FaK2llVG9P?=
 =?utf-8?B?NGZHS3N0dDB6bXdaWk5MVTIyR3VRREJoYnhibzhhOXMyc2NmQUMySXJ1QmhD?=
 =?utf-8?B?d3dyZWVEUXdDYlZnTytHWis0MWxPZmdqWVhlbVQrY3NRd2pjRGg5SjArU3VS?=
 =?utf-8?B?SFplczQ5VWRtZTRDRFN2bWNOQUhwUGU2UXUwVWFXWTREdGVjVDZNaXhYSVk5?=
 =?utf-8?B?L0dySWR5TUxFSDV3ZFBMbEY0a2NWQm5BSHdjMnpVNFFJTkZaV29MV1B4aC90?=
 =?utf-8?B?WUtBbFFsVXNrWVRHOTBwOE52SnhkeHFxM0lOYzl6MUhaQTZWdVptM0orY2RF?=
 =?utf-8?B?T3JNNGFYclBmTkZtazJJM25wQ3VGckk4Y0VTZWZYN2NkQzZRSUlqUkRqVTZB?=
 =?utf-8?B?YktMRFZBaWJKRUw4aEVmRGZ0dkJ3VG1qZHhZa2Z3Y1JyZHBzeFpFdWJwY280?=
 =?utf-8?B?b01xMU5CZkxhM2p4VWh0QTBvdHk2OTExNVJqOFg4SXprclA4VTZKVkJ2MTVl?=
 =?utf-8?B?eWQvRGJlQk8wUjdvSEhaVEJHRDVQWUhPRjI2ZFhmTEwvUXZpYmhDWVBxUUFq?=
 =?utf-8?B?Uk9rMWpzMG15Q2JMRjRmVUZuQ2x1c0dmK2pqU1UxaTdLbUZRNHB4bEhZYjI0?=
 =?utf-8?B?a0w1bTBJZDhsK3VLMVVaMDF4VEhWZks3U2tXaWx1UmwxWXJqbHdub1crN1lu?=
 =?utf-8?B?MnVqRTZyOUlDM2trcm1wTTJRWEFTUlk5Vlg1ODR1OHR4emsyRHZRSnJBZ1oy?=
 =?utf-8?B?VGFzdXR1UUMvUmt0TkFqUDlrUEVXZ1RBUGV4QXRyenJzRVFWRXA2SmZzL2di?=
 =?utf-8?B?Q1ZOSHB5YlJmRzdWMGZtRk42UlFuamFsWlFjQ1VOdXFyY0toLzlZMEpQMUR1?=
 =?utf-8?B?aHdCWTNDdm9BMStLSDFwcEdXMklLM0x6QzRxVitzV2Y2ZmZTS2FnN0tqcThY?=
 =?utf-8?B?VFk1Q0VrWmEyb1ZtTkhQOWltcmRjUTVOOTU3a2lFVk9KS3JQcTBXRGtSZXp5?=
 =?utf-8?B?VXVVS0RzR1d1NGF6YVB5Mm5IejF1SWlNaHZ0ZTZPTllDckFOdzNvdVdvWTBM?=
 =?utf-8?B?TUlwV2RuOElCRExPRS9ubUpaT2VhU3d2VTk1TlZRMHlyNTFreHc5K0FIRGIr?=
 =?utf-8?B?Wkpic3RaRGtnTW1ESGJQWGpOb1ZDcU9Udldldm11VWd0YlpJazhNcGwwU2pO?=
 =?utf-8?B?cUlTbFhET0NmczhXVG9oNFZaeWsrRW0zUHB3TjJ5WXhrQzRZeTZSdHgxMzV4?=
 =?utf-8?B?Tk03aHhrRmtzbXdIR09JYlcxMmpkT1kwTk5wZERYZUdYaUUxMWl5SnFCcmxa?=
 =?utf-8?B?a0dXNzJJWjJRVzU1c0N1REk5NjZmdFF2WWRkSXdsTVBTWUZWaXJIL3VqOXVK?=
 =?utf-8?B?aDg3a3RhZjBFZ1BWclJGQzQrZ3Z3Wmh6NFVIeERsNlN2RS9VNEIvY3VJc1N5?=
 =?utf-8?B?TFZ4T2l0WENGeFQxQjlVNDlBSjJoWE5XVDZJMVJBWnNvRkxrSzVHQlorRTEr?=
 =?utf-8?B?emZHRU52YUplMmZ1Y2lJeVEzUHg2SXVESW1sMFN6dHhIVHdIMXlQQXhNVDBP?=
 =?utf-8?B?SU43emttRU0vSDVzL2U5aXFOMzhwUVpWaVFUaGt0L3I1TFRTVVZoN3FYTEV4?=
 =?utf-8?B?YUxKNjJqQllNdmxEcWhEdHZPWVNuaTFQOWxTcmROT0MvZjcvSFhZbTlNTzZG?=
 =?utf-8?B?clRmQWxmMm9KK1MxZzhvWWNadGxBN05OR3hoNEJyVDIvQjhBb1pBdFlDOVZu?=
 =?utf-8?B?cVRsazBmdHV4dUhzeXVIVTdKbEEzaVVQQXRCb29aV0l0Zzg0WUtVbVU1d08r?=
 =?utf-8?B?M2x6YlRlZGxkZndwSjF1M1h0dkdDVHBwaEFQT1RjTlg0NXhJUm1tOGxXWkN4?=
 =?utf-8?B?S0hGZXkvS2ZyR0ltSnlUdVBsbkIrczRVNUpOM3ljdlJEcjFPd1NDOXBCbW1W?=
 =?utf-8?B?UjBBelprRlgwUnluVC9rY2VGTWdRbGxSYlN6Y2E1eWtxNnlJQ3RsNUpRcnV4?=
 =?utf-8?B?YVhQMkhJQ21wZUxnbmo0YlVxcXphRGo1MGxNTlg1d1g4UWVDUzR5dktPYklw?=
 =?utf-8?B?NDNZTWd2aU82TnpMSkppZjI4aFhUamwvNUZ6TEEyYWEvakNhMVJTb2NEYk9G?=
 =?utf-8?B?R1cxc2tXVmZBcy9UZTdpZklkbmJ2OG5rYjBRWldrSkhTbk1DVWlVL3lCUHlp?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1480AE4637974479D75B117037D5F50@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cab53a2-8ef8-4703-5e15-08ddd5ef6712
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 20:17:15.3900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KErwar/c/bJ63kEvQsiE6R84HN20tJJb+zPvSpcP8goAd9K23bMQE17LWX/LYQBYxTXUpV6Ea5+5TB25xK6PCfAhiJIpaiqfyT6tZGS7VX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10597
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyNyBTYWx0ZWRfX6CxoES9TZrXT LX4T41TH0WITVUzxfTNS7s0Xaq5kuqpNWujbOw2St2Ch15u46dxB2Fh57tO+5T3rSFRf26Sg7Hx T8Uk6nN8ot7de27ei0rONJkdNIdP19JvDTF6AXF+uR3kI8XzdBEnaZy/r/KF/kiLlnRKorKNd74
 6sDunkSsJle6m357ZhuJXoduKYcpUxDxYt2CRQVrDSL6ILMECU9f5lJS4BRr/tzxGyCIjRlZJyf s9/5GGEAkezuReiXX8HRqUhHrjdWEJsUSV6m7/Yl2DKlJvVUfbjZ/2vCdwdydBqYsX5uVuiSHXZ zIxmmEP+xknoY3R13dq0RoDL/+RA6xqOGv3da7+SpRIY1dbXT0NepD9Vf0VK6ogMmzAqj05mSfx JDKpWYRF
X-Authority-Analysis: v=2.4 cv=IO4CChvG c=1 sm=1 tr=0 ts=689509ce cx=c_pps a=l7AlRFJyJD7ZaDWTaO3eeA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=8FvfGRrCr9yIXM-yq5oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8B1PLxkjGJ1u-4Idx2FQ-7zERi5KAi-k
X-Proofpoint-GUID: 8B1PLxkjGJ1u-4Idx2FQ-7zERi5KAi-k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

SGkgUGV0ZXIsIEp1cmksDQoNCkp1c3QgYnVtcGluZyB0aGlzIHRocmVhZCBzbyB3ZSBkb27igJl0
IG1pc3MgbWVyZ2luZyB0aGlzIGRlYWRsaW5lIGNoYW5nZS4NClBsZWFzZSBsZXQgbWUga25vdyBp
cyB0aGVyZSBpcyBhbnl0aGluZyBJIG5lZWQgdG8gZG8uDQoNClRoYW5rcywNCkhhcnNoaXQNCg0K
DQo+IA0KPiBUaGUgbmV3IHZlcnNpb24gbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IFNvbWUgZmlu
YWwgbWlub3IgdG91Y2hlcyB0byBjaGFuZ2Vsb2cvY29tbWVudCBtaWdodCBzdGlsbCBiZSByZXF1
aXJlZCwNCj4gYnV0IFBldGVyIG1heWJlIHlvdSBjYW4gZG8gaXQgaWYvd2hlbiBwaWNraW5nIHVw
IHRoZSBjaGFuZ2U/DQo+IA0KPiBBbnl3YXksDQo+IA0KPiBBY2tlZC1ieTogSnVyaSBMZWxsaSA8
anVyaS5sZWxsaUByZWRoYXQuY29tPg0KPiANCj4gVGhhbmtzIQ0KPiBKdXJpDQoNCg0K

