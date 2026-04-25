Return-Path: <stable+bounces-241086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DaBRGj0R7Gl8UAAAu9opvQ
	(envelope-from <stable+bounces-241086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:56:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB4846457F
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0748C3010BA7
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919871DE894;
	Sat, 25 Apr 2026 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JJU8NVDb"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100161DA62E;
	Sat, 25 Apr 2026 00:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777078585; cv=fail; b=J5B/REi3n4T/2Tjplpg6vAYxARaxUEHUdknJJ0kUTu5fGGSfshzpoaNHbKyzPGKOgJn5+GyrX8UBsJJQLXqxz7myaQw/kQ7zf3sR8KGMYUgzIsyu7eVbwGKnoOzUmRRY3R6CDSVUGcVeYHTuRMrGX8HvzHABpEGD3iGmRycpQ80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777078585; c=relaxed/simple;
	bh=GNmfdOQdx+m8+/BgoB9tAZ53jlOdZ+xb7K58e+YfFpw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVFOqcdepPwa7p2uMHGmPpznJv+lXOI5k65RPAQigvuMFU1nlI5uaGA5/jZDAqOmFq6XB9c6lQWw7CygbE5uNw+KCnqlynm/2MzVNMkw2IfqI2mTCa8sTVfWiOuA4cjRiivDeGktyPYr408ffAkOuiCYvqkVr4sqaHrqlo1pQi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JJU8NVDb; arc=fail smtp.client-ip=52.101.62.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqjrTfQIdUqwcDieyDPjTP5gO/A5AfM9E3f28ALTCTj+KAfDW7NZqv9QeGujrB9dAnfVVeQZXxsJC7Y22TExc58BZ4+nMPDc+SRc3fNL5YdW3j8QbtNH6G6ZiPuS7rp3s4tTTDu1DdoCEQJcEqSQbmKRbActKjILYAD+mFTII5zL6zJhieZ/UzXf+9QCcbrni36GZpLnuR4jIjTM/lPd6SSiSoCisAk0zU12CdXV0U3YPXEwfV/EVpSuUSsfarawGQ1Tdrb7P0HrJ8ll+elF6YSBy4zLpDAGjZzYtiR9tpePKlqAO+4cOiqNhoZQmKKPKzi+xQ2K9qBXAXLFyuU72A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH0QlMe9YN5VEUfrYOeQcyOTjstkyS1jpsbo+gpYwIc=;
 b=gBk7ZukIbw4RfwNszK17S+PM7wvTL5zwdM5HicsI0eLZ97Py2WB7PMfwOL+XWqoj0Mi+0UJAkguV6MCzzJciaw75CWNa3QBM2KWgV1erZ+VCQ2m41BL+ENJHZ0B6DVRh4meGRE2iTjacDaA5ELWdaBhsfF50TPygcxTlGgnOR5rGe6X1xZJAtIsaNa1YtbZqcxokvvMEnzhS/FXzOu2geO1FRIVZXcddvUHd1m+ZyucFOP7koB5t0ipBgvxLCZulJsJ5H1cciAVK15fxHSwgmb3K1VeLxxMjlYAS1mD6exqQ/V5L8utsIT1Rj0lSI2N6niprQSumpSSLk/Sjwk2A0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH0QlMe9YN5VEUfrYOeQcyOTjstkyS1jpsbo+gpYwIc=;
 b=JJU8NVDbSEvfTSAPyAhKhiTz6coc9XMh6WXruPGx1FHUZmh/n7WtbF40RYrKqFsqeOLN/NtfQrnCPrsvsHnXhwyfvz4AbHdOcq6EgE5HYtOW9P7N6s9nD9GKBsdDIJgW8S/bXeWVK0W8abJKYwvLH65MPo1rrxWjRg2IDckLFgG79oZ96rOE23Uzn9bhMxYmiPVw0vqF+BGQOSLI577LSod2CC0K8iTDzjOU0KyOFdJFo4gI3lody2Guh4q3YTP/VmyXxqkDRDtWoWTL4HFuD3AybHzIH2h9h1xGp4orQmBigfWZuwOxQgVgKoneiectAeGBY4pTcJLV7ln16evhFQ==
Received: from MN2PR13CA0029.namprd13.prod.outlook.com (2603:10b6:208:160::42)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Sat, 25 Apr
 2026 00:56:20 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::db) by MN2PR13CA0029.outlook.office365.com
 (2603:10b6:208:160::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Sat,
 25 Apr 2026 00:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 00:56:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 17:56:13 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Apr 2026 17:56:13 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 17:56:12 -0700
Date: Fri, 24 Apr 2026 17:56:11 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH rc v2 1/5] iommu/arm-smmu-v3: Add arm_smmu_adopt_strtab()
 for kdump
Message-ID: <aewRKxYcYQY9TkA+@Asurada-Nvidia>
References: <cover.1776286352.git.nicolinc@nvidia.com>
 <af5fb880e771bc31ba42644ae5570e1fa208217a.1776286352.git.nicolinc@nvidia.com>
 <20260424165613.GC3444440@nvidia.com>
 <aeu3bNxCsy8azLOO@Asurada-Nvidia>
 <20260424205031.GK3444440@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260424205031.GK3444440@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: c9042073-023a-4c24-3204-08dea2657704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CZ8s74SSWS79NUlSCBIT00VLGv4oXPBYGzDCpd7NWvFW0vYfOYMAKRAwwT2LalZ+hGTGxM+4QYrGFc1NbL4ioV0COsxUpkMSlqB3jY2wdgffQt5lbDI98v40RN/mnI5BodQTVDeNgH3BkzrdvNKO8romJGYnvB4ci4Z5heuUaMxxObQdy5kogtVGFhkgk/Ka3mK3aQq1EZ7SNhG7s6+gAZxn526+ZfR7ZpxFxrc2I1Y+6Ehbod7YLn7RRQ5DRZoaSagW1jC/61nCKRQZMaIdJe/Q4bxmUFK/lEYYbO9sq7ypzR0UWjZnPOW+2zwnnnarfxeQKP9Z14AFJayU7mdoRvuEGkXHfm98zO+6D1hVBm/7e9RHIn8QiJJK3cYTzxrolxyvME9X5StUWvHymaroDZb/PdS9e1fK4M6mxOZuY76DTutEtVDeNQoaTI9XzfJXaRcbLr6lSfs6XtXWyxsQcgz/oFadbCSMWHa2n49G6cfuxUe/P0Z2ZREdfB5UW1RKU3gKg5dhPMOux8Exmxf949ODD24BihIL16+q/jsfr9AhTqZAdi2y8WD+kWdMYPwEYuNiyRLLpygNa99G2qPaA/ZDlCOldI3gl5taEb81LyXcJscVlPplu5PDK0E8Il4sNFi1PiDxfLhN/ZzsuBzzmyJnNIjV0jhhIONhZLQ2Nrsx5e24h+6iMaGsLvyVU9f7M2boaCCcc8xhHfc91tkyzxZf4qjIUgYOhsYDySad1V2QrMygLNjcvMn2I+2Ot+ZtCYVAg8RBqGJX7Ooc0pmd8w==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gsmIWBXA+em2tzUc4/W9m/QTIpTWR96KVrBJkaQJFmaqQft8LGNn+jAbKeB9NrfWv/uStbBH8rrVoAGfjGyPvTx9200E8/iobHnP8xiv/C/jxLqfTPYIkTdajWNq7rPVw664Fu7LoGTN76Q1LEEuQr9Im2CIRAvkV4mOCWXbpkDnHK9pEl0XPmjl83cMgH4DYG3N6D8oaoIRWjI82exQBoQjDtKoLaZ2jFuLHtJVhl+Lmapy5bkKVjdKHr0QSLUSHSxt6MgqQzA1gSRnVl+g4B2EngUNgq+6wf/Lkp6xqw2a44pPGY97PjVuyLOaQGf43vPYBPBA+/q2SVK0lVc8PkWF8vCeUzVciR7ewHKzLJAJOAJx6pSDiTd7clN9n03he74G60I1UillWOrY6GO9e9V/IwQIjAtuYHi0mjmGQvPtvp4iFgEx+kHYRYcMUdvw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 00:56:20.4022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9042073-023a-4c24-3204-08dea2657704
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
X-Rspamd-Queue-Id: CEB4846457F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241086-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]

On Fri, Apr 24, 2026 at 05:50:31PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 24, 2026 at 11:33:16AM -0700, Nicolin Chen wrote:
> > On Fri, Apr 24, 2026 at 01:56:13PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Apr 15, 2026 at 02:17:36PM -0700, Nicolin Chen wrote:
> > > > +static int arm_smmu_adopt_strtab_2lvl(struct arm_smmu_device *smmu, u32 cfg_reg,
> > [..]
> > > > +	cfg->l2.l1tab = devm_memremap(
> > > > +		smmu->dev, dma, num_l1_ents * sizeof(struct arm_smmu_strtab_l1),
> > > > +		MEMREMAP_WB);
> > > 
> > > WB shouldn't be unconditional? If the SMMU is working non-coherently
> > > we need to map it NC. Same remark everwhere
> > 
> > Hmm, I am trying to add a coherent-only gate for the series.
> 
> OK, may just add a comment to that effect here

Yea, I will add an assertion to the adopt functions as well.

> > MEMREMAP_WC might work. But we cannot verify that on a coherent
> > SMMU, right?
> 
> At most you could fake the smmu to noncoherent and check it maps the
> right thing and assume the arch code does it right

I see. I tend to leave it until somebody can verify. It should be
easy to make a followup change:
	unsigned long flags = coherent ? MEMREMAP_WB : MEMREMAP_WC;

Thanks
Nicolin

