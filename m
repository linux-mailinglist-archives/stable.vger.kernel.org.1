Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711747A2387
	for <lists+stable@lfdr.de>; Fri, 15 Sep 2023 18:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjIOQXy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 15 Sep 2023 12:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjIOQXj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 15 Sep 2023 12:23:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10D5AF;
        Fri, 15 Sep 2023 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694795012; x=1726331012;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cOJYlzWXWOXke3qRyBLCSV5295ef0kRxkOJh5OGD7zk=;
  b=TgCz09Ri2VfoNiqhdSJfOfTK9VpcqNEuWNhgCK0ubDfRD046EkLBvBAo
   FTt8xBY261qxyVdymoo74kr7R/iwJ4Mz6TRqG320n9sLNvG8a0rOf0k/7
   NsQweyJ/RgtPbf0m8egzjRw/2o8SWZM8MxVW4CXdnB7cdZ2wRYaZvArao
   FaXVjEgiU7RNUFOYBOI/TvO55zGaMdmY3Bja7SNzdSxVT/6OxkmWKnRaJ
   4kk3sfpq494cUuR+9nFvOGTTwSScP36wQ1tBhrad5J+tS0CTg5vF+cGjr
   1flfPtSwK0HA4KoBUFdFLTTG+tjwRXuePF6YKfRCQPuhgfYsFKCHwnVoe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="383112518"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="383112518"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="721743394"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="721743394"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 09:20:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 09:20:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 09:20:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 09:20:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbY7HgcRdO1/Z4oEHY+EN0AWoSdgbihqErN+uLjXiyR8pgWDzojkFKii3zpM9ujAD5OG5/aUJ+7tnOFHChKrBFSqHjAY2wyyLXULTHlqnd3ACW7USsgnn9V9Gmu/ZEN3lSMFkDGVulKwNKv7IxcxWx5pWi/6oUjbaWlSI48WXJagmYny7KsnpeT8nz+d0xQqJxRegu/7441R4I1EnbkHfxjDXjadV8aI/SOIeWdoETgch9l/1n1naU9eJVKpT0ECEuxWJOLfBuVf4nyVCgmnFjkiQ6u8AEB+h9a1lBFJ3bN5hyA9xAM2Sm0uWhdZxOtIpBgWwKsX2vPe5zJmETdbNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MSq7D3Hyt163Gsz3cN7O4hWC8wVElfZHSgFo6ZLKLk=;
 b=UwHav2f6b/9a/x+Il+tqSWzcpdLpDcYiZcWaoeUQqpylyLSts+3xS6+JXaWo01n1BshQN3AWS4i0K31xRA+kbTB8BWZcPfFKkh0fA24veiZBKqtHGeoU2XYR1OqKWLH9m/frkf2p4jHD2Krwioow4oNYxNGoWlZbag7K3TtU/kJ7GR19DyWPHcVxp6PNBozjJV64IC3+s4/zcSXtvi4wGo/LxkACHk1hLBTunPXD4copsqEOZScENtkA295aD/HTAasuZ2etJG6/EjZmduzJi1MYgkJaJeBo3uvNbbr7g2+aY7Y9RvByNUA+rF7l8cVGvfzAbuiWn9e+ZuqTukeWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS7PR11MB6173.namprd11.prod.outlook.com (2603:10b6:8:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 16:20:43 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 16:20:43 +0000
Message-ID: <b4b0cf83-c726-8e8d-5d6e-52136ca0755d@intel.com>
Date:   Fri, 15 Sep 2023 09:20:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] cxl/port: Fix cxl_test register enumeration regression
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <stable@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>
References: <169476525052.1013896.6235102957693675187.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <169476525052.1013896.6235102957693675187.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:254::20) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS7PR11MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: f4db27cf-d8ea-4ef6-afcd-08dbb607b5d4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJzX9VH+x6wqVQriaQCVL/rePjNr1zJ3b1yLOr3Hj9453P9fbnMdleR/WjUamirsVQFS3xf0JWku7QMsbsucD1tB7NN19LkGIb77WirbFQ2P5UHfRqybRgqWJdzdujzXQl8mvOt59J/V3tdLSLl14x7aEOqZBcxDWYgMu73qqhdPrShMrzkvUkwCoGcXl8RjqtPijEJRW5NlMQcKA0SNRLM5HQoTTAxOCiXftanjMyj7s3dO7eGwSdvYpDbk+AfTnMiFNLIOz9fn7u2J7nXmuoUQ6EO2+9MuRlvOQS+NAfJBqUHw5CymHQCnkXvXwA83H+HyRUc7zQMILlntb5qWTcxyVpEShRPi8LgICjz9LzLD9UrFTNQxEJ8fuE3LovP8QEcIp4747YrmEmEH4BnmksR+vRPeSFkBs7WwNHQqsWsAvffRmllKxw9mYoSa1FuMLufNiKEQmrvF3lBCRDg0DLxSyf4zSgrSCSFJ3GGALEMctwzW73qVmr5IW2Ffgg4rviKlUOWGpUuoa71eWSoZ8l+Rt6sbwaU3Fniju6+Nmav8vLeJ8Lzxn96tlh4G4mHDlv5Wx62zoA6G/iEKb4Fo2zQ58KoD8Cuug9WdGUWsc/lAVpnrvHim+s+Efpy+xyHcx3orTgpfHXv8TDr301e4tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(1800799009)(186009)(451199024)(450100002)(8676002)(8936002)(4326008)(44832011)(5660300002)(316002)(41300700001)(66476007)(31686004)(66556008)(66946007)(82960400001)(83380400001)(38100700002)(53546011)(86362001)(6512007)(31696002)(2616005)(26005)(107886003)(2906002)(36756003)(478600001)(6506007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU85djFXaUlhV2RKWTZNTzU2RjQ2NWlEazFseDRtZHI5OTN6Tjh5dTdTWmdS?=
 =?utf-8?B?Y0pzVlRUSzB1OUVubVFrWTRJYktGV0pmRXRwSWxhc2k1dTFubE1OajdKcFZU?=
 =?utf-8?B?ZkdMUnVKa243WXlaTk9uYjFSVDVlSURxVStMd3BCTDcybEVicXBFNGdHSlZG?=
 =?utf-8?B?ZXNzbHJpS3ROL2lPaHVVdzRhVkVSMTVWWTBWOHNCc29JcEd2dUZ3eXFqWFBN?=
 =?utf-8?B?bFNFQTBnOXNiZ2JxUmw1NHU4MVR3R0N2MkF0WjRVdHVMUlBlOUIyRVZoQm1t?=
 =?utf-8?B?eVRuWm1mbE8yaXRvSnhlbU5xTGw2eno2RnMwNm5Ha0FGSmZHeHJNQ1RlanVV?=
 =?utf-8?B?QXRqcHZkTEhmSHRqVlNmeFFFSmk4WktyZXpiQW42bVNzZnVqc1p3bDFUMTJk?=
 =?utf-8?B?cEs5Q2M5NkpaYjdWL1gwdU0wVmlHeFhzVUNLbDlNL2pTaEp0WExML3J3cVhD?=
 =?utf-8?B?bUswNDRNVXhNcjFZVEFUREpNdDUrMjRaS1kwUnV3YTg4Tm1VRW5oS0xCa0wv?=
 =?utf-8?B?WkdRSm1RUFFza2xmWTFSbi81WXdxNGx6OGxIa2Q4UWpjQ294L3JoTUNMb3Jp?=
 =?utf-8?B?TzlGbGxkaWNMMVZic1FCRXVXSEhLaHF2czBtcWZFclg0RUFsYit2NjZCZUd4?=
 =?utf-8?B?NTN3UktiV0E5TzNpcURzTkt0YldxSkJ2dUNkU3FlNnFCTWVRNGNQNEg1QVFT?=
 =?utf-8?B?NXlKK200OG5LUGdmZU1FSGVlV1dwcTNTbzFIZFRDc2JCUjVqTFN5bTZZY0Rx?=
 =?utf-8?B?dGE0WmM4MklZTk9XRG9JSlhjMjVVWGNrb2JNd2Q3ZGZHVUN3SHdoamN2TW9o?=
 =?utf-8?B?bE1Zb0M3S3hNenp3KzM2akFLT2NubWthelBPMDVrdG5SR1MzeWRCbk90Um1X?=
 =?utf-8?B?NlJ6bk5yUG5IVDVpZWlKb0htSzQvOGhsSWdNUk8zaWdIUkhnSkMvUEsrTmlv?=
 =?utf-8?B?NjFXNnJLNU5WL2JkUnI3YXNSbnVoSmF5UHNLeFRGUCtaZDJrV3pGNDd5MGFB?=
 =?utf-8?B?YTNvb1c1VndSbG5iaC9JbE5uRnh0L0NkMitYZk1SMWRVK3ltWUZCMlFHQVUy?=
 =?utf-8?B?RTZadU1ibkt5a21ydTBoOEcySCtNNXVKMUJDdk9tOTA4ZWF6WWpxVll6ZER6?=
 =?utf-8?B?cldER0IreWNmR2xBVmpRZUxmaXdDM3J6a1pTRVlyWHNmeEQ2bG9zY1lDa2ww?=
 =?utf-8?B?cCtjOURBYUU0bnc1UkphS1M3NUQxaXg1dkZyUE40TE1KaS8vSWRyQ09URldD?=
 =?utf-8?B?TlZNWktvUzFNem5xTlQ0dDYwbWM4ak1TSXA4MlFEenFjK0JzcnI0THJCb29N?=
 =?utf-8?B?cjFzdlhVeHlkaEFha2ZvbjJVVUJpZ1dyUDJKazJZaEpYdDZ1NG5OTnVVZFhR?=
 =?utf-8?B?bUdQRFBzVUVqdVUrWDBzSytSczBybTYwakQzY2p5MmdNWkFOYXJvMkIveEly?=
 =?utf-8?B?b0Z4ZTdyMlJBYm1wbVdFaXFLSjFNUEtGK2tUQ1NGS1JhKzQvckNJZURhNWdz?=
 =?utf-8?B?UHMrT1kwN1d3ZndLOVdjT2toOUVzb1JJbHpmNmdidmdIemtxWjRNdjdvZ29P?=
 =?utf-8?B?ejBVUTFUZDFJZCtaUmJadzJrT2ZHdDg2bnNUMTlZdUVIWVBYYURxcVZkVHhY?=
 =?utf-8?B?Wk96ZjRsV1pDUi9KRUNEN05RMCtJQ1VsK2I2YU8yTXBqVjZSMFlpWmJtaGFz?=
 =?utf-8?B?MUlzbUcyOHBncWR0V3dsWUVCRkc5dEFpcGtVRE5zeDdMN2xGQjQvTWJFZEtp?=
 =?utf-8?B?YjN4eTdkbmQ2RTlOencvTHRpbVppd2RuTVd3RmFBaTBLMmVQSlhsR2x1OENh?=
 =?utf-8?B?YTVzYzhQaG1RRjlJVitKcitjM0RqNXZ0RUF1amhVVWM5QUFFOFRGYVU0a1lL?=
 =?utf-8?B?bHFINWhpTi9YejBzMTR1RDF3MlduMkVUdXpQZkhaN2grN0UvclVtT1ZoSDkx?=
 =?utf-8?B?WjZIY1ZVNnBHUEV6eERpRlBBdnpPRVE4L01KME9EelNaS1oyRjNhM1BFUlc2?=
 =?utf-8?B?bkx5T1pENWdoNnJSSFpLWjc5eW90NjZMV0hQYzV3OXZLS1VCbWQ2cHVIcS9H?=
 =?utf-8?B?alAvcWZaWklHaUxPdDZUVzdWWXEwQVZsZ2JVYzEzQVFsZmR6czFyMlNpS21l?=
 =?utf-8?Q?8muU2Yj9aQjrgfXU73NyVS95X?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4db27cf-d8ea-4ef6-afcd-08dbb607b5d4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 16:20:43.7376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gMpHBC5AtUom1bwZ8G2LVgcJYqagJFi23R5j0zzcSkD4sleB2bDIW56UIArhKnBkS7fuunq/7rRJUBUkZqQfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6173
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 9/15/23 01:07, Dan Williams wrote:
> The cxl_test unit test environment models a CXL topology for
> sysfs/user-ABI regression testing. It uses interface mocking via the
> "--wrap=" linker option to redirect cxl_core routines that parse
> hardware registers with versions that just publish objects, like
> devm_cxl_enumerate_decoders().
> 
> Starting with:
> 
> Commit 19ab69a60e3b ("cxl/port: Store the port's Component Register mappings in struct cxl_port")
> 
> ...port register enumeration is moved into devm_cxl_add_port(). This
> conflicts with the "cxl_test avoids emulating registers stance" so
> either the port code needs to be refactored (too violent), or modified
> so that register enumeration is skipped on "fake" cxl_test ports
> (annoying, but straightforward).
> 
> This conflict has happened previously and the "check for platform
> device" workaround to avoid instrusive refactoring was deployed in those
> scenarios. In general, refactoring should only benefit production code,
> test code needs to remain minimally instrusive to the greatest extent
> possible.
> 
> This was missed previously because it may sometimes just cause warning
> messages to be emitted, but it can also cause test failures. The
> backport to -stable is only nice to have for clean cxl_test runs.
> 
> Fixes: 19ab69a60e3b ("cxl/port: Store the port's Component Register mappings in struct cxl_port")
> Cc: <stable@vger.kernel.org>
> Reported-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/port.c |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 724be8448eb4..7ca01a834e18 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <linux/platform_device.h>
>  #include <linux/memregion.h>
>  #include <linux/workqueue.h>
>  #include <linux/debugfs.h>
> @@ -706,16 +707,20 @@ static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
>  	return cxl_setup_regs(map);
>  }
>  
> -static inline int cxl_port_setup_regs(struct cxl_port *port,
> -				      resource_size_t component_reg_phys)
> +static int cxl_port_setup_regs(struct cxl_port *port,
> +			resource_size_t component_reg_phys)
>  {
> +	if (dev_is_platform(port->uport_dev))
> +		return 0;
>  	return cxl_setup_comp_regs(&port->dev, &port->comp_map,
>  				   component_reg_phys);
>  }
>  
> -static inline int cxl_dport_setup_regs(struct cxl_dport *dport,
> -				       resource_size_t component_reg_phys)
> +static int cxl_dport_setup_regs(struct cxl_dport *dport,
> +				resource_size_t component_reg_phys)
>  {
> +	if (dev_is_platform(dport->dport_dev))
> +		return 0;
>  	return cxl_setup_comp_regs(dport->dport_dev, &dport->comp_map,
>  				   component_reg_phys);
>  }
> 
