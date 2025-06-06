Return-Path: <stable+bounces-151717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A71AD0624
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 17:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C7D188AF07
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 15:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4440728A1E2;
	Fri,  6 Jun 2025 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGqFH4ZL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31AE288CB7;
	Fri,  6 Jun 2025 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224677; cv=none; b=k59api/5joUWKiWrVI/M6OEOdWO8dkGvog4rCo4BCzw8s6DkF2bbXO5keXHznvoxq14wx8pQCCkorvWa1ZoDy59EBO9Ft2tdb5F1loNsAXsTtghRPN5eqpoe/8rlWXiRSoUqY6j3q96JIVxwv+tjXLYIqZQ+szx0xqNFvSUgHP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224677; c=relaxed/simple;
	bh=4hZWSSBiBmXgCZRjHUQHX6vSbzo+EvjVtjI/uIdFtzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nW1vS6bHMnTWys2YOrB8ecQigEclYimuNTa7rwpUPz7hYZ8SHsaSwzftaaozYT24j2m61Z1W9YGg74XDHNl4CCACfPeTk5WSK1Xg6LA/imu3fC/BgBafSCc94zRB/i3t483EuVsgTPOQFxl/ivstd8KzQVFPjDfd+si+5bq/8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGqFH4ZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CD5C4CEF0;
	Fri,  6 Jun 2025 15:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749224676;
	bh=4hZWSSBiBmXgCZRjHUQHX6vSbzo+EvjVtjI/uIdFtzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pGqFH4ZLFN96FnGqa80FLFze15Fnb7Lv+LiHilorHz0kgobniy+su4n/3P/fnfoU8
	 myTeLm+6UK4RzQUUGCcKB1aWt0OkjKehTEqc70YAzeMJp1QPYNBxZQo0JPuV1irRH2
	 exMdKfPqik7bpsRFrodUQWxwQWZdqSiCCDbW34Uc0XtREMMcjQDSeDulw5Vt6h6XMh
	 rGVGdsY2j1U+JA5sQn9xBhod0Mqk2W8dh2MA2/e3igJfctJLqkJrBYiTl0P0f8s0BV
	 BrDN6IEwyjemnkUGd206BJf0/0HVVAijXSV/QZJvDN98iouFQLFplqMXSn2q/SyRme
	 xILYqNGzOCjUw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/3] mailbox: Not protect module_put with spin_lock_irqsave
Date: Fri,  6 Jun 2025 11:44:31 -0400
Message-Id: <20250606154433.548697-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250606154433.548697-1-sashal@kernel.org>
References: <20250606154433.548697-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.294
Content-Transfer-Encoding: 8bit

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit dddbd233e67e792bb0a3f9694a4707e6be29b2c6 ]

&chan->lock is not supposed to protect 'chan->mbox'.
And in __mbox_bind_client, try_module_get is also not protected
by &chan->lock. So move module_put out of the lock protected
region.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees.
**Analysis:** 1. **Clear Bug Fix**: The commit fixes an improper use of
`module_put()` under a spinlock in `mbox_free_channel()`. Looking at the
current code in `/home/sasha/linux/drivers/mailbox/mailbox.c:489`,
`module_put()` is called while holding `&chan->lock` with
`spin_lock_irqsave()`. 2. **Locking Inconsistency**: The commit message
correctly identifies that `&chan->lock` is not supposed to protect
`chan->mbox`. In `__mbox_bind_client()` (line 324),
`try_module_get(chan->mbox->dev->driver->owner)` is called **outside**
the spinlock protection, making the current `module_put()` placement
inconsistent. 3. **Minimal Risk Change**: The fix is extremely simple
and low-risk - it just moves one line (`module_put()`) outside the
spinlock region. This maintains the same operation order but fixes the
locking issue. 4. **No Side Effects**: Moving `module_put()` outside the
lock doesn't change the functionality or introduce new race conditions.
The `module_put()` implementation uses `atomic_dec_if_positive()`, so
it's safe to call without additional locking. 5. **Follows Stable
Rules**: This commit: - Fixes a real locking issue that could
potentially cause problems - Is small and contained (single line move) -
Has minimal regression risk - Doesn't introduce new features or
architectural changes 6. **Similar Pattern**: Looking at similar commits
in the historical references, commits that fix locking issues (like
Similar Commit #5 which fixed a locking bug in mailbox-test) were marked
as YES for backporting. The commit addresses a legitimate kernel locking
violation where `module_put()` should not be called under a spinlock,
making it a suitable candidate for stable tree backporting.

 drivers/mailbox/mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 6f54501dc7762..cb31ad917b352 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -459,8 +459,8 @@ void mbox_free_channel(struct mbox_chan *chan)
 	if (chan->txdone_method == TXDONE_BY_ACK)
 		chan->txdone_method = TXDONE_BY_POLL;
 
-	module_put(chan->mbox->dev->driver->owner);
 	spin_unlock_irqrestore(&chan->lock, flags);
+	module_put(chan->mbox->dev->driver->owner);
 }
 EXPORT_SYMBOL_GPL(mbox_free_channel);
 
-- 
2.39.5


