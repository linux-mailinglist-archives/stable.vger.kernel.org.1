Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060C16FA7D1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjEHKfG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjEHKek (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:34:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B15D26740
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:33:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B66D61408
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33112C433EF;
        Mon,  8 May 2023 10:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542032;
        bh=QNvySg/455ZPe+JjSomXiDEzlDkxlTK3w57SdW4oILs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vfpJnzjALjbNT+Vlq6fE/ccdpmaHpdZzwnkVOqUxyAqHg1EgeVjCu0pZ6CeuhFWZL
         mteWpSYyWFm6L1/T6PJhtLM6xewBgtjM/Yavq7FLNMPnwetIoDsrfP/HlyfSn2kaJL
         fXdm9fu306f9RDJqsxiXMViMRaa3yo+QtTbZgzQw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 304/663] libbpf: Fix ld_imm64 copy logic for ksym in light skeleton.
Date:   Mon,  8 May 2023 11:42:10 +0200
Message-Id: <20230508094438.052298410@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit a506d6ce1dd184051037dc9d26c3eb187c9fe625 ]

Unlike normal libbpf the light skeleton 'loader' program is doing
btf_find_by_name_kind() call at run-time to find ksym in the kernel and
populate its {btf_id, btf_obj_fd} pair in ld_imm64 insn. To avoid doing the
search multiple times for the same ksym it remembers the first patched ld_imm64
insn and copies {btf_id, btf_obj_fd} from it into subsequent ld_imm64 insn.
Fix a bug in copying logic, since it may incorrectly clear BPF_PSEUDO_BTF_ID flag.

Also replace always true if (btf_obj_fd >= 0) check with unconditional JMP_JA
to clarify the code.

Fixes: d995816b77eb ("libbpf: Avoid reload of imm for weak, unresolved, repeating ksym")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230319203014.55866-1-alexei.starovoitov@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/gen_loader.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 23f5c46708f8f..b74c82bb831e6 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -804,11 +804,13 @@ static void emit_relo_ksym_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo,
 		return;
 	/* try to copy from existing ldimm64 insn */
 	if (kdesc->ref > 1) {
-		move_blob2blob(gen, insn + offsetof(struct bpf_insn, imm), 4,
-			       kdesc->insn + offsetof(struct bpf_insn, imm));
 		move_blob2blob(gen, insn + sizeof(struct bpf_insn) + offsetof(struct bpf_insn, imm), 4,
 			       kdesc->insn + sizeof(struct bpf_insn) + offsetof(struct bpf_insn, imm));
-		/* jump over src_reg adjustment if imm is not 0, reuse BPF_REG_0 from move_blob2blob */
+		move_blob2blob(gen, insn + offsetof(struct bpf_insn, imm), 4,
+			       kdesc->insn + offsetof(struct bpf_insn, imm));
+		/* jump over src_reg adjustment if imm (btf_id) is not 0, reuse BPF_REG_0 from move_blob2blob
+		 * If btf_id is zero, clear BPF_PSEUDO_BTF_ID flag in src_reg of ld_imm64 insn
+		 */
 		emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3));
 		goto clear_src_reg;
 	}
@@ -831,7 +833,7 @@ static void emit_relo_ksym_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo,
 	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_8, BPF_REG_7,
 			      sizeof(struct bpf_insn) + offsetof(struct bpf_insn, imm)));
 	/* skip src_reg adjustment */
-	emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 3));
+	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 3));
 clear_src_reg:
 	/* clear bpf_object__relocate_data's src_reg assignment, otherwise we get a verifier failure */
 	reg_mask = src_reg_mask();
-- 
2.39.2



