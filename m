Return-Path: <stable+bounces-132820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08362A8AE55
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 05:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D24C3B14E9
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 03:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE40199939;
	Wed, 16 Apr 2025 03:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g+z5LBNG"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B137B8F66
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 03:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744772516; cv=fail; b=fU5mVCplo6v/+aoF+nUsUYPhqTp1tmowW2WK7NNlM5pIWtb3e/xBrWOKpmEamfh5IQ/8yJFd70tmbS0gkS5uZNxHUm5AUYDCTO/Y6SJ1BK4mMDxetMDnXX2T2CKPWB2zCKn8y+/RVVAt4Z5z93zowmFJ+7DjT6sG4a/5TVrt0ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744772516; c=relaxed/simple;
	bh=b+1/zna7si8JizG3JSz0k4rjYSzKmIiTWbLOHKBFr6s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MSrbaGD+PKjYwQvF/mYfKJarrRp44heInMe+uJBzp8HW4P7KmXq4rQ//uki7SRlq61k2LrIQjWP+cK8zlD4vkcb7UeGG+nBE7nM6zN5qK2eu/Y46GRuPWQXGb5I7W3NMu9qtNPVRJzztyu6UFr0zhrFLoj2mFVvvPUh2PFYvsuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g+z5LBNG; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cj1ccIYAe/cZyg7lLcHINb12OQRdxmgP2XqclQbwfkWABsxtrL2hXu1xsvt1yCorqhnuIRsvzPX3AMby1OASfFNWV82KsQxnnq1qqsujx7onywEMstbNz6LrT6nJdzybW8hp+UHDjv+ebXMV3mJSgZNpUxCmViJx/Tlf2MHT4piiWRhbV7R5wbN8tVrC6WZkaaLoZo2HwgbmetlEnviw/dOhFfFxj99m06tG3dk4pNhVxi91XxQFt1U25s3IlScsTtkJJAPDZu56V6NoSwvMtniXfys6Okmiqde7/cewC5ong/5lmzHUN9qHxNXfo1C44iJXz1gtshVtd69CKS/9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+1/zna7si8JizG3JSz0k4rjYSzKmIiTWbLOHKBFr6s=;
 b=lY99L1Yqe66m/CxjRtJqXcaQSvqdOXx3Us1Sosj5t2bWxAsaD1DV/IPDY8SKnJs2qb/UCfC+GWag8lCgIdyWI7wSQ2b42zmAn1x8mBFBfPhoDSwFm7m9dbCWrPN1w9xPOK1RpZZ+sDbUaRxzAHjK8W9MUpX/GX/cLC6k6WAAXaydw69kDyJt0Z+4CtYs0F6LrSc5bvv1imY8UQoovTNxYtcdnSyS+TC2VOq2Toih+2TgY0BWBTGgur0DKgzJ3/S4UGTisHF3Rj2lmakApxtZbpH19qaNBjDJBfsNPPRNJOKHL+umEVLsQLwoqw4kprGlEZbBvr7lap2GwucIv0fAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+1/zna7si8JizG3JSz0k4rjYSzKmIiTWbLOHKBFr6s=;
 b=g+z5LBNGtEQUIKS1czHxNZsY4EOjtyZMVGcRYB+V2LlB15Ny1hSRuWHxbX2WQUIsH3B+Retg3Qv7FudBPKL7nfQdOkzgZRQ1O83CEVG/4F8IzOr0QGraxzVtcl2ZSzviXa/6YLnh/pQ4YWGxIezmk6T409j6vtuucg4wkcjs3Qusbqb/n7UshU0niIRdle7k8hBzEYOwOg16ZuOnh1KJPVE/qeeLynvt+eBV/NwFO3tuBYYtVyjyURWm54YCustaZOj1+msbyvD60BeYeoJ08Q9oH12h4XCAo2Qn9+d0pC0yQRg1l+0Bg/tY1Atkd+kjWLfbVlDOCjbBX3tIUMlPIQ==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 03:01:51 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 03:01:51 +0000
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
Thread-Index: AQHbqJbdRx65Kra/ZUa37p1wvZrOxLOaNMGAgAEkOTCAACdhAIAKJehA
Date: Wed, 16 Apr 2025 03:01:51 +0000
Message-ID:
 <CY8PR12MB719506CC5613EB100BC6C638DCBD2@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250408145908.51811-1-parav@nvidia.com>
 <20250408155057-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71957D9729A72B8BD76513C0DCB42@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250409115557-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250409115557-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|IA1PR12MB6385:EE_
x-ms-office365-filtering-correlation-id: 0b292227-2ad9-4322-cff3-08dd7c93092d
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/0XyJpOC+RNX5XkvWbc4sJ8MVTIRCUFFWY8bytjTUPDX4B/mTEbpOP+38qm/?=
 =?us-ascii?Q?Rb31fY//GoCCjLEokimhlR2TgX+VDyipsAnSttoWZc8sKDi1ec6FCYJwjszZ?=
 =?us-ascii?Q?g2YIDut2nUkYV99Ohz88WWLVePlahu6CWfkA2tWmPphlhBmcU/W4yrPkx9fn?=
 =?us-ascii?Q?b3YIJVadw4nSsiA0wVJ3Nb98p2r4O5jTELfICGYep4iMKxYEA07xLGBDFgjp?=
 =?us-ascii?Q?Yth2hC60i8ZhquWmn8ORNsqu+yhcAB5VimDFJcg1R2XOxj/9iW8tCQKQxnU9?=
 =?us-ascii?Q?YzH1YPBom4F6JMiBxHQCO+lbYm6sYdix7ZG5PiImCUdWiJcQTzpWpn78BR22?=
 =?us-ascii?Q?VQOLRy8hRNob9PB+Qo7TZyXhgWb47rKQqX7WX8Wtp67cuwt2yDi2m0KSDgZy?=
 =?us-ascii?Q?W/vuB/kZdHTFJU8Za65NbbkbAtr9cOMcjDETUbYFUmKD03O4ZvnVm8lcIfX8?=
 =?us-ascii?Q?yGcQfBcHmBtkbkEY8x4MOOWkWLh1Whyxqm2V0az6y80iejbaBe5jkjfX9dSK?=
 =?us-ascii?Q?K2pgkJS9jjEZXReFAqgfB45Il2ddAX0BYERIaCtzm9qSgNVg0nt3JrCEX0jo?=
 =?us-ascii?Q?h/sU5O5evVihZrJHHTM7B7C9c+dR4BN+QpNglwTSZrubk1YCaQ6p1hgyOSyJ?=
 =?us-ascii?Q?eNNKpZZ++bvu1bS+Jhmo18eB9ggF0Rh4LThz0mWGafKLlbgFAoXNpo4x8u8C?=
 =?us-ascii?Q?+RKf1Gnnhuy2YFAhl1NPg1QdVbtVHUHnGWBmE1dL5mvwInhK/cY70cpT78h5?=
 =?us-ascii?Q?v7CBk7eZlJGfoIjCgqjLd3aRygw3V7A923VVgvZcFcqJEHXr3icQFcXv++6b?=
 =?us-ascii?Q?lL6pO+ORb4OUvNqLLxjpLmYcNqd0R+xEDGmYVaHk/9gM4vjL/OghxEZtNGEj?=
 =?us-ascii?Q?Ctlt4gDmyUvSFYBfxZA73cu75PHD6HN5QmTuwDfn/cxDppp4sbhpESmLm3EX?=
 =?us-ascii?Q?4C1M2vNouunARp/8BJc8xM1+X7PxknoOdrt+KZPTgDQE7MjluK9oaUpQzACT?=
 =?us-ascii?Q?k00ayYiLbdvapxhSObIGFzL5K7XNn5NlxN4H5LNxSgULwdywlV+jPNdnw9Js?=
 =?us-ascii?Q?0cUs9kwWIlToM/CU5BF/FnCS6gKbXCYbQo/O09FzR907OTThZ4vAmVbR7um8?=
 =?us-ascii?Q?J4qb60PME3joFfgv7bfVvRxx5XLlMFCTtCCfYwFz8iJm+FfMbMU/Ay/lcAlg?=
 =?us-ascii?Q?HcoqxRpUjtd0fHrhNefJfnZHstBHBnwRI9m86QnV2W5eztJqGyhi1E67j+C1?=
 =?us-ascii?Q?9rw04dnqDSmxT0e3HObGg8TRvwC1BSjn4sn7agXPpddXmUDh5Z70zCRbJb+U?=
 =?us-ascii?Q?fgNztGzcFyNo0NoWV+NGGQdIgR7UoKd1nY5MJy9KzKTHgWwlnGR72cPCQzyr?=
 =?us-ascii?Q?l5wPSJpZr8w5SQDO/XjxfE4BXymG3FvfgJmoQXlxZswmsownTSGUm+dVNuhT?=
 =?us-ascii?Q?Je5w9QqpwOpkvpHFjsdC79WO4qUQkc0kqWt3wKOy6hRiglq3nk9vFYvHF5NG?=
 =?us-ascii?Q?JbjKJQwkNhRZAh8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v5E5YTWAW55YxA8Gi1od7HyFXFKL1X8N/B/Rh/28d5nnPeLiRORWhL46CZkh?=
 =?us-ascii?Q?+k227LaOCF3DgfnrXhAnyj78Tx78q78Jrs7J3gJtKj9C6b6WSXO9TmXmANFp?=
 =?us-ascii?Q?1scAj72xMkuNVMOPSEv/lzc0GFXDh0gsi4lGcWIC1kc1/pnh3l8p8NZieM4i?=
 =?us-ascii?Q?Aq/Ft7PWAwWXbL7SwHowv/1jBwzmeg1BgSvfikNBXNgyCqNDqlkTBAu8xkDu?=
 =?us-ascii?Q?jDPlwkbRfwRvGkUz/1XOQGJYVUYnHpx9hEleengLs4iHzk3rk7Cojg54oudh?=
 =?us-ascii?Q?6eYZjmc5CjpOC9BaDV+uqeYM6sGMlh+l1GaCjERAiVR6PMFd3DA6SoIDMvMU?=
 =?us-ascii?Q?zjVuo7kRFuQ+kn/XIGnnZTRgsLVZtw4Q3gn9so6kxxMt2wjzVBk8Oz0jKRvO?=
 =?us-ascii?Q?58ivSAWslhYgd3Tqn0bxgxJS1mVcQ1cKT1AmYKIcOPXtJVOnNGFITGwi+oIF?=
 =?us-ascii?Q?mG3rW9adxQenhLa0YLSRUwxLFhff6VSlUHxtu1OsrY0TeWxtnsLmGG4jJqE8?=
 =?us-ascii?Q?hSj6FXpIDU0eNytM2i2fcKPyiE58zsgs1yPToibXR/KNQGYTvsGm1dyqWcA7?=
 =?us-ascii?Q?DKng7hts231ktVYj+5OEo9w2gzGeqQUJmrn70DxEwqC98DO/BDqAOmoPusfJ?=
 =?us-ascii?Q?ujnpGdiH6UiS6/6oQgNGv/SkfmOXZloBAhP8eCHQjt5u3sJ4rMzLHTew0X+C?=
 =?us-ascii?Q?YdF5MMZ1+qdpg6sTsBU3McZQq9Bxik/nxq2f0WRXT/7dNT4kCu04GgcSm8DS?=
 =?us-ascii?Q?0msOzcGsECINFxSyTAx2UYb8xG6PDBWNvHoylZU5lRcoDQ961T21G+Tep7i5?=
 =?us-ascii?Q?2tCcvycgbfK8bv/nEnTgAwXlY93L78y2k8JHIddf6CF4CifsSCkQuW6tGpAW?=
 =?us-ascii?Q?sBP56EFUHkBztFaJoAeax/SD95DfOqb9Ge88I19Ayri3HmIR4/WdQ6c+X0Ff?=
 =?us-ascii?Q?ZCLrLZD0v4BaUH33g83W0tAzGRxB37Yx2DSPMl62cpz1jmFvlcBkNsgWHHAs?=
 =?us-ascii?Q?4zjH79ZyxERlmfobKz/JZ/46FgpDW5yHa8X1Vk8WDt9vtjIpxe4JRvNcfOu1?=
 =?us-ascii?Q?tUWkJX5mfB/5a/mvz8m6ZrG7fj94D6qdnSSzIP/ys9O4Q1tHE44FQZQU8UC1?=
 =?us-ascii?Q?HEg+I0Tjq0+HsR4wvtDCXGOHj0KzfpboyXi4guVy4ievkfZCu2QzCXBKJNzV?=
 =?us-ascii?Q?/o81Z37wdEcECl7BVt2SNU0ft5tZCd7llSWuT0XSj/ivvgDhNr+MqtfqSEKk?=
 =?us-ascii?Q?K9VTqB/9s3j9Vo7KAR/Qal4bLEklJOOJJUHHrmkXnmLHLVqfRMgEpbUviPcv?=
 =?us-ascii?Q?c053SSXIXBjSskb73GH6w6X1Dl2l4yul8HmjKoRPJrvy4okDOY3A94TyARll?=
 =?us-ascii?Q?UOjW29BkEwHLArzm0BmeDCUot+sq962wKZrOgnEB0TWsELUfHShe1b78+D8H?=
 =?us-ascii?Q?gpEdNLq5WeWlCHHuoWs1nw/m/YLPTCUBsLfflB0itfDxWaFMWHa2vBhG18QB?=
 =?us-ascii?Q?+1thFZRQ8t1l967M9Qp8D7hUr8jnr6rW+5AJD6nij5FbTjy225jzAx78ShOS?=
 =?us-ascii?Q?1DdNENOwwwJSoRpButI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b292227-2ad9-4322-cff3-08dd7c93092d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 03:01:51.2328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kZig5P7XXLHERvzEllHF5+mv7iO7fNuH5FD1D20w2Rrz0osPtVZycZrfL3XPlLwXmQe8GjVREg+jQHyNKr3Zsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 9, 2025 9:32 PM
>=20
> On Wed, Apr 09, 2025 at 01:50:18PM +0000, Parav Pandit wrote:
> > Hi Michael,
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, April 9, 2025 1:45 AM
> > >
> > > On Tue, Apr 08, 2025 at 05:59:08PM +0300, Parav Pandit wrote:
> > > > This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise
> > > > removal of
> > > virtio pci device").
> > > >
> > > > The cited commit introduced a fix that marks the device as broken
> > > > during surprise removal. However, this approach causes uncompleted
> > > > I/O requests on virtio-blk device. The presence of uncompleted I/O
> > > > requests prevents the successful removal of virtio-blk devices.
> > > >
> > > > This fix allows devices that simulate a surprise removal but
> > > > actually remove gracefully to continue working as before.
> > > >
> > > > For surprise removals, a better solution will be preferred in the f=
uture.
> > >
> > > Sorry I'm not breaking one thing to fix another.
> > > Device is gone so no new requests will be completed. Why not
> > > complete all unfinished requests, for example?
> > >
> > > Come up with a proper fix pls.
> > >
> > I would also like to have a proper fix that can be backportable.
> > However, an attempt [1] had race.
> > To overcome the race, a different approach also tried, however the bloc=
k
> layer was stuck even if all requests in virtio-blk driver layer was compl=
eted like
> you suggested.
> >
> > It appeared that supporting uncompleted requests won't be so
> straightforward to backport.
> >
> > Hence, the request is to revert and restore the previous behavior.
> > This at least improves the case where the OS thinks that surprise remov=
al
> occurred, but the device eventually completes the IO.
> > And hence, virtio block driver successfully unloads.
> > And virtio-net also does not experience the mentioned crash.
> >
> > [1]
> > https://lore.kernel.org/all/20240217180848.241068-1-parav@nvidia.com/
>=20
> Parav this is a commit from 2021. I am not reverting it "because it seems=
 to
> help". We'll never make progress like this.
> You will have to debug and fix it properly. Sorry.
>=20
> Once we have a fix, we will worry about backports and stuff, this is how =
we do
> kernel development here.

Ok. I will post the candidate patch. Will likely need help to fix it. Will =
ask Stefano.
Thanks.

