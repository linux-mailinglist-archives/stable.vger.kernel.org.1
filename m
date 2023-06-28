Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDF87417E8
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 20:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjF1SV3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 14:21:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:50221 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbjF1SV2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Jun 2023 14:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687976488; x=1719512488;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F2WEMCayHdfRGZlFwikaUNRbVOZKAQb0n2nCvjhBO9A=;
  b=OiKKPEoHGRgBjov+5OTyf+weACxd3PwhdYDEOXPPPfiv1uBsyc7MLJ0B
   qXCiGIa+ENnULPqk7RC3nIbBXqZxc9MoQYKH0KquV5Hn/G/AUYsJqzAuX
   6g1GZ4f43L6IXYEG20vy86wFt0sJm19YSA+yMFQtRYOaupQQesmW3vfNl
   YhjwlIrCT0hP7epJ+R1dUd6ceJhXeSz4JgxcaECIHP21gqwyExXHSfViS
   Pwt7w1GXe5iMziGEjTyPlFsUQCSwOmAlO0pBZm9o9Ro7VKhszgOii3k8O
   bHb2fhafLAtlz5s0ZgHgzaVg+qGVMl6eG9KL7zJddVVYONxo8aJbLk/3q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="342261602"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="342261602"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 11:21:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="720305440"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="720305440"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2023 11:21:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 11:21:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 11:21:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 11:21:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 11:21:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6hOax57E0e1GkpbwHA3VToyFtS6u8AVtR0Hszu6iZBhO5ilTOvObEA8m03ROaQjeHgB7DhYmIf5A3CAmjmniUzK9vdDKRG2/0bpPvpmeHr4GY7nUpWl0pv8Lhu7mRdIxSCyijn0FpIVw6yJLqKEEyjBkxx2wht4q8e+jNAzWyS2EdXLoYykIuhDSJyk74mrZQ/10wbbADRYLB2TNPfsI/yekodrikiKoVDSDnrCjjNJY3XTSXYOOVtpX0sIJzFQIvVDwBSCDGDEyUT+kVH8lJsPXpGRRTLjELhrd909tTugoem+uoM9/k9lsFiNpq2AemKXYyUpK5D2TGS3h6LjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZWmYeIyUoVD4hRygewMmoaJn3p92HmxP/sOl/4Cu4I=;
 b=UWtx2SKeyQ/fwqsnOEanmNl/Qm7wCmwT3n2X3qqKiFGipDtOTRm3Hg3z0u48B4uHDrtHNugs8I53kj3FKmZytmXwveCRKV0dRFFkGlTaR1fKQN5CzorjUulwe7YBZiahPZJABWwCoTVXY7lHiJzH/cRJ7gcdeLglkXlQl4pl2Vxbe82LG6BVdhzK4Pp8TEDJ39l6bzRJyLbvEUzKh+vM2Va6wIXHU1NFS6NF32QM/s2DMAWEYwaPDAJ/5fXplWIAEsKG/CyFQpVI3QkCFY6pBiKGA+k+o4jNzL1w16tyrrmyjUm+t2RN2gZxUBtVkdIqjcTWcLPqMZY+0hYNQZm12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB5972.namprd11.prod.outlook.com (2603:10b6:8:5f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Wed, 28 Jun 2023 18:21:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 18:21:21 +0000
Message-ID: <4cc91766-998a-697c-8adb-fcc864f1be62@intel.com>
Date:   Wed, 28 Jun 2023 11:21:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net] nfp: clean mc addresses in application firmware when
 driver exits
Content-Language: en-US
To:     Louis Peens <louis.peens@corigine.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Simon Horman <simon.horman@corigine.com>,
        Yinjun Zhang <yinjun.zhang@corigine.com>,
        <netdev@vger.kernel.org>, <stable@vger.kernel.org>,
        <oss-drivers@corigine.com>
References: <20230628093228.12388-1-louis.peens@corigine.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230628093228.12388-1-louis.peens@corigine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:303:8f::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b9ed06-0754-40d7-9784-08db78047998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhfFzsZsJn+mmrVJrTCUuvF2lxuhA9chyopxWoSfv9n9WwTK7RNUomo0k4Xx7c61iCe51xEzEkCX4TtsALcqsg4+taxIV+dADNOBrSkgceQe4szwYe3+rvBD2gxVx41bLSBAGKPCtJ/wz0+NjZ9JcCVoGCyNx1iiaoyiHU1j3mBnXpsuE/7F3QwlPHMx8DZY+K+EQe2W1+FslupYTdHNq+4iPqOQLwyi5EDQ/IxOogdctM296qYSDxUVp9i+lD79lnOdm6cALEdyVppro4VUMPOt5lJQr0F9kMWZydMEs14Xu6RD4xOKang67bVQvnnZZPsZt97Pw00jiM4F6cFAo84ig+y0K38AA0i/Tp6kPHCuUX6lquNYbcCGSaCflODmQlePmpCjXugdD4S11t1r2Mm9l3OKnkUT7GrhwlH+gddmVlvwLyukD4Hrvc8YFagIIPqBAbeklIUqCBF2+A9OkC13zUCj1/0YRdDdZbNV31jUtRZ16CABbiDkPl8/83tW20olfYMwsUb11THBU8IGJPZ0yNQz0i8w2cqD7aK0DWhAf2fuoGdBbrDbQ8ASFe3+dFtS04mzop0tvL5j0GHvOLB+jHMsVz60gzthyZGJyhhBNeW5KzBge/wF19x3TvGDo+eliLoO6QMvzjkWnxeoig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(26005)(66556008)(66476007)(6506007)(36756003)(110136005)(54906003)(478600001)(2616005)(186003)(2906002)(53546011)(6486002)(83380400001)(5660300002)(66946007)(82960400001)(31696002)(38100700002)(86362001)(316002)(8676002)(8936002)(41300700001)(4326008)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2tQOHBEUnVoRm1HUVVycVBzL2Z5eWtwRkJuZ0NVQmc3R1llVTRVZVlqQ2JO?=
 =?utf-8?B?M2VxbWl2N3U2cTJUUXlzM0Z4L01wUWM1R0N1eXIxZSs0STJ4WWVaaHhDdmwv?=
 =?utf-8?B?eUM1U2ViaVBOSGY5bzdpNDdCYlVYWjMyRlRmQ3BWTDQ0T3J3SS8yTHRyckVG?=
 =?utf-8?B?bEpWUDFhbHJ2RFFnNVg1alFhTXVqWGJWZU92anlhZUVhdXBwY0ltRW45SlNW?=
 =?utf-8?B?OWhhbytXUDJzdSthRTBadG5DYytvZ09iOFdHZGRFWnFZSlNjRkRnejdIQXYv?=
 =?utf-8?B?VmJzQWZQRzAyZS96NmUybGZBb21rSjFMZ1NLNUxoK0E5eDVmUVBOVWxXT1lN?=
 =?utf-8?B?Y21kdXdPWGk0ZkhUNml1OVlrTkZOWEpVNk5wdW0zWVYrUzFsNWFEZDJkU2Zw?=
 =?utf-8?B?Z3F0K1JqSlBVdCtodFZRUW9UL3Y5a3llUzZnYVZmQWdKRWlrSHNZQ1ZjbWlM?=
 =?utf-8?B?QWtaYlVxc3VxcVFqK0JySWpNUEthR3lobkY3QUk1cUxDVThzOUFJTkw4RHdN?=
 =?utf-8?B?VjV6RlpGeXNqbWNxNDZFYUZDWjdMTVM4QkhHRFd2N2dQUUNieUhiV1FQMkcr?=
 =?utf-8?B?bHZFOGpqOURHU3VVV29RVDhxdytmdldaN3Btb05YcDVJcVJHbEhVRDUxNUhx?=
 =?utf-8?B?Z0VWZnVKZUdJQUhoUUpjdkxkajlrcGc1ZTUzZjZhdXNCc2J6WERXcTlBeTY2?=
 =?utf-8?B?VTQwUmYyQXJrcGgxV1dMNDViRU8rdEwrTVBCdTdUUW9zVmI4b2hueFI3UW9n?=
 =?utf-8?B?WUpzMXNETHFEK3hodlFFbE1LcWp2S0ZJYzdzeW9tNHRDakRQTEpybmtRU3Fi?=
 =?utf-8?B?N1AvZThESzlVeVZOVWxzTlRFS3MwY0NObVBCZ2R0MEpKQXEyWi8yMkFOOUJO?=
 =?utf-8?B?enlaeTBXNGFadFZwdlhQWkJmRkJvblUxZHp1ODBDbmk4QzZhVzFOY0I1VEZW?=
 =?utf-8?B?MmtWWGNOck80K3dqT0tTTkYxS0VQc3d4b3dVcldES2duclhBdGx0Skw0N3VW?=
 =?utf-8?B?eGhjTmdSak9zZW1NWllyMUVHTEVpeDY3UGhONnJJeUFRWGZYN1VHU21IZUtU?=
 =?utf-8?B?NTJkTkY0b0tlSTJTK01EMUVJNFFJTE02alM5WGt5U0tjYXJybVNCdlBIcENR?=
 =?utf-8?B?dzNlSDNqY0RHVzVxd0QwejNXbDcxWXpWYUY4TzV0WTRrT0pDL2lkM2ZwWXE3?=
 =?utf-8?B?ZTJBMVhONVg0S1RMQU91MTFhNFBRZHBQRzE5ZnZ4UVNrY1hWeTJlTXVFaExX?=
 =?utf-8?B?NFBqYktzMGs0N2NENG01T1pIUy83TXFPWFV5ZnNxM2tjVHljUjBZcFk1eDI5?=
 =?utf-8?B?eDdoekZycVVpUmtsb0picHhVYkJtNDVKTGVGU2dOYzJHOGFoOE9TeElrS05I?=
 =?utf-8?B?ZjQ5bW1Jdk9UcUFWb2d3eXQrdXdwRGFTeU9NWE1zRWdLcEdnVzdkOFpISkFH?=
 =?utf-8?B?Y0xkZXdJRVRlSFF6MExuVThiSW1EbnNWMFdYTGVjdS9hd0RZTDZoUElLN0VM?=
 =?utf-8?B?SG0yaEdrYXMyd01uQkJOTDRxSDExTWtmbTVpeldzOXd0V2hidUdOT1dkUlh5?=
 =?utf-8?B?cVozK0V6YkRGa1BjdXQ4aEJUSHh6MnJtZXNwcDVHeGlBN0g2aE1SS3VkQlk5?=
 =?utf-8?B?aTRrMmhBQTNiMm9tbDFRcnJqTjVkYmNHVkFab2ZLWmU4L1ZNcUd4TWRPK2RK?=
 =?utf-8?B?a3IyUjBiNm5BQm8xRzZXck9SZ1labVIvejVlUXR0dFFRVmRRb3dhalhoMFdI?=
 =?utf-8?B?QVZaNmxlRGJraWRVQ3NyNUlhTkVPaUhhbDJwbG5GTk9MeE1wdEVmRUVpZGZY?=
 =?utf-8?B?VzZUMlNhSXNoWFJWNko2NUtmeWl4TzZVRXU0dEFYMTh6amc5SnNabVlJMjlt?=
 =?utf-8?B?OEdjL0IydW9ZTWRrRmJiRzNzMzlsclphYmEzQ3phbmprMWUveEpnbkxBMDlm?=
 =?utf-8?B?MHBmQStFeXg0QXBqNXM1WnVEY3NwcUZycEwvcDFMdGJ5R0tYZjQxTU1qYjlH?=
 =?utf-8?B?VGpqNDdnQTdVWGxyWVNQNUFkUWJHWjd0SmxuczJ5TTY2MnFnd3hhMGhnUWhu?=
 =?utf-8?B?bXBRKzN4eW1HQWFWTnkvT0NvU3J0ajVnMDdSVTZjUy9tUHpFMWVHT3BHci9N?=
 =?utf-8?B?UnlxNWhta08vMWZ6ZjlLeER0U1p6US9rTjNmSzZBanJxK3hXaTVJbk1EaWV2?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b9ed06-0754-40d7-9784-08db78047998
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:21:21.9211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8hnf0LbmB1+YnjGHtVyLSNL9MoYZiTa0VInfg1DMqMa6uh8z5zoM72DFKeu4zNiythxpkH9fnjA3g6h8zttUaWLd+uJQjIyNuTr05yrtXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5972
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 6/28/2023 2:32 AM, Louis Peens wrote:
> From: Yinjun Zhang <yinjun.zhang@corigine.com>
> 
> The configured mc addresses are not removed from application firmware
> when driver exits. This will cause resource leak when repeatedly
> creating and destroying VFs.
> 
> Now use list to track configured mc addresses and remove them when
> corresponding driver exits.
> 
> Fixes: e20aa071cd95 ("nfp: fix schedule in atomic context when sync mc address")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
> Acked-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>
> ---
>  drivers/net/ethernet/netronome/nfp/nfp_net.h  |  8 +++
>  .../ethernet/netronome/nfp/nfp_net_common.c   | 66 +++++++++++++++++--
>  2 files changed, 67 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net.h b/drivers/net/ethernet/netronome/nfp/nfp_net.h
> index 939cfce15830..b079b7a92a1d 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net.h
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net.h
> @@ -621,6 +621,7 @@ struct nfp_net_dp {
>   * @mbox_amsg.lock:	Protect message list
>   * @mbox_amsg.list:	List of message to process
>   * @mbox_amsg.work:	Work to process message asynchronously
> + * @mc_list:		List of multicast mac address
>   * @app_priv:		APP private data for this vNIC
>   */
>  struct nfp_net {
> @@ -728,6 +729,8 @@ struct nfp_net {
>  		struct work_struct work;
>  	} mbox_amsg;
>  
> +	struct list_head mc_list;
> +
>  	void *app_priv;
>  };
>  
> @@ -738,6 +741,11 @@ struct nfp_mbox_amsg_entry {
>  	char msg[];
>  };
>  
> +struct nfp_mc_entry {
> +	struct list_head list;
> +	u8 addr[ETH_ALEN];
> +};
> +
>  int nfp_net_sched_mbox_amsg_work(struct nfp_net *nn, u32 cmd, const void *data, size_t len,
>  				 int (*cb)(struct nfp_net *, struct nfp_mbox_amsg_entry *));
>  
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> index 49f2f081ebb5..ccc49b330b51 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> @@ -1380,9 +1380,8 @@ static void nfp_net_mbox_amsg_work(struct work_struct *work)
>  	}
>  }
>  
> -static int nfp_net_mc_cfg(struct nfp_net *nn, struct nfp_mbox_amsg_entry *entry)
> +static int _nfp_net_mc_cfg(struct nfp_net *nn, unsigned char *addr, u32 cmd)
>  {
> -	unsigned char *addr = entry->msg;
>  	int ret;
>  
>  	ret = nfp_net_mbox_lock(nn, NFP_NET_CFG_MULTICAST_SZ);
> @@ -1394,12 +1393,30 @@ static int nfp_net_mc_cfg(struct nfp_net *nn, struct nfp_mbox_amsg_entry *entry)
>  	nn_writew(nn, nn->tlv_caps.mbox_off + NFP_NET_CFG_MULTICAST_MAC_LO,
>  		  get_unaligned_be16(addr + 4));
>  
> -	return nfp_net_mbox_reconfig_and_unlock(nn, entry->cmd);
> +	return nfp_net_mbox_reconfig_and_unlock(nn, cmd);
> +}

Ok so the motivation here is to allow separating the command from the
entry so that you can call it during the npf_net_mc_clean().


> +
> +static void nfp_net_mc_clean(struct nfp_net *nn)
> +{
> +	struct nfp_mc_entry *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &nn->mc_list, list) {
> +		_nfp_net_mc_cfg(nn, entry->addr, NFP_NET_CFG_MBOX_CMD_MULTICAST_DEL);
> +		list_del(&entry->list);
> +		kfree(entry);
> +	}
> +}
> +
> +static int nfp_net_mc_cfg(struct nfp_net *nn, struct nfp_mbox_amsg_entry *entry)
> +{
> +	return _nfp_net_mc_cfg(nn, entry->msg, entry->cmd);
>  }
>  
>  static int nfp_net_mc_sync(struct net_device *netdev, const unsigned char *addr)
>  {
>  	struct nfp_net *nn = netdev_priv(netdev);
> +	struct nfp_mc_entry *entry, *tmp;
> +	int err;
>  
>  	if (netdev_mc_count(netdev) > NFP_NET_CFG_MAC_MC_MAX) {
>  		nn_err(nn, "Requested number of MC addresses (%d) exceeds maximum (%d).\n",
> @@ -1407,16 +1424,48 @@ static int nfp_net_mc_sync(struct net_device *netdev, const unsigned char *addr)
>  		return -EINVAL;
>  	}
>  
> -	return nfp_net_sched_mbox_amsg_work(nn, NFP_NET_CFG_MBOX_CMD_MULTICAST_ADD, addr,
> -					    NFP_NET_CFG_MULTICAST_SZ, nfp_net_mc_cfg);
> +	list_for_each_entry_safe(entry, tmp, &nn->mc_list, list) {
> +		if (ether_addr_equal(entry->addr, addr)) /* already existed */
> +			return 0;
> +	}
> +
> +	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	err = nfp_net_sched_mbox_amsg_work(nn, NFP_NET_CFG_MBOX_CMD_MULTICAST_ADD, addr,
> +					   NFP_NET_CFG_MULTICAST_SZ, nfp_net_mc_cfg);
> +	if (!err) {
> +		ether_addr_copy(entry->addr, addr);
> +		list_add_tail(&entry->list, &nn->mc_list);
> +	} else {
> +		kfree(entry);
> +	}
> +
> +	return err;
>  }
>  
>  static int nfp_net_mc_unsync(struct net_device *netdev, const unsigned char *addr)
>  {
>  	struct nfp_net *nn = netdev_priv(netdev);
> +	struct nfp_mc_entry *entry, *tmp;
> +	int err;
> +
> +	list_for_each_entry_safe(entry, tmp, &nn->mc_list, list) {
> +		if (ether_addr_equal(entry->addr, addr)) {
> +			err = nfp_net_sched_mbox_amsg_work(nn, NFP_NET_CFG_MBOX_CMD_MULTICAST_DEL,
> +							   addr, NFP_NET_CFG_MULTICAST_SZ,
> +							   nfp_net_mc_cfg);
> +			if (!err) {
> +				list_del(&entry->list);
> +				kfree(entry);
> +			}
> +
> +			return err;
> +		}
> +	}
>  
> -	return nfp_net_sched_mbox_amsg_work(nn, NFP_NET_CFG_MBOX_CMD_MULTICAST_DEL, addr,
> -					    NFP_NET_CFG_MULTICAST_SZ, nfp_net_mc_cfg);
> +	return -ENOENT;
>  }
>  
>  static void nfp_net_set_rx_mode(struct net_device *netdev)
> @@ -2687,6 +2736,8 @@ int nfp_net_init(struct nfp_net *nn)
>  			goto err_clean_mbox;
>  
>  		nfp_net_ipsec_init(nn);
> +
> +		INIT_LIST_HEAD(&nn->mc_list);
>  	}
>  
>  	nfp_net_vecs_init(nn);
> @@ -2718,5 +2769,6 @@ void nfp_net_clean(struct nfp_net *nn)
>  	nfp_net_ipsec_clean(nn);
>  	nfp_ccm_mbox_clean(nn);
>  	flush_work(&nn->mbox_amsg.work);
> +	nfp_net_mc_clean(nn);

Is there no way to just ask the kernel what addresses you already have
and avoid the need for a separate copy maintained in the driver? Or
maybe thats something that could be added since this doesn't seem like a
unique problem.

In fact, we absolutely can:

__dev_mc_unsync which is the opposite of __dev_mc_sync.

You can just call that during tear down with an unsync function and you
shouldn't need to bother maintaining your own list at all.

>  	nfp_net_reconfig_wait_posted(nn);
>  }
