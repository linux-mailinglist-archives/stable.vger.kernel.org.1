Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A5B7D6C96
	for <lists+stable@lfdr.de>; Wed, 25 Oct 2023 15:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344332AbjJYNAt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 25 Oct 2023 09:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344354AbjJYNAp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Oct 2023 09:00:45 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED3B9F
        for <stable@vger.kernel.org>; Wed, 25 Oct 2023 06:00:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vuul-qK_1698238834;
Received: from 30.221.101.240(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Vuul-qK_1698238834)
          by smtp.aliyun-inc.com;
          Wed, 25 Oct 2023 21:00:35 +0800
Message-ID: <ea9b79ce-3618-454c-bea3-abb1c59e2eaf@linux.alibaba.com>
Date:   Wed, 25 Oct 2023 21:00:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 159/241] net/smc: support smc release version
 negotiation in clc handshake
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        huangjie.albert@bytedance.com
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Tony Lu <tonylu@linux.alibaba.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
References: <20231023104833.832874523@linuxfoundation.org>
 <20231023104837.750719920@linuxfoundation.org>
 <80669f40-3bc5-440e-9440-e153d12e37ef@linux.alibaba.com>
 <2023102521-undated-edition-d501@gregkh>
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <2023102521-undated-edition-d501@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 2023/10/25 18:08, Greg Kroah-Hartman wrote:
> On Mon, Oct 23, 2023 at 08:05:01PM +0800, Guangguan Wang wrote:
>> Hi, Greg.
>>
>> [PATCH 6.5 159/241] net/smc: support smc release version negotiation in clc handshake
>> [PATCH 6.5 160/241] net/smc: support smc v2.x features validate
>>
>> The above two patches should not backport to stable tree 6.5, which may result in unexpected
>> fallback if communication between 6.6 and 6.5(with these two patch) via SMC-R v2.1. The above
>> two patches should not exist individually without the patch 7f0620b9(net/smc: support max
>> connections per lgr negotiation) and the patch 69b888e3(net/smc: support max links per lgr 
>> negotiation in clc handshake).
>>
>> The patch c68681ae46ea ("net/smc: fix smc clc failed issue when netdevice not in init_net")
>> does not rely the feature SMC-R v2.1. But I think it may have conflict here when backport
>> to stable tree 6.5:
>>
>> @@ -1201,6 +1201,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>>  		(struct smc_clc_msg_accept_confirm_v2 *)aclc;
>>  	struct smc_clc_first_contact_ext *fce =
>>  		smc_get_clc_first_contact_ext(clc_v2, false);    --conflict here
>> +	struct net *net = sock_net(&smc->sk);
>>
>>
>> I think it is better to resolve the confilict rather than backport more patches.
>> The resolution of the conflict should be like:
>>
>> @@ -1201,6 +1201,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>>  		(struct smc_clc_msg_accept_confirm_v2 *)aclc;
>>   	struct smc_clc_first_contact_ext *fce =
>> 		(struct smc_clc_first_contact_ext *)
>> 			(((u8 *)clc_v2) + sizeof(*clc_v2));      --replace the line smc_get_clc_first_contact_ext(clc_v2, false);
>> +	struct net *net = sock_net(&smc->sk);
> 
> Thanks for letting me know.
> 
> I've dropped this patch entirely from the 6.5.y queue now (and the
> follow-on ones.)  Can you send a backported, and tested, set of patches
> to us for inclusion if you want this fixed up in the 6.5.y tree?  That
> way we make sure to get this done properly.
> 
> thanks,
> 
> greg k-h

I think it is more appropriate for Albert Huang, who is the author of the patch("net/smc: fix smc clc failed issue when
netdevice not in init_net"), to do this because he knows the background of the fix and how to test it.

Thanks,
Guangguan Wang

