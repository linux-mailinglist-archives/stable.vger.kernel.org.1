Return-Path: <stable+bounces-244925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J5yAUTo/mlCzQAAu9opvQ
	(envelope-from <stable+bounces-244925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 09:54:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D224FE970
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 09:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83C343011BEF
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 07:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2555383C7C;
	Sat,  9 May 2026 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QZ2BKDaP"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2D3537C7;
	Sat,  9 May 2026 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778313225; cv=fail; b=DDkzx5L6+nYiI+WNoPWRW6Oa9coG9j2gSf4+5vASOq6Y20NBJmiTAhoGFZ66jYS+qGVIis2oKKc5vWY0RD9kIQnIi7Znd6fYgJvTkG1eSB56HKdXCyNBGhbNV7fDhl33AARtviTzjirvt1QVFF90syYv6/6A4zZyfoE0fLwdFls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778313225; c=relaxed/simple;
	bh=sVwCQ1KdAcM1zqSoF/5WzHMwI9kH449e+47ZODcugEM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfB3NgIITBwrBRuJM6atv4nMS3JLjASYRc67jLz90hqM3r2ItZoMYAcYXC4En4eh6G8hMrH+G/BR1B/48jfovQya2NwQ5X8i+1N1rT5wMU3mL3c3iLKkoYsZE2us8OPMA37xulu7Yv2QdHZH1GMGbZjOxm2kpAsM7fbhZcQfmzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QZ2BKDaP; arc=fail smtp.client-ip=40.93.194.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlX8JKMQu8YrPtdl/Towcqsalq+quEIAk+USuoMYuXpVTof1KOl2RkEF5K07b7CErpgANqQQ8z1zqXECtuk0CtuOavQOb1uUccR0U5XmvZ98IqCDpBe0+I8nRqca8PMFQBMlswP/8UF7TTsMifAmZHlC/bTjdeSH+U0oRy/MvUBGt12ezO0OUbxT/qx7yd5OecOM0E5ISJT4Hj7O+TN7dQJa0T8aeN3rFAKcDbx0vnSy6FIaVNMheZVOXIlA1ivRJgikJLKiqQrAPuDuriH/yYI6EMg8Ond0kzCpsL3x3PoK3mJop0aP62r0IaeMEYVZOoN4WAw0kKuasIxGw0Y5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlMIZxmgmoGkuxgIZmVkDdQe2A9iWXZlHIpKU05UXLU=;
 b=aR1QNPBEcNhCoFORZO3hK8yzprTzLKUhsuYf574PqPTTZcHLpeziMA85fC9nCPjVHdeOoE+XNCBLQNF224TIe+cNnsSGyYbL00Vduxby55D7Aw9n7Du7++E0wxQiqi+Zos3NSZux4LRH2Vm/LHr1fGaQZSSKza+lXhxuXEg4FCOOohVpdRbbx+WnU5PMJOLndSuHKn8wChQR01Jr3+RGqdk7Zgh5aGon5mrt/jF0Yw8PL5GlhWFGH0oHoqswF9fGqrAmJhR8H8/wAu+FnsEXhXBIQ9tDdUroPZ0iEuMioQ4+lh+ZUymaORQM0e4kflkAvFhVBq3yU8Sq4fciYXbO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlMIZxmgmoGkuxgIZmVkDdQe2A9iWXZlHIpKU05UXLU=;
 b=QZ2BKDaPwMcjuwiE/sLC47v2L6CGgY7OCVhir+Nsi9bqrRv5PJ+c0pinRimkqw8crSPsS1mvpqD6S/mYD0c5op6Zo+Wrj8teHSA/Z7bmXUm0W9qwCy0DzA4/vAthXmeq14Fh7lpHbcb5ar+yZ/gO1jIyPeh3rMQwU6u/GaOnoKtaBxxT2i1IK6MBZYSYS2Bq1JVuj/ubGjbhyDlAFm7HjfhQLhjHC2tpXlMQKndETzsvNTf6MHNs3s9LYMpjfX9wkVZijQ4ybDNk/H562RvwHiuLGUU/QjKVfJV+nDpYlHe+MRJZ6JrKTTp3Wxk+G5fUySXNEKD7ChEGw+kyOnwQ4A==
Received: from DS7PR03CA0141.namprd03.prod.outlook.com (2603:10b6:5:3b4::26)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Sat, 9 May
 2026 07:53:37 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::84) by DS7PR03CA0141.outlook.office365.com
 (2603:10b6:5:3b4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.20 via Frontend Transport; Sat,
 9 May 2026 07:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Sat, 9 May 2026 07:53:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 00:53:27 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 00:53:27 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 9 May 2026 00:53:22 -0700
Date: Sat, 9 May 2026 00:53:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "praan@google.com" <praan@google.com>, "kees@kernel.org"
	<kees@kernel.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>, "smostafa@google.com"
	<smostafa@google.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "jamien@nvidia.com" <jamien@nvidia.com>
Subject: Re: [PATCH rc v4 5/5] iommu/arm-smmu-v3: Detect
 ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Message-ID: <af7n7lWkf5Tc5QpB@nvidia.com>
References: <cover.1777446969.git.nicolinc@nvidia.com>
 <bb1aa2d0d1fabadb76dfef9ea9cf44f4a96c65be.1777446969.git.nicolinc@nvidia.com>
 <BN9PR11MB52767C87673D2DF9AB737E7B8C3D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52767C87673D2DF9AB737E7B8C3D2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 483467df-3ee8-462a-6f0a-08deada013ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LJD6FMaQ45OjLv5Z9jRLRMggZpd6DBnbVhS1h77RpJ+/2sQqEIydxW94t8o7dBEIDrvj66jmkyOJLJMe/NQg6p7/KOROBsmCxdivHFomPTnfliBdV99cwDiSqLFCXpf5QYpVlf7UA9Ipenk++6NghGMHWrMX2YK+GqiBjAjaGnEBUdT57YzeHHSbdJtNZSJXrgmUMwH5Hh7PGWdLUKTKkesQbmtOhrXH9mJnp/5c0Pc/aE8jtIajuYYRKZaMhashgmVBqz9iZoBJq3HG5FtDgRTwPpV0WMx/491ZGVf7B5KP0iAp5c05y5q7aJ7GRZWibC/bSgZzJpvQh8kgn7WT42PdUB54nNg4VGdS7yk8hqPWTfsRBg6mO/V0rU40VYYNg1VVWJ9Cl3p5fk0UjxYFINsVBCbEwvWF24KAdyUTsp1CYwxURmAai5UjHrht1vmdYSVbtY2nmcy03O7kWWa31/tSnbZQHxTi3z0EgvYV15uImHynpbBvadlZaoS/IMYofODc9cjFRF+94P0oENLFa3LNCUcp6uM6H9sAIBAZabDBI9dg01kheLc3364MfwrzKnX3tMQYtnTf1ewq42gOv10D756TfYULwR3i9I9Z9PrurBMWXKtDstxgAfV8RC8rCv3gWaelDUC2AM5aw97zW8hzKTBvlqU24ZZclin0oK62MQ6ZuDoB4Yvh5E7a7JCvrMhzN2vlD9C3E3EpFe1vlnIZbHZWiOII/e3j8DyXtbM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BaMK4l89CRjQyh1iuTJLj/Xc9jCwKUxkXEQkMbNItrAXDCYYYc1hqsG2o/VvOfdyXC31oHd1RfiL+dq+49qOkP2bMRZnEH+HAcQkgg8y6hSsD7ctBCxevDc2fK7irSUqVTCTfMhfhtpKz7/uSGGgs7CXb2N0sfCOWimgJsAxlrcgK3W3mM1kgvaKz+L2dnH3aJZxIOZITGNaWda9W9E4FzZT50kGxKaJwgqjVxe/6rWCb0k8JGS1ihlTZn5+jqtolRVLtSBcDw3BGXaaJAWepr49JXxJ9dH877iHLA9HE3LpppFpQxXK7B0sqOLYHA1a4/nlfXDKnB9Vk2gmZmbsQMlmZcNMzchEPIN/CPWCUCG455qBQxlC6Itq2KkLkW3K3+pr0wrCFjR5ElylIpKa9NPNKVid5C2EqHCy3LMpJ4AOMXQYzD77n6yYRj+bEwEj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 07:53:36.8178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 483467df-3ee8-462a-6f0a-08deada013ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144
X-Rspamd-Queue-Id: 91D224FE970
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244925-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 07:47:22AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > +	/*
> > +	 * If SMMU is already active in kdump case, there could be in-flight
> > DMA
> > +	 * from devices initiated by the crashed kernel.
> > +	 */
> > +	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) &
> > CR0_SMMUEN))
> > +		return;
> 
> Above comment is for the entire function. for the check here the comment
> should be that no in-fly DMA to require adoption due to SMMU disabled.

Changed it to:
	/* No adoption if SMMU is disabled (i.e., there is no in-flight DMA) */

> > +
> > +	/* For now, only support a coherent SMMU that works with
> > MEMREMAP_WB */
> > +	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY)) {
> > +		dev_warn(smmu->dev,
> > +			 "kdump: non-coherent SMMU can't adopt stream
> > table\n");
> 
> "can't adopt stream table so SMMU will be reset to block all DMAs"

That'd be a bit too long. So, I changed it to:
	"kdump: non-coherent SMMU unsupported; reset to block all DMAs\n");

Thanks
Nicolin

