Return-Path: <stable+bounces-172365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6DFB317BE
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7035A1F8E
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2833E27B342;
	Fri, 22 Aug 2025 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EVPKG2xf"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF139B663
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755865378; cv=fail; b=eDTqdabEio1oyiPSrNEE+Iemw0MjV/nSJybb7KIrBxlz/tADSaXfUHXM2AtfjyLmKtmzHFRaGipaB4DyqicWbFfHqtsufPL6eq53E1OHXwCbKsntIopfyjMZUko6zJFoALSyyYflgQELkByWWq3gNvvShS5DA7RWGkIpUnvxYSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755865378; c=relaxed/simple;
	bh=Py0H8IbH5KoxjMCUBBNMHDcWxhFN8mzC1qqv6AN451Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j1D4Cu5qHm6344Z1KnNj3EkDtTt7FrZvwoJw+GMVE3xr8GeYqhYsqvV3eC7Qk+Qna+ei/cKI9i1TBWdvoiS3/VkTko04MdLbCAKtSgwYikYI+fwj2lyLxniXWiPvQp++Z7Ofef68cp/KRInHVBwJW53mWMLCgV502hyjtqvq3y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EVPKG2xf; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nV6hCdWTv3ZHWncbV7Z+nPyxCxkyffAS7Su1jj4MELy3SKosxl47RaVs0wppO/MbICDNPgKYyH1KXSeHxy31ZU/6t7aPhbWRPvsZqJqaXkp5Wfeon31AcYZwLVsZfeDX4pDt7IBV6i2aJY0vzgdZBWhsOW+VOu0myJig9oWvHYMKIrs+1UzgqhQ/f/gjv3censmABqvBJPHNFiCk6V+T/5KFsl00A4Ch4HIcRyxOea1vKCiBoGWwKwkz3S0K6ISRbH5RlcUKSZxHIYetjKGSh6YMZgaabz4ILsk9FHuh89v/LFRDmU5qFrqSiriF8dbrkzJe+/D5Ut9TqlYjh6w6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTxNbXsDgVuDHRUHKDpb1boe5KJnv1Wtpc+yiLlxOE8=;
 b=w2WM7P2E9e6QLLGXnN2j49FX0Qdp0kSNeu1JqfuRY9v1kNRnrIW/VXFjofQKWd61lgDvh2wenbaPOEOGO1MbrxHM7/nKdCSKTBoikUVXayxHuzSV5vXHkgp0iton9CMdqKofdsOKbR4aEho0jkWBV/7c08yWFgg5MHWCUisC5LNgGVeJKB8/idrBUb2eaxUHltlwt/dBzzsd8iTijAEake7/pLnlldGEcX76Vv/MknQ2828LcRx73xhXLfNWFcjKilZh2eZOonUzpVjtgMrz7qC3aS7bueRpVzvdMIwvk79Glyptt1Mr69PYGmaQmhNHSLSCFmS2cbuq2lzIwO3Ewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTxNbXsDgVuDHRUHKDpb1boe5KJnv1Wtpc+yiLlxOE8=;
 b=EVPKG2xfihHzW2d06KLAULfrHb48N7dHJXiysNjAXvGuDkXrqRCD6aYOIthMoS+1nryo38IAeRdDE+qUREIYstoqvM8IrszbYetMBDjzjrWcG2dW2bZBSiSGGxJ8EMiKZH9J+Gl+GMhUqGZajQHJ54OOfJhRBe0ia0hzUgV/OUsuFdYB+7ilxnRrqOEy+RJjrpFHkMKihylojVXg9qlji+yd7vI5OyAYmUfhcw5HYoqzK31X26RLe8ou7mZ3ln9pnpji7dpzNQZPhhwMrVXZqkLA3+J/20E5UTeLTqWMNQXOP5HgJRX0Lhn7vGTBJoJ+KqEkSROZ+pE4Z+vNnKA9UA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DM4PR12MB6567.namprd12.prod.outlook.com (2603:10b6:8:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Fri, 22 Aug
 2025 12:22:50 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9031.026; Fri, 22 Aug 2025
 12:22:50 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, "NBU-Contact-Li Rongqing (EXTERNAL)"
	<lirongqing@baidu.com>
Subject: RE: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Topic: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Index: AQHcE0XKqVbu8cWtaUCLZj1LjgeTGbRudpsAgAAWuWA=
Date: Fri, 22 Aug 2025 12:22:50 +0000
Message-ID:
 <CY8PR12MB7195292684E62FD44B3ADFF9DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250822091706.21170-1-parav@nvidia.com>
 <20250822060839-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250822060839-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DM4PR12MB6567:EE_
x-ms-office365-filtering-correlation-id: 8ce2af8e-bbee-42e3-68b2-08dde1769cb8
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?it8stU9dKbXZuc12Ue1ooUxWlrXFhC1snXGrUPLKiFHJE5i2WX2sMVV3EIBm?=
 =?us-ascii?Q?Ol79uxUo8BfckD6pOeas5UylMJqxpJwwYF87k1uQUPJb5OcREwTdVE/qYHjH?=
 =?us-ascii?Q?VGxtJOin0WKUtwLe0S3vKvyONNPBH6n2cT81WLfNtFm5cYJ1zueTFP1PzwGd?=
 =?us-ascii?Q?Qq0qIs6CEwnylk5cV73ZANKKQmZDRcjAoWjMdFkmhJ1G3pprKsuVGmkWNrqX?=
 =?us-ascii?Q?Q/ztEu+nAciWDBBkqPdRfSKXTk12KPL+D7gJCg0qG3m0eZfHG1L/+6yzEOCF?=
 =?us-ascii?Q?WfEY/kntOPgEZ9JjkKJSzSFne/6WIUxtTVkOqvhCuTAmkl1JESrDjWnjzPwj?=
 =?us-ascii?Q?PSbYTTeIROMqkJOeYTZYZSYMMlzysaBdqnX3NizfGnr+zHptaPNBREzbTEkS?=
 =?us-ascii?Q?RhdifCYhHd/h415q3JFy/0jdid6qCTa2oZv00FhUxlg/dfstUl6oXGindSFm?=
 =?us-ascii?Q?256KcdL5k8LNiDDG368kMPA/6WZ83QsdSWIFeBeZVPxZnQ6XGr4WmoHmaQ+T?=
 =?us-ascii?Q?/4U2W/cIk+rjQvho6py1ue+qiiVCjldLJV1WYZq+Zm2QYZpVb6LOnuceb7cm?=
 =?us-ascii?Q?pxcWePE5QJZCD4Q1XkqkGp72lRku/kMZ1O6SLSCQdzyUPfD5T8zt8LsQ24nE?=
 =?us-ascii?Q?Tn0BazM/lYcgg1D4hnrfjTNs+sdwXjj/r0CXfnIayMPUnDKYvRh72hq1pnwy?=
 =?us-ascii?Q?tkuHsJtpomb+YNL77ytO2x2dcgv3YunOp2Aygm/maRgvzk5ShHHjk+0UsLVj?=
 =?us-ascii?Q?UJmhJ7XqnCgzX6RLQyjDIEYQoqdpIgFOkLgVPrWM7lo+3zkn5MrUNkFT6k2F?=
 =?us-ascii?Q?OvfSdWWrB/8z2Ab5bnvQvqbflSJ1pZuyJX0FKJoIJfMBjHTW/eJSqSZOMniP?=
 =?us-ascii?Q?FRdn6uqpZleUUDp9oYzVWN7m+KH6jcot8ag5WANKODURbxffIG6+cyFgmxUG?=
 =?us-ascii?Q?GbGS3Mu88S/eua4JKf6XtVAefdeIBFbFhcx71ApqtCmDeZNErjpB124MIoyS?=
 =?us-ascii?Q?BJqVAivwPIQUe2TPaEgvYS+8322Wkqtghonj0FogXbZh7aUnWgihc4jbl9bg?=
 =?us-ascii?Q?r/EtBXQDCLluV0RoCU+Ftq2ixoOE0cZFI/F5bSz9FZtckHJ48cXWQLF+lJDh?=
 =?us-ascii?Q?9+i2Wb3Jre+IJFHSR9QZRd5vRPaifdZOhQEORzgNrUKs1mfr22ukh/y0vUeR?=
 =?us-ascii?Q?r4CTpsD7xaI8UDfBfEuWZDr5RwgmtTagRFyXJG7KXJFxPDt68HPfqc5J8qYI?=
 =?us-ascii?Q?QJYfJ462uwwoWC07h9uM4iM2XvlZMUrQnhVX2T6RDy7yclg7tlGYngaGCWpQ?=
 =?us-ascii?Q?QwZ0w4xEPICJX5Xf5OG8utHdB19iPQzDjNN6Bi8kpmrj1tqjhoZH41No+NZg?=
 =?us-ascii?Q?aZe1/aGMlxeQpJmdpCjiRJoahEtti/dDDaZkSYroZI7kG2o9m+NNyKVzy05I?=
 =?us-ascii?Q?xrjBKkO7TYPRayggzAjOVdEts7p8XhyMwhTj24CLAidCrQwAd4tDR/09wbIh?=
 =?us-ascii?Q?4p0NThRNT9lFdFM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6e580qpD2PlFYvhry8XG+a5B+4BgMKAQikq+qzwWgdfMynStbXLsPBuvRFTz?=
 =?us-ascii?Q?jzD+rVtzvZ+XPxMAM7gCoGdKQZA1KWBEt6qAsSwjbD/Gxl9rygWS48CqF+z8?=
 =?us-ascii?Q?zcFBEzawFyACR7tyroJhFqhg/jnCyNFmw2aV9TcpmFbE4dlSalWczp82qn38?=
 =?us-ascii?Q?F35DhOGJauGwIoMfOWi6vZ2DIIHv1sBoqge14CqH6AoW+2nMMxhZ2fxpumeh?=
 =?us-ascii?Q?vt2D+enidJ5/WLLE4y/CyAjVhh/9DRHxYAPh6lgR8nMA4eABmRsQtkkunTil?=
 =?us-ascii?Q?2FNsgcNCnto4C44x1JY8KGn5BJC3pCF92W2dgwyECLHjPBjE4zJuzxK/h9Zv?=
 =?us-ascii?Q?TL+LAq/irHfCiYnLD7cLk03mTQDwY0zs+Lf4+dzsWo8iEYdh7eETYRjrVZVL?=
 =?us-ascii?Q?q8GEWqa6kjSF+6oZ/p3FQaHXZPB4KfWUyyN/LPpCMd+EcedTw+gFv4dDM8Mk?=
 =?us-ascii?Q?CCG99enibhS1g+vlQbAi5O3fux7DroZJ3MXv7h2ibrw7ejO7jUb5XG8NFGU2?=
 =?us-ascii?Q?D5eEx523HCsPD1/fz259F/IReyE6lN31NJvu9t7QNpEuSusWWB8xQJeNsX0i?=
 =?us-ascii?Q?Qm7B8xm+cp9eHLh2u9nqdJ6hnYdbwLZCu1LYsv1kaA/EVRg5+JvMPkyl5hxb?=
 =?us-ascii?Q?pfM7m3cet5aT1hKsy61jJaMsIeeUuritxEkElGFBENdahAqvZPe8vfp1lZWF?=
 =?us-ascii?Q?O6kWU078RvtZVKHRkjQrSUkd9RsROfAicIhoqFA6+nHn078CX76V22Z4qv4Z?=
 =?us-ascii?Q?OtnwPdngcI5HE5PPqg/WkgQdiqiKPhhGXeDfuSpvRP2ILmoweKcPmTLFspU5?=
 =?us-ascii?Q?NCgEi3oBUPdNHXSrtwsMu+3mSyw9Ytvx7pGHk7RuqW/ia5Le5y55IEZYw/I1?=
 =?us-ascii?Q?B6nkenBF1mZsAYDGm6Z6xi0LXF0oNH0yWGZuwQ4LYW0CiUjL9BAvXuVB7I3f?=
 =?us-ascii?Q?B5UUo/FPqKU9YMBO0M58DO66bEm52B0YoXHCfxbQ8TjKKoDOTQ1B3aO1Qtpb?=
 =?us-ascii?Q?rPMyPcaxO46G2DojEz/7MpAo0BLacdr8YIk8pnzrQenZNTwqe3+kaEOAgb1K?=
 =?us-ascii?Q?RL9RUyYGQCnsZ7bA9+2wOWdN+mBU5zNUXZLcaHsuvFzB53xhwadc+GJD/AH6?=
 =?us-ascii?Q?uaJ5d428LgpRRp99KD9UUuf5l9uOy8v64rq2edtGn5TQhoCiR0YMgJ8Ta97j?=
 =?us-ascii?Q?qMTXmAurQUDESWCmlDBgQxC/bF0Tr7un1kfNXe/j4nHFsqdYxIYred/GJhHl?=
 =?us-ascii?Q?0FZsBTQmdse4jGvo4KdGgpotEzFtcQtrzVO989P6dhTY2Du96lxX+D/R6OYo?=
 =?us-ascii?Q?6oUWYd+bC0VetX+armfHD8sz5wl/3j0vZTcCWGGa+huovLqs9AGpsMhd0ZBp?=
 =?us-ascii?Q?xetsJi5zDaRdLsv+kKoQz+t7rAAm54sjayi4jUyZnM+heXgsV1KnrzpMF/QI?=
 =?us-ascii?Q?t65Dgy8xQxEI5M9rcg/7zX3l/BKDunWH9AQg6HHlGkaurFc0UrkjUGoD70Tk?=
 =?us-ascii?Q?nyFqy1EAF7ulYo4l8b3vMi2D8vHl/Cei1sf6yrDl+36tmAHzmZSB9jgO3csB?=
 =?us-ascii?Q?zXpgBmb1YihYjb/AiOA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce2af8e-bbee-42e3-68b2-08dde1769cb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 12:22:50.7494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O5WlTBvp+oi8THYDWlIuW7LO+lQXuwFPzCnm95rThtMWyUiaKuLFlPlnkcGubKeypmW8fatsBNsJMXe/ShLFyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6567

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 22 August 2025 03:52 PM
>=20
> On Fri, Aug 22, 2025 at 12:17:06PM +0300, Parav Pandit wrote:
> > This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise removal=
 of
> virtio pci device").
> >
> > Virtio drivers and PCI devices have never fully supported true
> > surprise (aka hot unplug) removal. Drivers historically continued
> > processing and waiting for pending I/O and even continued synchronous
> > device reset during surprise removal. Devices have also continued
> > completing I/Os, doing DMA and allowing device reset after surprise
> > removal to support such drivers.
> >
> > Supporting it correctly would require a new device capability
>=20
> If a device is removed, it is removed.=20
This is how it was implemented and none of the virtio drivers supported it.
So vendors had stepped away from such device implementation.
(not just us).

> Windows drivers supported this since
> forever and it's just a Linux bug that it does not handle all the cases.=
=20
Internal tests showed the opposite that hotplug driver + virtio didn't hand=
le the surprise removal either.

Can you please share the starting version of the Windows driver that actual=
ly does not wait for the CVQ commands and outstanding requests for block et=
c drivers?

We have even seen window driver that corrupts the CVQ command buffer when C=
VQ command times out!

> This is not
> something you can handle with a capability.
>=20
The sad truth in my view is that capability is needed so that device can kn=
ow how to do _sane_ stop as driver told exactly to do so.

For sure if device stops the DMA, the device is unusable until kernel 6.20 =
or whatever new kernel arrives.

>=20
>=20
>=20
>=20
> > and
> > driver negotiation in the virtio specification to safely stop I/O and
> > free queue memory. Failure to do so either breaks all the existing
> > drivers with call trace listed in the commit or crashes the host on
> > continuing the DMA.
>=20
> If the device is gone, then DMA does not continue.
>
This is exactly how we built the device.
And device behaved correctly, it resulted in the call trace on multiple dri=
ver hands in net, block area.
Commit 43bb40c5b926 partially fixed it.
However, device does not know when to behave correctly vs behave as driver =
expects.
And to do this reliability a capability is needed.

> IIUC what is going on for you, is that you have developed a surprise remo=
val
> emulation that pretends to remove the device but actually the device is d=
oing
> DMA. So of course things break then.
>
Not really. The device was built correctly to do surprise removal and stop =
the DMA.
That caused the call traces. One of them listed in 43bb40c5b926.

So to maintain backward compatibility, device had to graceful removal as ex=
pected by these drivers.
=20
> > Hence, until such specification and devices are invented, restore the
> > previous behavior of treating surprise removal as graceful removal to
> > avoid regressions and maintain system stability same as before the
> > commit 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pc=
i
> device").
> >
> > As explained above, previous analysis of solving this only in driver
> > was incomplete and non-reliable at [1] and at [2]; Hence reverting
> > commit
> > 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci
> > device") is still the best stand to restore failures of virtio net and
> > block devices.
> >
> > [1]
> >
> https://lore.kernel.org/virtualization/CY8PR12MB719506CC5613EB100BC6C6
> > 38DCBD2@CY8PR12MB7195.namprd12.prod.outlook.com/#t
>=20
>=20
> I can only repeat what I said then, this is not how we do kernel developm=
ent.
>
Kernel development does not promote breaking users.
Here users are affected with this incomplete kernel behaviour.
Virtio subsystem (multiple drivers) including marked stable kernel lacks th=
e contract on when to expect DMA completions and when not.

> > [2]
> > https://lore.kernel.org/virtualization/20250602024358.57114-1-parav@nv
> > idia.com/
>=20
> What was missing here, is handling corner cases. So let us please try to =
handle
> them.
>=20
> Here is how I would try to do it:
>=20
> - add a new driver callback
> - start a periodic timer task in virtio core on remove
> - in the timer, probe that the device is still present.
>   if not, invoke a driver callback
> - cancel the task on device reset
>

Multiple users request to restore the stability before adding the surprise =
removal support in reliable way.
Lets be practical.
Each net, blk, fs, console, crypto has different way of flushing the pendin=
g requests.
It is unlikely to find a single stable kernel where all the virtio devices =
would have support for above.

So until above grant work is added to new kernel, user deserves to have sta=
bility restored in stable kernels.

Hence this request to revert multiple times from the users.

> If you do not have the time, let me know and I will try to look into it.
>=20
> > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > pci device")
> > Cc: stable@vger.kernel.org
> > Reported-by: lirongqing@baidu.com
> > Closes:
> > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > 1@baidu.com/
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
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


