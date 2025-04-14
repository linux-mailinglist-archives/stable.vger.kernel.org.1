Return-Path: <stable+bounces-132538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE75A88334
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8F93BD2C4
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7116299CD7;
	Mon, 14 Apr 2025 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl8nrjLs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F06299CCE;
	Mon, 14 Apr 2025 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637365; cv=none; b=ZBoDOTCi6b9j0G6O/MrcEgdg44J81xPOhzI0h5xusZQZhL0ZWr5VDxWCOISZXu8aiQRPKgdkuvqhrI31rbYPGJViOag6a6Bs1r7J3oxaymOBKpZ3qaltZrIKR1gdp/NmftHfW7PVuoYkbdP3L4NmUEYQF+Ra8OWuZSNwUuCOl7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637365; c=relaxed/simple;
	bh=j80dpXbl6gke/kSrgGzp4xp3WVxgFP+OsEcQg/gXyt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QRtD1GgUrtiyHo0XpTmhKAFXfg27/ia7PZJ3VN5awUGjJEhIYpInqzIP0Z2g4AnfQRBLFXavHCS8sF0rBzj1gG6Jk9J96C6wFIH3fsdm9W/JSY8944fdVjKlc8ucPEoJ+cAcQ6Ds/6Fb3M7oCPf9iW0Mrru01Q76jqtn3TKPNuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl8nrjLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A62C4CEEB;
	Mon, 14 Apr 2025 13:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637365;
	bh=j80dpXbl6gke/kSrgGzp4xp3WVxgFP+OsEcQg/gXyt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cl8nrjLsRkErHdW2eLE9T9GJ8tlrTz7EfiMp34BIaBHFuIhXub6z5Di27Sa6fISAu
	 AkpJMkFbga9qXNGfr+PQBO6G5QKecy2hx1dlKwcFFO/hr36qj8XTdXKvtsfPTeTKRO
	 Yz769Sr4TseYExMxm+tyFP+PVewMaln5efYG1Fvp79XeGA6YDX96zHTJR5YZMe9XyN
	 qRhpuz0fMn1DoG+m4wc8SNSim3j82+3l+fzwos5dJhEFo9ViUttItOcOYYgZxj/fa9
	 WZIl7KICrll64BC0V2cvWh72+VC4MPcWfncNV0L1cR6X1+rCOnUUfiMP0tZQP66I/Q
	 5FgaoYr72S9ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org
Subject: [PATCH AUTOSEL 6.12 15/30] objtool: Stop UNRET validation on UD2
Date: Mon, 14 Apr 2025 09:28:32 -0400
Message-Id: <20250414132848.679855-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132848.679855-1-sashal@kernel.org>
References: <20250414132848.679855-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.23
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
index 286a2c0af02aa..d06cb7aedb723 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3999,6 +3999,9 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
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


