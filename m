Return-Path: <stable+bounces-116835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0D3A3A8F3
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA3E3B64F3
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70BF1DE88A;
	Tue, 18 Feb 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdfsTXvn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A8F1DE4FE;
	Tue, 18 Feb 2025 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910325; cv=none; b=pSc5uFqSYLJ/osZ+eVAfwlsV+9dfJxtpAcHVVjMWCHckYRCSnCFnEHaGHhIDisBdgkHYIsZ99TQkPeHjkq8ZufwB5bbJ0N6QtBD74F912aTHn4EJssjK3IS7WsSeRQx5A4Wx7wg+f0XHNE1S/HubVpZyJnJhACzjvpVY+7wS7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910325; c=relaxed/simple;
	bh=ucQEDSo0yN+rZoO8Jsc/kP6maAsDVyEaykoaqg/6c4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NavN4+ucLyC3HlH8W4CdbPMIfIzHwk9+eLWR7S3eDeu+fNCR6a3fZLAcuduaNDNGehWOonVY27YwHLkc2M/6hfuRzWcr1P9W+0T7UHQUkcvTH7u7i4IjIbxyurhV68PWOY0oAObCwiMq0VH640BgxCLs058LpduG/DYRPyL+fOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdfsTXvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF2CC4CEE2;
	Tue, 18 Feb 2025 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910324;
	bh=ucQEDSo0yN+rZoO8Jsc/kP6maAsDVyEaykoaqg/6c4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KdfsTXvnxZV4jMdaYg8EbwquqlgmFuFZMJv8fUAeOv4pVUSLSUrRo4MNboF/lxtYq
	 91ZXWax2ZOpLH6rv1pL3gMkKFUc9t2K75pdSgUERKt/y/9hu9IzUxNSQWnOrgRHR43
	 SjyTqQMwhMv6o9MOkpJXQTfq9QydilsOp/eG62VeXT2h7pwWc3VuWQG5w4mkwJ9BcM
	 uuAlYfIdI1LYaqX0Wz2eN/4PPg6rQUE8rJDyeEdpQMolwz4hKjREsWWwEsRd4yTFKO
	 6DvT8rfhdSF48sCGMTU0LYVaiXmYna1++NGFA1u4+wkVAhU1IR+1eGEJ74DmU929ym
	 z+nciSNjzV/mw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Klaus Kusche <klaus.kusche@computerix.info>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.13 13/31] objtool: Ignore dangling jump table entries
Date: Tue, 18 Feb 2025 15:24:33 -0500
Message-Id: <20250218202455.3592096-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202455.3592096-1-sashal@kernel.org>
References: <20250218202455.3592096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.3
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
index 76060da755b5c..4a0c5bb7e4576 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2099,6 +2099,14 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
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
@@ -2116,6 +2124,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		alt->insn = dest_insn;
 		alt->next = insn->alts;
 		insn->alts = alt;
+next:
 		prev_offset = reloc_offset(reloc);
 	}
 
-- 
2.39.5


