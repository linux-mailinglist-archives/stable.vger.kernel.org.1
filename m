Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A379C7A7B48
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjITLu4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbjITLuz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:50:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2291B4
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:50:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05372C433C7;
        Wed, 20 Sep 2023 11:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210649;
        bh=l0fGG4uA0rl8DjlQOtn1CObGCVsm/eFkPeJlJuNRliQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CB3eTjDXnybRhnMezTmO8/X9juWmazzUFej0q5EzDoyNsqHToRZ6om4qOyWc+x7/d
         Z5oigWcNo7h3P2DngxBhYR58bLmAZRxnxd8iZw1uIsOk/RXMQvCXY82ZsOMr8IhXXp
         0S6w8O9dVefbOAb0hqVOnfW7Nq9DVcN5qEGGU3QE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Song Shuai <songshuaishuai@tinylab.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 153/211] riscv: kexec: Align the kexeced kernel entry
Date:   Wed, 20 Sep 2023 13:29:57 +0200
Message-ID: <20230920112850.616376483@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Song Shuai <songshuaishuai@tinylab.org>

[ Upstream commit 1bfb2b618d52e59a4ef1896b46c4698ad2be66b7 ]

The current riscv boot protocol requires 2MB alignment for RV64
and 4MB alignment for RV32.

In KEXEC_FILE path, the elf_find_pbase() function should align
the kexeced kernel entry according to the requirement, otherwise
the kexeced kernel would silently BUG at the setup_vm().

Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
Link: https://lore.kernel.org/r/20230906095817.364390-1-songshuaishuai@tinylab.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/elf_kexec.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index c08bb5c3b3857..b3b96ff46d193 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -98,7 +98,13 @@ static int elf_find_pbase(struct kimage *image, unsigned long kernel_len,
 	kbuf.image = image;
 	kbuf.buf_min = lowest_paddr;
 	kbuf.buf_max = ULONG_MAX;
-	kbuf.buf_align = PAGE_SIZE;
+
+	/*
+	 * Current riscv boot protocol requires 2MB alignment for
+	 * RV64 and 4MB alignment for RV32
+	 *
+	 */
+	kbuf.buf_align = PMD_SIZE;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	kbuf.memsz = ALIGN(kernel_len, PAGE_SIZE);
 	kbuf.top_down = false;
-- 
2.40.1



