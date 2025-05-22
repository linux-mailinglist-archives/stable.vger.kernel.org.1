Return-Path: <stable+bounces-146048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DD9AC0674
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 10:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C2C3B84BA
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 08:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB512609EF;
	Thu, 22 May 2025 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g2VoagOo"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6002609EE
	for <stable@vger.kernel.org>; Thu, 22 May 2025 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900931; cv=fail; b=MrcudfYlLcCYBt46rXQh7/NoUZzoVpcAh17obE4Td461kD2s4UvEtZ5SekK+Xx+eXihk78HkRnc+9AY42vWwEzsdD8o9snabwiGn9qLOChLLq9l/iWkPzvD7OPvqSYVfEIvueMyLXEe9279vftOI5ahOt62WlOgQDeN+fvoRPlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900931; c=relaxed/simple;
	bh=CkxQaZeoQGq4ribCkzIM1qKwOJgC/pMUhySTQZfORxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PPjSZFJVbxbj0rth1+x+eBcF8E8STnMtCiUPqnugn0f1b4MlOON2jQEhI4w3QPmfuY/6HRzKg4rBsgJ0G9sIzIWiD/kB/7uuptNvmPi5oc/gPc/SCL7ZaTjHpxGgWMeOW5/1sy1X9qBEg/QZ6F/WBxj7qHKSHKVusGKV58/ImsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g2VoagOo; arc=fail smtp.client-ip=40.107.96.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQEv6mG27+FkSvnr6Xm0mFEQ2YRJcOZI1Yj0d9Rg/Aw+M3JmR4j+gYbjQrZcIe7uxtvJ2VZZqajaVnA8GKFjbYFbhruyvUatUTmARpV9ZFI3up9BtvE0vikczbRBIrfDkDt9yUxc0NiEnNJU78juWjr4sqeBYi+XEL0qzkjEwX8euFDxFSA5aEywZSLpCE/JvCwvlkOx3JUM2fTEARtIKn94Ue6YHMIXPzhiMLANBRH81DSXVV/e6ikOvsrjVbwr7tKM3Q+jV1ROUXOrREj2XmC7Id7w++jrURSP2BnaBzgjNkvCdwNpkVuDky66S2tO3hzn+v5r5gqlsu6aYjqpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlY51vV65/urR4aYF3iBIDHCI2+/0aVoHElpVLPd/jc=;
 b=XwI6L3KMlCeVSypCcWh9Cwa41OSDsnzrm2AhaM8iES+1IMcSvkuL1lJMdE672Qekb5YJeSmUg7tbf8e9fzN3URzn6jkogDF/pl9fO1IceFpEma53jvZSyG9lpLssi29ZzHnvXES6150h99FVMh6D/etXlvsj5fsCeTClfKBVspOS3pIlbAevle6dzF6FeotgrsiKohGavWk2iZdQBCI+G0qYzHsjqNa5dc2+yZUUPWzpM7wKi3DB6CrBrfWGelOPvjsdpToVVe95NYxXFitPvYBCiGKpfq7aXIiHV2Vj7GXAj5xsK0HUqxlqC/rliFbriV8slD6t3VZjDYyuin9giw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlY51vV65/urR4aYF3iBIDHCI2+/0aVoHElpVLPd/jc=;
 b=g2VoagOobFSqzhTnDxu4OHrN2tyEXmbdz81LtLkh6L0ejpKjkE4mScKpyFPh13/KuzyBQKdFV6eSUpmPNW60WJRn5C2iiqWGJdfyCRrIJGRtAtKgWWCR241yB+7C8b3jLZ2cUX+0zZhuRPCxaNZB9/kxcmkHR2RgN5O5kakfay6ZlIdvHjtvfAD2/gJ2Y54wYkcf13VxqSXpfE2rhhyUOBsCfS5/CjgSEqFfUdsUvl9E1uNiX9y/L5UA2V2ZSj952Kho51EdpvezNmUqLdoTM2ZcG89xXs7CRvMiEhgIPbhzAPCTSb/qtw+z1AD1bf0dDUXrzC37GDmIqanVSEcPew==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 08:02:06 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8699.026; Thu, 22 May 2025
 08:02:06 +0000
From: Parav Pandit <parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "NBU-Contact-Li
 Rongqing (EXTERNAL)" <lirongqing@baidu.com>
Subject: RE: [PATCH v6] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Topic: [PATCH v6] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Index: AQHbyu4E7Qf3y5LdTkmg/66Bf3LimbPeSXXg
Date: Thu, 22 May 2025 08:02:06 +0000
Message-ID:
 <CY8PR12MB7195BB4F987E9826ED4D35B3DC99A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250522074905.26874-1-parav@nvidia.com>
In-Reply-To: <20250522074905.26874-1-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|PH7PR12MB8593:EE_
x-ms-office365-filtering-correlation-id: 3bd278b0-7690-495e-a0ee-08dd9906f1d7
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?23om0ZRlLx3eewmq7D039CzE8wMz6rpSs/iT91pt37UVvq4VN1o2wj0laLuc?=
 =?us-ascii?Q?6w2ud1j3hbHVgIxfVJmND3GxEyDb6wyQZV62kKZaQVLbw770cmwQyuXmKsY0?=
 =?us-ascii?Q?FlDSVb6oUGeYH30AH/L+AZQMVoK45gy28naTZ+B/GU/pyxasu9T+v6zdxuE5?=
 =?us-ascii?Q?jUD6EcGrngUWfsELvOFnSBbWj8HpufiVsCnMh2ASB8ryofM9/7I/uIRVy5g+?=
 =?us-ascii?Q?U9TgrG9ebQwQTf0ZVmeu3KQ4IU7CyfhejO8BDsy7wjuJ2ETcgrZwEHab3rOR?=
 =?us-ascii?Q?A+3HqvnxuUgDZFX1ELUM0+NM6Xc3Zg4FaAPZZPPqTd1U2mP6NydG/zpq2qzr?=
 =?us-ascii?Q?ho+aQ6JpmQxDnSRuK66RZ7H1uz3xEfi30JqBmXbf8Za5brPWvOvL36KUkZhc?=
 =?us-ascii?Q?Qte4hioaAgAX3h0cdzPnorCVXb7iMIj8kLUP+SJRzByz7FvxWcw70G0+dM1t?=
 =?us-ascii?Q?aZBOALsEZItrWkPM3LV4fq4fIfef9O+Hh8DOts0JItNF/juuXph6aTXkjGcu?=
 =?us-ascii?Q?fBn1E0/EWyemwgJJPi7gFAbqxRmvllBaT6sz8aZOQWNF8EVtkvMZH3hjm0pL?=
 =?us-ascii?Q?l1En00xJkPLavDxmKeSw880+3vST+RGs3f/oSo9UN0md4cQ95x3zxTSXHQEr?=
 =?us-ascii?Q?SV6z1c70/rczrxvdFQnP4xLmjDjChqBhTn/6/mKqp7pwyML55SzDaQJRPaYf?=
 =?us-ascii?Q?EzXfIUxuCPcMGZ+9PV3Nhtr3L7d8gfCR5x0gsrAhspCa5Fym2K327G0Fsv/3?=
 =?us-ascii?Q?4MiQlqjDYgNG5u9/xoycX0WdPo2JRYLNWPlcKmGxG4OIhsObET8oMym8z4ts?=
 =?us-ascii?Q?wR5ZmWYGoIWQle3oiJR5D025seaqZqniicVEOFN2kXqqa/dnrbd05cVuZOdv?=
 =?us-ascii?Q?ZECkE59P+Y6u9SS5l0v4wF/Hvxuw83dRABMLQP36GVigk5qwCIHPO0gUibHu?=
 =?us-ascii?Q?BsdbE+o1+7nETVdRGdSZgOsjX+s8QWLk8K1x5CEVQ2FY44N/56D9QDF++RbQ?=
 =?us-ascii?Q?2fEqs/ZL652+t6oHullos51WG+r5uhogzk0ABULJprNU+YSLQBSA4ngf+TE9?=
 =?us-ascii?Q?DZk8hKWiR15DkB2XHu4Cn5tFO3m6r1GDc8bbzmSph5m3qP58pgpUSYPCwKX2?=
 =?us-ascii?Q?cEz+4fNMZdjXUjHN9jtYYjJEWZtqHfiHJZ/h8IkEkVP/YaqaWrecUaXoOKY3?=
 =?us-ascii?Q?2lttTqR+HhgEmPf6Ti6AmgiWm+HqIinEU8OuwcuarJY8Jdp3VijH5/gMcVWf?=
 =?us-ascii?Q?sS93i141F/RFzFfP9QzPyZpuS2PgV++wSbbmMsAfzf6k8DAFFewfQyBrBezy?=
 =?us-ascii?Q?Y4UezU6poaMkaI05ZmHC1NphawjqWEcuyyf/BwDKZDCoDu4jwoD0mblEsj03?=
 =?us-ascii?Q?VlOls7C7Zbp3w0EK5ZoFReLxIr8gDd9R5ZtjFwb7L22IhJbVaY/D8leldmPj?=
 =?us-ascii?Q?c9OhQ2bC1FgO21+CsBqF/XOwdot0vkbkTBtWDCbfwkZOhcprPr+lTSmOAH0n?=
 =?us-ascii?Q?yb7kB/NVngvA/yc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7HzfW7BHwYC2e+4b02NTwdrnTGxiFpWQVPypcY67GuwZJjCs45/vb0bpR2/z?=
 =?us-ascii?Q?J1zlGK+/D/CVyrr2bmFx/YqJOQmXOqtgkYouOKhFvGqi/V9vN9B+OJyBuy9L?=
 =?us-ascii?Q?v9CkDHvPqZo55OOX/ZLvDimU9SwmNbgS8k53J8+WKbWiPI+v7anVl/gHlagD?=
 =?us-ascii?Q?/UwjOfOa5fQVP7yXTub29IBGne7fLacqbqiJJ/Grjpszl5gW6jlKLXd58Sl9?=
 =?us-ascii?Q?JaEm3671kkT7Md+YOopvRiO/kZZFth8UOOoJVeSOgrQX2HjHcNpUdS0YArX6?=
 =?us-ascii?Q?21KGP7XON9jNtwvRlHNmAremxFUn5tei3sct1O09VVXDBXkM4US5XelMWRDG?=
 =?us-ascii?Q?gUH68ecRURqzFHVTPEYqbc89nlVJ92s9q2/u+Dmya2nUMs1lxWVPFitTW6gA?=
 =?us-ascii?Q?zjj4nV2tm0G2losMbq7MzYZcMfMhVywnJ7I0d5DJX5JnkyxEnjsUaD/krRBp?=
 =?us-ascii?Q?YGtvKqf+DjiVj8Gj+JXO9CAjt/qS+0TLdGOryx/2KAUt5JS1EvCxKF00t8YD?=
 =?us-ascii?Q?06EeMEu6jYCWnNjGrkc1uQG1NlRkjxB2ievjqmOq0mXO8Eq/BYdiyYpu5fxW?=
 =?us-ascii?Q?rtXcG9NIJjjxfwRuqrDKb2twHCe4GOVgEKzy2NITLEg5Bx10KmX7BAajb7P+?=
 =?us-ascii?Q?Hpg+ntw4e90V95Fqs0qdoXMOB55mgbj8tq1vxfvCgIZdL+YV9XMqGoifVCUN?=
 =?us-ascii?Q?CG4/YjfROkQk7/ODFrkSHWsny1PBzoVVVOuUP65HXk0vb1d6h2YUCwSqW9a4?=
 =?us-ascii?Q?oxly5M9+NKlPyD/9eLtwuxDafseZVW5ct8q+AMcL7f+0gD3iZNelwTUvk7nm?=
 =?us-ascii?Q?EBpYBN5BFB5PDOWjDErPBMQT0Gjp9Gz3VCpU47CWwvKQ0PAhgal69Ng1Nqn1?=
 =?us-ascii?Q?HSy2ZT7uOgcd80zW4BhXy7f0Hx5107nrI9bO4dsq+qQeAXY6BPm8/srgPTLY?=
 =?us-ascii?Q?SO2fcDMYfMbTVhHTAFczT963pF+X+nxSEjrbSnkWKnTlh+wSu5nqWsjQyGOu?=
 =?us-ascii?Q?+aMHcFBgZbBKTXWry2lRPN9Pz6lILFptjzas40p0KgBED9Ynjla/T+FYdRdB?=
 =?us-ascii?Q?Hx4xOdNzyc+tPuMx/nb2kJc9lB5pR5LqNXLn9VJ8A1wvtYjBMrAjQYSuKbmY?=
 =?us-ascii?Q?sz7kHQAn9lCuVfM+/FrmO7dyxbDnxITg9pNWghJTqmxvUF451RpTzoGj46mW?=
 =?us-ascii?Q?4A3WoxP52Ml81HNqFmLjrOfUS7ZewyVRjVspMstBNrO1EPW+G9YiD5ByJfsp?=
 =?us-ascii?Q?/0+V4t7jB0ooBkJOHYIPv73GXGcemcpwOibo0tQiBpl1SiXHYa3vgeocRP07?=
 =?us-ascii?Q?zpobNYdZP/rYtb06ZzpK02COCdeAAtY6iZ1Jiqj2uzyhIg/5cPCAffXRfpfW?=
 =?us-ascii?Q?8cYCm6SOsYJ52FAYxLhPJ07bEU9CCg9klQ7Y0u8x7p0gbAR7+Ag52jAX5bTR?=
 =?us-ascii?Q?qIAzL+aEf+OktyR3BJihpKF6Nczk0lSTj2RfvbaucYYVVeLFJD0Pw5tRhc8o?=
 =?us-ascii?Q?uj5kL2Dbhrms1vRFdSi8L9I0u1yfZ4L6SJX3Hhhkkf5svfP1VdLz2qn9w+6x?=
 =?us-ascii?Q?u0MqNf/yDFDFFWvc5dQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd278b0-7690-495e-a0ee-08dd9906f1d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 08:02:06.2574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1hDaf62IzB31nZ2wKokn2/g0VSU3Oy4d7/eWtmI1Han4+pMgs+xqYItoh6pRqrFdXNLOWLFEExbkpD8lblzvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593


> From: Parav Pandit <parav@nvidia.com>
> Sent: Thursday, May 22, 2025 1:19 PM
> To: Max Gurtovoy <mgurtovoy@nvidia.com>; Israel Rukshin
> <israelr@nvidia.com>
> Cc: Parav Pandit <parav@nvidia.com>; stable@vger.kernel.org; NBU-Contact-
> Li Rongqing (EXTERNAL) <lirongqing@baidu.com>
> Subject: [PATCH v6] virtio_blk: Fix disk deletion hang on device surprise
> removal
>=20
> When the PCI device is surprise removed, requests may not complete the
> device as the VQ is marked as broken. Due to this, the disk deletion hang=
s.
>=20
> Fix it by aborting the requests when the VQ is broken.
>=20
> With this fix now fio completes swiftly.
> An alternative of IO timeout has been considered, however when the driver
> knows about unresponsive block device, swiftly clearing them enables user=
s
> and upper layers to react quickly.
>=20
> Verified with multiple device unplug iterations with pending requests in =
virtio
> used ring and some pending with the device.
>=20
> Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci
> device")
> Cc: stable@vger.kernel.org
> Reported-by: Li RongQing <lirongqing@baidu.com>
> Closes:
> https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741
> @baidu.com/
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>=20

This is an internal patch, which got CCed to stable by mistake.
Please ignore this patch for stable kernels.

It is still under internal review.
I am sorry for the noise.


> ---
> v1->v2: (internal v5->v6):
> - Addressed comments from Stephan
> - fixed spelling to 'waiting'
> v1->v2: (internal v4->v5):
> - Addressed comments from MST
> - removed the vq broken check in queue_rq(s)
> ---
>  drivers/block/virtio_blk.c | 85
> ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c inde=
x
> 7cffea01d868..04f24ec20405 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1554,6 +1554,89 @@ static int virtblk_probe(struct virtio_device *vde=
v)
>  	return err;
>  }
>=20
> +static bool virtblk_request_cancel(struct request *rq, void *data) {
> +	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(rq);
> +	struct virtio_blk *vblk =3D data;
> +	struct virtio_blk_vq *vq;
> +	unsigned long flags;
> +
> +	vq =3D &vblk->vqs[rq->mq_hctx->queue_num];
> +
> +	spin_lock_irqsave(&vq->lock, flags);
> +
> +	vbr->in_hdr.status =3D VIRTIO_BLK_S_IOERR;
> +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> +		blk_mq_complete_request(rq);
> +
> +	spin_unlock_irqrestore(&vq->lock, flags);
> +	return true;
> +}
> +
> +static void virtblk_broken_device_cleanup(struct virtio_blk *vblk) {
> +	struct request_queue *q =3D vblk->disk->queue;
> +
> +	return;
> +
> +	if (!virtqueue_is_broken(vblk->vqs[0].vq))
> +		return;
> +
> +	/* Start freezing the queue, so that new requests keeps waiting at the
> +	 * door of bio_queue_enter(). We cannot fully freeze the queue
> because
> +	 * freezed queue is an empty queue and there are pending requests,
> so
> +	 * only start freezing it.
> +	 */
> +	blk_freeze_queue_start(q);
> +
> +	/* When quiescing completes, all ongoing dispatches have completed
> +	 * and no new dispatch will happen towards the driver.
> +	 * This ensures that later when cancel is attempted, then are not
> +	 * getting processed by the queue_rq() or queue_rqs() handlers.
> +	 */
> +	blk_mq_quiesce_queue(q);
> +
> +	/*
> +	 * Synchronize with any ongoing VQ callbacks, effectively quiescing
> +	 * the device and preventing it from completing further requests
> +	 * to the block layer. Any outstanding, incomplete requests will be
> +	 * completed by virtblk_request_cancel().
> +	 */
> +	virtio_synchronize_cbs(vblk->vdev);
> +
> +	/* At this point, no new requests can enter the queue_rq() and
> +	 * completion routine will not complete any new requests either for
> the
> +	 * broken vq. Hence, it is safe to cancel all requests which are
> +	 * started.
> +	 */
> +	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_request_cancel,
> vblk);
> +	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
> +
> +	/* All pending requests are cleaned up. Time to resume so that disk
> +	 * deletion can be smooth. Start the HW queues so that when queue is
> +	 * unquiesced requests can again enter the driver.
> +	 */
> +	blk_mq_start_stopped_hw_queues(q, true);
> +
> +	/* Unquiescing will trigger dispatching any pending requests to the
> +	 * driver which has crossed bio_queue_enter() to the driver.
> +	 */
> +	blk_mq_unquiesce_queue(q);
> +
> +	/* Wait for all pending dispatches to terminate which may have been
> +	 * initiated after unquiescing.
> +	 */
> +	blk_mq_freeze_queue_wait(q);
> +
> +	/* Mark the disk dead so that once queue unfreeze, the requests
> +	 * waiting at the door of bio_queue_enter() can be aborted right away.
> +	 */
> +	blk_mark_disk_dead(vblk->disk);
> +
> +	/* Unfreeze the queue so that any waiting requests will be aborted. */
> +	blk_mq_unfreeze_queue_nomemrestore(q);
> +}
> +
>  static void virtblk_remove(struct virtio_device *vdev)  {
>  	struct virtio_blk *vblk =3D vdev->priv;
> @@ -1561,6 +1644,8 @@ static void virtblk_remove(struct virtio_device
> *vdev)
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
>=20
> +	virtblk_broken_device_cleanup(vblk);
> +
>  	del_gendisk(vblk->disk);
>  	blk_mq_free_tag_set(&vblk->tag_set);
>=20
> --
> 2.34.1


