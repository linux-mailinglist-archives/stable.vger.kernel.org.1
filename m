Return-Path: <stable+bounces-110597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06525A1CA42
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B9F1885D03
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F21202C21;
	Sun, 26 Jan 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaEJF7L+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2682201278;
	Sun, 26 Jan 2025 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903439; cv=none; b=S+mwIyiM3cANjLeJn2DPcgSzPn0JMdQKZj5PX6AyidV1pDGGn07YnDUOSg+Lis2MrJtAa+A0lPnI+PVDk5TYMyGI1Vp31qQ6S0A0ytOTQQHSjYYNa4l+7CQxoZd27m0yZ7Qupyjpxl0KW7QU8+CO28OaWRCRLlm36D+DSGfbQL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903439; c=relaxed/simple;
	bh=FGImjdNF9yPRRRy/Rd4yxbFcRQc9iCbQk34Sn9qvTdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hMap7AP8I3DBodSfGaDo20l/bq4VLKFiL9mkuwLjZW/3sHnTOsooM4gZQ06yT5zuaPI3cRYQMXKFmS96X2uflg+IqxL+bqJOZEWxhgbfxCGUWCPpy8dAGBwPyZLxxFiIgw8NhPv1mgsKl0meDtV5rVnhtJnpBZHCWQGqhHnfhdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaEJF7L+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAE0C4CEE5;
	Sun, 26 Jan 2025 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903439;
	bh=FGImjdNF9yPRRRy/Rd4yxbFcRQc9iCbQk34Sn9qvTdw=;
	h=From:To:Cc:Subject:Date:From;
	b=gaEJF7L+rfNj6pTbWEMn0xRMnSVfPvf6yqLAKbUynA6wcKjF4CAtqndtp66e6WEsj
	 TQoj0PWzsecU2rXSuH4zaVlEAwxZbJjuIT4qHegkpNK7exaZzAg9i7yM4kpej8gJoz
	 xmiYD8Y+B41AUvS1hDZCdavw/85LjEEvEbknvLyNwu6FeU4orsWca9VD+BcxhSv4Uf
	 fttCqsIXaAlaM7FlQLoU/2+p8fMkAZcvIYYKr/AlnZuCDgX32O/nEEoImSgAYIZHKk
	 hdBvfq1vvNN6tib3zAZUIjNBx1SQyOJDFUY3JqSOuj/YgWF0FjbFofEYIlH2MUclFC
	 SLHi58ZS3rMQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 1/3] printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
Date: Sun, 26 Jan 2025 09:57:15 -0500
Message-Id: <20250126145717.946866-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
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
index a8af93cbc2936..3a7fd61c0e7be 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -420,7 +420,7 @@ static u64 clear_seq;
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


