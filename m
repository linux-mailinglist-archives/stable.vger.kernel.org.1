Return-Path: <stable+bounces-140147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC64AAA5A0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8363B1887062
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED4E313072;
	Mon,  5 May 2025 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMkCuxrX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D2A313056;
	Mon,  5 May 2025 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484232; cv=none; b=hFRDfvWdOifmFxvAf73Smp34y1u5hS6sxYzh/hqEtZXP2I6PGVl0OmBUR+tn8tMkUWF9hHcTaHLbT43mzLpbPktTRMOVAZ+f7y/Z6BoBz7Uua7TD9M+JL/xa6HLeO+ItlWoKpckXbyNIsY2Qi9M3QPPWM1f/G5FXaOUyytC89uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484232; c=relaxed/simple;
	bh=48PQfxHBs3eSka9Ze3qDcmDNf3YT2CBKYaX7XsictR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXjLjbS6xkzcG7VqZR/i79/uioO0Gi6VrEP4eJqw+hs2i6mMua2CsfCSJURYhmFt9Ea+Hi6Rt/9VmNr9Tx+U0ZGYjJ8SXtc6XIcCJUd3Z4ohLDjfdvHxmnpd3YUZ8JMJ6rbWgtsTmR5+5vaauwkntUB0BAl9Auj9t9dN58dchwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMkCuxrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CADC4CEE4;
	Mon,  5 May 2025 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484231;
	bh=48PQfxHBs3eSka9Ze3qDcmDNf3YT2CBKYaX7XsictR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jMkCuxrXZvhJCFfAIRPvJi3/lAiWHauJ/6FfOHkgSJt38BxeLc4Bse/0xLpAiRqns
	 FfffakQz0uy3p1mdeDHtldloCV6P5uK3OBRxhE7d+L3IZt2StEDzffX37brd1LZ4BB
	 A8S7QkAQ68+2OY/l6OYeMSoXLVRA4GSdGTa4ovnu6AmvW5a9KautaqOZBQTORPbsiT
	 /7Uo8DDvMtfamtnyzbkM3UeWPpr4S3cu3ufTPJysawTDnlyhUn8YQt0oqKOgwLzomI
	 JkBhF5H2JK2gBURhnG7MT7yqUqX05+Ep7U7asKBErWmWwnW96Mu6f1HH2kTmg1aTlK
	 rI/4CUsYkpXHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brian Gerst <brgerst@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	nathan@kernel.org,
	ubizjak@gmail.com,
	thomas.weissschuh@linutronix.de,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 400/642] x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
Date: Mon,  5 May 2025 18:10:16 -0400
Message-Id: <20250505221419.2672473-400-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Brian Gerst <brgerst@gmail.com>

[ Upstream commit cb7927fda002ca49ae62e2782c1692acc7b80c67 ]

Clang may produce R_X86_64_REX_GOTPCRELX relocations when redefining the
stack protector location.  Treat them as another type of PC-relative
relocation.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-6-brgerst@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/tools/relocs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e937be979ec86..92a1e503305ef 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -32,6 +32,11 @@ static struct relocs		relocs32;
 static struct relocs		relocs32neg;
 static struct relocs		relocs64;
 # define FMT PRIu64
+
+#ifndef R_X86_64_REX_GOTPCRELX
+# define R_X86_64_REX_GOTPCRELX 42
+#endif
+
 #else
 # define FMT PRIu32
 #endif
@@ -227,6 +232,7 @@ static const char *rel_type(unsigned type)
 		REL_TYPE(R_X86_64_PC16),
 		REL_TYPE(R_X86_64_8),
 		REL_TYPE(R_X86_64_PC8),
+		REL_TYPE(R_X86_64_REX_GOTPCRELX),
 #else
 		REL_TYPE(R_386_NONE),
 		REL_TYPE(R_386_32),
@@ -861,6 +867,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 
 	case R_X86_64_PC32:
 	case R_X86_64_PLT32:
+	case R_X86_64_REX_GOTPCRELX:
 		/*
 		 * PC relative relocations don't need to be adjusted unless
 		 * referencing a percpu symbol.
-- 
2.39.5


