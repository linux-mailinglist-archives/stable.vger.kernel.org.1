Return-Path: <stable+bounces-216234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCApFmoxj2mhLwEAu9opvQ
	(envelope-from <stable+bounces-216234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:12:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B67D5136FDA
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D7D3300DF5D
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B51360720;
	Fri, 13 Feb 2026 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="LFyJfHKj"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011063.outbound.protection.outlook.com [40.107.130.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203FF3570C9;
	Fri, 13 Feb 2026 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991847; cv=fail; b=TPBDhsx0+hRhxcJIA6/+ibDywsotos9twqKWh9TxJPRJyzfjha/yqYw0DfVuYumzkU+mIFqLgm2uFUAO8wq7VfGIhdKZDfe70VuFMAVXHwSFOB9rFxgI8fHwx2HOzxzgjcGTPy2caB8i1GHA4zjurtDyQTeX5l1Vu/NwncxJl8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991847; c=relaxed/simple;
	bh=kwjadFmFcV0b6wAYQOqmdq4kUG5jPqA+8VKlBYTyytg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mVP4Z13nJPhWMK0EKT9gClkfRl98EE1S6vYl3YC3ukZhnL6nXR601m772pIpICtDiavtUMaOrXfMF46i+CX7VxGOfjcHOGlUgG6aGPZUwkXoJyNaFF4yl9QaxTfmG9hchqu9CpuqJnZti14UGMKYcY9SaQHCyLFoypw8KGyA5BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=LFyJfHKj; arc=fail smtp.client-ip=40.107.130.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vllhIvXqMmbeWZXHDfJ/JaZI/fcY2biifTZYtsZm2WdE1OPRgK5ii1fzJS8bHFqwoxYgjERBtsQGscBBR0AYsaUcFyr5Q1MI26jB0kyC0agjV+N3Lh6HDD2LW6Cbwvx3dJzV2FK/Tgztw9hSq9/BB+jdYCxNV1+Tg6KFnP7iG4XFjZV+ka4UZ6WE9Squ9OIYzfaZpXAAUK2cYZ2/nfpglDskIYAIH88WyzabNDCGC6uQtE0snhkFlaUUJOPsJO7/YF1MetOwFHwjb7hzXr7awoUQuSPySvobCN+aaGH3Tf4Xo6jGtSQ3XRhW7Yx0YbSaqFYLgY1Dn1kgaMkggyQTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyPb2OSdiYHiAt2KU6cBcsHtcfCWFDMN4XPfxBugGvc=;
 b=oaGe9Yv1+n6wWCnErlPtDIx9lR2IT5wP5qjQ7K9ueBetipfFzYAG9IQ5ukj06Vkms7RUIrvTJWOf1ytr4jZ/JgoBGhC6hv3tC7/62mfDLc5dL4CCA2hiLJ4cDoNgIQmGV310BdvheM9/8o6hmtmHwBW7Bv1shIppdDmfmTlfKoQ7FnocsclmrKb+cJpe2NN0ExtQFjOnBXJRPRN9YQi9Wx6ljElb/rDB1FU8LrLRL1YYib94NdnWDqL5K5CkLt51UeVaXaTOlU8XGC4QAbtBb919tolf1lYMTK4yAJB6ejnvvxXd9veJfdmvi7AIfRvpPtxezSSJL3DOTwhh5XwLJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyPb2OSdiYHiAt2KU6cBcsHtcfCWFDMN4XPfxBugGvc=;
 b=LFyJfHKjK58bygivuIvsX8Ay2WMPxvDXtDu740Fcx2NRfackf7q9Qs0eUJf3O/Xk8Vnp2CjKwxTjM9NCN+U9i8rh26EE83K+89kWvVzR+TvXov08aAvdWAQAhZyNgKWA6P5u7wwGSIERN7iUbR2o9VY1Hoea3NcaIFJ590lujbpKdFK4NMxE64A9925dM4NO6AW2017w/5c8GKxsggOA13ZqwV/pxwMPqMPqhS0qa+QVKfCefxOtnJiQGxMeF+GSbR+DQs2VgKYuPJsMVNGLZkTi3ynqsm+9yOxRQ3RcKh/ngtacEUgQ6IVCPvyEwFwriiNlM8juzGuzjhPSIwwLtg==
Received: from AM9PR07MB7204.eurprd07.prod.outlook.com (2603:10a6:20b:2cb::15)
 by DB9PR07MB11159.eurprd07.prod.outlook.com (2603:10a6:10:60b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 14:10:43 +0000
Received: from AM9PR07MB7204.eurprd07.prod.outlook.com
 ([fe80::1f2e:eb0c:2b1a:9cef]) by AM9PR07MB7204.eurprd07.prod.outlook.com
 ([fe80::1f2e:eb0c:2b1a:9cef%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 14:10:43 +0000
From: "Igor Klochko (Nokia)" <igor.klochko@nokia.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Philippe Belet (Nokia)" <philippe.belet@nokia.com>
Subject: [PATCH v3]  uio: fix uio_unregister_device
Thread-Topic: [PATCH v3]  uio: fix uio_unregister_device
Thread-Index: Adyc8IX9McfdXwgPTjCBB3tZgBkzxg==
Date: Fri, 13 Feb 2026 14:10:43 +0000
Message-ID:
 <AM9PR07MB72044638C53C08909D71E12B8D61A@AM9PR07MB7204.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR07MB7204:EE_|DB9PR07MB11159:EE_
x-ms-office365-filtering-correlation-id: f8bf8d7a-92c6-4efd-048c-08de6b09acf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZCnQNPpRP00Kf/2Vea4kGG+aUNxD2tvbYe1gag5do9r3bZk3lQzsotgQEX1t?=
 =?us-ascii?Q?U8eNkF8suKVsWWpR+el4C27fTIZhrwMLWqZbVoZJHQnmLQL4QzMLs232YRMX?=
 =?us-ascii?Q?33dVVz+7///0Q5mrdH26o6IWamPf/OrVQTBGjawH0zwjZkzSDcd0j6z5evp8?=
 =?us-ascii?Q?SToHgU2y+eeYfT2Vq8jo81TpVoVFQQbemI/gposoceQG//jFpH8qIrcurN7C?=
 =?us-ascii?Q?/kxN3CtyRrwgJRSLpA1NRzfk+EZyZiHc4JE9rQ7R5Zb8Lrx9U6y5xW7Hw7dB?=
 =?us-ascii?Q?SAT270YiGrS3ZRtCqM3MtrfAQtAirrgvAr10J20ZFFdDxR7EoPR2mnOnvmx6?=
 =?us-ascii?Q?psI0luH5HMPhExF3qoTf44FZgLfYLsPIfMZi1PCJouJ7mUbzzkQbuPlRq8jp?=
 =?us-ascii?Q?bbLJgG1MgCG6hipDkc8o4Iju/KzGA5H4qVcoMXiLboqRT0WfMs4NuH8FtZbp?=
 =?us-ascii?Q?soUjK9OVqU7W5ExdaEzTq0df+jw73VUtmjasRQj051OBC9B8VGM0qJgpEtBZ?=
 =?us-ascii?Q?b7GnNvA+fdCg1OtjaGmStObknsLGsyJezpNMWUpt5+ANS2RCYqPFtrVZDShI?=
 =?us-ascii?Q?VRQ5USsGPelTEVPIb3KhbQFtIwEWQ11kD3Uu/QuHa2hnPh32zihL1sLhguRV?=
 =?us-ascii?Q?ZEamBgwsHcUWjamD0S9n9ZTED+cAbfDCZobuPBTkP7i2IxK+vYqxo5Ja6hGt?=
 =?us-ascii?Q?2OEsEjqG++gcjvhC6HlEuxstY95M89iEbBsPReEp/q30bu1XUp3KDzk8/e0s?=
 =?us-ascii?Q?k5KrJjiMfqCUg4qgFN0Ir8PYYLFvGdWQPqfZiAR6LafQTloAnuuUJYz8+wNp?=
 =?us-ascii?Q?ZMVqHr7tCRJ+Jb1fVrhpBKMpDqLg9mGTWtnEbFo1if001+yVQsvYbXhGR0C+?=
 =?us-ascii?Q?vsjHElF++zhDP+vlTEUN+2ZbA6rJUDRo6v+rTiOb+vk/7+fhtS1Xx6QmCJ3z?=
 =?us-ascii?Q?8pm/x1o8+FNkOFtoMREFzO4zxK9bj8j++xSPHEGMjOJtwPFzexj12FqQ6Jaf?=
 =?us-ascii?Q?xQax4p13fJwHlIgT0NWQAyubBJI7w6Vkdgmx31Kop1tdAnxB63YpIUNLidNr?=
 =?us-ascii?Q?afv8cCDpkgkOUPKN1Ullv27EGwjSIrFCkcHh/0loNB6Vr1hGT3HhB5k491Sv?=
 =?us-ascii?Q?AZHWD2QLsuBCBa2S3qTiqmHHhPpI8xwvk2/oyVrIi+kP+5Si5eAv/vxIHWqL?=
 =?us-ascii?Q?QTvUy2xbtgGw2yiImxzpw2Sdl8VaLcDdOKtLLZ1ItraXecnwulE5C343cYz3?=
 =?us-ascii?Q?IxDiTYW9JjjOoq2TrvU1WG7O4hBlKs2exoMMJiwDzn+KsmBh44mBN2DbotFX?=
 =?us-ascii?Q?GobmZzbaXlNSY8wX0KPY7FlIWvUYgK1uni3pHmmEHFUFobLayfwB8y7t/D+X?=
 =?us-ascii?Q?KmIS8sGhwz2MF/ObQrD4QEdGQZSZs5AZZu5M408aHuGkze0gvz10VAiIxtT8?=
 =?us-ascii?Q?Ctc5+uByuCmCuMTv/Ja9+lTOEQj/9/g9eP1rncv99QZq/AdD65CZ/oyichwv?=
 =?us-ascii?Q?s9txqceRokdlj5IBGtROOUtk1Otcdo+dUZXEuZq3YcNxHX+SaOjXEdRrftEa?=
 =?us-ascii?Q?8EIzixLr32brH4UNcp7NMNpbGzU1KPxWR9AOAv0b1ybyZKE4UNszASgJFTvH?=
 =?us-ascii?Q?oFaRBU6HM/pyiur9YGZz+mc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR07MB7204.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?I8iqHcxf2o9x2HY/OOPcpWFGLBxZtGQDlJIsD8BaIYu6BinlnFLLBYK7qr5/?=
 =?us-ascii?Q?nI5A7mJTx271t/YP3bCzKgSeeK5k05Atbi9uuO+HtgkosTZOcoyA0n0xfGKf?=
 =?us-ascii?Q?kknwrm/JP+XdLzd+4UTezNbYEcI6hfd22t8oymldB79j9QWG4JNvi6TZ6gzs?=
 =?us-ascii?Q?AygDPss0riI8UyP9+ebECyb9lO3z53h8S8w3iZwfCGY9mV+tsc7LjzlC4RsT?=
 =?us-ascii?Q?PCLJtb3LvtYqNSSnaprb5KVshWM+cQHFDb3G8kVxhhuBrePyhauZ785UduDY?=
 =?us-ascii?Q?+bq9d5cJ1f+QbQBK2CtZUWm2HvrujbL4HqhH9TdqfdKWY0HVJouymstKSAMP?=
 =?us-ascii?Q?acptlom/S23DskW0T1u3IbLLdk2fQS+zDYhsrRTxaaUv57CgnbseoAK9HtMf?=
 =?us-ascii?Q?4BkfmIpLRU8ld/gHsKDZt1eqqXS5+qJ63JzvPVhRQB+ZCbZfvJSTl0TCM3i+?=
 =?us-ascii?Q?DlENhOfymtyf+mMNiIvZDkMx0+irrJMrHTsT7/LwecN5fgUyCgmXE7iK/A0A?=
 =?us-ascii?Q?I/S++5jhzNIIU4K+ynlgrztGjRcUrcJvSqZiSdiDctL/u6117SSUGal6dy9C?=
 =?us-ascii?Q?WSimxhH5bWkzn7A9tMaY19DqcbcmaohgU625g5RpxR6LiLRWkQnesBWP1nfd?=
 =?us-ascii?Q?Q3ljJD6I024DONUPSOjzhB3qj5mav39ufzHh9LbCACbWLl680BBz8FgBNJOg?=
 =?us-ascii?Q?WTmFOA2YAe6vVbGUB0OmMz7ZcvoYicjkSJZVdVC7K9rRPurBBY75qHZ4/+eW?=
 =?us-ascii?Q?jvIvNJS4r8AOvSct6FfGHVYo+sxxoERahrDXNL882eha1hu1yFgB8e4/r3yD?=
 =?us-ascii?Q?KdlCkiG7IzgkVapUVKr/mTUaTcihCJBxpSQYSan4nXqHdRyBGmqTWREPCEgF?=
 =?us-ascii?Q?xUOqfLoAZqn0ueKxTdvhpVffuzkuYIVhIOfHHAKh6IoQ8LNzFwtXbIEQIL8y?=
 =?us-ascii?Q?yCU1mr+Xf9mqXJEqtS9iB9CmhW50n0emibPJj3vflbwUSug03Tl1NeitYgpy?=
 =?us-ascii?Q?+hMa4ny37kkV+brek7UzX7OgFcByt5/kOHjqhRwnAZnyQRPPTwekLlzkMzut?=
 =?us-ascii?Q?ETWKs177aO+TQQZ60X00Lxf1CUNj6IJhuQ3D1hYHUN51R3a9/xUwLUVZ6e0k?=
 =?us-ascii?Q?pzgpA9gwuFcgScHlNbWNh4Oi3khcimxW2mfGg3Dn9jY3mNGKw6sLIjOX5mOo?=
 =?us-ascii?Q?BcSsSM6Bg42tnThD/FByULgujixzG83T6Fuj7YI92swEQhbnDwAHvdLFT8I0?=
 =?us-ascii?Q?7xCtrRkWZUtY3byF5P+V3hj8gFAsJ8ZXRZse63kPphFJJKyDDAEh55SkqtaW?=
 =?us-ascii?Q?3yeVZZN0JmZ4Jd9up5aJv4WpAzUIjIFVUolXR7QhcTgkSUhILJbJ9laVOvaP?=
 =?us-ascii?Q?TpA+PfQJtdn3nxldcm9UegRNHPfcecxw9iH8Vx9WNkKYrLFwq7x67IdExQZu?=
 =?us-ascii?Q?zmnPBAqtQcR+Z2QRFSABRn6nikRdMM09y0g1V5qtyRiSSaJdD67Y8FX138o1?=
 =?us-ascii?Q?6rvzXKNSS3jdoPRsbezOMA7TkC77PoSx0H3D9JyMTdF5r+sBZj9eg9Vtx0dJ?=
 =?us-ascii?Q?t/p/OBSSpu4larDF3CwdhTCnoZOTyq4CgQS2PMpENCptJg4LG+Wmms2ejjua?=
 =?us-ascii?Q?sIxN25DORQMxIs0q+9CwBhYcYWBy8Ohgd92609W3QVQZ1c7dkBurH//WJMVs?=
 =?us-ascii?Q?/wBuKzpiC6Y5HtOhfVM8kejuat2NpGgFBilkUS68HpDTdaXeMBPCtg7QRpyb?=
 =?us-ascii?Q?CkV/m/CbNA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR07MB7204.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bf8d7a-92c6-4efd-048c-08de6b09acf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 14:10:43.3511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+iPeCLyeiBd+u8th5TGFNQfY3gkNLJcQq/tor72lxVLcn1srNuWUUr3stpXu+xcRNVC003nsChDp8iC+M2BTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB11159
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nokia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216234-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nokia.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[igor.klochko@nokia.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B67D5136FDA
X-Rspamd-Action: no action

When uio devices are created end removed in parallel, then we sometimes
encounter kernel traces along the following lines:

  sysfs: cannot create duplicate filename '/class/uio/uio899'

which stem from:

  sysfs_create_link+0x24/0x50
  device_add+0x2f0/0x780
  __uio_register_device+0x18c/0x550

The sysfs directory creation is performed synchronously as part of the
device_add call. The high level sequence for uio registration is:

  1. uio_get_minor (idr call, in critical section)
  2. device_add (leads to sysfs directory)
  3. manage attributes (popuplates part of the sysfs directory)

For unregistration we have by default the following flow:

  1. clean-up attributes
  2. uio_free_minor (idr call, in critical section)
  3. device_unregister (cleans up sysfs directory)

This creates a racing problem when we are in parallel creating and removing=
 uio
devices. The uio-minor that is freed when calling uio_free_minor can be cla=
imed
by a subsequent uio_get_minor call. The problem is that the device_addi flo=
w
can end up triggered, leading to a sysfs directory creation; while the
device_unregister flow has not yet cleaned up the sysfs directory.

This patch cleans up this problem by mirroring the registration and
unregistration flow correctly.
After this patch, the unregistration flow becomes:

  1. clean-up attributes
  2. device_unregister
  3. uio_free_minor

Fixes: 0c9ae0b86050 ("uio: Fix use-after-free in uio_open")
Cc: stable@vger.kernel.org
Signed-off-by: Philippe Belet <philippe.belet@nokia.com>
Reviewed-by: Igor Klochko <igor.klochko@nokia.com>

---
v3:
 - Updated email subject=20
v2:
  - Fixed commit message wrapping
  - Placed 12 char sha1 in "fixes"
  - cc'd stable
v1: https://lore.kernel.org/lkml/AM9PR07MB720434A2B0CC99BC0BDCD74E8D61A@AM9=
PR07MB7204.eurprd07.prod.outlook.com/#
---

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c index fa0d4e6aee16..5dd1=
37a85576 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -1125,8 +1125,8 @@ void uio_unregister_device(struct uio_info *info)
        wake_up_interruptible(&idev->wait);
        kill_fasync(&idev->async_queue, SIGIO, POLL_HUP);

-       uio_free_minor(minor);
        device_unregister(&idev->dev);
+       uio_free_minor(minor);

        return;
 }

