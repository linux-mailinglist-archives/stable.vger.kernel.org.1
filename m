Return-Path: <stable+bounces-141350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38582AAB2B7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C3977ABCE9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BA6293455;
	Tue,  6 May 2025 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKJ+LPaV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3913A2BD90E;
	Mon,  5 May 2025 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485854; cv=none; b=a0YsVKZkEALzWaqQ5JQLKrSiiDirydkGZ5tjK9+ebBpMlKiCCswB8cCaZqnb4w/fhUCqR+rj9+v7BaxtkrLNKrB8DWYUVCV3Y68EY983zBakeAStYB5hY7Uqz3wqqKzhcyMp4QGpAluQ2N6ii0ZClunRybe0OZap4+lulfB+Fgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485854; c=relaxed/simple;
	bh=2FQDgPCajLxKbD65RjjBamLGkOjnxgGPH+1vSbcdkLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LxNUwP5GKlOTuXC0WgCpfzXRgyj3xz67Khac8u3mS0Z71ETL+x5ofd41jZCzVD8BByrnPfdjdHG51+jMnYw6stoKm38l2LUeFpfClED7LaDHiCdt6VagDQqTOEKoo7mZAVNuB7MEZoWwIDDBnqmxTf1yghjw/nMJFzQ8AJ2dxgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKJ+LPaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69F0C4CEED;
	Mon,  5 May 2025 22:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485853;
	bh=2FQDgPCajLxKbD65RjjBamLGkOjnxgGPH+1vSbcdkLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKJ+LPaVsRoHlUh/NKD0EYQTohJo64/JPFZZzV1XRTzg3PhPSKP4TMIKsm7YIrJvu
	 HI/wcrzyJbBffz93JfUPbzTIfYW/eioC/hR2gmFzL2vnaorcKi/sxoMQkTbDowmGPx
	 228J/oItHuJ5M8LDwe8/zI4JX+SVm+LNXNenJ8hLuDRk14Q24F6suHWUEwHaR4R88F
	 lGqzLHtpJpRdki8MGkkrBniVehGfuOzp9n2JzOI8hRyIS8jd3ycuGJC9Y8nHBH586a
	 0zCI8m/vW3F7RVXeo97wwA0OthaO9bAHfoI22N9T4gqVNB8s+MuatUx6SwtSm+1BC5
	 x5B9Hac99MqmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org
Subject: [PATCH AUTOSEL 6.6 030/294] objtool: Properly disable uaccess validation
Date: Mon,  5 May 2025 18:52:10 -0400
Message-Id: <20250505225634.2688578-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index a1b14378bab04..f5af48502c9c8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3287,7 +3287,7 @@ static int handle_insn_ops(struct instruction *insn,
 		if (update_cfi_state(insn, next_insn, &state->cfi, op))
 			return 1;
 
-		if (!insn->alt_group)
+		if (!opts.uaccess || !insn->alt_group)
 			continue;
 
 		if (op->dest.type == OP_DEST_PUSHF) {
@@ -3754,6 +3754,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			return 0;
 
 		case INSN_STAC:
+			if (!opts.uaccess)
+				break;
+
 			if (state.uaccess) {
 				WARN_INSN(insn, "recursive UACCESS enable");
 				return 1;
@@ -3763,6 +3766,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_CLAC:
+			if (!opts.uaccess)
+				break;
+
 			if (!state.uaccess && func) {
 				WARN_INSN(insn, "redundant UACCESS disable");
 				return 1;
@@ -4238,7 +4244,8 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 	if (!insn || insn->ignore || insn->visited)
 		return 0;
 
-	state->uaccess = sym->uaccess_safe;
+	if (opts.uaccess)
+		state->uaccess = sym->uaccess_safe;
 
 	ret = validate_branch(file, insn_func(insn), insn, *state);
 	if (ret)
-- 
2.39.5


