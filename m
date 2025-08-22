Return-Path: <stable+bounces-172393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085DEB31A59
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 15:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900A73BAF6E
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7B23009C1;
	Fri, 22 Aug 2025 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jAUgWW5c"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB42EA49A
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870788; cv=fail; b=gJPF5lAhvpJ+ePwS0TJv/PEAW/EdgShn2SUhWIQ16wwk/ToKN3ZeNCgpME4bsXfcYxCzkOOXX1fNxS30XDrzwHQ5zx2exjYJ81kMBrT9CBMt9UFU6+bPj3iRkwyriUFdxdFaAoZOkWdygZh5jNATJ/aXjpxSSswpUb/3k7HHtdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870788; c=relaxed/simple;
	bh=Lfjcq9pDxFn3pDQoWvQHfjLMx2jzegH6pnPCQ5PM9TY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qFvFQgr7Qnls4Cd9xxKKVOr2qaWqmpQ27YRA6bECc+qRbPKgE9ACqZVVkKabtcye3kNts2OT1Kgb77bn+XaIlD0CUkVmD323wDB6M/Z3P9svZABn/ppG72Eim//F6wd+0TH2mw9hiGNsf02CWsScnWdTPj+m2QqER83HgaRWqeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jAUgWW5c; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EF+yyzEGYWMt1V+p7wNoo1qDxa7KKyQ7fa+M56lyd26mSilPeY0anubZ7oDrHuPPVrw1POVaGehUeNHxHJlFSLh7hIZzC3qhsOTT2eON8bR1bYZqCqNJdyCS+9yIGRF+WcJ01VOgdeXL6xcfth1qb7j2SZjztXNebEo+BTNxbQG/D1GABpMuWPJ76NaFEiaAPvEMWmyZFeuBF7nwHDLeixGnOV2wwxTWpiE5w5ToRKT45qDso7atKGlBRMo971n7BCYHt8pEk81HuTYpcJxmV8iqtCUbk52/volag6Im7Orq0a/hY0UKNQKNCOrmADe6KHFb9K2JClW+LqD7zD4YnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lfjcq9pDxFn3pDQoWvQHfjLMx2jzegH6pnPCQ5PM9TY=;
 b=KIaMOxxarx5Dgt6zQQYiXuw+JVkovyW7v5A4OvvaE+DrAbD1HgCpVsqeEq0BrBrogWDArLz3R2FwpVT9xlA+OUAEHYYSnc9aEKtlnW4AAtmQHmxnHIXXDMINvMz/YKL5G9DzNNNIRZhmoY4t9qacSbMfABD4cr2OU366HsKqebrG3QJith1wBI2ju650+nTh5JwxqTi4glE6vbFq2/+AVXmBdnrQX2ziVztM8jQNW5ma9+Q1laceMlNGqL+ddOR9QZJ+6U+P5d0GzvG5xrGs/cxIT6DGOt2EKH8uk+uevz65JmhfgjTmAznBfGuVEcFErxzMV3uKHOxuvcRKSgRabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lfjcq9pDxFn3pDQoWvQHfjLMx2jzegH6pnPCQ5PM9TY=;
 b=jAUgWW5cQI3dg57T2L6+uc5CEL0fzc1F710y18KTlB12mTKNZpQg6pEpDufFOJk4JtHlwXUq0xqxWj8ujxcA0DlTwgZQaZA+rTNi4PLSjD5PEkX+l5FvPNfKEuV4lahfu4ZEtEtasghen69yND2ZcV0TPjaYik7aiJ9ZHUtL2mGqeAeui6HCicdUVMtXQXtvkIKX43YFveKuIuKhGYQtdEuueDCXHYyGSaJ8E6IDAQLwpsPdI8pkHvHvBj2ZL41BSeNh8pbvJVfRijw2ap1YDKRTAopmIFmViJ1YpHX7zEVEdwYXEb62p/NMBAX4Pppb35sQd+SviaIswqk7qH+Ocg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 13:53:02 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9031.026; Fri, 22 Aug 2025
 13:53:02 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: RE: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Topic: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Index: AdwTTxd+YdVEFNqzQBWcarw+isQ7dgAEGgsAAAF2L4AAAZBEYA==
Date: Fri, 22 Aug 2025 13:53:02 +0000
Message-ID:
 <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <0cfe1ccf662346a2a6bc082b91ce9704@baidu.com>
 <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090407-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250822090407-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SN7PR12MB6885:EE_
x-ms-office365-filtering-correlation-id: 75e4ea09-92c6-4491-4d94-08dde1833686
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bjml4g3LLRzYK3SeVnYIXhYLbgfKln1JLVN0Jplt8+57tsWnqkGmy/VJ18Yh?=
 =?us-ascii?Q?3qT6RN5q5eASsZOP9Qfvqw0gh7hulpjii4k9MLzEClC3/VDsqatOxb044Fpn?=
 =?us-ascii?Q?sSf34StPAPyua3ND31ZJxYG0RR7a5K+YXA/NtgldMz2aStX+Y/xQVpJ57tbk?=
 =?us-ascii?Q?6w1t96h1xGYCQOrCxCnWt6BkAe9ANWV1T6pXrjAC6rQatgY2NjbQnFg6zC2p?=
 =?us-ascii?Q?8Cc1PQ7unllN0uSQFnpbprHRwkD3GxcuLJ1GVzbL07YtMfEsN8ssTrHUfEt/?=
 =?us-ascii?Q?3Yn8dmWkSTY6CdYIIyY2Nu7Ubl9eLFb2g/dXo6Pcg1YfjLQWZwNJCH3SrXQG?=
 =?us-ascii?Q?JWbHO6SIHp/UKJ9VttbRZEr8YMpRCfnEvHC5xuETaRuKNQpvVAgF8eulal5Y?=
 =?us-ascii?Q?GPoeh2ewMy1+lnDRtaam7RxfsJ/TAsx0s9/mKwRAeEOzFwkLZ5/obSZDUq8I?=
 =?us-ascii?Q?pfrCdEbOg5E6f/arCxy/XyX2texNACO2oAbPjoGxCJSiBKYpbtgDu76enB1E?=
 =?us-ascii?Q?uhF5mlyc9hhJQyjqMBQgxO1lb7BuPyY6mt5jtZ35u6jo73ivxWwCVCgD1gc/?=
 =?us-ascii?Q?ZpSAp+40G+L6WHgnddHf2OZKpjXEDTyxBU8B+bQJ3KbcqeCvvUsZqSYFdKmh?=
 =?us-ascii?Q?J3cfSO1mPeQUleCvvimdXAvsVwkdwycXmi7EIYz0SyquKC5VhOEoyIr/LQys?=
 =?us-ascii?Q?rMhowxkcJaghAaAFSU3uP5DBRtlXHFy0GicOFeOsfFPGF21T6tqMPB1RS+iP?=
 =?us-ascii?Q?4/1FtueoAj8WSTb7TS0BR1K1XZ/wpxx8R5nut8wdDjBP3NPMmkBPbzL2bKBh?=
 =?us-ascii?Q?omGiWApc5MbUjdqComo0jF9LT2D4PqMWbrW9nLHHxhUndcEqpq5vGZz1xCjH?=
 =?us-ascii?Q?AJ+jKrgHl1m7EpK513W5RJoSEwRv/rrHvZVSE30OxouR1SqCklgGKblxAgvj?=
 =?us-ascii?Q?1b09FwvOU5OZd/Z/WLtALblVPuvn87GXVUDMik9rh+iMpS5yNsjB9nQgMvzB?=
 =?us-ascii?Q?X4elQN1zev2cw/aMfDUkZTRacYhc7KAkaR/aFmJ7pAdDKWF0FPlPRmz13+CN?=
 =?us-ascii?Q?obwJ4pv8CboX+JV2nB6FlZG3M9teBgodQyEoeQCugUj4SFBZYU0Aq3Ga/HLX?=
 =?us-ascii?Q?fqgWqItYfop+HUGwgHnzJjNMXuf2kPUrgqibaOMjlX6zr6HlmPihPUlh9sQ3?=
 =?us-ascii?Q?p9HIQhxAwKKS/NoMOA73UVxcCIlgQdRpqtvClIVqCuaTX/pON2lQkEBvYs8Q?=
 =?us-ascii?Q?NaFPN1Cx9aCHb/TKPZ4bZlnLeZccrxB3b0FU+L3oZ4m4KezTe6Q6DjyPnY/6?=
 =?us-ascii?Q?FfMccvYmUno0BUvgoyL8LjGDPHOVFdd4Pz8TkwrJNgKlpbAhcgbHsaVHtzA8?=
 =?us-ascii?Q?4SxNEUyN0xjvq/CK9Ek0RKaWY/KAuzv2xfuE2hzmVMV07fNUeBTmiVQ7NBe2?=
 =?us-ascii?Q?2XNvc7ToSkN6e8ZgKBiswRSSnpo0r1Mc9VslJpxUPwgv0e7QFgF+pmpjqrrI?=
 =?us-ascii?Q?xQfMS3LAb6Rc0fo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aKewSd6Vh23Ct8hKrZpgJt6zVWP/YlpjOpIwZPZNQ54X8QtugXcbMZz+8WHU?=
 =?us-ascii?Q?0oO2k7DNLSHW3w50OSHksbfSDrpTANE/gE3NikiVBfoMMG42qw6BGwhtLgZn?=
 =?us-ascii?Q?xwtFpYK8KLqGzFzw6GqxiWTRbWopA13fVVO4jm4gIvfVu8w9tBnP/OF6U6mL?=
 =?us-ascii?Q?snqI5JlEhUecDTPGISrNCpzmwfUKIV8elSuwEiF7c2ev3fcngKP+iicpgd40?=
 =?us-ascii?Q?fCOkv6nT5Wycf5CPkWVPbEd6S8qNcXtqF7UIP3zBGm24/u/X22x+vv5ofRpg?=
 =?us-ascii?Q?XUb852pPo2Um5+FV2g0OkKTBqkV0K8FDBaWPdhpqcxViMc4kOajzK0BA1heM?=
 =?us-ascii?Q?Nce41Uejn3dYwwYqxowxawXG7zcm1s+G8OQIJZ0X1HO2MlN9g0+WIM7Fnk1y?=
 =?us-ascii?Q?iZBIVZadRRotL0IUAn9nBClsRNt6Y4/hHz5S3JPzA0ceAtZeJFCJbttNtYVL?=
 =?us-ascii?Q?Y6mHwxdxjgzbQU1j5irV5sdE7Pcn6M7LQhq+pxyRQNCYxrE2PkzvXlbqqZa5?=
 =?us-ascii?Q?sN+TVD8ZZC0maGIKMsXhW7hhTRK2wstgP3i+2cctLqLU2ZfKYacVUe5JWQSW?=
 =?us-ascii?Q?TSWcsPRQQGLyjWxxAf3Yz4vq9rpuq8yjMSQ9aHVkD4RC78ISQUC/9sOH1Z4R?=
 =?us-ascii?Q?yglHkCS1Jej81fsKYmarfvkYGe1EBz8U2gKRglBCNV+3VQ0vCrcReREl/AGj?=
 =?us-ascii?Q?fFrj2mg7yS3bqfaeSyugG18TAGRJjjK6/35kWHC+yYd822zMLJWn30mx9F7n?=
 =?us-ascii?Q?um9tLVKRZsZt+m2e1CLVckS1bM34joiIx5fE1rder7GbFEkzPRRYB2De3B6N?=
 =?us-ascii?Q?wZoHjuhCIPmt89OlYKh4BGKhIaPrUr3luAHShW4fttlQQdjaPoTe91dYFyYO?=
 =?us-ascii?Q?TPtB5NLiJAJ5iw7+bEwUMN10qgcbO5HB7R2CMotC6yBYC05oOYD5KVbhr5Wv?=
 =?us-ascii?Q?ycDECcmtQkCkH6mBcCFbj8UaJZu7YWBOPB9aTjVLYuy+JpFQ+ok0OP/yyvoQ?=
 =?us-ascii?Q?LYO1jvuhhh8aviU5jE9f7dx9VIpJLTZ+vVbhc6Ig0K6K1cKtnuQ8MDkcE8pS?=
 =?us-ascii?Q?acJHq4RnbwpuyFcPBnd9d/mSh5DTfeszK1FBLbrh+IStNbzpVns9meMUYe2U?=
 =?us-ascii?Q?IJJkZdIXMNnUx1EhKDY0ueHJv22xPT7VFSW8OMvPhHK0MZNDlbk8Yxx9KHzQ?=
 =?us-ascii?Q?ZUNfroi5hRBuXxianoX7EzwmJ0bt2GjunxAT+JWWWQHsRn7OxxBCh/KMllM6?=
 =?us-ascii?Q?dIwRsir7RQVDRX7hQWus1bNakCiSBRkNxvrjsbjdV0uVExNGFoKV5NdQsIIF?=
 =?us-ascii?Q?gz+ldYShwSvQFhxRQJhkCcNqoQ5VqXtY/xFJ1BryoopkdUbBxwdZHYBBS+RL?=
 =?us-ascii?Q?KKpWXAcg1uRF0NUTzGboiUPKOPsUuztvqtB/tMlRuDozyL0zKbk5kzptn+uQ?=
 =?us-ascii?Q?ofQ4YyWsw8dc/rzKdbC5QF41Lx6YXI+G4eG5uknQJsUGt04KWVyRVEx3PhHj?=
 =?us-ascii?Q?PpRBA5CCxUplcocO0LtKKMdUAjn1xcNMSbPNetlykNzjGl4AYChdbV29wsg8?=
 =?us-ascii?Q?75eL8tuGN+a1/g3Pfkw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e4ea09-92c6-4491-4d94-08dde1833686
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 13:53:02.8149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /SrSaOpoeleyJ2jJ6MFp/Rama0anpftUTNHdCfDdswAXWvXkReUJ8ry72YMLGUDvqQbH9LSBjJM1w2rLjmvSvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 22 August 2025 06:35 PM
>=20
> On Fri, Aug 22, 2025 at 12:24:06PM +0000, Parav Pandit wrote:
> >
> > > From: Li,Rongqing <lirongqing@baidu.com>
> > > Sent: 22 August 2025 03:57 PM
> > >
> > > > This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise
> > > > removal of virtio pci device").
> > > >
> > > > Virtio drivers and PCI devices have never fully supported true
> > > > surprise (aka hot
> > > > unplug) removal. Drivers historically continued processing and
> > > > waiting for pending I/O and even continued synchronous device
> > > > reset during surprise removal. Devices have also continued
> > > > completing I/Os, doing DMA and allowing device reset after surprise
> removal to support such drivers.
> > > >
> > > > Supporting it correctly would require a new device capability and
> > > > driver negotiation in the virtio specification to safely stop I/O
> > > > and free queue
> > > memory.
> > > > Failure to do so either breaks all the existing drivers with call
> > > > trace listed in the commit or crashes the host on continuing the DM=
A.
> > > > Hence, until such specification and devices are invented, restore
> > > > the previous behavior of treating surprise removal as graceful
> > > > removal to avoid regressions and maintain system stability same as
> > > > before the commit 43bb40c5b926 ("virtio_pci: Support surprise
> > > > removal of virtio pci
> > > device").
> > > >
> > > > As explained above, previous analysis of solving this only in
> > > > driver was incomplete and non-reliable at [1] and at [2]; Hence
> > > > reverting commit
> > > > 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci
> > > > device") is still the best stand to restore failures of virtio net
> > > > and block
> > > devices.
> > > >
> > > > [1]
> > > >
> > > https://lore.kernel.org/virtualization/CY8PR12MB719506CC5613EB100BC6
> > > C6
> > > > 38 DCBD2@CY8PR12MB7195.namprd12.prod.outlook.com/#t
> > > > [2]
> > > > https://lore.kernel.org/virtualization/20250602024358.57114-1-para
> > > > v@nv
> > > > idia.c
> > > > om/
> > > >
> > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > virtio pci device")
> > > > Cc: stable@vger.kernel.org
> > > > Reported-by: lirongqing@baidu.com
> > > > Closes:
> > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9
> > > > b474
> > > > 1@b
> > > > aidu.com/
> > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > >
> > >
> > >
> > > Tested-by: Li RongQing <lirongqing@baidu.com>
> > >
> > > Thanks
> > >
> > > -Li
> > >
> > Multiple users are blocked to have this fix in stable kernel.
>=20
> what are these users doing that is blocked by this fix?
>=20
Not sure I understand the question. Let me try to answer.
They are unable to dynamically add/remove the virtio net, block, fs devices=
 in their systems.
Users have their networking applications running over NS network and databa=
se and file system through these devices.
Some of them keep reverting the patch. Some are unable to.
They are in search of stable kernel.

Did I understand your question?

> --
> MST


