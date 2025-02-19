Return-Path: <stable+bounces-117983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93118A3B934
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE70188B4C5
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5F61B87D4;
	Wed, 19 Feb 2025 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jvzZ8Q9d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0C18FC86;
	Wed, 19 Feb 2025 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956904; cv=none; b=BCSD863x/G2pehhogEw/uRTbDAUmwaiQQoNdHQzvHf/b77BWQPY9k/di++A7Bb0apIjVYCtG+80oiF5TavELzT3sBa5tTW4rp6yqjrInrpXVpurTp85I/guKO1V9ew1VmQiu04ZF/eNlC+j/wCI0u9mRY1WNaOehxXMmXIGDrP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956904; c=relaxed/simple;
	bh=uueFgAKfmia4kMZaEUa/hDy6d2EpmCyKwIkwIU288fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q44IZVak4TQwgfMbmx4nWCIGS5AOW12V7XN0tqM/NiV3HXczLFOq3HzrIk+ddmQRSj7qm49S4IhWzH6EHq2KjE+CDCDsRyn6Qd35NAxhgd/f1EXPyqDuLitGxPrYkHcONc9BpEv3GowqWNr+dDdln/DotxrK1BPfOQCULjsIsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jvzZ8Q9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C9DC4CED1;
	Wed, 19 Feb 2025 09:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739956904;
	bh=uueFgAKfmia4kMZaEUa/hDy6d2EpmCyKwIkwIU288fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvzZ8Q9dX53sR/rDgxU9BD8aQi0wy/ZcyRlWRdXTmEVXzDR6kGRXqcLForgsbxBKP
	 76Jj4UaZcYc9UO8K8FKxuM7cEbKypGOZc67k+QEmlTlN7Nw38AtXCzGPXdyaI7p3uc
	 fQ7SiaMnwSRmwgr7ptGPvEXEEX87nlKLY3POGCnM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 6.1 340/578] s390/futex: Fix FUTEX_OP_ANDN implementation
Date: Wed, 19 Feb 2025 09:25:44 +0100
Message-ID: <20250219082706.391782336@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <hca@linux.ibm.com>

commit 26701574cee6777f867f89b4a5c667817e1ee0dd upstream.

The futex operation FUTEX_OP_ANDN is supposed to implement

*(int *)UADDR2 &= ~OPARG;

The s390 implementation just implements an AND instead of ANDN.
Add the missing bitwise not operation to oparg to fix this.

This is broken since nearly 19 years, so it looks like user space is
not making use of this operation.

Fixes: 3363fbdd6fb4 ("[PATCH] s390: futex atomic operations")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/futex.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/include/asm/futex.h
+++ b/arch/s390/include/asm/futex.h
@@ -44,7 +44,7 @@ static inline int arch_futex_atomic_op_i
 		break;
 	case FUTEX_OP_ANDN:
 		__futex_atomic_op("lr %2,%1\nnr %2,%5\n",
-				  ret, oldval, newval, uaddr, oparg);
+				  ret, oldval, newval, uaddr, ~oparg);
 		break;
 	case FUTEX_OP_XOR:
 		__futex_atomic_op("lr %2,%1\nxr %2,%5\n",



