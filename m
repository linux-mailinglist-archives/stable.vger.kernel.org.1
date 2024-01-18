Return-Path: <stable+bounces-12191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1311831BD1
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 15:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A1B5B21136
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 14:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680D61DA2C;
	Thu, 18 Jan 2024 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJbIoHMf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039E28DA1
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589549; cv=fail; b=WNeZKsjk22uWjIJM/JEE4VsJI7W0z1cRGNOoj85y5Bt0uuurtOJZrZg+jXEDxAaeatMgJ/DCBk7a/SNToBZJrSOHyGijaplDoXrXRjrt3vkuMvPdAFVNBp0fpeMkAqqTy0Ny0pffJGNZAwymtt50ScG+75TQBMB6yTdWDd6JfW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589549; c=relaxed/simple;
	bh=G9cr6OtwlGC8pzq3diMgdX43t6POYlkpB73mrg/S1x8=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=JVNETerjsLTk8wN9lVGijw/dKDgUcfUAqLJRZA+dd89Agk9ecx2kQZnV+49x663o1nhevRL9UnAZ/xTYJXZz2tKBC+Ytk2P9MMQfxYma/nvU0V2NWNHb1xVUFWHikLLFttFacFT571hGMy/l/hEULH4ThH7EPZEc+ZMgQhZfO68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJbIoHMf; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705589548; x=1737125548;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G9cr6OtwlGC8pzq3diMgdX43t6POYlkpB73mrg/S1x8=;
  b=aJbIoHMfTCtvGK3BsWmZEJBRr7Lj0OP8laamGN9qNc98EiWFjO+w5jEq
   4l+cQiTbrslU1YAnixlP2Gd1ipRTVIwK4HARR57z7w/1ZEgcDfvWlOYDI
   t1cH3LqXXDthVeLzhtpn9lnJvwrGZ7QJ/QtHb6ZZGu8k9x1OIoP4yAaC8
   dB5P1SnZHwYfea3nC2XgPZjJgyZt+olFctLDsbgJqj8iYSB0hxFkX/LoX
   iXMxtgjRZPEUmwkMnkW7/cRDr2GfAbkVU4ZbsxdnMlUj3JMr+QR1sfjVE
   Ox+t+WoFv4Sa3bRZ5TYgTN/4n/3RbVtW3X7yU8ByfBR0WsuD/GEf+OIMd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="369140"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="369140"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 06:52:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="957840373"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="957840373"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 06:52:26 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 06:52:25 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 06:52:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 06:52:25 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 06:52:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d31juHU7XEOjhO6y7iCkk2beiOyT9awIjW8OhV2P0cKQUuyhcTir2CvECbXkD3FcC+E/+7/oB+0okSrI0NpeeREDPjXKEiejbAlwd/3iZg57uCTa53jtkawgIxfFm67b34/24dKDgvYUTqjD2gxKFRTCSwhD9rgObNKawTXLNaKe3f/LDrqmbiQVv8v4pimfZonm/ow6zHE1u2eANbcp4O6dFlAR064yDN/awB+h4odc3gdF39Ar7yjHlWfnzChXqXTUxQj3oCWZO2yqZSraJhl0nrnLbwDL7R25jFi1wEX1QEHFBeZrEmWGBl79kLErDzcEDugBm1otYn67eoajpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFRPzRgo5CkNh+0hcS2nSFrm03js96Gnm325TBQFnT4=;
 b=XzzBkfInZje3Zq6U4Lnb5KAy4S0PrR1WjkVVY5Jt1g/TYgGdZucnfiVf9uwbJc6/x2Qk40sg327tMWB3J5yhAOBYSqohTU97ZGnBJJY6iCUcGsuwkPQY5Iyamm0p2MDBcV5RVmSr/xCNvpNidtiX1iQVUzJZssQ1nv5eKN5+FRKt8RWr6y7RUHaVuZ6nscl6KpLJIEUOxj6Z7ZFrZAY6QHB5mT32YgKr8w1zN3OaH4j7ed4+1h0zxFu19VIzIHIyuE0i77t9EwAfYZ34qGoUAiZs9/JvVZGVtdBpHB8BHxqH0xrEjuMOBssxEqUcFVdmFjTNEQAq5Yae7ZqZzSnqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DS0PR11MB6445.namprd11.prod.outlook.com (2603:10b6:8:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 14:52:23 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::b99c:f603:f176:aca%5]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 14:52:22 +0000
Date: Thu, 18 Jan 2024 22:45:33 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: kernel test robot <lkp@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	<stable@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCHv2 stable 6.1 1/2] btf, scripts: Exclude Rust CUs with
 pahole
Message-ID: <Zak5jaQDxxgVLnHj@yujie-X299>
References: <20240117133520.733288-2-jolsa@kernel.org>
 <ZafYCmLzkWeqI6sF@fc6e15c3a4e0>
 <2024011746-aloha-ripcord-8dd7@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024011746-aloha-ripcord-8dd7@gregkh>
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DS0PR11MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 355ab2b4-c12b-4d2a-f8e6-08dc183513e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpuoP6pQ117odnTcfniVAZe48DLAccr2jAoXUWlNrC9w+TthdUGHMgBkz/EhwqN9Uroa0fdsvuZuKXvjvgr4dqV2za20Md41pRaE5i4qZxUuLuHjRy4k+Jb3d54emETREyAdiJY2y5Fdqj1OxaDK8HpZrKBfYddFJ8bCwpl0+jiSlcIeAgBWBClAQwoRwHUVyHEWemZMxtWw4hrnujCsZLntsKQb7HkwS7fAzYO2T0w4z+On7gpSbRqGsP+nNqhRMwfthgxuLD7Smmnbmi02eg044sLoQ5+V1P+rArB9ztXW4uK4jbMBe7IL+V087gv5AmioXMmpWA/zIBdrySJmP5yYqqdlxhajKQv3qr32NZ6Lxnlsh/nTCixq0/oMxcEjjscQlWSmQ0DDPzOJ0xKoMiK1q6V578Yyh0l+owjeRazojGibG38k4KBck7fyQpny7k0wI+dJjV3k6QtD9/0+k21SlPiOD/Jf1tiAuKJqbH3tg/HDIgMhy8rP2BpGXxoOBlg/uEK2LvOcjS1LszY9CjfkSFqX6obZIIM5YckxlRJBdBPaBwtlOTlb+4VuRhLQM6X5L4ETRitQ1A4FMzsn8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(396003)(376002)(39860400002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(86362001)(8936002)(66556008)(54906003)(6916009)(66476007)(66946007)(82960400001)(5660300002)(4744005)(2906002)(316002)(966005)(6506007)(6486002)(4326008)(44832011)(8676002)(38100700002)(83380400001)(41300700001)(26005)(33716001)(6512007)(9686003)(6666004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WQt32WtLUoT/dFOYhcH31yZlGM18LzRKExtaJscOKnS7cCiHDQgDAPiyEicT?=
 =?us-ascii?Q?m942SKXpwXZ1CxlD/m4Pk89+eoWvzrbfb2XmM2YxSJ/vBorydr9D7Q7kg2Ha?=
 =?us-ascii?Q?5VCjaRKI/9HUPHwUn9PQIv77pVipgOZgW93ez3yoqWZmtViHRE9mkJhYYxGn?=
 =?us-ascii?Q?6yczGTXSJ/cEwr/j06rKxjD2/uqpiCAW/5ELhECqIuZrD4UxIPCZ/gDLXR56?=
 =?us-ascii?Q?2jYTOy1Q/VPi6l1n0xeEwTkGOn1SGtakJ6k4lagjPJPvLDJQ0j/hiNqS8Y5l?=
 =?us-ascii?Q?6MeqxK7HJ122t7im1YWJ2f+B2Wab+L00Fs31gsQsDtp9Vhlb51BGd9Mi5GCy?=
 =?us-ascii?Q?1dvt43CZ4BotLHJHQi6MZJbEQ1wdT3j+w2tL8i8nKKVAk8wv7/y5zs8F9ET1?=
 =?us-ascii?Q?8RjftKATjjiykft4XelH/h5Z4TBb1FzNuy0mBRWDglT3fnUaUgQVlGeTOpDz?=
 =?us-ascii?Q?TU6lg0lrK/3zI0oK6OIhQGs4eHHRZg/eBuznbLcgeINNEukDzbvpsLvuXReF?=
 =?us-ascii?Q?AAmhY3ecmwNGbjLcUeIdeGnPIcCJNm4kHsiyvUryK4GiFH4Uf19Bp3UK//X/?=
 =?us-ascii?Q?L9akKuVM7cyJHNjU+80lF+uVbGf/j9AfOO9BbJJDqts86tuvO5ylsEaX5ieQ?=
 =?us-ascii?Q?JLgKMcv0WkTvOWc98hWW69SKilWg+F9CzMgAUYY9yMesldwfvvMMOUetp3y/?=
 =?us-ascii?Q?zzSOKR8noDiMTffrL5Ypar++Ro+WCqFgGdllynOWLCvan29n/bkvNesNgUxJ?=
 =?us-ascii?Q?NRlAK0r1jhp4EsTJvoGU+Wzh0OfrjbPTlBfW284A9V3C7GLiFFOOzw1wC3UB?=
 =?us-ascii?Q?nMNuspk3olHptrgCJiNbp1vAt3v8dOVHm+N6Z3NB3RloAzUXrVFJO1mJoen1?=
 =?us-ascii?Q?G0xu0Ep9zCsj7WLkxREJWzDJHIlxiJxD8fzJmcrBFcIbI/fx0xKlIq/swvHU?=
 =?us-ascii?Q?ubF6xNaCZjD+AW0ezEwW0iHJCXSaTgqezY/r+3yUfAmVNrcEOlXohb4teY+G?=
 =?us-ascii?Q?BFneGr00hA3DsqNoDhsOIyPb7hdAKCmg1uXFKEsjTzD4G46WwNPX/mlEcD6y?=
 =?us-ascii?Q?w95RyG99egP2RmGhyhE6yBWeJgRVzYVUBvs6DlnWOiwPYoROil8WHTLHgS7F?=
 =?us-ascii?Q?dSCqpGsikBNVaSSQZ3koSOQN8tTC5/Q9QYV3wtn6knmbI5tgacPrOzh0bHxu?=
 =?us-ascii?Q?UKGwvEfHtgyofcXGDRdpYR3OcfHFzAjoxjxY00BlZPPalNrPcC5hXbJ+mnbt?=
 =?us-ascii?Q?1vVBnLCmsc//ELZo17XrnxwxcRX6isJqn/953bnubXvCluRqQb5YkgOMMTC2?=
 =?us-ascii?Q?FEnZpHJNFQkHnSxccWOs9SSy36BLOtlxl/o7zuKstAfMP7mOqp5bQlKpq2D+?=
 =?us-ascii?Q?P5V5EuY+bjYH3Z8QFFUVhLbVeVPueCPWyRinc4ysh+wbHD8AnvCrn4nVjCN+?=
 =?us-ascii?Q?y41jRwEK1QKRA4yffA+x5sGcEOOinFmqYbwdb3iMTykxo+GtQ8TKypQaRWTb?=
 =?us-ascii?Q?sDP0W26Bwn8Mm0aNfPXjxh7kmvEGy7FcebpFWP6cDooewefLdD60wEER2SZp?=
 =?us-ascii?Q?xD3wlL2hGtwa4NYImZ7C1o+uAlF60QTz69xLGZTQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 355ab2b4-c12b-4d2a-f8e6-08dc183513e3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:52:22.7844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pO5Di8qf2wmB9c0mlhdNtS2nRwlRbMD1LKMJJA6whMDJ/8Qn597OxCUN6vhAuehgDQCw16/J20uQ3ZrWiGVS+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6445
X-OriginatorOrg: intel.com

On Wed, Jan 17, 2024 at 05:07:55PM +0100, Greg KH wrote:
> On Wed, Jan 17, 2024 at 09:37:14PM +0800, kernel test robot wrote:
> > Hi,
> > 
> > Thanks for your patch.
> > 
> > FYI: kernel test robot notices the stable kernel rule is not satisfied.
> > 
> > The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> > 
> > Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> > Subject: [PATCHv2 stable 6.1 1/2] btf, scripts: Exclude Rust CUs with pahole
> > Link: https://lore.kernel.org/stable/20240117133520.733288-2-jolsa%40kernel.org
> 
> False positive :(

Sorry for the false positive. The bot wrongly parsed the patch prefix.
We've fixed the bug now.

