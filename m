Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAAA757FCB
	for <lists+stable@lfdr.de>; Tue, 18 Jul 2023 16:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjGROkK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 18 Jul 2023 10:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGROkJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 18 Jul 2023 10:40:09 -0400
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B35FD
        for <stable@vger.kernel.org>; Tue, 18 Jul 2023 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689691209; x=1721227209;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MspmtSiYKHwxYL13TKZpCOH0DuS4tJ1OuIZD9qpRjQ4=;
  b=IHTrTTF6jund8Fc/0MY/S8wFdmG5UuUIxQ/7xTmDe68mnB07PIgeEDRc
   zfoBGZk71wY2nRrcFEG+y9gx5tOFbL3njaFGltYn6n85wNsFt0OMu9Key
   nDMMXueb7EF6yKAbgOVnh2EWJaP5SpIYHnX54ciIYqXe3tN/1xNE22CE3
   4=;
X-IronPort-AV: E=Sophos;i="6.01,214,1684800000"; 
   d="scan'208";a="572786168"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:40:06 +0000
Received: from EX19MTAUEB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com (Postfix) with ESMTPS id BCB6FA2A51;
        Tue, 18 Jul 2023 14:40:04 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 14:40:03 +0000
Received: from [192.168.22.131] (10.106.179.5) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 14:40:01 +0000
Message-ID: <967420e1-d23c-a106-3d66-d03a0b400a2e@amazon.com>
Date:   Tue, 18 Jul 2023 10:39:58 -0400
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
 <dd3ecb62-94ca-a08a-01f9-453fe0545ce8@amazon.com>
 <ea1c9d1b9e120bdb8c42b2daefa6d11167208dd9.camel@gmail.com>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <ea1c9d1b9e120bdb8c42b2daefa6d11167208dd9.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.106.179.5]
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 2023-07-18 10:35, Eduard Zingerman wrote:

> 
> 
> 
> On Tue, 2023-07-18 at 10:06 -0400, Luiz Capitulino wrote:
>>
>> On 2023-07-18 08:31, Eduard Zingerman wrote:
>>
>>>
>>>
>>>
>>> On Tue, 2023-07-18 at 01:57 +0300, Eduard Zingerman wrote:
>>>> [...]
>>>> Still, when I cherry-pick [0,1,2,3] `./test_progs -a setget_sockopt` is failing.
>>>> I'll investigate this failure but don't think I'll finish today.
>>>>
>>>> ---
>>>>
>>>> Alternatively, if the goal is to minimize amount of changes, we can
>>>> disable or modify the 'precise: ST insn causing spi > allocated_stack'.
>>>>
>>>> ---
>>>>
>>>> Commits (in chronological order):
>>>> [0] be2ef8161572 ("bpf: allow precision tracking for programs with subprogs")
>>>> [1] f63181b6ae79 ("bpf: stop setting precise in current state")
>>>> [2] 7a830b53c17b ("bpf: aggressively forget precise markings during state checkpointing")
>>>> [3] 4f999b767769 ("selftests/bpf: make test_align selftest more robust")
>>>> [4] 07d90c72efbe ("Merge branch 'BPF verifier precision tracking improvements'")
>>>> [5] ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")
>>>
>>> I made a mistake, while resolving merge conflict for [0] yesterday.
>>> After correction the `./test_progs -a setget_sockopt` passes.
>>> I also noted that the following tests fail on v6.1.36:
>>>
>>>     ./test_progs -a sk_assign,fexit_bpf2bpf
>>>
>>> These tests are fixed by back-porting the following upstream commits:
>>> - 7ce878ca81bc ("selftests/bpf: Fix sk_assign on s390x")
>>> - 63d78b7e8ca2 ("selftests/bpf: Workaround verification failure for fexit_bpf2bpf/func_replace_return_code")
>>>
>>> I pushed modified version of v6.1.36 to my github account, it has
>>> test_verifier, test_progs, test_progs-no_alu32 and test_maps passing
>>> (on my x86 setup):
>>>
>>>     https://github.com/eddyz87/bpf/commits/v6.1.36-with-fixes
>>>
>>> Do you need any additional actions from my side?
>>
>> First, thank you very much for your work on this and getting the tests
>> passing on 6.1.
> 
> Thank you.
> 
>> In terms of action items, have you checked this situation in 5.10 and
>> 5.15? For 5.10, we also need 4237e9f4a96228ccc8a7abe5e4b30834323cd353
>> otherwise the bpf tests don't even build there.
> 
> Haven't checked 5.15/5.10, will take a look.
> Are there any time-frame limitations?
> (I'd like to work on this on Wednesday or Thursday)

Since, as you explain below, this is not a impactful regression to stable
users, I think that's fine.

>> Also, would you know if something important is broken for users or is
>> this just a small behavior difference between kernels?
> 
> I think it's more like small behavior difference:
> - be2ef8161572, f63181b6ae79, 7a830b53c17b are verification
>    scalability optimizations, with these patches it is possible
>    to load a bit more complex programs (larger programs, or more
>    complex branching patterns).
> - 4f999b767769, 7ce878ca81bc, 63d78b7e8ca2 - fixes for selftests,
>    no new functionality.

Thanks for clarifying it!

- Luiz

> 
> Thanks,
> Eduard
