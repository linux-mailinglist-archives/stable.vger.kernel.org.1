Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48436761329
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjGYLIa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjGYLID (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:08:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41124202
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18B0161691
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7E1C433C8;
        Tue, 25 Jul 2023 11:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283197;
        bh=oWvUHUfimxNymm3elD/r2z8cLywC3dXvqmTcYZOCTOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgbJfyh672PEKuwNN967GbVZaseEULwaULJpdOeFo6h0cW6YLt8dPVdrQX1ZbKw2n
         tR1krYRvMImuyPIlNpZmpbxkEoBv7JzXEXgJhV5ymqVnTG+h4Rv6bM/shJlg81qRBC
         ZDYQbhEtOdv7M1h3uUop77p4gEUnp12j1sl/jkzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com, mykolal@fb.com, luizcap@amazon.com, Eduard Zingerman" 
        <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.1 174/183] selftests/bpf: make test_align selftest more robust
Date:   Tue, 25 Jul 2023 12:46:42 +0200
Message-ID: <20230725104514.005190591@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/bpf/prog_tests/align.c |   38 +++++++++++++++----------
 1 file changed, 24 insertions(+), 14 deletions(-)

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


