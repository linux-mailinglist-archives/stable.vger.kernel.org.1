Return-Path: <stable+bounces-215337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP64Lzr0iWl+EwAAu9opvQ
	(envelope-from <stable+bounces-215337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:50:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29901111109
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCED2304AC38
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DDD37B409;
	Mon,  9 Feb 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MeoG/JyN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386012DB7B4;
	Mon,  9 Feb 2026 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648465; cv=none; b=MmurknxkHOzotvn8m4HW9oJWoPOthUzKYUxmBz3EjD4M4LaZhzNBsNf+xRjGQ7rr7kctrX0g6ByN4JsVNNZRMj2LhSnupYk+kyoqbATXwV21OPYsOTaNJ2ntSlVpFVa2t8X9RAZfDqEEMv5gVMwxpNk2MeioPb6VCM7NROnamdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648465; c=relaxed/simple;
	bh=tLDtVgxsmpNhzRFJnchEyjJrwJrTKTx71VHo66iIyqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1n6CCr6YX9juG0TYobdNrzKm6w/kQRCZyZKnEat6n0TY+Hv0OZAVDJ65ZRToeghUF1PnocWKiVFRJZRh1nzqJJcZ/EgpPoRk9Mkec53BMYWe4dcEQ3MzzqlhEb9NsP0/6SF4jFBX+3d3QawZYI0MoB+lFybEZCoixiSCHQ4Y0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MeoG/JyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E76BC19423;
	Mon,  9 Feb 2026 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648464;
	bh=tLDtVgxsmpNhzRFJnchEyjJrwJrTKTx71VHo66iIyqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MeoG/JyNJXVWrlokX8XoirA5I3G+BVQ+rc6E6h+hCb1DBNYFVKlWEQlPo+33ungIR
	 PFLwz3AeiY9WeflRm/g4WbmcpQwXZ6bz5wEDJcvMtm5rjnImhB7qmwmRhUMAEs40em
	 rxcTxNWf9cQGB6LuGVoLw8L/+xDTgbK/852l4s3Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yi Zhang <yi.zhang@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 45/86] nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()
Date: Mon,  9 Feb 2026 15:24:08 +0100
Message-ID: <20260209142306.405772124@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142304.770150175@linuxfoundation.org>
References: <20260209142304.770150175@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215337-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,grimberg.me:email]
X-Rspamd-Queue-Id: 29901111109
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 2fa8961d3a6a1c2395d8d560ffed2c782681bade ]

When the socket is closed while in TCP_LISTEN a callback is run to
flush all outstanding packets, which in turns calls
nvmet_tcp_listen_data_ready() with the sk_callback_lock held.
So we need to check if we are in TCP_LISTEN before attempting
to get the sk_callback_lock() to avoid a deadlock.

Link: https://lore.kernel.org/linux-nvme/CAHj4cs-zu7eVB78yUpFjVe2UqMWFkLk8p+DaS3qj+uiGCXBAoA@mail.gmail.com/
Tested-by:  Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index ee19eeb47dd2f..4d1f260ae60ab 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1757,14 +1757,13 @@ static void nvmet_tcp_listen_data_ready(struct sock *sk)
 
 	trace_sk_data_ready(sk);
 
+	if (sk->sk_state != TCP_LISTEN)
+		return;
+
 	read_lock_bh(&sk->sk_callback_lock);
 	port = sk->sk_user_data;
-	if (!port)
-		goto out;
-
-	if (sk->sk_state == TCP_LISTEN)
+	if (port)
 		queue_work(nvmet_wq, &port->accept_work);
-out:
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
-- 
2.51.0




