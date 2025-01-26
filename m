Return-Path: <stable+bounces-110731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D8DA1CBE7
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE1D7A4F34
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410F222FAD3;
	Sun, 26 Jan 2025 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1btQN2A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E672E22F3BB;
	Sun, 26 Jan 2025 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903937; cv=none; b=DY1h1vDywphjZimyPfPL7VUylZY0WybLliE83TvWV5gnJkGEDqgNndxs4S/adxZYs33jzeTCSMhfouGRb1iS8hZwL37lsB+mJIPBsiLISZiLLyigPWB8qx7DtlXfTK7jITaBuKlnbHQVQYz8jM8izd1mFSyARnSfAU0TROYwRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903937; c=relaxed/simple;
	bh=coDBjQYCJdMJ8RoSlZOh9725+pb/7qsNmTV+zBP9iiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OFcjake9sJsrXioPWtHoExhO7qriS9laWi82RGjQGtKj3ZjdT09yP9+j5hJuzjBV1208rtV2nLCdS6Z5QZBtx8pYnjRDWorSxjFEXO3ig16e/hhyFkHl5qukj2KOcRiriYYGfw2GDPsjmeygOCZoYLPiWe8Yuo+6fUkwT8q7M6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1btQN2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F9FC4CEE2;
	Sun, 26 Jan 2025 15:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903936;
	bh=coDBjQYCJdMJ8RoSlZOh9725+pb/7qsNmTV+zBP9iiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W1btQN2AIaNwkJzpCF097LbVGddWDJt98/QLd5VRGsUZzIHHHwAx+hdT6Ph++QL6K
	 dYhJXpX7boM9tGOhBa9gEllXlNU/PPP245aJ61+5QwvAFnxby5OjpFkjdyt9jb9yZP
	 VwOwM+UIvw3GjxqGeWpa17WqfrkRWEHd5G+alyOjKdaM0jaCkiHcc+OI4ktHsUxIiK
	 xDy4W7uVVm+dohUUHsizPCb6XnvLcMxZ+UkR/OgsQqsH+qgb35SlzfjU/JL4OQsnrY
	 x18h3LMXeg/vSbOtkn2J6A6E8PViem1ILt4PV/K0Di2FLR5K8Q1zICZDnrTAAUnghf
	 z0BxM9YMSnS5g==
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
Subject: [PATCH AUTOSEL 5.4 4/7] tomoyo: don't emit warning in tomoyo_write_control()
Date: Sun, 26 Jan 2025 10:05:24 -0500
Message-Id: <20250126150527.960265-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150527.960265-1-sashal@kernel.org>
References: <20250126150527.960265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.289
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
index 1b467381986f7..360cf2960f349 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2674,7 +2674,7 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 
 		if (head->w.avail >= head->writebuf_size - 1) {
 			const int len = head->writebuf_size * 2;
-			char *cp = kzalloc(len, GFP_NOFS);
+			char *cp = kzalloc(len, GFP_NOFS | __GFP_NOWARN);
 
 			if (!cp) {
 				error = -ENOMEM;
-- 
2.39.5


