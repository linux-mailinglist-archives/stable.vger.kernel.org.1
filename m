Return-Path: <stable+bounces-120371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D13A4EC12
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 19:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD407AEC9F
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA8D2E3370;
	Tue,  4 Mar 2025 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="A2iAQhox";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="XL+dCjmh"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01BF280CFC;
	Tue,  4 Mar 2025 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113160; cv=fail; b=MCmg7ExGVaXoURQ+zbqRmlmrMwBJWooOsFR9colUFy1vBcuFoX28KTu8EdbfbbklRTKUa8orxxevN+lGeLij+5v2hnQylyoYHMNczmJOrS++6TQBwCCtRoodVlbRkuQ2HJnJV8BgDzGJZorwusY5KfT1SRqaAmuglmYw8ILc3lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113160; c=relaxed/simple;
	bh=GJ73Fi1ntHNNipKwmmc6xlPEng3Aa9+EiZeoMA+fvGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aYm0Hrd+3HZUzUhYUKeT9c8j1QFfPaa+QQVPyhugUhLMN2ktPWXgQX9e9chVJ+cvjNr/LzG3Gx8zvbi2n7/SHQDPb1TvUFAg7E1GNQcd0pxcQNWnSuNhTFrm6CkuthEGndZX9SLiRV01qGir9rC64iAW4zHDGWc7xdjCTsRC6Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=A2iAQhox; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=XL+dCjmh; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524AMFoq005476;
	Tue, 4 Mar 2025 10:32:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=GJ73Fi1ntHNNipKwmmc6xlPEng3Aa9+EiZeoMA+fv
	GU=; b=A2iAQhoxvlpFcJ9TzzwbJ7XsCx6JWtV7rLofjeKW3oBX2yiGYQkRES6Br
	Nmjl6ONFfsgJbWzTpvKrveJVq+SkSzojKyxJNYrsOI8arytsYROT5g2EZs+o2pbO
	B1MPWyfzffSVhhi24u3+tVWvhMU4ESJXrksKsrAYtXH/v01kPxJSCmJdMN+Ar+wW
	OgmvSRiPemZZEQDlGXkL6qOYpwqpiLe1s1nRtoSbDY+nhUHnPrePO5BcbwlKQuaN
	Y8gDAF2xKSISDnUqIomcopnpjRXl6FK10Myvd7eFr8KAC7tWoFUckSd0+PpePTnI
	JU7uADFIJoHTdZ34vukG0r8vkeajA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45417nj5q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 10:32:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3TBaLXGh76i7u/dfMQAHgkqalIZaPo1dLYxGuvMpdX5lACO9y6nqiwy2s7LIvdNF2d+3BeRiv1/V8U5Yp2mdiTV6SyGXgC4cB6QtekWuzEHK9FKuape0e4pMHlw7CjjjeblqwbEgEhi56GXRW88FfSqBsJPLgE0yz3K3+P+nv9UOPyDTNkI+2TxfVLf+9Zo3DmG7eDf+I9RpcvyRb2pDzfYmGdTW+YVq3rTx1O5jfGVj8JUKZ9tCv0NQsX0uZUnoU7o9ayMkmRTdoUcpIm7v9jND6QQBguyh/sD4VpX632b2/B6vHmdaIJVLWJmbMy3NzWo07jKn2aMu1N5V9U5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJ73Fi1ntHNNipKwmmc6xlPEng3Aa9+EiZeoMA+fvGU=;
 b=HSw27fB49W1+FMIY0wCu5iJYeajgmYk4AIDWhD53TOGCEZQu9pFhUP/3+5Ewff/0vG9f+XTD+7xwoyt3WXpUeFAYyUPTuZ21m7V8JcYaMw2+DTAL3CLLULq76pueNcgqZV/aFnz5R9/+rU4An7k9Jec28Vk3RIdvwnX5Fdf2unRtrcWof5srO1kbpI2HFB9H1VasKN+xmC/wicbMTN/6EzZBzJ+TZ8hAUFpmSdkrCYAsaFcPEP4MRoXMDbfTCaX/iB3TcvskZCfIcPVxhMTua8uNt00GlLaVX7es89PnO868yCgZ+EbJr7l3GldbYjUpdMT/sKZ3KeCzRismtlDQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ73Fi1ntHNNipKwmmc6xlPEng3Aa9+EiZeoMA+fvGU=;
 b=XL+dCjmhy7s9k4ZDwRw0gmjf676bzIp28D/geIiT5Cl4E+c7iK8XTp5kx9uGKAZ1NvAKqtCN2D0iwre/HdP4AdTjD8X3ILWAPK/9z/cJKePN6Kth8ze887vpO6GB9Tymb6dq5zVgWGVKeAqMlRsaUPj5YpZlFEmQ4q9VeXgP7WX+70QZqWvmX34oiL3AJpCu8tvClixMqo75wtYYJBl53cMDdadNbdHZ9y60HDJaKiyXOHCQb4XBUeTicb/ICe0XvvaC1J3Gl4QxC1nam29DEkIiU9jDzJiAQfx7XcOMW8antcOkqY3LFA/jK1k1v1Ff33MKCUP44oks0Mgn63DL0w==
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
Date: Tue, 4 Mar 2025 18:31:57 +0000
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
x-ms-office365-filtering-correlation-id: f784ce2e-4076-4c04-ec15-08dd5b4ad8d5
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TEFaSGFRaUVJMWhNQVhIeGhhWUxQSVpRTWtiUjdnRFpjK1dYK1RVa1RiYWJE?=
 =?utf-8?B?b0c2RWg0a1VQSVRHVWV3cGdFbWVZYWpCYU5GZ3lZRk13N2tWV3d1U09wTmlU?=
 =?utf-8?B?bmFCaEZYWXN0VWI0WGcza1BVOUEvUHg5R1U0R21HWk51SGo5b2ZiUmg5MnBS?=
 =?utf-8?B?NmgxK0xjMmlSdnJJU1FreHFMREVhRlAzOFlPUlRHTUR3V2FIdnNpeGt2QndB?=
 =?utf-8?B?OXQ4VnBJOHg4U09CSHBPT2pLWHV1Z043YlVkT0ozRUNHVHdXa0tMWVVXSERZ?=
 =?utf-8?B?NEljeDFGYTZSSnkvSDQvTlNYL003WEJYRnlrYnhoNVRqRnNyamFEQlhDTWdJ?=
 =?utf-8?B?M2JGN3pRMFFUeXZlWkhmRVVDazhKc0xCUml2Lzc4N0NMZjRvUFF4M25tYVN0?=
 =?utf-8?B?VmhoUDYwMTJxblBuQTRyN0JsNm5mV1Nmc21YSzFEQUJQWXY3QXRJUjhneU5n?=
 =?utf-8?B?MU50UGhYTGltb0JnQ3NoYjVXVnpZcTExejdwZTJGTjVqb1ZZUmVlT1NwbFRx?=
 =?utf-8?B?Uml0cTl0TUxvelBQUCswNlNrZ0RqMVVUTUtDeERGWkcybDVLTjJpUFV6TGdR?=
 =?utf-8?B?SzRkQkNTZnVUZGx5WGV6M0FGTzNHblViV0ozSXJ6Tm0rK0J2ZVNRaWE5dk95?=
 =?utf-8?B?a1VNSEFnOFpBT0o4SzYySFlwUlVuRkJFU3NzTTVlSkpaSm5sbTdLVFQySUY1?=
 =?utf-8?B?em5pa2d5TGRwT1VDQmNuYkxnS0Q2Y3RXTUx5NnhuZVY2T2cyTzNlWlBhRDF4?=
 =?utf-8?B?OHRGWW0zZVpCVUxudUVxNDBYQjQ2Z0U3MGxnbk80Ty9PYmt5K0crNHR2NUov?=
 =?utf-8?B?STRueitBTXN3eGVEVEhBdVI2VE9pemx6VjZyL1FKaU1POGxrOHArVk50KzQy?=
 =?utf-8?B?TjV5cVQyUUhra21wSWliclJsTlEzWi9QTlNkOW9PVkF1LzhHaDVKRlJnaFRJ?=
 =?utf-8?B?S3haWCtQUkY5WUpMTG1SQXNYZjZwK1o4QjNrUlg0NEZuWGpPemlhZktEd1FT?=
 =?utf-8?B?QkZNTEhNVDhnYVFZZk41Vm9Gdnk3OTU4R3VzaWNHZHE1T2Mxcm9EYnBtRUxZ?=
 =?utf-8?B?S0xkQ1IwSUVXajJkR2JTRjlVbU1lN3JqVWl6ZXpxWEw0c3cyN3FHNjdpMGY5?=
 =?utf-8?B?MWVINUVLdm5Md1lseVFYWUZIdVRQVGRib2E1ZDd4bXd5Vkx4MnBldG5FNDVS?=
 =?utf-8?B?RnJWVzM5MVFQd3ZiQmdYMTQxNEVwN2lrbENmV2MvL2JsL1plWHR2YncwTTNI?=
 =?utf-8?B?bEU0cGtqUGpkTHdVcWRubklaUnRxMGZXYUpnQ3lmNnZzQlBHbW91b0hEaWdW?=
 =?utf-8?B?alVEL21LRTluT05ZbkRSTjk1VURLcHBRZ0xFOWxUZGlFazg3NG1jcVU4TmJi?=
 =?utf-8?B?eURxOUFCUXVaWHpUdlBwRkV3UGE1aU5RdEFSM3NaNE1DWE8xelArN0tGU2pu?=
 =?utf-8?B?eHE3bC82SnVGc2lnakJPRHdVQys5S1lpREN2UENEN1llb3JNY2k1dWpkbFdG?=
 =?utf-8?B?NmRza09raU9YUnA3WTBqV09va2RiMlNxVUxlUUIvem96T0RMQmZ0OFU4UExE?=
 =?utf-8?B?RDlaVkoxNjZhdm10RWNWdzVPN1VGSWNtVlkvMzRmNzRmV3NTTkd0RVp5QkRM?=
 =?utf-8?B?YS9yL3I2OGNQMVFjSGdGTHNGci8vTk9YYUZyN3lwYjFtaC9JaTBPTlU0clpY?=
 =?utf-8?B?VGZncXMyNVlLQXJaM25LREZBb0lkM2ROSDlzL3A1MFlUMERZQ2FFL1phU3Zz?=
 =?utf-8?B?NHZyYVF1d2VYUCtzOHJiRkZZdWJUL3g2VTFpdnJVQjVRMWovRzFUWGhxT3Bi?=
 =?utf-8?B?anM5RUlkWUVGVW82YTBjQ3NwZkNqMy9ETEdoUllmOHhCUFNqNGZBRFNPV1Rp?=
 =?utf-8?B?YVE0SnpjREtubFBLYk42Znlvb0VUMVlCdkRRRmtHSWo1T3JZS1hncDViMkw1?=
 =?utf-8?Q?uZNkZsKsBaw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHk0ZUVoQThobUpCK0xJanY5OEs1eEp4TkFQOHc0Z1NxMU8zRlBMN2FLUGMz?=
 =?utf-8?B?aUl3YXFrb1ZaaythOEIvdGNteFF3VitOR1EzandVOHFERk1odVZ5d3I3WWFS?=
 =?utf-8?B?ZVN0Z1VWVFdBeHN2WGZNZUpoRkMzaTlqdVA3bXNNVVQvdjlnS3VLRExUU3kv?=
 =?utf-8?B?eDA1ekRYL3VJdC85bnJuUnh6aFhFejF1NFRmZFJFKzJKQktEYWNxb05XdjlY?=
 =?utf-8?B?VERqK2lKY3lJL1pLZ1lsc0VMZ2lRRlUxelJOOWVReERSTStXWWdHcUk3Uytu?=
 =?utf-8?B?M01XM096T2NxYldnZEl2bTNUZnNKUFRJS21TUzNsNngrZjUzQ0tGbXg3RVkr?=
 =?utf-8?B?SU4vZmk3aEtIVEg5UDZoeVZMWmZ5VmFOQzFnWEcrZm5pSktvSTNqaDVna3hk?=
 =?utf-8?B?SlQxOXVGQXNZdUgzWDVLK1poY215UExiL25MNGkvMmdZMUV6NWVucW92L2pv?=
 =?utf-8?B?Nm84ZmliQmdJOUtUNWc5UW9yQk5wUDV6RHFlc05UdFgwUkJ1bldYQmJwaU9K?=
 =?utf-8?B?b1lSSVFibmJHQ0FmemNBVERwK0twWlJFbkxhL0hQVWF1ZjN0aUdIZXB1Qjc5?=
 =?utf-8?B?K04zblhWZ0d3Q3lvbWMyRFpBcHlnUVJFSFNFUXcwRDRIVWplNzl2L25OTzlr?=
 =?utf-8?B?a08zTnNkMTlET1dQazVQVVFhVHRhRmxGaUdnM2pqdUVJeWxtVVY0djVjZ09Y?=
 =?utf-8?B?ejR3T3BwbGl0UGN1RHJKVEVpSXdtYW9ubzRmMlVva0ZGTUxEVGppWjByVmlB?=
 =?utf-8?B?SlZONUNhc05ONWNsUXdJOFI0VnVMZjZCWDVXYVhWMGF5dmpkUDRKK2FTMTBC?=
 =?utf-8?B?ZWdlMkd0YVVmc2hFUHozelh1ZWZxN3hqemIzNURzRklhKzVOTUpkNnNpSVVY?=
 =?utf-8?B?enp6QWFmakJIZFJiWktYblNQUzg1YlB4aDlXMUZNd3BZQVI1UTRQUzJET2VE?=
 =?utf-8?B?ckhaMHp3WUJKdVV2TnNuWUVwRWJQTXRBeElBL01QSk9FMnc0YVNxczVzakJv?=
 =?utf-8?B?bzBoWDJXWXlLYVZHL3N4YzVGNnZ6RmJMWmE1M2dWMEZRMkRjSmkrM3B3TTJJ?=
 =?utf-8?B?ZC92L3NQK0FmektSY1diZ1JSOUk0VksxOUMzZzRaVFQ2ZUJRcXpLTW02dCtx?=
 =?utf-8?B?Si9weHpXZ09RcEoxM0M5ZTV5dkQycU9oZ0FFMUpYK3N2K0FNRXpnenFLS29h?=
 =?utf-8?B?Rkpzai91MEV6YnlBM2orQmNNREZ0NERDNGJsS3B1SVhyT1hYRzFyRlFtSDZl?=
 =?utf-8?B?SlRvVmFWMEdkdm10NW15ejd6dkJCY1VXaUo2Z3NOZVRXRWZjYzVTQW1FT3ZJ?=
 =?utf-8?B?VlkzeGZ6QS9zUzkrZWpjRkp2ZmovMUFJdUp3L2p0Y1hDUzFrYXJjRThQdmRN?=
 =?utf-8?B?WHRTbks4VWZQTDF4NnFiZFgwcE96ZzkxeUhiMXhDR0lnNE1aSG1YWk9mUmxq?=
 =?utf-8?B?Z0JyWi8vcEVEcW1YZ0F4NTUzQmRVUktoTkpOcUJiWGs0dHF5YzlremdsR1I1?=
 =?utf-8?B?Y0JCSVJGVWhsM2l2N0hMbUY2NXUySlZVb1U0ME9mUTk4dUttOWNZU1V5WHJS?=
 =?utf-8?B?UUw1QXB1NkV6d0kraGpPb05MN2tqY00vanpPMnlKZm4zVkJCdHE5WWF5T0F5?=
 =?utf-8?B?dEtoSXRqY1ZRdjQ0Vlc2dFJwUmNUVUhIVkUrdnBCR0ZUS2dQazJRcXExMUxL?=
 =?utf-8?B?QitWNG9lc0p0ME9BeGZoN29YY3RlSjZQbUZBcEtZZDNpTUdkU0tkZHNqNlph?=
 =?utf-8?B?VTlnenBiQm9iVkFTaCs2VWM2c1BSOUpaMzFWb3JyL3RWZkdCak9Ya1lwdjUw?=
 =?utf-8?B?MFVLWHZhRmlnc2w0bUVIL3ZWMHJEbFA1N29yRlZ2Sk5iZ2xjbTBrL1o2U1R4?=
 =?utf-8?B?WmNTWlducWQzZHhWSS9wQlIwTXhUa3RmTWxYeStxZVZtMHhTcmwxNFVsVEg4?=
 =?utf-8?B?UGhLUmNRQ1ZkajQ0cldvL0E4UHJadVJFa3BQYmhlL3haVUtvZGF2bnQyenNq?=
 =?utf-8?B?K2N2bHZlZVREMTdKWG9IRGJoM0pCMTVlVVRHR1Y1bHJ2RTcyQjNqQThMMkIw?=
 =?utf-8?B?RkQ0VHdNZFJnZXlSeU9TenZiWGI3Vzg4djdmdEpBV2E0ejVsMjBwdy8xYm9i?=
 =?utf-8?B?NjhxN1MydlVFRWpUTjZoOEFkcmZyQndYUlFmZVoxQ2RFdTN6Z0JRS2RvYzhW?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A91C93256310C47A2D6628CC935421B@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f784ce2e-4076-4c04-ec15-08dd5b4ad8d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 18:31:57.9719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CcrFpqf4whF1g1h41ni4qGnoFqtmtYKBLbFfBfXr0jHk5k9iteKadxn0hkvfaD5J9jP8omjB+to/Y5xyxCn9uae6YERCYeLNmeUkc2L3wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9385
X-Authority-Analysis: v=2.4 cv=Ltxoymdc c=1 sm=1 tr=0 ts=67c74730 cx=c_pps a=dIBsZBmI1wyUZqnlzmwqRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=0kUYKlekyDsA:10 a=20KFwNOVAAAA:8 a=kmqNutOhmeH8vT2Rin0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FFjI0-VZBOTEYgHnNaZ26IPi4t2xX512
X-Proofpoint-GUID: FFjI0-VZBOTEYgHnNaZ26IPi4t2xX512
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

