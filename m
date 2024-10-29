Return-Path: <stable+bounces-89225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7369B4F3B
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 17:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5241C20AD6
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 16:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298D5198A36;
	Tue, 29 Oct 2024 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhZ1hOvM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77504198E6E
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219044; cv=fail; b=GsydjHyfn30isMZ6wLtPuJEGmjlOBjH/gVOm7ZVG9CXe/9+oQo07cEaRvsIQTgySkbv+AUEYG0PZwI43Q7utYi4qTMSua3jHkHE3u4w8gDmHLmQfULFp/EivUbVMGM1BejLS+SDEScTlRGn9/QRl0ZmGXemlQwXCCiyIdNiiUUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219044; c=relaxed/simple;
	bh=5Ktxnzhb+PcZQJEMHP9mu6cG/cXTP2sxj6u+yLJ8vWU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u55O5Kb2tVZr28h7e5Gj7prJG9G4vw1TS4D2WKt9z1bYBs3oqKwfDk3vhSD+qbHu2+Ux+g5L1Vdgy6dYOJgTUSSzyGaWkwhjYyEXJMr8IhZACgKZnegApgekczKhnuQBoVjAcS6bdbsCmLGaIY2BjxvS1Dy9ojwKgOS6kur2w9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhZ1hOvM; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730219043; x=1761755043;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5Ktxnzhb+PcZQJEMHP9mu6cG/cXTP2sxj6u+yLJ8vWU=;
  b=dhZ1hOvMvodn3Su/hxbndqWpNaPH+4QTT+zUBjOVJD9GrL5E4a1/ssbz
   SNztFlRlp+8TZR37tU+JeufR5BVQ2QOiLDx5TZiWWpg9r3NFJ5Ct3lMia
   J0ZyRJKlAKStVsOQG83JSclVCzl+lXHw0JYqX5MFehaPurzIDEyXeFw4u
   UfHo61et39hBTvuuVx3Ormo/VKHEzoZZGLNaowI4BndtsSdP2b42lcTnG
   eM95KP+m5T3LzPh1uRiK4gMaCF4RlgOFVd0q9hGMTggWLG5H3PfikbLTx
   IgF5aS+n1WK3Pf3BaI7o/rbFH5sw+gmNJrd8/pqomSqOPXr9x9BRWztFf
   A==;
X-CSE-ConnectionGUID: 1Lns/G0oSSmV9yIbwz73dQ==
X-CSE-MsgGUID: NRLYFI1NR5CorRH9MoJzQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29326599"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29326599"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 09:24:00 -0700
X-CSE-ConnectionGUID: QXVt33/vQCCinRWyiFyoWA==
X-CSE-MsgGUID: kb7ulZ81TAy76ZhXMKHI4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81936642"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 09:23:59 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 09:23:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 09:23:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 09:23:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQA5y/j5iNt07Rm8b+dZokQm3ohJRAWvvyeWfJM5tV82CSa1+6oe5qZ080oHY4MF21U7iXacc1gOfaIWAGuHW0gLSF7Vw6GEbV/XYVGzhPpY30hChzQthYGuIjaI6pOsc/T7JfgexFmFwSs0YKVwzopoumgq02lqcz1uQZRId7LIcKEdeAqJAYah9EgEc0CuWQ2elpeoVi7cJxegunERXbby3rH7Xb20PIxe4fFLrl9Aw/dnyJUTuCwjzZmhq4if4S7FME3wlkoLxlRcUKj4mWCB0QZ8gMgaYpWRjCH/eG9cJGKmibSI5dgVAez8jFKmxKADuS9pkugH9aAc58+quQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8wkpuvhaEQhNJvx7qqFAzc/wL2COrrodsSronFWzdM=;
 b=HfZ3lNeyqBwQEtHwoLnbGqCdFNYIeo4NUmt3VlQaTpi6QLu58PiRi2hKrcMDBTpesD2NeaYbHW7N0ukjiDtm7P8pWqwKsQHUdTVPVmwsGJR4YVyLnWUPDN4jI94QNROMOEt5IzV3KAXOVsqVbPT4URxV1iaGPPQ80D/hnUtdFl4oI8TPqgVFWuQ9Eqd9YC4Hl8JpQ0FdmgB5hg1KQ5boukAw4JQlfhueNPalC0W+lgy/x/+L5nfSl0s8zXdw6+bCp9RnaU7g8takwjnzryOROrv25wL02286ahwgaKuSUpeTFSc2GE9b0AOUGi3L1pRokrhRJ00Un6vnPRf4tN0jow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB6521.namprd11.prod.outlook.com (2603:10b6:510:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 16:23:55 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 16:23:55 +0000
Date: Tue, 29 Oct 2024 11:23:49 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Jonathan Cavitt <jonathan.cavitt@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <saurabhg.gupta@intel.com>,
	<alex.zuo@intel.com>, <umesh.nerlige.ramappa@intel.com>,
	<john.c.harrison@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] drm/xe/xe_guc_ads: save/restore OA registers
Message-ID: <pug6v3ckrvxd7hkrfmppwxck7nxz3ta36sorzcekpzdwgk5ljt@4hxdgwvuctwj>
References: <20241023200716.82624-1-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20241023200716.82624-1-jonathan.cavitt@intel.com>
X-ClientProxiedBy: MW4PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:303:16d::18) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: 905cd5b8-72e5-4f76-9eee-08dcf8361578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iaGxQiKFvQr64TyEBIXPYy4A7296k62sYLwYaR0NqFoYeJJPBOQa3UllGb6G?=
 =?us-ascii?Q?xatY1JDaR9DjRKd3ABr/rkUthCZx7FNJqFEN1t9j48S40z4TmH/wzEsdX1X/?=
 =?us-ascii?Q?dL94ysfifJS1UXrl8crsH+7Way3L9ZHYY2724n/s9Pmpgj9TPjFItyUn06Er?=
 =?us-ascii?Q?8hhKOOzhTD3NndVBSLIwP4xTo5HKqZUnwTqf7AFH1YVWTAOMmU+dwuIQOLG8?=
 =?us-ascii?Q?PMzWL6Xq2rnjFLeIVN6esOFMBMh5UMVTUBYcDNGBA6eo6fXYMoSwEHDWbaV/?=
 =?us-ascii?Q?sWePcHS8QrYZmmgWj/SB8EGpt1CQvADHw4rxc44ICMLCNq1e61yAtscH8BAX?=
 =?us-ascii?Q?OG5TyxnM3zfg1RElfLsdrW5KGdOdhB7rw//WcMYl9MFam+7SOTs5bOJS1W7t?=
 =?us-ascii?Q?c0dpXm6op4xNCtmkz7TeFI6zngcBJogHLfFfPztljdAwwIgwrri/udg79r8g?=
 =?us-ascii?Q?oD10YSLt6rTMX8nF8ixSHkzf0VtHWwCIjBoGH3jk73E1+7hcTuBPX6S0n1LM?=
 =?us-ascii?Q?2bYYpnTXKKyhXKNh29qRwCgf0LOqvYLGaxGdEtspuN83sHKj+kY9DmQJteEQ?=
 =?us-ascii?Q?dpVYuiE5lagAxQKnhCN24+dv/uchpjTLZr50Ys8gvs9Xm5B1YjeEsY4Ozhj/?=
 =?us-ascii?Q?hGQS4rS/MXsXVVLMXUukaDa6yeIxj1pTKthDHZzYOROxgaEtkuQ6Wwt6mA+i?=
 =?us-ascii?Q?BvMGa1CqK7+R2aFgCOGqQ/O133+6vL/CfpN5bNXsGQvxRaNVMYQTsF9cfDhT?=
 =?us-ascii?Q?jyF+kS9+jxc5xANjMQvX5W3/kSFFWIx8abZTcW3ZRVISfquQ6Zoj9tgyjr5w?=
 =?us-ascii?Q?FdP241wG75O0tQ7un5yNvjqEi2X6dD1QhH7RdmMoc5vEJia6uuGn0vhNzLtg?=
 =?us-ascii?Q?UrqyCeEeai9e3dGIzRpt0b+c6S6QnEep3mSBBpRZ8snpnAOSzDvl/TPXbx9a?=
 =?us-ascii?Q?Y661t6vKmYZpirSKFpBJ5ZjCzjc5avCJqIbIHQuCg4GPX0FBD6jjiAqVn3Hz?=
 =?us-ascii?Q?ex3yZ+JCHdwaEtjxpUYYiwG+b2edIwN92Ze+7//aEMHHOHrTWDVzB5hA9N7u?=
 =?us-ascii?Q?EJIwp9ASKNdME8H2vI13Cl2dn9Mfq2XSsJORmEV34navC8IkEnW1s9NMjQOW?=
 =?us-ascii?Q?T5FQYYs/1TLvbC/zzwYD7TBgRQkuK5GHurFfsJp5mf2VP6ZH82mE4adVfw0i?=
 =?us-ascii?Q?L3wh+gYeOAJwSBB8WQYS0Y5X7XCdlNRtYuI3v465IoO7C1ai5uZuBusRiXib?=
 =?us-ascii?Q?ED6tq7XDs1zx/n5etfZx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9rQE9LkgGhPv1heAvNbtGdfBhdNertuZAusMjw8qtyfDlUfRgFp2DnD2wEEX?=
 =?us-ascii?Q?bQSOhbw7wZOpz3YQNuBCCzSzRaLuap4sihoSwk7roiIk5T2nMc2YfDQdClos?=
 =?us-ascii?Q?dHivWH5q6ePdUYKMvM96hb+oSfzSF9vfbvYyZbBGpZ8SnWRXIswQ2W6lh+o0?=
 =?us-ascii?Q?hJgRjUhFViNoMls9XITQHQ3e4YliTMmq7E3s4ZhDRbMEtGxkddqXL8UrpNDG?=
 =?us-ascii?Q?3fLFrdSPXYO0KYxK/oMtqKwxfjjpON4/V8C1Jy3HOOln+RYg6e8zDcRxDYLr?=
 =?us-ascii?Q?Zy0+uYskYNey4DU/o4Pv26a5PkBbsfIWPe5yeYDZY18469EcN3xebAhJ00yQ?=
 =?us-ascii?Q?1siArvNUHuQYpaaUg366sPJmEm4cB3uTg80TLJNhnc0Pmmy1nm0qa+SfU38s?=
 =?us-ascii?Q?mLIt/qIQ8SS7PrR9TszwHQjvY/ZJQiWw6xCv/PLWT0i+gDBP2K1ILkI/L+DO?=
 =?us-ascii?Q?eqxEFEc6fetrz8ok4/SjbKmHOK5uP2rCpXYmWHDHe1Ob2C5QRTASmBd0Gb44?=
 =?us-ascii?Q?V1dVrMau6O5p+lt0JiS83ESr5M8jRjEscV3tP7ag0VpiOUjLG9t+v4rtxVMH?=
 =?us-ascii?Q?NXDixGKTGmtMibvxEFxqePej/f5ea7UHfMXNlc13pMdVE1CInuGAAyiZGSFh?=
 =?us-ascii?Q?zXhiGY3eKBAXgnQYtGkL+GitHBns8mCPXXmp6hKVyCwlSOxWwe8SSUgPMJdi?=
 =?us-ascii?Q?lfLhtIiEl9vzYtpYQNGyDoNBfxCZxAuBpl/VG6PaHQtDhCrKz0MaMn0fF6Wb?=
 =?us-ascii?Q?VeSuUmbdEMCCm+Kv/39MMFEchYRbp0zh0g+BExl/18ZtPooJxG8p2PYbTEkN?=
 =?us-ascii?Q?5eYZoznGjI5g1zUWkanPvYzqW4NSWSXcgz//6IMShYjYJY5kZcSP//IU+clS?=
 =?us-ascii?Q?GHV7/yUbnTrhZbILnfL6EWdpDKtJ7xOwA1i29m0BUDQ7cXBUy/iqndx3J9zo?=
 =?us-ascii?Q?3P8GTgfYxTxAFFB9HfAHpc78pEc5OXiFZEEdXRKjz0riJI35PHPYGOyBLjbp?=
 =?us-ascii?Q?IcwLNnvxoVshvs4XWX+M+SVVE9dokpa4lOpe6ujAici1oygzFRSpaLfZTqSg?=
 =?us-ascii?Q?raGWYJU08QBCRKemzz2kYIIfVIK0nW7fBSD3VuPVH7++KlqGgX3f69fhu43Y?=
 =?us-ascii?Q?93px5cfmyVWQGwq6KppnRZoYmzzmW1Weeyb64Q2EbAFJKJdyMOMZZBii3uwM?=
 =?us-ascii?Q?zuVEMDOHUX9r727vIDrclfdVZuT0jQi1kEiOEqV/yPF0eA2pcNn3+aZdTa6Q?=
 =?us-ascii?Q?ZG5ZporyhjXtd5uyL+wsuf8cZnsyGyygEOo/n+zbwhfiKKx6/9C+rrLMmbkK?=
 =?us-ascii?Q?2qcxx1m8gh27EXSgZsQUDWZ3pdCKOGIrhErU/YYIug5JMEpoHYuAyfwiTPVz?=
 =?us-ascii?Q?4c6Wc+hQv7HRPVmPsFe01GbaUNcYFVFLWlAZy71vXF88Hz0pUQJ1wgTy9V9h?=
 =?us-ascii?Q?5uLSok4on5kq9L/hgJlobDRlLPm/JPod5drrs+0j3TSZLsi0Q9vlV1Am/6Xy?=
 =?us-ascii?Q?kIYuyrL4DxJCcOOVe0AS2cLZTTNRzmkVgaIGc6tNUL9sR3Vg6DVQ/w3GevnD?=
 =?us-ascii?Q?alq9OznN7LLbpuamzC+mTAOWOxT57FYPV4cTEAqUrbjdj0x+e6m/AWEpQg4J?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 905cd5b8-72e5-4f76-9eee-08dcf8361578
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:23:55.6087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Se7/CbWkdrc9PaSZTDffkaOc0AgXwnuvoShSb1qKnB/rjyNRBEd4i3kIyZqhF73UZRrYddhQDrjACtXPBEqJwGf3lXUcndM1z5JuUMBXIe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6521
X-OriginatorOrg: intel.com

On Wed, Oct 23, 2024 at 08:07:15PM +0000, Jonathan Cavitt wrote:
>Several OA registers and allowlist registers were missing from the
>save/restore list for GuC and could be lost during an engine reset.  Add
>them to the list.
>
>v2:
>- Fix commit message (Umesh)
>- Add missing closes (Ashutosh)
>
>v3:
>- Add missing fixes (Ashutosh)
>
>Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2249
>Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>Suggested-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
>Suggested-by: John Harrison <john.c.harrison@intel.com>
>Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
>CC: stable@vger.kernel.org # v6.11+
>Acked-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
>Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
>---
> drivers/gpu/drm/xe/xe_guc_ads.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
>diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
>index 4e746ae98888..a196c4fb90fc 100644
>--- a/drivers/gpu/drm/xe/xe_guc_ads.c
>+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
>@@ -15,6 +15,7 @@
> #include "regs/xe_engine_regs.h"
> #include "regs/xe_gt_regs.h"
> #include "regs/xe_guc_regs.h"
>+#include "regs/xe_oa_regs.h"
> #include "xe_bo.h"
> #include "xe_gt.h"
> #include "xe_gt_ccs_mode.h"
>@@ -740,6 +741,11 @@ static unsigned int guc_mmio_regset_write(struct xe_guc_ads *ads,
> 		guc_mmio_regset_write_one(ads, regset_map, e->reg, count++);
> 	}
>
>+	for (i = 0; i < RING_MAX_NONPRIV_SLOTS; i++)
>+		guc_mmio_regset_write_one(ads, regset_map,
>+					  RING_FORCE_TO_NONPRIV(hwe->mmio_base, i),
>+					  count++);

this is not the proper place. See drivers/gpu/drm/xe/xe_reg_whitelist.c.

The loop just before these added lines should be sufficient to go over
all engine save/restore register and give them to guc.

Lucas De Marchi

