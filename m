Return-Path: <stable+bounces-241022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zW40N6+362nfQgAAu9opvQ
	(envelope-from <stable+bounces-241022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:34:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC334627BA
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1AE22300A587
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4403F0AA7;
	Fri, 24 Apr 2026 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mHogqlyj"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564662DD60E;
	Fri, 24 Apr 2026 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777055613; cv=fail; b=byv7ehkbHIFhIBVRsLmWlCIDQU9NarXubVimUcrsLnv8eR7nEegloUjKNwcOzQ7LIAWijF4NUSNE/NuXh7AWmWH+S0YMdaFTVg4FBxohka5FBN0TKIyWGpbUrwnSk7fT2mvCHtBO2UyfMJvgShziCcUBGy0lLCn5JS/VvEsWA7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777055613; c=relaxed/simple;
	bh=pyCWTSLPKQwiX1xxCaKDsnCXoC+Cq1asyjgfG8JJYF4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS7K/LmRxFZwTpM59F2yx3ShDxXZ5D5lsZHLhS9sewirkQIOsDqFCgUIJ2JkYbpDeQMU7IaPD4BsQGKFpHZPO9DmS29Ce494kscJGWyAETJVbr8wfNGY7jKx/MqpgJMzS5cx06XSXQHZx0V+wT/iN0VdYwpDT+7Kbk9sjzeSkYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mHogqlyj; arc=fail smtp.client-ip=40.107.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpDrD7PGI2RDgvm0myjkIpsxD76U7dATgTIOkG4zmHAZaktttgbmnK1SzakeGyQlC4a5lPUDbHwTBtRfoHp4XgfC/YyHOj+1qXCK0OorbnjhXsDEZAof/+xEGH/cfAgXWdXo2fnT+eeknk7/FljbO1GEvSEmTT879ngU3oOQehLfs7VK7sNAwDehafUGTuFevmogvrAy55d32h/ns92Nz9np7MtB5WsxdMwQx61sQxnYUVvzDrx3TDyWekKm5dy88Zwo0jOXlxrMl3ViSCfouwOiiKO38tF5x8ZkT4Sk5I7dT79XgmSkepj3bT6BZ3TrZ1i8kaAcCrv0yyqJkA1kiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5EpQwZhAJjdbm3QzuvXtwgjsIJmE75H3o2MtIcAqFI=;
 b=eJHO70hM/Uvm7hAfRk2wu4v8CH/8UacT/fmpGZDMHciXR2zR3v2tMwWY6U8gEzLao6qgJsyCkz5a844/H1/Dg+qHYK34KXAkt+NrtAkfYgBi4nhx5YMFwobDTq2IaYL4EAewCskTuoJ2YZQzghggNxe9631nOx5nL5bj/ZfmyeCK9haYtchc/6K+9MIiuc8c+46gginCtH03sEadSCrxsGPBnYoUYesA/rSGdDmJAe9VKnAXuGfMOWVcpUEB0Hw5mnrviZvqpq/lE8J0HF//E463y5gQkbP5uGlFusIkL4fGc3wdz/0MpHeLV5OKFEPCmn1p1Dz8/VaEACc48DrNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5EpQwZhAJjdbm3QzuvXtwgjsIJmE75H3o2MtIcAqFI=;
 b=mHogqlyjRA1JdPyZUx/QARYe2Zwh0lVbUkbhmDuIgGf/S/nGCQ4BnqGtqpjHCRCOBis23xro1R8LhZF/mHkYxDJeWJObz4GpToZ/mIRTaW1XDmbWUBi/rmRf6fXQMY62bpGBpw21r0YipmQhgNJg97kb9TJqte0IWBwqBYpGJkfGdDB4LskGdtBMoRk347vxcxXGLCmmjSAiKObaZWiCwqbex027BuBdTh2Ko4u4vcQalfN/zE6hchRadlvcR3qG0ax7SPvmZMCj9eZnvq4dv8mpnzclfrQw7Q/2KzwaMU3KnwW3/I/tYvcH6WUog65wpCRDifit4HRSTN+8uthZ1w==
Received: from BN9PR03CA0381.namprd03.prod.outlook.com (2603:10b6:408:f7::26)
 by MW4PR12MB6852.namprd12.prod.outlook.com (2603:10b6:303:207::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Fri, 24 Apr
 2026 18:33:27 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::52) by BN9PR03CA0381.outlook.office365.com
 (2603:10b6:408:f7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 18:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 18:33:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 11:33:18 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Apr 2026 11:33:18 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 11:33:17 -0700
Date: Fri, 24 Apr 2026 11:33:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH rc v2 1/5] iommu/arm-smmu-v3: Add arm_smmu_adopt_strtab()
 for kdump
Message-ID: <aeu3bNxCsy8azLOO@Asurada-Nvidia>
References: <cover.1776286352.git.nicolinc@nvidia.com>
 <af5fb880e771bc31ba42644ae5570e1fa208217a.1776286352.git.nicolinc@nvidia.com>
 <20260424165613.GC3444440@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260424165613.GC3444440@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|MW4PR12MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c26bb8e-7044-4080-2d29-08dea22ff9ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ztH/kNvrZf5sZne0iqMNF/yv79hnVXbgBOMEDaJZ4Yp+0WgU1oatW+n2Ob3kfSIUPayLJ8JuQ6pyUz5DmCJttsqjwK3U6hNpBkaIRD7BpGWFCpzkMCf0fWckKUgR9+P5usyCKG64lLiBBh1bpFbxsnZkkgoIiy9r4m/ZYDM3JZ1XlmLRmu+M86OJOz+nM8CHz8PCALa+nPYnYmXVxhOvlGweJKUOvCdc8/oQxKDP/IpehaXfJJxM43dpdXTWZja5l2oWy+OQvhK/wTxioIih1DlRSuzJMDXYEx4Ew1kyDKZbKYU0FSv28zZjaBxOCe/qPL+8M/sxM/L8Sidx6lj2F1zx6d3NL2uem+Di7yWI5lPBaJS2FNNFtFg8RNKqhRD4KxhuHDkN/b0zZwdcisIfrMRUaGGtOhuQHXTki7EnyKuphDbe7PdQaGzMpaLoROqI+4hk8KyfMC4Hz5x7rPtLHigo3AB3cQw32dUe/VwmnBcZpKmgHYh+9XdoXelH8De2q07oR6OOR4CxAVe4xpS4f8HnOA84ECecYRdhmCN6bIDbYtcPChTrBav8jOYzDtitTGov7dvzDVgRziWjAIvhn7OzM+739b8WCixznMvwwdEVpaCEXT05NP1CjLAvW1tSrJpkR5TwG90wcCU0KJin36KnJxLrm/LwyXvvfKDGZ0tQfHKPQ+0fG8kqvzwXrnd/65BD8feaZWrHVpNicV4SmGsa4DR0y7IfXUFTq8LnaXO7ba6wF6fQ49ED9F6qHHpZcfxM3THC7DQjvjP3uiNvnA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bmDuVLcu0KGkkpqaXPnSZI7dCrbfpBJVwitrRVg/pgDC13O+fzID+JLu6j7SYzl6qVVdkL3N7nmVHheSYEOT7Azhd59EpMhUUmdBvIo3U6dfB1U8DAfKOTp4fjAcB0UYphFqVpQR/YTj9rpdRUyXxNJDDbOwyB9TQfNhgTOedlPjDRzCn07dhyHcn25m0soSbpx+zjdVgmDFQsmHXvRGOSCS1CHgjBcVDZRYczp1xQwyJIpEog6JOn7KffJKhC8GEv80s5s4k7BC5Crqt6QtGWyYuZPA0iYVwFPT5iin/L3QtluhPsP6OhUNHYn282PpF7tuVL8Ry0dvv4V3bGPz9HgGHlPp07C08OdRLV4SrdqGQKine5/5xiTldoZWAkcjTB2U8ftRoXAxCPffSdJSUtBUAcOg6U3UMEEwgTq5Ua+OFzs3T5tRSXz7zL5X192+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 18:33:26.7763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c26bb8e-7044-4080-2d29-08dea22ff9ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6852
X-Rspamd-Queue-Id: EBC334627BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241022-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]

On Fri, Apr 24, 2026 at 01:56:13PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 15, 2026 at 02:17:36PM -0700, Nicolin Chen wrote:
> > +static int arm_smmu_adopt_strtab_2lvl(struct arm_smmu_device *smmu, u32 cfg_reg,
[..]
> > +	cfg->l2.l1tab = devm_memremap(
> > +		smmu->dev, dma, num_l1_ents * sizeof(struct arm_smmu_strtab_l1),
> > +		MEMREMAP_WB);
> 
> WB shouldn't be unconditional? If the SMMU is working non-coherently
> we need to map it NC. Same remark everwhere

Hmm, I am trying to add a coherent-only gate for the series.

MEMREMAP_WC might work. But we cannot verify that on a coherent
SMMU, right?

Nicolin

