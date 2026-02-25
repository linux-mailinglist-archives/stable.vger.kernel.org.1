Return-Path: <stable+bounces-219703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFaNOTdbn2lRagQAu9opvQ
	(envelope-from <stable+bounces-219703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 21:27:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B4A19D319
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 21:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92A983124CC0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 20:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F653090D4;
	Wed, 25 Feb 2026 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AwLRLA1P"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF0830DEA5;
	Wed, 25 Feb 2026 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051077; cv=fail; b=JVzQe5uUY9FKFKYuN2ki9sT0bP4kH+ERchJWArl4RHsz0QwXUZSZ8BBCDbvCNthFE6AFJ0mj6C9tk2nnqBPCNRJkem5ngB9k1nWTOi2jXzkAqyY5njQVTOF0Bd1c8J3IFHMtpS0nwk0jXg8ferFPKljvFg5phhpOs6taEBHSGog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051077; c=relaxed/simple;
	bh=NeGRwzhc5hg9f4J9DCKCpSstDyFn2BFWAQY67xL3jxE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=YQT03KW6wSZnvUFexyz86M5MGXD19KolHb2mB1vIIJEmPnR5b8pI3oCD8WZ27oEB/ixrRddStuTv0jWaFySAqRRvzEyWjDERt3LtxyQow7idtz8qKmwfA9Gk1vTvZv1CzoxEk+BeuJO8MTD8TI7UhudOIkV75zE9CeGDKsIiS7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AwLRLA1P; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PBnHpq2465972;
	Wed, 25 Feb 2026 20:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=NeGRwzhc5hg9f4J9DCKCpSstDyFn2BFWAQY67xL3jxE=; b=AwLRLA1P
	+vh3TTkRCtlS4qGy048vFsEsT3dzRTyEfI3ArOIeKj2D88rbFsHsmnzLKQQLs8Fj
	xU7JMRAqQ6ZsMkCRcLM+c8liYd0A5t8liB3iJAIrbec+09D36d4z6fsS4n5XvmOX
	Z6KirYH902lb+Ah0CzdN3MS2korv0kAya7BsifqBAGR+GGhHew1PcwKNhK5bQTCe
	3Glr/ucJLVrDBmFIJUFw/4S2REdUHl98bTsHj3gr1QEIjwLZ6wh6IT0znRHjkM0f
	mKju/7fw4sPAGOyXYcmwovQ2lHxdeUbcWLGm0XDQd4bzKeq3w7kv6aOT2HsfUDZj
	HirGdeRqElEU3g==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c9n28-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 20:24:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ap+u+W8mqluCfHBmsRG3a9UBETZQYDgjkAKQjJT74aGNbAOA3G0X6Wg8WzpAYIV86T+AnbmR4F+CAcyrim1xqpLymZ3+lIgt6RfjCbl5SUNFunaSZnpDDnUU8KjxY01k9jIFRNEz12QfRNhWBiIMX+LNeMyc8et9xaw4NH7DQnonrdlx+9q8v1FoHR9NI5V6j0PHeD0Z3+dKAyGDBh1Wafh0p7Ddp/GxMH/iptALWpBua04O7fzMsWLlLq8Otg6GIQzBOsDnhH5K2ZcLDSdnD3zMJiRTGsDcfN8/2/QgAmdBQtcFk62ULcqleI6Hi2pKYkTxwPC1+BZKFOUFD3WalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeGRwzhc5hg9f4J9DCKCpSstDyFn2BFWAQY67xL3jxE=;
 b=T7KJBvXiQshA+uWtaEyV3Llg5D3hxPQmXOqmfTvWvC6VGNExjpmDkdlVY6eagsJ0BuYcVwNCKQusaNP/IsNT7jvQUR9pf4kJOeDF2t7UaZp43tgjwEZDezzNDExjjOvJMbSfZKWLtLqEEqhBWRbfl4xeVBmKxSnq2Th9cR5rks0okTS3V7UF8FsYIC73+iGYd0ij7or067qQ97VNcF8skUGaioBKzENvyzlTFH+hSjo9gEOlfR1Z3Xc3OVzXSZbINHNJKbhyIBFEt21XDIkw33ILPYy1oFBN1VkegeBIsZatKpvp/lU5aROv4og9OjYCBfaI5HDrNxxKHGHYCJpB3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CO1PR15MB4970.namprd15.prod.outlook.com (2603:10b6:303:e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Wed, 25 Feb
 2026 20:24:12 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:24:12 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "hristo@venev.name"
	<hristo@venev.name>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Alex Markuze
	<amarkuze@redhat.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] ceph: Do not skip the first folio of the next
 object in writeback
Thread-Index: AQHcpoAG9EyKRy9VAEuzsSv8Smhge7WT3GaA
Date: Wed, 25 Feb 2026 20:24:12 +0000
Message-ID: <50447e5d0d4e3bf993d05dc9da9dde1c20371378.camel@ibm.com>
References: <20260225170758.2014172-1-hristo@venev.name>
In-Reply-To: <20260225170758.2014172-1-hristo@venev.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CO1PR15MB4970:EE_
x-ms-office365-filtering-correlation-id: 06c9ec48-a217-4fd3-022d-08de74abd6a0
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 jFGgUUqKLIAZlx4GeMRs2Eq8tD5SjdSpmafAheoA/YT3xAmKoIFb7m8hjjT+7M8CwOXt1e+mcBhb91Xcu0hnMeN7E7bnVsERZZatvS954eHmqBZCDnKiUuSOFs0lGvt6PPN1MO6MnuxhnkZ9d7xlO/MlrUi7u/IXfA/VJ9lTl/+luKl9gQcqVcK5LV9vWoRva2DbYEKsdOcfhU6vC6kKoLv9Y3Z2nXLq1R6jQ6Kq1h1bajzPa90bUL+1jlRC/v3dMcn51ZAGT5NY9aAShp4bv934SQES/e7eg9HKSmxQnrOC6X/wdJ8xTsh8hpWBxd0cD8P7EzBMDjIbkHWUlnaW8bpCbF3XAXYYl8lniFcZfGMmh7YpeUCeWl4XcwMlp0mGkJKPHQ1OD5kIKVUB2LtX4dK5n3wU60xsn9s7twTx9kEa5lvt7FLU9H3IKFr+QIhuJGkEE1qOA5V/5QCvSG6TVdcHkXRaM628vdCgxqj/qHhROkEBbVEuFLO8ed3RlTpS5y68w+06blaA271eANco4Q655Gd59dQXmTXJ2Bdnflf6G+t600bf39KrWwo9udK9dGuu18yNY+j+2HshK34aogAywdaZ5uM8WU6++Qt7ZksHCYkhTBNL7hkFGmt0lMm3GfzF2/CXYvVCdzUoFgRsl9xOD4Ys8lDIz1e3rVmk62QPohVbI+CMSGxSLLOYIQKEtP9B8nFnku7hGhG1gu2o6hsIWiSvKcTI0h97Tk0+aqISzzBC1RIBZmZLGLssPoETqgoPNgvKV0MoVswaYxDRMHOYipFCJYlO3Zwe5rku4UQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?emQvc2E4NzJwcCt6eEVDY1hqa3FmeFliY2NUelVWYWFOdlF2MUtvdEdwK240?=
 =?utf-8?B?U3hXYllycnAwejhYdGFmb1ZzUXZxbHdublM4T25GbFo5UlJYeUkxRWxINmcz?=
 =?utf-8?B?amJGbytCbXFPZEpnem1OVDdlYWZxM3psQ2Rmb2EwTE14VXppYWlsNFIzamZW?=
 =?utf-8?B?ZU5RYyt6ZXFvQlNCekEzQUFWdGdGUkgyYUFjUHpqSlNWY1gvNy95cUNGY3R1?=
 =?utf-8?B?RmhDdFp2UkVDbEV0OThBVUtJeFVUYllhcHlSV0o4NjVYSU0xSUxIakVGQ1ov?=
 =?utf-8?B?R0RlNjhOa1lvWGprcGlsWjY2RnZieEk4QUdYMTFjOWhZaXM0TzRUVWpFUzND?=
 =?utf-8?B?bEJrZWwzRWJvUndBS3RqMGhZZ0gxYnBmWU1GaTFsK0h2dGw4QTUxdmtpdGZ0?=
 =?utf-8?B?ZnQ4T01TeGd6ZWVlMzdNc3FEdkJxQ3JWVHJqcVl4QTBGNDBPbWJKdVV3emRN?=
 =?utf-8?B?SmRDSThpenNoL0hSUEs4ZmJWMlUvZU83ZHhyc20wcmlYVjlHL3J6OFF6OGJT?=
 =?utf-8?B?UGJzc1k5T0VWeWFNWTc5ZmRVTUZjL3d6US96Z0FXQ0JWVlA1VjYxczhkSlJa?=
 =?utf-8?B?SWJFT0pJeGVnSVlPN1hHdHk2MGpvTm1TQ2IrRkcwVnFNWEtvanltVk5sZ0RT?=
 =?utf-8?B?TmtFQ1Q5SnB4dXlKSmNBb2QrdVY3c2RUNmZOWjlFSzdSRzBMZWZNNnhOS1FJ?=
 =?utf-8?B?ajVoQUI0OGs4ZWdrNmJZQkd5WUVpRVh2Y0orYXM3ZlJWNFVja0RoalZOMGxW?=
 =?utf-8?B?dVJjdFo2ZzZHbGUxNW4veHpHWE56TTBDTmY3VEZMZjFCVFZESWRlalVEa0R3?=
 =?utf-8?B?N2R1M1VpV2xMMDZaeXdFRWRSVEpEY1FjWWJnbVZFT1lvZVppTVordE9NQTFT?=
 =?utf-8?B?WW5Ld2Z6QW5qR3FKYUtialBnY2NQMm5rV0pmSHJFU2JIR2FBMTVnYXh1Q3Rl?=
 =?utf-8?B?aVJ4enpwMjJkMkxNOEdCdFM2N2hQWDFUNUF0S3pzSlNRUW80WEpzR21wV1pv?=
 =?utf-8?B?T3o3UkZQR0p5YzdQeE03TGFDZ2VsUjY4VFRYKzNYcElTajk4ZXdBbjVFc3pi?=
 =?utf-8?B?NTFqS3phbzc3SFZiakp5RWlHUGVWRTNyd0xUME16Qmw1RkR5dE5YSVhXNkJB?=
 =?utf-8?B?a1hGRE81ZENLVU5VUklIUlhvN3d3UjkxRnpqb2hTS3MrNHh2bjFDS1NpUzR2?=
 =?utf-8?B?VXpDVHBUbjYraDdET3B3SnJDMmFjclhPeUlNYnkyazNZQTNDdjA3Tk5Oc1ho?=
 =?utf-8?B?VlV3N2dGZjFHV1BoVVBnbGtRRUdoQUtLUDI0aGxCbzNFaHhnNnFvVERFZHJ6?=
 =?utf-8?B?M2J4MnRUR2oxUU14SElxOXcwU3FaMlluQWcxeTN5Q1VPb0Y1NjQ0S0Z6aC9k?=
 =?utf-8?B?OVZnN0YwTDlmTHk4aTlOejE5clJtRFNZbk41eURBNm5aU0tjUEVSMDFPa00w?=
 =?utf-8?B?dXZybm1tM0ZZbXBQOU5TTG5XcVBGNmljQUx2ajVWd3l6bGhVaExvYmVzSDVC?=
 =?utf-8?B?SnFPNnNuakdOclZtZVRpT1hDcDhNYW1qZEpVR2lxUmNGQjJvQ0o1NUViUWd1?=
 =?utf-8?B?YTJEYVp6QlhyWDhrbWhRcHplTENUYTIwcGM1cHdZQlFYSnB1ZHNUMVhUWjBY?=
 =?utf-8?B?cE80clFnVEwrblhWMEltcHNlTXRXaWhtdC9hUDdHc0llYThoRkNmK1phQWNq?=
 =?utf-8?B?RndCM2ltaXFZQVdIVUc5czNwbE85TTIzMWFmWnhLMVEzcjBKSFZwM21tTjNN?=
 =?utf-8?B?WEppbmtoZXRmMFFGdE5BdWtxUFdyZTE1ektSd2w5V0I0MU13UkVnaEdqZ3VD?=
 =?utf-8?B?b05oMEZFN2wvKy8wUzlaMmNSS2g3NTlVVDJ4WE4rUmtkWllJZjRIeG9BemtI?=
 =?utf-8?B?YWRtYkhpdWkrV1pTZDNRWXRTQm9rZmpoeVkwUGVCSUF2NE1aRDhsb0ozd1kw?=
 =?utf-8?B?K3owMENDQmxJeXd1djZoeGc1U2ZuK1pnOURPZ290RTcrUWc5R1FpZ0FmUzg3?=
 =?utf-8?B?b2JxR1c1RDZyVjduMnpwRi9UWEx3UkpibjFIM2VxQXAvZjFIbU9SYVdab2Jv?=
 =?utf-8?B?UWZsWXB0T0tlNHZMNytpZW52NjAwcGlTTkNOTk8yZTZ4QmQ1SHRWbmhJb29T?=
 =?utf-8?B?Z05TZis4RUNrMk8ybzVuUllFUTJQQUV2dUdOSDl2M3VZTE5TMWdJWnNuTXQ5?=
 =?utf-8?B?dDc4cFV5RThHLysrbVNWZDVNUGlka3k5V0ozOWI4ZVkyYXdDZTRVWjFNcDht?=
 =?utf-8?B?K1JXQWYxWTFuWU1sbXFwaTdoWFpvcWJYakd6eEg5elpSYkxTREhkMG1NdzZX?=
 =?utf-8?B?MDVWV1FIWnYrbzVFUTF5ZjA4djhvaUJCUHMzRmlvQ3JLRTBMdys1S3huNVU0?=
 =?utf-8?Q?aQlBs5ctQD65sFPmC3VUfFLeSuTqPc9fbaVlW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD8B1330C04CD048893C9DD7E90BAA0B@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c9ec48-a217-4fd3-022d-08de74abd6a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 20:24:12.2075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IEU405rH9ZVBPm6JTfVaeMZzR6e2jTuhrc14R03Bpy2x706Jo8oeyW+onl/oQK4+IfFvPDifNhzCceEIEPcyng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4970
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE5MyBTYWx0ZWRfX+ObRHPB72Xer
 mYrgsuOdka4qPijbjj5/m+edS8NaKvZuG3YlCM4sbNev06F2aTAftRQI5qJwelPzi1CY5x1YUxN
 s/S2o8CV/uYkNpIkJSOTDGw5Z7peLqlzhHQaf9mlsELeYX4iH2q8QlSdLbgJsW4B9g4w2Yg9ogC
 E/kSg/I/2iiGKWaFw9WGaNvYZqt/K+h07p5FQKKSTWva7DZjc2WDmiVfUaKCz6qByBCvKvQfRgE
 0eT1pHt+9ADeigiHuU7D9dZ+SSj2e58BugxeoAlpfg4Rart01A71WxgjRyxT4XO2XVApdD56W2X
 bysb7jaJmhJF1UGXD57CNz9Ta3Zc6CRYhTmHI1Wg3uE+NCFN/rZRrtkyVu/cRytzn7Dfparzvjc
 2gC5hrEai7pTq8T/BIYaiTXNyDnyXkW4nOC2D/SKKvmA/XRAabcdfSmW7Vbb80IDJFKIvJxomK9
 rHrT5Yh7sY/rGihNAhw==
X-Proofpoint-ORIG-GUID: g2EPd7vX9E2DFNIhbS6N6XNSeylAf1re
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699f5a70 cx=c_pps
 a=r8U4PY7g8F27BymEuqiK4A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=GVT9W4Wiak6UpZ1B:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=4u6H09k7AAAA:8
 a=VwQbUJbxAAAA:8 a=7QsCU1_fb8p0UtRoQjMA:9 a=QEXdDO2ut3YA:10
 a=5yerskEF2kbSkDMynNst:22
X-Proofpoint-GUID: 1OqPfe3YgIhy6s_5FGH9ycEsW4-VcPR8
Subject: Re:  [PATCH] ceph: Do not skip the first folio of the next object in
 writeback
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602250193
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219703-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,venev.name,dubeyko.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proofpoint.com:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 44B4A19D319
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAyLTI1IGF0IDE5OjA3ICswMjAwLCBIcmlzdG8gVmVuZXYgd3JvdGU6DQo+
IFdoZW4gYGNlcGhfcHJvY2Vzc19mb2xpb19iYXRjaGAgZW5jb3VudGVycyBhIGZvbGlvIHBhc3Qg
dGhlIGVuZCBvZiB0aGUNCj4gY3VycmVudCBvYmplY3QsIGl0IHNob3VsZCBsZWF2ZSBpdCBpbiB0
aGUgYmF0Y2ggc28gdGhhdCBpdCBpcyBwaWNrZWQgdXANCj4gaW4gdGhlIG5leHQgaXRlcmF0aW9u
Lg0KPiANCj4gUmVtb3ZpbmcgdGhlIGZvbGlvIGZyb20gdGhlIGJhdGNoIG1lYW5zIHRoYXQgaXQg
ZG9lcyBub3QgZ2V0IHdyaXR0ZW4NCj4gYmFjayBhbmQgcmVtYWlucyBkaXJ0eSBpbnN0ZWFkLiBU
aGlzIG1ha2VzIGBmc3luYygpYCBzaWxlbnRseSBza2lwIHNvbWUNCj4gb2YgdGhlIGRhdGEsIGRl
bGF5cyBjYXBhYmlsaXR5IHJlbGVhc2UsIGFuZCBicmVha3MgY29oZXJlbmNlIHdpdGgNCj4gYE9f
RElSRUNUYC4NCj4gDQo+IFRoZSBsaW5rIGJlbG93IGNvbnRhaW5zIGluc3RydWN0aW9ucyBmb3Ig
cmVwcm9kdWNpbmcgdGhlIGJ1Zy4NCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
IEZpeGVzOiBjZTgwYjc2ZGQzMjcgKCJjZXBoOiBpbnRyb2R1Y2UgY2VwaF9wcm9jZXNzX2ZvbGlv
X2JhdGNoKCkgbWV0aG9kIikNCj4gTGluazogaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQu
Y29tL3YyL3VybD91PWh0dHBzLTNBX190cmFja2VyLmNlcGguY29tX2lzc3Vlc183NTE1NiZkPUR3
SURBZyZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJbTRBWE16YzhOSnUxX1JHbW5RMmZN
V0txNFk0UkFrRWx2VWdTczAwJm09Wmg0b1d5MXZrazlra2NDR0kweGpHUUU3MUttN2lNRDRWbFhV
WHo5ZVl4VzZWMUpyVUI2V09TeU9zMkpSSHBKeiZzPWNPTzhXZHljdllENEF1MmFBSlJnX19fZ2JH
OWFxWW9CNWVFYmxBdldSRjQmZT0gDQoNCllvdSBtZW50aW9uZWQgaW4gdGhlIHRpY2tldCB0aGF0
IHlvdSBkaWQgc29tZSB0ZXN0aW5nLiBXaGljaCBwYXJ0aWN1bGFyIHRlc3RpbmcNCmhhcyBiZWVu
IGRvbmU/IEhhdmUgeW91IHJ1biB4ZnN0c2VzdHMvZnN0ZXN0cyBmb3IgdGhlIGZpeD8NCg0KPiBT
aWduZWQtb2ZmLWJ5OiBIcmlzdG8gVmVuZXYgPGhyaXN0b0B2ZW5ldi5uYW1lPg0KPiAtLS0NCj4g
IGZzL2NlcGgvYWRkci5jIHwgMSAtDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvYWRkci5jIGIvZnMvY2VwaC9hZGRyLmMNCj4gaW5k
ZXggZTg3YjNiYjk0ZWU4OS4uMjA5MGZjNzg1MjljYiAxMDA2NDQNCj4gLS0tIGEvZnMvY2VwaC9h
ZGRyLmMNCj4gKysrIGIvZnMvY2VwaC9hZGRyLmMNCj4gQEAgLTEzMjYsNyArMTMyNiw2IEBAIHZv
aWQgY2VwaF9wcm9jZXNzX2ZvbGlvX2JhdGNoKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5n
LA0KPiAgCQkJY29udGludWU7DQo+ICAJCX0gZWxzZSBpZiAocmMgPT0gLUUyQklHKSB7DQo+ICAJ
CQlmb2xpb191bmxvY2soZm9saW8pOw0KPiAtCQkJY2VwaF93YmMtPmZiYXRjaC5mb2xpb3NbaV0g
PSBOVUxMOw0KPiAgCQkJYnJlYWs7DQo+ICAJCX0NCj4gIA0KDQpUaGUgY2VwaF9jaGVja19wYWdl
X2JlZm9yZV93cml0ZSgpIGV4ZWN1dGVzIHRocmVlIGNoZWNrczoNCigxKSBJdCByZXR1cm5zIC1F
MkJJRyBpZiB3ZSBoYXZlIGVuZCBvZiBzdHJpcCB1bml0LiBTbywgeW91ciBmaXggc291bmRzIGxp
a2UNCnJlYWxseSBnb29kIGNhdGNoLg0KKDIpIEl0IHJldHVybnMgLUVOT0RBVEEgaWYgZm9saW8g
aXMgYmV5b25kIG9mIGVuZCBvZiBmaWxlLiBBbmQgd2UgY2xlYXINCmRpcnRpbmVzcyBvZiB0aGUg
Zm9saW8uIEZpbmFsbHksIHdlIGNhbiBleGNsdWRlIGl0IGZyb20gdGhlIGRpcnR5IGJhdGNoIGFu
ZA0KZm9yZ2V0IGFib3V0IHRoaXMgZm9saW8uDQooMykgSXQgcmV0dXJucyAtRU5PREFUQSBpZiBm
b2xpbyBkb2Vzbid0IGJlbG9uZyB0byBjdXJyZW50IHNuYXAgY29udGV4dC4gU28sIHdlDQprZWVw
IHRoZSBmb2xpbyBkaXJ0eSBhbmQgZXhjbHVkZSBpdCBmcm9tIHRoZSBiYXRjaC4gTWF5YmUsIGV2
ZXJ5dGhpbmcgaXMgY29ycmVjdA0KaGVyZS4gQnV0IEkgYW0gc2xpZ2h0bHkgd29ycmllZCBhYm91
dCB0aGlzIGNhc2UuDQoNClRoYW5rcywNClNsYXZhLiANCg==

