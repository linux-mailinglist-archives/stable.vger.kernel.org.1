Return-Path: <stable+bounces-89402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C989B7AE3
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 13:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13271C20897
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 12:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6A51BAEF8;
	Thu, 31 Oct 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="Xrd+EB4O"
X-Original-To: stable@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2100.outbound.protection.outlook.com [40.107.255.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A4D19D084
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378362; cv=fail; b=saaQXu5ArNBqpNlOpS53DQidVC7oDGu27wCHS00ZgfPRMl+8v5rXNVJzHl6gYhggLRp3tsROwdiDqKaHwjkBqHvtKcMIs+cuxhL7msRT/PO2MJTh6fnw+AOSctRsIFGPVuhkIals40dzEiVWEEiYidtiLGhdmXdWF6owLEWcUXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378362; c=relaxed/simple;
	bh=/CG87DMV9A0JkPd7iT8zMgZ9BSAZjc/OdF+DvJ5ym2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NjWSaRZIyNKWdTZKxdkyfahQ1UB9ZTckvTL5/n1gcTs0qoG5Fu6Isgr1mL9x2ULpQrp6mSauY/L9zIlQUwCA6LICahu7dqkKKOL4K382rt0iJ+HOKtRBENHrmPc/pQAsIDtbCXPK57v0+nh50zaku987jiLXsT/45S9rFqP3eTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=Xrd+EB4O; arc=fail smtp.client-ip=40.107.255.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhVAizifzT/4yPSaAOXb3RVgx4i7+AQmeoy8spMl09YR5oitZsAJz5/Jjp83gpOVPwyxCr5U4OO/c2G4QEidjVdGhl7Ua/LBfVX3AMLT1iBg1RVSpzLaIV4L6hdGWlBCj0QGZ6MMVn23Io64rHMGF06AZmTtWsq42ki93UBqGJ2IzJR2kz8OglHchszNA99KYuhL7RGQu+61YwtMjp/tWTE0nppn1shZpPOeK9wIuC+IR675QY+UuQ421kUYTgHMg4khHIpQcWfAFce5t9qirLy8jkWm5Z04m+e9sxX6hPG4jpeeBsOWy7btN6Hr2QT67/iQx1v/OZ9nsmR9CuCxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TO2WhqASzfkiVWXkPHkjZTI/yUeQ52VZORNeIzkGoTI=;
 b=nEiig32eyNcU8pEL8h9TcVSZSnXPmuVTxCFvHZzTY+EVJLCkSi9z2OQ3Zx52c95baMhprSJsPYxgKWb5MJ1yVFZVskipEEz10zKt8nYREEDufs1naXePgzlCAiyUALzFdfNqsd8PdnVr8j/VW2lZSa6wMI+ft6C5LqbN/3w7bRu5RUyxKBqEbCeGah3tB8XnPbkkvzJ/VQPiB2rrdfjxvUJOshTo/BGHcgc0HLoZVtcUyIKUtLPM76Px2Blxy6FD2VJOqXkZH/+E5DmKEiZR02kJ1xZ2Zyzc03LEzPna5fX1XbEc4lsqwuywC8/get4ulqSFuQpXdoM3rmHx5k5JJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO2WhqASzfkiVWXkPHkjZTI/yUeQ52VZORNeIzkGoTI=;
 b=Xrd+EB4OQAy/HGGgs0E0kctzlOvkLXN3eaxmAnIyB/CsquDoGbfvCFeZ0Zy3GFaJHudLDL+RAcLJeizUHY0R2khveDPson/53q+tnii91+kJzCBdLEx8Mh9tLFdNzijHX4xESUUi25muc3KLnKoAzQwNllYIvIcONCbvoB1skz0yTHi8WfdWivIxRIzZ2EahirvarDIJu3uTh3RNbx5MhMUhy5fMZfSK7xltJomHqY9NdQY0+Rt4pon0eBazsv2H8itVSfrMkME7b44HpIDqDXi5cfkoXADvDIrPdlHokDVbqmCYHHJz9MPEzLRSxDmLYaNLShe50ibvi/bOf2v6Gg==
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com (2603:1096:4:1ec::12)
 by TYSPR06MB6471.apcprd06.prod.outlook.com (2603:1096:400:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 12:39:10 +0000
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::967d:afda:6f4:33dd]) by SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::967d:afda:6f4:33dd%4]) with mapi id 15.20.8137.008; Thu, 31 Oct 2024
 12:39:10 +0000
From: Lege Wang <lege.wang@jaguarmicro.com>
To: Parav Pandit <parav@nvidia.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "mst@redhat.com"
	<mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH] vp_vdpa: fix id_table array not null terminated error
Thread-Topic: [PATCH] vp_vdpa: fix id_table array not null terminated error
Thread-Index: AQHbK0ogafT92RUoPEyaCu0bwt0L57KgQDKAgACFXqA=
Date: Thu, 31 Oct 2024 12:39:10 +0000
Message-ID:
 <SI2PR06MB53853CBC1C23E04D009B04B0FF552@SI2PR06MB5385.apcprd06.prod.outlook.com>
References: <20241031040514.597-1-lege.wang@jaguarmicro.com>
 <CY8PR12MB719540F6E6CC0A6AAC2FAA5DDC552@CY8PR12MB7195.namprd12.prod.outlook.com>
In-Reply-To:
 <CY8PR12MB719540F6E6CC0A6AAC2FAA5DDC552@CY8PR12MB7195.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5385:EE_|TYSPR06MB6471:EE_
x-ms-office365-filtering-correlation-id: f329c8f7-b8aa-4d4b-fbfc-08dcf9a904ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?KAv42ze2VdvZaMdQhUF6JCkTfdLGyJc8OSe8KnalauaBTYxrMSCt3IRB?=
 =?Windows-1252?Q?APejXiPw559xFJpG2rdXHN0oDyEiKm8nV1xN64XNl99hsS5GfB+d0Vyr?=
 =?Windows-1252?Q?sdQBqrSpc0hd0r0IqWTIK+xBn45hMdHtGu2KRCE9GkfRdNE1q62OoWj4?=
 =?Windows-1252?Q?gS1m8xRoy2uiaZTOeXdhQvqnH1w+7IzrpXi7unS6JsJAS70LaDEoTYWJ?=
 =?Windows-1252?Q?ucEPutFb+17/QQqj20pHslBEBWE67RhmKXAFos2rlkovcLmrezb96xff?=
 =?Windows-1252?Q?HbUPdgGOpF1ZhxU7F/p2sPeGI5rdTsRgvPS7y4OpnyOuPArcATAje/72?=
 =?Windows-1252?Q?MFjXhU5IHc/SHe3pTWIw6R9z7WSMX7dhx7kqljLYhIbXeimZ6iv4nEBf?=
 =?Windows-1252?Q?+GbgM5l4bJ4AefDg/DH1z/JdQiPWNkcnQBFgbIDuNZY0I0FBUYfo2wkA?=
 =?Windows-1252?Q?ZCtTtVNjwHFMepJIrPv86jLTe04EoCzmsT2P8KyG6lHWyNLaqEFykLeP?=
 =?Windows-1252?Q?MfkzHL4yW/S8voqK8AjCT/rTJlabbgHuDMMX38Ij2DupKa4DiWieOX9w?=
 =?Windows-1252?Q?kR9+c98yYbAiKQXvdtlYnt/mNvnF82bDlU7I3ccEmXrDTPPHetO+DLlW?=
 =?Windows-1252?Q?NzZhTIsXirQ46YYNaRnrH/J1ikku3JwMHd+gOdxhCwAuFxJlcHmHV596?=
 =?Windows-1252?Q?F2X4T/KMwoBw+5P2K2bwS+rQFCuHMpV5W9FTZ1q3QH5ToT7epLuR1Q2d?=
 =?Windows-1252?Q?I4YE66OoN37c6/0guHsEwsn17gPKweWj32cwhbWIv+UXqafIVdOVHC5u?=
 =?Windows-1252?Q?H3/aaWvrSOcyXUFGibCO2n4tPxznndnUfBt/eBcIE041Bdy7cHf0JqKQ?=
 =?Windows-1252?Q?sipiLB+O4u/js4sn8RXO7jFCs644CM3BXYkHQVsYQ1r3poZ7nNFXnlZz?=
 =?Windows-1252?Q?/l8DQwWfhmE258cEvZX8g0tNSwv+Ido8RoEsEJiFPvJnGUMXp+gcWuhT?=
 =?Windows-1252?Q?5nSkcsdE19Kb9LTSXET7SWNmogLXhiZbkMSZgqq7RsEJ5US3JitQA7GG?=
 =?Windows-1252?Q?2jmC7nsZLD1OQr3+U0FQzMdy7cjlfZJ8LClxV7UPVyPEFEFIJUXMBhhu?=
 =?Windows-1252?Q?PszwY1Uw7tZz0G0bw1Ry52o5EujAi6nriekO4ySMp7C9Qfw+5pQ50cNo?=
 =?Windows-1252?Q?u/AupzmMvroZFfXSMnTTKNobuf9dAZanhevvfBj/y/xOBLMKFu2LxpOg?=
 =?Windows-1252?Q?kuWZTfhksIwHzHDrMPzUs00AD69NOe9ncsDzMG0r32CL8chIzzbsuh+P?=
 =?Windows-1252?Q?GGlj5XILf9Ogwc7gSbNddnff0TvCcT+/WbjdxKst64F5EW3OwkVBSLj+?=
 =?Windows-1252?Q?UcOdEgq8eTYUrwPJxQ8Kn1g+dsuDJ0HSx1cjMmk6yZ1U5tBBZoucXbMh?=
 =?Windows-1252?Q?G5zGvi/IxlRVd/IxgqScoe9lFCRBVvdreqLI3Kc5HtA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5385.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?GaJkeORXUOmE0QtMwYJ7TO3HxW+fiwGj9BpNGR7Uk7MigtrLLbX9NIg4?=
 =?Windows-1252?Q?0eEY3ygmbISbfEKHZQ9FUG9bVqwsjJe8i/Mmm2F15p1ASQIt40uQsfo1?=
 =?Windows-1252?Q?SJHuc4myMbE5s4G5f9Zu32rEWde7LL7wNlps8VogMTtgoe+TflBUXxwO?=
 =?Windows-1252?Q?DUv27JbbQmTI4VlgF8GeYLT4ygSY6pxh9zddPJwd12x5t5Theru/DNSu?=
 =?Windows-1252?Q?1uvU7n2M/wyobbaoZQpEUZCZJ3PzciUzuDk8cOhjSzwsqIpu+ysEF0ds?=
 =?Windows-1252?Q?/D4HHpM79b4Y5XZOJamIc/IBadWzsIvs37bonHRSJBnEEV20nmdvukHY?=
 =?Windows-1252?Q?2GFN4ozAxxQDmzclj3yWxTv72ZGVn4wlKQUNEkK6yqIOxLs9ho2BkFkP?=
 =?Windows-1252?Q?vOVIPEeUY7o8T/28oMCucwrMxWXodOU4YTy5Zj5r5sXeD1wj6dr8QLCg?=
 =?Windows-1252?Q?0T94c5MddXGkiQSBdcrcNuBoaEpyBwVokSz1gCmJkvGeBUKafupzfzDx?=
 =?Windows-1252?Q?0cU/2zXGyHAXSWLKjptGnfHfXTOl3qae7g/3TRkM17+Jfm3aQHMxNuQN?=
 =?Windows-1252?Q?AbpZd6xGgrFXl2w0/sSCwxNcdQXpQBQ9UCjqEuZDULihNYZiJ1waaa+s?=
 =?Windows-1252?Q?/17L8K6idcQtjfbQ1+yFbfXQ61O+NappOdHCdYLK6UMO6vW61MNKp4IJ?=
 =?Windows-1252?Q?fnT1OQCh6m6xkJzqkNAUcelL2W2DzU61KztRi4yBatddexAg6wTkwIAz?=
 =?Windows-1252?Q?/qOEj7t0T8HMfFIhEnPIJvc/fJAblHM6mNRGjWsyuhVYN5U6ZeQzUMG9?=
 =?Windows-1252?Q?SkhWi73gGZRbCAPmQhrZ1jGFuD9tYkpzC39MbWVsHr8wNdLgvNWWbNLx?=
 =?Windows-1252?Q?WMMXkzBfDNHuTamzkUuge6e7Wy/+xGj+OyT64sSKTNuspqu5g8xlmP7F?=
 =?Windows-1252?Q?0NW9ucLUz9Fhw583f4PwhPUKHX8wVo285kGO2BT6I/4/v1FS/afZBAfR?=
 =?Windows-1252?Q?1OeZW93aqG/BCVjKmryitahegwigzejdGQCQMdAIIzy64RkTcUCUC34k?=
 =?Windows-1252?Q?m079Su8YQdOR2zSlqVJbEld3QjjX4tZfpeajgLRX1T0/Yi/cBVoWcDv3?=
 =?Windows-1252?Q?EbGEfIUqVNwraMcl3dGxLgHyqwRrch85f0FlDYqzvzpu2T2LPrGt9IBw?=
 =?Windows-1252?Q?xYztk2wamcJ/0a916NeSPNltOOO1fE6rWIN8MsdoXrUHnddDRz4O4D3z?=
 =?Windows-1252?Q?UPp76GUCALr/kpfaSG6wjAKeEXXm6ZDNCE+JLdxn9RENAl86eJYMVLB7?=
 =?Windows-1252?Q?wkaS6TA3Uw/c9sBlqVZRueACv82aqTs96BY0sVEbNRqCFfOi/o8nFkJ1?=
 =?Windows-1252?Q?dwX5jobH0VnbFkQSsIS3sIxdLJvs+Iu+wf2u5oibumiNDaeMfFZQ17VH?=
 =?Windows-1252?Q?NnuoFMgZ8zvsi6jKYY8rb0ZW8S9WIc/jQ0kn5sb/xwOtWHcB65bolXGe?=
 =?Windows-1252?Q?efPgIXV4F5p9Lx807JPUaYPvaPGUS6K8uxMfonaM45hWLSauQI9pfRAl?=
 =?Windows-1252?Q?lFW2jHjzJBHewPDILCxKLI9R36Kb5UBxLLdtvdGg9USNX1qBHtD78brl?=
 =?Windows-1252?Q?/CuHKdurRM3RKosuar3ENTPW8xNMfw8rNCbVpeUV4HPh+hqUC3cOtOqi?=
 =?Windows-1252?Q?Asp+6N0uNqTDEC/1bB2PRM7Z355qjMwj?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5385.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f329c8f7-b8aa-4d4b-fbfc-08dcf9a904ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 12:39:10.4827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RF2Q0iaJFdqQ9q6zYZeYRIP2zro6NxpPhfX6Ej2CvaVbm/dXQXV0o7TLaH32VtatHaUoAvBijsUgukUvKoqy4uq+xg1WBSxTSicPT0LIUJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6471

hi,

> -----Original Message-----
> From: Parav Pandit <parav@nvidia.com>
> Sent: Thursday, October 31, 2024 12:15 PM
> To: Lege Wang <lege.wang@jaguarmicro.com>; virtualization@lists.linux.dev
> Cc: stable@vger.kernel.org; mst@redhat.com; jasowang@redhat.com
> Subject: RE: [PATCH] vp_vdpa: fix id_table array not null terminated erro=
r
>=20
> External Mail: This email originated from OUTSIDE of the organization!
> Do not click links, open attachments or provide ANY information unless yo=
u
> recognize the sender and know the content is safe.
>=20
>=20
> > From: Xiaoguang Wang <lege.wang@jaguarmicro.com>
> > Sent: Thursday, October 31, 2024 9:35 AM
> >
> > Allocate one extra virtio_device_id as null terminator, otherwise
> > vdpa_mgmtdev_get_classes() may iterate multiple times and visit undefin=
ed
> > memory.
> >
> > Fixes: ffbda8e9df10 ("vdpa/vp_vdpa : add vdpa tool support in vp_vdpa")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xiaoguang Wang <lege.wang@jaguarmicro.com>
> > ---
> >  drivers/vdpa/virtio_pci/vp_vdpa.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > index ac4ab22f7d8b..74cc4ed77cc4 100644
> > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > @@ -612,7 +612,11 @@ static int vp_vdpa_probe(struct pci_dev *pdev,
> > const struct pci_device_id *id)
> >               goto mdev_err;
> >       }
> >
> > -     mdev_id =3D kzalloc(sizeof(struct virtio_device_id), GFP_KERNEL);
> > +     /*
> > +      * id_table should be a null terminated array.
> > +      * See vdpa_mgmtdev_get_classes().
> > +      */
> > +     mdev_id =3D kzalloc(sizeof(struct virtio_device_id) * 2, GFP_KERN=
EL);
> Only one additional entry is needed for null termination. No need to allo=
cate
> 2x memory.
> Even though you have only two entries. Reading code as +1 is better to
> understand null termination.
Sorry, I don't get your point here, vp_vdpa_probe only needs one struct vir=
tio_device_id, plus
one null termination, "sizeof(struct virtio_device_id) * 2 " should be enou=
gh here?

>=20
> And for array, you should use,
> array =3D kcalloc(2, sizeof(mdev_id), GFP_KERNEL);
OK, thanks for your suggestion.

Regards,
Xiaoguang Wang

>=20
> >       if (!mdev_id) {
> >               err =3D -ENOMEM;
> >               goto mdev_id_err;
> > --
> > 2.40.1
> >


