Return-Path: <stable+bounces-88190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E16049B0D74
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 20:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100BA1C230F8
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 18:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7701FB899;
	Fri, 25 Oct 2024 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGUE963e"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414601534E9
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881280; cv=fail; b=oMLKnJ9tXJ2NZojVuhcqoQe/HX7Ho7fCwJBPYaaDUTmGBOwR8BfkmOcnbBMiWmGgPalGvOCno9cGP16lYYzte0YO8w58d1aJiMQ5UJka0kcayhCJ62EFY2nGOcFef3qxORrbB6WVZUHWQ1b5Q7nqdfZWVT0aEvnR70+ULqF9pXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881280; c=relaxed/simple;
	bh=Q6woNAu/6GB2xXEi9VWVKgLHUPaTiZUDIsJoC/2N1H0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WNs7uVHtT4GYdsBAjDf/c6weWw06vwYKwt/OCHRhPojoGPPyMzRenTrN1gvh3uM4N8Y4DJke3fHXbFvLC23H4cxetZ3IwVwTEY30G0Am/N3XrlVkwibrfncZ9CTrcWBQ/8DQO8WX35G3V4m0xR6VHR5prWrEvKMB/wLesnh0d+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGUE963e; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729881277; x=1761417277;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q6woNAu/6GB2xXEi9VWVKgLHUPaTiZUDIsJoC/2N1H0=;
  b=VGUE963eUuaus6JBoD1ZcX5TcYaM4Vw7j/FFqSPfYzk9ab+80uFysvZN
   9AcWkH4A6A02bauNrKQ2thwUAOLRH+AZR8lXDO0uEnUeIbFPz0MqS5h6+
   GT2xovwqwAJiXIO7mFhlBhv7aCUw8AvjKtwHsP2+NmWd6FiJyw/eddCKm
   jR2SDowaqZAtyH0hUFLtwQwfliXhSqBuGoNpPjAFKc5xkJFSlDgrkKljP
   aI0h5EPV3M2osfU7BxZ6U6d8/GB8GVqaIuKpEJrHfQSW1LvQqTRdGymif
   LAh29d/yraTM5t2pAYk6ojHy2sDuwR/e2JF5ZibtxexQ6m4NGwayqXKS3
   g==;
X-CSE-ConnectionGUID: g/+s2r/5Sq++ERIrwExj0g==
X-CSE-MsgGUID: MAqXkFNZRwaR+q50lPgecA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="33469634"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="33469634"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 11:34:36 -0700
X-CSE-ConnectionGUID: bJuc2HuQReWebsyENd1q+w==
X-CSE-MsgGUID: 22BNx1RhQv+FsNLu3GXlpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="81138879"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 11:34:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 11:34:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 11:34:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 11:34:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgYNr4KCY+1NmU1zDllYKYsHi7TQ/pLUI522zj+IG3WcJ//izsGc8REG/cBcRghWP0M3PlSWTmSRn+6J1bqdb+lSWU5kc4B0s4bq11MQaiZDdZyBu3k4/beG81wXC/knApmG6oPHbWKbZWvzRmf+UHhapeEyS4wFh/P+5KObbdtEO+uNqsDqnzrRUMgBzsu3JGtB7K0OMi98+l8N6zGeN+yPAyv0884K2652uNhzVHt8QJjBvno3Nt3GuOGiJH1IxKnI/QB5WMRIspp9IM/2aJWElCJu61hLcamXv7A3dx9R9qInPc1f6/ahk3cHodlqHUoBJkdoOGeWZ9M89VIJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JQSTQsKStzvtepX0cydZfaCu+ECmjtTNje+GLcrHTA=;
 b=lnbsWRl/rr5OIeET/SvKNMlmU9k3oqPM23A8pGP4o+b8W4WqIni8yuMP0oipl6k3vAz0uua7DhnyfLhwPGaDdUKRfLh+bxHAGY34B2TSAso7jWk8LZKcnImvHEiJXjz05vsipbli5XMfOYThZZtcS/d+UIIH7NfVOlS0n3pioafIuirbGrOFWaCz6ZxluPzlJqw7FbcmVzJPyfVyZVb2uUWa+XycMZvr0l6ZFMKuf7H/FmPiuaVgei3mB7cqjWiBwcyPK9tr4z7+EyFpvOkGgVx3SxbT/kdIJKc0m9PEarvrOyMkbkrn0AETc7OvaY1M2r8pEwyPPCkueFMYar33Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CH3PR11MB7916.namprd11.prod.outlook.com (2603:10b6:610:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Fri, 25 Oct
 2024 18:34:32 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 18:34:32 +0000
Date: Fri, 25 Oct 2024 18:34:06 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: John Harrison <john.c.harrison@intel.com>
CC: Nirmoy Das <nirmoy.das@linux.intel.com>, Jani Nikula
	<jani.nikula@intel.com>, Nirmoy Das <nirmoy.das@intel.com>,
	<intel-xe@lists.freedesktop.org>, Badal Nilawar <badal.nilawar@intel.com>,
	Matthew Auld <matthew.auld@intel.com>, Himal Prasad Ghimiray
	<himal.prasad.ghimiray@intel.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe/ufence: Flush xe ordered_wq in case of ufence
 timeout
Message-ID: <ZxvknjgW+3hQx6nM@DUT025-TGLU.fm.intel.com>
References: <20241024151815.929142-1-nirmoy.das@intel.com>
 <87bjz9sbqs.fsf@intel.com>
 <3865ed60-94aa-4bfc-b263-90283aef274f@linux.intel.com>
 <892d9ec7-6a0c-43d6-bfc1-eb8004e27da6@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <892d9ec7-6a0c-43d6-bfc1-eb8004e27da6@intel.com>
X-ClientProxiedBy: SJ0PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::26) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CH3PR11MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: ed43106d-55ee-42f7-19fd-08dcf523aae5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8XC3DiQuYkP3xA0FDTdDOW+MMpidtw3QNtoZdAbglzxvaVbdyGADuzWIVJ7K?=
 =?us-ascii?Q?LEHcGcDC7iRHh1q1f4VQ7iWUGPv9dFvvcbgBi+7NfkE3uFhL41N+sGSgdwOn?=
 =?us-ascii?Q?Z9YXNE9fZBEIo35OjIIvpOrh4mHNE9oSrS6I71+AlQ5DVx4jpEZ+gihEjGxq?=
 =?us-ascii?Q?mvKc4VpOtnBv90tmk+FaDkoHaomOyyOpdTtM9YrMzUxsCwvYRLMxEyYM3yYb?=
 =?us-ascii?Q?3DYDZ9h27ftPC/4r+cWSBZdB6Gg1inYZkKS8+1Yyg9FYv59NmV2FtesMTOjH?=
 =?us-ascii?Q?I7B5LnUF71OpotYvbyqi3ZEicHYUPaYZJ6mJuUyHYVt7BZseueu1paCpCFFP?=
 =?us-ascii?Q?UawEwcV+ll2PnnDxc964WdJob0Rh7ZVgd1C/yuP/mo7mJsYhPTj66oPL1J1c?=
 =?us-ascii?Q?oB2OPA+qlQKbUixYuy0cPTyCmGbbWbIwLTKXh7OyttWR5MxdSrGpEOu3n2ha?=
 =?us-ascii?Q?qAajk/v8CWTq+fgf0n525GvwUVGRp6nNfbMj4KUCWHBmWOcgCyj3UBJJ7yfk?=
 =?us-ascii?Q?Pd1wjrziQQ8rt5rkCAc/mUXumdjHfrFDmPkMImzF6Pe8p+FyBT7saa9zd41u?=
 =?us-ascii?Q?IKVJ6/bHJ9TxVsNRvmaeiccGdGNw6dlm2U/ab3eMg9VPtZu/1kOxVG/MluEd?=
 =?us-ascii?Q?a+Km+l1O8DO6SX+DxJ/dg9PFaYCkZt6HIkQkFHhLOcrcTD2JFYUwt8Wtb0I8?=
 =?us-ascii?Q?8oDQAcGCvf5WUMc1sUZQ5I3/vDcvJuKUT5KnP0Q/TUBXfb7YO0Z8DhoomTu8?=
 =?us-ascii?Q?1fj2zlLQUmZ9ARQ1Gnvo9sD1BMHFtDRQdGo8ld/bo0pNFIoTostmtD5JTMU8?=
 =?us-ascii?Q?bOzGTUwNwhny3oN0bt+6LmkX4N0iH1lwy04PbC2/rplFGRF4eApXPT87WPe0?=
 =?us-ascii?Q?L2AYBJ0UNAuhL8OwKkuSY6St+B26rsWjqjXyWkpUghxMf1USCxfW6c6529JN?=
 =?us-ascii?Q?XPAtK+Ct2Qe//WReGEoOtZn6ndCwz5I+XtuWAO38BnfTdLdANHIl6+xLvNCA?=
 =?us-ascii?Q?yHbwsL008L12ItmAKlxySpOHmW6wQ9cgTpZYsYVIpZ9nhfpVykWB2TDzycHy?=
 =?us-ascii?Q?5LUytqFwhD67Gr8qrSh/P1QN/6LR4dvKJheTz36b/ON/pTTXfFCYSxhVq8kU?=
 =?us-ascii?Q?cW7rIl8Cjlq5fgDplngEJLyTRrjqMZx+Mqwaxg9P16nmDCrsRoV6npyyEOgv?=
 =?us-ascii?Q?HkjNys261ifehyFfk3sTY2W9PtCBYoOcHoXjAAsw6zUTFG06cuNcyIGQ1gqH?=
 =?us-ascii?Q?lVomQwb9JfuRxiDeTnHJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fZ+nRPTpGgLVXjK2GCtYcrdLj6rOBES8iiD3xxCV/DOndKsxPs3CII9mid4I?=
 =?us-ascii?Q?45XbRDD07wRIhN7B6DXp4fDCMiMKY0/Y/OVnQesJoKA0QWas4n617Ye5WK80?=
 =?us-ascii?Q?qqVVUUxlKIZ/LT8o337qMsrZEgB+FxvSWkKS/dhwLNLszi4VQfHDHZNx7P2K?=
 =?us-ascii?Q?dbFR0b97HOiIZq8ZMK2/KvALOIbZv8OmJ8D5ZM/r+LkHaI6xVOxWmG6X/qzm?=
 =?us-ascii?Q?s4LQzLskiUuFBYYdszKe3lYVLWAfMsxHZqCMC2bXOMUsJSYp+JbgQZF6yx3c?=
 =?us-ascii?Q?s8evjCIxOnzlwG3HjVMIPxh2PKvlbDJ1U8h8HFtWXUi/uOMt21LZXcP6feCu?=
 =?us-ascii?Q?xQNu5+9jPbKoI/bN9Ewu+GzidRiBtU9zfMJTC6YDDOUndzKubCxN/aakad2R?=
 =?us-ascii?Q?eZF1bPe+TmcgHu8WyPEeg8/mri+mXQDVtOchud7YEGpGhY3iw2KEfM93VNwa?=
 =?us-ascii?Q?FHc2Pyekv4YwgEzdi68rOjpwQZ576amkzOkhGrbTb9djzrTaX75f6D8uOqyW?=
 =?us-ascii?Q?RVP+88opkZABst8jP0Ok+TsiBf/k2x+rL0wHSpmnybbXU1h0GM1KkMTpoofY?=
 =?us-ascii?Q?tvhEVExptfxolf2QrSjGm+USyFLZZjIO1nqrwXwMWc5GdcBpNA0nHOayLkxE?=
 =?us-ascii?Q?nCqdgS3UQ2fiVRwVLui7xT+zLAV31ppLT2WIKb+CtAFFt6qlAnkbVqOYQMlb?=
 =?us-ascii?Q?TN25sVdfSy/UcBYWQmbSVnd5pfD66Ql0DY5b7odXxjf4FLvhudDRnO6ZcFLt?=
 =?us-ascii?Q?pvjIMdwG5ts85LZ1sWVFdFMbLb7bFeVoaoqj62ZL4qqO2tTdHh3aIpoye94v?=
 =?us-ascii?Q?aeqDp0o5CTFg+8hS8S4yKFod7UOF/TBnT1c1sSH7yk8DuwUFbKp6yGO2L98F?=
 =?us-ascii?Q?98+dolLWa/lbxtf+iIyv9u+aHpSXgIhGBdk9b+szc7rEJKkPHuXtfovY/gS5?=
 =?us-ascii?Q?Yt3DcI88iKbvfzpsZO07uU7WNQVHU4SsD2UHtQ1NPHOGyAWKu56b8kA0R2zm?=
 =?us-ascii?Q?LQNnlQrgafIkyimA8xu04hIvuteDwmvjhzkuuv3mE7JzPS/ENmR2Q75a6k7i?=
 =?us-ascii?Q?WzLSzJjPp+kjg12TX5bVogiZQdyK65s6PzD1KkCVnoLR99EcghHthJcvK+mX?=
 =?us-ascii?Q?m27DpyPFoa+5Cu7wLaEIh+uzlh41EPxOg2ivcSK4XgroTcWBi1iFdw9vyoSL?=
 =?us-ascii?Q?rruRBx3gonyLrQht0HYNs5oO9sPPDqdLaOi3EBWWJfYtS45mJ8G2I5Neb/Cp?=
 =?us-ascii?Q?XwVr9WAlE+f3hH6Qt5FINLJWqwBUyI0bE/PeANe3634ivxJwWrCHxwSuQq4s?=
 =?us-ascii?Q?bibGBiNaAfJuB3f3qqYWvJm72DdEGRgcqQg+w6TUUIltsnqal9/R+az1/gNy?=
 =?us-ascii?Q?pdkdan/GxWBISE/cBW7ODlGFX984KNM/ezkVhdHH6Emzh0I7bMug6fCG6UbL?=
 =?us-ascii?Q?WO4kmaoKc4CgCPdH5YgSZWeka372O80bt1Hdk5ch4vC7gcuV4IzS9Aptrk8i?=
 =?us-ascii?Q?V2Lusc2aXqgVIY2WgtfgCvCjYuP0RN3rWsswL84U+UMCdqaw98FC8MwJflxU?=
 =?us-ascii?Q?H54mBadMZHQmroh8iPwhb2tFcmRT+gMa6Kc6GPhJjdqLVEy5O42WutUjw5Hx?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed43106d-55ee-42f7-19fd-08dcf523aae5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 18:34:32.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCOZSADEZq6uToPecy1L1Sr0nsMn+eB7SIUw2e+qxprVGwQRBj57ZcpRadhlRd+dxeQCV6lKerUrXEZAEkxitg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7916
X-OriginatorOrg: intel.com

On Fri, Oct 25, 2024 at 11:27:55AM -0700, John Harrison wrote:
> On 10/25/2024 09:03, Nirmoy Das wrote:
> > On 10/24/2024 6:32 PM, Jani Nikula wrote:
> > > On Thu, 24 Oct 2024, Nirmoy Das <nirmoy.das@intel.com> wrote:
> > > > Flush xe ordered_wq in case of ufence timeout which is observed
> > > > on LNL and that points to the recent scheduling issue with E-cores.
> > > > 
> > > > This is similar to the recent fix:
> > > > commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
> > > > response timeout") and should be removed once there is E core
> > > > scheduling fix.
> > > > 
> > > > v2: Add platform check(Himal)
> > > >      s/__flush_workqueue/flush_workqueue(Jani)
> > > > 
> > > > Cc: Badal Nilawar <badal.nilawar@intel.com>
> > > > Cc: Jani Nikula <jani.nikula@intel.com>
> > > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > > Cc: John Harrison <John.C.Harrison@Intel.com>
> > > > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > > > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > > > Cc: <stable@vger.kernel.org> # v6.11+
> > > > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
> > > > Suggested-by: Matthew Brost <matthew.brost@intel.com>
> > > > Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
> > > > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> > > > ---
> > > >   drivers/gpu/drm/xe/xe_wait_user_fence.c | 14 ++++++++++++++
> > > >   1 file changed, 14 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
> > > > index f5deb81eba01..78a0ad3c78fe 100644
> > > > --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
> > > > +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
> > > > @@ -13,6 +13,7 @@
> > > >   #include "xe_device.h"
> > > >   #include "xe_gt.h"
> > > >   #include "xe_macros.h"
> > > > +#include "compat-i915-headers/i915_drv.h"
> > > Sorry, you just can't use this in xe core. At all. Not even a little
> > > bit. It's purely for i915 display compat code.
> > > 
> > > If you need it for the LNL platform check, you need to use:
> > > 
> > > 	xe->info.platform == XE_LUNARLAKE
> > 
> > Will do that. That macro looked odd but I didn't know a better way.
> > 
> > > Although platform checks in xe code are generally discouraged.
> > 
> > This issue unfortunately depending on platform instead of graphics IP.
> But isn't this issue dependent upon the CPU platform not the graphics
> platform? As in, a DG2 card plugged in to a LNL host will also have this
> issue. So testing any graphics related value is technically incorrect.
> 

This is a good point, maybe for now we blindly do this regardless of
platform. It is basically harmless to do this after a timeout... Also a
warning message if we can detect this fixed the timeout for CI purposes.

Matt

> John.
> 
> > 
> > 
> > Thanks,
> > 
> > Nirmoy
> > 
> > > BR,
> > > Jani.
> > > 
> > > 
> > > 
> > > >   #include "xe_exec_queue.h"
> > > >   static int do_compare(u64 addr, u64 value, u64 mask, u16 op)
> > > > @@ -155,6 +156,19 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
> > > >   		}
> > > >   		if (!timeout) {
> > > > +			if (IS_LUNARLAKE(xe)) {
> > > > +				/*
> > > > +				 * This is analogous to e51527233804 ("drm/xe/guc/ct: Flush g2h
> > > > +				 * worker in case of g2h response timeout")
> > > > +				 *
> > > > +				 * TODO: Drop this change once workqueue scheduling delay issue is
> > > > +				 * fixed on LNL Hybrid CPU.
> > > > +				 */
> > > > +				flush_workqueue(xe->ordered_wq);
> > > > +				err = do_compare(addr, args->value, args->mask, args->op);
> > > > +				if (err <= 0)
> > > > +					break;
> > > > +			}
> > > >   			err = -ETIME;
> > > >   			break;
> > > >   		}
> 

