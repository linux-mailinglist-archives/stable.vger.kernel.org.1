Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6CE77ABCF
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjHMVZ5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjHMVZ5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:25:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A3A10DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:25:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46CB262969
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDE7C433C8;
        Sun, 13 Aug 2023 21:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961958;
        bh=oRCk/Hxr1zM1ulmwrTHTtRmAcAU350bPlP+CDrFzLC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvRPznelv2O3rzWThbY7z16v/5YgYejQj0tiVnmYlypdhJ8Bu4prl9VMy2etD5u9t
         iR2vN+qw8JtxOgWNLIwxza+WstXQXN/vf7FElJ3bQI8bRIvvMZdRlKLYNBFQmnfvkp
         r6oEDcuxgPN6/jib3epuiIUp9YDtJD58VNe+aJeQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Torsten Duwe <duwe@suse.de>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.4 031/206] riscv/kexec: load initrd high in available memory
Date:   Sun, 13 Aug 2023 23:16:41 +0200
Message-ID: <20230813211725.895070625@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
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

From: Torsten Duwe <duwe@suse.de>

commit 49af7a2cd5f678217b8b4f86a29411aebebf3e78 upstream.

When initrd is loaded low, the secondary kernel fails like this:

 INITRD: 0xdc581000+0x00eef000 overlaps in-use memory region

This initrd load address corresponds to the _end symbol, but the
reservation is aligned on PMD_SIZE, as explained by a comment in
setup_bootmem().

It is technically possible to align the initrd load address accordingly,
leaving a hole between the end of kernel and the initrd, but it is much
simpler to allocate the initrd top-down.

Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
Cc: stable@vger.kernel.org
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/all/67c8eb9eea25717c2c8208d9bfbfaa39e6e2a1c6.1690365011.git.petr.tesarik.ext@huawei.com/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/kernel/elf_kexec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -281,7 +281,7 @@ static void *elf_kexec_load(struct kimag
 		kbuf.buffer = initrd;
 		kbuf.bufsz = kbuf.memsz = initrd_len;
 		kbuf.buf_align = PAGE_SIZE;
-		kbuf.top_down = false;
+		kbuf.top_down = true;
 		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 		ret = kexec_add_buffer(&kbuf);
 		if (ret)


