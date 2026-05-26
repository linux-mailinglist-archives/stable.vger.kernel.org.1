Return-Path: <stable+bounces-254424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKijFZPqFWrGewcAu9opvQ
	(envelope-from <stable+bounces-254424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:46:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C06E35DB86C
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 355363036F9F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5353BB138;
	Tue, 26 May 2026 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TXrkWnHj"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299853446B0;
	Tue, 26 May 2026 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821109; cv=fail; b=SFXalGVp45rWYcrhATR40pdqIDTz58EbnqswS7SuWiq6Qjd9QrnPgTCAAW6CJMFslSUpvZuODcHFD9D1hxK2XFyn6YABSSX3wtGABFB7gy5PPHDnhfxVA9Z/TluKZYYeK0wzPHyLnxubAGmIAPg/HuIc1HUbhdNrTL4tvV0Efzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821109; c=relaxed/simple;
	bh=8ZKGUIaZuyfQsJPW8ukKX4DYC3GHexkmMemCTjBa8PI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=X4xHAu4ql5jYr4fVdpKlXvBjsj+evVWCkcPx62sAVW8i53/jC6IlzcL6mclW6M4k/iZSIw24knGUeg6a7XncyHAfliiUbjHFR6ndU1G0v+YwD168/CFZSgHfdal6m4KGOBR23/RDcifIgNDes7QueCyhTMP/yZswUL0z6O27tCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TXrkWnHj; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QAj7fI1701412;
	Tue, 26 May 2026 18:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=8ZKGUIaZuyfQsJPW8ukKX4DYC3GHexkmMemCTjBa8PI=; b=TXrkWnHj
	X/GP3+86zSLX46D5UiH/RXgUjQHmQ3v9srDc1q23s9y0SUO4I7ywrOb9VZtwCGY+
	uWblD4juOgY7MmEacNrqLy/e+4JTDFEhES+WGNW1J1V/XQOUTzHc+Vx0LDqQZH5L
	JxI/2iJsOOBVodV4kL6eTLbcGrW0vih1ZOqFetszqJ6BKIsXeZ4Xv2hrIg4qM0Bq
	+xynkhAENQk9qKgbmeNAj3Nfgm4KCljT07FsBys7GmrX8K5ObRFdO+Ums4URqydI
	HPvcO4xFsrSyhSfrsMz5f3fOVzWkcFEpfO7rHWKQYHYblJ4MmBKHMCMVuWgdSCxN
	n33gw4Mh764Wpg==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2dr7j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 18:45:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEnVsog97IC9oN/O3jFUEiZQg4Cxjc2yydIy5f7RTgIwK95iBz4aBLr36xMLiv+nsMfx82x8wNyt4kBwrCjbE0USk70DHd4FAx/8+eFJr4LMuupJwwIm+hcPBYJglgEdxfoz5yuqNie2+QdzjRvidXKpcpXr2IobrhNyz6hq4IporlVav8FsyEnnQluHMqlBJdweVzjEabrgMimqRrMnw86Vq2cwOGTS6ckfBACUDfWd7XuMUhkAaNv9tdoDsUZ43yREevG1TVwyshImQcrTi97PvJrM9hZ+aBHTqCmtqS72sl0/BQWYypLorQySUKPQEItcE5Uyv/BgI+SEYsMaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZKGUIaZuyfQsJPW8ukKX4DYC3GHexkmMemCTjBa8PI=;
 b=KVgGqVad6q5dgMyhptOD6PKHYAJs0m47+fpyVU3DfR2LEPiI2hasgCzydPyJwIuI+QW8W/A5o/9jPjhOY/16K7wzKDqiHGSqt9RVOTiBKJ/TNjaDyZG3CQCwlLLfGhbF4bM2TyWwXqo836XaNjqepGI1Sk1gbLcWztc8Bdqfzc6hr3n6BosC47dLNkVJ8qiwhxFhz7frhCJFO/rsckcoodVKcXezyOaLAoAPUzNQVZVxRqlEh47nC8OE/ec2NVHOYIDOuRoIMMcl2vSIJg30/CeAUPiRiXsQLc1PBYuT30z1Q7fKJgUlvf5g2A2TLjh8pOb/HBz6AIUwb4MZpE3Y/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH7PR15MB5643.namprd15.prod.outlook.com (2603:10b6:510:268::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 18:45:01 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 18:45:01 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "jhapavitra98@gmail.com"
	<jhapavitra98@gmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] ceph: fix OOB read in ceph_osdc_list_watchers
 via uncapped outdata_len
Thread-Index: AQHc6hXGZMgFtmpQ3Umwjx5y7wN8PrYgq1cA
Date: Tue, 26 May 2026 18:45:01 +0000
Message-ID: <71578c12a1b9d37aa2a39c8d1415084e0dea9216.camel@ibm.com>
References: <20260522180231.406895-1-jhapavitra98@gmail.com>
In-Reply-To: <20260522180231.406895-1-jhapavitra98@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH7PR15MB5643:EE_
x-ms-office365-filtering-correlation-id: 61538165-ccb8-47b9-22c3-08debb56e505
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|22082099003|18002099003|38070700021|6133799003|56012099006|5023799004|11063799006;
x-microsoft-antispam-message-info:
 /L75T7RUzfxqcGcYTqJ9yq7+ZYnX5WCy5s47NWRfGDF+v5r0LqTJje+VqKV60LQ82xOMeOQKioGtx4FJ0PSHxucXnc64AWMmcNJo2m7QebHtD2M8dqrN+DOBdjo3XaVWWbC1IXmD1hUSkHTkXePZpVzJ5m+P4B8GFovhGa8DtixuFrJSN3H7ln5/hXcCXmJf+x55CAbJB1xnWsf63Azq9JyVo1leQq8+JG/8N9HnrIFuuMVY98bX+OwdiCQYdTV51q0OAL3W5eolQ8REYMMslMBwzFinBfAsdqRIHdAyv9uBoUGVfg4+9ELl/yotMKkNd5StZISnKVv4IbQiGLdlQPzRvRl8P2DQDYvdU3MbAflv1ILZ+eaBGjpOEGCKJ0K9InEiaMr3bcmR5imoNxJzBCSpWPkVqqFatsGa3Lu+1xBR2JvUsXu3rWftAEU4Y4fsMXjk1jQxHB4AzOJzXSAgZFUpcvQGyBr4qT11Vlvbk6TZGIBJboVWyyQFupslxmoLLMdwb279RAaDEu6TpwTTT3111M4Hp4+whhUJzPKyUcgIKizqoRRUvXGWPU9ARKYcUfQ7pZ9/0ZeSZ3kYbEcOxXrYnUQP0k9d2uNdJMkmBi9uT8YQYcMofGuib/4mblwlHxsYGvJiDXCthR4BzOOcARa4+MDyC7V9OWTLfkLxfgevGfoxxZ/89UrlhvsfXDyi67rOc2msnmFX6pq0Zt+KEe8Fvp/hgDdKXrD6AQjwAGqzQbhfEmGnnegchdx7N8ol
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(22082099003)(18002099003)(38070700021)(6133799003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFpjUlowTHVYelFEWnFUS0UwREQxcTZ3ZXFIV3FSdUdOcXZ0eFhEU3Z6eE01?=
 =?utf-8?B?QVFmM2hURkFHMVpoM05iMGlwV3d0VVZsWEJPNkhkVHVBNm1ic3pNTVR3TjQ5?=
 =?utf-8?B?QUVtTnRENkpSNUZhNm5WdXd0L1FwaGNhZDRYS3RsdFhrdFlpb2poc2tNbXMx?=
 =?utf-8?B?RU9jcEFSWURia1RGNmNrUEZhMmRHRDZzTUg1YmlENy9Lc29uMUtaQ0pJQU1J?=
 =?utf-8?B?OGcvZU0ySi9JM1NFK3RBemxrSkU2VUcyOHYvSkFEZWRRYkJuRnp2VUpSc1Jt?=
 =?utf-8?B?Z0MxekRVMlFnTnJ2TjVqamN1RndtNzRFeFF5OGRQSUFLYldWOGJMaHRGNU1U?=
 =?utf-8?B?dUNEUG05bmc5elhEcUhML3dBLzBCQTNPUjRlbi8rWCtBd0QybDRCQy9yN0Fw?=
 =?utf-8?B?dEdXdGVnZlB4Rnh4Z25ZMXcwNTZuU3VOT24rbE1Ka2FnWVFHanE3RmpvY01h?=
 =?utf-8?B?VEtGQUFYOVhYanAxcWVRZEEycUxJWERMVEZ5WkFSZXV2YlJPNi90NlRPYnM3?=
 =?utf-8?B?blVGbUt2dmhRZ0ZQcHVqQ0d0dXFJRVkxa3psZ1pZc2ZRa3hVditqSWxJa252?=
 =?utf-8?B?VGt4OGFST3diRTNXT0gzUlV1dFJMSjZiVk1Jbk0wM2dLZzdueGJqa3hGc3du?=
 =?utf-8?B?aHBPNDBtOEF5a0EwYVNnRXIvV3Q3eG1XVXhWYnhpeGs2dXlrOUtZdFUwVndl?=
 =?utf-8?B?L3JMWFQvQm81dVhPdTlHZnZBMHQweUZMVmxwRFJEZ1A1czdZU3h6WEo1Q0Jy?=
 =?utf-8?B?a2hMOG4xZndTYmVkT3BSQkxoTExFYXhYWkZSWVM5MFE2aVBRb2FuK0hmcSsz?=
 =?utf-8?B?K09COXJpRlgwMnVFQjRMWnNrNzAwRnRjK0RoWkZDdkFFK1NYY2N1djdSM0px?=
 =?utf-8?B?UGN5SHJaSEk1Uk9vVm4xMzVvUnZ1Z2czVk5RR1lVVjNna1JnL2tYbDBWUHJk?=
 =?utf-8?B?czdzclVCTjVPeXNCVkRGOVd3UGdwOFFITnBLc1k2aCtPWWZoOE9xdkl0Yys4?=
 =?utf-8?B?Z0pxamEvMVQ4ZVBJVGZJa2ovNUZCTG5qeEVBOWtLeE0xUlZJcDZIUEljNERZ?=
 =?utf-8?B?Vlk3NmF4TVJOU3JUdlFXVEozWjluT2RlSjRScWtROThxZDh4dmJKTHNyejJ0?=
 =?utf-8?B?M0hVd28vTmFEeHdmK0VWRks5eGJKQ1V4UVdYeW8rbUJDZEwrb0pBaHVTRXpJ?=
 =?utf-8?B?M1NFQVIzZkhRaGlhbyt4MFVkM2lheUZHRHhjVzI3TTZ2NDZPRkhaUXVPK0RZ?=
 =?utf-8?B?UzJ5aVBUUVJaS3lRbnJsTHhlMi8wRjFCY1Vaam1nTU12WmxzSE9BMnB3OTNT?=
 =?utf-8?B?WHFVY3ptTlNkVzF1ZU9abWFIZXpsQVZMMmdCRUo2SlZsTVVlVnpDNEg5aEdm?=
 =?utf-8?B?VHZzVVc4ejhoU1cvcm1FemlaOUs5OXMvNU9PQkVWN3FqNldoYjNxTHhqM3dG?=
 =?utf-8?B?VUw1OWRoN0UrS040RFVYWllqUFB4V1VtQUEvZU5aZ1NIQXo3S0FDSEFhMWJB?=
 =?utf-8?B?TnBIbGQvRnlHMkVPMS8yNjd6R2pUSHdDMktVdmhKdkZiMEVBaTNCTFlXM0JL?=
 =?utf-8?B?aU5CMDJwN0JJeDVDaGg1cWUxZnVjZUVuL2I3YjlTN1ArTVpwSzh0UkYwWmJ2?=
 =?utf-8?B?Q0s2NGlSWGlFckl2WVVpc0pIV1V4MFVmTmJ3VjgvMHErM3J6M3hGTE13MS9p?=
 =?utf-8?B?RTUwWWFDTHBQMm1SQkd2ZWo4TlR6RzFmamhjcU5ZZ1hJSjVyUW9qcVNpZWlw?=
 =?utf-8?B?YklwclNsTzUzQW9rMldrbGJBbzdhNGczTit2bHVvT3pPSG5YbFl0VjdpMXk0?=
 =?utf-8?B?bTRLLzB6TnRQa1hua3NTTGFWM0pNbjFNNnFpZStUakpCM0lOc2VPS0pEYlN5?=
 =?utf-8?B?L2g1WUUvMk5wbXI4Q1B0dFg1eUVpYTVWUW5rWXA2OVB1MHNPYVBrZnh1QkZ2?=
 =?utf-8?B?ak9JZlM2UDViRXlOMm8wZmgxY1FRUDdweW1UYW12SkxrV3hTMnBKTXJ1ZENN?=
 =?utf-8?B?Sk9INTNtaVdlcHRiYzhnUEpiaDFGSDhRcWZGa2hjbXc4NmIxWFdySVRUYVNi?=
 =?utf-8?B?aXlXc1BrcUtETUpCMkJ2enEvQmJSWFlUcXlnNlZuYldFTGV4YSt2Q2MzMWdl?=
 =?utf-8?B?N25UTGt6Ti9rT3M5NldYaU1Td05ZajJPSm9jSGZldFFka0ozdjJCUTVIaTBl?=
 =?utf-8?B?MEx4TzJVRXFsZnVhNlRiS0FnV1BRdWt2Q0NoSmMzMmtkTEM3RHZUMEVNT1h3?=
 =?utf-8?B?SEZvenc3RUlHc1Vsc09QQklLOHB5S0JkaURHWjZZZ3l0K1E0NHZwNjVzRml6?=
 =?utf-8?B?VjBvSkR6NFUwbTFOaFFPLzBvdGFuY05OVkg3RUs4dzRUWDZzTGwxdDBlcW1O?=
 =?utf-8?Q?6tsRgLgl7AHdh3gD+M7aRtOhx5pm7tMRP9OAy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BB62D8ABA4BDB41A7D54444722ED508@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	O4SDJi3Dvn0Gl5IMIxc5xM7BkKZtvNRc5TqlHomRpQXDFg7SDl3cPilY4lVNPiORgOhgA+7utB3Yz7Fg2pjIe2TGvBhsSemxECBXBYX7DpX+NznWM/P9K2jEYSDd9xFGCjSdkpC9H+Q85eL6v41zri8NQZ13jTwGIy0Pq915QT0KLMWoaglEpLjwYal2K3rFXA7DtUaIIdgpjYBuGfLvcHInLJJxRsRk1QNoXFm3nJB6/VnQXBd7l2ugGG6PvfsB61KfqewmZnQbi093FR6qosNkbmQDwIv/03ukQojsaw2Yw84SGL9rfufBC61k06GvqRozBkKV8dLjHbhmIcPYEg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61538165-ccb8-47b9-22c3-08debb56e505
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 18:45:01.6115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AD2qAd2FP+Ft6iy/HgaHlXRDEsgk18p9Myhtbqv+KU2MAk5zf5AC2yZFV1Mjf+eY7zWtn7dtN+/oYhncR67sJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5643
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 2lt-K2qtAKRBDC5GaTPef50sxnk57DXN
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a15ea31 cx=c_pps
 a=j8DUK8/cuCuEDQ3LLq2Aww==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=2Rzjsj7i1L2xKbbRrQYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE2MyBTYWx0ZWRfX/y6cF6FTfdKB
 TEAtI+93S3SWh41XTTSN8lyM9uk44YV/A/YbP9psSGkx69c0wmJHTfnONL8nFmtZj6Kcic972XH
 ovCCn5VXkCNnF9XCIP5oscti8wNRCPYZJCfV4C9M1PSgGo/ZhByp/cWuZVW9AR+gmfbDxsSwsgM
 6S3I6naseWalIbObGUJSJEH7/fjeeGwClxrR0wsJao6yH297c0aS2M0b6DhQ34TegtF368RpvRC
 RJHGaXMpdsiTnKK/EuEAaJVs1T8qaMf4HsdtCBYcYOBDAUN/yiEni0dQRcMmdoyErLRe0XfJoEe
 fNurCFtXvuTStRzckLyfx5VAsvbVvjf1vDF38igquMqvl3AZFGJB6bRw72OUKz15S9E8B0nIR33
 gIVrMiKc/odyGD/3Old09VhtLQhkIQAsYMwrC/i4Wn+BhPT+AGCwZEU13d81P1SHCwEADfdDvi8
 yMXuJUG4cxhWomjm+7g==
X-Proofpoint-ORIG-GUID: HmQ6cWMmMvDEYBkTtHy_CC_UGZYqFw9B
Subject: Re:  [PATCH] ceph: fix OOB read in ceph_osdc_list_watchers via
 uncapped outdata_len
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260163
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254424-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.745];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C06E35DB86C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCAyMDI2LTA1LTIyIGF0IDE0OjAyIC0wNDAwLCBQYXZpdHJhIEpoYSB3cm90ZToNCj4g
VGhlIE9TRCByZXBseSBoZWFkZXIgZmllbGQgb3AtPnBheWxvYWRfbGVuIGlzIHdpcmUtY29udHJv
bGxlZCBhbmQgaXMNCj4gY29waWVkIGRpcmVjdGx5IGludG8gbS0+b3V0ZGF0YV9sZW5baV0gd2l0
aG91dCBhbnkgYm91bmRzIGNoZWNrOg0KPiANCj4gICBtLT5vdXRkYXRhX2xlbltpXSA9IGxlMzJf
dG9fY3B1KG9wLT5wYXlsb2FkX2xlbik7DQo+IA0KPiBUaGlzIHZhbHVlIHByb3BhZ2F0ZXMgdW5j
aGVja2VkIHRvIHJlcS0+cl9vcHNbMF0ub3V0ZGF0YV9sZW4gYW5kIGlzDQo+IHRoZW4gdXNlZCB0
byBzZXQgdGhlIGRlY29kZSBib3VuZGFyeSBpbiBjZXBoX29zZGNfbGlzdF93YXRjaGVycygpOg0K
PiANCj4gICB2b2lkICpjb25zdCBlbmQgPSBwICsgcmVxLT5yX29wc1swXS5vdXRkYXRhX2xlbjsN
Cj4gDQo+IFRoZSBhY3R1YWwgZGF0YSBhbGxvY2F0aW9uIGlzIGFsd2F5cyBleGFjdGx5IG9uZSBw
YWdlOg0KPiAgIGNlcGhfYWxsb2NfcGFnZV92ZWN0b3IoMSwgR0ZQX05PSU8pDQo+ICAgY2VwaF9v
c2RfZGF0YV9wYWdlc19pbml0KC4uLiwgUEFHRV9TSVpFLCAuLi4pDQo+IA0KPiBUaGUgbWVzc2Vu
Z2VyIGNhcHMgdGhlIGNvcHkgdG8gUEFHRV9TSVpFIGJ5dGVzLCBidXQgdGhlIGRlY29kZSB3aW5k
b3cNCj4gZW5kIGlzIHNldCBmcm9tIHRoZSB1bmNhcHBlZCB3aXJlIHZhbHVlLiBBIG1hbGljaW91
cyBPU0QgY2FuIHNlbmQNCj4gb3V0ZGF0YV9sZW49MHgxMDAwMCwgY2F1c2luZyBfc2FmZSBkZWNv
ZGVyIGJvdW5kYXJ5IGNoZWNrcyB0byBwYXNzDQo+IHdoaWxlIHRoZSBwaHlzaWNhbCByZWFkcyBj
cm9zcyB0aGUgc2xhYiBhbGxvY2F0aW9uIGJvdW5kYXJ5Lg0KPiANCj4gS0FTQU4gcmVwb3J0IChr
ZXJuZWwgNy4wLjAtcmM3LCBRRU1VL3g4Nl82NCwgS0FTTFIgZGlzYWJsZWQpOg0KPiAgID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQ0KPiAgIEJVRzogS0FTQU46IHNsYWItb3V0LW9mLWJvdW5kcyBpbiBjZXBoX29vYjJfaW5p
dCsweDIzZC8weGZmMCBbY2VwaF9vb2IyX3BvY10NCj4gICBSZWFkIG9mIHNpemUgNCBhdCBhZGRy
IGZmZmY4ODgwMGEyMjlmOWUgYnkgdGFzayBpbnNtb2QvNTcNCj4gDQo+ICAgQ1BVOiAwIFVJRDog
MCBQSUQ6IDU3IENvbW06IGluc21vZCBUYWludGVkOiBHICAgICAgICAgICBPICAgICAgICA3LjAu
MC1yYzctZzljMmFiZjY5ZGE4My1kaXJ0eSAjMTUgUFJFRU1QVChsYXp5KQ0KPiAgIFRhaW50ZWQ6
IFtPXT1PT1RfTU9EVUxFDQo+ICAgSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0
MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xNy4wLWRlYmlhbi0xLjE3LjAtMSAwNC8wMS8yMDE0
DQo+ICAgQ2FsbCBUcmFjZToNCj4gICAgPFRBU0s+DQo+ICAgIGR1bXBfc3RhY2tfbHZsKzB4NGQv
MHg3MA0KPiAgICBwcmludF9yZXBvcnQrMHgxNzAvMHg0ZjMNCj4gICAgPyBfX3BmeF9fcmF3X3Nw
aW5fbG9ja19pcnFzYXZlKzB4MTAvMHgxMA0KPiAgICBrYXNhbl9yZXBvcnQrMHhkYS8weDExMA0K
PiAgICA/IGNlcGhfb29iMl9pbml0KzB4MjNkLzB4ZmYwIFtjZXBoX29vYjJfcG9jXQ0KPiAgICA/
IGNlcGhfb29iMl9pbml0KzB4MjNkLzB4ZmYwIFtjZXBoX29vYjJfcG9jXQ0KPiAgICA/IF9fcGZ4
X2NlcGhfb29iMl9pbml0KzB4MTAvMHgxMCBbY2VwaF9vb2IyX3BvY10NCj4gICAgY2VwaF9vb2Iy
X2luaXQrMHgyM2QvMHhmZjAgW2NlcGhfb29iMl9wb2NdDQo+ICAgIGRvX29uZV9pbml0Y2FsbCsw
eDlhLzB4M2EwDQo+ICAgID8gX19wZnhfZG9fb25lX2luaXRjYWxsKzB4MTAvMHgxMA0KPiAgICA/
IGthc2FuX3VucG9pc29uKzB4NDQvMHg3MA0KPiAgICBkb19pbml0X21vZHVsZSsweDI3Yy8weDc5
MA0KPiAgICA/IF9fcGZ4X2RvX2luaXRfbW9kdWxlKzB4MTAvMHgxMA0KPiAgICA/IF9fa2FzYW5f
c2xhYl9mcmVlKzB4NDcvMHg3MA0KPiAgICA/IGtmcmVlKzB4MTVmLzB4M2IwDQo+ICAgIGxvYWRf
bW9kdWxlKzB4NGE5YS8weDYzNTANCj4gICAgPyBfX3BmeF9sb2FkX21vZHVsZSsweDEwLzB4MTAN
Cj4gICAgPyBzZWN1cml0eV9maWxlX3Blcm1pc3Npb24rMHgyNC8weDUwDQo+ICAgID8ga2VybmVs
X3JlYWRfZmlsZSsweDJlZC8weDc3MA0KPiAgICA/IGluaXRfbW9kdWxlX2Zyb21fZmlsZSsweDE1
Yy8weDE4MA0KPiAgICBpbml0X21vZHVsZV9mcm9tX2ZpbGUrMHgxNWMvMHgxODANCj4gICAgPyBf
X3BmeF9pbml0X21vZHVsZV9mcm9tX2ZpbGUrMHgxMC8weDEwDQo+ICAgID8gdGlja19ub2h6X2hh
bmRsZXIrMHgyYTMvMHg2NDANCj4gICAgPyBfcmF3X3NwaW5fbG9jaysweDdlLzB4ZDANCj4gICAg
aWRlbXBvdGVudF9pbml0X21vZHVsZSsweDIxZi8weDc1MA0KPiAgICA/IF9fcGZ4X2lkZW1wb3Rl
bnRfaW5pdF9tb2R1bGUrMHgxMC8weDEwDQo+ICAgID8gZmRnZXQrMHg0ZS8weDRhMA0KPiAgICA/
IGZkZ2V0KzB4NGUvMHg0YTANCj4gICAgX194NjRfc3lzX2Zpbml0X21vZHVsZSsweGJhLzB4MTIw
DQo+ICAgIGRvX3N5c2NhbGxfNjQrMHhlMi8weDU3MA0KPiAgICA/IGV4Y19wYWdlX2ZhdWx0KzB4
NjYvMHhiMA0KPiAgICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ny8weDdmDQo+
IA0KPiAgIEFsbG9jYXRlZCBieSB0YXNrIDU3Og0KPiAgICBrYXNhbl9zYXZlX3N0YWNrKzB4MzAv
MHg1MA0KPiAgICBrYXNhbl9zYXZlX3RyYWNrKzB4MTQvMHgzMA0KPiAgICBfX2thc2FuX2ttYWxs
b2MrMHg3Zi8weDkwDQo+ICAgIGNlcGhfb29iMl9pbml0KzB4NDQvMHhmZjAgW2NlcGhfb29iMl9w
b2NdDQo+ICAgIGRvX29uZV9pbml0Y2FsbCsweDlhLzB4M2EwDQo+ICAgIGRvX2luaXRfbW9kdWxl
KzB4MjdjLzB4NzkwDQo+ICAgIGxvYWRfbW9kdWxlKzB4NGE5YS8weDYzNTANCj4gICAgaW5pdF9t
b2R1bGVfZnJvbV9maWxlKzB4MTVjLzB4MTgwDQo+ICAgIGlkZW1wb3RlbnRfaW5pdF9tb2R1bGUr
MHgyMWYvMHg3NTANCj4gICAgX194NjRfc3lzX2Zpbml0X21vZHVsZSsweGJhLzB4MTIwDQo+ICAg
IGRvX3N5c2NhbGxfNjQrMHhlMi8weDU3MA0KPiAgICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3
ZnJhbWUrMHg3Ny8weDdmDQo+IA0KPiAgIFRoZSBidWdneSBhZGRyZXNzIGJlbG9uZ3MgdG8gdGhl
IG9iamVjdCBhdCBmZmZmODg4MDBhMjI5MDAwDQo+ICAgIHdoaWNoIGJlbG9uZ3MgdG8gdGhlIGNh
Y2hlIGttYWxsb2MtNGsgb2Ygc2l6ZSA0MDk2DQo+ICAgVGhlIGJ1Z2d5IGFkZHJlc3MgaXMgbG9j
YXRlZCAzOTk4IGJ5dGVzIGluc2lkZSBvZg0KPiAgICBhbGxvY2F0ZWQgNDAwMC1ieXRlIHJlZ2lv
biBbZmZmZjg4ODAwYTIyOTAwMCwgZmZmZjg4ODAwYTIyOWZhMCkNCj4gDQo+ICAgTWVtb3J5IHN0
YXRlIGFyb3VuZCB0aGUgYnVnZ3kgYWRkcmVzczoNCj4gICAgZmZmZjg4ODAwYTIyOWU4MDogMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj4gICAgZmZmZjg4
ODAwYTIyOWYwMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDANCj4gICA+ZmZmZjg4ODAwYTIyOWY4MDogMDAgMDAgMDAgMDAgZmMgZmMgZmMgZmMgZmMgZmMg
ZmMgZmMgZmMgZmMgZmMgZmMNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0K
PiAgICBmZmZmODg4MDBhMjJhMDAwOiBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBm
YyBmYyBmYyBmYyBmYw0KPiAgICBmZmZmODg4MDBhMjJhMDgwOiBmYyBmYyBmYyBmYyBmYyBmYyBm
YyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYw0KPiAgID09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiANCj4gICB2YWw9
MHhjY2NjYWFhYSAoT09CIGdhcmJhZ2UgZnJvbSBLQVNBTiByZWR6b25lKQ0KPiANCj4gRml4IGJ5
IGNhcHBpbmcgdGhlIGRlY29kZSB3aW5kb3cgZW5kIHRvIFBBR0VfU0laRSwgbWF0Y2hpbmcgdGhl
DQo+IGFjdHVhbCBhbGxvY2F0aW9uIHNpemUuDQo+IA0KPiBBdHRhY2tlciBtb2RlbDogYSBtYWxp
Y2lvdXMgb3IgY29tcHJvbWlzZWQgT1NEIGluIGEgbXVsdGktdGVuYW50DQo+IENlcGggZGVwbG95
bWVudCBjYW4gdHJpZ2dlciB0aGlzIGFnYWluc3QgYW55IGNsaWVudCBpc3N1aW5nDQo+IENFUEhf
T1NEX09QX0xJU1RfV0FUQ0hFUlMgd2l0aG91dCBmdXJ0aGVyIHByaXZpbGVnZXMgYmV5b25kIE9T
RA0KPiBzZXNzaW9uIGVzdGFibGlzaG1lbnQuDQo+IA0KPiBGaXhlczogYTRlZDM4ZDdhMTgwICgi
bGliY2VwaDogc3VwcG9ydCBmb3IgQ0VQSF9PU0RfT1BfTElTVF9XQVRDSEVSUyIpDQo+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFBhdml0cmEgSmhhIDxqaGFw
YXZpdHJhOThAZ21haWwuY29tPg0KPiAtLS0NCj4gIG5ldC9jZXBoL29zZF9jbGllbnQuYyB8IDIg
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL25ldC9jZXBoL29zZF9jbGllbnQuYyBiL25ldC9jZXBoL29zZF9jbGll
bnQuYw0KPiBpbmRleCAwMTQ4ZTRjNDAuLmE2NzA5M2NmNCAxMDA2NDQNCj4gLS0tIGEvbmV0L2Nl
cGgvb3NkX2NsaWVudC5jDQo+ICsrKyBiL25ldC9jZXBoL29zZF9jbGllbnQuYw0KPiBAQCAtNTA5
MSw3ICs1MDkxLDcgQEAgaW50IGNlcGhfb3NkY19saXN0X3dhdGNoZXJzKHN0cnVjdCBjZXBoX29z
ZF9jbGllbnQgKm9zZGMsDQo+ICAJcmV0ID0gY2VwaF9vc2RjX3dhaXRfcmVxdWVzdChvc2RjLCBy
ZXEpOw0KPiAgCWlmIChyZXQgPj0gMCkgew0KPiAgCQl2b2lkICpwID0gcGFnZV9hZGRyZXNzKHBh
Z2VzWzBdKTsNCj4gLQkJdm9pZCAqY29uc3QgZW5kID0gcCArIHJlcS0+cl9vcHNbMF0ub3V0ZGF0
YV9sZW47DQo+ICsJCXZvaWQgKmNvbnN0IGVuZCA9IHAgKyBtaW5fdCh1MzIsIHJlcS0+cl9vcHNb
MF0ub3V0ZGF0YV9sZW4sIFBBR0VfU0laRSk7DQoNCldlIGNhbm5vdCBkbyBhc3N1bXB0aW9uIGFi
b3V0IHRoZSBidWZmZXIgc2l6ZS4gQ3VycmVudGx5LCBpdCBsb29rcyBsaWtlIGENCmhhcmRjb2Rl
ZCB2YWx1ZS4gUG90ZW50aWFsbHksIHRoZSBidWZmZXIgc2l6ZSBjb3VsZCBjaGFuZ2UgYW5kIGl0
IGNvdWxkIGJlIHRoZQ0KYnVnIHJlYXNvbi4NCg0KV2UgbmVlZCB0byBpbnRyb2R1Y2UgYSB2YXJp
YWJsZSB0aGF0IHNob3VsZCBrZWVwIFBBR0VfU0laRSB2YWx1ZSBhbmQgaXQgY2FuIGJlDQp1c2Vk
IGluIGNlcGhfb3NkX2RhdGFfcGFnZXNfaW5pdCguLi4sIFBBR0VfU0laRSwgLi4uKSBhbmQgaW4g
bWluX3QodTMyLCByZXEtDQo+cl9vcHNbMF0ub3V0ZGF0YV9sZW4sIFBBR0VfU0laRSkuDQoNClRo
YW5rcywNClNsYXZhLg0KDQo+ICANCj4gIAkJcmV0ID0gZGVjb2RlX3dhdGNoZXJzKCZwLCBlbmQs
IHdhdGNoZXJzLCBudW1fd2F0Y2hlcnMpOw0KPiAgCX0NCg==

