Return-Path: <stable+bounces-166718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD39EB1C99B
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 18:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4997A3BDD
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 16:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A561D299A84;
	Wed,  6 Aug 2025 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mkENUPCx"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCD9298CC4;
	Wed,  6 Aug 2025 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754496552; cv=fail; b=R2/ae8mE0BXCOSelzZzVjv6H2nCX5lOUT/7Oz2eOpEXenRfkCg7brH3YhEMo7P1Q6vpzwP1hwbMQ6QeSD646btXWBDD1nlYywYyEcnfuF4NJjFay4DnTpPRwwreNFxo1jvPOSBErfVQxqWF5dNwVnOJme5E+ovdcPp8lhRXHWiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754496552; c=relaxed/simple;
	bh=iHkQ8lY9q4Dv7MR+IjKjJpBlbooNfYO5kQXKRP1QO3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b9MEFPCgqIp/qR7FlkZLjalkgd78rwxuFemOQiX89t2HUPFZXFtFqGG0JggCL7mXsw0KAQictlHTTHEoP0uqyqtxlP5zqWRWtKSwRUZWjJCbBk4zeUD2bXWwCwcuJLdkRJEO5zEMZlDeUiZqBXKhRO1rW2I+Ss18IgG1AkC33Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mkENUPCx; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enp6PAzI/laQUljDFxMg98YBYjUv+Yx9Te8rO0qJXs7uKhggcVakWOiVI07YOXSEN8DgtgahXb//eDmF4J80zlO9bDZYA2ty8kgXxoqkFF5p/DJQjfA+nSSC5aVq08VwOIUMICf5AkFRlVdRGe2tYG31bxc5jf9ev8yZsrHgy0srZ7vwJzrhcQhyX0rxhUKHJjVtOITb36iPYAPt5rI+8OlV7OAtx2gL/FuhPPpw3BR/sWyRBGO9Fyw8yfcuxlhm+iqhBWFF9Uub8bf6wT6hiDWdk3PSBOmn+t71xh19WVoWZxigDP/QktXrXigF8CGXQROLCY2nkgKIrbRP47uMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gw3ML0Vs5yUlCCRt0q9v7M6BWk1ySGRTlag4rsSBPS4=;
 b=j1JWvGM2iTTlNN8B0+p1sdXjEVQRhLpJvmW99RNdTTh+17U8YAzXJhFqiAf6Or1lje2WVZX3ht0RIyP7RT3Xb14h9EzdiECEXLZ6uw4CEVoNKQopUL7KuiK2hlTlLRh1i+2R/Tc6H+ZXFLvgkGywikmg1XTmDsVuZYi6kUj7AHER5GXegQRZLH97G32DMM12Ece07n/RtD2kMZIWXBouSSSTKoJPZXK1OxkzGIoUZx5CSFI5batZFEVLCux6goCut0lS8pMC9tCglMGWp3hIK4Aj5K2vXEFx6LiGs+tUvcyI7Tr9nguysJyq/BYgP4tZD8XBoVSz3buQFej07gL71Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gw3ML0Vs5yUlCCRt0q9v7M6BWk1ySGRTlag4rsSBPS4=;
 b=mkENUPCxjHJDLRmkdr6ck26KQUN7qdPR/qWsDku3Ys3dcEFEXzWBUfIf80T/1bVOQXywlYol+mXfS0BVU1hvcB1MCNNd4JGA4YWmI587AXz7YcE2p76E4zmYdJ0Oi2sJxIyYrcHpKxJyF7xC16h4zpN1UafGu8f/tLHDu6f/FSM9r0ZyjMGXjR2UayCiJsB3QtLPVyuBG3NL5BvvIOnokLY3qDVXDMHTynQ+41RFEgkCyEqJsYkTCWqwORKGQ8J4iiOujvEUQ/1vNY9zqNzxFF7Ahq8sBx9926A4jZwVbRLYTNcggcfb27h3kA4Wa/U/CaGDF2a7gHWAK4vy0/vLmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 16:09:05 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 16:09:05 +0000
Date: Wed, 6 Aug 2025 13:09:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <20250806160904.GX184255@nvidia.com>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
X-ClientProxiedBy: YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6daa3d-5d53-4860-2c29-08ddd5039134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4YfHq4VvT6FCC51YwnQpN7b3KBI8dYnfa87/4chPqGOqG61YOQD4TaYam6fG?=
 =?us-ascii?Q?ISNKW98es1W4aLsC0B8R47Y+cAqti5mfImxPiyJquavMnoyvWGorHrLlDKRP?=
 =?us-ascii?Q?DH0w2vydheJt5+I1+WLORXgBWTJ2mprNReJrsG1zxV8NshfLgZy94RuoWUzP?=
 =?us-ascii?Q?S7mRxjKg8I7baII9vig8ZFdo1x24pt+SPWDWY8TPub7RBzXFivu1G/ecP+4n?=
 =?us-ascii?Q?upTtwg14IrbJzRkGeCimP7ICu5fBxe9436qR5l3IK2sywnRpDdU/Pb2OTWdN?=
 =?us-ascii?Q?QxAvywTp1rh0KxXwg8bofxPKI42YeEP7Yzcwl4JmzVU1XrSl5FLhz7yq3POS?=
 =?us-ascii?Q?vyVuo8eLuAZeeh3lgaWMvJ1vU14IeEmkAM7h/vYM4FzxLmf4403w+oNbR8cF?=
 =?us-ascii?Q?yIBknd1Ibtwa9W2SQgBtBLDmY7THOn2EUswg6AccUrGPj/RVv5OUPWgQJ1Oo?=
 =?us-ascii?Q?jR45p4jXIOxYR8ItQ4I8OGn1N3FjsdvluJ6pnhjBxhU7xRAx22iJQXPAGvdl?=
 =?us-ascii?Q?Dcxyg4qGsFhCjyAu9jR2+e7Wo9jPdbsBOC5/xba5PlZLFu+jB3dzNEq7G+Ji?=
 =?us-ascii?Q?5j4mmJYOetXeFOcf4niDIvJoE1mbV9285J98Fmft0ORfDc96TUe4UyAoq7Yn?=
 =?us-ascii?Q?1FGmMnvP0TiUZTjx/yoX4yCP6yHfSn15hjE/gFHFFzJCEmNRuAb8igMM/Slk?=
 =?us-ascii?Q?nbB/fHZHlVacpWgk7ziVFLIG+UYoLhOLER+f8ljdFI6icVOp1xZoa6cytvCy?=
 =?us-ascii?Q?sGA4fYF1pCNR9IFwCHjFwxbRS8D62civ9YCg5VbxP5hdSqE4laIEjRTYj2UX?=
 =?us-ascii?Q?XnwuYi1w54tkmfYWioCuemBoVhGTaQnrpulY07E88S/CYqn+mEZ9uJ+hjSbf?=
 =?us-ascii?Q?VlcX+3p95fqJVtHotETmr9+0XHkfL6kweX6fpHhEVGRjWoclaTi45CKctQYc?=
 =?us-ascii?Q?DHlCzMVfzYl++Tdv7/4nVJeAvCicwjvCa6KerVdhH6waY+IscR8pVNyct9Cj?=
 =?us-ascii?Q?x5aBY0I4BuQym0dQxJPp5OoiPYxORpdnbGU7Ni9SoEDq+/yb13LxTjYpmBw1?=
 =?us-ascii?Q?vzTB6ipm0ixzf5TwgfU7YnQOEwagvDtSfRMthM5QYUYRXLrju7lm4/R5N9k+?=
 =?us-ascii?Q?L98fNv5sRgJNItKN1VTvlxatc6w/sGIAo7SFs8UvJHLDrmKyXnuJvOD3nWnl?=
 =?us-ascii?Q?x7v8nKZV/aR93vL1ySbdGJ7RN3KBXK1kJloRuR2YGJZf1EM1AhpscR8Uu1n/?=
 =?us-ascii?Q?C1zcg+Nqylyj9yPU9fKnPCAkyf/1neHfJzT6NFXVrQRolmaxUYKqycUSFfz9?=
 =?us-ascii?Q?5Gbjqml4k6DHqEETJxQ7tDMAJqnq17WEV4Ff9GsXUv76kmT1NCLWcr3DZ7DQ?=
 =?us-ascii?Q?DMSoVEzxWPJoNJ5naN33ONNzF3HNybBDYwJJv6oorQeusaLemAEw1uEnSd1T?=
 =?us-ascii?Q?mQ+bMr58g3g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1o3S4fUGUj0M+t4D0Vnjh9fF0REtncpGPicEdL23TYY7EefeVunDCSfGZt59?=
 =?us-ascii?Q?7pXKCiJmvWE8ZjYTlyOKFh0a6d8wiN01hgcXR2y+C2V2PPFQpfKrGsUJEXFv?=
 =?us-ascii?Q?qiv2s2rFg8AsIx+OqmEE28GokqJx7EmtXMfkmk2a6R3e04iL4Tntg3f3eNnD?=
 =?us-ascii?Q?Hw632blFxFI3SLJA5RrUVj5eHO2v75EzF87Xk9BVtj6dymcJpuIRA8/mI2sn?=
 =?us-ascii?Q?LE/HxIn26XAn/0IscxWgstoBJEWfrOwt/0WWVcPsMGpMLhJal0L80KeOnTOu?=
 =?us-ascii?Q?cNU0bDE/eRH+kD9hxt5LiXJnlelqUqQpdCFVtHZmdcvrNcl9ln/EhJlKIiAS?=
 =?us-ascii?Q?G30JCG+yoliKJSKTiu4K4xYcxFK0vFBJOAduT7nxP9wDraRjEME32hSoA462?=
 =?us-ascii?Q?3eL6cCl3HA0diHHuNpil//NSa1guDVQWhTJrn1U9j5oWioCSBz3DmQ/eekwN?=
 =?us-ascii?Q?oMpSJgJQxl+3cGvksNHIf6Ee+bOUJ3+GWeGnzXrQh0UGDf9H3l9EjQc20oIi?=
 =?us-ascii?Q?3wC+/PH6zVckvU5gatENKAeBTdkPN53RjFAl+17ulADtd5p0CwkfowMMXVD5?=
 =?us-ascii?Q?TpQQRfXDwe76RRYqjeDIBQ1KSLHNctxDXI0vfb98aOpHlj1RXxlA6t4YbS8h?=
 =?us-ascii?Q?VC4+w0eqZAbxAOv/lHL2QbnLLvxznvhtxyqt5JmyBHFAMJ5nqvvT2B4bsh7o?=
 =?us-ascii?Q?hmm5iVBOLejNZ8gQmcM9p5XuEHMHsZHWyLE5TC4kdy+K9idMHCmjSIasD7wd?=
 =?us-ascii?Q?2BNA0quBTNmbyjIO50ZLZ9ZArQgHE6MXVCOqZtuuCL6kGARylPe5Hayy8Rn6?=
 =?us-ascii?Q?gydxHaVLZdIr4WbkBCym6RgnvKg02gnbSMQJ5t+JFjbiUcTUhIlnN+7na1lf?=
 =?us-ascii?Q?w0HwZd3YrB2JTGomIo1W55hQbF0kt7otguXnYOrTBdTX4ammicN85JDXkHDE?=
 =?us-ascii?Q?J1uWRgKghlkAsBbf9G1qAYgsAV+getEx5UqUzV4ypshUiUfPYxefzDEKY+Os?=
 =?us-ascii?Q?ePZMMCWOxuyu9evLnJUoEYyQAkxj11GlenthTSwSeegtzeG6lRbVFOek//Pt?=
 =?us-ascii?Q?0CLciApbviHS5p3xX3itveSt8QAbqtypFFSifZ3EjY1z1jK3TwroWSf8ukZy?=
 =?us-ascii?Q?ZRxmM/5glcUyBgA1a9dagpvrI2tsVZZgEEwqXlzAy2orCbnYJQ7leGnzOLq4?=
 =?us-ascii?Q?MD/ZxQ9dpEQCkIHalCqIYxzLZDsrrziNj3HyYFIqn0USwUNDT3e5qAA1Tm/V?=
 =?us-ascii?Q?rvq5wEu9ARdCs2zdBXOZta6HktLyVuqBJeK5+741o1BtrOjduOfijS4NAD5i?=
 =?us-ascii?Q?XNBV75xO+Fh6f3OUv33zX0b92bB6TNzoXQ9P62F4vuN9AMP+IqOiXucSouty?=
 =?us-ascii?Q?OE3IDJ5gNBruDxUuNr+tynWBxlYCCG7CKs3EDRNWLnMXinSmglClq+cxcKqq?=
 =?us-ascii?Q?CkcBMsiY4rZCQxjsydyOzGY+mmpM4y9xBtUMHVF6ZN1+2IAikPrTjBdZWCn2?=
 =?us-ascii?Q?I8RTF9SqddExTl+buTvGMxQBLYpkyK2YCu+AXGyYFUoGN4mSQfDzv55qcVQc?=
 =?us-ascii?Q?mhYzDR+pFGaDUh22fJk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6daa3d-5d53-4860-2c29-08ddd5039134
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 16:09:05.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvdMNlD1a+hvlhfFik8L3NFYVM5n9wFDD40aHjDux70dVWaRfsdbCP6yjr1Y5Wvo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117

On Wed, Aug 06, 2025 at 09:04:29AM -0700, Dave Hansen wrote:
> On 8/6/25 08:52, Jason Gunthorpe wrote:
> >> Isn't that still a use-after-free? It's for some arbitrary amount of
> >> time and better than before but it's still a use-after-free.
> > Yes it is.
> > 
> > You can't do this approach without also pushing the pages to freed on
> > a list and defering the free till the work. This is broadly what the
> > normal mm user flow is doing..
> 
> FWIW, I think the simplest way to do this is to plop an unconditional
> schedule_work() in pte_free_kernel(). The work function will invalidate
> the IOTLBs and then free the page.
> 
> Keep the schedule_work() unconditional to keep it simple. The
> schedule_work() is way cheaper than all the system-wide TLB invalidation
> IPIs that have to get sent as well. No need to add complexity to
> optimize out something that's in the noise already.

That works also, but now you have to allocate memory or you are
dead.. Is it OK these days, and safe in this code which seems a little
bit linked to memory management?

The MM side avoided this by putting the list and the rcu_head in the
struct page.

Jason

