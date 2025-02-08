Return-Path: <stable+bounces-114385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AA6A2D5E2
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 12:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393A73AACF9
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 11:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613E6246346;
	Sat,  8 Feb 2025 11:51:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BC424632E
	for <stable@vger.kernel.org>; Sat,  8 Feb 2025 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739015493; cv=none; b=Pe05vmUem6V4ilVM6Eygbj7w1dta0hsm86aIuqhKXA4rCUuLufK2xiE3PFJ4+DGkdW/dhzGdUYbW2yUUPmULNyw9aC3L8r+9InXiDTzYmDhdvzdH06xf3MdIsFvp9pd+00NoUDMQ29xJcSYjy0NS216VO4Z/TkhMDBx0QRciWfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739015493; c=relaxed/simple;
	bh=d0I0NcU9zYnrhHQkvZdmUL7DdsVqAHzWb6MM+QEIlvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRJLG3+XeDCwOoaED6iH+aTz0yJhBPI1af35NFwdbEOJDOkY33eJ2SYiFam2IzJTWgy4ATnpQK+VlmcOVGkPFNYVZzVPKP4HirYy/Q3d4EeVIc6N/1Mylvh4WsMGG42EQPbGN+s27I1XHXFLGlAvQZzFviJj4RT6y5PAjj64Kw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tgjMw-0006ja-36
	for stable@vger.kernel.org; Sat, 08 Feb 2025 12:51:30 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tgjMv-0048LW-2p
	for stable@vger.kernel.org;
	Sat, 08 Feb 2025 12:51:29 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8869D3BCCC9
	for <stable@vger.kernel.org>; Sat, 08 Feb 2025 11:51:29 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 06F153BCCB3;
	Sat, 08 Feb 2025 11:51:25 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d709db6e;
	Sat, 8 Feb 2025 11:51:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/6] can: j1939: j1939_sk_send_loop(): fix unable to send messages with data length zero
Date: Sat,  8 Feb 2025 12:45:15 +0100
Message-ID: <20250208115120.237274-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208115120.237274-1-mkl@pengutronix.de>
References: <20250208115120.237274-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

From: Alexander Hölzl <alexander.hoelzl@gmx.net>

The J1939 standard requires the transmission of messages of length 0.

For example proprietary messages are specified with a data length of 0
to 1785. The transmission of such messages is not possible. Sending
results in no error being returned but no corresponding can frame
being generated.

Enable the transmission of zero length J1939 messages. In order to
facilitate this two changes are necessary:

1) If the transmission of a new message is requested from user space
the message is segmented in j1939_sk_send_loop(). Let the segmentation
take into account zero length messages, do not terminate immediately,
queue the corresponding skb.

2) j1939_session_skb_get_by_offset() selects the next skb to transmit
for a session. Take into account that there might be zero length skbs
in the queue.

Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/20250205174651.103238-1-alexander.hoelzl@gmx.net
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
[mkl: commit message rephrased]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/socket.c    | 4 ++--
 net/can/j1939/transport.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 305dd72c844c..17226b2341d0 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1132,7 +1132,7 @@ static int j1939_sk_send_loop(struct j1939_priv *priv,  struct sock *sk,
 
 	todo_size = size;
 
-	while (todo_size) {
+	do {
 		struct j1939_sk_buff_cb *skcb;
 
 		segment_size = min_t(size_t, J1939_MAX_TP_PACKET_SIZE,
@@ -1177,7 +1177,7 @@ static int j1939_sk_send_loop(struct j1939_priv *priv,  struct sock *sk,
 
 		todo_size -= segment_size;
 		session->total_queued_size += segment_size;
-	}
+	} while (todo_size);
 
 	switch (ret) {
 	case 0: /* OK */
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 95f7a7e65a73..9b72d118d756 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -382,8 +382,9 @@ sk_buff *j1939_session_skb_get_by_offset(struct j1939_session *session,
 	skb_queue_walk(&session->skb_queue, do_skb) {
 		do_skcb = j1939_skb_to_cb(do_skb);
 
-		if (offset_start >= do_skcb->offset &&
-		    offset_start < (do_skcb->offset + do_skb->len)) {
+		if ((offset_start >= do_skcb->offset &&
+		     offset_start < (do_skcb->offset + do_skb->len)) ||
+		     (offset_start == 0 && do_skcb->offset == 0 && do_skb->len == 0)) {
 			skb = do_skb;
 		}
 	}
-- 
2.47.2



