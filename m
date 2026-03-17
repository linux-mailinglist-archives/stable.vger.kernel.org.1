Return-Path: <stable+bounces-226882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCGmFVOYuWkJKwIAu9opvQ
	(envelope-from <stable+bounces-226882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 19:07:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 016462B09F8
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 19:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59A763032055
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E6037BE94;
	Tue, 17 Mar 2026 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="klJpxb3P"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F03F331A6D;
	Tue, 17 Mar 2026 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773769636; cv=fail; b=SVkWs/funjHt2Xp8leeuks7rAFRGEVzdnXokwnfs44XPBo43ulgl9tRymCb/dElejGrwyVn9ZaeaWmivDwogIqDJotJBnjgYBPnWmqkPi3tRX9hY/5wVJnwwnqQKEvKH1zBIKPmhsTNcTTg5suwhtYfCVurbUWh3AM4+5hMUnJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773769636; c=relaxed/simple;
	bh=IzjhKOnqYWtVwT67ZHbGps4E4dB4sVck3DGxBWyZKe0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oTO9ChXioyTLZRs3giSu95grVe108WaN0rg8OPCQa50L4a0LpfOX9iQwdj9D80yxRRBTLOSW7qkVRLaNbS8lMcINWVX9WAy7JqnheD3baB1gaxjjM9teoDcbzHRxxojHh5SVoCdZBli1SLqjF9m4MCU8gG1yz5WNHem+5Zu71rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=klJpxb3P; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HGweio1695431;
	Tue, 17 Mar 2026 17:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=CL
	2lMm5LkuH/0LxBr57gXcE3uZJOJEjhzeIfx+YADi0=; b=klJpxb3PmrWcy7ESaS
	8/MbFwvTcwzD/dX28S2ibABjUpCah3czS0m+Pj108e84QHnCAzUB1azlTTQs+D1W
	Y8BznZqf4fXZ+p7kemjnUQ7JAw1mcXe++2XtgiENSUwfvHpBV044MS97BkKmtIuK
	pSIVv1YP70GlCmdBOGtNFeM1mUTk9naCKPP9FpwjCgxm++WbPhcnv/MbuYAOuCTM
	GP6cQzWV0cqf0Hb15uph779Ag1pzMnGPAvQqbof1Gky3zkMkKNU2Jl8FRAd+XJ1O
	8EGVeTQ5kHnYggXa+N4fYJK72Nz88vMt0YPo3nroraGR0sblLMGX01/uJtu/rcb3
	T0VA==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4cy920jc0m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 17:46:58 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 7EC95D279;
	Tue, 17 Mar 2026 17:46:57 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 17 Mar 2026 05:46:57 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 17 Mar 2026 05:46:56 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 17 Mar 2026 05:46:56 -1200
Received: from DM2PR0701CU001.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 17 Mar 2026 05:46:56 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bE0RXij9OHoIv/FRE8x16ZDtN5afIkLviYpORnSqdL8r5Nb73/XF0hIegP9AMjnbqLS2UQWWo61LI8cZh4lCDRC39EBIf9ZIopPdZjzTKLOt+HPjZdvQzmsd01R15EBwhRLv/Sy2iaasyjsuYFcN5+GDlG/pr4G8VR4UkCGvk0wB8bKd6N23QqQ9/turjwF++TRPQC7yaRyhCGI5RHvaBkBXGU67gSAqUtihAVzxZ9x5idF0VXwjoW6emFAXiORfwK0EPh+3Ts3DbCrG4ahyjTnf0uoHegoAVtChIC/xjJx+/R/VLx/pzoNo71QBadUycMKK9yNnhRpAu3X9OgWa2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL2lMm5LkuH/0LxBr57gXcE3uZJOJEjhzeIfx+YADi0=;
 b=opTRjOE1Jf7U+NGr9aHjIeATi1Pzfo+SVKTJ1vrYFcT7FWN/uYy9je+MASHvrweid5erg5B7Njuko8SCVtRXSjUGLDlLGg+XLiDhV6sAumPKgIdXk0eHxLbAkHwuO4I3lBWJs3xao732oxr+8xtR0SHs1xZDaYXNj5L2is3siX9LR0MerZYupn9O7Sk+/G6use4qyonjbv1ghiFByDN2o8ElBjZ/JJxcVRA079r5NrfBh3WW95/ewo1Ceahn6L7v1fm2zCqccREKTmLFmTuJhkkP8zWqZKPpHd1M8speR2PM9MG0DTfSnmzu96BFlywMEtxnTdw4KHkQqZWZqegBVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by PH0PR84MB2028.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:163::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 17:46:54 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 17:46:54 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "vasileios.amoiridis@cern.ch"
	<vasileios.amoiridis@cern.ch>,
        "leo.yang.sy0@gmail.com"
	<leo.yang.sy0@gmail.com>,
        "wensheng@yeah.net" <wensheng@yeah.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 5/5] hwmon: (pmbus/isl68137) Fix unchecked return value and
 use sysfs_emit()
Thread-Topic: [PATCH 5/5] hwmon: (pmbus/isl68137) Fix unchecked return value
 and use sysfs_emit()
Thread-Index: AQHctjYLYiXyymEyRUmpo3tn+qMQEA==
Date: Tue, 17 Mar 2026 17:46:54 +0000
Message-ID: <20260317174553.385567-2-sanman.pradhan@hpe.com>
References: <20260317173308.382545-1-sanman.pradhan@hpe.com>
 <20260317174553.385567-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260317174553.385567-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|PH0PR84MB2028:EE_
x-ms-office365-filtering-correlation-id: 44dd0804-b2cb-4210-86a6-08de844d2d8c
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: TZcTmqa6RXwuGcClGDbHHRR//p9eMBCUQhs83SfcdSKcXu8dintrsPEFn0W9C+NgZMlsOcVSe0OfLYfMOgvFCbzfljQjPFTa/YuETDK20tDPmqqfwsSA8otNrPXX+3pcEWRMwXeXCZi8V9PfWOqpwkjoNnLr5wDEyHBB01QS0DBWd71hyLfxnV1IhsOVRU7crME/xpJSgb/i5w7RErhYyRDxfh8b764n4Ucyx02/5cAP65A7a8V76jalqH8fnCiPEeKZpdsj2m4rhJt7qTPtciJXOWDsY0VSaqxadrYNMbWwSupyUTwmm1AhPV4lNJZ/4d8t7Uj21Zd+6aJUqpOk44T+uSu8VWxbnvCQHEQOS38LXHfFzvVsfIm7QBW+lKU6jN5D6hKXDP20wAoS+BKH10JY6dcNpZajRZ6W6GcbSoKH9Wsqbr+SdAwtOl4+w5yhHdW+Jv8uUbhQn80UdZFokmIXZ2k0R4U05Tcz0ZyDClO3KPCtMGJZB8sPEfRQIEYPI3AsfC3zvnjEEkq7RupVlhz0V2UFDawdNAe8vWAvX8JLEgtmefqkM3aN7l+zrEmkrBNbqILIDnWFqI5xnwTbyM5y2F9cGocICC2zUpjqUDgyexaUqcutGZqRulgYCpH/F83BfFjRN3QjLz/KeZtZst3Q5pGibsP527uupbW0gKiybq1rVAvNZVeIRkLDJYU4UZIMGW+mnR94pm4CcBplWwXbXZ20leUvU7adh37Mrba39U5TdlFB3PhVM9UwZHyrbBNPhUpDSVh5tBi05kIbfWh10EYne4MWbAT+GYEMXJs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z3NxijLjex9kwLcER6YxVGNH04OJhaYwuy9TYNkobz9jULX9T0uoFh7Zvp?=
 =?iso-8859-1?Q?+G2h5uy+CG6Y/JDoXjBYVFq5qD8VINwh+Kve7Rnn4cobDzakDrTJROCWIw?=
 =?iso-8859-1?Q?Z9D99bHS5cdfBirNRgOPbRF+cCAD0k4cFuywyfoEgoTYfQ+PzdMLWDHi3n?=
 =?iso-8859-1?Q?m+v4pwTAul5ygT3pR9Jtg/onKF6/DI9ViPRb2oJZdXT74HlWqUotMAAvVy?=
 =?iso-8859-1?Q?cPN33D01QGrEuMpZsg2F1MWjeLymaClnatSOFNH9YJ0r40Z7ZtN7sLq6jR?=
 =?iso-8859-1?Q?PaJeCujrJBc0te8TYXUgdbr7r/qYoL/hK6UoBOSuCjpSAqipMqrq2rippW?=
 =?iso-8859-1?Q?y5aTvvUoNP7jGl7nIJsBictmJlZKg7QF9jZfduN0IEPLyIzM/sZ/Fg9Ic5?=
 =?iso-8859-1?Q?h3iNaYPqx9VMdzQvLJwnZ/KKQ3h6q7HFJ0mQ2V5F59NakHoQOOA2ebcLqQ?=
 =?iso-8859-1?Q?Q/ehjKTcEcdA3fYnVZ5UerpivyXQw0FQiluDLoDmQxCKMOgB8nGzWvRgSP?=
 =?iso-8859-1?Q?+yciar5GBM6pwp2eCr6iUbgsPXHkumPKJy3sIrD/Ihy8/YNSh21mJJLvv1?=
 =?iso-8859-1?Q?WMjQH9U7JOTUGI97rUyr3V+XIcDxR7Bif/q1zU99hGkoi6re4yCJJ01C8D?=
 =?iso-8859-1?Q?iC6WfZsAEMVxk2upZjConrJh+1f1hQ/Uu5GZhLD0+ax4CGvplnu8D2vJvb?=
 =?iso-8859-1?Q?DBJmAKrZtG7C3q9mcAh5ajmHSyK+9Ef6t//IGL4veJvJPDSTFi+W6DrSXT?=
 =?iso-8859-1?Q?FKzG61yzTGMgSdlHTfbZIRWeR8NufEq8Oq1H89Qy99/tfFdjSwStQFksC3?=
 =?iso-8859-1?Q?FLcMZqUPoDaXqPqtcnrfrYZherV0w8Go45i7kydHtuK3gS8YP9eCHbqwgK?=
 =?iso-8859-1?Q?DGonPiFnQ5auugz9IpMHJpceF5ZPN0LnQEwzYYy7QQGZxmkJAJUo2pQ7YN?=
 =?iso-8859-1?Q?OFVwZPdg4QbHCiRyTOJKCB2vkIEabQ/1/gkC2Rl7sXhSvgI18+Z2EN26u+?=
 =?iso-8859-1?Q?mgAqT6Ut6azWDRQh+zGkRmwbiV1clMmGm8Zz1iIHIKF2Kcaz9g8zyFdfgJ?=
 =?iso-8859-1?Q?twi/ER75kbMMr5f/yULpb/Pg0ilCzDvxHjCPL1h6f6wKsBfKb1MEXYxTuY?=
 =?iso-8859-1?Q?FPTVX+JBJdBSOOHPy0QdDREI8ES/xf2paRQY3G+9sfDFWm+WGTuHhtBqqD?=
 =?iso-8859-1?Q?tMu0IneweBfmehOdgDO7wpOR3XrE4+ru8OZwiyzryn7x73oSu2Y1KYMWBp?=
 =?iso-8859-1?Q?3sxr9m/b1E+SygZ6PNKxIsx7so3xPqGJluOhbHMxYk2A9UfpIlNXY4pY4I?=
 =?iso-8859-1?Q?jUwVYdavHiwDGqLrz16C7RP5gDkUQmBYF/ErHoGWciSm3HgYmVaMNVWWJQ?=
 =?iso-8859-1?Q?G0WdQcj5OLPVkniqLhF8bXrqFHE9QpAYUeldPTCX8LPOg4avMtwWcXtsUe?=
 =?iso-8859-1?Q?tIjKjgVVexg6XqmzulPdB+X34sclaYFycAoavn7yVWc59m5GyW3jg27/0k?=
 =?iso-8859-1?Q?aUQA5Vvo+RMjaoeG5rDoCK9yj1oaNj7kODqZmnYCxBTmHX2K9p4LyxruJl?=
 =?iso-8859-1?Q?m/FXZ0uuroLL88WK6FxyJJc0rHUUgKXUrSxrEZuasBMHX5U5a6DI23YY4l?=
 =?iso-8859-1?Q?1eHpMGyjYctmIG6lUlPMOjGbuPC1lhORgasryYJsX/CIxmjo9p85Z5lrHP?=
 =?iso-8859-1?Q?+ivULKBwALDpxXPxxFACV1X2rgNIHyFlLCeqdiW67qLdRYVJJOlT8S5fRl?=
 =?iso-8859-1?Q?cE94eaMXBnF3gPCWtaMoke9ofd4zehRwBO1xUrnLsm4KLpnk2NzXZaPuXo?=
 =?iso-8859-1?Q?5u6gO+VxLw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Hky884xNGn8ZhTj+T/DiDcy1MEvd+dnC6PDQ7ZxGF0Nr9mG/FyN/u6CYUsrX7Xvp40Sqi/1INvP586bTdBvSwJf8xqS20fFpVYbdYJnuq6Qhgd5nsJmEfAd+KKxT5UlxXXf6WXAhyjX+BYfvz0LtzFcD95G/KZ9+EUiqOMbmQkER+N87ZjJ145jUZMSGHs8gnYdofU4m9ZydVCPtVd+1uLLwoZ7sGG+DkqZAAoT23UGMqsEFXaIC1Y06yoU4EyTnWuKD6TlI/GMxXYDAwJLiAoefLzxUSeY3HekEZygu92ApP7gQIQpLuf/VUWwyMxaVWcLzb6/tLFgz43Llsa9S8w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 44dd0804-b2cb-4210-86a6-08de844d2d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 17:46:54.4650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7Ryi6kgO8D1EjkoV+exN+Sw7ir5Fy82T+TfQdrHY0hAEl8R+GO+R1+Hn/JpwY7dPwFku/3ZBaJvOZWJAb+oew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB2028
X-OriginatorOrg: hpe.com
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE1NiBTYWx0ZWRfX7Tn8cis5SQSB
 J5ZnjGJe23czyGylog9K21S/KHGoYJIvIJTKzT+zGdBmTUEgHLtLzPnUPEkwLa1fxasCEJ2/UOs
 Z3nnL7qTA2HpXhFgtgUm/tPocYjW81uJiuVt1p1TBsdp00a+UzC/o9r66UFzvsqVe1seTMOj/2A
 2KckyFxq6/XK6J1q6Al5EABXJN4cuYHgK509Eha5ygDGbJfLjXLwKr+WnnV/Rv5Rg4Oepff1HsD
 kg7gQqx26pOjxuBA9OMddi/meHqX17z9hQbibh6/KdMN//PAemQN75HX7UPYY+VkOdwO1ZktUjh
 XIKfVseJJAvA9CvXX82wAB5hW1HiWQv45kmprrixupxtMJfYevSh5Mz7T6IAnfIdZbMsHW98AuH
 z9hdkCgslCnsjsP7yEqKDrJc2oWepTOmBqeHgQedLPXVUIwvA7rDCftjVxH5FO+f5FaCJXVfe1h
 IaxyY96ev31yXpi7dPg==
X-Proofpoint-ORIG-GUID: V5Cr-EeXkDH5biaOzZaFeLHjiu5AKKZc
X-Authority-Analysis: v=2.4 cv=AKLTt4sb c=1 sm=1 tr=0 ts=69b99392 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=g3u0LPWLDYfGfufhFw6-:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=xJ2UmOqLvB04nY2elPgA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: V5Cr-EeXkDH5biaOzZaFeLHjiu5AKKZc
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170156
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226882-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[roeck-us.net,cern.ch,gmail.com,yeah.net,vger.kernel.org,juniper.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hpe.com:dkim,hpe.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,juniper.net:email]
X-Rspamd-Queue-Id: 016462B09F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
isl68137_avs_enable_show_page() uses the return value of=0A=
pmbus_read_byte_data() without checking for errors. If the I2C transaction=
=0A=
fails, the negative error code is passed through the bitmask test and=0A=
sprintf, producing incorrect output instead of propagating the error.=0A=
=0A=
Additionally, replace sprintf() with sysfs_emit() which is the preferred=0A=
API for sysfs show callbacks since v5.10.=0A=
=0A=
Fixes: 038a9c3d1e424 ("hwmon: (pmbus/isl68137) Add driver for Intersil ISL6=
8137 PWM Controller")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/pmbus/isl68137.c | 7 +++++--=0A=
 1 file changed, 5 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.=
c=0A=
index 97b61836f53a4..739e7126be51c 100644=0A=
--- a/drivers/hwmon/pmbus/isl68137.c=0A=
+++ b/drivers/hwmon/pmbus/isl68137.c=0A=
@@ -98,8 +98,11 @@ static ssize_t isl68137_avs_enable_show_page(struct i2c_=
client *client,=0A=
 {=0A=
 	int val =3D pmbus_read_byte_data(client, page, PMBUS_OPERATION);=0A=
 =0A=
-	return sprintf(buf, "%d\n",=0A=
-		       (val & ISL68137_VOUT_AVS) =3D=3D ISL68137_VOUT_AVS ? 1 : 0);=0A=
+	if (val < 0)=0A=
+		return val;=0A=
+=0A=
+	return sysfs_emit(buf, "%d\n",=0A=
+			  !!(val & ISL68137_VOUT_AVS));=0A=
 }=0A=
 =0A=
 static ssize_t isl68137_avs_enable_store_page(struct i2c_client *client,=
=0A=
-- =0A=
2.34.1=0A=
=0A=

