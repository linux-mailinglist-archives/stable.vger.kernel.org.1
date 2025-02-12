Return-Path: <stable+bounces-115069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2370FA32BAF
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 17:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F081888D78
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8824C689;
	Wed, 12 Feb 2025 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sZtczy56"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD0620A5DD;
	Wed, 12 Feb 2025 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378046; cv=fail; b=NTjc3I3jUwEGcC3p63yACbmQeASkRjtsJP55tCfVJrwZnxWw/goX1Pr+xHpUkoMaN1SMjxPOLhygNChmPxiEYItFqDm7J+K3yG2rQuobGqzHkGrizSOXOLMUSQ6nZSMm4wiObYM94bGu7xyfSMafAtMM4GRWefzoqVYI2boeIvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378046; c=relaxed/simple;
	bh=MDuYX0VRcKArKXBiwJ2+SEQJyu4o8Fh8sg3v0LuOv6o=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=H2rI/j1OZh1OUb3+LbhhUz7fyJjcM51PV4DfKYm4qI08GKvttM4/MTzJuuOquCtwBiyRhJ95oi8IS+tKLWkcxRTwZyYavVxdUHAdhkB5F07wmRJNOmMmomoGpb/mAG8VojMyAIGB04xjwef6xycwOwgiiIgT9Qq1eK48d77cOXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sZtczy56; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLoAd1aqFsI2Wrt4gUNMbXrw2k5HwZlcr4xH4KRCpdgTrz3Kj92xrth5rJtJ3fXcSegZCS6VB6unT6cg8IrwMv94WbkUU4TKRaVFVGtFHNDR0NSEadHZtb/7z94Pfd/2FR/qjXbfR3tNZRj7IwRnlZI5j0wfuESF2IwhVHhWZK7trCoTHb2TaRYWKcXJyl1IfCgvD8I+oJ1CGiD/zy+65/FROgs+21Fr8HLzrG5X4VYf58xNDKm25AFgl6oY6Aj8Ivg/FZWMoHMa07AaM9Wi/q4/cX1IG+JfBerT87csD5/jgjCrkxdlS3Fdu8WLq/MVXjq+hguKRUxv/Zyz6XMA8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDuYX0VRcKArKXBiwJ2+SEQJyu4o8Fh8sg3v0LuOv6o=;
 b=A5pE+IRvScYAKX5F0z7tIsdbH0XSjJ2CR8/NVY8nfB+8c9KA3V/sdXhTK9UcMYlW8gIScZgRqXohUU+/7B03nbB3cPSdjrLTydl+tQmsuKxyFVpzspWO0IdTCORyqjpHPq16r+AOtnRl/wSjRM2a3qjs0eFO0TniY2rSfgdIDJL7ih/bmeffjKXDhTqm9NLtfzybZYkrN7bXs6ryQYvtwVATr2ggYpc63Wo8UW4F23969yHFVX7P7n02o9YwBL7WYrUq+0DfWadgGo0DqeleH5myvCdVitMsYApKNyn6Hbu42HyGR2qwrGO+GD9eiff+RPX3fNMtBZwHhKWU5DGFvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDuYX0VRcKArKXBiwJ2+SEQJyu4o8Fh8sg3v0LuOv6o=;
 b=sZtczy56Pu5ppnnXSd7fRDS3x1Ar7klkjn9uqx4j+AddJYg6FKsBN07xh1JVcsLYUaCN5Hw6Kys39cWjyRok16N3hVOJYuiY8Y9zaQCXAAQJ8J75uhS6VDmxhCzdFYnUIdCn0yZqYw/abPSd5/dTXaYQFcdKBHnwVJRniBfMCH1RKTGPIloA/XtKrcqiYEsEluuP6C8L+42e9icrwDuoA/67DQH1Yo2Tgyb0ge8iXbbN5FCtvL2CTBpDKAMUYOg5AadE2TW3z+9nUCzxXaKNm4UJedId9LirljSpy0ThRx9TgVcWwoRdcCbwyLk1Myh8mmRJAPx5vJcGLROusU4l6w==
Received: from CH0P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::26)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 16:34:00 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::d5) by CH0P221CA0042.outlook.office365.com
 (2603:10b6:610:11d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Wed,
 12 Feb 2025 16:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 16:34:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Feb
 2025 08:33:44 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Feb
 2025 08:33:39 -0800
References: <20250212152311.1332-1-vulab@iscas.ac.cn>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <idosch@nvidia.com>, <petrm@nvidia.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] mlxsw: Add return value check for
 mlxsw_sp_port_get_stats_raw()
Date: Wed, 12 Feb 2025 17:32:15 +0100
In-Reply-To: <20250212152311.1332-1-vulab@iscas.ac.cn>
Message-ID: <87wmdvcecg.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: ebfbd517-f96b-452d-d4ba-08dd4b830e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rsLIYFi1ME7IphF/qJJw3wk5FIWuBmM+zQZr+/xFDsta4DD4mR/2+KmImZdD?=
 =?us-ascii?Q?XPVprQ8pTwFB2toyey2QltReQYuAEpZ+SVf6wvn6gKDOEEURSJlU9f9WL9gf?=
 =?us-ascii?Q?qqFZOYzBalyHD4EVBNg+goKsgcJJIpiE1CaoVZXD0nmlghZsdxdOqJx8nYQJ?=
 =?us-ascii?Q?RuinznnIpAkrKJ+GnaiK1D0oLQUMiHg3N6qPaSPe2a3OsZOpaMz7vgP6HFan?=
 =?us-ascii?Q?E22USwlA6gDnMrRZspzfPFRWrdHG+UHk2+jgbiQ93UHGhomxw05qY8L6oULv?=
 =?us-ascii?Q?PWA+/tJSS0CYmT0tf8lbwJYj4c8x+WVBAeJ1Kp7NeoTEoA2okmadvIjo98ZG?=
 =?us-ascii?Q?ms+E2ZdsmJ8l5ueX9M+W2TEjhrfxPQYlA6FA8icmMNCq8wtUwlAlm13Z2K8i?=
 =?us-ascii?Q?jIxknNYsXUmvRAisRCGaxoBfsmlZx+cGkDSMdJWk6cilOrnHYGQZ20gMDXg6?=
 =?us-ascii?Q?vij3kwYPmeL1Pz8Ta9XlXJ3mDRKiBqhJErSTD2ZKHFYtba52LitdIeAO6zbP?=
 =?us-ascii?Q?QMBg9MHQqft1h2z5Ozu/R3ptyCNkMqk9iczn7GmFgPb/vl9jGkHtA27mFOOy?=
 =?us-ascii?Q?V0r+MEVguCli/DrjjO+zGel08KTcxk63ZdIEbkdxlOW+kqhN2N5T3DdoJFlA?=
 =?us-ascii?Q?rTSjF9J74sDe2MHXk2pBCpGVTmOkNCzJZpVkhh7GFz5IeYIUo/0xgctqjZES?=
 =?us-ascii?Q?fuEKJibzIqpVHX4Orj99O6utBSVsXyyEpWoAjn/WULIC80CBezeu5Tn5w3IF?=
 =?us-ascii?Q?jOTP9f6e4U8FWUUh7pC/TYyLskFES/WvRU3JWAxPDkTq8FX+r07ri43eIwzW?=
 =?us-ascii?Q?1CpIluczHcvUpeHhNyhsaLnc5piO7cLE064l+z/1et9oZrxMKlVthHubIucu?=
 =?us-ascii?Q?RjzkArP3Y7EPH9m0X7eN9MxnebpzGZRLhMIInIjPX2iHo+t8VPcDd01huk84?=
 =?us-ascii?Q?rmBJjxTB5upsjVpK/fqLnYoui7SipXP7wu+48eXfpUYHnGXaGzDMmtoiblIR?=
 =?us-ascii?Q?5gcmY51S7XbdsGiK/p7FcJE865n/pLsFXGLJJOEr/LQLA2yLAtO/c76jZ5IO?=
 =?us-ascii?Q?LXJGHMdNnABOx6fN2aIEesE+mB/GM9uesBt0+fqBw85mQ/uCWmO7MOemVogb?=
 =?us-ascii?Q?13YOzXRsAPy2q7PBVO83EEXdHsyqa50cyhxCsGVNCAmSCy5JRgXJ0ls1yYwz?=
 =?us-ascii?Q?LxzfpOA8SxyQfOobX/EcL30KMzwyeU8lx2tCkXNIddJbAJxEp9/APhYbLMVg?=
 =?us-ascii?Q?+ZFdzy5KARQErAPZTFGwzGrigxPGveTZ6+5CEXvK1lPjj4n/XElC491loNVj?=
 =?us-ascii?Q?t9jZLIC4GFgKpvJPHJAjd9rFcZ0VCcxQMnEa/BBCbEdg/YVKrq4KcRJigHd3?=
 =?us-ascii?Q?gS8YM1JAt9qunsDSiEg2gAweHW+MFtIolsSOYD/kRMUUi53dLmGvSOoiv2mx?=
 =?us-ascii?Q?apsWyHIJjd80oJw7qQLeDkD2te+oqByRzPYnjxPZzgKs8t/w11+3KCdy3zji?=
 =?us-ascii?Q?y+1JJ29aKNKTFIg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:34:00.4288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfbd517-f96b-452d-d4ba-08dd4b830e19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908


Wentao Liang <vulab@iscas.ac.cn> writes:

> Add a check for the return value of mlxsw_sp_port_get_stats_raw()
> in __mlxsw_sp_port_get_stats(). If mlxsw_sp_port_get_stats_raw()
> returns an error, exit the function to prevent further processing
> with potentially invalid data.
>
> Fixes: 614d509aa1e7 ("mlxsw: Move ethtool_ops to spectrum_ethtool.c")
> Cc: stable@vger.kernel.org # 5.9+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Petr Machata <petrm@nvidia.com>

Thanks!

