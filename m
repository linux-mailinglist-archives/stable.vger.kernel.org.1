Return-Path: <stable+bounces-89914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F173C9BD58C
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 20:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD821C22918
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC681EB9FE;
	Tue,  5 Nov 2024 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MLpsyJvu"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3411E5714
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 19:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730833240; cv=fail; b=sOb5GSoixkzjAWe91CEDouRTFTBS3bxrqlDOruoMLjxGb67/WMfoYffL9csr+ORmbK+xSNZKdtW6MRyk/2jCA9p7VHN426lG3y8Wsxcj7yQmHSNj5Z9ehErctbd3vY3c8HGotfFP90a1bwC3uq0AwO0HN7qBZcxu6zKjXP8S/W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730833240; c=relaxed/simple;
	bh=Iod7SAk2fij3+keJyoA5wz3oyN5fJ2B42h4AelaFy3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cIzqFYoPxe+n/gewLndPEKie04rg5YMfC+NJfyWkxwo5HhdYzetLauppxhSCxRl/m3B+BqNlQYXOOb/LRpdiWqd14HyRvAkFpI4Q2alr0pQxnr3skAqcPf0aCI7RLgsdgoxWJtaP/1MpkKan7hrnQhDDx58fzr2IbTNdZIU3F9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MLpsyJvu; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEamoX3q6lobo0XbGHmNUtL+8nmtXX4cVuZhhcs6KbutU9SmoKM/LxPi1av7245hAFMP/3g7Xg/6bvD7rpAUkfEr4IP5UXzg9cf5btfZwDI/lnnrygBczSn3DWR6Z6PfOw5hwyXNDi7YrRFVJ4bd5WG9A4/KPdPzPyrST8AvjILaWYXidBzkjoy9eZDOIfUMU0qloLWUHAzU7LP5K9sYdT3D0voM6fB8DDll+20idvfvnv81Z1Ee78fGeGhdVvy9PeVrGkXslBs60UJ9nxcolPCr7mTI59ofY/6hruE8m5DdVyhIw4jJdnEcy8GOCCqf7vPPTKeJb7vOrhrs/Emh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djdq4NdTsKSRS4oFCVzW8f8APlpMvKJcI5tEcczu790=;
 b=Df9ImDXQDicijtrF+INuQQCM6aTx7Ht4QXe49JuAConsMPXvlTtUJztTpZS/J0ESSwQWpcKIUsyZlth+knHovVOgRT18U+jpb/1YuSnT3HNoFsFUX2TV6cInL85ZJsqrO5lr/Hk1LfLmwyFn8jfMRzV6C8Z1wG+YMwsk0zGm6HmXrVtDbE42tdA7SrJSfmYaKk/oWqx4txrItQg0cFv8LnvLxOS4Vxr6QYSeA7oJd5PRSpJHC0yaWfHKWGbDY8Fpk9MPR26C+XSzvCpfSlrbLQk2iqpbgYglDMnzSYkmaU5Q65Rwc1wTaNAgeN6d7sNJPevwlbVwbzJ4Dqm7LIf82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djdq4NdTsKSRS4oFCVzW8f8APlpMvKJcI5tEcczu790=;
 b=MLpsyJvuF0Y+8Yc4+SNiaIYb4mu5LypCPm1p+Je1yQ9GzU4zVjQsIjMqvarH5zPk2bnMw4ljrP2qdU+4HUZfMUiQG5q/AIM5ooZteExDBzmsrIzfNvGRQobjVjKPvpgGfMK9xtZAcSG1tw44Gj+8FFXHYP1bFlMMp2Wo0uFIiJtbDul6XeeUT/AURr3RCK9FtLDmCDU7idnRGJKHhI5IJ7PglnHPeme1BLSZbOcg8SCefPDrU1lnUAZkT8M+bBv+3640xsx0uwqIEL4Chzj53kJtMGUg3LdaVnD/H41kA9zdhw3xowu3Ny0MQDn2hnD6oH2eep1XWKoI5yGbiWnADA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 19:00:23 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 19:00:23 +0000
From: Parav Pandit <parav@nvidia.com>
To: Xiaoguang Wang <lege.wang@jaguarmicro.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "mst@redhat.com"
	<mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Angus Chen
	<angus.chen@jaguarmicro.com>
Subject: RE: [PATCH V3] vp_vdpa: fix id_table array not null terminated error
Thread-Topic: [PATCH V3] vp_vdpa: fix id_table array not null terminated error
Thread-Index: AQHbL4eetjckcoZtvEOa+Ump8W7i9rKpCsYw
Date: Tue, 5 Nov 2024 19:00:23 +0000
Message-ID:
 <CY8PR12MB719589DF823E26B3C7797E43DC522@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20241105133518.1494-1-lege.wang@jaguarmicro.com>
In-Reply-To: <20241105133518.1494-1-lege.wang@jaguarmicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|IA0PR12MB7750:EE_
x-ms-office365-filtering-correlation-id: 9c7ceed5-e8ee-4fe5-129f-08dcfdcc1a3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zLcwljZL4jbkw2VnlB1VU4oDaJmCM6dUBB9B+2hqu5zR3a2OTVvU/BuD5oDY?=
 =?us-ascii?Q?qOxOWCC6r0QYJGYW4SW0VMRP+Ltpr69sc7eUH4s3tO8cZKyK4GQyO8tqIVfU?=
 =?us-ascii?Q?iOkXEYXyUGiGRxh7hXNQLBmC8BDusrsWndRaUwISoICtyuuUQoA8CZQ9bsXS?=
 =?us-ascii?Q?7k5LQstakLzmaClJfXhvbmzjsw76sm6OYFTO5Si9x5KW7y9RvNp4Fg9Lw9JA?=
 =?us-ascii?Q?fo8yP3NszCyR1bAV8NyxewlPgoFqbiyQRzz7xu8XP0WgOvaF0qOR1hqJx2iM?=
 =?us-ascii?Q?p5KMAKKvr3BoX81qXr6xNPTZQvtMvm6+hOdrAGMbKMwrwk7iMp47dSFvY9ob?=
 =?us-ascii?Q?LSuwo/hj1fLV2xmUWEEyEH2gL5dLnTDSlp+QlDZ4CB91m8YFH3cKng46UOid?=
 =?us-ascii?Q?O0tjBYgoWN2ICvhvYXD6KyGfsFI6uxh+6znLTQqcbcHBuIz7V7f301Ipi7qi?=
 =?us-ascii?Q?nFq6v52deSSIH5jPFNtv/ytlfZFz6ehN/K7d3PXBt4Rm/ma6u00sEkzjcPI2?=
 =?us-ascii?Q?e7QNK95xiWDmwwQ7ZxcNeuOOqYdQAWq4/mTKdGhHrTcHWdpI46RRgGaW3RWs?=
 =?us-ascii?Q?8TsSOqscKiNLaLhaQHjSDF8vjHPRRvTwJgm6/yXpSWaXN+fX54SzunsnS5AY?=
 =?us-ascii?Q?1XwqD8698YmFix8Duc8HvcHY0AJsVwVba4EDmzVagEkRywsUmgnf0acm0enD?=
 =?us-ascii?Q?oTihCmZ5bU6uj6vB3dJmAR07+gQM84RC5ErXqx3iv2ALInru9IcdrHy280XU?=
 =?us-ascii?Q?X8Q4WImsLS//22By+NNXavbaNYcWmQrhhF3EPj30xoSLfsJ/WKYs5ldkv/Vq?=
 =?us-ascii?Q?r8LEVSz5t3p5gPxf6JXN5KptnHNcNug8PxPk1Sq/1ib5eRXKI3JmJku76NAu?=
 =?us-ascii?Q?oItueW9hqK3eWp2f0Uvm8rNccVMuha+AE+2WC40Ymm1Zn93h80Z3Z/xD5jLk?=
 =?us-ascii?Q?coMbyT4tlUcXftgTPttefyAoDIUYvCNxMyFO+KsrluHMJdtt1sEilnDVqdTO?=
 =?us-ascii?Q?uGXcS34UPCpKDswfQAAodin48QUv43bWg7GFbFOFcjeWPbUAiKp21zaDu9Pc?=
 =?us-ascii?Q?NH9xp1JV508J8i3dQXc2msn56NF1tDTvhg1kDxydPdqI39UfLdZAnuSkJ2Es?=
 =?us-ascii?Q?R/5X6g6R8+VyXx5TSDKijANrLNSjcuX8/QkHhKAnz/JdVbNEZfkDJE7Ug2mP?=
 =?us-ascii?Q?0ucQV9Vh9vaDpphbAvuaudxA63jQ6+A8MuC5T4suUKjQtkh/niPtfUm+HfFq?=
 =?us-ascii?Q?FKy7SEHzKPkHzSuJsWsU0dKBQ3qxPberSV/ETbkufYACSKH/4UeASsDpBFwi?=
 =?us-ascii?Q?UDDmDsK+vW7lBYp4UyNT+A9X1G00BzAqG7Y0aa2ihTM3ckKyOyotxa6SJSc0?=
 =?us-ascii?Q?LpFZfg4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5pXBTgDHQzeT6IkUIf3Rl7xX0/iIzt0hJOnJvKOtzWAxWbbphhEW3DITeBE/?=
 =?us-ascii?Q?T5WRjmYMDcYzoQT79wjUIKD5bLS5zAuD5aQg9hGzB8wf7YIichxocz8WCUx4?=
 =?us-ascii?Q?MKLcqIKICnGii//hNG2xDdh3Vd1sSibYcedu45SHZVfrOxfK1kSs8/b7RF+H?=
 =?us-ascii?Q?G0rCuL4pMLFigjGvvbwWZxrbzvCKIGRgEgPZvoUw9wfm64rfdTZ9FYSst29P?=
 =?us-ascii?Q?RYedjyCBcCNrixLPL3R0F66tCLz10JaJZq+Yqu44Zf3glXjDvg+FGtlciB6J?=
 =?us-ascii?Q?u77DCJBs/NrFAMJ0IfUHraqe4vCGgGqzPXHUyvc4Ua7Vze5QOEf1LGF1Go2n?=
 =?us-ascii?Q?WAIcWJqamdCpLZMQh637QdDQe+wyoVV5GZmixorZe+3OpU0PVZpOorCP/SFr?=
 =?us-ascii?Q?oIcoxTY5PJq2PxWtfMUSLsr5EV51aDVOC0fx07UCYLAVz8PH7uqcuU61tGE3?=
 =?us-ascii?Q?yEFQcuGQfZ31AbnfjwaHtRY/AmWOtaboJDdqibpryO+3d6tOYZQSSn5KZlkd?=
 =?us-ascii?Q?3owMn5rKSeHxsyg4ozZTsNsR5oSk7PLYOdoD76fF5VXc9K6yr75ti+0qJF3Y?=
 =?us-ascii?Q?CDqGifAt8pQUxu6WKPGxPZZep9xKX9KMM2uoXaK+koysFRXLYda+bOGXsSRU?=
 =?us-ascii?Q?GGQ/8kTqhQHWCqvoUXukeM1TTof64coSXLSzMvAwy5lEs/i5zvWftyiBQvSO?=
 =?us-ascii?Q?jHgl3mYI76JVMeGcVqUcnUXdfpaqlJYumaplOSvDu434CE8FBPsvPx7phyHd?=
 =?us-ascii?Q?ZpF3bFo0oE4yVsRyVRuv6raKAdK0wa0x9GoDicgLaL9BojPTOH24+4deGzc4?=
 =?us-ascii?Q?bTETDLXrIjveOEdGmIAXpYH0MRK8TGjc6Q5vzmiVov5spkBp+AyVVvnHqaD/?=
 =?us-ascii?Q?h8+a/S8GhxTwXOGDHz7+Pwr8wG4thAMBqmWGsZbWNZniNOyZbp7O6VsCYum7?=
 =?us-ascii?Q?ITf8Xwi82OyYi/E7vtdZ/Xk7Cm2L8sq6euYDg4pXRonQkca4mIBWHo0uq6zy?=
 =?us-ascii?Q?tHBI4l8rPfwqIla1VmYAdVXfYeZDvtW/WW3VBuEzvU8SyFp4BfekXikiR1Bp?=
 =?us-ascii?Q?YFiJZDsbod+bjOxwhgMxQws+aEQzgCFvUucS8XxT5EbYwyw+gEgKSxzgXEzK?=
 =?us-ascii?Q?1zyhx3zIH4T03d0KVg+FVjLyvFpJ5ky4DhwdO+G2Oqyc503eQq8oxrg8xey7?=
 =?us-ascii?Q?Di85fwPjUiotXFthUtPDgTRhaI6ekOaxcbjI6ZYV6Es/s1GMJIJu5dMPbnn8?=
 =?us-ascii?Q?J5USifLBz2v2hpVdqsqiA6aKzwpMwSzRBEuzIxBOzqP8hEQwP48JoAU9vLkd?=
 =?us-ascii?Q?5Q2/Jp5/TQbNsmULQidpX46yoY6nQ6jCADncjF6SzeujSKsiX+B+do9xVeNs?=
 =?us-ascii?Q?9HNt7W7ydYMNzBr1nIpUi3c+WHHUrNlOr3Ooi2z584+7rpQyksRHyy4iBsAv?=
 =?us-ascii?Q?hdCQo693kpu9+zDI8rYGm7bcTUNVOxRFn8C3UjPPHvmgxYJqSr1MTDKM61dQ?=
 =?us-ascii?Q?CcXsvZGQvivXN7eiyaV9deu4yKmpNPwn1OTAnha5dqrMMqJOd6KWEWx2nX0G?=
 =?us-ascii?Q?AGQbaNf4Z3Kc+0MCL7E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7ceed5-e8ee-4fe5-129f-08dcfdcc1a3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 19:00:23.4904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 43obir+AkQNDIXs0D9+27eRfLbMRh67lDqbRIJBYKB8k9bFVcmdid+RJRKKY0vK3+CRjTtgWkifDJUcwKz0sIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750



> From: Xiaoguang Wang <lege.wang@jaguarmicro.com>
> Sent: Tuesday, November 5, 2024 7:05 PM
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
> ---
> V3:
>  Use array assignment style for mdev_id.
> V2:
>   Use kcalloc() api.
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c
> b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index ac4ab22f7d8b..16380764275e 100644
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
> @@ -632,8 +636,8 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const
> struct pci_device_id *id)
>  		goto probe_err;
>  	}
>=20
> -	mdev_id->device =3D mdev->id.device;
> -	mdev_id->vendor =3D mdev->id.vendor;
> +	mdev_id[0].device =3D mdev->id.device;
> +	mdev_id[0].vendor =3D mdev->id.vendor;
>  	mgtdev->id_table =3D mdev_id;
>  	mgtdev->max_supported_vqs =3D
> vp_modern_get_num_queues(mdev);
>  	mgtdev->supported_features =3D vp_modern_get_features(mdev);
> --
> 2.40.1

Reviewed-by: Parav Pandit <parav@nvidia.com>


