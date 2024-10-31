Return-Path: <stable+bounces-89390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41FA9B73C3
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 05:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0415B1C22082
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 04:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D18513C8FF;
	Thu, 31 Oct 2024 04:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UfhOjgLc"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253A4126BF2
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 04:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730348079; cv=fail; b=gSTQBc4vEqXMEpG1f2CzYtv68J+GQhtuCN/tput3zumsDorXg+/Gvuq7PbSd+PpW9m9wjl6s834L+GGZ/yaVrGILT7J0aLzSvKlw5Zbz8fKGtMFxpF/TQyb/+h5RykEQyHng0lfboWIfc0OBTGF5emaFB7I1cRgFVD8cTTIqWVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730348079; c=relaxed/simple;
	bh=XUYuiBnYtT6AJ7qRAVXgGowT1SSy7CTYTc+4UkCYyn0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qnPgTzON6UI8A6p2WefGjLrEKVK2iCv8X/mwoQZW1xZPq1mXVeqmwZtHpW6LfE9lzD8Ifmq13WdXBxVrjWyy5pBHUI5OVV+fzNSdart2Nto/JF9bF74Yh62W0HQbMrykf6OzUAgmXGYDaeK6y9yxwn7CzLLLw2uyfitOYLAmFzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UfhOjgLc; arc=fail smtp.client-ip=40.107.96.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFGzALqT9T15eCM0AJe4gtGyUjAHxtylz8MOkMS8HGEDCF0eESlpQ27Keq33odaOhL2ECOdnQXhOuop3HFS8NMZkZIRDDcnEC/9YDR55S5gb3mX7/r30R6N3cHlIxOjZUDeE65g4XoicyIszP3iB1BoaZrPXizO2K0ljNlKgoRAHln+/zhvN/WjNXI0K/RzO9cVnD9YX5YpPlRVGIHflXiHF/rdjzh+/kV1/w/nGAoK/cw3yYLrHY+peCZWSMf2rlGdnuetGxq1neWdxCGNxCTge/qFTB2sS0HbJK9yCd0nCF8/Qxj+VK7Yuux8KaR/9yQKiTxzTGkBchqlZ/VEI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkX7VmF469FiHYwimaE80EtqAr52finuWYJ9TBtiZmA=;
 b=S9caE7E4ozrolnVVGaVgMYqzPEL9CznyGwFa/FkhW3rfjUJvYM30z9fB3cohfY4D03G5IYSmSskdKks7Eh6f8cu/9xQRAMaiZf1otsBT6DZGE7koOsv168BYTSlriu+gq22PuBO7SsXZQDyIUiQEv/PiZChOq8da3d5PGRjth54leOvMzUUd9gtOVaRycJp0XldqhXa/wqJxwWQIlXC/7OJh26WQLwNqpEvKN7d+EE4+i1pqC4SVRAP6TNVIXKrUe6pLoZD7ySyJKJceAptBIczNv2IB5UwfytyykYiz/OuYgt5Yo5zJ0RM9ayr/b//i3bzGG1Bje9CDgd+BnI5+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkX7VmF469FiHYwimaE80EtqAr52finuWYJ9TBtiZmA=;
 b=UfhOjgLcQk2xTzfi+ddg+Dj6eg2+mFcWfGqyj5AWJ586/rIgicHY70Xeo1HwDqZxrpH06heRr9WrUnF/gKI8muBMhC5xU9ZWUR+E2rMHZEmoEX6FW6BrUZzwp3Pw2UE1A1I1Tv5/QOcqwHLkpiIawVc6FtkCuBw02a/VJafVA38RKgTCq5lDLUDEo+HdfK+V1/Z1WJJYDhXvJv0kGtU1IS7YQQZxe7RjJrR0i66LErdeouizDsKL1Bdo3TP6rDE7v9b4UZ89jbmI+qfd8twJasb7wY96GSg4J8cwNJEBQsDMY5jizpuagbDv7vqZTU2OLNCx4kSgev6liB/vyc/4CA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 04:14:33 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 04:14:33 +0000
From: Parav Pandit <parav@nvidia.com>
To: Xiaoguang Wang <lege.wang@jaguarmicro.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "mst@redhat.com"
	<mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH] vp_vdpa: fix id_table array not null terminated error
Thread-Topic: [PATCH] vp_vdpa: fix id_table array not null terminated error
Thread-Index: AQHbK0osxYombZG26EWFJPY0HTFt3bKgPsLg
Date: Thu, 31 Oct 2024 04:14:33 +0000
Message-ID:
 <CY8PR12MB719540F6E6CC0A6AAC2FAA5DDC552@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20241031040514.597-1-lege.wang@jaguarmicro.com>
In-Reply-To: <20241031040514.597-1-lege.wang@jaguarmicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|BY5PR12MB4097:EE_
x-ms-office365-filtering-correlation-id: 40c6535f-a33e-45cf-71f7-08dcf9628658
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xTUDcRcOiLDlwspkNpJXgHDnAioVtVQIXFDH2NTUXFgpgQhiJfsMHjjiT59e?=
 =?us-ascii?Q?RjdKh8X3v3Dtejp/ljnqCJ27K+suduSZujHKQd8ru9eh45AHl1hK46a6E4XH?=
 =?us-ascii?Q?XuZLCCdNwB10XTkChlMKz9qHZHCXCzskc1yw+KcK05D/6Bn/ESIFy4PAB6f0?=
 =?us-ascii?Q?R+V7+y/eS1ZWXAHyoXzrxrDGXuNmR0pF2vlK0su+ELeRnaJG2Nkv2k/vyC1L?=
 =?us-ascii?Q?TimtuwnO2V8ymJ7W9b6mhMoP8P/n6jEjhdxrcJj31G957hGVT6knaoJ8HdYM?=
 =?us-ascii?Q?gOHxyW8yrI2Jhs+vnHg7+fMcy2WRxVwVxS5+H5IZ33R0UWsLamJnxSaG8Zbp?=
 =?us-ascii?Q?2DsS/5regm6zoMECtv4Fgtu8Y1V5av9x47iHeLrXj9e7e1MooGiuO3Q6uzpZ?=
 =?us-ascii?Q?QLJWQm5QnUkcdUQvMcUK4PKQhYhqEzUTWtDPnM27mQNsvgPExeE4pa0OXMhB?=
 =?us-ascii?Q?gNF67cLN5xFrvuuXTstutlMzk7jFxxIcR2C8266Wb5CL+rbxwj7Hj5ioBGQl?=
 =?us-ascii?Q?1NVNGo45+maODBGt0gSPAKq+wRumPtmH2qDkp4Mfy9zxxBdwKKfCK/7c67LD?=
 =?us-ascii?Q?22GVmU3Ln7U4+ZhsITt4HF63Ag7CZp7XGtfDMdKj7MRaa271Li0Xojxw8Uxw?=
 =?us-ascii?Q?K+q7/N5YHmXsuiqJWiuyGOFjb/TYHSmqFns1Fk49X5DDC28T4vf9s9wgKnfS?=
 =?us-ascii?Q?VKs1O1xuGZ8Sl7dD7OaQIahvQ1lrLe6z1lXYrp0GXK/cDkS5wBEH9miogqcK?=
 =?us-ascii?Q?1OkccfZP8uDDPVkQ0itWy62wiOwiA8XyeeD5QezX8U9bTHXenJkbHbk0lkHT?=
 =?us-ascii?Q?txZ3U1L7l241cjqexfdjklies2eaLw+JC84MNzYjCAF1XhRcqumAB5nOrFMv?=
 =?us-ascii?Q?rmHh5jR+avjthp0BjG1010LPpN/zlUiqE3+7paNwGqaHLzPxM2Gv9vxs8IKr?=
 =?us-ascii?Q?62CxBL7/LZED375nXVdFv8+k8X1zf+myVsikoQiU0uHCIWQyjtgtiY59nCX7?=
 =?us-ascii?Q?PbUBhCmW73nZP9vNaJ03901XgTDFve1ObOHjLocPwnOe6y0AGSv6yoP7eBmD?=
 =?us-ascii?Q?9rEF4CTvXZG8GS3lm/XHNIur1ca4ew0NV3Butc0SBKKDuts6PaOIMXA/TPnY?=
 =?us-ascii?Q?FXiClUo9RscwE+P7gf36Rc/dz4xJ8KRm5iNX2jsTZWjb/dkE/NLKo7UkNV/B?=
 =?us-ascii?Q?6ah6ATYWu3rrjSQELDoQEWsr/Thv/g+CC6t8Cj4tglZLhmhvEUr28vaWbYrk?=
 =?us-ascii?Q?ww1/gEU3/bwDC9/IWDClcmpQtNhPjHNTUCBZF3PT9hoQMbICtu2A+NwyOu+n?=
 =?us-ascii?Q?PPxvlHQJ/6eahAmy+z8VLsj/lpTT5+0jvh7lokI4G/fJdMgJJwwWP8eJecv9?=
 =?us-ascii?Q?KJw2AJo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dcAyJXFjJe5D35m6E3b2filKzDADbX9fooSlfiXjteMQs6gnFxSTQJQjsOoi?=
 =?us-ascii?Q?werlHXsDRHWiQWtXLWLbgyfssP7gC+nAlONqd95oxL0/uVv59MX5QR4kXFjO?=
 =?us-ascii?Q?1/l3a8uTqTm58SoYuTM1+aPfyZ3g0eLlrNS4FFsaULNluNRzc21GHZiSAO1H?=
 =?us-ascii?Q?Ecn2Yt7qYTIRRScV1v04iZKKqhlN+gHwgjHI6mnuAWcLY5Zi/1uX3doZC3Xi?=
 =?us-ascii?Q?aScIZY6f14aUK4FGrWanAhs1lnmZRt0WdDH6+kOpGZPaK/3KYWFaSh4Uoe5v?=
 =?us-ascii?Q?aNpqtYkUksPbxRGSLiF6DxO6BAQNHBo/Et0LQs/cistayEqMlcQ1bEMphLiC?=
 =?us-ascii?Q?fZODCCbpGQhHzGq0ggE0bbmbXCSy1xz+Zq/AOwkFFazvdjJnzdS1udgRskJp?=
 =?us-ascii?Q?YtOP8HZRJ8GuTaU/I6xk6tbslkX9yZhnZRLdeLg0be8qg1ZdCzcR+H6qexm8?=
 =?us-ascii?Q?3zb+RG4QTJ2FCffthxJnGArfLvG8fwOE21cnTEJnawOKI7g+ClnYJeVNDcop?=
 =?us-ascii?Q?iUORnbOiltUXffidSFdCOkcW43oMBiuJMxmTMp+k/X+LXFNzXokdZBJpU0o7?=
 =?us-ascii?Q?s11AS5fgFatxyvckAtFdRRVFvYwEcO7lfZdHQ34EwX3u4xjYR+Q32ufPJg6E?=
 =?us-ascii?Q?1NrGAF85Ic3M34PzjPQLceEPtH198A6EIcG/4sITiAFD0uwzMpAmvK2vvoJs?=
 =?us-ascii?Q?GqVmegDoj7STKIhsU9KUbfAKN4s49z6WGMcZAqzFjGkyXXJxUbcxH7qf28B5?=
 =?us-ascii?Q?pqp3caw9RbfnFQQ3dq+RuhY+4fDK0adSS0903rVONYhp5M/mcp7WGPByJc1f?=
 =?us-ascii?Q?LnDh/oliNfvv0BjdODyVvEATmHgdgnU+Ge+B1lh1K4JvStNzEZ1kFRrFgdqA?=
 =?us-ascii?Q?+CCz38NXTQuKMurk4DRT0vXKW1TwENe1i+MwzQmXY4D9apeOK8lYgIbDCP3J?=
 =?us-ascii?Q?B48Wptf/g8Qpac5ONjt7VOqOpbKHM6J8NiFcJbDYUWHPMmQMV3KjXbqBNlIh?=
 =?us-ascii?Q?dZv5oTpP55+8lSKaFQ19iNdZlCQIktjl7ID1bXkPHLYUqs0dnpG0JSYoHHrm?=
 =?us-ascii?Q?sHQqUEsE2MH2dTqm89D/GaFSWtI5ooPsr18GSs/A4nbY1WMcuLWN/CZ98Occ?=
 =?us-ascii?Q?YcgPCEklsKNhpALTLNceUWN5mXwAKXKkTTbCjKrDxt2DtyFY0CIMwEcyYn5i?=
 =?us-ascii?Q?+q70bnDILqtT8wyCVfzv3C3EA6XPb8Sy9KpqfSyJcRvnxqmPKia5NiY9ofS1?=
 =?us-ascii?Q?Yn/uGdNkYEqLlUanqCW3gpSjXRwO7d/otyKS/LRlbGMXpBrtKgCMG4dpbN9Q?=
 =?us-ascii?Q?4vKpuTcybfE1zwUhpGqH8q5pF8FHkLWhu4RBzTU3IF9DdDNCUWeWP8ur8UjP?=
 =?us-ascii?Q?l1wZwA0RsFwMOIKMNnuBkCtPebJc0YC9KdHwCaUyNUmOh5ouCS6cvx5xBdo1?=
 =?us-ascii?Q?zd6v0MzpCwQLrZ9GbqfiCCC205rkh/YcL+/OKrY5LQ5kqRo+NjhUOn1yogm0?=
 =?us-ascii?Q?LCHw2CqkP9ITsasA6juPe2DPnfm4fo5Rw8pbRXEr8AEpU9cwHmgflV6bi0Xb?=
 =?us-ascii?Q?pmsQcaMnwwQIFtlvWjs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c6535f-a33e-45cf-71f7-08dcf9628658
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 04:14:33.5470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UMT4rRLsNfMVRJ7an7eNxCDjmJHpCKuLcgjUxZ5rhwbBkQ12K6ZDFmJ/IRBkoWpMRwLWUcMeJT0U4+5gGVW7aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097


> From: Xiaoguang Wang <lege.wang@jaguarmicro.com>
> Sent: Thursday, October 31, 2024 9:35 AM
>=20
> Allocate one extra virtio_device_id as null terminator, otherwise
> vdpa_mgmtdev_get_classes() may iterate multiple times and visit undefined
> memory.
>=20
> Fixes: ffbda8e9df10 ("vdpa/vp_vdpa : add vdpa tool support in vp_vdpa")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiaoguang Wang <lege.wang@jaguarmicro.com>
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c
> b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index ac4ab22f7d8b..74cc4ed77cc4 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -612,7 +612,11 @@ static int vp_vdpa_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
>  		goto mdev_err;
>  	}
>=20
> -	mdev_id =3D kzalloc(sizeof(struct virtio_device_id), GFP_KERNEL);
> +	/*
> +	 * id_table should be a null terminated array.
> +	 * See vdpa_mgmtdev_get_classes().
> +	 */
> +	mdev_id =3D kzalloc(sizeof(struct virtio_device_id) * 2, GFP_KERNEL);
Only one additional entry is needed for null termination. No need to alloca=
te 2x memory.
Even though you have only two entries. Reading code as +1 is better to unde=
rstand null termination.

And for array, you should use,
array =3D kcalloc(2, sizeof(mdev_id), GFP_KERNEL);

>  	if (!mdev_id) {
>  		err =3D -ENOMEM;
>  		goto mdev_id_err;
> --
> 2.40.1
>=20


