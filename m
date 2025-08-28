Return-Path: <stable+bounces-176563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFDFB393BA
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 08:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F620206F15
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 06:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B219B20551C;
	Thu, 28 Aug 2025 06:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hojCC/Yq"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245F71CAB3
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362257; cv=fail; b=VXfMWETRtHIGzYEphx9hXx3VFJCYlHCjrqxBSXri5SalgGHOGc3Z0i3DDj700/g7fWUxHoC7bzJ7EJGSEZGXmia+4uZHhgOs1jPPmfv86kz0fo8y7ln+8YN+FUcDTyR6dIn/qZINtRohyK5Z04uhzLh8GDP5w+SkS+hojLxm+Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362257; c=relaxed/simple;
	bh=AVdO05053Moq1ZVU01LZpSAlb4MMjoEQQf+91MqQnGA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OzmlsasyIZNn3uZUkjSCfAIhFgrC2Bciqe1pgimzJkEYefpPjjWST747RTwo1k63PNhe59r8MkM3tz/XMAeCIS+53Vfvna/bo6Mwe1cT/JSeFZwg3fKBsYHtOJzIdfRhicxVMvVfa7qpUWz54LWqVciH2GWBWyY8nVPujiSnHOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hojCC/Yq; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYgF7/I3tzY19pebmJ2H0KAQmMICi7TWLZewUAvDohY3Gq7IAvDuPfMghgjnqo/90pSoahDrg7KPhmk6Bjj5idU5YKcUDaFtTFd5OJc+SfRAZ6c4i3DV+dKnccX35UdW/tWZ9odpxczTmKUWqP8suQHImI6BF+VMmAhF76rnnCRGtycxem/S4nKcfo1J/4gwxLaT7Fqx9wcE36S2XEX2o5nx977Xz1oUbjs1Ij2oYecWzJuyo5RHWZnM3weNdxiO7RTWKNx7jNPaLS9/uwQMZ9tYw32SpHEEifKKDDURozDupq9mbpwjx5mSFJzfQhXJQAHA/w43WoP15fVPT4thMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TxADPBmuNz3jV0sUnmMMLGnX+cruKRkl7RJiC+wVyY=;
 b=A+jY0Ajiym5v2jtRztia5KovNJ0GLcuhIl8m1Ub5mKlgRDUk+h+Efs07j7ZsWP2PIUhKxcbtFOxX5Zej9gOVEw7tSuThyO2sDlZ2q1kJqFOPv1AsG0ajHOePSBkQIKCLvYruotaTUIqMHZpwB+e1Y7R+1R73vJgkh7tpW7Q3edmTSCf8FIrSp5G1FT71OUPchlmX02ssUNGzOMQUNnzK/BdP8ds//lU3fTV9YVVFs3zr+aB0Klj6mkFBzMScfGZoj6wU2QSLbGvH8vg0T88O8f0uigWG6W/b6DVWlsYYOfRviSFwy5wq71W66s5GEBfxMPFelNjlmIjvtvbyAURO2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TxADPBmuNz3jV0sUnmMMLGnX+cruKRkl7RJiC+wVyY=;
 b=hojCC/YqiDeXP0A9XBXXJZIDVk9uxLxCBy6HIN3ZQe4eAsijWcB0LPjXu/Sapi1UAhDOrple+QswYzR2L6xEBC4q+UDX3MmDftPM2beF4htYUAU+itKwvN1XUlx9nyusupyWu9hAi7JjSDr/UfQ/TTn78ipZb3PKaNNzuAjOqQyFinnIre27ckVKHb3b+w+90oD6/c+nJpiKsN1q2o7PHfPl1gzvC4AWxUUsuGRvDPMLSRqmiqc/ulrsJbBu1omZhIZx8wjiQwGHFuJRaU2ziMhP5cTaS0VAcqhWlNC9F5EH9wjd2f/LONNOOPumv5HLCYcr7XkdrCjlG7Gzn/FThQ==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 06:24:12 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 06:24:12 +0000
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
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
 AQHcE0XKqVbu8cWtaUCLZj1LjgeTGbRudpsAgAAWuWCAABaPAIAADA7wgAADewCAAmIWsIAAy/cAgANp/uCAAQYPgIAAFMmAgAEqTRA=
Date: Thu, 28 Aug 2025 06:24:12 +0000
Message-ID:
 <CY8PR12MB7195FD9F90C45CC2B17A4776DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250822091706.21170-1-parav@nvidia.com>
 <20250822060839-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195292684E62FD44B3ADFF9DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090249-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095225-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102947-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71956B4FDE7C4A2DA4304D0CDC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061537-mutt-send-email-mst@kernel.org> <87frdddmni.fsf@redhat.com>
In-Reply-To: <87frdddmni.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DS7PR12MB6070:EE_
x-ms-office365-filtering-correlation-id: d32690d3-8e95-4612-6bb2-08dde5fb8137
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NSEvQ6CBySWugI9aBL8mzGoEgezcdPjQlcmdrTM8U5Uqhm6YlvwmAEEBtBjx?=
 =?us-ascii?Q?gb8FoweGdZneM1Hh7rjg4InpkX6YNdmPomtQuR4fu/mt2/LdMdwjyMLKiPrF?=
 =?us-ascii?Q?dy/aH7Piu8iFIVgFCjrUsGPzXyMbCw5bY74TC/b+dDqDKPzRsX2blgcwsl6M?=
 =?us-ascii?Q?SMtCxa3t/BchO9IwQ5MGpjDbf59DhVWW0bfEPUwryBIJv0hUZpXrBcZUgjIB?=
 =?us-ascii?Q?KVGSoUwgZQnfp3UK9VM/XvPmk/oOV1fgnrsYTC+L7+FSZltwTnUiakxOma02?=
 =?us-ascii?Q?7PiPDSZdIkNZ2ER6VsRCimIVq0CsC3eaVE1s/9RoQmVn8Veu1Hi0ZFTkenrq?=
 =?us-ascii?Q?Rd9PpQUhsPt/Vq/raGZIVVLXuXwnzOOIKYFGouiPKnbCQKWDEDZ0vqSedreR?=
 =?us-ascii?Q?L3cYMWTxRBqAuvxjFPeXquSl/v3poYkycudIuqu6OrfjtMD5iLQK0DcA3ABr?=
 =?us-ascii?Q?lEwGtTeoddZGdC92mzqITokskTURY/uAUuIy2+mNl0Lks1RvQy37k6Yqj+Ke?=
 =?us-ascii?Q?Qqum4HuTmEDMld9BVWiFLLYQidYziHuZM8wHW83pySk33BJAZUyS2eEbhWZH?=
 =?us-ascii?Q?jMtXldiB1gvkcfw6RgoDV7eetQ1h0AuCMrh4iQ5A8Kk95zCgsS5bO+Pz+uaE?=
 =?us-ascii?Q?Jy6H+LDgjw34ZQUQbaT5rl+JL/+YErGCRdUwBjxoG5Nh2HpvJJGRZNaSNQiz?=
 =?us-ascii?Q?g1mwltFGDmZd5iLL3zLjeaW9QX7SqOdypEhAXr7biIXpBUH8OYtDMetxJ01o?=
 =?us-ascii?Q?ms3HBbUCkmhFwVwVCcrJHhSJ5waDdQOMHOSl9ik66d1NwLdp3sR9zaEKIKfj?=
 =?us-ascii?Q?dScHHawIBvg8zyLBzkWzHbJAhe+UTciO+XIaH9j3SZyKCuI9Mr9PWEbTOAIc?=
 =?us-ascii?Q?bA6jVwybs0WOkjPYKDWZ/e5O6M98zsxYjwTPDcGXr9kRbGOMWB8dF2vx6swn?=
 =?us-ascii?Q?5YLGoY2yj2ey9G7lPqmfWjFKTeDFOwE3KXUg3DJ0Cx5jvsmlBrHbMNEo7YJn?=
 =?us-ascii?Q?q/58uk3OcxVKRxal23OlGCiOU7ex1Vk1N9mg8jskLgbE7B0czXuvxeuUEMdi?=
 =?us-ascii?Q?K8VtM+iTwPtQaesSaEFGNG+O+zIMdfHXeRkArEy1beKxmdJNuM0DpfVXG8Je?=
 =?us-ascii?Q?dQ4OZJEv609JFKAEMisoG0Vo/LW1q3d9ooumnejh2OBXKFUsxfiI1KCXN13l?=
 =?us-ascii?Q?xb4FUZZhzKVDsTsiwuPm2Jxn8LycGl2P/G5Lsx/LIZL8BahGjvvVG7NT1aFS?=
 =?us-ascii?Q?OiHteRQgmoV525ByAL1xb1tpfj3LaT43Z8kQMOAiBxkhAy5OCHtKJGJNqe0d?=
 =?us-ascii?Q?HyapP+3sYDfERcY44njCGwwPwUBDP5VS/EEcA1EZRjt0POog81aoijC4881D?=
 =?us-ascii?Q?Jo5g6QQbZqG/axgho0iT0QVeQkKZIGdsPmRqw3TWTGev7E8IFrTqxv/jAd8W?=
 =?us-ascii?Q?UqVhpYYGtvCm4d5vsTKJmRgx2WGaSa+hTAjLygc3fuAlm8NcIRh+ew=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Wy8DcOh/oIT1RVoS7LKHgZJXwjD2aZqlAr/MTp0YNU4mKzVTcZiC0El0aj/z?=
 =?us-ascii?Q?4uOEYR8JNuF3AM9Lc1LCDV9VRpmi6SwoSLBjwzDaqzpx0RfDXFi6dRZFH444?=
 =?us-ascii?Q?Sbn9yMx1Lxnkc4MO0VPTkJLEClASvdXwRKepLAeO59pdR3GKMiPXEIy5mMmw?=
 =?us-ascii?Q?KWYaNnSJbA7f9KJohcbnI9kuq50POrlexBHJ5k4i8t5/Qh6aV8O9YmvuhEao?=
 =?us-ascii?Q?6eWEzKhBEHSlWX7Fm8KybvGYhuBPDiUyvy2NG/AjW6pn7jSof9Ioy8rDCGRy?=
 =?us-ascii?Q?NjMz89pgPnDe3T1/C3fpaViUYR14QpagL0MnuNP8y/CS2ewOPv82mcSf1IP0?=
 =?us-ascii?Q?7xSoSucP1o3M9MVhQKYOQTfOuNVZVCM2ogaKHDPz7YWLkB89Iqf1YUFwHOlW?=
 =?us-ascii?Q?8cvf6OYJP/uSa8neY2WO3+hul2X6knrIafnSTLRsRcK3X2e48PYBzra3Az/Q?=
 =?us-ascii?Q?g02B0YZlJTdWZb72QaFQyQLho2ja2CJGozFcdFMSRh+yORT3QJ4LGwgP1vDR?=
 =?us-ascii?Q?oajgm+5Nnb2hbnFq+q7LuKxDdS3BGWGX0Wdb26QlJFcL66GCfInpUcCFKu+I?=
 =?us-ascii?Q?Gfq9BPcMIH3VQMYZF8yPa0Z4DXiaTFoxHA3WrOOwkzpkA9ifzohTxHe23wcI?=
 =?us-ascii?Q?U+HA2WYa/TEIZ1XTcnYWLUEIOnu1d7O/YeAyUI6gu3XE0vr4jCz0c1JXHqLk?=
 =?us-ascii?Q?OTeWEVj2DVyqqYU+Yzsq5HwivWd/OkGlq2JoV1XTgYDBaY+8lLOCtHwYMdpL?=
 =?us-ascii?Q?1R50MixWA+kgZv8C/oYxDqA/TECvsQAiXLKTxbgr+qr08YWuyusEQGghU2OU?=
 =?us-ascii?Q?+4UUQC6035z7Fo6VQEyKDJrZfoAfkv42N8KJXphQgKWbSkCTASNyn+AfQU88?=
 =?us-ascii?Q?EYb7mbWWvuucKBX9CRjMKjAASBR+o5SI8Qp5ULMHukGKstjI3OOdW7zzZ/0Q?=
 =?us-ascii?Q?HcOA6UuSYR0cToRXTj9igtflmnTmz2dDRJ+pgEPhmcqZ+6T0J9LZUgLvoZ/5?=
 =?us-ascii?Q?QFzD2SMQPPqteoae5ASRNcZu+SeerXe7CyCLAONRvj3t1wAQsoEOnkFgKKHz?=
 =?us-ascii?Q?gzFfAQgB2nPXHoz7rUItS2LRiG6ftl2DW7hnIrCdQeKoAHEESNIkAXIljz3l?=
 =?us-ascii?Q?jCvGm0QqcIDzeF9ZlDu9+MEVQ5MKYehpRUdibQ5MizxYOC18zTq1KcRWEamF?=
 =?us-ascii?Q?yHip7AE+0gMrl+J9a2fmTrsptTqAVZ+XSMpq5JkC92m230N8zexmdbvmeBf3?=
 =?us-ascii?Q?LJQ7DyZhAtcWtqOpzs1+oZUKAFAEIhJ/QKB/NnyAmdrPCe/2/jKBkvra165b?=
 =?us-ascii?Q?ujC2XGGoNeaiBIOj3dxCPx2VBREZ1KLy5RmC/M35qyCC50tay+kCQYVBy7cR?=
 =?us-ascii?Q?8vs69e/nucB1CEbHe8zi3cYUpnqDwp7+OQXkN/Tgx0xMrE9JMnKRuqZ83w30?=
 =?us-ascii?Q?0VmFECWQCB9GlewDBYDk25AC95emJT6cCC6aTWwYXqDHIcQ+7FpMn3Q6Cq4/?=
 =?us-ascii?Q?7d0M5yq7GXAMhMNdNAAx3/a0wvatFDHIkqQXyhVxCM89yxfPul441oMNLunB?=
 =?us-ascii?Q?29WFFiT7cUMVnlTQGYI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d32690d3-8e95-4612-6bb2-08dde5fb8137
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 06:24:12.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q1ZL4XnfWMZuu5aN8vNg4mc+LQAne05/4luQvLDbqvVNuFtvRusN48MZGCbiz7pKItJ5y1HKeaePoSnn6BTVfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: 27 August 2025 05:04 PM
>=20
> On Wed, Aug 27 2025, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Tue, Aug 26, 2025 at 06:52:03PM +0000, Parav Pandit wrote:
> >> > What I do not understand, is what good does the revert do. Sorry.
> >> >
> >> Let me explain.
> >> It prevents the issue of vblk requests being stuck due to broken VQ.
> >> It prevents the vnet driver start_xmit() to be not stuck on skb comple=
tions.
> >
> > This is the part I don't get.  In what scenario, before 43bb40c5b9265
> > start_xmit is not stuck, but after 43bb40c5b9265 it is stuck?
> >
> > Once the device is gone, it is not using any buffers at all.
>=20
> What I also don't understand: virtio-ccw does exactly the same thing
> (virtio_break_device(), added in 2014), and it supports surprise removal
> _only_, yet I don't remember seeing bug reports?

I suspect that stress testing may not have happened for ccw with active vbl=
k Ios and outstanding transmit pkt and cvq commands.
Hard to say as we don't have ccw hw or systems.

