Return-Path: <stable+bounces-91427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D989BEDEB
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E852286640
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE9C1E25E5;
	Wed,  6 Nov 2024 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ciBpH8fF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBED1E0491;
	Wed,  6 Nov 2024 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898704; cv=none; b=Jx87ogFsoycV6vVxs9tZ1vh00N8uu9JLpV1ehhp/e0Ssa8muVR3TPl5Uyg46bsSWQBagu6T7wkZLBadewV2nayWgEOTGKG2cFrLmsW4CWT6bMf4B1x28MgGwmKtdi0jt5cP7tgBZdqckuI5WHjlJcMOCHgJBL28ek8Cf9/CZ0Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898704; c=relaxed/simple;
	bh=IaOhtWFl6eYT81nCDrLF9iiG3PJ5QkF+f8SOEH8SpP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjtIETSjM0zgXlfck6hZcr6ryXQ1GkLwCmdnC9ylkECRbJ8/Vi3MMaX8VsEIB65uVylCnSLTr5cwg7AeSzvKKOpKv+P2iSQPyEu+1gb5sF7aM0DGM0xjvOLNnqvntTA1f56Wwm5HEhr7U77pzfDMZZZ8LMFumgJcS5uWJnWVEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ciBpH8fF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083CCC4CED8;
	Wed,  6 Nov 2024 13:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898704;
	bh=IaOhtWFl6eYT81nCDrLF9iiG3PJ5QkF+f8SOEH8SpP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ciBpH8fFGIijdjb4sOUHCk9C2Y+3ViKzxS9qJQsgyBuRxJFD9NMP9LTEEQZWpFBDO
	 m8+32GkgP/VawLC88/Oxqzqup+fiJL9wwQi0xm/pYr7TFkX798x+San/qaUA/MqOKv
	 Fj+ZIPwwFbJ0GPpkjirn2Hv1YW76cqLlxbpsElzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 327/462] Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change
Date: Wed,  6 Nov 2024 13:03:40 +0100
Message-ID: <20241106120339.603808803@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 08d1914293dae38350b8088980e59fbc699a72fe ]

rfcomm_sk_state_change attempts to use sock_lock so it must never be
called with it locked but rfcomm_sock_ioctl always attempt to lock it
causing the following trace:

======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
------------------------------------------------------
syz-executor386/5093 is trying to acquire lock:
ffff88807c396258 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1671 [inline]
ffff88807c396258 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: rfcomm_sk_state_change+0x5b/0x310 net/bluetooth/rfcomm/sock.c:73

but task is already holding lock:
ffff88807badfd28 (&d->lock){+.+.}-{3:3}, at: __rfcomm_dlc_close+0x226/0x6a0 net/bluetooth/rfcomm/core.c:491

Reported-by: syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com
Tested-by: syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
Fixes: 3241ad820dbb ("[Bluetooth] Add timestamp support to L2CAP, RFCOMM and SCO")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/rfcomm/sock.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index e67310a749d27..c52e2f7ff84bd 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -872,9 +872,7 @@ static int rfcomm_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned lon
 
 	if (err == -ENOIOCTLCMD) {
 #ifdef CONFIG_BT_RFCOMM_TTY
-		lock_sock(sk);
 		err = rfcomm_dev_ioctl(sk, cmd, (void __user *) arg);
-		release_sock(sk);
 #else
 		err = -EOPNOTSUPP;
 #endif
-- 
2.43.0




