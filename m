Return-Path: <stable+bounces-110514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C6A1C995
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCE11614E6
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F821A23A9;
	Sun, 26 Jan 2025 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFJwkI+3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D417ADF8;
	Sun, 26 Jan 2025 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903235; cv=none; b=abaNPtXg1okNbkbipMDMmNoEwBLpA5oHfh8b6tAWw1qu+s/7wBmrlYGDvPEYocLK+6IG1OfoakWyAJb9BbPuj1MrBfcKXBlvvTlCrc5LR0loFtjUaws1/rKPGY1ZNRiyFoxLtwL7Tzc9OtjF7k21PWdOgnBACq2s/UNfgsWPwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903235; c=relaxed/simple;
	bh=9n4p4UyWr0Xmb6GSq7HhDZHKtkqSg4PzLwwEamUTSBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nHIy3zGLDiA+qyrojb1/jhrbx4E7W5RsJLAnYRixE7l8kkbt/Wu8b3rpt39dGLF5ZZ07jbdGG5MKirxWdOLa1Qo3EPwEJOswJyQ3WiB53xcC23/v8kxGwr9wgpK2XHFMR078iKs7NSY5NLTPy4SBx3x+nze+x3OTPoVZlJa/ASA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFJwkI+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C09C4CED3;
	Sun, 26 Jan 2025 14:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903233;
	bh=9n4p4UyWr0Xmb6GSq7HhDZHKtkqSg4PzLwwEamUTSBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JFJwkI+3ADpKNuFcJ6sjhee2r7MgnloY6C89eOmArw339OSJAJYrFFjK88fa2oXBq
	 hLU0qNlLRSvQIJgLJWwcB1yC2wB9z3k6OpKll1c8hC6GPuRSoSpc+N7dbMgIOeam9o
	 O2BLEV1xFlbHOjsT5iaUtb6tS5npsvryzbkzxPxZTvgEWn6GtZt5AE3YL641O8wp6P
	 uf/cLf6RlublEm0TKywgzAz5o7f/rJfpIJhC0jsf0byq5y6Q9ONReYY+Vz6+Pp0YLM
	 3ldYK0ckOuV0XeHmcKcUW4y84oWL5JGvn0Htc1cyNbqFNRQOaK0PA62MwNCT38sWMd
	 gjm0snDrY5Qfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.13 12/34] printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
Date: Sun, 26 Jan 2025 09:52:48 -0500
Message-Id: <20250126145310.926311-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145310.926311-1-sashal@kernel.org>
References: <20250126145310.926311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index 80910bc3470c2..d8d82dd39dee8 100644
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


