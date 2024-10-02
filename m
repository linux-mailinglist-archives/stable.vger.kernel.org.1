Return-Path: <stable+bounces-78650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2AC98D337
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE14EB2090A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D3E1D07A9;
	Wed,  2 Oct 2024 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOihqfzn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38551CF7AD
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871885; cv=none; b=A+1zUOOAm8mxvUQiIEAe5hREJGU4qja+o6N65fKps7ENwVgHYax4qyyLOtNc5rEegZ5u0K3VJPKs/ydGxOK00QNaFv6k/wR/OVE+6XsrVX7L3684duz6+dBDJnJaPs7wORD+IVPKe4L32wbVIExrmkIuOxA5UBDQVzZMcm2SFVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871885; c=relaxed/simple;
	bh=X3e9kRULRjZb9TGN3ZNhhoFjOUtuHwcyScRt2yxCU0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpS24G1nx3zh+HfUfZO9cb0alqSnutse4lbCD+JeSF4EjpNYRMptBLe8U7yBj+eo767B/58hX+wBWHdPydGo/jwNy8UCkDx5NRX7ZRDF+RR0Wf92awqPyHBAYUrsBH8lkZkUyNCsM+Ja0CiXaVLeqp/gyaPeygsn5x4Dv491w7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOihqfzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE21C4CED4;
	Wed,  2 Oct 2024 12:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727871885;
	bh=X3e9kRULRjZb9TGN3ZNhhoFjOUtuHwcyScRt2yxCU0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qOihqfznBKgQlavQ2mQ3heVvU/sWBs+ZhFrJHxsQI3G8uJV8XqLzVB6kllqMYC+cx
	 HcmgQeYCHKcwUAjdiPgo0H/tqhhby/qUP51qZQJxx8k76sXfs0lzotnCA7b9i5WIZg
	 zafy2bU6zovI/aTu2kOUShbNGNKeZll4vbyDxg5z7qk69VM6moV3jzqRCbtz/ouaFW
	 pyLe+OSZxz0HUjqWdgY6+Q2BgsHwz0J1qKOmXkE6YKQhQHjXmwVvK0UlauvVJGQIxW
	 fWPFTHeRRrLYKmAuULALKRR6OX8WXxPO+H/v7jfHh/l17qKlMtP4P5wobramJnACwZ
	 sDuOLrvUSwvlA==
From: "Alexey Gladkov (Intel)" <legion@kernel.org>
To: stable@vger.kernel.org
Cc: "Alexey Gladkov (Intel)" <legion@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 6.6.y] x86/tdx: Fix "in-kernel MMIO" check
Date: Wed,  2 Oct 2024 14:23:59 +0200
Message-ID: <20241002122359.83485-1-legion@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <2024100100-emperor-thespian-397f@gregkh>
References: <2024100100-emperor-thespian-397f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX only supports kernel-initiated MMIO operations. The handle_mmio()
function checks if the #VE exception occurred in the kernel and rejects
the operation if it did not.

However, userspace can deceive the kernel into performing MMIO on its
behalf. For example, if userspace can point a syscall to an MMIO address,
syscall does get_user() or put_user() on it, triggering MMIO #VE. The
kernel will treat the #VE as in-kernel MMIO.

Ensure that the target MMIO address is within the kernel before decoding
instruction.

Fixes: 31d58c4e557d ("x86/tdx: Handle in-kernel MMIO")
Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/565a804b80387970460a4ebc67c88d1380f61ad1.1726237595.git.legion%40kernel.org
(cherry picked from commit d4fc4d01471528da8a9797a065982e05090e1d81)
Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/coco/tdx/tdx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 006041fbb65f..905ac8a3f716 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -14,6 +14,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <asm/traps.h>
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -405,6 +406,11 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
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
2.46.2


