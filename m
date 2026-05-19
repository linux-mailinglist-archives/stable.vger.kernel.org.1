Return-Path: <stable+bounces-249685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHUwHYO+DGqJlgUAu9opvQ
	(envelope-from <stable+bounces-249685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:48:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E88E7584523
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 558C3306DEC4
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9113B4EB5;
	Tue, 19 May 2026 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hypZ5Csd"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4781A39C64E;
	Tue, 19 May 2026 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220074; cv=fail; b=ge5eTVXj+gSkm9AFpO73mxiLQn34Ku/yBg3EgKC0BEBBA3zi+wIBz1K/UsyLYSZcWUlYcEDjCI53tN4yAU8cXFDIgBW3jYAzQwoWiXNgB9Fed2XDqe/28wQLn1wp9DooERRUHYpAJi/EiTe/2uAo1wUl/b0DZGqh+Ui19c/tkUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220074; c=relaxed/simple;
	bh=hVsPSWEC4w4azQWU3OjscwHvY35z9SWJAIJjyKpWN/U=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=tWEyDl6I8t9cdr3RgIkCKe0ug6hIgm2eDVSoMghcc74lT1SVMF1RN2MW0yA5GHrEGmUwaA+XPsMoX2ui8b+x5IS7fSByFD20pqJ865sWhkwcPHVJbo3tcV4yG+k05EViV4QYcbG/q07fi/QdUOW56nliaXmDnRyGN3yq2Um80bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hypZ5Csd; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JEVxVU1734549;
	Tue, 19 May 2026 19:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=hVsPSWEC4w4azQWU3OjscwHvY35z9SWJAIJjyKpWN/U=; b=hypZ5Csd
	Puopgl45xrnJuhQOgQO5mzXhTnWGCZiELH13Ujwwf+OXSY+uFX5yYcp6OYHo8I6w
	dLDzLXbq+m/VBYF2g7hAASaNX/U3hCY1y8x1q8Z2xks3+OAizfO6YzckUk3QqsOX
	G70jY/7pT2/CR2aUNR0JAjYwObjtPWuQPmU1lZf3XFtbWv7DX3d9g/eykSaszB9X
	nGY6ctjJ3ggxJeLh3fxw12lEf/TaJ9klmoHSfsD3EA9o5a2/5CjxYjlXrSXeNLIL
	qCZ1uQx9SYKlJLSBc5L7ueK2P+dp89qwhfqT1o4yqkfFGv1Ci4nYTkw8mhejeOBw
	kUSKQzTamVY50A==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88e2bh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 19:47:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RS5HbCyFBEyg2ZiLzY9Sq/t440RK1p6gORBBGzoSQeUbq/qs86ama9aqs6WnFDoSmUZr7ImTXh8+/pacJzaR5FHr7/WCTb2fq9YHMsZETKinTqaJfxN40zlUa/RkQEIgqqLowtxx7iSMBUkK3dqYDmWjeZ0WFnn3fx7Rh/xC7uYwD1LZjKu1dX3yfVXfB7YLRQ02vifbCSzqvhWl9sxGQipcMIIdKhG3cx5SoWd1M2YbBiGG153UZJ57H1d5GV6LGEKs7EwHITBI+A3CY8YAyx4pvNthfyj4xZ5kawXHsOb5SDHzRUHFwp+d0oY68FYSFPK2ZPGV3SCCuCmz2epUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVsPSWEC4w4azQWU3OjscwHvY35z9SWJAIJjyKpWN/U=;
 b=XtW4Kj3jV6sQFYv5Ivq6oG8LchG+DBIa1rkdC8zz1RXTCjfsSFNRr7wPxOk0acohz+yx53jn2po3XOT6c1PQRNOnotbWpcwgmclGON5aqK9n48zbbgxBrLNzzUs29Q9eRdauFw44zrukhlmNvmOFyw9GSA5huKfXYq5GR/czQoTWQIM7PxVySt7IsauvQzk5nMd6czDHtegFno9J9rcOSSnN41kxcLSP6P/W6q5hZ5ZJoFprUbbZyWqEB5dhXmbhRi/w3OX79tejw8gG3Hpaa7oBzd/+9NTEOqdb4CKbKgU7pzfcsTYWhCp4KyHXtVg4uw67ERdnq5/SKrOqvDUIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB5393.namprd15.prod.outlook.com (2603:10b6:208:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Tue, 19 May
 2026 19:47:47 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 19:47:47 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "michael.bommarito@gmail.com"
	<michael.bommarito@gmail.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] ceph: bound num_split_inos and
 num_split_realms in ceph_handle_snap()
Thread-Index: AQHc54ZBaOnlBd82jUmU2+tyEOGvNbYVwa2A
Date: Tue, 19 May 2026 19:47:46 +0000
Message-ID: <6176a49943969a3948b21bfa98c98aa69c0b6c16.camel@ibm.com>
References: <20260519113017.1851462-1-michael.bommarito@gmail.com>
In-Reply-To: <20260519113017.1851462-1-michael.bommarito@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB5393:EE_
x-ms-office365-filtering-correlation-id: b4c174d0-346a-4553-0408-08deb5df8036
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|11063799006|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 ZEgK7YV3uiF9VzkVMORrEvOEgDcbkk60fGdKUexW5zRhNGDrvXhI0IqARi9Mm3/jWIOSAJo32tU87l6k87rouObLDyLQtd1TBZ39nC2ZQy4+4EmPvhkueWHJninMO3Fy5nlFN8QUpDZXHD2PhVM0OdrLsunBPtr5yJTuRZSBE4OFevcJoB4CBp6EZfOFhBlK5XgyLSRwXfTqau3oU9+McI5XUFpD7tPXL42Hxhknhpk5grv1QOLbdUIXMwpKzd4yWKjhwtLWahKmrrN/9wjQ+2tg77s6QMSM0QStkGTym/eKqKEQGa5EN3ER9RpC2IsdW0I0De2HALHI5lUCoNIbP+BFSu6GbN9QLL6pfs7lpmbMaUkQ2pjD1BIVrTVq9ZLsUy/Qnz04T7UkbpXKjHaTu2vKApVSgVvWrDqvW4TFaDUohS6D9PFx+fn4SiAbPW4fSxfzxasnbPuF5WbhuuPoaqRCxQK5OowTUPmh+ne6Qs20DzHyHRDtC5mvDZHhWLQJu2/h3rsgt6NG4KPUsjmTLneHm8KDWrMyLQUeShgvvSPaOP0I3lGC8t7BFrZ3y2vOOT5gVAcKciqsR4BOzxceJmxsRtyxoas0MjtOrhceUPzzCnvw9Q15c6RaQQ5kdYIH2pZNhJ0+8F3xanCI7RKIXEfAAiWSw5YQlu/ummSwRpDqNLSlz3a/8Cr/aDddOYe9B0Hq1tLdpcfHtAkju8hzvZXc9mEYMzpkezVOL+9BTKLKugqfd0CC8SQODZzNTLY8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(11063799006)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aUZVeXZKcmpweDl5Q093ejNZZTRsUnRQOHVXSmpiZXM0dWVudlA3Vzc0V1dL?=
 =?utf-8?B?d2ZEM0h4SWd6OUcyakpzcVlJTXBESG1sK29MZno1M3JWdWhveDRtRGx2dDJ0?=
 =?utf-8?B?NTFiNGF0Nzd4ZTNyRDJVOEJ6NVVyTWRxRjdidFhhZ0dnMlhGSm9zbUdkR2tW?=
 =?utf-8?B?QXh2ZHN1YzVFc0FDU1dRUXU1SWdLNlprb3ZFRWF4bHV4Uk1mV1VCZXp0QjNZ?=
 =?utf-8?B?S0JtL0Z6UG1kaEd1Wm1SOXVGMXIvM3hnVElEWGFvejhjRlJodXBSNGdPeVE2?=
 =?utf-8?B?Q0VUTnBKbXdFSmF1VGJPaVo0TVdkTFY0YTQyRkJHUXlEQXdXa0VtV2srVVJa?=
 =?utf-8?B?L1pyOW9UdmsrcjR0V3pxTUE0aHA4MFRic0NkTFNLR1h4dUpPcFFkbHJkV3Vu?=
 =?utf-8?B?endCd2pYWGoyYk9GU2ZuVVMvY1BIN2lKNDBOYlhMZk92ZlNlVEVzK2x4THp6?=
 =?utf-8?B?RkNPL3M2Y05Za1EwUXBjMEVIL1Q5d1QzYVBxMFZrRVUyR2t2TXRmdFNSa0hi?=
 =?utf-8?B?QWNYRmM5bVBVVEJrRUZyLytJVEdmS2FvQXg5cW9LcCsvNHpNcnZsQ1hCWk9S?=
 =?utf-8?B?Qkhpa0d3a3F0TFhGWTRFSVNkOEJMRE9mS25ZcUZBeWorZWNaRVI2K09zYm5R?=
 =?utf-8?B?WnJQUzl6WG1jb2x6WEs2NmxEaVJhejFIYUhmaTlOOW5QM29RL1J1bUdmYjY0?=
 =?utf-8?B?cTVqYS9VUmdpekFxN2NjdVdGdWQwdWFwOWpRdzZVTzlHUjhVRnF6MnlkYndq?=
 =?utf-8?B?VTFCQkk1OEJDb3BVWlYyaGZySG1tTTI1NGxuWUV0QVB3cW1jaGJaNGkzUDdT?=
 =?utf-8?B?U1VXMkR1bzBjZ2wwQWJrSENiVVNmUEd6YkYrb3A3eFBXQTZoVnNnSlF2a21F?=
 =?utf-8?B?bnZQMzROb3YvV2RVeW9oT1BzcHl5bkpWeWJac011dVVvSEN1d0srQUNZNGpp?=
 =?utf-8?B?dDBnSDgxN2tYUTlrK1JNRUYvRnFPRzV5SDlhKzlKenBjVTlDZ2p3NEk1T3I1?=
 =?utf-8?B?Yyt2bGhUSWRxNm1NSTVpeUZaK3pvV3ZrVEQ1SVlyQ3Qzc1FrZWtuelBqanZW?=
 =?utf-8?B?US9KaVVmL3BTK0d0bWJKSldhMnBmbE85Y0ZzcmFZMXFDbkoyZlMvZlFRRFNK?=
 =?utf-8?B?NW1xVGo4aGR3Yy80dXRsRnExN3VjYlk0eWd4NXFuMDJLZ0RxZXhFbk9WdUhh?=
 =?utf-8?B?RGJjNjQxQzV1NUhyOHNKUk9rNGtDZzMzb0ltUGw0NFFxQ3djNTg3NExHTVdJ?=
 =?utf-8?B?WTNHcnVKQmkyZmQ0eDZzZVBoTEsvVXJhVnhwMWZWVklBVWNhcU1rWDdwZ0VZ?=
 =?utf-8?B?ZHFPRERYQWs1Q29ZMzR3M0pvb0tWNVdnMEdST0pBa0o2RGp0Uy9TbjFnSU5a?=
 =?utf-8?B?NXpQeWlteG9aSkk3THB0bVkxKzUyTkszY1V5WGFvdFdwVlpyQzErSjVmVWtw?=
 =?utf-8?B?S0RuTXdwTDdrM2p0bVp6WFc1azdwb0gzUGRxUWdEcllINkFmbWRybW4vZFVG?=
 =?utf-8?B?MUNOcVpEMTVzZ2hYN3dnL1d0Sm0zRU5WL2x5SjhBeGNNUWQ2ZkNMaGRuNk4v?=
 =?utf-8?B?bldZblNWU3BoWTdwc2F4bnJxKzZIR3FpQmg3MEhsRCt1QUdrWDNIWkRwV2hU?=
 =?utf-8?B?M3pUUEdEcEk5VVJrWGxheU8yLzFiOHpWZ1JkVlI5MlVBTmJIRTluV1l4dlJC?=
 =?utf-8?B?dndGeUxiaElXalREU09BZEt1cmlUdHpkMC8xRXdRcDlrR0xacWhLZTlSdEk1?=
 =?utf-8?B?RkNVSXA4ayszOEdHVmtQTE5hcHZoU2xNN3RDdy9qMDZjbUFmdzNJZFI5YjdR?=
 =?utf-8?B?NVBZV2xKYnR4eWNKdFlIOVVJbkNiVlJHYkd6R2ltWVRMV3lYSzRtcWFoQ0FD?=
 =?utf-8?B?ZDJ2OXE5VERVR3NaUWU3Q0pVaEFyUFpBMlI3NnBYS0xaUjRBejRIVm1IdmVr?=
 =?utf-8?B?d2VQVjR4TTBlOWFQWUNqa0hLSE00YVRralZ3RDVKdzlOb1gxN1dNTUwxS2Vl?=
 =?utf-8?B?b0NxSWpuL3p0eFNyNWllaFdBSElhRjJEU1RNRkNFQkRxazBUMG84TS81WDQr?=
 =?utf-8?B?QWxTbGdiNzJqZ3Y5dno1K3g0YmZVNlRFakZ6QmNIVWZQL1RaeTNXMnA3ZXRN?=
 =?utf-8?B?SklSNnZUTjRYRWMyUTBlN25ZZ0oyc1BwVTdMMmNCelhqUSt6VG85eCsxZnN0?=
 =?utf-8?B?SVAvTU02b2U0RyswNVR6aHhwTVFBT2pBNU1Mc3BzUGJjTTdaSzdPZDkydE8z?=
 =?utf-8?B?aURpOFI5ZDBkWVppQXNQY24vTEhGZDFINHBIU0U5QThaRzJ1cUZGKzFMb3Iw?=
 =?utf-8?B?RkljdVBXS0djS3dlaDJBeFVNNUU4ZHNxTElvYUFsaCtMeVovQW12MHYvOWFZ?=
 =?utf-8?Q?tODXGMD/YqOwmAqRK19cr92RVedPNa2zVPfYl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <156D2B13DBEE1E4E8AC5FDA4DB8BC3EE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	hADcaMpptjoFOqsEn2HuMxl5KYUvPvI0ZmYSf8KfHET6dkHQG5efWX6ss/J/txGnOZYzlbjwMLMgsrtfKKXYLp+sI+pv+TidwvWff0NNqkhXSLLAOAooJyShIAwLvL1OmzHrbXBcSiHdOICzb6buX0MWloVuRaLNtShZP/kMHhq/JlzI8pLHnCgM07Iz9cfwSoNIFupWEhQp1N65jMFHUFece+k1xvn2CqwPQs6SpMEye7RhyYooUw1V4DkexkQayNi388CoBYKeGe/5VPp0bdUqyZ4pUO6xKLsmqdhEkmQdId9TacRXF5UVwVoI+1fEI141XmglWi/fD0n8jhyExw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c174d0-346a-4553-0408-08deb5df8036
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 19:47:46.6107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjNA5UDOSkyTc15nmNbp0Au5gqL9feZYyFQrZpmwxi9i760DpP41wgBbj+zE7S+/KXOwwKU4S1QdsSp4MEfGUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5393
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 0IlM4US3ikXSupOKkkfS33gXPRxSDzmt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE5NiBTYWx0ZWRfXzgbnQWAznIUo
 UsJ9bA8/Gy1YYNUKOG/TwT+wDiruRSVghgmJBQYmJ+0Yv0cPMTFc4+P/oT881aLXIJJzYhtB11u
 08ibWYY27IdrvLlj27MHeQTXRv7+d4viJTBSVDUmWINUNNiA07/8gslRU/rIE0Zg2x2GIzrJotQ
 nCE2LB8WdD1zYCAUweqNnEO5qgJONYqH8M2/PQrx0vp01TMFQntpleYFymyTkFqYH4sDG4OPnQ+
 SpBusryQbIi94aLGLR67APZ2Hnvb7M2bCgr90WzXSaBHc0Bt/RfvakNSRZbmR0y8osrqLixNOMA
 rh6y2V+yxXBfC4FXNg06pa+B1Ae00u087JTAy4eZSNDfVL3M6ku3qbvsCMFWm6vxPS956ZN6fNc
 kqUMQ6S48TzRetalgspcVSFvcgFw/Ns8crDtww0i0RbR3aQgN21VwciGDBvHv61OivpdinaXlDE
 laW9y20+ZP2W2USfNhQ==
X-Proofpoint-GUID: KtEt7kyJGamzqBNCRREPKZNklqo3q_ww
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0cbe66 cx=c_pps
 a=xx7W88v/Jz1hHwbI4fXbew==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=3imFcao44g1R_zZ5ywYA:9 a=QEXdDO2ut3YA:10
Subject: Re:  [PATCH] ceph: bound num_split_inos and num_split_realms in
 ceph_handle_snap()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190196
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249685-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,dubeyko.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[checkpatch.pl:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E88E7584523
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTA1LTE5IGF0IDA3OjMwIC0wNDAwLCBNaWNoYWVsIEJvbW1hcml0byB3cm90
ZToNCj4gQSBwZWVyIHRoYXQgY2FuIGRlbGl2ZXIgYSBDRVBIX01TR19DTElFTlRfU05BUCB0byB0
aGUga2VybmVsIENlcGhGUw0KPiBjbGllbnQgKGEgY29tcHJvbWlzZWQgb3IgbWFsaWNpb3VzIE1E
Uywgb3IgYW4gYXR0YWNrZXIgd2hvIGhhcw0KPiBmb3JnZWQvcmVwbGF5ZWQgYSBjZXBoeCBzZXNz
aW9uIG9uIHRoZSBjbHVzdGVyIG5ldHdvcmspIGNhbiBjYXVzZSBhbg0KPiBvdXQtb2YtYm91bmRz
IHNsYWIgcmVhZCBpbiBjZXBoX3VwZGF0ZV9zbmFwX3RyYWNlKCkgYnkgc2VuZGluZw0KPiBudW1f
c3BsaXRfaW5vcyBvciBudW1fc3BsaXRfcmVhbG1zIGFzIGEgc21hbGwgbmVnYXRpdmUgX19sZTMy
Lg0KPiBjZXBoX2hhbmRsZV9zbmFwKCkgcGFyc2VzIGJvdGggY291bnRzIGludG8gc2lnbmVkIGlu
dCBhbmQgdGhlbg0KPiBhZHZhbmNlcyB0aGUgZGVjb2RlIHBvaW50ZXIgd2l0aCBgcCArPSBzaXpl
b2YodTY0KSAqIG51bV9zcGxpdF9pbm9zYDsNCj4gdGhlIG11bHRpcGxpY2F0aW9uIGlzIGluIHNp
emVfdCwgc28gdGhlIHNpZ25lZCBvcGVyYW5kIGlzIHdpZGVuZWQNCj4gbW9kdWxvIDIqKjY0IGFu
ZCBhIHdpcmUgdmFsdWUgbGlrZSAtMzIgcHJvZHVjZXMgYW4gYXR0YWNrZXItY2hvc2VuDQo+IGJ5
dGUgb2Zmc2V0IHRoYXQgd2Fsa3MgcCBiYWNrd2FyZHMgaW50byB0aGUgc2xhYi4gVGhlIHN1YnNl
cXVlbnQNCj4gY2VwaF9kZWNvZGVfbmVlZCgmcCwgZSwgc2l6ZW9mKCpyaSksIGJhZCkgcGFzc2Vz
IChlbmQgLSBwIGlzIGh1Z2UpLA0KPiByaSA9IHAsIGFuZCB0aGUgbmV4dCA0LWJ5dGUgcmVhZCBp
bnNpZGUgY2VwaF91cGRhdGVfc25hcF90cmFjZSgpIGlzDQo+IHBlcmZvcm1lZCBmcm9tIGF0dGFj
a2VyLXBvc2l0aW9uZWQgbWVtb3J5LiBUaGUgc2FtZSBhcml0aG1ldGljIGFuZA0KPiB0aGUgc2Ft
ZSBwb2ludGVyIGhhbmQtb2ZmIGV4aXN0IGluIHRoZSBub24tc3BsaXQgYnJhbmNoLg0KPiANCj4g
UHJvbW90ZSBudW1fc3BsaXRfaW5vcyBhbmQgbnVtX3NwbGl0X3JlYWxtcyB0byB1MzIgdG8gbWF0
Y2ggdGhlDQo+IG9uLXdpcmUgX19sZTMyIGZpZWxkcywgY29tcHV0ZSBlYWNoIGFycmF5J3MgYnl0
ZSBsZW5ndGggd2l0aA0KPiBhcnJheV9zaXplKCkgc28gYSBzaXplX3Qgb3ZlcmZsb3cgc2F0dXJh
dGVzIHRvIFNJWkVfTUFYIGluc3RlYWQgb2YNCj4gd3JhcHBpbmcsIHN1bSB0aGUgdHdvIGxlbmd0
aHMgd2l0aCBjaGVja19hZGRfb3ZlcmZsb3coKSwgYW5kIHZlcmlmeQ0KPiB0aGUgdG90YWwgYWdh
aW5zdCB0aGUgcmVtYWluaW5nIGZyb250LWJ1ZmZlciBsZW5ndGggYmVmb3JlIGFueQ0KPiBwb2lu
dGVyIGJ1bXAuIFJlLXVzZSB0aGUgdmFsaWRhdGVkIGJ5dGUgY291bnRzIGZvciB0aGUgYnVtcHMg
aW4gYm90aA0KPiB0aGUgc3BsaXQgYW5kIG5vbi1zcGxpdCBicmFuY2hlcy4NCj4gDQo+IFRoZSBN
RFMgaXMgYW4gYXV0aGVudGljYXRlZCBwZWVyIHVuZGVyIGNlcGh4LCBidXQgdGhlIGtlcm5lbCBj
bGllbnQNCj4gaXMgc3RpbGwgZXhwZWN0ZWQgdG8gdmFsaWRhdGUgbWV0YWRhdGEgaXQgYWNjZXB0
cyBvdmVyIHRoZSB3aXJlOw0KPiB0aGlzIGhhcmRlbnMgdGhlIGlucHV0LXZhbGlkYXRpb24gYm91
bmRhcnkgdGhhdCBzbmFwLW1lc3NhZ2UgZGVjb2RlDQo+IGNyb3NzZXMuDQo+IA0KPiBGaXhlczog
OTYzYjYxZWIwNDFlOCAoImNlcGg6IHNuYXBzaG90IG1hbmFnZW1lbnQiKQ0KPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiBBc3Npc3RlZC1ieTogQ2xhdWRlOmNsYXVkZS1vcHVzLTQtNw0K
DQpJIGFtIG5vdCBjb21wbGV0ZWx5IHN1cmUgdGhhdCBpdCdzIGdvb2QgdG8gbWVudGlvbiBpdC4g
RG8gd2UgaGF2ZSBmaW5hbCBwb2xpY3kNCmFjY2VwdGVkPw0KDQo+IFNpZ25lZC1vZmYtYnk6IE1p
Y2hhZWwgQm9tbWFyaXRvIDxtaWNoYWVsLmJvbW1hcml0b0BnbWFpbC5jb20+DQo+IC0tLQ0KPiBS
ZXByb2R1Y2VkIG9uIHg4Nl82NCBRRU1VL0tWTSwgS0FTQU5fSU5MSU5FIGdlbmVyaWMsIHR3byB3
YXlzOg0KPiANCj4gICAtIEluLXRyZWUgaGFybmVzcyB0aGF0IGFsbG9jYXRlcyBhbiB1cHN0cmVh
bSBzdHJ1Y3QgY2VwaF9tc2cgdmlhDQo+ICAgICBjZXBoX21zZ19uZXcoKSwgd3JpdGVzIG51bV9z
cGxpdF9pbm9zID0gKHUzMiktMzIsDQo+ICAgICBudW1fc3BsaXRfcmVhbG1zID0gMCwgb3AgPSBD
RVBIX1NOQVBfT1BfVVBEQVRFIGludG8gdGhlIGZyb250DQo+ICAgICBidWZmZXIsIGFuZCBjYWxs
cyBjZXBoX2hhbmRsZV9zbmFwKCZtZHNjLCAmc2Vzc2lvbiwgbXNnKQ0KPiAgICAgZGlyZWN0bHku
DQo+IA0KPiAgIC0gRW5kLXRvLWVuZCBvdmVyIGEgcmVhbCBUQ1AgY29ubmVjdGlvbiBmcm9tIGEg
cmVhbCBjZXBoLW1kcw0KPiAgICAgZGFlbW9uIHRvIHRoZSBrZXJuZWwgQ2VwaEZTIGNsaWVudCwg
d2l0aCBudW1fc3BsaXRfaW5vcw0KPiAgICAgcmV3cml0dGVuIHRvICh1MzIpLTMyIGluIHRoZSBm
cm9udCBidWZmZXIgYW5kIHRoZSBtZXNzZW5nZXINCj4gICAgIHYxIGZvb3Rlci5mcm9udF9jcmMg
cmVjb21wdXRlZCBzbyB0aGUga2VybmVsIGxpYmNlcGggcmVjZWl2ZQ0KPiAgICAgcGF0aCBhY2Nl
cHRzIHRoZSBtZXNzYWdlLiBUaGUgS0FTQU4gcmVwb3J0IGZpcmVzIGZyb20gdGhlDQo+ICAgICB0
Y3BfcmVjdm1zZyBzb2Z0aXJxIHBhdGggdGhyb3VnaCBjZXBoX2hhbmRsZV9zbmFwKzB4MzQ1IGlu
dG8NCj4gICAgIGNlcGhfdXBkYXRlX3NuYXBfdHJhY2UrMHgyM2JmLCBjb25maXJtaW5nIHRoZSBi
dWcgaXMgcmVhY2hlZA0KPiAgICAgdmlhIHRoZSBub3JtYWwgTURTLT5jbGllbnQgcmVjZWl2ZSBw
YXRoIGFuZCBub3Qgb25seSBieQ0KPiAgICAgZGlyZWN0IGhhcm5lc3MgaW52b2NhdGlvbi4NCj4g
DQo+IEEgc3RvY2sgdjcuMS1yYzMga2VybmVsIHByb2R1Y2VzOg0KPiANCj4gICBCVUc6IEtBU0FO
OiBzbGFiLW91dC1vZi1ib3VuZHMgaW4gY2VwaF91cGRhdGVfc25hcF90cmFjZSsweDIzYmYvMHgz
MWEwDQo+ICAgUmVhZCBvZiBzaXplIDQgYXQgYWRkciBmZmZmODg4MDAxMmJlMWY4IGJ5IHRhc2sg
aW5pdC8xDQo+ICAgICBjZXBoX3VwZGF0ZV9zbmFwX3RyYWNlKzB4MjNiZi8weDMxYTANCj4gICAg
ID8gY2VwaF9oYW5kbGVfc25hcCsweDMxMi8weDkwMA0KPiAgICAgY2VwaF9oYW5kbGVfc25hcCsw
eDM0NS8weDkwMA0KPiAgIFRoZSBidWdneSBhZGRyZXNzIGlzIGxvY2F0ZWQgMjQ4IGJ5dGVzIHRv
IHRoZSByaWdodCBvZg0KPiAgICBhbGxvY2F0ZWQgMjU2LWJ5dGUgcmVnaW9uIFtmZmZmODg4MDAx
MmJlMDAwLCBmZmZmODg4MDAxMmJlMTAwKQ0KPiANCj4gV2l0aCB0aGlzIHBhdGNoIGFwcGxpZWQs
IHRoZSBzYW1lIHRyaWdnZXIgKGJvdGggdmlhIHRoZSBoYXJuZXNzDQo+IGFuZCB2aWEgdGhlIHdp
cmUgcGF0aCkgaGl0cyB0aGUgbmV3IHZhbGlkYXRvcidzIGdvdG8gYmFkIHBhdGgsDQo+IGxvZ3Mg
ImNvcnJ1cHQgc25hcCBtZXNzYWdlIGZyb20gbWRzMCIsIGNhbGxzIGNlcGhfbXNnX2R1bXAoKSwg
YW5kDQo+IHJldHVybnMgY2xlYW5seSB3aXRoIG5vIEtBU0FOIHJlcG9ydC4gSGFybmVzcyBhbmQg
d2lyZS1pbmplY3Rpb24NCj4gc2NyaXB0cyBhdmFpbGFibGUgb24gcmVxdWVzdC4NCj4gDQo+IFRo
ZSBrZXJuZWwgc2hpcHMgbm8gZnMvY2VwaCBzZWxmdGVzdHMgYW5kIG5vIGNlcGggS1VuaXQgbW9k
dWxlIHRoYXQNCj4gZXhlcmNpc2VzIGNlcGhfaGFuZGxlX3NuYXAsIHNvIG5vIGluLXRyZWUgc2Vs
ZnRlc3QgZGVsdGEgdG8gcmVwb3J0Lg0KDQpXZSBpbnRyb2R1Y2VkIHRoZSBzZWxmLXRlc3RzIHJl
Y2VudGx5LiBBbmQgeW91IGFyZSB3ZWxjb21lZCB0byBhZGQgS1VuaXQgYmFzZWQNCnVuaXQtdGVz
dHMuDQoNCj4gDQo+IGZzL2NlcGgvc25hcC5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9zbmFwLmMgYi9mcy9jZXBoL3NuYXAuYw0K
PiBpbmRleCA1MmI0YzI2ODRmOTIyLi43YzQ0ODdlYjI3MDhhIDEwMDY0NA0KPiAtLS0gYS9mcy9j
ZXBoL3NuYXAuYw0KPiArKysgYi9mcy9jZXBoL3NuYXAuYw0KPiBAQCAtMTAyNyw5ICsxMDI3LDEw
IEBAIHZvaWQgY2VwaF9oYW5kbGVfc25hcChzdHJ1Y3QgY2VwaF9tZHNfY2xpZW50ICptZHNjLA0K
PiAgCXZvaWQgKnAgPSBtc2ctPmZyb250Lmlvdl9iYXNlOw0KPiAgCXZvaWQgKmUgPSBwICsgbXNn
LT5mcm9udC5pb3ZfbGVuOw0KPiAgCXN0cnVjdCBjZXBoX21kc19zbmFwX2hlYWQgKmg7DQo+IC0J
aW50IG51bV9zcGxpdF9pbm9zLCBudW1fc3BsaXRfcmVhbG1zOw0KPiArCXUzMiBudW1fc3BsaXRf
aW5vcywgbnVtX3NwbGl0X3JlYWxtczsNCj4gIAlfX2xlNjQgKnNwbGl0X2lub3MgPSBOVUxMLCAq
c3BsaXRfcmVhbG1zID0gTlVMTDsNCj4gLQlpbnQgaTsNCj4gKwlzaXplX3Qgc3BsaXRfaW5vc19i
eXRlcywgc3BsaXRfcmVhbG1zX2J5dGVzLCBzcGxpdF9ieXRlczsNCj4gKwl1MzIgaTsNCg0KSSBk
b24ndCB3aGVyZSBwYXRjaCB1c2VzIGkgdmFyaWFibGUuIFdoYXQgaXMgdGhlIHBvaW50IG9mIHRo
aXMgY2hhbmdlPw0KDQo+ICAJaW50IGxvY2tlZF9yd3NlbSA9IDA7DQo+ICAJYm9vbCBjbG9zZV9z
ZXNzaW9ucyA9IGZhbHNlOw0KPiANCj4gQEAgLTEwNDgsNiArMTA0OSwyNCBAQCB2b2lkIGNlcGhf
aGFuZGxlX3NuYXAoc3RydWN0IGNlcGhfbWRzX2NsaWVudCAqbWRzYywNCj4gIAl0cmFjZV9sZW4g
PSBsZTMyX3RvX2NwdShoLT50cmFjZV9sZW4pOw0KPiAgCXAgKz0gc2l6ZW9mKCpoKTsNCj4gDQo+
ICsJLyoNCj4gKwkgKiBWYWxpZGF0ZSB0aGF0IHRoZSB0d28gTURTLXN1cHBsaWVkIGNvdW50cyBj
YW5ub3Qgd3JhcCB3aGVuDQo+ICsJICogbXVsdGlwbGllZCBieSBzaXplb2YodTY0KSwgYW5kIHRo
YXQgdGhlIHR3byBhcnJheXMgdG9nZXRoZXINCj4gKwkgKiBmaXQgaW4gdGhlIHJlbWFpbmluZyBm
cm9udCBidWZmZXIgYmVmb3JlIGFueSBvZiB0aGUgcG9pbnRlcg0KPiArCSAqIGJ1bXBzIGJlbG93
LiAgV2l0aG91dCB0aGlzLCBhIG1hbGZvcm1lZCAob3IgbWFsaWNpb3VzKSBzbmFwDQo+ICsJICog
bWVzc2FnZSBjYW4gY2F1c2UgJ3AgKz0gc2l6ZW9mKHU2NCkgKiBudW1fc3BsaXRfaW5vcycgdG8g
bGFuZA0KPiArCSAqIGF0IGFuIGF0dGFja2VyLWNob3NlbiBvZmZzZXQgdmlhIHRoZSBzaXplX3Qg
KiBpbnQgd2lkZW5pbmcsDQo+ICsJICogYnlwYXNzaW5nIGNlcGhfZGVjb2RlX25lZWQoKSBhbmQg
bWFraW5nIHRoZSBzdWJzZXF1ZW50DQo+ICsJICogJ3JpID0gcDsgcmktPmNyZWF0ZWQnIHJlYWQg
b3V0IG9mIGJvdW5kcy4NCj4gKwkgKi8NCg0KSSBhbSBub3Qgc3VyZSB0aGF0IHdlIHJlYWxseSBu
ZWVkIENsYXVkZSBBSSBnZW5lcmF0ZWQgY29tbWVudCBoZXJlLiBNYXliZSwgc29tZQ0Kc2hvcnQg
Y29tbWVudCBpcyB3cml0dGVuIGJ5IGh1bWFuIGJlaW5nIG1ha2VzIHNlbnNlLiBCdXQsIGN1cnJl
bnRseSwgSSBwcmVmZXINCmNvbXBsZXRlbHkgcmVtb3ZlIHRoaXMgY29tbWVudC4NCg0KPiArCXNw
bGl0X2lub3NfYnl0ZXMgICA9IGFycmF5X3NpemUobnVtX3NwbGl0X2lub3MsICAgc2l6ZW9mKHU2
NCkpOw0KDQpXaGF0IGlzIHRoZSBwb2ludCBvZiB0aGlzIGFsaWdubWVudD8gQ2xhdWRlIEFJIGxp
a2UgdGhpcz8gUGxlYXNlLCBkb3VibGUgY2hlY2sNCnRoZSBnZW5lcmF0ZWQgY29kZSBhbmQgZm9s
bG93IHRvIExpbnV4IGtlcm5lbCBzdHlsZS4gSGF2ZSB5b3UgcnVuIHRoZQ0KY2hlY2twYXRjaC5w
bCBzY3JpcHQgZm9yIHRoZSBwYXRjaD8NCg0KPiArCXNwbGl0X3JlYWxtc19ieXRlcyA9IGFycmF5
X3NpemUobnVtX3NwbGl0X3JlYWxtcywgc2l6ZW9mKHU2NCkpOw0KPiArCWlmIChzcGxpdF9pbm9z
X2J5dGVzID09IFNJWkVfTUFYIHx8IHNwbGl0X3JlYWxtc19ieXRlcyA9PSBTSVpFX01BWCB8fA0K
DQpDb3VsZCBpdCBiZSBwb3NzaWJsZSB0aGF0IHNwbGl0X2lub3NfYnl0ZXMgb3Igc3BsaXRfcmVh
bG1zX2J5dGVzIGFyZSBsZXNzZXIgdGhhbg0KU0laRV9NQVggYnV0IHdlIHN0aWxsIGNvdWxkIGhh
dmUgb3ZlcmZsb3c/DQoNCj4gKwkgICAgY2hlY2tfYWRkX292ZXJmbG93KHNwbGl0X2lub3NfYnl0
ZXMsIHNwbGl0X3JlYWxtc19ieXRlcywNCj4gKwkJCSAgICAgICAmc3BsaXRfYnl0ZXMpIHx8DQoN
CkFsbCB0aGlzIGNoZWNrIGxvb2tzIGxpa2UgYSBnb29kIGNhbmRpZGF0ZSBmb3Igc3RhdGljIGlu
bGluZSBmdW5jdGlvbi4NCg0KPiArCSAgICAoc2l6ZV90KShlIC0gcCkgPCBzcGxpdF9ieXRlcykN
Cg0KVGhlIHdob2xlIGNoZWNrIGxvb2tzIGNvbXBsaWNhdGVkIGFuZCBjb25mdXNpbmcuIEl0J3Mg
cmVhbGx5IGVhc3kgdG8gbWlzcw0Kc29tZXRoaW5nIGluIHRoZSBsb2dpYy4gSSBiZWxpZXZlIHRo
YXQgdGhpcyBjb2RlIHJlcXVpcmVzIHNvbWUgcmVmYWN0b3JpbmcuIEkgYW0NCm5vdCB2ZXJ5IGxp
a2UgdGhlIHBhdHRlcm4gb2YgY2FsY3VsYXRpbmcgdGhlIHNwbGl0X2J5dGVzIGluIHRoZSBwcmV2
aW91cw0KY29uZGl0aW9uIGNoZWNrLg0KDQpXaGF0IGFib3V0IHRoaXM/DQoNCiAgc3BsaXRfYnl0
ZXMgPSBzaXplX2FkZChzcGxpdF9pbm9zX2J5dGVzLCBzcGxpdF9yZWFsbXNfYnl0ZXMpOw0KICBp
ZiAoc3BsaXRfYnl0ZXMgPT0gU0laRV9NQVggfHwgKHNpemVfdCkoZSAtIHApIDwgc3BsaXRfYnl0
ZXMpDQogICAgICBnb3RvIGJhZDsNCg0KVGhhbmtzLA0KU2xhdmEuDQoNCj4gKwkJZ290byBiYWQ7
DQo+ICsNCj4gIAlkb3V0YyhjbCwgImZyb20gbWRzJWQgb3AgJXMgc3BsaXQgJWxseCB0cmFjZWxl
biAlZFxuIiwgbWRzLA0KPiAgCSAgICAgIGNlcGhfc25hcF9vcF9uYW1lKG9wKSwgc3BsaXQsIHRy
YWNlX2xlbik7DQo+IA0KPiBAQCAtMTA2NCw5ICsxMDgzLDkgQEAgdm9pZCBjZXBoX2hhbmRsZV9z
bmFwKHN0cnVjdCBjZXBoX21kc19jbGllbnQgKm1kc2MsDQo+ICAJCSAqIGNoaWxkLg0KPiAgCQkg
Ki8NCj4gIAkJc3BsaXRfaW5vcyA9IHA7DQo+IC0JCXAgKz0gc2l6ZW9mKHU2NCkgKiBudW1fc3Bs
aXRfaW5vczsNCj4gKwkJcCArPSBzcGxpdF9pbm9zX2J5dGVzOw0KPiAgCQlzcGxpdF9yZWFsbXMg
PSBwOw0KPiAtCQlwICs9IHNpemVvZih1NjQpICogbnVtX3NwbGl0X3JlYWxtczsNCj4gKwkJcCAr
PSBzcGxpdF9yZWFsbXNfYnl0ZXM7DQo+ICAJCWNlcGhfZGVjb2RlX25lZWQoJnAsIGUsIHNpemVv
ZigqcmkpLCBiYWQpOw0KPiAgCQkvKiB3ZSB3aWxsIHBlZWsgYXQgcmVhbG0gaW5mbyBoZXJlLCBi
dXQgd2lsbCBfbm90Xw0KPiAgCQkgKiBhZHZhbmNlIHAsIGFzIHRoZSByZWFsbSB1cGRhdGUgd2ls
bCBvY2N1ciBiZWxvdyBpbg0KPiBAQCAtMTE0NCw4ICsxMTYzLDggQEAgdm9pZCBjZXBoX2hhbmRs
ZV9zbmFwKHN0cnVjdCBjZXBoX21kc19jbGllbnQgKm1kc2MsDQo+ICAJCSAqIHBvc2l0aW9uZWQg
YXQgdGhlIHN0YXJ0IG9mIHJlYWxtIGluZm8sIGFzIGV4cGVjdGVkIGJ5DQo+ICAJCSAqIGNlcGhf
dXBkYXRlX3NuYXBfdHJhY2UoKS4NCj4gIAkJICovDQo+IC0JCXAgKz0gc2l6ZW9mKHU2NCkgKiBu
dW1fc3BsaXRfaW5vczsNCj4gLQkJcCArPSBzaXplb2YodTY0KSAqIG51bV9zcGxpdF9yZWFsbXM7
DQo+ICsJCXAgKz0gc3BsaXRfaW5vc19ieXRlczsNCj4gKwkJcCArPSBzcGxpdF9yZWFsbXNfYnl0
ZXM7DQo+ICAJfQ0KPiANCj4gIAkvKg0KPiAtLQ0KPiAyLjUzLjANCj4gDQo=

