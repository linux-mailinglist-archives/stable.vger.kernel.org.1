Return-Path: <stable+bounces-195042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E89C3C67071
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 03:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 5E9DC24254
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 02:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7142F690F;
	Tue, 18 Nov 2025 02:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZhAXk3u5"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013011.outbound.protection.outlook.com [40.107.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340B1A5B8A;
	Tue, 18 Nov 2025 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763433103; cv=fail; b=tZkvIX2JLY0APtwOznsOgsaEyVRGXdd9XNy2umMZ08AGp8n5fX1GYIh9mBZ2JdOOkqEX3vVms6zMUXf0i0qd9gi6FAZqo+HLkEEgC7xU6IQQBKIAv+N5GFC4Rhh94k5xMgcQwVzg77Me/4RmaHFaQzPkssmffjssQr972MY7u14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763433103; c=relaxed/simple;
	bh=kbBXkY7AOfP+/EkRN+Iv5BhAk+q20opPGb6jGD4HkXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vcq8R3BfLK6ECZbCnaMX3wWznyDPUF535Pa1AiE3yWF8IgykJrMtg96WBDJ0CTtneicfCT73PAuYtOteI+41cAVGgTnMRslPuPhfL6kha1CtWMkiEUsMjgssaDHDOhiMDT6DBPibuoNKdtrqiDIhzJ6I2G3NJOmzwE9ub7In7iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZhAXk3u5; arc=fail smtp.client-ip=40.107.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ns355Rq4FZHLZ4FlBihgSc4gzwEfzpt4mYEB9Ra2o2lcbog84cspiGOgCrIPfknocZd6Qdd9hvg+V/+C74RCvO9IGOOaWwS072z9QOSEfp9VBH0YDob4djT5l8qYEkfxpOjGRgm6i/xHO/L7r4ToUkQ9CDY8yrufCg4z9WvU+QSXFjN/B/WrZkIrG3lBGojMJEnAbnVGLORTlrAdnYRFPjanJLpxZ/Hngm7zU8vY/a0hdqlAs6BAKSBHT4Vki73bb2nx8L9QPERk7ALfEBRVYb/U3NA/P0hfXeI6v0yl4lBhq/ya8ERFdsRwPZUowhiqgeuOjEompSRLmLsutFQdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36AU+AKTsdXgXhdfiBghlE+ajirfkLS6Dy4BG3h3v9Q=;
 b=vpHEWeDKzaE/gYOMRQqu/o6zseOPo709ijqDMa3gjJ77+57srpWxOS6HAcwVq5zfykhTmK30kk23XjgAmw5O4NTuO5S7NEVYzu+YIjfkgMeaVKONm4XgfotlP5+mLydhjc+0ybFTUZ69MIuUvISKMs5c5P+SST/W6xFuzGvhGjD1Dt1OC5uruH/Hsfeg+S2CDzOGedxnRhPADEKKALxtx4719tnUc9/NWb8l/8S0zlbw/jH/vPsSGNmXGGSEu4ex7cjsyUUicFnjH2e74AZNJNpa+90lHrOh2mikx0owHWryNXtIrRn9vcqgcVLa99Oy8OfZsY23fHZ/LfMCoaXPoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=suse.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36AU+AKTsdXgXhdfiBghlE+ajirfkLS6Dy4BG3h3v9Q=;
 b=ZhAXk3u5curv/x6oRFe5qffOsMDAZQzqJy2MQSipds7/38zg8YMuJIrgt2lJSjrfAAWkkYygaxJ40MUfZTKQtvLAm/bYCN/8kpOSgO9cXWoAHdTTKgMkUnY/IOqGWLTRDesJ4u+e4/ozZmytyNto+Kx0a7rGDObGFswwmiccejM=
Received: from BY3PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:39a::20)
 by CY8PR10MB6827.namprd10.prod.outlook.com (2603:10b6:930:9e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 02:31:36 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::6e) by BY3PR03CA0015.outlook.office365.com
 (2603:10b6:a03:39a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Tue,
 18 Nov 2025 02:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 02:31:35 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 20:31:33 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 20:31:32 -0600
Received: from DLEE209.ent.ti.com ([fe80::9756:3b42:e53b:3cbe]) by
 DLEE209.ent.ti.com ([fe80::9756:3b42:e53b:3cbe%7]) with mapi id
 15.02.2562.020; Mon, 17 Nov 2025 20:31:32 -0600
From: "Xu, Baojun" <baojun.xu@ti.com>
To: Antheas Kapenekakis <lkml@antheas.dev>, "Ding, Shenghao"
	<shenghao-ding@ti.com>
CC: Takashi Iwai <tiwai@suse.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH v1 1/2] ALSA: hda/tas2781: fix speaker id
 retrieval for multiple probes
Thread-Topic: [EXTERNAL] [PATCH v1 1/2] ALSA: hda/tas2781: fix speaker id
 retrieval for multiple probes
Thread-Index: AQHcRq0VJnZsv0XkeE+LiG/QWnafObT32Ubq
Date: Tue, 18 Nov 2025 02:31:32 +0000
Message-ID: <7c0d8c96c51c4265aa150ed8c4d785c7@ti.com>
References: <20251026191635.2447593-1-lkml@antheas.dev>
In-Reply-To: <20251026191635.2447593-1-lkml@antheas.dev>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-c2processedorg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|CY8PR10MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: b15c2495-8458-4c00-6a25-08de264a986d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?QsbxdXKeVXWFT0mHPJYNk/ZDr4aCE3jCuxURq1R5nMc29EccWy+dc4vWEo?=
 =?iso-8859-1?Q?OgBHeYWu3T0f2gbyqNIi09f0wXFwUvzIZ1FWCjXqTokys0ClX1RO0s5JN6?=
 =?iso-8859-1?Q?sk7JlMfwIoONLBpJELhbuiAmcrC0ZyfGZDeLUG+L3/4liMDkAq2QHHe6mH?=
 =?iso-8859-1?Q?aPMhrORMT529bJV/XXJoCYNzO+vrAmV/MvAA72PS40Dg8To9c87r9k/0/+?=
 =?iso-8859-1?Q?RIQ2+UNz2FrMv3LWiDSjY3wHhLnAhr8eYYVW5TLuVt5EWxp1O1iL55mORU?=
 =?iso-8859-1?Q?ORiCU2tz9SSeZV0V2+Oasy6x+iJtkN0waIShivl53KOEwUTxjahBkP29lW?=
 =?iso-8859-1?Q?AcjCg/Y1kxg/G71dJINw+7nxHyySKeiEx2d9xHn1f8mAZTobLhrQK6W5D7?=
 =?iso-8859-1?Q?Es/UiOlE66JcIxHYLbXFR4W/Pl2BG/L5+NuzMwWrJTXaBBtifZ+5W6sSOk?=
 =?iso-8859-1?Q?ngHcPMwZWaQYbZBF5sw4vyXKYhSqOm0ByfLoXWimaCbwIRL31pTKQrndOA?=
 =?iso-8859-1?Q?+/I28yE0eJU0jICtre0prq+3q+u0ncSAK/y2Kq0wS2dELdz3LiB/7iUGHs?=
 =?iso-8859-1?Q?IKHUrzSJEw0jYzvwh/yYjFZfB6Bh2/gh9DvQvORXcz2btJBbDhMcrzVTzb?=
 =?iso-8859-1?Q?XG9DNHFORy5PEG/QV/B6baO1oMc2jKLfWFsvugXme7Vkp0HsvDEW6Hzto2?=
 =?iso-8859-1?Q?ta7xC4eDWF4r8l8n9vCF12n+RxVesJ73ghAp71u7sAPRV84vf8Hxtu++vB?=
 =?iso-8859-1?Q?Npa7MF6jFffoYtXUJOun3HVB7Tr1kXVpjl2LriPeHxwB7n2wZTcSvoyh9H?=
 =?iso-8859-1?Q?pR4HQvLRwQ9SZTGsuvErbFjn5N+8lUeSgXGqEwTCiJfS0VcTASxC9XF9Nn?=
 =?iso-8859-1?Q?dkEO3W/sIXtUwFrIjxK0TFGFulgXgrF5R6riWEwg6BuUd0Lm5W3lSF78Ef?=
 =?iso-8859-1?Q?8gNFE8MOXFR9TNCprUjLvxWXnpM3MWY/zhKtVkDfgPTm7T4IR8evn4QeW5?=
 =?iso-8859-1?Q?+RQlUtODrDxZqeX9J5jf6wT22j5D52mE5x97l+1ruYzYsVY0mBHINIvIOf?=
 =?iso-8859-1?Q?bfxPv6vfYWhO8Fz2J+Nn3gzsIF06hrFLN9SujfOS6lCPphpkycNms0eLpy?=
 =?iso-8859-1?Q?qB3pL1R0HKR+vxl2cjBYSm8QdAB/a2jS1qRw3pdQ9ZjKwF4/MmEcmNF2uA?=
 =?iso-8859-1?Q?zzTqeYV7PTu1p5OEU/OB7Hcs62RFadwbQuH7Ai2O6IAO7FtmD0jh3PLl1c?=
 =?iso-8859-1?Q?HFNg8wZdD2Jpq2n7LoncQaJfkPAswqiXqq1aCijXXKpIn7CrYKj951SM/N?=
 =?iso-8859-1?Q?QMFqbVmuBBEUnSxnbVrDAD8V8/XMDirYL1dlTllWXeHOlSW06LVGh5KPOQ?=
 =?iso-8859-1?Q?M+wzWIbXKEW7cxAh4xmQVJ4JTGEBb/O25tudvudz3JYJY6Rzcc3zN2doll?=
 =?iso-8859-1?Q?HYUdT4FI91YkIIAFNhSt7ouxrEpoF1fPuIjKZnGbosVEOSpBt4NOvnCBU+?=
 =?iso-8859-1?Q?LTBieujko7ZW1tBWiwemqBLrS2LxeNHF7bQhLUAIIom0yTVYWG9rPs3laF?=
 =?iso-8859-1?Q?We4hvBgy3xTm+Sr0AzdCVF5g/e3zbZ7Vo4Vyjjqp5cOchhTTY8D2sen63t?=
 =?iso-8859-1?Q?Z9VRgcYx/reo4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 02:31:35.8704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b15c2495-8458-4c00-6a25-08de264a986d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6827

>=20
> ________________________________________
> From: Antheas Kapenekakis <lkml@antheas.dev>
> Sent: 27 October 2025 03:16
> To: Ding, Shenghao; Xu, Baojun
> Cc: Takashi Iwai; linux-sound@vger.kernel.org; linux-kernel@vger.kernel.o=
rg; Antheas Kapenekakis; stable@vger.kernel.org
> Subject: [EXTERNAL] [PATCH v1 1/2] ALSA: hda/tas2781: fix speaker id retr=
ieval for multiple probes
>=20
> Currently, on ASUS projects, the TAS2781 codec attaches the speaker GPIO
> to the first tasdevice_priv instance using devm. This causes
> tas2781_read_acpi to fail on subsequent probes since the GPIO is already
> managed by the first device. This causes a failure on Xbox Ally X,
> because it has two amplifiers, and prevents us from quirking both the
> Xbox Ally and Xbox Ally X in the realtek codec driver.
>=20
> It is unnecessary to attach the GPIO to a device as it is static.
> Therefore, instead of attaching it and then reading it when loading the
> firmware, read its value directly in tas2781_read_acpi and store it in
> the private data structure. Then, make reading the value non-fatal so
> that ASUS projects that miss a speaker pin can still work, perhaps using
> fallback firmware.
>=20
> Fixes: 4e7035a75da9 ("ALSA: hda/tas2781: Add speaker id check for ASUS pr=
ojects")
> Cc: stable@vger.kernel.org # 6.17
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  include/sound/tas2781.h                       |  2 +-
>  .../hda/codecs/side-codecs/tas2781_hda_i2c.c  | 44 +++++++++++--------
>  2 files changed, 26 insertions(+), 20 deletions(-)
>=20
Reviewed-by: Baojun Xu <baojun.xu@ti.com>

Best Regards
Jim

