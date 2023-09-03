Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF83790D40
	for <lists+stable@lfdr.de>; Sun,  3 Sep 2023 19:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjICR3X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 3 Sep 2023 13:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345820AbjICR3V (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 3 Sep 2023 13:29:21 -0400
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129BCF9
        for <stable@vger.kernel.org>; Sun,  3 Sep 2023 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693762145; x=1725298145;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T9oPe7Oz1dqEpZGMgetHt+XPQ8QmWPBXIaXoqOeHKmM=;
  b=pP3Kw+P8VQSMR5F0NqbVd9oCEg5IuxIc2mzEgpL2qualzZQYr5B0MkzF
   WcQy39/1ss+pYpVKx7s1jjjcC8zHLeDfE6qNsED0yUzAr7GKEa3jjimjK
   PSnCez58c62oQEe2DBWIfbRlnoWlqCFsVW8g7Mk5wyNIePu6h5cqkMAvJ
   M=;
X-IronPort-AV: E=Sophos;i="6.02,225,1688428800"; 
   d="scan'208";a="670128187"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 17:28:59 +0000
Received: from EX19MTAUEC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com (Postfix) with ESMTPS id 0626480750;
        Sun,  3 Sep 2023 17:28:56 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sun, 3 Sep 2023 17:28:44 +0000
Received: from [192.168.199.102] (10.252.141.22) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Sun, 3 Sep 2023 17:28:42 +0000
Message-ID: <018ce439-26b3-eab0-27b7-db6a33a4fa15@amazon.com>
Date:   Sun, 3 Sep 2023 13:28:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATH 6.1.y 0/2] Backport KVM's nx_huge_pages=never module
 parameter
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <seanjc@google.com>,
        <christophe.jaillet@wanadoo.fr>, <lcapitulino@gmail.com>
References: <cover.1693593288.git.luizcap@amazon.com>
 <2023090211-tainted-gonad-f78f@gregkh>
Content-Language: en-US
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <2023090211-tainted-gonad-f78f@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.141.22]
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 2023-09-02 03:27, Greg KH wrote:

> 
> 
> 
> On Fri, Sep 01, 2023 at 06:34:51PM +0000, Luiz Capitulino wrote:
>> Hi,
>>
>> As part of the mitigation for the iTLB multihit vulnerability, KVM creates
>> a worker thread in KVM_CREATE_VM ioctl(). This thread calls
>> cgroup_attach_task_all() which takes cgroup_threadgroup_rwsem for writing
>> which may incur 100ms+ latency since upstream commit
>> 6a010a49b63ac8465851a79185d8deff966f8e1a.
>>
>> However, if the CPU is not vulnerable to iTLB multihit one could just
>> disable the mitigation (and the worker thread creation) with the
>> newly added KVM module parameter nx_huge_pages=never. This avoids the issue
>> altogether.
>>
>> While there's an alternative solution for this issue already supported
>> in 6.1-stable (ie. cgroup's favordynmods), disabling the mitigation in
>> KVM is probably preferable if the workload is not impacted by dynamic
>> cgroup operations since one doesn't need to decide between the trade-off
>> in using favordynmods, the thread creation code path is avoided at
>> KVM_CREATE_VM and you avoid creating a thread which does nothing.
>>
>> Tests performed:
>>
>> * Measured KVM_CREATE_VM latency and confirmed it goes down to less than 1ms
>> * We've been performing latency measurements internally w/ this parameter
>>    for some weeks now
> 
> What about the 6.4.y kernel for these changes?  Anyone moving from 6.1
> to 6.4 will have a regression, right?
> 
> Or you can wait a week or so for 6.4.y to go end-of-life, your choice :)

I can do this backport for 6.4.y if that's better for stable users. Will
submit the patches next week.

- Luiz

> 
> thanks,
> 
> greg k-h
