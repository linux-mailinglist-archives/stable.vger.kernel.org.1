Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6617974607C
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 18:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjGCQLq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 12:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjGCQLp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 12:11:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2224109;
        Mon,  3 Jul 2023 09:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688400704; x=1719936704;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pX1UQgNZXn92/zcmgB5ALOc4HN6DB/lnLGLVKeS/SCU=;
  b=Q6tKQh38L1OUzHUQpj49j3UB8fWiPXN+i9zsIychbjOySMUtduX1shBM
   TkqMR/v6OKEveVDCMmk81FrMBPTeSbtoyYrrAJJG/KergojtzATfEvLXu
   HSTXWL+gaUXs3dFR5oD9DDhkqiuBy/jw4r/89jckNFWopTHIUikz42vbL
   18u1g/rvesmX4oao0xApaKPkWEaWFj6dNtujR5sMvoDKeJXQB6pRotTOD
   ylfOhLi4mZp8RoAHu5KQN2gpfh74p5sLMWzXV4nEDdRQVXf2Ixh8XIqTO
   nQZlkJdn4cqSyfxnNvtDfxxAPHBmXnxW4ZruPt40zoitKEmTeei9V9je3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="366404243"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="366404243"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 09:11:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="753792133"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="753792133"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 03 Jul 2023 09:11:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 09:11:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 09:11:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 09:11:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l01v45UwabNf28smc0GlwwQkIQ0tAe45XRDMNnIZQddhuvjMQSTe0akwG7N7rtD2moXxlVPVEOK990/r3Q6AYJl3bNOdPPQihEkd6l1ohlOVaIxpfJQpEM7+5P+qAPktMmgNxU4POD1DLmM/AOIPSiLEVwmgG8LjFb2GE9CnMq3A3f5r6ogD9EgIPszj4RY+YbIBJrVNqEm0mFVzoVkKxbHac4n2dxVvK6gzJbWG+e5132mSv4Rq3w2KZJmqIcV8lGcjow4lRuaYsOHJgyWJ27vNnCAQGxIwhS7d6pQpXVJ6KAA6ZE9Kxtd61I/uLXqhlT+QtvUi2nNhwKOsFvfNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLlNcIS1Bg8sQ+pZEjzlCaGbpu6KN6ymNarbSUTGNkQ=;
 b=I5UOuGAbA9yZ4XJu18ClgvZXWdEorN1Gu82OXNZ+4DEDYUC37BZxTa6hAr/pge0urWUVq1BkbXfWNqjqnAq4HjFfQNU5Y8LWa4rNwrYgwUCaBxjX6VMC/TyraYG6/XQS8ROowyFU4E9tFu1qZMT06LkN3m/7iuV7u6jbGJGVBtEna2A7+ebD0eFdDNVBNl2L9orMwztWgzsuBUnXEP76jBQTyVNYdNuV+/bVVE2JLN5GpA8rI/SuotyLgAyLf2teiwDfWG8mjm/92QTOxyo8hDOpZheYPabdlEm3/BWzhncn6YJmc4wG09ziutSNUca1ND71ZLC3+HOERQPYSg2fiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SA3PR11MB7433.namprd11.prod.outlook.com (2603:10b6:806:31e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 16:11:41 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 16:11:40 +0000
Message-ID: <4012ae37-f674-9e58-ec2a-672e9136576a@intel.com>
Date:   Mon, 3 Jul 2023 18:10:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net v2] nfp: clean mc addresses in application firmware
 when closing port
Content-Language: en-US
To:     Louis Peens <louis.peens@corigine.com>
CC:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Yinjun Zhang <yinjun.zhang@corigine.com>,
        <netdev@vger.kernel.org>, <stable@vger.kernel.org>,
        <oss-drivers@corigine.com>
References: <20230703120116.37444-1-louis.peens@corigine.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230703120116.37444-1-louis.peens@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::11) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SA3PR11MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 323f9d5e-cdfc-4b0b-66aa-08db7be02f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlCqgv6X71luGmQ02wa2ZCdPoKx9CW1v23JgHKouL4rGGWOc1IJTG2X+XkLz+/hFZWrTw8k57/vUuQO0FkkGq//8ABfDVjOwiZs1CDSwRLGK3HxnmJ59OWQZ/MHM099G0SBZCem0kMasNWpy6YFIClwH8LqBg7QoHP1nJKCOprgKZnoTsDtxgyU4Do3vzyPsO3+xYRd1lqgwncE+q4rq0fKj/tfzds+ZHjv+eRGqyrEiBQ0x4da+JdOJNVMCReeA8tH1lMbYJQslirQL+VlFCrHjOJHd+PAB9oNH3LPd5xNgiVJUD/J35D7OtQBfqtPII5WB1VmCeqoP/jWzvoa/W7Fpba8uYycbxamQuMym8NYe19iib3jlBjfby3iMMQcuLkCriWQttboPybJW6pfg/+pQ5X0GUQTO0bToQjg4+niOH5rRrVKNRwOts4gocycqUOVsjv/xv5GhiiDXWSRrvM5ldJMeQ4KieNlFopiUgOeC6vDxP61FQc7Zzb3tnSOu1ncBePDYM8pWiyVgJ9C11d4HSGLHqOi0rt9EJzw0S/sKDNWz8zj31XklOLJtEq6WrA9XxF+va12KkvLDcVFiAWcyrmImTG+EM8RMCUSm8s4uvnMkiKCtZIqHrFVWvX5cism8WQ6NlqCORkMEV4ev+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199021)(31686004)(4326008)(66476007)(66946007)(6916009)(66556008)(316002)(478600001)(2906002)(36756003)(8936002)(8676002)(5660300002)(31696002)(41300700001)(6512007)(54906003)(86362001)(6666004)(38100700002)(6486002)(26005)(186003)(6506007)(82960400001)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c21XWVZMSmh2c1Eza1A0eldWNHkzZXRBUTJQNkNhN01PQm16WElIclFocWhw?=
 =?utf-8?B?cmRGRmVKamtGV1krUTNBMGRDWVB2VFd0dk91OUMwM25ySXFTdGN6dnZaUjVZ?=
 =?utf-8?B?bmt4dkJqUG0rSEttTVdGUmtqbEM2bmM5ejY2Q0RGTEk2Vk1LUllnaTNFcXRW?=
 =?utf-8?B?TUkwM3k4WjExb3JlVUMzYmZiNXlRUy9Kay9ucEpWckR5VllZVktqSDcza0cx?=
 =?utf-8?B?bTBaS1R5VW43Y0UvL2QxN1BIckI0SmtWOHd4SVpPb09mR0NhQUJjSEphc3N6?=
 =?utf-8?B?QmhQTjRhWDNJUEFENVV3Q2RxUjVTeUwvczg2d2pCN2ZjQlNpRGFkZytscnov?=
 =?utf-8?B?Qi9XSnkrZlRRSDNtT2NIVVdIYUg5eTV3SW53VExXYkJFc3hjc25CUDdtbTRI?=
 =?utf-8?B?NkE3Nnk0RjdGVWZQVXREYmdPL0RXWkFFOWxZTVpuei9kUE9nYnRPbUdBM3pp?=
 =?utf-8?B?QUoycjN1eHhrSk1oMGU5ZnI4djV6ZXlJODNRK1p5UExhenNFV2ZpSVYremJO?=
 =?utf-8?B?SHdLT3dieHVENHhLVHc4d0dvczg5NlFzbWMyMU1mc0h4blNiTHRtOFljTXVS?=
 =?utf-8?B?d3RLandVVHFTaXM4dTg2YmtzWVRhR2U2N2grY24vd3BRMTNQL2h0R0ZVTTVG?=
 =?utf-8?B?VE9oMlFvUndSaGxtY1ROakdoY21tYk1HdUllcXdxUG1wUEZ0b2c1ZHpBWGZt?=
 =?utf-8?B?YmhrSlRCOXRTenU0UnRTbFpzREJWbHREeWUvdkV0MFRidmE2ZDFvUGRlS1BZ?=
 =?utf-8?B?d3lsSmR2NlArY2xoeVRWeW45dEZuTDczNWJsZVp3bCtjbjFNKzl1aVA2MHda?=
 =?utf-8?B?RTRjUzdQSjI3ZTRXZGtWZE1pY3BOc04wd2FIeXprWjg2R3JsejlkVDdQek16?=
 =?utf-8?B?NGVwMU9nZzduVHJIMFBnWlNJYTZ3UWRoc0dMa2FxNDgwVitGbGlsUUpBakIw?=
 =?utf-8?B?MFhzKzkySUNzWjR1Y1RUZVZmdkNIeTRueWFPc29XQjlzd3pEdm9VMmNKZWJI?=
 =?utf-8?B?NU1hK1NmK1JxL3lkZzIwRTJ6bzlBcktmTEdZbW16Q3Nyak9HS3A3VTZSckpq?=
 =?utf-8?B?YTFVZ1V3VEYxK1FPMGk2a0NFbzFtVFZGc1NjclRDaWJsYUxmY0N4QXBkbUdI?=
 =?utf-8?B?SmdYaWZFR0tsN2JYNkZSVjJOSklFRFQvK2FheDNvU1hYK3pVL3Iza0NWTjdL?=
 =?utf-8?B?M3lrUkhLTTU1WlhQaEdoS3JMS2k3NjFSSmJ5eFhRaUpDdm5kNVh4RFRjTDhn?=
 =?utf-8?B?eGZ3L3FPcjRVS2pEWFhZQXRFRGFtUmNGMXg0Rk5wVElQeW9RY2NEazQrQWht?=
 =?utf-8?B?RStBalNOeVhCRUR1QU5jMjVld0w5ejcyeml6bm1MVERyU3RWSWFBQ1JxSk9r?=
 =?utf-8?B?elJuL0pBaWhabHN3c0Z0KzM1QUFWeWFreE5aTFB3WDYrc1d1WWJEenZ5bHhX?=
 =?utf-8?B?TVRhUHJ4VkNNT1liZzNZZCtEUksrdGJrOTg1cTE5cXkwOENWV3lvYVBDZHFD?=
 =?utf-8?B?bVdIaStUckpOR0hHL2tERlIwMFRiQ1JaVnptUTJDNk5aTVNEdXA0ZnVYYlNj?=
 =?utf-8?B?VDRxOWcxMi9DeXgyUFZlQ21JMkdlVDVwRnNPOC9VS2RFVFhFQmpzeUp5Q3RR?=
 =?utf-8?B?WmhJRGJqYkt2WEN6dTNGNUpzcGR5MXRyM1VtSzRxNklpWCt1VG5GUk5hbDRu?=
 =?utf-8?B?a1VvQUJDVmpaY3pCZUNyekMxTDMrUXZxVDJWM0d2ZGtVNVRzbEFCcHcvRnht?=
 =?utf-8?B?cENNMklZeTVhRHVkbjQyNTR6QzZtSExHTks5eC84V05SdjF4R3ArU1BrRU9p?=
 =?utf-8?B?VlorVlJOWmJGREp0MTRsN1lhbzRBQkNwMk1lMnJiZWlPYlJ1ZlZqemdhNndq?=
 =?utf-8?B?YnlXNHpscTJSODU4a2VlT09uUytCTHpUNmNZTno4Y3dXSDg5MFFRUVhZdEdH?=
 =?utf-8?B?aVNDSEU0YzU0d0hGa3JOOWlBQzU4NmNJcW1NcW9zcHhKbFdnYWtIVzRvTHdZ?=
 =?utf-8?B?Y0NZamRHKzhKN296R2pjSGRpanM1V0xFalc5VGdMdW9oVFc2ZW9sek01UHpP?=
 =?utf-8?B?VFdqSXdkekpTbDFqakRIektHMm52d2tZQzVvRGdMK3Y0NEkwOXFpRlRabzY3?=
 =?utf-8?B?TEZJNzhMTjdFNUNZYlhpSXdVdHU0M0x3VE42QXFVQXp2dkpMekpWR3JTOFB4?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 323f9d5e-cdfc-4b0b-66aa-08db7be02f6d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 16:11:40.4701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1o2bXH1dufzTj02i9rRUHEzi2fhNOe6waNeO5mrI6SiGC1q6sssiV7azwPyVt+nxiDLxrwIdd3B6+GC4q9VAnXPGuhGrNHpq7KZmWPIpZOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7433
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

From: Louis Peens <louis.peens@corigine.com>
Date: Mon,  3 Jul 2023 14:01:16 +0200

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
> Changes since v1:
> 
> * Use __dev_mc_unsyc to clean mc addresses instead of tracking mc addresses by
>   driver itself.
> * Clean mc addresses when closing port instead of driver exits,
>   so that the issue of moving devices between namespaces can be fixed.
> * Modify commit message accordingly.
> 
>  .../ethernet/netronome/nfp/nfp_net_common.c   | 171 +++++++++---------
>  1 file changed, 87 insertions(+), 84 deletions(-)

[...]

> +static int nfp_net_mc_sync(struct net_device *netdev, const unsigned char *addr)
> +{
> +	struct nfp_net *nn = netdev_priv(netdev);
> +
> +	if (netdev_mc_count(netdev) > NFP_NET_CFG_MAC_MC_MAX) {
> +		nn_err(nn, "Requested number of MC addresses (%d) exceeds maximum (%d).\n",
> +		       netdev_mc_count(netdev), NFP_NET_CFG_MAC_MC_MAX);
> +		return -EINVAL;
> +	}
> +
> +	return nfp_net_sched_mbox_amsg_work(nn, NFP_NET_CFG_MBOX_CMD_MULTICAST_ADD, addr,
> +					    NFP_NET_CFG_MULTICAST_SZ, nfp_net_mc_cfg);
> +}
> +
> +static int nfp_net_mc_unsync(struct net_device *netdev, const unsigned char *addr)
> +{
> +	struct nfp_net *nn = netdev_priv(netdev);
> +
> +	return nfp_net_sched_mbox_amsg_work(nn, NFP_NET_CFG_MBOX_CMD_MULTICAST_DEL, addr,
> +					    NFP_NET_CFG_MULTICAST_SZ, nfp_net_mc_cfg);
> +}

You can just declare nfp_net_mc_unsync()'s prototype here, so that it
will be visible to nfp_net_netdev_close(), without moving the whole set
of functions. Either way works, but that one would allow avoiding big
diffs not really related to fixing things going through the net-fixes tree.

> +
>  /**
>   * nfp_net_clear_config_and_disable() - Clear control BAR and disable NFP
>   * @nn:      NFP Net device to reconfigure
> @@ -1084,6 +1168,9 @@ static int nfp_net_netdev_close(struct net_device *netdev)
>  
>  	/* Step 2: Tell NFP
>  	 */
> +	if (nn->cap_w1 & NFP_NET_CFG_CTRL_MCAST_FILTER)
> +		__dev_mc_unsync(netdev, nfp_net_mc_unsync);
> +
>  	nfp_net_clear_config_and_disable(nn);
>  	nfp_port_configure(netdev, false);
[...]

Thanks,
Olek
