Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB134776303
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 16:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjHIOvp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 10:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjHIOvp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 10:51:45 -0400
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F522107
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691592705; x=1723128705;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lfYvmANeEjKHH7Rf6KvGbjOF1TuP0e7EZDuDT6eZzeQ=;
  b=lP6Ec3MpjKKKrRIuMDXqY1D2tFalA0qIGXqfYqmKu4LNsht68lCOzu4U
   23SdtGh8JOClrMNKXhz4XZ6hOWlJmI55SnJOTVtw5oUnDurco7Cc/6vlB
   CngYOeQT1MfrV9cPi81L+MB/EMiq5JqM4NGyRkStFerVF93igoJ9eXhhh
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,159,1684800000"; 
   d="scan'208";a="576904592"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 14:51:41 +0000
Received: from EX19MTAUEC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id 779D240D73;
        Wed,  9 Aug 2023 14:51:39 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 14:51:38 +0000
Received: from [192.168.211.240] (10.252.141.29) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 14:51:36 +0000
Message-ID: <634a059c-1fd7-29a7-8cd9-0af5959939a0@amazon.com>
Date:   Wed, 9 Aug 2023 10:51:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 5.10 v2 0/6] Backporting for 5.10 test_verifier failed
Content-Language: en-US
To:     Pu Lehui <pulehui@huaweicloud.com>, <stable@vger.kernel.org>,
        Greg KH <greg@kroah.com>, Eduard Zingerman <eddyz87@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Pu Lehui <pulehui@huawei.com>
References: <20230804152451.2565608-1-pulehui@huaweicloud.com>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <20230804152451.2565608-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.141.29]
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 2023-08-04 11:24, Pu Lehui wrote:

> 
> 
> 
> Luiz Capitulino reported the test_verifier test failed:
> "precise: ST insn causing spi > allocated_stack".
> And it was introduced by the following upstream commit:
> ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")
> 
> Eduard's investigation [4] shows that test failure is not a bug, but a
> difference in BPF verifier behavior between upstream, where commits
> [1,2,3] by Andrii are present, and 5.10, where these commits are absent.
> 
> Backporting strategy is consistent with Eduard in kernel version 6.1 [5],
> but with some conflicts in patch #1, #4 and #6 due to the bpf of 5.10
> doesn't support more features.
> 
> Commits of Andrii:
> [1] be2ef8161572 ("bpf: allow precision tracking for programs with subprogs")
> [2] f63181b6ae79 ("bpf: stop setting precise in current state")
> [3] 7a830b53c17b ("bpf: aggressively forget precise markings during state checkpointing")

I don't see this one applied yet, in case it's missing my testing:

Tested-by: Luiz Capitulino <luizcap@amazon.com>

> 
> Links:
> [4] https://lore.kernel.org/stable/c9b10a8a551edafdfec855fbd35757c6238ad258.camel@gmail.com/
> [5] https://lore.kernel.org/all/20230724124223.1176479-2-eddyz87@gmail.com/
> 
> Andrii Nakryiko (4):
>    bpf: allow precision tracking for programs with subprogs
>    bpf: stop setting precise in current state
>    bpf: aggressively forget precise markings during state checkpointing
>    selftests/bpf: make test_align selftest more robust
> 
> Ilya Leoshkevich (1):
>    selftests/bpf: Fix sk_assign on s390x
> 
> Yonghong Song (1):
>    selftests/bpf: Workaround verification failure for
>      fexit_bpf2bpf/func_replace_return_code
> 
>   kernel/bpf/verifier.c                         | 175 ++++++++++++++++--
>   .../testing/selftests/bpf/prog_tests/align.c  |  36 ++--
>   .../selftests/bpf/prog_tests/sk_assign.c      |  25 ++-
>   .../selftests/bpf/progs/connect4_prog.c       |   2 +-
>   .../selftests/bpf/progs/test_sk_assign.c      |  11 ++
>   .../bpf/progs/test_sk_assign_libbpf.c         |   3 +
>   6 files changed, 219 insertions(+), 33 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c
> 
> --
> 2.25.1
> 
