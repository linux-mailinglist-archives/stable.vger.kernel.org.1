Return-Path: <stable+bounces-146538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CB1AC5392
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759D23BF109
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D72F27FB3D;
	Tue, 27 May 2025 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G0SiYBfL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC1D194A45;
	Tue, 27 May 2025 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364529; cv=none; b=e5UXsXL87mRAZmjK1QWLKKJmg2580ZgxrZcg+0RK1bQV9xVwx+zXwFXNLwjRCEg7V6X1H7uLOkDzd1gOKndMkbmSmFtxXVc63uc86Wqo3/FTV/A7C3TP40+vrHuE8//uzlktFaWDFmvit3luHzpAaebdV+2d3eItzbpNT7ej47A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364529; c=relaxed/simple;
	bh=gGbrOHssW0ifZtpswZ5VVSodlz50pPXg/ao4s+ZNutE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDRmHbxwPp5z/QwTatawQIa+VGqzeLfmdSp9NzAxz+cl1V4V/2vJ8IzyFZ/6LpXn+1i+4IKqJOqc//M9AYZb/IyDSOLsrk49LhFbXA+nvJR8IXRELHlAv53e+cYJixZS5YpRhjQdlshL4vYaIjuqGnVIbczKRiEQCWCj6Y7ZN7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G0SiYBfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F2AC4CEED;
	Tue, 27 May 2025 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748364529;
	bh=gGbrOHssW0ifZtpswZ5VVSodlz50pPXg/ao4s+ZNutE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0SiYBfLWxSQFfhQid+rB02JgOGbg3Z2VmnCeT37zDgRCBT/UuPrY9rE3jymO9u+2
	 zjf/m8qhK1dn7OZHYfuTGOdeg0QREOq78SinYxVZwZ9XLhkx2Erh1aWG7AfPHTe5/c
	 x5uMEJit2Ctx3D8hYHwGoOcWtQdyUzmkOlf5yI9s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 086/626] objtool: Properly disable uaccess validation
Date: Tue, 27 May 2025 18:19:39 +0200
Message-ID: <20250527162448.537054806@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index bea6461ac340d..0757b98b0a445 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3353,7 +3353,7 @@ static int handle_insn_ops(struct instruction *insn,
 		if (update_cfi_state(insn, next_insn, &state->cfi, op))
 			return 1;
 
-		if (!insn->alt_group)
+		if (!opts.uaccess || !insn->alt_group)
 			continue;
 
 		if (op->dest.type == OP_DEST_PUSHF) {
@@ -3820,6 +3820,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			return 0;
 
 		case INSN_STAC:
+			if (!opts.uaccess)
+				break;
+
 			if (state.uaccess) {
 				WARN_INSN(insn, "recursive UACCESS enable");
 				return 1;
@@ -3829,6 +3832,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_CLAC:
+			if (!opts.uaccess)
+				break;
+
 			if (!state.uaccess && func) {
 				WARN_INSN(insn, "redundant UACCESS disable");
 				return 1;
@@ -4304,7 +4310,8 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 	if (!insn || insn->ignore || insn->visited)
 		return 0;
 
-	state->uaccess = sym->uaccess_safe;
+	if (opts.uaccess)
+		state->uaccess = sym->uaccess_safe;
 
 	ret = validate_branch(file, insn_func(insn), insn, *state);
 	if (ret)
-- 
2.39.5




