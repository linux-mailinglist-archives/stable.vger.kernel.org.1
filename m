Return-Path: <stable+bounces-46543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6EE8D0789
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0DC1F220E9
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7163016E866;
	Mon, 27 May 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5lNzkyp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7116726B;
	Mon, 27 May 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825471; cv=none; b=Cv4jcOXgBeZyKT5D82Nid+cdeDEfwo484kdycKf7VUHzEujfyXKVpEkAJJE63EpbRARXb3BTWUcMqEWf5cUhTth7KZfnpS2/u+brreZrN6myPzf4BjgCLcr4bRIHP2EAzP/0Pxd7GUawWeuCzsuCtCC4BETk3FCJXYqJI9x/VRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825471; c=relaxed/simple;
	bh=jliCrrRlvQBl/x/36ti7pFXBGun1yJO+TJTp8mWdxmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSPe6Fzl/qP3qxrjHiJUUp3jHRfRM5cbqTOKHbz8eq1x7mvtsxSVTi466KMWfxwIBTkuHwF/bpZJ8IaHUUJWMusvBCnwt9Q+K4eht2IIfV/GxguHM4RMon8MM+gIFB5ciB6bDFB56zkTagJ+RKy/XVO1lofySA7ro6mmQ0fY0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5lNzkyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB84C2BBFC;
	Mon, 27 May 2024 15:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716825470;
	bh=jliCrrRlvQBl/x/36ti7pFXBGun1yJO+TJTp8mWdxmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a5lNzkypUQh3XLSgOjFmtL/I54QX9vmBQr1RgDeoi0x5k4JBqbtD+l+ww5zAX6eH0
	 +bTRt5Z1eBEOC324bTzLAQHa6JYRgL3/fd5yltWnqWObDdkTAfwLTlu+7DFD3VomF4
	 rTaRGvGWtsi2JAVCWKWX129o5H42caLJfXfKxlbnpPe6uvpgpMj1tU5ncSt/iRkyms
	 TZ0+uxzop0Ntk0nuem+WQlekep7beD2XDt+EDbQSJwYfFC0NXJ64WaJajL5GA5Q6/g
	 HHvwt+5doel9BHwQFuoJnlFvsO3RT9WmoIuLdIqOKoEXWaXPz+9kv5ykuIWNZFU+MH
	 NXuNq2eg8bQvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	vaibhav@linux.ibm.com,
	gautam@linux.ibm.com,
	jniethe5@gmail.com,
	sshegde@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 09/11] powerpc/pseries: Enforce hcall result buffer validity and size
Date: Mon, 27 May 2024 11:56:46 -0400
Message-ID: <20240527155710.3865826-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527155710.3865826-1-sashal@kernel.org>
References: <20240527155710.3865826-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
Content-Transfer-Encoding: 8bit

From: Nathan Lynch <nathanl@linux.ibm.com>

[ Upstream commit ff2e185cf73df480ec69675936c4ee75a445c3e4 ]

plpar_hcall(), plpar_hcall9(), and related functions expect callers to
provide valid result buffers of certain minimum size. Currently this
is communicated only through comments in the code and the compiler has
no idea.

For example, if I write a bug like this:

  long retbuf[PLPAR_HCALL_BUFSIZE]; // should be PLPAR_HCALL9_BUFSIZE
  plpar_hcall9(H_ALLOCATE_VAS_WINDOW, retbuf, ...);

This compiles with no diagnostics emitted, but likely results in stack
corruption at runtime when plpar_hcall9() stores results past the end
of the array. (To be clear this is a contrived example and I have not
found a real instance yet.)

To make this class of error less likely, we can use explicitly-sized
array parameters instead of pointers in the declarations for the hcall
APIs. When compiled with -Warray-bounds[1], the code above now
provokes a diagnostic like this:

error: array argument is too small;
is of size 32, callee requires at least 72 [-Werror,-Warray-bounds]
   60 |                 plpar_hcall9(H_ALLOCATE_VAS_WINDOW, retbuf,
      |                 ^                                   ~~~~~~

[1] Enabled for LLVM builds but not GCC for now. See commit
    0da6e5fd6c37 ("gcc: disable '-Warray-bounds' for gcc-13 too") and
    related changes.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240408-pseries-hvcall-retbuf-v1-1-ebc73d7253cf@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/hvcall.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 95fd7f9485d55..a0fef2493c1f1 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -493,7 +493,7 @@ long plpar_hcall_norets_notrace(unsigned long opcode, ...);
  * Used for all but the craziest of phyp interfaces (see plpar_hcall9)
  */
 #define PLPAR_HCALL_BUFSIZE 4
-long plpar_hcall(unsigned long opcode, unsigned long *retbuf, ...);
+long plpar_hcall(unsigned long opcode, unsigned long retbuf[static PLPAR_HCALL_BUFSIZE], ...);
 
 /**
  * plpar_hcall_raw: - Make a hypervisor call without calculating hcall stats
@@ -507,7 +507,7 @@ long plpar_hcall(unsigned long opcode, unsigned long *retbuf, ...);
  * plpar_hcall, but plpar_hcall_raw works in real mode and does not
  * calculate hypervisor call statistics.
  */
-long plpar_hcall_raw(unsigned long opcode, unsigned long *retbuf, ...);
+long plpar_hcall_raw(unsigned long opcode, unsigned long retbuf[static PLPAR_HCALL_BUFSIZE], ...);
 
 /**
  * plpar_hcall9: - Make a pseries hypervisor call with up to 9 return arguments
@@ -518,8 +518,8 @@ long plpar_hcall_raw(unsigned long opcode, unsigned long *retbuf, ...);
  * PLPAR_HCALL9_BUFSIZE to size the return argument buffer.
  */
 #define PLPAR_HCALL9_BUFSIZE 9
-long plpar_hcall9(unsigned long opcode, unsigned long *retbuf, ...);
-long plpar_hcall9_raw(unsigned long opcode, unsigned long *retbuf, ...);
+long plpar_hcall9(unsigned long opcode, unsigned long retbuf[static PLPAR_HCALL9_BUFSIZE], ...);
+long plpar_hcall9_raw(unsigned long opcode, unsigned long retbuf[static PLPAR_HCALL9_BUFSIZE], ...);
 
 /* pseries hcall tracing */
 extern struct static_key hcall_tracepoint_key;
-- 
2.43.0


