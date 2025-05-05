Return-Path: <stable+bounces-141481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9639AAB3DF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5073A2ED7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E481036F892;
	Tue,  6 May 2025 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6SW6gmx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2212EC010;
	Mon,  5 May 2025 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486432; cv=none; b=GeryAtM6xuPtDeU7zhSRSaUCKKcwFY/X0QkMXVsdm024vT++fWo6G3Fj7XfV1Bt5ZEjQDGS2aOg2ybGCR8reRxMILEi+sYpgBcXg2qx/0ZoXS7hhU84TKO/wrGgGdEgVLvtAvDlaCbkbEwpWw35B2LmeqRdMMn2SYKpGpo8U0bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486432; c=relaxed/simple;
	bh=kzSyyvd3/yElOODaEHwKXg+4Hm01WJRVqSMsusW2GH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZxQKuHjdyJVS+2Y0yUQe7DteTV9oWp/1WEXk9D2Nvt35+gp/b1ahSwbsoIXBQdI1PE9JEgZTYiXB0e0riMrVTO+kd+8EBx0OFLK2+0tNnEv+URq2nc9h6pmjsIvi27e84O3ulO/FSVvzyAn2ZDBIBlcKg3fbTyy28rem1YYR9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6SW6gmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C005EC4CEED;
	Mon,  5 May 2025 23:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486432;
	bh=kzSyyvd3/yElOODaEHwKXg+4Hm01WJRVqSMsusW2GH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I6SW6gmxCvBxybgRylM71JQa40hM3Zyp5XJNbx1FgktrcAfArYwOZtjtlNkTVkSkh
	 m+nmpom8/QJ2wDUD8AqtUMyV6iXf9H9pSTGZV7eQSaDjEviGf2wn7ahk8pMpxx5MFf
	 6cadFuk2TgNIE4klDLEo+k6C1OaF5oomnpoX5b6YUyQ7hrL8OPkHm297WSA3qrFnL7
	 Dw55XJ2gbbRjF5axDM3b/7IDgT0Kmh0i3wL0v0I0wof918kghdjUMeZAfN9Jvcr5Pc
	 rceSDEPl91hnV6ksuqGm3FU3IOwvuN+yVkJXhB4mAR6MaJimG0Hitpi4FPqKwnWAjo
	 T/FuEH4+Cf/Lg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org
Subject: [PATCH AUTOSEL 6.1 024/212] objtool: Properly disable uaccess validation
Date: Mon,  5 May 2025 19:03:16 -0400
Message-Id: <20250505230624.2692522-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit e1a9dda74dbffbc3fa2069ff418a1876dc99fb14 ]

If opts.uaccess isn't set, the uaccess validation is disabled, but only
partially: it doesn't read the uaccess_safe_builtin list but still tries
to do the validation.  Disable it completely to prevent false warnings.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/0e95581c1d2107fb5f59418edf2b26bba38b0cbb.1742852846.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 828c91aaf55bd..bf75628c5389a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3083,7 +3083,7 @@ static int handle_insn_ops(struct instruction *insn,
 		if (update_cfi_state(insn, next_insn, &state->cfi, op))
 			return 1;
 
-		if (!insn->alt_group)
+		if (!opts.uaccess || !insn->alt_group)
 			continue;
 
 		if (op->dest.type == OP_DEST_PUSHF) {
@@ -3535,6 +3535,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			return 0;
 
 		case INSN_STAC:
+			if (!opts.uaccess)
+				break;
+
 			if (state.uaccess) {
 				WARN_FUNC("recursive UACCESS enable", sec, insn->offset);
 				return 1;
@@ -3544,6 +3547,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_CLAC:
+			if (!opts.uaccess)
+				break;
+
 			if (!state.uaccess && func) {
 				WARN_FUNC("redundant UACCESS disable", sec, insn->offset);
 				return 1;
@@ -3956,7 +3962,8 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 	if (!insn || insn->ignore || insn->visited)
 		return 0;
 
-	state->uaccess = sym->uaccess_safe;
+	if (opts.uaccess)
+		state->uaccess = sym->uaccess_safe;
 
 	ret = validate_branch(file, insn->func, insn, *state);
 	if (ret && opts.backtrace)
-- 
2.39.5


