Return-Path: <stable+bounces-235331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLw8NstV12kFMggAu9opvQ
	(envelope-from <stable+bounces-235331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:31:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 699A13C70DD
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 09:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 737F4303DAC8
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 07:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B4A37A4B9;
	Thu,  9 Apr 2026 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="eMdR91Iw"
X-Original-To: stable@vger.kernel.org
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8521257F
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 07:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719640; cv=none; b=GEefcDAfY4s6jaoglqmZM6M/Fa1Yow2rEaIP47sKRXo3eUFCDYvUWwIrQeZ6HaW+C4ycUB+nKo5NJBSELrJxeBOSasuKbsxcEesN1AUCSQa3N8Ewe8IuozcgMt1q/OngSSf24dUX8y3lUd50jlJahhWw8lLLoihHVhOjo2kCXOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719640; c=relaxed/simple;
	bh=IBKDApS8cl9ptSAnQtUs+GTa1DVVnMGBPGv+drTGiIU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q32hndSLI3RRcIBa9csvo+PfxWLlORJnH7bf1SAyH2c9AUFhF0L8DYDNL+1YtosTw/cWzIqN4Akz67B/ldbd7Kq+KfUKJ8k5u2zcMsUBrVoMgd+uKV4/TaimwljPvnRQv0sBCTiWoENKiXZ511UBy9rNRG+kEdI+Z0GqLnt/3Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=eMdR91Iw; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1775719634;
	bh=B9Ky8dM7FipFI/IZO7wupdIYKTEbpR7DFPjKqs0Wqbs=;
	h=From:Subject:Date:Message-Id;
	b=eMdR91Iw6/Pc50l7PXVY+DlXhdMFhgQagAKZAzpzZIh24EJvd++AdJjaMysXiQVXS
	 Sunu2pyF/vUFvjOdvVigAzPvSREi6QFnt8Cg38iYsFgAWBFnkHMM+4irSosWTrP0T2
	 WRu77dqTbz0R+Klpm0lHx1cnZOPXynvWBI7kI7T8=
X-SMAIL-HELO: NTT-kernel-dev
Received: from unknown (HELO NTT-kernel-dev)([60.247.85.88])
	by sina.cn (10.185.250.21) with ESMTP
	id 69D754A500005FD3; Thu, 9 Apr 2026 15:26:34 +0800 (CST)
X-Sender: jianqkang@sina.cn
X-Auth-ID: jianqkang@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=jianqkang@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=jianqkang@sina.cn
X-SMAIL-MID: 6621113408540
X-SMAIL-UIID: BA6D2CF94FC24441B027FD2B1276A3BE-20260409-152634-1
From: Jianqiang kang <jianqkang@sina.cn>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	imv4bel@gmail.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	luiz.von.dentz@intel.com
Subject: [PATCH 5.15.y] Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold
Date: Thu,  9 Apr 2026 15:26:29 +0800
Message-Id: <20260409072629.621981-1-jianqkang@sina.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sina.cn:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235331-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,holtmann.org,gmail.com,davemloft.net,kernel.org,intel.com];
	DKIM_TRACE(0.00)[sina.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianqkang@sina.cn,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[sina.cn];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sina.cn:dkim,sina.cn:email,sina.cn:mid]
X-Rspamd-Queue-Id: 699A13C70DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 598dbba9919c5e36c54fe1709b557d64120cb94b ]

sco_recv_frame() reads conn->sk under sco_conn_lock() but immediately
releases the lock without holding a reference to the socket. A concurrent
close() can free the socket between the lock release and the subsequent
sk->sk_state access, resulting in a use-after-free.

Other functions in the same file (sco_sock_timeout(), sco_conn_del())
correctly use sco_sock_hold() to safely hold a reference under the lock.

Fix by using sco_sock_hold() to take a reference before releasing the
lock, and adding sock_put() on all exit paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Jianqiang kang <jianqkang@sina.cn>
---
 net/bluetooth/sco.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index d98648bcc1a8..d0ef74c45914 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -311,7 +311,7 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 	struct sock *sk;
 
 	sco_conn_lock(conn);
-	sk = conn->sk;
+	sk = sco_sock_hold(conn);
 	sco_conn_unlock(conn);
 
 	if (!sk)
@@ -320,11 +320,15 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 	BT_DBG("sk %p len %u", sk, skb->len);
 
 	if (sk->sk_state != BT_CONNECTED)
-		goto drop;
+		goto drop_put;
 
-	if (!sock_queue_rcv_skb(sk, skb))
+	if (!sock_queue_rcv_skb(sk, skb)) {
+		sock_put(sk);
 		return;
+	}
 
+drop_put:
+	sock_put(sk);
 drop:
 	kfree_skb(skb);
 }
-- 
2.34.1


