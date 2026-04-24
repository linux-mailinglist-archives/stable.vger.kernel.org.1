Return-Path: <stable+bounces-241023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEqxLx+662nfQgAAu9opvQ
	(envelope-from <stable+bounces-241023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:44:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3D74628A6
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1766D30075FA
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDACF3E5EC6;
	Fri, 24 Apr 2026 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z3QJtJ8R"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8F03DA5CE;
	Fri, 24 Apr 2026 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777056273; cv=fail; b=Sv628NHW5vmfAgJvyA/cyNg6U5KbM0wo/sSc0ZmdvGxdol7sOOO+UCdEs4gpsUZkn7eZjryY4xTMsnCHHTSDoq4Ridgb+PqSIzya3tDaHv68zRDR3tsXSEqCrp55qRy1jziXL9enOtVCsUXlsrKhgJpVe6bik7oZrh4dGC7A3Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777056273; c=relaxed/simple;
	bh=wEr1RDf9PZgBc379Obya7bTl/EItrmI1oEY9PCACn5E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEsTcrQtQlJTiXxo97TF2gWDgJEUzNlcmlo38ETT33r79lzA0leKV5dTEqa5C0pOqiAYGKNiWCZHyNaV5sAinUoi+uO9FiPotnKlpKdY4L3B0TGm3Ywh+jxFCgS8z+vf6MlQxEjw4aFhlWf+KGiYEf7Hye61JtF2DYWcQvqmbiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z3QJtJ8R; arc=fail smtp.client-ip=52.101.57.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRTo08v6siKVYxCxld+TUHOc5wTNYpZdaVEiOprLKGeRLzhL6xkxLBaidsuj8+zOO5EEwsnlOEPSRYZoWORQM1eDVhXWSuVVLrZy+xW+MD16qRlAs1OZlpH2KKvJ9uhiWww8g9/BEz1tyarA8ELNDdXKIGzhHBwBzJIjYxhXnNdbw+3BCzNpL8PbGrZOR5Al1w+JyWBMP+tBzuYOOt8dr6Tdmoog88Rpai90HZwco95Pg5mlcagz+OcDNhWTscnczHmqZXkYVVKvJkw0VWt662gHwRM5s5aUFh+kJSCgo05INF/skABT9mm1MMUasJ/MCATV4885w8vbYCmLctUJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mehcwLQk7yFuKfbeMZ+FkkoLLFfwD/gT9UIwnqKtjjc=;
 b=bFv3zV720iwBve+ngxNa6VmzSAXOVEjceYsfPH0a0wx01J2oCU/W0PeWftlvsWsoy7crOYMg2QW5ct0i0FFNgxLNXL0AvXKkPLagJAuLowEx0+8zlKLezlP6mJQKK1jcGAd4XBsT2nCjnZSnzUitfx3WuNFfDVqGxTkQ23QmEl6yCmi0TgsRP10iWW1MxhVdwGAcyYg2Os8u590DSVnlLuMbjFU1pbSIjCOBZ6zcDKPZsCggHYUQNIXOzMSoAC2+mA4NmczgeI2RjA03shtpuqT2mmbYmSQ8fAGpgEhYjEqcAVlEVvE8YCmXFHmXhn99WnNYYVnu4/azJc4VeIpl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mehcwLQk7yFuKfbeMZ+FkkoLLFfwD/gT9UIwnqKtjjc=;
 b=Z3QJtJ8RuVfQPqGcju4KFydl6hKXIxPYZzfJypmbcCCic+okM+4kGCs8mAk0DRorhj34uDJZM5vCXwTosdDqmkYzGpNOaHoDikVy3wcBa9qjntUl4Sg7Imuegu+vIxe6emmRb6lEXkBgPsc78s89kJhMFWpTfCezhbCVcsubIcCiK/miIjiICCqg2F4jJAhVxTySxQ6p6inx5HDTZISEuE6qVhEhR6m0fYsbjcCAQtnbo5vDJvhNYDA9KXnm1iEzUBFK7BnMqp9DevCp9qAOU0F1KxTDp2odgC7YGoEY/BUVpMuW2l9Ubn8ljGiCcSmckEZ7mzsXaTBOlIrXH4AMmw==
Received: from SJ0PR03CA0120.namprd03.prod.outlook.com (2603:10b6:a03:333::35)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 18:44:22 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::3c) by SJ0PR03CA0120.outlook.office365.com
 (2603:10b6:a03:333::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 18:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 18:44:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 11:44:15 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 11:44:15 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 11:44:13 -0700
Date: Fri, 24 Apr 2026 11:44:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH rc v2 2/5] iommu/arm-smmu-v3: Implement
 is_attach_deferred() for kdump
Message-ID: <aeu5/HsLwfhNWpbm@Asurada-Nvidia>
References: <cover.1776286352.git.nicolinc@nvidia.com>
 <7637d66c0f6c1fb16da4b5c9c4cec71752cf4d23.1776286352.git.nicolinc@nvidia.com>
 <20260424165927.GD3444440@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260424165927.GD3444440@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 7390847b-e69a-4ac0-5f99-08dea2318018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p9zTcBseHjARo5PBghAQ+ZEr520p3OsBtNKYtXMSgYCwgzW/uM2tOmbwnnEFjgPhTHUjKLFPL4to4c7rRxHvl+vy6p4/jCgEhGJsjRw4t2xE4vUFzYDS/4VLXd8bsAvIeFZrqS1q5VJSGwulo37h6/nc56y/NZiccBFh4Ieuajdo75jxal/FFYeduP2CPAWXu0RTbMKqj07Pm2zsTzwp9VIbUuL3ltlcAOcr6ULa90AG/8+iNZbKk5epq6E889kkAChIAmto0nXWbctXKNDcUGM1Hd6qSPZBxUZU9RxqrWzTQuWMUISCSeWtUd+xEJaT/M9HA1W9cE0Gq7Y0NhBBfgRBoLpmXqA42/smtVdAh3PWaloCyFS+jhgDQtOkMum1XCwbBM2lUFuF4GrZNPvEiZck+hrxG+PpmrD8JMcIhKIqPpcco8S8Oqyl4PW0KBlEW08REGKxR5hfTH7oeBZHxePp2z3vQcwOlAMnpkli05bCZloBT9Ho609zj9iSF2tR+0lGpjeZsnXngGOJuIP8AXFvZ05NNBH6gAp4v95EgGdX9UfdtaQwYhQtPmzkpKCcrJm6DhelvpG3Mqhpt5U/ybg2tNyHW5SFVDzN9gtOACtWHNmI1bhcHN84uT1yOU6PN7Yp37k8TgvSlMR4O6yBihPtW1mXnBQ/YAwPL4OzpKwbd/xj4lPWKi3TIg1XPUyxamUrXCWUfyg72gMLxOuegKT2LlNEMG7/EIosdXVUzrBtt+Jdlv+Cx9lzooeHEsPIts88Kz2MGfAVUzPoaLGJiA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yJ22TiL4Bjs4SSM86G7upw5YLIL/zdDj11QhZG3hIc/OwZ+mu9ySc9XVXFirLn6yDLNMIjLkKod3jVtMMujsI4XaGPGbntxTKW+osx4uBDWte39+HqE+ydxCkPO2PUKEeIrQ8FfI7r26vQ9kPE5R4izYmScxmBvDr0IANddm8BcXzOMhE7y0jS08wlc9vyZH6VaAFlVS+NOUY7Q3FfMY8EjFz784GsbknYGNGBs7uQa1/P8xTB14oy9Hl82yReJAliovoPfwrfEGjthGjSb0TXknsr8kOr0vjVGhW5lDvB5+3xiuhU+zC/ez4Vv0dbiR3B/acC+MaMhQjs+koQdxn8lckL0Gt2P98Bf8Uy2sjaDFj7GnjC/W2AQ5g9fnWTTiOf4kCHvhZitRN2cqI6x3oTpQpQHkqYISHyKQ9k8AGIfi6WTjSmg9BubV6d4tGy7B
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 18:44:21.9234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7390847b-e69a-4ac0-5f99-08dea2318018
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341
X-Rspamd-Queue-Id: 3C3D74628A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241023-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]

On Fri, Apr 24, 2026 at 01:59:27PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 15, 2026 at 02:17:37PM -0700, Nicolin Chen wrote:
> > +static bool arm_smmu_is_attach_deferred(struct device *dev)
> > +{
> > +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > +	struct arm_smmu_device *smmu = master->smmu;
> > +	int i;
> > +
> > +	if (!(smmu->options & ARM_SMMU_OPT_KDUMP))
> > +		return false;
> > +
> > +	for (i = 0; i < master->num_streams; i++) {
> > +		u32 sid = master->streams[i].id;
> > +		struct arm_smmu_ste *step;
> > +
> > +		/* Guard against unpopulated L2 entries in the adopted table */
> > +		if ((smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) &&
> > +		    !smmu->strtab_cfg.l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)])
> > +			continue;
> 
> This can probably just call arm_smmu_init_sid_strtab()
> 
> I think it is OK to allocate another level 2 here and it also has
> protections for SID out of range..

Actually, sashiko pointed out that this guard is a dead code.

arm_smmu_init_sid_strtab() is called in arm_smmu_insert_master().

Thanks
Nicolin

