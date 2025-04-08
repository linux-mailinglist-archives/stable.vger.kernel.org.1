Return-Path: <stable+bounces-131657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1659CA80B83
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F93F505998
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183FD27713;
	Tue,  8 Apr 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oJNii+2F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA51E26B2CF;
	Tue,  8 Apr 2025 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116986; cv=none; b=qrhjb7NDTe1QlHWNqi9i1GE8qELhZlf1EdIyoZnFRNbsKaig54uHL5/2SMrxhSyKzto94lj+nLKJ/jYxfO449ubB3WM0JXdbAVc8Ux7/h8gQMhigEDcpbNv0wfXZyUSLglT/pG6bWcXf9SHp9P9tf6xnkL+CO0wWSNAWdmOsn7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116986; c=relaxed/simple;
	bh=6fPL2qnHnjw29Jv4GBJnpEv3ILoSuTKhf7pvKYy5lXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGqK2iJ0ODZkC0+wvas4nqHTwUFh4IzJqtAtdJYI9oM1r3F6IYZvFLT6VMJdChCUHrCKffxQ5CYI4OvxUimt+ydDaQJG+2SfZM56ti6jO8A1QqTYEi4Qy5IBNTxHIs17BtP9C/PcCSHNTKrlckMOR9TdL4zASRgGGKsCRTZxTAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oJNii+2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2164C4CEE5;
	Tue,  8 Apr 2025 12:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116986;
	bh=6fPL2qnHnjw29Jv4GBJnpEv3ILoSuTKhf7pvKYy5lXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJNii+2F1NyC0f7XADRDo6gelpmg+8btCHVgGy8wpeSzBoxbXf5MRbH9b86rdIfil
	 AwMFdgtOoqEXG7P7rJ5Umnwg1O6r+0pJ3LgTkxHzF3mbvvHVRcIS7x56mDLI5TbJxv
	 FXID1VHUzBv/u4N+vQW787I4sAfz0kDu/tQ6j2+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Juhan Jin <juhan.jin@foxmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 305/423] riscv: ftrace: Add parentheses in macro definitions of make_call_t0 and make_call_ra
Date: Tue,  8 Apr 2025 12:50:31 +0200
Message-ID: <20250408104852.900329449@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juhan Jin <juhan.jin@foxmail.com>

[ Upstream commit 5f1a58ed91a040d4625d854f9bb3dd4995919202 ]

This patch adds parentheses to parameters caller and callee of macros
make_call_t0 and make_call_ra. Every existing invocation of these two
macros uses a single variable for each argument, so the absence of the
parentheses seems okay. However, future invocations might use more
complex expressions as arguments. For example, a future invocation might
look like this: make_call_t0(a - b, c, call). Without parentheses in the
macro definition, the macro invocation expands to:

...
unsigned int offset = (unsigned long) c - (unsigned long) a - b;
...

which is clearly wrong.

The use of parentheses ensures arguments are correctly evaluated and
potentially saves future users of make_call_t0 and make_call_ra debugging
trouble.

Fixes: 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to half")
Signed-off-by: Juhan Jin <juhan.jin@foxmail.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/tencent_AE90AA59903A628E87E9F80E563DA5BA5508@qq.com
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/include/asm/ftrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 2cddd79ff21b1..f253c8dae878e 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -92,7 +92,7 @@ struct dyn_arch_ftrace {
 #define make_call_t0(caller, callee, call)				\
 do {									\
 	unsigned int offset =						\
-		(unsigned long) callee - (unsigned long) caller;	\
+		(unsigned long) (callee) - (unsigned long) (caller);	\
 	call[0] = to_auipc_t0(offset);					\
 	call[1] = to_jalr_t0(offset);					\
 } while (0)
@@ -108,7 +108,7 @@ do {									\
 #define make_call_ra(caller, callee, call)				\
 do {									\
 	unsigned int offset =						\
-		(unsigned long) callee - (unsigned long) caller;	\
+		(unsigned long) (callee) - (unsigned long) (caller);	\
 	call[0] = to_auipc_ra(offset);					\
 	call[1] = to_jalr_ra(offset);					\
 } while (0)
-- 
2.39.5




