Return-Path: <stable+bounces-241758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EAJI4oA8WnubgEAu9opvQ
	(envelope-from <stable+bounces-241758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:46:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFAA48AD02
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9F9830438DE
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA7547AF61;
	Tue, 28 Apr 2026 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jQN3ZfmW"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E0F47CC69;
	Tue, 28 Apr 2026 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777401990; cv=fail; b=h7nJE7dyTGwx19xfW81fggNiMAL1Faxv8CsxNRYpbKZjvN2quPl5wHc3AoUhRW44A/NwFWH4uft3sZrpkIC+9F5n/L3iCjkK3iDYC9dkXxWxetidRsoMJVl7tVapHp/bNL5wXbjG6FDo/onxajPomTOUWMDAUD5AZO7UB1T45Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777401990; c=relaxed/simple;
	bh=hSpcUobVHCMJIxaMjLpz+Dy42f53pq2SsvV1oOeWi9s=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=aSvjZv+5DnaTtbI9Ws9yl/87OhRn6uuoZYAxdv2bDxUal84n79DXMNcmIpUdGOENA+IIqyLj7T7eo499e2OIDmyiCFMdvpGhqI8bwttNZGsae076Ddhlf4LQacEx1Qh3mNmCOlRTa/5Mh07vxAAro1Ap9I0Ygee44F80ddKuaFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jQN3ZfmW; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SHqk3I2999657;
	Tue, 28 Apr 2026 18:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=hSpcUobVHCMJIxaMjLpz+Dy42f53pq2SsvV1oOeWi9s=; b=jQN3ZfmW
	Gg2xGiBaUaB98WorAYtoA9uLLwtVRpXvqG4IGvuWl1cll68BsLjeCJonpCqEOtWm
	Na+H8aBXMpA01CyUSVh76iGewCk36Lz7sB42IErDBimrP2NyBT+2ln8iDrhKU+yN
	dAXzfaOkVdmaInc95/N6SSENWAgYAjsv4lXulWuhqFfn0DlASjr93EaA6u0keW/V
	9s4QkN6R7NTNuNkRoUGVw6MtXFBJJQ9iKEePI+XXjS1Hb+AjKi/LqDD6WlWAxADw
	n2sSbIHgSrg0rK0oJ8gIdZO0VI1Vc2KHGF9IMFN/STJf2U2EzEMV6GZTiIKdgMrJ
	6ljRI45AmGCChw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013019.outbound.protection.outlook.com [40.93.201.19])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb5753k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 18:46:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzrFjp5uvro4PAGWNq3Bk5tr/YVfcEkASNFwrX7syVEFk68ZTRA9P7JLbIaLv6+c6swX7CQiA6cOHMOJ+w7zzsgAJudH4+zX2H1G73kXtua71B1jQW1B3UdtWlOSX7S/B/hdhXeg5LHj78ye+xDpV0ZcInXUAFCHevmLTFTHRHQpqpu7t/RLk1HitrX3TVS2ePvcZQYnuvo/OZpuHskikn6pdcqQQm91+6QjTnc4Z2XQnMJ0YHLKK/BJfhWfwgRi1KoxsObLXlbxCQGA3eUWQ6TLQP7eFaMFKS+7l4TS60MTJeVmE15CQb3tFY7WYaSkJXj9QntaZkm6Nxh5vrZEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSpcUobVHCMJIxaMjLpz+Dy42f53pq2SsvV1oOeWi9s=;
 b=for1n3q7AnwHW/SlRv1C9dc4hW92nv52RzFsQ4DjR5jzi8flRnQTLnPmzCLGXfC9Bwf7pohSPu0QSPDS8GFO+0gm4NIjZKVxkEM3C9RshrXUZUQSQbw+ufDiqBGhSKTaFgB4sByIav+CAx0kWOYSYGG4KyA/28e6ZXM1FsVVZIFyZ9TxSb6ZSw3DAXfXDDNCBmpr7XVQpZm72v2bdHS0mPpoi71KwyEhOiLrikppyjcTErwentFCOQul2AQJKY4UvmWOBpNolZJ8kA1rAL/kAVH+TbRmtcEq8eQPxi1deuOEAVud2waloGa8MICA0ii5x90TWIijJ0eIQLYS1MfedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS4PPF2CBEAAC80.namprd15.prod.outlook.com (2603:10b6:f:fc00::98e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 18:46:19 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 18:46:19 +0000
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
Thread-Topic: [EXTERNAL] [PATCH] ceph: fix hanging __ceph_get_caps() with
 stale `mds_wanted`
Thread-Index: AQHc1mGuV0y+XmF+7E+cuumHIjKZAbX00dUA
Date: Tue, 28 Apr 2026 18:46:19 +0000
Message-ID: <b7827e38e2e4b87aa92261e1f02a7b7340f8d0e0.camel@ibm.com>
References: <20260427155813.2561935-1-max.kellermann@ionos.com>
In-Reply-To: <20260427155813.2561935-1-max.kellermann@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS4PPF2CBEAAC80:EE_
x-ms-office365-filtering-correlation-id: 10763715-e73e-48b9-30c5-08dea5566fcd
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 Bx9+/AtEt8b17z8rkmz63LDspCe2BAucO6mjdxfiDZwJPxQ4+umqReV+P9b8c27Hmm2M6NxZWymHGRgT5ePksGnQIHZWfDvn6W8dRbOqs1Z5kgI95kFVRqbcvhTxChCjKHwaKYrjV3z3xvnyCb9ZJ8naZuHXVT0lmRyR29R6p1NWaIRM+pr7bXh7RIYKyZDmLBGLK+vO5OpAf1bxU7iZ83pntWUPhqYxlewLBj9pPWu2ubBySqim35jBRtWHz/g2kDeSppK2fA8LXZVyjUIWzLBKMexrz8M2djy0A7z0Q9kDOYG57y9RiE3Xd4N+nrFrXC4twCx/SlIg0x+FtGjLind5loT65Y/ARi9qsYM5s+d9sQ52vgF5fZAl0msAj9zKb/9u7zsQ6/qtTu4XTJtcovQ59b6tIlb6vyDmVBkD/w6K7ZWoUsLFp2bw49uSOmNWr6i3TIUzvr59RNKu8Y0SXEJOc2owC5bYZeJBgH+ckrD45rRTdjo4ieKiT7ja4kaiBwkEgQENu7C9tq7VsiSLwyV0LvDovOTwrgUQn57MFPS9Ts3XlI2WUBW2+aODXnf8GmLMqx7Y9iy3YMpmrekDKQAL0SuS4UbyEVl29EQ6Ah071ZZI81+qp2NznbnUWnCFAb1DW3n5ezbZ5h2ImiBqhHPGyEZJeiNPfWwc61tddOGVkhuNV8GkXvR+6UL0OuwHsD3YMKsxNWnWlFWQUiAkngBDW/FO1WtJZkMwVtjt2dTeiesWLNnPcFcHV3F904EhN49CaxaDLAun9a58sSmL7iSsPvw6I81/s2qaciuSyaA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmJUdkFPWEcvNTlMT2FBTHFDT3ZYM0ZHaHBETlVYV0MxSFk0ZTNmeFFRTzAv?=
 =?utf-8?B?K1MrdWNoaytkRTRJUjk3TlM3U3NxNS9Pb3lPL0JtV3I1eVczQkRCUWdEcy8w?=
 =?utf-8?B?eXdtdWFrYm9waVRiMC90RUwwNEdkdmtkSWpHcEJvU0VhRE1CTFFZUGkwd0Ew?=
 =?utf-8?B?cElXWXdmU3F0ZWhSTVFTRnJwMzJQT3NHYjRrS0h3dmszVnA5VjZhc1YrV29J?=
 =?utf-8?B?MXBneXpzeG40SWt6amNCQ2dvQ21pOHhpYkQ4UmE5Q0xHOFV6UnFjN2thVlUz?=
 =?utf-8?B?UXNKQU56TTRuTENUUDNoTjFHWDRtT1o5eUFMZ0o0MFJOS1hNTXNvUDd4M1hm?=
 =?utf-8?B?UmxkUkNRNFF2aytBdjlrUDc4TWUwVTYvUzZzT09RK01HaHVjQVc2bnVkNjlo?=
 =?utf-8?B?LzN5MWVVVjZKakJvamVpdHB0dkdTTlp2QUhrMFFGZmdxeThLNlJFNUJuTHp3?=
 =?utf-8?B?VVNFMytrZ25JQktMNmNHRVRuYmZMbmpDQnY3d2gweDFFaFZRS2MxaEtPZ1hQ?=
 =?utf-8?B?VDFsQWJCU3lzY01Fclp6VmROUlhtbXpEMmFFKzQyMlVjYVZ2SkJhdHJ4dGFj?=
 =?utf-8?B?ZTAwQkhzNHRhN1NCVUdkZVpLeXdGVkFkSXFidTUweHpxU3VIT0VpSkd3djdI?=
 =?utf-8?B?aWM0cWZ6aUFySDQ3MTltWGt2TlorN0FhSG96UEJ6azdUUS83Q2thSmtHcTdG?=
 =?utf-8?B?VWkyM2p0MTZickZST3k1c0FCTlEzaUtBR1lWcUEybEdBVVp1VlR2TjVQSzJX?=
 =?utf-8?B?a1psM2FmSW50TlN2b3p6cmpTYThZZGM4K0thYUNDQW9nakp4disrdEFYSUVs?=
 =?utf-8?B?M1hWamRZUFNrSllzaUo4SVl3ekV3L2xLZ05JSWgzNXlzUnVvZ1N2OVV5Vi95?=
 =?utf-8?B?a1FLZk1NYys3NlUrUlcvYUcyU3VBR3hJdTFFSml2QWZwR0tvMmg5MG55azEz?=
 =?utf-8?B?WmxKaStJdWlBSWlUdnRRWGFDazduTnFCZHk4cGVCQlptQkg4L05yTmFFVTRa?=
 =?utf-8?B?TXQ0NVdESHZLM1FVQ2tRVmMxeG5Hb04xZU8rL1hWamx0cTZoSFptQTRsWitY?=
 =?utf-8?B?UkdzcVVoOTRMMHNTZU1yamFpNnlwSEkwWldZRjRrOHFJa2U5M3VHaDhXSFkz?=
 =?utf-8?B?Z1hkbWg5R2xnejBYOXpjalduT3FrY2RNd2haUXB1UTV5MnRpTjBieFBQSWl4?=
 =?utf-8?B?V08zRk8raXpVUGZjTlRJTEY2VkM2eDBxN052Y1dPbXlyekQvcHBsUEVHZmN6?=
 =?utf-8?B?TGFqMUthaVVieitqQ0NKQU5haDhIbExKOTF0ekdMa21obWh6cG1FNEtSTi9j?=
 =?utf-8?B?TmtWNEVkVzJUQUFteVlxMXQzV0pkeEZsUWQxeVlBYTlyTVJ4V1VCVTA3V2tR?=
 =?utf-8?B?TGVlejdoUEtHWERqbkcxV2IwaGlvbi9hVjkvckZvU3F2dm1oL0MvOTBVT2Rh?=
 =?utf-8?B?OE1YbVZxakVibUYrVzFiNE5QY1lRcWVjUlNERks5NDl1K3Q2dzdmM3JoS0Vs?=
 =?utf-8?B?OHhMU3hLMmZ3YVNCQVBlbUhOYnZ5VG5kdmJDR1VIWVpWa1JaVDQ3RTBDdWt0?=
 =?utf-8?B?dEljeGs5L0pRSEhZbE42UEc1Y1duL3psVTBTdDFlRzNKUUFvMlVXQ0IvdTZP?=
 =?utf-8?B?NmNCaTROM3RLejI3QmZDU29xQkFpRnhrYXJjNG5rdytQZkw5UEQxVlRLd3ds?=
 =?utf-8?B?ZXloVytJKzhwak9MZlhZZFR5MlJnQTVFVVBLMmlBNXNXZEpQSTN2eUtZV1Vm?=
 =?utf-8?B?VG9NZzBnVk5HYmFJdVdBeUNQYVcrS0x5b1RJakp1UWcrMzF1cVJtK0YvUHJi?=
 =?utf-8?B?bjBTaHRicmNMVUduSEU3UEQxV3VqcVJtWFFxZHg0TC9YeWVZUXJuSVVxaStY?=
 =?utf-8?B?RW1oSmk1QXJudGJxeXpDNHJYSmFLMDViL1dTdjM5emxHWHU5eDhsTFNaMzRq?=
 =?utf-8?B?b2M0aU1Dc09TMjVQQk9iSXlWczVUNVdBb2kvRTl2THpVNENLdVFrdjYyTFc2?=
 =?utf-8?B?SWR0Rjk2V3dIeFRwNDh5T0pCTGVBMzZDNjJUOEIrWmRjVjFMY3A5NllYVENN?=
 =?utf-8?B?a2xyZWlYY2JhVnpuaGFpZ3dQcm5KYXJ1ajZpUGRTQ2JiZ3o5WnlSTVhRT1I0?=
 =?utf-8?B?SUJDcTNMYk1zN0cyeEd6MXhqWTB1STg3Q3FNNzRMem4yK2FLSndIMWhUaksw?=
 =?utf-8?B?VllPOXNtMm9RUmFSWnp5enRacjdxbHViODFhSzlYb1JYOWt1aExTSlh4Rmhk?=
 =?utf-8?B?N1R6L3lZdU05KzhTMm1kTjh0aFJSR1M0U24rdVFHTENGL0l5MTRDa1cxZVlD?=
 =?utf-8?B?L2NjSk9WZnczOS9mbUl3Sk93K2FHWktNR2xZeXVSMFJkSFZzM1M5MTZTZVlo?=
 =?utf-8?Q?xP+47kgRp9A8eGl2ucJQpZHkS13vY03p/N/OU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5D957675B4001448DC20205A81428C9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	bnSC6eRfThLXe7pS20pAev27ir3KCHJnWUOEymtvCY8uFR5zh1T/392jk4XrNLJAnI8mivP5EUY3mzpdGE2p3BdnpUJJgCAq+bfh6XIpG50a35wVeGVv1uW/yNNKe0BkbAJYiMd7Kdgt8Umyox6V7qvNOQLam8mf2ZNO1AUa6eiKMekCgrgDMVhyK2HZOB8KI//baJqPFo2pfeRe4KNDNJ9aY9RZHOMEseOmm6gIrc8jqPpzolcKxpJ2mqpyF39lQ1Wqe7bWZQ5ta9LP7JRB5nKQaztU1dctZzoZX1q09GHi7uug+KC7HGULKOY2j54z1nj/Uaoe08RuHfunaKS0wQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10763715-e73e-48b9-30c5-08dea5566fcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 18:46:19.3727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idVUIJx1H5v6lEwwtc0yxFxBTiNLeM83MoxayInLEdzxkEH2/NLIsHhtR/+vPw42ERqgl3Q3+LAjt7UpYlgO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2CBEAAC80
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f1007f cx=c_pps
 a=DoKDTACKjh9G6IJ+hAMtGg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=UgJECxHJAAAA:8
 a=G1D-ENIrLMZmrEi4EKwA:9 a=QEXdDO2ut3YA:10 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE3NyBTYWx0ZWRfX/EgO/RRtHQO2
 vslv5oiVLako0+PdJhl0HcQjyzg89a5F0SIyDm4PLzecZ04YS4JIOaZL+gULnBb+m1U9yYmR3Lu
 3jXEo/vZvmeAjELcDTEdiJPyJ8ztb0C06QHQFe4JHnPXSwiLXI1U3TS3yS0HLMefq7fVQDo5SSG
 i9rYAoKFHDVSaFImmQZQ4sRe775GcNE4SWrbhH8ljFGH2VvzwdNRq+kCyRU6O7a6Vd+lG1LdEgG
 6lM9C2SVcYNW+W4ery0jCTDKK9L2ThXnf7Xbo3TfiDYMF3nZwrGGmvdb/A2QE/9v2eDpos40Tu+
 Su/vMGZKNqHHzi4VWPR/YKU9snjmcQ9iCBQ90UNgN5Q+JPyulGQ4FuVEcWnZLbnO5GSaSezUTJP
 3e4GRJZeyGs6yM/eCdI/QcvYKy+L3izAE5uF9OH+A6kfk8Urbm1/koGAuT9TPol/O4QnhSwTRut
 zlc+pMRwE7Rt9zYcgZA==
X-Proofpoint-GUID: zk9TkObZ7Dh7laI8h4shhGTfx80jjlSv
X-Proofpoint-ORIG-GUID: cfuIX9tv1FlDvJVFmCVjjTGBYG9i8fiy
Subject: Re:  [PATCH] ceph: fix hanging __ceph_get_caps() with stale
 `mds_wanted`
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280177
X-Rspamd-Queue-Id: CFFAA48AD02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ionos.com,gmail.com,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241758-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

T24gTW9uLCAyMDI2LTA0LTI3IGF0IDE3OjU4ICswMjAwLCBNYXggS2VsbGVybWFubiB3cm90ZToN
Cj4gQSByZWFkZXIgY2FuIGhhbmcgZm9yZXZlciBpbiBfX2NlcGhfZ2V0X2NhcHMoKSB3aGVuIHRo
ZSBjbGllbnQgbm8NCj4gbG9uZ2VyIGhvbGRzIGBGSUxFX1JEYCwgYnV0IGxvY2FsIGNhcCBzdGF0
ZSBzdGlsbCBzYXlzIHRoYXQgdGhlDQo+IGNhcGFiaWxpdHkgaXMgYWxyZWFkeSB3YW50ZWQgKHZp
YSBgbWRzX3dhbnRlZGApLg0KPiANCj4gT25lIHdheSB0byB0cmlnZ2VyIHRoaXMgaXMgdGhyb3Vn
aCBNRFMgY2FwIHJldm9jYXRpb24uICBJZiBhbm90aGVyDQo+IGNsaWVudCBwZXJmb3JtcyBhIGNv
bmZsaWN0aW5nIG9wZXJhdGlvbiwgdGhlIE1EUyBjYW4gcmV2b2tlIGBGSUxFX1JEYA0KPiBmcm9t
IHRoZSByZWFkZXI7IHRoZSBuZXh0IHJlYWQgdGhlbiBoYXMgdG8gcmVhY3F1aXJlIGBGSUxFX1JE
YC4gIElmDQo+IHRoZSBjYXAgdXBkYXRlIHRoYXQgc2hvdWxkIHJlcXVlc3QgYEZJTEVfUkRgIG5l
dmVyIHJlYWNoZXMgdGhlIE1EUw0KPiBhZnRlciBgY2FwLT5tZHNfd2FudGVkYCB3YXMgcmFpc2Vk
LCB0aGUgcmVhZGVyIGlzIGxlZnQgaG9sZGluZyBvbmx5DQo+IG5vbi1maWxlIGNhcHMgd2hpbGUg
bG9jYWwgYG1kc193YW50ZWRgIHN0aWxsIGluY2x1ZGVzIHRoZSBmaWxlIHJlYWQNCj4gY2Fwcy4N
Cj4gDQo+IEluIHRoYXQgc3RhdGUsIHRyeV9nZXRfY2FwX3JlZnMoKSBzZWVzIGBuZWVkIDw9IG1k
c193YW50ZWRgIGFuZA0KPiByZXR1cm5zIDAsIHNvIF9fY2VwaF9nZXRfY2FwcygpIGp1c3Qgd2Fp
dHMgb24gYGlfY2FwX3dxYC4gIElmIHRoZSBjYXANCj4gdXBkYXRlIHRoYXQgd2FzIHN1cHBvc2Vk
IHRvIHJlcXVlc3QgYEZJTEVfUkQgbmV2ZXIgcmVhY2hlcyB0aGUgTURTDQo+IGFmdGVyIGBjYXAt
Pm1kc193YW50ZWQgd2FzYCByYWlzZWQsIG5vIGZ1cnRoZXIgcmVxdWVzdCBpcyBzZW50IGFuZCB0
aGUNCj4gd2FpdGVyIGNhbiBzbGVlcCBpbmRlZmluaXRlbHkgdW50aWwgdW5yZWxhdGVkIGNhcCB0
cmFmZmljIGhhcHBlbnMgdG8NCj4gd2FrZSBpdCB1cC4NCj4gDQo+IFRoZSBvcmRlcmluZyBpc3N1
ZSBpcyB0aGF0IGBjYXAtPm1kc193YW50ZWRgIGlzIHVwZGF0ZWQgaW4NCj4gX19wcmVwX2NhcCgp
IGJlZm9yZSB0aGUgYENFUEhfTVNHX0NMSUVOVF9DQVBTIG1lc3NhZ2VgIGlzIGFjdHVhbGx5DQo+
IHF1ZXVlZCBmb3Igc2VuZC4gIFRoYXQgbWFrZXMgb25lIGZpZWxkIHNlcnZlIHR3byBkaWZmZXJl
bnQgbWVhbmluZ3MgYXQNCj4gb25jZTogd2hhdCB0aGlzIGNsaWVudCB3YW50cywgYW5kIHdoYXQg
dGhlIGNsaWVudCBiZWxpZXZlcyB0aGUgTURTDQo+IGFscmVhZHkga25vd3MgaXQgd2FudHMuDQo+
IA0KPiBBIHByb3BlciBmaXggd291bGQgYmUgdG8gc3BsaXQgdGhvc2Ugc3RhdGVzIGFuZCB0cmFj
ayB3aGV0aGVyIGEgY2FwDQo+IHVwZGF0ZSBpcyBhY3R1YWxseSBpbiBmbGlnaHQgb3IgaGFzIGJl
ZW4gb2JzZXJ2ZWQgYnkgdGhlIE1EUy4NCj4gSG93ZXZlciwgc2ltcGx5IG1vdmluZyB0aGUgYGNh
cC0+bWRzX3dhbnRlZCBhc3NpZ25tZW50YCBsYXRlciB3b3VsZA0KPiBub3QgYmUgc3VmZmljaWVu
dDogcXVldWVpbmcgdGhlIG1lc3NhZ2UgaW4gdGhlIG1lc3NlbmdlciBkb2VzIG5vdA0KPiBndWFy
YW50ZWUgdGhhdCB0aGUgTURTIHByb2Nlc3NlZCB0aGF0IHNwZWNpZmljIHdhbnRlZCBzZXQsIGFu
ZA0KPiByZWNvbm5lY3Qgb3IgbWVzc2FnZSBsb3NzIGNhbiBzdGlsbCBpbnZhbGlkYXRlIHRoYXQg
YXNzdW1wdGlvbi4NCj4gRml4aW5nIHRoYXQgcHJvcGVybHkgd291bGQgcmVxdWlyZSBhIGxhcmdl
ciByZXdvcmsgb2YgdGhlIGNhcCBzdGF0ZQ0KPiBtYWNoaW5lLg0KPiANCj4gVG8gYWxsb3cgc2lt
cGxlciBiYWNrcG9ydHMgdG8gc3RhYmxlIGtlcm5lbHMsIHRoaXMgcGF0Y2ggaW1wbGVtZW50cyBh
DQo+IHNpbXBsZXIgd29ya2Fyb3VuZDoNCj4gDQo+IC0gc3RvcCB3YWl0aW5nIGZvcmV2ZXIgaW4g
X19jZXBoX2dldF9jYXBzKCk7IGFmdGVyIGEgYm91bmRlZCB3YWl0LA0KPiAgIGZhbGwgYmFjayB0
byB0aGUgcmVuZXcgcGF0aA0KPiANCj4gLSBtYWtlIGNlcGhfcmVuZXdfY2FwcygpIGlzc3VlIGEg
c3luY2hyb25vdXMgYE9QRU5gIHJlcXVlc3Qgd2hlbmV2ZXINCj4gICB0aGUgaW5vZGUgc3RpbGwg
ZG9lcyBub3QgYWN0dWFsbHkgaG9sZCB0aGUgd2FudGVkIGNhcHMsIGluc3RlYWQgb2YNCj4gICBv
bmx5IGNhbGxpbmcgY2VwaF9jaGVja19jYXBzKCkNCj4gDQo+IFRoZSBleHRyYSBpc3N1ZWQtdnMt
d2FudGVkIGNoZWNrIGluIGNlcGhfcmVuZXdfY2FwcygpIGlzIG5lY2Vzc2FyeQ0KPiBiZWNhdXNl
IHRoZSBwcmV2aW91cyB0ZXN0IG9ubHkgY2hlY2tlZCB3aGV0aGVyIHRoZSBpbm9kZSBzdGlsbCBo
YWQgYW55DQo+IHJlYWwgY2FwcyBhdCBhbGwuICBUaGF0IGlzIG5vdCBlbm91Z2ggYWZ0ZXIgcmV2
b2NhdGlvbjogdGhlIGNsaWVudCBjYW4NCj4gc3RpbGwgaG9sZCBzb21ldGhpbmcgbGlrZSBgcExz
YCBhbmQgeWV0IGJlIG1pc3NpbmcgYEZJTEVfUkRgDQo+IGNvbXBsZXRlbHkuICBJbiB0aGF0IGNh
c2UsIGZhbGxpbmcgYmFjayB0byBjZXBoX2NoZWNrX2NhcHMoKSBpcyBub3QNCj4gc3VmZmljaWVu
dCwgYmVjYXVzZSBpdCBzdGlsbCB0cnVzdHMgYGNhcC0+bWRzX3dhbnRlZGAgYW5kIG1heSByZXNl
bmQNCj4gbm90aGluZy4gIEJ5IHJlcXVpcmluZyBgKGlzc3VlZCAmIHdhbnRlZCkgPT0gd2FudGVk
YCBiZWZvcmUgdGFraW5nIHRoZQ0KPiBhc3luY2hyb25vdXMgcGF0aCwgdGhlIGNvZGUgb25seSB1
c2VzIGNlcGhfY2hlY2tfY2FwcygpIHdoZW4gdGhlDQo+IGB3YW50ZWQgY2Fwc2AgYXJlIGFscmVh
ZHkgYWN0dWFsbHkgaXNzdWVkLiAgT3RoZXJ3aXNlLCBpdCBzZW5kcyB0aGUNCj4gc3luY2hyb25v
dXMgYE9QRU5gIHJlbmV3Lg0KPiANCj4gVGhpcyBwcmVzZXJ2ZXMgdGhlIGV4aXN0aW5nIGFzeW5j
aHJvbm91cyBmYXN0IHBhdGggd2hlbiB0aGUgd2FudGVkDQo+IGNhcHMgYXJlIGFscmVhZHkgaXNz
dWVkLCBhdm9pZHMgY2hhbmdpbmcgY2FwLXN0YXRlIHNlbWFudGljcywgYW5kDQo+IGZpeGVzIHRo
ZSBoYW5nIGJ5IGd1YXJhbnRlZWluZyB0aGF0IGEgc3RhbGxlZCB3YWl0ZXIgZXZlbnR1YWxseQ0K
PiByZXRyaWVzIHRocm91Z2ggYSBwYXRoIHRoYXQgZG9lcyBub3QgcmVseSBvbiB0aGUgc3RhbGUg
YG1kc193YW50ZWRgDQo+IHN0YXRlLg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU2lnbmVkLW9mZi1ieTogTWF4IEtlbGxlcm1hbm4gPG1heC5rZWxsZXJtYW5uQGlvbm9zLmNv
bT4NCj4gLS0tDQo+ICBmcy9jZXBoL2NhcHMuYyB8IDIwICsrKysrKysrKysrKysrKysrLS0tDQo+
ICBmcy9jZXBoL2ZpbGUuYyB8ICA5ICsrKysrLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMiBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgv
Y2Fwcy5jIGIvZnMvY2VwaC9jYXBzLmMNCj4gaW5kZXggZDUxNDU0ZTk5NWE4Li5kZDExNjExZjI1
MGIgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvY2Fwcy5jDQo+ICsrKyBiL2ZzL2NlcGgvY2Fwcy5j
DQo+IEBAIC0zMDg3LDExICszMDg3LDI0IEBAIGludCBfX2NlcGhfZ2V0X2NhcHMoc3RydWN0IGlu
b2RlICppbm9kZSwgc3RydWN0IGNlcGhfZmlsZV9pbmZvICpmaSwgaW50IG5lZWQsDQo+ICAJCQlm
bGFncyB8PSBOT05fQkxPQ0tJTkc7DQo+ICAJCQl3aGlsZSAoIShyZXQgPSB0cnlfZ2V0X2NhcF9y
ZWZzKGlub2RlLCBuZWVkLCB3YW50LA0KPiAgCQkJCQkJCWVuZG9mZiwgZmxhZ3MsICZfZ290KSkp
IHsNCj4gKwkJCQlzdGF0aWMgY29uc3QgdW5zaWduZWQgbG9uZyB3YWl0X3RpbWVvdXQgPSA1ICog
SFo7DQoNCldoeSBleGFjdGx5IDUgKiBIWj8gV2hhdCBpcyB0aGUgYmFzaXMgZm9yIHRoaXMgdGlt
ZW91dD8gQ291bGQgd2UgcmUtdXNlIGFueQ0KYXZhaWxhYmxlIHRpbWVvdXRzIGluIENlcGhGUyBk
ZWNsYXJhdGlvbnM/DQoNCj4gKw0KPiAgCQkJCWlmIChzaWduYWxfcGVuZGluZyhjdXJyZW50KSkg
ew0KPiAgCQkJCQlyZXQgPSAtRVJFU1RBUlRTWVM7DQo+ICAJCQkJCWJyZWFrOw0KPiAgCQkJCX0N
Cj4gLQkJCQl3YWl0X3dva2VuKCZ3YWl0LCBUQVNLX0lOVEVSUlVQVElCTEUsIE1BWF9TQ0hFRFVM
RV9USU1FT1VUKTsNCj4gKw0KPiArCQkJCS8qDQo+ICsJCQkJICogSWYgYSBjYXAgdXBkYXRlIGlz
IGxvc3QgYWZ0ZXINCj4gKwkJCQkgKiBtZHNfd2FudGVkIHdhcyByYWlzZWQsIHdhaXRpbmcNCj4g
KwkJCQkgKiBmb3JldmVyIHdpbGwgbmV2ZXIgbWFrZSBwcm9ncmVzcy4NCj4gKwkJCQkgKiBSZXRy
eSB0aGUgcmVuZXcgcGF0aCBwZXJpb2RpY2FsbHkNCj4gKwkJCQkgKiBzbyB3ZSBjYW4gcmVzZW5k
IHN5bmNocm9ub3VzbHkuDQo+ICsJCQkJICovDQo+ICsJCQkJaWYgKCF3YWl0X3dva2VuKCZ3YWl0
LCBUQVNLX0lOVEVSUlVQVElCTEUsIHdhaXRfdGltZW91dCkpIHsNCj4gKwkJCQkJcmV0ID0gLUVV
Q0xFQU47DQo+ICsJCQkJCWJyZWFrOw0KPiArCQkJCX0NCj4gIAkJCX0NCj4gIA0KPiAgCQkJcmVt
b3ZlX3dhaXRfcXVldWUoJmNpLT5pX2NhcF93cSwgJndhaXQpOw0KPiBAQCAtMzEyNSw4ICszMTM4
LDkgQEAgaW50IF9fY2VwaF9nZXRfY2FwcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgY2Vw
aF9maWxlX2luZm8gKmZpLCBpbnQgbmVlZCwNCj4gIAkJCQljb250aW51ZTsNCj4gIAkJCX0NCj4g
IAkJCWlmIChyZXQgPT0gLUVVQ0xFQU4pIHsNCj4gLQkJCQkvKiBzZXNzaW9uIHdhcyBraWxsZWQs
IHRyeSByZW5ldyBjYXBzICovDQo+IC0JCQkJcmV0ID0gY2VwaF9yZW5ld19jYXBzKGlub2RlLCBm
bGFncyk7DQo+ICsJCQkJLyogc2Vzc2lvbiB3YXMga2lsbGVkIG9yIGEgd2FpdGVkIGNhcA0KPiAr
CQkJCSAqIHJlcXVlc3QgbmVlZHMgYSByZXRyeSAqLw0KPiArCQkJCXJldCA9IGNlcGhfcmVuZXdf
Y2Fwcyhpbm9kZSwgZmxhZ3MgJiBDRVBIX0ZJTEVfTU9ERV9NQVNLKTsNCg0KRnJhbmtseSBzcGVh
a2luZywgSSBkb24ndCBxdWl0ZSBmb2xsb3cgd2h5IGRvIHdlIG5lZWQgdG8gYWRkIGZsYWdzICYN
CkNFUEhfRklMRV9NT0RFX01BU0s/DQoNClRoYW5rcywNClNsYXZhLg0KDQo+ICAJCQkJaWYgKHJl
dCA9PSAwKQ0KPiAgCQkJCQljb250aW51ZTsNCj4gIAkJCX0NCj4gZGlmZiAtLWdpdCBhL2ZzL2Nl
cGgvZmlsZS5jIGIvZnMvY2VwaC9maWxlLmMNCj4gaW5kZXggZDU0ZDcxNjY5MTc2Li40N2M3ZDRh
NWZmZWQgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvZmlsZS5jDQo+ICsrKyBiL2ZzL2NlcGgvZmls
ZS5jDQo+IEBAIC0zMTQsNyArMzE0LDcgQEAgc3RhdGljIGludCBjZXBoX2luaXRfZmlsZShzdHJ1
Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSwgaW50IGZtb2RlKQ0KPiAgfQ0KPiAg
DQo+ICAvKg0KPiAtICogdHJ5IHJlbmV3IGNhcHMgYWZ0ZXIgc2Vzc2lvbiBnZXRzIGtpbGxlZC4N
Cj4gKyAqIFJldHJ5IGNhcCBhY3F1aXNpdGlvbiBhZnRlciBhIHN0YWxlIHNlc3Npb24gb3IgYSBs
b3N0IGNhcCB1cGRhdGUuDQo+ICAgKi8NCj4gIGludCBjZXBoX3JlbmV3X2NhcHMoc3RydWN0IGlu
b2RlICppbm9kZSwgaW50IGZtb2RlKQ0KPiAgew0KPiBAQCAtMzIyLDE0ICszMjIsMTUgQEAgaW50
IGNlcGhfcmVuZXdfY2FwcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBpbnQgZm1vZGUpDQo+ICAJc3Ry
dWN0IGNlcGhfY2xpZW50ICpjbCA9IG1kc2MtPmZzYy0+Y2xpZW50Ow0KPiAgCXN0cnVjdCBjZXBo
X2lub2RlX2luZm8gKmNpID0gY2VwaF9pbm9kZShpbm9kZSk7DQo+ICAJc3RydWN0IGNlcGhfbWRz
X3JlcXVlc3QgKnJlcTsNCj4gLQlpbnQgZXJyLCBmbGFncywgd2FudGVkOw0KPiArCWludCBlcnIs
IGZsYWdzLCB3YW50ZWQsIGlzc3VlZDsNCj4gIA0KPiAgCXNwaW5fbG9jaygmY2ktPmlfY2VwaF9s
b2NrKTsNCj4gIAlfX2NlcGhfdG91Y2hfZm1vZGUoY2ksIG1kc2MsIGZtb2RlKTsNCj4gIAl3YW50
ZWQgPSBfX2NlcGhfY2Fwc19maWxlX3dhbnRlZChjaSk7DQo+ICsJaXNzdWVkID0gX19jZXBoX2Nh
cHNfaXNzdWVkKGNpLCBOVUxMKTsNCj4gIAlpZiAoX19jZXBoX2lzX2FueV9yZWFsX2NhcHMoY2kp
ICYmDQo+IC0JICAgICghKHdhbnRlZCAmIENFUEhfQ0FQX0FOWV9XUikgfHwgY2ktPmlfYXV0aF9j
YXApKSB7DQo+IC0JCWludCBpc3N1ZWQgPSBfX2NlcGhfY2Fwc19pc3N1ZWQoY2ksIE5VTEwpOw0K
PiArCSAgICAoISh3YW50ZWQgJiBDRVBIX0NBUF9BTllfV1IpIHx8IGNpLT5pX2F1dGhfY2FwKSAm
Jg0KPiArCSAgICAoaXNzdWVkICYgd2FudGVkKSA9PSB3YW50ZWQpIHsNCj4gIAkJc3Bpbl91bmxv
Y2soJmNpLT5pX2NlcGhfbG9jayk7DQo+ICAJCWRvdXRjKGNsLCAiJXAgJWxseC4lbGx4IHdhbnQg
JXMgaXNzdWVkICVzIHVwZGF0aW5nIG1kc193YW50ZWRcbiIsDQo+ICAJCSAgICAgIGlub2RlLCBj
ZXBoX3Zpbm9wKGlub2RlKSwgY2VwaF9jYXBfc3RyaW5nKHdhbnRlZCksDQo=

