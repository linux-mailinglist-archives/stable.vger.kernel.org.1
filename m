Return-Path: <stable+bounces-253501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJiZHMTjDmrACwYAu9opvQ
	(envelope-from <stable+bounces-253501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:51:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E620E5A39C3
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDD76303D327
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5653F39DBD3;
	Thu, 21 May 2026 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="IYfXS6RC"
X-Original-To: stable@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C7395DAA;
	Thu, 21 May 2026 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359101; cv=fail; b=ZhbfKcZT4ax+4uvCKij47vo4UNBKIx/qcC0zobnjn8xjKz9gd+bLFVIIyZb1Xiptb5AQinOH6bCp5+4TNh9U7RzHAC2ostlHAeeBBch+4Oy+mkcbPhExta3ZIoogM0hw7H8dC8kqoOpTQcrk8hoe2yVGdiNQ4v3rVCIAbCK/eEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359101; c=relaxed/simple;
	bh=+sRlv+WQQD/9kuqkEUByOi739aYgQS3eklaId+NOYXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PBeIPU2/tKGWqkMN6J2nfDIHPkG2G7GGQ7GWQZC3GoDE8Q6rTxUEAvZAFqgGQ9y1vOOw3LkiozoNgJF69Ts8i3Y0/9XHuvDmY6+495JnxqgoJcfa//h5Fy949fcKdXCghWpWiO31VUT8hXsgcvKr37TkEmLojr8j5N3gXB9v7IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=IYfXS6RC; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L5mrQt306072;
	Thu, 21 May 2026 10:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=p1; bh=pT2AsDn
	EUo5ywsTbALbEy6GCT05CknpsNWXleB+HTFY=; b=IYfXS6RCy6kk54ENXMOMRHo
	IF4cI09a08Rd59LEJoT31amL6bRzkYipa2jXmgEuNPnElAcwsNmc25BQ4lSRRXkS
	rJM24JKZCy4ZHseB4UzL1N+zyQN0sKLdtWv9wE1pR752rAGrzHHMe1thoRAnOMUF
	ygqA8z/uov5ZVR31/HqKqQvjQZEUh5bG2asivoPKBdLGLs/wnR7Rs6ltnOXkT4rm
	uvQGydhd/NXGvcEfSjSr4/NcXJ7hBSvrD0XTlvCBeJNewbZFCNFuX7Zzoib76xON
	mCDPUHe5k7iTNZJMSgiH0B+i118KdYUYSMDkXZOtUXGVGrdEg3+UNJ6SULgqCJA=
	=
Received: from typpr03cu001.outbound.protection.outlook.com (mail-japaneastazon11012013.outbound.protection.outlook.com [52.101.126.13])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4e6h4rwdqf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 10:24:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5miOcuSfM5bkNAvcWka5vv1RBNiMcbvxXbLTaqbZ9unQsx7ivI0xFfM8zyGTrXhqC4XGLYeiTe3iQaOGtkeH/Dk2Smrhb6IuxkWHeN6aCqSGvxuWxizJev9+xQJWgk0759B9123QxvI0Rk6m8DrkwMqwt0xjSzTGk8aDZ0mIyVSBF3r3pJkO6ff50thq2ngKhdfzUJ8jYG8Tq8zWZDpz6/xG17P13+NMEBZWQ4MBlyAHMp5qcvr6zvKSlXFLh5Y+5KoQ9+/a2YVytV54S2wnyFYGpWaVvS9uZyfyIbWRhYczKGicaAydM0Uux22gtV0nyMu2W5dpPCq/XO/urVe4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pT2AsDnEUo5ywsTbALbEy6GCT05CknpsNWXleB+HTFY=;
 b=QRuBuyfGlWF9AiKwC3/+Sc/XMM3i3gjGwLHmvYFO7/i3nI1Gqitx8x2O36ZgLEnWwMh5p6/JHTqeqL8lt5Qi34dlGbEEeSLvQY+NFpLEnSseayET1grL/QN47AFMcjVHDrXwaXLyEw2eEPT9R9L39yEMrL58N5F6sojF09B2tCvss5HI6ifVU+gHrMbM7d7r2GBpXKdYyghy1Hts5e6+H3KXp/dSvbBN98N7sj0oPoKVEYHCXkLUvfjybvy78wbwChamovBDEJdM5nyLAz1Z8xQpnh4JKXxw4+d61FYdCoU0zUIGdctKFbO4aJNyKeGOycvRnrQ1ePcB3SYRUWX7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYQPR04MB8939.apcprd04.prod.outlook.com (2603:1096:405:2fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 10:24:33 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::a631:6b1a:332c:831c%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 10:24:32 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Rochan Avlur <rochan.avlur@gmail.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "rochan.avlur@skydio.com"
	<rochan.avlur@skydio.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] exfat: preserve benign secondary entries during rename
 and move
Thread-Topic: [PATCH v3] exfat: preserve benign secondary entries during
 rename and move
Thread-Index: AQHc5uCwthTHNHYzfE23LSyfpFcNPLYYOYzI
Date: Thu, 21 May 2026 10:24:32 +0000
Message-ID:
 <PUZPR04MB6316B8342BA4AFD993DB8D7E810E2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References:
 <CAKYAXd-1P-bPV5PuUa-cePaObUzmQ+9qTA48mriivEeFeRcvWw@mail.gmail.com>
 <20260518160836.29876-1-rochan.avlur@gmail.com>
In-Reply-To: <20260518160836.29876-1-rochan.avlur@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYQPR04MB8939:EE_
x-ms-office365-filtering-correlation-id: d0f8c4d4-2bba-410d-6f72-08deb7232641
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021|56012099003|22082099003|18002099003|4143699003|11063799006;
x-microsoft-antispam-message-info:
 2yNObXfFnZ/8cFHM8RR2IQjMjLEqR8/Nj7pRdPBU1otf9V4lo1OENgUqGdOFfA1O1mDQI6m/1WWLMlZ0Bjr3Leoyb9q1IUJAQNC/RvolGT6ecgX6XOcissjnxHQxaqjX4lCGvrllPVjlKjrwl+iOf4jK/dI62FqBk0IuFUPUu5F8aylAJsYb7nWEz9p7DrkfI29l7Xom3Bv0bus59/bCA4DBlBDR3HyDehm7tTCw8/kdMj1bcGZ+MYPovMPche2r3nm7ZJxNGMU6pbf/3F6wfAw0bC+k58RYP5NRDfZDULda5gHcCLrBnTlCIZrnHrwElIu9feKDFf/h71rVvt07dWxv1+1exGPW7brfHoQmqxVTHEgpFjtKENUpz+Pa1LCxRY75dV5DpbXTIN2EtNIKjyn410ufvLu0n/mEJhY6Yfiz0e9kvkNG7EijmxZyK++aTW6lAYFdzmKc1b9RH2gUsev0X1Dw60N/PbGLzMM6ollg5mNwWGt2OzBUnj4evNy06Lcp+tllL8LYIEyKSuTfLmZG1Jg1VBsNPnWeA/4HIkEy44fk8/zC9Mxn5wydLipjpYFV1vDVN2E2zAHXGr/WOB66E9Alb8EI9qNSCu7tUc3CdUXVQf34KqdHLRHqYlIXwwbf53QalFRpb9IefGThKLThbyWSeh8DcVL/a++sDb5QbUNAOo0rHyENGQcBTCK3lHz5ai7wb6E5kX9U9rCMtJx5O6HlXXrO09Mox6n9LrS6gGYOSGCHpo/AzWzz9iS/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AokqtSikUEevPOEpLf8apyYBjbD11lP2c2BzDh5FfDsA9+oJ9NzKWkl91B?=
 =?iso-8859-1?Q?DnFN8VbcL/EDe5ifEXCyZujg1De/rdHIGnZqEBfNo37AG1MM29z4LvxRNk?=
 =?iso-8859-1?Q?NreaT6fpbl7+5XfYtqdt29Ui+Kk1MrVq4iI99mDK0zEaqGKwHbXvYJ3Egd?=
 =?iso-8859-1?Q?iHx0yfztQD5tP8JnF54Gr8uLgvDoLjgGPlecgQrs4oJXMi/fZo31Ycp2HM?=
 =?iso-8859-1?Q?BehbUE0+vGXUf3S3ZQzb6s2xw5eCdNSahshYoJ4rjhzoeiss8B44865gjG?=
 =?iso-8859-1?Q?M8vEdisGseCZbwSmqPruBr8NQYP0qXH9sb32GQfLRIifdl+YzceEZ4YIC9?=
 =?iso-8859-1?Q?Fsbb7ulcdM8vxwTOGzjgSs7eAULeYtKaen3cVmlwBoaqggBVZytvRJv4tB?=
 =?iso-8859-1?Q?SBgBWri5wIKfrSMApzjI3GUVKggsUaP5QEWHWV487kfGysEsDZZCm7VAuk?=
 =?iso-8859-1?Q?g5yPCbu/pF5jIxBQng44HiRX/08nWeV5o726GKF9/dtLZzvy08B4cVqIc4?=
 =?iso-8859-1?Q?qZKamYvgvIzl8/eU5vbqggPrvD9sYXev7572eeTaGBriXBWdIMbhXqTpxU?=
 =?iso-8859-1?Q?92cwi3tAxDMGyGCJRx++VsEI/Yz7bN0eXyBha/fTsDQEs5Si/l42sJF0S7?=
 =?iso-8859-1?Q?0Z2kPRhYqg9jhi8OuhE5iYdeC3wn51thDm6b8XlTErzbRAHsB8+h9h+IGn?=
 =?iso-8859-1?Q?1Bn3u3wYlGer/QcULao5NoMPCxknVD5WbqX0QGIb1GS7vyjo1OU7olEplg?=
 =?iso-8859-1?Q?RbP9qsax+sPJ6n/s9PfR8ooEtR5tg9hlUkzV4zInbGJAEQMEYoDV2xBO1R?=
 =?iso-8859-1?Q?HxFOQkrTlbqWe945WncZkOg6V45Iftclx7qlm6FRud5Fb09c0ZefoEUDKj?=
 =?iso-8859-1?Q?pluN6k3l1/dG3ZGnk7RgKFaY6/9XdjUonCofcbzAuY+dSYZibf1lC3cucL?=
 =?iso-8859-1?Q?HYqy1FENsAZtT/GMZhzDhUjmxykczN4w15CoO5JEjbUg82KiZxBv80kmuw?=
 =?iso-8859-1?Q?eZYDydAIR9nWv8ssQTw9EVlrtniR4diL4F8/RMC2A/OtmhB/0qEjXjl+3d?=
 =?iso-8859-1?Q?rcMEW/yoh4KkF+TKOCtGxL5RRfkc1a4CYm8yszKL14WuSmPZ7pwAq1Df+t?=
 =?iso-8859-1?Q?h7A2ID46UzldSOqmVsX6df3nytGh7OknGYtjaKSYww4USGdKDumYBGzUGS?=
 =?iso-8859-1?Q?IrGYkbMkQQxYltd60axD+OOBKoyW9HmOoHqVy2kY27qIU4R/VR5IyK1zLw?=
 =?iso-8859-1?Q?aqJsZxdII/jy6wtQ7vrslxy1HojiOd8cz7s8hLCO3PaLkGf9CVM/6mBNjI?=
 =?iso-8859-1?Q?i21owHpKRuxocBWIHdqtNU0atZj0PbA07eeECkAyivI3cFCr3vhmy7qUs9?=
 =?iso-8859-1?Q?nV5OGfgd+AtXNLyRCCBMrVUzuEabz4VNCH45JnQfuc7bWjrJA8rNXB6a9V?=
 =?iso-8859-1?Q?GE5p73qZlTXpW1v+32/6ysZnHPYJHthYWV0b0RnersKqCjuSk3Z8RYO7Lw?=
 =?iso-8859-1?Q?haZfHw0OyPOGon6R+6m+YAM6w7S5R7v8uE/eh/fRVRMXY4detPV+IT/niC?=
 =?iso-8859-1?Q?cdv65Ufm27+WWpmU7zCciQBOfZB2XBrdhFZ5PKW0sWTgWMLdKqTV4YLP+7?=
 =?iso-8859-1?Q?Yix7/8KcDoKs0GL/2Bo8KQUXG/FqqmWmExt2rU/LOUjba/5CMzFd00y5rp?=
 =?iso-8859-1?Q?OgbgXU0JG5rEB33OJ10D6l83RLv6kTYEy0r8z1OIqA4A3uGa645MJLZNuz?=
 =?iso-8859-1?Q?MbjTY3coPcIByW5m5hPbs0ToabmwC28HiBbkXuJZhwcnt+VVZaOKxT0oG6?=
 =?iso-8859-1?Q?XTxUwFsK6a7bzv/rUgD8napUWohLF1w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	qCfRhWXY97/LsX5ZtpamUTZtRLztKBrPeWMwKH/mgZw0HELx0sk+ZccuKjjGTZb5GTxR/V4jKkh/B45K+7tbXPbAz0/Wge1+CDtTFKVBtczFJo0PlCRAcR4jK68UYomXCUXNUIlrL1jBAn3ErAF2AXG4zZrJ2W0Uzbih9z2kyzbIxt/+nuWoaranKYgF1deLSWeJRoPQRT9VVbXL4NZWITaRiwyeMatvWImZA1sWD0qg4moJupSA7p0T6Qj8p+0XHuDRPVpC8ElqTCCsUeqs1khhPBsokUHha03VptI6PU6ChQya6AKYlraaRudIJEVR4jwizl8sRV71sLo0DVXbyw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UOwldqsDpy1+0e/+L4kJMxn2ywtSLsZv0Tpxu4H1Yc60fp0RwV7FyaPh5+cFk499vFCJyusLgJTd2+UyCydqnujvTCMikQJlXKlSkd/thbjzA6m82vvwaU7WaMvScPXynHX/mLmIl5iX00fFRB7sFF2vmPU0TMOK/SA65O+8skXAk0WYzadCCehjD8eaUoIlynYDUHWvTNRsWgwCs2jxFKsNUoas6aNKMal91rJmB+jFRK3dUWrhIKh49p9a2BpHCJYN7LNHRbr2AIZQyQ9BA6Rv2sTNBJ6VnsoqChMqmOr08k5wOu4IlOlCsx41+12+kXyJrIiWFgy7d6BaGcjShaYBGNWjESKB19YnniMH/ohyRv7calPt5AgoSpwO59B0+2r67Tw9VO4CEb1uHZhAcm1hQqbe3/5oXK3sp6GYtrXELey5+mvWFwWJgW/u53GLoivZC8isNts0a4iz8ybfvRSffoBGIsMyGGhSj9i4+F/jDrqyMzUSU5AP5fqH2ZJuFu4qY/i75aVeM4o/lsg4qLgZhVf54lIsNDzDptTHJO0smTR0ifVgMDKu3o5wxtzNlGPVfCxds8T6g+T0W7b6TOVG6SMkH51Jk+EZbNu7pFxFwC1RN12XQbXzqXy8sfO1
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f8c4d4-2bba-410d-6f72-08deb7232641
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 10:24:32.6109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEOyqKnazbwjuzb6C2j5HPYPKeQEQ4ACW+Hmr5SdvMSlxEM/IFO9zTQTs6Y9M9ru9AUWsKYcSQHaYw0aYxV8Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR04MB8939
X-Proofpoint-GUID: xlsaogH6Bl7ofzJsipBNpLNwpi_4srPV
X-Authority-Analysis: v=2.4 cv=TeKmcxQh c=1 sm=1 tr=0 ts=6a0edd6a cx=c_pps
 a=R5E0JZfuZuOkO2CZe4yZoQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=XGr2FpfLDd2dUKU_94WB:22
 a=oV265rIn68nUDKU2M7cA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEwMyBTYWx0ZWRfX3a3wK3AT7SLS
 KXqBixaBKjgjQtUVsR9tq9Zo13KT7rME1HLYuCQImIQCTrzzOZQB7P1pX6f/VEL6Tyj/X2nbEh7
 Xp2hj33aKUBjIFpiudPkXVwZLQmOs6CKGDjDF6oRjUUl3zvN985ooDo+WikHcCSOhO503pbfMW7
 RPiZ3hjEA6CYSXdxOthLy1IhwahYVg7B+ge6ykQ9sArM04Yki8+yqU1kQE61A7MVKwi6scFHypP
 yKpLgO4CSCMHS8HqR5FJZphBohuMNzqlZ5laxXt8YSF4tuy2h4VrKaJW3T7EhwV/Vf7F7E3FPkX
 RCi0+FpMqXr7qTvsS88blNBdxXMjcvhx12+U3w2M4LxhJqZc80rIzuA/rUuZc5iMWf955zEsNtm
 2wnX5DqK/eaD7bt8ydA5tzMqZZyoLo8SArYl5diI8HrgK9l8K6Yjwti2pVpq9V4kSgQijT/P9xv
 xK1IL5F5g94aZ51rotQ==
X-Proofpoint-ORIG-GUID: xlsaogH6Bl7ofzJsipBNpLNwpi_4srPV
X-Sony-Outbound-GUID: xlsaogH6Bl7ofzJsipBNpLNwpi_4srPV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	FROM_DN_EQ_ADDR(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sony.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sony.com:s=p1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253501-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,PUZPR04MB6316.apcprd04.prod.outlook.com:mid,sony.com:dkim];
	DKIM_TRACE(0.00)[sony.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Yuezhang.Mo@sony.com,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E620E5A39C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +/*=0A=
> + * Copy benign secondary entries from @src_es to @dst_es, placing them a=
fter=0A=
> + * the new filename entries.  Updates num_ext and the directory checksum=
.=0A=
> + */=0A=
> +static int exfat_copy_trailing_entries(struct exfat_entry_set_cache *src=
_es,=0A=
> +               struct exfat_entry_set_cache *dst_es)=0A=
> +{=0A=
> +       struct exfat_dentry *ep;=0A=
> +       int extra =3D exfat_count_extra_entries(src_es);=0A=
> +       int new_entries, src_start, i;=0A=
> +=0A=
> +       if (extra <=3D 0)=0A=
> +               return extra < 0 ? extra : 0;=0A=
> +=0A=
> +       new_entries =3D dst_es->num_entries - extra;=0A=
> +       src_start =3D src_es->num_entries - extra;=0A=
> +=0A=
> +       if (new_entries < ES_IDX_FIRST_FILENAME ||=0A=
> +           src_start < ES_IDX_FIRST_FILENAME)=0A=
> +               return -EIO;=0A=
> +=0A=
> +       for (i =3D 0; i < extra; i++) {=0A=
> +               *exfat_get_dentry_cached(dst_es, new_entries + i) =3D=0A=
> +                       *exfat_get_dentry_cached(src_es, src_start + i);=
=0A=
> +       }=0A=
> +=0A=
> +       ep =3D exfat_get_dentry_cached(dst_es, ES_IDX_FILE);=0A=
> +       ep->dentry.file.num_ext +=3D extra;=0A=
> +       exfat_update_dir_chksum(dst_es);=0A=
> +       return 0;=0A=
> +}=0A=
> +=0A=
=0A=
I think we can do this by passing old_es and num_extra_entries to=0A=
exfat_init_ext_entry() and set new_es in the following order.=0A=
=0A=
exfat_init_ext_entry()=0A=
{=0A=
	// 1. set file entry=0A=
	// 2. set stream extension entry=0A=
	// 3. New step: copy benign secondary entries to the tail of new_es=0A=
	// 4. set name entries=0A=
}=0A=
=0A=
> +       /*=0A=
> +        * Relocate when the old slot is too small, or when extra=0A=
> +        * entries exist and the name entry count changes.=0A=
> +        */=0A=
> +       if (old_es.num_entries < num_total_entries ||=0A=
> +           (num_extra_entries && num_old_name_entries !=3D num_new_name_=
entries)) {=0A=
=0A=
If the above implementation is followed, this change is not needed.=0A=
=0A=
This change will cause the rename operation to fail due to no space, even i=
f=0A=
filename is shortened, when the partition is full.=

