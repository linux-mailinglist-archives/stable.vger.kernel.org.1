Return-Path: <stable+bounces-189265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3628C08D1A
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 09:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F32407C68
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 07:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EDB2D3A9C;
	Sat, 25 Oct 2025 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ik/fkAGS"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC61212B31;
	Sat, 25 Oct 2025 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761376296; cv=fail; b=m4slpjZ5ryvrU4fhf2bwQRPVqd0RqjhWcOh8qx3qHdOxLSvcpGtI6N6ipUy1r7TJbMjMKx+YxpLJXMxc08Rg71mQ2rNpRLO6V9x9WU5giUiF6OG2G32xn5B3RHWovLZFr6wnGprAr3jU5LWsytWDXxd2kJqH+M/L3jHW4ll1L+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761376296; c=relaxed/simple;
	bh=nzy118G83XhApnaqE8DvaaHfXAj/vXYpBCqyNdeOERc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oh7syhVpf1EUzv8s/hcmf7HP4tI3zVn7FnRdtqf4y/3CCQz7/z4F5yL5tdbX+LV6G+drWqkSQtrJL23gpMlcvZWM8pW01EC8s0cZsc9QFTrGrhCvE2Z57+vIlgfekBWvYaEAOS00klY436KvDfVOrb962qsbzttyFyBXDgExr4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ik/fkAGS; arc=fail smtp.client-ip=52.101.53.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLIb4QMy7XHeQAXYqNqVyBj0ghKtkb7+UFVQgxQwWWc4LZ31UeVI3T5yLtijrkZW4oDv4UmJHMT0xz219KsFeoguPZKRETQ0/xVL7wkO2JvxCtgh0P8jhryGQs3jhOtNNvMKja4hU4jitfvMwSA6v8DZ+Fvb3a9sdYiA5om+A8DsnWFq1UrGWA/KYRuS96fGyLqhhduIOC2merbW3wwU6z5QgUftP1W9n6UA34s3S+wXpOQu6iowHj/ao52MTxHU+wzz/pBB7IK53c+gkrYmmD0XGzJ0rhkKy0K0BMaHEcycv7WIRr1ObkNEjhwr+MBepeBQeQVFo+l1v7hjR65esA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQxEoD97t6d+CwsajJVTpANw9nJXLjt3wGOLAdUch5w=;
 b=A8a/JmvGba5HIDT+7rqAP4tNDB6uITdZwNSshSXpZMrGqn1vykaR81Jy2uOA/YlBNolz20wrkh2cmbLrN0V9pIvj87SBDEKAsORWUVwLHBi65k8wqA8sgr9hKvuQ5O+GpPnry8B+RsyhPncoXZHqPECE+wte3n58LZx83TXKE/M7YA8Omp8yeBgt8Fi6pIxKRf2l1QfVOoI1HGC4Or/4t9/jehuV+bQdd9hPi5R78w9VDKQmyei7HLaN5CTHPskByUfaDMyacmBV0t3X1hRQmTchdQsdsbn76JtVlLNykKUnFCxjavdq80lkI4CEkMacyTewbn8ataMuxIrKX9VFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQxEoD97t6d+CwsajJVTpANw9nJXLjt3wGOLAdUch5w=;
 b=ik/fkAGSjHx/En91WWxXarlbim4DmhuJrAXcaWaYJyUHOePePayrNd+KTBdYfqy19WBM02PBvdSdzRTDGLJSyPtmQisRnxKfsjgZwrcr/+EH7oqibZE7ag6OIGmjTLHSv4xGSNQSDmfyI8xaIurKygNB47a921jpl/hP2537hLlPDwknFQjy8Coa484Gi3/pveaGzJ9pcLDfX+sILGC66edO82m+7kRHIjfqiwl4/qS50p/6YcZH3x2kfOd/+QT77QFFiTxXha5cZEQXPjktgO6+7kPFoU/Pka0VuKHpxaUCWdNHooKqE1mfuLslNNo/Z4CLMjgFidURs/DvbEtssg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Sat, 25 Oct
 2025 07:11:30 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%5]) with mapi id 15.20.9253.011; Sat, 25 Oct 2025
 07:11:30 +0000
From: Parav Pandit <parav@nvidia.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?iso-8859-1?Q?Eugenio_P=E9rez?=
	<eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Minggang(Gavin) Li"
	<gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v5] virtio-net: fix received length check in big
 packets
Thread-Topic: [PATCH net v5] virtio-net: fix received length check in big
 packets
Thread-Index: AQHcRPgJwKk3Q45MeUGTanh0wr8u4LTSclGg
Date: Sat, 25 Oct 2025 07:11:30 +0000
Message-ID:
 <CY8PR12MB71951A2ADD74508A9FC60956DCFEA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20251024150649.22906-1-minhquangbui99@gmail.com>
In-Reply-To: <20251024150649.22906-1-minhquangbui99@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DS7PR12MB9550:EE_
x-ms-office365-filtering-correlation-id: 88a8f1b0-637b-4af7-2a2c-08de1395b8f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ZCIivwdTVEDjx9SdMmtrkZLYEgbMXgSZKmJ0zzGtniEHovEaH00qdYZO0+?=
 =?iso-8859-1?Q?1lmISE+ndKgvdy71Q26eHpDfv/9PuVB88Qg39wjag/K9BXfHFFCoMu3D/u?=
 =?iso-8859-1?Q?l7Fzccd6NeeZYxtY08uIZanjB9ClU3AC6VRU/5b1pPq9aRVkcX4yReX5KP?=
 =?iso-8859-1?Q?JbA5Cqabsfi7X7lbilxCjFxTEt5mmUkuy/l1nG9aDPPL9C+tXnobMR9eM/?=
 =?iso-8859-1?Q?0PbhdQmzrBFKY2eeiXjfNjri9nWTfRlG+nq1NEKFGxfkoXwXkBHedFY301?=
 =?iso-8859-1?Q?Fa7PPtnADn0DY4U54ItIOkZeh/WM9tbZIYVbmQC8SVY628/fIWHRNF5/Jq?=
 =?iso-8859-1?Q?mGBOkFLcbqvmAwVVCzwPkun8qohPMw5H1fsirCmBDMQrOmeU3tZSkzxTdi?=
 =?iso-8859-1?Q?Y8F9Yw8csKhwnI1pFyekUAaktd7RSu5XKNyENuosbg2sTSebCF3w4BK6K6?=
 =?iso-8859-1?Q?WmQm3HW7Kv3kwis3H+IoWinybcEBYhy3nPEEs10rZX8qu5FZR38gy2CYN7?=
 =?iso-8859-1?Q?qyvXozrjUbxVokbdFeu/cuQgd+3G5ICcZNskiN5DVTaU5bIdOtz88nQ1iC?=
 =?iso-8859-1?Q?UEQ20yzHyn/UNAoPjsZAieneVdnNw1+501iL5CHU9iELboEajg7P+9JE1f?=
 =?iso-8859-1?Q?1JxhACC+Ox+rLdkfMKx5Eq7C4KRTcWg0hvTzo++BYKYPbQf/lf8zfr9wdY?=
 =?iso-8859-1?Q?3IoTvED1PWhMuh/p/HOibEVTkBIBv/G+T2vrCc695eFuIC2/Gqf8cG+Ako?=
 =?iso-8859-1?Q?RTCJlQb+2s7JrHtXLaWr2e2kvvlQXLyXuHm6Htl8H57o3+ACK/sC+VJs/j?=
 =?iso-8859-1?Q?nRuk7MNjacLRbQz2LFysywLUJ2cQfCoZ/VqowRZhsTKnmC6sYazG0F+dtf?=
 =?iso-8859-1?Q?RLZ6bGLsU151kV2GC9a2IeXh92mLjDpBwVIJ18jRNgXrqWHCvblXmBwaKJ?=
 =?iso-8859-1?Q?H3J3DZRhxC7GLN8cqnSDmRNNaAmFW1BVU0n4QXZLZ/qyVkI1qTgnzcAf1+?=
 =?iso-8859-1?Q?dfaEbEXNQifkYlLKzKfMlJ1ShuZWhV1e5uR0Lr6yibcuaPFK7upOfq2D/q?=
 =?iso-8859-1?Q?ORRJPOVWMkDEkreS5dpa8pshEH8L4gxWucHROtkIyVm/hIDtPdr03PDx4+?=
 =?iso-8859-1?Q?WNpoqPYlrhCEfTStBDChbqERM6ERuHb+mBTVx23eODV1V0JIdJ26xcDDQk?=
 =?iso-8859-1?Q?aWTiad4M7jkkjWHlF/y5F3MRcKopluJ3lTiMnvVhRbBddGoiudAwgEHHV2?=
 =?iso-8859-1?Q?o1vK11zDWb8zEl+dcSOUdi6Ia0R1kZkdncIdExbW7/W7M3PPtHDrerd8ZF?=
 =?iso-8859-1?Q?8rg8HzuwQoGh9FdYjbYH/peHlm0M8gtua0aaJk/q1cBuMmIDk0XYsoI7yx?=
 =?iso-8859-1?Q?Aw5KGv9z1hM0JT5ZKLZOaPAsgE7Mqxd8sRmezX2GX8rcAzVd3nhQaLlr2k?=
 =?iso-8859-1?Q?YX/eKicLBjzjgmO7RRm7XsQsBvHWyrYaxerxiG3sptX3oMiJ9H3Q63SQXh?=
 =?iso-8859-1?Q?RJ1szmWM9YdJTOn66D+hCsFuLeTay0CIiTo3JUkU9DVPJqP7W+paNyB3EP?=
 =?iso-8859-1?Q?eU5q4ywUeq++9vWHTAIXWtH8Fn530YEcHBoNwApdSTlXaPnriA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?b58TvYfLJm4Vkb+wcQB+L3VsLbQKzK/psN4RU4OCl8gvot3INj38O4qrCc?=
 =?iso-8859-1?Q?GpVUVzcRXNSqN8Owa2M2V3SzGaMrIXVTYeCFswh4jmPX65OMkBtacrprhH?=
 =?iso-8859-1?Q?5O/gMW2rP2ni9izt5ZjYJq8v6Wfl/+tYrGgzWYPhZ6BgJGlg+iV6PVZoGv?=
 =?iso-8859-1?Q?R24z3aR8Fmg623AATdAU33hJQCI+8mlqJjPVKQ9pgrlNcDkK36xSpg5mpZ?=
 =?iso-8859-1?Q?bqLl8kc+lPQk4M+g2QKpXBoUoii6O1FxyjxiTDPz9oIBpQM1NBrMUKOXcV?=
 =?iso-8859-1?Q?KfLFnDowxF5kXWgJuDMZPG6fkzMM/GKlA6b5NBB07ZXy7Af7dosglEvwCV?=
 =?iso-8859-1?Q?234zrxUeRb9+9NxqUepdtkC6OkOpjGMwJbexBtD2TuEEUKjOgvVsdCKtw8?=
 =?iso-8859-1?Q?kijkb9mOsCnFDGGi9Z7DpsChqQvsfAdcczLZNOKLpcyL9OV4XngIEPT6It?=
 =?iso-8859-1?Q?rRAo0GDAi0zYpBSeos1buFxyWGyXTMKoKAhqHMa0XoRJ9hLw+Pn1pVe/mQ?=
 =?iso-8859-1?Q?K61zyK7Xe9a57M1HHPwKHYLRj9qwVOPeK5AFtlUFuumdJT6T3mScmF0Z4x?=
 =?iso-8859-1?Q?i/1Mc7RUtrXB7fxhaC7AXPQ7DvMiO8YSXFzLybRRL+REmGdVkq7/pUVCks?=
 =?iso-8859-1?Q?fNI7clu45VIc99AivB6R9aP31NeWBg+Qa9KD8vqn+ihtE8C6q4mctC47By?=
 =?iso-8859-1?Q?vbeMBKE958pJ2aQVB4tspGL8t4XzSny7OgH4UrDg9+4C3otjXhB8osKVfG?=
 =?iso-8859-1?Q?C6ynxgVgHLSnbwNOjjCzG/9b1tpkp4bAgreAJ6WQusIwb8/CJzbvJAia+d?=
 =?iso-8859-1?Q?412mUd3rFl2OeVHksGeM3C6wHzTE7z2xmoPmwE+hlZH65VnBYxBCM68lcg?=
 =?iso-8859-1?Q?Kvt7Em98zW92bU5eXYE+2wSsOWJ+TkGHj3viriZnPD3VOBF616RxR2zlzG?=
 =?iso-8859-1?Q?GqKN174zO5KPAffbcWQ+ObtM2b6iZVl2JqPrFBxiJxjDzBqMakTZOqCkyD?=
 =?iso-8859-1?Q?SrOJpV4n2lMRHr2KBCX3Tiht6wTjVTxQmhtskp45Cl2SqEWB0nnVbBJQb5?=
 =?iso-8859-1?Q?YJ1FqgHLAjI54p4MustaOvopyj6dfdDxV+7Tp957aNvtO8xbD4g5K02/tw?=
 =?iso-8859-1?Q?QqBniBFPZIUcbtxRSx2yy9cZiBFrh+t3/aG25HvTjTy5VciB66E8qHpzku?=
 =?iso-8859-1?Q?nAI9M3aQDPCUWwTuYC3W/iWla6ihAcFk5B6uEkkNrT8PiL9/Ww+F9o55GG?=
 =?iso-8859-1?Q?iH4sDR95abjwMghcCtK/ZUEJS1PMFpt5EWmkioHoOtY72mtCemwL16FFG9?=
 =?iso-8859-1?Q?diClzu3i41+8aNhopFTYihlOxXty64LjMOh8F4X2OgJdcdY2rAbt+4hCia?=
 =?iso-8859-1?Q?FaAJ8qVSchLm74nS/yNC/28/HvA1dsnkFBJv4Pjc5Xgbt8/23eMhTI73GK?=
 =?iso-8859-1?Q?jT8Yy5w5UtQdRyf30zckz74JxmbTSeZ6XNEW3l1k9I+jQIxuOEVeQt4rot?=
 =?iso-8859-1?Q?X4nV0seIIwtm6zph7OQ95VfjmbUm8fe0M693e1ewYA/BhcZC4KOspoL8jt?=
 =?iso-8859-1?Q?isJmeXzilP4aLZtBRIeIR194XRvc7O66BUxsITB7mWl1EsVOCikxEx6oaQ?=
 =?iso-8859-1?Q?75Qn8EvTiZQ1c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a8f1b0-637b-4af7-2a2c-08de1395b8f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2025 07:11:30.7002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTZ+PY+EgqZJJtd9eP0uHiJ/jCaYWR8Ey8yK2ZUKlKEmLOZesUtfoGx5vkBkUGojUhDQj2RzcKPu2kFuwYOnEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9550


> From: Bui Quang Minh <minhquangbui99@gmail.com>
> Sent: 24 October 2025 08:37 PM
>=20
> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length for=
 big
> packets"), when guest gso is off, the allocated size for big packets is n=
ot
> MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
> number of allocated frags for big packets is stored in vi-
> >big_packets_num_skbfrags.
>=20
> Because the host announced buffer length can be malicious (e.g. the host
> vhost_net driver's get_rx_bufs is modified to announce incorrect length),=
 we
> need a check in virtio_net receive path. Currently, the check is not adap=
ted to
> the new change which can lead to NULL page pointer dereference in the bel=
ow
> while loop when receiving length that is larger than the allocated one.
>=20
This looks wrong.
A device DMAed N bytes, and it reports N + M bytes in the completion?
Such devices should be fixed.

If driver allocated X bytes, and device copied X + Y bytes on receive packe=
t, it will crash the driver host anyway.

The fixes tag in this patch is incorrect because this is not a driver bug.
It is just adding resiliency in driver for broken device. So driver cannot =
have fixes tag here.

> This commit fixes the received length check corresponding to the new chan=
ge.
>=20
> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big
> packets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> Changes in v5:
> - Move the length check to receive_big
> - Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-
> minhquangbui99@gmail.com/
> Changes in v4:
> - Remove unrelated changes, add more comments
> - Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-
> minhquangbui99@gmail.com/
> Changes in v3:
> - Convert BUG_ON to WARN_ON_ONCE
> - Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-
> minhquangbui99@gmail.com/
> Changes in v2:
> - Remove incorrect give_pages call
> - Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-
> minhquangbui99@gmail.com/
> ---
>  drivers/net/virtio_net.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> a757cbcab87f..2c3f544add5e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct
> virtnet_info *vi,
>  		goto ok;
>  	}
>=20
> -	/*
> -	 * Verify that we can indeed put this data into a skb.
> -	 * This is here to handle cases when the device erroneously
> -	 * tries to receive more than is possible. This is usually
> -	 * the case of a broken device.
> -	 */
> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> -		net_dbg_ratelimited("%s: too much data\n", skb->dev-
> >name);
> -		dev_kfree_skb(skb);
> -		return NULL;
> -	}
>  	BUG_ON(offset >=3D PAGE_SIZE);
>  	while (len) {
>  		unsigned int frag_size =3D min((unsigned)PAGE_SIZE - offset,
> len); @@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct
> net_device *dev,
>  				   struct virtnet_rq_stats *stats)
>  {
>  	struct page *page =3D buf;
> -	struct sk_buff *skb =3D
> -		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
> +	struct sk_buff *skb;
> +
> +	/* Make sure that len does not exceed the allocated size in
> +	 * add_recvbuf_big.
> +	 */
> +	if (unlikely(len > vi->big_packets_num_skbfrags * PAGE_SIZE)) {
> +		pr_debug("%s: rx error: len %u exceeds allocate size %lu\n",
> +			 dev->name, len,
> +			 vi->big_packets_num_skbfrags * PAGE_SIZE);
> +		goto err;
> +	}
>=20
> +	skb =3D page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
>  	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>  	if (unlikely(!skb))
>  		goto err;
> --
> 2.43.0


