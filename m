Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9F3748AA9
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 19:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjGERfB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 13:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjGERfA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 13:35:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1401BEE;
        Wed,  5 Jul 2023 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688578469; x=1720114469;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RChYpsb2it1GpXwd3EWAk1T7Vp2QQluSXcyXEV/4gu8=;
  b=U8n08yNNJzwk8oaajr5QeeKeyr/QweDh1fFC3SK00PniMsddmkireajL
   jAE1iksM9Yb1ebjMemV2ZayfydwEyv21JvoG2sfF5OHFYQmbjTPfb+NH+
   mPQG3Ob5RpdNoZlKot2ckrK8H/Vu22MRY8QEGS82gpOGiyGYqk/JN6Bcb
   owulcaGbjMva7APsG7th872cuTYaDmn8Y4Mb/wPJ5MJcBbbCqUJ0iH8U/
   UZ79yIseQHN4BF2fmNjVudwDpJ7uHams19EtWJd7372mF3SggYJiGbf60
   OOQSR6w+zBXS6HJvltLZ+CX+cJn6hlcI3zSOnTco5CUMJH7XEzi/1/vom
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="363432609"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="363432609"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 10:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="719310121"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="719310121"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 05 Jul 2023 10:34:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 10:34:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 10:34:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 10:34:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 10:34:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbP2HFDrrtyWFgyVhzl4imC22wKNJk02xV6qfrhSb3Z8aHxBgLXAvETJwqjdRin3kmGx+vbnbdeaIN2exm3xwU4790RYLgvuNACwoz2C+0HEZM37874Q0vgE2EH4JmIxe8ETld9UNj6c3047RgYLNQxWj6dg2Ti4AJpCj9uzCne8uwIrZUxhUfbPTFO3umO+BALOEvQMYAknRq8MDf+BCVgAcfxSsHX8qpycBErAOviUapXiDtvSLjBXncyfd4ocdfI98P8tt0NhAZwg89CVufxEkycbMjafPYqLOL4XWOAX57ddfl1EqhcJ2tGIs1lQOdqtr1B8fz6hzsYwycm0eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MQ/0rilLDwO6mSk2aR2OwqmaQ5vEnXu6AP/AdWEz8A=;
 b=hAmhp+/MNHVOoFLv6hXoSyWrEWWyarJ9+KlXpCrs0lnxqYeaG0RKpPm5SxLdFYlYT7EjsBuU+JUfNx0gT04Zd1vCgvFxtapWdCEcXxwVHSqlieRew5uCSmjlwN+nNd1wJgJVcmI3GHjy9PxHPYLDzBDBEwZLYqvKfdcUylriRd971awRyf7CA56bpLCshWXRW3zhhKUJskC3hOScbHBuk9zlJLNP1mq+ti9h6paPcYdnWDihaoEzbrguaJ8+f65eELwRI8UPtAB3LC2zHMHNYwRuYgivA5TxyfmZs6X2SKCJFiIMjhERzvZtACDVBBYa5/QwBSVGqbb202WsrXG1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5492.namprd11.prod.outlook.com (2603:10b6:610:d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 17:34:04 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 17:34:04 +0000
Message-ID: <c9802967-abb9-6c12-0b78-c9bcb4fb56e8@intel.com>
Date:   Wed, 5 Jul 2023 10:34:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net v3] nfp: clean mc addresses in application firmware
 when closing port
Content-Language: en-US
To:     Louis Peens <louis.peens@corigine.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Simon Horman <simon.horman@corigine.com>,
        Yinjun Zhang <yinjun.zhang@corigine.com>,
        <netdev@vger.kernel.org>, <stable@vger.kernel.org>,
        <oss-drivers@corigine.com>
References: <20230705052818.7122-1-louis.peens@corigine.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230705052818.7122-1-louis.peens@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0082.namprd04.prod.outlook.com
 (2603:10b6:303:6b::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5492:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a8eee2-e7a4-460b-0ad3-08db7d7e075b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYffngGn3CjJFCR0gX4DJ24MLzJNAgtEqI9aoklnY6g1uxfpJnFxqEcoe7nfSl1PzToKIalI7b7RXX4ZcsJvTEXiaTvb+69urd32k2Q8sHVJojxuhM5TrtwDPtiJCAUnSNZBQrSQLl+SfgTKjM6r3h4ED3gOIF6hyuOQ65ZK5NEitdyCv9uF5zuKAiy3oKuUNW8ArI3q8dkVtnALDKeNlD9BUmO/Wxa8dUYBtlxfLClZsOT6/HT4eQDKXFA6OjGAwiVqo9XMjd5JuByW7HBZ+/b9sCJexr9onS4hsmf3F9gYVXOCCq82yYjOqaIC2vAgHQ0fXRu3wogE8PKZHLLd7m9to5jTiNaHo8l/XJT4Rh1lERxn1k5ThBAG0b1H7ZBDBNLYG2rGmnqYXHRwKtsmQ27BzEnX3HCHN+AocH4AkNN/yqjbNxJnSpW5E4IKScS3FUysIKRUy7wMeZjB26r/4RZhn0voLFYdLoVBCSnN2dfojdPZfUBu2XxUEqnQ4Qd2IUZvE1ElUqCfm5C2OuzIHipOYBIW00Dfl5VAYCB6ZpPZ9oDYVPLZV+Q8PthP3pEqWgpgsd2OHmwCn+VbY6eNVDhRgkla5i10Tez6j7hU4QgldcYRt3N60uCjhZUQb4GCdyAcr2OuGUiR3R1c/SpMZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(186003)(82960400001)(478600001)(6512007)(26005)(6506007)(53546011)(31686004)(86362001)(2616005)(110136005)(316002)(83380400001)(54906003)(38100700002)(6486002)(66556008)(4326008)(66946007)(66476007)(5660300002)(8676002)(8936002)(41300700001)(2906002)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak1LclN2UEtiWUd5b1BYLzBFeUZLZFgwYW1EL2VyK0VtaXRFa29WSnl6WHNZ?=
 =?utf-8?B?dmZGd3I5TUFJWXNQTWIxQndDMjQ0UitkT0NGTzJldmV5bDFCRU1mTzR5TjFS?=
 =?utf-8?B?cXlEVXhrOGs3a3BqM1NrV2xlakkrRjBlby95aCttQ3F3SWNCYXNybFY2V1Bv?=
 =?utf-8?B?TDhLdWVQZnBtYUpuQ3lsb0tqWGYyeWtzTHdlaUlQMHJjKy9rV0tBbmJUR1lU?=
 =?utf-8?B?WDNvMjdqOGdwVlpMTkw2czlQL2pGTUtiWTAvNmxpM3N6b1Ntc2Z2YUVGYW1W?=
 =?utf-8?B?ZHZiL25kNDc2NmZOclZlN2RtanlJQzlDeFZkMi82TXB5eWtVSG0vN0E1Mlli?=
 =?utf-8?B?VzB6NGlGVWVGVHdLSWdYUE5NNkxPV2pxc3IvYW1RRFI4UEtJZEczRGMyVkdI?=
 =?utf-8?B?ekozU1R1aWdWV1gzQVpyVUIyVExJQU9hRTd2SEcyaGczRU42L3Y0b0h5ZFg2?=
 =?utf-8?B?L2t0VVM2RXo3d2d4L2xiN3lwZWorSW5zWGg4YnpiRkZ2MTlrM1g4VFdYRXRH?=
 =?utf-8?B?QUk1cTV2Nm1wYUVRcC84UitKNmEzSGE5UDB3Mjk3czFqVE1HOUR0WmpJU3FP?=
 =?utf-8?B?VjExYnNJZEZsVFhmcnRpWFlkc3hVMGhoelJSbVFxb1JCQkVqT1lvZjZkWkND?=
 =?utf-8?B?bE9CRG53VUI1QnN2QktoUjdtaUcwTUgrbW1Ha2xlU0tUVXl1OGJtb3UvU0NX?=
 =?utf-8?B?bDlpS2IvWTFZeVNoNlphQU44NHRLa2hUWW85Zk5iUWx3RnU1TkRtb0Y2ZlBL?=
 =?utf-8?B?cmtZbjZRUXUzcWo2LzQxZ3V6b1RxREZMdmJiZ1d0SXBXSFQ3RHZjUFZFSldv?=
 =?utf-8?B?Rnp3enpybjlyZjRjZXdaLzh0ak1pSDFYWEpHQlFXNVlEU1I1WEpMSzBoU1o4?=
 =?utf-8?B?UXFGZ2lBbnhxMTJseWFuRWU0YmNyREROVUx3QmtnNld1MlpFaWJFRitLSG9Z?=
 =?utf-8?B?SEpOcWg3OFdONXA4YjIzaHZhYlFPM3k4WUtlSUN1Z01MNDdBbm0rcjRkSmVQ?=
 =?utf-8?B?WWptaHhrc1pveWxrSm50RmV5UUp2cUVGcWxIb1pFQ0doTjRhSXZpUXRrek1p?=
 =?utf-8?B?OHlPbEJ5SmUzM1JnTjkvdHQ4WFBRK1h1a1hKanE0OHhpaElscm52VEFwQ0kw?=
 =?utf-8?B?cDFPblhmQldPK2h3bnVzYlp1UzZUc21RaytNS000MGdQTUlKcy8rUWlpaTUr?=
 =?utf-8?B?UjFvSmlJSU9QSjFSRTdIR01ENVVYQ0l6cFFFenAwQmtydW1QSzh5enNYQXRL?=
 =?utf-8?B?M3NDSGswNkp2bWZHclNWWHo4UXJVbWg5RHVQTUN2SlJ5c29oaHlJQmc4bVNy?=
 =?utf-8?B?MXJuOVd3cmMwUmcrNGZKNGVTMDkrQWNJbjVYOEJLVFNQNEU1RGFwS1VUNXRF?=
 =?utf-8?B?dUFTVzJrZDRGSndMdUJBN3RTT3A0YTZ1VExRQm1iVjdZdERpbzRzTXR0YjBX?=
 =?utf-8?B?MndWMSszN21lNDRhanNwODNPaVR6M2k2WVE4WDQ2azQwTGlqSzgyUG1BVVpO?=
 =?utf-8?B?Qy90cGxVdnNOK29Cb2hIZ1dRTDBodDNqWjAweGNPcENxcllmeDRMYnNpVTgx?=
 =?utf-8?B?dmxXakk2YUFzeS9ydkFTYTZQUzJtS2g0NnU0TXh4S3AxRXk0VGtMRXlOUDc0?=
 =?utf-8?B?cW9Nd2VoT05uczU4cjJjN2xIRU1EcHUwVUVVWmVZN0VJZzI2MHBaSFF4N1NM?=
 =?utf-8?B?clZhYXg5SytuMWZjMmozUFg5STlKWVlTQ1pPbDhJL2FKaXhzL2lZWWtUTFZE?=
 =?utf-8?B?eXUwK1NWbld5c1IvRHZSM1pmSGY1Ykl6VjN2dnlOR2d3aVE3RnJONG82L0g1?=
 =?utf-8?B?bWZLdDJjWGRmOWQ0S2pob3Y0S2RIcjBSZUlWL09POGEvYVlDaytiN1JLYXJu?=
 =?utf-8?B?dTB5NDFZMlFHbEhsb1NYY0c5RWh2cXZWaGJKbHIyNG5CTmIzOWw5TWttejVo?=
 =?utf-8?B?ZzMxTkw5Z3ZBYk1hVTY4eGZzV1hyUU84dzRTUnh0VWVjZzBGR1p2Z2xSSDdj?=
 =?utf-8?B?cFZJUXk1RkRld2IwNk5ybmE3QUZ2VnNoZ1NnLzNiblRDVjBZeFdnRXRlT3la?=
 =?utf-8?B?bnVWSC9DOHcwTWwyRnZNWmkwc2lhWHR3Y0lhMlJ5dVV0TVI0NHBmaFRVdVZX?=
 =?utf-8?B?YlhXRUpodEdSQTlPcWRaSnh5SjNkWHpYemhLUnlwdkJOUko3MytoVVFiR1Fv?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a8eee2-e7a4-460b-0ad3-08db7d7e075b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 17:34:04.7873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9FcsUHkcnGotpddI87YcTOfFBO6FDkfR+5cdGqYYCsJTT4U9lpRri7fPE+3dXGUY77H/7mAwLs3WwJbJKhWbS1iblAuf6IWaVtkZZ93n/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5492
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 7/4/2023 10:28 PM, Louis Peens wrote:
> From: Yinjun Zhang <yinjun.zhang@corigine.com>
> 
> When moving devices from one namespace to another, mc addresses are
> cleaned in software while not removed from application firmware. Thus
> the mc addresses are remained and will cause resource leak.
> 
> Now use `__dev_mc_unsync` to clean mc addresses when closing port.
> 
> Fixes: e20aa071cd95 ("nfp: fix schedule in atomic context when sync mc address")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
> Acked-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>
> ---

Ah, you already posted the v3 version. This looks good to me. Given that
this fixes not only the remove issue but also issues with assigning the
interface to a namespace, this makes even more sense than the previous
explanation.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Changes since v2:
> * Use function prototype to avoid moving code chunk.
> 
> Changes since v1:
> 
> * Use __dev_mc_unsyc to clean mc addresses instead of tracking mc addresses by
>   driver itself.
> * Clean mc addresses when closing port instead of driver exits,
>   so that the issue of moving devices between namespaces can be fixed.
> * Modify commit message accordingly.
> 
>  drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> index 49f2f081ebb5..6b1fb5708434 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> @@ -53,6 +53,8 @@
>  #include "crypto/crypto.h"
>  #include "crypto/fw.h"
>  
> +static int nfp_net_mc_unsync(struct net_device *netdev, const unsigned char *addr);
> +
>  /**
>   * nfp_net_get_fw_version() - Read and parse the FW version
>   * @fw_ver:	Output fw_version structure to read to
> @@ -1084,6 +1086,9 @@ static int nfp_net_netdev_close(struct net_device *netdev)
>  
>  	/* Step 2: Tell NFP
>  	 */
> +	if (nn->cap_w1 & NFP_NET_CFG_CTRL_MCAST_FILTER)
> +		__dev_mc_unsync(netdev, nfp_net_mc_unsync);
> +
>  	nfp_net_clear_config_and_disable(nn);
>  	nfp_port_configure(netdev, false);
>  
