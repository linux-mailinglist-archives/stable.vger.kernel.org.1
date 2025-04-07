Return-Path: <stable+bounces-128622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C38DA7E9C6
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B67A67A43C6
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425F621C9F8;
	Mon,  7 Apr 2025 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH5rZBW6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E605A224252;
	Mon,  7 Apr 2025 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049520; cv=none; b=iFFOmyVJO7SB8+0hInaXWd6ZvU7gp/t3AEtTiGR1pvCfenMU7iiviweKuseyLF32faWs1mQuEze8goolVGmhqW0hp1V6jVZ6t98bbjFN+giXmQoZ5l6Tp1O0pzQ3Hnsr8Kqum5pRqQkNslwk330ItKNmkAVYCvdIhvKXWp6sCnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049520; c=relaxed/simple;
	bh=gU6hkKGDdvk7K7dSuye72CQjJX8W0AKAn4D7NbahrSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wy8asRzPXXw1nvG/Zp6vNaTYus+/ShrPCrrLymbyGVnVQRD34MD7L3HDHhnaimClAlRZauQet/jtc4jDUUh4RV7i2EmzEtGGcj6mRiUkLr094vQu4eOnBhyX7FB68KIRTFI2SFhGQvckEBKMcy5DVB5M8zh9cO1LxItHj2Qf39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH5rZBW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC00FC4CEDD;
	Mon,  7 Apr 2025 18:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049519;
	bh=gU6hkKGDdvk7K7dSuye72CQjJX8W0AKAn4D7NbahrSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XH5rZBW6srTSd+yJvhIe3cLRB8CQS9m9lhRenOm0atgLI2MKNEKO4g9bQOGgtLZON
	 mRhj3du3m+Py3okBA+cmDBMxt9lOOKEvZUdtagsUPROZie3Lu9P0srNFiuQm3N2/PR
	 CYiSUMkcO8koB6yUNejYRIt0qFNWwqseeR8BtTDR7ChBz/k+UO68CrK/+KRO2c8Xnu
	 Fl7WEApgITIvR8kZD+T4YLSAU3qUAjVDfdwOyUEGiju855+xlfN/OlrER75QUUQDVc
	 fJxNicHVn2hwdqO8lNb3koRredYgpBLZAUSzkZtqPz0ptqeEEcYT+PoJb9wE7XfE3A
	 Q1A8dTqE29D5Q==
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
Subject: [PATCH AUTOSEL 6.14 25/31] um: Switch to the pthread-based helper in sigio workaround
Date: Mon,  7 Apr 2025 14:10:41 -0400
Message-Id: <20250407181054.3177479-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
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


