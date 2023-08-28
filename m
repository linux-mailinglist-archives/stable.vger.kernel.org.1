Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A277978AAF0
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjH1K0b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjH1K0B (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EC518E
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:25:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC8B7612F5
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05D0C433C7;
        Mon, 28 Aug 2023 10:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218352;
        bh=Soocc7gblpZ6yiVgq0ftqSXH8V9t1CZpkJX+oCj8fxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S17EwmmuKQ/m8B1Uq9sKxT8b9i+LDk+CZS7Ys7FH08KnN1W2RXzrvfPV/9jFFqeQU
         6O5hYA5SR7+v6GGw//klXJZhNNArarembvuxAdhM/AaBnu9XWB+1An07nn9wbcDVrO
         PYSfhCG3a1mWbq5COJ3BQiINsLqFFC0urUttETKQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 028/129] powerpc/mm: dump block address translation on book3s/32
Date:   Mon, 28 Aug 2023 12:12:02 +0200
Message-ID: <20230828101154.108070868@linuxfoundation.org>
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

[ Upstream commit 7c91efce1608325634494b25ff6491320208e457 ]

This patch adds a debugfs file to dump block address translation:

~# cat /sys/kernel/debug/powerpc/block_address_translation
---[ Instruction Block Address Translations ]---
0:         -
1:         -
2: 0xc0000000-0xcfffffff 0x00000000 Kernel EXEC coherent
3: 0xd0000000-0xdfffffff 0x10000000 Kernel EXEC coherent
4:         -
5:         -
6:         -
7:         -

---[ Data Block Address Translations ]---
0:         -
1:         -
2: 0xc0000000-0xcfffffff 0x00000000 Kernel RW coherent
3: 0xd0000000-0xdfffffff 0x10000000 Kernel RW coherent
4:         -
5:         -
6:         -
7:         -

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Stable-dep-of: 66b2ca086210 ("powerpc/64s/radix: Fix soft dirty tracking")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |   4 +
 arch/powerpc/mm/Makefile                      |   2 +-
 arch/powerpc/mm/dump_bats.c                   | 173 ++++++++++++++++++
 3 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/mm/dump_bats.c

diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index 5bd26c218b94f..958b18cecc96a 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -34,8 +34,12 @@
 #define BAT_PHYS_ADDR(x) ((u32)((x & 0x00000000fffe0000ULL) | \
 				((x & 0x0000000e00000000ULL) >> 24) | \
 				((x & 0x0000000100000000ULL) >> 30)))
+#define PHYS_BAT_ADDR(x) (((u64)(x) & 0x00000000fffe0000ULL) | \
+			  (((u64)(x) << 24) & 0x0000000e00000000ULL) | \
+			  (((u64)(x) << 30) & 0x0000000100000000ULL))
 #else
 #define BAT_PHYS_ADDR(x) (x)
+#define PHYS_BAT_ADDR(x) ((x) & 0xfffe0000)
 #endif
 
 struct ppc_bat {
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index d2784730c0e5d..8ace67f002752 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -47,7 +47,7 @@ ifdef CONFIG_PPC_PTDUMP
 obj-$(CONFIG_4xx)		+= dump_linuxpagetables-generic.o
 obj-$(CONFIG_PPC_8xx)		+= dump_linuxpagetables-8xx.o
 obj-$(CONFIG_PPC_BOOK3E_MMU)	+= dump_linuxpagetables-generic.o
-obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o dump_sr.o
+obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o dump_bats.o dump_sr.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= dump_linuxpagetables-book3s64.o
 endif
 obj-$(CONFIG_PPC_HTDUMP)	+= dump_hashpagetable.o
diff --git a/arch/powerpc/mm/dump_bats.c b/arch/powerpc/mm/dump_bats.c
new file mode 100644
index 0000000000000..a0d23e96e841a
--- /dev/null
+++ b/arch/powerpc/mm/dump_bats.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018, Christophe Leroy CS S.I.
+ * <christophe.leroy@c-s.fr>
+ *
+ * This dumps the content of BATS
+ */
+
+#include <asm/debugfs.h>
+#include <asm/pgtable.h>
+#include <asm/cpu_has_feature.h>
+
+static char *pp_601(int k, int pp)
+{
+	if (pp == 0)
+		return k ? "NA" : "RWX";
+	if (pp == 1)
+		return k ? "ROX" : "RWX";
+	if (pp == 2)
+		return k ? "RWX" : "RWX";
+	return k ? "ROX" : "ROX";
+}
+
+static void bat_show_601(struct seq_file *m, int idx, u32 lower, u32 upper)
+{
+	u32 blpi = upper & 0xfffe0000;
+	u32 k = (upper >> 2) & 3;
+	u32 pp = upper & 3;
+	phys_addr_t pbn = PHYS_BAT_ADDR(lower);
+	u32 bsm = lower & 0x3ff;
+	u32 size = (bsm + 1) << 17;
+
+	seq_printf(m, "%d: ", idx);
+	if (!(lower & 0x40)) {
+		seq_puts(m, "        -\n");
+		return;
+	}
+
+	seq_printf(m, "0x%08x-0x%08x ", blpi, blpi + size - 1);
+#ifdef CONFIG_PHYS_64BIT
+	seq_printf(m, "0x%016llx ", pbn);
+#else
+	seq_printf(m, "0x%08x ", pbn);
+#endif
+
+	seq_printf(m, "Kernel %s User %s", pp_601(k & 2, pp), pp_601(k & 1, pp));
+
+	if (lower & _PAGE_WRITETHRU)
+		seq_puts(m, "write through ");
+	if (lower & _PAGE_NO_CACHE)
+		seq_puts(m, "no cache ");
+	if (lower & _PAGE_COHERENT)
+		seq_puts(m, "coherent ");
+	seq_puts(m, "\n");
+}
+
+#define BAT_SHOW_601(_m, _n, _l, _u) bat_show_601(_m, _n, mfspr(_l), mfspr(_u))
+
+static int bats_show_601(struct seq_file *m, void *v)
+{
+	seq_puts(m, "---[ Block Address Translation ]---\n");
+
+	BAT_SHOW_601(m, 0, SPRN_IBAT0L, SPRN_IBAT0U);
+	BAT_SHOW_601(m, 1, SPRN_IBAT1L, SPRN_IBAT1U);
+	BAT_SHOW_601(m, 2, SPRN_IBAT2L, SPRN_IBAT2U);
+	BAT_SHOW_601(m, 3, SPRN_IBAT3L, SPRN_IBAT3U);
+
+	return 0;
+}
+
+static void bat_show_603(struct seq_file *m, int idx, u32 lower, u32 upper, bool is_d)
+{
+	u32 bepi = upper & 0xfffe0000;
+	u32 bl = (upper >> 2) & 0x7ff;
+	u32 k = upper & 3;
+	phys_addr_t brpn = PHYS_BAT_ADDR(lower);
+	u32 size = (bl + 1) << 17;
+
+	seq_printf(m, "%d: ", idx);
+	if (k == 0) {
+		seq_puts(m, "        -\n");
+		return;
+	}
+
+	seq_printf(m, "0x%08x-0x%08x ", bepi, bepi + size - 1);
+#ifdef CONFIG_PHYS_64BIT
+	seq_printf(m, "0x%016llx ", brpn);
+#else
+	seq_printf(m, "0x%08x ", brpn);
+#endif
+
+	if (k == 1)
+		seq_puts(m, "User ");
+	else if (k == 2)
+		seq_puts(m, "Kernel ");
+	else
+		seq_puts(m, "Kernel/User ");
+
+	if (lower & BPP_RX)
+		seq_puts(m, is_d ? "RO " : "EXEC ");
+	else if (lower & BPP_RW)
+		seq_puts(m, is_d ? "RW " : "EXEC ");
+	else
+		seq_puts(m, is_d ? "NA " : "NX   ");
+
+	if (lower & _PAGE_WRITETHRU)
+		seq_puts(m, "write through ");
+	if (lower & _PAGE_NO_CACHE)
+		seq_puts(m, "no cache ");
+	if (lower & _PAGE_COHERENT)
+		seq_puts(m, "coherent ");
+	if (lower & _PAGE_GUARDED)
+		seq_puts(m, "guarded ");
+	seq_puts(m, "\n");
+}
+
+#define BAT_SHOW_603(_m, _n, _l, _u, _d) bat_show_603(_m, _n, mfspr(_l), mfspr(_u), _d)
+
+static int bats_show_603(struct seq_file *m, void *v)
+{
+	seq_puts(m, "---[ Instruction Block Address Translation ]---\n");
+
+	BAT_SHOW_603(m, 0, SPRN_IBAT0L, SPRN_IBAT0U, false);
+	BAT_SHOW_603(m, 1, SPRN_IBAT1L, SPRN_IBAT1U, false);
+	BAT_SHOW_603(m, 2, SPRN_IBAT2L, SPRN_IBAT2U, false);
+	BAT_SHOW_603(m, 3, SPRN_IBAT3L, SPRN_IBAT3U, false);
+	if (mmu_has_feature(MMU_FTR_USE_HIGH_BATS)) {
+		BAT_SHOW_603(m, 4, SPRN_IBAT4L, SPRN_IBAT4U, false);
+		BAT_SHOW_603(m, 5, SPRN_IBAT5L, SPRN_IBAT5U, false);
+		BAT_SHOW_603(m, 6, SPRN_IBAT6L, SPRN_IBAT6U, false);
+		BAT_SHOW_603(m, 7, SPRN_IBAT7L, SPRN_IBAT7U, false);
+	}
+
+	seq_puts(m, "\n---[ Data Block Address Translation ]---\n");
+
+	BAT_SHOW_603(m, 0, SPRN_DBAT0L, SPRN_DBAT0U, true);
+	BAT_SHOW_603(m, 1, SPRN_DBAT1L, SPRN_DBAT1U, true);
+	BAT_SHOW_603(m, 2, SPRN_DBAT2L, SPRN_DBAT2U, true);
+	BAT_SHOW_603(m, 3, SPRN_DBAT3L, SPRN_DBAT3U, true);
+	if (mmu_has_feature(MMU_FTR_USE_HIGH_BATS)) {
+		BAT_SHOW_603(m, 4, SPRN_DBAT4L, SPRN_DBAT4U, true);
+		BAT_SHOW_603(m, 5, SPRN_DBAT5L, SPRN_DBAT5U, true);
+		BAT_SHOW_603(m, 6, SPRN_DBAT6L, SPRN_DBAT6U, true);
+		BAT_SHOW_603(m, 7, SPRN_DBAT7L, SPRN_DBAT7U, true);
+	}
+
+	return 0;
+}
+
+static int bats_open(struct inode *inode, struct file *file)
+{
+	if (cpu_has_feature(CPU_FTR_601))
+		return single_open(file, bats_show_601, NULL);
+
+	return single_open(file, bats_show_603, NULL);
+}
+
+static const struct file_operations bats_fops = {
+	.open		= bats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init bats_init(void)
+{
+	struct dentry *debugfs_file;
+
+	debugfs_file = debugfs_create_file("block_address_translation", 0400,
+					   powerpc_debugfs_root, NULL, &bats_fops);
+	return debugfs_file ? 0 : -ENOMEM;
+}
+device_initcall(bats_init);
-- 
2.40.1



