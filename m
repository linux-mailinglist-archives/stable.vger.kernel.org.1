Return-Path: <stable+bounces-110568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9212EA1C9F9
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB6A1881911
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E401D54E9;
	Sun, 26 Jan 2025 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRxvUDTc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24051CBA02;
	Sun, 26 Jan 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903376; cv=none; b=WP8/fN6at/ro45OtBf/b2B5JDAh/bkIIpPIYsfwdHCHbNq90WOKi+d8kPHDcZsN32+0h/V8DwLes0Mtw6UtYemS9LJcPNZTMTbuq3stbT60erG+Gc5UeKY1xdyiNQUfxG4fYYSgrM2OIF/Nqush02ns5HovH36AVZQ7ZqbHc0h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903376; c=relaxed/simple;
	bh=Tdm/EnYLhmTz4f56Biulj5irNvRuRL3QnqC+X7PqT3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qVqwuaWBoF01bfLxK6k+anAU/hl03t3B4UzlVeoD2PuEkdEDyWsjWg2nHF3vsVyVFIGr9/wozNQ96I1QBPrL/Lu/pshBlHQhfDs6BvxuW+L5SpBjkAInBauPrU2kHh8sJvEUlTIU/cUUlNGFzZQKwMbc6itMXFz+yQ2Vjg6W8kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRxvUDTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8843C4CEE3;
	Sun, 26 Jan 2025 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903376;
	bh=Tdm/EnYLhmTz4f56Biulj5irNvRuRL3QnqC+X7PqT3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRxvUDTcQZMhK8hiy3JmE5150Fnt9jc4etFPGreEFvKJfuqkMm6Bbg1D/HakCfUHd
	 ND7DUTRWFJwGhC+3SFVmHIXdSV8vSVWocgXNjZMRe+oLr0Nlm/sy57DPpNS3GLxIo3
	 B0n0lxttA3cqIAfOEZRF4WIi6vq7TvfO5Jg8tOpteixbWUB2+G/7yf6cMl/rgNV/yc
	 aUjv4A3unnuyqG4GoLzRtf2W79ZS37NWrAD+oZR7CmavwfpzKau76iMb58J0G/2ZAJ
	 0DVxF20Pl828IG/tzeW6luEcpo8zc6BhEcRFk+3Ih1aoe3J6UnzxL6aQZgUx+EZEWe
	 8f/FOXRoO1Vpw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 02/17] printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
Date: Sun, 26 Jan 2025 09:55:57 -0500
Message-Id: <20250126145612.937679-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145612.937679-1-sashal@kernel.org>
References: <20250126145612.937679-1-sashal@kernel.org>
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
index 0fca282c0a254..dcdf449615bda 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -474,7 +474,7 @@ static struct latched_seq clear_seq = {
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


