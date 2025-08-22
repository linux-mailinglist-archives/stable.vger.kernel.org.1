Return-Path: <stable+bounces-172392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D18B31A37
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 15:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72259188CB89
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 13:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946DB302747;
	Fri, 22 Aug 2025 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V0OgGe+F"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0725284B4E
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870580; cv=fail; b=TLtTS2ZoEAQGu/18tyMYECfLL7J0mu/GwBG6OOxqnRUjMf0rEcUrt8dRCC5/cEtyhyZoLoQcV9XDxI9JUATqFAxZIML81yuubAfQSER9u19AoxJCVzqpI9IXQaPOOsC629qrtzsU2QWUpYrHWh4kjG4Rk1m+Q2V8br/kGEg0feg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870580; c=relaxed/simple;
	bh=/mset3D/sT+OkQSDTeXa9m7YVwbeDvjIOE9tsIbGN60=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JMt9ietF+TFSg3R4YczkX5Ypfx/8hVng0BvZa5dqGcRzR9Anz/1wpwzulSEiuom6lcEIbpj05jC1Gi7clZhezYTWEjoaFgoKbAAU7AAB1nTujM4ahrtNiAqw0wqj5vIqu826Pfxv6lOz6FeyAXg6pPPUfZhsfr+SOEFY1JzcyZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V0OgGe+F; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VN7BHRwmzovRf4TzqzOqvNxK7ldk2QCvFoBoTHE1+nvdnBB1/hSXPZyn1Dw/atfHax8KOTT/3rJBchkfPFOL0vBhqBADo2OycHxJixTCcwoaqALrznFW/RXP9rITLax6B6G+K2wKtOzkp6AS2Pdh+pwjTkh33rfOhBa+fYF347tKDO1iNcfJsn32VAaES1qbrFruWppkm//+Jb1O0os/TgF99+mdPnb/eOjexAZfi32QmOuckWc98EBnzqEJVWBxAGFRitNJbJno5QxXMk2yhLolGFBytMx78lVey1bJiup3ss9A9G5l26CK6T6CfoqnPEGqaaw1H2Gyc8GjcOM6hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mset3D/sT+OkQSDTeXa9m7YVwbeDvjIOE9tsIbGN60=;
 b=CBoJAtcDXe+okfCMXpi/Xnn0ZnJZmkDJcBMbhFNB2JymAvM/711plqdMqPZ/DqEm9AzE0S9l3QASANTP+nsXEiIljDPJD0SxBagCKejL3YufjsXFgGVbQYX3PGn25Cp+v48T494G16s7JxX0V79y5D/ta7MmTXywF9SG6OPI4/VIbNpxn0caZM+4V3KafMFAPrUMnAluI3WXiLiuK1Erj/4q+mMwZXOybafIDj5wUXfMrVZnzH5y7vgzJC7d2SxLZkNj4o+GPJlDKp3vJwR5upLrTqJ+VfQmYPjEBXGiCzaXDK//bzW+3gSMKoVUAyaA6Y/EY5wnoQoc/rW+wXOcew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mset3D/sT+OkQSDTeXa9m7YVwbeDvjIOE9tsIbGN60=;
 b=V0OgGe+FqCm4hJM/OEFRFTPlkDvu4QfErfoUoiXu9FrNAGpABRg8SJFymgIrjLnymp0dh8YXY39Cg3Njvg2BO6nXiRxc1Ud53SIj6JmzY2bzSlFU6udVDtZOtg4NnJPBPRWfboZRbM9p5p73VPa/KEXL605c3/RC12SU1vFxqs2DMfR+RPP3tziK6HpPzsDAdNqQykLVEETSyd0QgIYc6FDZ99ixhXGBV4oaVZ3sPhaQ1/Zw8fl05PHWmANFqNMHYvHrgi2wj9L/HQZQqXEbiTpAcW7HNqCm+uupKk0XidsfdyVkQgW0vihYLKnxE0GEbdzaPA+m3GohaAxtvL9lEA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 13:49:36 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9031.026; Fri, 22 Aug 2025
 13:49:36 +0000
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
Thread-Index: AQHcE0XKqVbu8cWtaUCLZj1LjgeTGbRudpsAgAAWuWCAABaPAIAADA7w
Date: Fri, 22 Aug 2025 13:49:36 +0000
Message-ID:
 <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250822091706.21170-1-parav@nvidia.com>
 <20250822060839-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195292684E62FD44B3ADFF9DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090249-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250822090249-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DM3PR12MB9413:EE_
x-ms-office365-filtering-correlation-id: 953043d1-7cca-4505-046b-08dde182bb72
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GjhMB8HDGUuvjjuMMiq70JxPmcW9arxdl0EXhGirX9LvaLZo0XR6TdwO3tUM?=
 =?us-ascii?Q?u3e946AUBISZUYF7BypDiY9ZPeUAO31vIzN4hDHkc3+vtMq2bMR9FbsbqV6N?=
 =?us-ascii?Q?UhDiqrvW7PLQApRnAsrvvebm5H/DSWClRM9tGbGoN7jH1QtR7uTw6fKu2b8G?=
 =?us-ascii?Q?r6s42y3yY4X+jbGG6+JflkRF3lX0ZqpXwfTCrG+ZQApEhWHBaRBxUfUEtpwz?=
 =?us-ascii?Q?G9pXmDqg3pGjwfjH2icxMsi3D5euQgVI5li2dwFO/5ENaZuBrY+Rwg5PRfbl?=
 =?us-ascii?Q?AEaZobqCzqzTCWAjjfWVeuTRm/TVoqau7SqXmGNmc04/sE90h/00i2jnl2h2?=
 =?us-ascii?Q?km91GTljll5hrKISBlPW+hR8YONg7EpbYR+Uc8SZ7NsyY/NZliQimzOkqeLx?=
 =?us-ascii?Q?rPQlLgHx0OUnWb1SUJ5H+Os67qEtBqMG+Zj3qGseQbZy7jA+Synzg1natBxP?=
 =?us-ascii?Q?fGFFd8wG+/xa7LKl4da/N8xzL4HLdVnVUyf5UXFs47yBqvYU6HHN2SfbyvG9?=
 =?us-ascii?Q?QmA59elISTgNXULbgyeECO+eVjBYLUDbch7b4ULeuWQrJ7+RAQBfJEumYl0i?=
 =?us-ascii?Q?c2UeygRMO6v2YSJJQ8uqo0l1PZ/JcSYU/AApx7UodNHzI6DK2Rt/Ifcew5VI?=
 =?us-ascii?Q?DoaF4oUGF/seXqUVqa5endPBPvkYUXnzN8gJCZUalcp/5RDosVNMABPzxsns?=
 =?us-ascii?Q?9ZnpJB3XfRv3/i+nE5VTab93BvlQLFAln2RPoB+0D23hqRdFqERbKYSZI0YW?=
 =?us-ascii?Q?Tcj+pG4h4OM0I+WvuWzLDmlbFatc3naYc/qWQWNV9zBQZZrEskT6uwh3+lMe?=
 =?us-ascii?Q?mkgwJKG/ExN50ddmldtAYRcMcnh/7KkHlmlAon13omhCc2EnqzePW3AXTN0f?=
 =?us-ascii?Q?HGhmiw8FGnlq+x06zbxk4c2NHAZxKqAGOWTxtxo1uBp8KIbZrCWVofQUPZbN?=
 =?us-ascii?Q?X1erdrLqsrGHiZ8qKML8d8x+2Kf1EAgkKvItltY28EPHiw5sqMOcpJnipgBw?=
 =?us-ascii?Q?0Mhm/NOv8nBjxmQtQNZjQHr06JbZSEvjq185WAmNCrJBWFmCSgKf/eHHwqbn?=
 =?us-ascii?Q?FiAIH8EVbolxydZ7QlRN1ZBLO9zhEtksuULqw960C20+jRa//NS/iYDeiKUY?=
 =?us-ascii?Q?sbmOb/kN0E7N0NdsaO/gmQwLfUD9UrNc0m7RL3HPu0dVVAgmUcH6Z6Gbpst5?=
 =?us-ascii?Q?m3k9rfTufV4el+Qz1Fd895ZLrUl5g8v0bTARmdH3U3MC+XF83KnmxFHtxFYN?=
 =?us-ascii?Q?4wJP+ACT8F7UqMJV7sjqbsYcFQyuPZs5iaBUPIfRU7DYVdCmF0fW9SNojzQp?=
 =?us-ascii?Q?DHoHUDlnGC2gPibnpG/HN2v+0EEwpIBNWibkV9Vmz5+c91DNkndoVjedlgWa?=
 =?us-ascii?Q?I/VDfXLXTsyHpxvfK9NQZ6BDqxSfRI5XOOURJrDAtFKGYjt/A1ue7jaziA83?=
 =?us-ascii?Q?gpsGVFqiW8fp8FQ/q5ZCYj0qgD0EjNImqhCc907VKkbCjHQF+zcxDK7eBEr1?=
 =?us-ascii?Q?rB+aIEuXTRC1fQU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k8yVaIStuAX8L5ikJSE+xCC602SjaNxxDZR8XVIUuFtWQ8mJBPTSAMuECsgV?=
 =?us-ascii?Q?omjq1MByFYs+Ij8T9xPW3D8ArQNN1SuEz9OPvfd2TaViqD4NRss79UM/buWe?=
 =?us-ascii?Q?/DzQy3Q4gsEvIRp5WQZwHsNezvaA3BPPlMeYlglcxo4nGGFnZrSlVHs6fcRR?=
 =?us-ascii?Q?qAh9S+p09o2OOdiwW6ctl78a6dzaBq7T5b8GBDnx4RwshATCI/2/xwIGc8JM?=
 =?us-ascii?Q?8l34/qBN35KZAiVG+76PGJPj7b/Lgfgq+6R0dRlk8Vvxm30E1BjsUYFOvqJD?=
 =?us-ascii?Q?FS4+agNXsmq5v5hoUDkXtnGJjtiXZwXSQoE32UgCqTT00jNCR8ONhi5Ek6Wz?=
 =?us-ascii?Q?mxytkDKQw2o7aKqYc4Xo8JI1axT0GXoEkrj37piGJCOl4ALv9bHw8mLdXhGS?=
 =?us-ascii?Q?KrpsYCGOXf0EsAuHRgLXUOva6rQjY7cWgBL9Z/LElQIQkTchTj4tS7EVbod5?=
 =?us-ascii?Q?8wPq425Q+opql8k3jyyPWpcdgPutWssgHQaf36+modev6kcBAlltZI8VZ1ry?=
 =?us-ascii?Q?I4GNH1P9509qSm+kNhviaEN57Z3EVrEryIScH0h8BaYD3ku7B/fELIr5ATqf?=
 =?us-ascii?Q?aA9f0MDytYX0NAaXrXQXXWH6sjSSSGfTwGnEr3nE06kmMJkaeGGyBZLd14LW?=
 =?us-ascii?Q?XLx0zFmawCP0kXkpdBNMW86ucORi9ZsqY0MGLIFivgcSJ8ykrmui8N898JdP?=
 =?us-ascii?Q?sWq7x7D1WUBsh0PVd22lIBiLQAzl/LGavVpjM/zVHTKCB6r3AO8Hm3Mz66nf?=
 =?us-ascii?Q?mlz9FtGRm/5q1gMi89z4miNBFOxcjf1LpTV3eOR7UW+9PEOMDd5UUHx6JDYf?=
 =?us-ascii?Q?VB/hQU7nVM0KQpTO6cMc9cG9hydriPo6YED8iohdFAKuyQiHZB/offrEtkYu?=
 =?us-ascii?Q?kaY/ZFNQ3QvRdOHfkGd/0XqrREM/D8cqMn3JfYXSesDWbik16zLavAwSl8NT?=
 =?us-ascii?Q?x44yXHY69o0xr6ZQvaSfd+nVuskXsIwvZ8hulCccN6WG4oxoiHKYv8eQES9O?=
 =?us-ascii?Q?FNuE5c2lmkQvoPn/IbOWVKvf5Hf7ievxTyx4B2qVh4vST6yjL8F54844uRLi?=
 =?us-ascii?Q?MWY7A/c9gFQE8PwgdMAqndFiizQMy1bbZrTPESr2ebaPwMtcqGoBt9uvfm59?=
 =?us-ascii?Q?SzkuSNTFiy/FZ6wfWaiChYg9n9br2Gs+E75u0xAh8eoMPYuu5KRoMh2mQSNJ?=
 =?us-ascii?Q?LWFAznpmo/962V3oAaEws/tu9OYcWWaCHLBupoIOSa/xQEsX3Pvso8J7codz?=
 =?us-ascii?Q?GkVKT9YmqfgjNCu60BWnmXWPWYhZgqquiTaKi23LKeakdyLrRZq/sCEZnUnI?=
 =?us-ascii?Q?WUh9YoXDOadpl+hsAVkTUEJp3xA77djzV7chLCTqzMzz9BQQ1lvVpevhCs2K?=
 =?us-ascii?Q?rsQD4CLeYekOlPs9mKLYrF9P7YbCBs4ecPw4mcAcHC+YBid/XvTnWRA7YFKE?=
 =?us-ascii?Q?dUluUlopmrH6VKRsupndmWhHvjtT5b4eP0kF2JnJCHOfwD6CbU6zMoh0Kils?=
 =?us-ascii?Q?3KoA2V9ZBBK3AeXlGKrnIi8oSKMkGio+GoaBmfwU8BZVIwiyQ0XczNIvZHoy?=
 =?us-ascii?Q?GHQBs++3mpLlzIoaNQw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 953043d1-7cca-4505-046b-08dde182bb72
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 13:49:36.3237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UShYHccKEm8c70BFUCjWWPv67oN+b2fOG2pyAI1k29FxowFHUaXszrAgGb+dnRVJRltnjravnzus0XXM6yK8EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 22 August 2025 06:34 PM
>=20
> On Fri, Aug 22, 2025 at 12:22:50PM +0000, Parav Pandit wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: 22 August 2025 03:52 PM
> > >
> > > On Fri, Aug 22, 2025 at 12:17:06PM +0300, Parav Pandit wrote:
> > > > This reverts commit 43bb40c5b926 ("virtio_pci: Support surprise
> > > > removal of
> > > virtio pci device").
> > > >
> > > > Virtio drivers and PCI devices have never fully supported true
> > > > surprise (aka hot unplug) removal. Drivers historically continued
> > > > processing and waiting for pending I/O and even continued
> > > > synchronous device reset during surprise removal. Devices have
> > > > also continued completing I/Os, doing DMA and allowing device
> > > > reset after surprise removal to support such drivers.
> > > >
> > > > Supporting it correctly would require a new device capability
> > >
> > > If a device is removed, it is removed.
> > This is how it was implemented and none of the virtio drivers supported=
 it.
> > So vendors had stepped away from such device implementation.
> > (not just us).
>=20
>=20
> If the slot does not have a mechanical interlock, I can pull the device o=
ut. It's
> not up to a device implementation.

Sure yes, stack is not there yet to support it.
Each of the virtio device drivers are not there yet.
Lets build that infra, let device indicate it and it will be smooth ride fo=
r driver and device.

