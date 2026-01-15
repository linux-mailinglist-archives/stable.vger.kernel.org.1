Return-Path: <stable+bounces-209432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E14D26ECD
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C905325DEA7
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D682D595B;
	Thu, 15 Jan 2026 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cg3kSekb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498A028725F;
	Thu, 15 Jan 2026 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498679; cv=none; b=PBcU6Z5jHKbDfJIeI5SaOB5uilF/DmHAXA3UU5sdQdUOumgsLwWPgOzce9rrYam2YsxCDVvsQXDCi+xZe6inevFN6EFETFRW3m/BVtEuWtYkt1Q7N+XFatzGvpbkFm+g36SusbeoeECL5kqImlwZjGlHncZQyb4StOsyhFUvw3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498679; c=relaxed/simple;
	bh=sq4HR/ueQtnmOnLD9y71Aye8EoFWDdcfgoUv6b3ISz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvQCXIFNzJC7GgurxOBVJ1t1ivqsQeHZqYmMW+fnEtJwIr26YmnINRb0UngzIr4scKlOitddnUhjosZN9RfAmKqBmLTHRfjn0RXPlydXQy860CZ6U9Aux5oaKsteCWfijU8Eq0ZtCb89/F72dzPDSCZiN3W5tOGoRL1NtDPq6/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cg3kSekb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C819CC116D0;
	Thu, 15 Jan 2026 17:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768498679;
	bh=sq4HR/ueQtnmOnLD9y71Aye8EoFWDdcfgoUv6b3ISz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cg3kSekblsobJKhH79eIKSsLITuBrx77jwpWmBSBRsgc4xsx/Zz7xVCRGGXENLRb+
	 EJmLkxrZH9O3CrzKJmciTpPZV/j/1XsxupT717r0/z+bVw0ddnPIB1syW7s+SQkYhq
	 BX993OE3LX4G4prUD61hCyJf1sBHsuBEmwaP/s9Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Li <yang.li85200@gmail.com>,
	Guo Ren <guoren@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 516/554] csky: fix csky_cmpxchg_fixup not working
Date: Thu, 15 Jan 2026 17:49:42 +0100
Message-ID: <20260115164305.005043503@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164246.225995385@linuxfoundation.org>
References: <20260115164246.225995385@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Li <yang.li85200@gmail.com>

[ Upstream commit 809ef03d6d21d5fea016bbf6babeec462e37e68c ]

In the csky_cmpxchg_fixup function, it is incorrect to use the global
variable csky_cmpxchg_stw to determine the address where the exception
occurred.The global variable csky_cmpxchg_stw stores the opcode at the
time of the exception, while &csky_cmpxchg_stw shows the address where
the exception occurred.

Signed-off-by: Yang Li <yang.li85200@gmail.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 7215a46b6b8eb..98699fdeeeb54 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -45,8 +45,8 @@ static inline void csky_cmpxchg_fixup(struct pt_regs *regs)
 	if (trap_no(regs) != VEC_TLBMODIFIED)
 		return;
 
-	if (instruction_pointer(regs) == csky_cmpxchg_stw)
-		instruction_pointer_set(regs, csky_cmpxchg_ldw);
+	if (instruction_pointer(regs) == (unsigned long)&csky_cmpxchg_stw)
+		instruction_pointer_set(regs, (unsigned long)&csky_cmpxchg_ldw);
 	return;
 }
 #endif
-- 
2.51.0




