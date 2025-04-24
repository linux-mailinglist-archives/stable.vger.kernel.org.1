Return-Path: <stable+bounces-136543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CA2A9A7A2
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 11:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6911A3A6DCF
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 09:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0F821D011;
	Thu, 24 Apr 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=impulsing.ch header.i=@impulsing.ch header.b="TVwvYikP"
X-Original-To: stable@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022111.outbound.protection.outlook.com [40.107.168.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08CD21C160;
	Thu, 24 Apr 2025 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745486664; cv=fail; b=idZmtGHYhK2MdtxNUj7cDazlzGE//0p1UNsomZ4P5tF/2fLhVsKaqI058P+ihiXRluG5AMLcnmeWpVkWYM4dBKbiy8mNSxARl2mBhuV+y7o1UASrKYkwkfMIBT5LpyubtXTlE2HXQzY9ew4Ni05mtjg9rhuNjuAczaIi6NIqsHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745486664; c=relaxed/simple;
	bh=S4YO/W8RJJyC5Xrb1fGSnP78Uu/SC0y771y/cX2NYlA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LX7TUWyvBqZGOn73kG/HKyLuSz3cEjsN7hTdsUk9lx0hYurpDlAS9sfe0lAVmPpf1zgJ3zHE2s9r3MdB0vlPQ0o/vhfmrT/3/dBty5/gunqNxk57OnYegXR1lZ8Ao2/hukf5I6pkXFWSIAGYtPPH7xhZ+Dq/8CBOkFxYOe8idt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=impulsing.ch; spf=pass smtp.mailfrom=impulsing.ch; dkim=pass (2048-bit key) header.d=impulsing.ch header.i=@impulsing.ch header.b=TVwvYikP; arc=fail smtp.client-ip=40.107.168.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=impulsing.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=impulsing.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgjSnIEYfUtIm4H57ZV+AvuRDGMsNenEquUhU4zIIa0NzQ9HBt0qygRC/t3bIlcZT4m7giJi+n2+5ju3bl72Kq0fJ+Ayu2AEkvCWMmglE4v9gSImA1Trl5Ohg64T59kJv7VyosfuO0U1iziJMIAJwcRu8bZmVdLs21DnJinPv1Ze/VfSwqviCGFRZZgBHiVbqFRLKp1/umjby6KNKaNGvhz+zsUypoLJdQMta92WPJ54b8VG+urPDzwWDm/8Tr0Q+U3+5xvp8gm+u4bR8dooUmfqSiIY9nkqLOcJpDhHtBcjnr/M6VLkKxmLpSPJ5CjuFsaMzKMSjzKDPHmJqW7a2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4YO/W8RJJyC5Xrb1fGSnP78Uu/SC0y771y/cX2NYlA=;
 b=pWdDWAowwau1lpwawOUhu9PqWx7rie+RYNb49+0yNWrJ6Tux7cWJ0J9vSCnnF9LF78Dy7YXmnlSMnRm826M6QkNqCx6KCV4fDcgAdbFHlLvstvY6/J/+OHiXgWEYZfwOJNVThCShBVLxyroNlFODOlrX10H9QGFqWqPWyjdReLhR4nXWUCGdFMy9AvcYqosCzxh9Shv4m7Y8K9UPkWmHjW2hv0rfSe3BBup5UJDsoB73vhVQEkzNi7OKlPjNLXU1IgHx3kxXsdntQV0ist4VeFU9CHwhGRRvL0rn/lLV6k/os+Bc7C2N8sJ9NUl9W9MNRmswX61px0xgTFCDrP663g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=impulsing.ch; dmarc=pass action=none header.from=impulsing.ch;
 dkim=pass header.d=impulsing.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impulsing.ch;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4YO/W8RJJyC5Xrb1fGSnP78Uu/SC0y771y/cX2NYlA=;
 b=TVwvYikP2LW+cqP8QbOyKXKNjNnV90KOQ2WOVif0QPkTKOAm58H/kiENLHLg37PeDFmcok2V9BKjYZUMbQdHBgJeh+KdCFXlm7MzRO4lk0+Lp+fbuyFTKVIm7tJXG1UBbwxWe0lyCnbbM/qqj3JxSKxT+99Qo6oJSFd709RRU2sr/hBTiKRbR84z6pdFEPqP68C8IEqIMZIBU6WP3Ec4purt6zI/NhfpoEVp8i9iGKout22s0PqXgQyOtPUBqfrtZFagW/gSzolWMtZzbyrZPE5A4qeka5B7ti8S2z8SxRiDL3r0I2RX7a14dYkR7XnzUSXyrr1F8DWUlQXdyYye7Q==
Received: from ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::6) by
 ZR0P278MB1296.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:83::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.11; Thu, 24 Apr 2025 09:24:16 +0000
Received: from ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb85:95c7:b27c:a819]) by ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb85:95c7:b27c:a819%5]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 09:24:16 +0000
From: Philippe Schenker <philippe.schenker@impulsing.ch>
To: Francesco Dolcini <francesco@dolcini.it>, Wojciech Dubowik
	<Wojciech.Dubowik@mt.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: EXTERNAL - [PATCH v3] arm64: dts: imx8mm-verdin: Link
 reg_usdhc2_vqmmc to usdhc2
Thread-Topic: EXTERNAL - [PATCH v3] arm64: dts: imx8mm-verdin: Link
 reg_usdhc2_vqmmc to usdhc2
Thread-Index:
 AQHbs48w0QwgOvbFxkuKoITcJDMRw7OxA+uAgAAGkgCAAAFvAIAAESGAgAE8lICAABIoAIAAEJCAgAAEAgCAAA3MgA==
Date: Thu, 24 Apr 2025 09:24:16 +0000
Message-ID: <84dc6fdf295902044d49cafc4479eb75477bba5c.camel@impulsing.ch>
References: <20250422140200.819405-1-Wojciech.Dubowik@mt.com>
	 <20250423095309.GA93156@francesco-nb>
	 <222ce25ee0bb1545583ad7a04f621bac2617893c.camel@impulsing.ch>
	 <aAi_PPaZRF26pv_d@gaggiata.pivistrello.it>
	 <9eb7b15068eb8a4337ad0ea2512d02141afd491c.camel@impulsing.ch>
	 <aAnXK0sAXqfTNaXg@mt.com> <aAnmZkpuaMOU0n2J@gaggiata.pivistrello.it>
	 <ec0f5da5a4da6b2649373530d0103d65ea990c0e.camel@impulsing.ch>
	 <aAn3qBG0ckInWvs1@gaggiata.pivistrello.it>
In-Reply-To: <aAn3qBG0ckInWvs1@gaggiata.pivistrello.it>
Accept-Language: de-CH, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=impulsing.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR3P278MB1353:EE_|ZR0P278MB1296:EE_
x-ms-office365-filtering-correlation-id: e53586ef-ece7-4088-ccd5-08dd8311c8ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Rk1aWXZJcEFnWGxOMWZSMWhnbGNmMFo3TUUrRldyeGpGVU84WTRJZWh2MU5K?=
 =?utf-8?B?U0xJNW12RURySDk2QTdwVExWZHNsQnQxOHlvSkp4S0RJeXJ0R2RqRnh2M2t3?=
 =?utf-8?B?S1gwZnVLSWwxazlwNnUxOG1xTzdJZVUwMExuZFJYOXRIRUdvei9HZ1I4SFpE?=
 =?utf-8?B?TFIvK2lIYjFZR3RpNms3UEhlS3g5Yy83WmczMUM5SWU1aW85NmwvVDBpS0g2?=
 =?utf-8?B?b216ZFNLNmNvVlJUYUtJeDVSSEltV2FvQXVoTVljbENvYm84Y3p1b202c3Br?=
 =?utf-8?B?a2RpM2tWb3hxVzN6ZUNLcnlBSFI5WHBwaVBSdkpnb0l3S2lOOVY3RnlSMFhP?=
 =?utf-8?B?aHA0MkRkM2JlbUZLQm5KMngvK3U2cEg3eERZOU5SdlA0eS92RUZueXc1bkM0?=
 =?utf-8?B?MUR4bWFmWElBZDZrRE5TVTdlaUt1RUxGMGU0ZzJSNEFFM05kOGU5WGxRTnBl?=
 =?utf-8?B?cjg4SmIrbzRYckpaUTRXQzZ1eDVCV1J2Y0ZKeWF6S0RNemcvM1p2YlVqK0pU?=
 =?utf-8?B?bXNSY1VSNHhMelQ2ZXZ5eThMK3BzNGZJU0g0WFVQdjgvVG53QmN6MUxJVTZr?=
 =?utf-8?B?amxqM0ZTTFVUd2owTGNHeFExOUVpaDZadGUxT1Iybi9GdG5sVVEyUW0zbFhL?=
 =?utf-8?B?Q1UrK0ZPcVlBOFY1NkFrcU43dFlzamJFUDF6UE0wUHRVdEhJMyttRlVsV2hQ?=
 =?utf-8?B?ZmtjU0pUVDgxK2ZVRzV3Ylh6R0lUd0o3VHUrcG9ZZHBjL28yUUV4bml2WG9D?=
 =?utf-8?B?c09UbGx2TnRweE0yeGtJbFo1eUpWd3NrckFEUkcvRDVqT2Z1RHUwT0FhdXlH?=
 =?utf-8?B?c2dJRDZnZEpXblV4K1p3ZVdwMEs0Rkg3bmZRWGVrVGVmT3h2cmNWa0tIZm1Y?=
 =?utf-8?B?RWlRcDFrUk11M1o4VnRWZ25GYzhXUGVIYnZPdkFVTVJGWThYTzZuMUl1d1lU?=
 =?utf-8?B?UDNmVVFsc2cvdmovelR0SGd4Umo2bnFNV2dOcUkwYVFnaWNJR1JKSTdTNU8v?=
 =?utf-8?B?MGdvTGFqeC9OWUlsZFBtTlYzN2YyUS9jd3JIMlJrRXdvRURDdWZlMWtmWmxy?=
 =?utf-8?B?eXNuMEJHSmVPa2k4c0ZIN2dQWEdoSmNZczZUZmdXUDdjaGJkalgyNmw3Rm5p?=
 =?utf-8?B?Zy9SNVp3Wk9FejRCYnMzbVo3YzNCUGtzaFhZbmlvVWtERGRJVHdCM29XZ0ZK?=
 =?utf-8?B?b0R4SEc0TmxyVXZXWWV4eHZPS081WFJOQVFPUm9UQnY5eHUxZEFRQi9oOS81?=
 =?utf-8?B?amxHeGpMUTBXd0ZwU3VqL2ZzcjI5QjI2clJDSVZTSmtYeVZVRCtPcDZIQ3ZT?=
 =?utf-8?B?a3hQZXFtazREZWI0cjd1UFF1VHJpOXUxSWhkcG50bXFNdlhjSDRxWStMWWJO?=
 =?utf-8?B?S01FWGJ3V0kwbTNxZVFFcUViQVArbnkrZnEwRnhFNEZtWk45blJDOG5MaVRp?=
 =?utf-8?B?MWNNNTR3aWcxSUlMaDdsVzZNOG5LUE1aL3dqNzQxZGtpcDZtVmFUWVJsUHJz?=
 =?utf-8?B?Ykh5UVZ5ekRmV2NuckJOcVRjKzNvKzZ4ang2eDE3U29CMmkzV0VTKzE2dm44?=
 =?utf-8?B?Y0JUQ2ZjdTd2Q3JVc2d2L0FwR1BwbWpQMkZ3VVk2UG5BekpXYjU3Zlg4NUdG?=
 =?utf-8?B?MHM5Wm9hUGRQSUlUZ1grUXYxTTNGZHFnSTRHMnAvVktvWk5zNUUya3lneWFB?=
 =?utf-8?B?R2FKTmp4bEJSeVZ2Q2pEdlhKYzA3RWpvR3lxN3R5VkZFV3dsbG4wdlZNMnBB?=
 =?utf-8?B?RWkxRnhqZ1ROQ2tFZ3NCbVBqMGtWTGRiby9meEhqb0tkckJVNHVqVGdWMnBy?=
 =?utf-8?B?OWZLWldwWTZBbG1mOEp1cC8zcVlYNUpFazNrQ3Q4dEJ6aGNucE85a0x4Zlpp?=
 =?utf-8?B?b3lqdEdEVlNKcldoakRua0RJUXY4dFd5UzFiWXFCMnRsdjVJYzlHQlN6VE5r?=
 =?utf-8?B?NXNsT2RuaWNQYjdQUVFLWEpidFMzVlVOdVY4Sk5lV2trMlZjYjVGNTFWZCtQ?=
 =?utf-8?Q?MNomI8yICFyEo6TgIiz/5CyvdoMh70=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVliZURwSXBYamdqTXcvQ2l5ME1lWEZuMUJIQWFnbFozUlJIYWJ2MGNsbmdt?=
 =?utf-8?B?NGM5Nng4NkVpM1V2MnNyeFJZc00rMGdYM3Z6aEpIRGFEZVRaazJUckU1VllU?=
 =?utf-8?B?NW83RkQzbERFVTZjTlhMc0lyNlZEaHkzZlBsMHpxOFZGSU5WdDlDa0pXUy9L?=
 =?utf-8?B?QW9sdG5KV0ZSbXA1c1Y3VXdiTEtWZmZIbUUzTTNINFRrL0krcnMyZmpCdzI4?=
 =?utf-8?B?VGFzVnd2a0YvRk51em9SL01mZ3J0bEJCY1E5VEVHM2FRQ2FxdGdBUGU0ZElD?=
 =?utf-8?B?UEpCVlc2dlQ5TlJ5Y0F6SUtBMXllaXZJWCtVdS8vZHltWHZ3eEJXYlV2UHpQ?=
 =?utf-8?B?YzE1cVV2STRNQzZnY1NscEVPK0cwWjlGS0ZTZTk0eDJuQ1llVC96MFlISnpw?=
 =?utf-8?B?UUNadFlFK1FzajJNSG1Fd3JnVGt5WFN5elJnWEV0djBJUFNKRlJ5bnNyVWJY?=
 =?utf-8?B?NFlGbG8zQ0d2YzIrWTk4NTh1bDFIRG1PVVF5NEpuZnh4SVdlSFI5VCt6WXRO?=
 =?utf-8?B?Qnl6VzVJdVM5N2tCM0FBd2Y5dEl6WGZ4VGdFRGhhb1M4UWx3NDdMdFRBSFJ5?=
 =?utf-8?B?T3A1K0tHcDhDZEpSTm9iVitiOURTNzVPaHd6Q0dBbEJJbjRPUlNXMlpxLzdi?=
 =?utf-8?B?NE5oR2t5UHRDcFZ4N2xORjZZN05UcnV2ZnRyVWNZZklGVThkZ2dNVlZsNHBN?=
 =?utf-8?B?ZUdmc3NYR2NYRXI3RGRYWU5oeWZZNExZbWxCRUtodHIrRFErRU1POTBoczZ4?=
 =?utf-8?B?L1NxcTRjbW9jKzdUU0dkU1JVN0I1T01Yenk1SW1VRzlIRGU4Yjdkb0RCT25E?=
 =?utf-8?B?M3BzWHd0RVQrTk0xbXc2M0kxcVpVTWRXbFRSTnFuVU5ka2xOQU9JbXoyVE5p?=
 =?utf-8?B?ZFpPbTJSWTY0dktHaitrcm52YTJGQUMwUThVcjJaNWpRN0pLaENKSEJmVDBt?=
 =?utf-8?B?R1pYYkMzd2xKYUc2VTJMUjYwWHdxUXZHdElXdEI4NERaWkRwM25EUFVXNHJV?=
 =?utf-8?B?T0hUcmpuTXc5RXZhcEF0Mm9JWnNCb1h0d0s0aGp4OGprQU9iSUxReFh1V09B?=
 =?utf-8?B?aXE4TlBtY0lKMWdZUmdtTmZRVEp4WTlxdG1yR3ZtbGVxakhNRWxLWllPaDNR?=
 =?utf-8?B?bkJVdGdJYlhPV1JTL3hGRjBEcnlvclNVQUFpVVM4akI2bGxRUzJwK1c0aTBo?=
 =?utf-8?B?VWMvL2xuVllFNG1YTlNRbFNBZWdqUWt3KzJpMWt3UU1xWHRoQW5HckJsTWUx?=
 =?utf-8?B?KzlhdnJ5MXVNbFdFNnI5b21FbnZEMXUrVlFlV2ZBSnc4MkxVN3NYSjV2YXlX?=
 =?utf-8?B?RDc3U0F3WWFQTlprbFpWajVoQ2Z4SjhBYlVuK3VLMDdDZTR3UEFqNlFpWGpE?=
 =?utf-8?B?R1dBTWxIU05zUVdnaDlGd0tFSEM3YmZQM3E3SE9YVGNXUUlsNDI5NFNUeVVr?=
 =?utf-8?B?L2U4WThEaGFyM1o4S0dBUERpMlFsWFRQSE5iWVJJRVdEWUcvSENiNW5iOUgv?=
 =?utf-8?B?ZDd6Q0RUYTg1dERnZEFCWi9ZYi9DS1lIdEQyQlNPRXEwZ2h1STRxb2ZwTkxW?=
 =?utf-8?B?N1BxYjRSMDE1RVRyN1pnNDF2eVVwQlkxSlJ3eFhZU2h1amR5WE5oUDBrWUcr?=
 =?utf-8?B?cUgwc3UvTE9vaTV2RDZsNWs4SXpRNUdWeXdWaEhMZndGWDE5bzZSM2MrdzBQ?=
 =?utf-8?B?WEV3QkM1UG80WGM5RjByNS9YS1N0bnpMVTJTRHVtSytZR0RQVFNUdVlJL2xx?=
 =?utf-8?B?blkrU2R1OGNMZlVBT1lIdFNqbDlDdWQzTlVVNXNUQ1BEVjJGYVZTcklydUxI?=
 =?utf-8?B?Ujh6cm1tZ1FnYk5PYklOOFkrb2tWckYzREZOZ3c5MzRFRTBrOEcyUWxzNUhv?=
 =?utf-8?B?ZW9kQ3EzYmw3bXFjUTFWazBCWEIyQXErMktsR3lyNUVXK2dQcEZHR1NJeWlz?=
 =?utf-8?B?Nkp1MSthQUtvU3l5YkJUN3dxb2JVNUt2V1RwYU9XRkFDZThhRTMrL1cvSkxJ?=
 =?utf-8?B?T1lUZWZGdU9lTElYVmI2VkFlMzhZSHMzN2FxUkpvOUR6R2x3VW1zRlp1d3pR?=
 =?utf-8?B?WWg3VW9CR3RLWXlFWmhYczJsWWU1YkpSeVJCbDJ5ck5NcHN0dGFidmlpSHRn?=
 =?utf-8?B?NzNKOWdSMEFpZjR4c1F1MStWSi9sbHJTV1daSVUwMm5HV3RNcnpRaFRQZTVF?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="=-mUxwj1/PUgc4vPFkpK0s"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: impulsing.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e53586ef-ece7-4088-ccd5-08dd8311c8ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 09:24:16.0764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86709429-7470-4d0c-bd3c-b912eebdee40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0f+Kj5ftJcfewOdLCCPkFu66dLjlBNKIEyAk114Ai/DJouOt0ht8V8qKxXNh73a62cW9slPb7TuoqCfQ7Rshvn15mZKT+7K+qaLN+NbkhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1296

--=-mUxwj1/PUgc4vPFkpK0s
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-04-24 at 10:34 +0200, Francesco Dolcini wrote:
> > >=20
> > > My opinion is that we should backport this fix. The DT
> > > description
> > > was
> > > wrong, that change on the PMIC driver just made the issue
> > > visible,
> > > the DT is about the HW description.
> >=20
> > From what I understand it was not wrong but it became wrong with
> > the
> > PMIC driver changes.
>=20
> It was wrong. You had a regulator described as not used, and
> therefore the OS
> was free to switch it off. For a bug in the driver this regulator was
> not
> switched off by the old kernels.
>=20
> The DT description was never correct.
>=20
> With that said, hopefully it makes no difference in pratice,
> f5aab0438ef17f01c5ecd25e61ae6a03f82a4586 will be backported, and
> therefore also
> any fix to it should.

Aah I overlooked the Fixes: tag there. Yes in this case we need your
Fixes tag, you are of course correct as always.

@Wojciech, please send a v4 with:

Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for
verdin imx8m mini")

Philippe

>=20
> If for some unfortunate reason we do not backport also this one,
> you'll get a
> non-working SD card on your LTS kernel.
>=20
> Francesco

--=-mUxwj1/PUgc4vPFkpK0s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNATURE-----=0A=
=0A=
iQHTBAABCAA9FiEEPaCxfVqqNYSPnRhRjRDjR2hoXxoFAmgKAzwfHHBoaWxpcHBl=0A=
LnNjaGVua2VyQGltcHVsc2luZy5jaAAKCRCNEONHaGhfGiYNDACSeAR96JER5XjM=0A=
32PaEiFixuIXhctgB3eerYlocY5jMDkA71sk5zTejzvN1XvwmUuJgKhqpD/pDWFH=0A=
hDKeGlrT9DumEQ0EYg60UJqAceN62OZSV9w7pgQW2Pi3Vta3nVxuXbNb4zm6Aul+=0A=
JYedrohFjX62YIgIH3/pN11NhcLPHxRxPd+FSQUEIL+1lIEpzevV5Xyt7BNVgd3P=0A=
XcYaQHlAiPUeU8tRHE4Ih/+36gXQSetZLJU9gBUmL2A4p9jGuJz5PASjFlkaHAcc=0A=
t3sdC0B94rJbat8IKuzFhNSN1ocWfdgGm9z6/iwtyhpY32xdiDcGoC771lO1i3a1=0A=
Fe2B3lZ1NFUK71FUs92uxEOjsxB0QVODf6s0v2GYmZl9/T289UWIKtQfEoM7cS96=0A=
8v1ibFEACvtDFNScDVuTcsB3BmDDXCgiSg6++TLyyR3P/mFar/RfILL21VKxwfvh=0A=
CGZ+XgXBWVjJpLgHxqwUe1EERwQE38CjICbY3HqPTXE41qQ6vjY=3D=0A=
=3DwhwC=0A=
-----END PGP SIGNATURE-----=0A=

--=-mUxwj1/PUgc4vPFkpK0s--

