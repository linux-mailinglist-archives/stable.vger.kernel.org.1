Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D015726C5F
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjFGUdM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjFGUdL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D97212E
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95C146435F
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC52EC4339B;
        Wed,  7 Jun 2023 20:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169977;
        bh=5ATivHTZCPFlrJw9nus5w68adzQee6zZmftqZTtFVqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivs87vyf1ZiTXmF1eF54C3svw5nncyGMUr6VgB+jP/7wvcJ/9mpn/UOeGKtPfrMb3
         cy7ZoBD99XqDCS0IKxXdJKVjkeJa2aK1H6MmrfLDE1k3BBt6ntNvSUKY9QGFxOxeOz
         TubSrPIhfiR92BTLFtgZzIjUAKpUEmOkrY953DmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        ndesaulniers@google.com, trix@redhat.com, stable@vger.kernel.org,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor" <nathan@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 6.3 285/286] riscv: vmlinux.lds.S: Explicitly handle .got section
Date:   Wed,  7 Jun 2023 22:16:24 +0200
Message-ID: <20230607200932.590767678@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nathan Chancellor <nathan@kernel.org>

This patch is for linux-6.3.y only, it has no direct mainline
equivalent.

LLVM 17 will now use the GOT for extern weak symbols when using the
medany model, which causes a linker orphan section warning on
linux-6.3.y:

  ld.lld: warning: <internal>:(.got) is being placed in '.got'

This is not an issue in mainline because handling of the .got section
was added by commit 39b33072941f ("riscv: Introduce CONFIG_RELOCATABLE")
and further extended by commit 26e7aacb83df ("riscv: Allow to downgrade
paging mode from the command line") in 6.4-rc1. Neither of these changes
are suitable for stable, so add explicit handling of the .got section in
a standalone change to align 6.3 and mainline, which addresses the
warning.

This is only an issue for 6.3 because commit f4b71bff8d85 ("riscv:
select ARCH_WANT_LD_ORPHAN_WARN for !XIP_KERNEL") landed in 6.3-rc1, so
earlier releases will not see this warning because it will not be
enabled.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1865
Link: https://github.com/llvm/llvm-project/commit/a178ba9fbd0a27057dc2fa4cb53c76caa013caac
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/kernel/vmlinux.lds.S |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -129,6 +129,8 @@ SECTIONS
 		*(.sdata*)
 	}
 
+	.got : { *(.got*) }
+
 #ifdef CONFIG_EFI
 	.pecoff_edata_padding : { BYTE(0); . = ALIGN(PECOFF_FILE_ALIGNMENT); }
 	__pecoff_data_raw_size = ABSOLUTE(. - __pecoff_text_end);


