Return-Path: <stable+bounces-128691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDA8A7EAC4
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223A1442495
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E312673B7;
	Mon,  7 Apr 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzK1n5dm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F82673AD;
	Mon,  7 Apr 2025 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049678; cv=none; b=obBo+ZeMPEpzsAxHJ9W5bN5cX/SEi67cnZs6ZYvXetAm8xi1mUbmyUA29Us4kHFK1CaHAblW2EknUjq6APoLKrPGMYR/+kTOrdLq2kgmHgY3+TCb+ys4+fmnHfjfMu+ySmTsWs9eQBGLmNOdmlmT3+fqfTSNCcjjonfKdLT37E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049678; c=relaxed/simple;
	bh=q5csLpQ+mh9o7lfCI1dsQaiQJ46R0m+uYFH+7vEOer4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UEBN2M47tV8BpsW21YHrAG9fAUFQrGX4winOKImtJ9H2UVjeFqc0EqHg8azQQbcv2HZnTylzkrNBmCuIiq78itnt6Mf33938W194maHmoHFiffJCiTz7GHrJ88849Doy+SwKnisfd5GBEOtwyJ8QdB5MEN4LZX9YYXTPoINKKio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzK1n5dm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6E2C4CEEF;
	Mon,  7 Apr 2025 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049678;
	bh=q5csLpQ+mh9o7lfCI1dsQaiQJ46R0m+uYFH+7vEOer4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QzK1n5dmDiII7ci/SSgurdqsX1hC3DB8CFP69YwyxLJ9KAvsbsgNGuPQH1wQOYYDv
	 jtP6eBGV0nK4L4nTmMI6Fk4kCMWzAbsWuzDBzASMG8R94SCn6aRGfDC7wpXSrcXL4P
	 QR234cWVh5O5kMODDA2ojmDqJ8UwqcDbaeu0L/I7iLDS+Nd9jOi9xWyeeQEh2T5zBj
	 YAfJg8TwQipamSnfKbS/KpcpfXpSnnIRj7nlBXI8uiONstkJ7eqz+B85L0bHhoUdCL
	 HLciLwp6mI4ZzLBoGj4MNEOjmbOUfgUM3tiUlJWFqvShkRqhQheWdPnpi5J52Rxvrs
	 hvHKSd2MD6I4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org
Subject: [PATCH AUTOSEL 6.6 11/15] objtool: Silence more KCOV warnings
Date: Mon,  7 Apr 2025 14:14:11 -0400
Message-Id: <20250407181417.3183475-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181417.3183475-1-sashal@kernel.org>
References: <20250407181417.3183475-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.86
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 6b023c7842048c4bbeede802f3cf36b96c7a8b25 ]

In the past there were issues with KCOV triggering unreachable
instruction warnings, which is why unreachable warnings are now disabled
with CONFIG_KCOV.

Now some new KCOV warnings are showing up with GCC 14:

  vmlinux.o: warning: objtool: cpuset_write_resmask() falls through to next function cpuset_update_active_cpus.cold()
  drivers/usb/core/driver.o: error: objtool: usb_deregister() falls through to next function usb_match_device()
  sound/soc/codecs/snd-soc-wcd934x.o: warning: objtool: .text.wcd934x_slim_irq_handler: unexpected end of section

All are caused by GCC KCOV not finishing an optimization, leaving behind
a never-taken conditional branch to a basic block which falls through to
the next function (or end of section).

At a high level this is similar to the unreachable warnings mentioned
above, in that KCOV isn't fully removing dead code.  Treat it the same
way by adding these to the list of warnings to ignore with CONFIG_KCOV.

Reported-by: Ingo Molnar <mingo@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/66a61a0b65d74e072d3dc02384e395edb2adc3c5.1742852846.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/Z9iTsI09AEBlxlHC@gmail.com
Closes: https://lore.kernel.org/oe-kbuild-all/202503180044.oH9gyPeg-lkp@intel.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6e59e7f578ffe..665dccdd6b0af 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3569,6 +3569,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			    !strncmp(func->name, "__pfx_", 6))
 				return 0;
 
+			if (file->ignore_unreachables)
+				return 0;
+
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn_func(insn)->name);
 			return 1;
@@ -3788,6 +3791,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		if (!next_insn) {
 			if (state.cfi.cfa.base == CFI_UNDEFINED)
 				return 0;
+			if (file->ignore_unreachables)
+				return 0;
+
 			WARN("%s: unexpected end of section", sec->name);
 			return 1;
 		}
-- 
2.39.5


