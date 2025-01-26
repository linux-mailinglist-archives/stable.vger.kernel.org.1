Return-Path: <stable+bounces-110643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A80A1CADE
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F2916419C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017E020ADFD;
	Sun, 26 Jan 2025 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/YvTm/u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA620ADF7;
	Sun, 26 Jan 2025 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903745; cv=none; b=uc+TYkcPFBKnlBna3qdvSMa2lWoJBplqYiCgKCwy2I4lKjVVwGdoPNr+wWIYTjnXYQRMkClXoVfUEiMpIZ2TInJ2M5+lDNdxtLlEyr7XvJxuVD/D9zUsdL3wt5QF7yn5ClfO28aLda9JuFeyB9oc6RqhWeSpiC8/KJKa3A79ts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903745; c=relaxed/simple;
	bh=8yq2XVg95QqNPrBbNM7POF3aaHyzT+nf9JDacZVezXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PQbM/Bb5Z48NaHT5XuxcmZW9xiWu89YvCzS6kya5HP3dFHOlUIDbbEeGJ4tEg8N+cgI7Oywz0zfm1ttwShBlqWuMjXqScE4gOvye4d9IvhoLcRWFr6jcKY1/WlFkuqLAOC7pCMCN5wWBnc6bud5vUmFoeTtXackYeeGXHeErFl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/YvTm/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7396C4CED3;
	Sun, 26 Jan 2025 15:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903745;
	bh=8yq2XVg95QqNPrBbNM7POF3aaHyzT+nf9JDacZVezXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u/YvTm/uoJQC8HYF6LN4wda9koweB6O2TUFseoEGh2fYWlWG7m0jwm6EbwjGOru/k
	 gWH7XLoLqyCM9LKEOTyBQATPC1u07BYolSwdCIJcKy2ZPJrkgeGajeipkFdWbTl/C/
	 TgUe7mfv3Fu3jkodZ6FWIg74fNhBwHxqHKsfrYPct1QndgcMG1BRK+p8tSo0fqvkuP
	 KpFcINUv+mrehxfDfKrN3UEtW6lBqZNWxPTAJehiPbfnWDYvUTMcfjRqASASeapUdQ
	 MgSApnMC1XyhNyoKLDeInJY6Ff5eLWQrjGM1FZ1pa5PebKOyThRz/SCcPTmYHBElk2
	 K62gPNm7fcQUg==
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
Subject: [PATCH AUTOSEL 6.12 07/29] tomoyo: don't emit warning in tomoyo_write_control()
Date: Sun, 26 Jan 2025 10:01:48 -0500
Message-Id: <20250126150210.955385-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150210.955385-1-sashal@kernel.org>
References: <20250126150210.955385-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
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
index 5c7b059a332aa..972664962e8f6 100644
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


