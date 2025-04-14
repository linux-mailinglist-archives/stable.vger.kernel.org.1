Return-Path: <stable+bounces-132603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E600BA883DC
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3A6189F5EC
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187AD2E62B1;
	Mon, 14 Apr 2025 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rgz6hyGV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89D82DA905;
	Mon, 14 Apr 2025 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637503; cv=none; b=It119+8AsFKAHiWb07gvt/E75kyyQkR7ZYV6+OnjV0mMCVTqn+lxJFir2GWaoAob4kiOK/yenR0fA62tpqYVIt+To2bV/mspp0wDQTvPrDvOsOmGUiyO8CeLlfSrwDffrtpY2bQObmYClkoTwdQyeWFhC4pLfmAVG7oN2+NsbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637503; c=relaxed/simple;
	bh=RaqmZjmAtE6tB70TVJVrhF72uMpOXSCo8rETW5vc56A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q2E0mVtsEU4Fj9B6FntbH6HSH1AeaSMiBJFqvyF1GrHl/kX32tCfTZ+hr2q3NNECbM1plb03r+i0pU8rQg6WL4AgeFEV2MOtEiuYrLmAfqZJ2AlvAdM6LExIjup4Vhv8uHyM51zsKSATF+YzFxX3jbq5qI0DKcGSD+gPn+ALCk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rgz6hyGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D58C4CEEB;
	Mon, 14 Apr 2025 13:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637502;
	bh=RaqmZjmAtE6tB70TVJVrhF72uMpOXSCo8rETW5vc56A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rgz6hyGVR+R0xOBf8ruRlqC7+GorqgYTJ9KpHacU1qrvTtnQxr2+yVbXjUkvpE6Dq
	 Kk00VDuUwmYCs1yFEc47BDqZOX9GLAK5g2zNTCTOUn4ftL8koKnYYZw1kMUN862lQe
	 nhBC2J+1PVw3hdUwWiAZyNQuX9gVRHzgn2nhQBDH8/4vRboH62neWGHDJZ7qfVI7g8
	 xHqL+J+2qy/RsetsTxx8kkFdYFbvYF3dtxFBg54Lr5O8+bhr1HQfs7T8B8qSv/mZyD
	 B6AztzMW+U6TsnYqKb6oPqhoAoh+VGrtfvbf/jvUVXn1C0STrjTfAMUSYDs9IujXgY
	 4BxKlmtM8dgOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org
Subject: [PATCH AUTOSEL 5.15 08/15] objtool: Stop UNRET validation on UD2
Date: Mon, 14 Apr 2025 09:31:18 -0400
Message-Id: <20250414133126.680846-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133126.680846-1-sashal@kernel.org>
References: <20250414133126.680846-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
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
index c2596b1e1fb1e..d2366ec61edc4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3416,6 +3416,9 @@ static int validate_entry(struct objtool_file *file, struct instruction *insn)
 			break;
 		}
 
+		if (insn->dead_end)
+			return 0;
+
 		if (!next) {
 			WARN_FUNC("teh end!", insn->sec, insn->offset);
 			return -1;
-- 
2.39.5


