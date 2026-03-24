Return-Path: <stable+bounces-230059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCMAKbc4wml+aQQAu9opvQ
	(envelope-from <stable+bounces-230059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:09:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67852303B9C
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A2643193661
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 06:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7AE3D412C;
	Tue, 24 Mar 2026 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jgiu0saW"
X-Original-To: stable@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010014.outbound.protection.outlook.com [52.103.73.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8C3C7E0C;
	Tue, 24 Mar 2026 06:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334515; cv=fail; b=mkH3X6IwP3XgTNXh7zrowFNKd19XC5D+LqBAaftyLb8dD5rBpRaVwgW+dDT2t8KLfduqy7uDEqS4PnG6mz/Eo9XdpMrMqWLl/oUZDvY32oFD67tp1EXzsMbRp4vo2HZRJj1MV58xfkOQSXOaJuak/OvcmeVFzjM+QWX/TWdvLes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334515; c=relaxed/simple;
	bh=EHu5eNCqAq6d/SRYhmbTyYLO3BmarBporQEJjyYFb9c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jI/rmd7QacEyzD2wCcGD+aPqo6iRunTp1Sg9y03Ezc+FwvEwWLKCTPPrJX7lzidPEJNGrJN/oDjnrxt8hoBR9e5eT84XnMkBlAeMQPNWlSA6glEDbKcV8rWpHCgSmpVe8b3zjVY7W5Ssj9OhTTcXsN/zbVpHOsm7P5l6rCTP4VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jgiu0saW; arc=fail smtp.client-ip=52.103.73.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmOXmUDVqgjcHjo2AGwq7c/QcPmb8u4H311570UGzkVoytlZGS7VXnNy6Q8BPjI7tgNltNmmXtMP1107tKEkflG5iRLmfjGl2Qc53tCwBGEOCscNQva1zVT/LXd6mCBO9YEKPDI0lpqSIn0y2krAo2FWOU1EINWz9KTRX/gW5sRXlCisMTl/cXsHzF3sLOA80YzkjzOAgnZckuFD0n6RhYF0xJ8NU5X6X9mbAjyqRjKWwoOD7T5OuBRmWs31dFQy4TrxiH8b1GV9pUvIYDUnu4f7b1yJnUH23GSqQdKcgTOy+wgVWUgectNjaNE1KUC1oKrmmhFLAWuV9c1IxpNJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtaT+GrYrtcL+Z/oWZMenaUWRgLO6nXUNpEPVqTjEwc=;
 b=q8C1mvLEJkp6l1MTE7dfiXNlt7Qzcxplc2nn3KTQRekIUU6C/s7uSV0BsBWXqw3S7N9IPosZdw1r4Ds6XTRDCf9X5RRGBoejybVljO6lBhHBbMfh36JKeiIShYNPWQI8vnWQXwsRCEIID1oHG1PRVzROMgrAry0HwzZoJp8KbFQ4ZZkRZDcwnU/LiJAZsoG8Y/qO/usXoa0kEeqNpd4rgymyr9FGbm3B7D2GfAlJtQDZiWEeddHR1NGQp1jyWOm7Ss6dV2qYDSUGdaKobHYPemFMbw7RlrYfSD9UP1ylfo9P17veiQtThAlFXPFpYs9x0FHG22ApMmbAseed2AEriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtaT+GrYrtcL+Z/oWZMenaUWRgLO6nXUNpEPVqTjEwc=;
 b=jgiu0saW+yOxGa280xiY5ZrxS8gArFjpSTNHlAwGDl05sF0ba6BVQal5YMgdLbdQKOYVwI4iKkNO7ORZFLALF+etisZgNy9kVKZoX6hMA5d/xkR19VhUqnRupvP+7PZkdHpYXQUjU8Y9Zn8iaBm0nRyKE2uEeQLHc2kSb9or6E60NUA4L4Uo2dtCKny4LVwggE7FE2GqNKtjt1lhLeFCUidyfkwYWUGNEFitJ/0jt7tQXWTBQ7MEbr2D2WhLLF6DBEVsE+M9Xj4ve0AXygmP3fwpdSF/eFRmAi8MIwtNYSKMiVPFnzYZ3nLNep31p+OxydS5yasEJAsdOvkrgBspzg==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME5PR01MB10001.ausprd01.prod.outlook.com (2603:10c6:220:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 06:41:45 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9723.022; Tue, 24 Mar 2026
 06:41:45 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang
	<teddy.wang@siliconmotion.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-fbdev@vger.kernel.org"
	<linux-fbdev@vger.kernel.org>, "linux-staging@lists.linux.dev"
	<linux-staging@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] staging: sm750fb: fix division by zero in ps_to_hz()
Thread-Topic: [PATCH] staging: sm750fb: fix division by zero in ps_to_hz()
Thread-Index: AQHcupdRDbGbwchbjkiKA2UtqSpAIrW7ygUAgAFzToA=
Date: Tue, 24 Mar 2026 06:41:45 +0000
Message-ID: <31686C37-FAD7-4E47-A75D-F76DF88A4EBF@outlook.com>
References:
 <SYBPR01MB7881AFBFCE28CCF528B35D0CAF4BA@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <acD6pMfM9XjTXdhf@stanley.mountain>
In-Reply-To: <acD6pMfM9XjTXdhf@stanley.mountain>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|ME5PR01MB10001:EE_
x-ms-office365-filtering-correlation-id: 950c21e5-4cd2-4011-a04d-08de89706b08
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|22091999003|24121999003|15080799012|19110799012|51005399006|8060799015|8062599012|440099028|3412199025|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?608Oncj13BiykK3Xja3s6QaOo+B0ki3cYTm2SX7s5fEQNElYeIm1xX5HS9GC?=
 =?us-ascii?Q?RKmiR3eo3qeeuLpLppIux9aIkaQTQJGoF4HdD3joF/K45/eFeNUCFzcgTo1m?=
 =?us-ascii?Q?cW20JYdNdqb61010Kh4cBgvXCJtDkYppyyh/D+pNLqe9KxDC1pclGoGYfENz?=
 =?us-ascii?Q?PMis0gHxOhWdFCePQqF12mrvFPCJQZAN7cTmF64lfnUK3x7GjllGvO2jW2Ot?=
 =?us-ascii?Q?bXGi5C5PTlvTplGPwmBaqZZtr1L24WKLUflsw3HjBY4k/u5RCLOeQjjxoAj2?=
 =?us-ascii?Q?FHVBLXTxqWDpSiDqYJo0tAedJHdGReAXgQ4CoJ9BJXBasHOmiCiUby0u8EtS?=
 =?us-ascii?Q?8VWR11/VB1mBFzvY8C0/uvMgTqbZI9GONAPMkPmgqDSQpN27vu6qQh3q0mve?=
 =?us-ascii?Q?eDQUtGUEyRA995wDCaV8aZZ6iuyqhG7KJuKnI9Ncs/tkZtZmGmxrtz7HpZLI?=
 =?us-ascii?Q?2wmLgplKPeSj1YcxmFzK9xgA4qm0Wj5U5F3k0F8g1zPqjStvOGYur5sqX7Vl?=
 =?us-ascii?Q?ZF0TzwdcF6DTBUD0MJDDOgAS7SgHiCbM0Wz4g4u2zWJ/+eRGCGamoLpArDuN?=
 =?us-ascii?Q?mScb9FPe4EF+5f5LvhTcgzLb8E3+5EF85KI84OHgR05Crcn1hEhICY6uJvzu?=
 =?us-ascii?Q?IY4ULdeZaPO/BV665nbBz05wWgU1EHO99KkDK7L1oRrltge0l/B2/tI+Fgz7?=
 =?us-ascii?Q?tJqdZ3tm258VPkkbAE4SrrJ6bzgGge00ND7kYzXwL4mHwMjd+bWmVnRuu/Bd?=
 =?us-ascii?Q?vOHkm5pgN4cEqZxlmmoJhZj9dGcuBSo0vSSgisUlDFXyI87+SASSlxKrz1aE?=
 =?us-ascii?Q?d51lF8yCm2pREZ0yKyEyIDwBlq/Gn5khfKE+tjo7gpgLqggsTMCIRKlfIlOO?=
 =?us-ascii?Q?Ppl1Qc6qbbIkJcf+I1xZx1vD0L/jqlNmKv4KRt4cfUVClqdSXWNhPeg9eElF?=
 =?us-ascii?Q?8f3wcCJBoeidtw2hbhu90F01zBlC8uBH4lrivt9YVok=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lxfY2/+0DYJSbMoEipBFR2RIax/b0RfBX7J2x7iTUJaZ7gcbO1exYrVh/a3e?=
 =?us-ascii?Q?WMOU6vVkPPqS0RwgkrCDBJ/i3KUfbeBKD34LC7xX4WTMPgB8Vb7OEek6iYu6?=
 =?us-ascii?Q?mCeLzPm9cKw584hE/zDc17awep1Y2v2XPhpWdlveRbIHMwtM8gfeBbN4C0md?=
 =?us-ascii?Q?EqEofU4LIZXOjn/5562IPyrfyuFGCXkyVfjEWuC8i8efSvbM9uW9M24oEKC7?=
 =?us-ascii?Q?MAzfNYmjXnuid03i+4io9pBx91FPP/4m0gwgkdWCYPAkGeiIUUBDUkAXyTKQ?=
 =?us-ascii?Q?xseSaJr0mgaMxe+iKUh+gDdhSLHQuI/FKcCQ2nkDV+8XNu1ruAkqxomCpPaQ?=
 =?us-ascii?Q?9bAvP6XHy9rvT370KMTztVBUxzExNleEOVWPwiKAocBVWx3lGtAV/PKf8Z1Z?=
 =?us-ascii?Q?vtQ2Sym8bbIBPmy05KMD042wDtUnAZjsIbXGPw7WKVlcmfznAE7L02Rm6oRs?=
 =?us-ascii?Q?EKt50iA6QKAwnUwqtXcIJb8fdT9Xv9ImfCxlpqWsgb60akn9GX+sxAH3ymZy?=
 =?us-ascii?Q?eF5GUN21WLyCNucCUQjz9M/wVldWERvJlWSq3DaEzVnwc1HvWUqq54GFxyON?=
 =?us-ascii?Q?18HpL7ELu8vwmqF7hZ0L5dkKhzsbp3ZwsSf0NG7NyS61tY+fz7deBRWiEFxw?=
 =?us-ascii?Q?65LZPLdgUgXnAXD1Cf02qEKPQHO6GuB9YkA4TMsMziOSYN8L3oFfrUZ1QDeX?=
 =?us-ascii?Q?Uw81uHo+nP3cIbBYwyrBDDaTo1l8fLjgWfzY/VjB/4PCClKZKi9SKEAq9DoT?=
 =?us-ascii?Q?ngkAZqgNM81Mmx3qWricRHiZdQewaVf35a7w+vNvzQrll/dJwyZP/x0jOdBh?=
 =?us-ascii?Q?AcB8s4TNXa4cKCqZ5dusNvlmibVd14SmgcBZ28q5Q2JCynElus4JKjtVS68X?=
 =?us-ascii?Q?1Aymu8gqaqycQA7D4gtoD9Y/Ilm2FyzZSGIXhBmL+xZjS+Kj2F4RjsNAMi/m?=
 =?us-ascii?Q?JMWwQXhMzhvFJmfuaeSp/C7vQDlNY1iV8yATDKuQPomJ4RSCINFhFD5RERI7?=
 =?us-ascii?Q?jvmFpvZZq/FcZC8tTieWLG4WiwTOd2+5Ia5BT+K7njnmWO71HsS/c/MfZie/?=
 =?us-ascii?Q?k9v8HANj4hd4KPqPZv6wJWO3WzeSq8CUfFeqvQF4kr7xKcCibwfeGohnkMCj?=
 =?us-ascii?Q?xmmkGTJHSPmxnW4jPPyBa946ybox0VRl00jHQkeDTwl1fNpNIjgV1SFN/6Cl?=
 =?us-ascii?Q?gutkqxdJEn4IOU2OyivkQ2mYCyeLXdY2Go/CcYwsLi7YHQhWLxRRcKKahURQ?=
 =?us-ascii?Q?KOrJJjd/SSvaoqGTf5fkwsLMz7if1RV7chlt9xnySx/VC5M2oq8EPP8Mb4dC?=
 =?us-ascii?Q?zwfmvgSjEeB1qNp01zhGW6tVQ4j7a1fc/nn9++63+8B/Qg9DiwUu/DVngmW7?=
 =?us-ascii?Q?ugYmKJ5tMpXrZ4CPsJ5HZFjcGGlYJcKOuPFFkrKfbU8Av1Nu5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C1DD66610B0D944B3E68B18C5B8C2B4@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 950c21e5-4cd2-4011-a04d-08de89706b08
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 06:41:45.7231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME5PR01MB10001
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230059-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,siliconmotion.com,linuxfoundation.org,vger.kernel.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:mid]
X-Rspamd-Queue-Id: 67852303B9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:32:36AM +0300, Dan Carpenter wrote:
> Seems reasonable.
>=20
> There is no Closes tag.  Could we get some more information about how
> this was found and tested?

Hi Dan,

Thanks for the review.

This was found through static analysis by Yuhao Jiang.

I don't have SM750 hardware to test on, but verified by code inspection
that the fix is consistent with how other fbdev drivers handle this case.

There is no bug tracker entry for this, so no Closes tag.

Thanks,
Junrui Luo


