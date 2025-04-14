Return-Path: <stable+bounces-132586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2121A883C8
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D14558008A
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7046C2D7413;
	Mon, 14 Apr 2025 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4PF4jmg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278502D740C;
	Mon, 14 Apr 2025 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637467; cv=none; b=Bki0jVRzlqFeoivydUCnfFrQuomTesNOFKxe1eH90PIUPAAv5jERWr7at5PKaQKH2EC5366YHvE6g8FpMlvOLok324YZU5gpM8V+2OFkTqEw6YEs5qhb2C4vd33IMkPRc7cZjjcZoEnK5QcfkOSTy7ZQFswXjM910Re0P9ot/qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637467; c=relaxed/simple;
	bh=+gVa1DyG67ymqVLcWNT8dtiRunORaW+k43ZsDvCFVRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RqTAYeaLsrhkeFfwmfOg40aQvLpYZ304rw4BJLCtHu0R6F/5JprKP6W2/LrI6pXM0lqt+7uWlFGijeNR+9WCfXKQ7N6SbAsEBFxWkXVStnbVe6TW8Y13bV1WRz1vYpdegOK4Sgc2/3GJX6+JmTM0xMf3l+TQ8l5AJmwzTCPCY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4PF4jmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7B4C4CEEB;
	Mon, 14 Apr 2025 13:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637467;
	bh=+gVa1DyG67ymqVLcWNT8dtiRunORaW+k43ZsDvCFVRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4PF4jmgAKAn0jmiLmyYzfsNg1wOJDEuW6QTHhfGbA42jc2T661X0AICFXvsFBSnb
	 AM4BVx4/tx3Ob9SlGW14RvZtdelkEL/YhDHqzkJx06FDYeXokpBHXFsYTZ7wN0J3GF
	 m1p9hN/m0H4cB25x1yLouGLQp6Hb0VNz6+MRko+K1bOK1qu+kWspStuDkmfbH50mlD
	 Zl+SBChDsRLjBSHDFGmCN7WI7A1a8N0tCSBHuh/Lc/liQykCeFQX/c7n1yrJkE2Fon
	 8AqffetzUWrG05wtit7C+1/p6qreAv9DXr3KrCEQ3OLGYvaekejcUvB/my0oPnidok
	 Eoj8Lx5623ZIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org
Subject: [PATCH AUTOSEL 6.1 09/17] objtool: Stop UNRET validation on UD2
Date: Mon, 14 Apr 2025 09:30:40 -0400
Message-Id: <20250414133048.680608-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133048.680608-1-sashal@kernel.org>
References: <20250414133048.680608-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
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
index 6ea78612635ba..9696e03de07de 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3731,6 +3731,9 @@ static int validate_entry(struct objtool_file *file, struct instruction *insn)
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


