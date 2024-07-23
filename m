Return-Path: <stable+bounces-60802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A1B93A4DD
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 19:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17211F21825
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 17:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C571581F4;
	Tue, 23 Jul 2024 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5hiqh9S"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55A214C5A1;
	Tue, 23 Jul 2024 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755148; cv=none; b=XYiKZKC4EhlaDDbgm5fLo9cxF+P1E1jhoLMBGigsao1J4qZAnMab7cVqbqMLTNHcJ9Js0lUBVSWsHlLAXDLWCn/5czD0fFWDPkTb4s3bHiVPAJsH9dMqx//w52jvUjy82G7TZvUqh+jbDn3zW5Y66CtW98zXQY0+CUD0GJrGpxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755148; c=relaxed/simple;
	bh=9s5Vi5MZuDidTPxO2XHs1LBSd+mG/mBJsPBCN5ZhRso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HzeaeaGueSpasEqola23ooc8cj62VuivPudlML8eUIxIm+MQ/Z+z8lB/NX3l+eXAoQjAwi1qWPBoRoAHWVxuYhLk30+7EG0+9x0SSwBUOk4iyS9OCgUxantzyKvXZ/gq5yIZ59dNaZwlFRayUfCc37aIb4PwaFhwsYhIIvAqwm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5hiqh9S; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso782742a12.0;
        Tue, 23 Jul 2024 10:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721755146; x=1722359946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7PESp8ToMvs18L2DY1lc9MxMw8bEbHV0v8oTGSy6LMk=;
        b=T5hiqh9ShUZdjARLEpaMLZcI65gRZZ7cAWTcKSNxRQtbIDMTSmqYXvLq1nGuBSR0qI
         OvHU7/59GYlVs11OPnG1pCxlOloy05ghAXPpjzC4zuR5aALPCdzNxtysEa1NMzYg79/E
         MEzZOyYa4G9OweW7/k/o3gQSLP51vqI7SlXQBzujzWblYSD/SLDTns7HInZ40I/cpgCB
         mHywl6qvd3zEsPcPj1BVsFgX1XVwtt4oB0p5xmf6ZxbHf45jmLn4UM6bcrWOCC83aoP8
         eN+xZekbQ7mEy/btXRxswJo/UhSF3TUwLK4LjuGZaFn61jwjePhJNm79kOBWd2lYs+U/
         em0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721755146; x=1722359946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PESp8ToMvs18L2DY1lc9MxMw8bEbHV0v8oTGSy6LMk=;
        b=QA45ICRLk8T3bf9v0JD4NFodasYqd/r9t5phXHgBNHheR51/cUSr8Qbn0apZw28yvq
         INy9e507XX200xnxss2LLL/LOkKewrqaSpMGqtXlRg6kUl+PH3pECVkHuTcxqYq66y+P
         oCohW/brPdXkUqNdFsPlRFUcuPECEndi9qowLEFaoaiCjzeZ7r3kKSp4gT4EBUyjOsHa
         wbof0e6fm4OGMGoB3R3a5IUv2Pt/WYugppOLB4+pOI2fwRxoT3NqWWqxiEMa7mr3IQqe
         7DFy+DWN9wqDAu2qqfRei3VwV38J/W6SJi+whBsmTN8kgsCZUuZVmtoF/pfzh0gN4bXb
         0BTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXz6CoTpb1FvciJFXFTec4VaA6o2y9ZjFkzOtfYhWELn5bm+wPDxOtuGUOVhgNOtBCF+HWk7SZRhczfQPneU0iMuv8BaKZa+ca8Tw9dloauT8sS1kFwTK+L4+rwI1XOh8u435OGR0Oy26ZYB5mQqbNW7pYDv+PfPtv+yCa
X-Gm-Message-State: AOJu0YwZI+K6JgZRXs/6amygpbtzFhgsixP4IlpWGG2JwN7B5beK0STv
	iRiq8jSiAudpIriVtrsOEbpsE/fe4rCqBL4RbgpK7mvxxuTse+yB
X-Google-Smtp-Source: AGHT+IH/x0EB2OW34wSIoGSpIBNCX6QxTmCPilyFpkTLbvSMOGQPUxFAfFsR5aZVR1HBIrLkMPEiAA==
X-Received: by 2002:a17:90a:7841:b0:2c9:75c6:32dc with SMTP id 98e67ed59e1d1-2cd85c25249mr3762641a91.1.1721755146006;
        Tue, 23 Jul 2024 10:19:06 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb76a5fc6csm10705800a91.0.2024.07.23.10.19.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jul 2024 10:19:05 -0700 (PDT)
From: Yunseong Kim <yskelg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH] Bluetooth: hci_core: fix suspicious RCU usage in hci_conn_drop()
Date: Wed, 24 Jul 2024 02:17:57 +0900
Message-ID: <20240723171756.13755-2-yskelg@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protection from the queuing operation is achieved with an RCU read lock
to avoid calling 'queue_delayed_work()' after 'cancel_delayed_work()',
but this does not apply to 'hci_conn_drop()'.

commit deee93d13d38 ("Bluetooth: use hdev->workqueue when queuing
 hdev->{cmd,ncmd}_timer works")

The situation described raises concerns about suspicious RCU usage in a
corrupted context.

CPU 1                   CPU 2
 hci_dev_do_reset()
  synchronize_rcu()      hci_conn_drop()
  drain_workqueue()       <-- no RCU read protection during queuing. -->
                           queue_delayed_work()

It displays a warning message like the following

Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
=============================
WARNING: suspicious RCU usage
6.10.0-rc6-01340-gf14c0bb78769 #5 Not tainted
-----------------------------
net/mac80211/util.c:4000 RCU-list traversed in non-reader section!!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz-executor/798:
 #0: ffff800089a3de50 (rtnl_mutex){+.+.}-{4:4},
    at: rtnl_lock+0x28/0x40 net/core/rtnetlink.c:79

stack backtrace:
CPU: 0 PID: 798 Comm: syz-executor Not tainted
  6.10.0-rc6-01340-gf14c0bb78769 #5
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace.part.0+0x1b8/0x1d0 arch/arm64/kernel/stacktrace.c:317
 dump_backtrace arch/arm64/kernel/stacktrace.c:323 [inline]
 show_stack+0x34/0x50 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xf0/0x170 lib/dump_stack.c:114
 dump_stack+0x20/0x30 lib/dump_stack.c:123
 lockdep_rcu_suspicious+0x204/0x2f8 kernel/locking/lockdep.c:6712
 ieee80211_check_combinations+0x71c/0x828 [mac80211]
 ieee80211_check_concurrent_iface+0x494/0x700 [mac80211]
 ieee80211_open+0x140/0x238 [mac80211]
 __dev_open+0x270/0x498 net/core/dev.c:1474
 __dev_change_flags+0x47c/0x610 net/core/dev.c:8837
 dev_change_flags+0x98/0x170 net/core/dev.c:8909
 devinet_ioctl+0xdf0/0x18d0 net/ipv4/devinet.c:1177
 inet_ioctl+0x34c/0x388 net/ipv4/af_inet.c:1003
 sock_do_ioctl+0xe4/0x240 net/socket.c:1222
 sock_ioctl+0x4cc/0x740 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __arm64_sys_ioctl+0x184/0x218 fs/ioctl.c:893
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x90/0x2e8 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x200/0x2a8 arch/arm64/kernel/syscall.c:131
 el0_svc+0x48/0xc0 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x120/0x130 arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x198 arch/arm64/kernel/entry.S:598

This patch attempts to fix that issue with the same convention.

Cc: stable@vger.kernel.org # v6.1+
Fixes: deee93d13d38 ("Bluetooth: use hdev->workqueue when queuing hdev->
{cmd,ncmd}_timer works")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Tested-by: Yunseong Kim <yskelg@gmail.com>
Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 include/net/bluetooth/hci_core.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 31020891fc68..111509dc1a23 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1572,8 +1572,13 @@ static inline void hci_conn_drop(struct hci_conn *conn)
 		}
 
 		cancel_delayed_work(&conn->disc_work);
-		queue_delayed_work(conn->hdev->workqueue,
-				   &conn->disc_work, timeo);
+
+		rcu_read_lock();
+		if (!hci_dev_test_flag(conn->hdev, HCI_CMD_DRAIN_WORKQUEUE)) {
+			queue_delayed_work(conn->hdev->workqueue,
+							   &conn->disc_work, timeo);
+		}
+		rcu_read_unlock();
 	}
 }
 
-- 
2.45.2


