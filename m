Return-Path: <stable+bounces-99740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D3C9E7329
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB92188808E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3375220A5E5;
	Fri,  6 Dec 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yglfhrw1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EFD207E13;
	Fri,  6 Dec 2024 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498195; cv=none; b=PMyFgvj8pCZ5B4Ru/3LOTXm6Vv0GooIr6KPyPJWSJE16Ct39gHgt9zd/1FuL52kz+VeE+f77Bo/ZzPqvmgajgjiRoMIEbd+QZQ+Ozo/wql/bPL5DE2nn3+gjhDYj/c8u68WmiYwx5Af6JyEJQ1vge7dgerVLKISWZ/7kpCnJ+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498195; c=relaxed/simple;
	bh=M+8aybJ8mIsG1yV9h9LkC7Ry8ibAzbGWsJN9xlZTcl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsvAv7U/jW5gH5x+cNFpsdj9oVvn2EE5XWG9FWuS5gyLPZ6LCDmd+710xOJzwHhs2eMVxW85vUCZay2oJHXVIm5mXJbPrW4pA+rLUWy5IVoWn1LnLZdz6Ckrv/a4VhgZNTS1R8UmcDMolR+CvvnncndXz1Gwr8kyfNCWtWc0gH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yglfhrw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB604C4CEDE;
	Fri,  6 Dec 2024 15:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733498194;
	bh=M+8aybJ8mIsG1yV9h9LkC7Ry8ibAzbGWsJN9xlZTcl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yglfhrw1yWavEFXDEY4ZGe55ejymAfhzfnAg8RzozIYxxcmhdo7VPzszE+IWKLvl6
	 AtW3ZmXga0ocHSRP8MDwf51x7ySsrME80BzDquKsa2Ani1S1hvlMZ3QiM1J1PZ7QGr
	 GgINm6NcxL/ySPcreliOrdhZRHSpV4XXHIBahx7c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 6.6 485/676] fsnotify: fix sending inotify event with unexpected filename
Date: Fri,  6 Dec 2024 15:35:04 +0100
Message-ID: <20241206143712.305926167@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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



