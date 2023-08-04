Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413B4770481
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 17:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjHDP0l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 11:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjHDP0T (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 11:26:19 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E328B49C3
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 08:25:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHV060Qmwz4f3p17
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 23:25:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP1 (Coremail) with SMTP id cCh0CgB30hxkGM1kpNz_Og--.43554S6;
        Fri, 04 Aug 2023 23:25:27 +0800 (CST)
From:   Pu Lehui <pulehui@huaweicloud.com>
To:     stable@vger.kernel.org, Greg KH <greg@kroah.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Luiz Capitulino <luizcap@amazon.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH 5.10 v2 4/6] selftests/bpf: make test_align selftest more robust
Date:   Fri,  4 Aug 2023 23:24:49 +0800
Message-Id: <20230804152451.2565608-5-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804152451.2565608-1-pulehui@huaweicloud.com>
References: <20230804152451.2565608-1-pulehui@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgB30hxkGM1kpNz_Og--.43554S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar18AFWfCw4fJr4rJr15XFb_yoW7KF13pw
        4rJr15uF1kAw1UWrnrWa47Xr4Iqa1DKrs3Kr9F9ry7Aw17Xa4fJasF9FWYq3s7CrsYvr1a
        y3Wjqa4qga1UWrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9G14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
        W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZX7UUUUU==
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
Stable-dep-of: ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")
Conflicts:
	tools/testing/selftests/bpf/prog_tests/align.c
Signed-off-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Luiz Capitulino <luizcap@amazon.com>
---
 .../testing/selftests/bpf/prog_tests/align.c  | 36 ++++++++++++-------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
index 5861446d0777..7996ec07e0bd 100644
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
 			{15, "R4=pkt(id=1,off=18,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			{15, "R5=pkt(id=1,off=14,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* Variable offset is added to R5 packet pointer,
-			 * resulting in auxiliary alignment of 4.
+			 * resulting in auxiliary alignment of 4. To avoid BPF
+			 * verifier's precision backtracking logging
+			 * interfering we also have a no-op R4 = R5
+			 * instruction to validate R5 state. We also check
+			 * that R4 is what it should be in such case.
 			 */
-			{18, "R5_w=pkt(id=2,off=0,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{19, "R4_w=pkt(id=2,off=0,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{19, "R5_w=pkt(id=2,off=0,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant offset is added to R5, resulting in
 			 * reg->off of 14.
 			 */
-			{19, "R5_w=pkt(id=2,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{20, "R5_w=pkt(id=2,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off
 			 * (14) which is 16.  Then the variable offset is 4-byte
 			 * aligned, so the total offset is 4-byte aligned and
 			 * meets the load's requirements.
 			 */
-			{23, "R4=pkt(id=2,off=18,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
-			{23, "R5=pkt(id=2,off=14,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{24, "R4=pkt(id=2,off=18,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{24, "R5=pkt(id=2,off=14,r=18,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant offset is added to R5 packet pointer,
 			 * resulting in reg->off value of 14.
 			 */
-			{26, "R5_w=pkt(id=0,off=14,r=8"},
+			{27, "R5_w=pkt(id=0,off=14,r=8"},
 			/* Variable offset is added to R5, resulting in a
-			 * variable offset of (4n).
+			 * variable offset of (4n). See comment for insn #19
+			 * for R4 = R5 trick.
 			 */
-			{27, "R5_w=pkt(id=3,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{29, "R4_w=pkt(id=3,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{29, "R5_w=pkt(id=3,off=14,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* Constant is added to R5 again, setting reg->off to 18. */
-			{28, "R5_w=pkt(id=3,off=18,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
+			{30, "R5_w=pkt(id=3,off=18,r=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
 			/* And once more we add a variable; resulting var_off
 			 * is still (4n), fixed offset is not changed.
 			 * Also, we create a new reg->id.
 			 */
-			{29, "R5_w=pkt(id=4,off=18,r=0,umax_value=2040,var_off=(0x0; 0x7fc)"},
+			{32, "R4_w=pkt(id=4,off=18,r=0,umax_value=2040,var_off=(0x0; 0x7fc)"},
+			{32, "R5_w=pkt(id=4,off=18,r=0,umax_value=2040,var_off=(0x0; 0x7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (18)
 			 * which is 20.  Then the variable offset is (4n), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{33, "R4=pkt(id=4,off=22,r=22,umax_value=2040,var_off=(0x0; 0x7fc)"},
-			{33, "R5=pkt(id=4,off=18,r=22,umax_value=2040,var_off=(0x0; 0x7fc)"},
+			{35, "R4=pkt(id=4,off=22,r=22,umax_value=2040,var_off=(0x0; 0x7fc)"},
+			{35, "R5=pkt(id=4,off=18,r=22,umax_value=2040,var_off=(0x0; 0x7fc)"},
 		},
 	},
 	{
-- 
2.25.1

