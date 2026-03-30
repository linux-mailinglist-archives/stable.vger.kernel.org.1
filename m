Return-Path: <stable+bounces-231258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHf7Mg6tymkx/AUAu9opvQ
	(envelope-from <stable+bounces-231258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 19:04:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6576735F2A9
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 19:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFE75301511B
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC543859C7;
	Mon, 30 Mar 2026 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Aqtkh2Rx"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84869341650;
	Mon, 30 Mar 2026 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890250; cv=fail; b=fYl1Sj/VqzT2dNSsgV1aY2SBBUg8rOP1L6E0jj4QaifsAJPM5oX0tw3xAY87plweX8AOEoECea8Tjgbf2Eb/5yQjcTNi+6DqAde5dhyge6VH5Oq3mQ0Mit8WHG2Wc78ByDivl+TdQzXEEZbBhVBqPxKoSaE+5jwIdLhiwIT/1MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890250; c=relaxed/simple;
	bh=UOV1pXXGKR9uu2gv33TdaZimYkOu7EvnZqFIuOp7tn4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=TFkAI+ag/jfOcXV9D1xdeiXyexmGX9FfCS8fQvKXH61USlfTi3aY62XOxJdtJ6Ed4Se6ii/V0N30Ng0PmVqeui/rygIs8K7cShaIxf4OXCFyWiOPpXp69HKmAQNyLkzdOj+LZSA+Iob05bIkNEfsFqW+ogZY56rJjU+YoDpj9t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Aqtkh2Rx; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAtVqj3226225;
	Mon, 30 Mar 2026 17:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=UOV1pXXGKR9uu2gv33TdaZimYkOu7EvnZqFIuOp7tn4=; b=Aqtkh2Rx
	PqjZFrpo6PQvK6FMJK6bCu/VPNjj+l1u9l+9k5WemYN9iXYyuJn4q9LSokEAArfA
	G9dZQ0mqM2EmEEhG1d3KWoB5AL3q2R1/BIwtZ+VsZc/BJPqRkj4mHLgwNAeplAyL
	hCtFcNergfddQWhNYIbtZguvOFnF0Q8831EEkzAN1lUpCEf8yhlVi9uQNJow/MT2
	4oE5Q8A8j0ozH8nxOsl3V1ryYypb8dG7rKAQ4njGNXZkjEE93IL86iZaNyYqsoby
	Vc48MJrAqhMq7OVlJLEHU6zYprk/n1k5Xz337klHK18drHZMx99hPVbApx4nUNBD
	gFlK40AiTaotgQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnfu8v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 17:04:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HytLLFLF2+YGCzeiv41j4VhyNy9qEnTFkmes//MM6dIujapJh46u2Obju4RdKKwpHpWqunT55gINJGgGEGsaVaGmteWbqMg1sfw7a+Q0iN7Q19IHJwozhYTAkbgOK5grgyffpZD0UrEqe5TBOOnKBcKpOQstZwt/fs1kPAVmEUxlhOrH0FNX12/NxIzfvWshHqu6hzORE9tghghstFgwQ1in4WMnw7+ILPxKopvc2u9uoQomhfAvJnTMYJuC+NFcW4iMPIHhFi+WlvluaIRvXI+wX+gGakpb3WjAjP4lMwYA+bmywkptX2PmAG52YFRzS94O9ODy1O06P+vmRNb3bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOV1pXXGKR9uu2gv33TdaZimYkOu7EvnZqFIuOp7tn4=;
 b=sEAanrv0Pc9pebmePHVJwZILWMRX6q2f6nvNUEj7TUM+2rCdWqPg4/HH2Nr2cFd3+9I2XBV4jZxBzFh2WGpmsMbISxXsLAUUru5KHQhrqeCP34QWdJugyCdaU8R2xO5ud24XuU+H/rh88RwwXMXY7Es88Kk1Pl/h2eVHBwOvt6EqXxZMXNmCkno2HEI6OOSSg6BexASShvWjIoNY+N6yTC+Wt3FV/nbJgkDpt9kvyePAin0tCpMdHnayJGvVsGmWkecF0/lrhYObUrripUpwKnCYouzW1+ratLKlYfG3Kd13/gtmOgxAJw5dLwn085+TZ2SUSHCNPZnjYRE1B93Hrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MN6PR15MB6341.namprd15.prod.outlook.com (2603:10b6:208:47e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 17:04:00 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 17:04:00 +0000
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
Thread-Topic: [EXTERNAL] Re:  [PATCH] ceph: only d_add() negative dentries
 when they are unhashed
Thread-Index: AQHcwGczdLET/MkZjkWLja1B6qa1JA==
Date: Mon, 30 Mar 2026 17:04:00 +0000
Message-ID: <f8c25bcd64be6fdaafd4e49507ea9e04110d56a5.camel@ibm.com>
References: <20260327162308.1118621-1-max.kellermann@ionos.com>
	 <765945680a8b83b26148430752295deedea831e7.camel@ibm.com>
In-Reply-To: <765945680a8b83b26148430752295deedea831e7.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MN6PR15MB6341:EE_
x-ms-office365-filtering-correlation-id: 18da1585-e40d-4b44-5a4c-08de8e7e569d
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 Vvce9JCj6BE7+sJW0qQ/P79cjK44iqpfuDfKdwfTatQwE3hMfl9sWo8vxTROfPhrxXNVjBM6oOh9KNS0aE0lsiKXvZA1L2DHZvAgaCrnOb2akjmek8wYVPA0/uE+XI1Tib2epLF41ftaqWtZRtR7HM4NR7MkJ3LyrsEth6zRJvcak5KMfjIvldL3dTb+aawd8es4UaWgoAJdF9pf82+KTDAd8Keb6C3GDOIqa+adClcmMm57oQEmScGe1Swagh+dcgMPH1SqNSAwrIu15dJ9f5uK/beBPN2Dgk/9Gs8yMHhxIpJUXR9q8NP0WaBS0DYEzXDJNf+q1r6eql7r1JcXQ/qbJWXbapOetSWyj752FJUoPuoriDTTw7yFvpovYrLX3Uv0mJGkBklR7TgSP1QggelEF9Ai6uI1uG4VJPKtyr2w0eTT3cCU13WG53snwUyEJM+DdlWU4hyN+JegmJGdZOhe96do/AK0faBAKVfmjwGUpB4X/ntXKMNPdS8eQKEyOyT8fYq9BHSi8opp3Bw06pUWjzI2xTo0FQLl+pIReAqOaw2y48O6tKVjhl78baSE5zZbRuvSh4k4rD3Td3XA0apjZkcIemfI0IZH/bvojAamcp4CxSmdxIWPeUg83MlEdwc78F+uICthuj+RGmSMAPLXmz6SpM89ag+iinhS/ps4NfXVWjOJAPuswjFU/6i8QJRWP8MBFldAUCVWPWtOyuTPBH/gUonCD/viy4xtagfQntKiT6rSlkYBhhS1YmiRNHdqIBMGMar2t49wHrkDqdtQkYo+nhWdc3SLM3rOnF4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3RUWDdadWMrTHEzTVl4RHhsMVNsL2l6Z0dVcHpNaFpKY0Fhc2pJTXUvdHBM?=
 =?utf-8?B?MTIxRlVqY213c085YTIzdWpLZVVVdU1iV3Z1b1Z1ajFacVI3OWE2a0d4aEN5?=
 =?utf-8?B?SXpENlBjL2g5blJOOVRWRk13OE8xRVdSbnhKS1ZTT2hCdDQ0eEczVEdwVEVt?=
 =?utf-8?B?TnZTZnNRajJLcVJkY1pOaHhSbHFzckRJcjNLT0dtcnY1Vk83eC9wMENrVlhE?=
 =?utf-8?B?bnhIWVhobGNSdjlDMk10eGMrZm9mYW9JS0dwLzN0TFg4MkpnbEFDWnV4bFRK?=
 =?utf-8?B?ODc2Y3V2Q0RCTHAxd1JuWUNMK09NMzRmQlRvUzNwZ2d6Wlc4Vlo2eEVWaHBl?=
 =?utf-8?B?QytoOFJtWmxqY0VOaXEyaHQvK0VxSmVkTmNGYVUrNVJTTnZ2NFVFcUZKaE5U?=
 =?utf-8?B?dUg2T0pLcmhOTUdpblJhNGFvNTd4NHkzbEs2amt2VCtjQ29ZSHFXMWREcGZP?=
 =?utf-8?B?WmxzUDB3MlhPUmJ6YXNGTmw2cUZNdzVoNzhKcFQvSUtHVGJoSVJLOEMxWjda?=
 =?utf-8?B?QUNSZTF5QWdETDZYSjJCTnFySm0rdCt5MHN4OFRMTFA2OVkxMjB1Y2RUWTY5?=
 =?utf-8?B?RzFtQzZER0Z6THNBbTRqV1UrbStXblhZKytKN1RMNmw4NWFBWExUL1NUbGdr?=
 =?utf-8?B?OEtIRmNPS2k1Wm4vRG1WeFBCalV3R0gwOGxGa1d1SEY5QWFMWnV6cXpDR3px?=
 =?utf-8?B?a2V0TjJ3aW9FOTFKVnhtQWRYUTVCZ0tRMmVQbm1SUVI4aXZiY2VFd0FXdGNL?=
 =?utf-8?B?NGpWU3BOWEtla0ZhdVJYY0UxZjRxOHlrZzZIUHhCUTAzYkY4OWd4R1UyamdH?=
 =?utf-8?B?ZGs1WUM4dlRraHBmNUdPZzVpaDhHR08zalozb25ncTlncXo5SVYyRTBhS1JX?=
 =?utf-8?B?dU0rTTJJWjAyZkVydUpLcjF5Nzgya1NiZFpIdTZ3QlpzNFlaNjBwdlRXM0pS?=
 =?utf-8?B?K1dhME1FYjdRTXZGZ0NvTGlURnBUNVpkaC9NdS95bWthWjQxV3ZrbGh2b1VK?=
 =?utf-8?B?NEZRRmxaWnZ5MHBzeTdjN0NmMHppUEpFOUM0K3lGUDRrQjZvZEd3L3dRMVYv?=
 =?utf-8?B?bkpGcExXTmFvNEZ6NDlaV2FaRXNrR2V5dmRDbEtlNGtxRDgyd0RjQTVhZzhN?=
 =?utf-8?B?RTcwMmR4OHQwSUZGZU1BT1NxTnRoaVM2Yzk5SC9Ddi9rNmQrSzRzTFdLVmZp?=
 =?utf-8?B?QlJOVTY1NmF3YzRnU1RRb04rR2k0UCtOUzlrRjltTU1Dc1JBMWtldVRid3FQ?=
 =?utf-8?B?WThHSk5iNjl6SkhYMjJPdWp2YVVjNy95QmZQMU9FV1VwbWZmeFVMR3FPQmM3?=
 =?utf-8?B?RlExOVRpbE5ySkdNUHQ5ZzFRSENlNHF5a1hpcVE1eS9yT29EbXpxNUxmNG5J?=
 =?utf-8?B?c2ZxY3g4RG9nWEl6amc5WUtEQnNDV3NVaVo3RlhweGwzYWRXN2t0YlBHZk55?=
 =?utf-8?B?RUQwTmVMd1VMWG14OFpKNDZJdHhzenBzWU9vOW12RTBFVXJ5WE5tZmdVajdO?=
 =?utf-8?B?VjZ6K1Vwam00bWVldnA3aG1YL3M1a0plc3BvMzAzbVpydXRyMExEZGRLUTE1?=
 =?utf-8?B?SFVKSE41dDFhWGZXb0Y4T1p6ckttOGVxemc4RHpSai9DaldaTVpWWkdiWXY3?=
 =?utf-8?B?b2JHRXc4ZWlmai8rZXpDQzk2eUJySjU1QUhDZldUOTVWVVdFMExnYjBndHla?=
 =?utf-8?B?NWdMOE5YczBvZTk1anBhZ1hWMkR0MTFDMlh5c0NLVkJhL0dRam5jNUFsbzFJ?=
 =?utf-8?B?dUQ4WVhXYWo0REZDdTN2TzVrbXhmU1E4MmxEZmo0UTVDblNvVVh5bTA4aVZI?=
 =?utf-8?B?bjU0Qjc4VjJuaTlkdlk4aFVvWjBuR0daMVpERzdRdE51dUNBTFlaQm5FVHFn?=
 =?utf-8?B?SnBUMFBoYnV0N1BKUW5sY2hOQS9YbDYvcVpWb0pCRFU4SWoyZEpmaFhma2xF?=
 =?utf-8?B?VytSS25DL1duQzRyS3JGcEkvVS9LQ05EQmhaUlFjYTVXdkl3ejIrL1NlK09M?=
 =?utf-8?B?SGk2TnJEQUU3OHNiclJnbTQ0cmVjV1A4eFgzNnZKWitjK3ZFTTRmanNUNnZO?=
 =?utf-8?B?N3hIOW5CTWlyRnN4b042Y2lISnFZaFFaMTZWdXBRWkx3RUdpbndEMVJxVTB1?=
 =?utf-8?B?L2tROHlSMVNaeHVjTmowN1U3ZEkxdkswb0Yydm9LUkMrbVRtaWY3cXNmbFVs?=
 =?utf-8?B?SFQ1WlZvV2UvbDRxcDc3SU5NTWNVamhOTXk5Vy8vdTZMSVRlVE1TM2JMUVpM?=
 =?utf-8?B?TFZ2NnBQTk8wM0FJMFdRZkxTb3ZHeFhtMVQrZHJpMDJrQjUvU2hFL1hkdGgy?=
 =?utf-8?B?UzJHbzBVRG0vKzRGV3VVZmRKQm5MV2V0azVXVnNLVkN5T0Q2eEdDaThZOGlh?=
 =?utf-8?Q?f1kMhEwkNL+0PzHTzIqkd/21x95fvlvwWWQ6s?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <242BEAB695C47D41AF64E88B2B85468D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	FljxJTdkw30Go/vVgG5Dy4Op2jJf+7q1QBRR9pfYKsNmBi+bDBsj6y4O7wwoVZBxQ1U37tYuH0Xj6qSD8379u9Ih6VXXs2mlkAts0PoMFDufC5wkEa7xoEo1C29B6+1tZ2YcU60qJMRc/iEx0WhtL3M0jGaDB3WL346xUjonDE0c6eFd/7iovVXlPNJHjLhLAxXHWQXgrwB8fBNMx7WiC/c9Nn5oWr3lHxPbz6RYca0JTdfaJ65GK+EYNmVL4zu2KHvQXFfpdvbn5b7UbVWwl67ClLRQGi+kXrkZPno/rEn4q09L3+JJWPGhlfKIShtnB36JcH/yKQK2BS/8YVfglQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18da1585-e40d-4b44-5a4c-08de8e7e569d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 17:04:00.2747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSjm6e4D6V8Gm/a6RgyNN1ku5Bcyeaetjx0iDhHfYFjJ9ss4zdNTxNWBmYjq5p1G9KHNTASUWj/5Xwce1izbXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6341
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: djFowKeOcZ7mW3yN3Li1zRqFASbRfKky
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69caad03 cx=c_pps
 a=6wX/tLcgNF/HagpTIcwFsg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=UgJECxHJAAAA:8 a=VnNF1IyMAAAA:8
 a=Jcf7CJWrNI3xS0raN94A:9 a=QEXdDO2ut3YA:10 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEzNiBTYWx0ZWRfX9ol38uW/HJEX
 z1+Q29Vsj/tNZte+8NoSGucnUfbiXV92DIq1YdADH16+lgApDkKkCYThOTcKwZk7D+M/H4lZKjh
 d+h5igxNqvBSeZm7OrUCZc6skv7R5MqoEKWqOWJU3GbDdaGP/AQKGFCaFmSX/zzalXDWSorvRV0
 EiOC721/VFoAXr2IIaMNRU6CEwM9OYYQ4EaTPG1u784uyvJE/m5Lw6ZnBxYAoNFxcq0nevJABiD
 baihgq0z/BW6CA/xubYE01pmaScis5H9Da00C2LDnG+LEkATIRkmLu7eVMn226riQs2Oe4g9is+
 z80Js+PO8TlT9vy2ebLIxTwV8qua4RhpgsHHW2HSqwUjG87E9DezwWJ/WfKLvzhdWLKo9SVwQkI
 txeLR34VQJqeK7+Oy4zf28p1fp2/JVjDR55QzII+jRaIiPNOLPSTbKCgxg4hFhtlr2bJOyrU3/N
 uI+rEUKSTakXU3eUpBA==
X-Proofpoint-ORIG-GUID: 6QYcdpwDuEXnFA8xRjBPo_QJPvGaH_Lr
Subject: RE:  [PATCH] ceph: only d_add() negative dentries when they are
 unhashed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300136
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231258-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ionos.com,gmail.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ionos.com:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6576735F2A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCAyMDI2LTAzLTI3IGF0IDE4OjQ0ICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IE9uIEZyaSwgMjAyNi0wMy0yNyBhdCAxNzoyMyArMDEwMCwgTWF4IEtlbGxlcm1hbm4g
d3JvdGU6DQo+ID4gQ2VwaCBjYW4gY2FsbCBkX2FkZChkZW50cnksIE5VTEwpIG9uIGEgbmVnYXRp
dmUgZGVudHJ5IHRoYXQgaXMgYWxyZWFkeQ0KPiA+IHByZXNlbnQgaW4gdGhlIHByaW1hcnkgZGNh
Y2hlIGhhc2guDQo+ID4gDQo+ID4gSW4gdGhlIGN1cnJlbnQgVkZTIHRoYXQgaXMgbm90IHNhZmUu
ICBkX2FkZCgpIGdvZXMgdGhyb3VnaCBfX2RfYWRkKCkNCj4gPiB0byBfX2RfcmVoYXNoKCksIHdo
aWNoIHVuY29uZGl0aW9uYWxseSByZWluc2VydHMgZGVudHJ5LT5kX2hhc2ggaW50bw0KPiA+IHRo
ZSBobGlzdF9ibCBidWNrZXQuICBJZiB0aGUgZGVudHJ5IGlzIGFscmVhZHkgaGFzaGVkLCByZWlu
c2VydGluZyB0aGUNCj4gPiBzYW1lIG5vZGUgY2FuIGNvcnJ1cHQgdGhlIGJ1Y2tldCwgaW5jbHVk
aW5nIGNyZWF0aW5nIGEgc2VsZi1sb29wLg0KPiA+IE9uY2UgdGhhdCBoYXBwZW5zLCBfX2RfbG9v
a3VwKCkgY2FuIHNwaW4gZm9yZXZlciBpbiB0aGUgaGxpc3RfYmwgd2FsaywNCj4gPiB0eXBpY2Fs
bHkgbG9vcGluZyBvbmx5IG9uIHRoZSBkX25hbWUuaGFzaCBtaXNtYXRjaCBjaGVjayBhbmQNCj4g
PiBldmVudHVhbGx5IHRyaWdnZXJpbmcgUkNVIHN0YWxsIHJlcG9ydHMgbGlrZSB0aGlzIG9uZToN
Cj4gPiANCj4gPiAgcmN1OiBJTkZPOiByY3Vfc2NoZWQgc2VsZi1kZXRlY3RlZCBzdGFsbCBvbiBD
UFUNCj4gPiAgcmN1OiAgICAgICAgIDg3LS4uLi46ICgyMTAwIHRpY2tzIHRoaXMgR1ApIGlkbGU9
M2E0Yy8xLzB4NDAwMDAwMDAwMDAwMDAwMCBzb2Z0aXJxPTI1MDAzMzE5LzI1MDAzMzE5IGZxcz04
MjkNCj4gPiAgcmN1OiAgICAgICAgICh0PTIxMDEgamlmZmllcyBnPTc5MDU4NDQ1IHE9Njk4OTg4
IG5jcHVzPTE5MikNCj4gPiAgQ1BVOiA4NyBVSUQ6IDI5NTI4Njg5MTYgUElEOiAzOTMzMzAzIENv
bW06IHBocC1jZ2k4LjMgTm90IHRhaW50ZWQgNi4xOC4xNy1pMS1hbWQgIzk1MCBOT05FDQo+ID4g
IEhhcmR3YXJlIG5hbWU6IERlbGwgSW5jLiBQb3dlckVkZ2UgUjc2MTUvMEc5REhWLCBCSU9TIDEu
Ni42IDA5LzIyLzIwMjMNCj4gPiAgUklQOiAwMDEwOl9fZF9sb29rdXArMHg0Ni8weGIwDQo+ID4g
IENvZGU6IGMxIGU4IDA3IDQ4IDhkIDA0IGMyIDQ4IDhiIDAwIDQ5IDg5IGZjIDQ5IDg5IGY1IDQ4
IDg5IGMzIDQ4IDgzIGUzIGZlIDQ4IDgzIGY4IDAxIDc3IDBmIGViIDJkIDBmIDFmIDQ0IDAwIDAw
IDQ4IDhiIDFiIDQ4IDg1IGRiIDw3ND4gMjAgMzkgNmIgMTggNzUgZjMgNDggOGQgN2IgNzggZTgg
YmEgODUgZDAgMDAgNGMgMzkgNjMgMTAgNzQgMWYNCj4gPiAgUlNQOiAwMDE4OmZmNzQ1YTcwYzgy
NTM4OTggRUZMQUdTOiAwMDAwMDI4Mg0KPiA+ICBSQVg6IGZmMjZlNDcwMDU0Y2IyMDggUkJYOiBm
ZjI2ZTQ3MDA1NGNiMjA4IFJDWDogMDAwMDAwMDA2ZTk1ODk2Ng0KPiA+ICBSRFg6IGZmMjZlNDgy
NjczNDAwMDAgUlNJOiBmZjc0NWE3MGM4MjUzOWIwIFJESTogZmYyNmU0NThmNzQ2NTVjMA0KPiA+
ICBSQlA6IDAwMDAwMDAwNmU5NTg5NjYgUjA4OiAwMDAwMDAwMDAwMDAwMTgwIFIwOTogOWNkMDhk
OTA5YjkxOWE4OQ0KPiA+ICBSMTA6IGZmMjZlNDU4Zjc0NjU1YzAgUjExOiAwMDAwMDAwMDAwMDAw
MDAwIFIxMjogZmYyNmU0NThmNzQ2NTVjMA0KPiA+ICBSMTM6IGZmNzQ1YTcwYzgyNTM5YjAgUjE0
OiBkMGQwZDBkMGQwZDBkMGQwIFIxNTogMmYyZjJmMmYyZjJmMmYyZg0KPiA+ICBGUzogIDAwMDA3
ZjU3NzA4OTY5ODAoMDAwMCkgR1M6ZmYyNmU0ODJjNWQ4ODAwMCgwMDAwKSBrbmxHUzowMDAwMDAw
MDAwMDAwMDAwDQo+ID4gIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAw
ODAwNTAwMzMNCj4gPiAgQ1IyOiAwMDAwN2Y1NzY0ZGU1MGMwIENSMzogMDAwMDAwYTcyYWJiNTAw
MSBDUjQ6IDAwMDAwMDAwMDA3NzFlZjANCj4gPiAgUEtSVTogNTU1NTU1NTQNCj4gPiAgQ2FsbCBU
cmFjZToNCj4gPiAgIDxUQVNLPg0KPiA+ICAgbG9va3VwX2Zhc3QrMHg5Zi8weDEwMA0KPiA+ICAg
d2Fsa19jb21wb25lbnQrMHgxZi8weDE1MA0KPiA+ICAgbGlua19wYXRoX3dhbGsrMHgyMGUvMHgz
ZDANCj4gPiAgIHBhdGhfbG9va3VwYXQrMHg2OC8weDE4MA0KPiA+ICAgZmlsZW5hbWVfbG9va3Vw
KzB4ZGMvMHgxZTANCj4gPiAgIHZmc19zdGF0eCsweDZjLzB4MTQwDQo+ID4gICB2ZnNfZnN0YXRh
dCsweDY3LzB4YTANCj4gPiAgIF9fZG9fc3lzX25ld2ZzdGF0YXQrMHgyNC8weDYwDQo+ID4gICBk
b19zeXNjYWxsXzY0KzB4NmEvMHgyMzANCj4gPiAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdm
cmFtZSsweDc2LzB4N2UNCj4gPiANCj4gPiBUaGlzIGlzIHJlYWNoYWJsZSB3aXRoIHJldXNlZCBj
YWNoZWQgbmVnYXRpdmUgZGVudHJpZXMuICBBIENlcGggbG9va3VwDQo+ID4gb3IgYXRvbWljX29w
ZW4gY2FuIGJlIGhhbmRlZCBhIG5lZ2F0aXZlIGRlbnRyeSB0aGF0IGlzIGFscmVhZHkgaGFzaGVk
LA0KPiA+IGFuZCBmcy9jZXBoL2Rpci5jIHRoZW4gaGl0cyBvbmUgb2YgdHdvIHBhdGhzIHRoYXQg
aW5jb3JyZWN0bHkgYXNzdW1lDQo+ID4gIm5lZ2F0aXZlIiBhbHNvIG1lYW5zICJ1bmhhc2hlZCI6
DQo+ID4gDQo+ID4gICAtIGNlcGhfZmluaXNoX2xvb2t1cCgpOg0KPiA+ICAgICAgIE1EUyByZXBs
eSBpcyAtRU5PRU5UIHdpdGggbm8gdHJhY2UNCj4gPiAgICAgICAtPiBkX2FkZChkZW50cnksIE5V
TEwpDQo+ID4gDQo+ID4gICAtIGNlcGhfbG9va3VwKCk6DQo+ID4gICAgICAgbG9jYWwgRU5PRU5U
IGZhc3QgcGF0aCBmb3IgYSBjb21wbGV0ZSBkaXJlY3Rvcnkgd2l0aCBzaGFyZWQgY2Fwcw0KPiA+
ICAgICAgIC0+IGRfYWRkKGRlbnRyeSwgTlVMTCkNCj4gPiANCj4gPiBCb3RoIHBhdGhzIGNhbiB0
aGVyZWZvcmUgcmUtYWRkIGFuIGFscmVhZHktaGFzaGVkIG5lZ2F0aXZlIGRlbnRyeS4NCj4gPiAN
Cj4gPiBDZXBoIGFscmVhZHkgdXNlcyB0aGUgY29ycmVjdCBwYXR0ZXJuIGVsc2V3aGVyZTogY2Vw
aF9maWxsX3RyYWNlKCkgb25seQ0KPiA+IGNhbGxzIGRfYWRkKGRuLCBOVUxMKSBmb3IgYSBuZWdh
dGl2ZSBudWxsLWRlbnRyeSByZXBseSB3aGVuIGRfdW5oYXNoZWQoZG4pDQo+ID4gaXMgdHJ1ZS4N
Cj4gPiANCj4gPiBGaXggYm90aCBmcy9jZXBoL2Rpci5jIHNpdGVzIHRoZSBzYW1lIHdheTogb25s
eSBjYWxsIGRfYWRkKCkgZm9yIGENCj4gPiBuZWdhdGl2ZSBkZW50cnkgd2hlbiBpdCBpcyBhY3R1
YWxseSB1bmhhc2hlZC4gIElmIHRoZSBuZWdhdGl2ZSBkZW50cnkNCj4gPiBpcyBhbHJlYWR5IGhh
c2hlZCwgbGVhdmUgaXQgaW4gcGxhY2UgYW5kIHJldXNlIGl0IGFzLWlzLg0KPiA+IA0KPiA+IFRo
aXMgcHJlc2VydmVzIHRoZSBleGlzdGluZyBiZWhhdmlvciBmb3IgdW5oYXNoZWQgZGVudHJpZXMg
d2hpbGUNCj4gPiBhdm9pZGluZyBkX2hhc2ggbGlzdCBjb3JydXB0aW9uIGZvciByZXVzZWQgaGFz
aGVkIG5lZ2F0aXZlcy4NCj4gPiANCj4gPiBGaXhlczogMjgxN2IwMDBiMDJjICgiY2VwaDogZGly
ZWN0b3J5IG9wZXJhdGlvbnMiKQ0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4g
U2lnbmVkLW9mZi1ieTogTWF4IEtlbGxlcm1hbm4gPG1heC5rZWxsZXJtYW5uQGlvbm9zLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZnMvY2VwaC9kaXIuYyB8IDYgKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL2ZzL2NlcGgvZGlyLmMgYi9mcy9jZXBoL2Rpci5jDQo+ID4gaW5kZXggYmFjOWNmYjZiOTgy
Li4yN2NlOWU1NWU5NDcgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvY2VwaC9kaXIuYw0KPiA+ICsrKyBi
L2ZzL2NlcGgvZGlyLmMNCj4gPiBAQCAtNzY5LDcgKzc2OSw4IEBAIHN0cnVjdCBkZW50cnkgKmNl
cGhfZmluaXNoX2xvb2t1cChzdHJ1Y3QgY2VwaF9tZHNfcmVxdWVzdCAqcmVxLA0KPiA+ICAJCQkJ
ZF9kcm9wKGRlbnRyeSk7DQo+ID4gIAkJCQllcnIgPSAtRU5PRU5UOw0KPiA+ICAJCQl9IGVsc2Ug
ew0KPiA+IC0JCQkJZF9hZGQoZGVudHJ5LCBOVUxMKTsNCj4gPiArCQkJCWlmIChkX3VuaGFzaGVk
KGRlbnRyeSkpDQo+ID4gKwkJCQkJZF9hZGQoZGVudHJ5LCBOVUxMKTsNCj4gPiAgCQkJfQ0KPiA+
ICAJCX0NCj4gPiAgCX0NCj4gPiBAQCAtODQwLDcgKzg0MSw4IEBAIHN0YXRpYyBzdHJ1Y3QgZGVu
dHJ5ICpjZXBoX2xvb2t1cChzdHJ1Y3QgaW5vZGUgKmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5
LA0KPiA+ICAJCQlzcGluX3VubG9jaygmY2ktPmlfY2VwaF9sb2NrKTsNCj4gPiAgCQkJZG91dGMo
Y2wsICIgZGlyICVsbHguJWxseCBjb21wbGV0ZSwgLUVOT0VOVFxuIiwNCj4gPiAgCQkJICAgICAg
Y2VwaF92aW5vcChkaXIpKTsNCj4gPiAtCQkJZF9hZGQoZGVudHJ5LCBOVUxMKTsNCj4gPiArCQkJ
aWYgKGRfdW5oYXNoZWQoZGVudHJ5KSkNCj4gPiArCQkJCWRfYWRkKGRlbnRyeSwgTlVMTCk7DQo+
ID4gIAkJCWRpLT5sZWFzZV9zaGFyZWRfZ2VuID0gYXRvbWljX3JlYWQoJmNpLT5pX3NoYXJlZF9n
ZW4pOw0KPiA+ICAJCQlyZXR1cm4gTlVMTDsNCj4gPiAgCQl9DQo+IA0KPiBNYWtlcyBzZW5zZS4N
Cj4gDQo+IFJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJt
LmNvbT4NCj4gDQo+IExldCBtZSBydW4geGZzdGVzdHMgZm9yIHRoZSBwYXRjaCB0byBkb3VibGUg
Y2hlY2sgdGhhdCBldmVyeXRoaW5nIHdvcmtzIHdlbGwuDQo+IA0KDQpJIGhhZCBtdWx0aXBsZSB4
ZnN0ZXN0cyBpc3N1ZXMgZHVyaW5nIGxhc3QgcnVuLiBNb3N0IHByb2JhYmx5LCBpdCB3YXMgc29t
ZQ0KZ2xpdGNoIG9uIG15IHNpZGUgb3IgaW5jb25zaXN0ZW50IGJ1aWxkLiBJIG5lZWQgdG8gcmVw
ZWF0IHRoZSB4ZnN0ZXN0cyBydW4gd2l0aA0KdGhlIHBhdGNoLg0KDQpUaGFua3MsDQpTbGF2YS4N
Cg==

