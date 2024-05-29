Return-Path: <stable+bounces-47640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CE58D36F5
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 15:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81BE628B2BE
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 13:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A169461;
	Wed, 29 May 2024 13:02:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2070.outbound.protection.outlook.com [40.92.57.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F078C9474;
	Wed, 29 May 2024 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.57.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987777; cv=fail; b=PZZAPj7oRPVF/J2eGBhYLcy8nYkIkMM2+DN/2b85CqlutOjh0YbrpkHddorZfr3EXGB5lmPBVlaOpHzD7+ayjE9p872st7o+Ks1NUFphfgf3W3X2Rx4TnkeHyKX/Sr801gval4LgLSq19VxcvHjdrhAKVs7YTBqu2ei3UbUU/Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987777; c=relaxed/simple;
	bh=k+IUSy3sdUDpnFe0/vaqt89JwpJI3yvLM5VjKBYO70k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JFtXsrfhgOVv3BWytbETqbDaOnGIkDvNZnJiCHqNUgemELxv6s/9HLNSZag5k7LMAd7J1sfXSmWBJDaZ3GU+kWFUHQgjaO0tHWkJEh2KSDaMpo87Hyxb6RF+69nZZDvOEkl1PArmMfdaiuVLhN9TYQFZg3YpzcLd9HweLXO2C9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de; spf=pass smtp.mailfrom=outlook.de; arc=fail smtp.client-ip=40.92.57.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outlook.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW9ctoGuUFnDzptPesCl8hwPu9B/OtxYZefD62XNEgGjoTvhA2Xmxt2XgeHg8iQnu/Is3z+1g8WrDMI0mual7qCLM5O9aR7d9Uik5lyvJNvVeP0wDLB/hrSbvA5C65zhMQVvzUyEl9Gg948qJ6zqFH8Grd8gRD4rP0etMrrsE4SEinODymRYZOBv7h0rPyue3WpVBd0NghlKnbzHT/2RLEsAjW/D27YztuBql1emzK0GturY9GV2h5AEBNNjBD+TCm7158pGGAdQM6+69nJ1hLAU/NhHumVoZNvXtORstLBr8cHaSroRY3MFaTL2gsPkr54mCFc5BdW9w8+o00RgXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XlAvn65zxTV0Uxbi5jB59k0/dsVt2v8bRViczwd+TI=;
 b=OQMSfDQFec0gAxpx/koZ3yCpDZdyyEdMfQmdhlOWQKo0UakhD0d3viV8fWrbqyOdYDFLmC50TLEsvm1pvj5rbUz4pJ2m3bTtxXN+Bq57vZ+yMFcd4f21PZZSrVkDpcg84wOld6vf8UUJTiZzftp7pI68ywtO1aVZgZVr382fMDT+UtEuFKhygojl/fcKL8PCbvWtSJy4NOsLVEYvIHtmws2jYiWqG3Fvakco8ewNDGvOzhOiIyqIPAglEmreaUgY+vWGWNNTdGVRiEmYlqBaE/t5z53NMwnh1owdfuVjKOEpAJcuB9COHgQP7JISOH/e7UuILu9KBPdIi/wx2ryc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PR3PR02MB6012.eurprd02.prod.outlook.com (2603:10a6:102:69::18)
 by DB9PR02MB8046.eurprd02.prod.outlook.com (2603:10a6:10:370::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 13:02:47 +0000
Received: from PR3PR02MB6012.eurprd02.prod.outlook.com
 ([fe80::15a3:e65a:6972:b802]) by PR3PR02MB6012.eurprd02.prod.outlook.com
 ([fe80::15a3:e65a:6972:b802%5]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 13:02:47 +0000
Date: Wed, 29 May 2024 15:02:45 +0200
From: Tim Teichmann <teichmanntim@outlook.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Christian Heusel <christian@heusel.eu>, regressions@lists.linux.dev, x86@kernel.org, 
	stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [REGRESSION][BISECTED] Scheduling errors with the AMD FX 8300 CPU
Message-ID:
 <PR3PR02MB60127B753B3B4BA69A737BBDB3F22@PR3PR02MB6012.eurprd02.prod.outlook.com>
References: <gtgsklvltu5pzeiqn7fwaktdsywk2re75unapgbcarlmqkya5a@mt7pi4j2f7b3>
 <87h6ejd0wt.ffs@tglx>
 <PR3PR02MB6012CB03006F1EEE8E8B5D69B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <874jajcn9r.ffs@tglx>
 <PR3PR02MB6012EDF7EBA8045FBB03C434B3F02@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <87msobb2dp.ffs@tglx>
 <PR3PR02MB6012D4B2D513F6FA9D29BE5EB3F12@PR3PR02MB6012.eurprd02.prod.outlook.com>
 <87bk4pbve8.ffs@tglx>
 <f3b909f3-de1d-4781-aa7a-1967abe24125@kernel.dk>
 <ZlY8SbGVMHho-dLz@ryzen.lan>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g73rnwnqsob4jnl6"
Content-Disposition: inline
In-Reply-To: <ZlY8SbGVMHho-dLz@ryzen.lan>
X-TMN: [GWBWqbsTktfEQFuVl+hVfifikKfXXy8AsQVGGbmsU7gYaG+17cugTFZH3Nq7FNo8]
X-ClientProxiedBy: AS4PR09CA0020.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::7) To PR3PR02MB6012.eurprd02.prod.outlook.com
 (2603:10a6:102:69::18)
X-Microsoft-Original-Message-ID:
 <2o564zd3bmq2zekgsbqhli63t72j2ejng2ramgy3goakuvhbkq@7upqegjvj3w2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR02MB6012:EE_|DB9PR02MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 990f8327-4c32-4f56-93af-08dc7fdfa2f5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6092099003|461199019|440099019|3412199016|1602099003;
X-Microsoft-Antispam-Message-Info:
	eVNYQiU3SOYQaeRn/9x4uM4A9nzYFdkjoqHn9sjVaK0suTMX1mR0FRRIs5AyzwVPHgRB4x5UHZzVjMR6puILdp7nrFMFabmjb3Fn6eFvGPGE+cAeFmLEuMil8yfsUuANUuhW88Q0fne/M2wUnAYKyqh8NOZ/k1jM4TcNRVd8DltJ7PJ2vriFMJtk8K1TfTFgaxuTNASEwGzdAEEOJspjnMoQ5WTuFl4SSlDKpaWHaW87Zku9ZfQiQLuAonpi7b17jPNkxeCyHwI8thWKYEkzSWC4Kd2Q2GxUHhFUZYBH4R6+s9EFPJRJzz1bqrswPNPTJPdWQ0fAnb5rQtSyKxftViO1kccQsLVf2H1isA66tPq/06Qh5DZ2mxQ1AtKpyrItqBA37ZYN0nyB0ZJ1P0NC5zXWIZzoIecufiobx/AHobmXEhXOyd1OtVKuPtZ2r+Ueh3qYkX++ru27oICkX92CqP0o9qvzYIgS8s9woeqyPad+JqzSQj2N/uDXj66s/0lJ81FazS+4qX+UU2fYquLjFVT3PFY+R0rbwd9Ebh5aEu8o5UbnI5dmOXEYSv82dplfS8v6g90abXGPex0H9XEv/JshsJy1zLQ2yDZBDWWIeyY0XBwRLwVhFrdFnZsaVO8ipRUhZb7THMlXdCYzf90npw5C4wsdaMkH4wiUmpehHKSY7X109cmH6kuZ97pzrQYE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PChYysPpYtMWluxvqOoRKmYoVFNnL96CG4v7khmUuZPN2ga+RbiXKwLOSUZK?=
 =?us-ascii?Q?SCFEpWC+hcxFb5Vk+BcBsrgxEShXQr+uzwZjpP+jWMWD3LhnHOfGOLd+QiV7?=
 =?us-ascii?Q?IryCRBtQ8QlWiEWa6scaC5H7+Is0SO6HrRuXM/Q9WiqQZSvtw2nFwvzi82Pn?=
 =?us-ascii?Q?YZAIRt0InMLkn/31IjLP25emTEqJ3rlSEK9maAsUrzp0umkRilKYWZEXbett?=
 =?us-ascii?Q?3rYOWRdX5DaO4mwQu2SqWuXHo9XekF3ytVzKyE0Gxf+f9ZMR6i+xkGfUpku4?=
 =?us-ascii?Q?HD2eb3WA7fvDaGEidcZqDBjWDQ2q6+7pyRmsjn603/dbDEhvFTpXxT5z4Qab?=
 =?us-ascii?Q?yV+gf0IOvq+AImXe4evSdzVCUaOKXXs1ZNsjV5r0X8hDR+02dnAtyTSZCPaz?=
 =?us-ascii?Q?z5yyvaDemUTc6szdLC3OYHNofIbYsnoHRqF7zrF7G3XnvKQCB3MAKPfeUyvp?=
 =?us-ascii?Q?iQIqaGyUYJRtveqAx7F7pZwqixKJkUFdFogtHYt5ku5VsLyHGMUzsFQoeKjf?=
 =?us-ascii?Q?pG6+KBjcw2u3VKfjW1iI3MuuRgwsIfAG8u1U17zSfa/cPvibIVXnkNbYr+12?=
 =?us-ascii?Q?A5a+R4YvBgvIfy+lkpXpVYIGzGAXrkw03cayN9hKO+mthDAzqtAp3+YeNQQE?=
 =?us-ascii?Q?nR18P0dCUIFtV0z2XIRo8Ue8UyQZNm2ZjdzGECWcfdHhUIl81AOSXMv1GvQY?=
 =?us-ascii?Q?x6nY2ECC1q8tgkb6++uKV5e8dIToNZvkxxI3BtxEGjE7ZPEvob3MIQbom+wR?=
 =?us-ascii?Q?qJRJTtOShepsoeVeDrS9X8pEtdXGreY/WDjIaEa0BOjZvuFfj9WK057kmm4c?=
 =?us-ascii?Q?RzXjnsbJa5RbGE+YGUIYWcNjvdxKHHCgY8qCR/qlznKUM4lXlNNUk+dZdq60?=
 =?us-ascii?Q?LMIJhJAjEIhwF2rzYT1mPcpW1ZzNfx+mRggmSIE0ZnIoMax3lNt/NYLiWdze?=
 =?us-ascii?Q?mD90AuROCme9H468Si+sgpsVbBSSImyulEwKjVAO3C6PetfqKd89ff4CBGUd?=
 =?us-ascii?Q?SI0WOSmL1WFJRbNBAUD3c2PGu2Grluv6vkJx6AgWoOKcSbvaMGYMA4ryG8Vw?=
 =?us-ascii?Q?AHlvjuLeQHhpxcsem/wzvCjVPlm0E+ZC2q0ibjZnwr/070unvu84sgmB9HHd?=
 =?us-ascii?Q?svwwyhORS9BtjNEN5Nbfef+UNdZ8T8bWPhO5DYdFCmDXaj4ccZ888am28PD9?=
 =?us-ascii?Q?ylw0+GoEFb1TqohcYHuLR5BaBgb3S3CtqFT9nNdLaA56zRlkgJUyBdNXxtqz?=
 =?us-ascii?Q?ubAR79y+udb4Hoqm+gRNOOXSoqXDwB4gvFmWYXEgztT/+alNfDF87Eh/iZbU?=
 =?us-ascii?Q?Gk90V0pBMR2GkND+EvMTt5PV?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bcc80.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 990f8327-4c32-4f56-93af-08dc7fdfa2f5
X-MS-Exchange-CrossTenant-AuthSource: PR3PR02MB6012.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 13:02:47.1518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8046

--g73rnwnqsob4jnl6
Content-Type: multipart/mixed; boundary="44ebpvkh4q256cwl"
Content-Disposition: inline


--44ebpvkh4q256cwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Niklas,

On 24/05/28 10:19pm, Niklas Cassel wrote:
> Hello Tim,
>=20
> On Tue, May 28, 2024 at 01:17:51PM -0600, Jens Axboe wrote:
> > (Adding Damien, he's the ATA guy these days - leaving the below intact)
> >=20
> > On 5/28/24 1:15 PM, Thomas Gleixner wrote:
> > > Tim!
> > >=20
> > > On Tue, May 28 2024 at 17:43, Tim Teichmann wrote:
> > >> On 24/05/27 07:17pm, Thomas Gleixner wrote:
> > >> I've just tested the fix you've provided in the previous email.
> > >> The exact patches are attached to the ticket in the archlinux bugtra=
cker[0].
> > >=20
> > > Thanks! I will write a proper changelog and ship it.
> > >=20
> > >> The error regarding CPU scheduling disappeared for both kernel verio=
ns[0].
> > >> However, the ATA bus error still occurs.
> > >>
> > >> Also, I suppose that the ATA bus error is the same as the previous o=
ne,
> > >> because the only value that changes in the exception message is SAct.
> > >>
> > >> This is the message of the ATA error before the patch:
> > >>
> > >>>> May 23 23:36:49 archlinux kernel: smpboot: x86: Booting SMP config=
uration:
> > >>>> May 23 23:36:49 archlinux kernel: .... node  #0, CPUs:      #2 #4 =
#6
> > >>>> May 23 23:36:49 archlinux kernel: __common_interrupt: 2.55 No irq =
handler for vector
> > >>>> May 23 23:36:49 archlinux kernel: __common_interrupt: 4.55 No irq =
handler for vector
> > >>>> May 23 23:36:49 archlinux kernel: __common_interrupt: 6.55 No irq =
handler for vector
> > >>>>
> > >>>> ATA stuff:
> > >>>>
> > >>>> May 23 23:36:59 archlinux kernel: ata2.00: exception Emask 0x10 SA=
ct 0x1fffe000 SErr 0x40d0002 action 0xe frozen
> > >>>
> > >>> That's probably just the fallout of the above.
> > >=20
> > > It's in reality not related and I saw some other AHCI fallout fly by.
> > >=20
> > >> And that's the message after the patch:
> > >>
> > >> [    4.877584] ata2.00: exception Emask 0x10 SAct 0x80000000 SErr 0x=
40d0002 action 0xe frozen
> > >>
> > >> The full dmesg outputs are in the attachments.
> > >=20
> > > Cc'ed the AHCI people and left the info around for them.
>=20
> We recently (kernel v6.9) enabled LPM for all AHCI controllers if:
> -The AHCI controller reports that it supports LPM, and
> -The drive reports that it supports LPM (DIPM), and
> -CONFIG_SATA_MOBILE_LPM_POLICY=3D3, and
> -The port is not defined as external in the per port PxCMD register, and
> -The port is not defined as hotplug capable in the per port PxCMD registe=
r.
>=20
> However, there appears to be some drives (usually cheap ones that we've n=
ever
> heard about) that reports that they support DIPM, but when actually turni=
ng
> it on, they stop working.
>=20
> Looking at the dmesg, you seem to have two SATA drives:
>=20
> > >> [    0.957220] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > >> [    0.957984] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > >> [    0.958027] ata3.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/1=
33
> > >> [    0.958069] ata2.00: ATA-11: Apacer AS340 120GB, AP612PE0, max UD=
MA/133
>=20
>=20
> ata3 (TOSHIBA HDWD110) appears to work correctly.
>=20
> ata2 (Apacer AS340 120GB) results in command timeouts and
> "a change in device presence has been detected" being set in PxSERR.DIAG.=
X.
>=20
> > >> [    2.964262] ata2.00: exception Emask 0x10 SAct 0x80 SErr 0x40d000=
2 action 0xe frozen
> > >> [    2.964274] ata2.00: irq_stat 0x00000040, connection status chang=
ed
> > >> [    2.964279] ata2: SError: { RecovComm PHYRdyChg CommWake 10B8B De=
vExch }
> > >> [    2.964288] ata2.00: failed command: READ FPDMA QUEUED
> > >> [    2.964291] ata2.00: cmd 60/08:38:80:ff:f1/00:00:0d:00:00/40 tag =
7 ncq dma 4096 in
> > >>                         res 40/00:00:00:00:00/00:00:00:00:00/00 Emas=
k 0x10 (ATA bus error)
> > >> [    2.964307] ata2.00: status: { DRDY }
> > >> [    2.964318] ata2: hard resetting link
>=20
>=20
> Could you please try the following patch (quirk):
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index c449d60d9bb9..24ebcad65b65 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4199,6 +4199,9 @@ static const struct ata_blacklist_entry ata_device_=
blacklist [] =3D {
>                                                 ATA_HORKAGE_ZERO_AFTER_TR=
IM |
>                                                 ATA_HORKAGE_NOLPM },
> =20
> +       /* Apacer models with LPM issues */
> +       { "Apacer AS340*",              NULL,   ATA_HORKAGE_NOLPM },
> +
>         /* These specific Samsung models/firmware-revs do not handle LPM =
well */
>         { "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM },
>         { "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM },
>=20
>=20
>=20
> Kind regards,
> Niklas

I've just tested the patch you've provided [0] and it works without
throwing ATA exceptions.

The full dmesg output is attached below.

Thank you,
Tim

[0]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issu=
es/56#note_188819

--44ebpvkh4q256cwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg_6.9.2-arch1-1.3.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 6.9.2-arch1-1.3 (linux@archlinux) (gcc (GCC) 1=
4.1.1 20240522, GNU ld (GNU Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Tue, 2=
8 May 2024 21:16:00 +0000
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-linux root=3DUUID=3D963d=
aeed-0888-4658-9f17-18bd343dfb2a rw zswap.enabled=3D0 rootfstype=3Dext4 log=
level=3D3 quiet
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009f7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bfdeffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bfdf0000-0x00000000bfdf2fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000bfdf3000-0x00000000bfdfffff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000bfe00000-0x00000000bfefffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000043effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. GA-78LMT-USB3 R2/GA-78LMT=
-USB3 R2, BIOS F1 11/08/2017
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3322.009 MHz processor
[    0.002928] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.002932] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.002938] last_pfn =3D 0x43f000 max_arch_pfn =3D 0x400000000
[    0.002947] total RAM covered: 3070M
[    0.003245] Found optimal setting for mtrr clean up
[    0.003246]  gran_size: 64K 	chunk_size: 4M 	num_reg: 3  	lose cover RAM=
: 0G
[    0.003251] MTRR map: 7 entries (4 fixed + 3 variable; max 21), built fr=
om 9 variable MTRRs
[    0.003253] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.004118] e820: update [mem 0xbfe00000-0xffffffff] usable =3D=3D> rese=
rved
[    0.004128] last_pfn =3D 0xbfdf0 max_arch_pfn =3D 0x400000000
[    0.007039] found SMP MP-table at [mem 0x000f5ea0-0x000f5eaf]
[    0.007060] Using GB pages for direct mapping
[    0.007180] RAMDISK: [mem 0x31c9f000-0x34e46fff]
[    0.007303] ACPI: Early table checksum verification disabled
[    0.007308] ACPI: RSDP 0x00000000000F78B0 000014 (v00 GBT   )
[    0.007312] ACPI: RSDT 0x00000000BFDF3000 000040 (v01 GBT    GBTUACPI 42=
302E31 GBTU 01010101)
[    0.007319] ACPI: FACP 0x00000000BFDF3080 000074 (v01 GBT    GBTUACPI 42=
302E31 GBTU 01010101)
[    0.007325] ACPI: DSDT 0x00000000BFDF3100 0069E7 (v01 GBT    GBTUACPI 00=
001000 MSFT 03000000)
[    0.007330] ACPI: FACS 0x00000000BFDF0000 000040
[    0.007334] ACPI: MSDM 0x00000000BFDF9BC0 000055 (v03 GBT    GBTUACPI 42=
302E31 GBTU 01010101)
[    0.007338] ACPI: HPET 0x00000000BFDF9C40 000038 (v01 GBT    GBTUACPI 42=
302E31 GBTU 00000098)
[    0.007342] ACPI: MCFG 0x00000000BFDF9C80 00003C (v01 GBT    GBTUACPI 42=
302E31 GBTU 01010101)
[    0.007346] ACPI: TAMG 0x00000000BFDF9CC0 000022 (v01 GBT    GBT   B0 54=
55312E BG?? 00000101)
[    0.007350] ACPI: APIC 0x00000000BFDF9B00 0000BC (v01 GBT    GBTUACPI 42=
302E31 GBTU 01010101)
[    0.007354] ACPI: SSDT 0x00000000BFDF9D60 001714 (v01 AMD    POWERNOW 00=
000001 AMD  00000001)
[    0.007358] ACPI: Reserving FACP table memory at [mem 0xbfdf3080-0xbfdf3=
0f3]
[    0.007359] ACPI: Reserving DSDT table memory at [mem 0xbfdf3100-0xbfdf9=
ae6]
[    0.007361] ACPI: Reserving FACS table memory at [mem 0xbfdf0000-0xbfdf0=
03f]
[    0.007362] ACPI: Reserving MSDM table memory at [mem 0xbfdf9bc0-0xbfdf9=
c14]
[    0.007364] ACPI: Reserving HPET table memory at [mem 0xbfdf9c40-0xbfdf9=
c77]
[    0.007365] ACPI: Reserving MCFG table memory at [mem 0xbfdf9c80-0xbfdf9=
cbb]
[    0.007366] ACPI: Reserving TAMG table memory at [mem 0xbfdf9cc0-0xbfdf9=
ce1]
[    0.007367] ACPI: Reserving APIC table memory at [mem 0xbfdf9b00-0xbfdf9=
bbb]
[    0.007368] ACPI: Reserving SSDT table memory at [mem 0xbfdf9d60-0xbfdfb=
473]
[    0.007432] No NUMA configuration found
[    0.007433] Faking a node at [mem 0x0000000000000000-0x000000043effffff]
[    0.007436] NODE_DATA(0) allocated [mem 0x43effb000-0x43effffff]
[    0.007477] Zone ranges:
[    0.007478]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.007480]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.007482]   Normal   [mem 0x0000000100000000-0x000000043effffff]
[    0.007484]   Device   empty
[    0.007485] Movable zone start for each node
[    0.007486] Early memory node ranges
[    0.007487]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.007488]   node   0: [mem 0x0000000000100000-0x00000000bfdeffff]
[    0.007490]   node   0: [mem 0x0000000100000000-0x000000043effffff]
[    0.007493] Initmem setup node 0 [mem 0x0000000000001000-0x000000043efff=
fff]
[    0.007499] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.007539] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.055138] On node 0, zone Normal: 528 pages in unavailable ranges
[    0.055214] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.055397] ACPI: PM-Timer IO Port: 0x4008
[    0.055409] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[    0.055411] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.055413] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.055414] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
[    0.055415] ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
[    0.055416] ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
[    0.055417] ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
[    0.055418] ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
[    0.055431] IOAPIC[0]: apic_id 2, version 33, address 0xfec00000, GSI 0-=
23
[    0.055434] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.055436] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.055441] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.055442] ACPI: HPET id: 0x10b9a201 base: 0xfed00000
[    0.055452] CPU topo: Max. logical packages:   1
[    0.055453] CPU topo: Max. logical dies:       1
[    0.055454] CPU topo: Max. dies per package:   1
[    0.055459] CPU topo: Max. threads per core:   1
[    0.055460] CPU topo: Num. cores per package:     8
[    0.055461] CPU topo: Num. threads per package:   8
[    0.055462] CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
[    0.055475] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.055477] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x0009ffff]
[    0.055478] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000effff]
[    0.055479] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0=
x000fffff]
[    0.055481] PM: hibernation: Registered nosave memory: [mem 0xbfdf0000-0=
xbfdf2fff]
[    0.055482] PM: hibernation: Registered nosave memory: [mem 0xbfdf3000-0=
xbfdfffff]
[    0.055483] PM: hibernation: Registered nosave memory: [mem 0xbfe00000-0=
xbfefffff]
[    0.055484] PM: hibernation: Registered nosave memory: [mem 0xbff00000-0=
xdfffffff]
[    0.055485] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0=
xefffffff]
[    0.055487] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0=
xfebfffff]
[    0.055488] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xffffffff]
[    0.055490] [mem 0xbff00000-0xdfffffff] available for PCI devices
[    0.055491] Booting paravirtualized kernel on bare hardware
[    0.055494] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 6370452778343963 ns
[    0.061413] setup_percpu: NR_CPUS:320 nr_cpumask_bits:8 nr_cpu_ids:8 nr_=
node_ids:1
[    0.062339] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
[    0.062348] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=3D1*2097152
[    0.062351] pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7=20
[    0.062373] Kernel command line: BOOT_IMAGE=3D/vmlinuz-linux root=3DUUID=
=3D963daeed-0888-4658-9f17-18bd343dfb2a rw zswap.enabled=3D0 rootfstype=3De=
xt4 loglevel=3D3 quiet
[    0.062455] Unknown kernel command line parameters "BOOT_IMAGE=3D/vmlinu=
z-linux", will be passed to user space.
[    0.065336] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)
[    0.066737] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)
[    0.066821] Fallback order for Node 0: 0=20
[    0.066827] Built 1 zonelists, mobility grouping on.  Total pages: 41239=
60
[    0.066829] Policy zone: Normal
[    0.067262] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.067268] software IO TLB: area num 8.
[    0.153647] Memory: 16301808K/16758328K available (18432K kernel code, 2=
164K rwdata, 13296K rodata, 3412K init, 3624K bss, 456260K reserved, 0K cma=
-reserved)
[    0.161802] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1
[    0.161996] ftrace: allocating 49852 entries in 195 pages
[    0.173225] ftrace: allocated 195 pages with 4 groups
[    0.173386] Dynamic Preempt: full
[    0.173613] rcu: Preemptible hierarchical RCU implementation.
[    0.173614] rcu: 	RCU restricting CPUs from NR_CPUS=3D320 to nr_cpu_ids=
=3D8.
[    0.173616] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.173617] 	Trampoline variant of Tasks RCU enabled.
[    0.173618] 	Rude variant of Tasks RCU enabled.
[    0.173619] 	Tracing variant of Tasks RCU enabled.
[    0.173620] rcu: RCU calculated value of scheduler-enlistment delay is 3=
0 jiffies.
[    0.173621] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8
[    0.173629] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjus=
t=3D1.
[    0.173631] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_=
adjust=3D1.
[    0.173633] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb=
_adjust=3D1.
[    0.179214] NR_IRQS: 20736, nr_irqs: 488, preallocated irqs: 16
[    0.179427] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.179520] kfence: initialized - using 2097152 bytes for 255 objects at=
 0x(____ptrval____)-0x(____ptrval____)
[    0.179595] spurious 8259A interrupt: IRQ7.
[    0.179615] Console: colour dummy device 80x25
[    0.179618] printk: legacy console [tty0] enabled
[    0.180017] ACPI: Core revision 20230628
[    0.180243] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484873504 ns
[    0.180277] APIC: Switch to symmetric I/O mode setup
[    0.180782] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.196930] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2fe2839811f, max_idle_ns: 440795276340 ns
[    0.196936] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 6646.85 BogoMIPS (lpj=3D11073363)
[    0.196960] LVT offset 1 assigned for vector 0xf9
[    0.196965] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.196967] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.196972] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.196974] Spectre V2 : Mitigation: Retpolines
[    0.196975] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.196976] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.196977] Spectre V2 : Enabling Speculation Barrier for firmware calls
[    0.196978] RETBleed: Mitigation: untrained return thunk
[    0.196980] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.196982] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl
[    0.196986] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.196988] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.196989] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.196991] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.196993] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes, using 'standard' format.
[    0.220801] Freeing SMP alternatives memory: 40K
[    0.220807] pid_max: default: 32768 minimum: 301
[    0.221538] LSM: initializing lsm=3Dcapability,landlock,lockdown,yama,bpf
[    0.222378] landlock: Up and running.
[    0.222380] Yama: becoming mindful.
[    0.222387] LSM support for eBPF active
[    0.222633] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)
[    0.222673] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)
[    0.230401] APIC calibration not consistent with PM-Timer: 0ms instead o=
f 100ms
[    0.230407] APIC delta adjusted to PM-Timer: 1257428 (1507)
[    0.230416] smpboot: CPU0: AMD FX(tm)-8300 Eight-Core Processor (family:=
 0x15, model: 0x2, stepping: 0x0)
[    0.230808] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.230814] ... version:                0
[    0.230815] ... bit width:              48
[    0.230816] ... generic registers:      6
[    0.230817] ... value mask:             0000ffffffffffff
[    0.230818] ... max period:             00007fffffffffff
[    0.230819] ... fixed-purpose events:   0
[    0.230820] ... event mask:             000000000000003f
[    0.230932] signal: max sigframe size: 1776
[    0.230983] rcu: Hierarchical SRCU implementation.
[    0.230985] rcu: 	Max phase no-delay instances is 1000.
[    0.233293] MCE: In-kernel MCE decoding enabled.
[    0.233373] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.233505] smp: Bringing up secondary CPUs ...
[    0.233600] smpboot: x86: Booting SMP configuration:
[    0.233600] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.000814] __common_interrupt: 1.55 No irq handler for vector
[    0.000814] __common_interrupt: 2.55 No irq handler for vector
[    0.000814] __common_interrupt: 3.55 No irq handler for vector
[    0.000814] __common_interrupt: 4.55 No irq handler for vector
[    0.000814] __common_interrupt: 5.55 No irq handler for vector
[    0.000814] __common_interrupt: 6.55 No irq handler for vector
[    0.000814] __common_interrupt: 7.55 No irq handler for vector
[    0.263642] smp: Brought up 1 node, 8 CPUs
[    0.263647] smpboot: Total of 8 processors activated (53173.81 BogoMIPS)
[    0.270270] devtmpfs: initialized
[    0.270315] x86/mm: Memory block size: 128MB
[    0.272131] ACPI: PM: Registering ACPI NVS region [mem 0xbfdf0000-0xbfdf=
2fff] (12288 bytes)
[    0.272131] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 6370867519511994 ns
[    0.272131] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)
[    0.272131] pinctrl core: initialized pinctrl subsystem
[    0.272131] PM: RTC time: 12:42:29, date: 2024-05-29
[    0.272188] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.272620] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic alloca=
tions
[    0.272907] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    0.273800] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    0.273814] audit: initializing netlink subsys (disabled)
[    0.273827] audit: type=3D2000 audit(1716986548.096:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.273827] thermal_sys: Registered thermal governor 'fair_share'
[    0.273827] thermal_sys: Registered thermal governor 'bang_bang'
[    0.273827] thermal_sys: Registered thermal governor 'step_wise'
[    0.273827] thermal_sys: Registered thermal governor 'user_space'
[    0.273827] thermal_sys: Registered thermal governor 'power_allocator'
[    0.273827] cpuidle: using governor ladder
[    0.273827] cpuidle: using governor menu
[    0.273827] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.274016] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for =
domain 0000 [bus 00-ff]
[    0.274021] PCI: ECAM [mem 0xe0000000-0xefffffff] reserved as E820 entry
[    0.274034] PCI: Using configuration type 1 for base access
[    0.274129] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.
[    0.277003] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.277003] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.277003] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.277003] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.277018] Demotion targets for Node 0: null
[    0.277135] fbcon: Taking over console
[    0.277135] ACPI: Added _OSI(Module Device)
[    0.277135] ACPI: Added _OSI(Processor Device)
[    0.277135] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.277135] ACPI: Added _OSI(Processor Aggregator Device)
[    0.281946] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.282248] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.282255] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.282262] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.282268] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.282281] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.282288] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.282294] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.282300] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.282313] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.282319] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.282325] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.282331] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.282343] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.282349] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.282355] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.282361] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.282374] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.282380] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.282386] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.282392] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.282405] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.282411] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.282417] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.282423] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.282435] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.282441] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.282447] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.282453] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.282465] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.282471] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.282477] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.282482] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.282495] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.282501] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.282507] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.282512] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.282525] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKA (20230628/dspkginit-438)
[    0.282531] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKB (20230628/dspkginit-438)
[    0.282536] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKC (20230628/dspkginit-438)
[    0.282542] ACPI Error: AE_NOT_FOUND, While resolving a named reference =
package element - LNKD (20230628/dspkginit-438)
[    0.287045] ACPI: _OSC evaluation for CPUs failed, trying _PDC
[    0.287206] ACPI: Interpreter enabled
[    0.287226] ACPI: PM: (supports S0 S3 S4 S5)
[    0.287228] ACPI: Using IOAPIC for interrupt routing
[    0.287550] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.287552] PCI: Using E820 reservations for host bridge windows
[    0.287705] ACPI: Enabled 5 GPEs in block 00 to 1F
[    0.294800] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.294808] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]
[    0.295182] PCI host bridge to bus 0000:00
[    0.295184] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.295187] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.295190] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dfff=
f window]
[    0.295192] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebffff=
f window]
[    0.295195] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.295212] pci 0000:00:00.0: [1022:9600] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.295224] pci 0000:00:00.0: [Firmware Bug]: BAR 3: invalid; can't size
[    0.295301] pci 0000:00:02.0: [1022:9603] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.295314] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.295318] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.295321] pci 0000:00:02.0:   bridge window [mem 0xfb000000-0xfcffffff]
[    0.295327] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xdfffffff=
 64bit pref]
[    0.295333] pci 0000:00:02.0: enabling Extended Tags
[    0.295361] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.295467] pci 0000:00:04.0: [1022:9604] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.295480] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.295484] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    0.295487] pci 0000:00:04.0:   bridge window [mem 0xfda00000-0xfdafffff]
[    0.295492] pci 0000:00:04.0:   bridge window [mem 0xfdf00000-0xfdffffff=
 64bit pref]
[    0.295498] pci 0000:00:04.0: enabling Extended Tags
[    0.295524] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.295624] pci 0000:00:06.0: [1022:9606] type 01 class 0x060400 PCIe Ro=
ot Port
[    0.295637] pci 0000:00:06.0: PCI bridge to [bus 03]
[    0.295641] pci 0000:00:06.0:   bridge window [io  0xc000-0xcfff]
[    0.295643] pci 0000:00:06.0:   bridge window [mem 0xfde00000-0xfdefffff]
[    0.295649] pci 0000:00:06.0:   bridge window [mem 0xfdd00000-0xfddfffff=
 64bit pref]
[    0.295655] pci 0000:00:06.0: enabling Extended Tags
[    0.295681] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.295804] pci 0000:00:11.0: [1002:4390] type 00 class 0x01018f convent=
ional PCI endpoint
[    0.295821] pci 0000:00:11.0: BAR 0 [io  0xff00-0xff07]
[    0.295830] pci 0000:00:11.0: BAR 1 [io  0xfe00-0xfe03]
[    0.295840] pci 0000:00:11.0: BAR 2 [io  0xfd00-0xfd07]
[    0.295849] pci 0000:00:11.0: BAR 3 [io  0xfc00-0xfc03]
[    0.295858] pci 0000:00:11.0: BAR 4 [io  0xfb00-0xfb0f]
[    0.295867] pci 0000:00:11.0: BAR 5 [mem 0xfe02f000-0xfe02f3ff]
[    0.295889] pci 0000:00:11.0: set SATA to AHCI mode
[    0.295993] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310 convent=
ional PCI endpoint
[    0.296010] pci 0000:00:12.0: BAR 0 [mem 0xfe02e000-0xfe02efff]
[    0.296140] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310 convent=
ional PCI endpoint
[    0.296157] pci 0000:00:12.1: BAR 0 [mem 0xfe02d000-0xfe02dfff]
[    0.296297] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320 convent=
ional PCI endpoint
[    0.296314] pci 0000:00:12.2: BAR 0 [mem 0xfe02c000-0xfe02c0ff]
[    0.296393] pci 0000:00:12.2: supports D1 D2
[    0.296395] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.296483] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310 convent=
ional PCI endpoint
[    0.296500] pci 0000:00:13.0: BAR 0 [mem 0xfe02b000-0xfe02bfff]
[    0.296627] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310 convent=
ional PCI endpoint
[    0.296643] pci 0000:00:13.1: BAR 0 [mem 0xfe02a000-0xfe02afff]
[    0.296776] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320 convent=
ional PCI endpoint
[    0.296793] pci 0000:00:13.2: BAR 0 [mem 0xfe029000-0xfe0290ff]
[    0.296872] pci 0000:00:13.2: supports D1 D2
[    0.296874] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.296974] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500 convent=
ional PCI endpoint
[    0.297129] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a convent=
ional PCI endpoint
[    0.297146] pci 0000:00:14.1: BAR 0 [io  0x0000-0x0007]
[    0.297155] pci 0000:00:14.1: BAR 1 [io  0x0000-0x0003]
[    0.297164] pci 0000:00:14.1: BAR 2 [io  0x0000-0x0007]
[    0.297173] pci 0000:00:14.1: BAR 3 [io  0x0000-0x0003]
[    0.297182] pci 0000:00:14.1: BAR 4 [io  0xfa00-0xfa0f]
[    0.297202] pci 0000:00:14.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
[    0.297204] pci 0000:00:14.1: BAR 1 [io  0x03f6]: legacy IDE quirk
[    0.297206] pci 0000:00:14.1: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
[    0.297207] pci 0000:00:14.1: BAR 3 [io  0x0376]: legacy IDE quirk
[    0.297315] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300 convent=
ional PCI endpoint
[    0.297336] pci 0000:00:14.2: BAR 0 [mem 0xfe024000-0xfe027fff 64bit]
[    0.297403] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.297482] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100 convent=
ional PCI endpoint
[    0.297648] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401 convent=
ional PCI bridge
[    0.297679] pci 0000:00:14.4: PCI bridge to [bus 04] (subtractive decode)
[    0.297685] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
[    0.297689] pci 0000:00:14.4:   bridge window [mem 0xfdc00000-0xfdcfffff]
[    0.297694] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff=
 pref]
[    0.297779] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310 convent=
ional PCI endpoint
[    0.297796] pci 0000:00:14.5: BAR 0 [mem 0xfe028000-0xfe028fff]
[    0.297926] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.297976] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.298023] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.298073] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.298121] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.298170] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000 convent=
ional PCI endpoint
[    0.298277] pci 0000:01:00.0: [10de:1c82] type 00 class 0x030000 PCIe Le=
gacy Endpoint
[    0.298291] pci 0000:01:00.0: BAR 0 [mem 0xfb000000-0xfbffffff]
[    0.298302] pci 0000:01:00.0: BAR 1 [mem 0xc0000000-0xcfffffff 64bit pre=
f]
[    0.298313] pci 0000:01:00.0: BAR 3 [mem 0xde000000-0xdfffffff 64bit pre=
f]
[    0.298320] pci 0000:01:00.0: BAR 5 [io  0xef00-0xef7f]
[    0.298328] pci 0000:01:00.0: ROM [mem 0x00000000-0x0007ffff pref]
[    0.298355] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.298444] pci 0000:01:00.0: 32.000 Gb/s available PCIe bandwidth, limi=
ted by 2.5 GT/s PCIe x16 link at 0000:00:02.0 (capable of 126.016 Gb/s with=
 8.0 GT/s PCIe x16 link)
[    0.298520] pci 0000:01:00.1: [10de:0fb9] type 00 class 0x040300 PCIe En=
dpoint
[    0.298533] pci 0000:01:00.1: BAR 0 [mem 0xfcffc000-0xfcffffff]
[    0.298683] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.298724] pci 0000:02:00.0: [1106:3483] type 00 class 0x0c0330 PCIe En=
dpoint
[    0.298739] pci 0000:02:00.0: BAR 0 [mem 0xfdaff000-0xfdafffff 64bit]
[    0.298800] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.298870] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.298918] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000 PCIe En=
dpoint
[    0.298934] pci 0000:03:00.0: BAR 0 [io  0xce00-0xceff]
[    0.298954] pci 0000:03:00.0: BAR 2 [mem 0xfdeff000-0xfdefffff 64bit]
[    0.298967] pci 0000:03:00.0: BAR 4 [mem 0xfddfc000-0xfddfffff 64bit pre=
f]
[    0.299049] pci 0000:03:00.0: supports D1 D2
[    0.299051] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.299175] pci 0000:00:06.0: PCI bridge to [bus 03]
[    0.299190] pci_bus 0000:04: extended config space not accessible
[    0.299252] pci 0000:00:14.4: PCI bridge to [bus 04] (subtractive decode)
[    0.299261] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 window]=
 (subtractive decode)
[    0.299263] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window]=
 (subtractive decode)
[    0.299265] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000dffff=
 window] (subtractive decode)
[    0.299267] pci 0000:00:14.4:   bridge window [mem 0xc0000000-0xfebfffff=
 window] (subtractive decode)
[    0.299551] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.299553] ACPI: PCI: Interrupt link LNKA disabled
[    0.299609] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.299611] ACPI: PCI: Interrupt link LNKB disabled
[    0.299666] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.299668] ACPI: PCI: Interrupt link LNKC disabled
[    0.299722] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.299723] ACPI: PCI: Interrupt link LNKD disabled
[    0.299777] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.299779] ACPI: PCI: Interrupt link LNKE disabled
[    0.299832] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.299834] ACPI: PCI: Interrupt link LNKF disabled
[    0.299887] ACPI: PCI: Interrupt link LNK0 configured for IRQ 0
[    0.299889] ACPI: PCI: Interrupt link LNK0 disabled
[    0.299942] ACPI: PCI: Interrupt link LNK1 configured for IRQ 0
[    0.299944] ACPI: PCI: Interrupt link LNK1 disabled
[    0.300718] iommu: Default domain type: Translated
[    0.300718] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.300718] SCSI subsystem initialized
[    0.300718] libata version 3.00 loaded.
[    0.300718] ACPI: bus type USB registered
[    0.300718] usbcore: registered new interface driver usbfs
[    0.300718] usbcore: registered new interface driver hub
[    0.300718] usbcore: registered new device driver usb
[    0.300718] EDAC MC: Ver: 3.0.0
[    0.300718] NetLabel: Initializing
[    0.300718] NetLabel:  domain hash size =3D 128
[    0.300718] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.300718] NetLabel:  unlabeled traffic allowed by default
[    0.300718] mctp: management component transport protocol core
[    0.300718] NET: Registered PF_MCTP protocol family
[    0.300718] PCI: Using ACPI for IRQ routing
[    0.310072] PCI: pci_cache_line_size set to 64 bytes
[    0.310124] e820: reserve RAM buffer [mem 0x0009f800-0x0009ffff]
[    0.310127] e820: reserve RAM buffer [mem 0xbfdf0000-0xbfffffff]
[    0.310128] e820: reserve RAM buffer [mem 0x43f000000-0x43fffffff]
[    0.310315] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.310315] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.310315] pci 0000:01:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    0.310315] vgaarb: loaded
[    0.310317] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.310317] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
[    0.313604] clocksource: Switched to clocksource tsc-early
[    0.313620] VFS: Disk quotas dquot_6.6.0
[    0.313620] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.313620] pnp: PnP ACPI init
[    0.313620] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    0.313620] system 00:00: [io  0x0220-0x0225] has been reserved
[    0.313620] system 00:00: [io  0x0290-0x0294] has been reserved
[    0.314919] system 00:01: [io  0x4100-0x411f] has been reserved
[    0.314927] system 00:01: [io  0x0228-0x022f] has been reserved
[    0.314929] system 00:01: [io  0x040b] has been reserved
[    0.314931] system 00:01: [io  0x04d6] has been reserved
[    0.314934] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.314936] system 00:01: [io  0x0c14] has been reserved
[    0.314938] system 00:01: [io  0x0c50-0x0c52] has been reserved
[    0.314940] system 00:01: [io  0x0c6c-0x0c6d] has been reserved
[    0.314941] system 00:01: [io  0x0c6f] has been reserved
[    0.314943] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    0.314945] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    0.314947] system 00:01: [io  0x0cd4-0x0cdf] has been reserved
[    0.314949] system 00:01: [io  0x4000-0x40fe] has been reserved
[    0.314951] system 00:01: [io  0x4210-0x4217] has been reserved
[    0.314952] system 00:01: [io  0x0b00-0x0b0f] has been reserved
[    0.314954] system 00:01: [io  0x0b10-0x0b1f] has been reserved
[    0.314956] system 00:01: [io  0x0b20-0x0b3f] has been reserved
[    0.314958] system 00:01: [mem 0x00000000-0x00000fff window] could not b=
e reserved
[    0.314961] system 00:01: [mem 0xfee00400-0xfee00fff window] has been re=
served
[    0.315981] system 00:05: [mem 0xe0000000-0xefffffff] has been reserved
[    0.316207] pnp 00:06: disabling [mem 0x000ce600-0x000cffff] because it =
overlaps 0000:01:00.0 BAR 6 [mem 0x000c0000-0x000dffff]
[    0.316230] system 00:06: [mem 0x000f0000-0x000f7fff] could not be reser=
ved
[    0.316232] system 00:06: [mem 0x000f8000-0x000fbfff] could not be reser=
ved
[    0.316235] system 00:06: [mem 0x000fc000-0x000fffff] could not be reser=
ved
[    0.316237] system 00:06: [mem 0xbfdf0000-0xbfdfffff] could not be reser=
ved
[    0.316239] system 00:06: [mem 0xffff0000-0xffffffff] has been reserved
[    0.316241] system 00:06: [mem 0x00000000-0x0009ffff] could not be reser=
ved
[    0.316243] system 00:06: [mem 0x00100000-0xbfdeffff] could not be reser=
ved
[    0.316246] system 00:06: [mem 0xbfe00000-0xbfefffff] has been reserved
[    0.316248] system 00:06: [mem 0xbff00000-0xbfffffff] could not be reser=
ved
[    0.316250] system 00:06: [mem 0xfec00000-0xfec00fff] could not be reser=
ved
[    0.316252] system 00:06: [mem 0xfee00000-0xfee00fff] could not be reser=
ved
[    0.316254] system 00:06: [mem 0xfff80000-0xfffeffff] has been reserved
[    0.316278] pnp: PnP ACPI: found 7 devices
[    0.322952] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.323236] NET: Registered PF_INET protocol family
[    0.323560] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    0.341101] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)
[    0.341146] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)
[    0.341306] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    0.341785] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes,=
 linear)
[    0.342107] TCP: Hash tables configured (established 131072 bind 65536)
[    0.342329] MPTCP token hash table entries: 16384 (order: 6, 393216 byte=
s, linear)
[    0.342432] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.342495] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, l=
inear)
[    0.342592] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.342609] NET: Registered PF_XDP protocol family
[    0.342625] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.342634] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.342638] pci 0000:00:02.0:   bridge window [mem 0xfb000000-0xfcffffff]
[    0.342641] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xdfffffff=
 64bit pref]
[    0.342645] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.342648] pci 0000:00:04.0:   bridge window [io  0xd000-0xdfff]
[    0.342651] pci 0000:00:04.0:   bridge window [mem 0xfda00000-0xfdafffff]
[    0.342653] pci 0000:00:04.0:   bridge window [mem 0xfdf00000-0xfdffffff=
 64bit pref]
[    0.342657] pci 0000:00:06.0: PCI bridge to [bus 03]
[    0.342659] pci 0000:00:06.0:   bridge window [io  0xc000-0xcfff]
[    0.342662] pci 0000:00:06.0:   bridge window [mem 0xfde00000-0xfdefffff]
[    0.342665] pci 0000:00:06.0:   bridge window [mem 0xfdd00000-0xfddfffff=
 64bit pref]
[    0.342669] pci 0000:00:14.4: PCI bridge to [bus 04]
[    0.342672] pci 0000:00:14.4:   bridge window [io  0xb000-0xbfff]
[    0.342677] pci 0000:00:14.4:   bridge window [mem 0xfdc00000-0xfdcfffff]
[    0.342681] pci 0000:00:14.4:   bridge window [mem 0xfdb00000-0xfdbfffff=
 pref]
[    0.342688] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.342691] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.342693] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000dffff windo=
w]
[    0.342695] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff windo=
w]
[    0.342697] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.342699] pci_bus 0000:01: resource 1 [mem 0xfb000000-0xfcffffff]
[    0.342701] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xdfffffff 64bit=
 pref]
[    0.342703] pci_bus 0000:02: resource 0 [io  0xd000-0xdfff]
[    0.342705] pci_bus 0000:02: resource 1 [mem 0xfda00000-0xfdafffff]
[    0.342707] pci_bus 0000:02: resource 2 [mem 0xfdf00000-0xfdffffff 64bit=
 pref]
[    0.342709] pci_bus 0000:03: resource 0 [io  0xc000-0xcfff]
[    0.342711] pci_bus 0000:03: resource 1 [mem 0xfde00000-0xfdefffff]
[    0.342713] pci_bus 0000:03: resource 2 [mem 0xfdd00000-0xfddfffff 64bit=
 pref]
[    0.342715] pci_bus 0000:04: resource 0 [io  0xb000-0xbfff]
[    0.342716] pci_bus 0000:04: resource 1 [mem 0xfdc00000-0xfdcfffff]
[    0.342718] pci_bus 0000:04: resource 2 [mem 0xfdb00000-0xfdbfffff pref]
[    0.342720] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7 window]
[    0.342722] pci_bus 0000:04: resource 5 [io  0x0d00-0xffff window]
[    0.342724] pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000dffff windo=
w]
[    0.342725] pci_bus 0000:04: resource 7 [mem 0xc0000000-0xfebfffff windo=
w]
[    0.361533] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x730 took 183=
01 usecs
[    0.378188] pci 0000:00:12.1: quirk_usb_early_handoff+0x0/0x730 took 162=
51 usecs
[    0.394839] pci 0000:00:13.0: quirk_usb_early_handoff+0x0/0x730 took 160=
52 usecs
[    0.411492] pci 0000:00:13.1: quirk_usb_early_handoff+0x0/0x730 took 162=
52 usecs
[    0.428146] pci 0000:00:14.5: quirk_usb_early_handoff+0x0/0x730 took 160=
44 usecs
[    0.428177] pci 0000:01:00.1: extending delay after power-on from D3hot =
to 20 msec
[    0.428212] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.428421] PCI: CLS 64 bytes, default 64
[    0.428434] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.428436] software IO TLB: mapped [mem 0x00000000bbdf0000-0x00000000bf=
df0000] (64MB)
[    0.428477] LVT offset 0 assigned for vector 0x400
[    0.428514] Trying to unpack rootfs image as initramfs...
[    0.433810] perf: AMD IBS detected (0x000000ff)
[    0.435368] Initialise system trusted keyrings
[    0.435382] Key type blacklist registered
[    0.435423] workingset: timestamp_bits=3D41 max_order=3D22 bucket_order=
=3D0
[    0.435432] zbud: loaded
[    0.435825] fuse: init (API version 7.40)
[    0.436328] integrity: Platform Keyring initialized
[    0.436335] integrity: Machine keyring initialized
[    0.451147] Key type asymmetric registered
[    0.451149] Asymmetric key parser 'x509' registered
[    0.451237] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 246)
[    0.451317] io scheduler mq-deadline registered
[    0.451320] io scheduler kyber registered
[    0.451386] io scheduler bfq registered
[    0.452277] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.452401] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input0
[    0.452438] ACPI: button: Power Button [PWRB]
[    0.452491] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input1
[    0.455780] ACPI: button: Power Button [PWRF]
[    0.455827] ACPI: \_PR_.C000: Found 2 idle states
[    0.455903] ACPI: \_PR_.C001: Found 2 idle states
[    0.455974] ACPI: \_PR_.C002: Found 2 idle states
[    0.456038] ACPI: \_PR_.C003: Found 2 idle states
[    0.456103] ACPI: \_PR_.C004: Found 2 idle states
[    0.456167] ACPI: \_PR_.C005: Found 2 idle states
[    0.456230] ACPI: \_PR_.C006: Found 2 idle states
[    0.456293] ACPI: \_PR_.C007: Found 2 idle states
[    0.456574] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.456760] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[    0.459791] Non-volatile memory driver v1.3
[    0.459793] Linux agpgart interface v0.103
[    0.459841] ACPI: bus type drm_connector registered
[    0.460708] ahci 0000:00:11.0: version 3.0
[    0.460951] ahci 0000:00:11.0: AHCI vers 0001.0100, 32 command slots, 3 =
Gbps, SATA mode
[    0.460955] ahci 0000:00:11.0: 4/4 ports implemented (port mask 0xf)
[    0.460958] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp=
 pio slum part ccc=20
[    0.461546] scsi host0: ahci
[    0.461736] scsi host1: ahci
[    0.461867] scsi host2: ahci
[    0.461987] scsi host3: ahci
[    0.462034] ata1: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f10=
0 irq 22 lpm-pol 3
[    0.462037] ata2: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f18=
0 irq 22 lpm-pol 3
[    0.462040] ata3: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f20=
0 irq 22 lpm-pol 3
[    0.462043] ata4: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f28=
0 irq 22 lpm-pol 3
[    0.462257] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    0.462263] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus =
number 1
[    0.462305] ohci-pci 0000:00:12.0: irq 16, io mem 0xfe02e000
[    0.520463] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001, bcdDevice=3D 6.09
[    0.520470] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.520473] usb usb1: Product: OHCI PCI host controller
[    0.520475] usb usb1: Manufacturer: Linux 6.9.2-arch1-1.3 ohci_hcd
[    0.520477] usb usb1: SerialNumber: 0000:00:12.0
[    0.520657] hub 1-0:1.0: USB hub found
[    0.520669] hub 1-0:1.0: 3 ports detected
[    0.520900] ehci-pci 0000:00:12.2: EHCI Host Controller
[    0.520907] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus =
number 2
[    0.520912] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[    0.520923] ehci-pci 0000:00:12.2: debug port 1
[    0.520989] ehci-pci 0000:00:12.2: irq 17, io mem 0xfe02c000
[    0.528005] Freeing initrd memory: 50848K
[    0.533015] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    0.533088] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.09
[    0.533091] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.533094] usb usb2: Product: EHCI Host Controller
[    0.533096] usb usb2: Manufacturer: Linux 6.9.2-arch1-1.3 ehci_hcd
[    0.533097] usb usb2: SerialNumber: 0000:00:12.2
[    0.533252] hub 2-0:1.0: USB hub found
[    0.533261] hub 2-0:1.0: 6 ports detected
[    0.599674] hub 1-0:1.0: USB hub found
[    0.599686] hub 1-0:1.0: 3 ports detected
[    0.599839] ehci-pci 0000:00:13.2: EHCI Host Controller
[    0.599845] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus =
number 3
[    0.599849] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 E=
HCI dummy qh workaround
[    0.599866] ehci-pci 0000:00:13.2: debug port 1
[    0.599919] ehci-pci 0000:00:13.2: irq 19, io mem 0xfe029000
[    0.612952] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    0.613009] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.09
[    0.613013] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.613015] usb usb3: Product: EHCI Host Controller
[    0.613017] usb usb3: Manufacturer: Linux 6.9.2-arch1-1.3 ehci_hcd
[    0.613019] usb usb3: SerialNumber: 0000:00:13.2
[    0.613140] hub 3-0:1.0: USB hub found
[    0.613148] hub 3-0:1.0: 6 ports detected
[    0.613330] ohci-pci 0000:00:12.1: OHCI PCI host controller
[    0.613334] ohci-pci 0000:00:12.1: new USB bus registered, assigned bus =
number 4
[    0.613352] ohci-pci 0000:00:12.1: irq 16, io mem 0xfe02d000
[    0.673662] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001, bcdDevice=3D 6.09
[    0.673667] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.673669] usb usb4: Product: OHCI PCI host controller
[    0.673671] usb usb4: Manufacturer: Linux 6.9.2-arch1-1.3 ohci_hcd
[    0.673673] usb usb4: SerialNumber: 0000:00:12.1
[    0.673843] hub 4-0:1.0: USB hub found
[    0.673854] hub 4-0:1.0: 3 ports detected
[    0.674209] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    0.674217] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus =
number 5
[    0.674260] ohci-pci 0000:00:13.0: irq 18, io mem 0xfe02b000
[    0.733607] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001, bcdDevice=3D 6.09
[    0.733611] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.733614] usb usb5: Product: OHCI PCI host controller
[    0.733616] usb usb5: Manufacturer: Linux 6.9.2-arch1-1.3 ohci_hcd
[    0.733617] usb usb5: SerialNumber: 0000:00:13.0
[    0.733795] hub 5-0:1.0: USB hub found
[    0.733805] hub 5-0:1.0: 3 ports detected
[    0.734126] ohci-pci 0000:00:13.1: OHCI PCI host controller
[    0.734132] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus =
number 6
[    0.734155] ohci-pci 0000:00:13.1: irq 18, io mem 0xfe02a000
[    0.777835] ata4: SATA link down (SStatus 0 SControl 300)
[    0.778006] ata1: SATA link down (SStatus 0 SControl 300)
[    0.784485] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    0.793557] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001, bcdDevice=3D 6.09
[    0.793561] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.793563] usb usb6: Product: OHCI PCI host controller
[    0.793565] usb usb6: Manufacturer: Linux 6.9.2-arch1-1.3 ohci_hcd
[    0.793566] usb usb6: SerialNumber: 0000:00:13.1
[    0.793784] hub 6-0:1.0: USB hub found
[    0.793794] hub 6-0:1.0: 3 ports detected
[    0.794124] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    0.794130] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus =
number 7
[    0.794149] ohci-pci 0000:00:14.5: irq 18, io mem 0xfe028000
[    0.853510] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001, bcdDevice=3D 6.09
[    0.853514] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.853516] usb usb7: Product: OHCI PCI host controller
[    0.853518] usb usb7: Manufacturer: Linux 6.9.2-arch1-1.3 ohci_hcd
[    0.853519] usb usb7: SerialNumber: 0000:00:14.5
[    0.853737] hub 7-0:1.0: USB hub found
[    0.853747] hub 7-0:1.0: 2 ports detected
[    0.853995] usbcore: registered new interface driver usbserial_generic
[    0.854003] usbserial: USB Serial support registered for generic
[    0.854106] rtc_cmos 00:02: RTC can wake from S4
[    0.854346] rtc_cmos 00:02: registered as rtc0
[    0.854374] rtc_cmos 00:02: setting system clock to 2024-05-29T12:42:30 =
UTC (1716986550)
[    0.854408] rtc_cmos 00:02: alarms up to one month, 242 bytes nvram, hpe=
t irqs
[    0.854453] amd_pstate: the _CPC object is not present in SBIOS or ACPI =
disabled
[    0.854657] ledtrig-cpu: registered to indicate activity on CPUs
[    0.855141] [drm] Initialized simpledrm 1.0.0 20200625 for simple-frameb=
uffer.0 on minor 0
[    0.860055] Console: switching to colour frame buffer device 160x64
[    0.863471] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledr=
mdrmfb frame buffer device
[    0.863541] hid: raw HID events driver (C) Jiri Kosina
[    0.863645] drop_monitor: Initializing network drop monitor service
[    0.863986] NET: Registered PF_INET6 protocol family
[    0.871573] Segment Routing with IPv6
[    0.871576] RPL Segment Routing with IPv6
[    0.871596] In-situ OAM (IOAM) with IPv6
[    0.871637] NET: Registered PF_PACKET protocol family
[    0.871698] x86/pm: family 0x15 cpu detected, MSR saving is needed durin=
g suspending.
[    0.872216] microcode: Current revision: 0x06000852
[    0.872218] microcode: Updated early from: 0x06000822
[    0.872363] IPI shorthand broadcast: enabled
[    0.875084] sched_clock: Marking stable (875210984, -2518685)->(17777225=
56, -905030257)
[    0.875272] Timer migration: 1 hierarchy levels; 8 children per group; 1=
 crossnode level
[    0.875373] registered taskstats version 1
[    0.875705] Loading compiled-in X.509 certificates
[    0.880257] Loaded X.509 cert 'Build time autogenerated kernel key: 7925=
80fa945f304d2a9a419b9cee8195831e651e'
[    0.882915] Key type .fscrypt registered
[    0.882917] Key type fscrypt-provisioning registered
[    0.883423] PM:   Magic number: 8:131:735
[    0.887139] RAS: Correctable Errors collector initialized.
[    0.900662] clk: Disabling unused clocks
[    0.900666] PM: genpd: Disabling unused power domains
[    0.932113] usb 2-1: New USB device found, idVendor=3D0bda, idProduct=3D=
b812, bcdDevice=3D 2.10
[    0.932119] usb 2-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    0.932121] usb 2-1: Product: USB3.0 802.11ac 1200M Adapter
[    0.932123] usb 2-1: Manufacturer: Realtek
[    0.932124] usb 2-1: SerialNumber: 123456
[    0.941464] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    0.942251] ata3.00: ATA-8: TOSHIBA HDWD110, MS2OA8J0, max UDMA/133
[    0.942490] ata3.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32),=
 AA
[    0.943452] ata3.00: configured for UDMA/133
[    0.944601] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    0.944732] ata2.00: LPM support broken, forcing max_power
[    0.944760] ata2.00: ATA-11: Apacer AS340 120GB, AP612PE0, max UDMA/133
[    0.944790] ata2.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 32), =
AA
[    0.945126] ata2.00: LPM support broken, forcing max_power
[    0.945429] ata2.00: configured for UDMA/133
[    0.958193] scsi 1:0:0:0: Direct-Access     ATA      Apacer AS340 120 2P=
E0 PQ: 0 ANSI: 5
[    0.958598] sd 1:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB=
/112 GiB)
[    0.958602] scsi 2:0:0:0: Direct-Access     ATA      TOSHIBA HDWD110  A8=
J0 PQ: 0 ANSI: 5
[    0.958611] sd 1:0:0:0: [sda] Write Protect is off
[    0.958614] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.958630] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.958661] sd 1:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    0.958942] sd 2:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 =
TB/932 GiB)
[    0.958945] sd 2:0:0:0: [sdb] 4096-byte physical blocks
[    0.958956] sd 2:0:0:0: [sdb] Write Protect is off
[    0.958958] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    0.958977] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    0.959011] sd 2:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
[    0.959334]  sda: sda1 sda2
[    0.959434] sd 1:0:0:0: [sda] Attached SCSI disk
[    0.985590]  sdb: sdb1 sdb2
[    0.985834] sd 2:0:0:0: [sdb] Attached SCSI disk
[    0.987971] Freeing unused decrypted memory: 2028K
[    0.988653] Freeing unused kernel image (initmem) memory: 3412K
[    0.988657] Write protecting the kernel read-only data: 32768k
[    0.989141] Freeing unused kernel image (rodata/data gap) memory: 1040K
[    1.032417] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.032421] rodata_test: all tests were successful
[    1.032425] Run /init as init process
[    1.032427]   with arguments:
[    1.032428]     /init
[    1.032429]   with environment:
[    1.032430]     HOME=3D/
[    1.032431]     TERM=3Dlinux
[    1.032432]     BOOT_IMAGE=3D/vmlinuz-linux
[    1.200858] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    1.200869] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus =
number 8
[    1.200961] xhci_hcd 0000:02:00.0: hcc params 0x002841eb hci version 0x1=
00 quirks 0x0000000000000890
[    1.201144] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    1.201149] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus =
number 9
[    1.201153] xhci_hcd 0000:02:00.0: Host supports USB 3.0 SuperSpeed
[    1.201247] scsi host4: pata_atiixp
[    1.201335] usb usb8: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.09
[    1.201339] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.201342] usb usb8: Product: xHCI Host Controller
[    1.201358] usb usb8: Manufacturer: Linux 6.9.2-arch1-1.3 xhci-hcd
[    1.201361] usb usb8: SerialNumber: 0000:02:00.0
[    1.201406] scsi host5: pata_atiixp
[    1.201452] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfa00 irq=
 14 lpm-pol 0
[    1.201455] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfa08 irq=
 15 lpm-pol 0
[    1.201679] hub 8-0:1.0: USB hub found
[    1.201691] hub 8-0:1.0: 1 port detected
[    1.201851] usb usb9: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.09
[    1.201856] usb usb9: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.201859] usb usb9: Product: xHCI Host Controller
[    1.201861] usb usb9: Manufacturer: Linux 6.9.2-arch1-1.3 xhci-hcd
[    1.201863] usb usb9: SerialNumber: 0000:02:00.0
[    1.202220] hub 9-0:1.0: USB hub found
[    1.202234] hub 9-0:1.0: 4 ports detected
[    1.267571] usb 1-3: new low-speed USB device number 2 using ohci-pci
[    1.454222] usb 8-1: new high-speed USB device number 2 using xhci_hcd
[    1.457506] tsc: Refined TSC clocksource calibration: 3322.063 MHz
[    1.457523] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2fe=
2b689782, max_idle_ns: 440795272807 ns
[    1.457602] clocksource: Switched to clocksource tsc
[    1.457630] usb 1-3: New USB device found, idVendor=3D0c45, idProduct=3D=
7603, bcdDevice=3D 1.06
[    1.457636] usb 1-3: New USB device strings: Mfr=3D0, Product=3D2, Seria=
lNumber=3D0
[    1.457639] usb 1-3: Product: USB Keyboard
[    1.481139] usbcore: registered new interface driver usbhid
[    1.481142] usbhid: USB HID core driver
[    1.486931] input: USB Keyboard as /devices/pci0000:00/0000:00:12.0/usb1=
/1-3/1-3:1.0/0003:0C45:7603.0001/input/input2
[    1.541271] hid-generic 0003:0C45:7603.0001: input,hidraw0: USB HID v1.1=
1 Keyboard [USB Keyboard] on usb-0000:00:12.0-3/input0
[    1.541717] input: USB Keyboard Consumer Control as /devices/pci0000:00/=
0000:00:12.0/usb1/1-3/1-3:1.1/0003:0C45:7603.0002/input/input3
[    1.595598] usb 8-1: New USB device found, idVendor=3D2109, idProduct=3D=
3431, bcdDevice=3D 4.20
[    1.595602] usb 8-1: New USB device strings: Mfr=3D0, Product=3D1, Seria=
lNumber=3D0
[    1.595604] usb 8-1: Product: USB2.0 Hub
[    1.596308] hub 8-1:1.0: USB hub found
[    1.596496] hub 8-1:1.0: 4 ports detected
[    1.597725] input: USB Keyboard System Control as /devices/pci0000:00/00=
00:00:12.0/usb1/1-3/1-3:1.1/0003:0C45:7603.0002/input/input4
[    1.597805] input: USB Keyboard as /devices/pci0000:00/0000:00:12.0/usb1=
/1-3/1-3:1.1/0003:0C45:7603.0002/input/input6
[    1.597946] hid-generic 0003:0C45:7603.0002: input,hiddev96,hidraw1: USB=
 HID v1.11 Keyboard [USB Keyboard] on usb-0000:00:12.0-3/input1
[    2.087564] usb 4-1: new full-speed USB device number 2 using ohci-pci
[    2.282353] usb 4-1: New USB device found, idVendor=3D04d9, idProduct=3D=
a088, bcdDevice=3D 1.00
[    2.282365] usb 4-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    2.282370] usb 4-1: Product: USB Gaming Mouse
[    2.282375] usb 4-1: Manufacturer: RH
[    2.289761] input: RH USB Gaming Mouse as /devices/pci0000:00/0000:00:12=
=2E1/usb4/4-1/4-1:1.0/0003:04D9:A088.0003/input/input7
[    2.344621] hid-generic 0003:04D9:A088.0003: input,hidraw2: USB HID v1.1=
0 Keyboard [RH USB Gaming Mouse] on usb-0000:00:12.1-1/input0
[    2.352021] input: RH USB Gaming Mouse as /devices/pci0000:00/0000:00:12=
=2E1/usb4/4-1/4-1:1.1/0003:04D9:A088.0004/input/input8
[    2.352086] input: RH USB Gaming Mouse System Control as /devices/pci000=
0:00/0000:00:12.1/usb4/4-1/4-1:1.1/0003:04D9:A088.0004/input/input9
[    2.407892] input: RH USB Gaming Mouse Consumer Control as /devices/pci0=
000:00/0000:00:12.1/usb4/4-1/4-1:1.1/0003:04D9:A088.0004/input/input10
[    2.408041] hid-generic 0003:04D9:A088.0004: input,hiddev97,hidraw3: USB=
 HID v1.10 Mouse [RH USB Gaming Mouse] on usb-0000:00:12.1-1/input1
[    2.411712] hid-generic 0003:04D9:A088.0005: hiddev98,hidraw4: USB HID v=
1.10 Device [RH USB Gaming Mouse] on usb-0000:00:12.1-1/input2
[    3.035241] EXT4-fs (sda2): mounted filesystem 963daeed-0888-4658-9f17-1=
8bd343dfb2a r/w with ordered data mode. Quota mode: none.
[    3.204415] systemd[1]: systemd 255.7-1-arch running in system mode (+PA=
M +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +=
ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LI=
BFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZST=
D +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=3Dunified)
[    3.204423] systemd[1]: Detected architecture x86-64.
[    3.704252] systemd[1]: bpf-lsm: LSM BPF program attached
[    3.755371] systemd-fstab-generator[269]: Mount point  is not a valid pa=
th, ignoring.
[    3.755953] systemd-fstab-generator[269]: Mount point  is not a valid pa=
th, ignoring.
[    4.457554] random: crng init done
[    4.472946] zram: Added device: zram0
[    4.637985] systemd[1]: Queued start job for default target Graphical In=
terface.
[    4.678959] systemd[1]: Created slice Slice /system/dirmngr.
[    4.679369] systemd[1]: Created slice Slice /system/getty.
[    4.679736] systemd[1]: Created slice Slice /system/gpg-agent.
[    4.680110] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    4.680482] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    4.680878] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    4.681254] systemd[1]: Created slice Slice /system/keyboxd.
[    4.681618] systemd[1]: Created slice Slice /system/modprobe.
[    4.681937] systemd[1]: Created slice Slice /system/systemd-fsck.
[    4.682266] systemd[1]: Created slice Slice /system/systemd-zram-setup.
[    4.682496] systemd[1]: Created slice User and Session Slice.
[    4.682557] systemd[1]: Started Dispatch Password Requests to Console Di=
rectory Watch.
[    4.682603] systemd[1]: Started Forward Password Requests to Wall Direct=
ory Watch.
[    4.682749] systemd[1]: Set up automount Arbitrary Executable File Forma=
ts File System Automount Point.
[    4.682768] systemd[1]: Expecting device /dev/disk/by-uuid/03ce297b-4be8=
-4886-953d-2d2cc4bd0862...
[    4.682776] systemd[1]: Expecting device /dev/disk/by-uuid/6BB1-1CFA...
[    4.682783] systemd[1]: Expecting device /dev/zram0...
[    4.682795] systemd[1]: Reached target Local Encrypted Volumes.
[    4.682813] systemd[1]: Reached target Local Integrity Protected Volumes.
[    4.682837] systemd[1]: Reached target Path Units.
[    4.682851] systemd[1]: Reached target Remote File Systems.
[    4.682861] systemd[1]: Reached target Slice Units.
[    4.682890] systemd[1]: Reached target Local Verity Protected Volumes.
[    4.682963] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    4.683296] systemd[1]: Listening on LVM2 poll daemon socket.
[    4.684820] systemd[1]: Listening on Process Core Dump Socket.
[    4.684936] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.685041] systemd[1]: Listening on Journal Socket.
[    4.685173] systemd[1]: Listening on Network Service Netlink Socket.
[    4.685190] systemd[1]: TPM2 PCR Extension (Varlink) was skipped because=
 of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    4.685489] systemd[1]: Listening on udev Control Socket.
[    4.685574] systemd[1]: Listening on udev Kernel Socket.
[    4.687027] systemd[1]: Mounting Huge Pages File System...
[    4.687760] systemd[1]: Mounting POSIX Message Queue File System...
[    4.688524] systemd[1]: Mounting Kernel Debug File System...
[    4.689247] systemd[1]: Mounting Kernel Trace File System...
[    4.690393] systemd[1]: Starting Create List of Static Device Nodes...
[    4.691389] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling...
[    4.692560] systemd[1]: Starting Load Kernel Module configfs...
[    4.694984] systemd[1]: Starting Load Kernel Module dm_mod...
[    4.697704] systemd[1]: Starting Load Kernel Module drm...
[    4.698928] systemd[1]: Starting Load Kernel Module fuse...
[    4.699880] systemd[1]: Starting Load Kernel Module loop...
[    4.699948] systemd[1]: File System Check on Root Device was skipped bec=
ause of an unmet condition check (ConditionPathIsReadWrite=3D!/).
[    4.702243] systemd[1]: Starting Journal Service...
[    4.705201] systemd[1]: Starting Load Kernel Modules...
[    4.706206] systemd[1]: Starting Generate network units from Kernel comm=
and line...
[    4.706241] systemd[1]: TPM2 PCR Machine ID Measurement was skipped beca=
use of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    4.707349] systemd[1]: Starting Remount Root and Kernel File Systems...
[    4.707431] systemd[1]: TPM2 SRK Setup (Early) was skipped because of an=
 unmet condition check (ConditionSecurity=3Dmeasured-uki).
[    4.709289] systemd[1]: Starting Coldplug All udev Devices...
[    4.711777] systemd[1]: Mounted Huge Pages File System.
[    4.711955] systemd[1]: Mounted POSIX Message Queue File System.
[    4.712065] systemd[1]: Mounted Kernel Debug File System.
[    4.712184] systemd[1]: Mounted Kernel Trace File System.
[    4.712458] systemd[1]: Finished Create List of Static Device Nodes.
[    4.712869] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.
[    4.713131] systemd[1]: Finished Load Kernel Module configfs.
[    4.713552] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    4.713739] systemd[1]: Finished Load Kernel Module drm.
[    4.714168] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    4.714388] systemd[1]: Finished Load Kernel Module fuse.
[    4.715895] systemd[1]: Mounting FUSE Control File System...
[    4.719435] systemd[1]: Mounting Kernel Configuration File System...
[    4.722528] systemd[1]: Starting Create Static Device Nodes in /dev grac=
efully...
[    4.722962] systemd[1]: Finished Generate network units from Kernel comm=
and line.
[    4.726581] loop: module loaded
[    4.726666] device-mapper: uevent: version 1.0.3
[    4.726785] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised:=
 dm-devel@lists.linux.dev
[    4.727625] systemd[1]: modprobe@dm_mod.service: Deactivated successfull=
y.
[    4.727806] systemd[1]: Finished Load Kernel Module dm_mod.
[    4.728143] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    4.728294] systemd[1]: Finished Load Kernel Module loop.
[    4.728436] systemd[1]: Mounted FUSE Control File System.
[    4.728536] systemd[1]: Mounted Kernel Configuration File System.
[    4.730091] systemd[1]: Repartition Root Disk was skipped because no tri=
gger condition checks were met.
[    4.737696] EXT4-fs (sda2): re-mounted 963daeed-0888-4658-9f17-18bd343df=
b2a r/w. Quota mode: none.
[    4.738458] systemd-journald[293]: Collecting audit messages is disabled.
[    4.738774] systemd[1]: Finished Remount Root and Kernel File Systems.
[    4.739317] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    4.739357] sd 2:0:0:0: Attached scsi generic sg1 type 0
[    4.740284] systemd[1]: Rebuild Hardware Database was skipped because no=
 trigger condition checks were met.
[    4.741389] systemd[1]: Starting Load/Save OS Random Seed...
[    4.741419] systemd[1]: TPM2 SRK Setup was skipped because of an unmet c=
ondition check (ConditionSecurity=3Dmeasured-uki).
[    4.747471] Asymmetric key parser 'pkcs8' registered
[    4.748531] systemd[1]: Finished Load Kernel Modules.
[    4.749793] systemd[1]: Starting Apply Kernel Variables...
[    4.762719] systemd[1]: Finished Load/Save OS Random Seed.
[    4.766178] systemd[1]: Finished Apply Kernel Variables.
[    4.775775] systemd[1]: Finished Create Static Device Nodes in /dev grac=
efully.
[    4.776951] systemd[1]: Starting Create System Users...
[    4.799839] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots e=
tc. using dmeventd or progress polling.
[    4.804706] systemd[1]: Started Journal Service.
[    4.816414] systemd-journald[293]: Received client request to flush runt=
ime journal.
[    4.824979] systemd-journald[293]: /var/log/journal/ca3d73a04dc345538c99=
04a96756e41e/system.journal: Journal file uses a different sequence number =
ID, rotating.
[    4.824986] systemd-journald[293]: Rotating system journal.
[    4.984536] zram0: detected capacity change from 0 to 8388608
[    5.028103] mousedev: PS/2 mouse device common for all mice
[    5.029341] parport_pc 00:04: reported by Plug and Play ACPI
[    5.029425] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[    5.049222] cryptd: max_cpu_qlen set to 1000
[    5.050369] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000=
000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\SOR1=
) (20230628/utaddress-204)
[    5.050382] ACPI: OSL: Resource conflict; ACPI support missing from driv=
er?
[    5.051092] acpi_cpufreq: overriding BIOS provided _PSD data
[    5.051936] input: PC Speaker as /devices/platform/pcspkr/input/input12
[    5.067613] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    5.067731] sp5100-tco sp5100-tco: Failed to reserve MMIO or alternate M=
MIO region
[    5.067735] sp5100-tco sp5100-tco: probe with driver sp5100-tco failed w=
ith error -16
[    5.080852] AVX version of gcm_enc/dec engaged.
[    5.083989] AES CTR mode by8 optimization enabled
[    5.090062] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM=
 control
[    5.105231] r8169 0000:03:00.0 eth0: RTL8168g/8111g, e0:d5:5e:3b:15:1f, =
XID 4c0, IRQ 28
[    5.105238] r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes,=
 tx checksumming: ko]
[    5.109703] r8169 0000:03:00.0 enp3s0: renamed from eth0
[    5.134683] ppdev: user-space parallel port driver
[    5.162871] snd_hda_intel 0000:01:00.1: Disabling MSI
[    5.162884] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio clie=
nt
[    5.171548] Adding 4194300k swap on /dev/zram0.  Priority:100 extents:1 =
across:4194300k SSDsc
[    5.214513] input: HDA NVidia HDMI/DP,pcm=3D3 as /devices/pci0000:00/000=
0:00:02.0/0000:01:00.1/sound/card1/input13
[    5.214589] input: HDA NVidia HDMI/DP,pcm=3D7 as /devices/pci0000:00/000=
0:00:02.0/0000:01:00.1/sound/card1/input14
[    5.214658] input: HDA NVidia HDMI/DP,pcm=3D8 as /devices/pci0000:00/000=
0:00:02.0/0000:01:00.1/sound/card1/input15
[    5.214726] input: HDA NVidia HDMI/DP,pcm=3D9 as /devices/pci0000:00/000=
0:00:02.0/0000:01:00.1/sound/card1/input16
[    5.308685] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC892: li=
ne_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:line
[    5.308693] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    5.308696] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x1b/0x0/=
0x0/0x0/0x0)
[    5.308698] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[    5.308700] snd_hda_codec_realtek hdaudioC0D0:    dig-out=3D0x11/0x0
[    5.308702] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    5.308704] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=3D0x19
[    5.308706] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=3D0x18
[    5.308708] snd_hda_codec_realtek hdaudioC0D0:      Line=3D0x1a
[    5.326722] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:1=
4.2/sound/card0/input17
[    5.326807] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14=
=2E2/sound/card0/input18
[    5.326871] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/s=
ound/card0/input19
[    5.329070] input: HDA ATI SB Line Out as /devices/pci0000:00/0000:00:14=
=2E2/sound/card0/input20
[    5.329531] input: HDA ATI SB Front Headphone as /devices/pci0000:00/000=
0:00:14.2/sound/card0/input21
[    5.340116] kvm_amd: TSC scaling supported
[    5.340120] kvm_amd: Nested Virtualization enabled
[    5.340121] kvm_amd: Nested Paging enabled
[    5.340128] kvm_amd: LBR virtualization supported
[    5.894238] EXT4-fs (sdb1): mounted filesystem 03ce297b-4be8-4886-953d-2=
d2cc4bd0862 r/w with ordered data mode. Quota mode: none.
[    6.784621] NET: Registered PF_ALG protocol family
[    6.847510] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-300:00, irq=3DMAC)
[    7.037662] r8169 0000:03:00.0 enp3s0: Link is Down
[   12.862299] systemd-journald[293]: /var/log/journal/ca3d73a04dc345538c99=
04a96756e41e/user-1000.journal: Journal file uses a different sequence numb=
er ID, rotating.

--44ebpvkh4q256cwl--

--g73rnwnqsob4jnl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQGA96qgQojnEauApolGWOpdmSxVgUCZlcncAAKCRAlGWOpdmSx
VvuWAP9OgS6WFwFGrrrwk4oNbEneiJJa4eX4FXWmziTpowsgsAEA4rjmhvpZSgtR
HlI53RKgwoLApXtU6qX33f5D2wnBjAM=
=5mY3
-----END PGP SIGNATURE-----

--g73rnwnqsob4jnl6--

