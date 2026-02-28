Return-Path: <stable+bounces-220553-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIFxGfNNo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220553-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:20:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 874441C83BD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 985BB3176F62
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F131F3D6CC1;
	Sat, 28 Feb 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaWXWqnf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38333D6CC5;
	Sat, 28 Feb 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300434; cv=none; b=LeEa4OpWAW9N5Ty1uyu/5b5j0ebImVg/hi2L8Ou2DYNd+ZkW683rwibtrXKY9RM9ywieKaRbb+gSVWA0xAo1Lva9xHdYk2wjtQ8ozzc6RPpJPrG4uK+Ecn/af6rEPVxMfoZ9Rp9Ezg4oLW+uGYCMDt1P0VNoazjPvDffQpZG/hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300434; c=relaxed/simple;
	bh=HdpIbdqWlygfBKQsCat8ydjJKTUIpd8b2jpC7u8VgAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fu6ILiCvp+waHgMIDUdrdd41Pb+e30zSxOQbtVoZ11X4N8M9BNv01QuBb/l76NKKL+T9REg4Aj/VJYynVnlQs/gjTRI8iY30mVqOieT6mNDcxwBisBItlWRemz0g+vmAh2p33UBSo5JJslnJTmSCAPwTID31ey/7LM3M4xvGjsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaWXWqnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20632C2BC9E;
	Sat, 28 Feb 2026 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300434;
	bh=HdpIbdqWlygfBKQsCat8ydjJKTUIpd8b2jpC7u8VgAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HaWXWqnf8TPQUyHiEtncegslpItFHZ3gcly0Gj/lKHHT+9IuE6PwJwO+Twob+T/vx
	 tMQFz0ht5ukl4dW7zw31wa9qR69LduTEu6e7MCAEgQ9/sHwNxG1tzK3rJmjrilyqjB
	 S0c6XDexvdb/WmP4Vm/XsQbK6e1HgCM8+6Ifc5bzz+Yey6coS2LgQoPrjOWwCW4bYl
	 mmDlsXYhIa3uhJvtloIREpCVNrxs5GJJSF8xop1LN5sIzQUJrzIThUpY/G3WM3BMch
	 xXFnsZ3Yuww5GmNvCwS+75hDjQsZQqVgkQfmiobea735l3wIpxhx2CjLkGPj/lhneI
	 mLk+TfikpdYew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 474/844] Bluetooth: L2CAP: Fix not checking output MTU is acceptable on L2CAP_ECRED_CONN_REQ
Date: Sat, 28 Feb 2026 12:26:27 -0500
Message-ID: <20260228173244.1509663-475-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220553-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 874441C83BD
X-Rspamd-Action: no action

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit a8d1d73c81d1e70d2aa49fdaf59d933bb783ffe5 ]

Upon receiving L2CAP_ECRED_CONN_REQ the given MTU shall be checked
against the suggested MTU of the listening socket as that is required
by the likes of PTS L2CAP/ECFC/BV-27-C test which expects
L2CAP_CR_LE_UNACCEPT_PARAMS if the MTU is lowers than socket omtu.

In order to be able to set chan->omtu the code now allows setting
setsockopt(BT_SNDMTU), but it is only allowed when connection has not
been stablished since there is no procedure to reconfigure the output
MTU.

Link: https://github.com/bluez/bluez/issues/1895
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c |  8 ++++++++
 net/bluetooth/l2cap_sock.c | 15 +++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a5038160675ea..29af3f63e89ce 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5101,6 +5101,14 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
+	/* Check if the listening channel has set an output MTU then the
+	 * requested MTU shall be less than or equal to that value.
+	 */
+	if (pchan->omtu && mtu < pchan->omtu) {
+		result = L2CAP_CR_LE_UNACCEPT_PARAMS;
+		goto unlock;
+	}
+
 	result = L2CAP_CR_LE_SUCCESS;
 
 	for (i = 0; i < num_scid; i++) {
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9ee189c815d49..66ab2754594d6 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1029,10 +1029,17 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		/* Setting is not supported as it's the remote side that
-		 * decides this.
-		 */
-		err = -EPERM;
+		/* Only allow setting output MTU when not connected */
+		if (sk->sk_state == BT_CONNECTED) {
+			err = -EISCONN;
+			break;
+		}
+
+		err = copy_safe_from_sockptr(&mtu, sizeof(mtu), optval, optlen);
+		if (err)
+			break;
+
+		chan->omtu = mtu;
 		break;
 
 	case BT_RCVMTU:
-- 
2.51.0


