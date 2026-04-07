Return-Path: <stable+bounces-233709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA+mM3lC1Wk73gcAu9opvQ
	(envelope-from <stable+bounces-233709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:44:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3743A3B281F
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3154E30C11EB
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 17:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEE338A29A;
	Tue,  7 Apr 2026 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="BnOO6I0S"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55CA30F7F3;
	Tue,  7 Apr 2026 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583573; cv=fail; b=YlzROGG8g412o/KtaccTHtz97g/0yF9hdq3zi7YgWkKyWZeeMXjsKf7wYFcmrB5lG2chLmBce1LdT/Zoy+oEXTvq/YGGH+8whzlqbZf/LjDstI2WbPLoExg3blM3RiInt+yefgkPXMfdfMHgYTvKbCgfV6VOll0DoFhttwcFOaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583573; c=relaxed/simple;
	bh=wRv9o/J4lD8q1KbPRc2180WUsiLFK3wk1xCtsLb1m74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lDK58HieewG7uSWzWDUjrOpvobqzy9p/m0Os0OEeWbFuopEcMChAgqoskx8VMW6tZw2UgJaxDIsBERg9L6sphCCokVl79y+mby/ctUcjxwM91Kqou6cwm/nh5wQI1dmg6n82+eZfWvuXb6QknbinTtNjhiHcXzB5x4JeaS6wcbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=BnOO6I0S; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637H0oXj2113087;
	Tue, 7 Apr 2026 17:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=Pr
	H7YtZZMfMrgiMHLjvp09TwZi0T5a/gzc29R89p/Yw=; b=BnOO6I0SEHWXcyV8kw
	bAv9Uo5vMdYan+CQUgPWYHjIFAKMGIfmYhQMRNndF7TQzorSKxH+Y+nxOjee+Zqa
	M+wdxjED+HSLDK/gfeqKhMjxbMFb7KFY3dO44BJnQpocZTDYTjbai2KycFZUDOh4
	puEmlQiqhI9Cy+qQSVAbr0kZx3sx86X/aVnQpmpcpfC8iwS7agIlSo2rEejo10JA
	skRFGDJUstXTJ+cAd7ahaLtgAfjsxPcqbLqjQT+TjQg0nWIejQDkGZz1BIWtbAK7
	Mmgt+7QDMv/8GLDpn2wSjmi2VQDdgBUKSptIjHKhDnifdrYuI4GBc3TFS/+yFDnw
	gAOQ==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dd494t2bj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 17:38:59 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id F325480171E;
	Tue,  7 Apr 2026 17:38:58 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Apr 2026 05:38:38 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Apr 2026 05:38:33 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 7 Apr 2026 05:38:28 -1200
Received: from DS2PR08CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 17:38:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYi9ywRIIJhAes720tjooctPEZzBJvNawkedEnNmzeZpJnRQECXKl5hMmsXimRn6S20CCASKndahHJ7wIGaOBvi1j7PGFIaAVXxxBDaQhgCEr2RwrNChvEsxCac4z491msShWgx3gjTEPrkeXXEWyX1KZdK/tqJDwpbO/Um4istauvTlesfGf+tq3CwqIPFJGV3auIEkCQXbFMQgofYqCoK4fSCYF0l8I5s0arLBzlxn87DKTSQEx4WbV+SDNwugJ985beW2CVXoKphUh3vVgwhFYfgUPYMfA5tx4dFAnlCJyct5qu28q97T67hKkBC8kepc6xmromiZMzbFsINFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrH7YtZZMfMrgiMHLjvp09TwZi0T5a/gzc29R89p/Yw=;
 b=Hp/H2Sm3HBcrAzGWpdUenSesSlN1fcJ+tu6/e4UBYdixbInxDdSRlqhJOAdA3sqUFrRfo0EpyfTI/LXyiF4JQYOmocKSJp3xogYowXR6rBoYR57PxJ5XQinBVf9eu0E0IHsHfbBMsrFysp3DKF6Kz7RyPx8tX3t5JzxavzqDRkbwZN4X7hhXbeqv88Y/TSddxXXA4u+YpvPbQSKtf+BNMK9nzdyIkojx74CFUflgDeeYkr4r6Cc9M6STurkITAl8OBR5+Zhjl6WHedztaMuTJAPAxLEG73fXHD8Ix4z8b8PW8ue/fwdwIAoCBDLqJZlCc33THNan0xRvSQcu/Gs1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by DS4PR84MB4043.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:29d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 17:38:26 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9769.020; Tue, 7 Apr 2026
 17:38:26 +0000
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
Subject: [PATCH v2 3/3] hwmon: (powerz) Fix use-after-free and signal handling
 on USB disconnect
Thread-Topic: [PATCH v2 3/3] hwmon: (powerz) Fix use-after-free and signal
 handling on USB disconnect
Thread-Index: AQHcxrVWLd/rOXZi8kyE8kQP654q7A==
Date: Tue, 7 Apr 2026 17:38:26 +0000
Message-ID: <20260407173624.247803-4-sanman.pradhan@hpe.com>
References: <20260407173624.247803-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260407173624.247803-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|DS4PR84MB4043:EE_
x-ms-office365-filtering-correlation-id: 9c57c20c-847c-4949-9ab5-08de94cc7946
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: uTMWD654WTo4SGdM5EBZbyYJDcjcHuaM5u9T8pcwz2xu0q4hnAZZZkqiDI2JaM82PGdXnGuAiRehKdkGow6QrvMqo/Y039QKh15p1eVb7xxPcDh5k/xe8UJIBjxeheLRZtH9ed1HyRj4NKMdBg0gIGCuTbEm2M8Bn1uaWMD9/pvlcm7AwnEYXTK/68CSyduSQDwmdhevdBlAwMccy0BqAa34qjDk+zm9ahQNrP7L+IVNUMkcMgMkKzHj0+7I9ebAdYu2NwhVQXGfEgYpN/0oB73duiQzUEmXsiwlzbWxBYSokzBe5gPux0TwO9d45B5dvDHghhInwePcRQ9EfO5zoti9i87JYDWeYtrMq/L1fBxfUILi3Fvpl+n2Nu4n9nEQkyXNZpjrhYaRjia2mhEy09J++EKQg4MGLKs2oITukEVeVGJcHjuACMAxa3x+gM6A07nj07Bst+rbnHh/IRWF/j273pwkWz0km8xCu+jCepbROhkshZROqcC1kqQeKM1oyS+1NJzsUQCcGeDmMCtKHX2+PtMuErsA+VDlmrRLJSLc9eLgF8G9WI00DzZmxHuo4xJHjxKzxxgWYvKYVKGkjdZ0SZ3kJ1GDhcpodbTtkPTQBL8QI7OVmlElWjyeA8HIy4v+aJNjukpkcUwKdNh/xzn9HwUkAj9YP6T1HHPYe43d+kFYXHJwE8dkI1vSf8r/tFWd2iw9y+92obmgScUp0DhOGux/70fFKJEcmOtpW3lbT0ZJvgstvOSnkkpso3i+sEHVDlmGLrEnTWUoU0WkAIAq0i6N7w9owNucovV7NpA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tVxcJk0jDojmftqPtN+gPo4kK7T76q7goNJ5XxiWL+di0mPWzy0Y21Ahfa?=
 =?iso-8859-1?Q?5HOTUaRRDPvd4h7z/Qt0gtrr010b9islY2m7lBW8OHdBI6Sg72R6bspxDe?=
 =?iso-8859-1?Q?sRmrlTXnLBX99dRHMH13BabWzhYOvHq/5e3bfUMf8Vr85DsL5CztRX8M11?=
 =?iso-8859-1?Q?iLxBcslOi5yq4uJS68WCj7luCdtuQoFf59DwIW/5hkjw9ExkOPf39bdtJ2?=
 =?iso-8859-1?Q?7vzRgw2l4KLMKJKgoxcW2ne8luY5yiXoq01wshuefi8tsEAdqvwHEk1C3t?=
 =?iso-8859-1?Q?8KQB6t4XRY5mWHBUgdL+A0CfyfZ2J7evkZHvKG8wOdug1ih4Op43d64E2X?=
 =?iso-8859-1?Q?VShkeRFBOK3NFV59phYsigRQaCvYbPX3qvIq8fM0+GPfsDfkobamQhNhxN?=
 =?iso-8859-1?Q?HHZXqW62MyfssbnMG1WOotuQDNIlzeF385juDKdHwNO6B+tZ+89BphTqse?=
 =?iso-8859-1?Q?5sOoj01ySLagcPcOCmHPI7hhi+mH36xw6zKe2Aul67T+rN6a0IVNEX614e?=
 =?iso-8859-1?Q?kulSK8HqYmm4W7EgIUL8Yhn4hGhlnohuXU4qXXw+y+QBUKXQKxEobbKKNp?=
 =?iso-8859-1?Q?P4wVrKzhSRpy7En2dy/rWHcHuoMuPVPBHUwJoA47TukfKsK3xczXT/NNoQ?=
 =?iso-8859-1?Q?oH6GYeBd36Yx2v5xE+MoX7+Gs4zW51stpfyNFz9144ST8npGl7KoNr08aY?=
 =?iso-8859-1?Q?4ndPwEydC3dkSLNwiBxgNDTkGCxRn99u1OzeKgX0N5Kb922e6S3KGPPgso?=
 =?iso-8859-1?Q?3FtCRycMarLC+auyWyhmjvStm5HJe4JQuS1MJHrwn4aAS8sJC+uvIHKWmf?=
 =?iso-8859-1?Q?i/phP8dBSGz8N6lKe353OeE1oPQDBXlh4VKahbgpRFzYrEQzyisXjODmd1?=
 =?iso-8859-1?Q?9pnfMNrzcFuoYrbxgSzJFMmJIMMY/TvcSS56AiIhdPDd/FPiT1Pkf2jPvI?=
 =?iso-8859-1?Q?ObnjbNQf30WH/8cWLFUeS03sWnXAPkZkD3gBq3G1OU7xQNZV8Xu7QQ+IXh?=
 =?iso-8859-1?Q?/uMQcQEgFI6kmBEKO2dXjovQYYw2eXIdMmDQ6i7pdvNgvOczQk/lVjXFh6?=
 =?iso-8859-1?Q?QaL8o2X+nF1HTbsTLJlbXZVEhkQQaF3L4mV7dHdKf7/o2J/BTH4WZcaxfi?=
 =?iso-8859-1?Q?asR7JikT0BLfyZXVnO7CkqqoX24ZXbAsVRwdUeX2C6iflOICDoz6azOblW?=
 =?iso-8859-1?Q?QpRYuI8DU5ejW2sbSj4BhU+/IHp3DfzrbOBrXl3eTQ7oljAAuDRxNDyCPO?=
 =?iso-8859-1?Q?oQuKuR9A7LhdeDTpfaSEsKBbhFInJp16ojgEZZy0UQ77RywSGHSEq/24Po?=
 =?iso-8859-1?Q?vxDIv9njBJ/n+8CDbYz5wEGz0hR9zrkpqvpeMkjg/WnrGlB0jPiqkfPbgw?=
 =?iso-8859-1?Q?kjdskkeH8XobgpjKtjIea/egG3pjloA2QUuSfgG+1nKPd6BLpY8CnzbAJv?=
 =?iso-8859-1?Q?t/49u84lV+Hf9BAnkTOyH2q50GlXmtZLQ93y05xAKLPprLDvJHUV05BzIS?=
 =?iso-8859-1?Q?0v9rjlhOOSOznzs+R38WgLxc3jDlyHIAqEiU7QSA5JP6N3NEkd6k1yG6ww?=
 =?iso-8859-1?Q?/G3qLm64IsVKblHn04RywP9xSCUNzirepO1FGw3mYAAGTa1sLuYvxg85sV?=
 =?iso-8859-1?Q?h4EPTGUMwI9XItAbfefWMRhgsLVpsz2ZdRdJjvnVQfmMklIldncNL+zVVF?=
 =?iso-8859-1?Q?f1cta1q3W7XsdaSC8x6cmznfSGG2kJLw/9qJnjCOGDCOusSkwaDOzv8TBS?=
 =?iso-8859-1?Q?ZeQOohWJ39RhgA1QTAntooaOSZVsIrUkqc/3kBYdaMZJLoXu/GzdG9S9iJ?=
 =?iso-8859-1?Q?Tgi3Ab0p4w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pLNG3ctS6JKH9o6m/rSzHLcOJpkJC/f0jC+m2cp1pYUt2CjdKHCqVHqN7qjNKPt7QfXZHqC9kgHQVWRgD3L6wkAuHKj0aNadwFOUG2ck0zT/a0LS/hKIG6idwzvEWTWNv5NAEaeiRJWve4DcXbNuATbrjfQelL39T/hXy6MXhmKlI87o6wVJjltHczBuuakhAkdc5E8dUc/CVe2AwQe//GtTV18vjlHHgaPmyndSH+H/AH/jT8nok+4EXlgVR+PB69XhnOzNWwWG0bA0Kh9Wbrt+H9zLQ0SCpnGlTTccHNsY+ixpF/dNhWhwt+dLr00iA9cvMXsPkLzkNTsPwisSDA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c57c20c-847c-4949-9ab5-08de94cc7946
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 17:38:26.1269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tCNnbfg5rJC6EDD+HLj1IaD58w6zgIY17BBea0y9cSNmo7EugN6Q3MJQfYs5gtPXv+fREvPD7e/6oz4aymAmOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR84MB4043
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: U6q2tonWT9CQWeUDgFb1js-EKe3kI9Pi
X-Proofpoint-GUID: U6q2tonWT9CQWeUDgFb1js-EKe3kI9Pi
X-Authority-Analysis: v=2.4 cv=aoCCzyZV c=1 sm=1 tr=0 ts=69d54133 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=ModqzXLkJJ0tFyq98apW:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=BpGXxSgqvIGdrXJJSgAA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE1NiBTYWx0ZWRfX6WbkdMZPRAYo
 h2eNT0oHe5+v853ads64wVI/kBzDijgJ3atXpRNEy8LWLeDQAvnNST7ALtHg9kAYckuQuibCXMG
 touy6DWe9DeKqP35zo6THFUu8bFy4wTayVavlF8BvTma1Z8dp+o/S1Ux52yMAxx6bjk/YmVsWwT
 vh+ktrvxz12g+Yfmn0jscarHVq0YfP7bNJYcPpTQecvc3YmyQPSrOr5GiXjROhV1LU5mdVYOYrn
 v0cIGOCdcrj7kD7ry0P+4wqKDGSODBpFIENjhQbX767UsLVOdOkXZwgi2dy8k70AerGCr1fPJ9Y
 0ks4BwEot0Xmr5W7wWCcqHeh6H7i5tdPqgbU90x6lWMdorVc/X+t5TzpX0zIhxK7tUBr3NL0mja
 0T7F39v0guhqmd6iCsYC4GAqC3s5kCCfPFZr87wJWSsz4q8XC51pPvcffPRFo/ZOB1GYBWfMpSE
 qMn5hHMbBVMz2SbJHAg==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070156
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233709-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,hpe.com:dkim,hpe.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3743A3B281F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
Fix several issues in the powerz driver related to USB disconnect=0A=
races and signal handling:=0A=
=0A=
1. Use-after-free: When hwmon sysfs attributes are read concurrently=0A=
   with USB disconnect, powerz_read() obtains a pointer to the=0A=
   private data via usb_get_intfdata(), then powerz_disconnect() runs=0A=
   and frees the URB while powerz_read_data() may still reference it.=0A=
   Fix by:=0A=
   - Moving usb_set_intfdata() before hwmon registration so the=0A=
     disconnect handler can always find the priv pointer.=0A=
   - Clearing intfdata and NULLing the URB pointer in disconnect=0A=
     under the mutex.=0A=
   - Guarding powerz_read_data() with a !priv->urb check.=0A=
=0A=
2. Signal handling: wait_for_completion_interruptible_timeout()=0A=
   returns -ERESTARTSYS on signal, 0 on timeout, or positive on=0A=
   completion. The original code tests !ret, which only catches=0A=
   timeout. On signal delivery (-ERESTARTSYS), !ret is false so the=0A=
   function skips usb_kill_urb() and falls through, accessing=0A=
   potentially stale URB data. Capture the return value and handle=0A=
   both the signal (negative) and timeout (zero) cases explicitly.=0A=
=0A=
Fixes: 4381a36abdf1c ("hwmon: add POWER-Z driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
v2:=0A=
 - Also fix signal handling in wait_for_completion_interruptible_timeout();=
=0A=
   original code only handled timeout (ret=3D=3D0) but not signals=0A=
   (ret=3D=3D-ERESTARTSYS)=0A=
 - Return -ENODEV instead of -EIO for disconnected device=0A=
=0A=
 drivers/hwmon/powerz.c | 18 +++++++++++++-----=0A=
 1 file changed, 13 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/powerz.c b/drivers/hwmon/powerz.c=0A=
index 4e663d5b4e33..0b38fdf42ddb 100644=0A=
--- a/drivers/hwmon/powerz.c=0A=
+++ b/drivers/hwmon/powerz.c=0A=
@@ -108,6 +108,9 @@ static int powerz_read_data(struct usb_device *udev, st=
ruct powerz_priv *priv)=0A=
 {=0A=
 	int ret;=0A=
 =0A=
+	if (!priv->urb)=0A=
+		return -ENODEV;=0A=
+=0A=
 	priv->status =3D -ETIMEDOUT;=0A=
 	reinit_completion(&priv->completion);=0A=
 =0A=
@@ -124,10 +127,11 @@ static int powerz_read_data(struct usb_device *udev, =
struct powerz_priv *priv)=0A=
 	if (ret)=0A=
 		return ret;=0A=
 =0A=
-	if (!wait_for_completion_interruptible_timeout=0A=
-	    (&priv->completion, msecs_to_jiffies(5))) {=0A=
+	ret =3D wait_for_completion_interruptible_timeout(&priv->completion,=0A=
+							msecs_to_jiffies(5));=0A=
+	if (ret <=3D 0) {=0A=
 		usb_kill_urb(priv->urb);=0A=
-		return -EIO;=0A=
+		return ret ? ret : -EIO;=0A=
 	}=0A=
 =0A=
 	if (priv->urb->actual_length < sizeof(struct powerz_sensor_data))=0A=
@@ -224,16 +228,17 @@ static int powerz_probe(struct usb_interface *intf,=
=0A=
 	mutex_init(&priv->mutex);=0A=
 	init_completion(&priv->completion);=0A=
 =0A=
+	usb_set_intfdata(intf, priv);=0A=
+=0A=
 	hwmon_dev =3D=0A=
 	    devm_hwmon_device_register_with_info(parent, DRIVER_NAME, priv,=0A=
 						 &powerz_chip_info, NULL);=0A=
 	if (IS_ERR(hwmon_dev)) {=0A=
+		usb_set_intfdata(intf, NULL);=0A=
 		usb_free_urb(priv->urb);=0A=
 		return PTR_ERR(hwmon_dev);=0A=
 	}=0A=
 =0A=
-	usb_set_intfdata(intf, priv);=0A=
-=0A=
 	return 0;=0A=
 }=0A=
 =0A=
@@ -241,9 +246,12 @@ static void powerz_disconnect(struct usb_interface *in=
tf)=0A=
 {=0A=
 	struct powerz_priv *priv =3D usb_get_intfdata(intf);=0A=
 =0A=
+	usb_set_intfdata(intf, NULL);=0A=
+=0A=
 	mutex_lock(&priv->mutex);=0A=
 	usb_kill_urb(priv->urb);=0A=
 	usb_free_urb(priv->urb);=0A=
+	priv->urb =3D NULL;=0A=
 	mutex_unlock(&priv->mutex);=0A=
 }=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

