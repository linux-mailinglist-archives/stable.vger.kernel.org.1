Return-Path: <stable+bounces-110586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF316A1CA28
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E4C87A3C9D
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7962B1FF61D;
	Sun, 26 Jan 2025 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuD7FwY+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F21FF618;
	Sun, 26 Jan 2025 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903416; cv=none; b=gq+MMqZMyN963qUXxwLB8FD6VUJsPfqWr1alFskfNIPC4m5NvtG6RRfjwjQ+kgaXXQvUGDoLlD8yXFviB0GMJLnFoRS11v6LeyS+5CVriHDnZGejJVF20LELT3x+O0Q0adbuyjnHMzVzdafat6XrsYh1zcRUYQ699PuebzrG3J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903416; c=relaxed/simple;
	bh=r5xQP2kmxkcLbzRQVpciXSfD1lIp6RBQ5jEUs/vGmfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aOrbONB2kLM+H4dvbu1QO8rIi6tPLfL+r3P7X3QVIyPzxZhubh+KxzICDkqA8a/L76oTL3jX9TcW2vdU4PRZEu4/JUNwHuk30B+657T1wwuQVsodqUdMpqxA1g+9DhpY6ZGIt99KyWsFIJ5kLKmqgfx+6s+2KDd+zNJ//2kzISc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuD7FwY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1DAC4CED3;
	Sun, 26 Jan 2025 14:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903415;
	bh=r5xQP2kmxkcLbzRQVpciXSfD1lIp6RBQ5jEUs/vGmfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OuD7FwY+81dRSFDK0CgCvDg9JCq8sXYO2GIwZUuTVQN1JrjcGP6u3e/lesBMmNm0x
	 b8zy93z2yTix+m9sf63/7BIUTMDjwHwQwAqOrE0/mxxDg7MGK4r+n+LQyVZPkw+5Md
	 /tw/XQWQNuUmGZtaTFM6LMrZBrTeLwyA9JYABFne/no2cR6AtvfJlnhQwDIzQNQUv9
	 wFbG3AZ3aeg7063NGPgrFGWXnAWSo3BPnwJxXWVs/pDhRGbHnF4d4MILqAG/DcutXG
	 5QrJOY2oK3DE6uHUPr0ezmIE8RszY4N1PEyApP+JaxoFUtiP3WihaYRXjkieMz0rHg
	 zLrp7f86D0TKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 2/9] printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
Date: Sun, 26 Jan 2025 09:56:44 -0500
Message-Id: <20250126145651.943149-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145651.943149-1-sashal@kernel.org>
References: <20250126145651.943149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
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
index 5a88134fba79f..c93beab96c860 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -403,7 +403,7 @@ static struct latched_seq clear_seq = {
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


