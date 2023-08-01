Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C4976B7C4
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 16:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjHAOhs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbjHAOhq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 10:37:46 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273D419B7
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 07:37:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RFd4L5vgSz4f3mHN
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 22:37:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP1 (Coremail) with SMTP id cCh0CgBnwRuwGMlkGuIaOg--.36375S2;
        Tue, 01 Aug 2023 22:37:38 +0800 (CST)
From:   Pu Lehui <pulehui@huaweicloud.com>
To:     stable@vger.kernel.org, Greg KH <greg@kroah.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Luiz Capitulino <luizcap@amazon.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH 5.10 0/6] Backporting for test_verifier failed
Date:   Tue,  1 Aug 2023 22:36:54 +0800
Message-Id: <20230801143700.1012887-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBnwRuwGMlkGuIaOg--.36375S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18KryUCF13JryrGFWUCFg_yoW8uFWkpa
        y8t3W5KF95GFy3Ww4xCrW7Wa4Fq3Z5Jw15Gr1fJryrZr45JF18trWxKFy3AwnxArZag34r
        Z34jvFs8WayUAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Luiz Capitulino reported the test_verifier test failed:
"precise: ST insn causing spi > allocated_stack".
And it was introduced by the following upstream commit:
ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")

Eduard's investigation [4] shows that test failure is not a bug, but a
difference in BPF verifier behavior between upstream, where commits
[1,2,3] by Andrii are present, and 5.10, where these commits are absent.

Backporting strategy is consistent with Eduard in kernel version 6.1 [5],
but with some conflicts in patch #1, #4 and #6 due to the bpf of 5.10
doesn't support more features. Both test_verifier and test_maps have
passed, while test_progs and test_progs-no_alu32 with no new failure
ceses.

Commits of Andrii:
[1] be2ef8161572 ("bpf: allow precision tracking for programs with subprogs")
[2] f63181b6ae79 ("bpf: stop setting precise in current state")
[3] 7a830b53c17b ("bpf: aggressively forget precise markings during state checkpointing")

Links:
[4] https://lore.kernel.org/stable/c9b10a8a551edafdfec855fbd35757c6238ad258.camel@gmail.com/
[5] https://lore.kernel.org/all/20230724124223.1176479-2-eddyz87@gmail.com/

Andrii Nakryiko (4):
  bpf: allow precision tracking for programs with subprogs
  bpf: stop setting precise in current state
  bpf: aggressively forget precise markings during state checkpointing
  selftests/bpf: make test_align selftest more robust

Ilya Leoshkevich (1):
  selftests/bpf: Fix sk_assign on s390x

Yonghong Song (1):
  selftests/bpf: Workaround verification failure for
    fexit_bpf2bpf/func_replace_return_code

 kernel/bpf/verifier.c                         | 175 ++++++++++++++++--
 .../testing/selftests/bpf/prog_tests/align.c  |  36 ++--
 .../selftests/bpf/prog_tests/sk_assign.c      |  25 ++-
 .../selftests/bpf/progs/connect4_prog.c       |   2 +-
 .../selftests/bpf/progs/test_sk_assign.c      |  11 ++
 .../bpf/progs/test_sk_assign_libbpf.c         |   3 +
 6 files changed, 219 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c

-- 
2.25.1

