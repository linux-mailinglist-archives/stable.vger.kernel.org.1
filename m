Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15FF75D86C
	for <lists+stable@lfdr.de>; Sat, 22 Jul 2023 02:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjGVAqH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 20:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjGVAqG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 20:46:06 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2F41FCB
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 17:46:05 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b96789d574so32933361fa.2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 17:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689986763; x=1690591563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4jIM8rqnLOLlaVFmvWdjapdpoHkdpwx9/GHTM6a1w0=;
        b=eADhtKVHOlS4XVPyBCwEELVncR3OCCZ73KI3vlEKkOmskertVmwykWSYz07XYmqy/W
         kt3QGtqSqAr3nO8eelQ7n8LEKdRV9sjVOFPdODuR3YaIIqHHOcKtsF5bFhoDo/4J62s7
         MLRxi1kSuwwMuUIN4X8JFMpkYpqO8JehWUoUoEZaYO1gWMBJiJhy7MW90PzZtGHGdaij
         SflKAuM8SC2m4tkqHmFUEdcmMW3wFFUxyVpExqG6YAUUorKVvjXt1db1F+vNpNc+FKDb
         Rkv/CUvm8IjaDlp55mAlWvQ5pXoI36DqrbUWGoRJQaoVNazvEATAUAiriyDW1k2mv70j
         MNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689986763; x=1690591563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4jIM8rqnLOLlaVFmvWdjapdpoHkdpwx9/GHTM6a1w0=;
        b=jlgJ6hN6tnfsqZQDRMp2235W7ePE/mox7D2Wvz2ewk5tT9GwVGfgwgxK6f/cj6hmNR
         dERu51iqFlYxtnx4DvVN9qR5YugdD3hsEp3JUQxoUnuY2SpIRWxSM8Ovr8zQIMPnPuR0
         UmYBoIydzmIZ1zUURm1+tfATwh+aO/jPdO9/uY4BsVIGXfe7/IdNdjawDIper0ncSYKK
         H+I3dyT9riTpcQ6laBjqrEq7yStBQdiskuEJmvQHxmnW+SQlJD2XledAEj1G1jx4Neaw
         U7DOEGnpad+EZeNRbm8DqEuhIurDHeXpB++hnvB8Hawhi3u3SA/GgQOvpbaC9rp2wkxY
         FC3g==
X-Gm-Message-State: ABy/qLZnWR2GbFoA74rIr9bwVuncETaWjjz+cF3Sx+HB5H/XJ03l7fQY
        Cfs94BtSCoQe/oCdSGt0kc4X3vTCNJw=
X-Google-Smtp-Source: APBJJlHZVhN+ABRcvqVJP53AXysJmKKuyW82c/8yStuHFzhbkOeJeNquBmjJGBryxJRpRt9wTYqK+g==
X-Received: by 2002:a2e:990d:0:b0:2b6:9dd5:7a5 with SMTP id v13-20020a2e990d000000b002b69dd507a5mr2540433lji.12.1689986763198;
        Fri, 21 Jul 2023 17:46:03 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j2-20020a2e8002000000b002b69febf515sm1224585ljg.125.2023.07.21.17.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 17:46:02 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     stable@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com, mykolal@fb.com, luizcap@amazon.com
Subject: [PATCH 6.1.y 4/6] selftests/bpf: make test_align selftest more robust
Date:   Sat, 22 Jul 2023 03:45:12 +0300
Message-ID: <20230722004514.767618-5-eddyz87@gmail.com>
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

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 4f999b767769b76378c3616c624afd6f4bb0d99f ]

test_align selftest relies on BPF verifier log emitting register states
for specific instructions in expected format. Unfortunately, BPF
verifier precision backtracking log interferes with such expectations.
And instruction on which precision propagation happens sometimes don't
output full expected register states. This does indeed look like
something to be improved in BPF verifier, but is beyond the scope of
this patch set.

So to make test_align a bit more robust, inject few dummy R4 = R5
instructions which capture desired state of R5 and won't have precision
tracking logs on them. This fixes tests until we can improve BPF
verifier output in the presence of precision tracking.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20221104163649.121784-7-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/align.c  | 38 ++++++++++++-------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
index de27a29af270..8baebb41541d 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -2,7 +2,7 @@
 #include <test_progs.h>
 
 #define MAX_INSNS	512
-#define MAX_MATCHES	16
+#define MAX_MATCHES	24
 
 struct bpf_reg_match {
 	unsigned int line;
@@ -267,6 +267,7 @@ static struct bpf_align_test tests[] = {
 			 */
 			BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
 			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
@@ -280,6 +281,7 @@ static struct bpf_align_test tests[] = {
 			BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
 			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
+			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
 			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 4),
 			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
 			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
@@ -311,44 +313,52 @@ static struct bpf_align_test tests[] = {
 			{15, "R4=pkt(id=1,off=18,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
 			{15, "R5=pkt(id=1,off=14,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* Variable offset is added to R5 packet pointer,
-			 * resulting in auxiliary alignment of 4.
+			 * resulting in auxiliary alignment of 4. To avoid BPF
+			 * verifier's precision backtracking logging
+			 * interfering we also have a no-op R4 = R5
+			 * instruction to validate R5 state. We also check
+			 * that R4 is what it should be in such case.
 			 */
-			{17, "R5_w=pkt(id=2,off=0,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{18, "R4_w=pkt(id=2,off=0,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{18, "R5_w=pkt(id=2,off=0,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant offset is added to R5, resulting in
 			 * reg->off of 14.
 			 */
-			{18, "R5_w=pkt(id=2,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{19, "R5_w=pkt(id=2,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off
 			 * (14) which is 16.  Then the variable offset is 4-byte
 			 * aligned, so the total offset is 4-byte aligned and
 			 * meets the load's requirements.
 			 */
-			{23, "R4=pkt(id=2,off=18,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
-			{23, "R5=pkt(id=2,off=14,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
+			{24, "R4=pkt(id=2,off=18,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
+			{24, "R5=pkt(id=2,off=14,r=18,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant offset is added to R5 packet pointer,
 			 * resulting in reg->off value of 14.
 			 */
-			{25, "R5_w=pkt(off=14,r=8"},
+			{26, "R5_w=pkt(off=14,r=8"},
 			/* Variable offset is added to R5, resulting in a
-			 * variable offset of (4n).
+			 * variable offset of (4n). See comment for insn #18
+			 * for R4 = R5 trick.
 			 */
-			{26, "R5_w=pkt(id=3,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{28, "R4_w=pkt(id=3,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{28, "R5_w=pkt(id=3,off=14,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant is added to R5 again, setting reg->off to 18. */
-			{27, "R5_w=pkt(id=3,off=18,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
+			{29, "R5_w=pkt(id=3,off=18,r=0,umax=1020,var_off=(0x0; 0x3fc))"},
 			/* And once more we add a variable; resulting var_off
 			 * is still (4n), fixed offset is not changed.
 			 * Also, we create a new reg->id.
 			 */
-			{28, "R5_w=pkt(id=4,off=18,r=0,umax=2040,var_off=(0x0; 0x7fc)"},
+			{31, "R4_w=pkt(id=4,off=18,r=0,umax=2040,var_off=(0x0; 0x7fc)"},
+			{31, "R5_w=pkt(id=4,off=18,r=0,umax=2040,var_off=(0x0; 0x7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (18)
 			 * which is 20.  Then the variable offset is (4n), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{33, "R4=pkt(id=4,off=22,r=22,umax=2040,var_off=(0x0; 0x7fc)"},
-			{33, "R5=pkt(id=4,off=18,r=22,umax=2040,var_off=(0x0; 0x7fc)"},
+			{35, "R4=pkt(id=4,off=22,r=22,umax=2040,var_off=(0x0; 0x7fc)"},
+			{35, "R5=pkt(id=4,off=18,r=22,umax=2040,var_off=(0x0; 0x7fc)"},
 		},
 	},
 	{
@@ -681,6 +691,6 @@ void test_align(void)
 		if (!test__start_subtest(test->descr))
 			continue;
 
-		CHECK_FAIL(do_test_single(test));
+		ASSERT_OK(do_test_single(test), test->descr);
 	}
 }
-- 
2.41.0

