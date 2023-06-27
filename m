Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D1873FC4C
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 14:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjF0M6e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 27 Jun 2023 08:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjF0M6c (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Jun 2023 08:58:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2EE1;
        Tue, 27 Jun 2023 05:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687870711; x=1719406711;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3ru76aSIFEunf17+dCfY772euatfjzdWK6qdX4R1+lI=;
  b=Ca2Ritp5K53Q6Ew9hziLJDxClSBAeyvc4haAD98OG7/2zhnhyoojHi8w
   B/UBSFqSDJ26+dsR47gckzerL0woddSszX+BLpLBx6LIjg7Kh66j1mSyQ
   yTtH8hp/dxLk6Fltiele5CHsUTm31hImRXph2m63W/gC5j2Lyw2jizxkI
   6ywSrFbST7cCctoz5AF3AopSVeWgv/7cD6uiK7Z7GpQ4Inw7fGQ7UPZbi
   I7luqmZJJpLAHa8Hl4TtOqQv/9e08zFR71W/GCMnEI35HU7ZRvmptEbqa
   rlYGzrYWJxqwzAy9ZvESeXnsooojk1dqEZuFAAldUrPwXhYWjWZMfd2WI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="447945375"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="447945375"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 05:58:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="666693784"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="666693784"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 27 Jun 2023 05:58:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 05:58:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 05:58:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 05:58:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 05:58:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyBdWt9MQTxmvZBKYu+cp0m0dNPfrDqlQ35wjGOYwythmDuNp550F/aA8MCz8nBVp4/8IEXOd5XXxuW917SQzqCKhPA8SHsvbXnMkYeB9v4pYis1B3F7YwbGp3Rdu4JqDDVgmGUFSUubm2YlgqQms04eHKnt07IsUgbtDCZr2gHVf2Vu80Oh91NZBWWulANbvHVEIbOPAprbvBanP9vmn8IVRL5TzhTOmmv45Yd/y+Yzp4W7csWdiCd+X3YDP/hbWev/i9Lvt6rZ44Dtr9EqCYu3DQn65F0ZLR37Q09GIpYqleWU3kYj3ejx2U/cDjI0JMn1pDrSI0BHllME9VNa/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upxkElUzk7Cq9+upr9lra1ZRrN52DYMNEl7nL4rz5DU=;
 b=htnALXNmAY/M69ml8+jWuFKdfQ8GyaMhKPc+/x9YUhnISFcUFPilgH7Ezufz2UP4qN2CcXKLZNFC0d5K7GVZjjqPsXAO61lFmugtZJkbtt+iHo1ttP9ddHYhdugq6ik1BeOyAS4d+OCiFNpNjGTkjytdGn+XyUvuau5OCqYY7JZbB5A83LUp6ZNuMUAZtX5+0pvM/ASx1FX9w2t1KJOevly9labj8Yl+ucGxq/FrCuqru0Eb9q6u0LDSbIkCJaYg7hm+v33xPWXRqPM/AplLp7UdWjIHLZiJKX9AYuv2SZ3m08VSR7l+Ikskln3YG/l2REtY6dtNDMeziq6YD/6PWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB4829.namprd11.prod.outlook.com (2603:10b6:a03:2d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 12:58:29 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809%2]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 12:58:28 +0000
Date:   Tue, 27 Jun 2023 14:58:15 +0200
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     Moritz Fischer <moritzf@google.com>
CC:     <netdev@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>,
        <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <mdf@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v3] net: lan743x: Don't sleep in atomic context
Message-ID: <ZJrc5xjeHp5vYtAO@boxer>
References: <20230627035000.1295254-1-moritzf@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230627035000.1295254-1-moritzf@google.com>
X-ClientProxiedBy: DU2PR04CA0298.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::33) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB4829:EE_
X-MS-Office365-Filtering-Correlation-Id: 383bec05-261f-46e1-9176-08db770e33c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQtjSN6PCbA0h5/2BW5SOhKerivncuQ0yg4i+3ZYxbPlIJZbwEopi/TCUc5CwrXfbwo0XK8eIK1Dctlwbmphn8Ct0mDd+nyfiZT9zA7eA0KtqO1nPczpYRWqqbZWGSjNXmWxq3i2UHG/EJPBjhqAXCSXfNm2w1wsq7o1+YJAbZTTn0Dz6KLm3BXYbniZ0aLcHA1kzYEdEwR0TRY2YvXqHQeSY1JtcSP5CoWEVoIIhe72zEzizr5f3xfPEd+gRSv6j9YsFP3tfZs8pY8+shqsz/XpIu2MyJEPQ3ATNYbN83k64uBtmFHA1ZHJkEewy/OkJj56WTf+7pq+xEm+16PRVrwwoKhktfevybIiMaADxerrCsSrcnqjl7EZ6epnK+P4+yqe0KowyzPsur/BQK/cU6Eu0Fa+0uIyYWoS7jV03nUSM4+RQMHFI11imFrFZD5f1ZRNZ3gb9ID+OnXGwFEhgNxRdWxJlm5EWVz2YHNiJ+TCKcbFsgsyRGX2wbq++Vi3KNJh+CHqogCj0Kv8ehgGmPxaFy6GUVJ4cCtLTlkjdEmBaXndkz3C4BlUptikEMSz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199021)(478600001)(6486002)(26005)(83380400001)(6666004)(2906002)(9686003)(6512007)(186003)(6506007)(86362001)(44832011)(7416002)(41300700001)(33716001)(38100700002)(5660300002)(4326008)(66946007)(66556008)(316002)(82960400001)(8936002)(66476007)(6916009)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U4pyir88jDcBdWtt271HsjZxQcuaF2eVvn7eo7PjNxhgn1ggCaukEDn0RAzL?=
 =?us-ascii?Q?qPtZS5UZJ2zNamNCT5srMIfY2+70EAgy+yhWC3pIztuI2rh3wABomP2foLkd?=
 =?us-ascii?Q?+SUzD1SJf7jI+OO2C4xJ1h+E381WH1YolJbZn078fsTPxpd7x6Q6PsMWYWMk?=
 =?us-ascii?Q?GXn3l8v+bpq5nYrBAlJKJcQMUdlVub+Svyx6J7//xemHJvPTnemm4x5rCfr6?=
 =?us-ascii?Q?U/NAWNuCOsElglNsqsDIn+YL+2LdP3jh55SX8ki5+b6d4KihGtpvsmQg5GzX?=
 =?us-ascii?Q?AF0Dak/575QxX+77cBjq8oVjhcRulXNZTO73Hguy+2kUMOoXg6tm6PqLMQdh?=
 =?us-ascii?Q?T/NQhL+R6AFgPGgXx4PzZ9Zd8H+u9+c12Ms/vT2DahERNrLvTUsO0hk/yGzb?=
 =?us-ascii?Q?FUMRXDY3DWYrNsD3/RfukWXk7T98KYyHozAbAHunWVI6V7MlaHXoftu9anQ5?=
 =?us-ascii?Q?FMDa0ArSETDZlsmGs7JKVX091G2eSOPsGrqGRogAqX3xUwqHzy8f/slR9rDj?=
 =?us-ascii?Q?SkkKmpLmC3uEGbzWOx6x/P1hIszjjfN8Zf5nnF/zIjKuKUaRMzXF2ql6UkvD?=
 =?us-ascii?Q?gFPLEw6pyXhSSN8KpAS2qUlVUNp7PJ4/8YeHicJUWwtA2q1/oP0WP3tocts3?=
 =?us-ascii?Q?7/3Lc800uyqVE6TrZfOsno6v0JC2XawtWIR7jhrRU8Qo2ZZk2S2MzkFoV/HD?=
 =?us-ascii?Q?PX9Pyvd8ts9zwobo4tQhywHFs70b1sQ2UBP9z38LykADj3P4i/PQpCRUnvUT?=
 =?us-ascii?Q?BIsdDhC+jYFL1Yi3lKY7jnatS/MwKLjtEwMw2cao601L/zNDjHUbZDxXRnyC?=
 =?us-ascii?Q?2/tiNTy720x10pdPg8zUVJye/78TMooGpNwPEHW10BhGNwY7qUdKiilUAJ3h?=
 =?us-ascii?Q?bO07Z1bc860/QmBswcTl6UAHS5lh0vndrU0XSmtd9c0ieR2tQSJAXo9VSazf?=
 =?us-ascii?Q?jdNjVv7SoZ2b1Awt6c0krACtxtDOZ3CKXvcA8Gmj160xxTADOouRhGth4Vmn?=
 =?us-ascii?Q?ayEjBcKMQQCsC7/pDEDWyw/GkrmcrkNCSMxrf3DqegPqwvbRSBtEiFhRsl3x?=
 =?us-ascii?Q?pNYBHGNR6PkIxi7fxbN+z/1EuAujynHDz8V2xhH/JHFuKQBxnGlGJX4lvahe?=
 =?us-ascii?Q?1GnNytHyhv+Uw+k6fXBAWCqJdMRIINsmDFBTzcQNPtWbaMPIMOuUDjQwd0Nv?=
 =?us-ascii?Q?jnYeymNmzEospJCTkueAjCJf33TgzgtVzet7b1iaNC3FcpX5tzLzfNUbtXu8?=
 =?us-ascii?Q?+0qDSBpeHpKPEzvXY8hefvb5Q3AaPpYehO9raYJwmFGxpAllk1/KCwvTa3m4?=
 =?us-ascii?Q?ppoT0Cz0YDamnWkb0O/n1WglY3BfIEk+acgCBiJuaNtq0L9ypIqDQu02CFVD?=
 =?us-ascii?Q?JmmolgjnS8mTNB17YmOqpEb6US7/Gf/PQEdhiAsxD1X3ujvR6fQpMzf4C+qC?=
 =?us-ascii?Q?KhGceOZJsgdgQTHnEGTVt1pe4WZYzgXaGvrlrUHiT7DdoF7gR0lw79j4sjih?=
 =?us-ascii?Q?2b8h7lHfE7acn/TwzXb4yIzZJmziwltERtmszafdR+jOwTXTV62OmZu0PgHN?=
 =?us-ascii?Q?0QjXEBjGDZ/07czYM8srsafuUIaupK57SBBm23tnOwrkrt21NaMjl98slfJ3?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 383bec05-261f-46e1-9176-08db770e33c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 12:58:28.7844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3awD2HRXmExGHQskYEL8kZ3VHAW0QNYPiQRdWaMsaHzW3nDAaoerM8LSuDKzASZXQgomOx75n6jC7sB50LGp8KDe4gBRFobmwrMFdCKdJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4829
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

On Tue, Jun 27, 2023 at 03:50:00AM +0000, Moritz Fischer wrote:

Hi Moritz,

> dev_set_rx_mode() grabs a spin_lock, and the lan743x implementation
> proceeds subsequently to go to sleep using readx_poll_timeout().
> 
> Introduce a helper wrapping the readx_poll_timeout_atomic() function
> and use it to replace the calls to readx_polL_timeout().

nit: weird typo with capital L

> 
> Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
> Cc: stable@vger.kernel.org
> Cc: Bryan Whitehead <bryan.whitehead@microchip.com>
> Cc: UNGLinuxDriver@microchip.com
> Signed-off-by: Moritz Fischer <moritzf@google.com>
> ---
> 
> Changes from v2:
> - Incorporate suggestion from Jakub

suggestions were to skip the ternary operator i believe - would be good to
spell this out here

> 
> Changes from v1:
> - Added line-breaks
> - Changed subject to target net-next
> - Removed Tested-by: tag
> 
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 21 +++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index f1bded993edc..61eadc0bca8b 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -144,6 +144,18 @@ static int lan743x_csr_light_reset(struct lan743x_adapter *adapter)
>  				  !(data & HW_CFG_LRST_), 100000, 10000000);
>  }
>  
> +static int lan743x_csr_wait_for_bit_atomic(struct lan743x_adapter *adapter,

adapter is not used in readx_poll_timeout_atomic() call, right?
can be removed.

> +					   int offset, u32 bit_mask,
> +					   int target_value, int udelay_min,
> +					   int udelay_max, int count)
> +{
> +	u32 data;
> +
> +	return readx_poll_timeout_atomic(LAN743X_CSR_READ_OP, offset, data,
> +					 target_value == !!(data & bit_mask),
> +					 udelay_max, udelay_min * count);
> +}
> +
>  static int lan743x_csr_wait_for_bit(struct lan743x_adapter *adapter,
>  				    int offset, u32 bit_mask,
>  				    int target_value, int usleep_min,
> @@ -736,8 +748,8 @@ static int lan743x_dp_write(struct lan743x_adapter *adapter,
>  	u32 dp_sel;
>  	int i;
>  
> -	if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
> -				     1, 40, 100, 100))
> +	if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL, DP_SEL_DPRDY_,
> +					    1, 40, 100, 100))
>  		return -EIO;
>  	dp_sel = lan743x_csr_read(adapter, DP_SEL);
>  	dp_sel &= ~DP_SEL_MASK_;
> @@ -748,8 +760,9 @@ static int lan743x_dp_write(struct lan743x_adapter *adapter,
>  		lan743x_csr_write(adapter, DP_ADDR, addr + i);
>  		lan743x_csr_write(adapter, DP_DATA_0, buf[i]);
>  		lan743x_csr_write(adapter, DP_CMD, DP_CMD_WRITE_);
> -		if (lan743x_csr_wait_for_bit(adapter, DP_SEL, DP_SEL_DPRDY_,
> -					     1, 40, 100, 100))
> +		if (lan743x_csr_wait_for_bit_atomic(adapter, DP_SEL,
> +						    DP_SEL_DPRDY_,
> +						    1, 40, 100, 100))
>  			return -EIO;
>  	}
>  
> -- 
> 2.41.0.178.g377b9f9a00-goog
> 
> 
