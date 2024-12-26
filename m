Return-Path: <stable+bounces-106138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA649FCA73
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 12:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B61B7A05CB
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D9B1C5F08;
	Thu, 26 Dec 2024 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="H7AX4nN4"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A376A1D1F56
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735211722; cv=none; b=RjoPbPF4eO0sod2dm2ovA8vTbrJIbHUB6gYJvyJ+RgU2G1KKobXc233f8FnJd8TuZ6MY7nQ5+vLGymSu/RdNcNtN5heGxWJgls2PTG8StumCjOmzKhva9d2tGosybi4FCI/LpRHI4NIzJ6hRJ0F488kYzN0mXEqpwq6Wce63J2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735211722; c=relaxed/simple;
	bh=tz+wnvRFemD3tOoI3cO6ZP/52YBGteSX+tthqqNWdW8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EuvjG+BY8zR2XvZ2boWnPFX9DPscJgilsrw0E5snQ3rqdqcuULlIXOZLztTaLC8wPV8ELD7UWr7WDUKUakOn3Lmxf6swFL8jCcBwFDi8OnUwG64KH+zDArxJpbDQndwslbQvQ5Ank774ptVU+UMCshZaQjKvIT9mRPPy7p+fuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=H7AX4nN4; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wubPE
	O4XwNJm22CSvtslfS2CJDyvwebUzxe9kr21W8M=; b=H7AX4nN4kI3GQRJw5n/Tz
	dqL42ke0pp1JFdojMxGNIrh29z675mtyCcuzoiiqGKdIAomuvddV17psn4giuv+u
	YPLPQ78zeaXcofhGshsuPGBlZpRAFUCsNlvaojjBLeUXGVBzkfgSdeKr+PcE8BWz
	gsqnOLleyf6Mq90suCMvLc=
Received: from pek-blan-cn-l1.corp.ad.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnT9iWOm1nZ3VNBw--.3285S2;
	Thu, 26 Dec 2024 19:14:45 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: stable@vger.kernel.org,
	xuewen.yan@unisoc.com,
	jing.xia@unisoc.com
Subject: [PATCH 5.4.y v2] epoll: Add synchronous wakeup support for ep_poll_callback
Date: Thu, 26 Dec 2024 19:14:29 +0800
Message-Id: <20241226111429.12499-1-jetlan9@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024122326-viscous-dreaded-d15d@gregkh>
References: <2024122326-viscous-dreaded-d15d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnT9iWOm1nZ3VNBw--.3285S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1fAw45AF1xuw47KrW3Wrg_yoW8tw4UpF
	45WFnYqrWrWrWUtrZ5Xr4xuF9rWan5WwnxCrWDu3WUCr17G3WFy34IvFsxAF4vvrZYkFW5
	Aas3ZFn3ua1UJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6GQgUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/1tbiDw-ByGdtM-Sb5gAAs5

From: Xuewen Yan <xuewen.yan@unisoc.com>

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
(cherry picked from commit 900bbaae67e980945dec74d36f8afe0de7556d5a)
[ Redefine wake_up_sync(x) as __wake_up_sync(x, TASK_NORMAL, 1) to
  make it work on 5.4.y ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
v2: CC the related persons

 fs/eventpoll.c       | 5 ++++-
 include/linux/wait.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8c0e94183186..569bfff280e4 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1273,7 +1273,10 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
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
index 03bff85e365f..5b65f720261a 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -213,6 +213,7 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
 #define wake_up_all(x)			__wake_up(x, TASK_NORMAL, 0, NULL)
 #define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL, 1)
 #define wake_up_all_locked(x)		__wake_up_locked((x), TASK_NORMAL, 0)
+#define wake_up_sync(x)			__wake_up_sync(x, TASK_NORMAL, 1)
 
 #define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
-- 
2.43.0


