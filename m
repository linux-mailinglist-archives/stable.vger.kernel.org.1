Return-Path: <stable+bounces-117262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A32A3B57B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799441795B1
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029D31E5B89;
	Wed, 19 Feb 2025 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vyBLXk6e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3D1C3BE9;
	Wed, 19 Feb 2025 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954723; cv=none; b=GFE+Cx8QYCJ4KMkxcAosPCuhDP6XH/3oUijQy9DF7pPwC4UIQ6EWAECXNNDW9UdywIhJmEWYRpZAU14hL8yWpGl27Tu66rpz0H9lKHpPhpit1L895NSAVY0hEYt8Uj0HgIerkyoD5nimWB8nV8PNun78NXzPnbAf7eHZHFbdH/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954723; c=relaxed/simple;
	bh=cFfdDMNsic07pMgzqznwFRfFP5mG5lSwdrbuF8kZbKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6883Vd9DAeDZyZ9NM9elj5BWERjFUiQtTNNeiN7YgaI9HxqzYOGrHilscldrvs29zGWOLOcj4RnNZOk70m15qqcLvNkUkQSMfNV/d2o6bfeAOXj8rPH0vZAzKZe0IObeSfF7U2gef8c+MgaV3xLNT/g7NcQ/4mzFZFBy5XBtZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vyBLXk6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0398FC4CED1;
	Wed, 19 Feb 2025 08:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739954723;
	bh=cFfdDMNsic07pMgzqznwFRfFP5mG5lSwdrbuF8kZbKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vyBLXk6ew65uR1ULpisqYK0kh+tB3IubkHVfc3eD3BRj88clE6SJXoHqmjMQhJN3R
	 cXnifaRf63lykPrL1uYQOvND9QpP+KeI9T8U+aGm2Srus65blRCn6gTYD9hJKFPCt6
	 DSnCh//GUWAZtCf4HF9NIbC66btC54FnW56KzoxQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+33841dc6aa3e1d86b78a@syzkaller.appspotmail.com,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 016/230] ax25: Fix refcount leak caused by setting SO_BINDTODEVICE sockopt
Date: Wed, 19 Feb 2025 09:25:33 +0100
Message-ID: <20250219082602.336964247@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Murad Masimov <m.masimov@mt-integration.ru>

[ Upstream commit bca0902e61731a75fc4860c8720168d9f1bae3b6 ]

If an AX25 device is bound to a socket by setting the SO_BINDTODEVICE
socket option, a refcount leak will occur in ax25_release().

Commit 9fd75b66b8f6 ("ax25: Fix refcount leaks caused by ax25_cb_del()")
added decrement of device refcounts in ax25_release(). In order for that
to work correctly the refcounts must already be incremented when the
device is bound to the socket. An AX25 device can be bound to a socket
by either calling ax25_bind() or setting SO_BINDTODEVICE socket option.
In both cases the refcounts should be incremented, but in fact it is done
only in ax25_bind().

This bug leads to the following issue reported by Syzkaller:

================================================================
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 1 PID: 5932 at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
Modules linked in:
CPU: 1 UID: 0 PID: 5932 Comm: syz-executor424 Not tainted 6.13.0-rc4-syzkaller-00110-g4099a71718b0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
Call Trace:
 <TASK>
 __refcount_dec include/linux/refcount.h:336 [inline]
 refcount_dec include/linux/refcount.h:351 [inline]
 ref_tracker_free+0x710/0x820 lib/ref_tracker.c:236
 netdev_tracker_free include/linux/netdevice.h:4156 [inline]
 netdev_put include/linux/netdevice.h:4173 [inline]
 netdev_put include/linux/netdevice.h:4169 [inline]
 ax25_release+0x33f/0xa10 net/ax25/af_ax25.c:1069
 __sock_release+0xb0/0x270 net/socket.c:640
 sock_close+0x1c/0x30 net/socket.c:1408
 ...
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 ...
 </TASK>
================================================================

Fix the implementation of ax25_setsockopt() by adding increment of
refcounts for the new device bound, and decrement of refcounts for
the old unbound device.

Fixes: 9fd75b66b8f6 ("ax25: Fix refcount leaks caused by ax25_cb_del()")
Reported-by: syzbot+33841dc6aa3e1d86b78a@syzkaller.appspotmail.com
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
Link: https://patch.msgid.link/20250203091203.1744-1-m.masimov@mt-integration.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ax25/af_ax25.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index aa6c714892ec9..9f3b8b682adb2 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -685,6 +685,15 @@ static int ax25_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
+		if (ax25->ax25_dev) {
+			if (dev == ax25->ax25_dev->dev) {
+				rcu_read_unlock();
+				break;
+			}
+			netdev_put(ax25->ax25_dev->dev, &ax25->dev_tracker);
+			ax25_dev_put(ax25->ax25_dev);
+		}
+
 		ax25->ax25_dev = ax25_dev_ax25dev(dev);
 		if (!ax25->ax25_dev) {
 			rcu_read_unlock();
@@ -692,6 +701,8 @@ static int ax25_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 		ax25_fillin_cb(ax25, ax25->ax25_dev);
+		netdev_hold(dev, &ax25->dev_tracker, GFP_ATOMIC);
+		ax25_dev_hold(ax25->ax25_dev);
 		rcu_read_unlock();
 		break;
 
-- 
2.39.5




