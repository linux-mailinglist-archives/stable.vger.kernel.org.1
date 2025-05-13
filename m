Return-Path: <stable+bounces-144097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A19AAB4A9C
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 06:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119151B421AC
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 04:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5C31DED66;
	Tue, 13 May 2025 04:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F5SZweSR"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8941C13D
	for <stable@vger.kernel.org>; Tue, 13 May 2025 04:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747111486; cv=fail; b=A+p8moDDunEP6yMJSpSRco7fGzdiQCcIVAYhMagFwHcWyjYv6wRRm3s8AJ9NCJXboNmtiY9QOjZszNquA2Icu+J3l/FNGzCLLt7F0mN6kWDb8r7xbkr0E2tRUnoOB7axNys7mUgo5N9NQfzMcnQmgoDC2DZysbzXyGNf+Pkg+P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747111486; c=relaxed/simple;
	bh=l6M8a2dh1VOA9n16QQKPuepW0sDI54AF7wt9Fs3iDBI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fdfvuutxhja4fH5Nanl0UCSSwS5CASVhBjo7Yc0fBEsWoKuvncfVADGYh3IXq3kZOpid3DVb+/RSQSCXZGcuGizdk3P3mTLPSSbiW9pdLENATGoOdFd7iO2qN4SZV/1SLZ+/nuRukA8H0tjwYNg5kvAlF00RKuPcoYgDmBLvjqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F5SZweSR; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waiogtAuFclL1JGAcpK7zyAwXehKh3ajl+f1zkedGfO1TNPP66pGdBjIIDx7HHwHbskEk/i4+1o9QYZwsMBSRe0jgp039IYxKLWqA9z77c/kSl+ETwazN/ExBkrHDM5xN5SZz0cs14iXB+oT+ExZi8o9rv/hxc+CBiIuvRL8rHukZPnUlaMo3HjuVvBfZqBmU5MJeULcThE0XCXRqylGvTC/FmQ/ugGPQ6mwLb92RUAimGdzPRqVI546NJKC5LMk+n+bEzPTq7MH4p/290vygBm3Rj0hH+GL1kM7tSjFtGtKnd18k51g8Fkdel7aLD8B5w6u24DoU5+ZAln5sc81kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXSeER0HnwzDQM3L4CbihgsYUfviUt4E+LiNaYhlE8g=;
 b=sMmss+omJMCMoQznT7UWCZJALOamRP56MfPCtKN0uOj51DMTTsJF9bX4FzRMUpl6Iu8qaXtgv5zfSfWbH1ImP0a/XS/4S+SPsjRyL3RepeYkvuAP3VB7dj/guNp3MQSliCuP3/9pY78pgJ9avK0Y3nNFbn1Zf5IhU9ZTqCHZaoR/UPPaminRiFrXFoDnWQ8nVaLzlSujTZ98VNA6waEMME5K4OPAJ2qbkV311mGnM7iypR3Gf/nnpA5oyXZxFR+fy0LaS+MlrnBB2Va1XCJMChggU36Faay9w88UUCyFNfSb3n0UMyw34fTp1kvNIAHvMTpvH1DUHSupVL67V7ywBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXSeER0HnwzDQM3L4CbihgsYUfviUt4E+LiNaYhlE8g=;
 b=F5SZweSRhWFDT43q6Onzk3qpOU374VWqaQBP1yrDVz8S2d1OySk+aeUYxC1gBfXqvrM+7sQ+f0SQcZaIcdjE9wquxt+bEDIpL+PrmhDFSYeVtzDbT8n4NOnWqncOXQw6iKrbPNV8c004IoS7sE33kF/Vbe7034rPs0rJtTsZ+GE=
Received: from CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18)
 by BN7PPF7C0ACC722.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 13 May
 2025 04:44:41 +0000
Received: from CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::5f4:a2a9:3d28:3282]) by CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::5f4:a2a9:3d28:3282%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 04:44:41 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amd/display: Avoid flooding unnecessary info messages
Thread-Topic: [PATCH] drm/amd/display: Avoid flooding unnecessary info
 messages
Thread-Index: AQHbw7UEGv6yw2TQGEqT1wCPp635EbPP+kIg
Date: Tue, 13 May 2025 04:44:41 +0000
Message-ID:
 <CO6PR12MB5489297F57E841992C1FE9E7FC96A@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20250513031311.834319-1-Wayne.Lin@amd.com>
In-Reply-To: <20250513031311.834319-1-Wayne.Lin@amd.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a2dba9aa-97cb-48b9-b68d-ee72039c70f0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-13T04:38:29Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5489:EE_|BN7PPF7C0ACC722:EE_
x-ms-office365-filtering-correlation-id: 70e0bc40-1039-4365-16e4-08dd91d8e00d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vaekhLFQpRp5ZkzozewvOoJTCw72derQPpeYQEAw0k5Kckrnpa6928PdBaxU?=
 =?us-ascii?Q?oTfsS68sBSQ13J24r75ek9UzNDfdoOBk4XX+XC7PvNAyqhaJkHBt2n/Xeco3?=
 =?us-ascii?Q?HFWYPmbLu2IVipfRAcNq2uTS9cB/QkHQJqoWTq66Flp1WwKuKG/ny3ItEU8q?=
 =?us-ascii?Q?P1OfI5c3J6g4MYCWwgm11lSEpe5HjQXI7aqFqRSYGJ2ujhkfaL+QdsO7KpZo?=
 =?us-ascii?Q?gJ6ejpO1xn4FqrAg+Xau2abYYpqXAJbhS8d4Sji2WEZZwQze2P/s8MEJoMkk?=
 =?us-ascii?Q?3mfVhAnLXtW7AOq5ONibarLezmI1Rfk9U1VfWjdW9PGkuSNy8CBNo3ENi2cT?=
 =?us-ascii?Q?UTpHB4NxCRvqZ5jIlMClvPxh48XjzTmg336MNjqKgGBMqQ/XxylfHOiwxS43?=
 =?us-ascii?Q?7nTU4DTs49lL/A2+RTc18Lu9YEMn/vikV5VQxrn3WHjuGPlYVZPO9weuqUvq?=
 =?us-ascii?Q?lXPMVrjiDZcBg4D+y1B34f19xIa7lB4sUHu6DIdH5qxwyj+bvYoEX9HE/txt?=
 =?us-ascii?Q?mf7Yns8Rg8V1+XfYlHYgnDkIQocExyK2392ze/JqmvE1cFsHVIWx3hVo2C/J?=
 =?us-ascii?Q?4Z/JIVUwkp3ylmGLcBdxsnBgxUWi0UbQ3FuXYIFhYDQybVumgZaX/jPdx15K?=
 =?us-ascii?Q?IEc351XddICpJ55MEXx/tg1ZRwJqKMuQL1J9nB9rmTQRvEQc5kBXrfRqJVf6?=
 =?us-ascii?Q?3Fp9LtFrk9H/T9zpMyBh6JYPvZnL4tvn2cOe5V3GkCdkbxBg1PFZgZhXgWu7?=
 =?us-ascii?Q?N09gh9R+63ldFjumkPi+JAwpFBzj9gk3RIMuiX0kjzmGAAYlw2rknqzr1kPi?=
 =?us-ascii?Q?1HhBaUrJMyE2KtyI0THsiIcbGgZnP2k9S0jZdj+4tViBFVsvKF3JFi7JxTMU?=
 =?us-ascii?Q?pd6fwQ3nnteGnhroEQeILBClYCt5NOLZVcz5DtVCka3IrDX2QaR70F0Vy5fU?=
 =?us-ascii?Q?ODBdNmqsqly+35daxScmBuOpgWNJjeuQk09RxqRXr8GQxf/xAtgQPmqdbXTw?=
 =?us-ascii?Q?x3E8JIrmsIpqRVn3Q/iHyUFyxRKgkvMWJGjo8ZtbZWqjtWlAMWnTztZkWp6d?=
 =?us-ascii?Q?IaOJn3gRG403eFJFDupLl5CbC1ikanPIVIQYr0xfl88BZD1xT348C8EoWLuK?=
 =?us-ascii?Q?93jjIqg4DFl29k/ljQqfw+1Vc7ScqHdf1DlbszZcYIkOF1j1A4395tnVXkH6?=
 =?us-ascii?Q?BFrGXUViMQl7Rljr5O8nnnZIQkrI4Qdb3t6itINbERBHI+RTGQab9ulTimAu?=
 =?us-ascii?Q?EZ3QhuxvMTljrjSKxX3WpWgpA8Su/eJ+Edar3rT6mGByUZwEbxa/j9Hfq63s?=
 =?us-ascii?Q?QF/qmLjxC4lNIB52aig79MkVhkcVeO/IhPu0CSFfY5sI20IXQp9BVfRvrA05?=
 =?us-ascii?Q?53RbiuJX8rCNzLAlAoffUI9ose4V5Qn723yoaKDtx9dHUYIiYdbUcTff5hx8?=
 =?us-ascii?Q?Mp6SkK7Y59IhvPvFMfcpHncYEyr1fiPLSTWIlo5lkSbIrwtp95l3r1BRmUSz?=
 =?us-ascii?Q?UkCeP7RLVtCHe44=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5489.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hNRMCgGt8vQt9pIgskpRhGhMSqHwKnuqpEaodUfk5KVjkoeODeq/DeVJW6a+?=
 =?us-ascii?Q?k/HK6BezKEe04AKS2idciOx0GB68DREl9+fDGuCKBfJcCZrOZfsPOEsPBe6M?=
 =?us-ascii?Q?SiVFzUwGGXW/d6o4ZUDrMtReIXKLRp9YsPVnXh7/L0zSFXgbCF1AH4KsZjkP?=
 =?us-ascii?Q?vvaaD2jHwYwEvEmGU1vpgXOQcsWalmf2rPmI2dTfYR+mZvIaN6jnyycigygx?=
 =?us-ascii?Q?hxp71j7DfwR+45uMTEwNKi2Syq1hkHeL0oL1OA3MECsY9oxUDk+nbXsorxj7?=
 =?us-ascii?Q?Vp68hiUH2nkEfgNJPTUKSHpKkEb8zjL8gb2uJMs/rT+dG06WKE0SC3KwMGdK?=
 =?us-ascii?Q?mW+Gvy1YsKF8mMxP/bU6r3JPrN4xpDaMG+k3MsVfzxWDXftWtATS0Xp7y0Vh?=
 =?us-ascii?Q?bjH/i3mmOw3Hiy24g3HLZg+x5nAM/nOwSxayTeSTgcVpEYS/b8/WZN5SEGbx?=
 =?us-ascii?Q?IBo6akrDCOrWypBhy4GGR7HdjsoNgmV6AxJHsLPG0wMauH5cYNsMIdV9ty92?=
 =?us-ascii?Q?m6I65k8QdcSFJmQlkqml5SyiqCHt0tgRGBcx93jYyxCVxNV3cImAI8eG4fCQ?=
 =?us-ascii?Q?mhPNi37w0m6CZuqdRIAOCniJuPw3v0wi68b15z3ySm10cAV2PIAa5AIxpRNZ?=
 =?us-ascii?Q?LwyUGfcieNAxf1bNzNbVoE7Ut4LqkIYtoJXMJetc6H82mS9kgrmW5gqpvTZ7?=
 =?us-ascii?Q?6JJynY3CpeqiuTsWEJcgjWPJtVQSGUQscT8GP38JqeJ4Oc//HEhKNdPTJU2S?=
 =?us-ascii?Q?zp1a4O2tqF/49coCYpJ2q/vW8XQhuhwYrEj2yAHCd9rb/0ezpw/msDu806pK?=
 =?us-ascii?Q?EOtxzdRe2OnfnKtz5uwXS89/ZxCMoXbBBYGiCs7pHY6DB9aAk9lvxO0MXNJh?=
 =?us-ascii?Q?zSihnD8MB4BoPkhVk60b7hLJEuTBrp1FqGFc4Iri2DEFGjlqFmvyBhsGwJK6?=
 =?us-ascii?Q?WocIwyzVc2WzIRrwdVFB2ZUWNoLPCdOTnzt04TfR4iFZbXeE2LYzJrUWPM3P?=
 =?us-ascii?Q?9LrkJLZGWQY7f4NRkt08zK5lyk7uzPUuZmJP4zxhfjj3Wrakbp6F0l3C/PCL?=
 =?us-ascii?Q?68vdUEVj0O2DF1hjf3BRDu3/01JtGMu7h67Q2qcy0CFHoVc9IcQsGBERzXBD?=
 =?us-ascii?Q?BbKkV6BrYHuxymvqR5kp6T/T8MvJ/Qs1PGHMj6OMO8sHl28FIzmjiPrZkBti?=
 =?us-ascii?Q?PZ1nd+6ttmd6ilhthuKOmH7MlYw5khp3pY0KRJ+lM54sz4RXXSj9laVOzGhz?=
 =?us-ascii?Q?I6hbKhiU/PMLsNd4wdu5zaQnhL4EuSl8EYYDErsUOFS86mjt5zM7Quk3fiwm?=
 =?us-ascii?Q?7GD0syvzYIjIJNjC41ZtNw0hHTbL48jClWCPsjNN4oQQjgMohZW9sfsGDhAC?=
 =?us-ascii?Q?gx2h02J3q2lJ2mrpk0ztpvShOnpv4Sl0HR7+cUnLo61KB0Efq8TWN/hlh4E7?=
 =?us-ascii?Q?CN2KE6lwInPucCAPyrOZkgUJSICiSCL8LNNoxPrL4+ZpTjhVMBRvkNXVdGbh?=
 =?us-ascii?Q?ggwbDhoazcFuYt2KDJf4BDElkV8FQ+X8povq5JcF47SxtuEtOAK28atGsI3l?=
 =?us-ascii?Q?vPt8PFyFaD2MawwcTEg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5489.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e0bc40-1039-4365-16e4-08dd91d8e00d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 04:44:41.4120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5R4Voaib658/19vDD7UUJU8wUj+LKDLZxHieww9YjrZ3JkUE4c0PvL6dprkWTVNvlEp2fUpZGBK58tfBag3Pmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7C0ACC722

[Public]

Sorry for spamming. Due to network issues, didn't successfully send to amd-=
gfx by this mail.
Have another one sent to amd-gfx. Please ignore this one.

Thanks!

Regards,
Wayne

> -----Original Message-----
> From: Wayne Lin <Wayne.Lin@amd.com>
> Sent: Tuesday, May 13, 2025 11:13 AM
> To: Wentland, Harry <Harry.Wentland@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: Lin, Wayne <Wayne.Lin@amd.com>; stable@vger.kernel.org
> Subject: [PATCH] drm/amd/display: Avoid flooding unnecessary info message=
s
>
> It's expected that we'll encounter temporary exceptions during aux transa=
ctions.
> Adjust logging from drm_info to drm_dbg_dp to prevent flooding with unnec=
essary
> log messages.
>
> Fixes: 6285f12bc54c ("drm/amd/display: Fix wrong handling for AUX_DEFER c=
ase")
> Cc: stable@vger.kernel.org
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 0d7b72c75802..25e8befbcc47 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -107,7 +107,7 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *=
aux,
>       if (payload.write && result >=3D 0) {
>               if (result) {
>                       /*one byte indicating partially written bytes*/
> -                     drm_info(adev_to_drm(adev), "amdgpu: AUX partially
> written\n");
> +                     drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX partiall=
y
> written\n");
>                       result =3D payload.data[0];
>               } else if (!payload.reply[0])
>                       /*I2C_ACK|AUX_ACK*/
> @@ -133,11 +133,11 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux
> *aux,
>                       break;
>               }
>
> -             drm_info(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%=
d\n",
> operation_result);
> +             drm_dbg_dp(adev_to_drm(adev), "amdgpu: DP AUX transfer
> fail:%d\n",
> +operation_result);
>       }
>
>       if (payload.reply[0])
> -             drm_info(adev_to_drm(adev), "amdgpu: AUX reply command not
> ACK: 0x%02x.",
> +             drm_dbg_dp(adev_to_drm(adev), "amdgpu: AUX reply command no=
t
> ACK:
> +0x%02x.",
>                       payload.reply[0]);
>
>       return result;
> --
> 2.43.0


