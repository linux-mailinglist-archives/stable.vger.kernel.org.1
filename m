Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BEE76D7B2
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 21:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjHBT2P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 15:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHBT2O (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 15:28:14 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2759199F
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691004493; x=1722540493;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fa84hNPgKijtfa9WwHljmiMvasfeqi6OZYpTHwoaVUQ=;
  b=hVjorigx4DZ5VB6NJKoZdr/YTdZUojeRD2lMK7qUvGGRjTr9ntBVsn2A
   XPPrGJfRAbJ6IbweEPx3dM/Voiho2D1uVOfEkk5r/YvAi1gh+XeKEohZ5
   0zKLi55xsnnEaMOPR2UwM9c9DQcf/svOvL5OXKu2epl6PwFu3YGRqfK8G
   A=;
X-IronPort-AV: E=Sophos;i="6.01,249,1684800000"; 
   d="scan'208";a="20174800"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 19:28:11 +0000
Received: from EX19MTAUEB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com (Postfix) with ESMTPS id 60D8BA28CF;
        Wed,  2 Aug 2023 19:28:09 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 19:28:07 +0000
Received: from [192.168.0.224] (10.106.179.26) by
 EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 19:28:05 +0000
Message-ID: <e635cac7-9dc4-f54d-bc12-3bf3401ce97f@amazon.com>
Date:   Wed, 2 Aug 2023 15:28:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.10 0/6] Backporting for test_verifier failed
Content-Language: en-US
To:     Pu Lehui <pulehui@huaweicloud.com>, <stable@vger.kernel.org>,
        Greg KH <greg@kroah.com>, Eduard Zingerman <eddyz87@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Pu Lehui <pulehui@huawei.com>
References: <20230801143700.1012887-1-pulehui@huaweicloud.com>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <20230801143700.1012887-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.106.179.26]
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



On 2023-08-01 10:36, Pu Lehui wrote:

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
> doesn't support more features. Both test_verifier and test_maps have
> passed, while test_progs and test_progs-no_alu32 with no new failure
> ceses.

I tested this one today on top of 5.10.188.

Before this series:

   # #760/p precise: ST insn causing spi > allocated_stack FAIL
   # Summary: 1192 PASSED, 546 SKIPPED, 1 FAILED

With this series applied:

  # Summary: 1193 PASSED, 546 SKIPPED, 0 FAILED

Thank you very much Pu and Eduard for your work on this. Unfortunately,
I haven't been able to test the 6.1 series yet (it may take a bit before
I can do it).

Tested-by: Luiz Capitulino <luizcap@amazon.com>

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
