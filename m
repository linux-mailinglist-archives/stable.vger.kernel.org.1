Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4069275D86D
	for <lists+stable@lfdr.de>; Sat, 22 Jul 2023 02:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGVAqI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 20:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjGVAqH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 20:46:07 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39311E0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 17:46:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b700e85950so35994861fa.3
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 17:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689986764; x=1690591564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goYljPtd9v7gauXSTi0Rm5GCr4F7UWetlAeeeGfKqtE=;
        b=qu4M0RpzJnCZiTN+9+H7pZHqYFaArJp3TJFEwfxKxnE/R5mqKRyvVCYrhrHD817DNt
         5JIUqUzLPEcQxT16ui3V+5FtcJlbRoIufb45eFDYMwsfW8m6g3gj5HCfmoAdqf/UK/pE
         hXU6lX6dBedixaRSnMwlMT3P0JFxMTf5S9IJN3Xc8CfgJTcgVGWUQkDhK41vJClKv4Zi
         fJGPivXy9JmEmtG7XbdtU7TdONSgLT0evTdmm6ChQKtbvf0VWHzcq5P7FCKEtMNGXer/
         /SxgSL+w2cohcBMSZmSCoOfkCk1WdoaMk3jXfmqjvT+dU/MBaJwbw5niaT1YOxojo3Q9
         noug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689986764; x=1690591564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goYljPtd9v7gauXSTi0Rm5GCr4F7UWetlAeeeGfKqtE=;
        b=SCvguYBks0+Ya5tOxoHqT8zCY6jjIlKStaZ34BIOhjw4whM82pSMURLPYmb6GJ2/CW
         oCHAggPQSL6kd08EHUmKFZcQMSWsLbptXMmTGd7op86Vz+zozkUBGLY6/x7LIt44AyDl
         V8Vn0LPd8VFpnd/IgVkvPvKzxczisAaSt30CLNG/JGJKg6lE5B+CjuXAWmH7ZK/r3rWD
         rKiA6qpgVJiu2uLCHIOnNJxThTOz9xCOWk8Nkc3AzxoAkukemOsBR6UToAItPHIgkaxU
         ZXr7h5kKVbnGL6YZP/UZk1JQ2GJkPvk+kwKdejS8G87Ak9t7j/gYx5vzZZXjyrAJKnq2
         TB5w==
X-Gm-Message-State: ABy/qLaV1aO9xh84gaw71ryb/IjeViFiRMxu5yJS42tsgAmD7cjHOWA5
        hrSgihAj04cxPJx+siKbkHOAqYbMXCg=
X-Google-Smtp-Source: APBJJlG/ZqhW73Dn8fInm+SqJPBFH64f+TeAAIdp+i3IdOD0O8cJx7RAFps+wc46zmXMzrtdTOrxgA==
X-Received: by 2002:a2e:850d:0:b0:2b4:7380:230 with SMTP id j13-20020a2e850d000000b002b473800230mr2846953lji.13.1689986764187;
        Fri, 21 Jul 2023 17:46:04 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j2-20020a2e8002000000b002b69febf515sm1224585ljg.125.2023.07.21.17.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 17:46:03 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     stable@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com, mykolal@fb.com, luizcap@amazon.com
Subject: [PATCH 6.1.y 5/6] selftests/bpf: Workaround verification failure for fexit_bpf2bpf/func_replace_return_code
Date:   Sat, 22 Jul 2023 03:45:13 +0300
Message-ID: <20230722004514.767618-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230722004514.767618-1-eddyz87@gmail.com>
References: <20230722004514.767618-1-eddyz87@gmail.com>
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

From: Yonghong Song <yhs@fb.com>

[ Upstream commit 63d78b7e8ca2d0eb8c687a355fa19d01b6fcc723 ]

With latest llvm17, selftest fexit_bpf2bpf/func_replace_return_code
has the following verification failure:

  0: R1=ctx(off=0,imm=0) R10=fp0
  ; int connect_v4_prog(struct bpf_sock_addr *ctx)
  0: (bf) r7 = r1                       ; R1=ctx(off=0,imm=0) R7_w=ctx(off=0,imm=0)
  1: (b4) w6 = 0                        ; R6_w=0
  ; memset(&tuple.ipv4.saddr, 0, sizeof(tuple.ipv4.saddr));
  ...
  ; return do_bind(ctx) ? 1 : 0;
  179: (bf) r1 = r7                     ; R1=ctx(off=0,imm=0) R7=ctx(off=0,imm=0)
  180: (85) call pc+147
  Func#3 is global and valid. Skipping.
  181: R0_w=scalar()
  181: (bc) w6 = w0                     ; R0_w=scalar() R6_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
  182: (05) goto pc-129
  ; }
  54: (bc) w0 = w6                      ; R0_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R6_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
  55: (95) exit
  At program exit the register R0 has value (0x0; 0xffffffff) should have been in (0x0; 0x1)
  processed 281 insns (limit 1000000) max_states_per_insn 1 total_states 26 peak_states 26 mark_read 13
  -- END PROG LOAD LOG --
  libbpf: prog 'connect_v4_prog': failed to load: -22

The corresponding source code:

  __attribute__ ((noinline))
  int do_bind(struct bpf_sock_addr *ctx)
  {
        struct sockaddr_in sa = {};

        sa.sin_family = AF_INET;
        sa.sin_port = bpf_htons(0);
        sa.sin_addr.s_addr = bpf_htonl(SRC_REWRITE_IP4);

        if (bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa)) != 0)
                return 0;

        return 1;
  }
  ...
  SEC("cgroup/connect4")
  int connect_v4_prog(struct bpf_sock_addr *ctx)
  {
  ...
        return do_bind(ctx) ? 1 : 0;
  }

Insn 180 is a call to 'do_bind'. The call's return value is also the return value
for the program. Since do_bind() returns 0/1, so it is legitimate for compiler to
optimize 'return do_bind(ctx) ? 1 : 0' to 'return do_bind(ctx)'. However, such
optimization breaks verifier as the return value of 'do_bind()' is marked as any
scalar which violates the requirement of prog return value 0/1.

There are two ways to fix this problem, (1) changing 'return 1' in do_bind() to
e.g. 'return 10' so the compiler has to do 'do_bind(ctx) ? 1 :0', or (2)
suggested by Andrii, marking do_bind() with __weak attribute so the compiler
cannot make any assumption on do_bind() return value.

This patch adopted adding __weak approach which is simpler and more resistant
to potential compiler optimizations.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230310012410.2920570-1-yhs@fb.com
---
 tools/testing/selftests/bpf/progs/connect4_prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
index ec25371de789..7ef49ec04838 100644
--- a/tools/testing/selftests/bpf/progs/connect4_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
@@ -32,7 +32,7 @@
 #define IFNAMSIZ 16
 #endif
 
-__attribute__ ((noinline))
+__attribute__ ((noinline)) __weak
 int do_bind(struct bpf_sock_addr *ctx)
 {
 	struct sockaddr_in sa = {};
-- 
2.41.0

