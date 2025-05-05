Return-Path: <stable+bounces-139797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B1AAA9FC4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479E9460987
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8B3289E0A;
	Mon,  5 May 2025 22:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpPolNXQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F228937E;
	Mon,  5 May 2025 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483354; cv=none; b=OI0msAAlmUnTZH+VHLXlh90vKuUSUC3728x529xJUaBxVbVPVWQ7oPoRAM9R/5qioSwv0tlCsqsFbkFMiJWPlRCz+xrAC5FnuJJdgKmpnhTPNAA9tkYvmAGsFTKgDgvDTno63dB7Ghq8mqR9p8LE7ak7NHI3nln6mJGeu3lbRQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483354; c=relaxed/simple;
	bh=zhuL+YqLxc1F+UBF4Jsm+zm5tNVnXEuQhRkRyuMTEfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L31NTZFbokFXp84h+cTQ8UyK6knehpY8CMEa8yC2UTJV+0TQOqqFyWk3duDVComAfj2KDTUdkwyqWREGIwR+u4CO/aQHa7y90+bEb5luCQtYHvLLTTZBHuIJKPbh7yUROtzIFM/NRAA6eiBGkZHAg167e35bxrVgzE6s5A7XZJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpPolNXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA15C4CEE4;
	Mon,  5 May 2025 22:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483354;
	bh=zhuL+YqLxc1F+UBF4Jsm+zm5tNVnXEuQhRkRyuMTEfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YpPolNXQyTjyw0sPGo47AY5sOLBoIIcsCyycJ+TgXYRsvhF74a+EbUQ8l7VAb7bki
	 s2GEPH82afoQvn0jKqldAIE0tNH5FxI5E/fVcJRHyUumCdeanz3mnHLdEAe7/3Fh/E
	 U8qD0b4pjoGSvgZ/6P6jLronjX/5O22t11096Gr/TpABGUQgiY1vWp0/sroz0+vWhU
	 Jt1hGoKXES3QBfyGoteqg/NGlOGD9P/kW75fgI3NPpaJ5nJvAcaQW3ehB7rj/9ZboL
	 Jwlmf+Kh8scqXbifH1LCcp3Dp178pprjMXvONb34FERc1gkR3fbrXv602/UYuJ9ELr
	 dGPAIbVI+OTZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org
Subject: [PATCH AUTOSEL 6.14 050/642] objtool: Properly disable uaccess validation
Date: Mon,  5 May 2025 18:04:26 -0400
Message-Id: <20250505221419.2672473-50-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index c51be0f265ac6..a29e7580129ed 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3208,7 +3208,7 @@ static int handle_insn_ops(struct instruction *insn,
 		if (update_cfi_state(insn, next_insn, &state->cfi, op))
 			return 1;
 
-		if (!insn->alt_group)
+		if (!opts.uaccess || !insn->alt_group)
 			continue;
 
 		if (op->dest.type == OP_DEST_PUSHF) {
@@ -3675,6 +3675,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			return 0;
 
 		case INSN_STAC:
+			if (!opts.uaccess)
+				break;
+
 			if (state.uaccess) {
 				WARN_INSN(insn, "recursive UACCESS enable");
 				return 1;
@@ -3684,6 +3687,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_CLAC:
+			if (!opts.uaccess)
+				break;
+
 			if (!state.uaccess && func) {
 				WARN_INSN(insn, "redundant UACCESS disable");
 				return 1;
@@ -4159,7 +4165,8 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 	if (!insn || insn->ignore || insn->visited)
 		return 0;
 
-	state->uaccess = sym->uaccess_safe;
+	if (opts.uaccess)
+		state->uaccess = sym->uaccess_safe;
 
 	ret = validate_branch(file, insn_func(insn), insn, *state);
 	if (ret)
-- 
2.39.5


