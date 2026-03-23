Return-Path: <stable+bounces-227872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ2sI3aIwGlfIgQAu9opvQ
	(envelope-from <stable+bounces-227872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 01:25:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F22462EB42A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 01:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB2FD3009F0C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 00:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B01D1A0B15;
	Mon, 23 Mar 2026 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="JgT6KXf6"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0681519D092;
	Mon, 23 Mar 2026 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774225498; cv=fail; b=edxRohZo5hihnN+A+2mX1rLDh6SXgcbu5rZHR/0tQe51mttQeHMoTmcj+sTki+/CokL6y5TpM9wieYpgoMXumzqSJgcpa8esivamFQtJ6CSYWsk8MEG0Dpr62OOBx7r4kOFIdesKdd7o1NJJ5lZFIddtmTWRJJ0/KbMGJkzzQRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774225498; c=relaxed/simple;
	bh=CuO+3czQ5lPpWQ1/f1mYgMC9kVRPaG598RyEb6EWatA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QE1HuiJ5j367yxqnKcWYEpjnrADWGn2yHMWjr+Vr5A+MSgyB+i0EziUOMwpj3nSYPQPekLHV0EQle4ELbW9xHReFUOhkxpC44J8+LBhtboVoFflZ5gBXCAqtYiHKCoat9QXMCeN1okrqtDsETJREB5P18bxdqnckmbMCNzVaLDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=JgT6KXf6; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N02rmY3860456;
	Mon, 23 Mar 2026 00:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=m4
	BQ0lJkcXsBqHiJm4yAMPS9AQ3NrDPZ4Hmxeyn+LOw=; b=JgT6KXf6llDE1CLJui
	Nk1u/BHu1ffXxookYiOC0BGRzXiMRKEK8Ek1p/Uz4e5qMwcdgNodHhxKrcDMog5P
	oK7JtIZRCVl53US6KYhFSjK9J+tzUFd0mSGutmwc7jV8ge6GULly2BstZ9w5o2Ln
	r+Qb4pxAq9jlIHkr6CraaQ/q6H20MIem1foAwAe72E+P+Ak0jw2VOCjGsbfGW5Jr
	r5uR0TrM6DUAe1uBXWQzYzW5wA1R1M57124wzc5Aay+DTecO8Mxcz9wamd2zbCNu
	cRzSYr1RLpol4JGnIaKog6o+0Qvu7rw4O8KSf/GlQr/LjPxsq21OB64X59Nqpuey
	JF4w==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d28jnnytn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 00:24:41 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id E64D08014D4;
	Mon, 23 Mar 2026 00:24:40 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 22 Mar 2026 12:24:40 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 22 Mar 2026 12:24:40 -1200
Received: from CO1PR07CU001.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 22 Mar
 2026 12:24:40 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQQ+wvBsrJdmwlWs/OkPK6aMmag1D0WSwZ4KQEnUk1eFC67COuNl+0odt0tsCJjXn7zQRxoU2VwaBqNjyb+mDwXyeMvnV7KexYZRxDHAPHTAtyHu+bbT3lDxdqPJQtriSpLKp6QKZlgBMdjWtkjPSw49odZGuu1d4ew0iwDJUVOKbqg4PLVom3xcr/WgR+jYNwHOZsEws9nM0JSzQNJ7zvyPY1H86Fvsddd/JhkTPNnioj9fQRdo9xpEYw6vG06NPB7BQ60GwNQc5MEtxbvD/CJ0SQxaY+biaC8VSz00vrJbmesKKalOC00h5JEL7jet9HZ0VRLqOHuIilzSZeusog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4BQ0lJkcXsBqHiJm4yAMPS9AQ3NrDPZ4Hmxeyn+LOw=;
 b=Azxto7gbiEB8ugxSYNz+u2RFHY4oB9iok8COvA+0wagVsiJz0k2YSIQccd76hs5RxjJnvN4RKC3LiNy9Qnv4x2lVVsQYSkseOrikCjUWEjsqvOp7jYtTVVEBW8EgajekEwCnAbcZxxWn/F5blRR5czSlWsCdXVJhTXdQYA0d1nN9s9b7HTejBpOxrnHTnR48Hs2RlU5FqjdjEl19I2cuzEIzep+ZdQIMANq6xoWjuQ1gWjPnsayDvUE9uo4FTvAG+YPA81X61/jDZdhgWXcT5fLtn90DFvW3OZQHMZypYIrgACAX8Kl/uXky+UyNNjk4YNI7dktqcNKl3PsMKDWNCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:203::11)
 by CYXPR84MB3741.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 00:24:37 +0000
Received: from LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fce6:5af1:e04e:caf6]) by LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fce6:5af1:e04e:caf6%4]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 00:24:37 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "iwona.winiarska@intel.com"
	<iwona.winiarska@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 2/2] hwmon: (peci/cputemp) Fix off-by-one in
 cputemp_is_visible()
Thread-Topic: [PATCH 2/2] hwmon: (peci/cputemp) Fix off-by-one in
 cputemp_is_visible()
Thread-Index: AQHcultuj95gZDkUd0KFWC7rPkNKJQ==
Date: Mon, 23 Mar 2026 00:24:37 +0000
Message-ID: <20260323002352.93417-3-sanman.pradhan@hpe.com>
References: <20260323002352.93417-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260323002352.93417-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR84MB3535:EE_|CYXPR84MB3741:EE_
x-ms-office365-filtering-correlation-id: b7963237-ea5b-43b6-932c-08de8872912a
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: KV9LWM513Z77+3yHVzxASydbO3/L5I5gc0KrEyqlwxm5xvWSceHuVU6fa7Xwva8bdklq+yG5G6xWoYtXVgX436eeRzQouvej7o2RUMVjiZlNfJoby53KRUUsbM1Sd1uOddHsBGVmRfW4nHK6zJY4rVcZLwM8oG0UQQNp+3gTwHGw80bfdQ1b79Bc7ZkDF0+wDf8MyfQ/yznXPdTy9uQAE/G0zbtf68wF0GooY+lGu8LWuEJFomCFWUrYVpt7h+ZXmdhIoveJPEW/JclLdjVuaniklTHt2wBjwhWC0ZAizQhuzC0KLpT5xkIeWK9tHfBTquzmQ0RS4hdAtbdER5n6vwD1D11FmDKUtbD4mN8NA8ZR5moDRBODF/YxfZ1nGUTTvU1s4ez5UUyEcYvDDIG4+yyefW/3yAERYYIGkFzZbYu8HIn0a5SvccRuHNVSpnZ/Yzm0YXgFL//ovqUNZIpX/l/l6ZXcNBDp5dywDBVxdDTpyeisGGjG79OlEr2l0G9hu94oiEtb1jZTyrhVvX9V2xi1ASBoeb/QEfjZkVljfe8/MagQZSXHPHGQHFKgGEKmCKxD/0CkLGGBNC37+TmzAoIex5YUYa7rH43F5NHYczadXYNImA25ojEjccpL3IVFZXH/o7y9324F9TKydlTL0/tF6y2o3UHXaT5V1cK9g4cxkC1xpn1i9k81JUbvhhVcPIC60xnjN8oiEyqSFHxr2Y58ZfF5qIKNkCzAGnnZZaElwJBkvm/Kv0B4lywM7e6zA3OL5tYdfqRYRoE4NoVsghZwk8e9ud7VcU0wqQptu8M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BKu+mDLou15JNSVJSret1pveNhXmiStp3cViigI27PJMbUbwbLOMjyTaX7?=
 =?iso-8859-1?Q?Pc27rGtU9kVnb6nWXUDRZ7gTArTNo1hjq8bdD5v/LLxPw2uM63/kP7Uw0E?=
 =?iso-8859-1?Q?w+5mMVRUaxffxye8hwPZI/k57mZKHJew7tqTEHunj3iei1CIFz1Uv3hJJq?=
 =?iso-8859-1?Q?uPzK7S4IKifAKLMFe9ZdQkZ+N+EjJPemXYYot7k/NfuFb+par369kgVGwE?=
 =?iso-8859-1?Q?GfGJyV/XkyMxI2D+wGqO0yEw1JEfQNcx1xLK85GfHrtwVZy+4BvLKthfgv?=
 =?iso-8859-1?Q?DrW6McS1A/SfAvhz1FnPM27zYSbeligwu1wWWjQ4JRLLguxe4/q1rneuPv?=
 =?iso-8859-1?Q?Urq501MKLhpaOi9QPUET/20oMJkqMsrbyLxKvoEnvTZjdWcS5d5CIq2M9c?=
 =?iso-8859-1?Q?lLwQ2b+eHm5oMDSMsjsv4uNB6HZbt+lE+STXT/q4DXJC5kIgcWrKc0AvK7?=
 =?iso-8859-1?Q?YSoQgsDp5VA1ld4UIcRdGISA3U4XFIsp03LuTbz7z5vdQipSMblwfnMypU?=
 =?iso-8859-1?Q?/Lpr+5Wzzk6kgG7A/1dS/+kMMH3lQEX+wxXorMvfVk6qKLpC2DtxSnTU+5?=
 =?iso-8859-1?Q?FJutZBjW/ZbIDcgIr752q6+p9zajDnCU8rJ4vh+SgcnYKHq2Fyq81DTQ9i?=
 =?iso-8859-1?Q?KeVo/BwpEz9fVHlrqR8u6eywOxVm4cdUQPIwZV6/e65Ydl55DAgtbLndnI?=
 =?iso-8859-1?Q?26xjN8LSvlfA6cxOf1qZiVq8Gjnfwxc7Z7JoZ6ucW/6b4xUJgmz4e3VsQ5?=
 =?iso-8859-1?Q?Aa6Ps7d5EWu6caVqgDedQv6O6GjALCBdhjwv0Px5bjFkAkTLVqvFkiosc+?=
 =?iso-8859-1?Q?cMmOFJK6NWpIUL5jPZwH+pOxMiTZKxLa7KJj5QwBpv9TJuh6Kro0Jlvq4L?=
 =?iso-8859-1?Q?KWrXbjEASZwyYdA9Nu6tYGFYBo7jbtQJ/46TLRVTglhQswjXESVQYvfYjp?=
 =?iso-8859-1?Q?wHsZh2CIsCjLYKMjLkH1Ph5bZlgfAhOEszQCv6h0OBkZ846A9bXBW+gj05?=
 =?iso-8859-1?Q?AFfGwFj4Gq/HBjnH4invnXqQ4+0WMv6eKvMFvs7vozCX+Fb/ksTs0LX7LB?=
 =?iso-8859-1?Q?N361M3Ow66S8HIWAv3D3zIecT3o9ByBKOiOp+fbnuBOhPDE363OFGNn3ea?=
 =?iso-8859-1?Q?3LhNjF0VxW9HE75g4P9xt1YVL529fK4p2s5NoZ5gOT33drTXqiFokJBD8c?=
 =?iso-8859-1?Q?vsZ1KKMIhCNJ0leuKtyNlC5xuDpAe4+pyn/q/8gL7lV/p6twroFyN7o14c?=
 =?iso-8859-1?Q?4G/rQhpqjWMZzz02PaqRY7iSWhOTc46wmA/RUwjS3EQLuUW23FbrMMqiOP?=
 =?iso-8859-1?Q?rkHYx3mBwS0ZybJ7h4x3nra9ul2tbS52fYLvq6yLfnoN+kwGry3BZB8Dxl?=
 =?iso-8859-1?Q?UBgPOVp1xUi63vuj6GCgpCogU2/JNevUpuoyO95ABQXjovpSphcLDS1z4z?=
 =?iso-8859-1?Q?V4z566+JZ6NrVMUlrJSsTpJlME4xbfmWbsnwfuNNojsP1yB3YnxlG2OQ/v?=
 =?iso-8859-1?Q?o2HJB/hhSmlABJiBA6pLU9JLuDX3UCtnKfsoEtdfNI2BGpT6v0+YZf4eUA?=
 =?iso-8859-1?Q?EuqN2fgW4vZHeG3d1HDJJOTjYxm5U5vnAN71g4p2VlfMrTMhhD7tsWI68A?=
 =?iso-8859-1?Q?puvoLcNIXMYaSD1YVTMru9bZKQQdOolWz0QDXe87zpZ5/aZdCylLRmRTLi?=
 =?iso-8859-1?Q?AikDyLFjx72uvejTZU5RsdqSEaPqzFbt4sFMPIJpY9QkjaKkbV9G4vgqp4?=
 =?iso-8859-1?Q?jufIwh8sC6mASc2SQFzaweujytt7GII4KHP+9WkfuDfq2O?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: obvIAmFuZb6T+c5pc5yAbfJyST8GkW/nlEmblWHSF5VyqZ0iSebXuKByjq2fCm9QXx3FjuY/1me4V6jVMZ10gv3iQjSlCvhx8SAiRC8FmTr0TH1/9Wl0ywsiCvgAnbcKbu+b6BbmS/hi4P9DFxsixkuiF99PhX9ZM3VKvPGpcFF4F0SJf4jENfAdIXxZY0Vby0iVssLXelWPM7bwNjIhLf8QNHAHeLOvq43AJVXPEwVBK/IhFjG5WKkSCUfmdKv76mWR5QfadQGtkTO21WE0EFP2ZnFr8DNqPzaGE1PW4iuPsFLl0oHGEWTE8eFBFfOF2X/65FebngMohIFHW51v4g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b7963237-ea5b-43b6-932c-08de8872912a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 00:24:37.6218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2iT5le3GwhRGhDLutb02vlcXsPRNHaNbVO4LaiiTVXeKR3AsUztu09ot8P+RtYECYkE78wHdX+mkRNokq2YdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR84MB3741
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: FWPRYN5dha0dmI1XemDZImBfCS51lCr_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAwMSBTYWx0ZWRfXxxmnlBimRKhs
 yzmTRldh8VHIlm3fvqt3waAucWvUxuVUygucAXkba6HVNH32knfAFmShVeN2mcj+0iq0jTAkyFe
 I9ih7ThuRSoRh5Aif4Vi6zmw20OKyl5SbeP2ZpBjTSUPAHWiWQrm4knR9DfInyR7v254hkrzT4A
 K3ggif+b3qtGAv5k5stOAnhmJai2dbySYZ2rdGd2xK/awkmyjV7/WDpLq71jguqGyHhIdIJJyrp
 eMdZULNCGyo2+0D7crqZ6lxMtYmV1UX1CzTOxn4YQFQSNcHCgyPkQaaNCq5iL/atQ+fFxii4kYI
 L6WS/i2HJXTjDX4tDnSV4D4TTbWSfZq9HfkttsdAa+kOdChmVSkqUlkLGPX/uiJhe+ReBz817R5
 gSx7XmfA1dJZPXGwKlsQ8TZ0qNG+hm+JU/QW289fi0VNu0TP5q6Avmy6If+ENkHJgK7vvV8Ma3y
 43hGjdhHh+BTsG9GTrw==
X-Proofpoint-ORIG-GUID: FWPRYN5dha0dmI1XemDZImBfCS51lCr_
X-Authority-Analysis: v=2.4 cv=JeWxbEKV c=1 sm=1 tr=0 ts=69c08849 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=k7r4yCLl9DVLXMiQTbtC:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=4WRzc9QnOF0kFBEKHOcA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_07,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230001
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227872-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hpe.com:dkim,hpe.com:mid,juniper.net:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hpe.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: F22462EB42A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
cputemp_is_visible() validates the channel index against=0A=
CPUTEMP_CHANNEL_NUMS, but currently uses '>' instead of '>=3D'.=0A=
As a result, channel =3D=3D CPUTEMP_CHANNEL_NUMS is not rejected even thoug=
h=0A=
valid indices are 0 .. CPUTEMP_CHANNEL_NUMS - 1.=0A=
=0A=
Fix the bounds check by using '>=3D' so invalid channel indices are=0A=
rejected before indexing the core bitmap.=0A=
=0A=
Fixes: bf3608f338e9 ("hwmon: peci: Add cputemp driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/peci/cputemp.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c=0A=
index badec53ff4461..457089c561b40 100644=0A=
--- a/drivers/hwmon/peci/cputemp.c=0A=
+++ b/drivers/hwmon/peci/cputemp.c=0A=
@@ -319,7 +319,7 @@ static umode_t cputemp_is_visible(const void *data, enu=
m hwmon_sensor_types type=0A=
 {=0A=
 	const struct peci_cputemp *priv =3D data;=0A=
 =0A=
-	if (channel > CPUTEMP_CHANNEL_NUMS)=0A=
+	if (channel >=3D CPUTEMP_CHANNEL_NUMS)=0A=
 		return 0;=0A=
 =0A=
 	if (channel < channel_core)=0A=
-- =0A=
2.34.1=0A=
=0A=

