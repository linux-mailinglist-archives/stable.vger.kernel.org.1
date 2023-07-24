Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837F575F68B
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 14:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjGXMmi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 08:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGXMmh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 08:42:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18774EA
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 05:42:36 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98df3dea907so682496766b.3
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 05:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690202554; x=1690807354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fO2YG8nW8mvY6hNYPJQVh9kEAqrBQdvVfFZAX9P/Y7k=;
        b=ZcaPhrnTldvghpU0vIPWYcbHKHmNJYJJsrEpaSz0p+dUJykyzkYTLXp8rrk2XDKyL/
         tHA/xVq1QuFbD4nEfnuGg324JdKBkXwd6zE2Zu1jxP0MTsxNlOtSCDkXp8T8ldlbZuXU
         FY5TfvwgITVLxmOlMF01coaazT2o4WupMJ9v8HWGPvWe238N2CVrs6qtxXM5ebNTpQ0I
         jgPbmjXP01qlSDgUDTA7pYo2ngs3Xi5B48LitNKW+fpjlA3CjtiFmf6lo00FP3S4e4gA
         P4PCjOIvA3z/4c03JRKjG9GVp2KauagNHZgQthczBzgEFpEDEHVDl0ndvH63Nkh2FeP8
         VXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690202554; x=1690807354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fO2YG8nW8mvY6hNYPJQVh9kEAqrBQdvVfFZAX9P/Y7k=;
        b=cdiB55HfkDGyAWsQym5lvdqcSGRlQqQRcmTbCDiUiErAu/PLTSqbGHwazayqJNbn+8
         JwmO03YIZ4wxEx/i0oe4CT+nb4dL4KzSvCDO18rbzrQ+zeVceZEa1Q3frYctbLbpt0k3
         ZAAP1OUXDk5pB324gwb76S2RDnG6i1ZIXT8PXd75+OFZ/Zre7LBVBVA4gIGuptMWAzDN
         aDiH0g7JHOmN0I0zq1y+Nyrjb9jrr91Sm+7C//ihrxYRKbzS9lJHgDb7R+d6mXXWQ2Ag
         b24N/mDmOYJqOOBf6FOcpcHcQFP252C8bhdifnIGQba2+nfcHTx++trm7tulE1OPXSF/
         bABw==
X-Gm-Message-State: ABy/qLZH68J0SeBTF0QglHuP6pEhOtJ/SANjyzzQM7LznX3w1MrkWr3z
        85+wQ614L5eJmYIXIOVmjK1PZQjfu44=
X-Google-Smtp-Source: APBJJlGi0sncQtDxGxvnn1rx1Qbn3T3mWr1Cd9Of+G3gDz0BmTjJt7pl80gGBxGWVEymWvNzIpnWWg==
X-Received: by 2002:a17:906:8468:b0:991:e17c:f8fa with SMTP id hx8-20020a170906846800b00991e17cf8famr9284751ejc.61.1690202553886;
        Mon, 24 Jul 2023 05:42:33 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709062b0600b0099297782aa9sm6628490ejg.49.2023.07.24.05.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 05:42:33 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     stable@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com, mykolal@fb.com, luizcap@amazon.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.1.y v2 0/6] BPF selftests fixes for 6.1 branch
Date:   Mon, 24 Jul 2023 15:42:17 +0300
Message-ID: <20230724124223.1176479-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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

Changelog:
  V1 -> V2: added missing signed-off-by tags
  V1: https://lore.kernel.org/stable/20230722004514.767618-1-eddyz87@gmail.com/

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

