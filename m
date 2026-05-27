Return-Path: <stable+bounces-254468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIljO+dWFmqplQcAu9opvQ
	(envelope-from <stable+bounces-254468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 04:28:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 982615DE8C2
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 04:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BC88304817B
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 02:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15E135A381;
	Wed, 27 May 2026 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="F35WMz7M"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010016.outbound.protection.outlook.com [52.103.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BDB313E31;
	Wed, 27 May 2026 02:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779848787; cv=fail; b=mQ+2f6B3CLFT+oqIHdNtWVLujbBaPr2YyhxG2wARhDHS7OT67YkHSFUMbHUutcut1UcJzRc7nc+FRnoOzOWPSw6JBCw0TcmKPI5iN+5A9muzp5MB/gq+GNNQctz7HLdQJrJLNdMoa0smuSTbwrLZ9X5wDGX0ot4P0S1A2lmv9pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779848787; c=relaxed/simple;
	bh=46/PBQe4f72ZpobIctKkV4/n/Lg2KGbTGRQqPmQxvUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XcsxZdR/eBT0nR6Y+PbIBZS2fqssvc0zcrS9pFMwVh7KcgEb/Ly7XnJeLbWnfc25z1I6HM7QQu5OjEmsu2Cl/I6+JEkfZl2dMBxmxmYpL50XU2BZXIrXU56eIIolypwcfR33zZCvQQmWyILI6+q/znBwcr5hsowSB2ZxiLz1A+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=F35WMz7M; arc=fail smtp.client-ip=52.103.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsKp0W7lhm2t9ZRwkhqFPCQpfRae6QWmnB38hBbsma0UdYmgF+KnysMI5CM/mVy3vg0dfJOFx254ZLYvUQfwG9UDKy+Mi7k+/5vBX5hiG5VSvMZHFDRBOCH8nr1XY4tu+3nahuLlUkuzUaBp2wJFBkGHRzr0dXofzepcyErWnE4XF84wuhna/8RdR/RoYS25ySYk1/L4HumyYyOrozZGyoD4C2QYgJi7kpBZ7PMkkMQIVWcOOxmNNEORp+y0a2K2e+EwZ1Sn3N4wC/6oKowLAY3+sbWzMoBZsGPlMhIgB3FvtduM+kcfX2Vru2xNgcAhFdHrx6pU9vza8+QHSvSf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46/PBQe4f72ZpobIctKkV4/n/Lg2KGbTGRQqPmQxvUM=;
 b=UqIOsCaqwb6mirDw3Ozts1pmdn33qekUqsumiQYYIR9JNcu9ygk/5U97WqERPwtZwhBsH5XUpsvjx33OVA/gHg4mXkE+d3Ji5dcIcJSiEcqFVx/QrQHKsixk0QE46SZUC4NvOaRfKF+eEzEBETvXi0JcmZO1sPlvnJNl8PzSnntHmtbK+ldCFo26FX9G7B0R0rnlKWdfjBbwTEz4QXmDnd1dM/ofE4juJjYXYtiABn8JxPwjh0SiwZU/nXufBgHyrdbwwiZroJGQF7Z2MLGXbrpg8qKIB31jTJ8qYpYpFge5aXuYYPR8/3ONfyNIpnVlIOEE76efw0Tys9WHwabSAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46/PBQe4f72ZpobIctKkV4/n/Lg2KGbTGRQqPmQxvUM=;
 b=F35WMz7MlUSrieP4bOtIS05RNBXF+PGhJVd1uFXHdqQW7vCLxcOkSQk0VS4QnZxGuxnC76Z6iH+T8AcqTSaupniGxL7fKqHzWAZzDVdKR7nIvI37XiIubA4fbSu7bx3+cpSU4lj7aRbvLF3+ySsysMSqJtWSVD6Wz7skuafj8Es7hq7jVhDsMqC/VJUZRIXWMDrKEwX/iuGzSl+HF96NWd+rkFTgx8xkPEkOF8gfiq6mwjE5A1ZRP5Dslkm+Mendvdims2kMQ1rVD7uN2oOTI7I5RUD3f/r43Q2LWoaQjg3+qxXxhx3U0vpSftUoAF5Y/QfiVTe4C8n1dtjuSMjaPA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY0PR01MB8665.ausprd01.prod.outlook.com (2603:10c6:10:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 02:26:18 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 02:26:18 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Yuhao Jiang <danisjiang@gmail.com>, Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net] octeontx2-af: cn10k: restrict LMTLINE sharing to same
 PF
Thread-Topic: [PATCH net] octeontx2-af: cn10k: restrict LMTLINE sharing to
 same PF
Thread-Index: AQHc6086nfSUCy6ZyEOiT5LGBq+8dLYhEmGAgAAMWgCAAAGTAIAACQkA
Date: Wed, 27 May 2026 02:26:18 +0000
Message-ID: <EC369580-6077-4B78-850A-B29F5E46EBFB@outlook.com>
References:
 <SYBPR01MB7881F8D11D2930BB84215253AF0D2@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20260526180233.4323832d@kernel.org>
 <CAHYQsXQ4qQa9nLc6re=Oobyojv3FVG9Pc+3KVEq4qKXEq3kXYg@mail.gmail.com>
 <20260526185224.0c65e38a@kernel.org>
In-Reply-To: <20260526185224.0c65e38a@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SY0PR01MB8665:EE_
x-ms-office365-filtering-correlation-id: 1dba13ea-b635-4450-5f34-08debb9755b2
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|24021099003|51005399006|55001999006|24121999003|22091999003|15080799012|19110799012|8060799015|8062599012|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PJ0TVFHLXysIiLYwb9xaNWwrSnV0gcQqHUtOgGPCTqGDdQsSGVCitZb7Hy1t?=
 =?us-ascii?Q?6d486XQwXREQfbgexibiwdsZBlsnpDR3Sd/41VdtQkQ9c9d21ERCuWyp8sPW?=
 =?us-ascii?Q?a6xZaps+cgNv4RjbNS1HbJy28ojERIUwc8+m8RPJhrXjlKoJbopL0zbTFFBr?=
 =?us-ascii?Q?yrJoHTjnZDRkhYIB8jvASt/VNnU6hNkMxgud8qmxXRbpgEBk6xUE6eco/1g0?=
 =?us-ascii?Q?tyZxCcazw0aV2KUM5QkFE7ifUsQADpzCnogiCD+32Pil6W8nceMlhDF+tyxF?=
 =?us-ascii?Q?fsxH+2YEWMjfxlfvtpnl3fVxlLG8I8Z3ATskqaeQpucQgsoIIrusj7gsYKO8?=
 =?us-ascii?Q?oqSqtTzq7cH4GLaZqCW5AYBycYd91r0scWE3f6P/829Bc3fcohU9PSJ5HVxj?=
 =?us-ascii?Q?64guknGtw9LrO4imeLyQEt2UXudNBi5l/jKVEfFfH5P27ZjdLX8zkMR4DZum?=
 =?us-ascii?Q?pxKYbrFE8kUaPLSubAgndvMQUHL8CLwvXhUFlaH5BKFLSogWvvJn4me9rDRN?=
 =?us-ascii?Q?pvWNR5T/DWt0qfSenBV5yHpn9YDqAqL1cyu+WgTyDyfa0qc00boi0oo2vp5d?=
 =?us-ascii?Q?oatWa3JW7fNDLiDA161Ho6dqZNDvqlaaIlLETxZGNF/Y9W4kqi/yjFAYDJou?=
 =?us-ascii?Q?7HnK1MctO2yMigLhudCgpPuFy6xO0fdvtFfKFr1rqgT9gICfZOpZQPyv6kQw?=
 =?us-ascii?Q?GS98MaG279teRMmovPo3dVXvyRjcIoCGn+2lJnYU/w2ZQvLmKdbM1p0mER+Z?=
 =?us-ascii?Q?KShT2oSdpRn23CMmO4Aw9aTiftkPpzMZUsrjNGS3q+riWEXBPE3Iqz3+wFUK?=
 =?us-ascii?Q?8nBH20GdbD+2wffSyrmfU7zyemjVAWcztmiRXGTGNr8MkzaRPPR15JJ/3yLl?=
 =?us-ascii?Q?WD+B5zlpm5TEkeLs3dpwK6zLAzO27Ncd8NQn8tO+njb8NNNOg6RyiFnBT6IO?=
 =?us-ascii?Q?TAP8r8Fo8vQ9hk9qnelf1LPQ3axe1CddGTwomUlB9GB0tUQWkmb/E7QsZE/L?=
 =?us-ascii?Q?xCnSgNUYmQYWvrH0bzx8nj8nBMeASn6iTvL2vUJGa3ELXjE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v5HoMHTHsw35eFp6wNZL8miTdfcmIflZTuudHJJ0gM7rE0mOQo+d0UbEG2n4?=
 =?us-ascii?Q?8kar8/EEuNVLnr5Cx3e7jyLlqU0hL8hsMcSCRFRhPHi5aXU2FKjC2LPzXYUt?=
 =?us-ascii?Q?IVmb9Hr+wwo1TY1XX4BuOvpL8U3r/MnTHLNaZkdf0TuXzD+RjNll0T6cSETN?=
 =?us-ascii?Q?xPVFWKoQsZKwRlncNqS3kq2vxX55oJym8QIqWj5+AlJyL+lh8jHMNCa5VeXJ?=
 =?us-ascii?Q?SR03KXdK6vhcW+n13S+mpMgRjUNXlqD/9h92AwHIuMkzkteV3QCexvlfLP8s?=
 =?us-ascii?Q?2uwimeWeo3emuJsAfpVIY/0BCsFyM8gaA+RDwqN35708Yrq8APm3oP7gh2k/?=
 =?us-ascii?Q?i/ZqmW41gBPKRKSZF/0dQynHiz759ki0MUc6B6QeIey08kCUGmK7+DFFl5/R?=
 =?us-ascii?Q?GD/SB8RqhhV0K68je5xuTGru/+oU7FkCyt2p3ztJ6wxx2lv3VgwQibV7LO1o?=
 =?us-ascii?Q?3Ld8T0OGyi/5EcI7MawzGah/FksNQDiOAzw/U8FCTN6auFS0vOXK2YkcQLS8?=
 =?us-ascii?Q?hCd0kyW0JS+QPPHmdv6hka6drhFoPoQj5TO7axiDbY3BznKTat2p23rsWtiL?=
 =?us-ascii?Q?OF6VYzj4lW3GPpOYj/9CAAAoDeHlqet067toUUIPbmqXVedcytZvUGXZwtKU?=
 =?us-ascii?Q?tQVlVA9+NWzAVmKRQR1zEXqao3CsDIkTwv6nvilZgyN7WLESCbopEsPZKVZ5?=
 =?us-ascii?Q?sjDZC9kW97mGmBxgJzNqpGUNnSb/MXD1tNsurfju3hqPkGaIYjigDmK3SKLj?=
 =?us-ascii?Q?q+uAikA8axiLBZ86ODpVRiVpQ9boEqYGIWv2a4HD67qAuoutOuxDUj1I/2kJ?=
 =?us-ascii?Q?sXkFlKDRNwQDipwdrhUbNoIZMU5EpGbx4fDWgzXcCa/eD4pbe/0i1WQny3Eq?=
 =?us-ascii?Q?WtQwNgY2Awqq45YR00RHBLO0u4H4ok60KFvTWXu1XfO5KvTewDaqDYEQHTRl?=
 =?us-ascii?Q?MH70Rfj/U/EGg7ehmnH4EJjbSHGu0Le7HSA1eSeKz3BKK4HTfYpc1tcx65xg?=
 =?us-ascii?Q?mfcK6fXeUkgq53DuuxpS76qAgQRV/EfXxh9Y0zpcPQtI2i5pPk9io1nHVEh5?=
 =?us-ascii?Q?sELOwkAtn4RPRtTnkKSM7Yn8UH4n0wfKcXyhH4pq4THQN6ovAkpH0WDnYdfT?=
 =?us-ascii?Q?NPLQYHfyDZe72oLWkYuutIWIlqJLlSHQFVgRwbczAewurAwkTmF+gKVoQu4Z?=
 =?us-ascii?Q?VKLvuouklUogxzeVjvid0MJNrpfYgPpAxv4Tq5xGA/ym46nGhCiGZwdiXcq5?=
 =?us-ascii?Q?QIDe0AZuy6Ysaa/+0MNj5bX7UdduO7WGQY5TNMjkadGv75oK/zKPX7lMhN6r?=
 =?us-ascii?Q?X52gFf/tQKZTll28hU+aZEQz0P0wK4weEk8MHh8KiL2XP2zelHwv77NkpnMz?=
 =?us-ascii?Q?atu1n2nbBVx3ge3FBKqabNgEKr9ml4RGys3U4QH3vh16al9zbw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1EE61971A2A1EA4584DAF2BFD7D24103@ausprd01.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dba13ea-b635-4450-5f34-08debb9755b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 02:26:18.5376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0PR01MB8665
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-254468-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,marvell.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:mid,outlook.com:dkim]
X-Rspamd-Queue-Id: 982615DE8C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 06:52:24PM -0700, Jakub Kicinski wrote:
> Junrui, please describe your discovery process.

Hi Jakub,

Yuhao forwarded the report to me, and I investigated the issue and wrote
the patch. Sorry for missing the earlier report on Sashiko, and thanks for
the link.

Thanks,
Junrui Luo

