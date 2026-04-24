Return-Path: <stable+bounces-241041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDHME6jX62lISAAAu9opvQ
	(envelope-from <stable+bounces-241041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:50:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD2F463547
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E1B9300D16D
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A35037E300;
	Fri, 24 Apr 2026 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uqP/b5mf"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07B931F980;
	Fri, 24 Apr 2026 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063837; cv=fail; b=arULK8c1vlZihI+EmMAxlZ6rlLu/yoUDyYlAO1TuEnN+3UrZHgUluK7jhivdxsOWB4Lnj+uvnacGUG/od8I5BSedCJ9Vaqlk2qQaGKBvoD8G2Ni9HiJEQumquLVGehdkO69Kndt60VS9bjou0hL/4QKx0XhbrP5TW6A7yC7Z12s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063837; c=relaxed/simple;
	bh=8uPgVuMZKXEJVUcASCpcQmR5O7lKHPWBcotWTGFJgdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PlsNylAw3q+9kmbnPT08kX/X48CiRRDCNi7RNfMVqFlBKmsS7I1VVLClMIGFnCXO3hLe9VnofwPUEwe5p1jdibeqpE8i+0RoY17uAFLiDE5K8N39m/rzfQ+zv5ylwEr0lFIX9I9u0m9G2ytCiyYGCd9zKUVG9RrsVoxK5C5xCdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uqP/b5mf; arc=fail smtp.client-ip=40.107.208.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/b27/nEuXpebYvyV3s+DI82rq84eDGVIdWtRbTHciWAVLPtXH9lF9TiWccWQCBaYuXMsI+Q9V5iZo0VM0shBECytTntMThbUeU9C4g8ar/tR16xAifrNy+tqhVD98Ime7UiMkt3ip2fpQx2/2eyIkIfuqRF8E41IwspsQpRD2LfbXuffHVIszAsNL05sDB0eHOG3YmkWX92spwreP7HHAx+Yti7Hc44ZAh00PNMQcJcJMpCek6yMLIelRwsYNFZEVEMSoMkhSJo9l87DBFqVJ8Gzc+Qz8I8vh55twoqtx/KoCan20Z59l0kXrVUVbwifIqpFw2RxvuWFqAw1klcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUBD3xWtRbT2IVXBQ6wAHXZ19G2T2Nxr/4dvx+C3nc0=;
 b=FF/mX1Sp9617dbIqPA6Z1GI2dQ3554abV2fX5TN5IwxnpgdXbHozhuk1OyFT3M3lo6+n3Z54DjrPHmrRFm+t3CLDtw3cL9oC10+tX7EnKdLyqS50+HfKmwGxzi1oDW/U0lvAquID570rGHUQPF9l+Dc1+5nhXw8spa0Egob0cCtk5ZDK/MOy69s2o2pMIZL2LW7XIQhYfGJWn0R6sg3dIYfE+9EwdYxPG1GM0EU0vdRfed2xTPyggGTOwPgELx4HY/ruI8XjA4gkiHo3JXnAx4B4IciwPpyWOWNAUJ5UWiWDNWoj8jebluaaHMK8cnrjDQWI3P3bis6OS8ij5HRv6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUBD3xWtRbT2IVXBQ6wAHXZ19G2T2Nxr/4dvx+C3nc0=;
 b=uqP/b5mfkB2RrJ3i73cMcP26D+aGPRYPrr9lpuUBCCERMWvgtIfsRjzrXN93BZ3V7DEf5UjEbUVLG85cSMB/8cbLrKwjf+ZdA8NcyAFrzsky4ZFivMgJv0Tdedd2qHdrGQM0dO5wLSFjHmtGR+3fclmUdkywaSaiwmfYvSc7hXJMjyvfMkhX1b4j5qlevj3xhWc3a88Hh9vimUTmAwZBPW8E3m9m4ZHhmM//4Gv7rMk0ZfrBctNC3wasvNPKMQVdNg2JN1yORuAuHmbHLBJ8e62sSNkqd+JJvQVmGZaBqcWKLZmNcqHtLLUUmHzXXmG4j+DuWPk8+3pNnsanxBUYog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 20:50:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Fri, 24 Apr 2026
 20:50:32 +0000
Date: Fri, 24 Apr 2026 17:50:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	joro@8bytes.org, praan@google.com, baolu.lu@linux.intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v2 1/5] iommu/arm-smmu-v3: Add arm_smmu_adopt_strtab()
 for kdump
Message-ID: <20260424205031.GK3444440@nvidia.com>
References: <cover.1776286352.git.nicolinc@nvidia.com>
 <af5fb880e771bc31ba42644ae5570e1fa208217a.1776286352.git.nicolinc@nvidia.com>
 <20260424165613.GC3444440@nvidia.com>
 <aeu3bNxCsy8azLOO@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeu3bNxCsy8azLOO@Asurada-Nvidia>
X-ClientProxiedBy: IA1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d3c52a-6dcc-4aab-9ec1-08dea243205f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vzRp4VABejiR+jceLORbIjRE6JSdqU1UbS1GzweKimNU1dQ4RAJaZ/S0kHFEXW0HcMxcxeYviUKRrXNtFNIwnAYaMgcvLRXB0KxiIdzpH02mQsB5lsrvsY7MeImzcbHBeXriz1CpjeqyIN/SNEJzeeHKx/x9L81gsxaXzqfUB91np0CzGcOcdHgVoDBge98fTHbU3VkbcK+fNNXUV5LwnYhsGkG2/L/SK37+eFllsSoduzsAWLopzTw0LsQ7lVg80iMTcgJ50XvMr9C729VTj/rF7Djz0bZvHhwcdiSO6qWo6i4Kl7o+DTg5U+PhatxTYvXK8Xfjjy09pBSEKEzRnueFBl5pZS0fUypjLWlY25mJ8lfMXw770RNurqANnzJvlmZUqA0RR4WDYzBcVOi+Rc2B/AKJgNSUbl1FKhoCNhL4XiAY8m4qGYvruEl0/BpeTWK2O3aWDL8PLG/vT16NByoXHzNBlN43TBmVEmPeDlv9twCr01cZEsXVbuOo79ADZkO6zxv0mKFwgN5IthNe/XRWhFgGU9wFXHIJflPL+tVe4ozQVfVye8qsOE8IL3z63EerXzWFsGpl4K+AMQ0qXLD5ptMXfDS5L95WQ3/K0/ndFR7rCjlqP7JWkK3H58xIylSEenEhhZ+aSz/NIlCbWPOfH1jOIvoYL4POvSX6RO8/xxYivYEysFBseo8wEnEONGZ4MS6Jjpq4o7qhMKUrDJKWpjrWvL8Ds5uG0O+SINc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?42BYWIkXsNW/2tt71Gch+cVaJZeDdqgcUnQK4hWgGZccutx6fINl6+5BCcLq?=
 =?us-ascii?Q?9VP7e8atw+x9mvyCxXpEWEg4L0M7nSCX2VT/T8eV3wWdUKM2PBvDka7odFZy?=
 =?us-ascii?Q?DHc6VMCcCcgOM99OwAjfOHwZQkfF3KsdhdDtvASpoQlsFWbCGneY39IRz6rs?=
 =?us-ascii?Q?0cEkUNTmMz4wVS4Cdwdo9jMQ8CcsqRci7TKPjjNiqwhURdw3d9b7dJNgb91q?=
 =?us-ascii?Q?1MhmgWMEKCmK2PTW8EwbAjV/QpvNI8it5SzlUjlkuQFRt+qNuIBCgveVxu+W?=
 =?us-ascii?Q?8RpCjJy+wzpdleBjz4QkE26V+m5zFwg4rpnT5KNmc11LkYKHbCLsFMg3I6ma?=
 =?us-ascii?Q?s5ubcmETgfsmwV+1ZMCA71EX8dE7S2OtLrP52apwAxgOQfngVcY8khV6xrys?=
 =?us-ascii?Q?2RJZLctmhZppwQXSh+mjlRbx5rh1+huI5QCvYGni16NaRCoZeVW6T9Svbkkp?=
 =?us-ascii?Q?jQ8l+e0ZGF567B6fbqlYh76ihoqQPibT2a3C/E2/bs8PSqKCt+M6/NzSCDAU?=
 =?us-ascii?Q?VWuXywVo1QiagpvmNjgCpmqlxD4Racr/yz4EwvWEPASpAxStH8ghebgDDbLk?=
 =?us-ascii?Q?dyTUR5KC1BGzYAaHc4kBfNKCvFZCKjV5D1I7KmHOll7IVMotQnloyOBHkKwy?=
 =?us-ascii?Q?sCNtsImEww4i1NEkjPIlxj9Fu5MREBQAlANwmyjNqJrSMqOtUXKPz8LWli50?=
 =?us-ascii?Q?t0BFrVVX+PPQ1ta+SBbj/yBH821pIsp3uccK9xoUCntOiJMIK1V3MQuVeWzY?=
 =?us-ascii?Q?Rpjd1NzAMNfETPXNSRCj76VKTeyUt9g0eGdLQ/yDcEm1yJFQmM3i97VQj9CK?=
 =?us-ascii?Q?JSsnIO4jtL2ZjEIrQF9Xuk6Wu7+sljl0/h7d8UEkiozpnhDSqeKyimZPujcN?=
 =?us-ascii?Q?0d5v15AmTyMHeySPCdcV6h2AvYgCmorirzjbhhquN5TcWnoEtR6mSJfXw6Ye?=
 =?us-ascii?Q?W4oEEXE1TyIA1W+80Ir4s7n2DdRDKgeOmAasC5ZG4+IA7DyvburOYVaQ5ccy?=
 =?us-ascii?Q?s9Jt4nK7ziPfMuWIbmfRqwygFsusbP0/VmX3rmZjtPqW2IwAL8A/VPHMaQma?=
 =?us-ascii?Q?f9IFmiNXR0fPCf+w2LLzaVdvprJIfIOmWvmtwgSis2C9/XGBaD9U+r6J2wAY?=
 =?us-ascii?Q?M3Zgu0mGz50P9ijS/iSl+NvtgW0pacSVvn+praloZhs0Bc2bj+toYO2xXr2X?=
 =?us-ascii?Q?7sq/aAsQwIZqgGaamevFiu/nsobGgx0r6faGd8kAPcUqkfYFoyzgdR5dgCn9?=
 =?us-ascii?Q?f+TIcSFhWzjTisnrcf5dEll95v6b0MDSxY2pjta9wKV6lLhACSpujeqNWcS7?=
 =?us-ascii?Q?u93+VxlzW/VDfyJZCtA2QLjDuxCZ2uow55e2kWEKn7B2A74BgCIwO3Djf4wT?=
 =?us-ascii?Q?f8QV0uuw38H2momyGH+fIiibgLFCEchGPELHS9XHR87018k63kkiC/cYQXb9?=
 =?us-ascii?Q?J3PD1nBMFXyk/YHHCO0zqEmMQ/gQkQP9VP66vyOLEcPvdTVfvRRC4blFpn5/?=
 =?us-ascii?Q?Y3BtuGYgFL8hcPSCyymTEqvfQ5Bt7HneZ/TfTxMAQ1I0IFDkb/srEbB+eU9b?=
 =?us-ascii?Q?5LSNBCjj58QssFLCdmKehwmPrGH1pJ3rARaMWD05PFXItINTr6rtDf5NRQyx?=
 =?us-ascii?Q?PGcVfXMuIa/KoCTOwARlmlSKcDzTUUhRLQYo3EogHI8nQdboajZ9Og0F2cPy?=
 =?us-ascii?Q?GXm7yRf/7V7s3kt03uxbUbXIOaC8VxHFUMZxgndAcdAxIzNw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d3c52a-6dcc-4aab-9ec1-08dea243205f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 20:50:32.5351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBrPDKUip0jwDf5l6KorDi4fml7+mAkpmQS5w2H/R2WPd/clJxmzkhZkZpQJ8cBE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131
X-Rspamd-Queue-Id: AAD2F463547
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241041-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]

On Fri, Apr 24, 2026 at 11:33:16AM -0700, Nicolin Chen wrote:
> On Fri, Apr 24, 2026 at 01:56:13PM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 15, 2026 at 02:17:36PM -0700, Nicolin Chen wrote:
> > > +static int arm_smmu_adopt_strtab_2lvl(struct arm_smmu_device *smmu, u32 cfg_reg,
> [..]
> > > +	cfg->l2.l1tab = devm_memremap(
> > > +		smmu->dev, dma, num_l1_ents * sizeof(struct arm_smmu_strtab_l1),
> > > +		MEMREMAP_WB);
> > 
> > WB shouldn't be unconditional? If the SMMU is working non-coherently
> > we need to map it NC. Same remark everwhere
> 
> Hmm, I am trying to add a coherent-only gate for the series.

OK, may just add a comment to that effect here

> MEMREMAP_WC might work. But we cannot verify that on a coherent
> SMMU, right?

At most you could fake the smmu to noncoherent and check it maps the
right thing and assume the arch code does it right

Jason

