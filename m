Return-Path: <stable+bounces-233606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMNqJjgR1Wm30AcAu9opvQ
	(envelope-from <stable+bounces-233606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:14:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B1F3AFD4E
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52866301B07C
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 14:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2723B8920;
	Tue,  7 Apr 2026 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=guidelinegeo.com header.i=@guidelinegeo.com header.b="VjwBjkRb"
X-Original-To: stable@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021084.outbound.protection.outlook.com [52.101.76.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DA4391E45;
	Tue,  7 Apr 2026 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571224; cv=fail; b=hyMkfOa1RVrY5M5X9m4fmf0VBFawErw+VvCr429WsfzkJiqk93YP3eG8hBfrhMJnAw4JReK9HnL0mFKqUty4S9dGJW+bBYQrzhrF7YSqXEK0DYtF7PoSDkjQmQEk5DxGDDHEQjKSK5HEcSk1NIxyPATFwQmYGKspf0Zha+R+lgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571224; c=relaxed/simple;
	bh=2/QAldH+MHxdm8YOBA7HBb0u08Hxn+kbA14SNL4kAUU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i8cGvJy47asR9HSuvg/rUYUgdd1bzmFT1QQjCzCwbytCjz+N0asGPX0jp/KV8XGX+G36lJfKy4UcyIPa3a0MMT/BXqhyVEvkuLfa5ENoGNKYQtgN+Xwbz5UGeiWQ7evAtkyrkJYT7J+TAVPHZ11eDh7tYunTkpFShfh23CQf78Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=guidelinegeo.com; spf=pass smtp.mailfrom=guidelinegeo.com; dkim=pass (1024-bit key) header.d=guidelinegeo.com header.i=@guidelinegeo.com header.b=VjwBjkRb; arc=fail smtp.client-ip=52.101.76.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=guidelinegeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guidelinegeo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyLaosaznMPMrzF14q+iMAMDraXrvlax7Vi9ftjxuPwFnghF93ClaSf9EfJdn9Z+cIr9qI2M6kg55iqNtkrnl9V+kYdZKYXFTnJ4GOfTCLyHIfjkBSv1uZcpDN7oGBiraoX05JJVYbAzSoR1OSMJOW7fDcIvQgPq0e2Yy/WtFKkuP/Zu+OsztRtUPOhiRMVQO1LYrYAvNZ9TswjkmHsWW4QYzzz+JrcMeJmwebpW/BTV6qY6oMpun9ELylxeuI3nJzHfJVnw2qIBF9A29rllYqqjSwkCoQkrzlgW9xYH9mm+OvolYB4/0GFLJi3wZphlSIGhG93vZtethMn74eLEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/QAldH+MHxdm8YOBA7HBb0u08Hxn+kbA14SNL4kAUU=;
 b=IPeGyJLnfuGfwhvfF20qeLdt7/tIFh+rEEWEqDBPNaH6aA4c4weyrBdHSvjlCOiv9GyPhxF5H7wyAxv5jXj6XDVAFvrVmScXbirztnoW5r4ZIjaTliEHpSOJlHGqaaKtR6nHp4sjZDChp64t+Z/ZyU9+fUHWKSODDhQibJeiB58R3K9IM328e7LDHuGnOltQKUVr6OmWGGQkt1VtfoYeIjU2gtrGV8qSUmHcaF5DaDmTlP4O6oXJ9HgkDm9K7H3kxU4iZT6RQ4ZMz37fyozBJ+cBR4E40ZU5VCI8wZ1TVcnqAyxSzQqNdGuzWcDqMx12Ob/VC6GKpwmaCJb25s5EYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=guidelinegeo.com; dmarc=pass action=none
 header.from=guidelinegeo.com; dkim=pass header.d=guidelinegeo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=guidelinegeo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/QAldH+MHxdm8YOBA7HBb0u08Hxn+kbA14SNL4kAUU=;
 b=VjwBjkRb8K/H4/GlQRLeX/U3KVX5UDIF02HQdKCOfMfmXbjHBfsKtOgN7XBC0sVY2rzR43gFvdgLP7dLbN5zlQeE72epM2DCt7dwNl+CBS4ro/FmswUJHjCHria1pAYPQUsdAMTBiabLrB9AeU4yRhvA6dunnDe1RJlydd+G0vg=
Received: from GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:14::9) by
 GVYP280MB2271.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:364::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.18; Tue, 7 Apr 2026 14:13:09 +0000
Received: from GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM
 ([fe80::5a42:b24d:f94f:a5ec]) by GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM
 ([fe80::5a42:b24d:f94f:a5ec%3]) with mapi id 15.20.9769.020; Tue, 7 Apr 2026
 14:13:34 +0000
From: Christofer Jonason <christofer.jonason@guidelinegeo.com>
To: "Erim, Salih" <Salih.Erim@amd.com>, "Simek, Michal"
	<michal.simek@amd.com>, Jonathan Cameron <jic23@kernel.org>, "O'Griofa,
 Conall" <conall.ogriofa@amd.com>
CC: "lars@metafoo.de" <lars@metafoo.de>, "dlechner@baylibre.com"
	<dlechner@baylibre.com>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
	"andy@kernel.org" <andy@kernel.org>, Victor Jonsson
	<victor.jonsson@guidelinegeo.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Thread-Topic: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Thread-Index: AQHcq7ZpCeRIu+55oEGPm8jdqCh4D7WjB/YAgARjkoCAIu9BAIAJezdC
Date: Tue, 7 Apr 2026 14:13:33 +0000
Message-ID:
 <GV3P280MB00657EB1524612E9BA0142DEF35AA@GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM>
References: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
 <20260307124118.1d527749@jic23-huawei>
 <1166aeef-0c93-408d-b265-9037f2840074@amd.com>
 <IA1PR12MB7736AE6EEE95D5D184A15B9F9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
In-Reply-To:
 <IA1PR12MB7736AE6EEE95D5D184A15B9F9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=guidelinegeo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV3P280MB0065:EE_|GVYP280MB2271:EE_
x-ms-office365-filtering-correlation-id: a2594e8a-72a9-4ee1-c2c7-08de94afda88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info:
 KTQWzC5lgW1S/aAMZ21baE/995AO8Lx8/I4HCo9E0hYJoMjXf9t47RWfwqe1pmqpHBBcP5IPjjm8KwY4sR33x/SoHuHjdYT7tozMPJZ6s+D8KbMLKtskXgPy0lJ53v0Y4igRNiTkr1OlTUzLDct03kqQ4qRFG0MRMZYCk7xb+WWlR5bxb+zknetXTiPTF1MVfFlyCTUxFdLqMIuY89nChGoQvVY1HC3+PjXIUmExouxaRmnVKFRssPkdYTj5eyxN8al9dATlXwdnaJP4qevivAhgAjN34VWUP9VAN7VGRS0cnBzNOPAPnQRhlxAsRe9jCUVSlSRMoVhSFvUcENl7lF8v06YyV3b4xRJNPHynpQb52ANx7Rrc7z/GNygufRouQkvn9pE7xtMDSucoWwO7C9GyL3D0Mbr7VHa4cb9BqdkOs11PYs4Dn4CnJ9rpYb5nl73BU+byq/3Yp4bGiCdQF0qYMy7/OJ/8XvZlP6P0n9y21DWY9svFW8N4n8wMiyTJYeWj8F3LOEzyRmEQcveVrOetuenfm1A1Bf7YiVkFklPytP3r7dOevAy3DX0o8+ON2nS9Tx5YTP4OSfZYJFcOezNVavzf3zkEL+3j/JsTZASeq94/5MWIPMOwoEWcyOzs560KS+qV+l6Qxghy8Chhbx0JjQSOUt2a4aJo3AqoTbDUGdkSME5Hyl6Mly+fkmjAvrfHXssMSTJg12S72UZlRD2ALqleSfkIZRODvBqkJTZNaUmCYt4GkaBZqC/91iJbRlwQ4Mv2VNqNZoiDV7v9xoL7mCdvCGmV+kxWBAMubRM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?z97f2ZAWAYmECia8G1DVsizPojGHgZaUxBDipWn/H56rnxsMudrLl2cyIn?=
 =?iso-8859-1?Q?KEKjHOzbyX5oytqbaoa7NHtgDuoPEJ/YFNomj2ts/cMzozLp+tXT96s9Fj?=
 =?iso-8859-1?Q?4a+sn4laHz6HwrAsQCXRSu+d4FNAz6nGhe2CvEOGrHOFhH16PEMevT9q2m?=
 =?iso-8859-1?Q?5sbLPivZrDAMqobDiZgnkYxJr9VfEMx3tE79xnbaUzvc0PhBRP/kKFoEJ8?=
 =?iso-8859-1?Q?8i7y0po2SX7D9HfcJ74tynBbNp239JW2YioNmVWwYYEDI/GzrAtw9IpyMY?=
 =?iso-8859-1?Q?e0eK1Xn8lB0pZ7qqm/rhIPGMRrO4LA31RzwNuQIdqMX0cxYrLQIHRQSXjU?=
 =?iso-8859-1?Q?MLr0K46ubUy8fuKMX1a0CrqR5n9N8zytSeoISAA4IWNqsLuCXR26Ua5bvy?=
 =?iso-8859-1?Q?fwNvjyAMamsdn/PcHREXxmvTO7U1+iBknm623IF9gKZb5RhgjKrFkbQ9os?=
 =?iso-8859-1?Q?msTPNT/zPLhEyo3rbidJMzYlirpJTYOdyB2e4kHDK9xmjHVsdSR7mnJHnt?=
 =?iso-8859-1?Q?Kt8iCwzUJXIEB2qAEnFh0GbZgqrpvlyDsvJxkN+MSiWRAX/p/pcN7fpusK?=
 =?iso-8859-1?Q?P+oRw8KFDrRxP/xoXo8ZFoxbSUpxKEEwYlfIGM1RtYnL6R5HK2p/c/GQ3O?=
 =?iso-8859-1?Q?SnS2UomymecABVjsuqRePiIOJYhZ4zt/R4fazQg03gpzCYLAVXY4HTRJEx?=
 =?iso-8859-1?Q?XL/hFmZ8TVZrVC4bD1Xs5Z/qtqyCMMPM2MqNTY0ap9A3XWWZv5iq+gdv8W?=
 =?iso-8859-1?Q?OsTq0AB7eaBJytcVBvkLA5YnUK66n6hKjLgP2Vwy/9bupWd+v3fXNeJ/rC?=
 =?iso-8859-1?Q?PMZSGMO15li8BFsdvRQaAjG37LpT0W1o/xcOjcdOuUsbUKmmjvrZyG0XPb?=
 =?iso-8859-1?Q?GL5FUkIgtWvST/VMVFW7Tp51gCDneC2qPOgll0ArcRdHb7Oluxx07ugVYH?=
 =?iso-8859-1?Q?xXtk7s+REmh5gLcotXchIENptXM8nHsfC7nvp6Qge8FrdMf/5jxlGIdFdE?=
 =?iso-8859-1?Q?bjl1qdXrcy8dw4yKOL3jnSk2ig1DrPp9SbVUaSbaSJJQ/1GLllv7CQrsiA?=
 =?iso-8859-1?Q?nM5e+6/EPG0RS+VX6y0Nv9Ho8U7K5QIjCntINmJwzUndHUW7jAd+MsiYFU?=
 =?iso-8859-1?Q?MVnu/05SI7Zg84uw+0Wi+lbkZNGNRDHhQOxHLI7wTq5u8MpkVZ8qD8j+K1?=
 =?iso-8859-1?Q?DEh7Q8ieFX1Wkn7lq+boJHtlcAZGXa4FhlxgnbFSPpQ9wd7pEggbQ297fk?=
 =?iso-8859-1?Q?OJGTkILvbQdvCmSTLv4bzFWv5JSdOu4J0nlg9IjePcW+so5nmawdgCPPvQ?=
 =?iso-8859-1?Q?tP6qffhJ4uihDTV4QHw2FhQKe1yOoj40bZLwC30LN5WtOMw5tRFaFpDlYd?=
 =?iso-8859-1?Q?dMXyAEtrw8/CeqK1ojk6bZFSDO5xas8q0ufDUEMStkGzepyJHfCK/X7aj3?=
 =?iso-8859-1?Q?a3muLa43fb++shUUAzwTwg8a5rk3PQQtavom+4rH4rlO70BZutPoXshG9E?=
 =?iso-8859-1?Q?PcJm+zT8mzoxDc10eShV8hWNEfZUPeHj7QEO5rTY48LiGoCxcGKNsZKNUq?=
 =?iso-8859-1?Q?+KKTy/oF9pWPNvchuHMUmsR5BmrlT3Df5lphVsBSdkyASzybtXOWqBTyzW?=
 =?iso-8859-1?Q?pNfeoK/HGFXHQP8uNunbti8qqPDiqVUfn5CRGDX8TeDimdUBmvjk+Q5cEK?=
 =?iso-8859-1?Q?x6Zmfa2TMqyDHyAVbaG+J73lSpFfdG+p2a7EjtRfxTRKoQS5nmRu7mIO8E?=
 =?iso-8859-1?Q?CpJPmbGiMMgB2upzOc+14eX0cuBr8dlkov+d4TOld1fO/ROwwhpkuqtCCR?=
 =?iso-8859-1?Q?qiVJN2VMVtnch5cBi1kbmLk46ZOcetM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: guidelinegeo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a2594e8a-72a9-4ee1-c2c7-08de94afda88
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 14:13:33.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f3403a73-63c2-4dc7-b628-287972076881
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWyYZWippTFBNWx/3jXOG6AMiwLDVJMuzQrThDwopwwn0abNLEYLCaYw7XeqPTKtRrBGNfVZ2I+YhiKbmfIP9ykJV+TqIxGHp6HSPo9g29UkFTq/lpIbWDup0bj3bgvl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB2271
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[guidelinegeo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[guidelinegeo.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233606-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[guidelinegeo.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christofer.jonason@guidelinegeo.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0B1F3AFD4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Salih,=0A=
=0A=
Thanks for the review.=0A=
=0A=
Tested on a custom Zynq-7030 board with two TMUX1308APWR analog=0A=
multiplexers in dual external mux configuration. The XADC is=0A=
instantiated as an AXI XADC Wizard IP with xlnx,external-mux=0A=
set to "dual" and xlnx,external-mux-channel set to 1.=0A=
=0A=
Verified by reading all 16 external mux channels via sysfs=0A=
(in_voltageN_raw) and comparing against known reference voltages=0A=
on the board. Before the fix, channels routed through ADC-B=0A=
returned incorrect values. After the fix, all channels return=0A=
the expected voltages matching the board schematic.=0A=
=0A=
Thanks,=0A=
Christofer=0A=
________________________________________=0A=
From:=A0Erim, Salih <Salih.Erim@amd.com>=0A=
Sent:=A0Wednesday, April 1, 2026 3:11 PM=0A=
To:=A0Simek, Michal <michal.simek@amd.com>; Jonathan Cameron <jic23@kernel.=
org>; Christofer Jonason <christofer.jonason@guidelinegeo.com>; O'Griofa, C=
onall <conall.ogriofa@amd.com>=0A=
Cc:=A0lars@metafoo.de <lars@metafoo.de>; dlechner@baylibre.com <dlechner@ba=
ylibre.com>; nuno.sa@analog.com <nuno.sa@analog.com>; andy@kernel.org <andy=
@kernel.org>; Victor Jonsson <victor.jonsson@guidelinegeo.com>; linux-iio@v=
ger.kernel.org <linux-iio@vger.kernel.org>; linux-arm-kernel@lists.infradea=
d.org <linux-arm-kernel@lists.infradead.org>; linux-kernel@vger.kernel.org =
<linux-kernel@vger.kernel.org>; stable@vger.kernel.org <stable@vger.kernel.=
org>=0A=
Subject:=A0RE: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in post=
disable for dual mux=0A=
=A0=0A=
[AMD Official Use Only - AMD Internal Distribution Only]=0A=
=0A=
Hi Christofer,=0A=
=0A=
The code change looks correct to me - it aligns postdisable with=0A=
preenable by reusing xadc_get_seq_mode(), and the scope is limited=0A=
to dual external mux configurations.=0A=
=0A=
Since this is targeting stable, could you please share what hardware/board=
=0A=
this was tested on and how you verified that VAUX[8-15] channels=0A=
return correct data with the fix applied?=0A=
=0A=
Reviewed-by: Salih Emin <salih.emin@amd.com>=0A=
=0A=
Thanks,=0A=
Salih=0A=
=0A=
=0A=
> -----Original Message-----=0A=
> From: Simek, Michal <michal.simek@amd.com>=0A=
> Sent: Tuesday, March 10, 2026 7:43 AM=0A=
> To: Jonathan Cameron <jic23@kernel.org>; Christofer Jonason=0A=
> <christofer.jonason@guidelinegeo.com>; Erim, Salih <Salih.Erim@amd.com>;=
=0A=
> O'Griofa, Conall <conall.ogriofa@amd.com>=0A=
> Cc: lars@metafoo.de; dlechner@baylibre.com; nuno.sa@analog.com;=0A=
> andy@kernel.org; victor.jonsson@guidelinegeo.com; linux-iio@vger.kernel.o=
rg;=0A=
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;=0A=
> stable@vger.kernel.org=0A=
> Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in post=
disable=0A=
> for dual mux=0A=
>=0A=
> +Salih, Conall,=0A=
>=0A=
> On 3/7/26 13:41, Jonathan Cameron wrote:=0A=
> > On Wed,=A0 4 Mar 2026 10:07:27 +0100=0A=
> > Christofer Jonason <christofer.jonason@guidelinegeo.com> wrote:=0A=
> >=0A=
> >> xadc_postdisable() unconditionally sets the sequencer to continuous=0A=
> >> mode. For dual external multiplexer configurations this is incorrect:=
=0A=
> >> simultaneous sampling mode is required so that ADC-A samples through=
=0A=
> >> the mux on VAUX[0-7] while ADC-B simultaneously samples through the=0A=
> >> mux on VAUX[8-15]. In continuous mode only ADC-A is active, so=0A=
> >> VAUX[8-15] channels return incorrect data.=0A=
> >>=0A=
> >> Since postdisable is also called from xadc_probe() to set the initial=
=0A=
> >> idle state, the wrong sequencer mode is active from the moment the=0A=
> >> driver loads.=0A=
> >>=0A=
> >> The preenable path already uses xadc_get_seq_mode() which returns=0A=
> >> SIMULTANEOUS for dual mux. Fix postdisable to do the same.=0A=
> >>=0A=
> >> Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")=0A=
> >> Cc: stable@vger.kernel.org=0A=
> >> Signed-off-by: Christofer Jonason=0A=
> >> <christofer.jonason@guidelinegeo.com>=0A=
> >=0A=
> > I'll leave this on list for a little longer as I'd really like a=0A=
> > confirmation of this one from the AMD Xilinx folk.=0A=
>=0A=
> Salih/Conall: Please look at this patch and provide your comment or tag.=
=0A=
>=0A=
> Thanks,=0A=
> Michal=

