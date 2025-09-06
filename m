Return-Path: <stable+bounces-177944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D3DB4694F
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 07:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3E01C20C58
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 05:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6C02AD02;
	Sat,  6 Sep 2025 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="SF88vZNx"
X-Original-To: stable@vger.kernel.org
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92F31C68F
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 05:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757136674; cv=fail; b=ZSoS5q/aNQ3mfk7+DXWa14lSpq6oVfHdjcWvBN6OiH1/1lpa2MCPVR+P8r3nvXjucoNSOzhayH4JftFC/VYCYwu2Xdlx8KMkJeG4tJ04MQ2rluEpWKQMyIJaJVUPnJcWqPINFoSf+bPvqAH/pffCGeAX5FuY8bVup2zLp+5EBWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757136674; c=relaxed/simple;
	bh=ZlXJRnpxMtIyw3dww3sCea5KISaJ3wgfxw691D6nxhQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FZlWBSg5fxEB4fKrUMF9f6AW09X3h+20kfvRyejx/krwv6zpCu3N35A+S2WjBKCLW/gqVkF7XyH9D3FsAvS4qgPPgtqMm/BTmvtk2ZPkSLIa+W5z7r2sUwRj4ApKC3jumXiFvrqKfW6ZQGTHCU9S9iFPZjTw0ZYHB5i/VF1RO7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=SF88vZNx; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1757136673; x=1788672673;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZlXJRnpxMtIyw3dww3sCea5KISaJ3wgfxw691D6nxhQ=;
  b=SF88vZNxN3UYNxUTR5MCFsZnq0F5y88bm61BYWrFfDV+WKjceQYPrn9B
   IUgBLiloOdz48S3Kr4Uzk6AYUscs0S9Haf8vMNdNKyxypGDb4v/SNInHb
   JvwwSfVZbMTfBjoqzZ8VxL2pMz8y5NiSBGi8QASQYrT5l2+Ma6TLHDDHF
   V59LcXUizSEs4pQGaeIHMRLXtDftxXWxMyM+fxX/rsfhstJX5SBcBRt1U
   jvY45xJs2c/Hw5ygY50yemaaudrQJgo6h6q451ZwIBT2B3fntaBPvx1YS
   A8gd+PDDjXeeXAj+0kpUVlgmN3GVQGRVo46ut9+mz4ezSeNuwhd5zzor9
   w==;
X-CSE-ConnectionGUID: KS1VtA+OT/++Jn/4hePeEg==
X-CSE-MsgGUID: G28IYI1pSiqN9g8/iEAklw==
Received: from mail-dm6nam10on2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([40.107.93.100])
  by ob1.hc6817-7.iphmx.com with ESMTP; 05 Sep 2025 22:31:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7y9M+aC3QUMmuOAf02qJ/mTkbL6nWRDdPzxvkRyZ00HneTBZiLXHphMVkKrbzjkajLIF34HOUx5yqINGAWluZpM7wer63iZwSl2uq7EnsWXCfZ49FwcOHMulFR8Allk5nybKVAis6EtYjeGNG8leK9KaMFI4HqhlvrD4wilrDVRZmHYCclRPDZL9ZkQeWEJC3QqkOCxw2trOtFBUichKj+s1PMPSFg8i/caOjRhu54MXM9Yfb7kW0u67b4kT5xOP7vcrwK7tQAhx4CcE9NKiHwxOBTDrWrOVADOM6pGcZpXIl/yxed7BFMfJg/KS2oap2lyO5wLyT4GDZzBH4Q0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giLpkDJpikTaKMX9Za05z9FL4JGAMpTKuspRboydiio=;
 b=NYPsMsMICQSBi5ZtHP6/3ahJz6H0rOtJdqf0oc33XP5WF77i4aYNsyG62nb2AAD2Cw1y09kaMAeK0+J5O7MgG3JeIxLMBr+hXj+rJ/j6NQef1tMeCui/+uyk3JqoO9RoijItCXp9tfDZydnAHLDT1OZNU9BISaUOdZFNzztyGBHno5s5jeJJDI23CGVRPOxb8WOhKm3l+EbWLHPYQ0QkplcUaJHRBSSth+uNm52g1XdM98YNBgZrNuAorExjDwzZgcSnnDZnREl8bavmbBM9S3PIymeNMxW/mKR0pZlN0vA/JSy70e6wDoMixGaufM5QLmWvCOLQPPlSVly8s5qKQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by DS0PR16MB5293.namprd16.prod.outlook.com (2603:10b6:8:15d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sat, 6 Sep
 2025 05:31:02 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::d65f:a123:e86a:1d57%7]) with mapi id 15.20.9094.018; Sat, 6 Sep 2025
 05:31:02 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: Jonathan Bell <jonathan@raspberrypi.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Keita Aihara <keita.aihara@sony.com>, Dragan
 Simic <dsimic@manjaro.org>, Avri Altman <avri.altman@wdc.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: RE: [PATCH v1 1/1] mmc: core: apply SD quirks earlier during probe
Thread-Topic: [PATCH v1 1/1] mmc: core: apply SD quirks earlier during probe
Thread-Index: AQHcHlZZE4NxF0w4r0mwpZu/zz24erSFoWMw
Date: Sat, 6 Sep 2025 05:31:02 +0000
Message-ID:
 <PH7PR16MB6196F38C9E7C68BDBC181430E502A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250905111431.1914549-1-ghidoliemanuele@gmail.com>
 <20250905111431.1914549-2-ghidoliemanuele@gmail.com>
In-Reply-To: <20250905111431.1914549-2-ghidoliemanuele@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|DS0PR16MB5293:EE_
x-ms-office365-filtering-correlation-id: 2f07bc5c-ae85-49f1-cb8b-08dded069172
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7SsuW0V4mvtUaIQwq8khzePkZt4ZtYawnuLNiUGDbly+lnAu/LJwHNwTorjt?=
 =?us-ascii?Q?DhLCqI6JC+TE5lereRsq1sevptvFHOMOz1maQlxy3qTr4g9HhyHBXAhe1UAf?=
 =?us-ascii?Q?TWu1jMvLbdw00tm2TjbGmnR2p8Jr3LT+eDZxQlVXVkuKJ1XDRzWJtePg5f1o?=
 =?us-ascii?Q?JuHwVhnnwH59MbJ+JwKOchI1NmFqc5uRgib7poTanvNOgN/Ue8xeboJarglQ?=
 =?us-ascii?Q?HHRIyBiPrEQ/mPRTd8fOGCf2zEH+zY0UWvwsdiumlBpnBH8Ts5Ce2p+jrajP?=
 =?us-ascii?Q?lGZrOXad9HO2G2oPZwVfNoWXlQ3OULd6nNqjByuYqVEL+C3HSUNxS3+EvJ8w?=
 =?us-ascii?Q?3qpATsre+xCvRO1byTsXN2IXkA2gPK2HFqR5S3h6N6/xEKJVFcLUOl/E9k68?=
 =?us-ascii?Q?WRnLd1lIJiFn/1IdaVN6iaTxc5KNlYD9VeugvAKeOgybooj6jMWpAEBaP15X?=
 =?us-ascii?Q?rYdE7AyzKmKD1QsczZV3c7qZL5PNMZs5gxo8fpn6OFr3ryvIsSwkXCVeB80c?=
 =?us-ascii?Q?TpUA/tLxD6ytO1W2G3kfZEIUv2MKSGjX7KV/hR0a9+JGT5/IdJ6s86fbeFW6?=
 =?us-ascii?Q?saIlzkgZjhV6HetGZz99bNCv70Gb1FQ3aLO5jvW/CV4sYR5KIUFCFXzKibDX?=
 =?us-ascii?Q?+Z44DRP/lsKsOqW6f/1fkJ6MC0RRTxgPZGhgsEZ2U0I+8nbKKKSJ2mnY8ye/?=
 =?us-ascii?Q?A9pYQ5JVFRbQ6Usuxuufw6ITBYP2IXvDmGdwBUaDNf2WaXNaPwsrHCy7GMcX?=
 =?us-ascii?Q?DPMZSHGT36jhzm6/IxJ7CbTD7JNYJiptvBfzT+DQxvF6bSNDrfTiUCP1Bkma?=
 =?us-ascii?Q?q1j5DqOW0tcCFJRAUhy7kJNutmHrLRA0Vw/41gvQ9msrkY6QAUPokbs7wuwT?=
 =?us-ascii?Q?xruuKrJLnxrYom48CrEZUFgWjUh2ZrZtTjngM0mpRC/RveTpJ031+oQMqoo4?=
 =?us-ascii?Q?S1LFJnOCOBJ6oyo7CbXsCYYXA2qnKY3JlqDevNgqCdHgFiiwMoFgozxgBVTb?=
 =?us-ascii?Q?7be/S5yzgf9I3sy2z4EbG8mxXYYBiqTHQk9gb4uELRbdHI+E63ChZn++N5pj?=
 =?us-ascii?Q?MkgI1sliyv3HHYLATmIgqohhfzj/pt6whi8WWVN30UpkIwg950E+tp889WSi?=
 =?us-ascii?Q?hUyRlo+xIgntrTrkzFDTFYvTD26duNMRvQydWoxMayoyyhbnL14dmfL2zI0l?=
 =?us-ascii?Q?41H15GTVdhAwMyQkS9fuiAcTlSxzqqxmeE1dfhY5XLZ9DRh6cM6d7GZq01Ak?=
 =?us-ascii?Q?K39aPIXjoFzANbDV3RNK0yx9y9dWUb7GuDhfXCEVdja4O5dugPu3lBbxSdKQ?=
 =?us-ascii?Q?Ka/MgeGhe3fHLC9e9a5EGZWbtVeXv7ELD/MnAeut7FSH8RzAbCT0/DaRuOu+?=
 =?us-ascii?Q?GomEIJAZCZ68D/zb+vdzaGcVSefBnV5CJoF2uXWK9CKIG5NVEo+eT5bdrszj?=
 =?us-ascii?Q?/Bmn7ruyAFo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4bAOIdGFkR7kJLxz8yOl47UHgF4MUOrxofT1ywqviOHCOLtpFvFgwEFVW2mV?=
 =?us-ascii?Q?9scn8GxC9jtPl4bCp+RNaQ5uwBAjPjMUZerkILky5eXJsLmshnK8VeG/5Ipl?=
 =?us-ascii?Q?f/Nkq5NwRKb875VvWf5iVKzgMA2MB2YBI0vZEGQu2aK71CI5P7ZIPTaof83w?=
 =?us-ascii?Q?nAT2V5sjfvLx30YO3xXjAcB9Gu0IYuXM9pg8hdFe0g86BdVt6okRePkjEfT9?=
 =?us-ascii?Q?53YtINUp0KYR79XO7kt2E8iXTkJqt0g9bRrS4dIffCYMBI8kz45swD1tg0du?=
 =?us-ascii?Q?P9YYc9iFPgSP55G26LFCPOlJjZDYPfesb6ocWOqp5Nl+egJP287Pm2d6IPCz?=
 =?us-ascii?Q?dbe5mp7FCzeSRW+wUPMy3ZFQ24kxdi1CEMhIIQVk3+7Ow5wfXGjrH4b7Pwco?=
 =?us-ascii?Q?a0vuhx7qb3jJLf/4SrCwN1KF0ehVmuGLXDQYZoudMG5RszyG3Ef9XDG/66wx?=
 =?us-ascii?Q?mZPRb/0wZ+R7U+DlFkjd1tGYsNSCxeQyfb7ElX65fz3kzXCkEog3MARHg0/2?=
 =?us-ascii?Q?Q4l8XwiXTU30iWKFowG6UuHlkplf+Xfh2qrTa7BjETjTmVcAL33DPU+xVFYJ?=
 =?us-ascii?Q?VHoBNrDKTK3z2U4k0prC+AQyZkyvpUgl69HXgrnndw1qNyxCYRlLZSv7+u46?=
 =?us-ascii?Q?COefxrRGrARGfY7EDDj/XQ9T/lte6ptcl3L3uFUuTl0VAUHovoGVPs6txC7K?=
 =?us-ascii?Q?Fk/DoWj/s8e8TYZYZhrUkRJHjt1Vg5FCkB+QWecfuPWtcpflTmybQZ4QeIrt?=
 =?us-ascii?Q?zeHbiqQfSMkKGvZt9zevl0xgt7yb0Gzp0085+BCPRkiRF+7L0AefUr+P2NCv?=
 =?us-ascii?Q?n0wavbDkrJlX7gsjoYCc22Pzu+Ka9cjcrMS9Z2Z0wvufRmgryxQZj12PSUD5?=
 =?us-ascii?Q?l14eSGeMrAB0p/53oW4i0sgxmGO/rq7OrPBz8lmmUFXsgYgXqQVyFiCH/m3b?=
 =?us-ascii?Q?7x00NQRvV2vjdWBuZ8X9Y7tbWGBoX9zGY7y5debM7Wi1CRZwcbaMWvrC/NAt?=
 =?us-ascii?Q?AGCGhee3vEwlXghazR2Iq2Gcx3KvwtFQgLw2uO50VRQ+Jscb1b0rwVx4pCxH?=
 =?us-ascii?Q?OL/ChlZdNuC2xuCAER4gDlgB4EMS9dMzgy6c7FRPBiOc9/MzuDJ+Dd6KvK4z?=
 =?us-ascii?Q?27m32wNeax680VmYvhILT3k49L51JqT3bdM/XVif5qkxcIknKOGn2Okrkdzm?=
 =?us-ascii?Q?bSo6JDCC5qBmUJUT1roPQnNk5tX/33/FQHvxVWurKuVJJC/E8CIxjvj117Ot?=
 =?us-ascii?Q?cskp5XOFaV+3Y+X6gPO1rHSU2FtnfheXYjFSDSeI8ytQWYqHlquaGTAhq2cq?=
 =?us-ascii?Q?NY2gc1hn+63VfQxNNgrrlIK4Lj8UpRsqgYCF8WRBQtLFn8anIPJIN1mMHRpd?=
 =?us-ascii?Q?sv3pF5KDgZLeG05lnqi7LCoV0IeO22RmD/EC3rE3DtY0GMPkOt81wSU5T8zE?=
 =?us-ascii?Q?5JI6FgNKvzZKhfmzDTyhRILFJDec8P4wzvqYffVTjshXIvLXrDr3oUSFwmIY?=
 =?us-ascii?Q?pfVqWJiwP3ikln+aAClU91p3pp8Y4dzPl3Cp7gV0DeQfh/6bg0dlypbI+7dn?=
 =?us-ascii?Q?lJBY50Ual+Yf0yEOLizfzOqJyAuzUKr+uzaAqxi8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aDCT5zoEMIi23u45fiQUWFIvDfdvojtteHek7wMcgW2rxAkkZp3bx51SpOrujWS7CypocpYjd1mkZ+zddBbZdrQog3C5zAXzykSDvSZoVVyHpF46kX7XN9qtM8NwztBvob97tJdR3FW5kUeuOyIXwMMr/0nX8za5YneNeOl0N+urpji/FtSa7sTvL5ESZeaZMxn+7YXTZuojyU/bgK+BujEka3ybToOEV/AV5d0MbzDWZy5xW4EhWuVxehy2ynLPZ3CHR8ob3Dboxf/MAubAYLx/QwY548mlg+LTm4UdsjyfFYCq68zO/2hoiZmXynciIbekySd0ei+6hWz/Zbq3cvjnCumnA1VZFydYOATI0qlXAYvlkUeg6ZJt9E7SJ9+kyaNx+YE84g+UprYTnVguP3WKc9hj6enQWoTawO0tBhqqnFowLoMLLk7sLF3D11oAlmU6v/aXPQmUo5vVyIIEVnGYKX7GUBc02xcpDply0G/bQxJmyLAtZ1I20K5ZUT/eK7+es1pbAfKozNCyDf3UKVIDP0xZdQLhjS/JuUxZYHBDaKD9ibx3Ihil3+b0XU/z79leg23GWeeBAg+XyJfqKz/zW2cI6Hrm5k2bQCBGZ4W6wh2EtSCwh5V5NRstW6x84bkzP1WFNEkEXZ/MdAKonQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f07bc5c-ae85-49f1-cb8b-08dded069172
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2025 05:31:02.2091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKDSSRcvAAVafX2byr8aMFZH6BmRz3rKgoIhjcCGTPunv+9G/kJ+izdMf4yj5hZ1Mw+CnVxjhV233rKe/dws+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR16MB5293

> From: Jonathan Bell <jonathan@raspberrypi.com>
>=20
> Applying MMC_QUIRK_BROKEN_SD_CACHE is broken, as the card's SD quirks
> are referenced in sd_parse_ext_reg_perf() prior to the quirks being initi=
alized in
> mmc_blk_probe().
>=20
> To fix this problem, let's split out an SD-specific list of quirks and ap=
ply in
> mmc_sd_init_card() instead. In this way, sd_read_ext_regs() to has the av=
ailable
> information for not assigning the SD_EXT_PERF_CACHE as one of the
> (un)supported features, which in turn allows mmc_sd_init_card() to proper=
ly
> skip execution of sd_enable_cache().
>=20
> Fixes: 1728e17762b9 ("mmc: core: sd: Apply BROKEN_SD_DISCARD quirk
> earlier")
> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
> Co-developed-by: Keita Aihara <keita.aihara@sony.com>
> Signed-off-by: Keita Aihara <keita.aihara@sony.com>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20240820230631.GA436523@sony.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> ---
>  drivers/mmc/core/sd.c | 4 ++++
>  1 file changed, 4 insertions(+)
Looks like your backport is missing some parts of that patch.
Please see in: https://lore.kernel.org/all/20240820230631.GA436523@sony.com=
/

Thanks,
Avri



>=20
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> 592166e53dce..7b375cebc671 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -23,6 +23,7 @@
>  #include "host.h"
>  #include "bus.h"
>  #include "mmc_ops.h"
> +#include "quirks.h"
>  #include "sd.h"
>  #include "sd_ops.h"
>=20
> @@ -1468,6 +1469,9 @@ static int mmc_sd_init_card(struct mmc_host *host,
> u32 ocr,
>                         goto free_card;
>         }
>=20
> +       /* Apply quirks prior to card setup */
> +       mmc_fixup_device(card, mmc_sd_fixups);
> +
>         err =3D mmc_sd_setup_card(host, card, oldcard !=3D NULL);
>         if (err)
>                 goto free_card;
> --
> 2.43.0


