Return-Path: <stable+bounces-11017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C8882E403
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 00:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C361C22450
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 23:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0094C25631;
	Mon, 15 Jan 2024 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iULofnFb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5202563C;
	Mon, 15 Jan 2024 23:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5B8C433F1;
	Mon, 15 Jan 2024 23:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361383;
	bh=gnuy8mZtzmZKWhVWMXrBl/M8bT9jAiwlavaWGuykNo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iULofnFb0XXbJgW908O6afi2jnbKy5hQgjicy9PTqHlAE6m9YnJZGRjaRYzxq2ciF
	 dmT5o4Mh2ei7kTwG1QBVPHD0h6nnyyi9yAoUPVEJVPTE6KgrV5jyVaocaQrLOwBQNZ
	 7dC5JXxvadU4uNAP7psh7e64VChcPFjXAAuzCMN/murA+0R/usZ494/+G0TGLJvBqJ
	 TcHCWTXK67VqSNqdHpbAN3Mbug0eHkX65Ys7sgbigM1D05D3h2HywsnW65BahwY9EN
	 7qLCm0X6tpFaI/P6p6HS1JwAzfWTJWcZEp0iQNBgi7gs3Pg7kqG5hNWk/X7v4Fjsjo
	 gMAGi5szlI3AQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	christophe.leroy@csgroup.eu,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 3/4] powerpc/mm: Fix build failures due to arch_reserved_kernel_pages()
Date: Mon, 15 Jan 2024 18:29:28 -0500
Message-ID: <20240115232935.210529-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115232935.210529-1-sashal@kernel.org>
References: <20240115232935.210529-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit d8c3f243d4db24675b653f0568bb65dae34e6455 ]

With NUMA=n and FA_DUMP=y or PRESERVE_FA_DUMP=y the build fails with:

  arch/powerpc/kernel/fadump.c:1739:22: error: no previous prototype for ‘arch_reserved_kernel_pages’ [-Werror=missing-prototypes]
  1739 | unsigned long __init arch_reserved_kernel_pages(void)
       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~

The prototype for arch_reserved_kernel_pages() is in include/linux/mm.h,
but it's guarded by __HAVE_ARCH_RESERVED_KERNEL_PAGES. The powerpc
headers define __HAVE_ARCH_RESERVED_KERNEL_PAGES in asm/mmzone.h, which
is not included into the generic headers when NUMA=n.

Move the definition of __HAVE_ARCH_RESERVED_KERNEL_PAGES into asm/mmu.h
which is included regardless of NUMA=n.

Additionally the ifdef around __HAVE_ARCH_RESERVED_KERNEL_PAGES needs to
also check for CONFIG_PRESERVE_FA_DUMP.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231130114433.3053544-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/mmu.h    | 4 ++++
 arch/powerpc/include/asm/mmzone.h | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 2b396de45e9e..20cdf744522b 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -330,5 +330,9 @@ static inline void mmu_early_init_devtree(void) { }
 #include <asm/nohash/mmu.h>
 #endif
 
+#if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)
+#define __HAVE_ARCH_RESERVED_KERNEL_PAGES
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_MMU_H_ */
diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
index 91c69ff53a8a..50c2198c2c76 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -42,9 +42,6 @@ u64 memory_hotplug_max(void);
 #else
 #define memory_hotplug_max() memblock_end_of_DRAM()
 #endif /* CONFIG_NEED_MULTIPLE_NODES */
-#ifdef CONFIG_FA_DUMP
-#define __HAVE_ARCH_RESERVED_KERNEL_PAGES
-#endif
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_MMZONE_H_ */
-- 
2.43.0


