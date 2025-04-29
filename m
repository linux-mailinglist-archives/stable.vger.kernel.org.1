Return-Path: <stable+bounces-138913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE59AA1A83
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B869A0B32
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DC224E01F;
	Tue, 29 Apr 2025 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U6dvaMS7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A7C253F2C;
	Tue, 29 Apr 2025 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950753; cv=none; b=tX3MytCXc0df+LY7ssvVglwnKi/Y8RESGNA+hVACIIocxQOtRGqjgNulhLR3e4XYTsDUlZYVoxniUwEPyAyvR9NMkez4M1xD+CNEHqTgavPFMszqEgUgklPqc7H2/0GsyAH6mca7/BHz7DZibPltJ3wEmjsfeEmHxlfQov/e1HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950753; c=relaxed/simple;
	bh=4agH6j/KkV5/0cVFQZQg9GknjLYcmKJ9cyq6sk+pDpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlnFG7KRctwIQXrjUptuFdBSaVkAavK9PFVc09xqI+LqYEpsM58p1+TAWD5XgpRe72keBTpPP6R7CF9ff3S3vK3Zcr7/JMORqvyzT4Ieq21MfUpvm3xegTQAfpq+EN2ay+De2dv6PxZqsL75wrJFDM+apglXayLX5emSywSJujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U6dvaMS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E66C4CEF3;
	Tue, 29 Apr 2025 18:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950752;
	bh=4agH6j/KkV5/0cVFQZQg9GknjLYcmKJ9cyq6sk+pDpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6dvaMS7qEXz5NvsSoHO+6bqHJhgYCtjampZIrSPOS2P2+96P7eRAPZ7gWQpO7o3l
	 iZKDQGaslwRHi55crWd6hMcAf59RIbb1jSf8ezKShUAKNW7aORvKSC7/BhAH8qYv5L
	 OUf9f2WVJd0SajEw6vtS44stk7zmGBCtjbboysaU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 164/204] objtool: Stop UNRET validation on UD2
Date: Tue, 29 Apr 2025 18:44:12 +0200
Message-ID: <20250429161106.118238611@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index eb6d7025ee49c..6d35fe0e4695c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3949,6 +3949,9 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
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




