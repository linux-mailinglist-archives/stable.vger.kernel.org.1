Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC4675D868
	for <lists+stable@lfdr.de>; Sat, 22 Jul 2023 02:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjGVAqC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 20:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGVAqB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 20:46:01 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B98E0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 17:46:00 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b974031aeaso17354891fa.0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 17:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689986759; x=1690591559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xs9D27aU/FDDmfLl9q8n5/a1Gk+zIvs4DaEFihML5lk=;
        b=lezWrbe3HWK8c1cnwH8gYk/B9OUQDSTG7Vp/7qpbnuqkBH3GPyvM927osW6+ZirKqC
         Y7shgw5hrzCw92Bivku7APiSwGFQB786I3mksaSL8aVwAUhcT8tEiK9T/mzF7MwcJosO
         PPudm+PSkdgb7cuoV3Zg/lQoNxDbfL/7dQdZ6bEQqqv+sgrYDelnjyrWYAUPLYq3rw8f
         ArIGrcpg3Q9vKldz5QQ8sunK1S5ZBfPQgViU4SnYp6gRbfOOn39XAWDS2jpMmwW1AM9Y
         Hx+08QEx99aXH91Zw0ZtE+m+vZtqvf4yBgJdvFCjE0Ll3CVXpZ3P8BK6Xs/80LuIsl7G
         RIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689986759; x=1690591559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xs9D27aU/FDDmfLl9q8n5/a1Gk+zIvs4DaEFihML5lk=;
        b=akcxwWjYDiJPi9Qz2s6MUo0hvdEzZw2fzU/iHd/jRRD4PCxuMkuxzHXRpRl+wCf7JM
         nAvcnIU10yovBahDy1ALAbYa82hP8aAyg5LaRd4dMllXX85GcilQX17PEgvJ2x0OaEyT
         b8EDLy0lYA4YCEbYSe/2fig+KD68LNaTws7Ws1HscX5bop9F9E6sH/JTx4qeZlAR1Gtg
         8Z3pJwGz5RAdKDC/4E83eruLhZ4NO+niWfiaHFUFEPKec8zj+JwMiRtFRm0Mccm90m+e
         u5DXUJgR2QCA7iRdTNGDzlrWu4OA5ez01OBl3NO6POm+tSJWwnuxX+za5e4+ptRU0IlW
         Ft+g==
X-Gm-Message-State: ABy/qLbsN29Te0Z5hEdPuX3XieQHSc3A34vNnPWgvUuPDzc7P2mz347n
        7/IaJcyCkOiSRERstu6Woyqbem38tqA=
X-Google-Smtp-Source: APBJJlHkbFKYfZjvXP6E366L7ymDi84aLnZa8BuKoqELae1SiqLgN9nR35FO35p3mKbzldier6DRuw==
X-Received: by 2002:a2e:850d:0:b0:2b4:7380:230 with SMTP id j13-20020a2e850d000000b002b473800230mr2846836lji.13.1689986758459;
        Fri, 21 Jul 2023 17:45:58 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j2-20020a2e8002000000b002b69febf515sm1224585ljg.125.2023.07.21.17.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 17:45:57 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     stable@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com, mykolal@fb.com, luizcap@amazon.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.1.y 0/6] BPF selftests fixes for 6.1 branch
Date:   Sat, 22 Jul 2023 03:45:08 +0300
Message-ID: <20230722004514.767618-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Recently Luiz Capitulino reported BPF test failure for kernel version
6.1.36 (see [7]). The following test_verifier test failed:
"precise: ST insn causing spi > allocated_stack".
After back-port of the following upstream commit:
ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")

Investigation in [8] shows that test failure is not a bug, but a
difference in BPF verifier behavior between upstream, where commits
[1,2,3] by Andrii Nakryiko are present, and 6.1.36, where these
commits are absent. Both Luiz and Greg suggested back-porting [1,2,3]
from upstream to avoid divergences.

Commits [1,2,3] break test_progs selftest "align/packet variable offset",
commit [4] fixes this selftest.

I did some additional testing using the following compiler versions:
- Kernel compilation
  - gcc version 11.3.0
- BPF tests compilation
  - clang version 16.0.6
  - clang version 17.0.0 (fa46feb31481)

And identified a few more failing BPF selftests:
- Tests failing with LLVM 16:
  - test_verifier:
    - precise: ST insn causing spi > allocated_stack FAIL (fixed by [1,2,3])
  - test_progs:
    - sk_assign                                           (fixed by [6])
- Tests failing with LLVM 17:
  - test_verifier:
    - precise: ST insn causing spi > allocated_stack FAIL (fixed by [1,2,3])
  - test_progs:
    - fexit_bpf2bpf/func_replace_verify                   (fixed by [5])
    - fexit_bpf2bpf/func_replace_return_code              (fixed by [5])
    - sk_assign                                           (fixed by [6])

Commits [4,5,6] only apply to BPF selftests and don't change verifier
behavior.

After applying all of the listed commits I have test_verifier,
test_progs, test_progs-no_alu32 and test_maps passing on my x86 setup,
both for LLVM 16 and LLVM 17.

Upstream commits in chronological order:
[1] be2ef8161572 ("bpf: allow precision tracking for programs with subprogs")
[2] f63181b6ae79 ("bpf: stop setting precise in current state")
[3] 7a830b53c17b ("bpf: aggressively forget precise markings during state checkpointing")
[4] 4f999b767769 ("selftests/bpf: make test_align selftest more robust")
[5] 63d78b7e8ca2 ("selftests/bpf: Workaround verification failure for fexit_bpf2bpf/func_replace_return_code")
[6] 7ce878ca81bc ("selftests/bpf: Fix sk_assign on s390x")

Links:
[7] https://lore.kernel.org/stable/935c4751-d368-df29-33a6-9f4fcae720fa@amazon.com/
[8] https://lore.kernel.org/stable/c9b10a8a551edafdfec855fbd35757c6238ad258.camel@gmail.com/

Reported-by: Luiz Capitulino <luizcap@amazon.com>

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

 kernel/bpf/verifier.c                         | 202 ++++++++++++++++--
 .../testing/selftests/bpf/prog_tests/align.c  |  38 ++--
 .../selftests/bpf/prog_tests/sk_assign.c      |  25 ++-
 .../selftests/bpf/progs/connect4_prog.c       |   2 +-
 .../selftests/bpf/progs/test_sk_assign.c      |  11 +
 .../bpf/progs/test_sk_assign_libbpf.c         |   3 +
 6 files changed, 247 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sk_assign_libbpf.c

-- 
2.41.0

