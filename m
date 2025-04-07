Return-Path: <stable+bounces-128651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA63DA7EA22
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72191889DF3
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5A525E44C;
	Mon,  7 Apr 2025 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6qZ/5Ld"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6706F252903;
	Mon,  7 Apr 2025 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049594; cv=none; b=jXJIkHXwSdzL4z1ZqnYeB4s8ZkolOTPDV5zJeSoL+E3XNE3XgoCzOMA9B0mOvfcEy3COxelnAWA62sr9Qa8covPU79y0P0mfRGrd1Y+KvrAMulh09xLsL4OFdj1vAbrUDm1sAwX8pGkd85xplY6XJVQ+FlI+2hc3CymTWzQolcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049594; c=relaxed/simple;
	bh=gU6hkKGDdvk7K7dSuye72CQjJX8W0AKAn4D7NbahrSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vt7kM5Bob6BQesD7z+MmT2A5viIfP8mDRKJsStL/yHUn/j5jx0MeIs7WVX8UbHva+hvDlrBSVEyrhnuXDxSFyymzNNTPbMK3kG5eG+oa8WJo/2dexFmrptRhTL7dKPL2sTtz3hvWNGVGXvGVHhaNC+LFPKdjAvOwerTb+Irqm3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6qZ/5Ld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA71C4CEDD;
	Mon,  7 Apr 2025 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049594;
	bh=gU6hkKGDdvk7K7dSuye72CQjJX8W0AKAn4D7NbahrSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R6qZ/5Ld/fDycCih2uw2tHkJ1sss8iltjm2MRdOqRlzA2mF/jkAr7S3O/S4uPNy4J
	 nCgvjZueOI3lv7oPWgqAUc9z58hK0aplvfJqg3iUMRbliNqzpzi9NpvPz4g3E6S5Io
	 cOGj2fm/r5lk91rE+vcnco0nnreVwwCf2p8CC7rupPtMCaBBhwCBJnvk71eag9T2k0
	 DO92sC2Rqd+ju052U/WvVbpKXCoway7/XI/Q+lZAJEtb8ematgl1U+hEx+R+8bv+2b
	 GGGOv7i7RpA860rzL/V3r5NyvC/6pkQmbFiYuhyTyz98g05GGtRyHZ8hp9LUVeaCmD
	 MyvnxnBJuswrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 22/28] um: Switch to the pthread-based helper in sigio workaround
Date: Mon,  7 Apr 2025 14:12:12 -0400
Message-Id: <20250407181224.3180941-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181224.3180941-1-sashal@kernel.org>
References: <20250407181224.3180941-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
Content-Transfer-Encoding: 8bit

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit d295beeed2552a987796d627ba7d0985b1e2d72f ]

The write_sigio thread and UML kernel thread share the same errno,
which can lead to conflicts when both call syscalls concurrently.
Switch to the pthread-based helper to address this issue.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20250319135523.97050-4-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/os-Linux/sigio.c | 44 +++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 9aac8def4d635..61b348a2ea974 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -21,8 +21,7 @@
  * Protected by sigio_lock(), also used by sigio_cleanup, which is an
  * exitcall.
  */
-static int write_sigio_pid = -1;
-static unsigned long write_sigio_stack;
+static struct os_helper_thread *write_sigio_td;
 
 /*
  * These arrays are initialized before the sigio thread is started, and
@@ -48,15 +47,15 @@ static struct pollfds current_poll;
 static struct pollfds next_poll;
 static struct pollfds all_sigio_fds;
 
-static int write_sigio_thread(void *unused)
+static void *write_sigio_thread(void *unused)
 {
 	struct pollfds *fds, tmp;
 	struct pollfd *p;
 	int i, n, respond_fd;
 	char c;
 
-	os_set_pdeathsig();
-	os_fix_helper_signals();
+	os_fix_helper_thread_signals();
+
 	fds = &current_poll;
 	while (1) {
 		n = poll(fds->poll, fds->used, -1);
@@ -98,7 +97,7 @@ static int write_sigio_thread(void *unused)
 		}
 	}
 
-	return 0;
+	return NULL;
 }
 
 static int need_poll(struct pollfds *polls, int n)
@@ -152,11 +151,10 @@ static void update_thread(void)
 	return;
  fail:
 	/* Critical section start */
-	if (write_sigio_pid != -1) {
-		os_kill_process(write_sigio_pid, 1);
-		free_stack(write_sigio_stack, 0);
+	if (write_sigio_td) {
+		os_kill_helper_thread(write_sigio_td);
+		write_sigio_td = NULL;
 	}
-	write_sigio_pid = -1;
 	close(sigio_private[0]);
 	close(sigio_private[1]);
 	close(write_sigio_fds[0]);
@@ -220,7 +218,7 @@ int __ignore_sigio_fd(int fd)
 	 * sigio_cleanup has already run, then update_thread will hang
 	 * or fail because the thread is no longer running.
 	 */
-	if (write_sigio_pid == -1)
+	if (!write_sigio_td)
 		return -EIO;
 
 	for (i = 0; i < current_poll.used; i++) {
@@ -279,14 +277,14 @@ static void write_sigio_workaround(void)
 	int err;
 	int l_write_sigio_fds[2];
 	int l_sigio_private[2];
-	int l_write_sigio_pid;
+	struct os_helper_thread *l_write_sigio_td;
 
 	/* We call this *tons* of times - and most ones we must just fail. */
 	sigio_lock();
-	l_write_sigio_pid = write_sigio_pid;
+	l_write_sigio_td = write_sigio_td;
 	sigio_unlock();
 
-	if (l_write_sigio_pid != -1)
+	if (l_write_sigio_td)
 		return;
 
 	err = os_pipe(l_write_sigio_fds, 1, 1);
@@ -312,7 +310,7 @@ static void write_sigio_workaround(void)
 	 * Did we race? Don't try to optimize this, please, it's not so likely
 	 * to happen, and no more than once at the boot.
 	 */
-	if (write_sigio_pid != -1)
+	if (write_sigio_td)
 		goto out_free;
 
 	current_poll = ((struct pollfds) { .poll 	= p,
@@ -325,18 +323,15 @@ static void write_sigio_workaround(void)
 	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
 	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
 
-	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
-					    CLONE_FILES | CLONE_VM,
-					    &write_sigio_stack);
-
-	if (write_sigio_pid < 0)
+	err = os_run_helper_thread(&write_sigio_td, write_sigio_thread, NULL);
+	if (err < 0)
 		goto out_clear;
 
 	sigio_unlock();
 	return;
 
 out_clear:
-	write_sigio_pid = -1;
+	write_sigio_td = NULL;
 	write_sigio_fds[0] = -1;
 	write_sigio_fds[1] = -1;
 	sigio_private[0] = -1;
@@ -394,12 +389,11 @@ void maybe_sigio_broken(int fd)
 
 static void sigio_cleanup(void)
 {
-	if (write_sigio_pid == -1)
+	if (!write_sigio_td)
 		return;
 
-	os_kill_process(write_sigio_pid, 1);
-	free_stack(write_sigio_stack, 0);
-	write_sigio_pid = -1;
+	os_kill_helper_thread(write_sigio_td);
+	write_sigio_td = NULL;
 }
 
 __uml_exitcall(sigio_cleanup);
-- 
2.39.5


