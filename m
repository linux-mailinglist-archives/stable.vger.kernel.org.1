Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECE070D38B
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 08:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjEWGDt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 02:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjEWGDs (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 02:03:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150AC109
        for <stable@vger.kernel.org>; Mon, 22 May 2023 23:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684821827; x=1716357827;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+Ly5Ux0JrXI/yBweE67GAQXPzX4RQTd77U5TskDj960=;
  b=diMVFkP2UGVD8A8+I6VQNnvknQDLKfo0Y5PjQqE8e5K9zyhSo+2krKcE
   DPoOtXGqb7ddVcaRmrynsednlC5rSbkL11CVT4Aso3aLwWkgyv+MZVdt8
   F9VR1DhHgKskrD5TVXeJ5PTwRttxwl1V+/PudPMn3G/VMSePuuZNb6Xug
   ynXurTjnZlE9gmQwNqV+659Wp12q5x0kkNk31WdXt+82DeoBGMMFr7KjR
   7Qt214UBY/XmpQzerPe0gQiSmoQC+l9tWLdPOAZg+R9Sf0qb+qSGaUxpJ
   q58r3jY2mjF5rOIKzt34mtA1atW0erRYCH52h0Za14mvJeT2g21lAWNSV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="350649023"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="350649023"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 23:03:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="768852815"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="768852815"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2023 23:03:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 23:03:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 23:03:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 23:03:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 23:03:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1a+UJ4lCepfDJbLi78P+dz8lrfVv47YdNdvToDU8wTTtOefQcjlsPXsck3eIdTWj2yXGf1zrjBJFDsWg+SDEFp/93J6aSXjJdHupp8WCpjWFp6tIorIiu+vXVQ5O+pVDPTCtpVhZFiA0ZzUauP/liUT6t9dmfFrWoUU5H1/SsWxVxnPoz55uafZRHnlkKCZUEz6DY9Veh65DtV6zipEq777OGsXAAG8lNPRndaTLShV0EAYUTyV5FOTYsoUJ4o2+emuaiMQTdZTwlnVUK5XD62P8AT2hRJ1VV5BNloVZo/jd17yAFovj5s9Kv61O+qvclbIxgJEKZIxwFPTmeZi/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nnAuh5OYJo/eyR99d94RiSXv6C5dUHHSo3Q1oi/dDg=;
 b=I24Z0C9JAU5d+LeAL7IlB9AgX/nbCFFtiF0Fx9NuCOe7pzadLYcJhkKx1/d4+tnjwp29dtQdi3xFlQj9nPibaCyazxpvgmK8D6MT8wKHRjIQJCa1Z/8you1OX7PKoBl0QFvBwKkPwkG7bo2dg7/L1u2jriBrx24GFpADy7yel92jNcFa8DWw1WEGXPV1DI5X4GshCZfacIz/Pn0FHR3gJ/1Zq4Dz97F6jm34m363xnbFEm/hMp7pyzjXp9/PHh5ubUNFokhmxXOgC9/Abiac+/y4zl1OLlrGXL3YeTEbYr1uD4qfC9EnFePxapDtJ/fUlfWYlbIPT2zuGDI7xYwmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 06:03:39 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2dbc:e5ec:2032:55b5]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2dbc:e5ec:2032:55b5%4]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 06:03:38 +0000
Date:   Tue, 23 May 2023 14:03:27 +0800
From:   Philip Li <philip.li@intel.com>
To:     "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Shih, Jude" <Jude.Shih@amd.com>, Yann Dirson <ydirson@free.fr>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH] amdgpu: fix some kernel-doc markup
Message-ID: <ZGxXL00oWbEQyIXP@rli9-mobl>
References: <20230522120413.2931343-1-stylon.wang@amd.com>
 <2023052255-rewrite-stingray-cd04@gregkh>
 <BN9PR12MB5145A7D7D53F2572A546039DFF409@BN9PR12MB5145.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR12MB5145A7D7D53F2572A546039DFF409@BN9PR12MB5145.namprd12.prod.outlook.com>
X-ClientProxiedBy: SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|MN0PR11MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e306ae-dcf1-46cd-8504-08db5b537364
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58nxdefYVfJz4HPJpQn5XFmZU1OFohGQ8x7ikIsVqgUrxfuyYOWVCwfuYkGQBRlpOnkfGyS8t4qTG8iuc9YGEw6TcrFPhH51CO49VyT/EcS44RPU5TV0ku0AH+nqZAZ0iU89hg+bccqGCJFc4X8/JXotPCqOpXSQCz5hue63gcGAY/DpjWRFx5g+d6W7iqRU2nLhwh/iLdAA0pyfCOcmbg7fj2LnRyeMbWCylqLMxfHG4ixuuOUI4DlyIhwYt156Eq0iy/njt6vr0b/9Y7A8n34tWmmaHoR8bcDfTbjYuHOEq+M4zm0qGZJfw7JWMPP4MD/69Q1/a9+nUg3sG3ge/fPOVUKuLEn9RI2rRXYWE6mPPhghQwQ4P/nLOszfOFcJA4kK7a15Liz3ScncNTIIf92iCIRxmvQLWAHnOYT38tMgGZsVK5BuNF4+2Tz9TU3vZs/mQM9nnMe9enQsIAVj/rApZwcy6MjosD6Q6ePy8UHl9OrveAzPZqr4O8k9fczUQUCIS0BqIgveYF/qjAWbSnotw7qy4YA8bRHAblSW3/30b5Svk4nwhsCR6Ts0WrL67gmg1+H6oIEwkcPX0V6atDiJsFGuqHzgg9MxwfYLre5lspJ6MZSz1Y+z07z47oU80f0qsO/ppBqDhx4jpwmtGL1yBYAdUdalYqXL038YVJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(186003)(53546011)(26005)(6512007)(82960400001)(6506007)(9686003)(38100700002)(2906002)(107886003)(44832011)(83380400001)(316002)(6666004)(86362001)(66946007)(66556008)(66476007)(4326008)(6916009)(966005)(41300700001)(6486002)(54906003)(478600001)(33716001)(8676002)(8936002)(5660300002)(15866825006)(41080700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cTMqSc9ZGxnUNvyuyaqQMjCrRA3co5sfloHvXJwMj6VfiL7gIhTavCU6ld1T?=
 =?us-ascii?Q?9e07OnJY1ncIbYADdlNd2DwAzpNxgJWumlvDVIvmc3GgTKGwMdGvHy0+rsf0?=
 =?us-ascii?Q?hWoFDi4ZTUDXD4Im//oUKkitERs5Lwkhb1AivKgNYS+kMAzSwBgcRVzHVAgQ?=
 =?us-ascii?Q?lIZEtRzqYl9DewO7A+6G+TlgPlKSJb13YCDTQvcrvxze1faChm8weErdYaUl?=
 =?us-ascii?Q?Kj9eS3ABDD0Mu6+aG5PtL75IT1GLuJ7fmSK3jThULjyRNwbgNGMVxGoeiQk4?=
 =?us-ascii?Q?6EB7AY5X9p2SRTSgmw2arLTuSPDSBg6quMD3ugHepXQ0YPQBzR6znmoBXhcW?=
 =?us-ascii?Q?/gKT+/rtkjiQ581koepz49j+WbNeaEI11Pz6tcvl4d4nSqVddmjFGWGS4oee?=
 =?us-ascii?Q?4LN/92B22VLs/4NlJXNERItUiYllXP9FMmtYk0bokNVeUJghVbM8r4lxFNTE?=
 =?us-ascii?Q?SoTp3iWnrYmNjcj+V3VFcyBKJyfZF0bf9P6L80SVobo6qREWc0QQgr+A3gtF?=
 =?us-ascii?Q?XyndqhYT7pS/9V6azsxbwpL+Kt0kL48Xv5Dxxfc4eES8DPG9omCMzxGgk124?=
 =?us-ascii?Q?bnuN6Uuah3UtW5HJ6CVJTMt+pxIq+T9EMSItYx1pw5lEpxZr45Tll5BuMqqZ?=
 =?us-ascii?Q?0CtvNrzJbyoDsAC1uu9VuLFW4NEstRjUMdTRqE10ncap1cD9etIpwkSXMyHC?=
 =?us-ascii?Q?fwX2LFVbfrHQuFGvGlhBBTHvx/HNeqi0lAXONs4omIvxxSdfWOB6ldjWqLDn?=
 =?us-ascii?Q?smF5Q16y2jpg3hksW0gkEANACyyXvgho+kQ4yWx+7UI1OeJ92sgaFyXFMPLK?=
 =?us-ascii?Q?Dct+Oiuq0e3ExND3vpG0p7v1TvQf3psDZ8RwjLTmqBlcn9F8uDh9fRVGT3Qn?=
 =?us-ascii?Q?r6e6+W1FPVEBK/T0mPJiBWNAGHoa/HCM+UjBUdDzYDpcCBkNgXyEmFhTh/6s?=
 =?us-ascii?Q?zp+ufsD8SLBxmebhLuxTr8ta59iVAaZN9s6D1svTFHjmBpEVetv02TFoRIwo?=
 =?us-ascii?Q?TSYdlj6xUganH42fxAMDhaDfKgkWM4hgdqrIwarNEvz8I+jvBVpx8OUVv/jP?=
 =?us-ascii?Q?uhkk+vtCvzOCYkIwwkMMNCizPa8bEvJsrBscRz4OYYT5gCmqqjmvOnnWKEIb?=
 =?us-ascii?Q?NiT30zsfhtGUXKBkWtLE9i2BsY4zXP0usqa7fj7I6Xgwafdy4J0NA5QkgQKk?=
 =?us-ascii?Q?2ihpB1rtAoA63mJe29uJvM1Nb74In7yu9sUBt3DBx624QEHNydvPpMvM0Oum?=
 =?us-ascii?Q?/RS8FFwshzrpLJmf9iT9qF2HBsvDInO/V05bHRnD5eX5J0MDoht2Sv3smgb7?=
 =?us-ascii?Q?LmBMF/S4X8/fxebgLBsfv6cm1SVI1jK0io/JX2rHcvnUntZrffrSbcpqbNi5?=
 =?us-ascii?Q?zWZBp85YlxQfbSsb6gdCabW12l6jP+duHhoec4sgUDZqocnsQdwxBivqY0PY?=
 =?us-ascii?Q?iUGegMkmMMU1genZgvjGhhM9pJBf8vEaineI3agzsAMZjT3CgjTma50AJDKK?=
 =?us-ascii?Q?k2OHMwvGRanpF23aC7RoPXMuvV6foVLFEfY6wLxuWEMFizM9uL0Xo0r3oIqV?=
 =?us-ascii?Q?VX2N9ionq8zPyU9c3lW+zuT7gRmPAl2lmaTwRV75?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e306ae-dcf1-46cd-8504-08db5b537364
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 06:03:38.2060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGQLMBh5iREE7beJpuW4mnAG5LejfiOj2Ksp/zcUZJmXPEMG9lQ0R7rMrqawcmU05TmCmH5vRNRAMrM5ANeRHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6304
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 23, 2023 at 05:02:02AM +0000, Wang, Chao-kai (Stylon) wrote:
> [AMD Official Use Only - General]
> 
> Hi Greg,
> 
> To be honest, this is just to fix a build error/warning from a Linux kernel performance test:
> https://lore.kernel.org/oe-kbuild-all/202302281017.9qcgLAZi-lkp@intel.com/

Sorry about the confusing report. We will stop the documentation test on linux-stable.git.

> 
> No real bug/fix involved.
> 
> 
> Regards
> 
> Stylon Wang
> 
> MTS Software Development Eng.  |  AMD
> Display Solution Team
> 
> O +(886) 2-3789-3667 ext. 23667  C +(886) 921-897-142
> 
> ----------------------------------------------------------------------------------------------------------------------------------
> 
> 6F, 3, YuanCyu St (NanKang Software Park) Taipei, Taiwan
> 
> Facebook<https://www.facebook.com/AMD> |  Twitter<https://twitter.com/AMD> |  amd.com<http://www.amd.com/>
> 
> 
> 
> ________________________________
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: May 23, 2023 2:41 AM
> To: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>
> Cc: stable@vger.kernel.org <stable@vger.kernel.org>; Shih, Jude <Jude.Shih@amd.com>; Yann Dirson <ydirson@free.fr>; Deucher, Alexander <Alexander.Deucher@amd.com>; kernel test robot <lkp@intel.com>
> Subject: Re: [PATCH] amdgpu: fix some kernel-doc markup
> 
> On Mon, May 22, 2023 at 08:04:13PM +0800, Stylon Wang wrote:
> > From: Yann Dirson <ydirson@free.fr>
> >
> > commit 03f2abb07e54b3e0da54c52a656d9765b7e141c5 upstream.
> >
> > Those are not today pulled by the sphinx doc, but better be ready.
> >
> > Two lines of the cherry-picked patch is removed because they are being
> > refactored away from this file:
> > drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> >
> > Signed-off-by: Yann Dirson <ydirson@free.fr>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/oe-kbuild-all/202302281017.9qcgLAZi-lkp@intel.com/
> > Cc: <stable@vger.kernel.org> # 5.15.x
> > (cherry picked from commit 03f2abb07e54b3e0da54c52a656d9765b7e141c5)
> 
> why is kernel doc issues stable material?  What real fix needs this?
> 
> thanks,
> 
> greg k-h
