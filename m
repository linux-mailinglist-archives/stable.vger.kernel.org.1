Return-Path: <stable+bounces-61556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F58E93C4E7
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70DA1F2126E
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EED19D087;
	Thu, 25 Jul 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bVP/FJwu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668319CD11;
	Thu, 25 Jul 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918696; cv=none; b=Zc0f2TZQyyI6JJSvGmbwKfC82CwOhcaJkgsPzDBCVOgeU8iGG8DnbsH9XYZcHjqE0w+iyMoqsTUAYHQgiCZtECfZcAvWUxmhHAUNY/LqnEm+AaXKnT8GY2RxVKle1fYFf4WOaetN7HZ3nwqIFNGcgZYriwEQzHmymamGIcMbg50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918696; c=relaxed/simple;
	bh=8I0vLTJt/pFL/mIM9E0OafyeNUbK2EOG5k2vnU0Uwjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyMIIJFkXNEZkK63PeN+TMaZD9Bg7nrBaTX5G/UbeYoBrZFfI0W1w9r4SuSqtrYjM3UrxMzP1GgYLWT5pEzrAfw2Q61GYbK+fEp5oXhmRb1kC9k3pgvMkZWpE+iZhQVXXZA0/4GpQaQXhpUQkdcVxVkVAxbXWT06+MiPhi1pQto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bVP/FJwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A07C116B1;
	Thu, 25 Jul 2024 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721918696;
	bh=8I0vLTJt/pFL/mIM9E0OafyeNUbK2EOG5k2vnU0Uwjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVP/FJwuycIKR/0vla+DlWdmREtZaD88pnXHUO/6ZsuC8z5QSB9YestNZLypFuagi
	 8585C+WiZVfDPObFb9mRbdiLtEap0mZlWFNxF3KI27t3cUo5YAiLc627cHg5eOh+6L
	 Lxq8HuRws1Bp9oUnb7BsOTUO41nCCtOE+jsScTRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.1 12/13] filelock: Fix fcntl/close race recovery compat path
Date: Thu, 25 Jul 2024 16:37:21 +0200
Message-ID: <20240725142728.503993036@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725142728.029052310@linuxfoundation.org>
References: <20240725142728.029052310@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit f8138f2ad2f745b9a1c696a05b749eabe44337ea upstream.

When I wrote commit 3cad1bc01041 ("filelock: Remove locks reliably when
fcntl/close race is detected"), I missed that there are two copies of the
code I was patching: The normal version, and the version for 64-bit offsets
on 32-bit kernels.
Thanks to Greg KH for stumbling over this while doing the stable
backport...

Apply exactly the same fix to the compat path for 32-bit kernels.

Fixes: c293621bbf67 ("[PATCH] stale POSIX lock handling")
Cc: stable@kernel.org
Link: https://bugs.chromium.org/p/project-zero/issues/detail?id=2563
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/r/20240723-fs-lock-recover-compatfix-v1-1-148096719529@google.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/locks.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2516,8 +2516,9 @@ int fcntl_setlk64(unsigned int fd, struc
 	error = do_lock_file_wait(filp, cmd, file_lock);
 
 	/*
-	 * Attempt to detect a close/fcntl race and recover by releasing the
-	 * lock that was just acquired. There is no need to do that when we're
+	 * Detect close/fcntl races and recover by zapping all POSIX locks
+	 * associated with this file and our files_struct, just like on
+	 * filp_flush(). There is no need to do that when we're
 	 * unlocking though, or for OFD locks.
 	 */
 	if (!error && file_lock->fl_type != F_UNLCK &&
@@ -2532,9 +2533,7 @@ int fcntl_setlk64(unsigned int fd, struc
 		f = files_lookup_fd_locked(files, fd);
 		spin_unlock(&files->file_lock);
 		if (f != filp) {
-			file_lock->fl_type = F_UNLCK;
-			error = do_lock_file_wait(filp, cmd, file_lock);
-			WARN_ON_ONCE(error);
+			locks_remove_posix(filp, files);
 			error = -EBADF;
 		}
 	}



