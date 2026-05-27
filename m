Return-Path: <stable+bounces-254481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SQ/5C0l6FmpMmwcAu9opvQ
	(envelope-from <stable+bounces-254481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 06:59:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 701EE5DF45D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 06:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84F2C303454A
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 04:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9FF30C14F;
	Wed, 27 May 2026 04:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqrNXtf8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D42139C9
	for <stable@vger.kernel.org>; Wed, 27 May 2026 04:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779857986; cv=none; b=hLUEwf5VlQoJ8jZeqLwwYAqj17ELuS4wx+dK8ZypI7oU5IKwuYsRcZRHKVuUSPqCjUKMwTzOd5NPRkbFoxbZ/4L3JM74luXCUu6I+LeyyKiLsR86Ft9AR/wutA97Rs7IUvzjO+iGM/+bXXx8koohChjMWBEjPPCrg3r6vaj0rok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779857986; c=relaxed/simple;
	bh=XTXmDAUFvXvTiWqlHzjhD3yNcXPtaREUgWrMw5c6hLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lCLLvfhKPj3V3O13bV0elD2sRJTDGf1xNr8YYkQ9zMVR/1f5jskcQO+2aR7hDfEsiS/3ky2YlXcEBVN4G7Qzgipylc39Uv/PiMUofpyiXyAYW9jGhr9uEvvH2eqChHm8cidZz+p2I6dM7Fo1KKWwJlXPLOOAYM1OqY030Ew4/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqrNXtf8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8354461da74so5238294b3a.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 21:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779857984; x=1780462784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uMxFDyzWsRKlVJURYrmPdEmoNvPZv2yVR/RX1zOeUzY=;
        b=ZqrNXtf8EAVlpCJvWtBZ0TLYP7weSQKQWO6pJqZgqudtfFjQCltHDZTQU487JmJYsk
         42jcpJSL/AH3lJ329FreexxZBjWgmgHfStBQXpSKdR1t6yYiFmPTGLQzfrmJXhYRQMBW
         Lg29mrdfgLxcWtmK9lodf+Se9KtV8fsfi5BCrtne37Ap1X9MSzTrxThMlGPUVW3xR+w+
         wIwRTRUsmMNywLcbALMrW17R7PK1dQF7P2//Ud5M/5pMVScbvR1zNJkjsI9/iU7c1/Ta
         TZRyrBzE4fV8X2E2JTVDko2+2TDC+xu54366XWBXsUJVLrCSU3FW4FEuQYES+x7gpsC0
         D/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779857984; x=1780462784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMxFDyzWsRKlVJURYrmPdEmoNvPZv2yVR/RX1zOeUzY=;
        b=RQPh1zYstTmxvSYd6W/H0GI6C9sJhw+kjIQ124SDGBCP5Obtk9yLNOIpNXznLlpMXe
         gQl9Gge53ZNrIW4oorg3iGhwTtCFgkGXfs6kOJsrmxwkDMisdyynQg51ljzhbgYHfs/g
         1ijj2ybZyiQlEHBdHuLgBgLKfIF4o8nxgSzdB1JqLYmPz8olSXEOzyRrAitJLjEhcVQh
         O0DIjKYTeFlXayuUdeJ9O+jaG4GA9elmnH6s9Lt5LM7TD7grh+s3rMnuDKflJDe2bhbE
         hjNGyu70/LluSszDT2ZSo2wrdDKOIGAzqVfBdkZ3pXxqMH6cs57u4ElMf++FeXRWa+k2
         4X9w==
X-Gm-Message-State: AOJu0YyQmzCB+FjJrH+BlfDbd1y4ogBETyf54voow449YWONyS1qm9yV
	pMLOi9pLdcMrV8aXGE7AJTeLu64xEuEJ/xRW80BFkQYp2SRAQY1GgcYOrucQzg==
X-Gm-Gg: Acq92OEzGvXCDpci4j44FrX+2XT+2L73/rmKLi/VNpcKeQLNHUoe6LS1cRcjfidr7A3
	ymecNUtO9BVNkCN7QoXGssKg3sfGPW8reIl5s7AQVTjdAnSMx5JlCQgq8LkwKtmOV1GeIaK38bM
	QlEph3IL/pu86Qcslq/qwOXEzqQdXBzazVjJHC/Kckt7jIdaHDbm543sAqnQDFkV9jdj778+Gjq
	Ts7ShVtUXmkYcYorts+kbNfg819doruRa7AOLul0XAuR2k7HLLVcExpZlfcs6Q+K7vRNP09NpXl
	0vd0ZgWtQjXPPLqcr/aVPFqueUUgMuzzPUAmR7NiKX4oHr1Pk2J6HannH1qniKK/QPFRbrNrS26
	EXSwRcywbvWGNgO9E8NLOiMDxcRZHgmu5FjMHBj2tbLZ/ule+zc9e1PtmFdqAPTLYn3xY+AO7Nz
	yxIXDOaveRmEGEiJ12e3FPXM937sCox1oE8DyPQTtBBDWACL6QHT76zcQT2Fg+7WYEAQXHpDO+c
	08BxyCTrzn3dAz8zEqD+ZmNgTdXMZx4+usUfoAXy5gm7HpUSOQVwmDh8OpCx5LfuHsHhMOu3ood
	WPQrQ4TfHT7NuOs=
X-Received: by 2002:a05:6a00:3911:b0:82c:dd31:b844 with SMTP id d2e1a72fcca58-8415f5e9a44mr19610973b3a.40.1779857984382;
        Tue, 26 May 2026 21:59:44 -0700 (PDT)
Received: from codespaces-78f0a7.2t4prynt4dlezbzls5ze3dxsqg.rx.internal.cloudapp.net ([4.240.18.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70bb19asm930900b3a.30.2026.05.26.21.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 21:59:44 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: stable@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 1/2] Bluetooth: ISO: fix UAF in iso_recv_frame
Date: Wed, 27 May 2026 04:59:17 +0000
Message-ID: <20260527045919.39077-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254481-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 701EE5DF45D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iso_recv_frame reads conn->sk under iso_conn_lock but releases the lock
before using sk, with no reference held. A concurrent iso_sock_kill()
can free sk in that window, causing use-after-free on sk->sk_state and
sock_queue_rcv_skb().

Fix by replacing the bare pointer read with iso_sock_hold(conn), which
calls sock_hold() while the spinlock is held, atomically elevating the
refcount before the lock drops. Add a drop_put label so sock_put() is
called on all exit paths where the hold succeeded.

Fixes: ccf74f2390d60a2f9a75ef496d2564abb478f46a ("Bluetooth: Add BTPROTO_ISO socket type")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/iso.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index d7af617cda45..f03b7fa5dccc 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -564,7 +564,7 @@ static void iso_recv_frame(struct iso_conn *conn, struct sk_buff *skb)
 	struct sock *sk;
 
 	iso_conn_lock(conn);
-	sk = conn->sk;
+	sk = iso_sock_hold(conn);
 	iso_conn_unlock(conn);
 
 	if (!sk)
@@ -573,11 +573,15 @@ static void iso_recv_frame(struct iso_conn *conn, struct sk_buff *skb)
 	BT_DBG("sk %p len %d", sk, skb->len);
 
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
2.53.0


