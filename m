Return-Path: <stable+bounces-141364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F170AAB2DE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8271C022EA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8504A44440D;
	Tue,  6 May 2025 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJCugMx8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558132DA837;
	Mon,  5 May 2025 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485919; cv=none; b=tonOdzye/UhctRgQ7qke4opRJV9qz67rzHeUwgZckQDjCtC4Be0DDm1kIr8OH9HcjgAbTv4qmIVNokhRULKz7eJc9fGP1JPIun7cZZl8fdeP5Rxzi6Xpba7T1gtj5sZxZPRdjNKsjZMCjgdVZfaPOtkPN8l6eNjrWO3fmphmNxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485919; c=relaxed/simple;
	bh=hOu6RDv2bofvpbBquQTaswVOnl7AAW2levu10RPPsGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NtzINr0tXV2zlioS3MYK1CO5NTacrf2wcSR1qyJHhJ+2pPa3/mpmP4XBWoA4Uwn2Yu+5eWWWkZg+qOAJdeGnshtkZenJzWVnZs5DpW98cRnh1aY/EdOkVgR95MJDS31KxOpDCSXoAwBdFnESgQhkE+Z8zgoOTXx46G5mOmali6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJCugMx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B0AC4CEEE;
	Mon,  5 May 2025 22:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485918;
	bh=hOu6RDv2bofvpbBquQTaswVOnl7AAW2levu10RPPsGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJCugMx8IJfpT+j8BNkUnTpk4fF7rvMYU8MetX6rJj7Me+oeSnGlLYVvU8AQexlm/
	 wn9JtkPpR/0NwT83bSPcPchIE1GyZEXzcVBXgRiobYZKPYbXfYmpO50oWi6/afpldu
	 hfLPAAzS6WqpHIwP3Ca7MrfQxvOBJR+w/CxZ1PHijl3ztGac+NB1I6BG7g+wpZPso/
	 qcx9tJAQEsJVhIsukP0xy5hroQKp/c7zxLXEnttgseQTxLZU1edWP9HzIGTLNojVT7
	 iSk2/1VGRtGEv/ATf4UyUO3b9nN57EQXppm+9B7Y34Y3+jgBwfydeJMyTiQGlKwCzw
	 9HGuqDD/AofAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 065/294] objtool: Fix error handling inconsistencies in check()
Date: Mon,  5 May 2025 18:52:45 -0400
Message-Id: <20250505225634.2688578-65-sashal@kernel.org>
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

[ Upstream commit b745962cb97569aad026806bb0740663cf813147 ]

Make sure all fatal errors are funneled through the 'out' label with a
negative ret.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Link: https://lore.kernel.org/r/0f49d6a27a080b4012e84e6df1e23097f44cc082.1741975349.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f5af48502c9c8..f8e676a6e6f8e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4692,8 +4692,10 @@ int check(struct objtool_file *file)
 	init_cfi_state(&force_undefined_cfi);
 	force_undefined_cfi.force_undefined = true;
 
-	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3)))
+	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3))) {
+		ret = -1;
 		goto out;
+	}
 
 	cfi_hash_add(&init_cfi);
 	cfi_hash_add(&func_cfi);
@@ -4710,7 +4712,7 @@ int check(struct objtool_file *file)
 	if (opts.retpoline) {
 		ret = validate_retpoline(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
@@ -4746,7 +4748,7 @@ int check(struct objtool_file *file)
 		 */
 		ret = validate_unrets(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
@@ -4809,7 +4811,7 @@ int check(struct objtool_file *file)
 	if (opts.prefix) {
 		ret = add_prefix_symbols(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
-- 
2.39.5


