Return-Path: <stable+bounces-140556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385DEAAA9CC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C041758B5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FE72D6111;
	Mon,  5 May 2025 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTczwMtu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4427D3602EA;
	Mon,  5 May 2025 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485140; cv=none; b=e6LV5V5X/IVp9stVM5+Ycf9uH9F89gCzDbUravgu2VppxgphyPliT5FKPO/UZjwwXUdY38VTHxJHjug+Bw1wAoOyg/OqqdlsvraiXIXQrtRCFsh7sc4UL5t9TsegkgNq7wu+IDhHUvHYH9OQTfam35DQjI9D4uzfKOAooejJE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485140; c=relaxed/simple;
	bh=eYnGd+MTzDvMbzNFHVf56BTjUQYAvOdN/Fe7fP7U1Ng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AOHSe7B5c+zJuMIFbz21N85LqYJQLTp5L1SVcB5dFLGHtkCwFTNUoZExXGNljQml5fIvTah7e26FImWu3GKvtvPwFR+sQ7KZxgf9jYgfeAYRhSFeUSiDAgt5T6wxV+OdBYq/XrlEHHXHsL9LaxyYCzK6aiP0z/hbKcXZX8sHBnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTczwMtu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3016BC4CEE4;
	Mon,  5 May 2025 22:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485139;
	bh=eYnGd+MTzDvMbzNFHVf56BTjUQYAvOdN/Fe7fP7U1Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jTczwMtu4reIKvifyS6T6azBVyFJ/6FluxGW2jAZZMxCwLyMRL8mrecuLMjkewk2b
	 SpQc6OaYgJmgfE3wDS2akbnkJR8985PmMCeyXXEDUlvyLjdf/Bo0An4KP7IGAWznZl
	 uER3owoczs/6iSTeJuiJLzP22Y8D8WcxjE/hWT40FY1CVb89n7E0RAcMIiOzyBSnID
	 HD6D9c/lSnA8wP2x2+QwAAhq1iljbZIbdZ3DrAHWdf8Q/od550bcY1bUkfXF03HwAT
	 ICNUQdHG/td/B5K6HLVr68ipglzpjsHptUTSwxPs7oBkajJRoh8/QiqWO9k7mEWuk/
	 uEl2TIVJ1BNRw==
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
Subject: [PATCH AUTOSEL 6.12 179/486] ALSA: seq: Improve data consistency at polling
Date: Mon,  5 May 2025 18:34:15 -0400
Message-Id: <20250505223922.2682012-179-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index b30faf731da72..067bf531e6b5f 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1150,8 +1150,7 @@ static __poll_t snd_seq_poll(struct file *file, poll_table * wait)
 	if (snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_OUTPUT) {
 
 		/* check if data is available in the pool */
-		if (!snd_seq_write_pool_allocated(client) ||
-		    snd_seq_pool_poll_wait(client->pool, file, wait))
+		if (snd_seq_pool_poll_wait(client->pool, file, wait))
 			mask |= EPOLLOUT | EPOLLWRNORM;
 	}
 
@@ -2569,8 +2568,6 @@ int snd_seq_kernel_client_write_poll(int clientid, struct file *file, poll_table
 	if (client == NULL)
 		return -ENXIO;
 
-	if (! snd_seq_write_pool_allocated(client))
-		return 1;
 	if (snd_seq_pool_poll_wait(client->pool, file, wait))
 		return 1;
 	return 0;
diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index 20155e3e87c6a..ccde0ca3d2082 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -427,6 +427,7 @@ int snd_seq_pool_poll_wait(struct snd_seq_pool *pool, struct file *file,
 			   poll_table *wait)
 {
 	poll_wait(file, &pool->output_sleep, wait);
+	guard(spinlock_irq)(&pool->lock);
 	return snd_seq_output_ok(pool);
 }
 
-- 
2.39.5


