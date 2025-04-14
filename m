Return-Path: <stable+bounces-132473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C7CA8824D
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0855417A030
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AD227F74E;
	Mon, 14 Apr 2025 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUIPO1N4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB08C27F749;
	Mon, 14 Apr 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637217; cv=none; b=TyjqFhpN9UV2sYovbGsSvZcntDjGCmqwTh3SQOqhJUBR26YJsUZTxFZKP48qpyQuuJ0zZWXYBiX3TX3T6fDXV3GUr5iMu7ixjOcgVcTotTcyhxl5qch+EyAgWhn+FEF2uXnx+c9COIzvjkshRGDxgqaH2c3mEZ76sNQc2IFNOBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637217; c=relaxed/simple;
	bh=prgawYqB8DHgmFScI5FvDkvVFwLUlZn8w+F5ESxnXMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=brIaPWJzxjBubCC0p3FaoUyDxUJblCoWceGHBkvOtvDyJePDNsu9amlbuylxr8P/av6wGepHhjprwTDn1u9sy9wLWm6ERu8Z2YM3dScVul5hj8E4vpM3oVL2sa0wNksFKkA3OSpYgPKNCFEXyU3BzLjaYATC1KNVu0FScc3xzxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUIPO1N4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B7EC4CEE9;
	Mon, 14 Apr 2025 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637216;
	bh=prgawYqB8DHgmFScI5FvDkvVFwLUlZn8w+F5ESxnXMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUIPO1N4NDyklhxwTv6uxMCIldWKgcZ7VRf+CO+E7/wQzjGJ7sBMQut1cHlpxGf3X
	 +74ruZ54NdQcJBsIZnf8gAH0NVXu63md+huPQ8fs36iRt3HFq3DSz46/JAdAZE3UYu
	 5emdu+ZwLytpa2JMyClD+lK5sCTYhUULpLkIF6w3SK5GOPI8BNCi2ZFwDQUvXZg8lO
	 AdJTbEefjS6ZwIsq4vKF6l9UbW8Cbr+gmYc4m0SpGH+tXDQE0zaVVKSQh9+OaCoIne
	 kcyZk7/cJ/SGbt0CHUJaYiiOn1/B37+ZtWzCnh/e8B2xqJNaNZllO6SYw2Q98wMWiu
	 yIprVEIMqWdFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org
Subject: [PATCH AUTOSEL 6.14 19/34] objtool: Stop UNRET validation on UD2
Date: Mon, 14 Apr 2025 09:25:55 -0400
Message-Id: <20250414132610.677644-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132610.677644-1-sashal@kernel.org>
References: <20250414132610.677644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.2
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 9f9cc012c2cbac4833746a0182e06a8eec940d19 ]

In preparation for simplifying INSN_SYSCALL, make validate_unret()
terminate control flow on UD2 just like validate_branch() already does.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/ce841269e7e28c8b7f32064464a9821034d724ff.1744095216.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 159fb130e2827..9a46f77f3e351 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3855,6 +3855,9 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 			break;
 		}
 
+		if (insn->dead_end)
+			return 0;
+
 		if (!next) {
 			WARN_INSN(insn, "teh end!");
 			return -1;
-- 
2.39.5


