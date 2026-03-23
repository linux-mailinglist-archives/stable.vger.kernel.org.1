Return-Path: <stable+bounces-229879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKl0Nct1wWkQTQQAu9opvQ
	(envelope-from <stable+bounces-229879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:18:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF662F9B47
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19A8B317AF06
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30153B9D85;
	Mon, 23 Mar 2026 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M4fS5fir"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435F3AE6F8;
	Mon, 23 Mar 2026 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283110; cv=none; b=qKqvtzu4NY/QEeK0xWKoN3xNX8L//e0Gq3vUOdf96Kd/8DC9S4AvzKNkcSuxzWXeMe3RN3EVMoJUd2yRGWZEzwUA7nd6WVsX7pyxOfg4BANYuPHdMSlUJbwooeESzAdYL+XRr9PRfDQJ8NUM5ruOfOdCoXZuf9WhanHcUBo5hKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283110; c=relaxed/simple;
	bh=28ezYnE9VVlv2ZDzbsnOe9evy7ycjq04L76+r+PDpGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDm+fOzi4lksuZiCLVJ+i9wgSdDjNDyvgVUy71W2k3jjgDMpOxW+r7wqB7SN7NQ6lPvu3v19gO5irY1ZLKX4zYGc4NYgQmX7xOtJ2xhmJ63Anh18VsTMEPwkeeOt0mPxO2YTlsAD3zrN3fjvqvojP5SmCqmYa7OQbOVStqFGYhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M4fS5fir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B980CC4CEF7;
	Mon, 23 Mar 2026 16:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283110;
	bh=28ezYnE9VVlv2ZDzbsnOe9evy7ycjq04L76+r+PDpGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M4fS5firypsZ8JkZwmN9oO6TYnZ0LCxwsNhU7bpKdS2MRgEHf2FrdXAOMuRwLoncM
	 M3ZCXQSRw7hh1h7fCnkQT/Kcdfwi2gHpzOQw70UUB9WTekuse1uH7TCvLnV7neJsPF
	 mUx9WMmfLP1f+J5lk9ucvW6Oj/IzYAWCjgXHlP7s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Eggers <ceggers@arri.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 404/481] Bluetooth: LE L2CAP: Disconnect if received packets SDU exceeds IMTU
Date: Mon, 23 Mar 2026 14:46:26 +0100
Message-ID: <20260323134535.020784795@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229879-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: ECF662F9B47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Eggers <ceggers@arri.de>

[ Upstream commit e1d9a66889867c232657a9b6f25d451d7c3ab96f ]

Core 6.0, Vol 3, Part A, 3.4.3:
"If the SDU length field value exceeds the receiver's MTU, the receiver
shall disconnect the channel..."

This fixes L2CAP/LE/CFC/BV-26-C (running together with 'l2test -r -P
0x0027 -V le_public -I 100').

Fixes: aac23bf63659 ("Bluetooth: Implement LE L2CAP reassembly")
Signed-off-by: Christian Eggers <ceggers@arri.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7899600cd3724..db62b4f2c5210 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7678,8 +7678,10 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		return -ENOBUFS;
 	}
 
-	if (chan->imtu < skb->len) {
-		BT_ERR("Too big LE L2CAP PDU");
+	if (skb->len > chan->imtu) {
+		BT_ERR("Too big LE L2CAP PDU: len %u > %u", skb->len,
+		       chan->imtu);
+		l2cap_send_disconn_req(chan, ECONNRESET);
 		return -ENOBUFS;
 	}
 
@@ -7705,7 +7707,9 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		       sdu_len, skb->len, chan->imtu);
 
 		if (sdu_len > chan->imtu) {
-			BT_ERR("Too big LE L2CAP SDU length received");
+			BT_ERR("Too big LE L2CAP SDU length: len %u > %u",
+			       skb->len, sdu_len);
+			l2cap_send_disconn_req(chan, ECONNRESET);
 			err = -EMSGSIZE;
 			goto failed;
 		}
-- 
2.51.0




