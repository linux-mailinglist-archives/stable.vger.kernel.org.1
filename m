Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8F577062D
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 18:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjHDQni (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 12:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjHDQnT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 12:43:19 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0D046B1
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691167398; x=1722703398;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+VA1KSTvgSzZlo47TfsIvpWc4S5sY6hYOUmAD4ECm+8=;
  b=XdomPadWPuDgpC8jK522aYwu4NZddffNpueFDa6swj9iir5FDwMud9SL
   jMx3JiqNpI+GXhSNMBHJrqR2L8J1Vf3IEOAE9ebbUA3zB65Z7RVFVpVmf
   RhFVfthbqgMa/KxIBrKX4sdo1lQaqCDEmLFjuaFTqItyJoDNG5w4dN02l
   A=;
X-IronPort-AV: E=Sophos;i="6.01,255,1684800000"; 
   d="scan'208";a="348647292"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 16:43:14 +0000
Received: from EX19MTAUEB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id 10DBC40DB5;
        Fri,  4 Aug 2023 16:43:11 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 4 Aug 2023 16:43:07 +0000
Received: from [192.168.7.140] (10.106.179.17) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 4 Aug 2023 16:43:06 +0000
Message-ID: <76670af5-7d7c-213c-11ac-0494b1985243@amazon.com>
Date:   Fri, 4 Aug 2023 12:43:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 5.15 0/6] Backporting for 5.15 test_verifier failed
To:     Pu Lehui <pulehui@huawei.com>
CC:     <stable@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
        Greg KH <greg@kroah.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Pu Lehui <pulehui@huaweicloud.com>
References: <20230804152459.2565673-1-pulehui@huaweicloud.com>
 <3288ffdc-51bb-6725-835d-a44db396f989@huawei.com>
Content-Language: en-US
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <3288ffdc-51bb-6725-835d-a44db396f989@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.106.179.17]
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 2023-08-04 11:30, Pu Lehui wrote:

> 
> 
> 
> Hi Luiz,
> 
> My local 5.15 environment is a little bit weird, could you help me to
> test it?

I'll give this a try, but unfortunately I'm not sure I'll be able to
get back to you before mid next week.

- Luiz

> 
> On 2023/8/4 23:24, Pu Lehui wrote:
>> Luiz Capitulino reported the test_verifier test failed:
>> "precise: ST insn causing spi > allocated_stack".
>> And it was introduced by the following upstream commit:
>> ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")
>>
>> Eduard's investigation [4] shows that test failure is not a bug, but a
>> difference in BPF verifier behavior between upstream, where commits
>> [1,2,3] by Andrii are present, and 5.15, where these commits are absent.
>>
>> Backporting strategy is consistent with Eduard in kernel version 6.1 [5],
>> but with some conflicts in patch #1, #4 and #6 due to the bpf of 5.15
>> doesn't support more features.
>>
>> Commits of Andrii:
>> [1] be2ef8161572 ("bpf: allow precision tracking for programs with subprogs")
>> [2] f63181b6ae79 ("bpf: stop setting precise in current state")
>> [3] 7a830b53c17b ("bpf: aggressively forget precise markings during state checkpointing")
>>
>> Links:
>> [4] https://lore.kernel.org/stable/c9b10a8a551edafdfec855fbd35757c6238ad258.camel@gmail.com/
>> [5] https://lore.kernel.org/all/20230724124223.1176479-2-eddyz87@gmail.com/
>>
>> Andrii Nakryiko (4):
>>    bpf: allow precision tracking for programs with subprogs
>>    bpf: stop setting precise in current state
>>    bpf: aggressively forget precise markings during state checkpointing
>>    selftests/bpf: make test_align selftest more robust
>>
>> Ilya Leoshkevich (1):
>>    selftests/bpf: Fix sk_assign on s390x
>>
>> Yonghong Song (1):
>>    selftests/bpf: Workaround verification failure for
>>      fexit_bpf2bpf/func_replace_return_code
>>
>>   kernel/bpf/verifier.c                         | 199 ++++++++++++++++--
>>   .../testing/selftests/bpf/prog_tests/align.c  |  36 ++--
>>   .../selftests/bpf/prog_tests/sk_assign.c      |  25 ++-
>>   .../selftests/bpf/progs/connect4_prog.c       |   2 +-
>>   .../selftests/bpf/progs/test_sk_assign.c      |  11 +
>>   .../bpf/progs/test_sk_assign_libbpf.c         |   3 +
>>   6 files changed, 243 insertions(+), 33 deletions(-)
>>   create mode 100644 tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c
>>
