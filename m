Return-Path: <stable+bounces-80325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFC698DCE8
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7911F25EA6
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC56B1D0E01;
	Wed,  2 Oct 2024 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rs4Iln/f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF51D0786;
	Wed,  2 Oct 2024 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880044; cv=none; b=bFyQ02N8toB90DN1okYA1atEV0Lq04C3BCCtTucHdBM4VlCJeWGkHMq5D6MD6LaI5B44/XiFQL096uINJq0L4si9unbrEGiOntNgB/5JTbyUskOL1k++41rLFcwf+u936kRkS42c3Y70VHiXt87RF8WOw8ErhRnFvC+RfwdF8lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880044; c=relaxed/simple;
	bh=oeFOStyacAjBlnqPJ0mmpDncBwUPdOQoOYRT0xK5dEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4nt65PVey1PQcWhai9UdVywQLG6ptWrRRy6FDLW2UGRS2D5izahbgvOgLbwkoOfe397XRV5ZeIBs59Kg0GpcIl3KOPXh04H8xPZChr+tBDBSXg42JdCZV+Zy/CZx4Xvz5ReF/Zy/AmtfADMszrEadC/TjM1hRBbqQ/j/c1zS9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rs4Iln/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53EFC4CEC2;
	Wed,  2 Oct 2024 14:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880044;
	bh=oeFOStyacAjBlnqPJ0mmpDncBwUPdOQoOYRT0xK5dEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rs4Iln/fkx/hHY7DBTXXGtNWtYLOB+NtxAWrID7gmAmmlzqqNBLv84SWNf9nYyknF
	 sb30FYNDMxo2miDdtV5FJu0arKKtOIVWcdkCyTUf/K0yq+2HrV7YcURh/Qqt9B9BaJ
	 DWFqB91xaKUBItFp5U3REQkQ5qTfX1UjI1qpZObY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 324/538] riscv: Fix fp alignment bug in perf_callchain_user()
Date: Wed,  2 Oct 2024 14:59:23 +0200
Message-ID: <20241002125805.217204794@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit 22ab08955ea13be04a8efd20cc30890e0afaa49c ]

The standard RISC-V calling convention said:
	"The stack grows downward and the stack pointer is always
	kept 16-byte aligned".

So perf_callchain_user() should check whether 16-byte aligned for fp.

Link: https://riscv.org/wp-content/uploads/2015/01/riscv-calling.pdf

Fixes: dbeb90b0c1eb ("riscv: Add perf callchain support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Björn Töpel <bjorn@kernel.org>
Link: https://lore.kernel.org/r/20240708032847.2998158-2-ruanjinjie@huawei.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/perf_callchain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
index 3348a61de7d99..2932791e93882 100644
--- a/arch/riscv/kernel/perf_callchain.c
+++ b/arch/riscv/kernel/perf_callchain.c
@@ -62,7 +62,7 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 	perf_callchain_store(entry, regs->epc);
 
 	fp = user_backtrace(entry, fp, regs->ra);
-	while (fp && !(fp & 0x3) && entry->nr < entry->max_stack)
+	while (fp && !(fp & 0x7) && entry->nr < entry->max_stack)
 		fp = user_backtrace(entry, fp, 0);
 }
 
-- 
2.43.0




