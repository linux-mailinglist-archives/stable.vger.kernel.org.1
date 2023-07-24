Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6175F690
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 14:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjGXMmn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 08:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjGXMmm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 08:42:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEEED8
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 05:42:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991f956fb5aso645512166b.0
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 05:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690202560; x=1690807360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whkyyS3XwF5nKZTKOO10pppwvHXqLx9RJIcmhaWy3Sk=;
        b=JiV5QSMcdfDpopQ1eKZlWrID7qQ8v8hDRlHi1947GLGS8JpJJxq31n9NRJPoWLuDm9
         yfjWKBuo6kFdsVGC6u18PJ+4LVa5fyE+4TIf8C7sbmb4ArejOXCHnVb6pC7u6CimUEXi
         t4VznfTjTEW7qkg7wSIllrHe7XiUUIwJtKwJh6e5Xl0jrTwKH/YEP9bAD3sIW7Iy0f0P
         HG3AwaZJVeMZG9PJAZ5FD+mYERJpqSTGDqAm6NS+JqNNaDOh2VgrE6AaxIspbvDooQ9v
         BJVDgWjwx6RH5CieUz6ZDhg49bUKK9EXlwvjJ8h2a4qmisGVsA9vIP3ei+USX5m82ayI
         3k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690202560; x=1690807360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whkyyS3XwF5nKZTKOO10pppwvHXqLx9RJIcmhaWy3Sk=;
        b=UQEpUHnHjgiQvvN45sWqMQIR7w1bf9G0SeV76pXsHfIZhvCbGTbCKKkWrOgVLyXA3K
         6h4ma0pbTMfYfYnBjZnCfm0UZS1g852cemu/y01GfahGuvYSs/+PBNY1ma64rnAMG67k
         SycT5+amfZQX+rg9EPzLyQtb0MLpZNbBH//jtXoDMhc0oYK4VGnDsiFZl/k3vl7FvpZV
         D5zPK5eoLY/AYT3L/qZQKgLdwJFOf+KHrYSd9k7iHiN4Y1puaxEL0KHce9UCsbxwOLAI
         a4dllJwP05wH+6xq/0r4F2ElX/CQt9Q1CXi6HQElCiB4zzfkBe85LaECRj3SOFTswVYH
         15dg==
X-Gm-Message-State: ABy/qLY0Bpum40+rkRY/m97Uq9C+OTEw0+23LWInDbJUsaYNLRxVtuHw
        uMtGn5IghOnVzIFUEyuDkM7eyEtYUEg=
X-Google-Smtp-Source: APBJJlHfscDivR/TI1B2pKbx307cPtQHG/iDCSDafkJ+6jCJtLZFUnlTFNVfiaVwgFCdF+NKvF8bug==
X-Received: by 2002:a17:906:9bf6:b0:994:5544:3aea with SMTP id de54-20020a1709069bf600b0099455443aeamr8855686ejc.51.1690202559706;
        Mon, 24 Jul 2023 05:42:39 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709062b0600b0099297782aa9sm6628490ejg.49.2023.07.24.05.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 05:42:39 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     stable@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com, mykolal@fb.com, luizcap@amazon.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.1.y v2 5/6] selftests/bpf: Workaround verification failure for fexit_bpf2bpf/func_replace_return_code
Date:   Mon, 24 Jul 2023 15:42:22 +0300
Message-ID: <20230724124223.1176479-6-eddyz87@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724124223.1176479-1-eddyz87@gmail.com>
References: <20230724124223.1176479-1-eddyz87@gmail.com>
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
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
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

