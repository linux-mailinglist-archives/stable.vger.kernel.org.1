Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40847CAED1
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 18:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjJPQSV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 12:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbjJPQRs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 12:17:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89D21703
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697473037; x=1729009037;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o6WV3XTYih4EcpsOPXWWNfUXp86Dc30pAG+93hq2YgY=;
  b=FkAsMlSrXr6Du+L27/dAZA7o/zGSjqhc3nnUuBumb+9ME2GEQmvxQ5Jm
   qyCDmty+2OWSSvXlBYhQ8Y5W3rOHoCbUn9yB2k2JG8dPhu8pTtGbtXVvn
   v8DYVOubUskqY9vxqnUSlwQrj0A0hPB76yLbrnSK3HAnRB/wg87D8kPj/
   SEpU3loNJY9yITRyDqoLK+waLbBUf7NaS5pq0qkKiS/AZjiwnHpwx80hT
   mAp57n0tVxc2aIWdX0et+4unJRTI5hJDrdyxOqbchInrod7z1iGNV3mwn
   8NSPMQtqJgnJ7bWYRKB6lWX6PH+46XhHrCOeTsiv5AjHG01kuFnXTfWlm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="384442510"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="384442510"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 09:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="790859202"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="790859202"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 09:13:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 09:13:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 09:13:43 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 09:13:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrcqG+hO8gYDj99/wMeQ5X35jnc2EC6Y1Xs7lkicvNgcLQURRNHY4cnGzkBm2I3aWf/4CAOqZE56iSs0CC7yu3FJ07ZIFCprK17nrg5rouNEfwt3/esLEbCBZ9yezK9X81ZN+usx5CWeOHywX4BV9EHxN1mmHyOhZac0qtH/xSh8dvGLCfJmv8V1CSPgVu1yTk1UPaTty0BLkmGoue19Xjl/KbmB+bGmubzqASLQNUnNcNpub72XRuCWxZpLgvOlC+2Hontp3arP4qTC9Gs9NJ0Eu/amqV8WIzUn7xUltGG5yqd8dGL1bQSdLmWmIo89DkAQMMwQpmZsASONyQHXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/65XfHGR+oyXhKJHIrkWGiB51pgFPrUgFDT5796esk=;
 b=OpJzcil0JdnqZr3SwkvoYAvcATYUBXLtf/KOi9aTdj4vHbCQssl2aBemUZ75slDUWzNtqDWRjgnKGL1mYWG9NpPOesoVmPK3QGh1ewSuLyqt+qXq3ST6BjOv0vF342ObkzTHXFHm6/JWOAg9ZFFKl5ca+2RXTwxLFN+n+0lMmxFt8uYlD+Z6rrBQbTsM/3yZfW6V8rH0WVtsIkoGpn1AVPDePyXSty77UUx3IqaaurEPui7mKVUv7OQ61/juP3RmHo18TR+mudNH04QRHLjqoUBRqBZtH68R6vF7C9p7eOWxbBeEY2kscoVHINRN7FRWclOcif9i85ug1xlClpkeuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by MW4PR11MB6569.namprd11.prod.outlook.com (2603:10b6:303:1e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Mon, 16 Oct
 2023 16:13:39 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::f345:2318:9a82:51b5]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::f345:2318:9a82:51b5%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 16:13:39 +0000
Date:   Mon, 16 Oct 2023 11:13:37 -0500
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     <fei.yang@intel.com>
CC:     <intel-xe@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [Intel-xe] [PATCH 1/1] x86/alternatives: Disable KASAN in
 apply_alternatives()
Message-ID: <iloqncuas4yjg67jcghlwvs2gffyv65pj4byku62dtnmmuweaq@6wuynkpkphvf>
References: <20231016154025.3358622-1-fei.yang@intel.com>
 <20231016154025.3358622-2-fei.yang@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20231016154025.3358622-2-fei.yang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|MW4PR11MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 3697d384-7fc6-4005-a373-08dbce62dbe0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAlIonJHI0WhmJyGmc7wpmiIoohDRkoo2O0ZKUSGdK5eU2Q9XNEdcgskQO/YHts5laLxa/xrzeGcQrHvcyy3iS1/YXoSpUfj6pB+uoCKORcvihr+4zDOsP/bw7sqCTpgEQ0pL/2Bs46s7t5Ogeot5YlppVGAkaYh1RXsT1me1KiWyz24q9C+DHbKu5HatRbKSW/X34A48RhXUYulMBwACtq0AuIsLhPuD99ctXyv9qnikDsDMK+oU2aP0L9648KwoZmoiwaPSZPYqWJw2mbx9h8KgC4KAPVM+3uX58qQaco41OjcQGBNNg59flcD9+YJYWCWIuLrii6ydz+abhlCQr5zyNmLC8eBrifBzaGHkCrXNz9ZrAjoaw9WtNB2Lr+ihAnc9KmVl/GO8QpgBpXP8V3sLC7+g2ROM0HAHcfxWbbGiOYn8ZQQbk1DBVEFVR5sxMfJ2lvM5Y08tJGogd7B/tEg5iq743fujqdWgUj/bLVN7CSK053M+9plraEo45B1FV7kLO8E3CRgnVGhypdsNKDWf9YT5ZkTgmMjQhEnO8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6486002)(966005)(6512007)(6636002)(66946007)(66476007)(478600001)(66556008)(54906003)(9686003)(6506007)(5660300002)(316002)(26005)(4326008)(33716001)(41300700001)(8936002)(34206002)(8676002)(2906002)(86362001)(38100700002)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R6hjhDVOTNb6ZtotTMwo19vGqJzyQcvOy2A/+0WdlijukUptLx3PS7KxOsxj?=
 =?us-ascii?Q?LKKH5lS4UrZIFesBsuYET3hhaDYaq4qAAFCQR2QsXxsiLV/2s51uh5Q+3oBk?=
 =?us-ascii?Q?rpJzT0zKNAotwPE38zpTFP2U0ez7D5bBvSNxRBeb1lSb1Mv0JZSLMsMUlJFe?=
 =?us-ascii?Q?I5oleaaQblCsh9a+s0t39ujTudM36TGajAa4kszZM1aI9qu66GQ60xMypZJS?=
 =?us-ascii?Q?kjjbEi4HL6LFRnbrzaERWGHn+yoTHd8XWQ6M8RQc9huayvBozGU9vW6stL74?=
 =?us-ascii?Q?hK/VHiOylkNdbiqoFAufgUmgsv4zwwoxnKm2Z4XCd8QjNTmRj89BO2+cCCHm?=
 =?us-ascii?Q?VN+sH/AyuzimNbb0ZPzwLQb2oEjl6U7DXkAW+Fe4HJs3MmPDM6/x8Quy+IbV?=
 =?us-ascii?Q?EDu8330wr+kkUaHugXK77KAutCLm+09g1jC5ZhOszN5KFTyzpM73hbysQm2b?=
 =?us-ascii?Q?JUB2exGQPG4QlC6GhnAtOUiaOUU4/uk+u6f5R+9uYbdF7xRZeBxxAWd2ezti?=
 =?us-ascii?Q?iUENqXXb+x0brEQVGTp7+vaYc/EtwdlBA/FJ9iuX72OJeUrQNCD/9nkxRx6I?=
 =?us-ascii?Q?iVEkE0pIpFtWjOgwjpbJ12LnN70njs0Jq/Y9s3sr3pU6XowciO2d6JcbFbZZ?=
 =?us-ascii?Q?FxFKGeExwkNVr/xbbdWXbq+9HLvNO6Flh0KcPPLJsUduMl8T5kCZ3FJIE4Vy?=
 =?us-ascii?Q?ABNOuqnwgIAj3FfrqhZK0dXoufY1HboeXVDNYAKvPhx1FvWRSfEjr78RegtO?=
 =?us-ascii?Q?Kjh89A308rt7vD9CWbM18aA/iovw2AjDV2AdcBCSnd3QNmgriC27z4ixoaZM?=
 =?us-ascii?Q?mzGyRSBDEE90+IJZ2VqVPK+hm2iP5TqCxQDEMRYCttKfJSB9MiO2qz5sJVw2?=
 =?us-ascii?Q?54PUM1ZgHUHqU6TQKnJ3SIePLM6KoQFOPbbSIOWks0aMnhL9wLItQwLsoRAS?=
 =?us-ascii?Q?GpjY+VODuXp9y8aANZMyy5WTV6moJNOs8auubrEWkLsT21+qCyg8/SCtk2Kw?=
 =?us-ascii?Q?1Z2XOOPIyol5UI0d2hexRTtE+/eqQ0QCqm0s4gR+FFGIcyUqz4gPArba3fwi?=
 =?us-ascii?Q?oMNHNwYpeRXANI3WSN5R+3+DIXsqMEyPZOW2qFVx53NUEL4ILkQxQNZlKMaK?=
 =?us-ascii?Q?rZuOdBr4dfZJY3xotwMo/xrqWZHXtWlQBp696rkiinwsQ5VQrZ/2PH2iOcfe?=
 =?us-ascii?Q?b0S+VqaMAJ05In+m1z8a6WLlLP83p0YanG+v7CZ2Qj3Zq3KhoMfdpBnc90MJ?=
 =?us-ascii?Q?T1AIi5rEZNsM6Jv4MIEZu0zxTYuuvSvzVynWItEMfvwwYMBh9E5KIVaAOB4o?=
 =?us-ascii?Q?JJT5Y2IPEnJ8BZnaZP/HZoJfL+s1i6N8Vzg2lGNZkZROlyOaldq9eso4uEsG?=
 =?us-ascii?Q?cAxErBEdYOBUHULdyX2CwAeOG5wQL90tAo2khoodSRuJazvhR7h2qivY4tN0?=
 =?us-ascii?Q?/EZnd1JAhw54DR5Vr95i/0k90gao5QME13oKlxjqCFUDlP07R8/yfnS41vDV?=
 =?us-ascii?Q?NKb1Y92gtrIjemEA7vC4ZhpuZa3/797d1Qzv2z+OblWDLlz4Zc2okpg5woYO?=
 =?us-ascii?Q?p4IRm0bHXXfedXaLPQuzI+IVAhQERzRHm4OpYzQl8SFVtpoqed6mAJF2Ohwo?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3697d384-7fc6-4005-a373-08dbce62dbe0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 16:13:39.5460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcHclOiUB0/6T2DTDwllt45oYvgu/MRXMsvSj8S38C8mRzVCfvEZKeAW2qUkpEvvHzGBcyhiZQK9/JNLP4TkoyKv/Mi+zuuMvc/KtEtoPQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6569
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 16, 2023 at 08:40:24AM -0700, fei.yang@intel.com wrote:
>From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
>Fei has reported that KASAN triggers during apply_alternatives() on
>a 5-level paging machine:
>
>	BUG: KASAN: out-of-bounds in rcu_is_watching()
>	Read of size 4 at addr ff110003ee6419a0 by task swapper/0/0
>	...
>	__asan_load4()
>	rcu_is_watching()
>	trace_hardirqs_on()
>	text_poke_early()
>	apply_alternatives()
>	...
>
>On machines with 5-level paging, cpu_feature_enabled(X86_FEATURE_LA57)
>gets patched. It includes KASAN code, where KASAN_SHADOW_START depends on
>__VIRTUAL_MASK_SHIFT, which is defined with cpu_feature_enabled().
>
>KASAN gets confused when apply_alternatives() patches the
>KASAN_SHADOW_START users. A test patch that makes KASAN_SHADOW_START
>static, by replacing __VIRTUAL_MASK_SHIFT with 56, works around the issue.
>
>Fix it for real by disabling KASAN while the kernel is patching alternatives.
>
>[ mingo: updated the changelog ]
>
>Fixes: 6657fca06e3f ("x86/mm: Allow to boot without LA57 if CONFIG_X86_5LEVEL=y")
>Reported-by: Fei Yang <fei.yang@intel.com>
>Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>Signed-off-by: Ingo Molnar <mingo@kernel.org>
>Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>Cc: Linus Torvalds <torvalds@linux-foundation.org>
>Cc: stable@vger.kernel.org
>Link: https://lore.kernel.org/r/20231012100424.1456-1-kirill.shutemov@linux.intel.com
>(cherry picked from commit d35652a5fc9944784f6f50a5c979518ff8dacf61)

Acked-by: Lucas De Marchi <lucas.demarchi@intel.com>

Lucas De Marchi
