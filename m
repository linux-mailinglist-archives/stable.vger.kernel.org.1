Return-Path: <stable+bounces-155306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143F6AE3631
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633C0170C85
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 06:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA4F1EBFE0;
	Mon, 23 Jun 2025 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konplan.com header.i=@konplan.com header.b="G+8dB1oO"
X-Original-To: stable@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021115.outbound.protection.outlook.com [40.107.167.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE761F181F
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661372; cv=fail; b=hmOfbfIsE2qCCD1nEFEIom2IKLKTKLkssTcQshrhBwciifEUxl29SqyX3Kkb9W13NlnCXYEsyRmjBQFF3GQpf/xcXdESU7lXTW8JzG5ZcvR/Pxq1vogcaOYE4jF8mCoJWWs+LkBnaPBkGZWHiG8ZFKNu74TtVgifh/BJtbervhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661372; c=relaxed/simple;
	bh=3TeIrfP5vKV+3Dq4zyNire0UIptNc1vnjr8XPaImYjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O8xs4kOp6eEcme7uJFc42NCSIiRspcAzSGYPRGtLQSb/uxxn/jhJ1j00cwr0vwKJS/NXxLk0ywBzsuM/iahoyx/b8JT6WdImz5lGumCvJPN1TUuANAgi9yszoFbtfQxmsukIDrbWJbclegrPWzUBOvGWOLoASA/PNlovI1LvGj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konplan.com; spf=pass smtp.mailfrom=konplan.com; dkim=pass (1024-bit key) header.d=konplan.com header.i=@konplan.com header.b=G+8dB1oO; arc=fail smtp.client-ip=40.107.167.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konplan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konplan.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wE5SoqxR7Pa/T/y9MRVq6C+4MIxrQTcEGNc8CSYd70rm+65F6IAPXbeol648c7eVQHMApEThh1jywXlBcWuK1eVO1L3eHXJHMNzKxy0ccVNHBfWP3qfVgxhYCMBergVCVL4I5BlVnfv0eYt4logKzmFDkaN6UZtQAJTE4Gi/2ct198r3LBlXhcsTu2fGSv/SUP8LByry5uZKx/CLDLVIEaVOacBG+qd/vzaJu+ZFTDst6szO3T37WsQZUdkNQZWd2C9jZbOpKyWRNFbUCwAqXGpl4kivv7Th9R2jKmwXpbfvL5gPQhi7VBtXsQtA2KWBnBjSuHAuG9m7jVmH+q5RaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TeIrfP5vKV+3Dq4zyNire0UIptNc1vnjr8XPaImYjA=;
 b=X+Pwk83rYL3NMu6tWNH4Cc4lqjomrobV7apxDMrDhMrVRWH/BK74SKRWKxu7aAneIeNx+P38+yH9sRqf3uQbeWAKW5A4ZEAX8HExjqFNX3PW8UC4aQtjNm9EAN0TFC/5kCbgQBcXHV3oOOLFW4hhEAE+NPx+0cNdyTrqJsuF9kRgEDbbfM2oWQF7HoYYdicNvYULQe1SFuhD+PTDsMS6BQyh1meGmSGQpNAsmsgOZWPT5JubDsE+xKK58CvBL9ruJQ3avKEUUntSCVjwOMxxpuzQhJHNH47vxf5XeFw0enERrnRwcakBFln2l2KyJiNvZzBDJX7B5uNc+n4sXU1sRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=konplan.com; dmarc=pass action=none header.from=konplan.com;
 dkim=pass header.d=konplan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konplan.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TeIrfP5vKV+3Dq4zyNire0UIptNc1vnjr8XPaImYjA=;
 b=G+8dB1oOtpT38N/TMy9mjGNvdWzfQW060DeIddHHICvSi3hD/zkL81NXUajXWy0FbUp67IqL/M3mf4mXTU/riuVe4jQlSBaR5+j5q5QKvRUnnnYcVMts8OKpkxg1iggLwLZ6wMQA1LVfkUZQ35/rXePc0Y+buTxnz7PtGnuQUfc=
Received: from ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:57::12)
 by ZR0P278MB0846.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:43::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 06:49:26 +0000
Received: from ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ddb:a69d:c7e6:28ab]) by ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ddb:a69d:c7e6:28ab%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 06:49:26 +0000
From: Sebastian Priebe <sebastian.priebe@konplan.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: AW: BLOCK_LEGACY_AUTOLOAD not default y in Linux 5.15.179+
Thread-Topic: BLOCK_LEGACY_AUTOLOAD not default y in Linux 5.15.179+
Thread-Index: AdvekB6VDQOyY8zdQ2OLKqU1kdTP4QDabT6AAIQslvA=
Date: Mon, 23 Jun 2025 06:49:25 +0000
Message-ID:
 <ZR0P278MB09746D529099F1B9CD61B7559F79A@ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM>
References:
 <ZR0P278MB097497EF6CFD85E72819447E9F70A@ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM>
 <2025062007-fall-brim-a7ba@gregkh>
In-Reply-To: <2025062007-fall-brim-a7ba@gregkh>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-bromium-msgid: 94ee2458-e688-4366-a85b-128a8b9dcff0
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=konplan.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0974:EE_|ZR0P278MB0846:EE_
x-ms-office365-filtering-correlation-id: 4451ebb9-c9c9-4cbf-bac2-08ddb2221829
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?XWIl+F5G7wlbp3Fd+fGZ1+VlUtjA91mKEmFaxtDyMZQRuX4WlvAFQ5tYAm?=
 =?iso-8859-1?Q?/BE31GqMX8xjkCqX32qsvCkV8GPUKwyyYOsfKc9ab3h8L+sLOHHPnnGC3l?=
 =?iso-8859-1?Q?BxJetesISpglziFKLtAkbPoMFBY0jdG24bg1NO1/kIOawFo+kFUT9vkjW6?=
 =?iso-8859-1?Q?yCED3PRcwvDu7s9+0YSf6aZAsXFUpFGs1pipsbKkvBMeF8vNu9BZOlTAiI?=
 =?iso-8859-1?Q?feKtAXwjhlWT4w2yxyBBDzm+Na0seHFFSCeWbq5xf8rjfdp+M+6/j6u8ho?=
 =?iso-8859-1?Q?dc/mg5jiORQ3i48VSbYUT738e0YRglm8oIHGZUdZWNw+eslbM1mcGtxIKp?=
 =?iso-8859-1?Q?YtYGaleA1hLLIx+3ujKljpiOINwbTaOpc3dTev6K6c47adfwCLGmRxy38o?=
 =?iso-8859-1?Q?plPxnYdY4or7z5hI/0X5nXRRY6VxwX/hJaqDX7f33JsTAT0cUxBiXvq4Ic?=
 =?iso-8859-1?Q?Af2vJjbvKT2qLPhyUy41zi2CC6xJqORfTvcJEo2CGjtP9ubZ5PR3leCKMJ?=
 =?iso-8859-1?Q?bz+30ql5VkopbRoy3CNMb4oFFEvs+AKFyqKGLWGf/4I4l9IY+xVNGxhX5O?=
 =?iso-8859-1?Q?EkP4/zLRuXppsMakakmeb4vu3HepvVtTS3L7evjsVLm5iaehYG7GL+kOw/?=
 =?iso-8859-1?Q?WeS+fC9nWwIzzUtD0gMxlBEva9t+3IRUaOSH4nur8c8BYfoNDEMwieNmHD?=
 =?iso-8859-1?Q?PH9EPT0UYbEQNWqZ7geQcNhYqbmoqc+znrgRCWTExYnnhwRUTCPuzi3T2A?=
 =?iso-8859-1?Q?kDukkzLQ1t9kPo64lb3j9anWDqq4OFIUEUjNSEEkPeifFeAFbAf2Kw7oF/?=
 =?iso-8859-1?Q?YBKSsdWRCItqVCrwmwgCO0y3Ld65Brda2RcQlCiKJhLzDRRythHwxVs9+N?=
 =?iso-8859-1?Q?tzeYIC1bW1tlPo+ztyYLQJ2mvN/B3q9lj9IrjdWPCCu99M1ccSR6phL9uz?=
 =?iso-8859-1?Q?P2oTwIQNR8RHFShj4RVOePs7AkN0OqWJYBRSvrCu6Rq8Dv5kXA7V0Ms1O6?=
 =?iso-8859-1?Q?ThL1pMtzflWqmBBac+4VxA7mA0bYwT6mdPxb8PEg2V76D47vg++txb2cFu?=
 =?iso-8859-1?Q?tGEOuNzE7zRTacekwJ1QZM3avLxfutDmB1JVSEfBIWJ9mFhd9UOs2G36H4?=
 =?iso-8859-1?Q?bMUZsPAkbYg4jhgz1i3tH9mWN+P/fhMEn22LrWILLlan3OR7PKcZYjyr88?=
 =?iso-8859-1?Q?v5NhN3PsGCjccffe4gEbrFfKuCvJiCOJmr2KEPqv+CI7iSGoeHCpVHWrOP?=
 =?iso-8859-1?Q?7vhWqPzQjzMtkxsXd8/caZJLXN5F1Tx53tj5aoPaDilBtzPA+hQMePcvjy?=
 =?iso-8859-1?Q?3aVUxwxiyj3gdfeP0PPxZozncx9pzEUCn5OQU6MMTtjq92rUOvhC/Dodoe?=
 =?iso-8859-1?Q?m+tQEXf5wYwRmujtRO50/lheVdO8DtU85MltJyrrpbJQvoy7O53Xe7jhyS?=
 =?iso-8859-1?Q?Mc0SQdzqIIPedgElsUQrlb6Jd8qAcM6umchyyA70vC1YBuXUmP1/D0aCUC?=
 =?iso-8859-1?Q?F6ClebO1/ZzxMNDkzvSmueWXqIdFyvAO07kalgnrcBHQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7053199007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3Y6kOx+5eQpvuhIjmd5ZBMOwaMgG/0bAo5oKXtNlFOd2+E39OR/zZUiAV1?=
 =?iso-8859-1?Q?LC+0X1LrZGMVz/ibawRV12+mMGAZcVjB2TinQwKOLIll26P1dnH+IFDEv+?=
 =?iso-8859-1?Q?+anqRrMR4JiU8XI4ZQF2UQeXFpD9UUxRkJnxzjNCiMlOhOLboaqEmmgfH6?=
 =?iso-8859-1?Q?hGGessS6EfJLEhi62sbLM05JbyUqBXGzKOxjV4R7RwK7hongqTW37fwUrD?=
 =?iso-8859-1?Q?BXRAhU0flYisYa88q2/jxvkNuOJHmoD4ioPFuc+U4YnIgcCPMLSAcjsXL1?=
 =?iso-8859-1?Q?qr5YjruuepZ431oc3ATzLXsusUOeGuOAultVwvfYr1Duzeph+J7YbzFIxQ?=
 =?iso-8859-1?Q?W10HBc14CVeJSrQ+5BIULvBYdS/40/jTaOGcPi78SpLK95LylRqsuiuxGu?=
 =?iso-8859-1?Q?ODnDRU886yOHb9ifcX0AmCGTYKCn6rweyMWs95iNjTjEgOJpVzcZTm2i/z?=
 =?iso-8859-1?Q?RjwXL4z6Ae/3z2GThTaPehtnl/QJka6kjNldzVn8NXdvCgI/yuXQ/MvjZX?=
 =?iso-8859-1?Q?VL0h0QUuYaCt2vRcLtxov0lRetFXgwTYINnodgbdUOi+A8V1AzdWVB8Rx4?=
 =?iso-8859-1?Q?8VznBXjOm7HhZQIYjM7jmDcFFPAmSQex6jVbJczc7mlWfxlctk+S3nzzwc?=
 =?iso-8859-1?Q?lN4wKc9Q9ZpcbGfJd4/eZGfDONCgtDAYIaZczy+4SvYvszb1mmcfOkKJBf?=
 =?iso-8859-1?Q?yhVBgVfm2zHcUCgbCZ3OI7mI2V53hT7ODkP7e0O9avRafmsjwHpwWLloNK?=
 =?iso-8859-1?Q?NPKfbyaosSvw4sejiWnsuZYVlLvjN4Noem2/ycLehlyovOtzHXJza5zBRy?=
 =?iso-8859-1?Q?1KIOp70ww3P4/8lQcHlLUElu4QDl9ZRXiR3W0XKPjtQqvQCAE9e1TqWf16?=
 =?iso-8859-1?Q?pfuDoxJ4tjk8aGhpDWyX+seKiGR47ecL/VgUfWbkwKVlzIJi2+y0C4Cper?=
 =?iso-8859-1?Q?qkyjiatDd9i8hJpwKZgvv2R622AiQ2G3aHCnBA0mGGTFQwyeykpm8QMUUc?=
 =?iso-8859-1?Q?+rkw4Vl99vlToe28ATdhG9IpE/ypmjSHVW4MWpDzbWY1rN1OeYXe1h7LM9?=
 =?iso-8859-1?Q?whPDCUSSn20MO0LZqCvF8XQiRiQ58IjUiQCXafEqW8sX5A1ZRCww+88oht?=
 =?iso-8859-1?Q?GvoLfsOf3j3KfMHTaHcM0Rx539PJKqMuAAoNFTvQBmUtZowTPnPh7FsNGS?=
 =?iso-8859-1?Q?lohn5sAvcHTwYb8mIsjAHoC8l62g7YuIES4RX4hwoHFQLSHBob92gM1qxz?=
 =?iso-8859-1?Q?5DkAQXNn4C3v8WMHPoTLJgOxIk5ySPdJ/rE4zK2c915IMqMpsEDZXrbbT+?=
 =?iso-8859-1?Q?mcFTAkmly5JVQhugON1/NIyatoi/Fo04jfphLkAGocS0Knm5crohZ/0qZL?=
 =?iso-8859-1?Q?TQCgApqFok7Kj2Ib6bmv2gufuzVoVwOWja5VBK2f8Y+Z3FlTdiI66WaUS/?=
 =?iso-8859-1?Q?E89la4uOKGtdkYyQnraZB1hfSvrq4EPJl4FzELFGVFko6BGflffJDByCUO?=
 =?iso-8859-1?Q?3eNrxTBmZVn4vhJcT6nMWbbk39NhCLewrzLRXo3gp129KwUktQK0UTAYub?=
 =?iso-8859-1?Q?jwJpG8YzZ0XJ8y2hobsT7Sfo563C+Vw4rFSq32SjVRnjoABYuvtb1epD9A?=
 =?iso-8859-1?Q?DPeiPKluq4a+HBABy5/T/CVjHKA5sux0TpNWU6AmjYU+ey5UW+Seq5ss6k?=
 =?iso-8859-1?Q?t+dHXr49d048RMkiBCrBYSWEcJHs5G6mAsf4fQ2g4bSY0O5MAkPzsRF6Dm?=
 =?iso-8859-1?Q?Z/hQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: konplan.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4451ebb9-c9c9-4cbf-bac2-08ddb2221829
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 06:49:26.0360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b76f2463-3edd-4a7d-86dd-7d82ee91fe05
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qT+rJh5qkB8/kwSMGZQuhpA+s4sP8c82YEhGiqLDzrtX+Q9oonLmkYDrATBTfaH4ATIgjFfOFkdyVG6oX7+EEPGv+2oXZ1lMoW6m6zf1O4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0846

> -----Urspr=FCngliche Nachricht-----
> Von: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Gesendet: Freitag, 20. Juni 2025 17:42
> An: Sebastian Priebe <sebastian.priebe@konplan.com>
> Cc: stable@vger.kernel.org
> Betreff: Re: BLOCK_LEGACY_AUTOLOAD not default y in Linux 5.15.179+
>=20
> On Mon, Jun 16, 2025 at 07:28:25AM +0000, Sebastian Priebe wrote:
> > Hello,
> >
> > we're facing a regression after updating to 5.15.179+.
> > I've found that fbdee71bb5d8d054e1bdb5af4c540f2cb86fe296 (block: deprec=
ate
> autoloading based on dev_t) was merged that disabled autoloading of modul=
es.
> >
> > This broke mounting loopback devices on our side.
> >
> > Why wasn't 451f0b6f4c44d7b649ae609157b114b71f6d7875 (block: default
> BLOCK_LEGACY_AUTOLOAD to y) merged, too?
> >
> > This commit was merged for 6.1.y, 6.6.y and 6.12y, but not for 5.15.y.
> >
> > Please consider merging this for 5.15.y soon.
>=20
> I'll queue this up now, but note, unless you are starting with a new fres=
h .config file,
> the default value change will probably not be noticed by 'make oldconfig'=
 so you
> would probably have still hit this issue.
>=20
> thanks,
>=20
> greg k-h

Hello,
thanks a lot.
We're using a custom defconfig in our build environment so this should work=
. But I will have an eye on it.


