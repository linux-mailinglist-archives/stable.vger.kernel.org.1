Return-Path: <stable+bounces-112984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD69A28F79
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F773AA64A
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD00155333;
	Wed,  5 Feb 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DXghtQD6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B68314F136;
	Wed,  5 Feb 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765428; cv=none; b=pZv8cIB/A0xmLbdMdSwRBZV60HxnIV0Fl0lUFM3v7tls4Q5I4cHlhlAnv01aIi0+enED604J2USs8VYZk9sYu9MT4/1/NoKUt3rP1TxBdtismrPHhVBL9gas7ALVcfqMRKLQGKUbgyxgFN7ytiRiL+9ChnkbngwHqouLSg6/pz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765428; c=relaxed/simple;
	bh=Abbz0biAIwnfDkzOh0EEY2IpyHPh+iYUNTUMaO7UwMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcQePXHBEnLZ5/t1miSGqNWQEg5GsJPG3SpO7hXxIv/ezKJKNxl1hOl14H0jFgbvIZ7cw+I1cwAflgBSgICLm1XSqvTeYFD7lASEnq6cav5AsjBd4cG7rLfbB7m8jLTlJMRGbfT+hJatQzQNEbTugX8u0wKC8uggmTugtpzn11k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DXghtQD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B71AC4CED1;
	Wed,  5 Feb 2025 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765427;
	bh=Abbz0biAIwnfDkzOh0EEY2IpyHPh+iYUNTUMaO7UwMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXghtQD6jRyxu/c0M7iz8AaZdl/JYEmk1QdP6rzgfKF50//mSxjEYN5GqyXvMFkyE
	 I77NPeV/WhZLhQyrorRwfTQGYCvL0V2bPVdEGGJ0LXJuwzBJfKUF1n9LcDXXIMdJAN
	 5KDlNA+3ahfBBSj3AGGZNB03GCTVhWk+GU4JE4zs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Chinner <david@fromorbit.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Paul Moore <paul@paul-moore.com>,
	syzbot+34b68f850391452207df@syzkaller.appspotmail.com,
	syzbot+360866a59e3c80510a62@syzkaller.appspotmail.com,
	Ubisectech Sirius <bugreport@ubisectech.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 177/623] landlock: Handle weird files
Date: Wed,  5 Feb 2025 14:38:39 +0100
Message-ID: <20250205134503.005919459@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mickaël Salaün <mic@digikod.net>

[ Upstream commit 49440290a0935f428a1e43a5ac8dc275a647ff80 ]

A corrupted filesystem (e.g. bcachefs) might return weird files.
Instead of throwing a warning and allowing access to such file, treat
them as regular files.

Cc: Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Paul Moore <paul@paul-moore.com>
Reported-by: syzbot+34b68f850391452207df@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/000000000000a65b35061cffca61@google.com
Reported-by: syzbot+360866a59e3c80510a62@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/67379b3f.050a0220.85a0.0001.GAE@google.com
Reported-by: Ubisectech Sirius <bugreport@ubisectech.com>
Closes: https://lore.kernel.org/r/c426821d-8380-46c4-a494-7008bbd7dd13.bugreport@ubisectech.com
Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
Reviewed-by: Günther Noack <gnoack3000@gmail.com>
Link: https://lore.kernel.org/r/20250110153918.241810-1-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/landlock/fs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index e31b97a9f175a..7adb25150488f 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -937,10 +937,6 @@ static access_mask_t get_mode_access(const umode_t mode)
 	switch (mode & S_IFMT) {
 	case S_IFLNK:
 		return LANDLOCK_ACCESS_FS_MAKE_SYM;
-	case 0:
-		/* A zero mode translates to S_IFREG. */
-	case S_IFREG:
-		return LANDLOCK_ACCESS_FS_MAKE_REG;
 	case S_IFDIR:
 		return LANDLOCK_ACCESS_FS_MAKE_DIR;
 	case S_IFCHR:
@@ -951,9 +947,12 @@ static access_mask_t get_mode_access(const umode_t mode)
 		return LANDLOCK_ACCESS_FS_MAKE_FIFO;
 	case S_IFSOCK:
 		return LANDLOCK_ACCESS_FS_MAKE_SOCK;
+	case S_IFREG:
+	case 0:
+		/* A zero mode translates to S_IFREG. */
 	default:
-		WARN_ON_ONCE(1);
-		return 0;
+		/* Treats weird files as regular files. */
+		return LANDLOCK_ACCESS_FS_MAKE_REG;
 	}
 }
 
-- 
2.39.5




