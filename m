Return-Path: <stable+bounces-161807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EEEB03769
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 08:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89756189AE5A
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 06:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4792222CA;
	Mon, 14 Jul 2025 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qsxv7lnL";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qsxv7lnL"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EA27E0E8
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 06:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752475929; cv=fail; b=bri4tQgPWnSfGC+x2oJvp3rVTAlOYloCE8kQaEaZirTVBMyPp7d1hsjvbUmGX8utbIGbAVYQOcwOkewIv3IjQwh81xkDkz6CTG1uCwlW1+elFEIjlH2KOs4Cm4jYL83aFxFY/myV7toaO2lG+OaP4bFEneY4fOcTYKRKW+mtSZA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752475929; c=relaxed/simple;
	bh=Nl9v6XMjkRmJ+j1cg47obQQg9i3jAmtSYl2KA18/p2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WLpcVonZ0QpKfI5NnVMi5xsblq/RhCuYutpcJw+J9ePCwkRmTRJCEGDLXoECKo67WGf08pnostiO+EYya/svVlnQBervezSYmwbK2OMYLbjSdMu6kUUlW2yXEjewlHpwOACC/IMeu69YCnJ8VjXDT1Rlw7HjMHBu5C0iF5m2Ihg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qsxv7lnL; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qsxv7lnL; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=q5EWkmKS+uQ6Xva2o4Cijc3e/OT/7I1ONnVnuP8MxT1ojd1MOlkOLW/qbUg7Y7IKcmsEFIBFuZHtwHaNwFP1DMIQd4IMMu5MwJJDDRP08rxV3fcqmnfzQRFzxbSY804LdoYE87h+SvXntpdfYKT0IRTHJB7eBPgwIWM7ivj6qh/Yrn/loaRHBgo4AAb1I6vNQ3D6rOk+TjjnJ+7A6OXArErfS+zwwvx8e5JecDbG2cAR19Bqz35JpjWK7Pw+BrmZSCBnDL/khUCCnvBQQjQkVafhsyvlsk5oP4IBcW/34bXAcVs734GdfE6kkWV3d0coN1RZGiwsUmAVziDzSJyuvQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtKfddZ3QAbYTEO435Jy8qSs5CwQ+3bmXzkdAuPmnPY=;
 b=np0lIKXh/7HhWXrLcd9JuVaKDBPuQ+c4QyWvBByTjkYNP48Al9qSHUQu9ZGfxyMwTTR0S8OgcZnkH1cOeUEoKnR1/SmIVzIUq2b5oECR2uubMi897cwxn26UmNCgpy0OBfJ+GCcvhAR706DBGLcDy7sy53KN0xWObSdX0VXft2GwWly9SweNOoFbLKsmTnVBO5LPmgB+8EwdP/nsnB8SbGCfsmSaPzK+mj4VQJh3pP02hCTtV2vDIcGQjWsubvL2es8pDOvjVXuzIDn6QpIS+O9elzK6oOGpQ7vHkfq+Zhy1N1b6jnO4ekhLUncAcq7lDLS60qqaDtRWtsA1GxQQng==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kzalloc.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtKfddZ3QAbYTEO435Jy8qSs5CwQ+3bmXzkdAuPmnPY=;
 b=qsxv7lnLFwFKHjdVeHDSxewOxcLnXXYquAWvrAH55DoNJqy32Ju6i3TyU52AcbhZTO1AxmeVq3LXmVm4SHZ6DNHAXyPGYacq1xe5cyFm2WYsLHrjxqWFjz6lg+8VjRw9MgoxTSIX6ANVqE7o18rjNzdEBMyjwIQqDN2a+gpbyo0=
Received: from DU7P250CA0020.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::7) by
 DB9PR08MB7867.eurprd08.prod.outlook.com (2603:10a6:10:39e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Mon, 14 Jul 2025 06:52:01 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::53) by DU7P250CA0020.outlook.office365.com
 (2603:10a6:10:54f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.30 via Frontend Transport; Mon,
 14 Jul 2025 06:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Mon, 14 Jul 2025 06:52:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akyusPZIhYbe7jPHHYocXF2/cHBVvxfwAUPIbbISkf6GzVVjB61hBOjQVilKwAvqRCo0b+RBalhnkWXaF8O+8kQSHxtFo6/MNJK2YONI04MPU+pNzbpEJw+1m5OYJfDMNXpoJ0Fb4Ss2GpJCgQVSTctGV4FtNyPhj5snYa0IfUwK/MFyElzWs1lu9Gsn2H4/o9XA9ewFSF3Cpl3wYLX+TOUx3UVqba54v+yl1fAGvtReJrB+R6ZiZ5ldEaZAtxw+sHNeHL7MGz5LHGMg/cCNvbK8nZgDS4moYTaA2t0SAbXKRLaZIOOQV6rkE5lH/f36ryxW/T+NpFDEacrFT2eSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtKfddZ3QAbYTEO435Jy8qSs5CwQ+3bmXzkdAuPmnPY=;
 b=f81dObuoZ6SHuAahkhIrC7aXpgqYkZg09JKz6gkwrdB482ZhJdS3rNPscG5vaJC85Mg2mwOP6kGv71WIVz7UWWhDBzAuFocinri42mNYDCKpjj3c8jndIJWPvO/4JDABBS+B8GS2a2eDn+YH3srrkJKRA6RzsROrsywFJ6vWMBsimI//JHRdUtvqMZojx1I3TB5Fdl81Qn+S0pPhO55Tuz9PDprYQ8jEKs7cZ/xUZxy3LcngPhIb8AZfd2zd899YYybhTSK5VCyT3GOsNgOvkrQN1OfPGwyLB3rHkG+jFhCIS6MNbe1coXFgeiCy8POhN6qzDoH8iNr1ipn0p0RxSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtKfddZ3QAbYTEO435Jy8qSs5CwQ+3bmXzkdAuPmnPY=;
 b=qsxv7lnLFwFKHjdVeHDSxewOxcLnXXYquAWvrAH55DoNJqy32Ju6i3TyU52AcbhZTO1AxmeVq3LXmVm4SHZ6DNHAXyPGYacq1xe5cyFm2WYsLHrjxqWFjz6lg+8VjRw9MgoxTSIX6ANVqE7o18rjNzdEBMyjwIQqDN2a+gpbyo0=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS2PR08MB9296.eurprd08.prod.outlook.com
 (2603:10a6:20b:598::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 14 Jul
 2025 06:51:28 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 06:51:27 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: "ppbuk5246@gmail.com" <ppbuk5246@gmail.com>
CC: Yunseong Kim <ysk@kzalloc.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>, Andrey Konovalov
	<andreyknvl@gmail.com>, Byungchul Park <byungchul@sk.com>, Dmitriy Vyukov
	<dvyukov@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Vincenzo Frascino
	<Vincenzo.Frascino@arm.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y 1/1] kasan: remove kasan_find_vm_area() to prevent
 possible deadlock
Thread-Topic: [PATCH 6.12.y 1/1] kasan: remove kasan_find_vm_area() to prevent
 possible deadlock
Thread-Index: AQHb9IrW00Us/SOXfEqNmAE82ZEnkLQxLkUA
Date: Mon, 14 Jul 2025 06:51:27 +0000
Message-ID:
 <GV1PR08MB10521816C48FB74FEFE8D20FBFB54A@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20250714064454.979605-1-yeoreum.yun@arm.com>
In-Reply-To: <20250714064454.979605-1-yeoreum.yun@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|AS2PR08MB9296:EE_|DU2PEPF00028D13:EE_|DB9PR08MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 11998213-ae83-40e5-ec56-08ddc2a2ef40
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?jqDN7mZQQ8RJ426bcZeMOQhPIwZDWtPyNQFJPo3icblw2jivRs1ktsO1gmme?=
 =?us-ascii?Q?dKMOVP6vX+1H+Il3bqIZ3cpjuNfsdtzQeaghfe8chlGK3az+pkiq2DmNMprE?=
 =?us-ascii?Q?zhecu5b5QglCaR4S70ZUfFSFaSdqbAqX4AdWTYf3C+KGZ92HVSMzzafW9OAP?=
 =?us-ascii?Q?haFxqiKFX6cRYHP7yJhyJDCGYOqnY9+fMyJr+1644A03CanmR2TAHDF/aI3w?=
 =?us-ascii?Q?G5KP3m8/Gq6p42ZOz50UAbQD9ZVHV8Nx+eJlPqWCZd8fmffNZjNi+Q6hKFWH?=
 =?us-ascii?Q?kZnyhyaTqMqT+TtaM5zCNYNKW3a+pxLvxPgr6RqQMCPKaHPAR15Qe9tQtCoA?=
 =?us-ascii?Q?ceHVjmSIVZxwId4ae6qenoGDg4Kxlu6bt+vB19qeqt23aeVLFpARLeJ0mmE6?=
 =?us-ascii?Q?LEj9PjrF0CTu5ZqS9bLVccJLK4lQBGfxtMRbxOYkWL9JhKEuoePYjQObq+fh?=
 =?us-ascii?Q?NI65el0EO3AdNcIVKfTSIupvh0je9w8CgUzatVLHeDe0/u508HZvzJXMresW?=
 =?us-ascii?Q?sQB1Y+f0FEAnlP3Zwxl5zocU0/wn6cmTvmlCiQIf5QyvcolEtwD2bA/PwKKm?=
 =?us-ascii?Q?/kliFO5RX0y08WllqGm9LgixjyNDGvfocHN2SJGkuo58YTWHllzWzGVepxj3?=
 =?us-ascii?Q?E5CfXD0FGDxe9LU5pzz+zo9rgEW+O0Vpuw5/5AkHgVu1/tM3BJ4iyuG9ruux?=
 =?us-ascii?Q?hjKv6ogkz1jgy/yZQl7uiGTMOS1pYe7dpxAOvoauyCE4Z5gt8CxBbW32OQn3?=
 =?us-ascii?Q?0kmBtqC4+mQytQEIwlHa9cfvHw1bsIahrczxu+6vReSJUwotfA1TK78Vu2Iw?=
 =?us-ascii?Q?N7nWJJeOmPit6JBBvfSph/2F+xGYVw78vKiE1Sl2omBDCsTs70/BIoLBgdH7?=
 =?us-ascii?Q?xbiijE3EGEvwCCeScp+qC57UaO4HT2mCiOfCwR/dWP7ThqkRvtXPnWAG/qoG?=
 =?us-ascii?Q?WeHIy3VFPjqAMZ1A+2T9B8JWl1cH85bMIzWnRAKJSNgg5N7C0GHbwZ+N1W87?=
 =?us-ascii?Q?gXqUOHTReJTnlPSjnzY6GEilIiqE43W696khONsDd/GWObiWhSa7n9xZeuqQ?=
 =?us-ascii?Q?vVGsbQCoWfKpeBHXahVceO0h5KDJlmppXwb5j37TWNhFi6PqBWQJtcODK4Xq?=
 =?us-ascii?Q?3j/NdO6iOL+S6NbQDwiKu7hRal8syrtgaRxPUPCDqa/OCMR+63++DzMjrVXU?=
 =?us-ascii?Q?On6F7pbyVKJuQI+MmmeDCdjCuxJN68xAaRrZ58YkfIVi4KuRuXTxI5UtK+Ou?=
 =?us-ascii?Q?bAmO5pCV/yXAAnP/CLMthMEBgQLh/EtcrxCtEgKPtKVCt71Apu2dWfXcDbt/?=
 =?us-ascii?Q?BCot1ZeC3ztdA/ghCiqQrQh/8DL5Z+6xHZMMbt0rOHqvxsTzGbcJfKZ9wps4?=
 =?us-ascii?Q?qNSy24+EAlVue8r2tm4xlojKYqUZsj4hE4sq7i4jFh6t4S/gVOVsmnUcoefi?=
 =?us-ascii?Q?B6djWXTAegjSMFwAsy871pTNFT9xTzz3DT916HWYcxDr1i7KzUV5tOECUGqw?=
 =?us-ascii?Q?EFx+lX+G2kqisvg=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9296
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	539a3dbd-897e-4a38-4120-08ddc2a2db4f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|36860700013|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3JOomMjTcHEpGuXzIAkeBsNemn4kXiaQjsuwEaYf6pISqkl+lZ5EqV+E7FGm?=
 =?us-ascii?Q?9ht0kuNEb6YHXyppQ2XYfox33shFv+eqNPArfLkF/xJdZDbzzeTWQbdu/FQe?=
 =?us-ascii?Q?BesQyj7D6QQp3Ifce79hAjWbR/WQmbjJ0qZX999IZ54W028Jtqkfem4zsCaL?=
 =?us-ascii?Q?b+lUS4UN8wlsFf0oRHnufSzFzk/Z9ZNY7bSCrIpgkcRc+6LrWECU/Zra0Y9K?=
 =?us-ascii?Q?RAlBo8NSa2ToF2z950z5N4WPCCjHobCQByn0nsxHFO/nmyCqqtFweaH25f75?=
 =?us-ascii?Q?fXlwQAkB6YecdUJiZoqY16WkB5kIYNfrdNG0fBSl2En2zpFMMuAK4inJFJkF?=
 =?us-ascii?Q?V1LVz9L74wB5XcsIqgLIvRvg17TwCmgta6ClLbMc2F3FC1uVY+4xV3f6koA6?=
 =?us-ascii?Q?3hiNVsPAXDXU9nd7BncBpSIU/LylU/tyy+nKiCdcTQuFQUXTVItLDYoALQL/?=
 =?us-ascii?Q?vSgzEY1GVwNLPcrPpmuNhKZJx8p4VC3GOJ0kh9aeQaPIhJZTDtnVNJj5D7qj?=
 =?us-ascii?Q?l0m4JRqLVcAOpQYRZdRiusYGvV95X09jCPSQ9OCoMil4SE9+LbePtIff5oUy?=
 =?us-ascii?Q?ufGvnqxjqORKYF6HjwV7eYz1RxcEIV1PF8OUJVDiQcmDJrRi7UqdiaWrrzeC?=
 =?us-ascii?Q?isEIzwWtBQWa9y6jBf+G0h0PBE4v13S9Jwa+psn36JOgaFwHyDexyzh4CkAv?=
 =?us-ascii?Q?N/akDmZXJ2SR4xSD26bai3eSiacIoFOFDg7rUmJk08M7DIBfORqvJY8qeyZi?=
 =?us-ascii?Q?g7IfR8tA6/yC/53h3k+md3Kt2dIJ7e05yR3T+A80xbZL7JiyDpYjqJ9GWDYV?=
 =?us-ascii?Q?ZCt6tNginqRQSPMxjybeeYYciKTXChzHM1sR/s0Y1csjX/ngBN9Hr71Wi6J+?=
 =?us-ascii?Q?SMOodBWHiM3aKHPQnsf2CGcA2z9CE+9o7lCCyQHXO43/iKiH1IKx0myfsHHR?=
 =?us-ascii?Q?zLwQpa6pNNnMrK49c/XBqjqA+lCdUAI8OOz5wcjoVfwadwy4b9372Xr1vENY?=
 =?us-ascii?Q?k0liOdR02SbSCVz2PAObe7SeOMzDpYnYKljYvGy8bm8PvA3cCdI+7OP+uRvs?=
 =?us-ascii?Q?Y4SOKxP9ElGnMlPioMqTdYPWU7prZl8gBoTcucCEZdmPDuskbrNnt3yg76fn?=
 =?us-ascii?Q?qr0CjGfT+YRh//ta2DdJnj/XFUbuIYEbx8PBTZl/5fknMQROgS8DiRU2lCgt?=
 =?us-ascii?Q?wrKt0Z7Sx3lypOStFfMed0e8cJUvVRcnzqZihJcmNpFe3Sdz8mNNXOhzQe9p?=
 =?us-ascii?Q?NkMY+zjlxZud2JHI7M8ACwoq8KrZ0FT0W3KGUBmiI7iTiaqYiOOO5Wlg/Nnl?=
 =?us-ascii?Q?6JhOYhGPssmce2WxRtJ3PLJ/1QbwOMlQ5YXatMbztoYAhjGhqLDqL7xoKnHp?=
 =?us-ascii?Q?goHvXHe2S4W+ek/bBQXwkqt2qWFjfH9t956INs/n+0VX+9qPy/VnWFw1wWYx?=
 =?us-ascii?Q?x4xrcTbAT0x17J3Wd6ugLN+7cp8QBwitvV42U5ppGRcp/xMulcsmvhpAyNQq?=
 =?us-ascii?Q?boULzAAcYZGbgYn5mOGdw7zDFqvd6BjWfRixU2C4FJl/Y+vNzFRJYXyqWg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(36860700013)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 06:52:01.0021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11998213-ae83-40e5-ec56-08ddc2a2ef40
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7867

Sorry to make noise.
I've missed in-reply-to.

I'll send again.

Thanks

--
Sincerely,
Yeoreum Yun

________________________________________
From: Yeoreum Yun <yeoreum.yun@arm.com>
Sent: 14 July 2025 07:44
To: ppbuk5246@gmail.com
Cc: Yeo Reum Yun; Yunseong Kim; Andrey Ryabinin; Alexander Potapenko; Andre=
y Konovalov; Byungchul Park; Dmitriy Vyukov; Sebastian Andrzej Siewior; Ste=
ven Rostedt; Vincenzo Frascino; stable@vger.kernel.org; Andrew Morton
Subject: [PATCH 6.12.y 1/1] kasan: remove kasan_find_vm_area() to prevent p=
ossible deadlock

find_vm_area() couldn't be called in atomic_context.  If find_vm_area() is
called to reports vm area information, kasan can trigger deadlock like:

CPU0                                CPU1
vmalloc();
 alloc_vmap_area();
  spin_lock(&vn->busy.lock)
                                    spin_lock_bh(&some_lock);
   <interrupt occurs>
   <in softirq>
   spin_lock(&some_lock);
                                    <access invalid address>
                                    kasan_report();
                                     print_report();
                                      print_address_description();
                                       kasan_find_vm_area();
                                        find_vm_area();
                                         spin_lock(&vn->busy.lock) // deadl=
ock!

To prevent possible deadlock while kasan reports, remove kasan_find_vm_area=
().

Link: https://lkml.kernel.org/r/20250703181018.580833-1-yeoreum.yun@arm.com
Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reported-by: Yunseong Kim <ysk@kzalloc.com>
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 6ee9b3d84775944fb8c8a447961cd01274ac671c)
---
 mm/kasan/report.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index c7c0083203cb..5675d6a412ef 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -398,17 +398,8 @@ static void print_address_description(void *addr, u8 t=
ag,
        }

        if (is_vmalloc_addr(addr)) {
-               struct vm_struct *va =3D find_vm_area(addr);
-
-               if (va) {
-                       pr_err("The buggy address belongs to the virtual ma=
pping at\n"
-                              " [%px, %px) created by:\n"
-                              " %pS\n",
-                              va->addr, va->addr + va->size, va->caller);
-                       pr_err("\n");
-
-                       page =3D vmalloc_to_page(addr);
-               }
+               pr_err("The buggy address %px belongs to a vmalloc virtual =
mapping\n", addr);
+               page =3D vmalloc_to_page(addr);
        }

        if (page) {
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

