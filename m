Return-Path: <stable+bounces-93341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC939CD8B5
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C15BB25E88
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD04186294;
	Fri, 15 Nov 2024 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UHAgTPdx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDF718871E;
	Fri, 15 Nov 2024 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653597; cv=none; b=IofU/ZWzg5DDevVEwvNbAhj7/uxUEcO4zHUeGRfELqLfCMbRJD6vOYeFNk/f/XVGzsXKfrzkik6KzepQBpTourdm2jF0ohlF/0NhCsjNCqkUxGXfu5Lde71h07nD+49unRslexrnEPi7owW1j/LSdB4eNfuhw4rCvcfaySgN22o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653597; c=relaxed/simple;
	bh=IEAHIgSMcha41/KF3IEThxfwz+92adAKFcmY9kUR5fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxsEhUQI1v0o+M0YVVFEvJ+hx6Oi/WfXLTyBiQg1GbEJuK2QVyGNiDFnFFpjOX+f5oSt2DcMZ/ESKmAQ1ieLOO/RfHpgada7Lz2eQDaHVl9BsmvFHxsvMuU/WqR5odmvNzDxN2W1LuvAyVGDFBgP/D3pnKDVV3qz4CUPL8pi7bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UHAgTPdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737E0C4CECF;
	Fri, 15 Nov 2024 06:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653596;
	bh=IEAHIgSMcha41/KF3IEThxfwz+92adAKFcmY9kUR5fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UHAgTPdxCumNWT4Smc/lwHCz125FXUiZv33SJerk9QM+pmTxut2nza10J6FuiCJKw
	 3NNKeoUZu2KsWQ9FFIvyCa1fd95NyKHaCZXsVfPWoksBx2hmigH3GrDZSL0p4Zk49Y
	 +sPSyZEnT3w3K/8fEkYjbyC0Zu7vUdy2fLXMQpu0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Jeremy=20Lain=C3=A9?= <jeremy.laine@m4x.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Mike <user.service2016@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 03/39] Revert "Bluetooth: af_bluetooth: Fix deadlock"
Date: Fri, 15 Nov 2024 07:38:13 +0100
Message-ID: <20241115063722.730295581@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.599985562@linuxfoundation.org>
References: <20241115063722.599985562@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit cb8adca52f306563d958a863bb0cbae9c184d1ae which is
commit f7b94bdc1ec107c92262716b073b3e816d4784fb upstream.

It is reported to cause regressions in the 6.1.y tree, so revert it for
now.

Link: https://lore.kernel.org/all/CADRbXaDqx6S+7tzdDPPEpRu9eDLrHQkqoWTTGfKJSRxY=hT5MQ@mail.gmail.com/
Reported-by: Jeremy Lainé <jeremy.laine@m4x.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>
Cc: Mike <user.service2016@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Pauli Virtanen <pav@iki.fi>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/af_bluetooth.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -307,11 +307,14 @@ int bt_sock_recvmsg(struct socket *sock,
 	if (flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
+	lock_sock(sk);
+
 	skb = skb_recv_datagram(sk, flags, &err);
 	if (!skb) {
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
 			err = 0;
 
+		release_sock(sk);
 		return err;
 	}
 
@@ -337,6 +340,8 @@ int bt_sock_recvmsg(struct socket *sock,
 
 	skb_free_datagram(sk, skb);
 
+	release_sock(sk);
+
 	if (flags & MSG_TRUNC)
 		copied = skblen;
 
@@ -559,11 +564,10 @@ int bt_sock_ioctl(struct socket *sock, u
 		if (sk->sk_state == BT_LISTEN)
 			return -EINVAL;
 
-		spin_lock(&sk->sk_receive_queue.lock);
+		lock_sock(sk);
 		skb = skb_peek(&sk->sk_receive_queue);
 		amount = skb ? skb->len : 0;
-		spin_unlock(&sk->sk_receive_queue.lock);
-
+		release_sock(sk);
 		err = put_user(amount, (int __user *)arg);
 		break;
 



