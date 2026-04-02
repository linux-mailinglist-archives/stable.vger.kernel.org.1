Return-Path: <stable+bounces-233092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDLiIMOyzmk5pgYAu9opvQ
	(envelope-from <stable+bounces-233092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 20:17:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E4938CFEB
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 20:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1BCA303740F
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44992372EF5;
	Thu,  2 Apr 2026 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eyaBSwXW"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A685C371CE1;
	Thu,  2 Apr 2026 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153507; cv=fail; b=aRdTn6VrjAPPmKYA9OGdjzYCSQtx9G+wnF0xOjLhKSUeT2Y+9sJ1EilfYSLPU0wFir1LYWcOsTMadPuJvoAhT6ExUj1wV7O+VGkMup1esGmJGuk6Ue9LeZbKwc87f+r1WtJm4J8lDe3ue8/b9BoKEsf7VA6aG5bhmhHxS1j5Ipo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153507; c=relaxed/simple;
	bh=paDsSvS6OyEAWQgzK6BuJbj59vqTh5a8HYU/UJMhdYU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=BSzShG442u3nBiOKFy9NHOGYITaKzM1c3CoOVww+A/4o7Xs8N4jQPk3blaREQvHCT+1KfWMeVX5re6kukp0EgNcV2Fk/MS5AXjX64tAIlXu2BiRzNi3nTpw0WA5TvGXmipvxrGgbHLuPQY+XOzkGsTwb9o8kjn38YFOqUJ0gbRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eyaBSwXW; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632BFde93644103;
	Thu, 2 Apr 2026 18:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=paDsSvS6OyEAWQgzK6BuJbj59vqTh5a8HYU/UJMhdYU=; b=eyaBSwXW
	tDWbshGExFs4KjPCbFIZl3Hz6jxMcE3l5ogrJbWlIXdxgAEBHapPuva7l4airyPq
	rkmH5xdu8TNvJvJlghP/9RhyYoQJqe6eRtG3PoiZyfPKqX3An0uC+gZNRJmy4aGh
	tkNhe0cBpij/EJHUP9GOtHOBQctq9URv5qGi6HPAxvgR+UgC4YxgOw10IIR+5rwG
	io6dTpn6qXFBHpdqPOsTa+A7hWN2QwsVb9oxYKjMDxLvOqcDdWCfpbxseefSzn5X
	Z+5Y3PL3N+f4iLJ54cOapFjffPnOfxeXyk6fZY2yEhPmNGSWYcSGYu5R08xaKCvh
	h8BMBOxH4ModWA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3dyjh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 18:11:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjsDV+TNFHBczWzJXrLEuiDKwZdAZbHNk/u/L3xDJHE2z6RQbWwY++XjRdSqSTfUDU9sIvaGWnCgIRHpeQsFbPKFt3CBnhnInfnKQxSNO7jDzpRnTglKUDIqVyzvgb7Y4fdv0YLtfyZV6j2A91ZM3IQ9WaVGxUDxfctgIVNtdBIPqm4bnamIGaJdV/wDwJ04gzzE4QW3Pc2t0dMvoQksoJlfO/5hDagwbh1DO7p16GRS570l4kFAujzeGw0t2UbJ8VkNdGw5vmebriflxV7pBJN1vpCgFb4/atX56rYnJ/l7jgAQZyhUd/Ei2rHl4wGi9RLo+H5ygQ3RQ5Jj6TEF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paDsSvS6OyEAWQgzK6BuJbj59vqTh5a8HYU/UJMhdYU=;
 b=vgTByzJTCBDMcPlOPnw2VMheW/B+0V9r9qAvqkAs6iETW2yYuKUKNd8PuiXk252K3mLVl3wK1ZzCy+htC/2R2/QTbibaHW0q2P0aYWqyAvkicfDPBHNT9UM3ltkXjDEnJWcsg3xg7gk2GlqCSO70iOrCo5IuVjyddCSIz+NgqXMYUnQYU9iqbA8BFFBhO6dRUjpXuWvFda1MOtPOdCC8IBSTWA+HZqGA82PpCpygJ8HQXplks2nE1jvMJSd6CqrGc4bVKyjgZvpgTVdubg0SisEbiaoFJbt815+3J5aK9Z60wu8MRs/CMvObjU50jAb5nexPJepRNvQm+mosKn30KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB7174.namprd15.prod.outlook.com (2603:10b6:510:3b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 2 Apr
 2026 18:11:33 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9769.015; Thu, 2 Apr 2026
 18:11:32 +0000
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
Thread-Topic: [EXTERNAL] RE:  [PATCH] ceph: only d_add() negative dentries
 when they are unhashed
Thread-Index: AQHcwGczdLET/MkZjkWLja1B6qa1JLXI31oAgAM4G4A=
Date: Thu, 2 Apr 2026 18:11:32 +0000
Message-ID: <cae25009b37ffd152af27c1c10f75d7258983aca.camel@ibm.com>
References: <20260327162308.1118621-1-max.kellermann@ionos.com>
			 <765945680a8b83b26148430752295deedea831e7.camel@ibm.com>
		 <f8c25bcd64be6fdaafd4e49507ea9e04110d56a5.camel@ibm.com>
	 <93e1f2a995ad4c8977e1519a542f9b7b58f47894.camel@ibm.com>
In-Reply-To: <93e1f2a995ad4c8977e1519a542f9b7b58f47894.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB7174:EE_
x-ms-office365-filtering-correlation-id: fc4c91e3-53b0-40b8-58d4-08de90e34561
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 Hda/DeLVu0AsddDkjDo/i9yqYUB1sPj1WX9lKjwCsBbadidMe9a5Ob+rosgSDjmYMgngtss7rlym4dtp358IrhF4bWwzv7xS2scHYZrgQUEHmPtjgwAWyK8cHKSBsymJbvCChLqQEUjtvVwyLsGkOOQMxhguGQFlhmArYk34egPIg7RbB94B+uvv+hAm9/vCwppd+TW7TffxlyTab6gPNw8QKT25iCohciB+1VLnYzPUkR1DtLgRYPrhAIGgKh+RSuL8oIw7M0ykf/QcqD/hj1qI+zJoM+zV4hjypFNosjnQVNpL59e2ulfNF/AxKKSXgJus8pq4YfLZS0COzfB1Qa8fOSjdnJBmyP4S0CqN/IhHJtGK2nsF1XFlPgPqClHgaIrB2dyTaMZF1s+lZJq7SQF/OHBD2H8swDzMIFVtx7YM06vehHiejHMzs0RmduBhOWlWjTdBeEC7oKQAtxvYQ+4Vv4U4n49Kobat+E/Wyk4QsXLx2qhjqf/UndnyEgpO4ZShIDaJzv6RFKIY9OnWPP5xbcEtCvV8QEP6JNaE9ERaQ0ZOaACwcZ5qDLeJKwxbZIFy1mxucwYqBfzdVthGPCbANcLTz8il194m7bGfPn3mCUDULbs9mVd37Zck8JeqPj7NjMqUds1NnEcGbLsKWJooc/y3Z8yDbyXfGQQGepPh73wq3jsYj1m0lTFvZPr73qzSpoN6BiJX/lDZWhMRv/qwHuy9VA79vynLREqW2604gS01jCplBb61kOD+PhdAufmeyigym7yMvVlYdLqVgGjWG3fykc4M+v6JVGfxr7M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDI2anJvT1pwemFNN2Z6Vm5nWmtRNmRVeGxQdmNNVjJIVm1nSXk1S0tOcGwy?=
 =?utf-8?B?cm1KSERFMTVtUGxhWTM0TUYwQ1c4bGJ6TUU0cjlJSXFXQ0NZWm1uZ211M0x3?=
 =?utf-8?B?ZG1pdTVOZXZqcDFnaXc2bmkxTkFnek5LRktVMmthLzREM3pnNGFQY3YvMXdB?=
 =?utf-8?B?cGJqR1k4SFVDRlliS3cxQ1JBMDBIcHBKOGdqWWIxNzdpVFVGSWcrYS83d3c5?=
 =?utf-8?B?azB6Y0dhZU9odktRTmF1cmtMY2pwbFFSUkR3bnlkUUxjSTVUeTJqWnVpS3hH?=
 =?utf-8?B?L2lZZUljb2VDZmdsbnB6NU9oM2oycENJQ2F1MTRkN0l6M2s4WXJlKzUzdFll?=
 =?utf-8?B?dmdGMXZrdXNDd1kyZGZQT3NjbkhpdldKd0dmWUkxQkZlbFp4c3FFVUpwQ2tH?=
 =?utf-8?B?TjJxb3I3bXZUakV0OHNPVzJIcXBiK3RRbDBzMVpvMHcxZVZleWQxS0d0VUxL?=
 =?utf-8?B?ajBhQ3h6ejJBNWJjVEFqTnh5ZE9zY1VMWmR2eUoxREE4ZGpDb1A2QTUvRlow?=
 =?utf-8?B?c2MzSFI5UDRVbktTekphMTArZ21HbG13TUJqOGJDVzRkd1F3V1dFRGNlTjZ2?=
 =?utf-8?B?ejBmM3hnM1UwZTJjdHNYSmplNm1xOEM0STZSODYva2xZNWFvendFWVZCc01n?=
 =?utf-8?B?QkpqNFd5Q293RzdUeEV1alJzQ2VaaC9jbERRZjlsK2RrTytlb3FjWWV5cG9P?=
 =?utf-8?B?bVhzQ3V2eWFTRCtTL3doVHNCRFR6dUk5NzhNMnNhcllXL1g3aGkyeGhWb203?=
 =?utf-8?B?Q09OZlBhVzFFckNHVHE3NElNSFc1a05hcUIweGdhczI2WWE1N0w0OUh5anpC?=
 =?utf-8?B?bzUrNUYrRXpKS1BLejUrTDBONE56eHdsTTh1dlpEMWQxekw2NG5ocWE1YS9x?=
 =?utf-8?B?TTFFcEhBUlR0MklVaUtPejBGZ25xNHh2aDR5MFZZbDVxZ29oa0dGMWZiSGY5?=
 =?utf-8?B?a0ZRVUdZQ0w5M0JFaitBVDFnNHRiYmFQb3gyTnh1TWdNVXF6OU82TzM0YTB3?=
 =?utf-8?B?bnA4bjVVcnI4ZUF0dTVxVTU0TE9HUkM0S2RlV1lmRnBHYWl1L2dNRk9oeWlL?=
 =?utf-8?B?cnNCYVdteHB6ZmlGQ3F6Z3V1bU03cWgwa2ptYnlKdkF1aEZ5WXdhL1F4ano3?=
 =?utf-8?B?M1pmNW1MOVR6VURLQ25KZUEwVVd0a0E0VVhkbi9xRTFFNk5lblhmRGdUOTNZ?=
 =?utf-8?B?K29RdFNCd3ZuVWd5WkwwMkVLeVlSMHlraGZUdmhyaE1ueXFoS0FIOGRWZTIx?=
 =?utf-8?B?MWxLdXJHL2UvRE1WM2NMODh6YXRXMkVDTm1mMWNiYTJNblI0c3pZWjljNGdY?=
 =?utf-8?B?QWhtMVd0UmZzQ0IxcUxYaUg5K3J1eUgvOWFibmtzUml0aWVPZ3ZTMXZVU3Bq?=
 =?utf-8?B?SHFzdGw4M3ZhUElWcEh2V2E0RHgxa25rTTIzZ1l3eWpBMzNJNWZxaTFRZGJj?=
 =?utf-8?B?MmlONEJCTmk2UEhlZVNPR3FzMDdkdUN3QlJQUGhNRmlianJ3WkZUL3hmSm1q?=
 =?utf-8?B?WjZOU1NNOWVlbytkMDZuUDJ0TmdodC85S1VIMVEzSG9RUWF1RkdPVjR5dFlQ?=
 =?utf-8?B?Z1MvTTQzeHJ5UkdJd3REb1poTXZTcXVTV0kvSzdzWGN6ckFmQ2FBMFFydktH?=
 =?utf-8?B?b2grTHBPRm83M2hrYmRUNE14V010SkZ0UURZall1OTFyNUJPaFUzUHcrVDNp?=
 =?utf-8?B?ejF0VCtHWEhPTkJ5a1Q2V1ErWFNLTC9oelVIK29sNFV5bFVKR0lyWDJsTzFE?=
 =?utf-8?B?eTh4THB4SHBnY0ZEem91eUlIMk1BU3RyVWNNODRyMEpmbUN5QmdZQjBmeHFu?=
 =?utf-8?B?dzBMdGIrODR1UGNnQndOUU1hbStnWWw0ZFhyOG9sRmgxc1o4ZUJZSEpXR3J1?=
 =?utf-8?B?M0pMRXR5QjhLRkRoVk5kNFArREFrWWFnU2ZFaXNCdDhoR0FoenlKemF0YmZm?=
 =?utf-8?B?QXRCb0x0R1pOMEcxSWVGSkFGa1dkZUpCa2FIZTd5ZkNGWG85RDFxQlZTbGxX?=
 =?utf-8?B?U09oV1JJUUhTUHVCZlJPeDNocXExOSt5b0g0am5OOWNVTkdmQzZUYy93eGkr?=
 =?utf-8?B?VGE0ZXczR3lmaXgwOTVDM29Eb1NCRDVvaG4zcnBjU3ZJZ2ZrZzBqcGkwVVE2?=
 =?utf-8?B?cTFFaDY3RWp5TWdLWEk5dEJETlFGSGd5b0gwUUhuWnVGUHZoWmdqZWd5ZDlJ?=
 =?utf-8?B?M1lOWkEzaUszeFNZRGZ6cm5nOVVvcGlxbE9sK0tzRytDUWV4a3VucHRjVFNa?=
 =?utf-8?B?bXpGb2owYm1qWkNUcnRQQ3hKTTJucXBuN3NSY1U3cWt3TDVseGFVQTZBYlpm?=
 =?utf-8?B?WjF0WFVUQ01IQ2xaWEFucmdheG55UlJ1bEw3czd6OWY5VkQ4SzhuaC9adjdi?=
 =?utf-8?Q?ltq+A2cgOtkkN+JRJkVbO1aKEVLw7qwd0DV0P?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FBC26BBC7613A4B94F37ED631BF7D15@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	FkGb+1feCYqZgW9quIVyMYhms3IWK70jHjTefefZcc/EVe8PeEITWars8EBO0RFE+kFNilveEaWkW1V8rWvth18Jm/iHo+uFWhnYI/jWfXeJWjcZOKDn7gBkVOV/iDBwctgYFRPr1sUm+IsdLoHb3nkSVi2LRAgcZSk5z1JWM1XaFy24m16F0QN9ER3CM73pzhJ5Hcci5hy97HhsD5LtvhI0Es45s/jEh3f1e/HTWu7wNhrrfENvSfwidoDMHulJ9DmV8TysEwFo7IbDsq/s8MPEItRPL9V4yuv4jcs+r2oMN32moq3kCpDsreTm0P4wD63CMNc9q86g6aTukBtXBg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4c91e3-53b0-40b8-58d4-08de90e34561
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 18:11:32.8439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HdnqDQr3r/8JCxfeksGYZOPHBQ/ZJ+LirBgl9Lky8MjAkO0ZtKxpAiJsAupc6W5g3SY5cFg85OrX+aZIKsFFLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB7174
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: e62m1h2Xe9CDgHnNQWZYMt-hllO2SORa
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69ceb157 cx=c_pps
 a=k7JwuLoshMfzPsPeu96bmQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=WVHjsFipXO6o1lmZKqsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ag31krMdQGRaq6mwmg7i10YjumostDph
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE1OSBTYWx0ZWRfX2zsuGytTiC4t
 nz3ydgJeIj5Yaf3hqBwhvMYqXLTAgOwe+X3rdB+iBWY40E8OT7pcG18Bu29qSLacYkk61WAJMpi
 gh/LCXuz9CTEoKgZNLGN8Tf8GJNmZ4GFiNAY3X5grF6Op6dLCDzK698CgvNEhg2S7ZRX3GcFGl3
 grIANRo4pNniQ9/6WyWJsuGyNT5ddAkPTvuRSLQuYE+Vn/UavH11d/L8lMYbIIliTKlDmZ8Ebks
 GdMK4ChRJi9UT6gJRug8FH1OKTDTI9ByHuunWWUrtnLYTQKU6HSB2L+mWJY9CCAwTa0j1KyEnZV
 /PtwmplHJO+xfGFNJTesATPAyerNK6VxstELElNcV6h468rgGr38ccebWjM9RzOBRIaUEnjncyB
 lZPd2NTJYNvH0IEOw27gu/1/EclbOLy40O++T6JtFAU3dd1lVwHNMUAkqa4Ho8Phq6PSSg/GpK+
 sp1dSIv3gKIOXpGDYgQ==
Subject: RE:  [PATCH] ceph: only d_add() negative dentries when they are
 unhashed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020159
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233092-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 26E4938CFEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDE3OjAxICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IE9uIE1vbiwgMjAyNi0wMy0zMCBhdCAxNzowNCArMDAwMCwgVmlhY2hlc2xhdiBEdWJl
eWtvIHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyNi0wMy0yNyBhdCAxODo0NCArMDAwMCwgVmlhY2hl
c2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+ID4gT24gRnJpLCAyMDI2LTAzLTI3IGF0IDE3OjIzICsw
MTAwLCBNYXggS2VsbGVybWFubiB3cm90ZToNCj4gPiA+ID4gDQo+IA0KPiA8c2tpcHBlZD4NCj4g
DQo+ID4gPiANCj4gPiA+IExldCBtZSBydW4geGZzdGVzdHMgZm9yIHRoZSBwYXRjaCB0byBkb3Vi
bGUgY2hlY2sgdGhhdCBldmVyeXRoaW5nIHdvcmtzIHdlbGwuDQo+ID4gPiANCj4gPiANCj4gPiBJ
IGhhZCBtdWx0aXBsZSB4ZnN0ZXN0cyBpc3N1ZXMgZHVyaW5nIGxhc3QgcnVuLiBNb3N0IHByb2Jh
Ymx5LCBpdCB3YXMgc29tZQ0KPiA+IGdsaXRjaCBvbiBteSBzaWRlIG9yIGluY29uc2lzdGVudCBi
dWlsZC4gSSBuZWVkIHRvIHJlcGVhdCB0aGUgeGZzdGVzdHMgcnVuIHdpdGgNCj4gPiB0aGUgcGF0
Y2guDQo+ID4gDQo+IA0KPiBTb3JyeSwgaXQgbG9va3MgbGlrZSA3LjAtcmM1IGhhcyBzb21lIGlu
Y29uc2lzdGVudCBzdGF0ZS4gTGV0IG1lIHN3aXRjaCBvbiA3LjAtDQo+IHJjMSBiZWNhdXNlIEkg
d2FzIGFibGUgdG8gcnVuIHhmc3Rlc3RzIHN1Y2Nlc3NmdWxseSBiZWZvcmUgb24gNy4wLXJjMS4N
Cj4gDQo+IA0KDQpGaW5hbGx5LCBJIG5lZWRlZCB0byBkZXBsb3kgZnJlc2ggQ2VwaCBjbHVzdGVy
IGFuZCBJIHJhbiB0aGUgeGZzdGVzdHMgd2l0aA0KYXBwbGllZCBwYXRjaCBmb3IgNy4wLXJjNiB2
ZXJzaW9uLiBJIGRvbid0IHNlZSBhbnkgbmV3IGlzc3VlcyByZWxhdGVkIHRvIHRoZQ0KcGF0Y2gu
DQoNClRlc3RlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5jb20+
DQoNClRoYW5rcywNClNsYXZhLg0K

