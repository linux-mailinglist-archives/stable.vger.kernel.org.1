Return-Path: <stable+bounces-172684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0988B32CF9
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 04:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93964852D9
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 02:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0A01DE4E1;
	Sun, 24 Aug 2025 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m9E4CCsu"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7231D9A5F
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 02:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756002989; cv=fail; b=mS7FYiXQCbOCFB/DcjFxiC43yHodFC8GEVXE3LzljP8o2GjgajInKp2d91aUUrcaVnrDmN7X5+mxMnyR6WbCjGF+9i8pmARY7rLKzYNCLH01WRb/1u4JLWC9TdBuUo3h1ftiRREQfYooijrpRKCFuo2JFg0ZQa3/8QcCmYbvmfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756002989; c=relaxed/simple;
	bh=6oJh0E7J4VuCLXeiqnrm9Y5+OfyeW2YaB9yLw4JRD3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jz4lkumPgrFnIE4g+flXJnb04uNXb69Zi3VlzArg62NGAAn8bB7qlTtu+KK3GzhZ/AjdZGqM+wetvvL9Tk4a9VGTRZhS7aUsDY92xhZajXuaRUq1bhR1hSMJLOSfQHmoB1ICKu7vEZEEv6BgambiQkeVe4txPJ7b80h/PHi60ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m9E4CCsu; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnmuL4cxYp+mj/covpweFMc4/CHZxX+X+8GPoHmbCAi0gKMFmjmxb7ENG3tps5y//MhqBMevA/B4ENhCER6jySW/iYKaZDLi5x99+hiqBnGEJ6HlHGNz/TXsn0KbvdRrgAp5WoLmwtK4RvQomsPO28LmVAMz/TpimF3e/UOR1YLIeG3455Hpug/QILiCOLLxQX6cLIGWysB7Xmp0Ommg5BNahGyGqWVHxVeyY40ZpJnWbRFA5RPF0f/N4q6umXHaUFC0ACVCd3sT9RS4Z6tG0WHpjv+Ps7Dcape2uiL+ez7q7ZPZ74dzu6lpZJqk10GVPi24YtCsU7nnz0D1qnqyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41Z1PSI1uKVlH0qYSKsBlNLNiIyD7bmI8kE22e34NCM=;
 b=p8C8yjnNVAooXZtGM2K4vPLctjk/jquxR34tjX2J8Tlz4IwTaEkTkvDdRhEiGsAs0QJO9axEmAPyGbiDRk5yj7gXGSloW4Zx2phWhxJ3ra/TraKVBeOZrXsU0xIw/P5svSV0AHOM6T9Leo43vxpuOgSpr6+MxwemvI0gVkfxLZb3npK1Csgq/u3ElOFVdA7Wtu95kR52fnKr1OYh5crqFpNv8QY/6lPTZF/xBAA9uj0w5KjpVL5ScGWydlJYLRagqmHXBSRal2rxTitgTFP5ZOil5X8s53SCZFZvloCmCvoWKOOl3kacqYBmVRm1jTM8oGIxz8Zak8uOmeR5483r3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41Z1PSI1uKVlH0qYSKsBlNLNiIyD7bmI8kE22e34NCM=;
 b=m9E4CCsuS8eO19Y+oKF2NdClJsn6FdJwESqu9kuqF2TUHJgrOOy8GSvTmSx/UnpBghm6W6PPz5RUqdvvaOHjeIXdLCuaElZpbBsMRkUyYOFEQLQ8vzhmnswdsJ4NZVDWiwOntXsMO1FXTpCxr2d7jrDTcRb5NkjnzNF24ML8solx2xgBnqF0J7uvLTSvKrr6Hw3JihYVxzFCBq4G0QulAGNZ1eNaE6mgybHBokbpZeCV+ylSVNtvwijtrIas3ILSAZkA2U+NVYwxmj1E44VifUz3efDMOmm604oVoz7USNJ8KhiTELrQ2+kQMmzczKHd2P2qwQkDiFzuyGa9H8qPww==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CH1PPF12253E83C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::606) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Sun, 24 Aug
 2025 02:36:24 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9052.019; Sun, 24 Aug 2025
 02:36:24 +0000
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
Thread-Index:
 AQHcE0XKqVbu8cWtaUCLZj1LjgeTGbRudpsAgAAWuWCAABaPAIAADA7wgAADewCAAmIWsA==
Date: Sun, 24 Aug 2025 02:36:23 +0000
Message-ID:
 <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250822091706.21170-1-parav@nvidia.com>
 <20250822060839-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195292684E62FD44B3ADFF9DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090249-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095225-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250822095225-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|CH1PPF12253E83C:EE_
x-ms-office365-filtering-correlation-id: 1f649957-2cae-44cc-2617-08dde2b70495
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OBDp5Q1NKe+nFydDViyGD/90/3KN9uPBBh/HmWC2ZO1R5WioNOMccIGp4WZW?=
 =?us-ascii?Q?Tkn/VnL0elCt5iUYOlVxnCgkGURIItCCJO8ZaaUTzdLveoFi5ot3IQ84PsW/?=
 =?us-ascii?Q?RlcqZrBVzg56ICg9pxaaHPdZ/VwsIFlMuZPvATJKMxQIx61wKyRlOwIBps1T?=
 =?us-ascii?Q?SIPCelAyjkUYa802kmcCSUeWNJDJfy5QLarwt4N/RE4VmwaoI6enuuRXCm0e?=
 =?us-ascii?Q?gPkaPaao9AM7nK8I07/+fFSaaVAMooUYsXEva3MMvJLfrL9JE+igRXNVLiHM?=
 =?us-ascii?Q?2gQy7DT2ELDvwPBrn2/nfUwGeCcTS4JNXDrPoh9YasxTxmdgT7op1TMcb2jR?=
 =?us-ascii?Q?b1bo2Ehfa224u5NtXZUILkvHStr4bmDJ4Mf0S5toCo6nwTyYAPXlMcpMNYY9?=
 =?us-ascii?Q?aHqKYJ7LL7NT8bTx5NaCmAXEidUlkNYSlzsEgw4QDD3gvZBc6E7AMRzIcdwZ?=
 =?us-ascii?Q?vhT+33CQi/MozEH2zZoMso9S2Bi4tLMkf/Iw2AP7sC1noftczTy+3wZohUpQ?=
 =?us-ascii?Q?UD9LwkjERr4fl9CjsDYdizR5taUf+qFJNO1rO9ncO4WP/wZ38jwoWUH/a0xD?=
 =?us-ascii?Q?+RYb3vyg2CFV51bRFXYZSlpIE8rzz1fa3CaKrcbdPCWs7iLYI3SmGuPmara/?=
 =?us-ascii?Q?N+LVp/2iBFjL0VB2CvTjsPMk14FP2rd46yHLp6825GizMhr5ynId8Vf8F+LW?=
 =?us-ascii?Q?tBdTrU57QaceW28THELx97ireDUIPQKjPB4vxlOeUQQXXq6mAwqm2kQVwPaf?=
 =?us-ascii?Q?mkXWeBc/n+l3TOESY/VBpET09UXCj4IEUtrpZmT1dKcy6muh9AeDc9bHDqzu?=
 =?us-ascii?Q?tjVfHwM4Z9LVvbUWYkbNXRMffm3su0rZlqcwaKeeu6BF18o2hdJ0IiDaH5b0?=
 =?us-ascii?Q?8YF3S1LTtHa7/kaeRAcrH8MgIeB0zu9iJzq+yxMH3wH1Gz3Yx+aA7p2PZAys?=
 =?us-ascii?Q?pZ5hLR7eLhRFm3owMcxEGhUdaB+0ZCXZeE+78hspqf8JM7qWOgclP/9rGCss?=
 =?us-ascii?Q?jB/bs24jU8PN/GlVPbgvHug686CwloBjvS1gMrGqViTvR7bX0on0V0r1KmcW?=
 =?us-ascii?Q?m8lQzN7JzOZbW4DMipnIy0wzgB3jpWSusdtqvn7MIU5JmN1t3mFKvafaBKO6?=
 =?us-ascii?Q?F8ehIXApl1NBM96KiNRdzFFRH7jQLwYACsuuxWfHk8gm+zw3H7FL7U31nCIp?=
 =?us-ascii?Q?NSN5qDjYDzFqjJ9R0qxigg5Ld3WVcZA3aIzQOhWpwUKk1X0wqsZ+SveIBPDQ?=
 =?us-ascii?Q?8aOyrZIWw/l6gFVPaRza5kOrlU8M7NCz6jg+aGhSAx53hePfQbXBm/0JvFtr?=
 =?us-ascii?Q?NdCGKDF16qJmjcl6JYPKj95PyD5NFHYR8HI552CT94/tv101gpsf72VplWiC?=
 =?us-ascii?Q?8n9h1AmnieiCukoKWRUHCo6P+pGLOoDl8vuQn4RgUXezzBuIBb03qGnQsrq0?=
 =?us-ascii?Q?O6/LTCeZ0IbmOvXvw/7OJxmxCejXeDgLVY8sO47dDgJSiuEJFqJcRQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?th0rEqsX/g8rM1MFShUVcfXBJnS9wuNU8rVG7f3T9aCpBxHkBUSU5HKE/IcI?=
 =?us-ascii?Q?GhNV4ZoA2OMMCDBvXXgf9DEDdU692+VArG9jCl6bGXhwZTBly8bRfyq1IkKS?=
 =?us-ascii?Q?Jv1OeEr0v9+YJ94vRRE/lsndA8nKvFiXdJntCuz+UXX8iyrQO6LPj+jz78km?=
 =?us-ascii?Q?jPWO/5EhfJ7u/xUcswIPKS/fVD0NQ+aRfzQaqLQ3UUbHfGgjNAPxz/VtKx/e?=
 =?us-ascii?Q?5aTgkJfNv6QSXRbQbgJsfKrnFUuVMyyx0a3rLK9ArKOgv+k9hZzOUKddmLdi?=
 =?us-ascii?Q?BK8Noc3/UQu8uYqnVpQqt13EoxzShh1n/ZlOW5lOjGAU6WC8VVTY58qhzrkv?=
 =?us-ascii?Q?kOBvEJl0b/O4k7Tn1tbyEDEWS2vIizdQ3i7jQOObswrZGVvTOcVHiFe48GyK?=
 =?us-ascii?Q?YS0njoQdUJpHoStohUBDX0bQCp+eWLaEJ2tbAbdUxWLNh6tkqJ1VqHwMffy9?=
 =?us-ascii?Q?D04mXjdhh+xhhR4ansVrUbXIH3Rcqc3WiGKZII5y6BnM5Q6oR8JnAbIjiSkG?=
 =?us-ascii?Q?ee6W72pnTP73SMgrIxXtXzgao0T7UTPH/pYeiTbYkZUqz8aP97jGrF5iVA9r?=
 =?us-ascii?Q?8908DPlF/HNZkywh+qd+vfHXpYar+jK6r+Rgbq81sUenJ0zKEqJ5fLR54cgF?=
 =?us-ascii?Q?T/+dNvXnKmkvpCzV46zDdmHa7uYI9j5M7yXh2v49HLNuJcpTAhl5Gez8MHUh?=
 =?us-ascii?Q?UnoA+9BzwlQ60RDGDt4qSdLFOEf48CW/catnUk24sU0xqMi0DtGea+UTBsUK?=
 =?us-ascii?Q?M7/Zjz7gz/9FeMzk6YW/or43uXpM3hgvtEFl7hHbv7BQfMrVe+d9Z6CyIoHq?=
 =?us-ascii?Q?GemdeC4dAlAQNYtzaPuFfRc+EImbZeeu5WvztoB8vbFaQ/0iSmMtzMUsQNDJ?=
 =?us-ascii?Q?z6y5J9lIvb200faL7uA7DCIurKPBnAu9CDzA5ZzNYZtUYGWr7vJG16j6V4Go?=
 =?us-ascii?Q?zHtCoTk2TUGPore02kTTfhALyqOPx8TirX5orvNldlAzmETp53C77SqA2SfR?=
 =?us-ascii?Q?vGGq96hD3KS03cnAK43c7sXgNiDsXXaGh2HSDl6omPQ52OFR/b3l3nom9dnD?=
 =?us-ascii?Q?LqSNEDNDtGakPIhOb91/fGpAY6REkk5OKc6PW7lom7KjszdsxxUw8gYl4FLN?=
 =?us-ascii?Q?Xw3h3K8Ho18jCeQ2+b5A27gHpz88wKkTE5nQj4OCH0XtuY+udqDy/UhbdqfV?=
 =?us-ascii?Q?yrf+WUG8G8mGFIvGvMuLoMKRfkC8Sg5n/omu9zZ6odrykd50qjYU7i4k/pP9?=
 =?us-ascii?Q?KqKgdte2H2PREjXCjgiFBOv8vB+ivOaGjSysEsIiwlkkhZuy2l+gS4wv1fTi?=
 =?us-ascii?Q?E9q573KOT5+gpbiNO22ucymkdMgZ5JzrK1/qgZUMZ11BmoFlcCwZSHmJJuT6?=
 =?us-ascii?Q?WDfca0FeoD32DrQmr9xwyUXys8swfwe+/+HRwprNA9ZuPoBgZSIMj5k1XTRt?=
 =?us-ascii?Q?fHE5zNeoZE0wZAdMgzlFBaDENoHmpy9TYd0YiF1RG0zxyz+9jupw+NUa3ZUH?=
 =?us-ascii?Q?ZfVNSR8+v5E/krZtPtoBKWQWD39oSBN3Q973uGPkPwqENScT7iLGkHYhoLMV?=
 =?us-ascii?Q?ZfcxypYX9+0tauu9T6M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f649957-2cae-44cc-2617-08dde2b70495
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2025 02:36:23.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XW9XP/80CkJAJuLyrKdTWzXFhNySM3McuTszRxmRrvLGkejdalhVCNL1fUoS8jPuZ6JTJqo6oOaKqqujwMpVwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF12253E83C


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 22 August 2025 07:30 PM
>=20
> On Fri, Aug 22, 2025 at 01:49:36PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: 22 August 2025 06:34 PM
> > >
> > > On Fri, Aug 22, 2025 at 12:22:50PM +0000, Parav Pandit wrote:
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: 22 August 2025 03:52 PM
> > > > >
> > > > > On Fri, Aug 22, 2025 at 12:17:06PM +0300, Parav Pandit wrote:
> > > > > > This reverts commit 43bb40c5b926 ("virtio_pci: Support
> > > > > > surprise removal of
> > > > > virtio pci device").
> > > > > >
> > > > > > Virtio drivers and PCI devices have never fully supported true
> > > > > > surprise (aka hot unplug) removal. Drivers historically
> > > > > > continued processing and waiting for pending I/O and even
> > > > > > continued synchronous device reset during surprise removal.
> > > > > > Devices have also continued completing I/Os, doing DMA and
> > > > > > allowing device reset after surprise removal to support such dr=
ivers.
> > > > > >
> > > > > > Supporting it correctly would require a new device capability
> > > > >
> > > > > If a device is removed, it is removed.
> > > > This is how it was implemented and none of the virtio drivers suppo=
rted it.
> > > > So vendors had stepped away from such device implementation.
> > > > (not just us).
> > >
> > >
> > > If the slot does not have a mechanical interlock, I can pull the
> > > device out. It's not up to a device implementation.
> >
> > Sure yes, stack is not there yet to support it.
> > Each of the virtio device drivers are not there yet.
> > Lets build that infra, let device indicate it and it will be smooth rid=
e for driver
> and device.
>=20
> There is simply no way for the device to "support" for surprise removal, =
or lack
> such support thereof.=20
> The support is up to the slot, not the device.  Any pci
> compliant device can be placed in a slot that allows surprise removal and=
 that is
> all. The user can then remove the device.
> Software can then either recover gracefully - it should - or hang or cras=
h - it
> does sometimes, now. The patch you are trying to revert is an attempt to =
move
> some use-cases from the 1st to the 2nd category.
>=20
It is the driver (and not the device) who needs to tell the device that it =
will do sane cleanup and not wait infinitely.

> But what is going on now, as far as I could tell, is that someone develop=
ed a
> surprise removal emulation that does not actually remove the device, and =
is
> using that for testing the code in linux that supports surprise removal. =
=20
Nop. Your analysis is incorrect.
And I explained you that already.
The device implementation supports correct implementation where device stop=
s all the dma and also does not support register access.
And no single virtio driver supported that.

On a surprised removed device, driver expects I/Os to complete and this is =
beyond a 'bug fix' watermark.

> That
> weird emulation seems to lead to all kind of weird issues. You answer is =
to
> remove the existing code and tell your testing team "we do not support
> surprise removal".
>
He he, it is no the device, it is the driver that does not support surprise=
 removal as you can see in your proposed patches and other sw changes.
=20
> But just go ahead and tell this to them straight away. You do not need th=
is patch
> for this.
>=20
It is needed until infrastructure in multiple subsystem is built.
>=20
> Or better still, let's fix the issues please.
>=20
The implementation is more than a fix category for stable kernels.
Hence, what is asked is to do proper implementation for future kernels and =
until that point restore the bad use experience.
>=20
> --
> MST


