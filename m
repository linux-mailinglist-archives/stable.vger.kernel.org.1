Return-Path: <stable+bounces-126831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFC7A72AEC
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 08:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9B316CE4C
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 07:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B20D1FF7D6;
	Thu, 27 Mar 2025 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Z9A1aRbv"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2031.outbound.protection.outlook.com [40.92.58.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805351FF7CC;
	Thu, 27 Mar 2025 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743062338; cv=fail; b=qArljuNBFaC9vRPVytwaKfI/dExEgI0OlJlHJSdTT2UpVwFsk/1o9X581NA+WFn2nHr6N9vpzfUUORHLh9FoaTzlXce1Mvzn523x/pCGtKs9wuJ2vzCZbbrFpFBjhRP1of27w6I2SQt8X5Tz4Z/2pFFpHWDGG8SiSvop04ZpEOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743062338; c=relaxed/simple;
	bh=rtqtCBPcpxaqzYQDyVBnmvpaDOiihh0pxTPw1G7geP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aEjjesoeJjb2aK/ysKFrnGWq4/QYv+Fm41AsFKMac3Z47aQMCS6cHGwVtKGBMgxAJdpzQcr38FbQDEyFsRJZPiT8RajRgEM9WlGSmGXWMgQX52vvUb7+mrY1KzasSVCCbOL2BcS3BmloV6KgPb0etRKKaOpdBE8V7+fYD6zC/oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Z9A1aRbv; arc=fail smtp.client-ip=40.92.58.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3iXfaw4j//xNjgRcYpbdGkgGYdpqRWGuI0tfIqHx/V5b0l6zrdgIrav3OdSTqXhoe18qewvVI7lntYjEvJiBgqErW9cpxIJonqDlO+5OO8VFQ7Hc68MxeXqgvlQNelNg0dTG8yTCuTN6wV4XG9Ctl6cDAst2S2sd7P/8abBj9pSvYGWR/KbQHlu0IbgleXR7tfaL8+xJOgbf7DwffIInsSzUIoAHqXd0EqaqdUtHcnc3PWeRNVF4gyk/oNR35cQcTwfczXgUhAcOuSPrW7fFMBImh4SNtF/0ePFVM7xJubohlRzl6qhOeWro7OFLpy7u+AoYW+ru1d7xFt4rzeydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtqtCBPcpxaqzYQDyVBnmvpaDOiihh0pxTPw1G7geP4=;
 b=gBCFJRgT9crAAN7LY4Y8Dn+B+KM2Urh4T3bE/6FQ1caNrLrdjxycyjJ3nc6dK5RjcGXFgS0KB66wLHJeqfvS21Ut3HR4AR4NZwadhcTAqLQsD7wXydnMD3cIUpakaXQvrY9CHhqqb01zYK3nCkMtQedziJ39UHFHBThrKZO9NcZ1M+eB14saR4fAED9SH3LjMptTgoqje1EfZoJPnxvt2Shb0h3mZUmikZqdInLNATO6Y6uPKrd+b9f9nqU4v8EudqreVnFmyfzm4StikIYsV0WFFVsMC/boChUcN8Q8eizI7GHiAZoZUOhO/xACwKrVdfsezxVVm0PelclyFBLN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtqtCBPcpxaqzYQDyVBnmvpaDOiihh0pxTPw1G7geP4=;
 b=Z9A1aRbv0F+pjlA8nNsGIUrroBKZZCbKqjIQZm7/nf5VGMaNwk4addvomfKMdNIqEZjAOc77Sm0H600k86kjFY+fxNj8hJP6mVTZRAZt4wU0uDEVgbtVpS6I1jOVmx0mNvPgX3psiCAIgPc1SlH4wXgv0gMLfqigObGFsJLqcDs4y/RwVvvA5wbCtHgS3JRMKUhIx7amo7t8dPf4Q6RyyVDDvtmIfHbTLi8xu1wiMPMd50FyEHlCk3yVVAdk0s+R8mgmxkImm/ZzHvoudF0TvfyVK3etv/COwiRcbqWVkMjPTrx3KKxpk6MMxrhBUjOhNGKNGvb74/Ad+Tw6OrOo1w==
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 (2603:10a6:20b:63e::17) by DB8PR02MB5754.eurprd02.prod.outlook.com
 (2603:10a6:10:117::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.45; Thu, 27 Mar
 2025 07:58:51 +0000
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::58c3:9b65:a6fb:b655]) by AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::58c3:9b65:a6fb:b655%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 07:58:51 +0000
From: David Binderman <dcb314@hotmail.com>
To: Eric Biggers <ebiggers@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Ard Biesheuvel <ardb@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] arm64/crc-t10dif: fix use of out-of-scope array in
 crc_t10dif_arch()
Thread-Topic: [PATCH] arm64/crc-t10dif: fix use of out-of-scope array in
 crc_t10dif_arch()
Thread-Index: AQHbnosK3mh9Fpk80UqRnNseAaITfLOGnkLl
Date: Thu, 27 Mar 2025 07:58:51 +0000
Message-ID:
 <AS8PR02MB10217FDBBC9DBA3A5B3C5F27B9CA12@AS8PR02MB10217.eurprd02.prod.outlook.com>
References: <20250326200918.125743-1-ebiggers@kernel.org>
In-Reply-To: <20250326200918.125743-1-ebiggers@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10217:EE_|DB8PR02MB5754:EE_
x-ms-office365-filtering-correlation-id: 4c47aaee-ea1c-4bbc-2dd6-08dd6d053664
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599003|15080799006|8062599003|461199028|15030799003|8060799006|19110799003|102099032|1602099012|440099028|3412199025|4302099013|10035399004|41001999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5z+XN7407nJioKn0qT+Qsa5w/29Tm2k2D54t0W0wAWO9Zb3x0QKGaaYvuY?=
 =?iso-8859-1?Q?PwbWmEm4LKyMwMQa1IAQ1xEa5phzMQDfnwvnq/sR+dQvfrIbkZ9PJfLUwV?=
 =?iso-8859-1?Q?BUw6dcT0LT5Byh3Ub7YxII1xTensxmhfdRzFaYO4kYE1R/Y7AWcRzFaj1q?=
 =?iso-8859-1?Q?N1bjNFp0ttZYtJaFuJZ+SkXz5EMKA+LTL/2x5vB93kJxsCXToEldcBWOvS?=
 =?iso-8859-1?Q?FK39dEfFr81vOLLMikCr5LEy6WyN5cRlLKnzIgqjEX6aD5YvZ54zFPGvwv?=
 =?iso-8859-1?Q?esivvVo/H1ejKv+AyL6NCU2WrG5rvH9n0bwO/aYLr5lkwx0PeLRE2bK5WP?=
 =?iso-8859-1?Q?PubqGpU+MarV9/CUv59Cqy4H7dXhQpdxnRpoPAzwYX72kpg0uOiHJTcnWT?=
 =?iso-8859-1?Q?69IIW6gWnGG6jgTAI6hXKzao4CCXbQy7yymAGUhIgxAR73oNRxd3d5NX2t?=
 =?iso-8859-1?Q?yTCOQP7mIsx+uqoDAj4AJkfvGGGcJRUSVAAlHjSpTI7k4D/Ue+lhjSBSns?=
 =?iso-8859-1?Q?l9fhRfhqVBUuj74tZAy2eVTTuUy30oUghHuyT5/8DNq6JJXXPFHIRY9lEC?=
 =?iso-8859-1?Q?XzE1yOKc5PnZ0I+cRcqm7PYXgXBGe6Tq9FKjh/lVRCr+3SVMwbmgP8BbmD?=
 =?iso-8859-1?Q?LK+qJ2aM/XY6O7kiq77ZfeEnT5sNZSDAq2UtuDTeZQRCYwqTf2sAsMdIPo?=
 =?iso-8859-1?Q?7QRqI2wbnbk28gxkk//1r41RR1rpR+nMRF6jYdYJKcrqOT/mHXQGKEtQhL?=
 =?iso-8859-1?Q?pM2+Gt3QHCxfKBJrKVxaKvj7EU93j8V9R/GvnpTpBY2Yy9GJ6OrEFRmKY4?=
 =?iso-8859-1?Q?oGrdnVS2b/Y9jp1wLLkf4x1//eZ/fRhq8hq8xjkUSygbHEHK0tr8XFiOU9?=
 =?iso-8859-1?Q?xtrTAHOH1qvEzAn+jQQB5Cl14jlCywTz8HVmFIrsoZUDBRv0cBUdk/ufMz?=
 =?iso-8859-1?Q?5Y4UBSrV+Dl6b0nFbyLBL76RCKpkmjop7JBO7aaNTvgfRJirgNU0BFQCpC?=
 =?iso-8859-1?Q?OOUhfArvMmjZSR2jVnd0E6pnxIK8s4zb+YUZAP8KxL3xVAsoQYPibZT2IS?=
 =?iso-8859-1?Q?MBmdALnt/97RvuyLHXz8JE6daxF1rnqs696HQlOg4IVk/rRseI5XNNs+6T?=
 =?iso-8859-1?Q?448fbitvIxMMYAeFEg1s7D5xW+DIxcLnsZR8DnXPuLxqgHKUp6QVGWdIGL?=
 =?iso-8859-1?Q?JQV6e4LFQDTahyb1V+pbEvw0AGKzd0CpxvAj2rUjhwwtC7tDHT616rDEwt?=
 =?iso-8859-1?Q?lvfjbd4cLLU08qKUKWmSI+vEBFnLVjn912DB3uhJMoCRvUrVJptx4/GoMd?=
 =?iso-8859-1?Q?QGxNFWGiVhE8reXDDMSgNFbtqqNF68/+Mex8XbkvoE+5gTnToDysf6KR31?=
 =?iso-8859-1?Q?ffHoXNPvegWyENWpnnUj7TF2pGeXt8lQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vD+wrbMgc5W2qC6HOzaXoxkzs2IyFlddxWlBJagPnnpf+I/n5iD6JthP1L?=
 =?iso-8859-1?Q?Q2dPvR1xouTUr/7fvhgMokuYcCMQDbwI5JNpK35ft9Xq/i/E0jsU6swUJb?=
 =?iso-8859-1?Q?uV0GdQHlwZGOOgTzD77cUh7h9NwFd1aaDR/d08qk94SIbSjduFW9Z8vKjX?=
 =?iso-8859-1?Q?RnYdGQpKCXix24AUEqtYncSPlgM+A+RVHH5RpuaXWiiUSc5oJIyr5uFRgy?=
 =?iso-8859-1?Q?KdgeBhP0doUAwnVLZ8DrNfevb7dK8VpLOV/Xofyu4l9pTgVy789qLx5jCS?=
 =?iso-8859-1?Q?LXDzi4uW94YnI0YZ08HJK0WeIgRD1cExqc3U2LrIrzmredpnASA/13CWJ0?=
 =?iso-8859-1?Q?bFkUOQOfXYa9qN+pE41eBDJGt5FKRwZxUPDASQCpvB9gtgTq4875TmUB9c?=
 =?iso-8859-1?Q?DGyHNMf26S6ehXon4Ql0AJZ00o69rXrbVpmPby4eB273llsozoUQZgCA8L?=
 =?iso-8859-1?Q?RljsOor1bBOdXZYz+0stChzpKxePHQQPiaUC4gNuppA87yDe0TKAwbe52W?=
 =?iso-8859-1?Q?HrVtldmwfkGfkL2Gvvd0x6vyWermagHUoe4nMuDvMwbO7mSupcVGH0HpVk?=
 =?iso-8859-1?Q?ogFLtLLT6/UgNk+sw+hkvDN5EfYtKO9DOMVV92/c2iY0uysoz2D/KZQe4S?=
 =?iso-8859-1?Q?PAEXtDqH36Ciy6tnr9xc/cAxuKzwix2cZCD2MHbk8PO4FLNH+AkPh+Po4v?=
 =?iso-8859-1?Q?TBPrc3421f+ez/1cZ49gEw50R73502pc+u/fzdJ6dh+B5Yx81uKd8P9fzY?=
 =?iso-8859-1?Q?/KLACkgFk3gic6zsC+KDU1bOfuDlJDnV0aGmA6LMRp1NPmRncE239fvZcg?=
 =?iso-8859-1?Q?AWxoz3kBWaE0qyBFp7Iirky+iN93iZzxMhUlVpnPpTupcRw/ajbHAmNl1t?=
 =?iso-8859-1?Q?6J64SmdETtmKDi3Z1Doww1NxhaU0RCoLHKgZJgOzXg+yepKXFz59ILpU5h?=
 =?iso-8859-1?Q?XEiT4lqNTbvo1P+8KpJ8EQp0OEyo0OBJlKPmVctZnwdamb+qlVq2Y5KYnv?=
 =?iso-8859-1?Q?JlZTL1XRhs9AjKD7lGSdwqSjk2bNAnIq7Wm9Bx+faVmWmFXonz4+6zBaRe?=
 =?iso-8859-1?Q?+WzMLXCEhlj0nwT39wiZiZvsoyfK6bi6rmogtB3n9ZF5+OADj/GlddpWoQ?=
 =?iso-8859-1?Q?q77/gYsUv9f0t8fHCTHMFxmwaOPjwF2PwX0kDZ75x26MGMU6by8n6Sj3M1?=
 =?iso-8859-1?Q?8uWW8oXGBr3o/ZHmUSpK94MUBvpdNoLWuMgLmUrRzst9yXEIUEevJ3RCMZ?=
 =?iso-8859-1?Q?RQjulaEbZN3PO6UEJYOA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7828-19-msonline-outlook-12d23.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB10217.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c47aaee-ea1c-4bbc-2dd6-08dd6d053664
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 07:58:51.0483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5754

Hello there Eric,=0A=
=0A=
>Fix a silly bug where an array was used outside of its scope.=0A=
=0A=
I am surprised your C compiler doesn't find this bug.=0A=
gcc 14.2 onwards should be able to, but clang not.=0A=
=0A=
I will make an enhancement request in clang.=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
=0A=
Fixes: 2051da858534 ("arm64/crc-t10dif: expose CRC-T10DIF function through =
lib")=0A=
Cc: stable@vger.kernel.org=0A=
Reported-by: David Binderman <dcb314@hotmail.com>=0A=
Closes: https://lore.kernel.org/r/AS8PR02MB102170568EAE7FFDF93C8D1ED9CA62@A=
S8PR02MB10217.eurprd02.prod.outlook.com=0A=
Signed-off-by: Eric Biggers <ebiggers@google.com>=0A=
---=0A=
=A0arch/arm64/lib/crc-t10dif-glue.c | 4 +---=0A=
=A01 file changed, 1 insertion(+), 3 deletions(-)=0A=
=0A=
diff --git a/arch/arm64/lib/crc-t10dif-glue.c b/arch/arm64/lib/crc-t10dif-g=
lue.c=0A=
index a007d0c5f3fed..bacd18f231688 100644=0A=
--- a/arch/arm64/lib/crc-t10dif-glue.c=0A=
+++ b/arch/arm64/lib/crc-t10dif-glue.c=0A=
@@ -43,13 +43,11 @@ u16 crc_t10dif_arch(u16 crc, const u8 *data, size_t len=
gth)=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ke=
rnel_neon_begin();=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cr=
c_t10dif_pmull_p8(crc, data, length, buf);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ke=
rnel_neon_end();=0A=
=A0=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 crc =3D=
 0;=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data =
=3D buf;=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 length =
=3D sizeof(buf);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
crc_t10dif_generic(0, buf, sizeof(buf));=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return crc_t10dif_generic(crc, data, length);=0A=
=A0}=0A=
=A0EXPORT_SYMBOL(crc_t10dif_arch);=0A=
=0A=
base-commit: 1e26c5e28ca5821a824e90dd359556f5e9e7b89f=0A=
--=0A=
2.49.0=0A=

