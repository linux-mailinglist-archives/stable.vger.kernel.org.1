Return-Path: <stable+bounces-131955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C7EA826B4
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 15:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48A67B2F87
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF7C25F960;
	Wed,  9 Apr 2025 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p4azFldi"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D325E828
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206625; cv=fail; b=Fw47ElL+N1fVDeeRTTw4Eqy7GTxwTwZ+W0E3FzAmnM0mR39fviCjTLWW8nN2dpjyPqShoUoQQsWGnH4N6xz0Pno48vj2NlyFdAHbBtzzqySa2+tP/yFIZ7KfLTJhC2YsJDolTaTGdTiysQcAOv66FlaDQUhbNZkQnfm8kGcgC+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206625; c=relaxed/simple;
	bh=BX3GnqKXYFBkSBim5/g41CeZZT9hM5430BrBMvYcVME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fJv6Ed7D2Z4b1arBbXn3na4xuQLdynLGFwoMF2p9Mbl+vy1+gEwdm2F5aT4xB3xPDhPQEen0kyPcLiqjxInfxWv6Nlkdyp7Y8Ext6fw9DHUYdhXZ24fhaDs9U+MQ4e/p+RXjNdkRLnRoFq52AnoQh+C+Z08g8QgVjGXDiPHJxYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p4azFldi; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xzh73T4MTkC3MCHO7pebu4IjyXHbj6HRfUVesjLSLYkHPT8BRp5mCHeOczBW9KSnQiQOIJfpMzxwxjF3S0aY9hYWHiKcr5KKeqr/4zwbYN450MP5ivkKhFRDlFMxew6qC8JzSRvB3M/RS7HCgNRhMczaLHGp0ZEcws8wD4bTg2K+Z45wYETKN7ziCb8BomrzCdCw01YRV18PP4vlFIyACKigLmoSAk2bNJeZPZ7lZx0JqRwjdAQFDJ7arElACSDiX/KlzkJHJSTwN/ca9h4PITlaa2o0p0QvjWKtB5x1yF9pToDueIcU/Jslz96CSl5UHzRZ5Z6a+mfktbrbM4JyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnSYaqXy2aJ3hLhngB7S2E+ScbJ+HoXUeWhqvcozTW4=;
 b=jP93vGSps5Y/mzDgEnxUPARHepdiqstQE/y19+RtyW4rVUzvxi2+9naf8+BKW372jJw/+/vQulDang14RR4dpdNVOBdZqC9vrgvQVVQ39aGwNCaxRIQ43cJn5eUZ/hNet7QtEE0xcQ0E0Vx/1u4pk2xsTCkUfaoRiihz8cjhELXQ7QTV580JDYrw0izrR7dxScca1YVPgiOx7ok9Cr9WJ2fyXp0jOfni3FvKN9Y5kfqwnm3qZQrN7HSAUT/SIspl4bj6iehkMaCEvAYRUyE0YO1sIFoPnQ5hguzAmHsV7BSg+f+m0VIpzPV9C55M82vw6ZJ8qEjkw9QQtRqkladXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnSYaqXy2aJ3hLhngB7S2E+ScbJ+HoXUeWhqvcozTW4=;
 b=p4azFldiBOH9Kh+iQcqe88HwPMUpN0q9c3Gprvb1yMbTxUKfIUv/M2/WHW8rPp+lO540EVpePZ6gzi8DnmcKP1saSIm8V+2zzVnsI7qh43zo2S6MHHE/mgA7tunT9x5QpofhG7PnZq7Get798YOeK3BLhm1KiSle0nVNSaU+8B+GgW0v60W2cAaOJsnmbhQUbr9kWIeNzTOBc+W1QPrgMaLrp0gs/0nfiYGnAYMIvn6VPd7wUCaGA8WPFKQSsGoWrrhsfvdXngJ0ESSCjfIP053hfYI1Un1EhYL3vWd/6HABwqrQayCWLakESRv6G+rvwoUZ2s9c4NwVEFMJ1HV6kA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Wed, 9 Apr
 2025 13:50:19 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 13:50:19 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "NBU-Contact-Li Rongqing
 (EXTERNAL)" <lirongqing@baidu.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: RE: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Topic: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Index: AQHbqJbdRx65Kra/ZUa37p1wvZrOxLOaNMGAgAEkOTA=
Date: Wed, 9 Apr 2025 13:50:18 +0000
Message-ID:
 <CY8PR12MB71957D9729A72B8BD76513C0DCB42@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250408145908.51811-1-parav@nvidia.com>
 <20250408155057-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250408155057-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DM4PR12MB5915:EE_
x-ms-office365-filtering-correlation-id: 222f9ad0-8380-4f7b-70df-08dd776d7730
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8EAK0QpZ0xFx+aGZGWOoJqatdf15xsUTWGg+Ls27/o0Rch9+p0Y4ULaxc7R9?=
 =?us-ascii?Q?WULZUTTQTFeOAEyif8LBHKzA0C+cpMBd2p5LgxcPGgQIDMXU+TRfHs4aZ7kL?=
 =?us-ascii?Q?O2Cy55I7i6JM8sSAVhxul7nCEDbgUjpXf6IwD/Z03gPXvKPf0ECG9Y/7BZks?=
 =?us-ascii?Q?iSyDL6eO8oWECcRRmXlwhGrXjcfvpNTeOxQuo/HbvAJueaXQwnLhc9DC5QPR?=
 =?us-ascii?Q?eQ7bM2G2OEQYiOhoLZgQepw0iopVjBetkwtdCV2YpU5Y+ijYLBT8kMAGY5e8?=
 =?us-ascii?Q?PuIic5JOhs4fDweZZvVvO0vHBavGmwcUIdzwEwfJuEs7Ax4jEVOw5NFwqmHd?=
 =?us-ascii?Q?59Zna5GScOJLLQpAC8pMIqMoMrhxdhaa8OzBALa4Ap2brqjw3gfdOcbA1Fj4?=
 =?us-ascii?Q?HfnmYrR6KM5jWq5dSoglfMczVQHCLWxrhN7PP3xSTnfJZ18Z9AH9u26/EQ38?=
 =?us-ascii?Q?fT1D0tBNs1TjiFnO6HiGBxfj3WBaT9yHYbXEpEunc1q2Yt/alBW3QbuKvwpt?=
 =?us-ascii?Q?QHt/O++CIMS0dEcWRNY0eO/pGNXewyKGJfFGAJLPrrO1SFPec/ibHFoEIDPf?=
 =?us-ascii?Q?r81JboLGRl40gSripCAR2PkUPL5zVjjgYMSr/9JDypI75ptM1Wwuto8lEreb?=
 =?us-ascii?Q?kHMSpGN1ozTs6PLMwlJIr7MOCq9M9iAmPV3NyVxhoCbR5KiMESAz8VccOwam?=
 =?us-ascii?Q?j+ckfK8lIEiWgjHYxVrlTcD0igXy7kQ1HCGADxkow/eHxeOYJtN0ARuSOJ2Q?=
 =?us-ascii?Q?B3m4/grrqXW1PItsm9tNjJZ7iZY7eoGz+D/XsTBLoMJ7LtlJldO6iUk2kUVs?=
 =?us-ascii?Q?Q+jvsP7mxf4y3Jj+53AP2jFs1DmbUes0BPjYVvIUMxyfbZ2l9HkH7kTsqsjH?=
 =?us-ascii?Q?zFQuQBanjov6n0IcvMmwg2Fl2KbmpEcaI4AHxOtUSkFQpzlOVSlCSQ8tWKz6?=
 =?us-ascii?Q?yq1m+SG27R/yZKkAIyVCZKRlLUXEv5+jyDD4rK2B/NDgkFZAduumtZBsZN+b?=
 =?us-ascii?Q?uPhYJinZawV8pwGxrGcsV73eu5CCGe0iXBqzxCFKGckSr+kbwunQZYsyn5I5?=
 =?us-ascii?Q?87d4V9SCuZQ7L8iM1vx0YYyaErfJrS6INw0tDhDVW0hKMjLPCs9SwMNg7xxf?=
 =?us-ascii?Q?s4pdZRuAUAm99V6n0B370IQ/7H0RzqZxX12IWYOn3znCwCOfd1irBpq9dgRm?=
 =?us-ascii?Q?GHri7SbmW57h443C+GIvigm81Jnx8FhPU5s4upkuYfAB2VCGfvDEHXlCyboA?=
 =?us-ascii?Q?4XSd6dmvnO448RfQx2q3X2AVAgFc4SDmUvqVn5R++NAfNShreRbJ06zXTMAJ?=
 =?us-ascii?Q?ua0mXFMyZY0JJ1c9AlAujdkH7hGUbVdD8sH+TqZLiKIvELsCN9HAoUOOrh74?=
 =?us-ascii?Q?QutY7Rl10rsvbkxT8vWXPpge85QqEaVzmXcZDGRMHqA/Bob0vJ2vpZcCwphB?=
 =?us-ascii?Q?1QibeRBOMF9L+08YJR8NpeB8WQq2AzGC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4roDuitJiafNODMONe26YCiclFcJ0tciuuPbO667hP9M4XrBgWDsrRkKgabA?=
 =?us-ascii?Q?VsU1xqEZOQAkxL4HlVQEaBofcASmQdXFeCik3/qw5lWPf9jbmun2gqsO6Bei?=
 =?us-ascii?Q?F0UTNg7/S1KEZzy0IvYj1hPnVGjiVz9fGA2KDg2MLgfmQDR4p4pAXaRYpit0?=
 =?us-ascii?Q?4FkGfyRM5JazpGQiMREaXWw142u/fxgY9ZWJZGWum9DJ2yxRyZtAk1SRXF0M?=
 =?us-ascii?Q?W/FEm+KWw6aDhi3NKMYBG7j7N0FmDXqBR7LfM1rXpt8iHA2nk7AHiCE7tje6?=
 =?us-ascii?Q?wg+Rs7J3A4Q70XFvz8X0idr8qHMXft/Yq14QlANyMzwrznLkY9t9OWEgw6xM?=
 =?us-ascii?Q?8YRoxypWFzGHoZVMlahQN4DonR1d0Wogqr3rSd5eajjQaswN1O3jpy301HMJ?=
 =?us-ascii?Q?Q+fvDNRji3aRJlBZYJ2Qh6xPMx7mfTMFlge/d0mPpsojQFb4G51WLNHiCWfz?=
 =?us-ascii?Q?LbZAiXW0lp3qED67V+sieU1jS7gtmxwA5x+XzvtfiwV3KsYwODJBLRtl6h/f?=
 =?us-ascii?Q?/ke5vaS/JCLgIHtgvLUHjqCT/LBS1LAET0ojerTj5ajE2Vm6m/A/rxSN+Fs0?=
 =?us-ascii?Q?EqTqaRdHJ8XeDA3Y+YGolHd5SRwvF/dDIAJ9yNoRKT71b1HX2cWdinjRMnuj?=
 =?us-ascii?Q?uFuV5ewBmPoGRMkFJKnSSFgIbtc29OuKbf7DtKhKG/718QiZlkrbfSIdtfGv?=
 =?us-ascii?Q?8qiGFoX4D9dp+CwZqjDV/83YsdoYM+hRhok2JY3YZ1w299HuDOOKx5bNf1/Q?=
 =?us-ascii?Q?Upv9t7/ocD3A2quen1YcJMUv5aDj1TUad2tlna8HjlJm5d69rQGCqblrd0k8?=
 =?us-ascii?Q?TXiU1hTYLtrfZkK6o4+rd1hcr1CDGrexghT/+L7Rk8X/i4nYC52mXv8qm9ed?=
 =?us-ascii?Q?WTopAibNmRrOJMuqYrXhkBwE8EjJ3O8NVQ+0hlyvgAZ7cSKYjNTtyWG+BkAM?=
 =?us-ascii?Q?ysRvanRN/LmOs6+F33hrpWJU9Eh8pctZZGcg7dzoraMckrB+qryKAts1pK3k?=
 =?us-ascii?Q?PL63oLM71ZEoBLLKjwQYSOjsrEWaiSARrcc7xl0Tkbj66pc+lUj3Wx7rZcWY?=
 =?us-ascii?Q?+egB3zIU1IsIQDIU8xES11NeYB9fd59mq3VbcCJQvpVwx0Ijmmj+7+rs6EVf?=
 =?us-ascii?Q?U+SigUZJr6TQ/Y8BHEog01MMdem+KvFwUPvUWYupngAfq0tRHmkY00kEuL08?=
 =?us-ascii?Q?PCrWanEPG5mxeHLDwbjXKuQYIKCA2yYqMQ6dS7jQEsJUVkeHVgYCwYp4k3Ah?=
 =?us-ascii?Q?O+6q7PYwx5/W7hw/I8C/4bF0F+jSZz8hFDBM2GyGMqdcvi3Mcc3I2T38COw3?=
 =?us-ascii?Q?kg8TCsYhmJ6RHyrp8KeZioQBgypFJy/peH3mcAf1CJYNLDGd3lRVSGqLcyuP?=
 =?us-ascii?Q?iAKPNka40FNF1BIO13hqYPeftk9crjPqfx4g2ALok6i9w1I7UbWwwnkWwkrq?=
 =?us-ascii?Q?EjKhMo6gtdXzb+hO4V1s1kSoWs1QOfl7cEPgnEHYL9BuJHvAPkXAWcHv3jB4?=
 =?us-ascii?Q?QZExlYuwFUdn+OVCqI2oQhWgtvu2mvJMS8uCIWlXGbcATTBFsgVHznxcbZpQ?=
 =?us-ascii?Q?Wm8uCGx/uwwoKoeR7Lw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 222f9ad0-8380-4f7b-70df-08dd776d7730
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 13:50:18.5793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IpNZV8CQnOa4mVmiW0Y/IyJgn7LP8EgvEiiJ5ykr8cd7o9VOGNa0rx2XyAwmF0b6cxP7s1/WrwtC1TKK8iDpww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915

Hi Michael,

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 9, 2025 1:45 AM
>=20
> On Tue, Apr 08, 2025 at 05:59:08PM +0300, Parav Pandit wrote:
> > This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise removal=
 of
> virtio pci device").
> >
> > The cited commit introduced a fix that marks the device as broken
> > during surprise removal. However, this approach causes uncompleted I/O
> > requests on virtio-blk device. The presence of uncompleted I/O
> > requests prevents the successful removal of virtio-blk devices.
> >
> > This fix allows devices that simulate a surprise removal but actually
> > remove gracefully to continue working as before.
> >
> > For surprise removals, a better solution will be preferred in the futur=
e.
>=20
> Sorry I'm not breaking one thing to fix another.
> Device is gone so no new requests will be completed. Why not complete all
> unfinished requests, for example?
>=20
> Come up with a proper fix pls.
>=20
I would also like to have a proper fix that can be backportable.
However, an attempt [1] had race.
To overcome the race, a different approach also tried, however the block la=
yer was stuck even if all requests in virtio-blk driver layer was completed=
 like you suggested.

It appeared that supporting uncompleted requests won't be so straightforwar=
d to backport.

Hence, the request is to revert and restore the previous behavior.
This at least improves the case where the OS thinks that surprise removal o=
ccurred, but the device eventually completes the IO.
And hence, virtio block driver successfully unloads.
And virtio-net also does not experience the mentioned crash.

[1] https://lore.kernel.org/all/20240217180848.241068-1-parav@nvidia.com/

> >
> > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > pci device")
> > Cc: stable@vger.kernel.org
> > Reported-by: lirongqing@baidu.com
> > Closes:
> > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > 1@baidu.com/
> > Reviewed-by: Max Gurtovoy<mgurtovoy@nvidia.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
>=20
>=20
> > ---
> >  drivers/virtio/virtio_pci_common.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c
> > b/drivers/virtio/virtio_pci_common.c
> > index d6d79af44569..dba5eb2eaff9 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -747,13 +747,6 @@ static void virtio_pci_remove(struct pci_dev
> *pci_dev)
> >  	struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev);
> >  	struct device *dev =3D get_device(&vp_dev->vdev.dev);
> >
> > -	/*
> > -	 * Device is marked broken on surprise removal so that virtio upper
> > -	 * layers can abort any ongoing operation.
> > -	 */
> > -	if (!pci_device_is_present(pci_dev))
> > -		virtio_break_device(&vp_dev->vdev);
> > -
> >  	pci_disable_sriov(pci_dev);
> >
> >  	unregister_virtio_device(&vp_dev->vdev);
> > --
> > 2.26.2


