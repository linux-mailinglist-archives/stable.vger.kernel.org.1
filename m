Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B177704B8
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 17:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjHDPba (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 11:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjHDPbQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 11:31:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03E95B94
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 08:30:10 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHV4F0wQczrS3D;
        Fri,  4 Aug 2023 23:29:01 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 23:30:06 +0800
Message-ID: <3288ffdc-51bb-6725-835d-a44db396f989@huawei.com>
Date:   Fri, 4 Aug 2023 23:30:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 5.15 0/6] Backporting for 5.15 test_verifier failed
Content-Language: en-US
To:     Luiz Capitulino <luizcap@amazon.com>
CC:     <stable@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
        Greg KH <greg@kroah.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Pu Lehui <pulehui@huaweicloud.com>
References: <20230804152459.2565673-1-pulehui@huaweicloud.com>
From:   Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20230804152459.2565673-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Luiz,

My local 5.15 environment is a little bit weird, could you help me to 
test it?

On 2023/8/4 23:24, Pu Lehui wrote:
> Luiz Capitulino reported the test_verifier test failed:
> "precise: ST insn causing spi > allocated_stack".
> And it was introduced by the following upstream commit:
> ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")
> 
> Eduard's investigation [4] shows that test failure is not a bug, but a
> difference in BPF verifier behavior between upstream, where commits
> [1,2,3] by Andrii are present, and 5.15, where these commits are absent.
> 
> Backporting strategy is consistent with Eduard in kernel version 6.1 [5],
> but with some conflicts in patch #1, #4 and #6 due to the bpf of 5.15
> doesn't support more features.
> 
> Commits of Andrii:
> [1] be2ef8161572 ("bpf: allow precision tracking for programs with subprogs")
> [2] f63181b6ae79 ("bpf: stop setting precise in current state")
> [3] 7a830b53c17b ("bpf: aggressively forget precise markings during state checkpointing")
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
>   kernel/bpf/verifier.c                         | 199 ++++++++++++++++--
>   .../testing/selftests/bpf/prog_tests/align.c  |  36 ++--
>   .../selftests/bpf/prog_tests/sk_assign.c      |  25 ++-
>   .../selftests/bpf/progs/connect4_prog.c       |   2 +-
>   .../selftests/bpf/progs/test_sk_assign.c      |  11 +
>   .../bpf/progs/test_sk_assign_libbpf.c         |   3 +
>   6 files changed, 243 insertions(+), 33 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c
> 
