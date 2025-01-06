Return-Path: <stable+bounces-107506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C65A1A02C5D
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B5F3A61D0
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4991DED4C;
	Mon,  6 Jan 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YCcfHFHM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3E11DED46;
	Mon,  6 Jan 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178678; cv=none; b=LgufThN1xkL7zSOoXgtFs+s4FyFx3pODQPjVZ1MaX13Tu7MiwLuzT4dqb/9lYn9fX4gw1gRuQu8VHE4CUtBDgiQrg9jr9W8jXk4vP3ieezMWmhdTu/zEOgByUpuLQj5g1oWfkbVOvVMAuX/xT95wX/nIQZCQTcAy1MJPggpqgic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178678; c=relaxed/simple;
	bh=w1eM1FPwAiPoqmpkP6xClGVfmPtwrhBBUv/VAO7FsTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plV3c3t8JrSgjt4P6eBIbuhxVmglJRhhhJgigS7qKqARmtp8oR8rus06ggXB2bOGM/xCiUEbis83QFkx4CLKEXtspX9QCmMGBTcst7zs8DrN5zF5wv7mGuCaIfKygx66MCKiGJrmGj65Zol1R87A4Ydo842c8AFU37Z8lC+N+0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YCcfHFHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DE1C4CED2;
	Mon,  6 Jan 2025 15:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178678;
	bh=w1eM1FPwAiPoqmpkP6xClGVfmPtwrhBBUv/VAO7FsTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCcfHFHMFaDxRInVZ0wM5c85cddZjfuX122oYX55SMIepx5T0ZeOYdhAVSAxxEuWf
	 snkIFy8BM3NxFEE41iXvT42xKbhmbSKTfpwzfp8iFmbFeAaKQ/IcQ/nAy354xHLICT
	 lJiODHJFuxOpsuHTyBJsWbemwGsi9BSFiflDCk3o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jing Xia <jing.xia@unisoc.com>,
	Xuewen Yan <xuewen.yan@unisoc.com>,
	Brian Geffon <bgeffon@google.com>,
	Benoit Lize <lizeb@google.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.15 055/168] epoll: Add synchronous wakeup support for ep_poll_callback
Date: Mon,  6 Jan 2025 16:16:03 +0100
Message-ID: <20250106151140.541375193@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151138.451846855@linuxfoundation.org>
References: <20250106151138.451846855@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Xuewen Yan <xuewen.yan@unisoc.com>

commit 900bbaae67e980945dec74d36f8afe0de7556d5a upstream.

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
Cc: Brian Geffon <bgeffon@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/eventpoll.c       |    5 ++++-
 include/linux/wait.h |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1230,7 +1230,10 @@ static int ep_poll_callback(wait_queue_e
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
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -224,6 +224,7 @@ void __wake_up_pollfree(struct wait_queu
 #define wake_up_all(x)			__wake_up(x, TASK_NORMAL, 0, NULL)
 #define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL, 1)
 #define wake_up_all_locked(x)		__wake_up_locked((x), TASK_NORMAL, 0)
+#define wake_up_sync(x)			__wake_up_sync(x, TASK_NORMAL)
 
 #define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)



