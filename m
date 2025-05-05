Return-Path: <stable+bounces-141185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F574AAB16D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30F13ADCD3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D669A2D43E7;
	Tue,  6 May 2025 00:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xyq6vDkx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5692D0298;
	Mon,  5 May 2025 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485447; cv=none; b=urCEtHFpfoOGN+r21XBrj6O/IJxLJk15u6CakT7h6Ma89rGMUHGg/GXLRhgrmeXOvTKpHJSaAmOrOQuk8iv4fesNhI8Yk0kHpNPCqNbB2S9RPpJXn90TavsDro3dz/diDf7mN/tBzo33Gmh9tIGVRBPxyzxmw7wg7flxCLOSrQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485447; c=relaxed/simple;
	bh=b1JYZDxm/fglUhm8/o9+lonBk4/xFxZf/GkAfa+sEMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AN3QlebVbNOa/S94rwvGhrapzItQqrLQ6tzrEsxvUWKzZRdR7AQyRs5Jz/vo8gxJ8DI+HzNdqjsbXSt5lqn2AwYI/YbG51YWaAbud0TYdx4a8E+3RnbN3rCD+2VqKmeFkYwVvNniP5NpmsuiOiKZFdyzhKgg0ja86kHFsDYmFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xyq6vDkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE14C4CEE4;
	Mon,  5 May 2025 22:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485447;
	bh=b1JYZDxm/fglUhm8/o9+lonBk4/xFxZf/GkAfa+sEMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xyq6vDkxgHFXGlGzo9yEBhT9wmGiEfZHBRcZ5yjAlTEDZZBteoDoYNWjc82QHYQtz
	 MzG59u4M+swDcUZ0PlvI4BvGwfwXXpAQApJz2Oxmbs/ydsm/v7gUAfRNnkx1hGQxKC
	 FyA4i6dACbSZLVYkbUDaeRvXJLTDKAHjt3O6H09PgpkEraHB3uwv0N4oybIxq48cFI
	 UiQUsGIJsf2tptlEJmdtltA7INF5uVonFSXhLUErfJBAEvBHMpJmUcaH5qWgWqb1Mv
	 88RzWM+8b6K+PzYu0txJ1lXiX4yeeWpqDOOZ2b1oBVzMjnpWkPmjP5PMe1js/Lc5XT
	 tntHZ7ZM5hntw==
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
Subject: [PATCH AUTOSEL 6.12 316/486] x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
Date: Mon,  5 May 2025 18:36:32 -0400
Message-Id: <20250505223922.2682012-316-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index c101bed619400..7f390e3374a76 100644
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


