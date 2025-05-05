Return-Path: <stable+bounces-141186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A464FAAB657
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C494C1389
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13E83AF3E8;
	Tue,  6 May 2025 00:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3M9Entj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DFE2D0ABA;
	Mon,  5 May 2025 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485452; cv=none; b=q5OmFNEU4VCh6oVNqMnIKI6cjIbKGt+FcwbnPvCnVg7gIQ7Ns7bwTRYZwuL9fh26o6lLBNmxd0DYOe5aeXrV/+8yfZFnsUKPefdq2QHAK0Hu2VBVdVnDL3vK+wwbWdHbjDXXrPoRcI3/8MNYxIk4D3k7LN7JdVXRD/xKpaUbjSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485452; c=relaxed/simple;
	bh=eaS4YL6RxZzJC5GA5Hns3aNrJuNlUyAYTy8WG9WSKeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G151MU7gO5BKo5IF93fcRhBiaIfZUgdjudGupwGQCEBw44VCm62StMUI0St5d/KrcOTKlmI2NEG6LFnpiI/RCH63tCoGVcFMZMXLiiaEU5VzM55lcxNR1hhGt4gKVbASgwBYMF9yC5Dok33txIoNliVCl1ltazoqPCgD69fYVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3M9Entj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53C7C4CEEE;
	Mon,  5 May 2025 22:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485450;
	bh=eaS4YL6RxZzJC5GA5Hns3aNrJuNlUyAYTy8WG9WSKeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E3M9EntjsZx5KrVgyfIoFsrgh22fuIrfMELpaO+tIAeEbfKNsaRLZTZ5XBTHIgmP4
	 w6/C7NYDJ92Q1kNNjSyscn2pNWHuVjOfO2BkKhTqNyiUdXI4376HPJQxDQpVobI3P2
	 AeBGySXNot6HVqAG/k//LA1DrxELWMA8iq298v1EpvfFIxfQfg/FLPPMpFm0phb7t4
	 dsZ+XV8UX9giafQZLyBz6Hqmuxqrt87iPjWaoXwRCcn6YSf/pvIogdncoOo5R9uAIG
	 1f4w3xPJsQBPwOatsTy70wp4eDHC3TPxpQ6KcQazf+gTWb84tYOzOGOj/ZgaoKehhb
	 k8PROlUP+wINw==
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
	nikunj@amd.com,
	peterz@infradead.org,
	elver@google.com,
	dvyukov@google.com,
	yazen.ghannam@amd.com,
	masahiroy@kernel.org
Subject: [PATCH AUTOSEL 6.12 317/486] x86/boot: Disable stack protector for early boot code
Date: Mon,  5 May 2025 18:36:33 -0400
Message-Id: <20250505223922.2682012-317-sashal@kernel.org>
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

[ Upstream commit a9a76b38aaf577887103e3ebb41d70e6aa5a4b19 ]

On 64-bit, this will prevent crashes when the canary access is changed
from %gs:40 to %gs:__stack_chk_guard(%rip).  RIP-relative addresses from
the identity-mapped early boot code will target the wrong address with
zero-based percpu.  KASLR could then shift that address to an unmapped
page causing a crash on boot.

This early boot code runs well before user-space is active and does not
need stack protector enabled.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-4-brgerst@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f7918980667a3..f42c0903ef86d 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -44,6 +44,8 @@ KCOV_INSTRUMENT_unwind_orc.o				:= n
 KCOV_INSTRUMENT_unwind_frame.o				:= n
 KCOV_INSTRUMENT_unwind_guess.o				:= n
 
+CFLAGS_head32.o := -fno-stack-protector
+CFLAGS_head64.o := -fno-stack-protector
 CFLAGS_irq.o := -I $(src)/../include/asm/trace
 
 obj-y			+= head_$(BITS).o
-- 
2.39.5


