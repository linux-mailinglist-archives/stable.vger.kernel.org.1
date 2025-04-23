Return-Path: <stable+bounces-135292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 656DCA98CCC
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC75F3A639C
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4AE27CCC7;
	Wed, 23 Apr 2025 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cV1nN/Lc"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E08C27CB33;
	Wed, 23 Apr 2025 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418069; cv=fail; b=WSM9mDD19905AYY6xrKQxCZkhXDyz+nsbccXKNSK2TL+xOJcjYuklR3tzRIK1VV9C9r7odYGc2GcnBDJFQQUdarYpwlMnbT32QBNwI8IkCP9pIGeJKJ7si2ONrCOID47/MWt1HNhdETW2xqRNa4z0Q8nSKwiUf3k7sSqhvj006M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418069; c=relaxed/simple;
	bh=scZp+efHiy4ggJrhIF92KMGwT4uySbl8BkdKqjTVjzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GgnvkXL//69zCyBd8QFMTw9UPc5mTAnLv1mSzFX+1gjDGbR1rNJAVPBppas82rbj3D1BT/b/G4dpDD4oq478j2PTp7AU8D912xL77TJQp3JpG0RhVrqQsBl3pP3y9/tHIbyGM2ktZvl4aFse3PDDIfs1iStZIu1V3fzpWtYODlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cV1nN/Lc; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiZMY/pqVrJGkkWGRer7GOJu+YB144JIWgBsYmwMv/ydQ77WwhX6bLLELuv1eZPbf0OqQZxugqIXov4jbSW0MWuNMjVaV/LPQ9lJC2VowQQEA1Yk9K8U8qnQelKO6NmMMWZvSBKRIbOdfZDSaC92AjjVOMTiXXmzNSimFSQ47mVNclLitYJ2ME5xTVQbVY09ot0BXk+pUrX+npho54cHEJi8igbBDjon/TW5gbddjbmexkpunFo0koO3wjXiuxUxry2BQXTEcoMm8Uhc9v+JBbZ+ZWZplidsEawbgFRph8+JgSB2VdyPtuVU6ck1GKlGC+RUpasRXMYqb9wDydXBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wy/fwtf7JTaDoyDpLlkdk1R1yBDUMS33mhBvMNAHZns=;
 b=ECr4I5xnq1py+3MA+rNQQu4Mjxw6DNwsaWaARyh3U+DmrvGyu5Lxj+cTpjHmffSv/xGhrtY61Xb8y390jWEniCaF6a8AsFwZR/DMv3IkYYT5sZCz9eLNzF5Ea70zxVhsRFOopFskNp+X7j7qdwA/zfQfb6Vb7oYlKEwyZMzE2rUZlGh/QBtcKFQzPRi5dgTaIxQdwRDpLY5k4TahkqYus9ciikpxEfdA1A1l++KrwFUT4A2UyRs9yUZlrNFVcVMIJuinjLsMS+1JDo/qS8fuovbPPQCBbCTTa7EtiFN1ZvO8+mQeyaN59lJ63eT+wD1K8nQqcNEyBMU0YxgifE8MdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy/fwtf7JTaDoyDpLlkdk1R1yBDUMS33mhBvMNAHZns=;
 b=cV1nN/LcXeB9CFV205saFl09xdlF5CBb0EySWao04RU9I2+bBZ+35wfI7oOwFij0TIGdibyafLnkDHOBqK/XqB5w04GWQN9vj3DPNYb6jSodXKrxgqRVx/Fx17iFnCmkkcJezfbQqwXuJ7VQGlJasPbymQhCBXrXKlBnNcKOFuRdcCgq95PUaOfP5uPXnHhgSaEWHPDEVTmDB+lJrXXEIF5M07K6eftrvVXFKvdeFPAKyB27sWpfnpXwaE+AvAj4QUdBPkjZ98h+om456XV6rKqUv1mnZQiUUedovw0GJB2YCe6i+XJNOs1v/vi1q2kpBh5n2AAd6Ex4BER57yl7YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 14:21:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Wed, 23 Apr 2025
 14:21:04 +0000
Date: Wed, 23 Apr 2025 11:21:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, shangsong2@lenovo.com,
	Dave Jiang <dave.jiang@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu: Allow attaching static domains in
 iommu_attach_device_pasid()
Message-ID: <20250423142102.GL1648741@nvidia.com>
References: <20250423021839.2189204-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423021839.2189204-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:32b::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c86477-924c-4bbf-6fcc-08dd82721463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MUSC9Ik3yZm6AMm3x9lG8b0eaOqBgTr5MTjuuBcdwwJw0VR2Nh3ZiuK6+Pwj?=
 =?us-ascii?Q?ME5qMf+m/0LseEiHOPujSu67cvhvud8q9e5ebv/NHsXSOZB6DsruEnxzcd9j?=
 =?us-ascii?Q?Pl2Fxh/6ZBDPJGL65ZO5SVHsn+/YgMvDG/049+3Wm4520ZRRkAFFoJ0ZxAk2?=
 =?us-ascii?Q?E8TLVoSchwaYCWNqVIuDPj3ZcHDEe+u6EFTAFc2SpHE+Hc7/tUE4Zbwcf3cz?=
 =?us-ascii?Q?N033lZkZ4QkzkUzOBItPqWcwLsefIXYLt3HFhwKzJe5QKHx8ppicNYwvPJGq?=
 =?us-ascii?Q?mZlD0xxmkpNr7JBsvNYBlY10St5UrCQX0JnibSdaS9aNCvK/fmmkZ7hqnUIU?=
 =?us-ascii?Q?SgCSFRYKnI+tGygA70kPzg7/kFkI/bAl9zulIDYpVdDe/m31SZRqCqYHtUsl?=
 =?us-ascii?Q?s2RSfx+JOXwX3d8vDp62g3wzg7Nu97GbcWtAThxa4TD+6Pw8xYzxafFExvL/?=
 =?us-ascii?Q?Hb/mM0JMCQN56XfWjRq+gwkmdbRJ/i51gb1bVFrea6I3aXJ28dhRxsVpAj1p?=
 =?us-ascii?Q?0kCapZLBjvjn97isiPywJJ0WCZsSm4eFY7obRJJw/6prTkGxDQZoGw2nSe7p?=
 =?us-ascii?Q?/ZBB7pDuG5ruBLTxeN1kEQFIZ698qlWViWfuaOfR7YR6gNoQvxhGce4+oALU?=
 =?us-ascii?Q?Z527Wj+HnuGgoOFzWL1NnyuQXFob7c+SycoX/luAlji/J5VzGIyK8nJKshyv?=
 =?us-ascii?Q?i9S4ybRhK0iKPtOroCQnYP0sb74tLFqdIx97UKD/ZNUfOEEkx8S4dMZSpqSx?=
 =?us-ascii?Q?p1tmlM1oxwclihCKyNCtv664C5TEJyA6duXLGpEaRrRvlC9enkD2psnSDozc?=
 =?us-ascii?Q?Eog5isuBjaP3TV1KlfJkaY8LcR9Q1SPxhamxV7S/PAeTqKe7y6Yc7Rqbk3S3?=
 =?us-ascii?Q?ZfvP957yKYdQT70WlIl/cmr5tzbOPa9OVZ2f9SEGBKe8aPo0tMid0erc735+?=
 =?us-ascii?Q?wNPOOdGz/iUaJUkzhkJXAenvmrSo4RK8gBe7ff8/OUNj6UTVTsLDhguBDz6A?=
 =?us-ascii?Q?F3ZpNb5TY26NV/pR/99zUUHfOvQXHbNd1QMKzw9y3N9BPRbHESlEGsgaZdjQ?=
 =?us-ascii?Q?wLtf2fxIr1ESWMxPI79RqBGOIwrC/fVnUn5J7JMiSVGb8aBAMmFB6FNYWakK?=
 =?us-ascii?Q?0mZHOAv6o2zdeAu1cQEX4BJdmO1uOcOxQeNSWVMXHdL76KTcKwRQvC46G7Mb?=
 =?us-ascii?Q?5M3Swj4WLCyZObbgnEiw3fgQNUG5TckyRZXLwMARiL4ex+oNLkDY8LNUqfK0?=
 =?us-ascii?Q?VJjQtS0kn9n3qHxSHDoK37jKFk7+8TKSZI+9J921LFdUrRbROBq2OG7Xzsri?=
 =?us-ascii?Q?EpZfJw1kVSkV0Lr/PVQhM2MK6SoiApAqjgbQ3JQIsZicxLWxptrVMC3MxFY3?=
 =?us-ascii?Q?50kRZpcSLilU+9KNP53aIkGkN1UGNKKlkoz3GoNS9/AQ1LcTVoiUcAXENQyY?=
 =?us-ascii?Q?N2uGdqdaY0A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cMqRLQAzu6vtgf0lTonxTgAIErFU7AQkA4kTjv37Bi5YbFzYTp7Xh/biTXYD?=
 =?us-ascii?Q?eF9/qHUspsu0GBRpRNJyx9pGFSUV7+4fJcnhvRr+L2XiBQ5w0PMviLygSyAe?=
 =?us-ascii?Q?NILXdiuTT/9QSSeEUbXOK9TQcYeY99a0zxil8zo9+khDUJVGzP5fUlqvKDGb?=
 =?us-ascii?Q?Ffy0QV+wA1LyK6SF37LkxvitAnz4F0quXV4wPDE0Dnf4NZVd0Xi3qkSZB0b7?=
 =?us-ascii?Q?Me9eM5nBJvTCdZpFw6qrZ3xJ6IplZsRmP6h8KnFBFe49a8YrluHQEQXhuZ9y?=
 =?us-ascii?Q?9wtqCMJu4+ibNO+gYKX6yQjYz5n2gmmLOFIoTJ3yyBj+BBQBr4qhxr5gPNil?=
 =?us-ascii?Q?q0xKP+ObXTSLCctxevrX2ZDyWoxPerb8JPXU3cwk4bp2kg1Bom1u0wdjgA5X?=
 =?us-ascii?Q?tMldeeL4ae1EXI02Dds4eWIRg2DmxzVhxDbZeZNUsFIBQqHn81pppmDgfb7L?=
 =?us-ascii?Q?M1+SRNKcpOP+E0XYjzlvdejRfdf6AK4M6AkWVqd813Nn7XRYk8dU+tVfDSbk?=
 =?us-ascii?Q?TMbAcFXiLwq2/MHASbD6OODmOHYy1qjowq/y9J+i68TkV1jr08v13F1HHhM/?=
 =?us-ascii?Q?fhT9I7nuF2KgHm69ivcYwLisY8JGRlUWDoypDSVU4JVWHZ6mIUZufhnzwqyx?=
 =?us-ascii?Q?rs6G9MKw4Z4Yrv6NA2kXI6TDuCQF0VYhS72UPpYaS1Hf2CcCk4WsqRiFpcGo?=
 =?us-ascii?Q?eBS743imjq7SDNtaWuL1DYS4zy7I3i1P45kudih+o2dN3HmQ7Qtiy6jcC9zH?=
 =?us-ascii?Q?ZU2KE9a1rIsoLucV8cOZ8lZM/B9ezR3D7b9otUJVjrmJkR96rzplV86bSkNp?=
 =?us-ascii?Q?y+ymuhPJ+RLwRyBIOKx9/uN8XecJ0ID+5hX+lRIXC7uUWdEFyWgMEgs6+RmM?=
 =?us-ascii?Q?qaM6lJjF2u2xnftPlsNENmb5QOWP7rjCPecLH/V8PFmxbddSYl9Hgn+yTDLN?=
 =?us-ascii?Q?4k8eDP0lyR0qMAW3HQY2oKD6Awbe8AF6ltbSJA+BXHlfLOKNqd2RdRxnlLjW?=
 =?us-ascii?Q?kWhvlLgvAi140KYvNdSrxeS/XiYPGRNmETQUUs01WsvTA4COt62BxUvKbWxQ?=
 =?us-ascii?Q?r8XTTBI4iLNR++ZyHrszrfONPy7hbEAqVPd6alqR0Z8F3DBsXhrYSq2NTJ/j?=
 =?us-ascii?Q?uV0F1ygufrLhh2l1X3sBvlgQsuQtnjyFzA4GSVq0RMSHQVdSSgaHKEo1l91k?=
 =?us-ascii?Q?QbfBTqn0o2p7oSTiMIVimbBMOFIJSl44ceZjJUT+lhw0nUOt3FBKUR+OiqrU?=
 =?us-ascii?Q?JGagFOpl4Zcvpo7vE25PUOuHnHds0pvtguhxPd37/Yn7ekrsGUZRR0faQfKJ?=
 =?us-ascii?Q?4giYyPgcBhVazMqA9abe3sLmW5mV5HaL3XeWdUIPPw0dABN5p3KmtlN5l6An?=
 =?us-ascii?Q?FRRoVHXPNVchhL6zVDIBRheVts7k3o6ucE31ota1kNx9yOGQ0hQfh9oeU7XU?=
 =?us-ascii?Q?7L8KggXBqEFsvgqyFTXPGko8le1ZPdV/KDNO0aDW/4EhXqro5Hmcq9l9RlJz?=
 =?us-ascii?Q?3T6BmedUt7HQLC1nh4Dy5L2P0zGsOgfQ5MoCTrctuOnR/BcphAy1BICXZUpz?=
 =?us-ascii?Q?JbkqerTybooXx6F88U8y7soffu0yCZvhHZWB6IA7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c86477-924c-4bbf-6fcc-08dd82721463
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 14:21:03.9317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Qp6jkwK9AX70JIZ/prMYQ2M1q12K48DstL5EcNX3NLoMUWw3Ersxav1TPp5AWz8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017

On Wed, Apr 23, 2025 at 10:18:39AM +0800, Lu Baolu wrote:
> @@ -3435,7 +3448,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>  	    !ops->blocked_domain->ops->set_dev_pasid)
>  		return -EOPNOTSUPP;
>  
> -	if (ops != domain->owner || pasid == IOMMU_NO_PASID)
> +	if (!domain_iommu_ops_compatible(ops, domain) ||
> +	    pasid == IOMMU_NO_PASID)
>  		return -EINVAL;

Convert all the places checking domain->owner to the new function..

static int __iommu_attach_group(struct iommu_domain *domain,
				struct iommu_group *group)

int iommu_replace_device_pasid(struct iommu_domain *domain,
			       struct device *dev, ioasid_t pasid,
			       struct iommu_attach_handle *handle)

Jason

