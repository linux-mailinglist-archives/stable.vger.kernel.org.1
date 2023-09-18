Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF78F7A5325
	for <lists+stable@lfdr.de>; Mon, 18 Sep 2023 21:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjIRTeR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 18 Sep 2023 15:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjIRTeR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 18 Sep 2023 15:34:17 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB485109
        for <stable@vger.kernel.org>; Mon, 18 Sep 2023 12:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695065652; x=1726601652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+w3skUkZXI4TunVctalSlkq6A9lYHj+msMEV/9PAkQY=;
  b=JyCVLktgYcGeVclHHtXtSU27QTFb2CQEJUoS0hHTewo3RcMYKEJw6QMO
   pd3yNmaT8nL0nYrTGGRTBhuQ3GfP2V99+JBz0iyhG/1YmUlC+SOw5PkEB
   BafOqUnMox6kOummNus9nO6XZ013MWJF40DioRc9hHz7RyYsilireAST+
   E=;
X-IronPort-AV: E=Sophos;i="6.02,157,1688428800"; 
   d="scan'208";a="239812842"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 19:34:09 +0000
Received: from EX19MTAUEB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com (Postfix) with ESMTPS id CA714A0984;
        Mon, 18 Sep 2023 19:34:06 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 18 Sep 2023 19:34:05 +0000
Received: from [192.168.203.148] (10.252.141.29) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 18 Sep 2023 19:34:03 +0000
Message-ID: <89013759-7af3-cda3-3615-23d4ec957595@amazon.com>
Date:   Mon, 18 Sep 2023 15:34:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATH 4.14.y] net/sched: cls_fw: No longer copy tcf_result on
 update to avoid use-after-free
Content-Language: en-US
To:     valis <sec@valis.email>
CC:     <stable@vger.kernel.org>,
        Bing-Jhong Billy Jheng <billy@starlabs.sg>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Victor Nogueira <victor@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        M A Ramdhan <ramdhan@starlabs.sg>,
        Jakub Kicinski <kuba@kernel.org>
References: <20230918180859.24397-1-luizcap@amazon.com>
 <CAEBa_SCoUVCwVAZOtYfdtinbnF85-0fCYVbT-KAiBi4f75fWtQ@mail.gmail.com>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <CAEBa_SCoUVCwVAZOtYfdtinbnF85-0fCYVbT-KAiBi4f75fWtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.141.29]
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 2023-09-18 15:17, valis wrote:

> On Mon, Sep 18, 2023 at 8:09 PM Luiz Capitulino <luizcap@amazon.com> wrote:
> 
>> Valis, Greg,
>>
>> I noticed that 4.14 is missing this fix while we backported all three fixes
>> from this series to all stable kernels:
>>
>> https://lore.kernel.org/all/20230729123202.72406-1-jhs@mojatatu.com
>>
>> Is there a reason to have skipped 4.14 for this fix? It seems we need it.
> 
> Hi Luiz!
> 
> I see no reason why it should be skipped for 4.14
> I've just checked 4.14.325 - it is vulnerable and needs this fix.

Thank you for the quick reply!

- Luiz

> 
> Best regards,
> 
> valis
> 
> 
>>
>> This is only compiled-tested though, would be good to have a confirmation
>> from Valis that the issue is present on 4.14 before applying.
>>
>> - Luiz
>>
>> diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
>> index e63f9c2e37e5..7b04b315b2bd 100644
>> --- a/net/sched/cls_fw.c
>> +++ b/net/sched/cls_fw.c
>> @@ -281,7 +281,6 @@ static int fw_change(struct net *net, struct sk_buff *in_skb,
>>                          return -ENOBUFS;
>>
>>                  fnew->id = f->id;
>> -               fnew->res = f->res;
>>   #ifdef CONFIG_NET_CLS_IND
>>                  fnew->ifindex = f->ifindex;
>>   #endif /* CONFIG_NET_CLS_IND */
>> --
>> 2.40.1
>>
