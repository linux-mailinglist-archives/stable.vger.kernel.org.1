Return-Path: <stable+bounces-161471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954A8AFEED8
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 18:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2845A7D92
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 16:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F95621171D;
	Wed,  9 Jul 2025 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PYodFvO7"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D982144CF;
	Wed,  9 Jul 2025 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752078451; cv=fail; b=mhl717sm4HEYLEbCRIMlAxEDof0KN8yD0xj0EFs3AiOd7qMABihJ1h4cOXJoaAXTgMCK3pTNtoonKyqQVNHDKCh9+HJsDG2XX3nd7G2xSzK2Hir2/IjN6GfNnQUTj7OZQ4Lwol83B4s+fMsJ6oxsKFMEX1Ujw+PIhQo9cxKsOmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752078451; c=relaxed/simple;
	bh=KC+zilcQf6U2MCHfLZHxcIHrU4HWpTTab+Waxwh0Tpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B9dYazdtDyKHCWzRycyJ8RRPjQ2LphR2V3aztRyxDjF1B/IdLKJDXg332zs28I3rJtL++lp+cBvFkcCgU9H8ErlTMFQFv4HvqDNMRqdV9MK36hnad8cXbTnPhUcHnKbG7NjwHyKPgYVDD7qBKTgb0Z2GIKdstoPnDCL5NgV5X7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PYodFvO7; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maTW+cDHEImOMdJFI6DK5dxPx2qx/JgQ/kzUB30ohwI3pdnGFVG3206bKBcQJ6NRVTRe/uBngcpzXqvYSSq4CfGTrsOleiOPiubRiACJoXdLGQXxWZszU7LHp2pNLYjRf/EIL6+UbuCqR+DY2aDWI53CbodWfqTF6y/Y8Q+bNxLvQqVXoM/fu65GZmZcnJc7DRUWOm0glzQ9RRNWzs0Vh7EiCW0cIdEKb98Flm6Vy3SWb050c1KMrU6DdJzyCPy4HbmUeBEeBKZ0wEijOZim6ISp8f/mg7SoR5xJzqh2wbHVwpuanwQnvOxMlWh3iBWkW9w6duYeo7Z+wYsTLIyywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KC+zilcQf6U2MCHfLZHxcIHrU4HWpTTab+Waxwh0Tpo=;
 b=Qy8Gx3+vdVISFj6EWohy7p/Cd9QizgX00xl0YTZ1Au0PEeI595C/9UjoFatbn3oSTu7UoK0X8UfhanPrhHP9NC5GhBAIEp4LtfJVRS1QwZVOFGDA0yLI4x9cumM5eNQQ6ODVEUCBxbVfovzoB91jEGewpt0bZFpN6vaZRIo3+5odG5SS7kNp/5W5vZGPrxAyl3gGvBy7xTzPf8Yu2s5zAZQEKdTlb+KI5ic9EIMKmLmE/XYaSS5UJ7lLua2A1T9FTyrPxp5pXxJbMlok/1O6Ie2pmP3jranPljps9Vu8Wz62VSLJhpI0jsB3jMg/fAceqgpOeoZB6VOHkD8IFkzZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KC+zilcQf6U2MCHfLZHxcIHrU4HWpTTab+Waxwh0Tpo=;
 b=PYodFvO7y/Yex3H0UgG07SmiRR7BHeOhg9cLXGXWbV+rC09+PGAV4JaYMX734csx693ZLsWVQ7IrRMfU89gqw/nNTZ8llmdfIyp7BOAHZeaOjKDckWmim659GK/bUEkYALkLFlhmJ62i6FTanEco7qqPu8Oxk0Vc9Tz61qVkJrYaw9H2TfGi8zR351441FE8nPrGHHFpM3T+OR3efdcrM6LvaC2UFahGJB9FxMpfC4SYjoYiMWEkABAAJsFOPyG4ZscYpWQ0HK3qFLhsE0UAgX2fObwnjFtTeF827R3JcQRJQcNrlYbclkrHGKVd+p/irgwhuBvnlaQTUhY1UpnQEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 16:27:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 16:27:26 +0000
Date: Wed, 9 Jul 2025 13:27:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, iommu@lists.linux.dev,
	security@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
Message-ID: <20250709162724.GE1599700@nvidia.com>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
 <20250709085158.0f050630@DESKTOP-0403QTC.>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709085158.0f050630@DESKTOP-0403QTC.>
X-ClientProxiedBy: SA9PR13CA0089.namprd13.prod.outlook.com
 (2603:10b6:806:23::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 1438eedb-9eae-4b98-eb23-08ddbf057dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eLTrB3IOF4i8oAh+ryaANI+BC/mHjm3568Cr2/Nj9iDd5YOpLDBuPDehbCmv?=
 =?us-ascii?Q?FO5cG/uaXevFIbxXCtV7ImtZHkO/Oi+1oR5rImDG9IBQ4MBBoRr7pF/yWptK?=
 =?us-ascii?Q?33qXob/RQQ5E4chWnpn+owkDKMyg9kAIYBfHCvgmGw29jWfsJp0jIcA6m2Uz?=
 =?us-ascii?Q?5fVbDZYovpt0wMbXeG7wqJev+mIhn3Vztzhc8Qdazxa6o7UNl/ycKuSgJHY8?=
 =?us-ascii?Q?HP24WSPWs05xGZ7vFNzmFp7k3uADLXxNfi4GhMSAC9LVlP5ymgmbq0C33RU8?=
 =?us-ascii?Q?UWB/xkDjmx0o5rdq0lab4cw6r0LkxM+1JiopZsyyomoIzYvPjKMY4SB86GoY?=
 =?us-ascii?Q?emzG/Ky/SxFf16IS3Lu8abBfEkY1WRCX69JR/oLD2Uq8GnDnncLSizdngHui?=
 =?us-ascii?Q?v/CQec9JjSv4vgPlbtF/P3y8QIQRJy80PVXenKWNVV6Drnd2SLNKscg9KhRD?=
 =?us-ascii?Q?n/f+6JFJudIYQfxMv+q/T/HS1sGIEb6noUDQFX9CL0D6Pyev8duEdIVUqfXW?=
 =?us-ascii?Q?fmTj6CBkrBhMPNoU+X1G6DUGRPMQiy1bf4DK016iYJM1fWb7oDbNXfRQMxd4?=
 =?us-ascii?Q?+YdAK1TgYMtcm+bKiJJ8/MZ0fN3IZJl4AeKRdgu19wHt2SvxIfLvX6NIZPwM?=
 =?us-ascii?Q?NcczxtI6Vj0BprCF1UGBnuFpE8TXWMMJs5cppnSiABqJx9pyO7dS+Gp8/IuW?=
 =?us-ascii?Q?yh2qKI3v2876mjBED21Uc57mce8FU5sL34KHutOJg6Mn59RRgLoydc/lfFA/?=
 =?us-ascii?Q?xdjtIHoo/B2DzilD3AUps+ut1UYsLqE0gDX6oiV9XdqzN9tfCvZKdDK+eQyH?=
 =?us-ascii?Q?wJCZFZ85o/pWFi5+IfuS+lVCfWgDk7ji67h7mUd+9aDZU5ivsiQZSTyXGXGX?=
 =?us-ascii?Q?Km6D5CdQlbvfIm4nBnYpKxF9CWH6BI8Q6n2ZpdNl8edosIBQ2K/zhFIzY+eL?=
 =?us-ascii?Q?yzi7NbZFfpwVvPbErsW+7Jk0vKYdHNIo0zQRkw/W4svQEphnZ/N8PObTqmaP?=
 =?us-ascii?Q?ynzD1O8keoiKLgCa9Jf7T/g4w5PdQVizNbmXdckNfoAwfOT4Oa+8f0EJPhfr?=
 =?us-ascii?Q?R7l2hApBlJLKW+P/DEFytYsJCVG+g8yQFNOuv7J7vJXOM98C3CPLV7QHxkOR?=
 =?us-ascii?Q?hZfdjo/vdm+IlOYwJSBbuDPu75vl/Y0srvWgINUzK5QENlVE0WUbmTAduPrH?=
 =?us-ascii?Q?TN9VFAzGcbwgHTEov9EorGl2uJyJywJZ6BG4w4Cenhr+4bc1Cv1NQJYgLhY/?=
 =?us-ascii?Q?01MxiQUwDNoVFD0QfTVKfuEvMSuVLawlE73uuBaLNEvfsuXn3ZRw0C2hlIqG?=
 =?us-ascii?Q?4V8v2Go3KDHmE3Yn6Clq3p1CFIdhq4gmoHceLdQlrrkOvQJz9zK7jc/DY9Hg?=
 =?us-ascii?Q?gynsKGGeEwqO1XwN/paAWP05VeKn1OXHpJ2e/McmH1N9u6Ea4uAHDzQssO1r?=
 =?us-ascii?Q?gPRJ4AxjmmM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QP9rIezKcYNrfxHe4pU5Jht4S1JyiC14TvVhOWl9bTidYar2E1uKfEGRZZO2?=
 =?us-ascii?Q?Tl9fhO0pEzZYEntffmvJhvPNsfrDGdrm19/5j+NjUYaBa5H35u7RzEPPAqm3?=
 =?us-ascii?Q?Q0dxpArN56x82KJT0YtTs3RaaenSLWwjv2RqAhQk3xv8BtNXiHoy857wfrf1?=
 =?us-ascii?Q?3k21SzKIX7PUsJWdhuvvksKmThsNUSP0MiEbMgmP87hV/vonoCQ2cYWwlY9z?=
 =?us-ascii?Q?jQCHwaEs5jhYkDCp5W1+Tnvv7NcoePn2FJIPK3Sazf0C88sW0Mxvu93MClPb?=
 =?us-ascii?Q?N+66mzccipV90kSRI+IX0uveSpwh6F7Wlz/Fdq4qoyChZYWlL1r/zaHhtT0s?=
 =?us-ascii?Q?H5p9lXVfije5irhlk60hwVhowDXmMgUEpHYPpbKoj7TS4OJ5m9dTTu6BEYy6?=
 =?us-ascii?Q?2BjtvAZHiG6ZmFAzfnAiCygfFKsLY5udbiX2od6rIvtGkZhO5pvnu5ggvd/1?=
 =?us-ascii?Q?oQZEe3t/YINRwMGIxVQ5wsvvZyG+FdD/kHdf1HQrvHezGJVLl+ed+88M77th?=
 =?us-ascii?Q?zhKyatYzKX9C8Pl10rgh1vflfUvgcWuRNlLvZEETyqsG/m/jG7jzo9s7o55T?=
 =?us-ascii?Q?qSRVU2XQvy7mxLimjdxU9RTCjDmbqx2oF6P1CKpzzVpsiXZ09SC9Z4zUx4mn?=
 =?us-ascii?Q?0h2V5Rw5OHur/H1wnGg2KsAi2qrvOplnf9aDAz7d5hbcLF+wtuvGi1fTETE+?=
 =?us-ascii?Q?W++2XB22CeHqA65dRLwAf6sJNk9sTIJr3T7zZpBbq2iMBWYZ+UFAnMfVcWiZ?=
 =?us-ascii?Q?MmvGDbrs5OoMOHQeE42OjK2b7Bt86FC0/SFS2NVls4oCnJuaOYMTneBG5dNS?=
 =?us-ascii?Q?+FoziLTiJWrt9MaEL7SSWtCtx5CMhK3Ruzs5mmtP//O5ibOe2EFgS7EX/dOs?=
 =?us-ascii?Q?oLHGWgNmVDM8DfeAjOHK/qgmo87Ew/FrUoHjovYiPH1vrZpQrNMHJaWLnx33?=
 =?us-ascii?Q?kzozjyfgl8uuUv3fN92e23b4SpHlyFAnPxSZ1yJSkz+zdLav3+xpZpu5pO4C?=
 =?us-ascii?Q?WCPIb9iOfhfrvK9G6PT+qPXDI1t9xCHKG0FBJb7pWCuEoRBSn9+Ke1iY7Sfj?=
 =?us-ascii?Q?8BdOBnSOaLB4hrE/1zFgEKQ16QXDp19KkycHMkT8wOKSoBNamo7NOtuZzwad?=
 =?us-ascii?Q?bhyO7enrVot+mRt8tXIRWnkDvfjmnCy5ZNr1aPjgXcOyP8qSgYUSvzIbOaXV?=
 =?us-ascii?Q?0SYfkVwB47i1QLB42ZVBV8oH96+nXNWKn6/L1ruSW/XB0Sj0VlM23TiGYfvQ?=
 =?us-ascii?Q?/vV/Mu8X7/HJjjt1s4pNSvDH9hGLJWL/KcCBHWpaNZQxPawFoR87xxnlu6zJ?=
 =?us-ascii?Q?jBnBjzBwRDQYRoGEDyj0NH/gYdt/f3/1IEEPWvpW2T88A2aH57nZBF9iHW+U?=
 =?us-ascii?Q?Jqcbc6VhFI2i2VVA/+b7bNCnWiYlKweMgfXuCtuMvu0cqg+xV992j4qyKn6x?=
 =?us-ascii?Q?J5AxI83U66kIN2Q7KITZeennzX5yyEGMyELVeVnb+7Oyhhib3hYFeHrgP0V3?=
 =?us-ascii?Q?a3q0tNsanQ1QzT+usnPuf5kJSZxW0n+V5555VRM1G7Bl+1i9g5FRLIgA3MQI?=
 =?us-ascii?Q?X3qEHbAXn74FMjHD/6ZjwjRsWDrjfARlCm2rlXk3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1438eedb-9eae-4b98-eb23-08ddbf057dd4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 16:27:26.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45khU/aXISmF67RB/VSfv9BJy2BWYLVIDidgCrWLAdafOqEQz7OsxcruatnYHruL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311

On Wed, Jul 09, 2025 at 08:51:58AM -0700, Jacob Pan wrote:
> > In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU
> > hardware shares and walks the CPU's page tables. Architectures like
> > x86 share static kernel address mappings across all user page tables,
> > allowing the IOMMU to access the kernel portion of these tables.

> Is there a use case where a SVA user can access kernel memory in the
> first place?

No. It should be fully blocked.

Jason

