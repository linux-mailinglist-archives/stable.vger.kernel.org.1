Return-Path: <stable+bounces-172366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C914FB317B4
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154A83B668B
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 12:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794B92FB61C;
	Fri, 22 Aug 2025 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hYmw2LSz"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33C6287508
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755865452; cv=fail; b=Hewktnj19JhpqBjWQB5ngf1ABn2hP6Eq/4mkDnVpxzk1nBFZRXXDS03Jsi54Q/1bPgP1ZMLwkG693ZRBeSTt7oI9L+dW06BJyXwzCZWADU/Irj3URc6BTlrDQxKFxdElAduztg7R5YkiidkQmfP81fwsFcE3hlXsOGQnyJXQ+H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755865452; c=relaxed/simple;
	bh=INXbBNQ24zjsU9e/KZY3u7oTYOx9I/inqQ+Z0e5Gc6A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SyVelgORuoOEPTirHv0d/3d3tcUB1iRmzDSnN/rPIMFJBSC4wZ88CwovUu3C6SA6DKW41x9B2PBoVZyJDaOf/lKHJn+Wg67tHGFdqPYaTbv7kQRpkz/juhNs2YU9YII/szt8txMm3nOzVs+GslOBBF0PMUfrCNpULSkBaUFuHO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hYmw2LSz; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZ902qCyOLARRhdEvpqMexpGIlMz2kPqzkeGrcw61v+n/ar7slH/HgkKbOPf1+ymFIx4zWd2cxUabf5iC2VEm6lGIsNPQWpqWQNUaLrr696eiaaVnTRaDGNkGT5axc5WXNPBHTN9C0nbtIR5yuyfvtnifc8lfD1XGyKYQxZDNgsH2ao+5MVy47Wh2lkrY5+7E8oywarmf592XLeTMeAome4IlAwe25rSVCZ9LpsDSEm15GHqn/AOfKpFtOQizHxNMUa1aaxtIUq4WufeGMCcgeYt/irtD6Lap5HB695BrWp1OwVvdBbQL9P51pDM8MI2fQKu8yhMNBbVsd+ig586oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wh5Lor5QGpPUvePj1stdlytG6jaDOWGxvoc8iiDRqPM=;
 b=f0L2QjriO+emzewB1B4VooIrZC9o2sskOnykaft801tKFdVhjoSbCjLQHHzhzrgpEV/vLhPrIVT7nJIQEJZnSe4eozUGA6UvqwR49sDSRSSIj2pXHOb/0nJxwzdwulu5nnemdFEHnqNjoyhuR1DMLg9jQWJY+EstpY+JXTlsiI8aJT3YQMOGqrrsQjHZLinxonNnVBIeTzfpz10SNET/m8ZNtwHkeUwckK6n5+QNq1A4x3ahwFI+p3WZ+YvsQ7/ANp4WcF5StH5+QCq89m+eC3VB11VbJ8u5flWB6BiSjyGikfFKNsYxQdVbT+nLks1zrUanq28I2Hh1Vp+C/W8jNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wh5Lor5QGpPUvePj1stdlytG6jaDOWGxvoc8iiDRqPM=;
 b=hYmw2LSzalenISSPxyC3Vjp5ZuBiQwPBFBKjTcObLNul+PU+yBFnzhPlSt7lbrGiEjoYUgGi79cCkigxaKovzEC2niKm1ZGykDutb9NfUU1iywkulueCjNACOkXAoMdKBKnk6s9CVK3j5INCV+Ax2deB4uxLx2OEqK4fS1YnJfaBnU53JF0+F71dq+Ur7BJa/CAAkPilttyu7BZ5UhqFWlxPFHnROxVPArYwZE23A+PQwba1oBBlFhBBsyikRra9wMJwa9P9zgK+z5zdt1+njgQ1rk3+nfiTbpIMICDSyIEIYQSmvheA/OPMBcZjyYEYEt5jdm0iVUBytiNf9lhG1g==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by PH7PR12MB6694.namprd12.prod.outlook.com (2603:10b6:510:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:24:07 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9031.026; Fri, 22 Aug 2025
 12:24:07 +0000
From: Parav Pandit <parav@nvidia.com>
To: "NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	"mst@redhat.com" <mst@redhat.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "jasowang@redhat.com" <jasowang@redhat.com>
CC: "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: RE:  [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Topic: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Index: AdwTTxd+YdVEFNqzQBWcarw+isQ7dgAEGgsA
Date: Fri, 22 Aug 2025 12:24:06 +0000
Message-ID:
 <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <0cfe1ccf662346a2a6bc082b91ce9704@baidu.com>
In-Reply-To: <0cfe1ccf662346a2a6bc082b91ce9704@baidu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|PH7PR12MB6694:EE_
x-ms-office365-filtering-correlation-id: e6f9d3d3-4da4-470f-4de3-08dde176ca21
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pJRIXAtiQmGJPfT0mC0OWnVc96kulDVXooGhAV6tJkmdRSs2VUhChQRT+yD9?=
 =?us-ascii?Q?47Zg/awuxQxOoWHblUB7KIiqp8uhn4oAs7oNVX7j8+Ti0c8MEafeGzQK3eDp?=
 =?us-ascii?Q?14HJYttgxA9szLIgW8MuBJdOv06CO2KgUS3AMeBtv7lNthmnMhXntSA0OcFE?=
 =?us-ascii?Q?gPo+IklHH2qA4brpBfZvgAGFgywjEVunlAO2S06tUQdkC4watQnt1x3hR08N?=
 =?us-ascii?Q?3fgebjqJbwYrZCwV2kT98kL6CYDJacwTRH7yjzLE7WurdHU4ai+kSD6MZRGT?=
 =?us-ascii?Q?gviAYHGc/Ea4hNHztV10R1D6UMiNxCiRpH4z800OcAVvWiYBWqrNoGPbKOuP?=
 =?us-ascii?Q?8iI74FT1cQfZndOroKVO6cq1Q1RG3Ix1SyMUXXmKa7ES8+wwLT+4G9h0zMze?=
 =?us-ascii?Q?GNhvFvgJ7u35fVMB78Wcc3YWu8KMTskCgDyIjGFG5bMDr64HMrB2Lvof1jGF?=
 =?us-ascii?Q?58GpU1ihaGBonz7dS+Iel0XWHlUaS1EG5EjnY8pVl/zq3STX2Q77EOpYzx8D?=
 =?us-ascii?Q?38Gl98sR00Da5SDmWZeD8+j8Lq4xvCRGCxIrb4f5gSMoR7vnl0ScO/z/Zz+n?=
 =?us-ascii?Q?yOmy5S6D6PIO20OJ9hJZ2LiNj0+cvANIwqxLWRzA9QFGU5+tAvk8jjtBRHLG?=
 =?us-ascii?Q?N6siTElIR02uXAV54FtJE9TD0ds3EA9KtlZFSkuFrsn81NSsc1QI8ypvOpKh?=
 =?us-ascii?Q?JeY7sZCJ94AIWklVtMMdsrk4ZmHgSTlqOvPMCRRD7OVTn+olhvGmLWb1A1mL?=
 =?us-ascii?Q?dWoXgRoU1uIm4/nonZF4vUY1TqsqafyJFr/RSx/XirXpn7Ttj2SqAm2k6pr1?=
 =?us-ascii?Q?BK5iuBivuKTL/ESQT6xS7FGYy/+rcRwLoT/+/fq3PP/7saDRImTFcWKGQ374?=
 =?us-ascii?Q?ZXEVYBzuPbfqVZ+g/lw0VwbjH5FOHzmYxR6MFpJHmLqM193O05P6iwh1cc4V?=
 =?us-ascii?Q?lfy/qu+A6M4BA3GD0cOeORYTUPyL4tVRByp7lYNFFlQXSkbzfxUgGTRWd2fx?=
 =?us-ascii?Q?N7iVYhFFM9m3PZe1MYtcMfBIwynhqDBuyniGWCfURmQZTcjQ/X7LDU5fokgb?=
 =?us-ascii?Q?RKJN7zpojIwnw0Tw3q/A+hiOedivLV5todu39TrlSEileMSEj6zfCNeNy3K5?=
 =?us-ascii?Q?mKaSuxvFPVTwHgOQ0/bcR8brA3Eih8gAker+TvVVs0T2IB9a5fH6nOQg0wPq?=
 =?us-ascii?Q?bCSvT0BwAbW6oJ6w1Fa9a0qY1rGIUmhPv+sSMd9c1a7npdb8DjsW0QVqLYz6?=
 =?us-ascii?Q?f/zY0PHNtYktURIzqUoWt9s8z1AEJ6fStugPdBxWv9NJMTD0+77xLy1AWTFk?=
 =?us-ascii?Q?DWuAJb+usNjoFxJHs3Ujh9s4csnBEUtXPLGNJb/DW7p41kL96RvxtmdT4E7x?=
 =?us-ascii?Q?KVyFRwgA3h4qnQQqNlJaWBxHi23PFioQEO7AnfxlG85vUQZjBtOSMuClqZpS?=
 =?us-ascii?Q?wd+CeWX4dkPzXB3PQOoKEOC9dMw58SaRbfIKdEIrpgKTohWvKtSjOJFRHYH5?=
 =?us-ascii?Q?kqMP2nV7X3QYATo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O+prnkGKxjOkCBd9fNgPhx7Xb13qs078ooLggGX5+2svhvRSjfTdkKnQqnh+?=
 =?us-ascii?Q?PNsf+V3SNeHtZDbcxPD2uX87Lks0p7J5C0fwbGEpVMYmsCBTsHHpSNx63tYI?=
 =?us-ascii?Q?fomZC5BGaJCOQ0JKnxKYz8dg5EamtovlBwPi7JKiddHI5fiALCvnHZ+URtQt?=
 =?us-ascii?Q?HWLLXa8eYtASEqozCWqsUTAcKHDyeYJ2C/+fcR1lY6Xgp2o+x7cvvgQwRY13?=
 =?us-ascii?Q?aDpRVjpCGsDdzWBGFs5V7yJ0/YLNXgsLE0No8FEpV6EZs1vUA75WqIKweqgA?=
 =?us-ascii?Q?8+huNNh3DWHsVnwsZ4LSZVZaW8sN0O8y80zISA5qkktr3MXDWfjBAJ6tW9wX?=
 =?us-ascii?Q?Te8D2suPqHW9IOal3jRPbNTBLZICjiE74LE1d1/RJLmRztBhPaPuljx3eU5k?=
 =?us-ascii?Q?J7ytwPNTogq4MRPH7880f97wUaH1emL2+hmktLMCtwcTcwG7LY6hv08qG+a6?=
 =?us-ascii?Q?6Xa4HMWqLcuh80j8n+9OGCwS8EuSV/YlKrFc49gbvvCLNOmnWJk0JVwoB++1?=
 =?us-ascii?Q?ZIJsVT/8/u96+xC/YX4Mn0R/wl/di24g6kg07AqcPtVCzGmONPV1Xeltcg67?=
 =?us-ascii?Q?KTK2l6W5Z2eR7Nz0iJYU00MWmYZ2m35XcgAzrq+iKLrrLD68tumqvEUCclvj?=
 =?us-ascii?Q?UOi4YkPXCDb1BLUpcqbZ1VJcQoKNtgniOQbORTArUqT9XRSId9Gn1M8ECY6j?=
 =?us-ascii?Q?x3p7Cqax3HT7kgqCI/Bc+jlyRFGqT+1RhJuS3FL7nI5beBHWrvvQHWFcTq3q?=
 =?us-ascii?Q?S9pQmofU7zDBuSBfFf9UrGWMZXoRrGKS9wk+bEFgVicdPfuAQBvywoif9fuG?=
 =?us-ascii?Q?gNs9zhx7Xl30FvJw3eicS7SrEGcqcGi/T0bdgmpx+JJr9LTaHFTECMQ8Pffa?=
 =?us-ascii?Q?awibUpKlEDhw/tDnbUpF7wPmWfrDd36u3N4a+XNIQSQIsFC+alyV7/As6/q2?=
 =?us-ascii?Q?cCOFpsJo0bD4grzuUozTS+1GCCPlCYS67mgR5vvAyBCqxcAMOvZ/1oNXznu4?=
 =?us-ascii?Q?OI86OFIFVg/u5RJC4PGzJWU7XTdrCwGX6r2tPUX4naoluQW889KoMaSdeDx3?=
 =?us-ascii?Q?H9ydayGkS1UwnnEkB/UP/eJbZH9remoFablO8fGixVmAgnti+hydJn0xYl6U?=
 =?us-ascii?Q?WbLnRaja9AxV6RuGlHjuO5PPFcq64H+3x44JABdatVVqg5KP1D73e32M1k9A?=
 =?us-ascii?Q?Ku7EvTLu/j4mGcDkhWEtAUHR5Ah+30MkBZmTgl2CFe2nsptNTcZ8shwj7+t1?=
 =?us-ascii?Q?VmOcxpvkE9XFemTJ/X3WfMZA3bYoqaIzprRqk7ia4+YIzQGIuBIg9vJT8EoZ?=
 =?us-ascii?Q?ZXURsT9NQa0+BRGUNGQWg1JrP8TatNL+Ev04B1c7291Ma+XBgHQannIwkLwg?=
 =?us-ascii?Q?cpMrVXBYYDHUit/YTf0C8nhywmJt4hhks4JbKwYZ0yI84cYOfjhl7hiG5cHw?=
 =?us-ascii?Q?BDVih8XL1f8okg4e4IKIaU51lbq/bUfISWsssDW3jq44w+a6BisiSmz0fKff?=
 =?us-ascii?Q?tzrAyEHCGPG+Nqtloj+WV5RKMIIqKcGKYePamf0mWqLwQhOr1vVerrW1nL3F?=
 =?us-ascii?Q?dC9u5c+7N4Qzw1WodU4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f9d3d3-4da4-470f-4de3-08dde176ca21
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 12:24:06.9471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ANFFIpGiyuqvyf+lV850oPxBdDGKRRZn7LBgCHKcZMWFK1ookyhSC+QyUY3CpW2TZD+aLsZYWn+/QOLBiShCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6694


> From: Li,Rongqing <lirongqing@baidu.com>
> Sent: 22 August 2025 03:57 PM
>=20
> > This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise
> > removal of virtio pci device").
> >
> > Virtio drivers and PCI devices have never fully supported true
> > surprise (aka hot
> > unplug) removal. Drivers historically continued processing and waiting
> > for pending I/O and even continued synchronous device reset during
> > surprise removal. Devices have also continued completing I/Os, doing
> > DMA and allowing device reset after surprise removal to support such dr=
ivers.
> >
> > Supporting it correctly would require a new device capability and
> > driver negotiation in the virtio specification to safely stop I/O and f=
ree queue
> memory.
> > Failure to do so either breaks all the existing drivers with call
> > trace listed in the commit or crashes the host on continuing the DMA.
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
> > device") is still the best stand to restore failures of virtio net and =
block
> devices.
> >
> > [1]
> >
> https://lore.kernel.org/virtualization/CY8PR12MB719506CC5613EB100BC6C6
> > 38 DCBD2@CY8PR12MB7195.namprd12.prod.outlook.com/#t
> > [2]
> > https://lore.kernel.org/virtualization/20250602024358.57114-1-parav@nv
> > idia.c
> > om/
> >
> > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > pci device")
> > Cc: stable@vger.kernel.org
> > Reported-by: lirongqing@baidu.com
> > Closes:
> > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > 1@b
> > aidu.com/
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
>=20
>=20
>=20
> Tested-by: Li RongQing <lirongqing@baidu.com>
>=20
> Thanks
>=20
> -Li
>
Multiple users are blocked to have this fix in stable kernel.
Thanks a lot Li for the quick test.
=20
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


