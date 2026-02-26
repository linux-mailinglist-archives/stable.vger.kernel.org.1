Return-Path: <stable+bounces-219857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G6mGl+roGlGlgQAu9opvQ
	(envelope-from <stable+bounces-219857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 21:21:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC371AF06A
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 21:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B922B30095D9
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC99466B67;
	Thu, 26 Feb 2026 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EBDusdV2"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C33F45104C;
	Thu, 26 Feb 2026 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137306; cv=fail; b=QrONkVIHwbDFikfS0D7tCO17C1wc2k38V1iJK5QDgMzztOLpTWnHF/ppRMRCWCewhV82SQk4vQYZgWTHCpeD5bTFylJfNIf1lpAOD5PiTbhPpcrRN6wYKLgJSmDD9FB4aMLjk3jkgWy1SOcSBDE7AeqnsAPJksec3bOcG+/pwIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137306; c=relaxed/simple;
	bh=/bxSuFUKJUOKaiyrgTdin9sCSQaMgidM/r5fzEzOsaA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=l6i+e+FTlwlMpnxjIjZ6ybrc5RHX1GZbVB0bYANUxIfncTVMkL9aYbZ7NE0hSKg73yt9Eggs7GBVhiIphSxbnlJVAoO56ntQvuDEfiaspJiZ8k0iPgZTl0pJcCHWr0XxOtj2EwLsY4dZ5EAbvwMA2+0jGpu54CcGr6Qr3oKYsdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EBDusdV2; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QG2DWu3273855;
	Thu, 26 Feb 2026 20:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=/bxSuFUKJUOKaiyrgTdin9sCSQaMgidM/r5fzEzOsaA=; b=EBDusdV2
	OjOBANi5uz4gcRhWWkpjWUfXPxbDQM1ogUTzx6Qm8pGFGL5zQgp3RGW8rRcSqAJo
	9RWm4mKNvj3ISsg2IBnQtoOspxmQt2ib/Z0KfpRV98S6bdanXL9cdChowKksZjZE
	SgppXpdvlvrXr3/J1KFwh44sBDWexPSXKIXrI9L5nF1FhuwgWfeRUwrWsFgwdzyZ
	CK0/5+2jdp063gcI3Qy9fSv3TwDe2quxCOGGNdj209fdI5GDRgNQKf4iWaUYlUBc
	TgK3+LlijAhehmf+P0U0BtQ2ewxsauzG4i1AbokhdzQAgo8765j1h3Ou4BysJj9c
	IKHE2Yj90XBlEg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4728ye9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 20:21:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seIIrvYn2mIQZlxV/dn6stTEoBF0liEUcP8DZFFYEm14L2qGULsV1/hpi3kIOT/kK5YAhLXAK4uW+woLP4i7eyuV7d5pa3hKl02PFQ7sjBjhfar0cdGkwaqOLFSVdquZDc8SafcTZ8SJbw3eDazzVaNhRzaZSlv2Ha8d1j/wfej3pM7s+WOeFFnkhMgTfxMRg8l3mWskGFt+dHsoSJMe3Vn/iiYfMol6SWU+cAID/og2r4LoniUks35rhA0khQrN+3kfUWvbDkFgY8rN4oBI8hOETNs66PwanMCogNoJSxsBPFIceqbI9uuIinjQaBV4t+5TaOoV80zIJFJB79usxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bxSuFUKJUOKaiyrgTdin9sCSQaMgidM/r5fzEzOsaA=;
 b=XGLOh7B2l87jbx7jx0l3HjW1NVinzwV5L1b5IEVW0dId02/u/4jGz9kksGIOxvs2cV2N7NvNRxGBFhCrp6hg0XLhqigUTup5vyCnadpndKXkzRi8CYc8f3u/JpKUcQ6LT7C3qL2+eKQD3F2p78VrecaX90ToALKsal8UA0tamnxk7H9pjiTwlgQurTsQD/5CTOKLmLAyjVg620kzHPMnDmecZUnVrWismaJxZ/MB3oXUIYQUK7Fy03raXK6w1mcz4sRyCJ6SDirf3p1AvtvWkXTtN6AyGgS+gQJ9IuMkbxu3XQdzpJuugMD+gWolGP3JPlOba2+Pg8NHqGc0oxfg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BL1PPF25982425A.namprd15.prod.outlook.com (2603:10b6:20f:fc04::e10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 20:21:35 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 20:21:34 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "hristo@venev.name" <hristo@venev.name>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Alex Markuze <amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re:  [PATCH] ceph: Do not skip the first folio of the
 next object in writeback
Thread-Index:
 AQHcppgDS668W704B0iRyTKXxOujMrWT6I8AgAF3MwCAAAMxgIAAA36AgAAD5gCAAAN4gA==
Date: Thu, 26 Feb 2026 20:21:34 +0000
Message-ID: <0c8d905c386f5f9ca2632307802ada7423c82c2a.camel@ibm.com>
References: <20260225170758.2014172-1-hristo@venev.name>
							 <50447e5d0d4e3bf993d05dc9da9dde1c20371378.camel@ibm.com>
						 <4c074e71fd58851a84596c4798b9378a3006d551.camel@venev.name>
					 <1d321c24a2c4045e8bd79922a94fb4264a40f7de.camel@ibm.com>
				 <daf3f64ab55d5c6e6c4bf612db609e5505795d05.camel@ibm.com>
			 <b7c3c502da0d135fe1d57014f9f1074f8a2d4ceb.camel@venev.name>
		 <c1c033c44edf8d20b0a9dd8944a2f21bec942c1e.camel@ibm.com>
	 <e714d8106a492077707cd31df96401a08caef6fe.camel@venev.name>
In-Reply-To: <e714d8106a492077707cd31df96401a08caef6fe.camel@venev.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BL1PPF25982425A:EE_
x-ms-office365-filtering-correlation-id: e1f4c0b3-24d0-41bf-1e05-08de7574a2f7
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021|13003099007;
x-microsoft-antispam-message-info:
 i3UmVLow3HJgCk49PiywmyPVYaKbo/FvzdTbqCaLXJ+X9dsYeAANRD7FO2ArRWxBzm0qX22JCHRrfAvGtoDjL+Hi5ura8+Q3gTtqhcb5+w/RqhC1p4YFea5NNYe4ABEWftOw5WTDYhO1U2xYi22qOCsE7RkYkjZ9B32Z7OO6Cp76oLB1q9yrW0Q+7sdqT6wTmub8dUN62oyAUIDX3/8QlzG/VJat/LAGRCg0Yhn/75Q/c0GL04FNZHZQpNvS0vIlUxTRnmFZDv+vDwB3/LQfetM1JARVSBmPKNEv/DKm9m+TPxaZuUE+n2168SSrSbLX/LHJxLS+qn8y42Uc1Mvjp8VJt19zGnswl08jUhjxKG5t7zyWax8SKPIEJGCP2U6TsxlXIYF8sk2CFaC13YoXRKflz5oeMixGiR81I3MSs8Br/S93zSSYTNz5pTh2xmG+x9iSYtgaGqaFUk4QqHrLKBQbsczEckM/Q98caXps1f81GhK59xgl8G8S+VMZfnA1D59iV7p8etjx71XzIzxaL7RN7XEDxBN2fSIJXCc1tDDpdCn51/OU6BIJAS5NBvFnx+X4LD7vXSw+BBq2oDuDNm0HkOFg/wF4f3oxkybzyPQ2n7q+xKUzgLhtlCK/MAS7ljui2VNSFfBFzWHiDGl1DaqPMxOX+BJZ6LYhprS5ctOsa5RuVCtVCdPIbQFw0qku6qVjbjIwMb2UIKBWcwT0qbswJAsKpNtLSt2QOG9dBXWWVV1ESEOe1B9C32kfp25E
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkZyZk1vMitpOXVBZ0pRenRwNTNZendCcHI4UlpWeFZRSTMwb2ZyUGtiMjFr?=
 =?utf-8?B?YjFRQVNpMTAwMU9SZkd2M3NhQlZ6RVlMbU1MQlhwUDlDRnRkSkJETWg5bG41?=
 =?utf-8?B?S1Uyak43SXljakRJUldUalJrTU5ZcU1FalpvR2tmeDkwSEVtQlhNNVNIOEJy?=
 =?utf-8?B?QlF3YktUKzZDSDN5S3ZRUW81NWNIZmtLK3ZJbkdTRnZqcThrTmlpbDcrblZW?=
 =?utf-8?B?STIwRkxZM0FWcGZYSVRMdHJnbzhFS0w5YVlXQkFJZkNoWFFyRWM5dVdRQjJY?=
 =?utf-8?B?UkdFcEozS0FZbldkRWEwTUg0Q1phUEo3QjJvRlNVc2ZLdEQ5Z2NRZW5nMmxh?=
 =?utf-8?B?cHZ3Nlk0ZUxnRDBJY0RieFAzWkI5V1JIMHpCTHFSRGF5aUovcTg4V0lGcDlm?=
 =?utf-8?B?UzJ4TTExTTBvZTdpWXRuSS9KSEdqUFNJZy93RDlSMTNNK3IwSjB3bDRQYzQ3?=
 =?utf-8?B?Tk9USzNmQWJYekIyQWhFWituQlhUbzVyM0RrazJpUnlZVi9TR3NsRytJRStF?=
 =?utf-8?B?aC94WW51YVhhU3cwNlhNOXFBWlZ5UFFOcVRSbFVxeGJCaTlMWk8yZDF5c1NR?=
 =?utf-8?B?ZUtQTFplSVZzdVRyWEloUXBZRzRhaklPSmlBa0NCQmFWN1o4NVg2UnFQTG9i?=
 =?utf-8?B?bGhiUjhidlNMdFAvZ0VFYmt3Vi81TXZVcFk3SncvMVNkV1VKMkpVbXEyNWRN?=
 =?utf-8?B?RlFTWlZCbEFkTE4raXNVenJSemZwZzdwNnY2dzlvRTBPa0pVdXFYQytyaThJ?=
 =?utf-8?B?NFFZVktBQW1XQnV1VFJtNlhUTWc1cGZ6UFUwaTdDZGUzcHpqYWdhOVNRUndV?=
 =?utf-8?B?b3pkWnZvNzkyUEl0REtmcUF6ejFFNWJuRno5d1Nuek9rVlJSM2Fpb2ZIYmNQ?=
 =?utf-8?B?Y2tLWVVNRjN0TnNQWnhSNWdLTFlmUUxwY0dFei94eUxXMnJwaWFnSStCckRy?=
 =?utf-8?B?WEJvdmZMTThUQmVZS0dYVnNTaUtqaERmVlV0b1pLVHpDS01wNW1TdHNDRjli?=
 =?utf-8?B?Ni85LzgzaEM5MDJYSGJJMDVnQ1RyYmhaUHN6MmRzMnNEamY4dlo2OWlsM1R2?=
 =?utf-8?B?RG0xM0x2d3crK0VEZE5FNy9wMG5oeVZwUEd1ZjQxRE0zRGJyKy9veVJBU24z?=
 =?utf-8?B?Y29zb2xNeThYSGlSUHNYTGluTnNTSVA2VFd3VEFML1VIeW5lZE11N1preUpp?=
 =?utf-8?B?TVducnBjSFJ3Qk1HVm8wVHVOV0gwbE40bFVQMDJQSytGVFIvd0VaWlBmL0Jj?=
 =?utf-8?B?dENFSkQvQUFxUEx3a1JHa0loRE5jRmIzYTdjL2p5VDdzaEVadzJhQXk5NEVl?=
 =?utf-8?B?dmRFSFIwaGduRmtTYmhrK0xRRE12SmsvR294TXc0SXR4elp5cHBBSVNOZm9E?=
 =?utf-8?B?UWlwcnpKWmNhZFlveWNSQ29XcTYrTElpQjVKWUJkeVJ0RXlkTVhIbGdYM1Zm?=
 =?utf-8?B?K0lGV3pXQWg2b0pkUTZUbUdxWXY5b2lXNThQaUkvWnM3eElmWURFTjBWdWlC?=
 =?utf-8?B?UVlFQjVzVzNhb1dOMytDM3hscU9Wcmp4VXR6TWVrSWx1VFFtcGRqcWVsaFNP?=
 =?utf-8?B?MzZIcDRQSnhLZDZFRjNxdUxoc2Y1M2dkVG1OM3VIcEU4SDAxUy9sWDkzZnVU?=
 =?utf-8?B?S3g1KzA2SUZhZDIxWEoxNXRWbElDTGI4RGNLcTI4cFdhaXVqWHNtQjdQVVh2?=
 =?utf-8?B?RFZQcUlwZEsyZW1xZWlaeWlyU3Q5WSt3Y3RMbXRBWDR6WWFFRmRONkVGZWkr?=
 =?utf-8?B?SkRBcFBKa2MveWR3MU84QmJUVE9GOW1qbHpZVVpKcW9VVFV3SGtXSW03WnBB?=
 =?utf-8?B?dENYUHdkSThTU2JUUDhCZndYWDJzK2FRclJrM2UydG5DUzRFNXh1V2N1eVRV?=
 =?utf-8?B?UnU0RTlmZFppdURyMm1FbHhhL0N2Rmk1TWpWbGg2RXFNeXVzQy9qTEJpcEJB?=
 =?utf-8?B?Z1VuS0xYdjhxcmJxS095LzNWckh3RkdaTHlrUXNIMDJacklPbVptaFcwMlM0?=
 =?utf-8?B?UVV4a1FhMjg2VFN1Y1I0dGFFRlZsNzdhTzRla2o5anlDOWYwMzE3ZE1TUGtt?=
 =?utf-8?B?TlNodjVPNEpZSmdrMSt4T0o1NjFHOTJIaUloanpEcEViZGEraStMVGplZU1a?=
 =?utf-8?B?Y2ZqZXowMXdVbXNlYWFENDB6WTFZNWVicU9YeWp5MkJKQVo3Y0poaGRXMnZt?=
 =?utf-8?B?RUNiOWRDVXZwQ01sc1N6SEVJTDEzVitCY3JMMVdJWXlqOXMxZnpDaVR6cENW?=
 =?utf-8?B?RDFGUDl3elhsaFlvRm5rV2hORXVmOS9MbHN0c2NuTGVzVURPc0dUSUNIeERT?=
 =?utf-8?B?eEwwcTFVZlhCSW13UnBpOVczOUhOWGZicEprdUJDdW0yK1NpcE1EcytwVVhv?=
 =?utf-8?Q?xTPyJhaloHvLEzfzneyajfs5gx4o8zUVBpLhR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D1D0DF122A17945B4B4902A2275A094@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f4c0b3-24d0-41bf-1e05-08de7574a2f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 20:21:34.3808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BiDLT/W4iVsbLMB5UrzLWJH8T95BSiewlfZB8u0t2Hm/+CfDH6UzXYZjXkNv4mgt20GeDrwb6CqmIGN1wweszw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF25982425A
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 52Ebiz2erAaa-VPJthmSQEMMbxjajm-b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE4NCBTYWx0ZWRfX7Bqn6RZ0S7iU
 AEPzt7LyX1gsIuZdQMeYR2pEazISSLniGGI0ddLyJfLaW34/6ViPWV0GC3RAbBNPv/Hjzn1ktOJ
 jOc3R56vzQY8io37q99oNNak5RihhVWzx0Cn25OIcJ3DO7+HCutxHlT0O9Mx/Vpf7p7jUcT/RXm
 FHCjxvJ3QuwIs0Aoj79Go664Zc1ot+o4eQUjaKiGossJrWSs3kZlDGJVTNQeqpalb4R6j0M4hs7
 JeHa839XsP2k98k9AASHB2uld/Yu0KtmBcdSNkfQ6Ao5i7m+j+odr0p949ssVc+kttqxc6UFyQh
 h240d008Kgmq3braJJySB7qWJwL4UCkSwk6KCb0SkKPg3eEkJ702URvhJFi7JIfwrcH9qdAWiAb
 qUc6MIW+yMrPpJ5wV2i47uNfryPetkjrekFA0/Cz8IFVRrPEZs0qV6yDi4KZ1N0Nq3/XXoV92S0
 iOGIgxazmllNPe7b3kA==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=69a0ab52 cx=c_pps
 a=duIt1iBHFgRvnGs5ekVepw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=GVT9W4Wiak6UpZ1B:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=W_FtzOmwHllGhE5sz3oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mrE_Z5Y0DvWasW5gRl2iPyL8rb3aSp-c
Subject: RE:  [PATCH] ceph: Do not skip the first folio of the next object in
 writeback
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260184
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219857-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com,dubeyko.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,box:email,venev.name:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5BC371AF06A
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTI2IGF0IDIyOjA5ICswMjAwLCBIcmlzdG8gVmVuZXYgd3JvdGU6DQo+
IE9uIFRodSwgMjAyNi0wMi0yNiBhdCAxOTo1NSArMDAwMCwgVmlhY2hlc2xhdiBEdWJleWtvIHdy
b3RlOg0KPiA+IEFyZSB5b3UgY2FwYWJsZSB0byBleGVjdXRlIHN1Y2Nlc3NmdWxseSB0aGlzIHNl
cXVlbmNlPw0KPiA+IA0KPiA+IGI0IGFtDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9p
bnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19sb3JlLmtlcm5lbC5vcmdfY2VwaC0yRGRldmVsXzIw
MjYwMjI1MTcwNzU4LjIwMTQxNzItMkQxLTJEaHJpc3RvLTQwdmVuZXYubmFtZV9UXy0yM3UmZD1E
d0lGYVEmYz1CU0RpY3FCUUJEakRJOVJrVnlUY0hRJnI9cTViSW00QVhNemM4Tkp1MV9SR21uUTJm
TVdLcTRZNFJBa0VsdlVnU3MwMCZtPXU5NklIdlRhLWFaSG5YN3kyMzZFRUl6cHBXQTNtLTVrdkNs
UUc4dFZjaVI2SkNwWTVDYXVhaTAzdW80VHZJZDgmcz1xX2JYdXBHWGRxNVlJTG9TOWoxbE8ybm1Q
djI4RVlNZjhRUkEtQm9Pb2hRJmU9IA0KPiA+IGdpdCBhbQ0KPiA+IDIwMjYwMjI1X2hyaXN0b19j
ZXBoX2RvX25vdF9za2lwX3RoZV9maXJzdF9mb2xpb19vZl90aGVfbmV4dF9vYmplY3RfaQ0KPiA+
IG5fd3JpdGViYWNrDQo+ID4gLm1ieA0KPiANCj4gSXQgYXBwbGllcyBmb3IgbWUgb24gdjcuMC1y
YzE6DQo+IA0KPiANCj4gaHJpc3RvQGJveCB+L3N3L2xpbnV4ICQgZ2l0IGNoZWNrb3V0IHY3LjAt
cmMxDQo+IEhFQUQgaXMgbm93IGF0IDZkZTIzZjgxYTVlMDggTGludXggNy4wLXJjMQ0KPiBocmlz
dG9AYm94IH4vc3cvbGludXggJCBiNCBhbSAnaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQu
Y29tL3YyL3VybD91PWh0dHBzLTNBX19sb3JlLmtlcm5lbC5vcmdfY2VwaC0yRGRldmVsXzIwMjYw
MjI1MTcwNzU4LjIwMTQxNzItMkQxLTJEaHJpc3RvLTQwdmVuZXYubmFtZV9UXy0yM3UmZD1Ed0lG
YVEmYz1CU0RpY3FCUUJEakRJOVJrVnlUY0hRJnI9cTViSW00QVhNemM4Tkp1MV9SR21uUTJmTVdL
cTRZNFJBa0VsdlVnU3MwMCZtPXU5NklIdlRhLWFaSG5YN3kyMzZFRUl6cHBXQTNtLTVrdkNsUUc4
dFZjaVI2SkNwWTVDYXVhaTAzdW80VHZJZDgmcz1xX2JYdXBHWGRxNVlJTG9TOWoxbE8ybm1QdjI4
RVlNZjhRUkEtQm9Pb2hRJmU9ICcNCj4gQW5hbHl6aW5nIDcgbWVzc2FnZXMgaW4gdGhlIHRocmVh
ZA0KPiBBbmFseXppbmcgMCBjb2RlLXJldmlldyBtZXNzYWdlcw0KPiBDaGVja2luZyBhdHRlc3Rh
dGlvbiBvbiBhbGwgbWVzc2FnZXMsIG1heSB0YWtlIGEgbW9tZW50Li4uDQo+IC0tLQ0KPiAgIOKc
kyBbUEFUQ0hdIGNlcGg6IERvIG5vdCBza2lwIHRoZSBmaXJzdCBmb2xpbyBvZiB0aGUgbmV4dCBv
YmplY3QgaW4gd3JpdGViYWNrDQo+ICAgLS0tDQo+ICAg4pyTIFNpZ25lZDogREtJTS92ZW5ldi5u
YW1lDQo+IC0tLQ0KPiBUb3RhbCBwYXRjaGVzOiAxDQo+IC0tLQ0KPiAgTGluazogaHR0cHM6Ly91
cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19sb3JlLmtlcm5lbC5v
cmdfcl8yMDI2MDIyNTE3MDc1OC4yMDE0MTcyLTJEMS0yRGhyaXN0by00MHZlbmV2Lm5hbWUmZD1E
d0lGYVEmYz1CU0RpY3FCUUJEakRJOVJrVnlUY0hRJnI9cTViSW00QVhNemM4Tkp1MV9SR21uUTJm
TVdLcTRZNFJBa0VsdlVnU3MwMCZtPXU5NklIdlRhLWFaSG5YN3kyMzZFRUl6cHBXQTNtLTVrdkNs
UUc4dFZjaVI2SkNwWTVDYXVhaTAzdW80VHZJZDgmcz1WNHlvdUZXbmRvVHVHZ1RaeHpRb1RZMjQ4
eUpuUEdaWGdKMkZpX2FhSVQ4JmU9IA0KPiAgQmFzZTogYXBwbGllcyBjbGVhbiB0byBjdXJyZW50
IHRyZWUNCj4gICAgICAgIGdpdCBjaGVja291dCAtYiAyMDI2MDIyNV9ocmlzdG9fdmVuZXZfbmFt
ZSBIRUFEDQo+ICAgICAgICBnaXQgYW0gLi8yMDI2MDIyNV9ocmlzdG9fY2VwaF9kb19ub3Rfc2tp
cF90aGVfZmlyc3RfZm9saW9fb2ZfdGhlX25leHRfb2JqZWN0X2luX3dyaXRlYmFjay5tYngNCj4g
aHJpc3RvQGJveCB+L3N3L2xpbnV4ICQgZ2l0IGFtIC4vMjAyNjAyMjVfaHJpc3RvX2NlcGhfZG9f
bm90X3NraXBfdGhlX2ZpcnN0X2ZvbGlvX29mX3RoZV9uZXh0X29iamVjdF9pbl93cml0ZWJhY2su
bWJ4DQo+IEFwcGx5aW5nOiBjZXBoOiBEbyBub3Qgc2tpcCB0aGUgZmlyc3QgZm9saW8gb2YgdGhl
IG5leHQgb2JqZWN0IGluIHdyaXRlYmFjaw0KPiBocmlzdG9AYm94IH4vc3cvbGludXggJCBnaXQg
c2hvdyB8IGhlYWQNCj4gY29tbWl0IDE0ZjQ5NGNlZmQwYTQ5YWJmNDFkNDU1YjRjM2EzMGQ3OGJh
MWY5MWINCj4gQXV0aG9yOiBIcmlzdG8gVmVuZXYgPGhyaXN0b0B2ZW5ldi5uYW1lPg0KPiBEYXRl
OiAgIFdlZCBGZWIgMjUgMTk6MDc6NTYgMjAyNiArMDIwMA0KPiANCj4gICAgIGNlcGg6IERvIG5v
dCBza2lwIHRoZSBmaXJzdCBmb2xpbyBvZiB0aGUgbmV4dCBvYmplY3QgaW4gd3JpdGViYWNrDQo+
ICAgICANCj4gICAgIFdoZW4gYGNlcGhfcHJvY2Vzc19mb2xpb19iYXRjaGAgZW5jb3VudGVycyBh
IGZvbGlvIHBhc3QgdGhlIGVuZCBvZiB0aGUNCj4gICAgIGN1cnJlbnQgb2JqZWN0LCBpdCBzaG91
bGQgbGVhdmUgaXQgaW4gdGhlIGJhdGNoIHNvIHRoYXQgaXQgaXMgcGlja2VkIHVwDQo+ICAgICBp
biB0aGUgbmV4dCBpdGVyYXRpb24uDQo+ICAgICANCj4gaHJpc3RvQGJveCB+L3N3L2xpbnV4ICQg
c2hhMjU2c3VtIC4vMjAyNjAyMjVfaHJpc3RvX2NlcGhfZG9fbm90X3NraXBfdGhlX2ZpcnN0X2Zv
bGlvX29mX3RoZV9uZXh0X29iamVjdF9pbl93cml0ZWJhY2subWJ4IA0KPiBhNjIzZTFmOGYwNjAw
MGVmZDg2YjA3ODExNGJhNDFjNGYwNzliNWMxNDBjZGM4MzQyZTY5OTNiYjlkMjk5ODUxICAuLzIw
MjYwMjI1X2hyaXN0b19jZXBoX2RvX25vdF9za2lwX3RoZV9maXJzdF9mb2xpb19vZl90aGVfbmV4
dF9vYmplY3RfaW5fd3JpdGViYWNrLm1ieA0KPiA+IA0KDQpZZWFoLCBJIHdhcyBhYmxlIHRvIGFw
cGx5IHRoZSBwYXRjaCBvbiB2Ny4wLXJjMS4gOikgQnV0IEkgdHJpZWQgdG8gYXBwbHkgb24gdGhl
DQplYXJsaWVyIHZlcnNpb25zIGJlY2F1c2Ugc29tZWhvdyB4ZnN0ZXN0cyB3YXMgZmFpbGluZyB3
aXRoIHRoZSBrZXJuZWwgY3Jhc2ggb24NCjYuMTkgcmVsZWFzZSBmb3IgQ2VwaEZTIGtlcm5lbCBj
bGllbnQuIEFuZCBJIGFtIHRyeWluZyB0byBpbnZlc3RpZ2F0ZSB3aGF0IHRoZQ0KaGVsbCBpcyBn
b2luZyBvbi4gU28sIGxldCdzIHNlZSB3aGF0IEkgd2lsbCBoYXZlIGZvciB2Ny4wLXJjMS4gOikg
SXQgY291bGQgZGVsYXkNCnlvdXIgcGF0Y2ggdGVzdGluZy4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

