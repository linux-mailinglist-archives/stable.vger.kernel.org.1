Return-Path: <stable+bounces-18015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54CE848107
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8036D281947
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739FC1BC35;
	Sat,  3 Feb 2024 04:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RMvezo6A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332871B95C;
	Sat,  3 Feb 2024 04:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933485; cv=none; b=pZAnMPEdCbZoDY4AOW2VyUaTZuCANm05D8Dj1mMmPF9Zpe6wZJK8yzOky7fvhHcHY5tiAQKH/5oLLHd4K+XEloRvuYeDufmjETQ7T927Iqtl9y629f41qJTK8oMcuHeXWCsw8o7DfNz4IzweqEziPDQfaJsMUdkwhqMJ8ZXCSLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933485; c=relaxed/simple;
	bh=LPTTV4GEzriQZf9n2uu7blDFn884mM9qrbX2M3Z6034=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajTxbbt8ALDsT1lGne2EmdomSeyAEFID+JPb9QQTaqqE9X2EHezYFs2CbKzSZEvDV6hnh8hKal5Vmom4zwtcbDPHhTdkZOXKA39DsZMG8SyODdoHn/VYOcOuZDosCuc/4Gr1hJfG/26zMbMxqZtebq/mvn5m+HuL7UYYhLjebI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RMvezo6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED53CC433C7;
	Sat,  3 Feb 2024 04:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933485;
	bh=LPTTV4GEzriQZf9n2uu7blDFn884mM9qrbX2M3Z6034=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RMvezo6AMLdDVaLizTOu6rgTaDFoyKBbH1aXszLx0eb0wqQ97NkmDaR7a7oqNTF+r
	 YqnJzCfhfRRWh8f2F7NPiupEee2frEtmmp1CceknnliBaWQk2IIFUby72TqyxejaBN
	 85AXCIgnbcPqtHin6LGmUNIHP5lBqddMeBTk5sK4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Naveen N Rao <naveen@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 011/322] powerpc/lib: Validate size for vector operations
Date: Fri,  2 Feb 2024 20:01:48 -0800
Message-ID: <20240203035359.413727005@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naveen N Rao <naveen@kernel.org>

[ Upstream commit 8f9abaa6d7de0a70fc68acaedce290c1f96e2e59 ]

Some of the fp/vmx code in sstep.c assume a certain maximum size for the
instructions being emulated. The size of those operations however is
determined separately in analyse_instr().

Add a check to validate the assumption on the maximum size of the
operations, so as to prevent any unintended kernel stack corruption.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Build-tested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231123071705.397625-1-naveen@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/lib/sstep.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index a4ab8625061a..6af97dc0f6d5 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -586,6 +586,8 @@ static int do_fp_load(struct instruction_op *op, unsigned long ea,
 	} u;
 
 	nb = GETSIZE(op->type);
+	if (nb > sizeof(u))
+		return -EINVAL;
 	if (!address_ok(regs, ea, nb))
 		return -EFAULT;
 	rn = op->reg;
@@ -636,6 +638,8 @@ static int do_fp_store(struct instruction_op *op, unsigned long ea,
 	} u;
 
 	nb = GETSIZE(op->type);
+	if (nb > sizeof(u))
+		return -EINVAL;
 	if (!address_ok(regs, ea, nb))
 		return -EFAULT;
 	rn = op->reg;
@@ -680,6 +684,9 @@ static nokprobe_inline int do_vec_load(int rn, unsigned long ea,
 		u8 b[sizeof(__vector128)];
 	} u = {};
 
+	if (size > sizeof(u))
+		return -EINVAL;
+
 	if (!address_ok(regs, ea & ~0xfUL, 16))
 		return -EFAULT;
 	/* align to multiple of size */
@@ -707,6 +714,9 @@ static nokprobe_inline int do_vec_store(int rn, unsigned long ea,
 		u8 b[sizeof(__vector128)];
 	} u;
 
+	if (size > sizeof(u))
+		return -EINVAL;
+
 	if (!address_ok(regs, ea & ~0xfUL, 16))
 		return -EFAULT;
 	/* align to multiple of size */
-- 
2.43.0




