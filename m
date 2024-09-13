Return-Path: <stable+bounces-76094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A41978662
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 19:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BFA282C8D
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE6A84A27;
	Fri, 13 Sep 2024 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxgVP/Qb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277A77DA95;
	Fri, 13 Sep 2024 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247174; cv=none; b=idWXZKtorqi8ttSlx2WPiUmvDj5lSeigFkt2oMV0kW6ztXpHoI/oc90l2lF0TguuK0EQcZOfC10DYxbGHyHF4pQnsylIYJpjI5Yqtg45WLqMn+MJ9I3Fv1gRrUN+OdBt6TEdUlW9N0Hm0etjtcFlnPPW4X4wD2BpcCy8Zn+YIO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247174; c=relaxed/simple;
	bh=NxChBfmfE/PQew0FTivawHLni9itxwM9CzLHCbgP3wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpBzqpwNwea1uIJ1zzseqUeHS4I3NcHDKv/PkPBMot5Rz9f15Q1bcRr9IVoYr56ZsNH2p5RWBBO4jkY6iIi+45votGlAc2mLXBUiLKxwDHyxpYtE0zLsFaHLlLn1qCT0f0i98PHSWH67UxdZlqUeKUVJhM4lQ0vcc1jkX7MlZ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxgVP/Qb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1620C4CECD;
	Fri, 13 Sep 2024 17:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726247174;
	bh=NxChBfmfE/PQew0FTivawHLni9itxwM9CzLHCbgP3wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pxgVP/QbAzUTKfqfKBIPOtYV/dBwYzREvdFWhIev1FqfdG+r+zM/Ep3mNROPDX5Tv
	 56GPF8PLj+Sawwz2McYJWVTPL2JV89vDKy3zmhR2SFksTPUdkIZbNKbLGXZZpYW+7R
	 gJIfX3623C5fvqr11wx88YLB7vvPqZZRT/NL4K5EfTRw3iI2nLM39RS8hUy6kdBCAb
	 34ffpufBY4nmVrnOcbLVJVe1sjqqzLGo+3yIGjjXYsGH/GrV3QarqvRLOgDVzf/tl5
	 9N3kY+P3Gm40+KaM3PkLYnMvAxtKWGaV5sKv1ca/D2vmf9HWZuD/gg+N/Bh3i8bIoY
	 OTbv8k4e02ksg==
From: Alexey Gladkov <legion@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: "Alexey Gladkov (Intel)" <legion@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>,
	cho@microsoft.com,
	decui@microsoft.com,
	John.Starks@microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH v7 1/6] x86/tdx: Fix "in-kernel MMIO" check
Date: Fri, 13 Sep 2024 19:05:56 +0200
Message-ID: <565a804b80387970460a4ebc67c88d1380f61ad1.1726237595.git.legion@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726237595.git.legion@kernel.org>
References: <cover.1725622408.git.legion@kernel.org> <cover.1726237595.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alexey Gladkov (Intel)" <legion@kernel.org>

TDX only supports kernel-initiated MMIO operations. The handle_mmio()
function checks if the #VE exception occurred in the kernel and rejects
the operation if it did not.

However, userspace can deceive the kernel into performing MMIO on its
behalf. For example, if userspace can point a syscall to an MMIO address,
syscall does get_user() or put_user() on it, triggering MMIO #VE. The
kernel will treat the #VE as in-kernel MMIO.

Ensure that the target MMIO address is within the kernel before decoding
instruction.

Cc: stable@vger.kernel.org
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 078e2bac2553..d6e6407e3999 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -16,6 +16,7 @@
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
+#include <asm/traps.h>
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -434,6 +435,11 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 			return -EINVAL;
 	}
 
+	if (!fault_in_kernel_space(ve->gla)) {
+		WARN_ONCE(1, "Access to userspace address is not supported");
+		return -EINVAL;
+	}
+
 	/*
 	 * Reject EPT violation #VEs that split pages.
 	 *
-- 
2.46.0


