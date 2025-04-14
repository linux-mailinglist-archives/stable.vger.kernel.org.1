Return-Path: <stable+bounces-132507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15CCA882AC
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47340188BA52
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A882749EE;
	Mon, 14 Apr 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLp3Q+Ke"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70F828F53A;
	Mon, 14 Apr 2025 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637294; cv=none; b=aWKJwUa7cCCuYHrEOufFghFRhNkA+7vZ2Jn3gh2BcaFSiqcKwXZ5VXfGn2hjMuH5IjvJplBAliQRTahrypXn8wsBW69mMIJb+eI+sc6Z7HnMlQ6Se8JPM++nWoRuCwMoEaUbpVAjN/OI20iSkqLtF6kcgCIXdBYsfh/4n5KsXFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637294; c=relaxed/simple;
	bh=iZKI4STJ91gk+W6uFWjY6eRNbbyBq9uHUSC1gSQRcv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lil27J2Bhf0++iGZ2MRrrZJXuBmqpoQK5g+F+dQR0hNlaDNg2FLrH4RLrM7yzGCKJwAlhSH1z4IJtNtOKYSelzttrbllrZZKKUCXDtVJdLqqKPYbQjI9/8TyXqyWix8R0ED5JvOCAkHofR3hNLzLeb5yTMzBRe/zNgTXoP8KLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLp3Q+Ke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951C9C4CEEC;
	Mon, 14 Apr 2025 13:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637294;
	bh=iZKI4STJ91gk+W6uFWjY6eRNbbyBq9uHUSC1gSQRcv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLp3Q+Keehc+liqm9hUndmVi4T4UcCIBEcDd0pF/VU/rZdMGm8c289W5FdGQVDQdH
	 uqIEeAYyKfvXs2rgAYbLvEOJT2OGvgO+s8Y4v6pgE1n4r6g79xsjHdnbiUea41oC4w
	 aO5bIaFJx2SOOg8vtWce2Zb/xCLJmcG4WE66bqOMkak4HzJ8yGYvpFebUSKT/beywr
	 aEH/xmlYFqOUT7SpwOo74h6QlyuNkR3/Yf+gkqtLlKffVwiGjKOKRGZLJH9Wwmb2oJ
	 Oy1QwctWzCWU84VUrH0Wk4+sjoi0aF39RcqOuyfrtCVEXYlwJAhmAXfZ2h+vev0a/s
	 kWdVBXYviipaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org
Subject: [PATCH AUTOSEL 6.13 19/34] objtool: Stop UNRET validation on UD2
Date: Mon, 14 Apr 2025 09:27:13 -0400
Message-Id: <20250414132729.679254-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
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
index 9c7e60f71327d..d95abd5396c3f 100644
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


