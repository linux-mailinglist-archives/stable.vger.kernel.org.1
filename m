Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6867C77ABE4
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjHMV0y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjHMV0x (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFEA10DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A520629BC
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936E0C433C7;
        Sun, 13 Aug 2023 21:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962014;
        bh=udbVLT8B/yzzrAkANMZrZxrApXHWjhDFtxJKzLt+Jsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ncOlQRaq5lr2D0xjyORo86nUpVOHrrs16b2VJcOl0HbGUKUPtyJa2Aqh6z7MvRicf
         KBbFkF7j8PE4GvTOrOJTq6wwkB3G7e0qHQcWQuwR6Nx7r1wHCjGglE8t5cpjseld4G
         AOurUKxoCMgL6thQ3fkpKEK+i1Ex4uPojGQm4f5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <yujie.liu@intel.com>,
        Shan Kang <shan.kang@intel.com>, Xin Li <xin3.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6.4 081/206] x86/vdso: Choose the right GDT_ENTRY_CPUNODE for 32-bit getcpu() on 64-bit kernel
Date:   Sun, 13 Aug 2023 23:17:31 +0200
Message-ID: <20230813211727.398277094@linuxfoundation.org>
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

From: Xin Li <xin3.li@intel.com>

commit 39163d5479285a36522b6e8f9cc568cc4987db08 upstream.

The vDSO getcpu() reads CPU ID from the GDT_ENTRY_CPUNODE entry when the RDPID
instruction is not available. And GDT_ENTRY_CPUNODE is defined as 28 on 32-bit
Linux kernel and 15 on 64-bit. But the 32-bit getcpu() on 64-bit Linux kernel
is compiled with 32-bit Linux kernel GDT_ENTRY_CPUNODE, i.e., 28, beyond the
64-bit Linux kernel GDT limit. Thus, it just fails _silently_.

When BUILD_VDSO32_64 is defined, choose the 64-bit Linux kernel GDT definitions
to compile the 32-bit getcpu().

Fixes: 877cff5296faa6e ("x86/vdso: Fake 32bit VDSO build on 64bit compile for vgetcpu")
Reported-by: kernel test robot <yujie.liu@intel.com>
Reported-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230322061758.10639-1-xin3.li@intel.com
Link: https://lore.kernel.org/oe-lkp/202303020903.b01fd1de-yujie.liu@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 794f69625780..9d6411c65920 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -56,7 +56,7 @@
 
 #define GDT_ENTRY_INVALID_SEG	0
 
-#ifdef CONFIG_X86_32
+#if defined(CONFIG_X86_32) && !defined(BUILD_VDSO32_64)
 /*
  * The layout of the per-CPU GDT under Linux:
  *
-- 
2.41.0



