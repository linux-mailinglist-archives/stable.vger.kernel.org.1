Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FB2783327
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjHUUI1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjHUUIZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:08:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C934136
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:08:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDA86649DE
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA27EC433C7;
        Mon, 21 Aug 2023 20:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648503;
        bh=2lLFFkfrqM9pw7aUtXbAiwjFZEeNaczATqvOIfLswy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzlXrBKiO9DslqTVOrQx3n5W+SSyPfwwJj09C2E1mZmj2P7fxFDNnxp2IcpFT16Ad
         QcMZde9QLTB1Qg5RKxnUQx+WF2lR+KGRy2OwEeEmbXpWSQIMwevh5bEvxLWnqXxq7m
         52QSGA2r6VImmPj1aTRc21eMFDl1oGak6KCOlEs8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nam Cao <namcaov@gmail.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 199/234] riscv: correct riscv_insn_is_c_jr() and riscv_insn_is_c_jalr()
Date:   Mon, 21 Aug 2023 21:42:42 +0200
Message-ID: <20230821194137.632749363@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nam Cao <namcaov@gmail.com>

[ Upstream commit 79bc3f85c51fc352f8e684ba6b626f677a3aa230 ]

The instructions c.jr and c.jalr must have rs1 != 0, but
riscv_insn_is_c_jr() and riscv_insn_is_c_jalr() do not check for this. So,
riscv_insn_is_c_jr() can match a reserved encoding, while
riscv_insn_is_c_jalr() can match the c.ebreak instruction.

Rewrite them with check for rs1 != 0.

Signed-off-by: Nam Cao <namcaov@gmail.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: ec5f90877516 ("RISC-V: Move riscv_insn_is_* macros into a common header")
Link: https://lore.kernel.org/r/20230731183925.152145-1-namcaov@gmail.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/insn.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index 8d5c84f2d5ef7..603095c913e37 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -110,6 +110,7 @@
 #define RVC_INSN_FUNCT4_OPOFF	12
 #define RVC_INSN_FUNCT3_MASK	GENMASK(15, 13)
 #define RVC_INSN_FUNCT3_OPOFF	13
+#define RVC_INSN_J_RS1_MASK	GENMASK(11, 7)
 #define RVC_INSN_J_RS2_MASK	GENMASK(6, 2)
 #define RVC_INSN_OPCODE_MASK	GENMASK(1, 0)
 #define RVC_ENCODE_FUNCT3(f_)	(RVC_FUNCT3_##f_ << RVC_INSN_FUNCT3_OPOFF)
@@ -225,8 +226,6 @@ __RISCV_INSN_FUNCS(c_jal, RVC_MASK_C_JAL, RVC_MATCH_C_JAL)
 __RISCV_INSN_FUNCS(auipc, RVG_MASK_AUIPC, RVG_MATCH_AUIPC)
 __RISCV_INSN_FUNCS(jalr, RVG_MASK_JALR, RVG_MATCH_JALR)
 __RISCV_INSN_FUNCS(jal, RVG_MASK_JAL, RVG_MATCH_JAL)
-__RISCV_INSN_FUNCS(c_jr, RVC_MASK_C_JR, RVC_MATCH_C_JR)
-__RISCV_INSN_FUNCS(c_jalr, RVC_MASK_C_JALR, RVC_MATCH_C_JALR)
 __RISCV_INSN_FUNCS(c_j, RVC_MASK_C_J, RVC_MATCH_C_J)
 __RISCV_INSN_FUNCS(beq, RVG_MASK_BEQ, RVG_MATCH_BEQ)
 __RISCV_INSN_FUNCS(bne, RVG_MASK_BNE, RVG_MATCH_BNE)
@@ -253,6 +252,18 @@ static __always_inline bool riscv_insn_is_branch(u32 code)
 	return (code & RV_INSN_OPCODE_MASK) == RVG_OPCODE_BRANCH;
 }
 
+static __always_inline bool riscv_insn_is_c_jr(u32 code)
+{
+	return (code & RVC_MASK_C_JR) == RVC_MATCH_C_JR &&
+	       (code & RVC_INSN_J_RS1_MASK) != 0;
+}
+
+static __always_inline bool riscv_insn_is_c_jalr(u32 code)
+{
+	return (code & RVC_MASK_C_JALR) == RVC_MATCH_C_JALR &&
+	       (code & RVC_INSN_J_RS1_MASK) != 0;
+}
+
 #define RV_IMM_SIGN(x) (-(((x) >> 31) & 1))
 #define RVC_IMM_SIGN(x) (-(((x) >> 12) & 1))
 #define RV_X(X, s, mask)  (((X) >> (s)) & (mask))
-- 
2.40.1



