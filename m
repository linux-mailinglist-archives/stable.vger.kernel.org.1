Return-Path: <stable+bounces-229053-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DpkIjtWwWmBSQQAu9opvQ
	(envelope-from <stable+bounces-229053-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:03:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 260032F5AF0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4240E304D9F8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759F439C658;
	Mon, 23 Mar 2026 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pLhBD3ee"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385721DA0E1;
	Mon, 23 Mar 2026 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277911; cv=none; b=AodvJnfgNuGcCfxc1v+nDJcd+sA/r0halwnxrnbAtI59CLPpoJZY4xnchEOZcOQG536yEcZ4E7JdjNardOxpoPgGfgXZ6LrnV0k/3MIiCXM6L/U8rov02w7hc9U9RV6mwxzhIGLPC6QhV+nJEtXTk4ZXWYMKRa8NQ7kgDduKhJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277911; c=relaxed/simple;
	bh=HW8A2uOFnwMexGdV9cY2C+ac0GMkjrP5ksGfbr8huCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ih96cKfFPR4QNuyFSt2raP+jXT5r+W6txm3wTs+oAGtmqGhFsPTBe8dMUdunBtZFnYzq4YPxi5Ro58d2ZgEwGsjt702mb96Ifk6e4ky8RddJ0+SLY8jUomQOU0YqpJG0ZYoeztiIX9ulAVr0sSLKM0uoO5SGJ3XGwSds5ffyiS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pLhBD3ee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CA6C4CEF7;
	Mon, 23 Mar 2026 14:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277910;
	bh=HW8A2uOFnwMexGdV9cY2C+ac0GMkjrP5ksGfbr8huCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pLhBD3eeBqzhn+KMNfJ+6mLpcigmqT6MWNWtmK7TqCwKcK7rPQcFFE/tEbDr6yGPt
	 5iV4LWrBXqnS7fwbZNTe18Jat9XnAc/XZSMjOJZZ71eC2R2AQB2jc81R3CRFKBLD8G
	 Dtv8SNdxykBz2lzNdzageZm+CcPsBIB7h1Q6E1qU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org
Subject: [PATCH 6.6 098/567] can: usb: f81604: handle bulk write errors properly
Date: Mon, 23 Mar 2026 14:40:18 +0100
Message-ID: <20260323134536.251176211@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229053-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 260032F5AF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 51f94780720fa90c424f67e3e9784cb8ef8190e5 upstream.

If a write urb fails then more needs to be done other than just logging
the message, otherwise the transmission could be stalled.  Properly
increment the error counters and wake up the queues so that data will
continue to flow.

Cc: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: stable@kernel.org
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026022334-slackness-dynamic-9195@gregkh
Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/f81604.c |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -891,9 +891,27 @@ static void f81604_write_bulk_callback(s
 	if (!netif_device_present(netdev))
 		return;
 
-	if (urb->status)
-		netdev_info(netdev, "%s: Tx URB error: %pe\n", __func__,
-			    ERR_PTR(urb->status));
+	if (!urb->status)
+		return;
+
+	switch (urb->status) {
+	case -ENOENT:
+	case -ECONNRESET:
+	case -ESHUTDOWN:
+		return;
+	default:
+		break;
+	}
+
+	if (net_ratelimit())
+		netdev_err(netdev, "%s: Tx URB error: %pe\n", __func__,
+			   ERR_PTR(urb->status));
+
+	can_free_echo_skb(netdev, 0, NULL);
+	netdev->stats.tx_dropped++;
+	netdev->stats.tx_errors++;
+
+	netif_wake_queue(netdev);
 }
 
 static void f81604_clear_reg_work(struct work_struct *work)



