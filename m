Return-Path: <stable+bounces-161486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E63AFF130
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 20:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF49544F40
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 18:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECE323BCEC;
	Wed,  9 Jul 2025 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wun486qS"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B02367D7;
	Wed,  9 Jul 2025 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087257; cv=fail; b=PacF6uBUafdSV3CMoAwQZkjh0kKUoIvYW0mDv9+26FkF6w+CHObHP0MtECP0+udKZHh8XZyufh2Pv80W7Z3lqatRpP9LJQmC2lAC7xNSeqjw5FzfxEUryxCCLSVJoQi27Mjn1tzWGftZ0txNLSS53VY4Wsg2KpwRuX5aLmC57mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087257; c=relaxed/simple;
	bh=dz66vuwNEKtY0awqg9xi+zmcTBYGekcVgscsw/9A5P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m9//V1f0iPpt/nNXXSZXRmBp6zYMwMDKPWicnZHam4HXFmlLw3B3xHLkEw9lvlhUZdPZmyKl4S4z7qdWyiFKPIFvubcjsHjsPxkwKiJaRuQACBwld79OupiYSFNBQQxtz3fB1DMDB//Gkgd7k632JesDPKHjzpyGaTyHe1ykAHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wun486qS; arc=fail smtp.client-ip=40.107.100.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoW4Ik1rJyPVwEb+7bG/fczUXKs/jbTP9EB/gE1ZC1xanS75wr1Z7oi35D7UUpbwghdeP/9odVuONIyFzkdmQZWqXPdHjyLSzoz+wxvOX5M9PgxPlp25zSA3s66MPtqOyx0L6Txi740GYdaXGcABU5fcsiqbkWQzJ6edhknmxk8nWfrLCAGD7oy3FLA2ghqUvEec9FkimV4aelialGihQG14ZDNW8A0NAZSCx4tExdt6rT8R3FK79DLhLCFJB7hxpU2LoXb7EgXNrjoFtaKyJR5E2RwLb+2fEoir1PvHC43pqkfyu+ypSDhugnu5TfFQUtEMT5C+nRDhrw0d5sjZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dz66vuwNEKtY0awqg9xi+zmcTBYGekcVgscsw/9A5P0=;
 b=ie8L+KrGSeLIhnhgdqhA4y0gH5fYdrVHF7eSJi8tL/r54k9zdrMaSYXez6J6JnpJ9zBoG9uuVgKzVpCdQfAQMowR2+qU9xwusKj5oZYMISQVSDjRNJhBf+5MF3sBfSt1l9O5iU2yY7mzPm1L02vX/wqY848BnpH1D9iNA4UAkqB+XG8JMnyoZ2ViclTAzLBC+1ftrwIHtoN8JSWgfIl2+bbSO6DQcUN7Ki+5OXZNHTV6KIkR2qSCZbfqRSPll7otfqU82467y15aq0Xx+7RDJPfyWcKjci9KPRYT/XLBOfm7871mFKJAwUSgc96miYhJHi7sZCZ5NuaG6/Los2/85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dz66vuwNEKtY0awqg9xi+zmcTBYGekcVgscsw/9A5P0=;
 b=Wun486qSDhpl+4ENxepxdJhUYspsVdhMpjvWpSEp3eAPp7DA3cxHJ5OeXAOLZKbRcc023oG2TVJZ3hyujB6qdZioNMy6q0dKrxPWs4TxK3k/9BL3ble+gO6lax1F6qfR/wepUaiDwnu1YINBzsVnIVvmWsNHO9hiQcc4E27fMTMOdSX9LyGo2HSHa8Q64sHi7SopViwbfwfGJHyihVWcECG5KmbK03a8o5+c2mjjYCADqOutGFhr0VHHIyeLf5N83zfPC5kTzCZalJ7J76yN/v9MeKnbZ2MRCklpwfyS1FJfw6vNxBrPrm71EnDxoD7Z4ja/I/tBa26mgyIVZLvGZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB9527.namprd12.prod.outlook.com (2603:10b6:8:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 18:54:12 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 18:54:12 +0000
Date: Wed, 9 Jul 2025 15:54:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, iommu@lists.linux.dev,
	security@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Message-ID: <20250709185411.GJ1599700@nvidia.com>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
 <20250709085158.0f050630@DESKTOP-0403QTC.>
 <20250709162724.GE1599700@nvidia.com>
 <20250709111527.5ba9bc31@DESKTOP-0403QTC.>
 <42c500b8-6ffb-4793-85c0-d3fbae0116f1@intel.com>
 <20250709114432.294425ff@DESKTOP-0403QTC.>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709114432.294425ff@DESKTOP-0403QTC.>
X-ClientProxiedBy: BL1PR13CA0196.namprd13.prod.outlook.com
 (2603:10b6:208:2be::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB9527:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d3e276-f177-4b15-c21a-08ddbf19febf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qKQvoJu5dCAphwvuzQHUZgut6Wat5ENbQDBjbpt1N4TnQm3LtAa09yjjWmmy?=
 =?us-ascii?Q?W0ac/Cieb6Rc9pyp2tYMFwi+LeLhzH9GpRx83pDPFGfc9q38OQIi9Tb11Cj+?=
 =?us-ascii?Q?q4ArJ9UAz2WnT6fuifrvC9hLxx0jhZXn6oW3J0/PPlxO+okR/w7tv8j8FnxC?=
 =?us-ascii?Q?oZkYQMtw6J+v9Cit20MvzwKoG95VFepaiTNu/dSwpf+n6ufOmGbwhgQ1WzVa?=
 =?us-ascii?Q?47ALZ1r/+PUVNoa4yQqSZCPJOGMvIiY+eOQOTGZZdvaIwxT+ZpjGLgllUDNk?=
 =?us-ascii?Q?48PnJkTOiio1tfgHNIRF6ou1JjxlluMgZ3lgixD1pr7eh6HsQ55Ys0+cAJd5?=
 =?us-ascii?Q?09O8kgasFf/vG0foPmrLXAK+x1CNejbvg6knIYRdzYAx3rarzrTNWxrvwKtA?=
 =?us-ascii?Q?0erusGbGQpSZP73F7z3gHttovcs0xNZx+IJDGdqHa731pOl71fh+4goVfpNP?=
 =?us-ascii?Q?z9rOPRC4bxR3uNBj0+B907qRzBH70hcn1muKw6W0BMEVTNAT2/c/kfZdNoQP?=
 =?us-ascii?Q?DQ9RlUTYjl5u73ALt1fgM14d0aQmr9hjUc+hWRt1LwjgAbjo8uPXPb/Yn6zg?=
 =?us-ascii?Q?VPApd0on17LXbEmLuYDJlyJ4UoL4ENq8WojxZ0YeeqyGfOoGja+8GuTWCsdl?=
 =?us-ascii?Q?I7SC8aBn3+C96VZGsc1ceN968nhIMe6cS4WtNC0/3Lu7GhTCrhAQoGmeY4br?=
 =?us-ascii?Q?1Z7QtFFofLtzXK4bwuRASo6zQ1BPrIkDPZrsNf2w0FFxkwKdyLSTD3UggNWb?=
 =?us-ascii?Q?q+ctjNhGmRt944LRecBiPagKjfhiG31xArSiGIW1tI3ut2LnOYo0yvDPfn2K?=
 =?us-ascii?Q?9HmPJGPBgnj2+Vh1DZjDIIffP9lozOp+MgQ3OsNrJ8UtaEtwvJ6oYzC36HV3?=
 =?us-ascii?Q?5bp7ueLYgDw9uuZ9tpXAfdRRV+KvOQPKxqMUL3nwVmmgbZ8KL5w8kPeoiHrD?=
 =?us-ascii?Q?hJTTT7TJxYqFGnZrap7yvA42jqbFGTPrbT9UmMYDLENGtxjhbXDJfHKgG6jb?=
 =?us-ascii?Q?57vv/1Cb8V/igv/UL7met1mlHIuQePgB5BsdmPGRhuJE2FwCGDKjs2H0qLuE?=
 =?us-ascii?Q?wxFUZIPbz/G812zNMDYEe7/cPdPLTcy72xFrpI2ZWiJd/cR007iqji2HUqJ/?=
 =?us-ascii?Q?bwviWi4aGv9Jmz1WCTb7NBVOKQrHneJOhTDgN/wXqyhvW9j01Zc7xKlzWQVX?=
 =?us-ascii?Q?n3FFOAGXkDP+OYYvpfD9ssIs4NCprETxWH2aGhpS+K9Pii6G4DCiKKqpnQsN?=
 =?us-ascii?Q?D27ZIqfE4obIGsl6u5FC/LkaU1/Dxm9RIPzQU2J7AUCXVfu4dE4BPN1hE3Oe?=
 =?us-ascii?Q?J3ejH5oZzen09RKd359qh9oQLk6RJbIp9VDyFlaBgKCNpPgZ1JMrXDVbfBr6?=
 =?us-ascii?Q?CKiFl0XI0b/2fBSxP+n8cAjNyvzxYITrRjZpmdmumrDKUDj7lw6rJpvQRQK2?=
 =?us-ascii?Q?EqCmmYMUx24=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tAVZuC82iverkdQdRewuKC1ZAZep5QFXgWpSO4LRErjVuMWySR2Upgz/VXYR?=
 =?us-ascii?Q?16jx3ZjvpfbFXb6wQBSx2jK/quU9X20NHrKEOkHFicz1JM1mdH9rTM2I9bWR?=
 =?us-ascii?Q?uDxbJ6yxMu8fzZp47fUWeCsGI246Fa+C6wEgQdQHXEhzvF3so2hHHXBvpFvD?=
 =?us-ascii?Q?bHdWSilPWV0+DxoxBzCBG5a4hZu3VF3irezBqcI+8Ijk7vNxWLFhwTreIi9e?=
 =?us-ascii?Q?cqy/aASo7PsjC7WobAVIxsJwBHHPaNFyPNNZV5wiO90dMWF5I27U7Chfrn9m?=
 =?us-ascii?Q?hHh2yvUcg+xKGM0xi6LUSEzVLgb/mlR4b9MCrWN9I2wZYhwuyX2khUUHOVDp?=
 =?us-ascii?Q?NjAtHw2mSN6zFNKhDb/yjKmd7pRdGgwkB/Z475NGJ1hG4qrdm1Jj/XyZnM3C?=
 =?us-ascii?Q?3pHVOa0MewC7ZcxWqsSVNBn8av1aaSf6ZspJYU7DKO1XciaoME1jAvwORkgG?=
 =?us-ascii?Q?j1EF0nP6uoCvynIMT0gfcBIetjTsAxGCZAHKNNod+OHXs8AfJ3JVTvdaHkba?=
 =?us-ascii?Q?RoMOIfchMExuaYxgCbxf5b+3RAL0/HtBJZlPx+CngrILPKmE5IYBhuKMoHy8?=
 =?us-ascii?Q?p4PuxhwipZs1I8vQwe9Fymp2q+c86zsR6ik0e7yyAbqwUf8odsEAYom6yqIW?=
 =?us-ascii?Q?HTT+tNse+f2B6qV0vpJb0CZx8ldwVXPsf5/MeoLTqT9c7e5gkyIboY5Me0WB?=
 =?us-ascii?Q?2USrTzTN3QWKvgBAPZpyMywP4egRe1CWIGCTdq582y/6EKWC3zF5ASh/HE+9?=
 =?us-ascii?Q?GwxhmWuox8WtMZrjIBo7obpAXpPc0x5SW3EQq/tCE999m0UoEu3Yoiilh7pv?=
 =?us-ascii?Q?qV3NkN1EodQp62YQ9ENaAiZmOF3ggyCMz4/GT3iU7oWN7tgDvygiGzzNn7DY?=
 =?us-ascii?Q?fGHqIk2XqD+sEwOzW5E6Fl+GrlurHgupU0a1haJ0plZ3Jv2QzLCrc9Tqo89J?=
 =?us-ascii?Q?42AU28pGQmn0JQOr836ZyplElqwiAzd+mcxQRnST5KIRpuw6//fJnw6m+6Mg?=
 =?us-ascii?Q?gtF/2WWGK8OQlI0UXYQ8Lz+QYLXE6DA7ejwkREHxtqbmXdDRcsZb+g9iEGtB?=
 =?us-ascii?Q?auleUc2ffcVLx/CAbDyqr09tppx9H32yCeAI4qB/SWLcj6VpCroc/sRNL45E?=
 =?us-ascii?Q?aFY/pMwmP4PhSn+c1fsU3j0kIxw4qSO7ZU8cxUm850a76pcDVpMMHCdujC7o?=
 =?us-ascii?Q?9nlfTOeNPdbDZBvz/8L2VjzmfZTpVBWk2DjHhfKcMp4mQtpfzpahp7s1r8sI?=
 =?us-ascii?Q?focd5CuvSIQj8BFPnaGxDajPZrRWOELFixyzC16DkAFK6DQcCVpn8Oxm+RIe?=
 =?us-ascii?Q?wTkjjh2Vj451OYAhGua2iy6sfdtFGVQEe2rA3EipDGJhLL7QHHtOS6D67hV+?=
 =?us-ascii?Q?GEtlD3k+neRVQQllbeGGyBzIEZOfWqxWp2eYAjthoVlVav6C0gJszTZ6MqyX?=
 =?us-ascii?Q?wrch1wGK2EqrCF4tQiKbUrvZch+2Fn8Pal8gQEOl8pvN0e5P3YHkS0vjerft?=
 =?us-ascii?Q?xnIgKZPyvjMnxs7gybJZzLlr5XCVQff7vESXzP/pPTFyZPi7lQau+YMaWsYW?=
 =?us-ascii?Q?JKK/aPRik7F0PJMnSOftuEZ0eyYgdfJa20MPnw8Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d3e276-f177-4b15-c21a-08ddbf19febf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 18:54:12.7925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwJiDrc3et1mCWkwNguamcBkiU95auSw0fExlwtBEU5/9obazwpSIsdK6mvLTGlg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9527

On Wed, Jul 09, 2025 at 11:44:32AM -0700, Jacob Pan wrote:
> So you are saying IOMMU can cache user DMA initiated walks and cache
> with supervisor privilige? Since the SVA PASID is a user PASID, even if
> IOMMU uses the cache later on, how could it get supervior privilege?

The walk cache (aka paging structure cache) and IOTLB cache are
different things.

The walk cache has no concept of privilege. All memory holding page
tables can be loaded into the walk cache. Meaning any table in the
radix tree is eligible to reside in the walk cache.

So we point the IOMMU at the CR3 of a MM struct with KVA's mapped into
it and the walk cache is permitted to somehow cache every single 4k
page that comprises that radix tree.

Supervisor does not come into it at all. I had hoped the U/S bits
within the table structure itself would effect the walk cache but it
was confirmed that it does not.

Jason

