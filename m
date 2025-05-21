Return-Path: <stable+bounces-145790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 759DDABEF4A
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 11:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92F13B0B31
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 09:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB75239E74;
	Wed, 21 May 2025 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ajTKF9K7"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79623958D
	for <stable@vger.kernel.org>; Wed, 21 May 2025 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818877; cv=fail; b=IMIlNLrxm8BbzB+Mvn1pyojZ1Su/BlJ6mawltxdZaqI2o+lOzt/pNaIQQDa5g4ch27RMCPFn+nzwDGr11QHsSTa6Y0jtYoucLWN1Ip2eTwD002yvEMVV2oLZcuLPWWhsfDo1dm4ObezpQPL+Ohs3zW+fwiV8lr0kwqOz8DcsOKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818877; c=relaxed/simple;
	bh=ScmhSBVViLau//WgGKGIPhfC9ePMcWwpQGlcjwUwVT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PRC/uSuAYcbtREiOcsOdchnugXqs1wyWiGCv/w6Ajii5ejOijj0WEeIkO6suKLBK3VCbIf/1JNXNktRtFCXJo4VMOhdGn5MlvKIHv+YVnx4WhxzEJm7FrQOEuyErvEEY6B7t9Zob33+yMu6dOo2w8EdQQUwI5cbVEKJ54d0G4DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ajTKF9K7; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmqYy2Yr8Ki+zDPcS0YaD4NAPBsHIjVL1iBSCXanEW4IxGCx30cPGS43wQTEGpkUgJ1ZgF6xV8eGpktg3KPSritFxM7xCaLUy7wf0LgI0zIguXzSx5l2++33SQh1dRAvedp97QFvytu9r4QvhI2Pt59e8dXyGhM66md774cK/nAFn4Ef4kXrsjapPqvFcL8ra3AhG6+odxAaUBGkf1lL1Kgkjq7v/BEv9P/V+vAsVeDevPxGB8sEcq/jL3Z2HlblmcL1G1+sK2tv/fC/sAjKqkjpSBbH+A492YykaIyNpef0SIyRnirdzaYMPtkjIdGLbToB6EV/jTRcj+rLTElhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TEUf5ruE+jHbaa003PAvWREXOehO3E8PWqHBhXMxH0=;
 b=tXIyk22RrGiQL+iYHiHr9KyamqX2JssK8ROLVYD6ZAGH77OxTGYrk0vfk0vm9sNKiSj7IdkY/D6HeXsmrGcTUsJ8c25ZF8PD/bZs+2Y4Pmppvgf1h7VLO1EuM7OgX06+NMe9mTfXkGc2XFIl0yLhAKGllqNUI3l7rYDo+fYQwdRUM8xQKXObaUcbINs8wV3JngJpvtmVL5AUukXebBOIjTYbmGIy6cfEKJDGacniRCsMCOfv6w/8q9CFF0ojwfyTs96dx1yDRDOuODAgmxIXYDVOdIugSwx/ek00zUdkQr17LBIcyNR9Id2Hagut2xUHtEaHmNS+pmCSQyNW//cUFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TEUf5ruE+jHbaa003PAvWREXOehO3E8PWqHBhXMxH0=;
 b=ajTKF9K7fJu73cvesOfAjopTdfsm+Zs3xf0gQ3PM9blkG9DPbkG6tOryu1x3T90alSQo0Ju+FjazIt9/AX3nFrGrLZ/5jQnhM2FKg3e4XIlBMo/2YCKAaGcx9VDV8Z2zGm8KO4CCTo9sqb/0oevQft3nnNQrutwWlA2dPjujy8WNY5cxAWohJd/sQbXFHR+85Wm9YO2NdLd+AEIgKpYLeiyOFtDW6ZSbkkx4vcYnTNqTTkEvPwhDlWaomsLoJ2xd/Ys/61De7CZD75cAKEqL0AM0BPYhHg6jTax65v34Wl5EjnP9Zdn59h3PAELoH4QNjHdSO2PPgsx/AsOESKN29A==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Wed, 21 May
 2025 09:14:32 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%4]) with mapi id 15.20.8699.026; Wed, 21 May 2025
 09:14:31 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "stefanha@redhat.com" <stefanha@redhat.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.or"
	<linux-block@vger.kernel.or>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "NBU-Contact-Li Rongqing (EXTERNAL)"
	<lirongqing@baidu.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Israel Rukshin
	<israelr@nvidia.com>
Subject: RE: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Topic: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Thread-Index: AQHbyhrdL96Oqawka0G+Ryv5JzR6PLPcvXWAgAALoUA=
Date: Wed, 21 May 2025 09:14:31 +0000
Message-ID:
 <CY8PR12MB7195F56A84CAF0D486B82239DC9EA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250521062744.1361774-1-parav@nvidia.com>
 <20250521041506-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250521041506-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|CH3PR12MB9147:EE_
x-ms-office365-filtering-correlation-id: 378ea837-75ed-4b74-0e73-08dd9847e555
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rOBH55Jbvd+u33pM/QeQVphFQ4LSrl61wulEvda8ehAA1KDZNtWVS6hjmH/x?=
 =?us-ascii?Q?XLaqlLpO9JT/72meePb4Kh8peeV7c38aGt7Wyhf3WJyeJkterUMsmpwdBZlU?=
 =?us-ascii?Q?TPiQbHOu58zq/Awfix2ew6FPDvxDo9HO0KCcgrTONP38UNKfwtUW0jdUdC+f?=
 =?us-ascii?Q?EfaXnwOhyEQkl/BtYVj51QLI7BL5fN1Q/FEzYupScpLUHHbtUgmSg3f5Im0R?=
 =?us-ascii?Q?pgLGDCCI/leMJl0+tYPPqwnTGyduutuCF7lvVion4yGBK594HZFaG53vRuL+?=
 =?us-ascii?Q?jPL/2Zx2qW2QnFp/ljCF2aaPc+Z4PdeHkBwN1mGnU8Sd/oPoTRANoSc0kzvM?=
 =?us-ascii?Q?KtnOvy3jw08ql6eqHbU4LpTxPzjkSJqdpxMRgr4E5q1X2ROj4nzTiJWBw+Ag?=
 =?us-ascii?Q?10H4J+jRpNraTGLFTmWA8peKD9rxxL3bT+QnCQum8YgUkOjYPebsdJlbCsG4?=
 =?us-ascii?Q?18MIRaY6XXHiuwFLDOfFrQoNSMETexbd4G1UjAwFDTLkXrCd2Oa1XiO4I66Y?=
 =?us-ascii?Q?YpcIcVGs7aNU0ChpriczwKMgaSo1C3Mb3DFoebMIPrCQyW/CichDCcmOeE/E?=
 =?us-ascii?Q?rfLXf1/3vJrzhwfdKN0vcgqTZsqTS7eFrCom5QToLIdHjH+XSZcAeiLW3v98?=
 =?us-ascii?Q?DPa//xa8LoxiwkA83oXH9NH1nHN4q6xRVI4I1RV164N/XeMeGqo8wsu0DjKR?=
 =?us-ascii?Q?OhzL+XJ7/ZJ2w+uS5sFQNNCatwnxp4XQrqOTPCRTWl7ExbT3WCzze0Ws0ABI?=
 =?us-ascii?Q?7i3y0Z+5uO6dMtTva6niAoGzLe5U6ixzjbSlzWdsmwfeCa165KhlWrxBgk6h?=
 =?us-ascii?Q?5mHT6AQPL3jurfTEHpkciRJU7LjvsdSSI6gCqncSdUvzsmoAJcFxyUwKTivF?=
 =?us-ascii?Q?SA2u3blvM3JV2Ar2bN/Io7OqipVyHDbgNv/Tfk+FDW7I/ljchm2bdfUVgN8w?=
 =?us-ascii?Q?767YwZG4ns11WbyxC5y8MD37ifL9Tt8wWEQu3LLS2HMGQlrOgeYoUubzRIlH?=
 =?us-ascii?Q?BTHhME7YBByUyRUfZJ1W+Z/FmcWpql9lAyLQPS2HBU2fu3tKl7jBupBKD636?=
 =?us-ascii?Q?Z3ImilePtKMC++RwfGzeslWwKB6oQcxaKKs835nyMoohsqZp4NeqR4DNTdf4?=
 =?us-ascii?Q?bF/sHnunDXZxHLvCHs5ZTXtspvO128PKZnfX9q2RJ7m5v65fPlK/K9bUe3d4?=
 =?us-ascii?Q?fmhep50XEm7mHCVRzIW86YcQ/QrB8xyGiqAvbaXVF5OnSwItR/CKAZOJTXMD?=
 =?us-ascii?Q?aIklQVkP1+2/DDVQhL7c2nlb4o6xvAksx4Bgh4LOFK0M9ofBMeRvUPrmt/iu?=
 =?us-ascii?Q?AJxdUQ6lTDD7au8aKE9BMDqT6vnTkECb5c+hyfKFykKoe/oJ64qoKe3ya5Fp?=
 =?us-ascii?Q?J09lBurZH9YiyxXLQ5wos3gd1oCxAOh30KjNTzjmIWKCKI0jQ4h+G/NlWtTp?=
 =?us-ascii?Q?lxAaEf66giV5p9scdc1gncdj9krrEAM3iuQONphn12ShwkSVicm70U4JRHIC?=
 =?us-ascii?Q?4C4kSZFZ66tHlMo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xmW7xZ2/fYNf4dXG1MjfkvtQsFtfolUSNs5vBMGuS5z/kq0T6Zzu2izQy4ov?=
 =?us-ascii?Q?/tarEKWaB47Hxe0/qdGT+RgltJ27MaIJGsGkx0XcEcypCuFXURpUv5iXihZo?=
 =?us-ascii?Q?h63T+0Ns2RMBirTBNJ8irsq2DEN/ks9wWNx2voRq+oKwgZRJRwXHoOaoNftI?=
 =?us-ascii?Q?4GP2+8OwHBbKDT38JSLnSqVv8cabR2rU1RUwnQQxEIPYh0e7Vo7zH7BkKNQE?=
 =?us-ascii?Q?S7wyaoJRwQdmrFpMsvNaM+SKS60sAwXCkq/PRCvoJEZlJ4BuZHmYumNGu3mA?=
 =?us-ascii?Q?ByPKSuN8r6lozmzOyDfSRUASRXZWL1NkxZ0nbkDfPURRBZnUz2UmIovJEPMG?=
 =?us-ascii?Q?uscK1rIggVsYRRNx4e6kRycgCvSY4MBCzd8z2j+PlXMEiaH0VzRJT7rYARpf?=
 =?us-ascii?Q?lMIJA/GYhLQQ5s4t9ZWC6MhMRdLUPpDqOLSn/KHAB/RFpReBwuoLCgTUoqXz?=
 =?us-ascii?Q?YRMk9gvOkdiUTFxEnFrlbOyCyayAyAm29Nafps6t8Gd3iceuzXc398UI010Q?=
 =?us-ascii?Q?0+pdm/0hQhzshLJyBDaC6B3Sc0VXFJOBFWpssSI6MDfjs+0fzKhMTXQRbNYk?=
 =?us-ascii?Q?TCehNOCgfEpj69Db/zkt5auxTgTj2TK+j8lv66MUdIP54d51yPkvzPhhD11Z?=
 =?us-ascii?Q?1K8x/BK8JaX4bWfYpItBEe29fyno2XbU4UXeK6rylpjNkH9Hxbm83Q2GXJE+?=
 =?us-ascii?Q?6fJlvsEJSZfHyPrV66mlUo0J9DSFTxkPeo+Dp4ow2cIIzxIhhD2szvEKzeUx?=
 =?us-ascii?Q?gt5+MhE07GJf1wr+4HnbsLWDiXkceX/yCJeryvWN6oUo76pVWVPSjkbX9bTR?=
 =?us-ascii?Q?krT1i+OBRiOhf/aqseoDoP+bOfxVrsdSn3jWFJvKw5STNwQ38k9naEirEhbk?=
 =?us-ascii?Q?EAoLof2L9+u4g9fyGPWd/mk4tbZPKqsiHF6uScn/eYhcS/2Rjhxolq5zNs5o?=
 =?us-ascii?Q?3FsCp9xf6PqyLAdxtVlbTdab4vz8KeQ6+3PeqvLzXebVOj7j1LQCHTaWWNus?=
 =?us-ascii?Q?LNY7C7xJOdnKTjJRWpoApr/hbw+NXtO529ruw93DfJpjKsME1VQedOoN9pUr?=
 =?us-ascii?Q?ph52RKWavz4OHZ4zAhbFA3Vk1PvvOZvtwdTQcFoiwkuL1SoEb1IHrYA0qyVN?=
 =?us-ascii?Q?6s2Uo6HXldW1Jwg04WEn2/d5dkEa+IDPAdUe3YIMKtYk3xuA4MhfAOv18WcI?=
 =?us-ascii?Q?7FAUY0qaAA+Jeoi/P7BgOiIZYjcssRRWMZjjuZTbpK/0GDONOA09THkO19u/?=
 =?us-ascii?Q?pcexcSZhdx0yIHvGqTXQtK8FdM53jvmjooN47Rrryz7V32nlDsFpe6DaFO+3?=
 =?us-ascii?Q?yUIdZqewMJKyyKXWa8KecahmgYzH642UACi5HMGJQZIVruoksM7M6rGx4V+o?=
 =?us-ascii?Q?rgYTqiDnkzfQ2DVu1EOl44YBlSriYak+xA72KdZxAxzwl2JfU8OIZLdpVNgV?=
 =?us-ascii?Q?BdNrrHtdsf+OeTO8o20KImNs0fXTFKYmAQ6m1CJNHDj/Vplcb+hyDcTWdq1A?=
 =?us-ascii?Q?Bx70RQGU2ftwzqKyE6066AZw/okv07VMzHwv4yl9+MmGRJcDx1UoTkRtLT4T?=
 =?us-ascii?Q?SbAgu/VPZ20xigTx+VA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 378ea837-75ed-4b74-0e73-08dd9847e555
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 09:14:31.3788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNBkgodi4BMERLiYPGsSACWByMm2Cezav9JxVZhJmcEG+tc6jpuJ9j8osylFSM5M/LEr149LWi9uY+AHKG+0eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, May 21, 2025 1:48 PM
>=20
> On Wed, May 21, 2025 at 06:37:41AM +0000, Parav Pandit wrote:
> > When the PCI device is surprise removed, requests may not complete the
> > device as the VQ is marked as broken. Due to this, the disk deletion
> > hangs.
> >
> > Fix it by aborting the requests when the VQ is broken.
> >
> > With this fix now fio completes swiftly.
> > An alternative of IO timeout has been considered, however when the
> > driver knows about unresponsive block device, swiftly clearing them
> > enables users and upper layers to react quickly.
> >
> > Verified with multiple device unplug iterations with pending requests
> > in virtio used ring and some pending with the device.
> >
> > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > pci device")
> > Cc: stable@vger.kernel.org
> > Reported-by: lirongqing@baidu.com
> > Closes:
> >
> https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b474
> > 1@baidu.com/
> > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> > changelog:
> > v0->v1:
> > - Fixed comments from Stefan to rename a cleanup function
> > - Improved logic for handling any outstanding requests
> >   in bio layer
> > - improved cancel callback to sync with ongoing done()
>=20
> thanks for the patch!
> questions:
>=20
>=20
> > ---
> >  drivers/block/virtio_blk.c | 95
> > ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 7cffea01d868..5212afdbd3c7 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -435,6 +435,13 @@ static blk_status_t virtio_queue_rq(struct
> blk_mq_hw_ctx *hctx,
> >  	blk_status_t status;
> >  	int err;
> >
> > +	/* Immediately fail all incoming requests if the vq is broken.
> > +	 * Once the queue is unquiesced, upper block layer flushes any
> pending
> > +	 * queued requests; fail them right away.
> > +	 */
> > +	if (unlikely(virtqueue_is_broken(vblk->vqs[qid].vq)))
> > +		return BLK_STS_IOERR;
> > +
> >  	status =3D virtblk_prep_rq(hctx, vblk, req, vbr);
> >  	if (unlikely(status))
> >  		return status;
>=20
> just below this:
>         spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
>         err =3D virtblk_add_req(vblk->vqs[qid].vq, vbr);
>         if (err) {
>=20
>=20
> and virtblk_add_req calls virtqueue_add_sgs, so it will fail on a broken =
vq.
>=20
> Why do we need to check it one extra time here?
>=20
It may work, but for some reason if the hw queue is stopped in this flow, i=
t can hang the IOs flushing.
I considered it risky to rely on the error code ENOSPC returned by non virt=
io-blk driver.
In other words, if lower layer changed for some reason, we may end up in st=
opping the hw queue when broken, and requests would hang.

Compared to that one-time entry check seems more robust.

>=20
>=20
> > @@ -508,6 +515,11 @@ static void virtio_queue_rqs(struct rq_list *rqlis=
t)
> >  	while ((req =3D rq_list_pop(rqlist))) {
> >  		struct virtio_blk_vq *this_vq =3D get_virtio_blk_vq(req-
> >mq_hctx);
> >
> > +		if (unlikely(virtqueue_is_broken(this_vq->vq))) {
> > +			rq_list_add_tail(&requeue_list, req);
> > +			continue;
> > +		}
> > +
> >  		if (vq && vq !=3D this_vq)
> >  			virtblk_add_req_batch(vq, &submit_list);
> >  		vq =3D this_vq;
>=20
> similarly
>=20
The error code is not surfacing up here from virtblk_add_req().
It would end up adding checking for special error code here as well to abor=
t by translating broken VQ -> EIO to break the loop in virtblk_add_req_batc=
h().

Weighing on specific error code-based data path that may require audit from=
 lower layers now and future, an explicit check of broken in this layer cou=
ld be better.

[..]

