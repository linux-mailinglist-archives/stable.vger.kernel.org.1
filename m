Return-Path: <stable+bounces-124204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 752DEA5EAFA
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 06:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DB0179109
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 05:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E191F8EFF;
	Thu, 13 Mar 2025 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CEtm3o4X"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F001372;
	Thu, 13 Mar 2025 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741842947; cv=fail; b=NN15eLYUcWz+MNmn71n8yhTggVhw9/FTh+sMOGyrME/CGNASTDP7EZ4VgjdF1IIbnnOjorTl7OIaEkeTpbquUlQi4SPiiAp+nJRvrvrQnWXmJ/4eyzUxA49ZULrR/xe9bMCEIjKa6OUMzPvXY47ENbg2fsYgo4XFXm0O1YafnEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741842947; c=relaxed/simple;
	bh=kPAfkd7FdPJmwqcfIrh51ynTYlccVCWTVJnmVYaLpQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gRTBaK+rlU5siWDHTt7ZdLRK5YQCBAfNgSdL1YS0zINniWkGcQM1eLu+hnT+s/P9YCBK5/vh4MdOz69cfPm5c8hTMu7s1WjlMWBpm5GhFBfcJLDUmmJ8U7HFCpvG8RfqZdkIte51+0NAuzzFbdhyky8+U+a4ZEaHs+ALmLNDTP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CEtm3o4X; arc=fail smtp.client-ip=40.107.159.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqFEmyeffeaPLTf8CqB6mubwE8KrB2oO0vc//zc+f7SEKGCcxg/R1c7w4W+7KxC6WioOkRHeMN95nlRIfR6BAxQrLAaB8oFgklpoLFbOPj0x9pcXMrVlMfb5l+ToM1v+B7zP3wV/2mMJhFlDmmA31Q5PWwejIBPY/n8fV98ip+3o4EN8UiK8WuFpCx95jmmMpme4aB0g0M9lD7yiRWYxeB6/1EdhJvq9FW+vvkj0chdrRaiuczyqJLJuV4ck3mLdTvN/d8x7rcD8dnbtgweR8npe76n0wfoFPQwYywMA8aRJ7Www8v2gycEHngcRn1nLkhHBvQnFTbZbQEaK34qzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMwwRTAOhhSg3Gli5C4OgEfNsnF9KmfhA6go8M50MNw=;
 b=ymks1UahLCBCBdmNRWODS5I6ixLpDflkMPxzSDsnlXNpx+2HGxWUIgDvRYQjf1GF+fAKhzHC5/DfO48rxuv972KepPDMtnho4DwfTu6MR2MwXQIPgfFc1qDTi9ZejJ9MXZQFysjJcrZm8uCaD37jF4gr1Jfj7rBscXQYIfdxLAxspShBFRlLrOP1YWsk7J5YVDlceqHBRjFNXiNCYm44QJhYn7GRGHe719nz+JxSoepIT+ZOzBZ7+e58oa3JuRnmZltYk/AYjX4tyztEY+WiLmjaWA09FnprMnh+Zr1hCXGZ80HnpG70VaWRMsIGd9QVmMfQQF6hYAY/EIPmILzFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMwwRTAOhhSg3Gli5C4OgEfNsnF9KmfhA6go8M50MNw=;
 b=CEtm3o4XeAAa4jaM/cMbk/XMUilmZBd2jBF4lT0uaPorPcChOicuw3zaSgPyXRvRYPkrmac68aEPLfUzRbvz5M744WqWEWazBze/dFFbYovibcRtPUCd70h00RfxvmThJPde205ncV6WZCOrmRxP76y8pdfycdAnIB9UgKz/3f9kBUpdiOkRPEAfkVGHISr16uYFFSH5DbW/oarom4obIKuO2cA07jMlBIJcXp9yz7/yKoMFE3cnZDDe85jdY3IRzI6nsSWne/Nxc24tC5vifCCkxpA0oGJt9Cic+Ukv7PU5f6rYQ7SVW4qzPtnvTARGOLduGHGgPnss/4zttIYzvw==
Received: from VI1PR04MB10049.eurprd04.prod.outlook.com
 (2603:10a6:800:1db::17) by DB9PR04MB8300.eurprd04.prod.outlook.com
 (2603:10a6:10:243::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 05:15:42 +0000
Received: from VI1PR04MB10049.eurprd04.prod.outlook.com
 ([fe80::d09c:4c82:e871:17ee]) by VI1PR04MB10049.eurprd04.prod.outlook.com
 ([fe80::d09c:4c82:e871:17ee%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 05:15:42 +0000
From: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "rvmanjumce@gmail.com"
	<rvmanjumce@gmail.com>
Subject: RE: [PATCH v4] svc-i3c-master: Fix read from unreadable memory at
 svc_i3c_master_ibi_work()
Thread-Topic: [PATCH v4] svc-i3c-master: Fix read from unreadable memory at
 svc_i3c_master_ibi_work()
Thread-Index: AQHbk1Y4SkbCrYt+yki4ZS7j1qEGurNv0p4AgACyIrA=
Date: Thu, 13 Mar 2025 05:15:42 +0000
Message-ID:
 <VI1PR04MB10049644F3287C378E9CC75EF8FD32@VI1PR04MB10049.eurprd04.prod.outlook.com>
References: <20250312135356.2318667-1-manjunatha.venkatesh@nxp.com>
 <Z9HSdtD1CkdCpGu9@lizhi-Precision-Tower-5810>
In-Reply-To: <Z9HSdtD1CkdCpGu9@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB10049:EE_|DB9PR04MB8300:EE_
x-ms-office365-filtering-correlation-id: 640d67a3-5b69-40c7-6290-08dd61ee1a36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZEVMBDqCNRnd9DpsmgScVksixlRfm0gqb5g3Rxn3/kwyJTR2/o0Io/cy+4H7?=
 =?us-ascii?Q?G+MG7qBRXrRNN2A/MoqkVg1ZoOXPY3pF853s6CU4YeZ0DLEdL1f8ibi08xD0?=
 =?us-ascii?Q?J12vXAmM13/H3TLhdbnoJaBhk77lp+m1z1yFRxRSzVTNx+J21/0okSYroV6G?=
 =?us-ascii?Q?7DbIyCqvdYDz6CC5XixkMwBl8gbmkadtHhB3Vxfqxj1sJ6kNR6nBpsxqKw80?=
 =?us-ascii?Q?G7vRAp7D/T+fNOGU/6N9lTAJy3WBGneA2WCjGZT/LhKLgKSCx5I/JzHxbvJL?=
 =?us-ascii?Q?d7EOGMboYkVWoVeIzDVmce59oIgWA2yR1MGf7ZYh3ppFlj/wRXBKbafXabgN?=
 =?us-ascii?Q?d3Dapfr3kmkQOVg0B7q3nyht0QMwlobiwqg1BNE+9/Fy6K/c39C87yVmeBcp?=
 =?us-ascii?Q?Iq13Zvyw/UVA07Wx8wH8BNdBkU0CZulx6oBk1Rnhw6J+dKHwPQ0L1Uaal/Aw?=
 =?us-ascii?Q?ULgaBzN+RCa/9ErK82zP78di5Ve2KQYWU+PAUZN5f09lSAtbNd26iOW1oq4V?=
 =?us-ascii?Q?VGuE3+tQXDux9DlZb92mXkXOOYOb4YemL19m85kT9h0Q+hoXXNW4x6dklIFI?=
 =?us-ascii?Q?H6LxGo0NRbDE/cMKI2KB9a/gUPbvxFZXoPXHdWGrlcweskj/OIwC4Kd44hVM?=
 =?us-ascii?Q?KlahhOvFLL/KwiusdfTcqNRwmcM/bS+zqTzCdcXcnvp3q5jAlQVKL08PRXMC?=
 =?us-ascii?Q?FcL4QjxKuUCvD8vjpKpIbxSXpUJEjcnH6Y2XIxPHyrF8OznQAMZ1VyFuruFE?=
 =?us-ascii?Q?wHhkR/qtVoNBPt2EZg8gaiN02SxRUhQBs8ZJ+EfdTRyYqAnS5rrdcE3YUKJW?=
 =?us-ascii?Q?mqhUZ/t8DFI+t+wS2guNFdBeb607ZiEzPzED77s74Ht9Gch1LryPXL8hNaAD?=
 =?us-ascii?Q?YlYrqrnynMSuU5xsQBUPsRy7OaFADObllPdYeg3uA46phuaUNrx3VGUBQkK/?=
 =?us-ascii?Q?v8g28GU3JeqvcG6WxwkEmHkOHv7/17Vyr1EMWiN9tVaiptEtWf44DvFj4YXn?=
 =?us-ascii?Q?wn2z+JD/Y/Xyi0T1hLfISnFIzI7o59oIwp+qMo6rxh8T5p1KgZJl9deLq61x?=
 =?us-ascii?Q?L46IcokIgumuenwJtKbgCLAvk4L0pcx1MUBf5OqLiPotqiKPmH59NzPmiS1c?=
 =?us-ascii?Q?+GPtpiezUkviOEzKsmf3JJ7ZW9XENLEJZ0JIUGblKD2OLj6INgLXQBEHadyr?=
 =?us-ascii?Q?GTRQg5LVKWganT4P9K2msv5ij4Zj1MKHHUVeBbbWcNwV0w9yKYcEter5ogTV?=
 =?us-ascii?Q?Zbxnjm8tAyHFOL4CTRq/DasY0Hw7ute70LIxZnDqwqPacx9RPd/b/0w1SGUj?=
 =?us-ascii?Q?caqbGZqIVBm+kaQlrIiAiOkbNbzqLhZantQbd67iMYN4AMm3A841C2AyrLed?=
 =?us-ascii?Q?I4TEGeR18KNbPXby0uK+ijMNjT+xHF6WjRvCS0kMFYcCYee+LPqCaGbcnb58?=
 =?us-ascii?Q?RG5wI1HlRHOmLSIGiOz/+VEKRI+RXysS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10049.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qT+PyZqhLr1b/Rmbc3t2HJbLj2BZ/BLCURZ4Mlbtm8nCQlbQmrPpPqdzGcVV?=
 =?us-ascii?Q?X3NeI9kMXRz7ocirGTaizkVzOSjwGQD2q++t5gOJmvtLu16NwVlrdC2gFybp?=
 =?us-ascii?Q?TVfO0gKxyMwMvpmHBz+O4HC0AkOsVemkwIl29NfCMZ/+we3lK7PXOXaSpC0A?=
 =?us-ascii?Q?U7mxzb6xJVs3LbgE2pKjnmyEMhpv15vPtFH8hT9g3vF860UQRTBiy7qsAAVE?=
 =?us-ascii?Q?S0NSGdqi4aDjgmpZmhRsmEnd9WqgRo/7AxINtONVBXD+llVBif7VTK7RLVjE?=
 =?us-ascii?Q?mfeY6LO0iLlfZkfeZO/fRH+TAsxIJeQCpQQZOJMAZiYDhjnak7n+R6Fdqz//?=
 =?us-ascii?Q?HU2+2OJ2NT4HYSbKiRKBpzcyPjlMbJBezYu/FblSTbn5UoI+qaVVTm6CXqn4?=
 =?us-ascii?Q?qqTzlh3VW7/y5zxTD6BT92A4dRD4nKTHpSrcTirmKsaQSil5txauI81Ddr06?=
 =?us-ascii?Q?40i6gUy/1m6AoTJQx43uNbWhyHSLGh10FzzC1HMoy6Ko1hdxWdAomzmQ902L?=
 =?us-ascii?Q?GiCiLkDnLfHStpfYiDLG/TJfZiC5uY14INhz0XpqcRttNfIpRkrMHmILYyKK?=
 =?us-ascii?Q?1ORNurMG5vqdAouWnNrWNe4t8pht/B50yqiPIr9yYwhGS3xa99ZYHSGeWxNc?=
 =?us-ascii?Q?nIEkiRmJhQLSL5rpTWTJEb/I81UL9vkHHE8cjNFIBcMQM78Z50rbbmnl4ESm?=
 =?us-ascii?Q?8GQje6yV/R36sgKTR0V7zStUTcG39ZbamnY74Op4FJzWoHSR+OU6EPb6oT30?=
 =?us-ascii?Q?ye/vdcd0FoXKcrRLZzhA/wcfn/omxGYxT77HumgWMZGCdliyDmK53y1St4eE?=
 =?us-ascii?Q?trgBT6behSBrpWRtF1j4tXZIlRyJFkYKSBI50dYdhJnbrdA6au1slQHfewoG?=
 =?us-ascii?Q?jummkyYO2yIYQwXPn1CcSLSu2JM9RGOoIALok0etFdltuGXTkONtGHdzEj4d?=
 =?us-ascii?Q?4V/QzCCg/tCumurxL+lOf3hMHoTH2M80hVpkUP7nnycVdFAWMpy81rRP3CiK?=
 =?us-ascii?Q?FR6RoIqRJnFKv+vDbKQfu3V1CiVoFALbPnFzG4poVTKL4g/suuO4yqtcVmCj?=
 =?us-ascii?Q?LiPqdMS5Gw6Idrq3Q8JJjDWrmZ1S9QkumHxl78H5hPQmN5OhUc+botNP7zy3?=
 =?us-ascii?Q?la6o6bfmknhoKXFsY4AuXR8xTqjbDHErTRinF7ZiB+GvFQ8ejdbi1EcFT/Bo?=
 =?us-ascii?Q?bfxXnEC0WeY0S2azdQLIPFG3Zz1BRDQSCInxRT5v8jLiUjKTJkAmPV4HElNd?=
 =?us-ascii?Q?SWbCLMyBd+mIevQ85VTArKiMISRLNn7oqB2g1AcyR4DGanUNVreWTxa9ca+/?=
 =?us-ascii?Q?klx+uXi6NauvCJylqYbDGsJ2CqOFCl9BpNEBJJIxOwcwadps/yn/1jrZKtIG?=
 =?us-ascii?Q?iTfNz5MYndmgdIKgyIZXGlkO6VCphsPBA3mtW6B5bl/PmAx+IyiaJDX4mtz5?=
 =?us-ascii?Q?wxkB0TbxwcHGZDWepnWDBYrx4rN6Qi6UkXOU8P7A7HU30Scl1gvm39BGpS07?=
 =?us-ascii?Q?Ei6Q5BzRkCSm9VjPyBTw/zLFqSkyqmKxbyYsTH5iHal/jnVlhmDXxq/gB06e?=
 =?us-ascii?Q?8aUSGxn2SxQ9WkhGHpL/M+NP4lxmuO6BPr6jalKfv8FC6CKSNHNPGpPg9JE3?=
 =?us-ascii?Q?Lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640d67a3-5b69-40c7-6290-08dd61ee1a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 05:15:42.5950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T3NTTpjkpNsRyn8IEqC6ElVtdpdgtdXwzcLUdTEacmCLUDc+IggSa3XexOvZPiNAiJI/lp50NBzSdu55hVIx6PioqHFP4ZyqxtsMLMxxlRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8300



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Wednesday, March 12, 2025 11:59 PM
> To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org; rvmanjumce@gmail.com
> Subject: Re: [PATCH v4] svc-i3c-master: Fix read from unreadable memory a=
t
> svc_i3c_master_ibi_work()
>=20
> On Wed, Mar 12, 2025 at 07:23:56PM +0530, Manjunatha Venkatesh wrote:
> > As part of I3C driver probing sequence for particular device instance,
> > While adding to queue it is trying to access ibi variable of dev which
> > is not yet initialized causing "Unable to handle kernel read from
> > unreadable memory" resulting in kernel panic.
> >
> > Below is the sequence where this issue happened.
> > 1. During boot up sequence IBI is received at host  from the slave devi=
ce
> >    before requesting for IBI, Usually will request IBI by calling
> >    i3c_device_request_ibi() during probe of slave driver.
> > 2. Since master code trying to access IBI Variable for the particular
> >    device instance before actually it initialized by slave driver,
> >    due to this randomly accessing the address and causing kernel panic.
> > 3. i3c_device_request_ibi() function invoked by the slave driver where
> >    dev->ibi =3D ibi; assigned as part of function call
> >    i3c_dev_request_ibi_locked().
> > 4. But when IBI request sent by slave device, master code  trying to ac=
cess
> >    this variable before its initialized due to this race condition
> >    situation kernel panic happened.
> >
> > Fixes: dd3c52846d595 ("i3c: master: svc: Add Silvaco I3C master
> > driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
> > ---
> > Changes since v3:
> >   - Description  updated typo "Fixes:"
> >
> >  drivers/i3c/master/svc-i3c-master.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > b/drivers/i3c/master/svc-i3c-master.c
> > index d6057d8c7dec..98c4d2e5cd8d 100644
> > --- a/drivers/i3c/master/svc-i3c-master.c
> > +++ b/drivers/i3c/master/svc-i3c-master.c
> > @@ -534,8 +534,11 @@ static void svc_i3c_master_ibi_work(struct
> work_struct *work)
> >  	switch (ibitype) {
> >  	case SVC_I3C_MSTATUS_IBITYPE_IBI:
> >  		if (dev) {
> > -			i3c_master_queue_ibi(dev, master->ibi.tbq_slot);
> > -			master->ibi.tbq_slot =3D NULL;
> > +			data =3D i3c_dev_get_master_data(dev);
> > +			if (master->ibi.slots[data->ibi]) {
> > +				i3c_master_queue_ibi(dev, master-
> >ibi.tbq_slot);
> > +				master->ibi.tbq_slot =3D NULL;
> > +			}
>=20
> You still not reply previous discussion:
>=20
> https://lore.kernel.org/linux-i3c/Z8sOKZSjHeeP2mY5@lizhi-Precision-Tower-
> 5810/T/#mfd02d6ddca0a4b57bc823dcbfa7571c564800417
>=20
[Manjunatha Venkatesh] : In the last mail answered to this question.

> This is not issue only at svc driver, which should be common problem for
> other master controller drivers
>=20
[Manjunatha Venkatesh] :Yes, you are right.
One of my project I3C interface is required, where we have used IMX board a=
s reference platform.
As part of boot sequence we come across this issue and tried to fix that pa=
rticular controller driver.

What is your conclusion on this? Is it not ok to take patch for SVC alone?
=20
> Frank
>=20
> >  		}
> >  		svc_i3c_master_emit_stop(master);
> >  		break;
> > --
> > 2.46.1
> >

