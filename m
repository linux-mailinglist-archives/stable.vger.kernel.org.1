Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265EC78AAEF
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjH1K03 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjH1KZ6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:25:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C28188
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07FA76131B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B5EC433CD;
        Mon, 28 Aug 2023 10:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218349;
        bh=aiVp4oHkOt7KAovPGs8xKVLgMt1jWZbitZmZiGjQ6wE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zp8xJIezL5b5ue5xnM3xj3iVKFIe52ZrJ71a7V/4PCjbwzaCa8E7MohRQeucV1lE0
         7jawKTnw8b7BZXSXUYbdg4tucfcP+Q0V+DPDrNu4VxhYbJEhCEydq44EmMWo1IqR1I
         aXCmfkt2WdjymKRQjNUmDWInMOXK7WyRPLaplugU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 027/129] powerpc/mm: dump segment registers on book3s/32
Date:   Mon, 28 Aug 2023 12:12:01 +0200
Message-ID: <20230828101154.067199031@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 0261a508c9fcb33e60f09cac42032f85c31e2039 ]

This patch creates a debugfs file to see content of
segment registers

  # cat /sys/kernel/debug/segment_registers
  ---[ User Segments ]---
  0x00000000-0x0fffffff Kern key 1 User key 1 VSID 0xade2b0
  0x10000000-0x1fffffff Kern key 1 User key 1 VSID 0xade3c1
  0x20000000-0x2fffffff Kern key 1 User key 1 VSID 0xade4d2
  0x30000000-0x3fffffff Kern key 1 User key 1 VSID 0xade5e3
  0x40000000-0x4fffffff Kern key 1 User key 1 VSID 0xade6f4
  0x50000000-0x5fffffff Kern key 1 User key 1 VSID 0xade805
  0x60000000-0x6fffffff Kern key 1 User key 1 VSID 0xade916
  0x70000000-0x7fffffff Kern key 1 User key 1 VSID 0xadea27
  0x80000000-0x8fffffff Kern key 1 User key 1 VSID 0xadeb38
  0x90000000-0x9fffffff Kern key 1 User key 1 VSID 0xadec49
  0xa0000000-0xafffffff Kern key 1 User key 1 VSID 0xaded5a
  0xb0000000-0xbfffffff Kern key 1 User key 1 VSID 0xadee6b

  ---[ Kernel Segments ]---
  0xc0000000-0xcfffffff Kern key 0 User key 1 VSID 0x000ccc
  0xd0000000-0xdfffffff Kern key 0 User key 1 VSID 0x000ddd
  0xe0000000-0xefffffff Kern key 0 User key 1 VSID 0x000eee
  0xf0000000-0xffffffff Kern key 0 User key 1 VSID 0x000fff

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
[mpe: Move it under /sys/kernel/debug/powerpc, make sr_init() __init]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Stable-dep-of: 66b2ca086210 ("powerpc/64s/radix: Fix soft dirty tracking")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/Makefile  |  2 +-
 arch/powerpc/mm/dump_sr.c | 64 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/mm/dump_sr.c

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 3c844bdd16c4e..d2784730c0e5d 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -47,7 +47,7 @@ ifdef CONFIG_PPC_PTDUMP
 obj-$(CONFIG_4xx)		+= dump_linuxpagetables-generic.o
 obj-$(CONFIG_PPC_8xx)		+= dump_linuxpagetables-8xx.o
 obj-$(CONFIG_PPC_BOOK3E_MMU)	+= dump_linuxpagetables-generic.o
-obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o
+obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o dump_sr.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= dump_linuxpagetables-book3s64.o
 endif
 obj-$(CONFIG_PPC_HTDUMP)	+= dump_hashpagetable.o
diff --git a/arch/powerpc/mm/dump_sr.c b/arch/powerpc/mm/dump_sr.c
new file mode 100644
index 0000000000000..501843664bb91
--- /dev/null
+++ b/arch/powerpc/mm/dump_sr.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018, Christophe Leroy CS S.I.
+ * <christophe.leroy@c-s.fr>
+ *
+ * This dumps the content of Segment Registers
+ */
+
+#include <asm/debugfs.h>
+
+static void seg_show(struct seq_file *m, int i)
+{
+	u32 val = mfsrin(i << 28);
+
+	seq_printf(m, "0x%01x0000000-0x%01xfffffff ", i, i);
+	seq_printf(m, "Kern key %d ", (val >> 30) & 1);
+	seq_printf(m, "User key %d ", (val >> 29) & 1);
+	if (val & 0x80000000) {
+		seq_printf(m, "Device 0x%03x", (val >> 20) & 0x1ff);
+		seq_printf(m, "-0x%05x", val & 0xfffff);
+	} else {
+		if (val & 0x10000000)
+			seq_puts(m, "No Exec ");
+		seq_printf(m, "VSID 0x%06x", val & 0xffffff);
+	}
+	seq_puts(m, "\n");
+}
+
+static int sr_show(struct seq_file *m, void *v)
+{
+	int i;
+
+	seq_puts(m, "---[ User Segments ]---\n");
+	for (i = 0; i < TASK_SIZE >> 28; i++)
+		seg_show(m, i);
+
+	seq_puts(m, "\n---[ Kernel Segments ]---\n");
+	for (; i < 16; i++)
+		seg_show(m, i);
+
+	return 0;
+}
+
+static int sr_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, sr_show, NULL);
+}
+
+static const struct file_operations sr_fops = {
+	.open		= sr_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init sr_init(void)
+{
+	struct dentry *debugfs_file;
+
+	debugfs_file = debugfs_create_file("segment_registers", 0400,
+					   powerpc_debugfs_root, NULL, &sr_fops);
+	return debugfs_file ? 0 : -ENOMEM;
+}
+device_initcall(sr_init);
-- 
2.40.1



