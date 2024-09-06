Return-Path: <stable+bounces-73777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF7996F395
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 13:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B921C224D0
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 11:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B8D1CEAD2;
	Fri,  6 Sep 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyoH99FQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2261CC147;
	Fri,  6 Sep 2024 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623427; cv=none; b=NwmqROQadHaIGUUDjBWP7ksJrVNoPWdkEgBsZEDQrqLhvIcUZhSijNRbPXZlho0fuRykBB/d3c6cjkA+k9wVT16kzF+ovrLvw2KvACHJNYvo0yit45fcoMjo/LgvGVUx+I1xrS8qHbhmdviFkOwkrUJHxOGTexP92SA+xCuDv7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623427; c=relaxed/simple;
	bh=Pq7HaeHb+oyX6a0W/LncyGpHPhum+h0zrTBZnIK+3FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmxryM0NVEfhaEGo2rba23QK2/zAkAkid/6PI5KmeH4Mvm5YU2NtXsq/DCSXulnQ4IEvv38Ph+Bvl0hmFLNjI4y7WmICpOtaTObKuHfEnIUejrvbYwoOWi0LZwqTsNQ7G14hE1SXKVLCJIZG2cO6grqEcxyj7Zy3TX0cuXr1heM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyoH99FQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FD5C4CEC5;
	Fri,  6 Sep 2024 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725623426;
	bh=Pq7HaeHb+oyX6a0W/LncyGpHPhum+h0zrTBZnIK+3FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lyoH99FQUzqSPOaJ5wJxkQAPRZPGulqBzEZIfRzUrJfdCjLag5XSTh8o2JfdXEDmc
	 iuow9Gj+ENTMxlXUaqwAkWRCjAPFTrp2joQYKv/14IeihFeA1LqDq4RjV3qMA8TwPS
	 mWHunxfeBdGBLpxyjXbxWRcQ45eq6/Dmjd0whQXEvQg4pMJaqlVVnBxLV2VPrj8mEp
	 dhkKj1Lzv42R7r3+iJwGEp8ii0k0mXg3A8PCkhnDRqW2d7y952KLTBe5/3Qympvyd2
	 x2nKWT0vzJodwZcQeU5T28VoGWBxJaErYbgy4c7qWUTtyBOEkbU1rl2I/x0QazLUMk
	 k57/k8L/FaEMA==
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
Subject: [PATCH v6 1/6] x86/tdx: Fix "in-kernel MMIO" check
Date: Fri,  6 Sep 2024 13:49:59 +0200
Message-ID: <398de747c81e06be4d3f3602ee11a7e2881f31ed.1725622408.git.legion@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725622408.git.legion@kernel.org>
References: <cover.1724837158.git.legion@kernel.org> <cover.1725622408.git.legion@kernel.org>
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
Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 078e2bac2553..c90d2fdb5fc4 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -405,6 +405,11 @@ static bool mmio_write(int size, unsigned long addr, unsigned long val)
 			       EPT_WRITE, addr, val);
 }
 
+static inline bool is_kernel_addr(unsigned long addr)
+{
+	return (long)addr < 0;
+}
+
 static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 {
 	unsigned long *reg, val, vaddr;
@@ -434,6 +439,11 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 			return -EINVAL;
 	}
 
+	if (!user_mode(regs) && !is_kernel_addr(ve->gla)) {
+		WARN_ONCE(1, "Access to userspace address is not supported");
+		return -EINVAL;
+	}
+
 	/*
 	 * Reject EPT violation #VEs that split pages.
 	 *
-- 
2.46.0


