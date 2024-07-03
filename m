Return-Path: <stable+bounces-57869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69006925E63
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ADA61C23E55
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062E2181BB3;
	Wed,  3 Jul 2024 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PJ4LpZaz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B086B181B9A;
	Wed,  3 Jul 2024 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006178; cv=none; b=K8ssFKkHOg7RSceD116LfMhjN2dC4beB/3dRjzP+5Z+qhwyw7OiMKwal8m6dXxpWvpXPHA32Hh0I0C9O+F66HnEMqehsv38XZFpMNFTjRZ2OHdBRZqDomie0wZOTm11qGQXtA5oXRMHsMpAPU8HTKLClbcQKo1WxjWy094QUfuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006178; c=relaxed/simple;
	bh=StgC+fepnaDXNb0FbXxuYNjEhTcq6Y+xXCgWPQRVg7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzjPWN2/TcEWbwkgArxGuUjy37U3uCEBVDC5rQbKhUrFWmCFrGJfNrMzH2IDgPCBvxSK4KmGDoIrJMdZvHUSFujpPvNbD1o7tRtsAY1buNXUNJkaCPfPx1fP0GpcNYnutRXfYF6c81Q7O2JSJi9Ja1Z26ir564NmlgoEbjpvuMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PJ4LpZaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351DCC2BD10;
	Wed,  3 Jul 2024 11:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720006178;
	bh=StgC+fepnaDXNb0FbXxuYNjEhTcq6Y+xXCgWPQRVg7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PJ4LpZazkH+KxQvxFo/tB5SNESz0ctxaN9C+2muWqsH1bf5og8qKeq3tW81S+ggd2
	 CKvgfQHRW+OlGi0Vi+Jpxmm5lXEbNE9vNGxHGJlE+zoJbb1yvOYv/turgrCrJV9wK7
	 uzCEyAKHWcwsZGYLtStGkg6ml0WmJILstR13VDs8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+daa36413a5cedf799ae4@syzkaller.appspotmail.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15 327/356] net: can: j1939: enhanced error handling for tightly received RTS messages in xtp_rx_rts_session_new
Date: Wed,  3 Jul 2024 12:41:03 +0200
Message-ID: <20240703102925.483640241@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksij Rempel <o.rempel@pengutronix.de>

commit d3e2904f71ea0fe7eaff1d68a2b0363c888ea0fb upstream.

This patch enhances error handling in scenarios with RTS (Request to
Send) messages arriving closely. It replaces the less informative WARN_ON_ONCE
backtraces with a new error handling method. This provides clearer error
messages and allows for the early termination of problematic sessions.
Previously, sessions were only released at the end of j1939_xtp_rx_rts().

Potentially this could be reproduced with something like:
testj1939 -r vcan0:0x80 &
while true; do
	# send first RTS
	cansend vcan0 18EC8090#1014000303002301;
	# send second RTS
	cansend vcan0 18EC8090#1014000303002301;
	# send abort
	cansend vcan0 18EC8090#ff00000000002301;
done

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Reported-by: syzbot+daa36413a5cedf799ae4@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/all/20231117124959.961171-1-o.rempel@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/j1939/transport.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1593,8 +1593,8 @@ j1939_session *j1939_xtp_rx_rts_session_
 	struct j1939_sk_buff_cb skcb = *j1939_skb_to_cb(skb);
 	struct j1939_session *session;
 	const u8 *dat;
+	int len, ret;
 	pgn_t pgn;
-	int len;
 
 	netdev_dbg(priv->ndev, "%s\n", __func__);
 
@@ -1653,7 +1653,22 @@ j1939_session *j1939_xtp_rx_rts_session_
 	session->tskey = priv->rx_tskey++;
 	j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_RTS);
 
-	WARN_ON_ONCE(j1939_session_activate(session));
+	ret = j1939_session_activate(session);
+	if (ret) {
+		/* Entering this scope indicates an issue with the J1939 bus.
+		 * Possible scenarios include:
+		 * - A time lapse occurred, and a new session was initiated
+		 *   due to another packet being sent correctly. This could
+		 *   have been caused by too long interrupt, debugger, or being
+		 *   out-scheduled by another task.
+		 * - The bus is receiving numerous erroneous packets, either
+		 *   from a malfunctioning device or during a test scenario.
+		 */
+		netdev_alert(priv->ndev, "%s: 0x%p: concurrent session with same addr (%02x %02x) is already active.\n",
+			     __func__, session, skcb.addr.sa, skcb.addr.da);
+		j1939_session_put(session);
+		return NULL;
+	}
 
 	return session;
 }



