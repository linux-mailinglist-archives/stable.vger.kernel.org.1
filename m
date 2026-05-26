Return-Path: <stable+bounces-254428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOSwIcvuFWqqfQcAu9opvQ
	(envelope-from <stable+bounces-254428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:04:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD205DBADC
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 21:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDCC13036CC7
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76CD3C09FE;
	Tue, 26 May 2026 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ogTwI9FP"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B30937702A;
	Tue, 26 May 2026 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822277; cv=fail; b=Zv/XSce54KoQVytVQkhCTFbJbgjWXl0jw4NU+8OH+XYnbEcry8GnuIUkN3QexxUnFMlxHMXbxjpoyc0jpJYwtZJxUwITG1IiWFdzt1+NbknJRblba/af8EHhkGMfGqscywag11jTHwZdscwVu1v+aJWCo/G3F8T75156IrMTnNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822277; c=relaxed/simple;
	bh=0EwTjPa63agyz1qAwCVtgYrwjccBhJt5WkWAHXScc0g=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Zua4TsmGi8sI68MAyJ7wNuJ/Spjwxmdqby6SUIDlFlmKnywrdLW2nUziY0Kn3Xql5Ts2mSFYENc+tWrZOuZcRLO9sdT114faqnmzk8tm65d84MZ6GEMluwdhGgKsf9QUZVWPS2WWYk6XJl4wTc6qBLnLCzdANEFkQed02xVqjoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ogTwI9FP; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QDSVZ13706617;
	Tue, 26 May 2026 19:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=0EwTjPa63agyz1qAwCVtgYrwjccBhJt5WkWAHXScc0g=; b=ogTwI9FP
	5Ta4dmuMJZQZWCSR6uRSU+94Y/56uhXXGIYalslJaYEX4F5pHGMpd4O2aMGQtFT/
	GWQryryBSRbiaiLfmrzhY+C5XLKoXarZFZt+/UUDwtleTQHIinF4S0JhE4BD2hSN
	WT1dg1e2npz4pJBhwiSE6vcukWUa+B8QSX3vQZuaC7veSU+hWZHmEKtcnCzpN7is
	9DsIez5SQuaelpNrjK765UJlfpTRpl1JxwRBKH6RwEjmvizSwcPrG2pnGKKFWc7C
	1xGSI2Oeq/fdzxypBFjJY6hV+9WzaqF1Vcy4JgIBZ2/f+yqWsr1IlxK+29DAVGZ4
	SKnn5wFhjuQ8/Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nunx67-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 19:04:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCqG+PiywIHi2/5iPTm501noM2RIron0rUcA11dXZIvZNoGYHusge0my30zzDA4Sbk2VdRPP7jBCcbhWD8ehnglGqOz63mJRGfi2INRI7ARIhQKo7XV3QXuhWqj7mYpG6Fl2tMOr1tAzzrgo6uABC1GOnfoh1j9rvQ2NmoJhemCHFjS1b3i+2FaZNXsfgOwZd6rj1UIwrY88Fsfib91pvIJdvjmDDC9QWL5Ja5SsSuk5d+ZuzZAvkPEc+8XGaQcG9aPPHhSw2uYyg3ky+8t9vmqME88MVQuFHEf6vB8YuYjjloaJBov0dYw+QaOp1H/X65gcSNBt6FCMPzShq+cIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EwTjPa63agyz1qAwCVtgYrwjccBhJt5WkWAHXScc0g=;
 b=CNyfJ0lEe1YzV9WVacUrTp3i2LfiMgtYu7ddxNhlxYPNBMqHskHnhLf5eFho8WmE2bOopBVwnnkTUx4MyDB2+d4PRbx5PBwJywkUK4kd+XxO/CF1WU0B2lh+mWRfzstNO//4rWm2wnBYvJFp/ox73rDgkG6LrZ2/SBpibwXpqrI//T7Sid3rFKcltAalyZCXLzH3D0YVYeZDEkqcNE2iN2boHTP55ruNjwgIZgtHqyFHLoZQpkFVY1gfDHloy73fQ0MfLJJBq5QZd2iCc2QqyqQknI+FRNV/gGiKmesDvHOrJR+8ZQ+5aFItE96LdTbYGi6ZdTicnh85OStv8eCu0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ4PPFE0F24BAED.namprd15.prod.outlook.com (2603:10b6:a0f:fc02::8ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 19:04:26 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 19:04:24 +0000
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
Thread-Topic: [EXTERNAL] [PATCH] ceph: fix OOB read in decode_lockers() via
 missing bounds check
Thread-Index: AQHc6lYh5SwDzd7zrE+NS6xg6yzPi7YgsEGA
Date: Tue, 26 May 2026 19:04:23 +0000
Message-ID: <50dc5a7472fb2d6da4ebb71cc659b03a5df06747.camel@ibm.com>
References: <20260523014607.426417-1-jhapavitra98@gmail.com>
In-Reply-To: <20260523014607.426417-1-jhapavitra98@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ4PPFE0F24BAED:EE_
x-ms-office365-filtering-correlation-id: 6906aa94-7a92-4a49-b405-08debb5999c8
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021|11063799006|5023799004|6133799003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 46CroCqgFJhuUTSGeHwJkywtA0PORBRRUhpMXXOLHKGMZcyQCW4W+d1ZEww8OWZk/UzUpdwaHzRbTuMt96igEirhNDn63IsDI0XImsJolLFYfZhvnsj5suWQgf7S3LqGQHqcCYOt+5FdshB1V+V0dPo629j5QtUvM6nDHgTW7I35LXhp7czQKd7KdyTXctt5xu0ul+GhhtARH7t135K4ey5gwKxnJnW7l9SCqcraw7gepMjflUC5Z+DsOA5Y5EfQL1fB8ralHZj+2o3jWtGGYnjrSKSbKdnZl72f8ms4xxA1uy77b4JU2XuUp0wnm6fCGtJTQnK4RHOBAFoikxJd7lDvjwqpNx+OVUH3lVTEdAk3qcJ0DXaYkbNuN7wxbQBMMofzmVkzVlvSpHW7PfcEGAAnyYsom2saVyREibnytmchvBKYlWW/EFd0tBVor1Sit3om8K10dgLlmx90x0Wpxwx7xf63eunaNkCqbnGuil2Zcbt+QrjuKDjgIY9iHR9G5q/Sp4VMjEfJGzHwG/9I2GXMRezp/zgJBrOROzzovX0qZli5nektXqYdMTSQx15E1cszuNfvIPr8wOgF6RLIfFkgM6S2VqE/bVXqDzW5In0jd/vD/a079MGq81adWncCSZrpbWr559be26zQJsK5TUWI60mY/TzzGieXPaB4LDfxcNVZr3lbQP7j4aINVTu5TPoc02YVpDUQJp6H3x9Lbg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021)(11063799006)(5023799004)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmIwL09zWTBIL1YrM1piTW0wWkoyZ3c0NmVUSlJac05rT2tEU3o4NzV5YzJ3?=
 =?utf-8?B?dk1hZUU3UHpHazZEZXF0aGhyQTdhSjRQa2V1NVl4V0lYRFptOVJDcTJXZjN1?=
 =?utf-8?B?ZG5zanAyTTJMVUpvZ2JLMEU0VHh3TTJ1RDZuOUlaSHczV2licUJtNEFtcmFG?=
 =?utf-8?B?T3Z3Tm1mZjJUaGJib0ZLVDNibzdtekRVY2JVbG0zam5IQjdkWnAxN3U5OWlt?=
 =?utf-8?B?a3hhcndCUlRuV1lScFVQVEJ1MmNpTnVILzJWQ3hQSU9tMEtSV3NXM1NaWSta?=
 =?utf-8?B?VUljRVZTK3F5TEQwWVl3dEIzNlBaVU8xdVZXcG9jRmVzTHhQTm1obVpvNlQ3?=
 =?utf-8?B?bHZDbFRUV0Q3NXVRTGg2dVVObFJLK3VrcWlSL0hpQko5ejZOOWxZaXF1M0RK?=
 =?utf-8?B?cUJ0UVI0dGdaellJNm5CRXNHaHRYdW5rOUllOTJOOWxobWIzK2h2TEgwRm8y?=
 =?utf-8?B?VW4zN3JiTEtVVFlNdE04WkNrK0g5MGlsVnlBcW5YZjVsYjZmQStpVVF2UzZz?=
 =?utf-8?B?cGRVNWkxQnk4K0lndHRFTUFBMllwNGkvTkxzZEVSSUszbDluVEIwaFd0azgv?=
 =?utf-8?B?K1AzeDgwdUhNTExzOWlmRkQvWERpaytBd0dqYkJTK0pIbW1rQXpNWEJha2hG?=
 =?utf-8?B?OHBoanVkdXFmcmI3cVk3Njh5OGJRTWxsWi9lL1RGWS9oVi9PdVNyTXB4VUY1?=
 =?utf-8?B?MGRjMTNyN21GM1JITnpHa28yeXhVNzR1QTZKNmIyVmVyenUxVGlRb0dBSTY0?=
 =?utf-8?B?dGpqMWhLQlpRMnBuQXc2Z3EzcEc3QzM0eVdMbkNWVlFLUEdEOUZONHZYKy9E?=
 =?utf-8?B?Vm5TRHBuc1ROZjZ4NXlJYnVBZ2E4clRza2dMOUtNdG5vd2hrZ0k2SVRJbk1w?=
 =?utf-8?B?d1RzODlUNnZGK2RYK2kzTHdtNGNWK3JLelprZVB1ZUgvRHFjb1BiQ25CV01i?=
 =?utf-8?B?RWJ2T29BV0FpdEMrbDV3UEFrZ043V2lwMUVzd0ZFTWlmY28zMjNIMVM5bzBV?=
 =?utf-8?B?Ly95SUVsdlBpei9vU3luODhVbkFRQTdZVXYvU1dWeUlzbUQ3Z3lueUFvbjZv?=
 =?utf-8?B?QmJaZXN5b3VOWXZXcW8vcDBHeGtqdUtxdmZYSVNsd1dlY0FRbmxhUHoxRmFt?=
 =?utf-8?B?TlQrcllScmJsdzQ0eFlVN2pnKzh0Rm1kUzBKQW5rY3RtVkRiQWJvZ2E2OUtG?=
 =?utf-8?B?Q3lpYitSYytZRy81NnpSYlhRRTM0TnpJYmt5THNNcDRMYzFHZGQrKzdGcTFF?=
 =?utf-8?B?RVpwdXZwY3ZPb1hwOTRKZTNkNGw3ZWl1TkN3U0V0ZUI0eFhBaU4vSDRQY3Rm?=
 =?utf-8?B?dXV0VUxIREZMOGRobC9PVnYyWlJlTEQ5KzJMK3pVVU1SN3F5VGlaQWhOaHRF?=
 =?utf-8?B?Y1lwUUtYNXExY0ZOaUlkbzlLRWlNZk15ZmpROHVNWUdHaFFsdnRDWmFqSlM0?=
 =?utf-8?B?MDltODc2d1ZCVW5ac215MFNqcWxzRzJzOHI1SmlTUGtGOVF0V3kzdWFFSi9r?=
 =?utf-8?B?a3p1YzlYZksvb3JjOWJSV3JBNXg3UFk5L0g1eWUzajBDeUtvVXo0LzlWQ2lW?=
 =?utf-8?B?VXFlWHQ4NGJ0YmxGd0plYW5wR2YwM0lWMUREVFc5bkp0MExKMFhkalJsdGIz?=
 =?utf-8?B?c0k0NlpNZHFid0JNMkdWWG5SRDZRNnpCYy9RYTdid1YrMkNwZ1Exd2tJY2VR?=
 =?utf-8?B?OUU1THVabVRVTUI3VHF6RTNtY1pkdE1XUEJBV2xmMi93bSszUUhlNFhGajg0?=
 =?utf-8?B?SWF0TmVLTXJWN1BuR09TSEZzeGRuWkJVU01OR1lIeE1pSXdtbkVFb0tlQjFU?=
 =?utf-8?B?R0Z5eHllcUorMVRLS1dPRDZpOGhEdithakVSVFVtaEFmOXZaVk52MWkvNHVy?=
 =?utf-8?B?bW1CVVI4dnArbmJUdmR0WlU4NU5xOTZwVzl5cGsvSFBDMnhyTWUxZUJBcVpv?=
 =?utf-8?B?a3Q5bTQ5UDBheitxQ2NsUDBDZ3lWN3Q2ZjE5aHhRTkIxK0J1eTcwYkZnb1Jy?=
 =?utf-8?B?ejlIQXlpdFJyaWNCc0w5c0ZNUHhKeUs3ZmhUYk1NVXM5OGVGbzE2bk5haFhO?=
 =?utf-8?B?bjdUcXBudUFOZHorQ1lwbDJYU2pSdHJaZExpTC9OMDBPWlZCb0hFRG5iYytl?=
 =?utf-8?B?eFp0WWxXbDFGRUFBWnRnN2Fhb3Y0aXhjT0h1eEpuSXd4NHlBbG1aRW1lc2g3?=
 =?utf-8?B?eXRwc0NsTFpCakIxbkhjSGZUcDRmNWFvTTJGZUpTM2wwRXAyRGwwZXFKdlVY?=
 =?utf-8?B?WlBhSGtqTmtaeFpDTnQyYy9mQ2FJeWw2b0VVY3M0YnZ2bEhBbStmMDVsOXJE?=
 =?utf-8?B?b2xqZzNLL1lLR2FOVGw4REFCWm5jNjVQTXphdlN0djQ0WFZGdkUyRHRBYkdi?=
 =?utf-8?Q?9TTN2MJtTjBLLIIChUWHuLWvHbG6mPPcYNItF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56D77E5D2F77BD4593B5FAB541854392@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Mx5e2QKcSMkIDcYJF4Cpe7elDhmjS5dXyjBiiNkmfDszswsOex7MQLs9985T3osVRZDWKnwxxfzlpnDcDPCEMsnMyhrePscFnadMTCTCOq6kuuhjvRy5mdpeunb7glg/lQnzbM9YOyUTdEUktzMDzLIcgG7HfH2Iie4tOoUUu3DtJdw5evPt8XQ/z85hoWJksZbZlz81dX5iFwfsxNE27BsdBJnGYOAHj6znihVaDeaK4YbbJ/U6FUnPgA0N7rfzQr6dF//jGJJ89k91VT2ZLGvLQuG69eLESnWpZ1T//3eteYBlYngayx3MM5lov7kKkU+VJjvkVF/Ercdpkvw+Tw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6906aa94-7a92-4a49-b405-08debb5999c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 19:04:23.9585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhETYNbgietZrhstkAe1KHn2T+O/Vl7tGMy/HUCewKguTvUO3Hm/GFlAkRySTRawzjTQG+WpgmZPvHvDymhMEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFE0F24BAED
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE2MyBTYWx0ZWRfXxNPgQ/a3D6wI
 v2266UJTYNCutDOrIg6ShgD+ID93LB89KGcaEim6dT3AwJD5+ibGFar9y1wVW1YJDIDxUazND6E
 8/Qm980OIecdgx3u/P0xnWnxteco0wlLXns6PtVfQV3PAbdKl6HNzVhV4Yo4ACe9WHHdr+/tkx5
 RQubteBof89V9Py0HsXP47/AdsT5eSC6m8pC2ned7KqC1Ibo6EnCoEeCq29diRpFtzLUVNJPjq7
 SVs3DlZsCuWzVMHLKrvxL/ngC5dqbyYwPkr0cv7XwDmTPj1bgSb7mftXWboOXuHaVxY/8gIxo5u
 1LYd02+KZR28okXG9wqJieVw9un8WtjV4D+b/pEEAQ26EffNice47PEybLLGFY1tZlcYT0NCsz6
 pSQRoNVX9dIbrdnHRKEkW6bxMALlIoqRv2R2xL4/8yA4u5DLYMxs/LT/VKU0zaz5TlfH8nB7Fkw
 +1kFHZqR3vLNQ0pSDRw==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a15eebf cx=c_pps
 a=LWr4lAA3g636x20Wckjs+g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=xLYXfvQhj-HlV1kuZ04A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: 6DrvBfCIobWsp-Amggm0LDX3KqGQFDpJ
X-Proofpoint-GUID: LxthBYL9spJAzO_5Qjveum9R1yW5F5t_
Subject: Re:  [PATCH] ceph: fix OOB read in decode_lockers() via missing
 bounds check
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260163
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
	TAGGED_FROM(0.00)[bounces-254428-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.882];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1CD205DBADC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCAyMDI2LTA1LTIyIGF0IDIxOjQ2IC0wNDAwLCBQYXZpdHJhIEpoYSB3cm90ZToNCj4g
Y2VwaF9zdGFydF9kZWNvZGluZygpIGFjY2VwdHMgc3RydWN0X2xlbj0wIGFzIHZhbGlkOg0KPiBj
ZXBoX2RlY29kZV9uZWVkKHAsIGVuZCwgMCwgYmFkKSBhbHdheXMgcGFzc2VzLiBXaGVuIGEgbWFs
aWNpb3VzIG9yDQo+IGNvbXByb21pc2VkIE9TRCBzZW5kcyBhIGNsc19sb2NrX2dldF9pbmZvX3Jl
cGx5IHdpdGggc3RydWN0X2xlbj0wLA0KPiBjZXBoX3N0YXJ0X2RlY29kaW5nKCkgcmV0dXJucyBz
dWNjZXNzIHdpdGggcCA9PSBlbmQsIGxlYXZpbmcgemVybw0KPiBieXRlcyBndWFyYW50ZWVkIGZv
ciBzdWJzZXF1ZW50IHJlYWRzLg0KPiANCj4gVGhlIGltbWVkaWF0ZWx5IGZvbGxvd2luZyBiYXJl
IGNlcGhfZGVjb2RlXzMyKHApIGluIGRlY29kZV9sb2NrZXJzKCkNCj4gaGFzIG5vIHByZWNlZGlu
ZyBib3VuZHMgY2hlY2suIFdpdGggcCA9PSBlbmQgdGhpcyBpcyBhIDQtYnl0ZSByZWFkDQo+IHBh
c3QgdGhlIHZhbGlkYXRlZCBidWZmZXIgYm91bmRhcnkuIFRoZSBnYXJiYWdlIHZhbHVlIGlzIHRo
ZW4gcGFzc2VkDQo+IHRvIGt6YWxsb2Nfb2JqcygpIGFzIHRoZSBsb2NrZXIgY291bnQuDQo+IA0K
PiBUaGUgc2libGluZyBmdW5jdGlvbiBkZWNvZGVfd2F0Y2hlcnMoKSBpbiBvc2RfY2xpZW50LmMg
YWxyZWFkeSB1c2VzDQo+IHRoZSBzYWZlIHZhcmlhbnQgY2VwaF9kZWNvZGVfMzJfc2FmZSgpIGFm
dGVyIGl0cyBvd24NCj4gY2VwaF9zdGFydF9kZWNvZGluZygpIGNhbGwuIGRlY29kZV9sb2NrZXJz
KCkgaXMgdGhlIG9ubHkgc2l0ZSB1c2luZw0KPiB0aGUgYmFyZSB2YXJpYW50LCBjb25maXJtaW5n
IGFuIG92ZXJzaWdodC4NCj4gDQo+IEZpeCBieSByZXBsYWNpbmcgY2VwaF9kZWNvZGVfMzIocCkg
d2l0aCBjZXBoX2RlY29kZV8zMl9zYWZlKHAsIGVuZCwNCj4gKm51bV9sb2NrZXJzLCBlcnJfaW52
YWwpLCBhZGRpbmcgYSBuZXcgZXJyX2ludmFsIGxhYmVsIHRoYXQgcmV0dXJucw0KPiAtRUlOVkFM
IGRpcmVjdGx5IHdpdGhvdXQgYXR0ZW1wdGluZyB0byBmcmVlIGFuIHVuaW5pdGlhbGl6ZWQgbG9j
a2Vycw0KPiBwb2ludGVyLg0KPiANCj4gS0FTQU4gcmVwb3J0IChrZXJuZWwgNy4wLjAtcmM3LCBR
RU1VL3g4Nl82NCwgS0FTTFIgZGlzYWJsZWQpOg0KPiAgID09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiAgIEJVRzogS0FT
QU46IHNsYWItb3V0LW9mLWJvdW5kcyBpbiBjZXBoX29vYjNfaW5pdCsweDI1MS8weGZmMCBbY2Vw
aF9vb2IzX3BvY10NCj4gICBSZWFkIG9mIHNpemUgNCBhdCBhZGRyIGZmZmY4ODgwMGEyOWI3NmUg
YnkgdGFzayBpbnNtb2QvNTgNCj4gDQo+ICAgQ1BVOiAwIFVJRDogMCBQSUQ6IDU4IENvbW06IGlu
c21vZCBUYWludGVkOiBHICAgICAgICAgICBPICAgICAgICA3LjAuMC1yYzctZzljMmFiZjY5ZGE4
My1kaXJ0eSAjMTUgUFJFRU1QVChsYXp5KQ0KPiAgIFRhaW50ZWQ6IFtPXT1PT1RfTU9EVUxFDQo+
ICAgSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5Niks
IEJJT1MgMS4xNy4wLWRlYmlhbi0xLjE3LjAtMSAwNC8wMS8yMDE0DQo+ICAgQ2FsbCBUcmFjZToN
Cj4gICAgPFRBU0s+DQo+ICAgIGR1bXBfc3RhY2tfbHZsKzB4NGQvMHg3MA0KPiAgICBwcmludF9y
ZXBvcnQrMHgxNzAvMHg0ZjMNCj4gICAga2FzYW5fcmVwb3J0KzB4ZGEvMHgxMTANCj4gICAgY2Vw
aF9vb2IzX2luaXQrMHgyNTEvMHhmZjAgW2NlcGhfb29iM19wb2NdDQo+ICAgIGRvX29uZV9pbml0
Y2FsbCsweDlhLzB4M2EwDQo+ICAgIGRvX2luaXRfbW9kdWxlKzB4MjdjLzB4NzkwDQo+ICAgIGxv
YWRfbW9kdWxlKzB4NGE5YS8weDYzNTANCj4gICAgaW5pdF9tb2R1bGVfZnJvbV9maWxlKzB4MTVj
LzB4MTgwDQo+ICAgIGlkZW1wb3RlbnRfaW5pdF9tb2R1bGUrMHgyMWYvMHg3NTANCj4gICAgX194
NjRfc3lzX2Zpbml0X21vZHVsZSsweGJhLzB4MTIwDQo+ICAgIGRvX3N5c2NhbGxfNjQrMHhlMi8w
eDU3MA0KPiAgICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ny8weDdmDQo+IA0K
PiAgIEFsbG9jYXRlZCBieSB0YXNrIDU4Og0KPiAgICBrYXNhbl9zYXZlX3N0YWNrKzB4MzAvMHg1
MA0KPiAgICBrYXNhbl9zYXZlX3RyYWNrKzB4MTQvMHgzMA0KPiAgICBfX2thc2FuX2ttYWxsb2Mr
MHg3Zi8weDkwDQo+ICAgIGNlcGhfb29iM19pbml0KzB4NGQvMHhmZjAgW2NlcGhfb29iM19wb2Nd
DQo+ICAgIGRvX29uZV9pbml0Y2FsbCsweDlhLzB4M2EwDQo+ICAgIGRvX2luaXRfbW9kdWxlKzB4
MjdjLzB4NzkwDQo+ICAgIGxvYWRfbW9kdWxlKzB4NGE5YS8weDYzNTANCj4gICAgaW5pdF9tb2R1
bGVfZnJvbV9maWxlKzB4MTVjLzB4MTgwDQo+ICAgIGlkZW1wb3RlbnRfaW5pdF9tb2R1bGUrMHgy
MWYvMHg3NTANCj4gICAgX194NjRfc3lzX2Zpbml0X21vZHVsZSsweGJhLzB4MTIwDQo+ICAgIGRv
X3N5c2NhbGxfNjQrMHhlMi8weDU3MA0KPiAgICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJh
bWUrMHg3Ny8weDdmDQo+IA0KPiAgIFRoZSBidWdneSBhZGRyZXNzIGJlbG9uZ3MgdG8gdGhlIG9i
amVjdCBhdCBmZmZmODg4MDBhMjlhMDAwDQo+ICAgIHdoaWNoIGJlbG9uZ3MgdG8gdGhlIGNhY2hl
IGttYWxsb2MtOGsgb2Ygc2l6ZSA4MTkyDQo+ICAgVGhlIGJ1Z2d5IGFkZHJlc3MgaXMgbG9jYXRl
ZCA1OTk4IGJ5dGVzIGluc2lkZSBvZg0KPiAgICBhbGxvY2F0ZWQgNjAwMC1ieXRlIHJlZ2lvbiBb
ZmZmZjg4ODAwYTI5YTAwMCwgZmZmZjg4ODAwYTI5Yjc3MCkNCj4gDQo+ICAgTWVtb3J5IHN0YXRl
IGFyb3VuZCB0aGUgYnVnZ3kgYWRkcmVzczoNCj4gICAgZmZmZjg4ODAwYTI5YjYwMDogMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDANCj4gICAgZmZmZjg4ODAw
YTI5YjY4MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAN
Cj4gICA+ZmZmZjg4ODAwYTI5YjcwMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgZmMgZmMNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAgICBmZmZmODg4MDBhMjliNzgwOiBmYyBmYyBm
YyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYw0KPiAgID09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
PiANCj4gICBudW1fbG9ja2Vycz0weGNjY2NhYWFhIChPT0IgZ2FyYmFnZSBmcm9tIEtBU0FOIHJl
ZHpvbmUpDQo+IA0KPiBBdHRhY2tlciBtb2RlbDogYSBtYWxpY2lvdXMgb3IgY29tcHJvbWlzZWQg
T1NEIGluIGEgbXVsdGktdGVuYW50IENlcGgNCj4gZGVwbG95bWVudCBjYW4gdHJpZ2dlciB0aGlz
IGFnYWluc3QgYW55IGtlcm5lbCBjbGllbnQgdGhhdCBpc3N1ZXMgdGhlDQo+IGxvY2suZ2V0X2lu
Zm8gY2xhc3MgbWV0aG9kIChlLmcuIGR1cmluZyBSQkQgZXhjbHVzaXZlIGxvY2sgYWNxdWlzaXRp
b24pDQo+IHdpdGhvdXQgYW55IGZ1cnRoZXIgcHJpdmlsZWdlcyBiZXlvbmQgT1NEIHNlc3Npb24g
ZXN0YWJsaXNobWVudC4NCj4gDQo+IEZpeGVzOiBkNGVkNGE1MzA1NjIgKCJsaWJjZXBoOiBzdXBw
b3J0IGZvciBsb2NrLmxvY2tfaW5mbyIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
IFNpZ25lZC1vZmYtYnk6IFBhdml0cmEgSmhhIDxqaGFwYXZpdHJhOThAZ21haWwuY29tPg0KPiAt
LS0NCj4gIG5ldC9jZXBoL2Nsc19sb2NrX2NsaWVudC5jIHwgNCArKystDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
bmV0L2NlcGgvY2xzX2xvY2tfY2xpZW50LmMgYi9uZXQvY2VwaC9jbHNfbG9ja19jbGllbnQuYw0K
PiBpbmRleCBjNjk1NmYxZGYuLjc4Mjc2MjczYyAxMDA2NDQNCj4gLS0tIGEvbmV0L2NlcGgvY2xz
X2xvY2tfY2xpZW50LmMNCj4gKysrIGIvbmV0L2NlcGgvY2xzX2xvY2tfY2xpZW50LmMNCj4gQEAg
LTI5OSw3ICsyOTksNyBAQCBzdGF0aWMgaW50IGRlY29kZV9sb2NrZXJzKHZvaWQgKipwLCB2b2lk
ICplbmQsIHU4ICp0eXBlLCBjaGFyICoqdGFnLA0KDQpBcyBmYXIgYXMgSSBjYW4gc2VlLCBkZWNv
ZGVfbG9ja2VyKCkgaGFzIHRoZSBzYW1lIGlzc3VlLiBIYXZlIHlvdSBzZW50IHRoZSBwYXRjaA0K
Zm9yIHRoaXM/DQoNCj4gIAlpZiAocmV0KQ0KPiAgCQlyZXR1cm4gcmV0Ow0KPiAgDQo+IC0JKm51
bV9sb2NrZXJzID0gY2VwaF9kZWNvZGVfMzIocCk7DQo+ICsJY2VwaF9kZWNvZGVfMzJfc2FmZShw
LCBlbmQsICpudW1fbG9ja2VycywgZXJyX2ludmFsKTsNCj4gIAkqbG9ja2VycyA9IGt6YWxsb2Nf
b2JqcygqKmxvY2tlcnMsICpudW1fbG9ja2VycywgR0ZQX05PSU8pOw0KPiAgCWlmICghKmxvY2tl
cnMpDQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiBAQCAtMzIwLDYgKzMyMCw4IEBAIHN0YXRpYyBp
bnQgZGVjb2RlX2xvY2tlcnModm9pZCAqKnAsIHZvaWQgKmVuZCwgdTggKnR5cGUsIGNoYXIgKip0
YWcsDQo+ICAJKnRhZyA9IHM7DQo+ICAJcmV0dXJuIDA7DQo+ICANCj4gK2Vycl9pbnZhbDoNCj4g
KwlyZXR1cm4gLUVJTlZBTDsNCj4gIGVycl9mcmVlX2xvY2tlcnM6DQo+ICAJY2VwaF9mcmVlX2xv
Y2tlcnMoKmxvY2tlcnMsICpudW1fbG9ja2Vycyk7DQo+ICAJcmV0dXJuIHJldDsNCg0KSSBhbSBz
dGlsbCBub3QgY29tcGxldGVseSBzdXJlIGFib3V0IC1FSU5WQUwgaGVyZSB0b28uIE1heWJlLCAt
RU5PTUVNIGNvdWxkIGJlDQptb3JlIGNvcnJlY3QuDQoNCldoYXQgYWJvdXQgdGhpcyBbMV0/DQoN
Cip0eXBlID0gY2VwaF9kZWNvZGVfOChwKTsNCg0KU2hvdWxkIHdlIHJld29yayBpdCB0b28/DQoN
ClRoYW5rcywNClNsYXZhLg0KDQpbMV0NCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L3Y3LjEtcmM0L3NvdXJjZS9uZXQvY2VwaC9jbHNfbG9ja19jbGllbnQuYyNMMzEzDQoNCg==

