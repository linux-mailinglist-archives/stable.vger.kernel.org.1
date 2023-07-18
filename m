Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A8B757EFE
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 16:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjGROHR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 10:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjGROHG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 10:07:06 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFAB1981
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 07:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689689226; x=1721225226;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3ATGcX8yVKStK7mHJZJJu4efaNzOkl3JlCdTVfuRZUA=;
  b=gb5kXddwARxxzhnDvXl4P5wiFPwVUwSZfNgJXg0ScgSej6CIkO0dUQQg
   ISzBSv1A17lAj/jgEgQMWStG2dx1AsflWt6FbEjPWMbeZjnHH4PDezp/b
   DB3uPwGMiecWz8PM1lkdYODPCxJoWGNCjwuwaqMQ4hy7jxPSttYkUfpdw
   w=;
X-IronPort-AV: E=Sophos;i="6.01,214,1684800000"; 
   d="scan'208";a="227471232"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:07:02 +0000
Received: from EX19MTAUEC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com (Postfix) with ESMTPS id D04F61008B6;
        Tue, 18 Jul 2023 14:07:00 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 14:06:49 +0000
Received: from [192.168.22.131] (10.106.179.5) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 14:06:47 +0000
Message-ID: <dd3ecb62-94ca-a08a-01f9-453fe0545ce8@amazon.com>
Date:   Tue, 18 Jul 2023 10:06:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [5.10, 5.15] New bpf kselftest failure
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "sashal@kernel.org" <sashal@kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        <ast@kernel.org>, <gilad.reti@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, andrii <andrii@kernel.org>
References: <935c4751-d368-df29-33a6-9f4fcae720fa@amazon.com>
 <76dfe02eea69141b662a3a399126dba9e00e5abe.camel@gmail.com>
 <9c7fc5ab-1c06-8452-2747-aa89e7a1dfb6@amazon.com>
 <c9b10a8a551edafdfec855fbd35757c6238ad258.camel@gmail.com>
 <bc521a2f24c416a658ab50685fbf647d4e069c8c.camel@gmail.com>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <bc521a2f24c416a658ab50685fbf647d4e069c8c.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.106.179.5]
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 2023-07-18 08:31, Eduard Zingerman wrote:

> 
> 
> 
> On Tue, 2023-07-18 at 01:57 +0300, Eduard Zingerman wrote:
>> [...]
>> Still, when I cherry-pick [0,1,2,3] `./test_progs -a setget_sockopt` is failing.
>> I'll investigate this failure but don't think I'll finish today.
>>
>> ---
>>
>> Alternatively, if the goal is to minimize amount of changes, we can
>> disable or modify the 'precise: ST insn causing spi > allocated_stack'.
>>
>> ---
>>
>> Commits (in chronological order):
>> [0] be2ef8161572 ("bpf: allow precision tracking for programs with subprogs")
>> [1] f63181b6ae79 ("bpf: stop setting precise in current state")
>> [2] 7a830b53c17b ("bpf: aggressively forget precise markings during state checkpointing")
>> [3] 4f999b767769 ("selftests/bpf: make test_align selftest more robust")
>> [4] 07d90c72efbe ("Merge branch 'BPF verifier precision tracking improvements'")
>> [5] ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")
> 
> I made a mistake, while resolving merge conflict for [0] yesterday.
> After correction the `./test_progs -a setget_sockopt` passes.
> I also noted that the following tests fail on v6.1.36:
> 
>    ./test_progs -a sk_assign,fexit_bpf2bpf
> 
> These tests are fixed by back-porting the following upstream commits:
> - 7ce878ca81bc ("selftests/bpf: Fix sk_assign on s390x")
> - 63d78b7e8ca2 ("selftests/bpf: Workaround verification failure for fexit_bpf2bpf/func_replace_return_code")
> 
> I pushed modified version of v6.1.36 to my github account, it has
> test_verifier, test_progs, test_progs-no_alu32 and test_maps passing
> (on my x86 setup):
> 
>    https://github.com/eddyz87/bpf/commits/v6.1.36-with-fixes
> 
> Do you need any additional actions from my side?

First, thank you very much for your work on this and getting the tests
passing on 6.1.

In terms of action items, have you checked this situation in 5.10 and
5.15? For 5.10, we also need 4237e9f4a96228ccc8a7abe5e4b30834323cd353
otherwise the bpf tests don't even build there.

Also, would you know if something important is broken for users or is
this just a small behavior difference between kernels?

- Luiz
