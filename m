Return-Path: <stable+bounces-46544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C578B8D078D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1F21F220C9
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB45216E896;
	Mon, 27 May 2024 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7H2yHzg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B3116726B;
	Mon, 27 May 2024 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825474; cv=none; b=jKhE0u04uNeqt+IbtON2Z9736UMCKKvyvy5+D4OoXUunojJDdYoVGMkZXklq8ikKGhDpkdAphNDuKKnU7D1CgKDH7Blzve4gDKgXTeZ9qzsY3qB4E49UzQvt1qnIX/hVP7y6+Oud63+tia0UFGhMya5L9Zs1+PxH/tlygXkePjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825474; c=relaxed/simple;
	bh=Rdcig0QlEbYG/qze7YAYrzkVNJF3ZDiIo1GDKCxuQ1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kriHsIG/qx07zrnQrMW4BVIsQw4E0p8D9wvukn7Acn4QP/PPadYP9tKDekiFhKATwcXFcOxkFfCnqAFPBDyVtBulJZghMe1uj8dO8T4/7NjmTen7tPm3rb6vGIJhlm5U66o0jKPCtp/IDM5zYvHt3GjAs6oHX2KlFSS2AljgUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7H2yHzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB19C4AF08;
	Mon, 27 May 2024 15:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825474;
	bh=Rdcig0QlEbYG/qze7YAYrzkVNJF3ZDiIo1GDKCxuQ1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7H2yHzgQDB9nl+JvJG9ACWz6OxStJdjMxHf4oguQH+3XpJVg9/qVkIy1rj9XrWII
	 1XvceYH96asj5Iei39hzDbfq3awjKOjqODLD7gcKAxS4UPR0k/GT5wkt3QZbYzTaZA
	 jjBtZ4Th+0Bk+h74hei5JHCNtsnGCPPM1iQQzzL1Tf1LD33IByt7yngp5RT4UIATdm
	 owjvQ0e8vg9lNo2bn1Mh0ukuo31o+EUxAK7/JIbGHOB3jwAfb8aJkO7ZwiJtfveqfm
	 /0bYxWDd0UJam0nrXFeEAEGKB722f0YC16/kpnOfRyALo52J6lYBSqml2KWy38MJDk
	 EVj/btSHJLU/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	bhe@redhat.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	geert@linux-m68k.org,
	wangkefeng.wang@huawei.com,
	christophe.leroy@csgroup.eu,
	stanislav.kinsburskii@gmail.com,
	bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 10/11] powerpc/io: Avoid clang null pointer arithmetic warnings
Date: Mon, 27 May 2024 11:56:47 -0400
Message-ID: <20240527155710.3865826-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155710.3865826-1-sashal@kernel.org>
References: <20240527155710.3865826-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 03c0f2c2b2220fc9cf8785cd7b61d3e71e24a366 ]

With -Wextra clang warns about pointer arithmetic using a null pointer.
When building with CONFIG_PCI=n, that triggers a warning in the IO
accessors, eg:

  In file included from linux/arch/powerpc/include/asm/io.h:672:
  linux/arch/powerpc/include/asm/io-defs.h:23:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     23 | DEF_PCI_AC_RET(inb, u8, (unsigned long port), (port), pio, port)
        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ...
  linux/arch/powerpc/include/asm/io.h:591:53: note: expanded from macro '__do_inb'
    591 | #define __do_inb(port)          readb((PCI_IO_ADDR)_IO_BASE + port);
        |                                       ~~~~~~~~~~~~~~~~~~~~~ ^

That is because when CONFIG_PCI=n, _IO_BASE is defined as 0.

Although _IO_BASE is defined as plain 0, the cast (PCI_IO_ADDR) converts
it to void * before the addition with port happens.

Instead the addition can be done first, and then the cast. The resulting
value will be the same, but avoids the warning, and also avoids void
pointer arithmetic which is apparently non-standard.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYtEh8zmq8k8wE-8RZwW-Qr927RLTn+KqGnq1F=ptaaNsA@mail.gmail.com
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240503075619.394467-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/io.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index fc112a91d0c2f..0e1745e5125b0 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -553,12 +553,12 @@ __do_out_asm(_rec_outl, "stwbrx")
 #define __do_inw(port)		_rec_inw(port)
 #define __do_inl(port)		_rec_inl(port)
 #else /* CONFIG_PPC32 */
-#define __do_outb(val, port)	writeb(val,(PCI_IO_ADDR)_IO_BASE+port);
-#define __do_outw(val, port)	writew(val,(PCI_IO_ADDR)_IO_BASE+port);
-#define __do_outl(val, port)	writel(val,(PCI_IO_ADDR)_IO_BASE+port);
-#define __do_inb(port)		readb((PCI_IO_ADDR)_IO_BASE + port);
-#define __do_inw(port)		readw((PCI_IO_ADDR)_IO_BASE + port);
-#define __do_inl(port)		readl((PCI_IO_ADDR)_IO_BASE + port);
+#define __do_outb(val, port)	writeb(val,(PCI_IO_ADDR)(_IO_BASE+port));
+#define __do_outw(val, port)	writew(val,(PCI_IO_ADDR)(_IO_BASE+port));
+#define __do_outl(val, port)	writel(val,(PCI_IO_ADDR)(_IO_BASE+port));
+#define __do_inb(port)		readb((PCI_IO_ADDR)(_IO_BASE + port));
+#define __do_inw(port)		readw((PCI_IO_ADDR)(_IO_BASE + port));
+#define __do_inl(port)		readl((PCI_IO_ADDR)(_IO_BASE + port));
 #endif /* !CONFIG_PPC32 */
 
 #ifdef CONFIG_EEH
@@ -574,12 +574,12 @@ __do_out_asm(_rec_outl, "stwbrx")
 #define __do_writesw(a, b, n)	_outsw(PCI_FIX_ADDR(a),(b),(n))
 #define __do_writesl(a, b, n)	_outsl(PCI_FIX_ADDR(a),(b),(n))
 
-#define __do_insb(p, b, n)	readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
-#define __do_insw(p, b, n)	readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
-#define __do_insl(p, b, n)	readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
-#define __do_outsb(p, b, n)	writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
-#define __do_outsw(p, b, n)	writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
-#define __do_outsl(p, b, n)	writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
+#define __do_insb(p, b, n)	readsb((PCI_IO_ADDR)(_IO_BASE+(p)), (b), (n))
+#define __do_insw(p, b, n)	readsw((PCI_IO_ADDR)(_IO_BASE+(p)), (b), (n))
+#define __do_insl(p, b, n)	readsl((PCI_IO_ADDR)(_IO_BASE+(p)), (b), (n))
+#define __do_outsb(p, b, n)	writesb((PCI_IO_ADDR)(_IO_BASE+(p)),(b),(n))
+#define __do_outsw(p, b, n)	writesw((PCI_IO_ADDR)(_IO_BASE+(p)),(b),(n))
+#define __do_outsl(p, b, n)	writesl((PCI_IO_ADDR)(_IO_BASE+(p)),(b),(n))
 
 #define __do_memset_io(addr, c, n)	\
 				_memset_io(PCI_FIX_ADDR(addr), c, n)
-- 
2.43.0


