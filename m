Return-Path: <stable+bounces-120366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D7FA4EAD5
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 19:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B211189663C
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6404D25F98D;
	Tue,  4 Mar 2025 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+fOy9Gp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD7325FA25
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110494; cv=fail; b=AMTjOkmTP9oeRVqHAlNkZmlOccxSjS4Azj2skmy6XaMi6Cpzl4c5dJ0ARfUIoXV+7NNG25ly7bJxqv9JVuZ/m4YFFixDX2oPrfgZFnKCVWMMpn10QPspJxRwkHaP20UpfwA7Hy9/bxtZ//V3ahVTQj7nn4X6lJXIy9AFa2P4pFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110494; c=relaxed/simple;
	bh=gGHnuz+JJ4lhdCQn5bMa69vkmqJ40Q5wFnjpdX8R2uU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mjeb0NxEkI1qi3UuVSqguA4QTPBpgbm+bSLYjrMhniwsXwmJLsC4xf5pCKhtzD8/0wLLEqPl7SUkyN/XgUJpQQNpJ4fMlz2xUX6kcgEx5JS/y3+EcMxFVQ14M8pAhcbWUG6eMUzrJTKHfltXWGJ5DcUM2waAJCurSyBRoFFQfjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+fOy9Gp; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741110493; x=1772646493;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gGHnuz+JJ4lhdCQn5bMa69vkmqJ40Q5wFnjpdX8R2uU=;
  b=j+fOy9GpGtOs+HPv4xKtkuSarbPf1QFFburxs3deyR/+Q9rkE8pSkmx0
   EYaWlz/PUXn4FVP/OikytaMl1WlQL8khniP8X38YSB2OXCFkiGqYjaQOj
   IhUM1khX+hB8TxC7pItx8K3BLO0xDwv37bq1bD1Xvl9hTZRw9yCUNCyIm
   /kMed7ETBBG2flcEemlyN3y+5CRJ8re/tPhSNTRV2ayTeuAj/8DaUbcba
   2bTx4ND8VgwwstyrY4bztdcYZfnt5DluezRzCcbQ9L7DFsaUdm17dLyhF
   0ywzVf6UX58no5VomUncMBoe0scpj2hf6sOBJs1BW9WIOI6QMOL/yyz3c
   g==;
X-CSE-ConnectionGUID: TOR7HJTjSRCR17iBtvE3YQ==
X-CSE-MsgGUID: vIpE55C+QiSXMQJRilQgcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59457544"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="59457544"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 09:48:12 -0800
X-CSE-ConnectionGUID: UiW17mUlTOWPjST9kUawEQ==
X-CSE-MsgGUID: WXE6UVvmQ0iALSgmH0pAyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="123565197"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 09:48:11 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 09:48:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 09:48:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 09:48:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFiz7M0pi3NBwtAGYG9CHdKkvkbE2uv8aLkS/plWRPIQm/H52fEoqIxiOWY1c8LYkLL3QyIh3+NCOfBsMWqGWtZGMQz+4GhOyL4U1ZbEsgJl7jw1sFt35eWveGWVHCXdNQnBzcVgnd4uDdI6+GLw2A3bTvelY+nKarohHUaAtE2VRe719XeO0xvtSk99xeEhnUlV7vK6Ag7FNB1nMm1A+tGU6obV1oaAa6iL0nu3J/YO6V0EnM4jwwrjp/8E16CumfXXVwL1mzMXb4RxqHUsNx/oHMYTI/VtnJLG34TRpogH2hh6xtbMyxGeBWAQ4tMcsqs+I/OPesfQL+COcOteuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cK3yHvSWKaZLT7ZQhSMvFVId+cz6MsPh+KPkiJZiB/M=;
 b=NDP2Ri6yxsP9fRLHwMgW6Qrxpqs9XFtLxf70FbGmgc1otKFIxNB2TMdi9ulW6/hrE1yMZ4Yh442gvDwZwgP1LaLeEF6Kl768FKrgHDTuPLpVdW3PEBb/VdNtDOvDgdI4XzGDaRIkOxMd0LOvRYCjj3DF2gCtYmUf/9s9BwHL49eBtfhjUG686dl4LlgZBAEkbWjg4hG0y7tYpyZBknbMQYBnrBxJwgWRmYo3ES9G+96B0oCeEjyJzQK0pHRjB4lGAQVqpkcr6961yY1/pJBUyy/iXPjs+J3QT57kZPp87pE6H1jmgGSG8kE3/wnC5T0ZActNfhleA078/gtSMydlUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS0PR11MB7382.namprd11.prod.outlook.com (2603:10b6:8:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Tue, 4 Mar
 2025 17:47:26 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%3]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 17:47:25 +0000
Date: Tue, 4 Mar 2025 09:48:32 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] drm/xe/vm: Validate userptr during gpu vma
 prefetching
Message-ID: <Z8c88NnmEGUMa0fm@lstrano-desk.jf.intel.com>
References: <20250228073058.59510-1-thomas.hellstrom@linux.intel.com>
 <20250228073058.59510-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228073058.59510-2-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:303:dd::9) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS0PR11MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: e8cec786-8413-4e1b-6119-08dd5b449ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?68RHxpjkWVrA58xDcqDs/F77ahflcLhqDoJIVXWAEfih5DJM2QOuLOuAnr?=
 =?iso-8859-1?Q?gtMsdjNwv9mVY6hLP0rXH9EA56DUWUkLRAakFmo4FLcY2B68yu9rb2GaJ0?=
 =?iso-8859-1?Q?qAoh8ZoDBopfBa5mRaXKW1p2JU8WQiIpGDyQjhu/XPU+bT7SoEte1zNAlj?=
 =?iso-8859-1?Q?8fbBxpdhcAEkzZwY68Fy5Yp4y2j3kbZk0t1D1GI0224AHEJVdJ1Z2WwgIu?=
 =?iso-8859-1?Q?HDRsrJrcLhV2Lvwxl9hZoo0tp8+I1Z4uCZqqxbbiMCc0MC8+JjEsJ8LjQx?=
 =?iso-8859-1?Q?9mEnLcpKx7+IufUOgqs58VKW702xsJz/IEAH95qC58ltexXdiO6FCMT6Ea?=
 =?iso-8859-1?Q?gVw7eA3gcjUTYJxns3ExXorWMETgC4pxVeei+4BxOS9ph7qxhseg5iaBc/?=
 =?iso-8859-1?Q?eTre5NVw1FzX7VbyjCeqXNtjIoF2kDjOkynE6s9/OIa9YKGCJaY7yux4cR?=
 =?iso-8859-1?Q?khG4qTOsJpeJuydBrk71YrRZZMld+/OPn0vdmcAtY5SEhCUcq8voyCM1+1?=
 =?iso-8859-1?Q?Wcs3/w5UQ31TR8fa9x/OoSiRw69fLQnrez19thnUf3Yc+P4RX4Y89sj9VE?=
 =?iso-8859-1?Q?/Kf2aT5qkTVwlCe6v9pB+4/HWZcHiLQDJmreSQtk9Pzwb04CpeiuN/rhUm?=
 =?iso-8859-1?Q?DaQxqKzcCv+Ygb4lQrWq0/UkqA44rSf+DPj/Z3iZAJrWnMXbwK6g4c1y6m?=
 =?iso-8859-1?Q?FsOkhPUA5K8yg8agYgMqLCWqXD22RwbMvzm+5WDXeEpoEKiEnQIcRoGjAv?=
 =?iso-8859-1?Q?c36oIpPP6Ihb1dsyu2O+oSr8qCjwb3fsXXfULbUFu+PhLumv3jbLvsHr/V?=
 =?iso-8859-1?Q?NEgixl0k6AbDahpd40TXDh4YaQxGXoFPG/RScB60smfli4xouY1PKOS/FR?=
 =?iso-8859-1?Q?/r/n6wI/7Kj9055dhjkFa1nRux7PVAD0HgmUPmZ3o11k23obPTWS0NBY+6?=
 =?iso-8859-1?Q?f0oDrlPnL2d5S+cS/vm+aGLfW5wG1MNNOsFLy9nlFVG1E78+wUe1rn8F+S?=
 =?iso-8859-1?Q?w/UycQ/a8nufVbVVlTcF+4LUtCabHc42/wYHKQoJXwZ/qGTsUEL2b8kMCK?=
 =?iso-8859-1?Q?83sDcBAWB0Xjtgw2PMoWmp77Ujzwr7PZX8kP6QU/yr5d8tosTrgUUUESLq?=
 =?iso-8859-1?Q?y0PuletpmrV33hnJ9808kf+pezm7HBKViOjk6zybsKsEeiHVy2eBmvXE0Y?=
 =?iso-8859-1?Q?yYt/e721lsQ2PCAr+vCGnqYni4Axm16L5zoLTiTY1U3afJT9CbHJ7hU5ec?=
 =?iso-8859-1?Q?0rVy7JN8grMrzTl7lHLrDi00cBIO2Nmy6CBZsaw62Yj+EcBcLJIArdJ+ux?=
 =?iso-8859-1?Q?Fvrfo73+vWjpn/DCAQb1A9y//iVkyfYjAJTzrnud9iR0L7T1wQSqUPqNZP?=
 =?iso-8859-1?Q?eljccjCY1R2gYIqTaC9jc514FOrFL18ar0CL6MrVkS2lGI2xzc9tKVKb4m?=
 =?iso-8859-1?Q?8Y3sFu2Z6rid/HqD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?EHt0LdomVAoqxNzuGpjzXcTMuO49pyjq9f+jNbcwopkQAKEa0V0cQGwuDT?=
 =?iso-8859-1?Q?SMczZgBn4adPF4k9eEWpfcVVgnzhLwBYrdC1Yd/ULfp8b2x7QdEMJpCYa+?=
 =?iso-8859-1?Q?m66Zk26J/qjzVoTjKpXV5jEK9eLaMkcr0Ch8Ee4dW/F49rZ1Mh5eJtwVXB?=
 =?iso-8859-1?Q?0+VEB/T5W/3W7AtfgOd9qDin5pwmK/LUH4xmyPS3EPIknnq7IZi3VKAJnt?=
 =?iso-8859-1?Q?bzJ/rqtEoqn1eXqxDMILS93RiojbxU9jlgk18/BK/GGS2x01Pfs+gZiAZb?=
 =?iso-8859-1?Q?K79onW3MyPh3MHdlD0uOsmIUa1XabfEzAsWhMjdWRKvb53b5TlqKQmGRbt?=
 =?iso-8859-1?Q?gFEF1/b0gyEJz2xmxAAsF05mLZVBwRqWqdWIHltkA8ON7Zxr9Rchk8WQfe?=
 =?iso-8859-1?Q?wdBgeFL1fQcZNg/+kAnHeodsbWS9Tpp8sj7aTBH+3PskxvsJ+kn8+58NSU?=
 =?iso-8859-1?Q?zIf3YJmqhXJ20iMYDlBaCYtPyeqA7acG3m7/jYfM1m7BeZzAksxypzh7ak?=
 =?iso-8859-1?Q?nbSCOvFGMA5XLGB4fcwTd6J2sWGnLDdQn4vdXNr7IROKlBcqUBsokgoZsB?=
 =?iso-8859-1?Q?IUT/vUeR+4nIymA+j2GCyM4Ayz/9UMV3vveVjMyUzP6bUyGblVbgQ4ukCC?=
 =?iso-8859-1?Q?DgQ4VSQcQc4qVSg382vzvsQpdDyGSGr0VaS5Nfz+dAH0RVrWDC7e8/z7Gh?=
 =?iso-8859-1?Q?jWfdG4FNuDdMFtOPGJwfEs8BiW4li2+TH4gJmp77sYJOjTQqracRL/C3IE?=
 =?iso-8859-1?Q?nPYHIm1cKDP+WEZ8Ox61H8vQ7xnhzu/QwHwrA2Qvpzqmu+6IfyoSw9k819?=
 =?iso-8859-1?Q?WQFiQ0Fl9VGACUb0hj5rr3OxDeBONzBLAMMa7MaCdaCWOOrS/JitNIbjcZ?=
 =?iso-8859-1?Q?aX5tACBUfeDQL9VXyIoLpsJ2oZeg5Tk6O1EoDVldlWoLJIYum9hwR53J8k?=
 =?iso-8859-1?Q?kUmwl8SAccJC2HR/xCtZ0T1ML6xFrkLMzW3QXBvPiWwsii+5ZNDWywZ1Ez?=
 =?iso-8859-1?Q?UpWNjzGmF6xKIp5mUwLtWCgw8xNZpm/0Hqyf2M1cQfZ6PUXltBCjCk6Ubh?=
 =?iso-8859-1?Q?s9M4mBH2nXElimVL21R120BATiMxROmILu1LZ7mzJHksT4a0f/nnk2Fyqj?=
 =?iso-8859-1?Q?OZPoAaHok+B9lBGS1r6AwORwkOwSsDZKagskUp7PBpreQBlpT4wtjbIMiN?=
 =?iso-8859-1?Q?w/yQ91k/MhHd2Azv3VDXl91bqUmotHKZefehpiiputoUmsGCHTHG0Xw0r1?=
 =?iso-8859-1?Q?dmAVZt/8Be9wkXVqM1+pMRcL+2QhzF+sS+0XGxNgtuOf/arBt/2Fz/umTo?=
 =?iso-8859-1?Q?oG0EPCd9kc6bMnpqioNxh582KJYbb4+XLoHjvBt7AaavNMcMTE92aOrjHU?=
 =?iso-8859-1?Q?0iHyGyQz4Oz0UigAyWoE7WoFd3n1EdiWrCZhyrgKqxuB/53n+HCoi3ogeO?=
 =?iso-8859-1?Q?ImmnIgeMEik24B/5Rpnsk14sQExEspQcxaQmnyvgvQEN9QrMhfXspkbIk2?=
 =?iso-8859-1?Q?BQACF+NJvQQGwLsMDw+qE+pqpJUC8K05b88QVYWg0vqbM4JHenjQ7qfrB1?=
 =?iso-8859-1?Q?KQIapNYY/VWSwAqEZFNvTe3KCKkxGiKYokfnS83YknlPuqbnZkCaigCqjV?=
 =?iso-8859-1?Q?a0zRRI/hrEM1KqNGX050khLQOkzg5jBSnJ2bUWk9DQZq8ogs/ayU6Exg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cec786-8413-4e1b-6119-08dd5b449ff2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:47:25.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofdDIRkmqagIERJ0vjdP4xl61BaK8p01BAI2y6qIOde6LkIqwNobsP7qPL4l//WxqJTHCjptxqLU1fsBA9b5EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7382
X-OriginatorOrg: intel.com

On Fri, Feb 28, 2025 at 08:30:55AM +0100, Thomas Hellström wrote:
> If a userptr vma subject to prefetching was already invalidated
> or invalidated during the prefetch operation, the operation would
> repeatedly return -EAGAIN which would typically cause an infinite
> loop.
> 
> Validate the userptr to ensure this doesn't happen.
> 
> v2:
> - Don't fallthrough from UNMAP to PREFETCH (Matthew Brost)
> 
> Fixes: 5bd24e78829a ("drm/xe/vm: Subclass userptr vmas")
> Fixes: 617eebb9c480 ("drm/xe: Fix array of binds")
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: <stable@vger.kernel.org> # v6.9+
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 996000f2424e..6fdc17be619e 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -2306,8 +2306,17 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
>  			break;
>  		}
>  		case DRM_GPUVA_OP_UNMAP:
> +			xe_vma_ops_incr_pt_update_ops(vops, op->tile_mask);
> +			break;
>  		case DRM_GPUVA_OP_PREFETCH:
> -			/* FIXME: Need to skip some prefetch ops */
> +			vma = gpuva_to_vma(op->base.prefetch.va);
> +
> +			if (xe_vma_is_userptr(vma)) {
> +				err = xe_vma_userptr_pin_pages(to_userptr_vma(vma));
> +				if (err)
> +					return err;
> +			}
> +
>  			xe_vma_ops_incr_pt_update_ops(vops, op->tile_mask);
>  			break;
>  		default:
> -- 
> 2.48.1
> 

