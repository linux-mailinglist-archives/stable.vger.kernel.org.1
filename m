Return-Path: <stable+bounces-176590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41304B39A72
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 12:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F691899E2E
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 10:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C71430C36A;
	Thu, 28 Aug 2025 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BCTLuCGL"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403D255F39
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377682; cv=fail; b=QeycoUqPggTWvI27PGbrywJiyu8DES0obIhiM7XHsdVLNG4jn4xpaVdEFqiRK2sqOnc+3GCQ0bjY5FBC1kG1y1KTyk8VIfLepi0qNb6IJfF4RCMBz42hQcC7z8R7LPXjLuGTvIfQUhH99eZmnfxGmSv7lmg8fvgCeOGUoiYczGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377682; c=relaxed/simple;
	bh=LMylAJWnlr2Oj43O1jY0fm/PV6xLTMDyb64G/t6D5SI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s5p24CWSExnSlOcrye9lT7JhnZ0VwkRVmDEIbfHsdVcllPp7XP7O7oMOiSslb3NmwvR0CR/AGEkIhFIEJsbNSSZYnE20K8L4+/+igzHaY3a3QeglNR33nNGTM5Qj9lAGaj7NDcP5Ft5crONv74fSnXnhJyXgPPW5wyGOgzEUGt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BCTLuCGL; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4kFq0YdchsES+iJLBdlDCWyuDWUaD/tMDl2wMzcyxz792FcT++BOzi8dly4kK4MhouuLjpyz1+4T5GDOWskfy/INmKwERaVLmnjC4ZWhPKKalRRFys/gCQaQ/uobNtDMZz8OEH9hUuiXShosFM/t6VsEgl3Ecgf/XHKioE1WzEXQ0lAn+KPjsrtbPbKgL+8pQSQE5FwgDPJZtIWB8BRNf8EUyJWDXzc6E/ZqPkLObn8pDcgS8WJokwYA2JL6B/QsOGITTDdICNkS0JaivGqjD9hBkiKZR1K1gdNoIqNIF9UwZyY1uhXYn/DE0jfaY6V68pXc1EdvOVoZHEObYbgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF74rbSqpS5rSHj5FghZaWLLWpUImNqap8EH9+jGkmc=;
 b=Vrzn7yNttQADfy11ZdOwsYWW9dodPF8A5IM9KR9Llq+D/6a3kGQ+S/vn6IdYT+6HMwQ3DFRtPeCZEyktfj+VKB7jYz7PVk9do7mvfHDvTy4GLts/TggCistF5/fZdK4UAU11En9O5uy/sCh4f/TJc3Bz3J1br3/bBVCUJ4kTdlU9nyDCLoY0b7sPjKHKlbLN9MZ1AQO2w3mvnfSLDUHGW9qAr4xON2PL74B/1BZqC7z78TzJwvlMjN3JTgIXk4D6dIcaalZk083hH1KgIpcnPno1x2nT36WHzl/leP2igDpMGxMM7EhMVGs44hBPbQP9EGQiUaigAfqwVJe3G61OwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF74rbSqpS5rSHj5FghZaWLLWpUImNqap8EH9+jGkmc=;
 b=BCTLuCGLvLbtIRr4X9WDdNS+8UL2DilPqqUJGYsW3m/lPY55/3IQF5GtjEvklDuhAlBqsc9XPrUdmK8R1iBcNfCjBCMasXxUiNGZtFXHYeGuK69CBnP7RlxTiRVFcBidqE0VGegHE3Nc82uPvZOsuAYz66yLU22oMURTjg2BKuLHYtYOvfKVmYwTW8eaoAiV7pJIsgmVh4HFa+BZeePr1c/DgA+D/MBiP0Sj1EqYAkSpBKzlyLawAAo1J1xxHpynB/NGfZLKpza3uF8Upt3dfhSBZeO1ijfVbSPJlRR+wQydAhFzh7Cil2UsL+Z+Tt6t4jiRC682LsRtjhfh/HSl2g==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.19; Thu, 28 Aug
 2025 10:41:12 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 10:41:12 +0000
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
Thread-Index:
 AdwTTxd+YdVEFNqzQBWcarw+isQ7dgAEGgsAAAF2L4AAAZBEYAAAb+MAAEx3t3AAGRJRgABs+xOwACE6ZgAAAPkmAAAm38wQAAKB44AAAC6g0AAFuYuAAAJbyGA=
Date: Thu, 28 Aug 2025 10:41:11 +0000
Message-ID:
 <CY8PR12MB719589580EA349D1D93F9489DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095948-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71954425100362FBA7E29F15DC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102542-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195EC4A075009871C937664DC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061925-mutt-send-email-mst@kernel.org>
 <20250827064404-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71950328172FA0A696839623DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250828022502-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71956D1AB42BFA9BF19AE134DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250828051435-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250828051435-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|IA1PR12MB8518:EE_
x-ms-office365-filtering-correlation-id: 2f0775d9-67bf-49c8-d1c7-08dde61f680c
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kY1a9imCisyqyJU2yPjxCZggjEang5muSmf+jw9bjMoq54+eAke7d5SwPtRy?=
 =?us-ascii?Q?hyVigZoj/UvHsNrRxKY0ExYcRYhG/grWQuTvSU2UkijEzYH/ta+t3tAaWSvX?=
 =?us-ascii?Q?jPeN4GrpiXtVrGAm9baWj9mVI/84m7vPPgmhVWeAnt2nLiCUeTdXlJYWko0W?=
 =?us-ascii?Q?zlcsv37OcU6ezm0X6NWTz42YaP77/7RqfS9tviX21MlGCBOoYN7md2E3USbs?=
 =?us-ascii?Q?//7UECpg/nezDYf6wUsM+UIxR0onr8jVzMZczbRbZth7fjVaBUNI8+S630DI?=
 =?us-ascii?Q?O1GHp+qoMzVMVeHTxaUxOlWOL6lUGWTrMltZUBcjlvDTwA+berKqIkt4DpTH?=
 =?us-ascii?Q?LoUgQFqIpcX6jS0Q0L/GZYDH+l5Qv6QbUjAcbPA7jpUqz74m7r4xJeGAdHtS?=
 =?us-ascii?Q?eTVIz8b9TwNaVsVWU159Cf8wnRdtKmfvXckb3isMuBOlcQfOUyIf8kbeMQpy?=
 =?us-ascii?Q?ZAdxHkyTc1lQH629cwbtntl8iYmgipPnnZ2vZ6Flg98MEmIZLj5mk7oOW+/d?=
 =?us-ascii?Q?z/4pIRFnFLR9pSIDtNz3cm3xhgEPJ6bQYlmXyhY31CDYPU/DDgNE7B+oiV3P?=
 =?us-ascii?Q?zVFLW9evAwIxfpb2bCuKVVOAuWgBsCA96/oDCAWQN2J4lPNtU6USNfDiD4Xa?=
 =?us-ascii?Q?aLfyXKpsjJNpZ7O36PmPSPDK9WLRrUjzejpef+sMyEVtYzL7jMXwTT9QW9kj?=
 =?us-ascii?Q?dq1cRpgtUtS+hvJW/aZrbF46DTs9kPci3ihhiXlUVeKWiH09FJDHpH5j3EO5?=
 =?us-ascii?Q?29+e00JLU9t87/tNanJI3ecgGOAq/PR5XNsRQvSed7INDIBUZgz+SWI90nvZ?=
 =?us-ascii?Q?btwRJVyNeXizHG6gdVf6l6+fUm5ehGYMBw+8QP/jSo6Y/fWdh1wpLnsVw0zT?=
 =?us-ascii?Q?vEyOGfXzFBOzw2HORhYjq1QhovVHm1sqLvp6qjTSFZxm5W86ohOrxKXuC9Bt?=
 =?us-ascii?Q?DbdPLIddiuyVRKWfLrkUqgkiCiNaT5giBdH6N2P7+8iGRLOHUAir6e2JjPud?=
 =?us-ascii?Q?3UoeZRhLhC+7aRbe/nTAiwt2ZM4q8VTLEIH0b114Oq1CR9TWvpseUNJxneSc?=
 =?us-ascii?Q?Fc7WIIiJSubzqFLRdF8ynmuX3xJ+Ob7gNdhb0HSYu4THpg8oDsFusUcFhZ/I?=
 =?us-ascii?Q?sbyIGsiwZAF7C6uCB0TiNVEgpBgeS4bjb4b/HlnYG1QYNrkKTadluFoJ5Idl?=
 =?us-ascii?Q?McsG53LgQpEIh8eOJC0jW3kSLxcHPulCopADg1M1mIZMQ2tU5D/pysijh8h6?=
 =?us-ascii?Q?zA5gupkA4Xz1EWEHvGvVHs09/fE/IKDkOo27D/p3h+LVXKLHRiPxAG7JAiVo?=
 =?us-ascii?Q?l0Qgzu1g6VzWLgFAArVjplikC5LAMZbf9BpP9fCxyCxA1A07SFGKBfu00ski?=
 =?us-ascii?Q?aJZV13dYCclMfuAF4Vg/2ZKVkwLxZCWkAo/7iPK6CbPCUNNuXORPxdoMO3o8?=
 =?us-ascii?Q?7O9ic2cQbUG0b4OdHkal6pG8DeQZbm3QyyinAOb6+HYfpD0LoGhflA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uBlJCJ27x9PXeNcswXWr6Zk2Rof2kjSUV9vY2tIRxgKg7K7aKdM1Rjoy2E3p?=
 =?us-ascii?Q?VZRcLPRFDoS3a/nQNok9W9o7GzN3k4Jx3ud3OAgFzRFlnxmWx237M8xrHXdC?=
 =?us-ascii?Q?DLrBwkVmuBm1N5kmuL1jV5xszDE66B90ji4DVfM0La5SBmYyJW+TsjOPZoWx?=
 =?us-ascii?Q?RNdS9ifS5kywsqkZq+UXC9kt+bWnJfY+xL4K49Ns2zoTTIRzLIV8xEOZJDPH?=
 =?us-ascii?Q?SMhqEgr7E+LddudjI8E3kCql2yFN6UbEFcSJ3PXe0CMBIlUEjag6kRcQHHJT?=
 =?us-ascii?Q?SXUsUswcQAGgbe0Q/lJo1D3d0CTj3hcX5yw0EYPwBcg0sH02YyuAFV3cxQh3?=
 =?us-ascii?Q?3fEwGUaUqc7LDcUzLhM7YnKBGMHqsbAi8Cch5ar6l7kiqlKFSt9ahMJd7KD9?=
 =?us-ascii?Q?wFUSAEUS7aCv5kTJHCC8shCRUhqhe+uDagJAGnf0w1HOuhFFAPJ4pVzfDVfT?=
 =?us-ascii?Q?po+tyi02PuAPvnOmJUIBAIXmn8KgPIrX4JJQqPZDldCdqo/XnsVky5+dCtJP?=
 =?us-ascii?Q?EsntpAb2S7et6kVAHVBdUoJi2BxvoUjxAy77mK+9gNTlz5+kKJNxTjOmzgN2?=
 =?us-ascii?Q?iuZ/Yu+frwmEGSpr5mIXCj224L1UompjuMj1tnoa8uPSmIS7PzHqoeFW39RZ?=
 =?us-ascii?Q?GOUTHx0EKKR5XSYG98m67Top8WRH2I+U7GB/+VmOmnRwEjdK+ygTGNB2tjju?=
 =?us-ascii?Q?tiZSTlbl+1XCYaSdQmtSW9Gk04B1/TLxSqCVkUTNsD2AxmBlSotVfnFUGWgY?=
 =?us-ascii?Q?uNjpW0GM3Dxl4zQbOgWAsfMPpMUXEldoAN2R/TmSCpqVqZ4c8JMm+AF8xDaC?=
 =?us-ascii?Q?uzfeG9IwLbXMWgC92gBCB/Gwd1QYRR7nm+pjtpv6tAW3p028kR00O545K2fQ?=
 =?us-ascii?Q?bEeewLI1aKwrcHoE38e53qEhoZphs9HsB/cXe1jn16xM3GwyOi2zsQ7Mm8MC?=
 =?us-ascii?Q?4q8YjM2+YVVpvmh7KtS/tFq8Wto4myNHYL3F0SVV3HbWuof494jc6EBLuGr7?=
 =?us-ascii?Q?MJC/EiQgsmls/x95w3eIusBFBlc4EUGH00l68oOJRlRJ3p74urNRxoHdwkwO?=
 =?us-ascii?Q?jXKsnaMiCpKDAw2CCO5oCktQ3XNEtzs1e6jQOWXcR8qtsEbtdJupAljghnNB?=
 =?us-ascii?Q?W3MDrQd9bFfhCAYqo47AYeOJRSPpPzHvFbN8CF2mbcR+Kwca/GZ5IrXHvkTU?=
 =?us-ascii?Q?MMzYbFj0u994TKexpwx6XfFIPzUZHfVkAVGQwn1NpANBeoqnuWSITyiyqLvh?=
 =?us-ascii?Q?N8YT3YjAqnvSemZbrdgL9AtpKp1bivjxmTeLTZh+pgL/sYN7kUZ40sVBOD/5?=
 =?us-ascii?Q?KU7alOfXyGY54ZOiRkp30I/B2N+BWthvzy4ed1BwI6606Th4kg54DVO8lSLJ?=
 =?us-ascii?Q?cE1z9LXCCEGmXxWj3/4ZRausrhVha6qd68BDcms3/XQKDxf2F188hcipBwGP?=
 =?us-ascii?Q?UQKVC8snL7Wtvza4NDQQKhqcC/Z+8eUELFa4LBO/86vP+5RHVAPmZTVrFaIj?=
 =?us-ascii?Q?wZ7JGGmYWtMAN36/X+HlyPWynIAyG6TTFkFx9JMKfLDa1csW8IweMeeNkYoI?=
 =?us-ascii?Q?GMz0ZTwG5s2A878vnKQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0775d9-67bf-49c8-d1c7-08dde61f680c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 10:41:11.7437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARyQMLFGdLoZ3nABnxECBCf5G0BUZ9ZSXUAx6h5ThDyssQrTRZxyxEj2M8sRmY8MTZLK1rKv0E93Gm7JAj4z2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 28 August 2025 02:53 PM
>=20
> On Thu, Aug 28, 2025 at 06:59:26AM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: 28 August 2025 12:04 PM
> > >
> > > On Thu, Aug 28, 2025 at 06:23:02AM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: 27 August 2025 04:19 PM
> > > > >
> > > > > On Wed, Aug 27, 2025 at 06:21:28AM -0400, Michael S. Tsirkin wrot=
e:
> > > > > > On Tue, Aug 26, 2025 at 06:52:11PM +0000, Parav Pandit wrote:
> > > > > > > > > > If it does not, and a user pull out the working
> > > > > > > > > > device, how does your patch help?
> > > > > > > > > >
> > > > > > > > > A driver must tell that it will not follow broken
> > > > > > > > > ancient behaviour and at that
> > > > > > > > point device would stop its ancient backward compatibility =
mode.
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > I don't know what is "ancient backward compatibility mode".
> > > > > > > >
> > > > > > > Let me explain.
> > > > > > > Sadly, CSPs virtio pci device implementation is done such a
> > > > > > > way that, it
> > > > > works with ancient Linux kernel which does not have commit
> > > > > 43bb40c5b9265.
> > > > > >
> > > > > >
> > > > > > OK we are getting new information here.
> > > > > >
> > > > > > So let me summarize. There's a virtual system that pretends,
> > > > > > to the guest, that device was removed by surprise removal, but
> > > > > > actually device is there and is still doing DMA.
> > > > > > Is that a fair summary?
> > > > >
> > > > Yes.
> > > >
> > > > > If that is the case, the thing to do would be to try and detect
> > > > > the fake removal and then work with device as usual - device not
> > > > > doing DMA after removal is pretty fundamental, after all.
> > > > >
> > > > The issue is: one can build the device to stop the DMA.
> > > > There is no predictable combination for the driver and device that
> > > > can work
> > > for the user.
> > > > For example,
> > > > Device that stops the dma will not work before the commit
> 43bb40c5b9265.
> > > > Device that continues the dma will not work with whatever new
> > > implementation done in future kernels.
> > > >
> > > > Hence the capability negotiation would be needed so that device
> > > > can stop the
> > > DMA, config interrupts etc.
> > >
> > > So this is a broken implementation at the pci level. We really can't
> > > fix removal for this device at all, except by fixing the device.
> > The device to be told how to behave with/without commit 43bb40c5b9265.
> > Not sure what you mean by 'fix the device'.
> >
> > Users are running stable kernel that has commit 43bb40c5b9265 and its
> broken setup for them.
> >
> > > Whatever works, works by
> > > chance.  Feature negotiation in spec is not the way to fix that, but
> > > some work arounds in the driver to skip the device are acceptable,
> > > mostly to not bother with it.
> > >
> > Why not?
> > It sounds like we need feature bit like VERSION_1 or ORDER_PLATFORM.
>=20
>=20
> Because the device is out of spec (PCI spec which virtio references).
>=20
> Besides the bug is not in the device, it's in the pci emulation.
>=20
>=20
> > To _fix_ a stable kernel, if you have a suggestion, please suggest.
> >
> > > Pls document exactly how this pci looks. Does it have an id we can
> > > use to detect it?
> > >
> > CSPs have different device and vendor id for vnet, blk vfs.
> > Is that what you mean by id?
>=20
> vendor id is one way, yes. maybe a revision check, too.
>
Vendor and device id are as defined in virtio spec as ID 0x1AF4 and respect=
ive device id.
=20
> > > > > For example, how about reading device control+status?
> > > > >
> > > > Most platforms read 0xffff on non-existing device, but not sure if
> > > > this the
> > > standard or well defined.
> > >
> > > IIRC it's in the pci spec as a note.
> > >
> > Checking.
> >
> > > > > If we get all ones device has been removed If we get 0 in bus
> > > > > master: device has been removed but re-inserted Anything else is
> > > > > a fake removal
> > > > >
> > > > Bus master check may pass, right returning all 1s, even if the
> > > > device is
> > > removed, isn't it?
> > >
> > >
> > > So we check all ones 1st, only check bus master if not all ones?
> > >
> > Pci subsystem typically checks the vendor and device ids, and if its no=
t all 1s,
> its safe enough check.
> >
> > How about a fix something like this:
> >
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -746,12 +746,16 @@ static void virtio_pci_remove(struct pci_dev
> > *pci_dev)  {
> >         struct virtio_pci_device *vp_dev =3D pci_get_drvdata(pci_dev);
> >         struct device *dev =3D get_device(&vp_dev->vdev.dev);
> > +       u32 v;
> >
> >         /*
> >          * Device is marked broken on surprise removal so that virtio u=
pper
> >          * layers can abort any ongoing operation.
> > +        * Make sure that device is truly removed by directly interacti=
ng
> > +        * with the device (and not just depend on the slot registers).
> >          */
> > -       if (!pci_device_is_present(pci_dev))
> > +       if (!pci_device_is_present(pci_dev) &&
> > +           !pci_bus_read_dev_vendor_id(pci_dev->bus, pci_dev->devfn,
> > + &v, 0))
> >                 virtio_break_device(&vp_dev->vdev);
> >
> > So if the device is still there, it let it go through its usual cleanup=
 flow.
> > And post this fix, a proper implementation with callback etc that you
> described can be implemented.
>=20
>=20
> I don't have a big problem with this, but I don't understand the scenario=
 now
> again. report_error_detected relies on dev->error_state and bus read.
> error_state is set on AER reporting an error. This is not what you descri=
bed.
>=20
When pci device is virtually removed from the slot error_state is updated u=
sing,

pci_dev_set_disconnected()
  pci_dev_set_io_state()

> Does the patch actually solve the problem for you?
>=20
It should. I am going to check if this approach looks fine to you.
Please let me know.

> Also can we limit this to a specific vendor id, or something like that?
>
Its spec defined 0x1AF4.
=20
>=20
> I also still like the idea of reading dev control and status, since it al=
ways
> bothered me that there's a theoretical chance that device is re-inserted =
and bus
> read will succeed. Or maybe I'm imagining it.
>=20
Re-insertion cannot happen in same slot until the previous slot is properly=
 cleaned up and bus number is not released.
User may still attempt to plug in in same (virtual) or physical slot, but i=
t will get different bus assigned as the previous one is not recycled yet b=
ecause cleanup didnt finish yet.
>=20
> --
> MST


