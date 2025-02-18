Return-Path: <stable+bounces-116892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD37CA3A99B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECEE188DD5A
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C672165E8;
	Tue, 18 Feb 2025 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+epzF/D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41402163A4;
	Tue, 18 Feb 2025 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910482; cv=none; b=fsaC/gzmwxcz0Vty1l1EB5pcgRNaEn/xFZdBE4xICDPueFAm0KEJv8UcxT34dRYISL7SO1HlA5AAggaDdIFph8KHoBzSONdZZEKKixsU/Wz9mOKGE7rdHD1+QZ7oAkJkYbBipkM8Q3IdbOUzhst4UvREtY2FhaHNGStWNayN36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910482; c=relaxed/simple;
	bh=45LlskNhzKOCHXWXhZDbvjn4nQM12liiy+SLC7mMM+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IZi1dupkcgUHXmYceyXuBypBPmu/lQHGZu0/VeHciKAfRulvNNBLkHC6rAgEmIvXfpSZjH1c6CLL2rEhXAWDyiRtQvJzmpWp155qEq9bvQ64bjugQiwWuRufvF5+oVBqFU5Rqib8LEc9YFUXJqdCHQ0u1POM3Ckj+rEgJXDaEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+epzF/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05792C4CEE9;
	Tue, 18 Feb 2025 20:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910481;
	bh=45LlskNhzKOCHXWXhZDbvjn4nQM12liiy+SLC7mMM+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+epzF/DD4WPXwbR8hx9khGGUrHBXaz1Cxgb5LkNspV7FcyuQViB++gOqlG2goSRU
	 Dg6rs4Fn8Zc1t0oyCafZxkyH42dy0U9UtL2meeA22L+40NjPdHZxim0f5HIX9PrU3y
	 FsNeMAA1llhuhLQyNdCTtdWwWTk6n8B8jK57HFqoxDJasgXqcqf4AU4rqflAMiAv/s
	 cJybotDM9ofVDqQh6cZXOcaq4H1uTlKykm1oQAKsh2eFo6IQpEI7/wSXgpFjcEoS9S
	 D/EAY+LP8onGcY27Vg9PEL4lQbYZiFY0CjW0Tex6QbYJqQo0k+5tnX/G2Xje4Yh4XN
	 lN/ETfCvcEyxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Klaus Kusche <klaus.kusche@computerix.info>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 08/17] objtool: Ignore dangling jump table entries
Date: Tue, 18 Feb 2025 15:27:32 -0500
Message-Id: <20250218202743.3593296-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202743.3593296-1-sashal@kernel.org>
References: <20250218202743.3593296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.78
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
index 1b242c3c2d451..6e59e7f578ffe 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2028,6 +2028,14 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
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
@@ -2045,6 +2053,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		alt->insn = dest_insn;
 		alt->next = insn->alts;
 		insn->alts = alt;
+next:
 		prev_offset = reloc_offset(reloc);
 	}
 
-- 
2.39.5


