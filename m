Return-Path: <stable+bounces-138683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2E9AA191C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768B018941AE
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00771A5BBB;
	Tue, 29 Apr 2025 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VoL0K6ze"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDD620C488;
	Tue, 29 Apr 2025 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950021; cv=none; b=FFylarFtDjEqfKMAoeto1QncDoQJ1A6OxW8wMgZpp5KXvstfw8nsAAeuAS4y4riq1x32MXo+KAwZDF5ZG72awYq3WStOAawNYqhgywe32NgVMeiyie0DFsA654bQJZIQ0AgpUwq/UzwGPGH63TT6VGI706Tm6g+wXM95XP1iLt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950021; c=relaxed/simple;
	bh=+xpH7Olh84OO+b4p+lH+XYW5n5Uad8gzdEx/iChBm9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQuOM+/+rze+kFp7mf0d/IYteaPk7xtJocMJiBBV9VZXbEBAuZO7SNmFeYOL1WXWL0LSeWvoW5dTBi1LAHt4oDYYvwgawYF4Zp172eMvZdARSpvQu7eZW9+uatqPp2hc6Y6MwS/SwjNXM19zyYfXRl4enqdzJ56GkCf5lax+wKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VoL0K6ze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA742C4CEE3;
	Tue, 29 Apr 2025 18:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950021;
	bh=+xpH7Olh84OO+b4p+lH+XYW5n5Uad8gzdEx/iChBm9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VoL0K6ze3eOBmkLNNTWmOQyNhmjCa99T3lA06iK7Y6mhD/+63JzhaMWNw7CxV89Jv
	 YGJ1l7yAHjRR96UPzGVzr94Oyog8c0Srn+kkADTeS1fxKE2cBQP5ytgFEonPOT44QG
	 U8SSd307CiaYjn5s9aE4Xe8wdrrGyP0oguUwsWXs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 132/167] objtool: Stop UNRET validation on UD2
Date: Tue, 29 Apr 2025 18:44:00 +0200
Message-ID: <20250429161057.076169065@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161051.743239894@linuxfoundation.org>
References: <20250429161051.743239894@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index b6c91bb5ce3e3..828c91aaf55bd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3737,6 +3737,9 @@ static int validate_entry(struct objtool_file *file, struct instruction *insn)
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




