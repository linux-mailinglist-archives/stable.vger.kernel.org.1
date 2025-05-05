Return-Path: <stable+bounces-140699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 784D3AAAAAA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A76F4A4167
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0B43984D0;
	Mon,  5 May 2025 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/EvOyeg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C912DBB03;
	Mon,  5 May 2025 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486010; cv=none; b=UT3F44UTbLiWuTR0WSozrc09WPbQexoocJo904aPBSdpUlyBrSDYqzq0ngjXogO64Lf34yh1kCkqdrWWh+3kNJ5xJ5XrzIVJ1peQ8e0nhq+TEvvXIRkdBaBzh27ZVyLaPVl86Ql43QN9h2Gkdfw9NmahVXY6mJz9B1eWckGn3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486010; c=relaxed/simple;
	bh=t0zjZdBFIP51RiNWky2D57ZxrQUtk0dHqwV6LRXsD7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GXIYJDMV44PXCde8dPoCsCDPVV1+zpGtadpl7UmMgI/maCXuemZ2eNy2e9HN28NVhPX+6U4WrucQnBV4E0UHu66TdbLxjuYFHAX/aqwy4oE3nfEXVLjNBljJXZ520/zTspcYEXUoqQ/Q3ytNBP3kXOPC3ww+BP2QQmmaLp5b9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/EvOyeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F64C4CEED;
	Mon,  5 May 2025 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486009;
	bh=t0zjZdBFIP51RiNWky2D57ZxrQUtk0dHqwV6LRXsD7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O/EvOyegtIW9H53F4lir1Fv6WsWGxA8CrWaJhTfIF8wOvat3lwQNRMjahGt1H1yyd
	 lkunlht2qWTRhR3o45Nv1vDtGKYTYhSugSyWO/imN2iNVa3xPXzMGsrOX0jtnO/Y+i
	 QqxyfHhUxeZT6f01+GE+rNoj31/Y+MrgaWbXj0sD8nSho04gtKbWWLlVHxgLITVLHE
	 FAI7l/hjEUb8Q+4p5slKZSYhD66e2Rp93Bpt4TED9Gv4k9kNboxfG/LKXUkdGpNDNu
	 jN9g1d7JCEqt8XUqPXBPLCuiD5H8oTrc71XgVWhjZOMNg7rZvklsAeTlrtnKdO9NJ6
	 i9a1nnimmhktQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	syzbot+2d373c9936c00d7e120c@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	viro@zeniv.linux.org.uk,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 107/294] ALSA: seq: Improve data consistency at polling
Date: Mon,  5 May 2025 18:53:27 -0400
Message-Id: <20250505225634.2688578-107-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit e3cd33ab17c33bd8f1a9df66ec83a15dd8f7afbb ]

snd_seq_poll() calls snd_seq_write_pool_allocated() that reads out a
field in client->pool object, while it can be updated concurrently via
ioctls, as reported by syzbot.  The data race itself is harmless, as
it's merely a poll() call, and the state is volatile.  OTOH, the read
out of poll object info from the caller side is fragile, and we can
leave it better in snd_seq_pool_poll_wait() alone.

A similar pattern is seen in snd_seq_kernel_client_write_poll(), too,
which is called from the OSS sequencer.

This patch drops the pool checks from the caller side and add the
pool->lock in snd_seq_pool_poll_wait() for better data consistency.

Reported-by: syzbot+2d373c9936c00d7e120c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/67c88903.050a0220.15b4b9.0028.GAE@google.com
Link: https://patch.msgid.link/20250307084246.29271-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_clientmgr.c | 5 +----
 sound/core/seq/seq_memory.c    | 1 +
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 6195fe9dda179..bc1338dc34851 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1155,8 +1155,7 @@ static __poll_t snd_seq_poll(struct file *file, poll_table * wait)
 	if (snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_OUTPUT) {
 
 		/* check if data is available in the pool */
-		if (!snd_seq_write_pool_allocated(client) ||
-		    snd_seq_pool_poll_wait(client->pool, file, wait))
+		if (snd_seq_pool_poll_wait(client->pool, file, wait))
 			mask |= EPOLLOUT | EPOLLWRNORM;
 	}
 
@@ -2570,8 +2569,6 @@ int snd_seq_kernel_client_write_poll(int clientid, struct file *file, poll_table
 	if (client == NULL)
 		return -ENXIO;
 
-	if (! snd_seq_write_pool_allocated(client))
-		return 1;
 	if (snd_seq_pool_poll_wait(client->pool, file, wait))
 		return 1;
 	return 0;
diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index b603bb93f8960..692860deec0c3 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -429,6 +429,7 @@ int snd_seq_pool_poll_wait(struct snd_seq_pool *pool, struct file *file,
 			   poll_table *wait)
 {
 	poll_wait(file, &pool->output_sleep, wait);
+	guard(spinlock_irq)(&pool->lock);
 	return snd_seq_output_ok(pool);
 }
 
-- 
2.39.5


