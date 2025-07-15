Return-Path: <stable+bounces-161965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450FDB059E7
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE834A117D
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 12:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B4E2DA750;
	Tue, 15 Jul 2025 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g4CqnVu2"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11852CCC5;
	Tue, 15 Jul 2025 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582311; cv=fail; b=FSZAjkvcXuU+CIwSdhEOfS8TskDVyuqj6AhoIboFOYkHdp0M5dunsxBu2j2rijcOsawzQt4a0uq316wGlYQ0CCTT22H9KOeZURYxcceufyTZPDoDNQhGJNA3lRXm5obe/reqT2ssj0YpsVisxbLmyPsFbb/LIS3lJgnuak4md00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582311; c=relaxed/simple;
	bh=0HLfz3uHjCaNyirTh6pq9cANknMUMqpjkxA91v+BsSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JgFVaOgtBnXCj88Yf9x2921yiPJok6sgFPmAF56Z7qTXq0D1pvB43nIiSMewQymS2xiuqLWBP1fj4HPnF7iIqs8U5Fx50YtxKgieNi47ZOPpIdT1eg/S6ds/HSpsnZvT6VeYRI56BG8nhtJ9XZhfnY9BeMrBbeGUcrYwpuJsw98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g4CqnVu2; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U78NRQdncNwrgHz4n9AJamll0+OKXxes7+X9y3WThN8hHQkyAXgxVLnZFpmDNY/aX+u5RSz7c5uMI35hLscW51U/Euu/6dSKm9fcpapsEkmoZ2G4Bsg77HYusiUjPS+klCwk1lLOVEBbkQrXeHKvj6TyUNJYH/MG89A4k1EuEPCJ8GnolDjJJphYX5MnujAEKPR+Yh4jHZIIkgVE+AVR5MDi6B0598j6lhkTmEvKiNPQAA+3pytp69hSNLWN9QhKe8+4YMOSL6VPWaWf63DjnlE5QjLL+xUP2N7mhioQ8S61w44KI+RxOQzS8aNOKAU4CF+VPE2B0JmyleKdIWeaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzc4tiulLEKsTdyaUz+Y0irq5fVCmf5FM1emizWqiIY=;
 b=L6TkCgZA0jEvk59smw1YugyoGLP/90tjU3Yat/4VOCNGbbt1td1RisQqBURqe+nJgG7bMPbI0Pk6zKPmvpcxuBe5+SHlmHJSYJ713VVMcir2h7DAUaPA96vyMxGokS3NzHd38+agde+gsJGIbNC/9Rjt/HCHB/lDxzPu9cJkRSVuylusBePj9x28hFByUC1x7QGM2ArMRdaUMFgZuEGCeq05YZD9bkGA9ug6LG6ODUU9tDUvxzllsydDKE9l9Be4/gBXh0QZrXdffRrzveZCcW/2v2OTSGelpEy3jh73LY4jD/1knFQ66cGzGCSjm7OXPpUk4rK89eL/NN17RkMECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzc4tiulLEKsTdyaUz+Y0irq5fVCmf5FM1emizWqiIY=;
 b=g4CqnVu2r5hxXz00YtsFxEgMlpMSVt7KZ9zsL+oZ8S+lmwk9b6OgNErDv/3fowVuct2W6/oS1wYG5rQh2nKo1lSZCm7I1AZE3CUtFKvyF0+FL3Hljj1zLBTdC5jl42tcr4gssXONK54TDYgl+mgxfP4c1BkgxpHXCpIxTBLGnqOx0rluiR7C1mKEsNb2tCpbjH2zXNIZ5wBuhR/1JwVDwZXEDQ97/l7DiCreJSYYcVVK/s9HrSIq/zf5vBAs/uxy9bKhwtPSF9hcuajgm3Wu4EV6/mYsQ6LFQYWvPNEmHOoF40chGOHeXZz60rG1pKjCD/GC91QkAQbVBOqroX2wXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 12:25:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 12:25:06 +0000
Date: Tue, 15 Jul 2025 09:25:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Tested-by : Yi Lai" <yi1.lai@intel.com>, iommu@lists.linux.dev,
	security@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <20250715122504.GK2067380@nvidia.com>
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <20250710135432.GO1613376@noisy.programming.kicks-ass.net>
 <094fdad4-297b-44e9-a81c-0fe4da07e63f@linux.intel.com>
 <20250711083252.GE1099709@noisy.programming.kicks-ass.net>
 <e049c100-2e54-4fd7-aadd-c181f9626f14@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e049c100-2e54-4fd7-aadd-c181f9626f14@linux.intel.com>
X-ClientProxiedBy: BL6PEPF00013E03.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1b) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB9492:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a84f32c-5433-40ab-f0ae-08ddc39aa181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tnnYvato2qV93ur/zo2bkPt5JyRlytWsGiADeSPzUdxaYQYmUKXNFlsqHipY?=
 =?us-ascii?Q?nwE/a4T4x9rWkaKftbMlhZAV388gJFBmGe5fpzaPHop2j02xLRtOPiysLa/W?=
 =?us-ascii?Q?Th+ulNBEbF2HbhMrmFib0gPtX6yptEZ16JxICkDZvAnAdKPICT+zsliTdEet?=
 =?us-ascii?Q?T6f10zHLcQ81vKLAq5SWD7QiRprpcO/Sf8xDUbY9dKtDEUGx4c7pZTT/ph0e?=
 =?us-ascii?Q?D2FI6zaUWJKjXt0EVb9scpTzSJ9iYTS2+S9nfMJJW5rl08Rj32n//wqxEo2B?=
 =?us-ascii?Q?moC+QpCnHNDs4BIe9sXklyxJFdjh0FygDSoJHoiJxlnZXwFmgDu5lE0Kfii9?=
 =?us-ascii?Q?vwZPrAUfuKOZSZ4XVr6DA9JSTcVd+O8hnmZ+CJVi9b3FCTuweTEjAx4RIm8k?=
 =?us-ascii?Q?7bRVIMu84ycrNDjmnujY3vpj2ghcVuayK0XDLSpWNpCWjKxRZpxxF+TF6ZuF?=
 =?us-ascii?Q?09VEGu+B+5kLCOeGfZ/RNGtw7d5LZvb2wjDuEsCTQ9Lhl07c67AcJtVnvVfG?=
 =?us-ascii?Q?9ZasJnCVHLJ5O6ajRQy+zWZDPE4iS8u8+61LN5nPxn+mLmP3JeTKTsWMk+Ra?=
 =?us-ascii?Q?OtzlioC36i4R7wzQTfd6i4iJw7e0u5kfwMt/lpL2IhJtPZmO2cp2+qz4o//A?=
 =?us-ascii?Q?y8cRypmgV+rR55kE60HWk+mZHv7bfB2oPVkgWPgnoRfMIXoF76tAsLHarpTY?=
 =?us-ascii?Q?W7G5LYRxwy+lAzVaXpuFMkYUd6f3feAW3xuq7eLASIJU2Somuy8rcD8uaEy6?=
 =?us-ascii?Q?DH1XbDVEbvYXHU4qUI2p6sS8dAK8s8LCbw6sGNiu6NQVRhbGLQTj6JeIJgHa?=
 =?us-ascii?Q?YOMt6B5xsaXjZJVYfNJ2tPBE3KhkeSM1fLsShjwVhZLSik3ze7eX8TKy0J0K?=
 =?us-ascii?Q?uP64zpNHtgMXNIfpZxcyGFd7Uk49QaeTSb2MsWfXfRwXCxoUFrYa792muMY8?=
 =?us-ascii?Q?owp5tWJQTnbHM4O0mptTksjB1P8E493VSxl+XXE4R2x5Gnr9S/Bev6vIp0+m?=
 =?us-ascii?Q?e8oUZ4OxW5QQU0g+YZZWVlrVd8FS2SVPbO8ovtlV2O/mcBmw2q3w/vKVQvtc?=
 =?us-ascii?Q?FbTgJm/MV/e+0SPuC1n5a7rhPnc/mqW/+crmARPDdRAjTYNjRnt4B4yocpMc?=
 =?us-ascii?Q?JCE2HfW0RrPshruJingVWpXXCtjoKFHajwA2xzsspzMw5intNxFRMfu2hkKH?=
 =?us-ascii?Q?Q3j+1o5RahlkDhQfq2oStdq8qSRea2izZ4IYkdlwvP+xPYSbiHN3SP6aH1M1?=
 =?us-ascii?Q?LDHIPMgExyh7qdW6lggZhMY/HV3wM7VBammcT0rXEufq20/NhiUQvJb0ExVD?=
 =?us-ascii?Q?Aewf8/xRBCS4prHpNkCtjNKypQ0RXzV18kYwhBnKllQpcu9dPLJPxqmGnMTw?=
 =?us-ascii?Q?x4yjmN4oH4TP7zroXtgL5WBqtqohV2zDNnajGTYvb4e50rHEL9LkPlHv8gHE?=
 =?us-ascii?Q?pcTFR2hyr0M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VnFpLWBqJ7dOe65fV4vAFoIMR6Mq7nCKNAyLJqbQnexUb7yoT59ep2rgpbtH?=
 =?us-ascii?Q?5WMN4mNuFLkvTvR6cxxkdzc0UfleOTjYtc9qS97GfY1rC7+9aiQv7brnEcAh?=
 =?us-ascii?Q?U+Zs01g+o5z/TD+BhpkiVPyJ1Mj3M1LvBspTukYaLX7TUJtLzJN3wpv1YB/J?=
 =?us-ascii?Q?XpYG8dDaRYzEfo9F8ahJRNOFdm8XdTDzNit4/2SoR+aQAMkE3mgbHPh6wnl6?=
 =?us-ascii?Q?6VecyDaMO/QqzteywAacdyB+3bzIm27zrD2wdbhXvxiUpHCt1EuAbZFt0oOR?=
 =?us-ascii?Q?954bKNRvDUrK7xr7heLAUeS4ubIggRkOhyzrURiSrOCeYZ3H1LoTRHSHDDuf?=
 =?us-ascii?Q?gef1iMaiyZHHrOq5pIV08OPYdnmcMZGAPno6LTDyvZVqOB8sLe5sqmJproRd?=
 =?us-ascii?Q?YVxVDLNfKVVrbE3PUgM+/5Mm3zEAi/tJLQGVZrZesW+nNqFboPCEwUkAZWoG?=
 =?us-ascii?Q?gYNdXq+3eSdJf5zwOpC58YNkjOvjKbMqYK2R2FF8lkxaw5Sqc8usQREgYBby?=
 =?us-ascii?Q?qfdasDJhKhPOffhR0XYDTh6JvPlwu9ot23lc3mUZzeN21EhgUjLteF1F4k4b?=
 =?us-ascii?Q?bSHzOvq6Eo1BYCkQdaULSo6WGDUpUuwIhdWyBiNxyJtcZCktoPEX3EPmR2Gp?=
 =?us-ascii?Q?RYw7mnCGw8eeM1AgEcR2LKwQhRJGWYGjfqoC35QjXUDOIP57Ke2mGcrfbTVt?=
 =?us-ascii?Q?wdedLbAe1ZZIJ47HLRNTsjuaZAIX7AlHTJuBNyO5cbvDkCJwdwRst6peZEZX?=
 =?us-ascii?Q?d8UW/VjnYZ18GrWnM8lX/dqmy90W+oCkV6hd2oKLiPRHhBL/3XftpqASa6kl?=
 =?us-ascii?Q?afJW4rnkac38dsXwW+PT1IqCQpndEeMPAMmUxfzyJKT7s9NMNDWCJd5vmnM/?=
 =?us-ascii?Q?C7lfABmnEx91woOFn8LH6D0fxUpHCdzI5uaOCYiXGzLPDQ/HclLLLDEpsdhF?=
 =?us-ascii?Q?GVQTLMXzFLrs05yOyfuMLPUE9VMvYQ15jngaLLjBN9DURlPfkewwuUimtrtD?=
 =?us-ascii?Q?2BQL169v76S5bLcLyD0G8yxcod0exeNq4qAV2Cfi35etdVblYPHYLZPl61e/?=
 =?us-ascii?Q?0jZUO/vE+KcqWaJl0uuZmEiZr6QcYIbcjqVePKjOqn4T1a6tX+am/DnxNZ8G?=
 =?us-ascii?Q?nScd6PelqUBai7cpp5DD+QStniOgJ6hpxOyACjFkgT4hB1YOg8Gj1VAGzEBo?=
 =?us-ascii?Q?mNLEVOZWmx5pgnM1vYJz+s0HG0148NUiPadWsnqHLblEuiG57yIYj/s5D8Kx?=
 =?us-ascii?Q?2RgPKRFF+R4MDevqGChPKH6GvzhRABCuVPQG0jm3vdLruMXSAoI4W+LaIOc3?=
 =?us-ascii?Q?wmFL/bI6MsT/oQe+NWNXmOxCqiuqz/RARt0oU9v/eV6X9Z6KGuXU456Rzztq?=
 =?us-ascii?Q?hTpoBOnsnF0hqw6F4QFXXs2+TUHLir3PHkHkKYl8zXTEdCi19jqIA4xBolVl?=
 =?us-ascii?Q?3cAxFhCws9dmxV0RcmOVTwbgOVUF2Yo6dtWUDhPvKycXINhBxrIFxNT9pYIe?=
 =?us-ascii?Q?H1FKy9C7NiNoN5Le2irVyEWWm6foDkpgsRWcc+Gj1TyXESyhfgytt4s6V/X1?=
 =?us-ascii?Q?UopbkzABp88mclCl/88EUs0rgaW4gDyipwHSGcTf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a84f32c-5433-40ab-f0ae-08ddc39aa181
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:25:06.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRJCa6VbIQKA6ADmqvXsvprVPbPg6Aj8Qf8/BVd/8XNTrKb039YwCqTMbV+WjxT7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9492

On Tue, Jul 15, 2025 at 01:55:01PM +0800, Baolu Lu wrote:
> Yes, the mm (struct mm of processes that are bound to devices) list is
> an unbounded list and can theoretically grow indefinitely. This results
> in an unpredictable critical region.

Every MM has a unique PASID so I don't see how you can avoid this.
 
> @@ -654,6 +656,9 @@ struct iommu_ops {
> 
>  	int (*def_domain_type)(struct device *dev);
> 
> +	void (*paging_cache_invalidate)(struct iommu_device *dev,
> +					unsigned long start, unsigned long end);

How would you even implement this in a driver?

You either flush the whole iommu, in which case who needs a rage, or
the driver has to iterate over the PASID list, in which case it
doesn't really improve the situation.

If this is a concern I think the better answer is to do a defered free
like the mm can sometimes do where we thread the page tables onto a
linked list, flush the CPU cache and push it all into a work which
will do the iommu flush before actually freeing the memory.

One of the KPTI options might be easier at that point..

Jason

