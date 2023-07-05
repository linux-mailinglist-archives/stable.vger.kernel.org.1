Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB615748A65
	for <lists+stable@lfdr.de>; Wed,  5 Jul 2023 19:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjGERah (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 5 Jul 2023 13:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjGERaa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 5 Jul 2023 13:30:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657971FFB;
        Wed,  5 Jul 2023 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688578196; x=1720114196;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sSa39Ynd5Wfm/pwyvbZC+CkdbKauksRmdbGaQqwdQHg=;
  b=CLuiSz6IsSjM5sHKpOw5oBQG5jR+Sklv2aofCPGqnqmz6UzOAMzv2BSF
   kzKWT2mQ7zEmUh4jBupwwn2GYMfxWmlpfiRVZrWhJ637il8tFr+iD720G
   4QvVN4bulNRUN0cQdc/7CL2JupZ5XDV2hcZR2sWlfEUaKVSaFP4uv9CUD
   PGxlHkeCbok0UzauIkdQtjyZDtWFtcn114ClIiQXxojbZ6SQ6BIK0ppPy
   nAk8oYrY4oWv1vAeqkdX4CYvXQPeAWTqANw5Imb77ZBYFNVXCCbJXeB5u
   WadI3O7B7CEOah67xrLYNMqZNRJ2gwUOuYFv3DDKLPQOSv18yTbAvMt0M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="365973126"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="365973126"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 10:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="748810510"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="748810510"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 05 Jul 2023 10:29:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 10:29:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 10:29:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 10:29:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSHV72ox0bxE/Cs5OID/i/EbI/pxRfSYnczMLK70kT3Hl3tNl+p1tYct2lcgmreWIwpqNJlt94dLj2MXuRZFuh+g3L6CFEEtm0rbCg2EOnmIPo7eJ18JIlq8g8gqAg9E08ZGEO7yOObiVWSDq0mTx1EkbCeqwlhYDfSuiRdI2F2sXBvid66NS1032Ykyq0/up1g4qCNTpVR1iwbJ5fUYhLQu2EU+B9N/QdBRms8vtleAV6VA4e+26k66OkHTzg5czleWeLtUU5+55jc5xReUk7p6vL3sFG+f6J+47KoZ/Ku3BsS7wbz1J0GLs8Yg7TgRqx/mKRF0kcVlQ7qOTBjKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/iIrIHpi3jJ1Q7EEq0nTXEF2Ky3lBml62B6m9k7LtU=;
 b=e3ebJcDc3WB6Xzd+DRZib/b02deKu6LfihtpC7DOJoLg1rOMthF1yVI7tXV7NVC4/uP9qsdmmyxQQiyDA6Lq1o0V2PQu7XFCJOrqDYZ5my0OTwxd9wI54SSKutDbRI+0Slgq1Ll7mXScNNxplDK0ppGJWZVIkGqFsvgJM0uPHtaYpYjTFpVTmKfdGpvr+w3QDmGWhEJAbRYhX0YP56KYU4/A2pI74nQTrmfXAzalqqHJitbp1S/Dima0K/e/fXv1s2ykEt7K/YHjc4YOaVAdanlDW20usANQsnW4jcdzGTgosEQDTByVe/WKt73Vf6c889Tv+xOQ17+iTcX/h8x8tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6699.namprd11.prod.outlook.com (2603:10b6:510:1ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 17:29:40 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4e5a:e4d6:5676:b0ab%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 17:29:40 +0000
Message-ID: <ca4d9186-705c-8a69-7fce-7cff884989c0@intel.com>
Date:   Wed, 5 Jul 2023 10:29:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net v2] nfp: clean mc addresses in application firmware
 when closing port
To:     Yinjun Zhang <yinjun.zhang@corigine.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Louis Peens <louis.peens@corigine.com>
CC:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        oss-drivers <oss-drivers@corigine.com>
References: <20230703120116.37444-1-louis.peens@corigine.com>
 <4012ae37-f674-9e58-ec2a-672e9136576a@intel.com>
 <DM6PR13MB3705E98ABE2CA8B2B677E055FC2EA@DM6PR13MB3705.namprd13.prod.outlook.com>
Content-Language: en-US
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <DM6PR13MB3705E98ABE2CA8B2B677E055FC2EA@DM6PR13MB3705.namprd13.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:303:16d::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c34b6f-8ba2-44e3-7562-08db7d7d69c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iNqhRhtQ2Q/UrdGnZ76WiZQZ0ityJrqrm6jwnYDR4jMzHkVIYO5z9Wkszq/KnLaO3l7o5DCL5EA8+vaigsjcnwZUkB40gBhoCnVs0fSjBTQvf48wP1vF6bBOHV+swG/GZvMgBzMaIzsnomqHEfHyRPiXTsW+823IxuwMZ1m9fOO7PHEhMZ0qJ8dIINSboLGHWmeZjr5Yg+LPkQBu98TX8YUuaj2mJqnQkU44aRMHxSqj+Mnkcm99VpRBiakhweELzwgKOzrlWc4qeebkgzMASEtxkNHEpbf1mzczgSKfDaNSn1mlZ5Pkub+CxuSleWkAABLwen95pHgDEbb8JSRr3gQL5VwJhlA8jKA9nOiF3wg2/zvZVYE9gtcYXYS3Ue/cODqLeaxaQgqucWxvxddp3un6mBNS+OUJzkqrqKyfLb7mpOH3Lm+CXjxQMr+scstJHX5xVbPBPfU8Ju7Jd6Zi4iAmJCJsD3rpQslJsK1gahXXB3ZfbGGL2kAr4iFxrUgpqq9w0H50CP1qTc+ydtzpspkrKj9ml5Zq0cKVmGDKSop+gl9bKgslG5zwqVS9O/1R7kkzxRv2ROMQbvPlR28PP8dh83/BmN7jn5ofvrlYT4gTTyMnmfCHylmQGxhqOD2ZM+rytcHqA60lmKowlR/tUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(38100700002)(66476007)(66556008)(4326008)(66946007)(82960400001)(2616005)(186003)(86362001)(31696002)(6486002)(6512007)(36756003)(478600001)(26005)(53546011)(110136005)(6506007)(54906003)(8676002)(8936002)(5660300002)(31686004)(2906002)(41300700001)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUtXTnU5cGh5VUhMTGZBR243QzZWUXQvSmZOUGNySnhNLzdmZDExOXpPWGNI?=
 =?utf-8?B?bTdVSFJjNUhyNWl1OVdyWDVvaXpYZS81bkZoOU5ad01OK0pDNFVWSVFGUkRk?=
 =?utf-8?B?R3ptcGJUUUJNckdqVnkzYkovM2wxUC95NU41STdBMmQwb01yV1ZYTlBZbm1F?=
 =?utf-8?B?ZVNwQzNDT2p4citGNDlDeTVmM21sYk9lYXJoYkxDQjZKRWNlK3V1N05tS2pT?=
 =?utf-8?B?ZmpQS0JCaERJYVM0bHpKQ0Q4dXZWR0pjRXFlVVUvMCtENldQaVd1R0VGaExm?=
 =?utf-8?B?NG1pT1lEUVJrZ0VuOEluS0JyQlljcnJLR2lNWm5IUTdFVERiYkVJOWFQTlZi?=
 =?utf-8?B?SkJvT1ZhRzB3blF6ZjJnUU5DZFp1N3FmZ1BLUmFERHdjek9ETmJrV3M1ZHYx?=
 =?utf-8?B?dzFxZFNtN3ZDdVJVZExxbUU3ZS81ZGdSUUkvYldaaXNRL1lHTkF6OXAva2RZ?=
 =?utf-8?B?bXdHdHBYb2dyVVMyclBwSzdINWZEb1VCbVhxTExjZ3dmMEo3U2Fmb01NRWhi?=
 =?utf-8?B?Z3ZaQ0RZeEhycWRPTjFydzVUWHBscGZEcXExK2d0Z1NLSWducVhIam9FU2l6?=
 =?utf-8?B?U0xPSXF1bTBtM0txbWtCNWhiTS9TM1dScDVCWWREdHNoOHZONmNNTSs4bGNV?=
 =?utf-8?B?VDBiVkZFaVlxTWFwMVFrclBoY1pYWURzSGhCQ2xsUzJBaHhMdkptNGFHbVBF?=
 =?utf-8?B?RlVlRHJWRmg1TGRKeGhrVkdxV3pVVllhSXhNKzB3SytUZUF4QnNPbmFxdjlo?=
 =?utf-8?B?UEtYMzJQUEQ0bzVra0dlMk5nWDZxRGdCYzAzdG1ieW4rZjBkSmNxWUFFNUtF?=
 =?utf-8?B?amc1bDdXN3E1a0FjeTVvc3ZZR3VkYWc0Nm1iV01SbVgwYW80cGN4UjMzbmh4?=
 =?utf-8?B?dU43TFQ2dkxobCs5QXZ2WmZhSDF4aVp6eFFWc0QweVFYdzZDNkxJWTlKTnpV?=
 =?utf-8?B?RVY3L3A4Zkk1OGNoLzdNbkxQU1ZaVHIydlVtTEFvRG93SStLVGxzcmp2Wlhq?=
 =?utf-8?B?UG5RTDBOcmhiZks0R1dWZ0JISXNqNWxZZGFXaUtYeW5xbFdrWnF0SVFQbk5H?=
 =?utf-8?B?dmFYWGNyay9uSmI5SVhneWllSGc2bHdac2dFWHk2QjNyMWVIb2Zuc0J3bWxp?=
 =?utf-8?B?ajErbDk3Y1YzZEhsb2lwOTlqSXhYcDl6M2VGM3dZZnZDZHlYWVdpVWptNkh5?=
 =?utf-8?B?emZSYmtHdkZZWGhpakxoeTloK1VmQzJrODdiWVBVdEtpTHFMelZJamdwa0Vt?=
 =?utf-8?B?UW9ZMlFDQm1qZjhLWnh0OWsrR2s2SkpzNlhVa2FWeGdaZVp0VEI4bTBmdThK?=
 =?utf-8?B?RzN1TTRtakVZRTR6M0ZvVW4zTXd2R3R0UEkwNWo1UG8wYTR4aDRRSCs5amZt?=
 =?utf-8?B?ejRzdmV3Mk9KdXYrWGwvemNBSFYxMmhkeTc4WXpUZjl1SGdiQ2dyUGZ3clgz?=
 =?utf-8?B?U3VIaXBwNm80SEg0UGt6V25iUDBqR0dmcXhLTzZOQ1FqNTRhUkxkbG1jYlQ3?=
 =?utf-8?B?ci9UQnhiU215cTdJbk83b2I0MG91OXNIN2pMcjR5UEdLWHIzNjdvZjF0czkw?=
 =?utf-8?B?cENydDlSaVVXNjk0VDBqUkpXZnRjeTZMM05MZFVSemtuOFV2L0ppdEw1OWM5?=
 =?utf-8?B?azdsbkp0WTRjZEJ5WldleW9mUXFrVExMbTFrTUJReHFZYVptcEtmeWhuelBt?=
 =?utf-8?B?NHduNTlkcy9Yb2xJN2xCS0Z1bWNOT3VORmNhVm5tNlppcFdBZkwvUVF6L0gv?=
 =?utf-8?B?b0xHRWZUQ1hPRUIwdzgzTmZiQlNHdzRXWkNlVUNtR21Md0dIdnBHRWNZUTJ1?=
 =?utf-8?B?TTl1dHJaOHprSnRKMld5Q0VRN3JNMzdHNXMrSTRUREVRdVlxTU9BQkJBSy9U?=
 =?utf-8?B?bE1nN285TktuZnpUaitQaDlScXhFL0FCOEpaWHAwa3A0WDFUR3Y1SlM1QVNN?=
 =?utf-8?B?M3JhbWQ0eGRSUndtODFwYW9GNHo3aDVscm9sS1RtTEtwWjhjckZpendUa2pE?=
 =?utf-8?B?a0hsSmo2K3V5RTk1ZmZnUi95ZG1ZSVBKakJKNnlsVXhoYWVUNmxoeXRrRE9B?=
 =?utf-8?B?WWdFZ3MyOVhva0RXRnI0TVlDSlN0RUtWM1hUUXlFa1o3Z0hydE9nTWZYRVpo?=
 =?utf-8?B?WktaWFdXenRQNFdNd2ZVdEpnQXcxYkVJWlBqdmFjaWVRYURzcjQrWEx2SlpX?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c34b6f-8ba2-44e3-7562-08db7d7d69c2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 17:29:40.3266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWOyZKfZTqSHKAcg+iK12ZVGInEtKkLc0iS4Vn3eLWWY83Y7J/zTdEi1yOeFWVhmv5G/THWAx8NbiuF9+wrJQpjK2uHbBztME03Srt0IKaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6699
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 7/3/2023 6:50 PM, Yinjun Zhang wrote:
> On Tuesday, July 4, 2023 12:11 AM, Alexander Lobakin wrote:
>> From: Louis Peens <louis.peens@corigine.com>
>> Date: Mon,  3 Jul 2023 14:01:16 +0200
>>
>>> From: Yinjun Zhang <yinjun.zhang@corigine.com>
>>>
>>> When moving devices from one namespace to another, mc addresses are
>>> cleaned in software while not removed from application firmware. Thus
>>> the mc addresses are remained and will cause resource leak.
>>>
>>> Now use `__dev_mc_unsync` to clean mc addresses when closing port.
>>>
>>> Fixes: e20aa071cd95 ("nfp: fix schedule in atomic context when sync mc
>> address")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
>>> Acked-by: Simon Horman <simon.horman@corigine.com>
>>> Signed-off-by: Louis Peens <louis.peens@corigine.com>
>>> ---
>>> Changes since v1:
>>>
>>> * Use __dev_mc_unsyc to clean mc addresses instead of tracking mc
>> addresses by
>>>   driver itself.
>>> * Clean mc addresses when closing port instead of driver exits,
>>>   so that the issue of moving devices between namespaces can be fixed.
>>> * Modify commit message accordingly.
>>>
>>>  .../ethernet/netronome/nfp/nfp_net_common.c   | 171 +++++++++---------
>>>  1 file changed, 87 insertions(+), 84 deletions(-)
>>
>> [...]
>>
>>> +static int nfp_net_mc_sync(struct net_device *netdev, const unsigned char
>> *addr)
>>> +{
>>> +	struct nfp_net *nn = netdev_priv(netdev);
>>> +
>>> +	if (netdev_mc_count(netdev) > NFP_NET_CFG_MAC_MC_MAX) {
>>> +		nn_err(nn, "Requested number of MC addresses (%d)
>> exceeds maximum (%d).\n",
>>> +		       netdev_mc_count(netdev),
>> NFP_NET_CFG_MAC_MC_MAX);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	return nfp_net_sched_mbox_amsg_work(nn,
>> NFP_NET_CFG_MBOX_CMD_MULTICAST_ADD, addr,
>>> +					    NFP_NET_CFG_MULTICAST_SZ,
>> nfp_net_mc_cfg);
>>> +}
>>> +
>>> +static int nfp_net_mc_unsync(struct net_device *netdev, const unsigned
>> char *addr)
>>> +{
>>> +	struct nfp_net *nn = netdev_priv(netdev);
>>> +
>>> +	return nfp_net_sched_mbox_amsg_work(nn,
>> NFP_NET_CFG_MBOX_CMD_MULTICAST_DEL, addr,
>>> +					    NFP_NET_CFG_MULTICAST_SZ,
>> nfp_net_mc_cfg);
>>> +}
>>
>> You can just declare nfp_net_mc_unsync()'s prototype here, so that it
>> will be visible to nfp_net_netdev_close(), without moving the whole set
>> of functions. Either way works, but that one would allow avoiding big
>> diffs not really related to fixing things going through the net-fixes tree.
> 
> I didn't know which was preferred. Looks like minimum change is concerned
> more. I'll change it.
> 

net-next might prefer code re-ordering and avoiding the extra
declaration, but net would definitely want the smaller fix.

For what its worth, I double check this kind of thing by applying the
patch to my git tree and using git's "color moved lines" options to diff.

Doing so for this patch shows that the change really is a straight
forward re-ordering without any additional changes accidentally included.

Thus, I have no objection to this version as-is, but a smaller v3 with
the prototype is also fine with me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake

>>
>>> +
>>>  /**
>>>   * nfp_net_clear_config_and_disable() - Clear control BAR and disable NFP
>>>   * @nn:      NFP Net device to reconfigure
>>> @@ -1084,6 +1168,9 @@ static int nfp_net_netdev_close(struct net_device
>> *netdev)
>>>
>>>  	/* Step 2: Tell NFP
>>>  	 */
>>> +	if (nn->cap_w1 & NFP_NET_CFG_CTRL_MCAST_FILTER)
>>> +		__dev_mc_unsync(netdev, nfp_net_mc_unsync);
>>> +
>>>  	nfp_net_clear_config_and_disable(nn);
>>>  	nfp_port_configure(netdev, false);
>> [...]
>>
>> Thanks,
>> Olek
