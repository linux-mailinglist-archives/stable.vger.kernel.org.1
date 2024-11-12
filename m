Return-Path: <stable+bounces-92822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B39B39C606A
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 19:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E6BB2B722
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 17:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E39213148;
	Tue, 12 Nov 2024 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgPPSW5H"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F391A4F21
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433887; cv=fail; b=eNkclglqxVJxVB3bjfA8JeyXjX0aV2IlYW/B83WSsegRmqzhGn9CzmwJX9MCknyqlDKC78tgF1NvmB9DIb5QZRT2xtkkGniQgxf2dcytycB1r6f1jdWcrSitiApuLrngH9R2kcxyO8Iwb3FPnzFXLCI312B/gxiLI0bHjsSldso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433887; c=relaxed/simple;
	bh=kqmc7f1Fr/ZPF/sSwHlIDPAx1Ncvftcr7o30i9g4hHQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n6KwpZ5e94bD64IctlSWmJj5nbkIdZIYHZG48TFQwcKqr3Jdnyzf1/s9SIXqjy9Gbo6dJ3eQUV9GDYaBaoiis4Kwf5SS/LdqmX4fFhV+xXQKt7EIo728XKpVOqu1mN2bwjKjCsdfsl73snvG4Kzm5FwRCNiX1c/f0R2AS93MyDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgPPSW5H; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731433887; x=1762969887;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kqmc7f1Fr/ZPF/sSwHlIDPAx1Ncvftcr7o30i9g4hHQ=;
  b=AgPPSW5Hm/2e8eUVt3QYgXx3xH9oSF/DGYqMXz1nufvaD6+7FZKsBXen
   YTHRpO6GlnAXIkMKc5Q2u2F1rF1M9e3M40lARtedplLbT43vKCM3mtty3
   S48nRwSkyOqnmJzHmis2aJ8N2re67UMfpFRPZqBEhRzJORV/n0q7otsVO
   r/GKooqEG+rCNuiybOtgPDcUaxZOt/9skWZeXxARO2Syca/OQtcvqlEr+
   hX7gHgN7gwibFGUCcExRkISbfSbzr5hDLRJ4ySrcHlzJ7sUi11gdEXfk+
   s5c0oGikwonKT7EMehILhndF8PuiMqz2m6+NakyxFPbY4KLnn1iRdD9mx
   w==;
X-CSE-ConnectionGUID: qPkuqPU+QEW/dC8d+Co0Tw==
X-CSE-MsgGUID: W+2Ydj/IRn2HH1XH2I4seA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="35076588"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="35076588"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 09:51:22 -0800
X-CSE-ConnectionGUID: aHHZ+76HTbCz6zxZbTz2lg==
X-CSE-MsgGUID: AoSBLtXCQtOujdrx6MlZQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87706137"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 09:51:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 09:51:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 09:51:21 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 09:51:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohNqvPC7dUzSTVIwxaljVZcJCIRjIbk4NcGMdf3xSf6vEjwZwvDWW1aHj3HGNQscn65tvWPrx4n2qAIVoSqDGVMIphBwgEDkpqaJpXPx8KkZKVTpgEpH2UFfQmKStyVezVHIwcoR4Rjb1BinDEE/SkY1hQvMHq/rW7fap4GbUaHqOEyTgUE6wJow06DMLm37pwHerLpZwgemWYWzIEsLKIe8OHpsU+VwkmtlFzL2ZZiSL0Q6zZT2NvjGVtmnZ80p7QS5Eu3M1/ajSYr+rtJogQ//zLUe97q9j8QO5GXYIlOqHmizudBrvRUiiIe2eH9vAe23J+MX491Mi3m0qFG9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhKot51WNVBf41tNk9Z7O22awmt/VEERGmrWC40hVHc=;
 b=MF5Pb7Hx3+4WBCk0lMun/wOv8/7VeBJ9M7DmJp7YXZVk/t8N0jNo9j6KZ1Mc/CNh8OpPtXvGfYc39ER/knlU+/M9nvFxy+g82gkCvT/Ixzjkd/lXzoCmniYVe9yGlLxTtOC3XB0NXK1AXSJPlN93udrouQ1fvh5rcMFbQugxxtiD5mqavglnT4bL/S2N3xeyiWIFO2qqseDqdg4Cd1E656JOuR0kdsIPPNt7DavRZ+JR6NhyPy4Im6q+Et11uGETOj1O2z2bd+xp3SbFrc/YmsVC8LrLbXJGbxv47EeXMA73R0Q2Es75z8ey3LjFolHJJuI/xUnJi7y/y2CCVp525A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2854.namprd11.prod.outlook.com (2603:10b6:a02:c9::12)
 by IA1PR11MB7365.namprd11.prod.outlook.com (2603:10b6:208:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 17:51:18 +0000
Received: from BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42]) by BYAPR11MB2854.namprd11.prod.outlook.com
 ([fe80::8a98:4745:7147:ed42%7]) with mapi id 15.20.8114.020; Tue, 12 Nov 2024
 17:51:18 +0000
Date: Tue, 12 Nov 2024 12:51:15 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Matthew Brost <matthew.brost@intel.com>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: handle flat ccs during hibernation on igpu
Message-ID: <ZzOVk1GGJEFagvdD@intel.com>
References: <20241112162827.116523-2-matthew.auld@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241112162827.116523-2-matthew.auld@intel.com>
X-ClientProxiedBy: MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::6) To BYAPR11MB2854.namprd11.prod.outlook.com
 (2603:10b6:a02:c9::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2854:EE_|IA1PR11MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9289da-3e85-40f7-e6e4-08dd03429c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nWLQkpQffvfZNpoOn3sOdNeVOJ/764+MDstYElJDEEPbGqeK46J7bU483FkM?=
 =?us-ascii?Q?2lbh17v/PGcULByTRBYQCBfKimVn/zbbvTJ7M1/ddFehQypSrRYTyeGan0MA?=
 =?us-ascii?Q?PQZ+xgDS6CgyrRftvvTQxn8v3y/2/MqqY5e1v66CdkHULXUZO5CmqdP7/0vD?=
 =?us-ascii?Q?AzuXLcOEOzifI8Ccs0NtoKVUyYkt/jWjRHO4sHzj7GaXb4eqPazk8cei/xGq?=
 =?us-ascii?Q?fCrH27ldRuiFv+U41My5uDCWKEZ3zhZKf0lxZiNcaXPoP8v3jHlJfGNqi0C9?=
 =?us-ascii?Q?awX5shRNkfTL81nTFGwOL2TLfF/huYl87s3BVljMIMahYVfeaetAGb0JqHL0?=
 =?us-ascii?Q?yEtW2ZOeNM85MXfsNe1kn2/oYM6e1C93oLCrT4XqI2lbkDZz/7UHccMtpYk2?=
 =?us-ascii?Q?OKD4kPmFnnQXcxgWBaWk4+zJVAOngKqq4Vf6CPcy3iOI9Flf+Yx55bJy72Ux?=
 =?us-ascii?Q?Bzwv4taXKRCsMopWY7aKOlmm+XXgty0msl6weuB0h+Ro2YsS9iNZdGegUF8M?=
 =?us-ascii?Q?u12CVXk736GpVCf6/RRXf7/YA0tjqwvt2NHWer+wN9xN/TyHsylK6IUF1F/2?=
 =?us-ascii?Q?dXzASip6etMBRK/F65VeTtK0fmwWlcPDARE4qgaQZc391rzTQdbNEp/PmlyQ?=
 =?us-ascii?Q?r6RkN71kY9wdhPhG2T5P9p8lT/gbacL90iLpcFQqYLfzaXdhFOCr8spk/pa8?=
 =?us-ascii?Q?iNb8kc+0XYQVbYJy/hucIR9g/oiChISe+yKEM0VGR4lkeeXAhm48r0SKC1Je?=
 =?us-ascii?Q?97JGpxCNlnBeoWrFRb0vE0b7grEHe2aKC7z4e+vfJXuufzfGiUOyjqkuvFZu?=
 =?us-ascii?Q?hUyGUzXAQ8HvUap84GHalQfwA5yjetX8s0djZ6aLbZdxa1S/m/Zq7GIqv2NG?=
 =?us-ascii?Q?ym6r9yO7Y1Tj7S/xYVJ5s3BTsHF2Pcf+jzcsdfxT7bV8TzdBgzTIu/xPO8v3?=
 =?us-ascii?Q?on4hGe1ICHW8HTugXVHdP7eICRxWqMdYm1gOxvUoVj3MvlNbOFSs5I/hQBsO?=
 =?us-ascii?Q?P6LqRt65kAvf2nfXVTsKXant4bbWK7tFrn1kNFCfbfcW6wxww/kEMgOKrhZg?=
 =?us-ascii?Q?wzWUdjcqhS8s6O6xWeQ+QYIPp22ykMau2SvBGkvLMtTmXEJ8Wnf1r7QrkmqF?=
 =?us-ascii?Q?M1RHnFCjDQn80yOxAtAkKXpUCPE07DQO+x0zizT6VpaOsGtBs4tdUd9PZKyj?=
 =?us-ascii?Q?hXA2t472wUVPDJyzPVKHMPzLgkpNAKF70J1+fSQ5vIAWXPlG44yMMukLWWBk?=
 =?us-ascii?Q?pkLzn86ThrexuYTy9pqb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2854.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+/Dqjw9orXYQFSV0rS1HYV1Jy8fwfNdKeuhAnSMWo3NmPPgl/BCaUPNu+P/K?=
 =?us-ascii?Q?KaOExIVWCnws8byRvL/rY7zzdAOKsqpjpJx6p1rXWkZW76t5UFIzi/ul0UZS?=
 =?us-ascii?Q?bGy8VmKv9kCTmOUHCxZaZBE0wUvTb01DzRoJzrxG8rGCcWlhySwcrNrKvDPY?=
 =?us-ascii?Q?9HUcYnJB2oxMvvaQQtWATDODZZDcV8zvNCmXUjwVwIEuYgJVOp23kN/NBFeF?=
 =?us-ascii?Q?vlxYg8A4r/dQ1dCpgMMrkr7FL6VMr1Psed2S+Uea2dbKeeUwrPfCygMsGpIY?=
 =?us-ascii?Q?obg68vYNZZVG6KvQd7t39KF6ZSKE45O61e6EsJ9px5vkmM3eD5gpsr2JfbpB?=
 =?us-ascii?Q?qW/3MEDMt/coNwXQKba+hWzUwruBIJ6Bo+6CS/Lb18Mf/wzwIan8dtnMrZL3?=
 =?us-ascii?Q?/UbrA0zTGVAHSwtbdJClG5nFXiq9mjCfiVn2gvW5EkdcKEjSC7LaAK5WHnm0?=
 =?us-ascii?Q?LBXkRHd8ckCpVle5rxva7tyTuPNAwG/RdGHiBYpjpMpGVsXjFOU3eT7zwVpX?=
 =?us-ascii?Q?ACk+WHQK4fbqrOkgYLi4Ds2oD8SUEwDGQLt6okWxf7RSNm0uiENTGaQ77Mfy?=
 =?us-ascii?Q?UVc5DRfdxT8YOM0QWyrA3+Kv75d43rN2FuNY56uywJsVKjIgkHo9Nymi7A6G?=
 =?us-ascii?Q?XynoLoIXXkclh6WQv7tIJZHaNtee1oF1K4E0G9mvVitjeaCmLU/e9cCGbNgw?=
 =?us-ascii?Q?2mX6PR8bzD3rNV7kA3orLfPl8O7EN3qbNcfuF1vLPlcTEoKXpN3YxlLt+Vj8?=
 =?us-ascii?Q?M6wtqgDYencDj+STb0Rjr+rshvpy0lUhU90wcFkWmhbZyfxeX6tW2oUfT5/W?=
 =?us-ascii?Q?mf8aEnHfo2pQkCs7xyPiyUP+KjDIKtiI6UTrDtPRoSnf/HUee/k81kw5vGg+?=
 =?us-ascii?Q?ZxSboHCJE3K7KBGqS2UaMsliasBzYGqoUJE8nCeYTZSLjU8gToo8OGZrNRAA?=
 =?us-ascii?Q?3awppqDotElT0UCih0Htimx5RUm/BG4mVgFWlj3vPznZYDGEtRPOs1uKnAbx?=
 =?us-ascii?Q?FA5MHTo+KikPcg+bDxbiJeGpCANIW1C2XqiBWDngtKd5AFwByJWEgGoxfZot?=
 =?us-ascii?Q?7JexSPZPeei8ZBLJoAZMPJ8Wm0if66dO9yeSwD+NI1+mJtv6zVuJvtezMQRc?=
 =?us-ascii?Q?eoiMOoyZcfF7rNSpozNQyBr+QAwQs80OCC5jV5Rxp6G77dIcz/CQnweehV1y?=
 =?us-ascii?Q?o904xtAgK3Gc4ooNc75YuHDINC3mjbwrKhzvyr48zLJ5+z+4qJAbB4wKyf9O?=
 =?us-ascii?Q?s+4HPxrB2aluJ2rSo8ltv/BiTvq9wY8GTLwB7ftGaX8MVfccOTp9pSGA3LFz?=
 =?us-ascii?Q?low9vUqhKxoE1wfWzysMDmfERjjRUPJHA4MJm23Cv6o1RTcUeBNtKVodI42z?=
 =?us-ascii?Q?X6UgXTBKVj33FIkqE/4b9hiHNW1bV97X8B3iyfgotRh6e5VGI3c4ukWB8LzI?=
 =?us-ascii?Q?eN8BpinZSdJxI3+0q6KoobX+Zw4WphVUM2wOrCEJ3bWmDqXqT8KsOrfrmevd?=
 =?us-ascii?Q?J+IKufzGjpCPxy1lt6HybgRGKWuuxq0aIzg++RQydTpY8FjnLkg4Pd0tf5rs?=
 =?us-ascii?Q?n7jrkaD0+sVkXCWp37czObjcV4DKW5LbgYXj8Ooj85yAkD9h2oTPXyRv3vgN?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9289da-3e85-40f7-e6e4-08dd03429c34
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2854.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 17:51:18.2716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+EFA9auWrhtLI3+LuLAxdDfib0kMWu+yqLL9Sq9P8OprCEa/+AbIN9V3kiN/q4htJ32Hw8LGNOQx5P/wK3t6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7365
X-OriginatorOrg: intel.com

On Tue, Nov 12, 2024 at 04:28:28PM +0000, Matthew Auld wrote:
> Starting from LNL, CCS has moved over to flat CCS model where there is
> now dedicated memory reserved for storing compression state. On
> platforms like LNL this reserved memory lives inside graphics stolen
> memory, which is not treated like normal RAM and is therefore skipped by
> the core kernel when creating the hibernation image. Currently if
> something was compressed and we enter hibernation all the corresponding
> CCS state is lost on such HW, resulting in corrupted memory. To fix this
> evict user buffers from TT -> SYSTEM to ensure we take a snapshot of the
> raw CCS state when entering hibernation, where upon resuming we can
> restore the raw CCS state back when next validating the buffer. This has
> been confirmed to fix display corruption on LNL when coming back from
> hibernation.
> 
> Fixes: cbdc52c11c9b ("drm/xe/xe2: Support flat ccs")
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3409
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
>  drivers/gpu/drm/xe/xe_bo_evict.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
> index b01bc20eb90b..8fb2be061003 100644
> --- a/drivers/gpu/drm/xe/xe_bo_evict.c
> +++ b/drivers/gpu/drm/xe/xe_bo_evict.c
> @@ -35,10 +35,21 @@ int xe_bo_evict_all(struct xe_device *xe)
>  	int ret;
>  
>  	/* User memory */
> -	for (mem_type = XE_PL_VRAM0; mem_type <= XE_PL_VRAM1; ++mem_type) {
> +	for (mem_type = XE_PL_TT; mem_type <= XE_PL_VRAM1; ++mem_type) {
>  		struct ttm_resource_manager *man =
>  			ttm_manager_type(bdev, mem_type);
>  
> +		/*
> +		 * On igpu platforms with flat CCS we need to ensure we save and restore any CCS
> +		 * state since this state lives inside graphics stolen memory which doesn't survive
> +		 * hibernation.
> +		 *
> +		 * This can be further improved by only evicting objects that we know have actually
> +		 * used a compression enabled PAT index.

yeap, but for now let's keep it simple...


Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>


> +		 */
> +		if (mem_type == XE_PL_TT && (IS_DGFX(xe) || !xe_device_has_flat_ccs(xe)))
> +			continue;
> +
>  		if (man) {
>  			ret = ttm_resource_manager_evict_all(bdev, man);
>  			if (ret)
> -- 
> 2.47.0
> 

