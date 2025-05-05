Return-Path: <stable+bounces-140493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215ABAAA951
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BD318910DE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B54635EB9D;
	Mon,  5 May 2025 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj9B0dyj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860B359DFA;
	Mon,  5 May 2025 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484975; cv=none; b=pZVRgjj1dKk2O1RLgUnZ+47jbVI1wMPcYXFdSXa5KGljH3+PZ/0KhTC43V7zG+y0jgOzmbw1J9/c83bquvNxFnKWGVI9P6F+rwCEHw+aFPcXfI03hmFvH912HCJivKIhz+KzSZp+QZDpB7fnG8fs7qZAcDmZreN82zKFZ/zVDDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484975; c=relaxed/simple;
	bh=nXFaesna7g7CfcsSIMm/jlr/29aNgCxe7xIdn/aj5Bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kuJHmZmFmvg49HFBXKOuy0gAk/29H4tPjdDBDreDdc27FSdEfSZ5o9mb3iTTYeyWTiAFZc8smkdrtKzOcgoIdjgHb/ZfWlnfK3ZE8cGIWVpO2xQT6yvZ/xnbG4ErN9Y/F/kfydpVgZg0XCdQJQsnPdY+nph0+RY9OvNYm7jWHqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj9B0dyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAACC4CEEE;
	Mon,  5 May 2025 22:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484975;
	bh=nXFaesna7g7CfcsSIMm/jlr/29aNgCxe7xIdn/aj5Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kj9B0dyjNUDg+frnXmEZDzydOOXGq3K2Z4d1jEwq+qdE7AK0gZ9rh7+0X+FtCEDKs
	 cez1O82wiRS6kBAX5fosYJoM0BXEUuOX/YVPY70v+TnYSkSaKP/+TjB5Uq9C86FVWb
	 hHtG6z2umzNhgyY/s8VdUwMZCZUDxd3246R1KozNSJheMVHQj6yN3Y9lXQTsz3J8/k
	 LF4FB4CVlmSc+HDEgqOvW1ziE9uZXFP2lx5MwiOB5l0ZBEEB9Lvz0SB8b8ZF6VlPRB
	 2fOj1tp8RKVI/mX6V+bu5dxUOhKW0V+DsLUQzmue26SDtA16rPc8qKPuLxaJmyj2aq
	 rAgoT8OAYvxYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.12 105/486] objtool: Fix error handling inconsistencies in check()
Date: Mon,  5 May 2025 18:33:01 -0400
Message-Id: <20250505223922.2682012-105-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 175f8adb1b76d..ad4ecc8b3479c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4757,8 +4757,10 @@ int check(struct objtool_file *file)
 	init_cfi_state(&force_undefined_cfi);
 	force_undefined_cfi.force_undefined = true;
 
-	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3)))
+	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3))) {
+		ret = -1;
 		goto out;
+	}
 
 	cfi_hash_add(&init_cfi);
 	cfi_hash_add(&func_cfi);
@@ -4775,7 +4777,7 @@ int check(struct objtool_file *file)
 	if (opts.retpoline) {
 		ret = validate_retpoline(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
@@ -4811,7 +4813,7 @@ int check(struct objtool_file *file)
 		 */
 		ret = validate_unrets(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
@@ -4874,7 +4876,7 @@ int check(struct objtool_file *file)
 	if (opts.prefix) {
 		ret = add_prefix_symbols(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
-- 
2.39.5


