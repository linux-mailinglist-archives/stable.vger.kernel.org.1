Return-Path: <stable+bounces-105621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9294D9FAE57
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 13:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BA8163473
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DEF1A8F68;
	Mon, 23 Dec 2024 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Bp4Scgu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D335319DFB4
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734957870; cv=none; b=GaZlZCRacukmOo2RkrYIJZWqPYU5NIoZCipHqVI5qzqjZeD6Rh+33uBgvjFDDnZjbcZjED3FZQoDA2RsbqHEXhh50dB1saj5fQYhDQAWI7j1bpu6wtL9J9qDAsDw/QWBHPetDHnb6lNY0SKQhiJ5Ep5f1kfAHn9MtEc09vb8nss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734957870; c=relaxed/simple;
	bh=XWXpQfhUDF8FHfoA0lcTCqHxx0uMrD+cuAUnA4RwgwM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IPHq9zc1Fa13UsmoyGEUDJq2oOP+S8zcxJC8xGBsNLQI2NlDiP1uHpvESPbiCaFQaNeqzZa4A4ggU1gAwcnvtrhwIl+C5VeFbjAo/x56SrzbQMoWHDNAD+kKOyCnNwZBDOTB4sbpN3K/reDx3UcrQLzvnNUTkcDi/K0IwipTOPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Bp4Scgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE97CC4CED3;
	Mon, 23 Dec 2024 12:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734957870;
	bh=XWXpQfhUDF8FHfoA0lcTCqHxx0uMrD+cuAUnA4RwgwM=;
	h=Subject:To:Cc:From:Date:From;
	b=1Bp4Scgu7H+AtTy17EKtklyvserGmVO4mnRveIHjKocc9qMNRwqRj6Q48n57hrJqx
	 moegk0FFxv8dBtVsdIfVA8RC7jcnLVvR8SQvw5fXeIhyDXpdmFceHHQHJ7OkwV1cbA
	 fzaStUMt9Li5Z0CKLuSnk4h2682FHqma4e1gzItQ=
Subject: FAILED: patch "[PATCH] epoll: Add synchronous wakeup support for ep_poll_callback" failed to apply to 5.4-stable tree
To: xuewen.yan@unisoc.com,bgeffon@google.com,brauner@kernel.org,jing.xia@unisoc.com,lizeb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 13:44:27 +0100
Message-ID: <2024122326-viscous-dreaded-d15d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 900bbaae67e980945dec74d36f8afe0de7556d5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122326-viscous-dreaded-d15d@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 900bbaae67e980945dec74d36f8afe0de7556d5a Mon Sep 17 00:00:00 2001
From: Xuewen Yan <xuewen.yan@unisoc.com>
Date: Fri, 26 Apr 2024 16:05:48 +0800
Subject: [PATCH] epoll: Add synchronous wakeup support for ep_poll_callback

Now, the epoll only use wake_up() interface to wake up task.
However, sometimes, there are epoll users which want to use
the synchronous wakeup flag to hint the scheduler, such as
Android binder driver.
So add a wake_up_sync() define, and use the wake_up_sync()
when the sync is true in ep_poll_callback().

Co-developed-by: Jing Xia <jing.xia@unisoc.com>
Signed-off-by: Jing Xia <jing.xia@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Link: https://lore.kernel.org/r/20240426080548.8203-1-xuewen.yan@unisoc.com
Tested-by: Brian Geffon <bgeffon@google.com>
Reviewed-by: Brian Geffon <bgeffon@google.com>
Reported-by: Benoit Lize <lizeb@google.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 90fbab6b6f03..1a06e462b6ef 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1373,7 +1373,10 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 				break;
 			}
 		}
-		wake_up(&ep->wq);
+		if (sync)
+			wake_up_sync(&ep->wq);
+		else
+			wake_up(&ep->wq);
 	}
 	if (waitqueue_active(&ep->poll_wait))
 		pwake++;
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 8aa3372f21a0..2b322a9b88a2 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -221,6 +221,7 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
 #define wake_up_all(x)			__wake_up(x, TASK_NORMAL, 0, NULL)
 #define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL, 1)
 #define wake_up_all_locked(x)		__wake_up_locked((x), TASK_NORMAL, 0)
+#define wake_up_sync(x)			__wake_up_sync(x, TASK_NORMAL)
 
 #define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)


