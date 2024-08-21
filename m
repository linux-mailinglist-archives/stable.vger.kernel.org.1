Return-Path: <stable+bounces-69831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B81D95A230
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 18:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422F4289C5C
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 16:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085711B2EC6;
	Wed, 21 Aug 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5o0XcsqF"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA28214E2D7;
	Wed, 21 Aug 2024 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255821; cv=fail; b=QTBinLSLrBF0jmDNKa9nVqCiW4qpLmk9QBkJsJto/GcApHf/JBk4vGosDbGfJKHh2hXmW2sKmv8TV+Rzn1UlqasT6f2d36dA01IWWHQ2tQ5iD1fiVb5qo6mh3dbT8NR401rRnuVYQepZH02aRFJwcFSWzFv5GzIPRYFdrSO1HDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255821; c=relaxed/simple;
	bh=czAI0o8k97kTofZwY3roV51yAAradOoi6J6O4H+c3c0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gdjdcamI021u9Ny6NspmJmw1Z1cnkZUBtPf1Cg+fkj5NjEFQvhl5df3tAheHkGBC5EUe3ez2PFhiu+TNGJM7yzsm/zrZsfEXIjpLxXocLpIWZxH0Q2G/RvdaBaUeggXG2uWtG6n6Ba6oZDV27bKxc7S9obbk5T/n4dj+NnYYyIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5o0XcsqF; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4smo4O0d8KxNLOch9qzpljFUd7ik1QV2IA/tzGTJJRSedIOJ+SV7NRkyGbmwY4Bsq9jmjzGmcJlFVxRvV+JiwahxYopg7fetQQ1FIDB4vRq/XlQrGPq1OJKx+2Nz9W49jufkOgTe14qGXXh3519THDzqHJ31ZWM0wrsy7taNqz1R9jxdpyIB2056RsK5MQjUIsIhTs8h9c4H8ae5xuVGgwEaBxOfIYTAhIGMQuJXmAhdOyAHbvIdj8NWazxmuComl0l5LSJGJPvKkZjnyXBhaxlkfZQaX3iXb1Ja7q48+ccWu+UE5J1JXjAs0vd/4J5OS3cAoJ2OjN44orAHOdTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7QMfkQ9f+1W0/huDK/y1DV0uPjwb5ycEEOxlGP+pos=;
 b=V9dzurpbhzruzvCdBK3S8VLmknCmleDA9I+sgbo5PtDNfT0TMG3trNQ/3Zo94o1bK56WszsoSTmxXZOJrZ+1L66RydoQiWMVaqf5unAhWoNS6/Ol8lsndpZvsX7sQWhTGXBbbSJokYCALnlLDahgH2kBLwx2eOKAhkglpqvibGMWOtAgmPY3cpCx71ljXF6g58qjha6zun1PD3zzC2y5pNqrw4tQdjX0zNYI57Zu1Wp3k0dY7BzI4kUfZfTIppQRIh7Z5K0eSlyka5Xfc5D/6pTC1YTFQZXfBWnVoygoTkncwFCpYG+4sYXkOci8554JPgFt9LC2LnWegtKpSBHsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7QMfkQ9f+1W0/huDK/y1DV0uPjwb5ycEEOxlGP+pos=;
 b=5o0XcsqF2FPl0YJN3KsX39YHI8MDKAecsORY6uw1INMzOIRXcpjVCDuK5vrZ0/Ds46INvU+Fe+mtg44LtYwA863MXOegOQc4H0otvF+wpfbxXZW+OGO7qXV3YU5aDXLjSBEQE10FP2qRJ3LpNneHs2S8adDxdbWhM9Zu8ybAz5A=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 15:56:53 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 15:56:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>, "Xiao,
 Jack" <Jack.Xiao@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui"
	<Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>
Subject: RE: Patch "drm/amdgpu/gfx11: need acquire mutex before access
 CP_VMID_RESET v2" has been added to the 6.6-stable tree
Thread-Topic: Patch "drm/amdgpu/gfx11: need acquire mutex before access
 CP_VMID_RESET v2" has been added to the 6.6-stable tree
Thread-Index: AQHa886w/6UqDwuXpUiLF0oq8CwP6bIx3YkA
Date: Wed, 21 Aug 2024 15:56:53 +0000
Message-ID:
 <BL1PR12MB51448BBFAAEAF8FE20E33B61F78E2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240821133314.1666552-1-sashal@kernel.org>
In-Reply-To: <20240821133314.1666552-1-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=d028e477-dbb4-46f8-979b-cb1e9c460759;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-21T15:55:52Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BY5PR12MB4306:EE_
x-ms-office365-filtering-correlation-id: a994a3e6-ada4-4eb5-fbb6-08dcc1f9e06c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?44H33iTXqM3S87HWKeQqf5zINGhPeQliRmwBNNaAqZh+tZfY+9jO1s1GxQsl?=
 =?us-ascii?Q?TyvN8RbNAFVZ4f12GjKNqhFVNsDKSkIgROmotlZD/zXSo8C1QxV4k/dWzm0g?=
 =?us-ascii?Q?alNgjvonvGCfaXGj4+rWAVmLqGKCYXdVutH8g6rIlWCgQNDI9s/aDoZ1k8SK?=
 =?us-ascii?Q?76NCM5zhYPnSfKIEC+0k0oo3Vb86F/n3Uf33WrqHwTfKC1ay+oFI8p+bnh7j?=
 =?us-ascii?Q?ja3JG6Lq6+JH+urMGoN/UkwdK+4pIqNmu+Wugz7rPI/ehxBBWVmNk8ChecJK?=
 =?us-ascii?Q?w+2MIeXimTXKBXoFL+kYQkGNtuOhs9qyOsTLRJEiQ42o6xFyRjVmlRWWob7K?=
 =?us-ascii?Q?yd1nfWi4EzOG8hSn3Z5Ts8ygyfi/ECS+rewZ44mYssl/mgQzomePjQbNWDUz?=
 =?us-ascii?Q?qo+Tempy+cS1M0Ir6IZjQAc2OqObpj5IvZTrQiisZJbS44An9AVmdg3iOlW4?=
 =?us-ascii?Q?zAQF1L/XR1Vo1e60lh3IZAfGP0TyoHxx+Jts/E2ubzV6xQ1NQ2tFfJX7NSRr?=
 =?us-ascii?Q?1mu3YB9+XR2ZdsJIMzr9QXB03D1fuEE81cXrsBTGT250XMqQnz8oTv/gT+fv?=
 =?us-ascii?Q?+I74k6J1tv+SSk0bfpw6EK5S9xJYtcu9ZYw32esDS2wWSufTCHVJjKzpmZUm?=
 =?us-ascii?Q?zvgLnVIEWCVVpjLIHDTqpwhGaewnX5kVxfesd0sq6C6WmRCnDaCtgPMGZ6lQ?=
 =?us-ascii?Q?LxY/WxCtyTuTci9+NS2Gt9nm8ivxMaXQdnVl0R1/era0KK/Uv5X+qASnb2eR?=
 =?us-ascii?Q?JnVVd+DsLvY+wbpYwmKWF7/DqUA17jX8im80nXd5oM4FdxQ3e/HJ6K7212FO?=
 =?us-ascii?Q?2J5fCh5A1c+EAMMKwlxXXLngFBACOhwRChVoBl+Bb+PFsGk/a2IuQOPYZBLH?=
 =?us-ascii?Q?dtqBGMKVwtGyZ2VLrWuPZctmj8BNIHUWSe4f4TIH1Pu/piCgVI5Xpp7/a4Cl?=
 =?us-ascii?Q?jB4rui0h4GroDtYnakrX6RTE0rZhms0LFZEKJ2ZgCV9MDe3JT/AFK5A0NKY8?=
 =?us-ascii?Q?t5tSZEZCWAFWdAsj+TA8ah6zf8ST+cNlpYxT6QXbzZjY3IfXD1yNQhkuopgq?=
 =?us-ascii?Q?ZjbssoktkfN3yL1CbUhf+eUEm88NkFcKUl7il3KfsV/kq6UmyprwbgUyBeN8?=
 =?us-ascii?Q?h1io/0JBL2mDPX1HVXcrOyyrASFXBHJudzH8009eImGhaWTo3UE+na1CgZru?=
 =?us-ascii?Q?xEMMAG0NKWC/B44xDsCR8trfcyT4qZFk1h0yZAQbmWQf1AOeT0WBN07QX0sA?=
 =?us-ascii?Q?9irmXGOILhytjbbquUsR2iTig5u/7TrbHpjCtz+FcIyTPdaCLRWqhOwMKamy?=
 =?us-ascii?Q?fIo67yWAC7Z71bpD0BkrCmmc7KiSg+5cqerlndJB49NYVLEGantSJcLdvk3t?=
 =?us-ascii?Q?IpUCceY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mvBcrtul3uKKeM/fosQoPbGLAC8ixbEONeE2gzfz5s61KGaeVfqaIsCdMygj?=
 =?us-ascii?Q?f1W93S9hhiGcBmwxWapH6gOp127rZRHyR6sNAWmqZWSADcXn9VayXLddjC7N?=
 =?us-ascii?Q?Al+ukRzN+o7+EF/rp9qaBPgWda8P05JPeMdxyKpKr9jVzRRCqKT0++5HKwHa?=
 =?us-ascii?Q?I63hQeDo0XQ37CAlgwG6MGa+P5qqo+YOvKAFBGMRleqnoJm56lV1I6KQv8n5?=
 =?us-ascii?Q?JcrAghcUGtuaSPf4GkOu94LTRTEOvxED2lt6s2fmhbUjkHX2Sx7HarzkfHGY?=
 =?us-ascii?Q?0TWxcK8GaUpOmo12cQxIUkPx2WqpyA/wymYJh0oWrO3alQVWpx20TX7sLLMG?=
 =?us-ascii?Q?FRiVB0tjBERYj6zjXM/XTJRaszuFFrTtz5ujUKlivB46kAU8Hk7ony8ZMLVH?=
 =?us-ascii?Q?/ajG0so5qYqSr20p5j3eq7Szm/33cFBehxgr7E6vMyawrt0itG7pZtEGzGcz?=
 =?us-ascii?Q?axhxlpIRtCFIWilJz3y0hNJicKjF8T0oaMxjZcIq69R19ldNdH4Eks+rgg8Q?=
 =?us-ascii?Q?3t90vYq8BCkPc1oMrahkK0anqVM/yQDfHYIY98pzqGTy9/3l85L08oKyHw0o?=
 =?us-ascii?Q?8gbgUO7NPbi5SH2+gPON61ALgHgiUV2Jb46n/9cUdN2LCUV0tTFRyUSFXwbT?=
 =?us-ascii?Q?S86JnrBf7lyf8bqG7n0NoL+M6xPAcUUihi8FXyTe7WAqdM3LCG7UFguY9ppB?=
 =?us-ascii?Q?9zb+vPJ0cGKPryGbP3xw7ZMHeLfSh41ZgTxDWayRDz2pTaJNrcR7gZmiRdmw?=
 =?us-ascii?Q?omLtRSnAg/zwCbuSfcrieEWbvxg2/639OgtPqK/jhk9xD5jrcvL8dMgv3PMC?=
 =?us-ascii?Q?n8fvRwNxdb5tdxSxohXk06kApI2olsRGmyfzbkMM7H8L09yxJSocun3tSgKR?=
 =?us-ascii?Q?2Yfzx4JtgRSUYV52KRVgNWxX/o2Cg05GBoSX4/WpF/00dAgyE4eBnuYOy/YQ?=
 =?us-ascii?Q?doW8WQ+7BEXqtPp1ve85RR4cCnIDQeKAFIyNBfDAbsoAbeE7Lh2Jg7FOFzEP?=
 =?us-ascii?Q?4z62Hs2HlFdRRd9EVAQgOpSC7cOrCoorhF3vCgTc8HRAhzdq4knvjb9mDXo1?=
 =?us-ascii?Q?FjHw0itJzPW4EdfKKUFoZU1qeLEpPPdSBBIMnMbbDJsXsQk4zpGtmKIOM+KQ?=
 =?us-ascii?Q?bs7PAHF0NyJkbvGwRXr7RyjEVkjidbFHzzSHT6u/7d/rqXgflHCpnhbk0ZdG?=
 =?us-ascii?Q?NF+EwEdiXLc1teWVwM5kD85pefP+r2krf8B+Wg5oGxmc+BJOzVoyURUoHW86?=
 =?us-ascii?Q?zfqMcafeFbK1KqTG6w3F3ZUJEW+wzLQOtW2lkTmn2czmDJz+VPX9CGHOpTOu?=
 =?us-ascii?Q?rrjvCB5PUAxVWHt2ttmiWU0ZVyib1502ppmgE5tNRAMx0jdDDX2mBdtRyfam?=
 =?us-ascii?Q?vZpLGj48e9TTbQ05y0iLc5T01qBoOT0P3xwKQ+fok7rlEUFOIg8i7DCAL6UM?=
 =?us-ascii?Q?3iewDg5ZeZqZm9iuwZlFqMtSpgjBwg5zLOsg2dS6WU4cZR9SZ55HRhQ/OtJz?=
 =?us-ascii?Q?st/VgayiOjEWrxrSTmY3ykaNNn1u1vowN5wKoVC+F8kylZdvzgjlC7QLximU?=
 =?us-ascii?Q?6BxpwAuKwpwcZI2r3Yc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a994a3e6-ada4-4eb5-fbb6-08dcc1f9e06c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 15:56:53.5630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7LcSNKXHwcd8E884I8nCudwMtu48BbQmb7dDQmCEkKvzqOzjC8VW7y41SpbLODcP3F9ldeZRA3Sw9LRuGkiqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306

[Public]

> -----Original Message-----
> From: Sasha Levin <sashal@kernel.org>
> Sent: Wednesday, August 21, 2024 9:33 AM
> To: stable-commits@vger.kernel.org; Xiao, Jack <Jack.Xiao@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>
> Subject: Patch "drm/amdgpu/gfx11: need acquire mutex before access
> CP_VMID_RESET v2" has been added to the 6.6-stable tree
>
> This is a note to let you know that I've just added the patch titled
>
>     drm/amdgpu/gfx11: need acquire mutex before access CP_VMID_RESET v2
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-
> queue.git;a=3Dsummary
>
> The filename of the patch is:
>      drm-amdgpu-gfx11-need-acquire-mutex-before-access-cp.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree, =
please let
> <stable@vger.kernel.org> know about it.
>

This patch is not stable material.  Please drop for stable.

Thanks,

Alex

>
>
> commit 72516630230bee2668c491fdafcac27c565a5ad5
> Author: Jack Xiao <Jack.Xiao@amd.com>
> Date:   Tue Dec 19 17:10:34 2023 +0800
>
>     drm/amdgpu/gfx11: need acquire mutex before access CP_VMID_RESET v2
>
>     [ Upstream commit 4b5c5f5ad38b9435518730cc7f8f1e8de9c5cb2f ]
>
>     It's required to take the gfx mutex before access to CP_VMID_RESET,
>     for there is a race condition with CP firmware to write the register.
>
>     v2: add extra code to ensure the mutex releasing is successful.
>
>     Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
>     Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index c81e98f0d17ff..17a09e96b30fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4430,11 +4430,43 @@ static int gfx_v11_0_wait_for_idle(void *handle)
>       return -ETIMEDOUT;
>  }
>
> +static int gfx_v11_0_request_gfx_index_mutex(struct amdgpu_device *adev,
> +                                          int req)
> +{
> +     u32 i, tmp, val;
> +
> +     for (i =3D 0; i < adev->usec_timeout; i++) {
> +             /* Request with MeId=3D2, PipeId=3D0 */
> +             tmp =3D REG_SET_FIELD(0, CP_GFX_INDEX_MUTEX, REQUEST,
> req);
> +             tmp =3D REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX,
> CLIENTID, 4);
> +             WREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX, tmp);
> +
> +             val =3D RREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX);
> +             if (req) {
> +                     if (val =3D=3D tmp)
> +                             break;
> +             } else {
> +                     tmp =3D REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX,
> +                                         REQUEST, 1);
> +
> +                     /* unlocked or locked by firmware */
> +                     if (val !=3D tmp)
> +                             break;
> +             }
> +             udelay(1);
> +     }
> +
> +     if (i >=3D adev->usec_timeout)
> +             return -EINVAL;
> +
> +     return 0;
> +}
> +
>  static int gfx_v11_0_soft_reset(void *handle)  {
>       u32 grbm_soft_reset =3D 0;
>       u32 tmp;
> -     int i, j, k;
> +     int r, i, j, k;
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
>       tmp =3D RREG32_SOC15(GC, 0, regCP_INT_CNTL); @@ -4474,6
> +4506,13 @@ static int gfx_v11_0_soft_reset(void *handle)
>               }
>       }
>
> +     /* Try to acquire the gfx mutex before access to CP_VMID_RESET */
> +     r =3D gfx_v11_0_request_gfx_index_mutex(adev, 1);
> +     if (r) {
> +             DRM_ERROR("Failed to acquire the gfx mutex during soft
> reset\n");
> +             return r;
> +     }
> +
>       WREG32_SOC15(GC, 0, regCP_VMID_RESET, 0xfffffffe);
>
>       // Read CP_VMID_RESET register three times.
> @@ -4482,6 +4521,13 @@ static int gfx_v11_0_soft_reset(void *handle)
>       RREG32_SOC15(GC, 0, regCP_VMID_RESET);
>       RREG32_SOC15(GC, 0, regCP_VMID_RESET);
>
> +     /* release the gfx mutex */
> +     r =3D gfx_v11_0_request_gfx_index_mutex(adev, 0);
> +     if (r) {
> +             DRM_ERROR("Failed to release the gfx mutex during soft
> reset\n");
> +             return r;
> +     }
> +
>       for (i =3D 0; i < adev->usec_timeout; i++) {
>               if (!RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) &&
>                   !RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE))

