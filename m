Return-Path: <stable+bounces-254430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEveCDXyFWpjfwcAu9opvQ
	(envelope-from <stable+bounces-254430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:19:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 226D85DBECF
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0B0D3012553
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FE7355F41;
	Tue, 26 May 2026 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DsdIqZ5C"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37D334D915;
	Tue, 26 May 2026 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823132; cv=fail; b=tI5pVigjKNJi4k5xvvOj8jWN+y2wptTcvIqtwoQ8AxaJ9Y+uBA4fBrBAhzzxcl9RLWmCGGK1c7btB9bt51JsitLGz5At32drkwxMJAXzvEYjPRTMR6mv0tGiBivIU+EuOBXbnwqWyXu/mv7JN4lu07x/tAu67I8ZpwiWI4wyjpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823132; c=relaxed/simple;
	bh=ZhoHK6hfzybBOkH5V8qZSeHW92w3D32sDgQ7YJPwZiA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=kEucJjXrk0K6p7+HsJT6IxAIXp86EYsbsryUPyojBFca7W61n5bOzXo+aLc3Bi/o+Ug+Z7+02TCosWTbImTmheQFjMJxwcGs8E7Jcce/RhTnGXQgJJxlEHz0qH2itHZS7G1LyqmCoAD+ePEoG+ha/xIqi0vvRriYxBteJAhASPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DsdIqZ5C; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QBVKUu104797;
	Tue, 26 May 2026 19:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ZhoHK6hfzybBOkH5V8qZSeHW92w3D32sDgQ7YJPwZiA=; b=DsdIqZ5C
	qUKPsT6xBpJmXEiNHc0iplqgOhVvz6pX4HjlGlUj+qS1CnbDCjsaHNFyBJoti9ns
	BEGUaoYrf0f/rUU4QgQvlfupFOIux6WdGwLEPjmc7roh464BB2sGHkiryk4sf7J7
	dxV5qL9x8VNQGF0NkXUlmDdGsg6AsWRVpiAeKqKJkwAKAkZLogAG0car01HOFTei
	58/HmwirrVQcf1t8v96GIuDG8+oTxeVjLjq6mLt164LsC7aKqxDJ2Mf3MLvTLfao
	Ed7p1OZyBQELNG18PGtfoOP+5Mz6+JWDyCBt42ynnhDaHsKc3bS83MaHLZnu7xqw
	0GkNQp1GG771hA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nq4v8p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 19:18:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijIy9Xnpt4+DM+LXlT4hlNCdYBESBvsEqv1ubHVrdsIAdL41cy6RufPYiQlzvA6r5Kg9ZtCbmLeBZHIvw4L5eZN0hsisJ6jwS5TiTuvqEWaPgVr9eiWGBKGltt0vNUsdxkBqXosN4/Rzdmbbd3chXrGcvhpbCJquDjWEo30Xuh+UO/9kPrC5Ce0PJhYRKql/VNUwxQdVlvymrb+qyWQnA6d8V9qtgQvU2vwOXa6vFtaHwL2AQbsRq/ffpxr82Xfj3hAQXO/bJwYhDcy5bB05QJtI2rbRb8uhB4LVwo41OGmNI1vsSJT/lTkVrtLTJADeNcSL7LOxn7qeTs82YgvrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhoHK6hfzybBOkH5V8qZSeHW92w3D32sDgQ7YJPwZiA=;
 b=r5pdnj9eAE9tUtokIrQL3bU4NaMF1PIz7fZF06K7KxFOiO7tKakhYb2IU1SO36dG7UWuBWwBDRqTQEDtbrjn6Uena8+F+PG8AnA7Uxm6rl4Mz0hN+/n6gUJkK02VV5j0u1NMoyDCAVFMKzHNaLExucbF10Vfozr5ANI7GmmjneUa74bKOXCQFUMkHOCQGtwZr1L7Xm5pHcfI5PkwqPJxeYg/R7pxQIqxYnVRJLXMseAZTCqmgunTLBm/8NwGGei9suytprxcbPFUKgEkksgI2oItGRf+ruQyBIOGuZ+QPsU+TwkXOcMrv0UEC/AlpJ37InzLt6QvJdD9sEtgZKNVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BLAPR15MB3857.namprd15.prod.outlook.com (2603:10b6:208:277::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 26 May
 2026 19:18:39 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 19:18:39 +0000
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
Thread-Topic: [EXTERNAL] [PATCH] ceph: fix multiple unsafe decodes in
 decode_locker()
Thread-Index: AQHc6pLLJ3VsILDDGkOciMtUDOqwdrYgs8MA
Date: Tue, 26 May 2026 19:18:39 +0000
Message-ID: <b8ccb15776c8b9770c09b884d1a908d4994ac936.camel@ibm.com>
References: <20260523085902.502821-1-jhapavitra98@gmail.com>
In-Reply-To: <20260523085902.502821-1-jhapavitra98@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BLAPR15MB3857:EE_
x-ms-office365-filtering-correlation-id: c2375755-f65e-4438-b303-08debb5b97d0
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|22082099003|18002099003|11063799006|5023799004|6133799003|3023799007|56012099006|38070700021;
x-microsoft-antispam-message-info:
 J1zBLTUYQfBX3lLR2vCji7Sg6FtViseqWo7qAUaxTWxmxC/Nz0boLpXwdWzYiss8ZAzmcec4Y1j7JarpdiKs69PePnWFByqJD2FZAtst0sdTiAEbCWBMhFHEMUkp+ULuVw8yBARJSS5nAUGz4ZUmURsJWLcAxJ6vQjB9y49eZAHCzULpNiGVeEPrGtytyKvPP2dsvvyWc94WeWMTW3oUcFnnBAyMmK4cyAgzpBe1Ixt6B/tXIZiDRihzE/g4PYsnUBz5GziH1BMIBkUSAEnN71P5Mxgrd5ciSX6fLIAQWTouAm8Rq0yQmB1sosFeja6QdnLhD1qSGdZgZuptvIJwey3xzQmwELx5HCv5obTmrUPYCM+e6GrjMljge6dLdlZ1Ir9aKd0UDX4gUtCKGiEnWAdmyeBR3yjBB8d2Qe+GcZeWH5G7WnZYCupJYiVPblV53ofDqAfgtBG57yC/8WDiqUzaLtXDRNNSYpcqxW0wP1vfq8atqoz2dTS4JSmbMnKkdB7aiwfYXD/BKlEhS3Jl7vFb+QLbgyQmDERtQzIcw6VVoWRBZxL5rZ97hvMQ/h/RZ1XVCDFVoM9KAYKix0Dd0d3jlEmvc+sXsT4Lafjv5kxweXW+dxA4AkSKJrVKXVjXqQjGYwvqAvn9fv47py+oQXONRrP27Va5pRf54mekDk136piAwUOPPDdWrdb3a2N0ZQSJ5g4KmZHgOpc/Dj4OnxMQyDSJc3DskkCqApAmDHzQIkCoZpU9wPRPrtRhGMkb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(22082099003)(18002099003)(11063799006)(5023799004)(6133799003)(3023799007)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2FsQ3NLc3NLU3dOSlZJWkU3VGRTT3N0QUJqTDdpSWxkcXBkK1lXWVk0ZFFk?=
 =?utf-8?B?VEZSamVsMU1mSEcxRnlkTUc1RXJ6bWhFRVVFZVlnZi9ETXdSR1lFVmhXN0ZK?=
 =?utf-8?B?THNpeGtSTFkzRHRrSEdEeEFyaUxHRXRBRTlaa3FKdEh0Y2R2ZnJJWHJBdkdQ?=
 =?utf-8?B?SUZPR0RsSERsU0FacWR3MjMxWjJMSXpJWEx4eFlqb2RzSGd6U0pnTjBab0t6?=
 =?utf-8?B?K21mcjlyL3JTMlRoVzB4NHYydENCTGdmbGxkeWVwYlpSWm9mMkgrQlFSVWZG?=
 =?utf-8?B?NUpmMEFnb2hkMzk4WUl1OSt1ZlBmN1dqZUtEcFRUOW5EN3B0N1hQNU1WY3o2?=
 =?utf-8?B?N2xRS0hKQ0EycDFqUUo0QnM3ZER1WFF3bWJSNzZJM3NPOVk1WVVSdnU0eWFu?=
 =?utf-8?B?bHBaRW1ZNUc3TXJCSzhpQU1kUnFTKzN5S0hObUZKcEx6RUZuN0ZyR0FlNnN2?=
 =?utf-8?B?bUdTbWpEK1FTOGJqM0lzeTFNTTNYZW9mWG95Q21OQVBxVms4cm1xNkpDOEkx?=
 =?utf-8?B?V2ZlWlhUSmNWamEzT2gzcTBLT0FCeEZIR1V5OTRZaWQvVkFKZkRvTk9PbDA1?=
 =?utf-8?B?VUp1bTJBVVFobDI3T2tUZFRMd2NDRkxIR2R4a0RKU294di9iejMzbHB4OGJu?=
 =?utf-8?B?MmZIUUJ5Mm52c1BVNVBlODlkSlNjRGtoMkk5ZytMVW9jT1ZBUVZ6SStlamZU?=
 =?utf-8?B?cUJQTWxuN05UUjR6MmJRTjFyeldWS0k4UTM4Ri9JOWdxZ2hCZjBjZ1pieWRv?=
 =?utf-8?B?L3lJK0JZcGFBVDBNN0dmaFJLNElNTit5THJkQlArZ204eHVPSVlvTndRY0pX?=
 =?utf-8?B?K2ZrUE1iQ2ZWbWc5eFNJcFR5QitmUk54bkd2dk9pa0xrUFpPazFTUlZoTFJp?=
 =?utf-8?B?amI2ekw2VlordnE3UEQ4T0c1SjRiN3MxQzQxODM5UTVyUTJjMUhYQ1U4cHFT?=
 =?utf-8?B?L3pHR0pVWUZ3SHpqQnNHU2toUTR3SG1HT2FJYkMrVDQ1VVJoRWZ4WmJyUUlm?=
 =?utf-8?B?aVFHeWd6YngwQ2tFUjI0a3VoTzBLKzM2Rm1QSENWMHBlZ3VUYk9lZHgvM2hz?=
 =?utf-8?B?VEl5dlpFOExzZG1NRmdUbGErVjFjTHM2RkVoaWNUWjZhVHliNFVSWCtERzRy?=
 =?utf-8?B?OUxBNHpDZE1NeWtSbWNnQW1KSGVDZkgrNm5GT3Y1bGlOU3h3NHNwQXkydkxI?=
 =?utf-8?B?SXVVR1RCL0toVXNQaS85T2FrRmJVUFV5VndLVFF6TlIwVm5wZE5Zd0pDZjIr?=
 =?utf-8?B?bjhycU1IZkQ0SHNCR0pqSENqRUt0N0pJUnFDdE9adG1lU3E5Zm8xK3FHTlBt?=
 =?utf-8?B?YmRoRHAwaHdGZEJybExzNmt0RFRId1U1UEY2ZWFGTlozejMxSm0yT1V2bStV?=
 =?utf-8?B?MCt6QWhpSmkybVdxRkxYUlBUcUtKTW9RZkN3ZlFPTHpxczlRb1laWFJobHpN?=
 =?utf-8?B?NmZnUWE5WWtld2FZeEM4SFJnUmFDSnp3VmxxWUVwdHJ5OFYvd0QzZnNPalRz?=
 =?utf-8?B?WEJ2OGZtTkdRSHV5RFdFR1ZoVVEyWUdPVWhNMjU2OCtvYXBXd0ZOaDlGWlBR?=
 =?utf-8?B?WjVSaGRLeW15QlFDNXUwU0x6ZlZFWVRHWGNKekdGazY1clNxVEJBY0JLNmNR?=
 =?utf-8?B?bDBQaWU3dmpVTXE0N1YxcEhObytmNVNyRC9IeVN3dUdUbXpWd2xUTWxTQVBG?=
 =?utf-8?B?dThJK2JUV2ZYYzM2S0hzeklacWdRdndRWGxGYSt4RHc0bHR0b1lhN1llQWhu?=
 =?utf-8?B?SWpqZEJZaTZIU3d5L0ViVjd2R0w2Y056YmlEMUZnRlFIVm84cjFYOFB4Mzk2?=
 =?utf-8?B?aC9LQ1lEaGMvZ2k2WnpiNkprN2EzalRCeHY5NlR5dGNxSlVkUEY4WmxValFv?=
 =?utf-8?B?VFlEek43cndmQlN3alRMeDVYUlVpUTM5V1FwV0gvR1N3eEFqSHdPVWo4MnBV?=
 =?utf-8?B?aWpyU2JNc0NYQ2pYWGhubFloeGJiaW8rSHoxZm9RTnNMK3VvQjk3d3B2S3Vi?=
 =?utf-8?B?VE1KaHlyNFZFSGh5NWNTY1lYRFlUNTdUMU9ZeXF4VzNFREVFZktLTW4wbVJS?=
 =?utf-8?B?UHBMNVJSNjQxUHNrcmtWR215OE10cVcyWnhETEQ0a2REc05CS3RNRm9jbUM1?=
 =?utf-8?B?aDhCRGN3SGZ1WXZqamtoOHpncmZRUlJUYVZ5VzMyN2Z2RUxQbHFwWENDWjBX?=
 =?utf-8?B?N2w0RndqODBwZ3Mzank0VlgwRENVejkrbWgrWjI2eXczeGx6dVo4UGoySFNi?=
 =?utf-8?B?VTV0c1hrbVBBN0FkRFVZVGRCZnQ0Z2FrNjdsNnpLOUk5aDZpbWZ4bWNRUWlW?=
 =?utf-8?B?YTVyUnd6SElUNjR4cHFXMHk2bUlRQ0UrYnBwcWcwRWlTUENrWVdydm9ieTFC?=
 =?utf-8?Q?JK50R+jiD+6eN21ce9ReAT11wnjiE0y2b9QMU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A246A3A4E83694BA641220067E06A82@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ol5peOw9Yl0BK9xkQxJXnGnZbESYqhb1drmBbwF2OX1FTSNEodD8mM2TrrzaFt5LDD/dJV3FchXj4MZQkSesdFDifWtzz0+JtkDxotzDvyKgl27IH5RLZnJ7GR0lWKipYjqVTVh8/BVdkFZRzUdysm4oiL9ljnB29hTLM/gL+ccwbtajXDYN6ndB+8coHPc4ecKi5qDtolzbW4BPtcBXcOkMkIfDXTz2V3mQPLG3/CGTEYDd8lvGET8+NB6eVJOTrXhJGCCpOWJ3cWPEEPIV5Bq5dx7d96pH3v4z66eVQqYIiIPmO0UBB7omBtrykqj5d5sGcUmoqSK3uVSxg2fCNw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2375755-f65e-4438-b303-08debb5b97d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 19:18:39.6576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FA/j45xg9J34FS1hSy0N5mDDRZpccOadbouozm2wYgBx4p+SR5XRa8LIF6SoDzrOJMA4TdjYEqrL1zlEokb/zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3857
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: tE4Kn0h_0WvykBOBQHZkKduk3Q3jBnyR
X-Proofpoint-ORIG-GUID: f09mQ0foclJ9WSGUTfpsLOZVB9aDMGcm
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a15f218 cx=c_pps
 a=0bDVNUKav+K/acou55tioQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=Bayn7meQWHFpFR3Fm8EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE2OCBTYWx0ZWRfX2oJ6aOGacbfY
 KIwVow2fOf025pOq5yagcmJvSqCHPgrgUYVwWUDEU98Nq34rABJcLMqMoZ38pt6fHZ6BtFmJ6T8
 R0q8uORrRgT6OE9jJRiLpP50x/2rKHJN3Gwy3Ltyjwe9M9pYml9RIyZj/uXFXNg2ftgGi0ZEDe3
 coFpCN6sImubkB/2U+gD7LqxkQDQWARauS5hnmw5woAYe6wJ8H+LG0Eu87Yd+WePu4HjnFVR9i9
 vSl2if4xnh9LfPYwUfiWs/03LvZ1dpc6ZYdIyh4suxWS0iZXi5dYU8h1lck6mDqY90wVHhymB7o
 MP9qd5JNjJ9PfH0chxqLOoLqcSmlo2Z/8Pf3bRWsTVASIEqwqML4UmhxlcO6iJJMQczSEDXMSN4
 +dqU+gAftn6Irl0hOvzlAgjAxiJeVG6xUnUehmcJKt2lwDRcwpEZWPaXV1i+1TqbZwW/mhSY24v
 WDy/qevlrTbnGYx9YZw==
Subject: Re:  [PATCH] ceph: fix multiple unsafe decodes in decode_locker()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260168
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254430-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.747];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 226D85DBECF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gU2F0LCAyMDI2LTA1LTIzIGF0IDA0OjU5IC0wNDAwLCBQYXZpdHJhIEpoYSB3cm90ZToNCj4g
ZGVjb2RlX2xvY2tlcigpIGluIGNsc19sb2NrX2NsaWVudC5jIGNvbnRhaW5zIHRocmVlIHVuc2Fm
ZSBkZWNvZGUNCj4gb3BlcmF0aW9ucyB0aGF0IGFsbG93IGEgbWFsaWNpb3VzIG9yIGNvbXByb21p
c2VkIE9TRCB0byB0cmlnZ2VyDQo+IHNsYWItb3V0LW9mLWJvdW5kcyByZWFkczoNCj4gDQo+IDEu
IGNlcGhfZGVjb2RlX2NvcHkoKSBhdCB0aGUgbG9ja2VyX2lkX3QgbmFtZSBmaWVsZCBoYXMgbm8g
cHJlY2VkaW5nDQo+ICAgIGJvdW5kcyBjaGVjay4gV2l0aCBwID09IGVuZCBhZnRlciBjZXBoX3N0
YXJ0X2RlY29kaW5nKCkgYWNjZXB0cw0KPiAgICBzdHJ1Y3RfbGVuPTAsIHRoaXMgcmVhZHMgc2l6
ZW9mKGNlcGhfZW50aXR5X25hbWUpID0gOSBieXRlcyBwYXN0DQo+ICAgIHRoZSB2YWxpZGF0ZWQg
YnVmZmVyIGJvdW5kYXJ5Lg0KPiANCj4gMi4gKnAgKz0gc2l6ZW9mKHN0cnVjdCBjZXBoX3RpbWVz
cGVjKSBhZnRlciB0aGUgbG9ja2VyX2luZm9fdCBoZWFkZXINCj4gICAgaXMgYW4gdW5jaGVja2Vk
IHBvaW50ZXIgYWR2YW5jZS4gQSBtYWxpY2lvdXMgT1NEIGNhbiBwb3NpdGlvbiBwDQo+ICAgIHBh
c3QgZW5kLCBjYXVzaW5nIGFsbCBzdWJzZXF1ZW50IF9zYWZlIGNoZWNrcyB0byBwYXNzIGFnYWlu
c3QgYQ0KPiAgICBib2d1cyBib3VuZGFyeS4NCj4gDQo+IDMuIGxlbiA9IGNlcGhfZGVjb2RlXzMy
KHApIGhhcyBubyBwcmVjZWRpbmcgYm91bmRzIGNoZWNrLCBhbmQgdGhlDQo+ICAgIGltbWVkaWF0
ZWx5IGZvbGxvd2luZyAqcCArPSBsZW4gaXMgdW5jYXBwZWQuIEEgbWFsaWNpb3VzIE9TRCBjYW4N
Cj4gICAgc2VuZCBsZW49MHhmZmZmZmZmZiwgYWR2YW5jaW5nIHAgZ2lnYWJ5dGVzIHBhc3QgZW5k
IGFuZCBlc2NhcGluZw0KPiAgICB0aGUgZGVjb2RlIHdpbmRvdyBlbnRpcmVseS4NCj4gDQo+IEZp
eCBhbGwgdGhyZWUgYnkgcmVwbGFjaW5nIGJhcmUgb3BlcmF0aW9ucyB3aXRoIHRoZWlyIHNhZmUg
dmFyaWFudHM6DQo+ICAgY2VwaF9kZWNvZGVfY29weSAgIC0+IGNlcGhfZGVjb2RlX2NvcHlfc2Fm
ZQ0KPiAgICpwICs9IHNpemVvZiguLi4pICAtPiBjZXBoX2RlY29kZV9za2lwX24NCj4gICBjZXBo
X2RlY29kZV8zMihwKSAgLT4gY2VwaF9kZWNvZGVfMzJfc2FmZQ0KPiAgICpwICs9IGxlbiAgICAg
ICAgICAtPiBjZXBoX2RlY29kZV9za2lwX24NCj4gDQo+IEEgbmV3IGJhZDogbGFiZWwgaXMgYWRk
ZWQgdG8gcmV0dXJuIC1FSU5WQUwgb24gYW55IGJvdW5kcyB2aW9sYXRpb24uDQo+IA0KPiBLQVNB
TiByZXBvcnQgKGtlcm5lbCA3LjAuMC1yYzcsIFFFTVUveDg2XzY0LCBLQVNMUiBkaXNhYmxlZCk6
DQo+IA0KPiAgIFsgICAyNi4xODM5NjldIGNlcGhfb29iNF9wb2M6IGJ1Zj1mZmZmODg4MDA5ZTMx
MDAwIGVuZD1mZmZmODg4MDA5ZTMxZmEwDQo+ICAgWyAgIDI2LjE4NjA4N10gY2VwaF9vb2I0X3Bv
Yzogc3RydWN0X3Y9MSBzdHJ1Y3RfbGVuPTAgcD09ZW5kOiAxDQo+ICAgWyAgIDI2LjE4NjczOF0g
Y2VwaF9vb2I0X3BvYzogdHJpZ2dlcmluZyBiYXJlIGNlcGhfZGVjb2RlXzMyIHBhc3Qgc2xhYiBi
b3VuZGFyeS4uLg0KPiAgIFsgICAyNi4xODc2NzldID09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiAgIFsgICAyNi4xODgy
MzZdIEJVRzogS0FTQU46IHNsYWItb3V0LW9mLWJvdW5kcyBpbiBjZXBoX29vYjRfaW5pdCsweDIy
Yi8weGZmMCBbY2VwaF9vb2I0X3BvY10NCj4gICBbICAgMjYuMTg4MjM2XSBSZWFkIG9mIHNpemUg
NCBhdCBhZGRyIGZmZmY4ODgwMDllMzFmYTAgYnkgdGFzayBpbnNtb2QvNTkNCj4gICBbICAgMjYu
MTg4MjM2XSBDUFU6IDAgVUlEOiAwIFBJRDogNTkgQ29tbTogaW5zbW9kIFRhaW50ZWQ6IEcgICAg
ICAgICAgIE8gICAgICAgIDcuMC4wLXJjNy1nOWMyYWJmNjlkYTgzLWRpcnR5ICMxNSBQUkVFTVBU
KGxhenkpDQo+ICAgWyAgIDI2LjE4ODIzNl0gVGFpbnRlZDogW09dPU9PVF9NT0RVTEUNCj4gICBb
ICAgMjYuMTg4MjM2XSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQ
SUlYLCAxOTk2KSwgQklPUyAxLjE3LjAtZGViaWFuLTEuMTcuMC0xIDA0LzAxLzIwMTQNCj4gICBb
ICAgMjYuMTg4MjM2XSBDYWxsIFRyYWNlOg0KPiAgIFsgICAyNi4xODgyMzZdICA8VEFTSz4NCj4g
ICBbICAgMjYuMTg4MjM2XSAgZHVtcF9zdGFja19sdmwrMHg0ZC8weDcwDQo+ICAgWyAgIDI2LjE4
ODIzNl0gIHByaW50X3JlcG9ydCsweDE3MC8weDRmMw0KPiAgIFsgICAyNi4xODgyMzZdICA/IF9f
cGZ4X19yYXdfc3Bpbl9sb2NrX2lycXNhdmUrMHgxMC8weDEwDQo+ICAgWyAgIDI2LjE4ODIzNl0g
IGthc2FuX3JlcG9ydCsweGRhLzB4MTEwDQo+ICAgWyAgIDI2LjE4ODIzNl0gID8gY2VwaF9vb2I0
X2luaXQrMHgyMmIvMHhmZjAgW2NlcGhfb29iNF9wb2NdDQo+ICAgWyAgIDI2LjE4ODIzNl0gID8g
Y2VwaF9vb2I0X2luaXQrMHgyMmIvMHhmZjAgW2NlcGhfb29iNF9wb2NdDQo+ICAgWyAgIDI2LjE4
ODIzNl0gID8gX19wZnhfY2VwaF9vb2I0X2luaXQrMHgxMC8weDEwIFtjZXBoX29vYjRfcG9jXQ0K
PiAgIFsgICAyNi4xODgyMzZdICBjZXBoX29vYjRfaW5pdCsweDIyYi8weGZmMCBbY2VwaF9vb2I0
X3BvY10NCj4gICBbICAgMjYuMTg4MjM2XSAgZG9fb25lX2luaXRjYWxsKzB4OWEvMHgzYTANCj4g
ICBbICAgMjYuMTg4MjM2XSAgPyBfX3BmeF9kb19vbmVfaW5pdGNhbGwrMHgxMC8weDEwDQo+ICAg
WyAgIDI2LjE4ODIzNl0gIGRvX2luaXRfbW9kdWxlKzB4MjdjLzB4NzkwDQo+ICAgWyAgIDI2LjE4
ODIzNl0gIGxvYWRfbW9kdWxlKzB4NGE5YS8weDYzNTANCj4gICBbICAgMjYuMTg4MjM2XSAgaW5p
dF9tb2R1bGVfZnJvbV9maWxlKzB4MTVjLzB4MTgwDQo+ICAgWyAgIDI2LjE4ODIzNl0gIGlkZW1w
b3RlbnRfaW5pdF9tb2R1bGUrMHgyMWYvMHg3NTANCj4gICBbICAgMjYuMTg4MjM2XSAgX194NjRf
c3lzX2Zpbml0X21vZHVsZSsweGJhLzB4MTIwDQo+ICAgWyAgIDI2LjE4ODIzNl0gIGRvX3N5c2Nh
bGxfNjQrMHhlMi8weDU3MA0KPiAgIFsgICAyNi4xODgyMzZdICBlbnRyeV9TWVNDQUxMXzY0X2Fm
dGVyX2h3ZnJhbWUrMHg3Ny8weDdmDQo+ICAgWyAgIDI2LjE4ODIzNl0gIDwvVEFTSz4NCj4gICBb
ICAgMjYuMTg4MjM2XSBUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBvYmplY3QgYXQg
ZmZmZjg4ODAwOWUzMTAwMA0KPiAgIFsgICAyNi4xODgyMzZdICB3aGljaCBiZWxvbmdzIHRvIHRo
ZSBjYWNoZSBrbWFsbG9jLTRrIG9mIHNpemUgNDA5Ng0KPiAgIFsgICAyNi4xODgyMzZdIFRoZSBi
dWdneSBhZGRyZXNzIGlzIGxvY2F0ZWQgMCBieXRlcyB0byB0aGUgcmlnaHQgb2YNCj4gICBbICAg
MjYuMTg4MjM2XSAgYWxsb2NhdGVkIDQwMDAtYnl0ZSByZWdpb24gW2ZmZmY4ODgwMDllMzEwMDAs
IGZmZmY4ODgwMDllMzFmYTApDQo+ICAgWyAgIDI2LjE4ODIzNl0gTWVtb3J5IHN0YXRlIGFyb3Vu
ZCB0aGUgYnVnZ3kgYWRkcmVzczoNCj4gICBbICAgMjYuMTg4MjM2XSAgZmZmZjg4ODAwOWUzMWYw
MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj4gICBb
ICAgMjYuMTg4MjM2XSA+ZmZmZjg4ODAwOWUzMWY4MDogMDAgMDAgMDAgMDAgZmMgZmMgZmMgZmMg
ZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMNCj4gICBbICAgMjYuMTg4MjM2XSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXg0KPiAgIFsgICAyNi4xODgyMzZdICBmZmZmODg4MDA5ZTMyMDAw
OiBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYw0KPiAgIFsg
ICAyNi4xODgyMzZdID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiAgIFsgICAyNi4yNTU1MTNdIGNlcGhfb29iNF9wb2M6
IGxlbj0weGNjY2NjY2NjIChPT0IgZ2FyYmFnZSBmcm9tIEtBU0FOIHJlZHpvbmUpDQo+IA0KPiAg
IDB4Q0NDQ0NDQ0MgaXMgS0FTQU4gcmVkem9uZSBwb2lzb24sIGNvbmZpcm1pbmcgdGhlIHJlYWQg
bGFuZGVkIGluDQo+ICAgdGhlIHNsYWIgcmVkem9uZSBpbW1lZGlhdGVseSBwYXN0IHRoZSA0MDAw
LWJ5dGUgYWxsb2NhdGlvbi4NCj4gDQo+IEF0dGFja2VyIG1vZGVsOiBhIG1hbGljaW91cyBvciBj
b21wcm9taXNlZCBPU0QgaW4gYSBtdWx0aS10ZW5hbnQgQ2VwaA0KPiBkZXBsb3ltZW50IGNhbiB0
cmlnZ2VyIHRoaXMgYWdhaW5zdCBhbnkga2VybmVsIGNsaWVudCB0aGF0IGlzc3VlcyB0aGUNCj4g
bG9jay5nZXRfaW5mbyBjbGFzcyBtZXRob2QgKGUuZy4gZHVyaW5nIFJCRCBleGNsdXNpdmUgbG9j
ayBhY3F1aXNpdGlvbikNCj4gd2l0aG91dCBhbnkgZnVydGhlciBwcml2aWxlZ2VzIGJleW9uZCBP
U0Qgc2Vzc2lvbiBlc3RhYmxpc2htZW50Lg0KPiANCj4gRml4ZXM6IGQ0ZWQ0YTUzMDU2MiAoImxp
YmNlcGg6IHN1cHBvcnQgZm9yIGxvY2subG9ja19pbmZvIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUGF2aXRyYSBKaGEgPGpoYXBhdml0cmE5OEBnbWFp
bC5jb20+DQo+IC0tLQ0KPiAgbmV0L2NlcGgvY2xzX2xvY2tfY2xpZW50LmMgfCAxMCArKysrKyst
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL25ldC9jZXBoL2Nsc19sb2NrX2NsaWVudC5jIGIvbmV0L2NlcGgv
Y2xzX2xvY2tfY2xpZW50LmMNCj4gaW5kZXggNzgyNzYyNzNjLi4wMGYwMzA5YTYgMTAwNjQ0DQo+
IC0tLSBhL25ldC9jZXBoL2Nsc19sb2NrX2NsaWVudC5jDQo+ICsrKyBiL25ldC9jZXBoL2Nsc19s
b2NrX2NsaWVudC5jDQo+IEBAIC0yNTksNyArMjU5LDcgQEAgc3RhdGljIGludCBkZWNvZGVfbG9j
a2VyKHZvaWQgKipwLCB2b2lkICplbmQsIHN0cnVjdCBjZXBoX2xvY2tlciAqbG9ja2VyKQ0KPiAg
CWlmIChyZXQpDQo+ICAJCXJldHVybiByZXQ7DQo+ICANCj4gLQljZXBoX2RlY29kZV9jb3B5KHAs
ICZsb2NrZXItPmlkLm5hbWUsIHNpemVvZihsb2NrZXItPmlkLm5hbWUpKTsNCj4gKwljZXBoX2Rl
Y29kZV9jb3B5X3NhZmUocCwgZW5kLCAmbG9ja2VyLT5pZC5uYW1lLCBzaXplb2YobG9ja2VyLT5p
ZC5uYW1lKSwgYmFkKTsNCg0KQXJlIHlvdSBzdXJlIHRoYXQgdGhpcyBsaW5lIG5vdCBsb25nZXIg
dGhhbiA4MCBzeW1ib2xzPw0KDQo+ICAJcyA9IGNlcGhfZXh0cmFjdF9lbmNvZGVkX3N0cmluZyhw
LCBlbmQsIE5VTEwsIEdGUF9OT0lPKTsNCj4gIAlpZiAoSVNfRVJSKHMpKQ0KPiAgCQlyZXR1cm4g
UFRSX0VSUihzKTsNCj4gQEAgLTI3MCwxOSArMjcwLDIxIEBAIHN0YXRpYyBpbnQgZGVjb2RlX2xv
Y2tlcih2b2lkICoqcCwgdm9pZCAqZW5kLCBzdHJ1Y3QgY2VwaF9sb2NrZXIgKmxvY2tlcikNCj4g
IAlpZiAocmV0KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgDQo+IC0JKnAgKz0gc2l6ZW9mKHN0cnVj
dCBjZXBoX3RpbWVzcGVjKTsgLyogc2tpcCBleHBpcmF0aW9uICovDQo+ICsJY2VwaF9kZWNvZGVf
c2tpcF9uKHAsIGVuZCwgc2l6ZW9mKHN0cnVjdCBjZXBoX3RpbWVzcGVjKSwgYmFkKTsgLyogc2tp
cCBleHBpcmF0aW9uICovDQoNCkkgZG9uJ3QgdGhpbmsgdGhhdCBpdCBtYWtlcyBzZW5zZSB0byBr
ZWVwIGNvbW1lbnQgYXQgdGhlIGVuZCBvZiBsaW5lIG5vdy4gTGV0J3MNCmRvIGl0IGluIHN1Y2gg
d2F5Og0KDQovKiBza2lwIGV4cGlyYXRpb24gKi8NCmNlcGhfZGVjb2RlX3NraXBfbihwLCBlbmQs
IHNpemVvZihzdHJ1Y3QgY2VwaF90aW1lc3BlYyksIGJhZCk7DQoNCj4gIA0KPiAgCXJldCA9IGNl
cGhfZGVjb2RlX2VudGl0eV9hZGRyKHAsIGVuZCwgJmxvY2tlci0+aW5mby5hZGRyKTsNCj4gIAlp
ZiAocmV0KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgDQo+IC0JbGVuID0gY2VwaF9kZWNvZGVfMzIo
cCk7DQo+IC0JKnAgKz0gbGVuOyAvKiBza2lwIGRlc2NyaXB0aW9uICovDQo+ICsJY2VwaF9kZWNv
ZGVfMzJfc2FmZShwLCBlbmQsIGxlbiwgYmFkKTsNCj4gKwljZXBoX2RlY29kZV9za2lwX24ocCwg
ZW5kLCBsZW4sIGJhZCk7IC8qIHNraXAgZGVzY3JpcHRpb24gKi8NCg0KRGl0dG8uDQoNCi8qIHNr
aXAgZGVzY3JpcHRpb24gKi8NCmNlcGhfZGVjb2RlX3NraXBfbihwLCBlbmQsIGxlbiwgYmFkKTsN
Cg0KPiAgDQo+ICAJZG91dCgiJXMgJXMlbGx1IGNvb2tpZSAlcyBhZGRyICVzXG4iLCBfX2Z1bmNf
XywNCj4gIAkgICAgIEVOVElUWV9OQU1FKGxvY2tlci0+aWQubmFtZSksIGxvY2tlci0+aWQuY29v
a2llLA0KPiAgCSAgICAgY2VwaF9wcl9hZGRyKCZsb2NrZXItPmluZm8uYWRkcikpOw0KPiAgCXJl
dHVybiAwOw0KPiArYmFkOg0KDQpZb3UgYXJlIG5vdCBjb25zaXN0ZW50LiBOb3cgaXQncyBiYWQg
bmFtZSBidXQgbm90IGVfaW52YWwuIDopDQoNCj4gKwlyZXR1cm4gLUVJTlZBTDsNCg0KSSBzdGls
bCB0aGluayB0aGF0IHdlIGhhdmUgbm90IGlucHV0IGFyZ3VtZW50cyBoZXJlLiBJIGFtIG5vdCBm
dWxseSBzdXJlIHRoYXQNCkVJTlZBTCBpcyBwcm9wZXIgZXJyb3IgY29kZSBoZXJlLg0KDQpUaGFu
a3MsDQpTbGF2YS4NCg0KPiANCj4gDQoNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGludCBkZWNvZGVf
bG9ja2Vycyh2b2lkICoqcCwgdm9pZCAqZW5kLCB1OCAqdHlwZSwgY2hhciAqKnRhZywNCg==

