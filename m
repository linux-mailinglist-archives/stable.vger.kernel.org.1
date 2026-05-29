Return-Path: <stable+bounces-256782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAMPOFj8GWrl0QgAu9opvQ
	(envelope-from <stable+bounces-256782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 22:51:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4381C608B0A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 22:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB1C4302F9B0
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14A43B27C7;
	Fri, 29 May 2026 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EAFjEXIQ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F63348C46;
	Fri, 29 May 2026 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087829; cv=fail; b=fIsWEiwNWd2y5F2rakl2g1ltWp88ITdHm6XPYUrEAs0Wc3ab6LXkPHKyBYnRPGwBHMlXrMiAMK+1pJChFCNfScGKxcAatW09HgF730K2MowVcjOZhJic85C2F+LahvxFzJ/hnL44HviooTIoc+UpJmFTNtL0/8rSmxna2kt/KuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087829; c=relaxed/simple;
	bh=3/m+nh54h56Bz/3LY+6c7cNc47OlQ9QoMSyWjpySBA4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Et4GehLiOGTFYFTlRfcNq5DxJYIIbkmN6m2L7cfR3he0hs4BK4sUWOB1xAvE4VkS1+iHpLomzLDpoGIDIuD3ncLrZRvVM0ye3YXMTiasCkgVDIa7Ktce9w52jlqVjXPGXbjjixHAAbtC4C9aV0x0zpuoGub4ooeRkzaqLIFm2jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EAFjEXIQ; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TKUmEx1467915;
	Fri, 29 May 2026 20:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=3/m+nh54h56Bz/3LY+6c7cNc47OlQ9QoMSyWjpySBA4=; b=EAFjEXIQ
	BiMONreXSb/FILDuqOnTIENL0763ezkYHp3U75YbXaQbsBEi3OEeQHOfg+VySdi/
	AAlpSsN+YAWUAVKiEdRJqOp5lwssb2TWl8OaPMn+/bGWXUjIsnIaDpvafRLH5lDv
	1FFPbjwVbrLMa4iipzkgRhFe4qyA8aU59wyzlNpScWRIFMn/KlGssGk4EQ5ddDpw
	yd3u1srfrtPbvfOrwFDrnJstPMhTiaj6ik5w40f8X/nNxRNk4wxbnf4/37Uf49dB
	NE4NKcvDePB7OpWslvtEZ3zwJMPTECBw1xwcfkzhasVQmrVzChKNwVHWZnvfY7sv
	mpP3DTxMGaFSVA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886rj3q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 20:50:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3e+XqfQYdqYiRcJ28iZPculRMMbq2+DqhQzNgDrlCqZuGEL0zhGRtpcyD1ujKDdYa4RT440qDmybQ6TuzHwSutGFuXCb+WP2Lr3U3HLLF+lQgRM2a7hnvKas7kgFBkjpYd0VcC6HfkQxAOWTfyX/o71V7zPuA2ksHoW6+lbbEKtfuKtn2KoB7N18XKEzsngE1G1hhB77AUdLSmdl2QDMWqHZlN9HlNvOBHnLCmv3L/aCRXWvQpdmFWozo24kD2mA+W74UvRMqDL6ljMkDt81rm7gbobX0+qKIMb+5Hx6VIQbAZp5VlI3Ha0le3RI0ZgHRr0RdFP3ndYV7LUpltlnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/m+nh54h56Bz/3LY+6c7cNc47OlQ9QoMSyWjpySBA4=;
 b=rl5kb1ZraE+kjEcyS20r4ppxdLAYq7u+LE4sAEu5CLFM2xcb+dOkX+P+wbAkngA7H8gjepe9qSFodv9iK/Bs+4LqZPe7nZAmnwYpq4sOgnt58UkgcAJKtye31fwooz3fU5iM4FYpKpioRTC4EVvYUBW7Sp7+9xEJtxFQyOYn9lH8Ti49wDiiVvXi8pxameh2TxRKlcHk4s/SEqAiVWxZhKN1tQ2Xn9C9VO9NYkJNQERATr6FU6Tdvbq6Z8tKBfMtVg+NnVmGCEDOU0GlcgFJe0iXLYNKPehzZRTI6M0LPE47PM4RI2+GtbzSAgUwM4XeY43Jkn5KWukWMXwd57P7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4733.namprd15.prod.outlook.com (2603:10b6:510:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 20:50:20 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 20:50:16 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "cfsworks@gmail.com" <cfsworks@gmail.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "mchangir@redhat.com" <mchangir@redhat.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Xiubo Li <xiubli@redhat.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 2/2] ceph: properly decrypt filenames in
 vmalloc() buffers
Thread-Index: AQHc7YT7Yf53KxBmFECNZMaErrVlYrYlfncA
Date: Fri, 29 May 2026 20:50:16 +0000
Message-ID: <937c1dbbb0300a8113d62ca1dbaffe1493bd10e5.camel@ibm.com>
References: <20260527025828.5966-1-CFSworks@gmail.com>
	 <20260527025828.5966-3-CFSworks@gmail.com>
In-Reply-To: <20260527025828.5966-3-CFSworks@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4733:EE_
x-ms-office365-filtering-correlation-id: 0420274f-9d73-4411-e318-08debdc3e39b
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|38070700021|18002099003|22082099003|6133799003|4133799003|3023799007|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 gQtsQBO4/EF10I4IC30BJPKGWFXJjsW5+t1Qzm+HdEwsfsbP6wqb8dLD974grT/Bkgofb9pfobG2CLg8QNMGjakCJiCHj38AxS+pPX92M+6TklTrk8b66asCz1mfzIDtz5KH1fYWRm98Bg8CWXrxuLd2Zv2vu36OonaMr7xGRsWxitb7NcLS7sQPUiUT5N0kyN+dtAyBa0ko+9ZH9talyZI7uSj/3u08DMk2K27iuGWuBlS6z+YGxkqfjhppj6zwMZrUr3un+KpXD/F4f+yLpNY0SZ5gtFfwr6HRK9i8GW/z/F85JeaZM/SQSPB7DV1OXiQBsl1kvttssL6kxltAfSrMOyHKFQ2cBIzTAm8RQ/oocrI373+cKLxiJnF/C3hWQGhEQobAOWdzpKwGPs9/kiRphcJuV5OlTf4+XzeYSXWc8LcWIxAjelfleDyJuSgVblYNAP+auy5vg1z7J0ygEwT09NvnFDty9ujf72Ldsme4nZtNSsca3nf9YOj8ezkXJcjNJgy/keJygUs9WakF1yWEMgTeIgRF6Ilqxgc3f5mWlrCME91ErA1fS1T4HgMlf0QKjG8Pahce/2OTjmes508T1FlqQ2JoOhWw9cOtNWO5EYfSW/dG+B3FrOZ7sUFvvRdTqLtYOGLpsF4BB4KalJ7ULZmk24F4VXZ5GjvPKRVppE7K/lkdGnGZqoSC5xoqNYnSEmqWbg0So1XgTpJgoKMO0kJABLqYeMmFcvgsJyNaUyLHmEPW90hjBea+c4OZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(38070700021)(18002099003)(22082099003)(6133799003)(4133799003)(3023799007)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFVpSjR5REF2SzZpUWFvbU5Hc0NVSFI3V1ZUU1FONnJSNUpEZ0tCRlc2TEd1?=
 =?utf-8?B?d25QczVybitvU0FjdFdSNzliVityaDVmc3RSd2kwNThrOXFiS1hKMHZuK1FJ?=
 =?utf-8?B?ajFuTHJUQ21ibHI0ZWlpKzdlNU80SmZMWlhkRXczV3l4YTlYc1ovdGFPR0NU?=
 =?utf-8?B?UXpQWGthMjREWi9LSGI1RXZqSitRWTF3eVNXY1FpRDhxb3dOWkx4N2pvUzFY?=
 =?utf-8?B?NFd1VDYzVnk4NUl0K3Qxbk01SGRTNm5tWEszV0NKSlZoVWc4cW00dXdNZy9J?=
 =?utf-8?B?U0ZuY016cDZtVnpWYm16by8waDhtNWZrdTBTbFVsclJsVG90cDZrSVErVEQ1?=
 =?utf-8?B?dGhwbHZiMG44cFE4OEZxQ1lDWU1JSzlJbExrRThQMnJSQ3AyYmJaWWVLdyt6?=
 =?utf-8?B?bk9VOUxwVUdEVE93blZPaHhmUjZUc3dDZFRwT2F5NmNHVnMrZW9vRW1CR0VC?=
 =?utf-8?B?Nk9nMHZqSmQ3cS9mc1R4dWY5cjF2K0JuWmFpLy9vTGp2SUdFSENKKzA1OUt4?=
 =?utf-8?B?NldKN2FlTjkrNzM5VDQvZWJTaEZNT2Q4RmVONkNHMlJKR3kvbDZ6ajZnYWNX?=
 =?utf-8?B?OW1QSDgxRStBQ1ltb05aQ0xzc2U2Uzh5dTRIWE5qYk9kMTFkdWZrak9EdFhk?=
 =?utf-8?B?MzMzRlNHODVNMHVXMjVwOHkvd0NJS1BOZWJSZXl0aytkaFovcmpTTzBmdGg5?=
 =?utf-8?B?aC90S0tmR3JKdzVvSm5aZTBZYTU4cjNja25UZzRKQnIzTUoxc2FCL3d1Kysr?=
 =?utf-8?B?MGo1bDdSUitDWExZK0U2U1hqSHJEd3JIbGFqN1RTandicW9iSEQyOGQ2aVpF?=
 =?utf-8?B?WnVaL0k2bXdmSm1RRm5BSUpBMHM3SklONDcrU2NLVHFQaHM3a1o4MFMvRE9y?=
 =?utf-8?B?OUlGbzlkMHVSdU8yczU0TUxoTHJMbVpja2FOcmhDd1U2SFFUQ1hmeDRCWlU2?=
 =?utf-8?B?NXNSZ05rWkc3S0g2cGI5Umh2b1ZiOFpBWWxTdU5WemN3OTU2RWRQNHB2eUNx?=
 =?utf-8?B?Tmh1aitsaFk0WXJua3g0bjZaMDUxbXN4Y0xyTGJaaW5ZMVVodWJRSVNiQlJ3?=
 =?utf-8?B?bmh3Vy9NaFo3SEx6UGxlZW1VMFZXODFaZE5SY3NhcnMwd2RXaDVqWmhiRlE0?=
 =?utf-8?B?NFc5aDh3ekMxR3ZyZHo0REZZcjB4WXZoWHd3bkN6M3RkcUtJb2xtRVpadlFx?=
 =?utf-8?B?WEtvM2llUEZPNjNIcnJwS1Q4V2gxT281MmdBb056bktqMkZ4OXM4bWlKbVVO?=
 =?utf-8?B?eGpRVm0zNisyRUxlTndmUU9DNVJXVDJ5Q1VRQWd6eGZ4d3B0VVdmNGRybEhp?=
 =?utf-8?B?WDhYYSt2U0pYY1p2dGRpUGxvQ1BuVXRiODNDUDVRSGgrSlJCMDVpRzV0REQ5?=
 =?utf-8?B?cmlyR2tsdjRnN1EweVVodTZFdmI2dU1kZVFUMkZ0S3l4dDV4UFFSUk9XcmJ5?=
 =?utf-8?B?aFBPTHo4dms5RnVPZCs3WThDY2V0M1ExNlp5OGpGZVJhSnJ5ZTZCYTRXWkhX?=
 =?utf-8?B?U3FmRlNZbjNJNXJFZW1iS24yMm9yOFhLYS9TSWQ5bVJUT2tzS2xlM2pmSFFC?=
 =?utf-8?B?dnd4TTVJUFZNWVhNOFhGd3dhUjNyUXdOT3lFd0c4K0FNeUV5WUlKbEN1ejZ1?=
 =?utf-8?B?TnJIUi9xUVVhWHNZaWYyQmQyZC95bjUwY0EwSFppbUU0b1BLaWFvU0M5NHJP?=
 =?utf-8?B?dXI3VE92MnI1UnlhSFY3a2ZENzFwcE1la3Jqejl2dm1RS00zZWJEVndpWCt1?=
 =?utf-8?B?eE1MUnp1b2hCaHN1dms4YXVuYkVRVTlsMmJaZktlWnowaU5XMEI5cXJ6RDY5?=
 =?utf-8?B?TXZlMWQrRTZuMHBYa0RrR0FjbnRIWGQ4RjFURzBPQytBOGhhbjdPWSsvamJQ?=
 =?utf-8?B?Wkpkeml4amV0OXNybWxrZTVXOG9ObzN4Uml1eUNmTmR3NUd2aVlVMnE1dE9a?=
 =?utf-8?B?VkhSajlqaFE1U1Fld2hncmlLU2IrWVV6MGM0WUNZd2ltbytmdGtXbDdIK1N6?=
 =?utf-8?B?RFNVb0MrMFZCQ3lXem1WaTNXQlc5UzRmWFBpczNQR2JMdmN2a3NWcWdYYXpx?=
 =?utf-8?B?WUxsUG9PenFXdDAzLzZwbllLaWVhWGNsRWxmb1IvckgwQTBiZVN5L2dKSGZK?=
 =?utf-8?B?YmkvRjlhSk1IN2l5K0F5V24zaVVSRTZxeHFTd1c4ZmIrQ3prR0pkbEJVdjBH?=
 =?utf-8?B?bXZGTmlXWjlVMUJkZzBPZDVYZHpMQWhIc0JxQjViTDkyR2lGOXVqdTVqMVRy?=
 =?utf-8?B?S2xjZ3IvUUJMd00zb3k3cXg3ak9DME1nVXVxNlZ2UkM5bGJGK0IzcHJ5OC95?=
 =?utf-8?B?bXliMTJDdkc2a2dmV2RCMkVCSTZyVEdMSHhEL04wQ3VLVmNlaE9od1dwTkEz?=
 =?utf-8?Q?mWVjzeSLRQoklX6oO7fY+sOVMDyNVzhMRKdBi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE75709DF8646242B3BDC99F3EC36E5F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	fAt+IQ4t3Cr34T/VN8l63FbMyDHulT8F6850LoUdRdBE91j/ZTJ5hR48BNh4MNLCyWylUEwAwNyTbPD/ZyeooBtF1CyT7QWy9ARiUuwJKFfo4hTrbn1L0ah3io67yJghbGiPa1J9zjW+rLWS2ukoI660siOsRjsC/16kRkmR7pJUhDyKOmW8dM6IoF2eNpcKd7CXgSYW7B/xbB6ZrnhrW3r48yF0Gzo9iWbOSqvuTfd90ZBOieoaTcKjMivQvKnDBsaEuejCuvSq4BaGu23SJUB5BDyduTV6zyVxbZf+p4yJVZ+eJIb0vIO2lw5Pm3W0LTYwMWjVerOuAGKKaPTfqw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0420274f-9d73-4411-e318-08debdc3e39b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 20:50:16.7845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yq9ZrB6aJ6Sdzf6MuTaa9NryVwwChNTwcBogqq3ufY4qfiaKVxnmx89rtAPDCa6ALya82RxCftb1Xn3J6nVa1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4733
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: aNEsf7gx0aT9F9w1AjaEMWHcvIdMQXgb
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a19fc0f cx=c_pps
 a=CJt2AWVwLbfAHulDA2arTw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=OFcqsrsI3VNllqBU3XcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIwMCBTYWx0ZWRfX6SbPTVjq19pJ
 dQjQ8dcqPNgoVIi8J8T49rF4Lt/FCxzWUDueLHlSaiPdoUfOj15w2QJ9exWKgwASHEfI/0+8h7z
 xhKaI/vdC58IipAqJPbCaQXjyNyNtS/2fAXls4GNocnD4k2saXqu3TlAyqiQUiAKhb++naphP4q
 iS+D3e67ASbRh4YkDv7exzwDW2MgORmP+GQPpQPp2nJShh6ldQjPC2wsXggq5cNCyRlcVK/pb1V
 LCeC0SfImrb2oIIK1wtscV4LUEgdVI3XIjgd4r32c0U4IALSZTpPcCqlrzRGKmrTnxmdn0jDd/w
 q+oFj3ckgFLvbba6THST441zvahDTApuNUii7Jbo9+04cNdwcJLF22j7VV9N/V162gH/B0/eb/4
 /aiiitrzrN9+5huDd/D4iarr79kc5/BpeMgDNNOoXeTDq0U4L/GJANmwZUToAyhJeKoxK14N9zt
 MlyKeYiH1z9NEFFoNBQ==
X-Proofpoint-ORIG-GUID: ooYjxOQ6boPFKr3_4n3oaGVGNRjdFn-b
Subject: Re:  [PATCH 2/2] ceph: properly decrypt filenames in vmalloc()
 buffers
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290200
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iname.name:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_FROM(0.00)[bounces-256782-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,dubeyko.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4381C608B0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTA1LTI2IGF0IDE5OjU4IC0wNzAwLCBTYW0gRWR3YXJkcyB3cm90ZToNCj4g
VGhlIGZzY3J5cHQgc3Vic3lzdGVtIHVzZXMgdGhlIHNjYXR0ZXJsaXN0IGNyeXB0byBBUEksIGlu
aGVyaXRpbmcgaXRzDQo+IHJlcXVpcmVtZW50IHRoYXQgYW55IGJ1ZmZlcnMgYXJlIGluIHRoZSBs
aW5lYXIgbWFwcGluZyByZWdpb24uIEhvd2V2ZXIsDQo+IHRoZSBtZXNzZW5nZXIgY2xpZW50IHVz
ZXMga3ZtYWxsb2MoKSB0byBjcmVhdGUgYnVmZmVycyBmb3IgbWVzc2FnZXMsDQo+IHdoaWNoIHdp
bGwgb2NjYXNpb25hbGx5IHBsYWNlIHRob3NlIGJ1ZmZlcnMgaW4gdGhlIHZtYWxsb2MoKSByZWdp
b24gd2hlbg0KPiBwaHlzaWNhbCBtZW1vcnkgZnJhZ21lbnRhdGlvbiBkb2Vzbid0IHBlcm1pdCBh
IGxhcmdlIGVub3VnaCBrbWFsbG9jKCkuDQo+IFRoZSB2YXJpb3VzIGNhbGxlcnMgb2YgY2VwaF9m
bmFtZV90b191c3IoKSBkaXJlY3RseSBwYXNzIChzbGljZXMgb2YpIHJhdw0KPiBtZXNzYWdlcyBm
cm9tIHRoZSBNRFMgd2l0aG91dCBjb25zaWRlcmluZyB0aGF0IHRoZSBtZXNzYWdlcyBtYXkgYmUg
aW4NCj4gdm1hbGxvYygpIGJ1ZmZlcnMsIHJlc3VsdGluZyBpbiBvb3BzZXMgZXNwZWNpYWxseSBv
biBub24teDg2IHBsYXRmb3Jtcw0KPiAoc2VlICdDbG9zZXM6JyBmb3IgbW9yZSBkZXRhaWxzIGFu
ZCBhIHJlcHJvZHVjZXIpLg0KPiANCj4gTWFrZSBjZXBoX2ZuYW1lX3RvX3VzcigpIGV4cGxpY2l0
bHkgdG9sZXJhbnQgb2Ygdm1hbGxvYygpLWFsbG9jYXRlZA0KPiBmbmFtZS0+Y3RleHQsIGZuYW1l
LT5uYW1lLCBhbmQvb3Igb25hbWUtPm5hbWUgYnVmZmVycywgdXNpbmcgYHRuYW1lYA0KPiAod2hp
Y2gsIHdoZW4gbm9uLW51bGwsIG11c3QgYmUgYSBsaW5lYXIgYWRkcmVzczsgd2hlbiBudWxsLCBp
cyBicmllZmx5DQo+IGFsbG9jYXRlZCBhcyBuZWNlc3NhcnkpIGFzIGEgYm91bmNlIGJ1ZmZlciB0
byBhdm9pZCBwYXNzaW5nIGFueQ0KPiBpbmFwcHJvcHJpYXRlIGFkZHJlc3NlcyB0byBmc2NyeXB0
X2ZuYW1lX2Rpc2tfdG9fdXNyKCkuDQo+IA0KPiBBZGRpdGlvbmFsbHkgY2hhbmdlIHBhcnNlX3Jl
cGx5X2luZm9fcmVhZGRpcigpIC0tIHRoZSBvbmx5IGZ1bmN0aW9uIHRvDQo+IHN1cHBseSBpdHMg
b3duIGB0bmFtZWAgLS0gdG8gZm9sbG93IHRoZSBuZXcgInRuYW1lIG11c3QgbmV2ZXIgY29tZSBm
cm9tDQo+IHZtYWxsb2MoKSIgcnVsZSBieSBwYXNzaW5nIE5VTEwgd2hlbiB0aGUgbWVzc2FnZSBp
cyBub3QgaW4gdGhlIGxpbmVhcg0KPiByZWdpb24uIFRob3VnaCB0aGlzIGNhdXNlcyBhIHBlci1k
ZW50cnkga21hbGxvYygpK2tmcmVlKCksIHRoaXMgb3ZlcmhlYWQNCj4gZXhpc3RzIG9ubHkgd2hl
biBwcm9jZXNzaW5nIHRoZSBtaW5vcml0eSBvZiBtZXNzYWdlcyB0aGF0IHNwaWxsIGludG8NCj4g
dm1hbGxvYygpLiBNeSAoY3J1ZGUpIHRlc3RpbmcgcHV0cyB0aGlzIGF0IG9ubHkgYWJvdXQgMSBp
biA4LDAwMCByZWFkZGlyDQo+IG1lc3NhZ2VzLiBTdGlsbCwgaWYgdGhlIG92ZXJoZWFkIHByb3Zl
cyB1bnJlYXNvbmFibGUgaW4gdGhlIGZ1dHVyZSwgaXQNCj4gaXMgZWFzeSBlbm91Z2ggdG8gbWl0
aWdhdGU6IGEgZnV0dXJlIGNoYW5nZSBjb3VsZCBhbGxvY2F0ZSBhIGJvdW5jZQ0KPiBidWZmZXIg
aW4gcGFyc2VfcmVwbHlfaW5mb19yZWFkZGlyKCkgYW5kIHVzZSB0aGF0IGFzIGB0bmFtZWAgaW5z
dGVhZC4NCj4gDQo+IEZpeGVzOiA0NTcxMTdmMDc3YzY3ICgiY2VwaDogYWRkIGhlbHBlcnMgZm9y
IGNvbnZlcnRpbmcgbmFtZXMgZm9yIHVzZXJsYW5kIHByZXNlbnRhdGlvbiIpDQo+IENsb3Nlczog
aHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19sb3Jl
Lmtlcm5lbC5vcmdfY2VwaC0yRGRldmVsX0NBSDVZbTRnYTdtaVVRRTBLLTJEY0pBOTNZYTd3NjJQ
NjlNQU4yN1I1Y0JpWW51ZG9PSGRBLTQwbWFpbC5nbWFpbC5jb21fVF8mZD1Ed0lEQWcmYz1CU0Rp
Y3FCUUJEakRJOVJrVnlUY0hRJnI9cTViSW00QVhNemM4Tkp1MV9SR21uUTJmTVdLcTRZNFJBa0Vs
dlVnU3MwMCZtPWJjWDBGaEJENmp6V1hHT3N3MkxvSk9sX1RxZ29ibXdOQm1xTkloajJLMHFCbjJr
ckI4SVVySWhjVXM4TG1KV00mcz0ydUluWTVZczd4UV81N0lmbzR1b3ZQN19lOFNOMFFfd256QkRY
LXVqMGhFJmU9IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIHY2LjYrDQo+IFNpZ25l
ZC1vZmYtYnk6IFNhbSBFZHdhcmRzIDxDRlN3b3Jrc0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZnMv
Y2VwaC9jcnlwdG8uYyAgICAgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tDQo+ICBmcy9jZXBoL21kc19jbGllbnQuYyB8ICA4ICsrKysrKy0tDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2ZzL2NlcGgvY3J5cHRvLmMgYi9mcy9jZXBoL2NyeXB0by5jDQo+IGluZGV4IDc1MTVjYjI1
MTIyNi4uNjFkNjgzMGQxNmJjIDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL2NyeXB0by5jDQo+ICsr
KyBiL2ZzL2NlcGgvY3J5cHRvLmMNCj4gQEAgLTI5OCw2ICsyOTgsMTAgQEAgaW50IGNlcGhfZW5j
b2RlX2VuY3J5cHRlZF9kbmFtZShzdHJ1Y3QgaW5vZGUgKnBhcmVudCwgY2hhciAqYnVmLCBpbnQg
ZWxlbikNCj4gICAqIE90aGVyd2lzZSwgYmFzZTY0IGRlY29kZSB0aGUgc3RyaW5nLCBhbmQgdGhl
biBhc2sgZnNjcnlwdCB0byBmb3JtYXQgaXQNCj4gICAqIGZvciB1c2VybGFuZCBwcmVzZW50YXRp
b24uDQo+ICAgKg0KPiArICogVGhvdWdoIHRoZSBmc2NyeXB0L2NyeXB0byBzdWJzeXN0ZW1zIGJy
b2FkbHkgZXhwZWN0IGFsbCBidWZmZXJzIHRvIGJlIGluIHRoZQ0KPiArICogbGluZWFyLW1hcHBl
ZCByZWdpb24sIHRoaXMgZnVuY3Rpb24gc2xpZ2h0bHkgcmVsYXhlcyB0aG9zZSByZXF1aXJlbWVu
dHM6DQo+ICsgKiBmbmFtZS0+Y3RleHQsIGZuYW1lLT5uYW1lLCBhbmQgb25hbWUtPm5hbWUgbWF5
IGJlIHZtYWxsb2MoKSwgYnV0IG5vdCB0bmFtZS4NCj4gKyAqDQo+ICAgKiBSZXR1cm5zIDAgb24g
c3VjY2VzcyBvciBuZWdhdGl2ZSBlcnJvciBjb2RlIG9uIGVycm9yLg0KPiAgICovDQo+ICBpbnQg
Y2VwaF9mbmFtZV90b191c3IoY29uc3Qgc3RydWN0IGNlcGhfZm5hbWUgKmZuYW1lLCB1bnNpZ25l
ZCBjaGFyICp0bmFtZSwNCj4gQEAgLTMwNSwxMSArMzA5LDE1IEBAIGludCBjZXBoX2ZuYW1lX3Rv
X3Vzcihjb25zdCBzdHJ1Y3QgY2VwaF9mbmFtZSAqZm5hbWUsIHVuc2lnbmVkIGNoYXIgKnRuYW1l
LA0KPiAgew0KPiAgCXN0cnVjdCBpbm9kZSAqZGlyID0gZm5hbWUtPmRpcjsNCj4gIAlzdHJ1Y3Qg
ZnNjcnlwdF9zdHIgX3RuYW1lID0gRlNUUl9JTklUKE5VTEwsIDApOw0KPiArCXN0cnVjdCBmc2Ny
eXB0X3N0ciBfb25hbWU7DQo+ICAJc3RydWN0IGZzY3J5cHRfc3RyIGluYW1lOw0KPiAgCWNoYXIg
Km5hbWUgPSBmbmFtZS0+bmFtZTsNCj4gIAlpbnQgbmFtZV9sZW4gPSBmbmFtZS0+bmFtZV9sZW47
DQo+ICAJaW50IHJldDsNCj4gIA0KPiArCWlmIChXQVJOX09OX09OQ0UodG5hbWUgJiYgaXNfdm1h
bGxvY19hZGRyKHRuYW1lKSkpDQo+ICsJCXJldHVybiAtRUlPOw0KPiArDQo+ICAJLyogU2FuaXR5
IGNoZWNrIHRoYXQgdGhlIHJlc3VsdGluZyBuYW1lIHdpbGwgZml0IGluIHRoZSBidWZmZXIgKi8N
Cj4gIAlpZiAoZm5hbWUtPm5hbWVfbGVuID4gTkFNRV9NQVggfHwgZm5hbWUtPmN0ZXh0X2xlbiA+
IE5BTUVfTUFYKQ0KPiAgCQlyZXR1cm4gLUVJTzsNCj4gQEAgLTM1MCwxNiArMzU4LDE4IEBAIGlu
dCBjZXBoX2ZuYW1lX3RvX3Vzcihjb25zdCBzdHJ1Y3QgY2VwaF9mbmFtZSAqZm5hbWUsIHVuc2ln
bmVkIGNoYXIgKnRuYW1lLA0KPiAgCQlnb3RvIG91dF9pbm9kZTsNCj4gIAl9DQo+ICANCj4gKwlp
ZiAoIXRuYW1lICYmIChmbmFtZS0+Y3RleHRfbGVuID09IDAgfHwNCj4gKwkJICAgICAgIHVubGlr
ZWx5KGlzX3ZtYWxsb2NfYWRkcihmbmFtZS0+Y3RleHQpKSB8fA0KPiArCQkgICAgICAgdW5saWtl
bHkoaXNfdm1hbGxvY19hZGRyKG9uYW1lLT5uYW1lKSkpKSB7DQo+ICsJCXJldCA9IGZzY3J5cHRf
Zm5hbWVfYWxsb2NfYnVmZmVyKE5BTUVfTUFYLCAmX3RuYW1lKTsNCj4gKwkJaWYgKHJldCkNCj4g
KwkJCWdvdG8gb3V0X2lub2RlOw0KPiArCQl0bmFtZSA9IF90bmFtZS5uYW1lOw0KPiArCX0NCj4g
Kw0KPiAgCWlmIChmbmFtZS0+Y3RleHRfbGVuID09IDApIHsNCj4gIAkJaW50IGRlY2xlbjsNCj4g
IA0KPiAtCQlpZiAoIXRuYW1lKSB7DQo+IC0JCQlyZXQgPSBmc2NyeXB0X2ZuYW1lX2FsbG9jX2J1
ZmZlcihOQU1FX01BWCwgJl90bmFtZSk7DQo+IC0JCQlpZiAocmV0KQ0KPiAtCQkJCWdvdG8gb3V0
X2lub2RlOw0KPiAtCQkJdG5hbWUgPSBfdG5hbWUubmFtZTsNCj4gLQkJfQ0KPiAtDQo+ICAJCWRl
Y2xlbiA9IGJhc2U2NF9kZWNvZGUobmFtZSwgbmFtZV9sZW4sIHRuYW1lLCBmYWxzZSwNCj4gIAkJ
CQkgICAgICAgQkFTRTY0X0lNQVApOw0KPiAgCQlpZiAoZGVjbGVuIDw9IDApIHsNCj4gQEAgLTM2
OCwxMiArMzc4LDIxIEBAIGludCBjZXBoX2ZuYW1lX3RvX3Vzcihjb25zdCBzdHJ1Y3QgY2VwaF9m
bmFtZSAqZm5hbWUsIHVuc2lnbmVkIGNoYXIgKnRuYW1lLA0KPiAgCQl9DQo+ICAJCWluYW1lLm5h
bWUgPSB0bmFtZTsNCj4gIAkJaW5hbWUubGVuID0gZGVjbGVuOw0KPiArCX0gZWxzZSBpZiAodW5s
aWtlbHkoaXNfdm1hbGxvY19hZGRyKGZuYW1lLT5jdGV4dCkpKSB7DQo+ICsJCW1lbWNweSh0bmFt
ZSwgZm5hbWUtPmN0ZXh0LCBmbmFtZS0+Y3RleHRfbGVuKTsNCj4gKw0KPiArCQlpbmFtZS5uYW1l
ID0gdG5hbWU7DQo+ICsJCWluYW1lLmxlbiA9IGZuYW1lLT5jdGV4dF9sZW47DQo+ICAJfSBlbHNl
IHsNCj4gIAkJaW5hbWUubmFtZSA9IGZuYW1lLT5jdGV4dDsNCj4gIAkJaW5hbWUubGVuID0gZm5h
bWUtPmN0ZXh0X2xlbjsNCj4gIAl9DQo+ICANCj4gLQlyZXQgPSBmc2NyeXB0X2ZuYW1lX2Rpc2tf
dG9fdXNyKGRpciwgMCwgMCwgJmluYW1lLCBvbmFtZSk7DQo+ICsJX29uYW1lLm5hbWUgPSB1bmxp
a2VseShpc192bWFsbG9jX2FkZHIob25hbWUtPm5hbWUpKSA/DQo+ICsJCXRuYW1lIDogb25hbWUt
Pm5hbWU7DQo+ICsJX29uYW1lLmxlbiA9IG9uYW1lLT5sZW47DQo+ICsJcmV0ID0gZnNjcnlwdF9m
bmFtZV9kaXNrX3RvX3VzcihkaXIsIDAsIDAsICZpbmFtZSwgJl9vbmFtZSk7DQo+ICsJb25hbWUt
PmxlbiA9IF9vbmFtZS5sZW47DQo+ICAJaWYgKCFyZXQgJiYgKGRpciAhPSBmbmFtZS0+ZGlyKSkg
ew0KPiAgCQljaGFyIHRtcF9idWZbQkFTRTY0X0NIQVJTKE5BTUVfTUFYKV07DQo+ICANCj4gQEAg
LTM4MSw2ICs0MDAsOCBAQCBpbnQgY2VwaF9mbmFtZV90b191c3IoY29uc3Qgc3RydWN0IGNlcGhf
Zm5hbWUgKmZuYW1lLCB1bnNpZ25lZCBjaGFyICp0bmFtZSwNCj4gIAkJCQkgICAgb25hbWUtPmxl
biwgb25hbWUtPm5hbWUsIGRpci0+aV9pbm8pOw0KPiAgCQltZW1jcHkob25hbWUtPm5hbWUsIHRt
cF9idWYsIG5hbWVfbGVuKTsNCj4gIAkJb25hbWUtPmxlbiA9IG5hbWVfbGVuOw0KPiArCX0gZWxz
ZSBpZiAoIXJldCAmJiB1bmxpa2VseShpc192bWFsbG9jX2FkZHIob25hbWUtPm5hbWUpKSkgew0K
PiArCQltZW1jcHkob25hbWUtPm5hbWUsIF9vbmFtZS5uYW1lLCBfb25hbWUubGVuKTsNCj4gIAl9
DQoNCldoZW4gYm90aCBkaXIgIT0gZm5hbWUtPmRpciAobG9uZ25hbWUgc25hcHNob3QpIGFuZCBp
c192bWFsbG9jX2FkZHIob25hbWUtPm5hbWUpDQphcmUgdHJ1ZToNCg0KKDEpIFRoZSBpZiBicmFu
Y2ggaXMgdGFrZW4g4oCUIE5PVCB0aGUgZWxzZSBpZi4NCigyKSBfb25hbWUubmFtZSA9IHRuYW1l
IGhvbGRzIHRoZSBkZWNyeXB0ZWQgcmVzdWx0IChmc2NyeXB0IHdyb3RlIHRoZXJlKS4NCigzKSBv
bmFtZS0+bmFtZSBpcyB0aGUgc3RhbGUgdm1hbGxvYyBidWZmZXIg4oCUIHRoZSBjb3B5LWJhY2sg
aW4gdGhlIGVsc2UgaWYgd2FzDQpuZXZlciBleGVjdXRlZC4NCig0KSBUaGUgc25wcmludGYgcmVh
ZHMgb25hbWUtPm5hbWUgYW5kIGZvcm1hdHMgYSBzbmFwc2hvdCBuYW1lIGZyb20gZ2FyYmFnZS4N
Cg0KQW0gSSByaWdodD8NCg0KVGhpcyBwYXJ0IG9mIGxvZ2ljIG5lZWRzIHRvIGJlIHJld29ya2Vk
IGNhcmVmdWxseS4gVGhpcyBpZiAtIGVsc2UgY29uc3RydWN0aW9uDQpiZWNvbWVzIHJlYWxseSBj
b21wbGljYXRlZCB0byB1bmRlcnN0YW5kLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiAgDQo+ICBv
dXQ6DQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL21kc19jbGllbnQuYyBiL2ZzL2NlcGgvbWRzX2Ns
aWVudC5jDQo+IGluZGV4IGFhNjczMGI0OGU5Ny4uOGZjZjE4NWUzYTgyIDEwMDY0NA0KPiAtLS0g
YS9mcy9jZXBoL21kc19jbGllbnQuYw0KPiArKysgYi9mcy9jZXBoL21kc19jbGllbnQuYw0KPiBA
QCAtNTM4LDkgKzUzOCwxMyBAQCBzdGF0aWMgaW50IHBhcnNlX3JlcGx5X2luZm9fcmVhZGRpcih2
b2lkICoqcCwgdm9pZCAqZW5kLA0KPiAgCQkJICogdG8gZG8gdGhlIGJhc2U2NF9kZWNvZGUgaW4t
cGxhY2UuIEl0J3MNCj4gIAkJCSAqIHNhZmUgYmVjYXVzZSB0aGUgZGVjb2RlZCBzdHJpbmcgc2hv
dWxkDQo+ICAJCQkgKiBhbHdheXMgYmUgc2hvcnRlciwgd2hpY2ggaXMgMy80IG9mIG9yaWdpbg0K
PiAtCQkJICogc3RyaW5nLg0KPiArCQkJICogc3RyaW5nLiBJZiB0aGlzIG1lc3NhZ2Ugd2FzIGFs
bG9jYXRlZCB3aXRoDQo+ICsJCQkgKiB2bWFsbG9jKCkgKGhhcHBlbnMsIGJ1dCByYXJlbHkpLCBs
ZWF2ZSBpdA0KPiArCQkJICogTlVMTCBhbmQgbGV0IGNlcGhfZm5hbWVfdG9fdXNyKCkgYWxsb2Nh
dGUNCj4gKwkJCSAqIHN1aXRhYmxlIHRlbXBvcmFyeSB3b3JraW5nIHNwYWNlIGluc3RlYWQuDQo+
ICAJCQkgKi8NCj4gLQkJCXRuYW1lID0gX25hbWU7DQo+ICsJCQlpZiAobGlrZWx5KCFpc192bWFs
bG9jX2FkZHIoX25hbWUpKSkNCj4gKwkJCQl0bmFtZSA9IF9uYW1lOw0KPiAgDQo+ICAJCQkvKg0K
PiAgCQkJICogU2V0IG9uYW1lIHRvIF9uYW1lIHRvbywgYW5kIHRoaXMgd2lsbCBiZQ0K

