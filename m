Return-Path: <stable+bounces-180707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 268F6B8B50B
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 23:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2193561A80
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 21:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DEC2BEFF9;
	Fri, 19 Sep 2025 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxbBwn5n"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B1F27F170
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316776; cv=fail; b=ZBE2hNQxpb6YQd54gC0BMojg/O2eSAZZ60+nab47MSYBice1TPjXF+VMUcGuQql5eA4PNThLt6KsGDFxfDyBzZbYPqOAXpt3rw45Pi0Rwa3oZHgYIFEINzrOzd2zd0DaxuRRMmanUnDDvlAaqImM3Dn54xEJ982rxAYC/eXc5Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316776; c=relaxed/simple;
	bh=13IZ74gDZFsVMNsat9Pn62M3QiFEkfSKb3khHljEEPc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cnuf3K1ZbVXLYO+BTgIawqE9hk3dZ96WT+HbdiFp/s0jeo1nqlX6enC9AANmQQCItVBbotvy9qdk6R14IMjjwt4utL/QarKzHNsE5s3LL0eCykb0L2Mx9Z9xlUOxpIn2gi7w67N+xpDhD56EHqJt5yotORxWzscMoh9PxvvaHWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxbBwn5n; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758316775; x=1789852775;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=13IZ74gDZFsVMNsat9Pn62M3QiFEkfSKb3khHljEEPc=;
  b=bxbBwn5n0kk6PoakAZ1sLLlJA93u3RLk7rWidzVk1n2/r9XkFKzrGDXB
   3OLjDjJzpcgoz1cr6UeZOaHF/7qF/fEpqIZFCZYS5mrqlGe/5NwqUE9kP
   D8TuIo9/ojg0XXARVut91MIHcfISex192WtKzpgeA2LRvaVem9seyDX86
   9wBy6T1gQ+YYGWJ6EGmEzeoq123l34AA2TIA030tFoZHoxMfEZhLEf/gM
   QNYQm0IN59Wz9KbpwQ8tVpsFfSXRW3t4mydQHHIKjms4b6tRI94URqgaK
   mhWNx8K9Ur5jROQoxBagaytbjbQwAIqQLxRU1epQojXUf5QY6J3/+BvaL
   w==;
X-CSE-ConnectionGUID: hCbtebAZT9yZA+8R0/zDhQ==
X-CSE-MsgGUID: mV1jO/a3TlyaIlxo14Eh8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="64489078"
X-IronPort-AV: E=Sophos;i="6.18,279,1751266800"; 
   d="scan'208";a="64489078"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 14:19:33 -0700
X-CSE-ConnectionGUID: 2lHq/zf8TQ+y1b1jZdydAg==
X-CSE-MsgGUID: F0oUogOmQ1u6NKZJZhPDMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,279,1751266800"; 
   d="scan'208";a="175852682"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 14:19:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 14:19:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 14:19:32 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 14:19:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9QvgmPio+YyuCSrNbDco1wnXPThlwsSoU4lsmzkqbggIUYX1vZjuJTbEGVrMQ3bGoFwR6/ToMd8sEHi5kirPPlNCG/0QC5kF8D3RFaR0OxD0gP4GAJnZC3huGV3/mQIGZdOSO9pQXG+LeOTL2JJK27uibMmmOJxwHB8OKuWpW7/cJunrsUJN4fbLtJLERIBalDZrue7tYpkZXqjhLgypA5QamfcrFxQmB91VbiC5djle6zRgiAbs3VMrdH7/d7jAfLDUvyRrNDtR8RRXxpvEhu+KikWyLgDP0bm1z/BMs7fb+27hsFgQzDqedJ0BiwnoLq+hkieqheM/ECARuVrxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwKTJq6rLlcE6rT8g9sffVEmVWGSX9qPsU0ayJcOlpY=;
 b=EA2vKgk8atYeMkii4c2NCLDigmR9cnMByTXz/2DVYws4PmJcHY8Vurhyc7nUDDPVM04kXZvCt6MUAt0qKXwbn/AaDIp81Fy+fjzXwnvY8SsFXD9tpg4aCX/Feo3fnoHIS7UiGs0+fidz7gFeM/lcUkDAKDoSfylQ1VbIoghLFotPDJldj4FVP7q1i48F04DGhUz19ZfzHadoPJ9QHyqAZwltzbXgTEuy3dZ7nYAEnb+W/oU9ynDhVUHoIa3obaLm4HNVv37ZdTGpw4crsy9p1t8EPVe+45Qmdk7ln34Cu+N3JSpypiEgd22gcjRfkZ6Ry6ZWu3Zgfn5f4+Xf2VyYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by DM4PR11MB6168.namprd11.prod.outlook.com (2603:10b6:8:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Fri, 19 Sep
 2025 21:19:30 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 21:19:30 +0000
Date: Fri, 19 Sep 2025 17:19:26 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, Joshua Santosh
	<joshua.santosh.ranjan@intel.com>, =?iso-8859-1?Q?Jos=E9?= Roberto de Souza
	<jose.souza@intel.com>, Matthew Brost <matthew.brost@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe/uapi: loosen used tracking restriction
Message-ID: <aM3I3oRNuZL86_3X@intel.com>
References: <20250919122052.420979-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919122052.420979-2-matthew.auld@intel.com>
X-ClientProxiedBy: SJ0PR13CA0197.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::22) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|DM4PR11MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d07aad-1bc3-4bee-8404-08ddf7c23841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?zcs9823EvqjsU8yOVOcUYw+OZ2Lh59jQFmaImLrG/WOipMQt4yVjzlUVXI?=
 =?iso-8859-1?Q?y/nQWV6FYfRU9fnZqEc93waaLpIaY0hrk2mQrmDjwTW2Fpzwa+54uQz4av?=
 =?iso-8859-1?Q?3jMCTGbvyBSPHp4K+MpHmvnp8gDyqvhhT40sXXm8vT7gEMK7QNa1c1w4Ax?=
 =?iso-8859-1?Q?1zoYrWbDHr8hKjDyV67ur4O0gThjhf1+2Yy3MmLzojXzx/96fwyLrr0kfN?=
 =?iso-8859-1?Q?zWHdMUjk5x7LZAdBi4EQpzeMrHxIgOKpGz85ZqauAxV0kNse06PKIOE47M?=
 =?iso-8859-1?Q?B/nK2QkwfIzkPoy7wGC3OgKtRSrcWh8nFAr+bx3WiQIYdkKiinpRslCSMX?=
 =?iso-8859-1?Q?hJyRatPfOp2PlDviHhUOXSAsw/Njr1ElT4s03LeckC4IMD4/QDfcoH8E29?=
 =?iso-8859-1?Q?26V6106IyL+cG1GLjzJzQLvkxiyDjVjK632PG1u32k8j+akpAmqaXt5ah8?=
 =?iso-8859-1?Q?WeWC1Tolk6c548oexdyCt3vgkEKFCbSaMazP7wKkuqHO671yK3vzrFoJGH?=
 =?iso-8859-1?Q?HcCfdyv8/nuoTjlwkRDSwKiddkJzM0Qi3MaFuUWrnBvfLOTAfmdulsr8Ez?=
 =?iso-8859-1?Q?KG/XfNFkyIIxpEJn2rR0w/tu1VZD0O0ESetcX2hey2ImpomWCwFiJYoH88?=
 =?iso-8859-1?Q?GXADooSOTcXbMydaC6C4pTogJW/c7TvKOgWt44iEBZt5FNP+KuJ2/+bQdf?=
 =?iso-8859-1?Q?W+/TsjdIF7gAS5grWAfRrtNTa1bu8TrOl6Jj6fPSuZxzNsWMBp3kbjYjmj?=
 =?iso-8859-1?Q?XDcE+OJcKnkz+5mxHGNUG3nMhLYwlNVm5UHX8s4aWRaw+VWb5sMbon9SWh?=
 =?iso-8859-1?Q?wbB5mKbcvjuhKAnjAra79VkKITPUFKdSkeqDxA8PomUJDnhULLIEaCQJDF?=
 =?iso-8859-1?Q?CHpzp0VlxmL+G1vjyizAklp3NXIzsryag+pOfZgVql0RjlwzRNwK8rTuyS?=
 =?iso-8859-1?Q?/uEKPcbhKTrxK6/t/abhs75R8L7IrnzMPXQIh3kqRvEAGG3ScloJN0MeN/?=
 =?iso-8859-1?Q?M3p8yQvhuPlbb79fzrPWO2eVh7RKn3Ze+bDgWVMvhqYi4R/A3PbEGap60A?=
 =?iso-8859-1?Q?eUB+BpI+rp32sczoTj+2TKkw0DCxRt3bcRQ5KFDgGgVsCJECT27kzR6vtF?=
 =?iso-8859-1?Q?16tkHgU+QzoAQjIK7x42GentIObL6HTk9wjzNCe3bJPX+X93lNMAyBt2Lo?=
 =?iso-8859-1?Q?kTfNPTVSN+LWKimVdR9OHEfNS9KuKgYpBuCr3kdx5cYo+EnkY0fKiHO0m1?=
 =?iso-8859-1?Q?3gyO33BdLDth3eUaymrjYCG7BDugm1qry74SWd0NpbjZZyOu1fMqY3SeNM?=
 =?iso-8859-1?Q?VV9255YyIdHGUQw2wORWqkkcsJ2VGkjjeFz0g2SQcV2YmNT0cIYE5jBwAc?=
 =?iso-8859-1?Q?DeJoRaCauYqYKvELF89c1MnKSlvNGOyOxzL/HukByA8w+3st7ASuNyOgj6?=
 =?iso-8859-1?Q?t9s071MrhbMfBWUVoI5uuacDVWrujG80V+XitfRj6W3ydruRYrR3uYo/FX?=
 =?iso-8859-1?Q?4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pMgEYaei1hGFypK2ynsdKUSlRdxb2evmCGpvcfkcH/oFd88Wey7dqSxQzk?=
 =?iso-8859-1?Q?U9D6t6zV6Ub6stard2p7jkxN45hd1VD0xGtMn+69DMI4XoC4WzoNXaKEA4?=
 =?iso-8859-1?Q?XYjMX26rwHOcWcFUQsapfWDTW43L8bSkt/Ff6U/O0vzlQEazSK9xK0kmOX?=
 =?iso-8859-1?Q?UFMMAhtxqAUqu1P/ActW3Zx2rr8Ezkv6Z06n6leln1zfO9iCZMLDYEhyoE?=
 =?iso-8859-1?Q?6tJzkoWLohlfznLFCdUn+KDIxMZrDlxTkrC4c97jahvNs81aRNcq/V4D/b?=
 =?iso-8859-1?Q?jU52TRP2BcmearV9U/Lzl+5jg+tuHIXV3ISdtwEo6craCdaSa/3EQvvdwl?=
 =?iso-8859-1?Q?20g4RbLWMApyONrhirtM/3JaQPv8QPZ/GJt21+oR8Y0PWZf6q7FT3jPqR2?=
 =?iso-8859-1?Q?vwT/+aH9mAADgICQrDB+BdT70WqfJ2VMWimc+CHgSVrC3o1fFxbco0PjD4?=
 =?iso-8859-1?Q?9RimGqAAGg9OyeZsT1WzEvcy7jJrQe3HrbtfJu1rb2KZRwcNMH/0jNDwWP?=
 =?iso-8859-1?Q?FriDQkr+kOESNj48y51U3e7PEicKCuPKaJSoF0y8aNfVhz6uCTmXTnMlld?=
 =?iso-8859-1?Q?kooru00hm+rPnu/Nj/osRvBa+S3+A1RZAb3SI7MAg3Js4JOpjJ4kS14Q/6?=
 =?iso-8859-1?Q?B2162/KHTc3ja2V9vpJ7ZBLQiC8dHqhgWojYz+qfq2Jq0LKOgE0qagQ5R7?=
 =?iso-8859-1?Q?G9LzboyksiYhWLaY+XK3E6AFMQdawl+hMx3E3FHhpkWS/NZI1wq1BJmSeq?=
 =?iso-8859-1?Q?qdtCJ4TEb0bywhNlfH+kQvTMXNstL46HHbe0daDAAvZNJXyDq5/GEJSe/Q?=
 =?iso-8859-1?Q?sPET0oGRlajAzbpDBk1FbNVYOubzsBgBuFVBbEJf2NF66pfMuUkY4u3l8X?=
 =?iso-8859-1?Q?URuF7mCcMa8zqf+A0PVhXCsTx/fzs9w2xIaltDufWENuepGm269IQqBYwb?=
 =?iso-8859-1?Q?g5UJaiSAyUxSOCZ4zw7csWVHKpemJLrBEfMm80mHgaagol+EwFu4xpkJbi?=
 =?iso-8859-1?Q?X54XTbJrD70FfjVbALsxi52i6S4OQXUjbf3rXODUjvNI7Nm9mGrcaUmVvE?=
 =?iso-8859-1?Q?5ygTzQIsZFZhXDs3MOExzWZ8bWr4pajOai1PnFx1n3k6eFC072S5btu2u4?=
 =?iso-8859-1?Q?EBCNxKj28+aGUUefGmAfn2a74VEL7+2s9gxz+3IbzvJDr98W2bwx16pQ7K?=
 =?iso-8859-1?Q?P18YDCE2zYrflYeETu6AgUqxWqzmB2AKHKuKWiGjxKCKnARZ3aEVw3N4Al?=
 =?iso-8859-1?Q?VLslC/ftd52dwrkRDZoKoO4ttXJq2C0Luk1Oiv4JVDzq037Ei1LzyuqtEz?=
 =?iso-8859-1?Q?bUhMzLfvyrSnKFW+FmY+srUYOCqJlnIPDYJPiK09l9kahLdxbTQR7Qr1aq?=
 =?iso-8859-1?Q?41SHU7KC+ZtcGFqSJ3QnprVzfJoGs6zvAetgONeD4b5qUMYbqxNNF2jXaR?=
 =?iso-8859-1?Q?jGPMSs//0V7xY+KMRut4yZuR1vJdH1T6+vs9WXSmABlOdTIuQdrHcBIKUa?=
 =?iso-8859-1?Q?xu1FV3kEq6TgF0xvdcUj/+U1mTAziWBf/QCIJLzGJdcVsoIWZmEmnY0in2?=
 =?iso-8859-1?Q?rlfzxwCg2bb8DakqOmv5DOHVsXso90FY081cXL7z6x1Z451cJLGwO+T1XJ?=
 =?iso-8859-1?Q?wOwcxl/vqQsiKxm/PCI0s4tzVKtlihb6X6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d07aad-1bc3-4bee-8404-08ddf7c23841
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 21:19:29.9300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDcfOQjpLr83Yd5vIqcclZc81hL/WsUCFT9ufnkhw/NmpbD3tfw6WH3VIM3p9XTMCnvvLONkjehgFADgd1MAoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6168
X-OriginatorOrg: intel.com

On Fri, Sep 19, 2025 at 01:20:53PM +0100, Matthew Auld wrote:
> Currently this is hidden behind perfmon_capable() since this is
> technically an info leak, given that this is a system wide metric.
> However the granularity reported here is always PAGE_SIZE aligned, which
> matches what the core kernel is already willing to expose to userspace
> if querying how many free RAM pages there are on the system, and that
> doesn't need any special privileges. In addition other drm drivers seem
> happy to expose this.
> 
> The motivation here if with oneAPI where they want to use the system
> wide 'used' reporting here, so not the per-client fdinfo stats. This has
> also come up with some perf overlay applications wanting this
> information.
> 
> Fixes: 1105ac15d2a1 ("drm/xe/uapi: restrict system wide accounting")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Joshua Santosh <joshua.santosh.ranjan@intel.com>
> Cc: José Roberto de Souza <jose.souza@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+

Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_query.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
> index e1b603aba61b..2e9ff33ed2fe 100644
> --- a/drivers/gpu/drm/xe/xe_query.c
> +++ b/drivers/gpu/drm/xe/xe_query.c
> @@ -276,8 +276,7 @@ static int query_mem_regions(struct xe_device *xe,
>  	mem_regions->mem_regions[0].instance = 0;
>  	mem_regions->mem_regions[0].min_page_size = PAGE_SIZE;
>  	mem_regions->mem_regions[0].total_size = man->size << PAGE_SHIFT;
> -	if (perfmon_capable())
> -		mem_regions->mem_regions[0].used = ttm_resource_manager_usage(man);
> +	mem_regions->mem_regions[0].used = ttm_resource_manager_usage(man);
>  	mem_regions->num_mem_regions = 1;
>  
>  	for (i = XE_PL_VRAM0; i <= XE_PL_VRAM1; ++i) {
> @@ -293,13 +292,11 @@ static int query_mem_regions(struct xe_device *xe,
>  			mem_regions->mem_regions[mem_regions->num_mem_regions].total_size =
>  				man->size;
>  
> -			if (perfmon_capable()) {
> -				xe_ttm_vram_get_used(man,
> -					&mem_regions->mem_regions
> -					[mem_regions->num_mem_regions].used,
> -					&mem_regions->mem_regions
> -					[mem_regions->num_mem_regions].cpu_visible_used);
> -			}
> +			xe_ttm_vram_get_used(man,
> +					     &mem_regions->mem_regions
> +					     [mem_regions->num_mem_regions].used,
> +					     &mem_regions->mem_regions
> +					     [mem_regions->num_mem_regions].cpu_visible_used);
>  
>  			mem_regions->mem_regions[mem_regions->num_mem_regions].cpu_visible_size =
>  				xe_ttm_vram_get_cpu_visible_size(man);
> -- 
> 2.51.0
> 

