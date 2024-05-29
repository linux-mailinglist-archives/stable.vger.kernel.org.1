Return-Path: <stable+bounces-47670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC598D419D
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 01:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414331F229AF
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 23:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5CA1CB32A;
	Wed, 29 May 2024 22:59:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2014.outbound.protection.outlook.com [40.92.89.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A1815B96F;
	Wed, 29 May 2024 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717023598; cv=fail; b=Dmm9xkBjIxTYctxUeBYejoWCXp4a98q6wwlcBQz/eiV7nlStIyFgPjk97tcdQUm+3cQ1pxx5r3viRyvqnmbQuhH0bp78tZZSYTDHozpqp/kuOOKGeAxwrFC7/LYsvoU9vignNQYRerHlaJ5HH1UIQlh9m5WOqwuO9oLe5Lyf568=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717023598; c=relaxed/simple;
	bh=1DSFfiU2SIt9M8g/5KgPHOZ8IMq7vSfnZq2GVu3MnpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tFWaKvFkRh3rUVlLW9SXmSFxz+GJ6ELKf/D2AM2xLZ96CjsJxxUw9PJdF5teVOaNNLDJYh0siZA8Tei/8QtpitEHbPVhcEbsb5WWuA5ogM7aA+Mj4bmFEzgLY77Kh5q1Lzo2Dh7lNvP7Puk34BXAJfgCvUJ8AfSQPGbXwtBS0pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de; spf=pass smtp.mailfrom=outlook.de; arc=fail smtp.client-ip=40.92.89.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8mWPc6iyMmsh3QjNI15Kbb79yMQeutypx9qSkcCsA6iXJQDfP0iW7YOzcnOu0PoudptDlREG2qcwkJfcItik+UHjdqgjvH6BmzNIBNQg/Jjrpk4gp8+piVbiUa4BaN4Mke3mGoogxuLaAmJ9YCrXosiXdTYZVN48Wu8wxZ7oejxXP/ru9V8eu5UYeUP4k6W2Aqfu1cpHrLjUGZi/XrLQTMAIeekZPVf8NM8znCbZaoZZOZCBiFXSacAehsfmcw7imvQNJ5CgpdgwWWqO5Rqwq2us7KrsbiKcLWFn79qcnh2i+Zfx69Hmgg5m/NEPlMbKB4CAeNEuAMk3FidfM5FkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaKPWD+Xxw10/tIuEiZ0N997+18B8bCgKkgwRTcUV6g=;
 b=Tk3K7XZY645YDKiUntMKg1jWTpvBpMkRWSaeaz8P7CIq7CGO9HxS5cxK3dqIS8p97c74bF8GdQE24L8dg6QpBvJfaTt9PLZ8xV4cT34XSGtHrrPzl+n+MKoD+Nh0zwE8ranzRnBAZLwkTwM9b45nDQxJIGD/rtt7Vwo5jLAVZ4JH04/lhItY6g0Q6Bd8LzlfGemYy/WEMKHMiiRK5hcIC6UAFG8HBzEK+c9W0jSgXdvSxU01+nWSKfV2yJb10xOzVQ8A9mdE0GTSrrS8W/Lj6X+G1ZPr1Yz7Db6poE+0qidbhFuXa2D4f9befwf/pbYBtL9uQY7o5EKEOZgb0IMCKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PR3PR02MB6012.eurprd02.prod.outlook.com (2603:10a6:102:69::18)
 by DU0PR02MB8666.eurprd02.prod.outlook.com (2603:10a6:10:3ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 22:59:52 +0000
Received: from PR3PR02MB6012.eurprd02.prod.outlook.com
 ([fe80::15a3:e65a:6972:b802]) by PR3PR02MB6012.eurprd02.prod.outlook.com
 ([fe80::15a3:e65a:6972:b802%5]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 22:59:51 +0000
Date: Thu, 30 May 2024 00:59:50 +0200
From: Tim Teichmann <teichmanntim@outlook.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Christian Heusel <christian@heusel.eu>, regressions@lists.linux.dev, x86@kernel.org, 
	stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [REGRESSION][BISECTED] Scheduling errors with the AMD FX 8300 CPU
Message-ID:
 <PR3PR02MB6012B1075C02636C2954676FB3F22@PR3PR02MB6012.eurprd02.prod.outlook.com>
References: <PR3PR02MB6012CB03006F1EEE8E8B5D69B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <874jajcn9r.ffs@tglx>
 <PR3PR02MB6012EDF7EBA8045FBB03C434B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <87msobb2dp.ffs@tglx>
 <PR3PR02MB6012D4B2D513F6FA9D29BE5EB3F12@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <87bk4pbve8.ffs@tglx>
 <f3b909f3-de1d-4781-aa7a-1967abe24125@kernel.dk>
 <ZlY8SbGVMHho-dLz@ryzen.lan>
 <PR3PR02MB60127B753B3B4BA69A737BBDB3F22@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <Zld03FTNQ5q5uQyN@ryzen.lan>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="chqs5npl3gmnyvlo"
Content-Disposition: inline
In-Reply-To: <Zld03FTNQ5q5uQyN@ryzen.lan>
X-TMN: [SljO6vWFzmhIuYZwWL7ezAfRBfY0stt4qyUyA3swFyleVdaNAT899xXKPb803Xyq]
X-ClientProxiedBy: AM9P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::7) To PR3PR02MB6012.eurprd02.prod.outlook.com
 (2603:10a6:102:69::18)
X-Microsoft-Original-Message-ID:
 <pewft2iqwc3ekoc67cunn7mf5ipycibza4et2hity7um7fqdrq@zlzrgyrf3beg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR02MB6012:EE_|DU0PR02MB8666:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b405f98-13b3-47b8-c1e6-08dc80330c2a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019;
X-Microsoft-Antispam-Message-Info:
	gjdF8fiXHJe+2XI02Cdz3Qdg3hVs+n25eZVNcWT5hPUuD0jeW5opxKhrzc9Pn/2y8RI/bY1XFWfiPk7vPSOn5DigKiQsWwQlhulx59gexoZc/tc7MMEJEYynPmrkmrCkBkEmCAepdCGot9OzrxikjHAS4WZ5TAVBRLAuUVtFj7P3UbdijcluQT9UFsXGjV750Pueg2feNMIGje9/O7AOigts/rW/Prb8PAwrC4zyrUB5HNPM9PNvNV9ZVpseZhhVk+f0h9K3fTnk2kUBkr15FnchRQBX+jj4An8vU/TiTRGZnWJxrOm4h3Kn1YvxlD/1yuEAPO7wryH0xhLA9fbxF9ARe+ZMWbOgJSKTrY3Ltt3ytI+3XCdlQXP9wD84ep98oQPi5o8HcH2yRfKXDJ1Gfkp3bsHx4ds7T5yVzobApinc95OHcALIw6cMO20ctIlpqjnUYoMdbmqFXXVUa/f66aBk9051fk+bY+8LSJrNnVo4LO9FSATgePkO8BuKGIijl73qtPwlIDcZxhLQTGSDjHNT6FbsVTLpb/RIvtmlv6gl9BQFjUDnnBIISuumA0JVHdTPZ1nmoJ+1TqRx8fwOErTP2PSeVeSTyQSEv+sVa9dlLiNy+7CwbkBT4RiJycXpmxWe7OyhanA4a4Fw2qbX01dk2tkkkkDZ0LRSN5mrKVE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B4BCNZda+G+IwxG5B4xO0JhN0XNGONGvGi/EKc5LzPY609LVch0OssWAE0iF?=
 =?us-ascii?Q?kFPZgZB/u78zzEj+uMYUJBKW85ZM7T1LZDiS3G+6YaEhAAfIiyUi9AE4R7D1?=
 =?us-ascii?Q?Iqp0hqpp5vLEtheXUUaJ50vHqH93eitZv69n8gNe+6ZXCW4F/I3I0N9buJH7?=
 =?us-ascii?Q?rHZjtZXacetYuCUWs4mSbum3Udml283Ye5zpxlCZWTZHnKX2mp5Gt8MXNo9V?=
 =?us-ascii?Q?mLX4MfRpAbMz1cTWdGkGbqOjjF7XSp3VgTGVtzG7C0gJyRBE1uMs7OvNKrcc?=
 =?us-ascii?Q?Jl11Ezc6Dyftp3MZerEZCKMWjS16KqUAvbLFsPilMf7bta3rfsUK3etjQxId?=
 =?us-ascii?Q?7l6guCwZ05tH4WtcQpDT663a6M3RSWcmFzvfkO+QOID0NX78Um6J/i1f0TLX?=
 =?us-ascii?Q?UJyL5rcPmVs2ITr03rvtuzn+zthvvpmwl4biNelkZD9tpGbFEoBC5CIIYx/a?=
 =?us-ascii?Q?UGd7Df81Prx4e0GV5nFYs83W8kRjNrAxvh8sKm9uF3I7u444b2nAkP10Zxgv?=
 =?us-ascii?Q?utqIQ/VR5wvXmTJH7uFOJ1gEMfXHquzdmx3KGcASq7WbZbZPe4GRI1O6ceLD?=
 =?us-ascii?Q?s+y8B9hdBkSqIN7jx/dwpjoSciw90j9KebZong5gicBBXMWbOhb7fVpM8FVA?=
 =?us-ascii?Q?5OCy6UKDXeHYxpK5mEg11FKGMgeohUjbNhbNgg5r3ZrZw71HNQGgQWvxJr+Z?=
 =?us-ascii?Q?92N3nUZYRmuVNbafbiLHly+N4ABInjJkBrVfftu0of6CuhiOsrNWxrtiSug6?=
 =?us-ascii?Q?NWUZAgRMGaeKX9smdUYZrcb/mI87gYLWNc3WcydgGzAtcbYnNrJrJn1OFKp/?=
 =?us-ascii?Q?InfV/smOPm+vhasnrt52zAW/18XrZCKOWqQ+3z39DCvZvdGZZPq6ElHtoHCk?=
 =?us-ascii?Q?keajIURUnvFqS3DKlW/4TRxZ1qHQadpSstgNfsj+W9PVhaGiZ1zQNmR6VOZt?=
 =?us-ascii?Q?BZunIjXFFdS1pDPOdPC8TYo9Yoy96YNNAmhxfR1S+rhLAfqPrNt6S4TrrnU+?=
 =?us-ascii?Q?lTqsbiLV0qxenqIRrhe/Oi9UrbuAiVy4H37CaefboraI78xRK7KTpZSs8Ioy?=
 =?us-ascii?Q?/QSQUOH4RVYrqaSzbaRnGKJv/t2TuhWzs8G/QqqhNvXq43dF0a9OGbEyYtt3?=
 =?us-ascii?Q?d8RddUmcHdo0rmjSw/Ix8eGyvY1dYTRADxSoVnNLkY8uj7qqsjYOl7du/J4s?=
 =?us-ascii?Q?n0JG/1Oq5D5I5ltoennyfLHMf8yVEuRI5yHMm47H+JcPi1mOoz7DUpqaENRR?=
 =?us-ascii?Q?ywScAOcewsGKqtoPCIU9xMi1TVytphMjLK7s/1Jibhr0FoNtefpNqbc/8nTs?=
 =?us-ascii?Q?sDOycAZC2BYTMAZyXEW0OyL3?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bcc80.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b405f98-13b3-47b8-c1e6-08dc80330c2a
X-MS-Exchange-CrossTenant-AuthSource: PR3PR02MB6012.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 22:59:51.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8666

--chqs5npl3gmnyvlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Niklas,

On 24/05/29 08:33pm, Niklas Cassel wrote:
> On Wed, May 29, 2024 at 03:02:45PM +0200, Tim Teichmann wrote:
> > Hello Niklas,
> >=20
> > > ata3 (TOSHIBA HDWD110) appears to work correctly.
> > >=20
> > > ata2 (Apacer AS340 120GB) results in command timeouts and
> > > "a change in device presence has been detected" being set in PxSERR.D=
IAG.X.
> > >=20
> > > > >> [    2.964262] ata2.00: exception Emask 0x10 SAct 0x80 SErr 0x40=
d0002 action 0xe frozen
> > > > >> [    2.964274] ata2.00: irq_stat 0x00000040, connection status c=
hanged
> > > > >> [    2.964279] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8=
B DevExch }
> > > > >> [    2.964288] ata2.00: failed command: READ FPDMA QUEUED
> > > > >> [    2.964291] ata2.00: cmd 60/08:38:80:ff:f1/00:00:0d:00:00/40 =
tag 7 ncq dma 4096 in
> > > > >>                         res 40/00:00:00:00:00/00:00:00:00:00/00 =
Emask 0x10 (ATA bus error)
> > > > >> [    2.964307] ata2.00: status: { DRDY }
> > > > >> [    2.964318] ata2: hard resetting link
> > >=20
> > >=20
> > > Could you please try the following patch (quirk):
> > >=20
> > > diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> > > index c449d60d9bb9..24ebcad65b65 100644
> > > --- a/drivers/ata/libata-core.c
> > > +++ b/drivers/ata/libata-core.c
> > > @@ -4199,6 +4199,9 @@ static const struct ata_blacklist_entry ata_dev=
ice_blacklist [] =3D {
> > >                                                 ATA_HORKAGE_ZERO_AFTE=
R_TRIM |
> > >                                                 ATA_HORKAGE_NOLPM },
> > > =20
> > > +       /* Apacer models with LPM issues */
> > > +       { "Apacer AS340*",              NULL,   ATA_HORKAGE_NOLPM },
> > > +
> > >         /* These specific Samsung models/firmware-revs do not handle =
LPM well */
> > >         { "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM=
 },
> > >         { "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM=
 },
> > >=20
> > >=20
> > >=20
> > > Kind regards,
> > > Niklas
> >=20
> > I've just tested the patch you've provided [0] and it works without
> > throwing ATA exceptions.
> >=20
> > The full dmesg output is attached below.
> >=20
>=20
> Thank you Tim.
>=20
>=20
> I intend to send out a real patch for this,
> but before I do could you please run:
>=20
> $ hdparm -I /dev/sdX
>=20
> against both your SATA drives and paste the output.
>=20
> (I just want to make sure that the device actually advertizes
> some kind of power management support.)
>=20
>=20
> Kind regards,
> Niklas

this is the output for both of my SATA drives (of course using the same
kernel version I've used in the previous reply [0]):


/dev/sda:

ATA device, with non-removable media
	Model Number:       Apacer AS340 120GB                     =20
	Serial Number:      270E0788096C03674465
	Firmware Revision:  AP612PE0
	Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II Extensions, SATA =
Rev 2.5, SATA Rev 2.6, SATA Rev 3.0
Standards:
	Supported: 11 10 9 8 7 6 5=20
	Likely used: 11
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:    16514064
	LBA    user addressable sectors:   234441648
	LBA48  user addressable sectors:   234441648
	Logical  Sector size:                   512 bytes
	Physical Sector size:                   512 bytes
	Logical Sector-0 offset:                  0 bytes
	device size with M =3D 1024*1024:      114473 MBytes
	device size with M =3D 1000*1000:      120034 MBytes (120 GB)
	cache/buffer size  =3D unknown
	Form Factor: 2.5 inch
	Nominal Media Rotation Rate: Solid State Device
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max =3D 16	Current =3D 16
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6=20
	    Cycle time: min=3D120ns recommended=3D120ns
	PIO: pio0 pio1 pio2 pio3 pio4=20
	    Cycle time: no flow control=3D120ns  IORDY flow control=3D120ns
Commands/features:
	Enabled	Supported:
	   	SMART feature set
	   	Security Mode feature set
	  *	Power Management feature set
	  *	Write cache
	  *	Look-ahead
	  *	Host Protected Area feature set
	  *	WRITE_BUFFER command
	  *	READ_BUFFER command
	  *	NOP cmd
	  *	DOWNLOAD_MICROCODE
	   	SET_MAX security extension
	  *	48-bit Address feature set
	  *	Device Configuration Overlay feature set
	  *	Mandatory FLUSH_CACHE
	  *	FLUSH_CACHE_EXT
	  *	SMART error logging
	  *	SMART self-test
	  *	General Purpose Logging feature set
	  *	WRITE_{DMA|MULTIPLE}_FUA_EXT
	  *	64-bit World wide name
	  *	WRITE_UNCORRECTABLE_EXT command
	  *	{READ,WRITE}_DMA_EXT_GPL commands
	  *	Segmented DOWNLOAD_MICROCODE
	  *	Gen1 signaling speed (1.5Gb/s)
	  *	Gen2 signaling speed (3.0Gb/s)
	  *	Gen3 signaling speed (6.0Gb/s)
	  *	Native Command Queueing (NCQ)
	  *	Phy event counters
	  *	READ_LOG_DMA_EXT equivalent to READ_LOG_EXT
	  *	DMA Setup Auto-Activate optimization
	   	Device-initiated interface power management
	  *	Software settings preservation
	  *	DOWNLOAD MICROCODE DMA command
	  *	SET MAX SETPASSWORD/UNLOCK DMA commands
	  *	WRITE BUFFER DMA command
	  *	READ BUFFER DMA command
	  *	DEVICE CONFIGURATION SET/IDENTIFY DMA commands
	  *	Data Set Management TRIM supported (limit 8 blocks)
Security:=20
	Master password revision code =3D 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
		supported: enhanced erase
	20min for SECURITY ERASE UNIT. 60min for ENHANCED SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 0000000000000000
	NAA		: 0
	IEEE OUI	: 000000
	Unique ID	: 000000000
Checksum: correct


/dev/sdb:

ATA device, with non-removable media
	Model Number:       TOSHIBA HDWD110                        =20
	Serial Number:      48L9BJMFS
	Firmware Revision:  MS2OA8J0
	Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II Extensions, SATA =
Rev 2.5, SATA Rev 2.6, SATA Rev 3.0; Revision: ATA8-AST T13 Project D1697 R=
evision 0b
Standards:
	Used: unknown (minor revision code 0x0029)=20
	Supported: 8 7 6 5=20
	Likely used: 8
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:    16514064
	LBA    user addressable sectors:   268435455
	LBA48  user addressable sectors:  1953525168
	Logical  Sector size:                   512 bytes
	Physical Sector size:                  4096 bytes
	Logical Sector-0 offset:                  0 bytes
	device size with M =3D 1024*1024:      953869 MBytes
	device size with M =3D 1000*1000:     1000204 MBytes (1000 GB)
	cache/buffer size  =3D unknown
	Form Factor: 3.5 inch
	Nominal Media Rotation Rate: 7200
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max =3D 16	Current =3D 16
	Advanced power management level: disabled
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6=20
	    Cycle time: min=3D120ns recommended=3D120ns
	PIO: pio0 pio1 pio2 pio3 pio4=20
	    Cycle time: no flow control=3D120ns  IORDY flow control=3D120ns
Commands/features:
	Enabled	Supported:
	   	SMART feature set
	   	Security Mode feature set
	  *	Power Management feature set
	  *	Write cache
	  *	Look-ahead
	  *	Host Protected Area feature set
	  *	WRITE_BUFFER command
	  *	READ_BUFFER command
	  *	NOP cmd
	  *	DOWNLOAD_MICROCODE
	   	Advanced Power Management feature set
	   	Power-Up In Standby feature set
	  *	SET_FEATURES required to spinup after power up
	   	SET_MAX security extension
	  *	48-bit Address feature set
	  *	Device Configuration Overlay feature set
	  *	Mandatory FLUSH_CACHE
	  *	FLUSH_CACHE_EXT
	  *	SMART error logging
	  *	SMART self-test
	   	Media Card Pass-Through
	  *	General Purpose Logging feature set
	  *	WRITE_{DMA|MULTIPLE}_FUA_EXT
	  *	64-bit World wide name
	  *	URG for READ_STREAM[_DMA]_EXT
	  *	URG for WRITE_STREAM[_DMA]_EXT
	  *	WRITE_UNCORRECTABLE_EXT command
	  *	{READ,WRITE}_DMA_EXT_GPL commands
	  *	Segmented DOWNLOAD_MICROCODE
	  *	unknown 119[7]
	  *	Gen1 signaling speed (1.5Gb/s)
	  *	Gen2 signaling speed (3.0Gb/s)
	  *	Gen3 signaling speed (6.0Gb/s)
	  *	Native Command Queueing (NCQ)
	  *	Host-initiated interface power management
	  *	Phy event counters
	  *	NCQ priority information
	   	Non-Zero buffer offsets in DMA Setup FIS
	  *	DMA Setup Auto-Activate optimization
	  *	Device-initiated interface power management
	   	In-order data delivery
	  *	Software settings preservation
	  *	SMART Command Transport (SCT) feature set
	  *	SCT Write Same (AC2)
	  *	SCT Error Recovery Control (AC3)
	  *	SCT Features Control (AC4)
	  *	SCT Data Tables (AC5)
Security:=20
	Master password revision code =3D 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
	160min for SECURITY ERASE UNIT.
Logical Unit WWN Device Identifier: 5000039fd6d25a26
	NAA		: 5
	IEEE OUI	: 000039
	Unique ID	: fd6d25a26
Checksum: correct

For my untrained eyes, it looks like both drives advertise power
management support.

Thank you,
Tim

[0]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issu=
es/56#note_188819

--chqs5npl3gmnyvlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQGA96qgQojnEauApolGWOpdmSxVgUCZlezYgAKCRAlGWOpdmSx
VrJXAP4gXze+1BGmeYh1YAeF822AantTLx9CEQwb8JEQH8Oh1gEA6eD8pivS8r2C
d61zd1mDrSTWTfnFD75UD6QOQMwTYA4=
=dONn
-----END PGP SIGNATURE-----

--chqs5npl3gmnyvlo--

