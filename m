Return-Path: <stable+bounces-106671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A56A00211
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 01:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C613A37D0
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 00:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C19433A8;
	Fri,  3 Jan 2025 00:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMm8uPs3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7611E1B813
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 00:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735864790; cv=fail; b=nILf71HYGKzl4SHRB0OxY4+RqXEZQx8OzZqdRbUMDLDM8qGW59eaftvdoTlvG0HM6x5FV1ljsX9/QXVfzDcAVodArLlmxKCn9wLbCdHrNZm9Phqkd7ECjn3rcVND7FiCewwVs/g8au7UVRDAV9rEJhMNSl/EUikz3ro17yNPpDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735864790; c=relaxed/simple;
	bh=aWvCvI/Q37wRj91hua18HAhwcdATDagz3BdmF8+TdV0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q0dMtCmiNnugckokIvB3BoyGUYYy1bFckmwft+i52sx/b0Bd0vQ56h9xNYOHrPUEdENg8tHZs76x92YYtua3flvX8VCADSgqvmSjZrtIOllmPWALzeIIP9SUkpUHUhMwjbdIqzC9NO8cXexQu9kr/DRxI9fZV9JTyfjT+AI9ox8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMm8uPs3; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735864789; x=1767400789;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aWvCvI/Q37wRj91hua18HAhwcdATDagz3BdmF8+TdV0=;
  b=XMm8uPs3rzzU8WzRSGSStr+bKKIZQ6RO97QfqWFhZ2tVTFaFVt/81/pR
   F2YD7qvzvojdAkzsRZSFS6LYHMeDpLhpXv7zMopVDxNJ4Gf86JuizFkgy
   93tznwC7t9v3MPVzBjXo4yMR6q0yW4cEyW+FOKOdt1D/whpcVv3hWkNOk
   cvtVeKK2cyQiHO0kCvAkRz+1ubIWEjdTfFjcM+jJSbEofdtPmw7VOvk15
   8ksGnWDQ19xGJWhK0cEZNY19GN1PdKui+f80ZtP3C5Fo1Vg9Jp6Z0dQkP
   vVK51bTdXcBS7+XjxXbRNx84ySwXr4uJh+oHc61m5t97juJaIr8DfKJeW
   w==;
X-CSE-ConnectionGUID: Xg7as1orSwasTmCUvDYV5Q==
X-CSE-MsgGUID: 5mx1pFxAS5+KeqYQWuBrvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="46694501"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="46694501"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 16:39:46 -0800
X-CSE-ConnectionGUID: M5aQ2QmSQEyRydCVpqkkAw==
X-CSE-MsgGUID: IxTyJvbhS8Sj7ZEncFDFIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="132505643"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2025 16:39:46 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 2 Jan 2025 16:39:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 2 Jan 2025 16:39:45 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 2 Jan 2025 16:39:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMd1M8YBrpf86luxObg9LWdgWVWVXjs/kzJLvEJL3w0eNe6IuWBQCHmi4Rdt9l761uTqWENlcU6FtkPEDApPaASPIi6Ih3VPUJ/9iJwOMtACrI6UTfejrZMUIZY4cUU6h6a5ZRQQ/mvm8bDzFxhwIiBUg7nvNKtV82EU1L00TM6ttrdO/yRvDuled1lOR0YzajdtISpkLM7kpfFF0QC8tbIZaXQBObRoXorU6L7GeoZ80ZSptkWcqktYzcGCz7TQgR0BaS6/PfxkvzDuNxx1qKE+FLzyU1Dc87XagjUlNCNh3X1Dc1kooH4Md5lSr6NxDV+5qbzcgs63cJl/fh+ZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inVTS4dQmB0KuOil25K83DnxVAAo5Ezh+LiFPTJNz80=;
 b=rqa/sF2HkEnOW8dNU96nwt0T17GwLL73VtvKjH5LwtHzyocxkFrt4HuEDxbhAhuuZRniGq88kupB9XlxGAtqSqA6KGg3DJQF+d5YAgD1xATYhW4qobrGo/FSk/Sfq4HIttaC8GRuNdHO4oJfTimNlMKBY57/xJ30CuJ4Z2BVnjhmsxZogSR8eL7C9duruJQDIjUJBzBHgKCVXy92Vl/CoKsx3vlA0yt3H1FBi6oGVmppCume0P+eayFwIjrGgwXHeGJ1JG6cSGTcrgXrVFsPltdPG0x9/v8s3XcuwAi3bTb4V1OoLOLjkc1Za24JVgzS5MX6C5VykXWSHU6ASIe1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by CH0PR11MB5316.namprd11.prod.outlook.com (2603:10b6:610:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 00:39:39 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 00:39:39 +0000
Date: Fri, 3 Jan 2025 08:39:23 +0800
From: Philip Li <philip.li@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: kernel test robot <lkp@intel.com>, <stable@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>
Subject: Re: [for-linus][PATCH 1/2] fgraph: Add READ_ONCE() when accessing
 fgraph_array[]
Message-ID: <Z3cxu/YGxFMi7sjX@rli9-mobl>
References: <20250102220309.941099662@goodmis.org>
 <Z3cNawJpV5b4Ob8_@997da2bbb901>
 <20250102171007.1c41355a@gandalf.local.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250102171007.1c41355a@gandalf.local.home>
X-ClientProxiedBy: SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|CH0PR11MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 328bf46e-4306-4b1d-2143-08dd2b8f1b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ChbyTWGGhvAOE773fAtKkcFOW5+dGquDvWTjr7pGK5im+0MZOw+RatTRh0Y+?=
 =?us-ascii?Q?6tbA7cs7jEHzjhzkLGxSFByP8kdrzxWd9s7qo4oVNCvAC1ThFALk83AVAvRV?=
 =?us-ascii?Q?vlTbzP2buucWD11tdOVwWZw0WTQlKMEWmj91VeImPxcdxAEwes/yTmgB7Z2a?=
 =?us-ascii?Q?cEwEkZ67NlA2Qpd277Vgm/QQmlczf0zcthse1etsfBIlU3lc58G/+wUaBcAT?=
 =?us-ascii?Q?C4z4Uu1uotTSVDKLacwTj6HOWxHkxd7WmNGJjmEhcbrFHfX/MKjxlvB3C2vb?=
 =?us-ascii?Q?jBOcmxl1h9eneNf8VWbmiUhSQo7m9mMkYd1OTBdw5Fj/9jBoXtzvnECov7OR?=
 =?us-ascii?Q?1yYBcbGeh0w3eA+/BSVfhw+nZj5lbWhbRT3sx/gIeAsUq/z8YXWd0qQ+1dpM?=
 =?us-ascii?Q?DtBDiBH9L1vWztIvsIQS8CMJeXlp4/dUt83oPHaggJWc2DxiZjZh07NHDsGm?=
 =?us-ascii?Q?iUF0ytLXmT70PRtjcefhCWcHnBP31/XrAPOF5CjNmoYYnP9idUM0WR9/nxzO?=
 =?us-ascii?Q?ytRnBnA/A223MginjGuCYEWs3ffMlYOwKzkp6zj+qGVP9a65UdzsMhkmN1aL?=
 =?us-ascii?Q?bVHw3UegI5fLHyo39C03Xs619I30I0CfktLE1gKnszizPfnpPhLWQe7VrYys?=
 =?us-ascii?Q?7O//0wnmIbTuwrxq+QnUiK4tTMBJBQSHuW78Jc3tSqNW9rp9r3EqgHfosSgY?=
 =?us-ascii?Q?thNSvN5n0HFAtfSr/G96b1xRQJyNuQgbMjaGX9DHf3PygIvOjLpqdVzpTyzj?=
 =?us-ascii?Q?HE5l75zRshYfkjitx/ZYT+xU1nljzn28pV1CRRy2XubvwTGGP3bcN7aDr5XL?=
 =?us-ascii?Q?bZP835Q+qKYjNxdfFCqqpC3wB8YgSasdyP0uKGBfVAp6frfy47QCw752xjW5?=
 =?us-ascii?Q?SN0Ph8pJMnWmOPwkO5jcBeVsHkpeb3yBiEmuing+22hoWOafjDyQJmdgMD37?=
 =?us-ascii?Q?rkZd49+fXqwvEpjk2T0JBxE0maCNkyiYpKhJrLOGQQQfJuPtR9kJeCscNvEF?=
 =?us-ascii?Q?Vjos6yrwQJRveu7qoH6v6odPDDGJ9aC3pUKZSQxFpJmrgy3lXDQ2fSPwtWMA?=
 =?us-ascii?Q?PxaXs+Vaph1EbSg2L2uZTsc6lppkB3h0P4c2npYsJk4nnGHkhsMLWlSHARee?=
 =?us-ascii?Q?MX2+gkCKg5yp/R80+7eKZ4jDv0r2RCkJpU5przP/DKD/z86GqTS/ULVs0WC+?=
 =?us-ascii?Q?rlc4585ejIP3VElipRwPp1MA3mKgc8h287L2/mEVT3hfC4v7TNrQSGk+QU9f?=
 =?us-ascii?Q?ERexDOXcvSWApXXH/LhnkTJ86kVeDulITtXQZk34enaiq53M/ZrEfZ5czedt?=
 =?us-ascii?Q?YDmE+fxgiKsl870Ko9VEhVKzpf15ci5CMvcSpeNGp2GVTA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SxGLHqgBdnZlq+nmx2v3uLpM0M1mwfIlM2Zamd8CNeAvO11dfCT3x9+AY5Sm?=
 =?us-ascii?Q?JqSU8iIq2qcRPlxYBNCDgBne9c9dgJxnPYJKSX110q2w1NJwWeTZDKMtw7lW?=
 =?us-ascii?Q?mVifKaBFqJKC7FPGPvAgyzn9HqjjqeowUL4cdeNMdbE+H91s+QxHbOJEZr7l?=
 =?us-ascii?Q?1a3fhrQuhQkjcRWfVnwVrgZ7CsuoOs5YHQ8uRa6MYOD4wLf4y9OWQkyrF796?=
 =?us-ascii?Q?Y7GBU6ntGdjknVqVxbyseFZG1GlSTgBnCn+Qp7nBMzI0gyPRGkRsuBw8y01V?=
 =?us-ascii?Q?Qm3840rhzwnBmH3GAMZfQo91KOOY+LnOoLjdz3Q9XigpixOc/G8d/B3CWosm?=
 =?us-ascii?Q?woFc6wd4MORiC+vDwiHOOpMfXPFvB1/fSTZOPQ1QvLV0gR3LuzXYt+D+oAEs?=
 =?us-ascii?Q?IeKKIbw0ZTNXYawOCLC+TJkO+EXOTr5Wxf0edoqoZSvd5MBnQg8qSsi6LMAj?=
 =?us-ascii?Q?GxXbWQfvYhEZ9aUneI2HqrrRSP7fUiTplIb5UHxjfAqaOIUWeBhE7SUrxHdG?=
 =?us-ascii?Q?ZXzx5lBdrG3cymqq7h0gaB6JEKxOEkeG+MWdRkO3Fz/J8rcbzc1T34fOvZUe?=
 =?us-ascii?Q?IWlgF/edkEEAZCSIpv+Z3tvHN0j5vEH00WNaJ3Ng4xNUZvcZPbWQqVZ0TO+r?=
 =?us-ascii?Q?2wOgGZOUPIz2V+LvyuFbUN6Ig8RbWRR3uVMTD21XHBxN/ccmuHvsIN8T45u+?=
 =?us-ascii?Q?BnR3f275bEnYmETIlQ769zZl0yXms0//5YNVVU7wDFhzl7x4M3Lnr5TFR6CF?=
 =?us-ascii?Q?hUbcdKOn/GVlV06SG5j8xjzeE8XB9rDXX96DrGUzI/1j+Th32+vmUlLZqFZO?=
 =?us-ascii?Q?27Yr6jVgcvksn/9MBy5lOZLB4xaRuMV6rvaArmr1NAqWU7U9qkhNUJLG0fad?=
 =?us-ascii?Q?en9B1BvrkQB+f0JHa9Inkb69SQs0//7yAzPs8uSrRcsOGR0gsU+fV2YQI29W?=
 =?us-ascii?Q?GyGtgfsil/RMvGa8ybabTiajlvEX0LkUOpwMhdEHqwHHNhjbhlIOxke6+9Gj?=
 =?us-ascii?Q?WNgycT26NHvGp6wjTe1W3X4M6tXRpalesJAq2hryPZkw6KZ4YM131FWSErWD?=
 =?us-ascii?Q?nMt4JJ5IoMGtMycUNoLd/27D15qjhAnGsdLaaniDuUn5OXt5Uu3JaJmVaoi+?=
 =?us-ascii?Q?wBEIacUWuSaaO8TzisHOcGTdoq2804sXaeVmZ44oWFXCwC7MUMZ+gKstXWG3?=
 =?us-ascii?Q?3X0yrud/h0SlKuMzAkPtBPsBjEtGR6R0uZoxX6vJEkSqAal4LqjRaUUXRYp4?=
 =?us-ascii?Q?yFbsiriDv2eNHbQ+oC3YhMT99NAO0ld9/FDfEECOmJ/7YGu8UXGK81UdjIzO?=
 =?us-ascii?Q?tzbFED09i0xmqoRg23vk86/D+9GzL3Sn8vGQ+I2yxPGO5cROZkQWNd3miLv2?=
 =?us-ascii?Q?7slGsifnXapELadiHzHwzhWU9ynQ3JxWBK1BVW5F9Tok7KNf8jQ5YkNBhsDf?=
 =?us-ascii?Q?ZVT4TyrSO7cgNzKcq8rK4kOKM9OeGJIwNN9GIWU3MxzmpfDT3r0QKfxKarK4?=
 =?us-ascii?Q?pauqct9/kYs9niv/FSRnArMqAilbcp7forP5LbYs4KgUg3y73SQEr+1GLeim?=
 =?us-ascii?Q?t8Yp5PivHlrtHf9eu/NM5k/EDx9+ZyasXkcXAQHc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 328bf46e-4306-4b1d-2143-08dd2b8f1b34
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 00:39:39.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oggSB1lW0ARO4XVLvtyMQCrlKqAjbP3u9OXeYaJ4JhuAjtyp1qUShotq9ynxGScE4zJipKqfSUVlldls2FufgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5316
X-OriginatorOrg: intel.com

On Thu, Jan 02, 2025 at 05:10:07PM -0500, Steven Rostedt wrote:
> On Fri, 3 Jan 2025 06:04:27 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > Hi,
> > 
> > Thanks for your patch.
> > 
> > FYI: kernel test robot notices the stable kernel rule is not satisfied.
> > 
> > The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> > 
> > Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> > Subject: [for-linus][PATCH 1/2] fgraph: Add READ_ONCE() when accessing fgraph_array[]
> > Link: https://lore.kernel.org/stable/20250102220309.941099662%40goodmis.org
> > 
> 
> I noticed that it has "Cc:stable@vger.kernel.org". I guess it needs a space
> before "stable"?

Hi Steve, yes, the check logic expects there's a space before stable.

> 
> -- Steve
> 

