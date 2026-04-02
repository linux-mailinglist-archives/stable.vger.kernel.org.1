Return-Path: <stable+bounces-233126-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFWLCFwDz2mLsQYAu9opvQ
	(envelope-from <stable+bounces-233126-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 02:01:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CFF38F5F7
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 02:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9695E3082DAD
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 23:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7030C3BFE40;
	Thu,  2 Apr 2026 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Ldnord3o"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4193B8D6A;
	Thu,  2 Apr 2026 23:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775174370; cv=fail; b=MFzDIb/W+SXEjpkP3XyWmLv1Vid9NzwRD7RiXLtQ3xHHO4d4KGDnidT12ZlNb9FArx18u3BMxv70JPUHtees7f16Ax+h8Id7Iaky9prn4aT9+DsnPjheh5lKz8dC0SvBSHRm6jeitDsITXIs8MO5bxka6py4zCebr4h8QBDtL0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775174370; c=relaxed/simple;
	bh=geopkyWbceSmNN9qSVPgURie3vw5eMbQizBVsAgdPD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kwfgxjyHIXQWBw21y/egEdoPY8ho9a4CJuFRpBaF27QGsi22F5shB7JfHbOig624mLgivsvZMdf4xkl9dgcXyFtG+ygJW7CL9k/eFlrJu+SbP3LCSQfiL1reVjuVQIz9XrHPNVB36OCrY1H43mF0Q2a4RV503/Y7kmqJkWU8CgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Ldnord3o; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632HotIj764424;
	Thu, 2 Apr 2026 23:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=cw
	J3OgamUWGqcBmtrsWeOdCacIKsHtAMcKoJYuPZTeE=; b=Ldnord3omab7Y/ybvr
	e6J+FH1TPv0w22rvg3ojnbB7Pmo/IQtjvRNQggS0uOztY2wt0USb5Q+PW5eqhCDo
	uNR+IY7AxeGpSnXZIWJbsO9eHvzMTc+4IfipuU2FkwJho7QstmSTPIi4uVg7uJC1
	TfN1Hdgpxd42uiG+59KtdPixAKNvFHHJFsVVUKzJwjxeXjq97A0fMbADFsxKNun7
	fCYtfRwQCAbhHgZQRHUsCQvGcaqF8sGt27fghobKDS98O5RH8VgMur6Ne79jXvvb
	55HKhHKw9zNaZp0jeLjafNRfTPq0BDR2Gv1HJ3KSQCTIn2LypfKTDaj8pdZqAfIV
	ZGiA==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d9rm2ffqh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 23:59:10 +0000 (GMT)
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 8D8B7801ADC;
	Thu,  2 Apr 2026 23:59:09 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Apr 2026 11:58:38 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Apr 2026 11:58:37 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 2 Apr 2026 11:58:37 -1200
Received: from BN1PR07CU003.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 11:58:37 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idi7xK30nP195qIZB9YCSpLblvK3aVzRt6CkTFTD/rHmaZ5ZBoNWcZi/MJY/Xq8aogvp+X+4YQHUlERemJXs4Hxl2SKrev9IIAwkvzW/OFI7qwBjjooFRaeuP9NihvQIuWaiKx+3+2QXz2HFiGoMY54RgUUFP2GRZACA/tEdIH/AKmHcKBeNVtowQPQBojyDZgFOHfO/EpSrfsnBqdZ3pIpkpPEyCIHI5vS6jUOXVEj3R2wwUh2Bk0Umtsb/p5HBoxUEESXaKQXuATe6LpEk3M9Hxd57Qb2jyv9XugQGY99NtAYL8J67Vgvpro98fgKxH+qEOhUDPPxBVqWBF+2anw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwJ3OgamUWGqcBmtrsWeOdCacIKsHtAMcKoJYuPZTeE=;
 b=bwVQojMEc+nfL68OfrBFC4qbaybFB6wBxm1/nuY5rX4r1sQ4L9BHYNbBpEyuAmAY1M66+Kuj4HTF+/A4hq4me76/ma8kn9iZCj2GlaWR+xD0JCN1YEZ/aTKpzxctYCPUHpbz3mEg4g89QbDEYBseTXpTuQO/dEDvCaZNU1Nwntwn9kKI+W1cUITmForYrW7aJBFd6RdFGK3dOdMRVaHlijAKQ8hHlFTad0e1Yh9j4T9zecw4Tp5WvYKgwKkdynvEacER3X4ejVKm4WSBBRuXqb2m+aQlCzrQjbPIRBNPKIvMuQpNrnq9jQri4ynJVBSgcr4WlxKRc3fwLFW17gQJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW4PR84MB2258.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 23:58:35 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Thu, 2 Apr 2026
 23:58:35 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux@weissschuh.net"
	<linux@weissschuh.net>,
        "cosmo.chou@quantatw.com" <cosmo.chou@quantatw.com>,
        "mail@carsten-spiess.de" <mail@carsten-spiess.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 1/3] hwmon: (pt5161l) Fix undersized buffer for
 i2c_smbus_read_block_data()
Thread-Topic: [PATCH 1/3] hwmon: (pt5161l) Fix undersized buffer for
 i2c_smbus_read_block_data()
Thread-Index: AQHcwvycAnvFBt5rqUaiYZvTdRd+bg==
Date: Thu, 2 Apr 2026 23:58:33 +0000
Message-ID: <20260402235819.86456-2-sanman.pradhan@hpe.com>
References: <20260402235819.86456-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260402235819.86456-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW4PR84MB2258:EE_
x-ms-office365-filtering-correlation-id: 6984e955-18c4-452b-cd4f-08de9113c075
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 7ZGKEo67FgCHW0y6FTt6CICXxWN9ilwM+hRjHSIBKJcvKko4ULlA1VaumLNEYOIJ26uEsdx6xvYmQWBD+nrhnn2QGzd2iRqosBnpSLfIY5kdsXavopfmsGQuKq5E/Fq7ecmvqefOz60FRLMSicUYpQ+Y2EPNXFt8dVUgeUhxxNCpoa4E9K7Bo7aCEyuUywWLk2AzqwK3iAqBsGviK72SIQRg+WKygH/G8P0T73rQwhhAYyQZt/PY1Xqd3Ned4mWNHDqO6W+lBvcMOGhm0guWmjtKVoX5teRuyvA6gH3wyXF747WUFOIjn73NPqtDQzNn89QFkvWm7vHzTfnDxnIU/SDwWMw1+BeKivwKGNumqLxBAORKmSG2I4l+aK3nYMCOutmdxJHcm2ItRk2wmPqfribJ6sTtM7cc5PARyS+LllEyRPfd4eqfJz/lrh/f6IEN22IXSk+lU/Ct1Q1X7rrFvpcQAUz38NaMewfia5cK99SYVZveUiFhKCFilpR/eK4MfnmVQx1aY+HM/UquNWKcgp0RL3/fkb14whbE42rRoXCzPWXW2OGu4BmXwVi90NV2e9VgC3vGtvixgdahBDWzsa9CZiluQgqliaxlarmUEZPj3+zprIla3PU8DiEPeHWCciCxJsjOvAg4sF2ra6xKXsj8IyN+rOcUTL/XzIProGkCBx6QzvYDZoD8H8Dkzevz1rfKRrnSG5+Ey4MO7iPSERMVPNF5afh+km4CYQTMdZ2L2DSPyGd1EsMhhAinqUD1KuQ3M8VL2rUQIsUwlWyd1tSvZiTod6x8e3NidiO3uBo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D9W6t5Zb4EG4ex/NoIkUCisPhh/+y+2ugesYdHTxRhyUbbi/+gxoNzXEFu?=
 =?iso-8859-1?Q?SHt3AzdcLxD9DdTgmPnkQ7qT1RvRBLKyPTAh/0AyQiJh3fopgUJUNJ+v2F?=
 =?iso-8859-1?Q?Lbta0AemKMw9Mwwv/W6x8P+OluQ3bFRD1ip58WywGetnlmmbsEVjmTi9K5?=
 =?iso-8859-1?Q?4EXxQ5N2Gi4dYFZZD6cjLEYA/SnpMnV6RZMfvk1MdEQqkCWeba8mbwAyyq?=
 =?iso-8859-1?Q?K+j8975EW0ycYc/SNIylismpfElaNV0iDAW3TVmZJA41U/pBO4cuYgUZGJ?=
 =?iso-8859-1?Q?YfcLJMeOlzbdhu9bjbJDrAxq9MbsIKAmuzT+ZZA8CuJkn7qm1KFqwLxm0Q?=
 =?iso-8859-1?Q?8AaZM1dqgdYcbCHbVVqYiyPhCKU77uXemf1LftcTrhIVSm7NuZ1tlM0yuq?=
 =?iso-8859-1?Q?aDnhGptsKMadXQKwHSGGiZ0v2WK3Y0EBloUXCscBmASd/ZrdMa0X9rzQD/?=
 =?iso-8859-1?Q?IfvKnyx1zOOqf/tG8hgf3E/eOuUoJqqyQuY7DiJSVakToZMkS1cqcHHMN5?=
 =?iso-8859-1?Q?PCmXVF8zuqljvNMhiU8Qn0SG3bVsa1hm+2Bizisx0nRcpvLpIthJEfz3LL?=
 =?iso-8859-1?Q?4GhFUNzKOEKjh5uyrSWSiA3ZdlQuUWkEbiKRIVHNDcH/nh0BHBC4kydnY1?=
 =?iso-8859-1?Q?J9H5E3lnl8yOCt82HOubHn3YWAaF9lFh+MEZgKB7PUjiQ5cZ72kPcK6D93?=
 =?iso-8859-1?Q?iKxSe3xOpyeG2mObJ81batyCReYy3/uE7RZ8EqN3xjxnIas+scjGZ7qY95?=
 =?iso-8859-1?Q?Dubun0uZgmIDIWxemAO/HxwQ7jwgV8gWzr3eRFRhtZyWGXfe+emjVqw8BT?=
 =?iso-8859-1?Q?dtCgJg1FaOasrjeyFcjiVZhFPw0BWUi2z4Pq3qFLRTM829V9cTmkdfF+Et?=
 =?iso-8859-1?Q?P94jp88s9PFThk6droTdFMV8nFogECGtUZ/gFrmg5lOiF+geny6mDhkvz7?=
 =?iso-8859-1?Q?5sDc/cZ6avHgVAbsvlJrasrYAH8T/Li+s7uD6Wv37iQOtYYjn5Glo+llW6?=
 =?iso-8859-1?Q?img2UA1gyh7LgAKVTfu3V51Y0WNVKfVBmWh0EFxcUwAUHnGQ5+y86v56bO?=
 =?iso-8859-1?Q?oozoKre9tf88fKz18XTiln51MY6jZjYIGVO8b5pw28siOYEw60WLiJZSzh?=
 =?iso-8859-1?Q?6FGTGfDzTbpuW6/HkyRmLnbEC3oIqevUOZrTtcvqEtgvg0NgY5/NNbbxTu?=
 =?iso-8859-1?Q?sDIA3FWR3tCGoDkqbvwugLobyi84ioUSoekjAKqjUkGONLwbh/+uQtOhtM?=
 =?iso-8859-1?Q?Ur0xlJw8eIltbmVeTQLf/rnruHFRbrYAYCCPH9/TK5yLVZoU7GyksQ7kim?=
 =?iso-8859-1?Q?w3yKZSDzqzm5IG3OYawMGc7Voh6wmWz5Fty59aMjNthF6EEYEkwXrYjNvh?=
 =?iso-8859-1?Q?DVTmLSrwpxAc7y9WdAD8a8EUMRBAfayC5N24h6mYfkmiSUhj7IXImGbfA6?=
 =?iso-8859-1?Q?7YKuSrRRHSEbCYNfzuoYmY2tdOJNPqhPw5Y+AAZ81aKllibd6pYANZv7u2?=
 =?iso-8859-1?Q?qrqehouLlHgG3w9MPSVY/4c/oDU2YsoxELVSHYGfvQSM9sCPyglxhPs3eg?=
 =?iso-8859-1?Q?TRAndQU9WIYDahSJEwJSoj3Vm89/G7/roq2RnGNUcHcj902Gdi/sF8U4Wo?=
 =?iso-8859-1?Q?at9LoHfAsMeYOH/etZlDz5IpdmUD//oPEeGneozauxXKAWsrhSdoY6WFI+?=
 =?iso-8859-1?Q?waQwx8idAMm3XNlAZ9q2LT3GQDqTvDXjV6VAk7V/hp35KnIr3G5FeC6Y8K?=
 =?iso-8859-1?Q?DHp3X64CywWxDldXCqWW4gxlhs+VoRUF7w17RfD7cyIMYR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lhfqGVVN1CvuH8363Qqo/hh5+jVnqhqdiB39DwCUk46pvUNfstidd1ggXtQNwTRepgo/LrlTe6hi4T5kdsu79bKXLFhgdW4FtgtcKjvAlW+bi1P8FIXihplLh/o5Y1Zt7L1mxoVZkMiRRXw/qiD9j8JhiVhxqZmapEmo28almnEyXMYaXiYItDStCTdrNHKk8+JU2I+QzF0/njsymJuRNxxaSuu7V3ESwuyxnGjYJCm3dZGtbQ90VIfGcuEFF+QCoHXV17VYxrLmXylhb5SrogWCg87tD1m+c30RrrwA6+/bPhl+482m8l+QFrfmCAKBUyffM+fcwQxRAGLYf073gg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6984e955-18c4-452b-cd4f-08de9113c075
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 23:58:33.5789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYYrjiBOhUD/WZg/7CqZDQTK9vEoiv1djTIu1/zrikpGyoirfrfwbzfBHijhfnTpKTP1cnCHWWbOkFtzisKvOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB2258
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=YNCSCBGx c=1 sm=1 tr=0 ts=69cf02ce cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=g3u0LPWLDYfGfufhFw6-:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=psGTehlhpka0orpKOXIA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDIxNCBTYWx0ZWRfX/8N4z21QZ4op
 Umi1efJSJu5CbTPdfRYaeVGmNDp/r0a8odCVrpZzt5G9doC/8HYElPXPx/YHo/bfQXlmtCpYykx
 TKQYUoz2MWpBRdPQPv6vYv2gIA6J6JKUce/dS/sNcCsIF7ak4hq6eJ/9vTzuKzB+26aO5VZBkAm
 NAnVdTbI9yfhzFZ6DiatdFB+J3n/5+37CzETWM++RHdDzextkkqJziBJFJ3Ko3r3ddH/MTWxwtQ
 ZFfJcA0+np47Gewxjbua6XQHYq3L+PcihxxVFdzTaxY4hD4z9bntPp4TS+nqtQuNPAJbG9voU4l
 xD/x3hVAU0kiOk8fRSPhQMa5Oobf8Se4j3FYXtbhgTBNnFEk1DeJMcffEG1nsoRdZAy+Dc6c4ux
 FtTRBvbcFf/pEKeu00zT/5lgKFB7W3GeJR94C5QsYEOQ/pqozSlFbpCU3fFc3l9OA2wiqsW1HE0
 EwuJCqpoRpMWx7Ivl8g==
X-Proofpoint-GUID: xSYGxasV46Ekbj94QTpZr0PIolFQwDRV
X-Proofpoint-ORIG-GUID: xSYGxasV46Ekbj94QTpZr0PIolFQwDRV
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020214
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233126-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hpe.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hpe.com:dkim,hpe.com:mid,juniper.net:email]
X-Rspamd-Queue-Id: D7CFF38F5F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
pt5161l_read_block_data() declares a local buffer as u8 rbuf[24] and=0A=
passes it to i2c_smbus_read_block_data(). The SMBus block read=0A=
protocol permits a device to return up to I2C_SMBUS_BLOCK_MAX (32)=0A=
data bytes. The i2c-core helper copies the returned data bytes=0A=
into the caller's buffer before the return value can be checked, so=0A=
the post-read validation `if (ret =3D=3D curr_len)` does not prevent a=0A=
potential overrun if a device returns more than 24 bytes.=0A=
=0A=
Resize the buffer to I2C_SMBUS_BLOCK_MAX to cover the maximum SMBus=0A=
block read payload.=0A=
=0A=
Fixes: 1b2ca93cd0592 ("hwmon: Add driver for Astera Labs PT5161L retimer")=
=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/pt5161l.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/hwmon/pt5161l.c b/drivers/hwmon/pt5161l.c=0A=
index 20e3cfa625f17..9c450bcb9dd8c 100644=0A=
--- a/drivers/hwmon/pt5161l.c=0A=
+++ b/drivers/hwmon/pt5161l.c=0A=
@@ -121,7 +121,7 @@ static int pt5161l_read_block_data(struct pt5161l_data =
*data, u32 address,=0A=
 	int ret, tries;=0A=
 	u8 remain_len =3D len;=0A=
 	u8 curr_len;=0A=
-	u8 wbuf[16], rbuf[24];=0A=
+	u8 wbuf[16], rbuf[I2C_SMBUS_BLOCK_MAX];=0A=
 	u8 cmd =3D 0x08; /* [7]:pec_en, [4:2]:func, [1]:start, [0]:end */=0A=
 	u8 config =3D 0x00; /* [6]:cfg_type, [4:1]:burst_len, [0]:address bit16 *=
/=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

