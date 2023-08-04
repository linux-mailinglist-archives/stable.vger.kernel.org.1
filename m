Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F6F77047F
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 17:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjHDP0k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 11:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjHDP0S (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 11:26:18 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48A55592
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 08:25:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RHV0374WSz4f3lY5
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 23:25:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP1 (Coremail) with SMTP id cCh0CgB30hxkGM1kpNz_Og--.43554S2;
        Fri, 04 Aug 2023 23:25:25 +0800 (CST)
From:   Pu Lehui <pulehui@huaweicloud.com>
To:     stable@vger.kernel.org, Greg KH <greg@kroah.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Luiz Capitulino <luizcap@amazon.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH 5.10 v2 0/6] Backporting for 5.10 test_verifier failed
Date:   Fri,  4 Aug 2023 23:24:45 +0800
Message-Id: <20230804152451.2565608-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgB30hxkGM1kpNz_Og--.43554S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18KryUCF13JryrGFWUCFg_yoW8Zw1Upa
        y8t3W5KF95GFy3Gw4xCrZ7WFyFv3Z5Jw15Gr1fJr18Zr45JF18Jr4IkFy3ZwnxArZag34F
        vryjvrs8uayUAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
doesn't support more features.

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

