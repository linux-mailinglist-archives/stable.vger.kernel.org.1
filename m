Return-Path: <stable+bounces-110671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1DAA1CB3A
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1192B1685CF
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B566218E85;
	Sun, 26 Jan 2025 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5ktvgmA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3E7218AC8;
	Sun, 26 Jan 2025 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903807; cv=none; b=EguystFE5rIqaBZ3Xw/4ar0Xt+K4gDz+TFNFXQ04E4ZfIqq3gY46mDEni192/a5ap4W/jLOj+WASUqYhjV9KmyZQQCG+GAA4skKdhVo+gylEJU6zHP94BD0wGkRN0ZUG4uQdqYGvRh29h2buWefGog3sK1W5vGIlFkxjiPjeD0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903807; c=relaxed/simple;
	bh=Mw9X+GFM85I9bSCAi3/ohnvIg22dOSIGUvdi7E4cFhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D8QVrGi+jhKfBsJsC0smLXQeNeH7b9IDydsp80zyEqUtN+gP90knAK6Ru5l9fcSptmJsYHpP98UeExsW2G/SHekueRkVuOfN1GrpGN3k935C30+ZEDqLr0Eqw2Q4Lz9IQzEbn3tCYNhhZpdAxf50aDS1n6QzpeVp/3D1vEwOWEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5ktvgmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00852C4CEE4;
	Sun, 26 Jan 2025 15:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903807;
	bh=Mw9X+GFM85I9bSCAi3/ohnvIg22dOSIGUvdi7E4cFhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5ktvgmA1ivWsQ2SNb5boGiOd9/dVahr2gwVZUQ2J4O+HFfmE/9jXLiLiY45p70lr
	 NK4oOG58R3dEzFMnh3jylcthpBLrN82w2fIRWBZXl//3wfJiSptGichBb3BVgBT6ul
	 nJtmJxN0h+G3P7I5mKPcg7zJJ/HUendANVv06CEGNGk7I/nyGgjMIkhbTzhcxoMor/
	 A79KXe0G6wwSR/Ts8WcpqUyQShzNAIp2j6unO3XzfYl9vWOf/MDKvBxwErlPqakjtr
	 nHSFdXqFAynQEPJGMwF3kHWQI+xKNMDleNt/SzrTYAFlr/vBlbbpvnLMES/ePdFSat
	 q1kMribnD6Kpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com,
	Leo Stone <leocstone@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	takedakn@nttdata.co.jp,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/19] tomoyo: don't emit warning in tomoyo_write_control()
Date: Sun, 26 Jan 2025 10:03:01 -0500
Message-Id: <20250126150315.956795-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150315.956795-1-sashal@kernel.org>
References: <20250126150315.956795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
Content-Transfer-Encoding: 8bit

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 3df7546fc03b8f004eee0b9e3256369f7d096685 ]

syzbot is reporting too large allocation warning at tomoyo_write_control(),
for one can write a very very long line without new line character. To fix
this warning, I use __GFP_NOWARN rather than checking for KMALLOC_MAX_SIZE,
for practically a valid line should be always shorter than 32KB where the
"too small to fail" memory-allocation rule applies.

One might try to write a valid line that is longer than 32KB, but such
request will likely fail with -ENOMEM. Therefore, I feel that separately
returning -EINVAL when a line is longer than KMALLOC_MAX_SIZE is redundant.
There is no need to distinguish over-32KB and over-KMALLOC_MAX_SIZE.

Reported-by: syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7536f77535e5210a5c76
Reported-by: Leo Stone <leocstone@gmail.com>
Closes: https://lkml.kernel.org/r/20241216021459.178759-2-leocstone@gmail.com
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/tomoyo/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index ea3140d510ecb..e58e265d16578 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2665,7 +2665,7 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 
 		if (head->w.avail >= head->writebuf_size - 1) {
 			const int len = head->writebuf_size * 2;
-			char *cp = kzalloc(len, GFP_NOFS);
+			char *cp = kzalloc(len, GFP_NOFS | __GFP_NOWARN);
 
 			if (!cp) {
 				error = -ENOMEM;
-- 
2.39.5


