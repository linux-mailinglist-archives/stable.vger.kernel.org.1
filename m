Return-Path: <stable+bounces-172683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1F0B32CF7
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 04:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED341B2202A
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 02:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AFA1C8616;
	Sun, 24 Aug 2025 02:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YTpF2aJO"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC80393DD5
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 02:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756002977; cv=fail; b=PLpt1Mf9tMq7ACe9Gn0/0YN2+2TN+nYlj5xS7EC66Cz5jCsWCZpCzfp/L5oB2h11mBTaSVeIjbN9+DByM2bBJkdV9+zS/xz5OB6+yRixO89eGdK4tGE9797sjZ208z8NfC3wEuGvap4gpqFoAEkBrY+thM0db3btFQkPw8crvaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756002977; c=relaxed/simple;
	bh=AnMdrd9+CR8TqLrB3RCADxHTbODtkD0/YMrBAJygTNc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fkxEJbFkvgSUbvSLSBPSGpuupORIxz7BsiTlq54IFSAMyfK6oX7b0+7v7DC79hWj+LPqCYb6EAkBzqzkFKpLuvtjBnLtLoQGlNHahqsNXaJN3DoEvcJ1rceRYRONmXSR6hPPLE1fGBZVYE6T3L/4V2ENeivPQStW4DhxoYO9eC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YTpF2aJO; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPnS7Rdvpc0nYMyWZs2/+wxZzlPUn8nf9KaSxR+hpibW4SAZQVCtaLAc9Qnp4y6wt0TeX5qtgypjVMD2+y4OtKpZYfRgzdTJ7+oc0nqkT6pJyeM2Bn7wt8HHlaL31n1x4e36T1uRD4ZU7f8pRZnMhoiUllVFVbKtKXxeWDC8T/zJi3Mv+SrZ74MSOUK+PJ3Re2HiF0oPOS1gJMKALAqfCYD38GAezjmZrmhk4yfKyzSs0KNHiToaKIvHqS4wQnS8wo4LrPxWuAFS/1VpG+cHaWcOiOk5o5ibpAdCXhTcdgqOELcNHsV5myHXD69URtH6aJQ2l4R4sABr3e+/Gbm+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnMdrd9+CR8TqLrB3RCADxHTbODtkD0/YMrBAJygTNc=;
 b=h0VO1FbEXluJqzS0Cf8KxM5+VQsRsMMHb41KuaSuQhzgcxYUydI2RYUL4I2SkMGW1bBg2/WdcHujoM3TTTqgQvQupgE8/8oW1kH7G2l2ubbkX/q4fdreimBMvm4mR9Fi783/gJtXvSJ/UrEFfVzqbU2OTFUkh4Dq4GnzhPUiP+/eQSuJ0mOaLRNCE4zIuoz4sn6iJoUxkrg9oD8Mt1VTMwBIUs7X0OfK/LmEyvk/Hdy2qL9+ryfKgaKRmdfv9oShRq4OEmId/xrw7Df586dPVqR6hHnFZcFDqKxkLADHYdUhIwJVOyMcLLoynugnQAiZIE3PfhoIbd5OJmvnwibF4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnMdrd9+CR8TqLrB3RCADxHTbODtkD0/YMrBAJygTNc=;
 b=YTpF2aJOjYyeOtpzP/q83s7GKSgTji3zCXIJqz/gco2/WvrxRu+V0qbwopU4Q+Z0oYLvGo/Q/RzqU1J5l4TAnbEk6QziqDBdSrQ2EdpsfXp0n+q0d34TIKvjzfc7Y7lv9jh076jm01B+M9HtpXUP7vPXmE1sGr+vDHp1Dj7jS6GxSXhJGhYMHsiLYSCeYSqNeWYv5759B1KzhiY5wM6BFACL0dtcNgHkKFw4XYcr31wZbY8Gf/8I6q9v6crzn/NgSag4IIkFnlXjKn+MOtLldxXxWtjNVCaGSwDjHmx66mZP0RF6qSaOajxdcNf1pbEDXhSf7F25b4W0swfWl5tqrg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 02:36:11 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9052.019; Sun, 24 Aug 2025
 02:36:11 +0000
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
Thread-Index: AdwTTxd+YdVEFNqzQBWcarw+isQ7dgAEGgsAAAF2L4AAAZBEYAAAb+MAAEx3t3A=
Date: Sun, 24 Aug 2025 02:36:11 +0000
Message-ID:
 <CY8PR12MB71954425100362FBA7E29F15DC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <0cfe1ccf662346a2a6bc082b91ce9704@baidu.com>
 <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090407-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095948-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250822095948-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DS0PR12MB7607:EE_
x-ms-office365-filtering-correlation-id: 24143b11-0554-408e-d32d-08dde2b6fd2d
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zf/olNC3UXRwGyGCThoO5oc745hcwtJ3FUYpueMOsuzA71L6tnKLANfQsm/4?=
 =?us-ascii?Q?Fp4Uw6GywZudAV5BgbW5k2o04M4QdPNRADHRCDyqelvlisdmIx+V1uWpqI7o?=
 =?us-ascii?Q?7YNvETdK6GDztiw9+cDa+42cPEq6E54RyUfX8sKQR+vkYfGXfmnYxqwmvW/I?=
 =?us-ascii?Q?YoBGklXoP7W85t3/YoWbDdzIgHWToZIouu0Hnvjilw0/9m6CoR1B4V3qpaFw?=
 =?us-ascii?Q?d2p9jmp+H7RKs+NkPq/BK26y0vixVoO1sdhP3cnYFReyP1dMh7xlLJus4yqQ?=
 =?us-ascii?Q?xqSGM0AQlTA3tAA58hGUc5pH0cCz5cyydfP5wPiXYrPNp2Y+d3bNg/Ragbvr?=
 =?us-ascii?Q?gX4RMgFJl1GqPbU8PTq1YstFb9gSj/6QEsfEh7vXzIeplKzpmbxgHz1MU/qg?=
 =?us-ascii?Q?FhSBfrG7DHcyEVb5n2XQJnO/3s8OxlEchp093i330vFu8xGKQhWEP9WWWfSl?=
 =?us-ascii?Q?aU+kAlCJsOnCytuPadMJCiFJA7hn+FhZz71a4FweSbPqIPCuph/chTVpFKq7?=
 =?us-ascii?Q?Evrvl0+DpzKlb/AP58HCjxJ9pSa8MJvTc3MwoiC+BOUUNV7qdCMeGURk1KWI?=
 =?us-ascii?Q?f4GN0upRMJ3Ibx/Zz5odNsgYkq87g9RoND3fZcqAahwVw/NLP9jvtnshUr0w?=
 =?us-ascii?Q?9+BUXL/O3RkMvxgQ2dTHZSG1qHwr/TJTKo6taBtfbBScSnY5+8xn6sBhbWi1?=
 =?us-ascii?Q?w3TGsf/2R9CuZBZJt8nxcILlpuo8qj+UkTi3sATslJOyMxxKUX9CB93kpJ1r?=
 =?us-ascii?Q?CrWx3MTROCWaKFcBfw0WcZAjrXPeQsuxiUkWJ8gCyDRztx5iKZP5F1szuiwD?=
 =?us-ascii?Q?iIkYyr07VlezKtHNtFTLqUEmLTaWDT4diJZUq1duwVvBOCFoTaG511TWBTIW?=
 =?us-ascii?Q?7bcT71UlQG6Nb4KpYiavTnL7YFPQPw8ujWYE5J9JAXgUJu//hTprdNBy+5Mc?=
 =?us-ascii?Q?Xn6D3nfGMBb+Qq5pVXg5MChJVaDDqzoa9VQjiq766Fv6C//oXPzipSLx5FPj?=
 =?us-ascii?Q?vdOq1D+4j0eWOyxZG+bAYL5sig669R9kGWTz9YErgLNiX7dI/WyCnETigg0Q?=
 =?us-ascii?Q?oaLkDZan6ryq0sABcsVybSGNY1rTuzd9np4IT6PlOg/viEwYMyxCKRQcc7Sp?=
 =?us-ascii?Q?geuMS0A3c3I+jTRNfO+RulzNzP+5MA/GXTQdOxcDq+EIKZVHl6Ei2kzeyu/I?=
 =?us-ascii?Q?7Bbv1DVCbugNAGczwdg+e3waDykif+5EwVYJPw+faTtbWqiOeolRZLEhqOgD?=
 =?us-ascii?Q?mLB5C6cYHeO/RE1CCp2uy/koDbwq/Mf31HQx5d05apKIrWbdf4eLs/UmbW2u?=
 =?us-ascii?Q?OcGMCGPJNDJKzUy/erg1cumxOze06TwsH+dfRKOK1C7qGbYoVs3BDdri2e6e?=
 =?us-ascii?Q?IsYX9JYzNW9b3wMomlqZU7+TzZj6ZpCV9L/VQ5p0ysgWG1cHqEbs9Q0eAC3R?=
 =?us-ascii?Q?fpSVO4y7MMwc5g4gl0hy/vXNF/pDl0jsUt3ldHCSR760niwZvDpq1m5vHP9t?=
 =?us-ascii?Q?UxwmaJ7FWExbcAo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GZlgMl3NRgjG1qCifeLNk/q/Nz++2cwUdt7udt9fQtxRrRsf4JWnwLYaQ6Xm?=
 =?us-ascii?Q?17AYgJ+CrX0MBa58ngPdUKTmMxMyzfnms4FvgdFgMDLZnsTe8RNx52JBWrGq?=
 =?us-ascii?Q?igR6snq1HHuLOeC9wO6/zZ0SkxR4X/gAjQccotTTUJJxX2NrBcHlMQx1686v?=
 =?us-ascii?Q?p1qrbq8fLK40GPH+oomdrzVYVBAABWwUFsALTrv2e0qGLP8pEhqQf8Ynnha2?=
 =?us-ascii?Q?flEZwrsj1KUrSlGTA2geSwbBqsbFbZZfEtVWvGdG1KpeH5tY1cPHtUuKJNmW?=
 =?us-ascii?Q?fOI+rcxaOx76WXu1FABpe6BfPxiSqJmUWO5UEBhrP/xi2eKKdw9v7oOEdtx6?=
 =?us-ascii?Q?TOEuVXpM7UnwlZpfZg+lQCJ4GoeufjqqOfvRSBFrY5eB1M5iI0FmsMS4xhpz?=
 =?us-ascii?Q?TKnkTmEYC6aEzFuYehks/WFUqPRNRLEaj8O1Zb56/WIPt/1EHNwZZGrT9plq?=
 =?us-ascii?Q?pEFPgzipeCiRYBJy/dZG0cpLdJl4Th00QfJdkkPYl6CdNeQM7/pYnKthGFKt?=
 =?us-ascii?Q?mivyplEELZ1AGTgf2VYx3H902v+V95aSKI4X2GhZ7prsbUSdFG7xzy42fKR4?=
 =?us-ascii?Q?qgSdCcbnVoCpkkOcATmBSturVqGaUMutuBKxt3mZTVPJD+VZSvmTfd5Szdbm?=
 =?us-ascii?Q?RSdPeCK25VrqIyOCZLahNIpWArkXzAYxW/GCZB4lvzg47m5NtrcR3K/oYAwd?=
 =?us-ascii?Q?eGrzcOKwUmYtiS5PTQakjWKQa5tx2dEtn5mUCSrRq2MjImAf/RErrNhtBLAR?=
 =?us-ascii?Q?dbXXJkmYChZIgqRwd2dXXsOeXLSLrhnxI534nBt+M0RbeCrlffVFQfJup8sT?=
 =?us-ascii?Q?7mbK3td1BwWP6oB0Q+PWsFPXNczLJ72fUaEpq6zrxo+k6QvXy1eAOWXEeI5U?=
 =?us-ascii?Q?E9hAMPES+BoXTQLiOb7xPaYVg0CGXDjDYiILuXa6a6dsw8mMi6lGYHN171rI?=
 =?us-ascii?Q?qDJ99PSCwjStF5ELVtVcfz6tXSyWpOmsUTL7cQwYUhSNE/ZikwAlPPcc2QZp?=
 =?us-ascii?Q?uUgCNC+ZyIiOKMb404y7aY+1CUEWD/6fSzEBvHuK4AzdT47gXap2B6yGbv06?=
 =?us-ascii?Q?R8P9IaRnFDQ0nZQ68JH6MmurX5n/1lD3/acXQ2AXuEyWPHGMIdwNVlXb4fa1?=
 =?us-ascii?Q?JO0kcuGhCd4hjh8PleDnXFd6Hk3Vz8RqlINoHHFZdXO/RLenG988O9OV2eWY?=
 =?us-ascii?Q?fvMrAvao7M89Aksq1Z8a7KUH7+BbX7J3aQmyqFrMkFTvhWZQu9LoeojIr8KM?=
 =?us-ascii?Q?MIZr+KUa6Bl5lVdoHVA0FiA4NLdfCWfv96XP+sCVw6b8JMF+BtL8AzXcSJ42?=
 =?us-ascii?Q?4OQagbzXCH3NF0s7UOj+CLg91ya7OE+39MyCRT17LK3j4SabPjAismPZ8Lip?=
 =?us-ascii?Q?BmszLpqH99sV81QpqUfVTfsZNteA/tx3RPkxakze634L47yUaTNSgZm57HjM?=
 =?us-ascii?Q?6qqlVDpucWJlXFYkcR83xiYArzMWXLXZ1yELS0JiFy7ueHY7oMlvbAFMHTPn?=
 =?us-ascii?Q?OxY0EVnB3ngtw/D0MepulckAIiCyEBDot68suX6YrBy0Qlk/nLsyjAvsThrb?=
 =?us-ascii?Q?lP3hRv2j2SmYfWvByQM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24143b11-0554-408e-d32d-08dde2b6fd2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2025 02:36:11.5528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+UEcVLeS5PTY/QBTa07RtZFOxGM5Ejhaz8iBQ+F9aKUioRYTlVR3PHaht2mphJg3aMWNt2MbX+4+bxaTLJodQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 22 August 2025 07:32 PM
>=20
> On Fri, Aug 22, 2025 at 01:53:02PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: 22 August 2025 06:35 PM
> > >
> > > On Fri, Aug 22, 2025 at 12:24:06PM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Li,Rongqing <lirongqing@baidu.com>
> > > > > Sent: 22 August 2025 03:57 PM
> > > > >
> > > > > > This reverts commit 43bb40c5b926 ("virtio_pci: Support
> > > > > > surprise removal of virtio pci device").
> > > > > >
> > > > > > Virtio drivers and PCI devices have never fully supported true
> > > > > > surprise (aka hot
> > > > > > unplug) removal. Drivers historically continued processing and
> > > > > > waiting for pending I/O and even continued synchronous device
> > > > > > reset during surprise removal. Devices have also continued
> > > > > > completing I/Os, doing DMA and allowing device reset after
> > > > > > surprise
> > > removal to support such drivers.
> > > > > >
> > > > > > Supporting it correctly would require a new device capability
> > > > > > and driver negotiation in the virtio specification to safely
> > > > > > stop I/O and free queue
> > > > > memory.
> > > > > > Failure to do so either breaks all the existing drivers with
> > > > > > call trace listed in the commit or crashes the host on continui=
ng the
> DMA.
> > > > > > Hence, until such specification and devices are invented,
> > > > > > restore the previous behavior of treating surprise removal as
> > > > > > graceful removal to avoid regressions and maintain system
> > > > > > stability same as before the commit 43bb40c5b926 ("virtio_pci:
> > > > > > Support surprise removal of virtio pci
> > > > > device").
> > > > > >
> > > > > > As explained above, previous analysis of solving this only in
> > > > > > driver was incomplete and non-reliable at [1] and at [2];
> > > > > > Hence reverting commit
> > > > > > 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio
> > > > > > pci
> > > > > > device") is still the best stand to restore failures of virtio
> > > > > > net and block
> > > > > devices.
> > > > > >
> > > > > > [1]
> > > > > >
> > > > > https://lore.kernel.org/virtualization/CY8PR12MB719506CC5613EB10
> > > > > 0BC6
> > > > > C6
> > > > > > 38 DCBD2@CY8PR12MB7195.namprd12.prod.outlook.com/#t
> > > > > > [2]
> > > > > > https://lore.kernel.org/virtualization/20250602024358.57114-1-
> > > > > > para
> > > > > > v@nv
> > > > > > idia.c
> > > > > > om/
> > > > > >
> > > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > > virtio pci device")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Reported-by: lirongqing@baidu.com
> > > > > > Closes:
> > > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb7
> > > > > > 3ca9
> > > > > > b474
> > > > > > 1@b
> > > > > > aidu.com/
> > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > >
> > > > >
> > > > >
> > > > > Tested-by: Li RongQing <lirongqing@baidu.com>
> > > > >
> > > > > Thanks
> > > > >
> > > > > -Li
> > > > >
> > > > Multiple users are blocked to have this fix in stable kernel.
> > >
> > > what are these users doing that is blocked by this fix?
> > >
> > Not sure I understand the question. Let me try to answer.
> > They are unable to dynamically add/remove the virtio net, block, fs dev=
ices in
> their systems.
> > Users have their networking applications running over NS network and
> database and file system through these devices.
> > Some of them keep reverting the patch. Some are unable to.
> > They are in search of stable kernel.
> >
> > Did I understand your question?
> >
>=20
> Not really, sorry.
>=20
> Does the system or does it not have a mechanical interlock?
>=20
It is modern system beyond mechanical interlock but has the ability for sur=
prise removal.

> If it does, how does a user run into surprise removal issues without the =
ability
> to remove the device?
>=20
User has the ability to surprise removal a device from the slot via the slo=
t's pci registers.
Yet the device is capable enough to fulfil the needs of broken drivers whic=
h are waiting for the pending requests to arrive.

> If it does not, and a user pull out the working device, how does your pat=
ch
> help?
>
A driver must tell that it will not follow broken ancient behaviour and at =
that point device would stop its ancient backward compatibility mode.
=20
> --
> MST


