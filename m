Return-Path: <stable+bounces-172318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DF7B31017
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EC35E4818
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 07:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66BB2E1EFB;
	Fri, 22 Aug 2025 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0ogmuE+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A114819539F
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847016; cv=fail; b=rcy9jT2lCwS2kHOhdRq6qrBbPqoLXWI47tbfKQOLD5y2VFgCdNiMC8VzL1Xd93n2ohfueYkBacETLMggfJtFUHmfS3K5Op29/k431dwOogUf+brOIfHQloIq3awuYJp0wVzTORJkCT1i1URZ+ig1nklprlIpN2Jg/IkgFElSWwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847016; c=relaxed/simple;
	bh=ltO+uYsGE6lFmbW1qFCkRBEXSXFN16OqhPlqf60RBZA=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UfQyBJk4pWUKLcaGDiho9Ve7hCYN21H9k59IA4txRtvZCglVO8m2eRxOgKZ841UbsU/SkSoW8s4cUdx2VrhAz16R2birxNoLLaSaDQjwVoJxlmt59Ptvl6esikltpjzVtrX381vZwUFK8sTL0FQUNjQusvSamUB5Lro4B4qMwi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0ogmuE+; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755847015; x=1787383015;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=ltO+uYsGE6lFmbW1qFCkRBEXSXFN16OqhPlqf60RBZA=;
  b=k0ogmuE+fCfD7yoNowatFoQeGxd8qGzLhNWmYLF8u9IDbRqL8Krb++U4
   eC14tMH/ignHtw5FSSIFQ98xvwyy9TwsP3whnM/JljD17k9+m6f32biaJ
   NxAyrdUkM2lwvU247IVn67H4enW9uIASNeMgXCAOM0SkzDsX2CP4+DAHM
   GvYk3GNlRMUoWRkYftFb2q1Jc/2U8HlfQBile6wHdgWMblTo5S/6UJKfE
   y5AeaR2HDWUf1qdyC6WgpSVvX6pB0jDytCLnh+ycQ8y7xq87oC+dFsbtP
   9OODp1AEcNUfFx/l7ZZLWN7MUm8hDiShuj+/wQsVy9bsik6vSAWRkegXh
   w==;
X-CSE-ConnectionGUID: ZbcX9ZoFTyKP5kPqi5bk1w==
X-CSE-MsgGUID: FOPe9i/5RM+MWS1y7zWJiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58217192"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58217192"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 00:16:54 -0700
X-CSE-ConnectionGUID: L1kKU/vDSby6DpwxCh5N3A==
X-CSE-MsgGUID: J9RpH7OtRqyqua9DZDIYGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="167872107"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 00:16:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 00:16:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 22 Aug 2025 00:16:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 00:16:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HChR6vHQ+prlldc7ABbo2dIbj6h5G+m0B1PJYnmg+aRWp4LKoUbgBcnVu3yVpdt1Ck1bZDoC7BYFMDSMJicsbd/Xsv508bDVwOFs46KuOKKUEqugXdVaEnoiUEw27Hc3BFBQdS4U2PF7mmqcQIhvgZdvFDF+CN8kT4La3aI9OZ2eyqivuEtLfqF78Nhdy+Qx5DcfzHeKl1yI7HOFm7wnu9BF8x7Ny5Tt6Sw9ipKEFbfyfQsFpX1+xcLNfeTxvQuAPVM0alpau6ucaxFShPDvMpwhj8YkyiyuVnEe36g9Zh5zgApavtT19/E2SFG3dI3vF14w623vVHoBj4gVXC4nAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwc6QYSLLkIkMhFGUgPjA8f82zXswQwHTZx7mLGPT0A=;
 b=DThGLRc4LzPRnTjm61n/a4fybzudtcznlQe6LqkHQrX4WpadY7rGuL9wzWALkzMXBpmp0VnqxaX7vmuq12KzFtmKX6TbuSxesLjsYDe9cknbbFI2ZHKTpQuX+Rd4fl0OfRL2/ORRgZZXnh/Tjs9MqqRUu6ZVcowBDCfRNbi6Fl26FUlmZtjdR8Oqes31EXIB8dDWTcDLNokr2NX6l0v9S8QJUKM1O81vFaZjrrDAMF2g6/7hC1aHzQweA8lqW7FBJeGxCfV9BcZWaMh08EJH4qIZqzl6Csnwiu/sDZHCo5LfaXZEfVpEgJoMw98ufdqjt8c1i7RWbT5PFtDrjO1x4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by MN2PR11MB4582.namprd11.prod.outlook.com (2603:10b6:208:265::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 07:16:43 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 07:16:42 +0000
Date: Fri, 22 Aug 2025 08:16:36 +0100
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Sasha Levin <sashal@kernel.org>, <stable@vger.kernel.org>, Eric Biggers
	<ebiggers@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 6.16.y 2/2] crypto: acomp - Fix CFI failure due to type
 punning
Message-ID: <aKgZVNygjrqd9L6M@gcabiddu-mobl.ger.corp.intel.com>
References: <2025082113-buddhism-try-6476@gregkh>
 <20250821192131.923831-1-sashal@kernel.org>
 <20250821192131.923831-2-sashal@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250821192131.923831-2-sashal@kernel.org>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DB8PR03CA0017.eurprd03.prod.outlook.com
 (2603:10a6:10:be::30) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|MN2PR11MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d86ef9c-1405-4915-49d8-08dde14bd88a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qGOGbS52u0X8PBZuZpM8xubsCp/FAib+pg3r88QqMRvJR+wE9O6EIDPPUwLs?=
 =?us-ascii?Q?iDzPEbsyfp6XjKtBymiujJkNFnthilBfdbdO4z2kOUwJD274BLMp/SrOw0xK?=
 =?us-ascii?Q?5HpQ5LC+pGnFGTSYyHUO2j6UIXcvgi8EhOtXU18fxdmLzCoTBxKdScMkf3//?=
 =?us-ascii?Q?Wg3ivYyxnNmLrc0Nna/G99eYpMsgKpYm/26V0FRz5RtjeNjG3R9xAKWq0Hyi?=
 =?us-ascii?Q?jLsZUyncIJKdtZ8sbTkb+UWQeZPkQ53rkEm5tzKa+J/tiOxyrBQPje07Uy4Y?=
 =?us-ascii?Q?f/xeva/siHMuEZ3uRk79v05JlVfDYAzxgyIqitvS+WIeczzHJYkReaYFMHND?=
 =?us-ascii?Q?LMHyioST7afzSLd8l/ZjwSB3tv8hnjF6wqF8wlT1fB709OKLSB24B/b3qJua?=
 =?us-ascii?Q?/9FsicfzBESWvZ6w9fINPzb0+f6M+R7CyOS+YAgkdi/mXrqUc4rE2Wu5Z9LE?=
 =?us-ascii?Q?nOokKaP1evUAXZvExLKTq4ezhf2QUbFRKGG0FVunoWFZp/VF9LjcYgSV3QYE?=
 =?us-ascii?Q?SDIgHnc7qzxvhfSfd6sS6MwuV6r6Ezhfp/PHPikN0TeEVAn4Q2qwXzwwCn91?=
 =?us-ascii?Q?2iPA1imO1JvnPlHTxCclMrNbm4nYNMY3INdTSrQex2zf1QLEItqihAGf+sMG?=
 =?us-ascii?Q?C1yhIYAw1S1hde69pmK2cMKNe0BddANDNt5/t1cpf7glGg8rQB+D42jKBnfL?=
 =?us-ascii?Q?VKjQF6qH1EAi5VvY6nNSOQk2jy2YxMnO2oIALGO+91SVIcutK3DWaT8qenpE?=
 =?us-ascii?Q?yLyZMvxDNeA1w1LCKWop35m7YeZRhtJQ5eQeUZK2aambSq5p8128hBgrYV5Z?=
 =?us-ascii?Q?SXWEVy3Vc75hSLgmTwmCvwk+vOGExZW++o5A7GvRQhWqYc+Ibxl8yY9yQky6?=
 =?us-ascii?Q?VW8D2jUsu1KHzxMEo560fyjk4vE7UIJbPbYsJw4EmZfpj9UKAwq39tVi/B3Q?=
 =?us-ascii?Q?au+6iRbLXpuEIo8VBETX2YHClqg2CaqZzUoTGsxOdqguHIHjdb4kUAHTpKnF?=
 =?us-ascii?Q?5kDPn0RBiMzj86l7UWBR6b8r7QzqWcANPKPW3/tYVy2zLTBIZjmdpOuBSssP?=
 =?us-ascii?Q?oLXrBbET6TNFD2eAFBKuZzOR4bC8iCg6hXdHfdtYX/PMMaPfTWklaF3sWuao?=
 =?us-ascii?Q?l4/x3Er8mrCxTPKUZKg1nxJVKWdNCDdFnYGaCiZe/WqBTjApY95OJ5PArBI/?=
 =?us-ascii?Q?NZfyAmNQwqPDvH+WiflxGY+X/JclH1BlC/64HJII9GKOQePKHWbuYUFUeVhU?=
 =?us-ascii?Q?bNPftnu3qvlpTUiMTr/an8S+WiDm6RkpVuFKMqbsWjeAwKSaoYr5uXxUIgbC?=
 =?us-ascii?Q?iyRDc084s1c/+KpXgUeJiPlnDA3M+CSNvpYTxqhvtEE2mX01rObj7MfoJAho?=
 =?us-ascii?Q?VjJeN/NASWyIzYgpj8RoMF9tWgS1+jBa5GIyozkbqlNGPkmrmGHaVVATprq5?=
 =?us-ascii?Q?JMTlEBBUROA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X5ZBA+nPCv8XH0Vcl9B4CyotLLC+DHf6qi1Z8CMZ2mvR2eDjErAwaI+QmEk6?=
 =?us-ascii?Q?VFSXa9Vaj4ICiX1qwf8p4857T/9sSTAAK/PxWm4/289Km5UCq7u8+a4Oc/6G?=
 =?us-ascii?Q?N9m6e9ukIPPaLg1PhBUw1h1JUEZSZWOstDjLKPr82R/OvlnRWjNJyZRthV3k?=
 =?us-ascii?Q?jHacU8ke3pbIvbazl+Bo4OOYm5SpOYkhKgeP5a196UJAG0lc0x8z8Sf+gEc3?=
 =?us-ascii?Q?BeEd1OsXv0tL9sXag7fE/KhMoBfuGxUko7kVFM9xNTUDw5QLz8vBIwG4U8u9?=
 =?us-ascii?Q?iKGkk/37EWtNoGzCBc0EOsxTv+otGEJc0hk7Pv5+Q8ONivxySxcsfoKKNBi+?=
 =?us-ascii?Q?Ft+hq0sWNiGpfsxtNHydB7WJgsWewSECOxJ0Jv49irJl8Q+vSxAUIM5tGmg7?=
 =?us-ascii?Q?PmSgs4FAy+NX2gW6nsVe3qoSIh4UIlVFxCOjxxxwQojo4iWR5mkPG+fiGDat?=
 =?us-ascii?Q?YT5ZRv9wxDfrSF5Ut1aMZDsRXM4UR73rGV68NaK7wlbxqlSRAp3mP+qQE3b/?=
 =?us-ascii?Q?99M/oa8HIml3Vp8A3A3sBqfgFP4br1Em/zSiIm5Qxl/c9DXdVw2JZnb1scVu?=
 =?us-ascii?Q?9y32Jj+x2uZQo2m3JeL1R8mlTThffakpr1okaT1XGwWxJIPx8yiLnm+r5BLh?=
 =?us-ascii?Q?MBTTBXARivffdXQeC6Zm8TFhtTqrGFjOs48b7SvNLqPc3maTLTYK+l5XXwKI?=
 =?us-ascii?Q?ZqNLuRspw1+r4pVp081dSm/9Y470kRi1KpeRZ0YSkTPaprc8sOAE1QeW1Hb+?=
 =?us-ascii?Q?GkYdLkzAzEQWclOY+3HjTj3U1z5P0OCEJFue93DKpOho2ctML9cre54v3nZD?=
 =?us-ascii?Q?XcjweG4Dv/bGniXXmaHgeqlQzVbzVEVc/uDHFnMZHgT0u/UduJY/Blgl5PiS?=
 =?us-ascii?Q?R/X6Tc7SZV+ryWGBREdznoAI5T3bmXraoc4Wg0w1udo+qZcUU6Y8JdTNBK5R?=
 =?us-ascii?Q?+M6ocpmp5/JhAxyS7ZvqMoxViQlijqRBNEBmGFET4SCfGru/tnYkJSzdyKJu?=
 =?us-ascii?Q?5cTxmt313+PhYZs9zt2zrO7PhMCjiWxYM5Z7CJlHd2d3fVcCia4gDuIRPt4V?=
 =?us-ascii?Q?+A8503mnvFhmCbMaIKrc7Lf632JZz66UDrFyEEDjdSrYaxB74Yf9EtKMAbcj?=
 =?us-ascii?Q?ZOGDATY2jR918HAOKiRR3AkgUPjjKCoAF47WvZoDnZxIL1Y6N6lPLQQ9mbC4?=
 =?us-ascii?Q?dQHCPyYuDFJKS++sxDcerQS+igmYzyt07aUQG6eC56aoC4iSF0WX1LcbXwT/?=
 =?us-ascii?Q?PDYyGQlBtfi2c/peXZZexYzuULMy584oOgtkUpFRH2AXeFNKBShB3rnEaS/B?=
 =?us-ascii?Q?gcd3qDL5o1EORcYPlaMDKbuOqkuLyfm7lwUioo/6vj0Hoq8TAAIIG4woJm0d?=
 =?us-ascii?Q?6s8ae564vKn+ZCZSpqN3mfeGtUamnjMD0slASLzD9TzvChj8Ux5592Ca7vi8?=
 =?us-ascii?Q?7gJ3GxrFs/vglr2oJ9VvN6rGtHEHKE/DZefXGohFF7pO6JyF7xaHuuqWpnaE?=
 =?us-ascii?Q?XLJ60R3XeI0qowwoT/0Pg5WZorat0EbzA1VxCQVZM6vIxu6ZIYPBa+KAQHe6?=
 =?us-ascii?Q?Gi99ndLzmX2DD3oBwhFHpPcItoeoQKAZPI1JETuoqe05UTV+Qz3tQXUTVw17?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d86ef9c-1405-4915-49d8-08dde14bd88a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 07:16:42.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NuNmsqlAkNvvRrJHvzBO/+AkcpeQH5nkkuXcOv41x3d0OoBwRoWycl/q48Ij31E898+OPsvmcYNYU68VRtNRv8rK6fJxqXW8BKfZnogV5ZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4582
X-OriginatorOrg: intel.com

Hi Sasha,

On Thu, Aug 21, 2025 at 03:21:31PM -0400, Sasha Levin wrote:
> From: Eric Biggers <ebiggers@kernel.org>
> 
> [ Upstream commit 962ddc5a7a4b04c007bba0f3e7298cda13c62efd ]
> 
> To avoid a crash when control flow integrity is enabled, make the
> workspace ("stream") free function use a consistent type, and call it
> through a function pointer that has that same type.
> 
> Fixes: 42d9f6c77479 ("crypto: acomp - Move scomp stream allocation code into acomp")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  crypto/deflate.c                    | 7 ++++++-
>  crypto/zstd.c                       | 7 ++++++-
>  include/crypto/internal/acompress.h | 5 +----
>  3 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/crypto/deflate.c b/crypto/deflate.c
> index fe8e4ad0fee1..21404515dc77 100644
> --- a/crypto/deflate.c
> +++ b/crypto/deflate.c
> @@ -48,9 +48,14 @@ static void *deflate_alloc_stream(void)
>  	return ctx;
>  }
>  
> +static void deflate_free_stream(void *ctx)
> +{
> +	kvfree(ctx);
> +}
> +
>  static struct crypto_acomp_streams deflate_streams = {
>  	.alloc_ctx = deflate_alloc_stream,
> -	.cfree_ctx = kvfree,
> +	.free_ctx = deflate_free_stream,
>  };
>  
>  static int deflate_compress_one(struct acomp_req *req,

Wouldn't it be simpler to drop the below changes to crypto/zstd.c in
this patch and avoid backporting commit f5ad93ffb541 ("crypto: zstd -
convert to acomp") to stable?

f5ad93ffb541 appears to be more of a feature than a fix, and there are
related follow-up changes that aren't marked with a Fixes tag:

  03ba056e63d3 ("crypto: zstd - fix duplicate check warning")
  25f4e1d7193d ("crypto: zstd - replace zero-length array with flexible array member")

Eric, Herbert, what's your take?

> diff --git a/crypto/zstd.c b/crypto/zstd.c
> index 657e0cf7b952..ff5f596a4ea7 100644
> --- a/crypto/zstd.c
> +++ b/crypto/zstd.c
> @@ -54,9 +54,14 @@ static void *zstd_alloc_stream(void)
>  	return ctx;
>  }
>  
> +static void zstd_free_stream(void *ctx)
> +{
> +	kvfree(ctx);
> +}
> +
>  static struct crypto_acomp_streams zstd_streams = {
>  	.alloc_ctx = zstd_alloc_stream,
> -	.cfree_ctx = kvfree,
> +	.free_ctx = zstd_free_stream,
>  };
>  
>  static int zstd_init(struct crypto_acomp *acomp_tfm)
> diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/acompress.h
> index ffffd88bbbad..2d97440028ff 100644
> --- a/include/crypto/internal/acompress.h
> +++ b/include/crypto/internal/acompress.h
> @@ -63,10 +63,7 @@ struct crypto_acomp_stream {
>  struct crypto_acomp_streams {
>  	/* These must come first because of struct scomp_alg. */
>  	void *(*alloc_ctx)(void);
> -	union {
> -		void (*free_ctx)(void *);
> -		void (*cfree_ctx)(const void *);
> -	};
> +	void (*free_ctx)(void *);
>  
>  	struct crypto_acomp_stream __percpu *streams;
>  	struct work_struct stream_work;

Regards,

-- 
Giovanni

