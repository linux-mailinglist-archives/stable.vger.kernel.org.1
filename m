Return-Path: <stable+bounces-46517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B12F8D073D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2453E1F21049
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC2516A37B;
	Mon, 27 May 2024 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqqc+rfk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC903155C8F;
	Mon, 27 May 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825305; cv=none; b=gXNgEgrN+wDfwQQpEDzMktJw9Ql+KJODdNOrpeHkvxJPPcQFsLy3WCafwpBbVKGtKYCpLtG4sd3hvg/Ci8b7E6W0nUDCswLOWEbzOPAfgoGE/qKCjoeFtPaQpkJ3jrekLAxiB5sqzdrlepDegqkpPfcnX9rsN1A5fmCbXDXU2Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825305; c=relaxed/simple;
	bh=QyS69jgg7CJB7UMnlbRSwr6HqSkeIzryJsG90rMbXzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLR0yA7vuk/4u2ywTjKAltOHOX1Npj/3I4Is/JxtWRm62eEzRZoeWW8lafbnXo8YDWVy8BP1p7eqK2hXEcp5p+UNNz+hl80HjWst2NbvvbFkTOcq1FdITIfXxofjwYeyOiD7eTQi5crz3OVqLX/0hWgrYaCuGYSakCXuiDDz+BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqqc+rfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D20C2BBFC;
	Mon, 27 May 2024 15:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825304;
	bh=QyS69jgg7CJB7UMnlbRSwr6HqSkeIzryJsG90rMbXzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqqc+rfkhJ940cQdqp/rqwQjarRSggA7BGg5KNVW+Rf5RbGEHpgrFVER3Cv8BXPSF
	 MstHb9f9SITmk1DcFlk8kHonY+kODuKzvQ79sjykEJVa7aKEVXQ6lmc5j0f9ppP3ZH
	 04VOpakk5pbrVqJVAB/UASYdZ+z6YH4LJJQz858mJ+1FTFSjErP767q0gGgAxoPEn7
	 QLJskF95y5uV2bcA92qrQrRZAUfoRN0syyhyahIMPTn+Wau9dfLGd6Gxs7NTtb75SC
	 FRtonwudkf2PMMVrwbSjYSNo2XQ1JvAU246rP36VQgQ6OT8sV6T23LzbjMBX2UxqRQ
	 hs5Q+TKmocDeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	arnd@arndb.de,
	bhe@redhat.com,
	rppt@kernel.org,
	geert@linux-m68k.org,
	stanislav.kinsburskii@gmail.com,
	christophe.leroy@csgroup.eu,
	bhelgaas@google.com,
	wangkefeng.wang@huawei.com,
	linuxppc-dev@lists.ozlabs.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 19/20] powerpc/io: Avoid clang null pointer arithmetic warnings
Date: Mon, 27 May 2024 11:53:02 -0400
Message-ID: <20240527155349.3864778-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155349.3864778-1-sashal@kernel.org>
References: <20240527155349.3864778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
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
index 08c550ed49be6..ba2e13bb879dc 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -585,12 +585,12 @@ __do_out_asm(_rec_outl, "stwbrx")
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
@@ -606,12 +606,12 @@ __do_out_asm(_rec_outl, "stwbrx")
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


