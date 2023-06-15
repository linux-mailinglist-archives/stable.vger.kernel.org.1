Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CA47323BE
	for <lists+stable@lfdr.de>; Fri, 16 Jun 2023 01:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjFOXhW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 19:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239867AbjFOXhT (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Jun 2023 19:37:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C78E294E;
        Thu, 15 Jun 2023 16:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686872233; x=1718408233;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jRPcr5Ga2TrcU2KqjTjtehM6C5cEydpuPEtWLH1w6eU=;
  b=Q3uxfxRj/enO/HVtLVXjFtmNTvIS9wAHAOnf8gMmr3iVFlJ4FmVVNlz0
   NfX96PDSS5W6xip/9NVgFp7kZSF17gEEqBDKd8z8JZbKlAGJ+u1TfahoA
   qSu+4qdZTgLLgLNeylETe4hu+ERb3Y7mIPtvWgimNVLKcv94XzfyBhTx5
   HHLq5yPbZKSCbSoR261OY9GT8sTlqfxlWdXAHmuho30U0455JLa8WKnlH
   DXk5DhgT4TZu/koy0nUhI/dfcOu21Kut3mTs9TwBr/4u7lACNIcPeFXhA
   BCp07lLr0JJA4i0yDK82paYfpCkHd1aDBQVyOBKJopAhVrZoC07k4EPB1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="445449498"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="445449498"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 16:37:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802602420"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="802602420"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 16:37:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 16:37:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 16:37:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 16:37:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 16:37:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYVcGDojQGln5JQIvmoEyVL48AAYjPWHvnfI87kel5vqFDTqYG4DM6Gz3ed3JRNS177z6SZNyrruiSYKDZUkHj7TyasAbuv14R6aiLEWZq9V3Swb2facba41nDRRn3tAA8mO4Msn0V/K/Km3CrfqBKLKhDxTfQYMkSuucbyJmc8ZKMw1jMecNnKJzIWg2gczyeUHYXMfT/6hVk2HIU40EqQSNkaKsVcFDUp5GO57ycYHSva9hyiAqqqTZCGIKI95sJUJSUTXrnObuoJTPjHHhDCMChK84d71AuxvR3B4kFrI46cpo3p4yq5gy+FSxXTaDAvlaks4+Ciz/tOyDtrPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezM5hwBYXO5UZbRZYGvb7crRIf6AFRShRJaMEbWn+dw=;
 b=g6pw2wVarO1Gz4r9HIXk3drdRyvdR4OiI+7SD3SyqJIRa54lbNeLT2YV+73FQ6mVApR3IhgCnltehKV0aMfNsjdgBWpuQ3hSbRpkOSmNwnDX7jSkDqZYyWMtLsb2LIjHsYMXKOisOlwix0s45PLebhmhHYb88iWwQZk41Tx0m8eAaFH+2V7yJIcEOfFwXDNFh3hujr85wnuYLyT/o+CNzm+rcINajvJbX9wrggPmvacZ4YZwc5KA8oZzvI4gxT6GTmq4i6fVP4xjzKH+taw3IqOYR5uLVLDg4zXbCroAsLo6XNKie2LfU81gJ06WEFeZDxf+iB5CRaD17y30fnnhjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CO1PR11MB5156.namprd11.prod.outlook.com (2603:10b6:303:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 23:37:08 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 23:37:08 +0000
Message-ID: <76058d75-65c5-f5bf-eeb6-ff8585530af7@intel.com>
Date:   Thu, 15 Jun 2023 16:37:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH] Revert "cxl/port: Enable the HDM decoder capability for
 switch ports"
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <stable@vger.kernel.org>, <ira.weiny@intel.com>
References: <168685882012.3475336.16733084892658264991.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168685882012.3475336.16733084892658264991.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:a03:505::15) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CO1PR11MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 17275195-8cba-4e49-9802-08db6df96ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ry2/PUdss/uosRbivAx1RATYrVYZ8s0DU0SIYIu/rzjQ/StRN6swgirpAHU2Gs3Oz4A54gHiO6XPLcClfF69IcOVWr4NRSgOMxDUvEdxQlEwGlmlR77lEhbJSil5W1if/oi0XcCrIrGgOuBcdGlAo8nY59T/6FibELMKuHPntKFUgVFOPPMydiN2f4o3E4jwnA+5gwaI1xusTs2G5vSYGVRqEIB1zrTpMAz6YN9Ck6BKNXG90TY+cAjimyY16zf2yC9vBct9mj1steD37r+1+tiJDZr3WNlwERv1x1/PvWFBwnmoF1AqYJzmW2pBFGFKzsdaKQrOiAKUoJ849hp0mf4uI+WplYO6EfxgQPEYQgoqq7My4BODkMIk2+6iLDgyHO0Ir/tw18amyMfQDJc9VN2fkyt+LcWDC64PacEvfGu2ZoJDrZUrpJLG9CTRYgJMqxcKo3vWkRuq9oLnXgEG3VHPuVt1iPKNCo83h+cB2xjCDz0HxXFvcH8iwQK5OFUGLvSKfz2pL9eLSXyBU+i6a7pDXNURuks79/2M2zqFQPW/LXPWhUqo9MJn4gF5qOk2xLQWyrXvqwatgGT1E98CnpKWqPdpHzmuA/vHuivBq5XQqoLCNFAYtcHZFrZbGAd6Yul0oaDpojMQmrAA5bv1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199021)(5660300002)(31686004)(44832011)(2906002)(8936002)(8676002)(41300700001)(31696002)(66476007)(66946007)(66556008)(316002)(450100002)(4326008)(86362001)(38100700002)(478600001)(82960400001)(6486002)(6666004)(83380400001)(107886003)(6512007)(26005)(186003)(53546011)(36756003)(6506007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHBsZ01UU01MWWFmOHM5WDhnazViMS9ERm9ZSjRzYUFvZ1VFV2tlejd2Sm5y?=
 =?utf-8?B?TVR4SzNBRGdVaUZrVVZKUnEybXlGRjlkck0rb0pkUDdpSlVJWGVKTDFpd1NU?=
 =?utf-8?B?UllmRnUrY0oxLzNVRTRnbWRHNjNuL0hyaGJ0alV4WnpaRUJwdTBmeTF6YW1D?=
 =?utf-8?B?WFlpTFlGU1QxR1NEUGZiOEJYVC9LUlRLMzFrcU10UG41SXhyN3FRNjhjdW1O?=
 =?utf-8?B?NnZyNktZdlIxTUc0VUNoQXVFRHpRZVE3cWZ1VHRNQm9Ec1Y0ajNqOGhXUWwz?=
 =?utf-8?B?bldsUTdaV2Q1NHpQdUEzMFVyY044Q1lDeGdxZ2JXQzcwSVplTGdTZzlVa3p3?=
 =?utf-8?B?ZC81MHJ5RTBQbW9ROHB3SXpWYUViTjZNWWExL3k5bFpLbDlBYlFWaUh5RGNt?=
 =?utf-8?B?bmJ0bktVQThXanpSUFlEZGRJdlA3WFhkRktZYVZzRVJNR1JMR3ZsVU9zbm5z?=
 =?utf-8?B?NUtRMmNmWTJhL0dCbjQrK1BmenBaVEFOUmd3UE4rOTRvOCs0U1lQcjlBWSt0?=
 =?utf-8?B?R2JvMlpGQ1RSckJhQ2pPeFZ0OG55RFpXSVpwQ2lTb21Ma01lb0IxL0drYU03?=
 =?utf-8?B?QWE2SnFmZzVIK1duVU5GbnRGSklEZW0yOTdaeWJyUFgvNlQyM3ZwdEI5N2hQ?=
 =?utf-8?B?cXExWUVZYk5TYzd4L3lkWjVMdUdwZTBEZG1abVpZelBCdE95bjJYUENESU16?=
 =?utf-8?B?ZXY5RGxoZHNlUkR4TXRxRlQzQzdZaGxPZW1JOGtTV2kxVkN0eitmNTAxelds?=
 =?utf-8?B?cGhMSmt6dnE3UWsvVlRERU9PaU1rTUd5WjFnaG5QSU8wKzQ3NmswK2k5Ullz?=
 =?utf-8?B?eDNRR1lhaUZOdVMyeVhTZDdUbWJyZlA4RDJGZmFtVGdyYThWL2RyOU5mM1Qz?=
 =?utf-8?B?MFhIbk1nOEZnR1pWZkoxY0hoK01rZ1ZpZ3QrejFQZVJhN2RTVlhiTmM0VmJH?=
 =?utf-8?B?MC9MT3VkaTU0ckpjQkwwQitHTytCRitOL0JHQ2ZQaHo3RG5SNS95dTR2NUFV?=
 =?utf-8?B?cHU1ZkxZWjgyVmc1aFhoeW04V3BqVXFYSGFweTdPWEhtUDRNTXR5NW80MEtz?=
 =?utf-8?B?YkhtQSs1cVprTzMzaXlmc1lNdXY2SlREWVcybDJCN0xVK3BQYlhkQTBXK0xR?=
 =?utf-8?B?TzdXUkxCMFdEQ3pPZmltNVlRc3p2clVNeDRiZTdmbENNa1g4KzlsVlR1UmMx?=
 =?utf-8?B?aVR0ekxsU0ZlbnIvWnk3WjNZTWtVN2U3bTF4ZUVSN2lkWHAvbkhINmNTU3dL?=
 =?utf-8?B?TUI4UE1ya0pvTDZyNTBwRXR6blVnVHVybE9PeU44ZmpUZ05mYlV4aFc0aCs1?=
 =?utf-8?B?d21ncG9Wc05MNmxkcWREaU9GUmdmSXZzSnpzNENENGQvdjVCYkxZNUVITWZS?=
 =?utf-8?B?UmY1L2tzd3FMV1V3QTdsdnVjRDdMU1dGYmlRTkdvL3RzcHhveEJxOTNORkVG?=
 =?utf-8?B?S2hiSFV4VUQ5Ni9OY3N3dE5xUGV6SHovTmlEaWwza21XeTRjVCt3ZHZnQXpo?=
 =?utf-8?B?aUxyeWhRbnVPK2wvQU5IRkk5QmcwRlRJVTlZMDdYSGRST01qUGN3YVJZSUxm?=
 =?utf-8?B?K2VHR1ZYQjA5U0RaZ0tFb21iZU9nTUpLRjhwRTN2eGRTc1pqRmVLYUJtOExG?=
 =?utf-8?B?eEY1bEVIYkV0anp2TzBQZlRjbGx6dUNBblhpbjRyTjl5M0k5UEJDdHBXSjlk?=
 =?utf-8?B?QktEb2lTK0hCRFZSMUJ0NGNkcThRYzJFQVdmSlFpUlJYY2gzVzJIeG43a01I?=
 =?utf-8?B?cU5XY3JCTlI2TjVUaWYwa2NhdU8xWWZnSXRIc3A4ZGtHYzRaQys5MnlCdVpE?=
 =?utf-8?B?SnQ4UnJMOVE2WW1qT2dEN2NUcGJPblZ6Z0NLWk1HTGIrYnpDU0dVTm9JOVMw?=
 =?utf-8?B?ZkREd0VmdkN3eVBFUkY3RDFQcVRkT1NtMklPZHg2V3lvbzZhRW5mNHNmRzdm?=
 =?utf-8?B?ZEJ2anpleElNMTNzSGMzSUtVeXdYUHUxUzFXNjF0SlM4YVh2blFyb0xZQmxj?=
 =?utf-8?B?eVpmeXlkZU5sMVRGVFpkaW5qNGJIa0tPZ05XZTVmUjZRaDMvWDJSdEg1VTFz?=
 =?utf-8?B?WjFlZWJMMm9DZHN5WUVmY0xWQ2hJbmViWEUvYmYxMFZFWXhUTytOeGZ4THF5?=
 =?utf-8?Q?nDUQMsQ3OS544K+XmCame4L/3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17275195-8cba-4e49-9802-08db6df96ee1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 23:37:07.9192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLjac1KWQ/Y/fOwKKRFU84OPP5nptC37P6/19zryN5s5aCQeiKe5gEdBj/k5pMw7GPn2RU8ujFVDGAhtisBKow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5156
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 6/15/23 12:53, Dan Williams wrote:
> commit eb0764b822b9 ("cxl/port: Enable the HDM decoder capability for switch ports")
> 
> ...was added on the observation of CXL memory not being accessible after
> setting up a region on a "cold-plugged" device. A "cold-plugged" CXL
> device is one that was not present at boot, so platform-firmware/BIOS
> has no chance to set it up.
> 
> While it is true that the debug found the enable bit clear in the
> host-bridge's instance of the global control register (CXL 3.0
> 8.2.4.19.2 CXL HDM Decoder Global Control Register), that bit is
> described as:
> 
> "This bit is only applicable to CXL.mem devices and shall
> return 0 on CXL Host Bridges and Upstream Switch Ports."
> 
> So it is meant to be zero, and further testing confirmed that this "fix"
> had no effect on the failure. Revert it, and be more vigilant about
> proposed fixes in the future. Since the original copied stable@, flag
> this revert for stable@ as well.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: eb0764b822b9 ("cxl/port: Enable the HDM decoder capability for switch ports")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/pci.c        |   27 ++++-----------------------
>   drivers/cxl/cxl.h             |    1 -
>   drivers/cxl/port.c            |   14 +++++---------
>   tools/testing/cxl/Kbuild      |    1 -
>   tools/testing/cxl/test/mock.c |   15 ---------------
>   5 files changed, 9 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 7440f84be6c8..552203c13b39 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -308,36 +308,17 @@ static void disable_hdm(void *_cxlhdm)
>   	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
>   }
>   
> -int devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm)
> +static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
>   {
> -	void __iomem *hdm;
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>   	u32 global_ctrl;
>   
> -	/*
> -	 * If the hdm capability was not mapped there is nothing to enable and
> -	 * the caller is responsible for what happens next.  For example,
> -	 * emulate a passthrough decoder.
> -	 */
> -	if (IS_ERR(cxlhdm))
> -		return 0;
> -
> -	hdm = cxlhdm->regs.hdm_decoder;
>   	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> -
> -	/*
> -	 * If the HDM decoder capability was enabled on entry, skip
> -	 * registering disable_hdm() since this decode capability may be
> -	 * owned by platform firmware.
> -	 */
> -	if (global_ctrl & CXL_HDM_DECODER_ENABLE)
> -		return 0;
> -
>   	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
>   	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
>   
> -	return devm_add_action_or_reset(&port->dev, disable_hdm, cxlhdm);
> +	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
>   }
> -EXPORT_SYMBOL_NS_GPL(devm_cxl_enable_hdm, CXL);
>   
>   int cxl_dvsec_rr_decode(struct device *dev, int d,
>   			struct cxl_endpoint_dvsec_info *info)
> @@ -511,7 +492,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>   	if (info->mem_enabled)
>   		return 0;
>   
> -	rc = devm_cxl_enable_hdm(port, cxlhdm);
> +	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>   	if (rc)
>   		return rc;
>   
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 74548f8f5f4c..d743df66a582 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -717,7 +717,6 @@ struct cxl_endpoint_dvsec_info {
>   struct cxl_hdm;
>   struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>   				   struct cxl_endpoint_dvsec_info *info);
> -int devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm);
>   int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>   				struct cxl_endpoint_dvsec_info *info);
>   int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 5ffe3c7d2f5e..43718d0396d7 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -60,17 +60,13 @@ static int discover_region(struct device *dev, void *root)
>   static int cxl_switch_port_probe(struct cxl_port *port)
>   {
>   	struct cxl_hdm *cxlhdm;
> -	int rc, nr_dports;
> -
> -	nr_dports = devm_cxl_port_enumerate_dports(port);
> -	if (nr_dports < 0)
> -		return nr_dports;
> +	int rc;
>   
> -	cxlhdm = devm_cxl_setup_hdm(port, NULL);
> -	rc = devm_cxl_enable_hdm(port, cxlhdm);
> -	if (rc)
> +	rc = devm_cxl_port_enumerate_dports(port);
> +	if (rc < 0)
>   		return rc;
>   
> +	cxlhdm = devm_cxl_setup_hdm(port, NULL);
>   	if (!IS_ERR(cxlhdm))
>   		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
>   
> @@ -79,7 +75,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>   		return PTR_ERR(cxlhdm);
>   	}
>   
> -	if (nr_dports == 1) {
> +	if (rc == 1) {
>   		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
>   		return devm_cxl_add_passthrough_decoder(port);
>   	}
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 6f9347ade82c..fba7bec96acd 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -6,7 +6,6 @@ ldflags-y += --wrap=acpi_pci_find_root
>   ldflags-y += --wrap=nvdimm_bus_register
>   ldflags-y += --wrap=devm_cxl_port_enumerate_dports
>   ldflags-y += --wrap=devm_cxl_setup_hdm
> -ldflags-y += --wrap=devm_cxl_enable_hdm
>   ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
>   ldflags-y += --wrap=devm_cxl_enumerate_decoders
>   ldflags-y += --wrap=cxl_await_media_ready
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 284416527644..de3933a776fd 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -149,21 +149,6 @@ struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port,
>   }
>   EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_setup_hdm, CXL);
>   
> -int __wrap_devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm)
> -{
> -	int index, rc;
> -	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> -
> -	if (ops && ops->is_mock_port(port->uport))
> -		rc = 0;
> -	else
> -		rc = devm_cxl_enable_hdm(port, cxlhdm);
> -	put_cxl_mock_ops(index);
> -
> -	return rc;
> -}
> -EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_enable_hdm, CXL);
> -
>   int __wrap_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>   {
>   	int rc, index;
> 
