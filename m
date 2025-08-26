Return-Path: <stable+bounces-176425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 143C5B3729E
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 20:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 107157B1D52
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467C62E7F21;
	Tue, 26 Aug 2025 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dNfBZ/YD"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6342980A8
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234331; cv=fail; b=j9FRwpcYD428QY34uSUjsCYz8LlCfIp1zAaVRNZ6rGOpMOxKWl3TAnKYxNpSeQoT6+fN4ZQGv0u5s2AX2dqLnmP1euUmMqswgxahenPx8/twYKZ3qEqu+jifvnZf1hGfZ/qxte1FnRZpe+hS8mqjIVJyhMHSSCBJ14EvlkE8yuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234331; c=relaxed/simple;
	bh=+QehTqjnTAAA1ZYXrVx3ZbWG+NuOAUnDpq0InA2fPbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UinJ46gHiz57sI5uDR9/l4e8kr3RbUwkDYtkyG9HRR/hxPO0eI98MnLzHMJBl2NUfAABvW98ZIcRb6yOmVFvMgEn14CrmGSVZmjnFKb68JYjAIZOZOxjOwmsYBnbH+0KtGDd0vh9FW+D+kkIZMQjzIJS/f0b2tqEKsfZMpRfNwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dNfBZ/YD; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyNxixRpg7PNOOVgFM3QpxFnrdQTtWWvTTdiJZAcbThadrA9z5IuHYLSwItt6Babu2Nczzi8W9T76yGR8CRFVhOx3Est51jzwWMCfM4ILIixmWtlV174u1YIJLcrAtNjKyK/IeMSZUDEIcqZOidIZIOJspLv8RQbCn1NuLjeGbTkMAgHFP+zlkaNnfjt9eS1jjtoz0PAZcfWgROsej3gBsTdBXRyzIJUpaUGWnnGxsNmGXJlREnSuWZUNkyJmLqXC2gHMAQi/44MzMVp1WlQCGn+gXAd8nWMmZ52Hqj2rQ5ktXW+c7llEXsNkcrwTv/ejJkwiZS40xachvK2JBTeSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+Lb4/3O+IXPZu+wDBOsL+rM3NXvK9d3mjDkG9iH5Is=;
 b=vgxi7RMatHFD+EZXiJyw9Cdn3mxpTqt+0AIFuGYRXDTFJ60+ZaVmurF/rNwhrh8sLWFQ9drP38/xYi8kBzP6KXJRxMcG0OOQCBfQMJ+LkNU4ITW5bGvf0wJ8WoqXMDpIEXpve3u3PsrsGBKtQzF3vR78DvxYfEyW5aPZusVlIPk9dj7uYDOPra93BdUklLAOTxXnKCsYfKWXcWlLxy8dqUYpwA48qLEvnnxLhZYxTZ1mAr+fc01q3hPm5QLR/g8vjxN6nKTOsy0XGUUaAOAvZjR5s+I0C3B9QKoe5clzogJ2E8jxqamXKrP9m62Q25y21d+j28RoFIx8HNXFp/5UNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+Lb4/3O+IXPZu+wDBOsL+rM3NXvK9d3mjDkG9iH5Is=;
 b=dNfBZ/YDK3cglxLrFM+xO1Dl60ywfU4/ot0olijsSOVtrKc42whaoQaa3c1Yf/rjVka0V6NSPOsNRwauRMHJQWj5KZqBtOj+XvLskbcH7dFcsAUpqK7hcys/Io6TTzzaOv/toxMkllXtrDYym+e52T5jAVejyexi0CctoAwI+PygArYliDz1gnOhiEQdOErSvXrXzPLl7gguiUZz/eFTp0O32zsM0cv4h6Ff74m/JXqbbDAwFS6d+ZjYbwMBaLw2j3wRKsdBr5wGgGP7pT/kA7zDvO/x8DFMoBEs5XKfC1/qqiZsFnv5sKGjDD88L1BCYeIHycJwHr6yM2iqsT1pHA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 18:52:03 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 18:52:03 +0000
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
 AQHcE0XKqVbu8cWtaUCLZj1LjgeTGbRudpsAgAAWuWCAABaPAIAADA7wgAADewCAAmIWsIAAy/cAgANp/uA=
Date: Tue, 26 Aug 2025 18:52:03 +0000
Message-ID:
 <CY8PR12MB71956B4FDE7C4A2DA4304D0CDC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250822091706.21170-1-parav@nvidia.com>
 <20250822060839-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195292684E62FD44B3ADFF9DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090249-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095225-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102947-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250824102947-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|PH8PR12MB7303:EE_
x-ms-office365-filtering-correlation-id: db75f510-389e-4373-e69a-08dde4d1a5c7
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vPUTnNzV03ffgnJDszEweqQzY8RWpu/IjDmREkQKG30v/dMK4wDX3Wy/T6o4?=
 =?us-ascii?Q?jJXSuh2UzhtCKPMpxkvjhe1LPSllvFNfpFH31Jlm1K7C80naQNeMCaW6zed+?=
 =?us-ascii?Q?CQVSIwjJGL17jgO3swTYykqsO7NSLN7rGxjpOvk/PKjCm9+FaFRxn7oXgUY9?=
 =?us-ascii?Q?EoUeU2YtLYgRuUusFTSJF5RJu5q1w77j7OqibRT5fZDR3QuqrD+9uv31vHA9?=
 =?us-ascii?Q?GdJ7MUoMuGLR9kUoupD/DmPWnZs7Goa/K8DIWA++MIA2Qpci3fMYJ0/tkUZt?=
 =?us-ascii?Q?lOAIHRvfccdJ3C66BQkZuPYkfxlzYWdPaTh6hrgdR1LB22liJnp1GsaI+XVC?=
 =?us-ascii?Q?Be8y5FKi3pgUd7z6tTo4HaXcEdSBkv/LIYsJJU3EixgZuOny8vvcbP1+DqRm?=
 =?us-ascii?Q?NaX1Swu6R+WU+gdGX5JV8Rw9oXt+gqNeQfMJ5pluHDJ8uLmTTdMTmg5qcJj6?=
 =?us-ascii?Q?r3aorQU9phpT5NeVkavyzkNOGeJEKqOoCHPekC91cNkg2KkfignLkY6N8M0Q?=
 =?us-ascii?Q?Y6UR9YZ9x0/qrSu7Lzo1TgoIV+xMqYA6TX5M0ntdcB4NxAsQOz/Vr8AYeQT0?=
 =?us-ascii?Q?9UrGV4tuPUhMwMDCzI1FdnRZdC+NlfpdwJrFpvJLuGlYW+WSIziOaXkzZl0/?=
 =?us-ascii?Q?mni8HLuitOnIOpEPLaXHugqcBvq8ewMzwUQXLHv/s0SbnJZPCVmXlchOfx5k?=
 =?us-ascii?Q?zfv2sKbBsgA7tDw+ibKttTHDs3c6VdqYs7jY1ZGLgvGy/C7xuh1A18YFk0PC?=
 =?us-ascii?Q?+Jh5+Ey17UpnoArH+V1OO7+glVZ0BGR5USEjoAYfwkobv1of7GUMZLUxFLF/?=
 =?us-ascii?Q?LWU3logOdF7LEh/O9qhRXKp6KiHecGTM2/nUOuK80w7egPsXmr8ojH6PfK9t?=
 =?us-ascii?Q?XDF2ER0F3bnLGpjTcXVQjskeIyI3GbuhF0G8pZTqNTnwwLxze43DK2JmxUWJ?=
 =?us-ascii?Q?Pua7LAgakoBE3IOmfE5NQasCX9ibum053MXoh1O7Ykv7fh05qU89NiOKjPDw?=
 =?us-ascii?Q?woIpGgZwMMbZt4JUl3OhszG1bQN5xEyNMb6ZeVaTq/Vc/fe7Xthw8czqtORq?=
 =?us-ascii?Q?vPCPTu0AZ2xEXZrCNXtjYxIuHolk1c/Lzgzd0lERtQKjO8JXhHOJLoJUYSJv?=
 =?us-ascii?Q?ySrujkyTxgsq4qzlXEZ3Cr3AJZGqt9yvTU0oW14SRMD0y+Ta/c2rEWT9LqP/?=
 =?us-ascii?Q?MPP1cRu1YQL9FycvvLognyZ8RjteNRyNUSlO4mBSxHxw4+8R3IsY43/MHeUQ?=
 =?us-ascii?Q?7RqQMIWge1bV8Tq+GbJhtUNjcFEfC/XKCSVD986PR8dNRDslSiBfeQsJFBbQ?=
 =?us-ascii?Q?LEPCpPKsfyNPEUuFdDwvg8JxC8RCd2LaxsxOVjuz5YjrO0NhzqzHfFES/ask?=
 =?us-ascii?Q?zUmsUhkbBfTmiVmAJ/ICrAN8rCwz25IoaEYMKnt7p6PCbmY3kgwPkC/DDGYA?=
 =?us-ascii?Q?Ut2fgnSkruuFIGAB/LEcwEMNyE+lm6+/N/QXGyKjS/A1qnyKYz3pcQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ivuTJZ/U0mJ9x6982tUfVLHWudr0jYDiBx5oo2qkIAP+WZ7s3bVT6HMO2V7H?=
 =?us-ascii?Q?WWyxlcXkgbG/RiU0cBR1A7NBN2I1Qlo4cOrN5Gms7cBTdmqREFo15okJc23z?=
 =?us-ascii?Q?P+hMPHGn6sOYBcdT60BoErwudt+lTB2g/TWJJqqFzhsGFMlpFt70uHgfSdr9?=
 =?us-ascii?Q?5lboHRkA2Zsy4VkeZKePqxnAMfA+I16Zcz+JGlHkMD25fzqv2le/I/FAaDzY?=
 =?us-ascii?Q?YRir+DCaIuCvO1xygvRb1nLRobT5Jmu1zXDNCCCZ1GGjglfZwubYfAdOBAGv?=
 =?us-ascii?Q?fad189ZLCla0nz2Hyk0d9zGBNly1UR/QcSWJ+IGlIPZaVLPJ084pBctG9OPs?=
 =?us-ascii?Q?kuZC81tMuoP2hyxR46a527hJLJp83CxnqskY+PkQs1soIZdg5expp+asN4cI?=
 =?us-ascii?Q?2wxQeur6iAd/pJeWJ8jtx3EEAodkb8CpjhS3C3vGenTuWp0aGTEtnTLLDJ49?=
 =?us-ascii?Q?smr3aEB0HXrnz720cCpfsUQzhHVb+GNBGb4CRqPfMaRClWtPNKmIPDMVXsd+?=
 =?us-ascii?Q?4EYJzfSFaiHwRGXyw48QzBRCTOJESEOvhIkdi1Y8826ZwGrXNzey5n84xoP7?=
 =?us-ascii?Q?c5neporJAS5ySf/E6axSQ94iykzEgdPg9B65pPp7TcfZoBW59qVjQtU0bUJZ?=
 =?us-ascii?Q?2sMbBYPYYvsimolFPCvPN72w1f1eaYiCRbQeOsBcf2hfPZQ2NinENuH8uKUI?=
 =?us-ascii?Q?ISwrr2fLcLJyflxePDtUCHA/q7aXf73vNVBy1N2yYFlHlRnmSmqfD3tMevaV?=
 =?us-ascii?Q?Iu6TKGutdxoBHn0RHOXvRVpzjYS/H/SFQ66ubbZ/n8C8Yi+eEdnN5P4xsEmA?=
 =?us-ascii?Q?MGpbjMpiQbKW5O5Si52xdKOQ690hHXS7DjMlxfHxpEwwJ4uTKPUfvW/5Y8Au?=
 =?us-ascii?Q?BIKjM8rNv3XADqbJ8FAek/eKK2T0P1k2d/uNLN2q4B2AW64OSPDAgZByBYxN?=
 =?us-ascii?Q?iLIp8aTo7pgOW2EAZNixcz7dlExBJf/CJCLRO/jLrKBTQwQTN3Qh0epF1Y06?=
 =?us-ascii?Q?x1KhwKgJO9djRMrJ60sPtBAInckfWVctv4q+KIhFSSrt3Ls4HkM9ghT4k3Mg?=
 =?us-ascii?Q?cQy8P9W1b6GzT/K8qe5gUdL1f2vTqyeG68D0OF/3KQoOxGVtqdf5BuwzieyL?=
 =?us-ascii?Q?W3KsDcoadZPU0e0t85em9CEIp0Uc91Bm9cEXgRsnycdSdc7clHEn0o3BMYyZ?=
 =?us-ascii?Q?Qdd+3AzbiwAjg3IshhkYx917qrZ/anDObQ2ZfUaO+ZKVFt7Qj4ez7fm2E5ta?=
 =?us-ascii?Q?jMjnuvOzbvSnnsANL2VNU9No6/djeNismhDA1Wv0Tk6X2Jge6TONSUieT2FP?=
 =?us-ascii?Q?gkTeoXZryNMR824GEgStGcV5vtsR1r5LI3TVLcR5qPkpitsa3PC4Crs4y33R?=
 =?us-ascii?Q?5L0MYdxfboLkzeBxDIHVPJGOqVPGejrcaTzcjosFGoyqaO3m0iokiMTDH1dg?=
 =?us-ascii?Q?jcw6tgcqT1uVuBvLibkqYKeQeHzacvK3ECH229cSO9Qvyz4pPPGaSKI6XdQf?=
 =?us-ascii?Q?/UU+s6t4RCEjrdo40LWiXefP955XYjg3ZPa5DBei+Bjg8CrqGoq0pHhr+K3v?=
 =?us-ascii?Q?iQ6pVUDQcygGoByblds=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db75f510-389e-4373-e69a-08dde4d1a5c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 18:52:03.6364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3cDMcV9myrCuQc+od+x8uCcw10aIRTgf6EEVty1y0V+f3lzu15vw1kJtK9GnNbY36MqCd2TOWAelOo8V6uLgnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 24 August 2025 08:03 PM
> To: Parav Pandit <parav@nvidia.com>
> Cc: virtualization@lists.linux.dev; jasowang@redhat.com;
> stefanha@redhat.com; pbonzini@redhat.com; xuanzhuo@linux.alibaba.com;
> stable@vger.kernel.org; Max Gurtovoy <mgurtovoy@nvidia.com>; NBU-
> Contact-Li Rongqing (EXTERNAL) <lirongqing@baidu.com>
> Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virt=
io pci
> device"
>=20
> On Sun, Aug 24, 2025 at 02:36:23AM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: 22 August 2025 07:30 PM
> > >
> > > On Fri, Aug 22, 2025 at 01:49:36PM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: 22 August 2025 06:34 PM
> > > > >
> > > > > On Fri, Aug 22, 2025 at 12:22:50PM +0000, Parav Pandit wrote:
> > > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > > Sent: 22 August 2025 03:52 PM
> > > > > > >
> > > > > > > On Fri, Aug 22, 2025 at 12:17:06PM +0300, Parav Pandit wrote:
> > > > > > > > This reverts commit 43bb40c5b926 ("virtio_pci: Support
> > > > > > > > surprise removal of
> > > > > > > virtio pci device").
> > > > > > > >
> > > > > > > > Virtio drivers and PCI devices have never fully supported
> > > > > > > > true surprise (aka hot unplug) removal. Drivers
> > > > > > > > historically continued processing and waiting for pending
> > > > > > > > I/O and even continued synchronous device reset during surp=
rise
> removal.
> > > > > > > > Devices have also continued completing I/Os, doing DMA and
> > > > > > > > allowing device reset after surprise removal to support suc=
h
> drivers.
> > > > > > > >
> > > > > > > > Supporting it correctly would require a new device
> > > > > > > > capability
> > > > > > >
> > > > > > > If a device is removed, it is removed.
> > > > > > This is how it was implemented and none of the virtio drivers
> supported it.
> > > > > > So vendors had stepped away from such device implementation.
> > > > > > (not just us).
> > > > >
> > > > >
> > > > > If the slot does not have a mechanical interlock, I can pull the
> > > > > device out. It's not up to a device implementation.
> > > >
> > > > Sure yes, stack is not there yet to support it.
> > > > Each of the virtio device drivers are not there yet.
> > > > Lets build that infra, let device indicate it and it will be
> > > > smooth ride for driver
> > > and device.
> > >
> > > There is simply no way for the device to "support" for surprise
> > > removal, or lack such support thereof.
> > > The support is up to the slot, not the device.  Any pci compliant
> > > device can be placed in a slot that allows surprise removal and that
> > > is all. The user can then remove the device.
> > > Software can then either recover gracefully - it should - or hang or
> > > crash - it does sometimes, now. The patch you are trying to revert
> > > is an attempt to move some use-cases from the 1st to the 2nd category=
.
> > >
> > It is the driver (and not the device) who needs to tell the device that=
 it will
> do sane cleanup and not wait infinitely.
>=20
> You can invent a way for driver to tell the device that it is not broken.=
 But even
> if the driver does not do it, nothing at all prevents users from removing=
 the
> device.
Sure. Vendors will implement the device accordingly based on the driver's c=
onfig.
If driver tells that it is ready for surprise removal, the device will impl=
ement functionality accordingly.
And user can do anything it wants.
But user will have indication and knowledge from the device, when not to br=
eak the system.

>=20
>=20
> > > But what is going on now, as far as I could tell, is that someone
> > > developed a surprise removal emulation that does not actually remove
> > > the device, and is using that for testing the code in linux that supp=
orts
> surprise removal.
> > Nop. Your analysis is incorrect.
> > And I explained you that already.
> > The device implementation supports correct implementation where device
> stops all the dma and also does not support register access.
> > And no single virtio driver supported that.
> >
> > On a surprised removed device, driver expects I/Os to complete and this=
 is
> beyond a 'bug fix' watermark.
> >
> > > That
> > > weird emulation seems to lead to all kind of weird issues. You
> > > answer is to remove the existing code and tell your testing team "we
> > > do not support surprise removal".
> > >
> > He he, it is no the device, it is the driver that does not support surp=
rise
> removal as you can see in your proposed patches and other sw changes.
>=20
> Then fix the driver. Or don't, for that matter, if you lack the time.
>=20
I explained, it is not a fix. It is a completely new implementation of the =
infrastructure that spans, virtio, pci or core subsystem and each individua=
l device types.

> > > But just go ahead and tell this to them straight away. You do not
> > > need this patch for this.
> > >
> > It is needed until infrastructure in multiple subsystem is built.
>=20
> What I do not understand, is what good does the revert do. Sorry.
>=20
Let me explain.
It prevents the issue of vblk requests being stuck due to broken VQ.
It prevents the vnet driver start_xmit() to be not stuck on skb completions=
.
And virtio stack works exactly the way it was working before the commit.

> > >
> > > Or better still, let's fix the issues please.
> > >
> > The implementation is more than a fix category for stable kernels.
> > Hence, what is asked is to do proper implementation for future kernels =
and
> until that point restore the bad use experience.
>=20
>=20
>=20
> I am not at all interested in discussing ease of backporting fixes before=
 they
> are developed.
Your attribution of "fixing a problem" for the missing new implementation t=
hat span across multiple different subsystem (virtio generic, block net) is=
 not accurate.
I understand that such confusion arises from your previous email regarding =
physical removal of the device...
Hope I explained that its virtual system where user has not removed the car=
d physically.
Driver is expecting requests to complete and attempting device reset too...

> Not how we do kernel development, sorry.
>=20
The ask is to revert a patch that broke the virtio stack.
No one is asking to backport new implementation and new spec to old kernels=
.



