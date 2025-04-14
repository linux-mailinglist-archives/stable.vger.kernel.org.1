Return-Path: <stable+bounces-132617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CABA8843B
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAE85612F0
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA192DD690;
	Mon, 14 Apr 2025 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0gsrXps"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016E2DD68C;
	Mon, 14 Apr 2025 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637533; cv=none; b=fGdTp5ntIX0tXMmrPt85XButqq6PpN/vvq1DJLCCzEDKCv5e/HFkRGhIBd6bOgsyhJa67u3VlmkX6PWFcKFSOjt0E/oePnsM/tjjmLSLztulhfYWDtu7LThzSgcPnVlu1m/hbUIu0eR+yCGisZzWAV9lvMrZ/VQ7UzYVTqAauqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637533; c=relaxed/simple;
	bh=9Boqaxc0T/ILY7xhjPJ9ikI6D0WZR6oGzxw8kESorEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ez8wQ+AYrTL07mDoNZom3+8VQUgSz0dOMwd0dmWNXCl7AwPpHkLOO8bQjg+sHR/sRWJ7Jwc/o1we6t1oPOqnNnRW8qzgL8IbJNO5UV7qGcBsIpKFjSgrOGC1samjqkza8M2xSn4+3UZtie0nOgfIz2REtUJsTCYfN49S2q/gKlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0gsrXps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510C3C4CEEB;
	Mon, 14 Apr 2025 13:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637533;
	bh=9Boqaxc0T/ILY7xhjPJ9ikI6D0WZR6oGzxw8kESorEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0gsrXps5DaV0+ow8pYQtjnESb/mbwAo8VGucbsFxJxr9jyUHa2a0Y2eBLNho65eG
	 OoL9T+MSm25y/VgAVDd+CVX8sTc3HH1tecRxbN2ElBgUVh4AE7/rGL1UztU0Ll+VeN
	 ME/xmGZk0li/bs0vl54hP+yJDVR4oR2EqNbzWBQmEfmtpwgzuAL0WVD9hxAvskNfWW
	 9JXI69R1qzsteygLkGRC5yqSqXSrUHrvsf0TikrkJDVXZLyiGHAKZ8+kuPUa11HLAO
	 2ktzyV+E7w5cGis2GqzE68dyrFh4pL+YMrV620BULtgrEu75uHyA39zt8C0O3q5wuo
	 mOHhmO6db0f4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org
Subject: [PATCH AUTOSEL 5.10 07/11] objtool: Stop UNRET validation on UD2
Date: Mon, 14 Apr 2025 09:31:54 -0400
Message-Id: <20250414133158.681045-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133158.681045-1-sashal@kernel.org>
References: <20250414133158.681045-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.236
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
index bcc9948645a00..20ccdd60353be 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3249,6 +3249,9 @@ static int validate_entry(struct objtool_file *file, struct instruction *insn)
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


