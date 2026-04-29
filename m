Return-Path: <stable+bounces-241950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ft0K1N68mnjrgEAu9opvQ
	(envelope-from <stable+bounces-241950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 23:38:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C99149AA42
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 23:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAB9830209D9
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F1E3ACA46;
	Wed, 29 Apr 2026 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ighhV2sH"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DED277C9D;
	Wed, 29 Apr 2026 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777498699; cv=fail; b=P7jaM+FcNz/BOyseU1G1gvkYv4SzxrkrCK5cAAc2+t54DbcxMAedPK4dzVfX8IGjy9X/TBHfwygh1NrbH9fmsIFoxTu1D7RB/yyJF4/Gv5SkYzYjyM6ctG1yPJKiZJYUwXYIrUl/KRVAggC29FzrEv09M1UKZk5UxsCtIU8V2Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777498699; c=relaxed/simple;
	bh=584yHut2/+3rsagrFJW+MLpWsW3Yme4yPE/RfO5LEZM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZnbhK2EyN2e2SWGepZ3P1fO7dC1cxM2P6UJAaDlEXnD9E4cV5eak+rnIz2+GpdirgH+HhMscn8oym5Hz8PS8XiW7qAYCtAJvx3io//MHht8ByxK+h4d+UOwfvEg32I1WErm8tAjS/Y5pTfcOnFDGPTUswziiwCQNKtWEwYB7Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ighhV2sH; arc=fail smtp.client-ip=52.101.62.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRaKFmMYxumeD7Ftj0Pqyr47k7t8NtERAsh4jKG/KsJTu189dsORey4w8LrzrBgPQl0IfX9uwGWB0IrD0m0jVC4rqzDPrDq5XrPqZrZJEKplRddbKFW9WJ0Z/4R5GIWMcu1fu+XrtlYD090AKBnOcvodLgIim3M54L+JKHDiZF24s2k2FK9K2Zs8pxBemikMc0oMmpnY0E8K3Y0DYxzsWQqzudXZKmkN4vb1LQkDBU3h5drG8E8uWO/yzzmpz43O7/Hg7/PZduEjx80LgYD2+7lI14NFxy3SCCZLxd4ZZRsK9vu9KvafIkALoQ54tFCCKkkIrLD+gnPYHSxZtmm/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwYya9kj9ebLJmfPo/BibPB0Rvmdjnri+4NZxs4H/KQ=;
 b=NRewX+UKF3CM903bJ8HVXp6YM0FLC3lnp3gEL7ExVd78vAJaVW9Ehi0QSI5Z4i7vV5YbX6GwE02ICPC0RYdHBlQ8/egCZ/O2D8o6RGle97+v8xQMfG9U7Xuh9D8WqN5jOdbM6EzVIjGywzQNwW6VrVj8l7JvE4fJThLwwlF/6oIGe3TTBTwXhCtuUl7rrNSglpo/E29JKg6IDSCVn/J0qsDCxowRmhql5vAxW8PvMcSpSW93OwNTnS9ZY3aXw3NKo2svq5zJX5g6BEs9mtiyjwyLFWKu5SyV8TQQHVGl4xxT+oYly5Ns9rbnclWp14Hx8n+OgD7UDuPU14PSx34NwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwYya9kj9ebLJmfPo/BibPB0Rvmdjnri+4NZxs4H/KQ=;
 b=ighhV2sHSGpIN7GGaLFm+KiHfRNrMKSTHNfJv+FxCCgXnPOJvRX8fR3vdWaTWf0XT2+OrMPjSFQML1wXI9G//jS8SisGzj6FCIIwEh3Tw37SKqWGV1tpp2z6AJYkXBI/jscGo3hyQo+QA5tldbw1YEjpoAdnW+98dej76Ug7tWU4lvTiObOu8bkko+4rlpIWoiXcp9kqczc7XEHptySKmljoJGJwsWvIY3PwQJI5zoAmvKmZ4W9Tm6AeREtEuCugtBGBbrq1z1iJZUSgnv6+ZlxTZkHfKOdAbSsZcS8ohuDsht/khF/ukF2aYtN+GCBq6zbaBULBKzYzXgyWQSUqlQ==
Received: from CH0PR03CA0210.namprd03.prod.outlook.com (2603:10b6:610:e4::35)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 21:38:12 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::9d) by CH0PR03CA0210.outlook.office365.com
 (2603:10b6:610:e4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 21:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 21:38:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 14:37:52 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 29 Apr 2026 14:37:52 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Apr 2026 14:37:51 -0700
Date: Wed, 29 Apr 2026 14:37:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH rc v4 1/5] iommu/arm-smmu-v3: Add
 arm_smmu_kdump_adopt_strtab() for kdump
Message-ID: <afJ6Lu0aZyff5TYZ@Asurada-Nvidia>
References: <cover.1777446969.git.nicolinc@nvidia.com>
 <edc9df0e05559ee3edfeb833b84d421d9b040dba.1777446969.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <edc9df0e05559ee3edfeb833b84d421d9b040dba.1777446969.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 383313f3-8a5a-470b-8597-08dea6379d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vHTC4VwDCKqM0qOxHjRhqlQ1EAROrR27BvBH7t2iv78Xqib+vOy+UswN+nRxKE04HGs+X56ycWcu0clYg5ISTg/QFSxbdeHLHQp6cFlmCYpaXKKWdaQNitgRBFGj1xqZZWxd1NebEdjUwNbzh9Ifn5WoMq/ZfndvTp6W8sP+PCSJKLTdXpnMVR9Bno/cibWtO7m4owCKPBKuse7jOdAKTyEcLi2wmrW7c9RQiIJ9A1gtyytIpAzasa4Vri2f3QPNmxVSqjU23iG9Skah54gxfGHMIjMlBPK45Or6tYu+QJkjORGKSaLnfM56h2UD5RF+FEuhII2tleLpKqlfudAjoz4I0WbBChRFlJbQrDW1zCNoF4bAuxmRQ+R1WgU8rPJNtOE+6yHgmzF2FOOPbFm9QVijPErqFp8W5/yry4ekVhLrChKHN5NIBEZTNSBsAZeRUyFOliMjiPlc2V5lRtc8a/TJ6fGrMnKwjEcFivopUpQd6e9g+AO3iD4+70k+QVB2+Nqozf8EFH9+sGkx7C4gqJRCN7nAdPk5ghGkQZkQ3VXwwILBPnZhjuS7bLGbE6tpjK2b8LesixuaQmnc36o4w3XQgnxHwKPxeZO35XdOeMcIwmCiH8UTfM2nI75NCGtSz/F4KH6OiG1nE0Pb58vuRC0+p0g9XFst+H2oLL6CwhYowqgwWuc2QtEo3CQF/11ZS7IU1ali7fRPtQHN2bUEhXKTz0ouW4ZhNiaBidC1Uk+NES9zUMD1v7IwMiXfLnJmrC1TupFMoyBICKJ67U8maA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3cn9di45m+7c7zJGvmgJX3bpqQaGQoC58W4sWdq+5cEaWnyt1hrrzhkuXo3FJ/87lgpJYhj2Zpf2yrqVdzNyjprEzJ7wT1CKxMR0wuVHENt0tdBQmZouzOJ1bqePzPClwmNbsOdu1sJacWP3ZxoK/7D4WuztQcT1MGEW1yi9BAQRzMBtja0iG2lCkn7DDpHQkopIOgM/ma7m4DXrQfYNTUeucj1R8BrPUuvrsjktdg4sqpETmiLbmMXT87DleuOt1zdpX3yAiPXCKTRVS8Xhzg0dDqtWY24tNdV8ciZUHPSE7qbWYBWO4Dhq5Y8ejk59Z3fBtgzlcGm7MaPSJ3kvJgDN+Mxk5bq2XBDBhYeLhO7J1qSjZf3Lqbb8tiFPTSGLRbpOomdS7wvcwo652uUYLSgTc7JvYX2tayVHKdDbcPK72aztyrSYigAIu+jdaU0X
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 21:38:12.4123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 383313f3-8a5a-470b-8597-08dea6379d4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211
X-Rspamd-Queue-Id: 9C99149AA42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241950-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

On Wed, Apr 29, 2026 at 12:20:49AM -0700, Nicolin Chen wrote:

> +static int arm_smmu_kdump_adopt_strtab_2lvl(struct arm_smmu_device *smmu,
> +					    u32 cfg_reg, dma_addr_t dma)
[...]
> +	for (i = 0; i < num_l1_ents; i++) {
> +		u64 l2ptr = le64_to_cpu(cfg->l2.l1tab[i].l2ptr);

Sashiko pointed out a missing READ_ON here.

And in arm_smmu_is_attach_deferred() too.

I've made a small change to my local v5 tree:

@@ -4337,7 +4337,8 @@ static bool arm_smmu_is_attach_deferred(struct device *dev)
        for (i = 0; i < master->num_streams; i++) {
                struct arm_smmu_ste *ste =
                        arm_smmu_get_step_for_sid(smmu, master->streams[i].id);
-               u64 ent0 = le64_to_cpu(ste->data[0]);
+               /* Pairing READ_ONCE() with the WRITE_ONCE() in entry_set() */
+               u64 ent0 = le64_to_cpu(READ_ONCE(ste->data[0]));

                /* Defer only when there might be in-flight DMAs */
                if ((ent0 & STRTAB_STE_0_V) &&
@@ -4747,7 +4748,8 @@ static int arm_smmu_kdump_adopt_strtab_2lvl(struct arm_smmu_device *smmu,
                return -ENOMEM;

        for (i = 0; i < num_l1_ents; i++) {
-               u64 l2ptr = le64_to_cpu(cfg->l2.l1tab[i].l2ptr);
+               /* L1 entry is shared with the SMMU and possibly rogue DMA */
+               u64 l2ptr = le64_to_cpu(READ_ONCE(cfg->l2.l1tab[i].l2ptr));
                dma_addr_t l2_dma = l2ptr & STRTAB_L1_DESC_L2PTR_MASK;
                u32 span = FIELD_GET(STRTAB_L1_DESC_SPAN, l2ptr);

Given these are two small changes, they shouldn't block community
review. I will wait for a few days before finalizing/sending v5.

Thanks
Nicolin

