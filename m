Return-Path: <stable+bounces-116866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F32A3A94B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06EDA1898651
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DD61FDA8D;
	Tue, 18 Feb 2025 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODvpTS/m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF01C5F19;
	Tue, 18 Feb 2025 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910410; cv=none; b=dDk/beWn8myDmpBkPx7YSBtSayY02MdIkzfuVNn2n/UZUQJdrzxK1VMRd5CuHKsFKMmGL1kHrw/C3z8z2br7dmYsyhhht7EEi7Hl8TISF3SbUlSlWZPiB7fIHY/7euBIG4TIDg0n2kGX8z2PqXyEQE/mm4mD1cd8czZuUiRVFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910410; c=relaxed/simple;
	bh=jSn76/n+4pkqgYx9QYEAICrWdnBjcMfetllFDv2D+8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gI9dDxIGr0v9VvxnM6WZ5kjUIAfCrP4t/beMWWmGG7u1xqNbaQLG8+z2aCkadtSeUEyb/nac6qL10viwHdqZQazK9au/LLZcalx6v6tHM2yqkCHf4SgH2mT6ZVdSC+BSpW/Q1J7/tImI3Q2pKqTusEPf+LirQpteMNmAl2bUu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODvpTS/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E29C4CEED;
	Tue, 18 Feb 2025 20:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910410;
	bh=jSn76/n+4pkqgYx9QYEAICrWdnBjcMfetllFDv2D+8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODvpTS/mo2hXACfpNxj4E9c9rZ9SoJ3QVhk8h0R9hBm09gnjBR3czl5Kd/V52iEyQ
	 34yuO0ZBad1oDj36czzDSjoFTqPP1tYHGvbL5luUkDO6wzt6pFbcGL1P1lGkKj1If/
	 /2L4pxVQGJ6oHle/kNPUbt6cEpagenVNEbMmIPZoJYTPF7c/K5yPXkqUDvvlSCQAi+
	 uuzJ0/XUlqK3MnNDS/Hh6jYx8Kro1KJ57aAz61J5W1FjzFF6yjjmsINckFIiS+Bggf
	 63f57g2h0+mRxlvDqjNRbAd0RZvmsg3Udw7n5lZ6SukkGH18qTHgdd+eRQhEhaDnJq
	 0oTihCjns9C6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Klaus Kusche <klaus.kusche@computerix.info>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 13/31] objtool: Ignore dangling jump table entries
Date: Tue, 18 Feb 2025 15:25:59 -0500
Message-Id: <20250218202619.3592630-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202619.3592630-1-sashal@kernel.org>
References: <20250218202619.3592630-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.15
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 3724062ca2b1364f02cf44dbea1a552227844ad1 ]

Clang sometimes leaves dangling unused jump table entries which point to
the end of the function.  Ignore them.

Closes: https://lore.kernel.org/20250113235835.vqgvb7cdspksy5dn@jpoimboe
Reported-by: Klaus Kusche <klaus.kusche@computerix.info>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/ee25c0b7e80113e950bd1d4c208b671d35774ff4.1736891751.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f0d8796b984a8..34b1c16d359c9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2099,6 +2099,14 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		    reloc_addend(reloc) == pfunc->offset)
 			break;
 
+		/*
+		 * Clang sometimes leaves dangling unused jump table entries
+		 * which point to the end of the function.  Ignore them.
+		 */
+		if (reloc->sym->sec == pfunc->sec &&
+		    reloc_addend(reloc) == pfunc->offset + pfunc->len)
+			goto next;
+
 		dest_insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
 		if (!dest_insn)
 			break;
@@ -2116,6 +2124,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		alt->insn = dest_insn;
 		alt->next = insn->alts;
 		insn->alts = alt;
+next:
 		prev_offset = reloc_offset(reloc);
 	}
 
-- 
2.39.5


