Return-Path: <stable+bounces-102845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8868A9EF46E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819CD16CA4D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA822210DB;
	Thu, 12 Dec 2024 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ftl3SvGq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883312210E3;
	Thu, 12 Dec 2024 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022703; cv=none; b=sVgLJRwrI0HLHS+PXUenh/7sLJDyeIL9g3emATvN+fobetTEntU1I6stgLldup52w2eAIM6xZOVJWdBVkOEGGLN1U/4+bkiwByztflJso+9Knvw2wFILv7wh9S/6rSIwOAoOLGjHX+ls+Zl2N4PR7kH4RMzksLvyDJJ0Aa8hKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022703; c=relaxed/simple;
	bh=jbkNRr247k4/uXyo74cMburn1Uih6Qo3B/6MkQpox30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hw/oopdCpBN9FC04NZQ1v6hXIvrSaNwzJUcUMMwq8RntpWxMjLwfZlrt9r45NjGWfANZjA0bR9bZl4ItXCSVP2+X3EvtuyNE8yvSMswj3uob8GJ9qwOODmX3PuvRJK9gKvDSfG5R9Zd5W1DTiHoxkMiKQIwv/Wl/ZJbFY4cybKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ftl3SvGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB75C4CECE;
	Thu, 12 Dec 2024 16:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022703;
	bh=jbkNRr247k4/uXyo74cMburn1Uih6Qo3B/6MkQpox30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ftl3SvGqFOEVxk3V5LfAdg2gPkQRaBccTSkKthBTY8Q+iepIaGNuy8Kp953xRzOSy
	 CCvfqjZYWXEg8xWNRfj8ep8wzoGWEt5D9tuuVMBwYlVs2ccwKFqcZ8ePAHCu0SsWSr
	 cdBc+lizLnApH6ybczggcWk9LTp5Wd25y5GF+JEQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 5.15 313/565] fsnotify: fix sending inotify event with unexpected filename
Date: Thu, 12 Dec 2024 15:58:28 +0100
Message-ID: <20241212144323.980153697@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit aa52c54da40d9eee3ba87c05cdcb0cd07c04fa13 upstream.

We got a report that adding a fanotify filsystem watch prevents tail -f
from receiving events.

Reproducer:

1. Create 3 windows / login sessions. Become root in each session.
2. Choose a mounted filesystem that is pretty quiet; I picked /boot.
3. In the first window, run: fsnotifywait -S -m /boot
4. In the second window, run: echo data >> /boot/foo
5. In the third window, run: tail -f /boot/foo
6. Go back to the second window and run: echo more data >> /boot/foo
7. Observe that the tail command doesn't show the new data.
8. In the first window, hit control-C to interrupt fsnotifywait.
9. In the second window, run: echo still more data >> /boot/foo
10. Observe that the tail command in the third window has now printed
the missing data.

When stracing tail, we observed that when fanotify filesystem mark is
set, tail does get the inotify event, but the event is receieved with
the filename:

read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\20\0\0\0foo\0\0\0\0\0\0\0\0\0\0\0\0\0",
50) = 32

This is unexpected, because tail is watching the file itself and not its
parent and is inconsistent with the inotify event received by tail when
fanotify filesystem mark is not set:

read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0", 50) = 16

The inteference between different fsnotify groups was caused by the fact
that the mark on the sb requires the filename, so the filename is passed
to fsnotify().  Later on, fsnotify_handle_event() tries to take care of
not passing the filename to groups (such as inotify) that are interested
in the filename only when the parent is watching.

But the logic was incorrect for the case that no group is watching the
parent, some groups are watching the sb and some watching the inode.

Reported-by: Miklos Szeredi <miklos@szeredi.hu>
Fixes: 7372e79c9eb9 ("fanotify: fix logic of reporting name info with watched parent")
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/notify/fsnotify.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -310,16 +310,19 @@ static int fsnotify_handle_event(struct
 	if (!inode_mark)
 		return 0;
 
-	if (mask & FS_EVENT_ON_CHILD) {
-		/*
-		 * Some events can be sent on both parent dir and child marks
-		 * (e.g. FS_ATTRIB).  If both parent dir and child are
-		 * watching, report the event once to parent dir with name (if
-		 * interested) and once to child without name (if interested).
-		 * The child watcher is expecting an event without a file name
-		 * and without the FS_EVENT_ON_CHILD flag.
-		 */
-		mask &= ~FS_EVENT_ON_CHILD;
+	/*
+	 * Some events can be sent on both parent dir and child marks (e.g.
+	 * FS_ATTRIB).  If both parent dir and child are watching, report the
+	 * event once to parent dir with name (if interested) and once to child
+	 * without name (if interested).
+	 *
+	 * In any case regardless whether the parent is watching or not, the
+	 * child watcher is expecting an event without the FS_EVENT_ON_CHILD
+	 * flag. The file name is expected if and only if this is a directory
+	 * event.
+	 */
+	mask &= ~FS_EVENT_ON_CHILD;
+	if (!(mask & ALL_FSNOTIFY_DIRENT_EVENTS)) {
 		dir = NULL;
 		name = NULL;
 	}



