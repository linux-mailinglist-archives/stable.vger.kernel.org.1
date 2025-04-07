Return-Path: <stable+bounces-128707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3161FA7EAC9
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE69188DAA9
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B162690E0;
	Mon,  7 Apr 2025 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZbTSxkQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9F32690D2;
	Mon,  7 Apr 2025 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049711; cv=none; b=YTgqN33JMIxJmZZroNaFYeeLO7u5uT2ydJVQ/vab/f80zTsHZJ6swShmfXfmKMgCqofawzYkm396NqvD+n59gxqBrzrbWXggQZWN1+jWZYAFmaQzRbr8aQaq3cVEDEGF8DOIKTBTF08MFBjO4XgvQHdCFTb0QenjV2c0T5JF7g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049711; c=relaxed/simple;
	bh=BqwADeEfMWfpSkpxZMIQF0p+lwUStPOVIOotEJAZ330=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nXHYLxyC89i84T4I4FEJxD0nXwIWzxPTMPHe4SiZwoSS+GOApXz9EnZpT9RJMZYHK85a/ePDnY1f+ObUg26nF52kR4gLREe2TtdewduVJwizXLdgY9OBePSzs/HpfRNEVuLBI4hmpN0wS+O/bt55twQaxUoEpoplMG3JASjooPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZbTSxkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B922CC4CEDD;
	Mon,  7 Apr 2025 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049710;
	bh=BqwADeEfMWfpSkpxZMIQF0p+lwUStPOVIOotEJAZ330=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZbTSxkQ1RXrMZJOsttA4w3ql4MOT02dQwDN3XcCgZ4Pm4RENxoRce10oPLJ0HxW6
	 S1t+qRjYCGaZlQOGa7ynC11uy1r5Lff2zr9E+m6JpLGKx9ufPnF7Gp+iECr2YNgBLR
	 g4xcag58E4l70MFQbxzD9roM8FqlJpbsgaCsF0YmMvBeiG02z0akJkz45yl/J/yUE0
	 D2DV7TqHne7oPtWMLI4b1Ll1UZRA8+4jMAbhJCKuGvda8j3h1XPdaz8NtKhVzIe4TV
	 9MGVwyi0iSguFepx3ftvUOSWWmlxmlbRPxREBUyZlYRI0B5xvxEOgAJDeKlka++4d/
	 qtgEJSD4k2uZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org
Subject: [PATCH AUTOSEL 6.1 11/13] objtool: Silence more KCOV warnings
Date: Mon,  7 Apr 2025 14:14:45 -0400
Message-Id: <20250407181449.3183687-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181449.3183687-1-sashal@kernel.org>
References: <20250407181449.3183687-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.133
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
index 6ea78612635ba..b6c91bb5ce3e3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3368,6 +3368,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (!strncmp(func->name, "__cfi_", 6))
 				return 0;
 
+			if (file->ignore_unreachables)
+				return 0;
+
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn->func->name);
 			return 1;
@@ -3582,6 +3585,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
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


