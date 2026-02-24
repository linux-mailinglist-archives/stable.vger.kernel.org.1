Return-Path: <stable+bounces-217942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJcsFuUAnmkfTAQAu9opvQ
	(envelope-from <stable+bounces-217942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 20:49:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B7D18C35C
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 20:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7937E303DD26
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 19:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672D232B99C;
	Tue, 24 Feb 2026 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C4kUYoLD"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E626B756;
	Tue, 24 Feb 2026 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771962591; cv=fail; b=XRGjv6LGUoyxZ4pEL4d6hawqBo3EyheQQyQAaDGIfVRBFJ6cHCtyvgqDL6oeqfsKc2C501OnmusuPtV+AhCyWkg5OXZ19rKDq326pNJVlH2t9b1RIN/5KbCvnEy+8EsiwNdW6ECSNaotvRwqBYDjWqQ9lkzdiJKQmj+K5yvS104=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771962591; c=relaxed/simple;
	bh=aL3OUqDlgckRMDdXIezvy1qP2BvKLZ6NrT7XykxGR4k=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ZjA1Z4mAn2i1u7+vptxlCdqCKl/0e/ntvgqvN9GS0qE3X6S3fIFxcrgNZ9Y63mXWHfhC38gsS5PP4FAp/vuZWfkZRHj7qBvJ0A/0FEWKt3uYyv8NZIiODaZWBvMLQ3o1ZEu1REPnfTrlCXztopQu9BdYDtPXREZkj1rkzcKOhkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C4kUYoLD; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O856cm2632518;
	Tue, 24 Feb 2026 19:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=aL3OUqDlgckRMDdXIezvy1qP2BvKLZ6NrT7XykxGR4k=; b=C4kUYoLD
	PiBtay9IA4of9GpgNYmsGzTzDJXYJGTHjFS6VB1Jdv6fffr9JTemMS3dsVVcTiSQ
	qldO+7OEUqVvU6Mzii+6hE8MO+CsR5HrGhRMQlviU6UhC+4u/IH+0SqeXfxGAQA8
	DTCxMx1dD8v/lPJ6MX7qt+YbxijETjg+cyU2JsIAZ3E/W632g64y4lVFrVRiNEyx
	Ij583V8Oj7TvVrORSlswo0Lvt8QbUJcgx9yt5rD/UTAaqjrUTHDZd3b3+3krkOKd
	foSEFRtr8lBp2UNcXpa2peWkTlAN386Chm0B+LiiHcOO2fBqGdzlQR/sTnqMPKxf
	cqFvmEtVWAXBIg==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4brvnfq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 19:49:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUk2QthXVb+s0nXYUc0eXQrFYWt1VSs7Sv3NVOTSvJ5KPhZEETGy/t+aEcz7Fn6FwpX4H9w6HvmPP62dIMX0X27M3BjktmwPcTSQRdvY6F/vg8oobjf0QvkecA5PlT41vmPBDFBdAwGp6GO7YE7z54jyN9HX4ZamfzB1WjBnD51YQUDtcsdVbYvs0QbQLf6SoPYpLrXKk+mEnunIfvE6nOOzy3anilavRrVH2x2NKb4x6RqD/V9N+kTDk6blQ0+uEsVS5KBoJlBbF5hd68ZpjyDzaKSGaTMM+2rKfTB6h+x8XkU7aLidM5R6TWy9DTC93w62myOPym7lvRV5vUNmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aL3OUqDlgckRMDdXIezvy1qP2BvKLZ6NrT7XykxGR4k=;
 b=mcmV+xK6VRNbAZZH0Mqcs0gJN+HvP17rHZGQpx8eP+8e9+Ssssoj7+p0QnrGKT7guDGz25kttrSRTtWtLl51ksICNHw1GqaTYhJDCoy3qaM1ihis0wn6dSPlej1p6I4Wggz4LI0xsDGOKOr5gcjeKIqT+RQvzZ+MJqqXOszrbCUCu/+uh4hS8F3N4hNO/jmaXSTUbk18DlTc5za3YtyanNFzlsiNutmYfCaIvtIKYv8IzJRsC/QfamQ0RQlCmErhZti4FlJjtnoxc2oSPBa9+1A9JNt5qvtKg7IiERroXt97GZ4/4P+zEEj72Z1wVHBPzwKYloH3uWDG7KjQlQOtAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB5053.namprd15.prod.outlook.com (2603:10b6:510:a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 19:49:33 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 19:49:33 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "max.kellermann@ionos.com" <max.kellermann@ionos.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] fs/ceph/mds_client: fix memory leaks in
 ceph_mdsc_build_path()
Thread-Index: AQHcpZI/TLIcALGmLEO9AefrDgARkLWSQj8A
Date: Tue, 24 Feb 2026 19:49:33 +0000
Message-ID: <23e9c06c6ac742cfc5bfd1886c5858d8b3013102.camel@ibm.com>
References: <20260224132657.3055222-1-max.kellermann@ionos.com>
In-Reply-To: <20260224132657.3055222-1-max.kellermann@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB5053:EE_
x-ms-office365-filtering-correlation-id: 08ec4d24-baff-4d05-9e96-08de73ddd545
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QzhzWk41SXhvZVozL29wWUIvRjN0aVZmSHVKOUtwZit2NlJrYmhELzAzNDIy?=
 =?utf-8?B?cGx6U2UxNk16dWE3b0hlTXN5WXUwOXFCT29pTld4cmpZZFBoRi84MUo1dE5r?=
 =?utf-8?B?VDBBNGJ6VW9sejFWVjl4dmJQdHkxZG43dW1BQzdMZ1YvSXJSRXBqUkkxRk96?=
 =?utf-8?B?QzB2MUp5cnJtVTdjSlU3aTBCVUI5UmpUcW1XL2h5eForVVlxUUxYQi80cVBp?=
 =?utf-8?B?c1Bla3BadVVuSDZkcjlEcXBCSXRvSTNYdjZ3Nm9JdzJHZ3VxbFN1RDFDUzdN?=
 =?utf-8?B?WENPVzU0UTk4ZzMyZGtVeWpxTUowY0JrOEljdGNBQk5EeUpjQUNCUUNZZStp?=
 =?utf-8?B?WWVFVWRqKzRhamNKQW9YVE93MFlpUlNGRjdNcEp0TGZpaGlhYkh3SE8wTGZN?=
 =?utf-8?B?RDlSQ0dBVFhGblA0UzlpR2V5WGZici9ra01obGNudDZXUmE4ZDhzaURhREln?=
 =?utf-8?B?RTMzakNDQUl6NnZUUkRGc05Cc3lnbE9WbnFQSTlObGFpOC90SFdCa2Q5N29r?=
 =?utf-8?B?alVndHlaVFcwdnI0dm1VcEtvaVFYTmdkN0NFa3VhLzJhb3EwVWhmVEg2bDd6?=
 =?utf-8?B?QTlzalYvL2tsTmpDeE5zOEJ3UW5PeGJrSisyanZ0UDJhbU10OVRTeXV5Y0cy?=
 =?utf-8?B?cUlCQjhDNnJxdHRFRnBCbUIvQ0hPM2RueHFmYkppRjh3MUxsYUFVd1dEK1pQ?=
 =?utf-8?B?SEVFblBxYUIrcGRNakVPMHRNYmF6dTU0ZFhjaDJxY2RtcUNuZldhdERQZXIz?=
 =?utf-8?B?R0JRSHNUNHQxUU5YQ3pXY1R3b0lxMXZraEdxZ1FoSFI4YTcrWGhDVTlUclN4?=
 =?utf-8?B?Nlo2TE04UnA2anlxSFNrQnQwUXJqa0w1RFFrM3FzYzFqaVlYaEtWSFc3Q3Vt?=
 =?utf-8?B?cVY1RU0wa0xQMHZTZHJ6c1hhN3Vaak1VV1RnMWU1UmwxYnM4KzJTODBUa1dy?=
 =?utf-8?B?WEY2RmJXR3VwaWxTWnJxTEw2SUIrU1BHd2hDYnJ5OUxnRDhGd0ZvRjJ5NlZT?=
 =?utf-8?B?enZMUTlHVHlvZHhScDJ2M0hBMWZmS1U0b0JIY0U4MzZrbmhqR1N4dEM3N01z?=
 =?utf-8?B?NjNOdjRyaHVyWFRXQXoyekJRQk80ckkyRExraHVTbWF6OFQzenV4ZVFEY3hG?=
 =?utf-8?B?Y1ZPMlN5cSt3cTFidGFXL3BXVEZUWWpLaHhOemJNY3NjNENrK1pFZitXMjdM?=
 =?utf-8?B?b29hKzVDZUNYTGc2NXRCM0ZHMFluNnZveGRHU21IV0VGMkluZjB4aXI1Tng3?=
 =?utf-8?B?OGFYZ0FLYUdhQmt4N0tDdWZWUDBuNy9ZZm95dmRCN2RrU0ZOV2lCMFJwYXBP?=
 =?utf-8?B?Z0VhVGJ1OXoxTmRucEU4T2QveHZGTlpzeFk2eTNrZHlVSEtveGxuSUNZMHQr?=
 =?utf-8?B?TytGeGE1cytGdmNibWdzMUVmTWdJQUtac3ZIeUM3NUFGdTRxTzB3L1ZDNDFx?=
 =?utf-8?B?Z1NFWXI3SFZlenZNOWRiV0MydVdmNllQYlEzUVlpdTd0WkhmQThkT3BPckdv?=
 =?utf-8?B?bUpRYmRNTUZ3TjlRMWVVUEdCNFp3NXdMOVp4cnNhVm44Sk4xYWV6ZExNcnNj?=
 =?utf-8?B?eGthUW5ud283bW83S2IyWFphQVBRY09NRmQwNXVJdUtEL1JxNEdibjgzSkpW?=
 =?utf-8?B?U3dyRjB1YjBGbmN3YVNmbWt1UHpybThvc2JxRmFNWjUrdFkrRGJhWWdzTEpr?=
 =?utf-8?B?ejBHaWE0V1E2YzE5SVNRak1HQzJtU1RIK2VtU1JQWVJpMDFNSnN6aFRnN0Yz?=
 =?utf-8?B?VUFDYVdsRDBQd3lRTEJ2N0h3TERhRXJOT0Yyck9EcEtQWGZSclcybkw2djBq?=
 =?utf-8?B?c0xmWWZHNHhWVUZTMlgxdjJ2Q21ITEhJaFFlWS9iVjBQTFlOUHEyeUFxSXY4?=
 =?utf-8?B?YmNHK2NsWnBmeU1IRUlUS2twMGxrVHR6Y1BrOXh5UDJQR0QveDVtNnRkRnFt?=
 =?utf-8?B?SHlsYVprUVhGZWFTMW4yZmgvSjE4RWNPUWdnb2pva1pHVkFCMmZJREFHQXZ2?=
 =?utf-8?B?Y3dQZVhUZU9Ua05tcklYVHNzN2cvVmZDNk9zb2FHbWlyYkVBajhTUlE4TUFp?=
 =?utf-8?B?YnFHem5xTnFNb1ZHVWdyZ0NCM3hveWtpY0VpckxGVWx0M3F4ODZUcG5BRGFt?=
 =?utf-8?B?bXhPNDRzTUZTMjRrZmRBZk9zd3pBdE5uVUhIcFIzNWV1Z1BtcGN3UjlTN0RD?=
 =?utf-8?Q?G2iYL9rMWtKrK9rcH4PbzIc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2tsNUYyWUhmWDVpRFE0WktaZUxqbE80dFZ0Z2Zya3UrVUlnVzhkbjhkM3hP?=
 =?utf-8?B?OXRlUjYyWnlFWmdFSWhSSzJiamdxd21OQmNtSFQrL2VBeVlpd2FTbE9qSHox?=
 =?utf-8?B?UjJkVkp6bFo3L0NyY0Fpd05CRWF6a0lwYjNxNjJ1czhCYUZqeHl0aGFIK0Y3?=
 =?utf-8?B?bmJIbVZIem9oMVhQcjVrZkJLVmVJSENDME1RTjBBTUgxb3Q0WXhzSG5FemlO?=
 =?utf-8?B?dmNJOVcwc2NHSnpIYldQeHpwTWtTcTE5aHhaN0pzcXZscnVwOTd0MnJXeFJJ?=
 =?utf-8?B?ZTFtOHNrTk1YbkhtOWpWZXBJMGRVK3BLM3RlMitiU2xmUzhocnRINTh1UWM3?=
 =?utf-8?B?Q3VJVUZyS0Z2eVphUllHWlhZbHA4ZFR6UWhObFljWHAyY1NrVFV6YjZDZVFp?=
 =?utf-8?B?bkVsYmlwMmNsWWJvNHRRMHRIbXh5bExNL0gyUllDdnYwbGdkWnp1eHlwZnhs?=
 =?utf-8?B?TkVyekp3K2MzWHBleWNuNXllMGlqUk9lcGJPNUJ3T2RxSThmTmErYUJicktx?=
 =?utf-8?B?dlV3SlB2MEtXb0h4QVJMZFlhNGxQb3F3eGRmcFB0bEx4T2d5cll3YUthbzVT?=
 =?utf-8?B?MGtWK05CcHEvRURlZTRCdGo2K2ZLMnQxR1ZHeERYM1NZb29aM1lhL0xTZjhp?=
 =?utf-8?B?d3pnOVdtRmtFWk4vMkhyYnl3TitzM3B2NzBkQ29iOHNMaVo1Nmgyc3E2dXhs?=
 =?utf-8?B?UUxOTXd4ZGtiWnZPT1JweXNRYmJheFJncXo4WVBxbldLSzF2dlF4bW80OG15?=
 =?utf-8?B?RjFLZnJOeTVhWnVRaXZ1cnZodysxMWVzUko2MnFnaVNkZFozUkpIWXdNWXBy?=
 =?utf-8?B?LzdGMWxyUlQ5UVAwQ25Kb05lcTRsNFFHdktMbFhMbW9FVVB3T0tRQXc1aXdF?=
 =?utf-8?B?QzlhdUt1a3cyQlFrVDc1UUNTSUZvUFYyZG16bmxKUXlOM3Nnc0l2WGhaYWpD?=
 =?utf-8?B?Uy9kYXY2SGdEV3Q4YXI3RHBQeE9FdUpkZUZBMU1GR2JwdzAxZ2FqQTdpMlcz?=
 =?utf-8?B?RW0vQ2oxOUhMeWpuM2JGeVdXL1pJL3h0SytSL2NySU1vUWhRVnp4RXRrVE5X?=
 =?utf-8?B?UTRsd01uaThSMHF3c1VDekY3cWJiZXN0OGxFUytvZzYrbDA2V2FkZU4yc3FQ?=
 =?utf-8?B?bi9EKzdBMjdKcUphWCtxb0FRbEM3eTJUS00rdnZNWnRVZnlpZDNoNjN0Nk92?=
 =?utf-8?B?YlEyaXZKN1hSNDJZMU5Kc2V6NWpnSzNxNWluN2hPYUlSWVBiNjlpQ3VvTE8x?=
 =?utf-8?B?cUI0VElOczQzMkVBVGRvSlVnYUJta1pIYTAvS2ZOVTNZNG1uM2M2SkJmRmt5?=
 =?utf-8?B?SFkwbWMzUnJSbjZ4a2dQRk92anJTb1UxZnNlN2svcFZaY1dwalhTMXRrZjZE?=
 =?utf-8?B?TXBrbGVuWEI4KzQ5UlluYlZ4SWFZZ2F6dFZBTFlDTnN1akRlTFc1NVlZa3Bz?=
 =?utf-8?B?VGtuWk5sZTJRb1pZN2RVQS8zSEdwVzZlS1pzaW5hczFLRURJMTVnZklIMHJk?=
 =?utf-8?B?dVhzSVU2NVVtVjl3NGJRamlYWTRFd05EZ3BWS1N4ZENGNFVUNytmRllFRWNk?=
 =?utf-8?B?Skp0cDFKWW1YNEdGTXQ0bVZKQ3FsZ1RMRHI2anFYNGNzSnpxS1VCNW9IK1Yr?=
 =?utf-8?B?aUF2eDlNL0V3ZDhJdnJkcTJDakFjRDdlLy85TDd1TVpGMEZ3UVZoRm56UUN5?=
 =?utf-8?B?ZGtSS3YvTHA4Z2V2NTFnQUNqQVJjdzZTbzB3d2FQelcrNm9RTTlFN2NQZkM0?=
 =?utf-8?B?Unh4OUxVR3BxK3poMjhVM1h6Z2E4UmJnbmVtNGVjQ3dwRTZ5UWc5T0RFSVEx?=
 =?utf-8?B?QURDUVowd1Fobk1Xc3ZHNWpPV0ZMRDJ6cHBnY08wNkNSRXlYb0dCcysxZEM3?=
 =?utf-8?B?ZUNUbUNidzlKMEQ4VXJ3NHNQRTRPZ1dHbkVaSW11VGhhSDQ5R3U4WlZwMllQ?=
 =?utf-8?B?THBrMVhzaTdDNnlMK0ViZW4zM3hwcUk4V09NSUR6SjVXUkk4UFR6bWJJMzFh?=
 =?utf-8?B?RXFYMmFlanA3bFlndHdMTStiK2pPQ2RIVGlObE9HVHJUSEZaT0hlbmxocUl4?=
 =?utf-8?B?UnU3QjUrQlRFVW5jdXgybEQ0a2dXWmQvM2I2N0huTnVVc05TQ1lrUHVDZFpx?=
 =?utf-8?B?V2lGNHVhTHlqazdFYVZYaUFVc1VvcE4zRFlDZWFSM3B6ZEx2Y2d5T256Mk9T?=
 =?utf-8?B?cFprMFkyUHhsSlhDTy9VWW9kNmQ1QUlVdjF3cEE3a1kvVlp5QXE4NVFMTk9a?=
 =?utf-8?B?cEdEdGtoUDhwWXRjakxNeW5aM2xsTzR4K3RJY1BxanI0NmVXZWhLVjY3eDhH?=
 =?utf-8?B?Y25TKzBhN2dNUkpkeGxmQjNxQ0Y2ZWJsY1MzdHRMRWdXUjA1bW1kcDloTFR3?=
 =?utf-8?Q?sxO7B9H1CbfRRkhJOckzdeH/4WPavnOQm8h88?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA286B0795D5564384502A831E11D14C@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ec4d24-baff-4d05-9e96-08de73ddd545
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 19:49:33.5678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbh5msTPRwu71V8KCa6Gca+IP5qSLrOHyzgMguQdLGfSBtojL9NSe0Q0vmRH6xMy02Odg6KrpvMB/YnIjZWRrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5053
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 43Wc_dwJOE0TxjWRGQD3wlVp2lM8F1Xb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE2OSBTYWx0ZWRfX0nRWLxrGMPmJ
 JZy2w+kv36roMOSOZ0rDbh7eTxHZTxG7tu1+qmHtXEeiKDtgQMfhSWBRV8jrdPazDGFYgs3BHvA
 i/kAiGOeYvYcSb0tIcHE0B6Sr57NvWS5S7utzrQSQUDf1uyGA0eyEIMWHahkOhPKKsAyw+wIg6u
 Ww/Gcriy3dgxIQnNsAUtssR8PAiUUwvbc3eTnA7n3tajc+Xw7/Yt+FdwkDvF1wJGxDeYPGv6lh2
 Abi3vhAPOqngRAb5aHskf/hPaamnTnU35PLEkXYfTCfbyfKl3LD1jjqh7Pflfvx/rhs24Lcf0/X
 +TqNBN4V5tjlju6D3cPIUKva4HRr+PsmSJOuxLIxtzR9zcnbOhd//QWLYkRnlsIwSk1fuAwFA4w
 AF2yRwQNHf4htW/BSTYLwJyt1c1pOOX1w0Vo87jtDw9GW5t0g/1AJBPpesQLxfKaK8W2ZoyoWR/
 p6uQqDLewiY+FLqvo6Q==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=699e00d0 cx=c_pps
 a=n/3lZCR83+ZXmFnVV+4wNg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=UgJECxHJAAAA:8 a=VnNF1IyMAAAA:8
 a=bOCbCvTosqCKGcoeamAA:9 a=QEXdDO2ut3YA:10 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-GUID: qaH6Lqik6dyQ8O1oOT2tFjWmFke5qXGL
Subject: Re:  [PATCH] fs/ceph/mds_client: fix memory leaks in
 ceph_mdsc_build_path()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602240169
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217942-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ionos.com,gmail.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B1B7D18C35C
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTI0IGF0IDE0OjI2ICswMTAwLCBNYXggS2VsbGVybWFubiB3cm90ZToN
Cj4gQWRkIF9fcHV0bmFtZSgpIGNhbGxzIHRvIGVycm9yIGNvZGUgcGF0aHMgdGhhdCBkaWQgbm90
IGZyZWUgdGhlICJwYXRoIg0KPiBwb2ludGVyIG9idGFpbmVkIGJ5IF9fZ2V0bmFtZSgpLiAgSWYg
b3duZXJzaGlwIG9mIHRoaXMgcG9pbnRlciBpcyBub3QNCj4gcGFzc2VkIHRvIHRoZSBjYWxsZXIg
dmlhIHBhdGhfaW5mby5wYXRoLCB0aGUgZnVuY3Rpb24gbXVzdCBmcmVlIGl0DQo+IGJlZm9yZSBy
ZXR1cm5pbmcuDQo+IA0KPiBGaXhlczogM2ZkOTQ1YTc5ZTE0ICgiY2VwaDogZW5jb2RlIGVuY3J5
cHRlZCBuYW1lIGluIGNlcGhfbWRzY19idWlsZF9wYXRoIGFuZCBkZW50cnkgcmVsZWFzZSIpDQo+
IEZpeGVzOiA1NTBmN2NhOThlZTAgKCJjZXBoOiBnaXZlIHVwIG9uIHBhdGhzIGxvbmdlciB0aGFu
IFBBVEhfTUFYIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1i
eTogTWF4IEtlbGxlcm1hbm4gPG1heC5rZWxsZXJtYW5uQGlvbm9zLmNvbT4NCj4gLS0tDQo+ICBm
cy9jZXBoL21kc19jbGllbnQuYyB8IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9tZHNfY2xpZW50LmMgYi9mcy9jZXBo
L21kc19jbGllbnQuYw0KPiBpbmRleCAyM2I2ZDAwNjQzYzkuLmIxNzQ2MjczZjE4NiAxMDA2NDQN
Cj4gLS0tIGEvZnMvY2VwaC9tZHNfY2xpZW50LmMNCj4gKysrIGIvZnMvY2VwaC9tZHNfY2xpZW50
LmMNCj4gQEAgLTI3NjgsNiArMjc2OCw3IEBAIGNoYXIgKmNlcGhfbWRzY19idWlsZF9wYXRoKHN0
cnVjdCBjZXBoX21kc19jbGllbnQgKm1kc2MsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCj4gIAkJ
CWlmIChyZXQgPCAwKSB7DQo+ICAJCQkJZHB1dChwYXJlbnQpOw0KPiAgCQkJCWRwdXQoY3VyKTsN
Cj4gKwkJCQlfX3B1dG5hbWUocGF0aCk7DQo+ICAJCQkJcmV0dXJuIEVSUl9QVFIocmV0KTsNCj4g
IAkJCX0NCj4gIA0KPiBAQCAtMjc3Nyw2ICsyNzc4LDcgQEAgY2hhciAqY2VwaF9tZHNjX2J1aWxk
X3BhdGgoc3RydWN0IGNlcGhfbWRzX2NsaWVudCAqbWRzYywgc3RydWN0IGRlbnRyeSAqZGVudHJ5
LA0KPiAgCQkJCWlmIChsZW4gPCAwKSB7DQo+ICAJCQkJCWRwdXQocGFyZW50KTsNCj4gIAkJCQkJ
ZHB1dChjdXIpOw0KPiArCQkJCQlfX3B1dG5hbWUocGF0aCk7DQo+ICAJCQkJCXJldHVybiBFUlJf
UFRSKGxlbik7DQo+ICAJCQkJfQ0KPiAgCQkJfQ0KPiBAQCAtMjgxMyw2ICsyODE1LDcgQEAgY2hh
ciAqY2VwaF9tZHNjX2J1aWxkX3BhdGgoc3RydWN0IGNlcGhfbWRzX2NsaWVudCAqbWRzYywgc3Ry
dWN0IGRlbnRyeSAqZGVudHJ5LA0KPiAgCQkgKiBjYW5ub3QgZXZlciBzdWNjZWVkLiAgQ3JlYXRp
bmcgcGF0aHMgdGhhdCBsb25nIGlzDQo+ICAJCSAqIHBvc3NpYmxlIHdpdGggQ2VwaCwgYnV0IExp
bnV4IGNhbm5vdCB1c2UgdGhlbS4NCj4gIAkJICovDQo+ICsJCV9fcHV0bmFtZShwYXRoKTsNCj4g
IAkJcmV0dXJuIEVSUl9QVFIoLUVOQU1FVE9PTE9ORyk7DQo+ICAJfQ0KDQpNYWtlcyBzZW5zZS4g
SSB0aGluayBpdCBjb3VsZCBsb29rIGJldHRlciB0byBoYXZlIG9uZSBwbGFjZSBvZiBwcm9jZXNz
aW5nIGVycm9yDQpjYXNlIGFuZCBjYWxsaW5nIF9fcHV0bmFtZSgpOg0KDQpjaGFyICpjZXBoX21k
c2NfYnVpbGRfcGF0aChzdHJ1Y3QgY2VwaF9tZHNfY2xpZW50ICptZHNjLCBzdHJ1Y3QgZGVudHJ5
ICpkZW50cnksDQoJCQkgICBzdHJ1Y3QgY2VwaF9wYXRoX2luZm8gKnBhdGhfaW5mbywgaW50IGZv
cl93aXJlKQ0Kew0KICAgIDxtYWluIGV4ZWN1dGlvbiBmbG93Pg0KDQogICAgcmV0dXJuIHBhdGgg
KyBwb3M7DQoNCmZhaWxfYnVpbGRfcGF0aDoNCiAgICBfX3B1dG5hbWUocGF0aCk7DQogICAgcmV0
dXJuIEVSUl9QVFIoPGVycm9yIGNvZGU+KTsNCn0NCg0KUmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYg
RHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KDQpUaGFua3MsDQpTbGF2YS4NCg0K

