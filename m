Return-Path: <stable+bounces-83508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A13E199B000
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 04:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3311C20EBE
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 02:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30703DDC1;
	Sat, 12 Oct 2024 02:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOlKh1w7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D45DDAB
	for <stable@vger.kernel.org>; Sat, 12 Oct 2024 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728698885; cv=fail; b=evkhnba4M5QBWlkEPUbws24Cgc+ML0NnNZ9UcM2/vdt1OnE3C9ACXFlYoXDFFoPosKX23y/ixsJC9zntJR//gdu41vLwLPvbFVNsjxkODUG4HFvxGy0+azeA+0WRifxK0nZfjMqqwmW8JiXLYYXa8HNdluwXj84LKXtfW5vihHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728698885; c=relaxed/simple;
	bh=q/t+cIzPCBIZdoc8sCCO+GHf29huJ0R28e/iEfN7pv8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DkqvdBr5uBIKDTTei5iZxgO6DHxQALLo2O6Csy4R0lOz+dTlzDJSdU2oeQY/LQCXSfq+USbYirfOJkr4nkUJ5GQ+UChGlaJ49Vk9C7Qb1l6Lw9cQ5gy1Iau99g2K90FOHOM6LdiArWMuJmrlvfcLl4OQerRTlTd8eFOXeEXecSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOlKh1w7; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728698884; x=1760234884;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=q/t+cIzPCBIZdoc8sCCO+GHf29huJ0R28e/iEfN7pv8=;
  b=DOlKh1w7QFHnPfoDtNJNODRQQAJ+dZPuk0rzq3M75LX6Kr17v9BUOe3R
   eGqbyUrxba2tfJcHLaNeeFL21Tw6knSZwTv1Q+EKFo0mGKcmRTrUL8Z/l
   cJElb08g6zq99bSw+JM6RYMgMlUVszTXEZkNa5JksCqHLDMnW5rl38v92
   Ths9odFTiX9EB8nS4HPyTeT5W+O31BFzSMiKNG2Cv44ftDFsMhcEauPvP
   eEfVUIdd4mrRUKpg0IkfKr1Q+RgiWjVAxO/ZlmoWTTgRgSn5E7h8q+/lv
   vlHo4Hr32Jta4+R8zkJH58RbI7loGUcKdT6Xq/T7pe9heiJISPh0H9Onx
   g==;
X-CSE-ConnectionGUID: bg+Acu0GStyC+Qv6ga2CCA==
X-CSE-MsgGUID: UB488RVfSum9/Ge2wX+oeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28216294"
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="28216294"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 19:08:04 -0700
X-CSE-ConnectionGUID: Py/fGeGsR8GAaPpyJ1S1Rw==
X-CSE-MsgGUID: iCP1oBfQT0KKIdXeNh/S2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,197,1725346800"; 
   d="scan'208";a="81851467"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2024 19:08:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 19:08:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Oct 2024 19:08:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 11 Oct 2024 19:08:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 11 Oct 2024 19:08:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUOCqE9ykWhQ18VA5ZvoBStluW4NgnUfjUj+zAGerHGSSATrYNIr7KBIjcDs2521Owc1+GSAQQjxixe7mZtbLCq+spVgx6IqGHwgxw3oYv7cDLbxIlrn064w3ZJ7+HvYRqnxrGXsm2M7tSRTYik3gqmEuSGNBymIWooEGa2Y/R9MKE7197nFPc53oVtDESRDbKzZgOiPh+uHJhrN+evVv7GXgj2tnN2znMGD9OM5OX5jNZyd3OEqhSD5GuzLONGjEB2kYDZ0ViDUExu5u6wII2bxKrEsNQfG11VavH5GRgPgxXvcaCjJW1PzLrfhXpXbFckzz5xuCC3wkx3NKU6z9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VniUH0UgVQvoKkQJJ1uRabehJ9oVTnSkmdllutjYMiU=;
 b=sHx7aKYTF8jQV9AZwcqTSFG8shNNsmKbZgHBy/4RQW/HvBXkxyl5o4dhTIMJkvIjiQmg4pMppJlHJ5uM/jj7S1RxzZFYNBE3C5xrH32kz43KVaOypaY829l7B/fk6xRwiMoerdOM4uF17atYm1tl59nHp56kZ/OdyKTRktj0YQ92uOC+gUfX4OZUXITtZydzLhhB279eHhE7hYTAQAEMw+Ct/Dc3HET3is8sj8sfymKGcZoZtyOugvE8C7ftn25Sjli//4kUwsAaX65cSzPo0Oxcg9f8omVqizglvIgLzAHddIr1oIsJ91j3gh4hfrCGKOlTFwHFNatQBsD5Q+mlGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA1PR11MB8152.namprd11.prod.outlook.com (2603:10b6:208:446::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sat, 12 Oct
 2024 02:08:00 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%6]) with mapi id 15.20.8048.017; Sat, 12 Oct 2024
 02:08:00 +0000
Date: Sat, 12 Oct 2024 02:07:36 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Nirmoy Das <nirmoy.das@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>, "Bommu
 Krishnaiah" <krishnaiah.bommu@intel.com>, Matthew Auld
	<matthew.auld@intel.com>
Subject: Re: [PATCH v2] drm/xe/ufence: ufence can be signaled right after
 wait_woken
Message-ID: <ZwnZ6FZQVcvwuPuW@DUT025-TGLU.fm.intel.com>
References: <20241011151029.4160630-1-nirmoy.das@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241011151029.4160630-1-nirmoy.das@intel.com>
X-ClientProxiedBy: BYAPR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::25) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA1PR11MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b9a7f8-bc80-44ad-5aa8-08dcea62b260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q8OBhFLMrVMcwbvZvhxN89bLRXFyvp5EHUawELRbasfZQ5WzKd+THmWCNeF/?=
 =?us-ascii?Q?6aH1GxqElqGFbzJSmPUZymVl8IFZO9CnoMIlSwtA9gv+n0woBeiA+QsUH7vK?=
 =?us-ascii?Q?HfxfqaKz1GU4PIQSDgq7CFOm2pWWNqPLBJIEv0A7GoppVps3CqXBjFQVoo5j?=
 =?us-ascii?Q?rT7mc0Ig1kfVA629R7Vv2R8dxQAZJFB+/+oIKO0NBUixSPJ0sA0orGi9lQB8?=
 =?us-ascii?Q?2cd3x6iupSGj5T1iaRR5UpL03hR/kQP55xzvfejJBcHDXhdepNMLRQENDt4U?=
 =?us-ascii?Q?DvpP3eaVhrUemnTSFNPzvFmL859+FXmZaVI5m88jgA7Tc0imF+ox8drgUixE?=
 =?us-ascii?Q?IP4UPXdY2Ll76bUaBc1TX/cCTqnGx30b1+YWq9gcnkUzF0xk9kC1h+8M8drJ?=
 =?us-ascii?Q?8Mww1ERqDoQ+aXXuai2SDNsW4izEBQ21kaVD7CaPlr7IFWI7Rmi3BYc1NYWL?=
 =?us-ascii?Q?ROoM3xLmOFvYiMQfex48OiC8LY2XE0xm2++MPeR9lmW+qFk6WmeLEPYGWp53?=
 =?us-ascii?Q?X7sQ4eFxcbQXRKQCx7QG2YEWz6Ol/Y9i4GKIEZtU1IYzBKqBq5jCz8Q88M8t?=
 =?us-ascii?Q?tGRoQXLBi2IS4aG0FaoXPyRMl21w8Xz/IlpyY1f/d8S++eBpVuhAaPM99+SC?=
 =?us-ascii?Q?xwRaoUjwpwKjcZ1yLLyUI8P9UQD9WsutxnlWJk5x85g2PZaPG48ETMWsyVpu?=
 =?us-ascii?Q?QjSqaaSHGxCB60KCBTTojnoeg54hyey5jVxq3iXS7K4UwWmIdHugyjM9tuVV?=
 =?us-ascii?Q?9FYgBXovlUDm8pPTKnGg84k9zX/FNBxR5iv3i/vOVU/JYz8tBOZX5jM266Lt?=
 =?us-ascii?Q?hJu3HOSa6CLpomUMQf4arhstykNaV38FFzx3ouj54165Ef1Q89ymx4JNZyjB?=
 =?us-ascii?Q?JLV2Q0hUnr3t7ITywBrBNuOkkFqOI2tMLvV/gvBmyxUSSomVzzJbJ6j9jcC3?=
 =?us-ascii?Q?Xbr3440Uucjbom0VPkL/VveK53m4PTr/Gz3rQrZ0pUJuFqYYCMDzPj4Wp4Lk?=
 =?us-ascii?Q?KUbkIxbdHwuf4caOAVsZaX9LPAtloW4aDQ5t7wURg9xOnrm+9oya+DCEcsf2?=
 =?us-ascii?Q?SF8yiLN0b/28Bpf6GaPmpqekEEglO4hraOEaqlfcHsM4e41b3A1Bnb6NDejv?=
 =?us-ascii?Q?wMa0/h2uD1hNmRXyP9Eo7ycAnGIxNuBMr3W1tEmS7/TV2ZIJ0Bcz4Bmvn4rC?=
 =?us-ascii?Q?/2cJEE3FrdWOgcrXefQKF6zFVmY/rZNBKi2sZaXhnc+Ll14RDSJ3Cbu5/h0?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v2hcySojmyDh1kSZCx04lfDxpoKA0+Azf3Tu0RN5mivnoyRPIyWX6fdGjtr5?=
 =?us-ascii?Q?BY5L00813pNVWRR1LOKz4wTJ6/jOJaWiO8kjoCbK8gcO+nZedZCPktDCcKYH?=
 =?us-ascii?Q?pVbW3AwbCUx0FwQIqShVusFDBn0Qo80yhqrvvT+dtByfa4JEDzWU12wMiIt6?=
 =?us-ascii?Q?IBCBwfbTz3/E3IJAsuVBf+ibezc+wY5oTvDYVaZY1CKOK2LaVgWTFQBccdcu?=
 =?us-ascii?Q?luCiZwCB+YpKehskZHdX1zIpNTm4qG2ECn42CcWuBVeEZwyahHr4e+Z8SlNM?=
 =?us-ascii?Q?dKvHQs9GHOBpXbOYbb/Op2G6AGAxJdujg97oqZf5zLdZa/7dgTqS7bRdRQ/y?=
 =?us-ascii?Q?Xh10k/MLCY7jxqWNFbnjZ65Br1tV6horiKrGBB8fjo3++EypVAcMAVu2HN9y?=
 =?us-ascii?Q?NYpZrqxnz5H4TVkPls4J6taQizTejhPICnB98Sj7RfIcsEXI/tEFgWgGBwib?=
 =?us-ascii?Q?WNABgA/6JgkapZFiQ4nsAegLKCkZt5I7ZnxznhJo5YGhsBV/RFNLMonsmBv0?=
 =?us-ascii?Q?rcF+EzOUMB+HvenSGSwzHUOOcO5oz/w7CA5TSERdf2nNYjHCCTAszHiZcvnL?=
 =?us-ascii?Q?8RmHbFd/FpYW+yoY29NVkj3GCZm0ZnGCiwDU2dPjupd9IO8CKzUtrDg1NTWk?=
 =?us-ascii?Q?bYh2z/nmHiHsKUfH52xZwJSCGg/JoESwF0GSLgPVKTty82ycy/yHe7bKDfy6?=
 =?us-ascii?Q?VSOTsCdSbIY4LT6GujqQjNpK33ythsSr+SwrC7rTnWB/R0jv8t1X68OxaWYS?=
 =?us-ascii?Q?gzPQOS0BvZszZgarPzXca6qvnRw0Tcgl5sYKrNXIC101wDjt6i/1LvH88aBc?=
 =?us-ascii?Q?sRiyCuOzyqjxuwfdNSiBAW5XedGA2ePHWUwiuEWTGTxNttf+b9VErB7+UiPD?=
 =?us-ascii?Q?Ii/XXahNTc8UohtFGX0iH2oAGjKKf8fnwcwqqLAYegz04gjtbEMtwHxtpbTJ?=
 =?us-ascii?Q?V3kmv/wHN573wIdQwi8wSNEnwq5jR9zKp2KzYeJkyD+W23gFnT25erEpjP/c?=
 =?us-ascii?Q?u/NOVmlsLl8DsiQkHO9/wuBSgzShkDE7p7+WS3h6ejczzU8AYki8t3FpfoEi?=
 =?us-ascii?Q?G4cIWvUvZteMw110SMbv0pLn10xKMMB1KkJDkRzRn/j7HlEcEK7gqRliig+A?=
 =?us-ascii?Q?LFzw3657zKUgJyv6xcPXZjFmfDyOEdZaUaX57vGPIGLl2OYesOs11cU65koW?=
 =?us-ascii?Q?Z2+FSTmcSeucDeaEgz6pfauf5qOx25Lxv5610v9H02NDx/NjmgZq22INmHv7?=
 =?us-ascii?Q?w+iPSIgdW/Oa37GIs01lcQQBfYheOicswk+cB0CluuMXh8mb7PRtYoub3z6A?=
 =?us-ascii?Q?LHLHZT5kv3RDvq0cIXs4kdUFNUdrnK5DYX4Vco7ly9Nb4jlU/MviEsWFuTFK?=
 =?us-ascii?Q?WjfR1kBNlcG1L511twjSbTyHwXn2ub9UtChCNL4BtJtbNIlZct1VMKzDEzq9?=
 =?us-ascii?Q?TQ1F90BtYe12Z9ID38zXSznDl0ZFm6Lfu0a6kXFnXBhyJrSh9i82YFJuGgfa?=
 =?us-ascii?Q?A6TFgbovH1USKdnahz29AzirI8yjqQwH9reOH0ev/ZOgNxXLt+y6bE0l5YAU?=
 =?us-ascii?Q?uwEFzoR+0F7pn4R5JwJWksvC7IZN5c4KW8Jtoq7NPYFKicj5MFim2XgJzOz/?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b9a7f8-bc80-44ad-5aa8-08dcea62b260
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 02:08:00.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFBJPyS+w/A/RXrdCA++tQuDYNEDkbY3nJgvUamUgXyfWfZ9gL6fPBJmM8VqmaLi9VKlJB+rE09L+qXXnyM9SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8152
X-OriginatorOrg: intel.com

On Fri, Oct 11, 2024 at 05:10:29PM +0200, Nirmoy Das wrote:
> do_comapre() can return success after a timedout wait_woken() which was
> treated as -ETIME. The loop calling wait_woken() sets correct err so
> there is no need to re-evaluate err.
> 
> v2: Remove entire check that reevaluate err at the end(Matt)
> 
> Fixes: e670f0b4ef24 ("drm/xe/uapi: Return correct error code for xe_wait_user_fence_ioctl")
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/1630
> Cc: <stable@vger.kernel.org> # v6.8+
> Cc: Bommu Krishnaiah <krishnaiah.bommu@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_wait_user_fence.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
> index d46fa8374980..f5deb81eba01 100644
> --- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
> +++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
> @@ -169,9 +169,6 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
>  			args->timeout = 0;
>  	}
>  
> -	if (!timeout && !(err < 0))
> -		err = -ETIME;
> -
>  	if (q)
>  		xe_exec_queue_put(q);
>  
> -- 
> 2.46.0
> 

