Return-Path: <stable+bounces-61431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9023793C346
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 15:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCA8283984
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F21C19B5A9;
	Thu, 25 Jul 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0Zz+UjS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FD31DA4D;
	Thu, 25 Jul 2024 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915287; cv=none; b=lDGvjbjuxQeVgdkwRo9M5yHieLipsCBmK5Lm6vA2nc/X8ACkjPGNChA8rh454RSTB7keDUAt0scYmjxa29myqBUe3Bz0cNb7LXzCOVwe8bRnTx88A5Egi/kg1eb1kVrVgO6Ian0exFacmw6X323ygQUkq588naOicowW7uquBGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915287; c=relaxed/simple;
	bh=7Sv6OCEzzkgx+3bkiIC0oHCZE/eFdrysxGn/aVTxDgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YIF8qn2AV/9LfWvy7gG4+HMCWPeVDFqLSuxh5rlfmS/M6Hb0GX0fd1lqnIpGKUa3tDFG5rHe6SRByMefIo+I+CLpiro6QaRxt2fkH1gcBOkpoZp32O8Vo5T7Cso1c5ahz+OBq1uFm6MPncGomThya9vXjxQTjhzex+71nll/ng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0Zz+UjS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd69e44596so7270445ad.1;
        Thu, 25 Jul 2024 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721915285; x=1722520085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D36avothTiN26DEXRrwl8vL9+l9JWVjxZcAnqb0lUtE=;
        b=d0Zz+UjSHKvdNFSolbR0RMPaFv1t683Fh9sq/H7h+nf15RcgB3LDaS8MkT3Kn43ZOR
         nRmfjXrQvyfcbRNo3ajZ1p8aHyToj4tbV4uNNgE1Vq0jl4A57zVDFVSivMe0/Td6co9A
         5fbCjjmc//RUJxBOdy/NQOz9AQjilx8rLN6SYTy8pgmJqGZ5B1pIB5WbVQBBvtBVWZZ9
         ofUTmmeJVhpPFJgergA1GOx0uafBJmEYk/AB6wkKaMI7vlSraDPA5/aEDaVoWcw3y0Oa
         cSz82lkccOHBc1Q7Q5yCUMYoZL5tFnOhp3avZqU5d2SExxWQm9UludKTU9nupSW245Lo
         qeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721915285; x=1722520085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D36avothTiN26DEXRrwl8vL9+l9JWVjxZcAnqb0lUtE=;
        b=R2lYqtFTO26VG5tcW5Ly12ep08bcW5jfYM8t37+kLSEa3a2V3UbvN7D1lM5zsVwd74
         PGcFugpgpRHTcFKTWIqcVEDd34xi8dZLcWa8FMZwyMlCds5hrCWg1ZxtD5kOJak1Jz0g
         ecU2op2wzdrey8PNwkx9ANXPO4MENKBVLokm1AvMY240pqdZfAXYJR1YdiPjgxd4Kn8z
         Xu13rrZGnBePZMoTgWeR5oKo1LT7GWpfvefFSAR7qywqc1kInu/7kZ1p00LYPNC3Qcmk
         ygD9KDoACkOPq1ONY2oQZO1XjPM5n1fgMqbnPF0E5p5xtS/teVU8h2wfeQd4jT1Jd+3j
         SHXA==
X-Forwarded-Encrypted: i=1; AJvYcCVT8S11Rh1/RKdlUfG1VKHCuH+4BZakdFa+m7KpmemoMJLYwDIKe/6gSYc8LStjkn6tRl5xExlC3pyNhQEjoe7NI0RClhidJliwRAsHiZCN2wBhi54tKmDE240b1F6oSnWKY0Fo+sjrQPbFOKHbGwVwNadQh5CVxKQEor3R
X-Gm-Message-State: AOJu0Yzduaw/ANgJTxC1TxCo3kcTspToAXcjq/ylcgvOGE66X/2KFmkC
	oUCrRsIVRxkc/g9dZibi7MNQq5gA1HQVR1std3zHzkMjsBg2z18Y
X-Google-Smtp-Source: AGHT+IHrGj4i8av4Df9LjTSzxkl4RLlmaLnBdbHXQEJCzMcaacwmT4UIE6ho2KCbU2sqs1FU8CfR0Q==
X-Received: by 2002:a17:902:dacc:b0:1f9:b19c:2e3b with SMTP id d9443c01a7336-1fdd6d9ca95mr91682575ad.15.1721915284726;
        Thu, 25 Jul 2024 06:48:04 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ca8fd5sm14309735ad.64.2024.07.25.06.48.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jul 2024 06:48:04 -0700 (PDT)
From: Yunseong Kim <yskelg@gmail.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Marcel Holtmann <marcel@holtmann.org>,
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
Subject: [PATCH v2] Bluetooth: hci_core: fix suspicious RCU usage in hci_conn_drop()
Date: Thu, 25 Jul 2024 22:47:42 +0900
Message-ID: <20240725134741.27281-2-yskelg@gmail.com>
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
Fixes: deee93d13d38 ("Bluetooth: use hdev->workqueue when queuing hdev->{cmd,ncmd}_timer works")
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


