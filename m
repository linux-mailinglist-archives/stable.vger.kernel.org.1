Return-Path: <stable+bounces-15785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ED783BDD2
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 10:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C711F33098
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 09:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C464C1BDC9;
	Thu, 25 Jan 2024 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lH7h6Bzb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3F01CA8B
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176087; cv=fail; b=YIinSGpvd8LklpMCHJZGT4hl+MaSfc2JQJmGwhchCVFuNF2fjjHkgz14awRdpMH9pkri2CAIOf/M118mOPg5C/qtR3qpZ7lRxL8/l9v3/69jkQAgDaGi49b1VhjwOhHcoJKb/vFLQ6a7VBn/JqyylARb21bpTerNFm50SXX9/nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176087; c=relaxed/simple;
	bh=8z6HvjTxY4GV8Wnw+Dc2l8OrC82Sv5Saf2nSmfMIah8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fFS0759Wcw1/SDaWaxTTXxgvD1CjqGbETZ25ZB7h6fOZdq3ohn8wVfk7aGDBZkr213IvrGBVlGat5UaXBaqEZdst+zKHb9av34+Fydjb2cIJyQBizPMOY9DdH/4Ftz8+ErbhB/c1sL8YGrAsAJIByBAXCnrRTWrkx57y/Wic1lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lH7h6Bzb; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706176086; x=1737712086;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8z6HvjTxY4GV8Wnw+Dc2l8OrC82Sv5Saf2nSmfMIah8=;
  b=lH7h6BzbqF2DcrZpWL76oIKNRiXzfyPr9MzNXhq9RWc3bCeZY33babqj
   WDxu+9Diiy9tnvpiHZt+gHfqNoDu297He5h1ZRMQVwyWtu3ounUJotcsM
   uDV11fsmqNoVAfD9yAWWjRl+ZF00SzS4VYTsKnpk2A3qz2OZ1TUWFP9wS
   5xBrv9WBkmaEA/irJPLdlibXA71yJHMzfvXvDv5ki9dcjsryP1/dA+F+W
   bARHCgWHsTVUtmVRWuHIDDGPZoU7BIQupQLAvw3b3U8QfdoB9RqCyedxt
   IZ/7PtfAIOhhc+9yJKq9Vox9ewRU60DezRV7IU0nXntefCGpqm63r31dO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="2006914"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2006914"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 01:48:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="35055206"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 01:48:06 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 01:48:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 01:48:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 01:48:04 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 01:48:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuYTpPHUrE4XB3bOK4ADhWrLckPi75c//5TjDc6rbmoCx78PqX8NZJIDhEJDlPvdZMORoCm2a9mSE1F5LPwROsJp/E4tCmsk8kR5+kuDc4jPIpJn1q2GLDp3Dm/OvsDj8vGLJ2aOJBkPlXilYgJ0X11x6GviFqYLFvmARa6CO3rB3yB4DDUCVdZGFDhbI/RHKPfiD3pH1yghh2R4pepIXec84y+aPenl6PTliMZKHjGoyYYe+Hg/JwIv/kOjYW1nW6JrgvGV+EPc/bpSsZd1xb9kEeKJ5N3swMGuDeK1/TQPiIs3dkjDyzzm94B0/G815hqEoyqgGarRV5Z9osBTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kN/DwHgftbnYrkL5BkGjZogbehzIheLXzjKQNq7R908=;
 b=Qc8CtdvxiZhU/uIhhvvdHgP/0M/MtpEq2KEDKK6MTfeB+moi5rJDV6GZGVMfgbWRiNiBKO43zNePgmINAIALRMyOgGL0L1WLPi/ZoueDtOvcGPgHigd6lytYeNDyKm6+RZZO/PnIg9QiIZF/Eto6wCb0srd8dJY2bEUg5S5sQttDvHEMD+NEwIaVXLyB6DNyMoXl0+PRTYv2rTrC4tG6m/ocsevm1ZBFEGnq8U1W48+7hu5SON3hNSR+C94tutZbbYQHM++L/A7oe9qW8XnKo7FFnIU0KUCKUWfVLrzChlbzd/6AV4TAluwG4+ivhs2oY5UljdMGiDOR0LOVKkDmzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DS0PR11MB7360.namprd11.prod.outlook.com (2603:10b6:8:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Thu, 25 Jan
 2024 09:48:02 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca%5]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 09:48:02 +0000
Date: Thu, 25 Jan 2024 17:41:15 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Greg KH <greg@kroah.com>
CC: kernel test robot <lkp@intel.com>, Mahmoud Adam <mngyadam@amazon.com>,
	<stable@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH 2/2] fs: move S_ISGID stripping into the vfs_*() helpers
Message-ID: <ZbIsu+c5cleZ1BpM@yujie-X299>
References: <20240124130025.2292-3-mngyadam@amazon.com>
 <ZbEKpvaVHrsXzISK@6c5a10f2f1e6>
 <2024012432-approach-expedited-bbfc@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024012432-approach-expedited-bbfc@gregkh>
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DS0PR11MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cdf509b-3e9f-4c8f-3c44-08dc1d8ab8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aoCsVspkR4x5bbRMZl4RsQOAibTPCGNCpWK/xiH/eV0A4Cxlm9+mSfs0kG59X3+CfvBtjQCTCojbFp1Xh6kWQGRCneT3ZgMZqkXkHvblTOciunjQlmOAiIWy0Iv8ouKH6ufySi877vgWD+tc/Dkp3fKPKUI21CIdzBWh1HtYcZERJtY4rwesvVD1dRO17sp2LFPKp7XovZ7piMvzFi4Vts99xtBgBLJF8hD7hQ63CZdcdhCfh53CrDnWNPP0UW4sxEqCco2NMV+7k895YG3OSI7L0yoNF/q5nXZ2BZgCj3rLYztGoQcQdIh+ZCX0Rsx2forvWt5KoBzbeAt+HOAHzy7jpFk0zzZeGsbIwQ10LBc8UufAlh75czfQxQkinsnCTSKbo8IOjpa3dzwgWzbNPNcspnT3Cg7Z5R9H97p7IfoX13RqSOisgGgsxDaBCwel1usDApFND3zdP8l/jI4uTkZQuAMlP7p6CxEQN/wppusbbRoUrNapwiKx8+LBsD1gf4Bx+zV6NDR5JJU0MRW9u0LuAevEHrIlcz4hCKQuEA5r9N82vZSZYVdB36CORUWEHecj5nYgkGgZJno0+VtnNtHqmnwXM27wBqdPJadMHVLhiqMx9lnwETiY4IymssE9UOwMrM+nbs6SgINLNlIGAQdmh8WhXdzCHoqD1hxhhQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(9686003)(478600001)(6512007)(38100700002)(26005)(33716001)(44832011)(6486002)(8676002)(5660300002)(4326008)(8936002)(6916009)(6506007)(316002)(966005)(66476007)(54906003)(6666004)(66946007)(66556008)(2906002)(41300700001)(86362001)(82960400001)(168613001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SiyU9ihQi5eM9GPlh2OF1WTPeNKLFVeCa4/amdvgaw/a09nhyfVv2pGBS+HI?=
 =?us-ascii?Q?BibLv/RsmPSMzQDG5wR8DyEO5bgqC8sS/wESKlpgSegPnpW6kSWT9IE2sCxf?=
 =?us-ascii?Q?9Pf8wowzQexhTSgMWVDOClwFPugQXtxf7yRaacTaB9qydmvECOaYLvy9A9MX?=
 =?us-ascii?Q?oVwspK+lK5sHrX9RAWll2wwb0pjZvNITcBuAafAhpV6l1J/a1dIz6RfRAw51?=
 =?us-ascii?Q?J2cprZHDmUEgqM80l80MeTpFLT2dnn3l+wLEIJSHLtQkKZPwt8hgrz+hj66f?=
 =?us-ascii?Q?hW476xu8rLuxEbrxEyWQFPBdaxbGxA/8QIuU5opQx1MYN3DZ7/1Fgrv7aDBF?=
 =?us-ascii?Q?IPZ22EcJDOfsojK0IZ30ilJrZM2fIHO2SDzix2lX+PKTPWxE81hC59IvOd3b?=
 =?us-ascii?Q?1RYCCG2DhFmApe64Uvh5a9sXzpNSZb52z4jwH0ptVC697BpapXnpXmG8sVK3?=
 =?us-ascii?Q?X8KLjzZdAqf3ro203Nuk5OvQUiWqc/wYx9T3n6Q/zL0a5C/lXX3IvE3WTBX5?=
 =?us-ascii?Q?mfc82tlGJrbLNzbdTgZlj8KsujWWY1J0dxsuy7Z21WEW1IHcw06CQRqG4lNl?=
 =?us-ascii?Q?uCexdeK1C+7wW4Q+PDa5FhC4Lqt61Dj83JaaHt9Q6SGpGX7nHCViYDmtTcs9?=
 =?us-ascii?Q?GxGo2oH/G7ETDP4nNSvHkzZfaela361Sx1Pufr1fiNlXja49IUHMlIFRFoIt?=
 =?us-ascii?Q?grABTi4S2UKqQFw/kAZI/iB1k0/SLCKE6J0Z5rq95dY6/R5PAbRHLW8wNToU?=
 =?us-ascii?Q?8+hoJQab63TeWtpupS7L/o5Q+1BtqVWcGGUJzF/sM+wYWmMfXa40QarTpQOY?=
 =?us-ascii?Q?ZbZOUIeVUY9wYqfIUA9qOuWaiWDalvtamxa3JvDmPPB8xDQs3V0qZEr0h51K?=
 =?us-ascii?Q?cJWBPnkG8N10HciImR/rpKq8lOOk9bEzODhWzT/lqW+lzzlJehcveuaFaDwB?=
 =?us-ascii?Q?JvZMF9868q8t7qrRuvcfCXlNbw9DELY3HVJrE9zXoxBvsAW97XTFwyBZp7pa?=
 =?us-ascii?Q?g0M1XbgFjKo/7d1v43ABoCYcZjeGoYYHTWC8jHZXXZfwQu4csD4uvUWNb8F8?=
 =?us-ascii?Q?EIaYcIMDMLRtMNDQHYpro9toOHlf9z/8U1poLXuwhc8O0PeCOB8PlpcGEv82?=
 =?us-ascii?Q?uzAJgs/tgmFgBFhW9P/eyxp4EjedVK23sinoqyld/Fr26A/iuQ6OxnAlrC0V?=
 =?us-ascii?Q?2oK0htV8iTDQjYQlo1d3JAm5A/kEJy0hhbUshaC5eLgj9rGTFI4bYHmOOH/4?=
 =?us-ascii?Q?eEMAWu5CqtaR5bi89cEa4OeUe66znWmUyb8iHjDuxX594U0o1VeSOyZ7sm96?=
 =?us-ascii?Q?IoAhje9Jxu2CnnObNWXEY0PSmXcJCD8xbXoRbFWNSixQgHAiM/7/XfVY32sK?=
 =?us-ascii?Q?cODTy3GgLKVyfQDJ55b0iE7RhCkpopNcLmhvuEPpqX8lgIkMpdbAUqUilptJ?=
 =?us-ascii?Q?X/1AiMFDxOg9bw0LS7zzBoY2vOJQWnHGQrATltUI/cfROKanAhPFxwuER+cL?=
 =?us-ascii?Q?dCY/CwL0hxJYXeApR+TIsxh9ugITjIxNNTOdl9L4oDciwChJ54y3dvjNFVoC?=
 =?us-ascii?Q?2cJOM0BD4dB8BFiKQjGo0f4dr3muYFk3+MCaihdn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdf509b-3e9f-4c8f-3c44-08dc1d8ab8c0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 09:48:02.3194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0J1SSPNetgbe+VDROV1GRqvlxEBb2bNJ6AU/VRogf7gmz13N8gseKgSoN7su23X94hatXKPKYTs+wKjr+lt9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7360
X-OriginatorOrg: intel.com

On Wed, Jan 24, 2024 at 05:50:39AM -0800, Greg KH wrote:
> On Wed, Jan 24, 2024 at 09:03:34PM +0800, kernel test robot wrote:
> > Hi,
> > 
> > Thanks for your patch.
> > 
> > FYI: kernel test robot notices the stable kernel rule is not satisfied.
> > 
> > The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> > 
> > Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> > Subject: [PATCH 2/2] fs: move S_ISGID stripping into the vfs_*() helpers
> > Link: https://lore.kernel.org/stable/20240124130025.2292-3-mngyadam%40amazon.com
> 
> False positive :(

Sorry for the false positive. The cover letter has a [PATCH 5.4] prefix
while the patch has a common [PATCH] prefix, so the bot was confused and
wrongly parsed the patchset. We have fix this issue now.

[PATCH 5.4 0/2] backport add and use mode_strip_sgid in vfs_*() helpers Mahmoud Adam
 ` [PATCH 1/2] fs: add mode_strip_sgid() helper Mahmoud Adam
 ` [PATCH 2/2] fs: move S_ISGID stripping into the vfs_*() helpers Mahmoud Adam

Best Regards,
Yujie


