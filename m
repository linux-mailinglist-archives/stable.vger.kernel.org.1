Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A74B78F310
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 21:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjHaTHl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 15:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347121AbjHaTHk (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 15:07:40 -0400
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DAFE65
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693508858; x=1725044858;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=gsFNpv5zZJVRNl1Pflvx15Ararl81nw7oojjZ/8dhU0=;
  b=U8UjQNUuy2qpQahbHmyTYqJr5GdLV16sYjunlmUKUoyvN1C6UvpzMTEE
   9ZCmi8vrXrIlk7RXWzoJRDBk57R/uH4gPFCfsgoCNK5ZiHDwnj3V9Pn/i
   57VsrjQjo5CBE+vrZzy0uTHU6cIxO/bW1P9PDL1VGenri/Sb5rzic7yaB
   k=;
X-IronPort-AV: E=Sophos;i="6.02,217,1688428800"; 
   d="scan'208";a="669738483"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 19:07:31 +0000
Received: from EX19MTAUEC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id 36E58A3730;
        Thu, 31 Aug 2023 19:07:28 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 31 Aug 2023 19:07:27 +0000
Received: from [192.168.9.185] (10.106.178.24) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 31 Aug 2023 19:07:25 +0000
Message-ID: <2211557e-2f16-9752-2d47-56e5fb5ec02c@amazon.com>
Date:   Thu, 31 Aug 2023 15:07:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATH 6.1.y 0/5] Backport "sched cpuset: Bring back cpuset_mutex"
Content-Language: en-US
From:   Luiz Capitulino <luizcap@amazon.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <juri.lelli@redhat.com>,
        <longman@redhat.com>, <neelx@redhat.com>, <tj@kernel.org>,
        <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <lcapitulino@gmail.com>
References: <cover.1693505570.git.luizcap@amazon.com>
 <2023083107-agent-overload-e3e7@gregkh>
 <7d4dac9e-a95a-1dcc-4723-79de0097e26f@amazon.com>
In-Reply-To: <7d4dac9e-a95a-1dcc-4723-79de0097e26f@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.106.178.24]
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 2023-08-31 14:31, Luiz Capitulino wrote:
> 
> 
> On 2023-08-31 14:22, Greg KH wrote:
> 
>>
>>
>>
>> On Thu, Aug 31, 2023 at 06:13:01PM +0000, Luiz Capitulino wrote:
>>> Hi,
>>>
>>> When using KVM on systems that require iTLB multihit mitigation enabled[1],
>>> we're observing very high latency (70ms+) in KVM_CREATE_VM ioctl() in 6.1
>>> kernel in comparison to older stable kernels such as 5.10. This is true even
>>> when using favordynmods mount option.
>>>
>>> We debugged this down to the cpuset controller trying to acquire cpuset_rwsem
>>> in cpuset_can_attach(). This happens because KVM creates a worker thread which
>>> calls cgroup_attach_task_all() during KVM_CREATE_VM. I don't know if
>>> favordynmods is supposed to cover this case or not, but removing cpuset_rwsem
>>> certainly solves the issue.
>>>
>>> For the backport I tried to pick as many dependent commits as required to avoid
>>> conflicts. I would highly appreciate review from cgroup people.
>>>
>>> Tests performed:
>>>   * Measured latency in KVM_CREATE_VM ioctl(), it goes down to less than 1ms
>>>   * Ran the cgroup kselftest tests, got same results with or without this series
>>>      * However, some tests such as test_memcontrol and test_kmem are failing
>>>        in 6.1. This probably needs to be looked at
>>>      * To make test_cpuset_prs.sh work, I had to increase the timeout on line
>>>        592 to 1 second. With this change, the test runs and passes
>>>   * I run our downstream test suite against our downstream 6.1 kernel with this
>>>     series applied, it passed
>>>
>>>   [1] For the case where the CPU is not vulnerable to iTLB multihit we can
>>>       simply disable the iTLB multihit mitigation in KVM which avoids this
>>>       whole situation. Disabling the mitigation is possible since upstream
>>>       commit 0b210faf337 which I plan to backport soon
>>
>> Please try 6.1.50, I think you will find that this issue is resolved
>> there, right?
> 
> It should, since the most important is dropping cpuset_rwsem from
> cpuset. I'll double check to be sure.

Quick test passed. We'll be doing more testing in the next days and I'll
report if there are any issues.

- Luiz

> 
> Thank you very much for the quick reply. I queued this series before my
> vacation and didn't check back before sending it today.
> 
> - Luiz
> 
>>
>> if not, please rebase your series on top of that, as obviously, it does
>> not still apply anymore.
>>
>> thanks,
>>
>> greg k-h
