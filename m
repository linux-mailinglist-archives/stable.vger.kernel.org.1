Return-Path: <stable+bounces-138110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F00AA1695
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A98189D79D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A323C251793;
	Tue, 29 Apr 2025 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iIW+QpS5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603761C6B4;
	Tue, 29 Apr 2025 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948184; cv=none; b=N38UlrQvQIzUTrmQvtFT/QcjTxOzEWHWqqTNALaymIAzYUzU/px6J9/NOxhCRlmV57+QB6+/aODTt7zjP1kgXKnPTkFqs/M10QsRtAMpHZDpNkGXgE4C33KE27TiwwJxB+rpuHKZb3vRzs2ur8MoXVQr3Zvs316LSlk84lxE99w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948184; c=relaxed/simple;
	bh=v5tnPKNglulc8Kh7hiMymUbgFcIqwqP6d+Odg9Nmqgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AahoJGAY5/iRoFd9BjRbrm73n3DdPCJ4i3TB20IBzo4UxyDl1O22YGIb7iMlecU+/uDOfT9jQFLvlZspWqr1dabm45LzHLI5UcKUtmIRklC7OjTXOKhq5Imnu3TFG6RNXwRyFWcgfie8utF6RdCsJ4yOrHlyqFV9Th3DJtJZlic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iIW+QpS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FA0C4CEE3;
	Tue, 29 Apr 2025 17:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948184;
	bh=v5tnPKNglulc8Kh7hiMymUbgFcIqwqP6d+Odg9Nmqgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iIW+QpS50ILvcwLzImCll1aN3TK3kqkI1K5qFksJY7o4APPb5Vx/rcsszgVKP4pLU
	 1R207/xgwX0DzLIREHrGY4ubJQSA1vAtJxwdMT4Lh0bhp54eTc0ePPV8P8CCKxpFl3
	 6wTVBmuRO+xOlDrTaSOwUWs6THqugDfTLzIAjPK8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 214/280] objtool: Stop UNRET validation on UD2
Date: Tue, 29 Apr 2025 18:42:35 +0200
Message-ID: <20250429161123.882198294@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
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
index bab1f22fd50a1..9e6a934329dc8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4014,6 +4014,9 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
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




