Return-Path: <stable+bounces-89581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AF59BA3A2
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 04:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E6A282D6B
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 03:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CDB70804;
	Sun,  3 Nov 2024 03:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p0TBSFJL"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABCC33F9
	for <stable@vger.kernel.org>; Sun,  3 Nov 2024 03:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730603297; cv=fail; b=gh3Wr0cXcn50OiNB+0WBlCmUjEXLQQjNvZeFS2RjygcOAkpErOBIarnKt/hd9n6WjBsBRyvpBxp2pf8+jn3WTZeO7W60bJsxJePYtcDn89cgEkOmn/PvLCJrRtOb1ruNVq4SaKFTauzkc9XQ8U+l3/3ijtC1vNayRnewBxD5ev0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730603297; c=relaxed/simple;
	bh=1EkmQRs2FshsmZ9NTtEWx0sylNG/b9nMHKDIBq5yg50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jEt0F7LnJaGBjyAd23MSxAZgvmuKZtBCfYNef1I1xdR40KfftAmMRkJd/KaJ1xWmol4359c5RwJz9xqpe+/Hs1Sds6PyHMrGomaIrxduLvzeKdRvCHYx0APsLrGSLSuUKHWkq6IllaamKL1fdRnWSJ0h2X5ZKjyKYdennHT9rBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p0TBSFJL; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6eTR2ISlMnT+JiUQeH/q7Ekib4OZDV5TJ5qGuhy3Tq7UvwSvwGAH8c6ctU5rM6AZERxxAhXiTmJj80WVuPH/6HcoIbq1pgLAfNpP7MLh/QTuaLkE2lPa97kD5K2GF8/6kQ/3xJoAadQbzYSOv5LZ33SzjMizkyuTbcNH3BWK6sjgLM75Tt+5srd3QBHmb3BMBmgf3BlzXOjfLjMHW8wFlSFCUvrjVPPVvXUZJ2t8wcdB1MKMjhnzZqtKkNOWlOamqOOHwedHLjJwatST6N9AXzpOLRRRToGEUGvq9kndE1Y6Fin6Q12EsSHRV7y2OmRBHk/UtkgzGzeh8cFVRKMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b66mJkgMq023KK4R1ZbstL7081QSnB8Eg3mZd63Hcuc=;
 b=BNCvOXruWQK8ibs7jFyI7wP1ldCu1x+7/AnxbgowWd2tkYy6TAH1wsoPxGAnjpwOODrNwi+BCsd8VkiviU8OE4eBy8gqrRPvJ0mf+7OQltAx454GOd1AKUW4DkNypWmFNMvwhac/JKMCVh1p/tPvFNz4AqDnNuFLqDPmzFMzpzkqqZcmUk11bDG+8Wx9QLv2Wd35i5M81VLyR8jKbO8VQVhBm65s2d5e5P+6PR654fKvYDPGD8ozbOulksWravIZF7v/hovonmTsV6Kdhk6UYznytCBJDRr896kN6URK072BFCl0PMB7JCIKk/0PuXWhsb7cp69qgLmIAf2bB9ZNUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b66mJkgMq023KK4R1ZbstL7081QSnB8Eg3mZd63Hcuc=;
 b=p0TBSFJLugapgk7gYpiw0vlfgXYbxdI1z2A9WtaHF0jzCrUu+ksh3VLCiud+UQphWVgcMLE0cw0ZfOUUFYxrPeHoO4LhRq4jHaC/bwPiwBGz0c0tA6uEn0RQyszfPcRuYqjFfJEXNdoFWCGyBMRayycdAQqkk27J1V9mWbr0p1hqa7KP48tJ8GmPy/OteUalvtpGMZDaZuzkAz4wC10gNkEPoO0t4JO3d40aFwFA1NaTN7S+ehobIBv5dxpwIeHRMGyb+Up2Gb0Iw9ZelunNEWog84V2TCBY7etL0CYaVff//aG8aikwaYc2NO4+wPg3R0Z2mF9LnqPuV1Qq171Lfw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Sun, 3 Nov
 2024 03:08:13 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8093.027; Sun, 3 Nov 2024
 03:08:12 +0000
From: Parav Pandit <parav@nvidia.com>
To: Xiaoguang Wang <lege.wang@jaguarmicro.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "mst@redhat.com"
	<mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Angus Chen
	<angus.chen@jaguarmicro.com>
Subject: RE: [PATCH V2] vp_vdpa: fix id_table array not null terminated error
Thread-Topic: [PATCH V2] vp_vdpa: fix id_table array not null terminated error
Thread-Index: AQHbLDj9dV2zjYIBME2V8y6xnYdFRbKk4jTQ
Date: Sun, 3 Nov 2024 03:08:12 +0000
Message-ID:
 <CY8PR12MB71952095F06EA9B9B301C39CDC502@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20241101083448.960-1-lege.wang@jaguarmicro.com>
In-Reply-To: <20241101083448.960-1-lege.wang@jaguarmicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SA3PR12MB7858:EE_
x-ms-office365-filtering-correlation-id: 6c11f8a3-fe04-4a47-2096-08dcfbb4c0e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9GvcT9Zat9Wt0N/k3vFR82W1M1E2wCwhlY2wzdQmeQ4Oi6DYlqo6dED5aRyZ?=
 =?us-ascii?Q?k6s1mcE3Vg2TWCWTuHmFrT5NYIoWp3Ly4aZnMkNQACVl411OB5YdQJXVSAea?=
 =?us-ascii?Q?Yaw4mLUalXnJPg4nsznSOTEzdNjLMo5GVZtnsKnbGL0QTpayqjg5kL9hVQO9?=
 =?us-ascii?Q?V8SVF/MBjpRV/Wd17c2+f6FmRqDMne6k/lLaoOac9dheqGk3vW4epXNmNH3v?=
 =?us-ascii?Q?Byp3aSJwBk7Gu2MJOygAdwtnCtIsG+QesLPnge/bTSKJqNRZqH5mLyqLTxaJ?=
 =?us-ascii?Q?9G3KZEH2BaPJ9KDKNes6/oC/avaBFPgvpLT+pZDFR2uCWSXBWBOdqWmP83xL?=
 =?us-ascii?Q?pmCOLmrVCoyVf3DWo8dboVLwEirAfFHrh+T+BZKNYcfTBTTCO7zMHo8GPQm2?=
 =?us-ascii?Q?EJJkU0AGMKbXFDw+JWVU7Piq09Tn0ONC64M8Bb9f88+DuFHgYhZoma5jIRQC?=
 =?us-ascii?Q?Q+uVsTE+aJFgY65tsz2FEUMeeZkaqbCsP7WTgAF9hGObS6MKX4feB8dHqbkL?=
 =?us-ascii?Q?SoFfFiIEGBXCfJ5HcLJaX67VJVgUA+wLa7o94Oj5xvCzxjb9ZtI4ZJ+AYogm?=
 =?us-ascii?Q?wbn3QTx6Dn6JmHfICJcCwrVSWJuYvullR5MsW/xFJ8iLYYaoT4JiE9bUoroB?=
 =?us-ascii?Q?xvZX+M4q8m2HJtvjwrxx71MNIwAt4a9sKGSMsSQ5Qsj43UL1ACFk+pDPqPWe?=
 =?us-ascii?Q?f714Hf0ZzzsT3hSEEmBQpdHOFnsrdM69hw8WuVqrXuQ22fFf4FWSh/xBASl+?=
 =?us-ascii?Q?uHeu6Bf0Cq2QOMPwinESkA/nSLkHqJW2/cV3N37Ro1S3OSl8H6utxa26N8KL?=
 =?us-ascii?Q?bbO76hlW+LFOxvz8Jv0H4GZMG9pv3qxaA8oSSlv4iHMiiNg7/7brxK7mErsv?=
 =?us-ascii?Q?ztd6gWQoL703OCZXwOh7YNYypA/1wKdTAnxduKbxf/O4zw2a3WlHHvUDVbKF?=
 =?us-ascii?Q?obrKJRIX8AF01ZD3+uMsmBg8Ua/xbvaylWFQN0w6hPodEHKeSM+hoj/To0k4?=
 =?us-ascii?Q?e5j67sMNFJEaDSOuZrGG9YiFyXD9kPvTL7QlJJ3io3Y8gkNc4BquGVlDtgDx?=
 =?us-ascii?Q?C7b9WKC3slp60YMiYH5bFLTaAVNN+XCNPO9KmFO/XMbEkY5O86SANx3W8DSn?=
 =?us-ascii?Q?sLcQRUksscEpbiPUOY6udxSblfLRg6ctsTd4svZLaghotFIqvE6kLszJUlVu?=
 =?us-ascii?Q?iSH6jmPWYsJIJoVaFBCDv2ErjCmupQ6eJTB+h1XrcbJh6/H37qRvb0985Jkg?=
 =?us-ascii?Q?8ayqvvLnTj0SbJRw1u7YRsO2o8yg3YD74T4qxkPYR5HP0+FkOG2JieL6dxR9?=
 =?us-ascii?Q?9t5r2OFStEhJMtOL5mqblTf8sU0JE2w52DdjJ8WWhByJcJhHixZRAtC/G/Ls?=
 =?us-ascii?Q?r1146ws=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eoO+Prga+qUew1AMF1R28XKSPxJ+esXflGi3m2W9lTwIYEZxYB/vJY0oQCKZ?=
 =?us-ascii?Q?cqTaVt9GkOSZi2fw5hA0YNH5Ov+1trM4X8qwM6QMwS/InYqfmXT6O8tjvs1c?=
 =?us-ascii?Q?N/XemD6YFAlpGFYqZ1AylQk76kL5PRY5lzk/0YrKoj0EbqTjf9E0oqLmLpMC?=
 =?us-ascii?Q?onSdpRLpJStPMN4aJlNyLInpMD6J7ZYw+8MLgIGqViX4djQYzXvq5edXPZKd?=
 =?us-ascii?Q?f8STVoieSkOTyEW4pQxOFxwP9njZ6kVxW2SK/S2lRLJH6oV5TmCl8t168L79?=
 =?us-ascii?Q?8DoUTc0tWIxNNAoMzQMcG87lzZdtYOK5T0uZyTi6QiU9pJ9HYmfAXFBFd3nS?=
 =?us-ascii?Q?SD1SSwuPfKR7MqwLozKgAqFSNkt+zXU6BnAAJYb7c5K0zTl5wbZNsgA1cZRW?=
 =?us-ascii?Q?y4Kk9zqgZBn7DnSby/xoPX6CUkTJxr1aMpwqq7rhJUvgK+1l1x/zYFbW0Lki?=
 =?us-ascii?Q?ccj+iQq6vo1Qyrpke6dvG7YekWogQTCbUpgetOkKw4t/1mppTcbTdndEYvwC?=
 =?us-ascii?Q?dQrf2s/qZTrKJEmRK5DLW+K2i+ND9CdKfD5own4YBQI92RPlCldevGf8kmjM?=
 =?us-ascii?Q?HamTMbJl9SUCjGHFv1s9CoOJQFiHFaulcE4mXfqOosYpRjBUtHWC4LtReU6m?=
 =?us-ascii?Q?zd7SOJ2DnjM3Hb7qMYA71PKCRTc8nWiQi33GttxRAVanps+QpssLSgtnCHHp?=
 =?us-ascii?Q?2s6qVmW6C4Vvu85cUv3PqkJaio+ceLDkpkcFsLKFvn58UZXyErrlpzyFgHmy?=
 =?us-ascii?Q?M/o3KpZ0ZLxGvni14/zPc1pL0BWMyt6MQNLJ+tzSTthXklBMvgJbUnnyBp0V?=
 =?us-ascii?Q?AWinK0hpIMHfNPVNJsHc9nancuau+csmC67tor9p+Ol/TROf8yGaHCPj9EdN?=
 =?us-ascii?Q?t1pr7Rv9rcYvHz+rvXq8amQsIehuALGLCRK5Qt2YIVyd9c+J/IK9ZaP22oMY?=
 =?us-ascii?Q?+/QGDbVt06deIe5yXGtmX7Q0Zxbt/q7jVrppmygx04wzeqB2bM5bf6BhQA6D?=
 =?us-ascii?Q?rMjKBHTJqm5ZOJa51OBZgzzREnxVpq9YC/idQkirsluDfE8kj0BuubhdJYL3?=
 =?us-ascii?Q?yp063/y5Mj9SA+TY4Wzs/2pbq7fxuwfIVtL9OV+yv2Xb21ML4gwyTb0xT0yC?=
 =?us-ascii?Q?yiMkmu9XKOUdzt6i/sMn7qVx4Ll/nuVvAY+VRMinkNqvikDo0ezZFGiUNKs2?=
 =?us-ascii?Q?vL5ZuTZ7QgkpbAHBe2Prs81U2bT65S8ns6pZsUwpDKoQQZbOw7RdGfLmBcXA?=
 =?us-ascii?Q?/jiC7Bjm2YImALxVmLY/t0yRx3sGOKoYeUGtUvm0VunI4JUJFy7jyrxm1lBa?=
 =?us-ascii?Q?zrqxEP7ATdeJer1fkGHjC2C2g5KQtz9AY2ZbLdelGYlKzgEp7xWgoApRYdsA?=
 =?us-ascii?Q?WVXE3oAfQUuCyIgiOXxNxFQyUUAjtNXQSpo7vBzOe1M0d17Y/GkxBIoIrfOR?=
 =?us-ascii?Q?nDrwXjIBRokk4XqaOUrEcSrD+dHR/3kj5TAXTws5XHg0bDhqGtI5lK20drWd?=
 =?us-ascii?Q?EFtxVKqbi0G4K8zrWSo2ukYTfCGrGo1JNqzwoD1nT1y6N8RtO6M6Rg8KMTji?=
 =?us-ascii?Q?PDfS9dETNzfTiKpqFoE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c11f8a3-fe04-4a47-2096-08dcfbb4c0e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2024 03:08:12.8409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtaHk/RRfUGtqYVsm7RX8XivGfHj+r3K3l7EtW+GBaIHZlBj3ua3im6rGGLqDh5Pml+m3VPnaZ56qU8PRd9YHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858



> From: Xiaoguang Wang <lege.wang@jaguarmicro.com>
> Sent: Friday, November 1, 2024 2:05 PM
>=20
> Allocate one extra virtio_device_id as null terminator, otherwise
> vdpa_mgmtdev_get_classes() may iterate multiple times and visit undefined
> memory.
>=20
> Fixes: ffbda8e9df10 ("vdpa/vp_vdpa : add vdpa tool support in vp_vdpa")
> Cc: stable@vger.kernel.org
> Suggested-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> Signed-off-by: Xiaoguang Wang <lege.wang@jaguarmicro.com>
>=20
> ---
> V2:
>   Use kcalloc() api.
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c
> b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index ac4ab22f7d8b..b6410a984f29 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -612,7 +612,11 @@ static int vp_vdpa_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
>  		goto mdev_err;
>  	}
>=20
> -	mdev_id =3D kzalloc(sizeof(struct virtio_device_id), GFP_KERNEL);
> +	/*
> +	 * id_table should be a null terminated array, so allocate one
> additional
> +	 * entry here, see vdpa_mgmtdev_get_classes().
> +	 */
> +	mdev_id =3D kcalloc(2, sizeof(struct virtio_device_id), GFP_KERNEL);
>  	if (!mdev_id) {
>  		err =3D -ENOMEM;
>  		goto mdev_id_err;

Now that mdev_id is an array,=20
please change the id assignment as below. Even though existing code works i=
s confusing to read it without an array.

-	mdev_id->device =3D mdev->id.device;
-	mdev_id->vendor =3D mdev->id.vendor;

+	mdev_id[0].device =3D mdev->id.device;
+	mdev_id[0].vendor =3D mdev->id.vendor;

> --
> 2.40.1


