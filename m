Return-Path: <stable+bounces-110547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D91A1C9FD
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0BB3A7E38
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FA51F943E;
	Sun, 26 Jan 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cdjdxman"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB431F91F9;
	Sun, 26 Jan 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903324; cv=none; b=r/gg7lBIaHbt/AXuSiyN9V3xQHSmAJoM3BJ0Wf7gUtr6aMQ9wWITkuVoBkkylIGHAzsywkntF2ecqBMh/GH+7WD22haAUBtSdwzD1ZYvQaQA6iBMWLunDbJal79BxJkHaaOzWGM4Xu4hM8HYwWmo59JU12vsE/jkbnX4g7nf0nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903324; c=relaxed/simple;
	bh=0aOUCKj0HZ3P1cz0RTZwl+fOFK1hYxwlHkUcJZoG6zQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K9fu/qy5QeXQuw1kh7Vl/vnx1sfXZyCRykP6RixHBVZYmg8xk8Rg/xo2UbM807cekDzGoBg4H3yq8XK39kjz7PEaJOcz+SI/KyQ6pZv+7VENKYaYUI0j1J99GNI+lIwfq8uzXK08fD0p2DI1SZwa9v0BIcJbv5fI5Uo0+CqM5go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cdjdxman; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765D1C4CEE3;
	Sun, 26 Jan 2025 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903324;
	bh=0aOUCKj0HZ3P1cz0RTZwl+fOFK1hYxwlHkUcJZoG6zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cdjdxman0heG/UvTde2Kxm2q71oa+WqjKek2Iuk345kL2d+DmF9tFEAwAKJFIqX0K
	 kAeeyueRbEnNjcr7/QfwAaxQf9bYlfiz7YCtejoKt43j3ZWoOMFgrta3iaH3PfIm3e
	 VM9YMy241iF0Y2ud4DFLLoMupMUIuc8eCXIv6BIcEiEQAcIhwldTM2JffrW2hU0uRa
	 v8uvupMIz4nAyMDEowbCuQYnJMaUjDnbk15XkX6DyyyOpc3MlmJhCBLBTje2Ud3TvZ
	 8ZEEFM/z7T+Ae7VFvdgRFRI1vgnAft0sYnIBOjQa6e0DkVyOI6m4foUKL8FRqVJvNi
	 2mYGhu73Xbv8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.12 11/31] printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
Date: Sun, 26 Jan 2025 09:54:27 -0500
Message-Id: <20250126145448.930220-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145448.930220-1-sashal@kernel.org>
References: <20250126145448.930220-1-sashal@kernel.org>
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit 3d6f83df8ff2d5de84b50377e4f0d45e25311c7a ]

Shifting 1 << 31 on a 32-bit int causes signed integer overflow, which
leads to undefined behavior. To prevent this, cast 1 to u32 before
performing the shift, ensuring well-defined behavior.

This change explicitly avoids any potential overflow by ensuring that
the shift occurs on an unsigned 32-bit integer.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Acked-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240928113608.1438087-1-visitorckw@gmail.com
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index beb808f4c367b..ea0b2290e2d12 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -523,7 +523,7 @@ static struct latched_seq clear_seq = {
 /* record buffer */
 #define LOG_ALIGN __alignof__(unsigned long)
 #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
-#define LOG_BUF_LEN_MAX (u32)(1 << 31)
+#define LOG_BUF_LEN_MAX ((u32)1 << 31)
 static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
 static char *log_buf = __log_buf;
 static u32 log_buf_len = __LOG_BUF_LEN;
-- 
2.39.5


