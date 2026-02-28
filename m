Return-Path: <stable+bounces-220549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOwZJS9Oo2nw/QQAu9opvQ
	(envelope-from <stable+bounces-220549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:21:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E623F1C8407
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 526F831FB608
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19F83D564D;
	Sat, 28 Feb 2026 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qwts9uwf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E553D5646;
	Sat, 28 Feb 2026 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300431; cv=none; b=Qeo7r1XzPCw2e4il8zlzg0H5NkdjP/uBPAgwZT/fRXdtPABvIYDveltY+PysROM5I4BPjKb3HZKqHa7c5GMUalYdinpC4RQSqVXDWewlp46knCoFBUm9M+XIKHaSCJzHbkn+ACEIGgGBRG9g6xFe2gpGmeIlIlomFFuLxqtwkHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300431; c=relaxed/simple;
	bh=ocHrck2TQZJancoEowj8OAOvZJd3MHztoq2hv2rFfTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxHejTTBOKkVKU0Y7p8GrGQz7UyGiOx9dSy6EZoaVSbTCJNIM+1QD+ozN/lIBwKrAgruaa6nTlv+2fzeVy9IprMEzsml35sd4HfF5rHZMauFxQxLWHYcU5M7ZkRaxtzR/EURlE9QVtRyJuGSNHFKgWqA9Lz3ZAVk4JIDIDlrQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qwts9uwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2447C116D0;
	Sat, 28 Feb 2026 17:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300431;
	bh=ocHrck2TQZJancoEowj8OAOvZJd3MHztoq2hv2rFfTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qwts9uwfgtUGtOI1mjNLBRqlVkcIYQDyJjWp71apbu0Sg7bjBmQ66NWdg9pKND0ZD
	 go5ivAqXaGvH/Ha/a4m68meDkRywF99Ykq5Im6Grsf3413ZfA1Tb9EYpNEXuqLOT+Z
	 f7UVtI4ney8QWXja63O4CVQT/8eAzEtdTb9ZgOL6eAZ6VlgOxMZ8lPaW/nRxRWuzlK
	 a+ThwvT0fh0CaEkTos5dUhnwWALKzODBN7nFrTPjjJujZHRBytLS1K5LPV1fB8tj1c
	 Tlq3pQc0tSFLriZKvd8kqGGCO80SCmWwcR1SoKzEqcAiyPFZIyEciAjiSs7i+Yin1N
	 w2BFtOXHecxLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 470/844] Bluetooth: L2CAP: Fix invalid response to L2CAP_ECRED_RECONF_REQ
Date: Sat, 28 Feb 2026 12:26:23 -0500
Message-ID: <20260228173244.1509663-471-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220549-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E623F1C8407
X-Rspamd-Action: no action

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 7accb1c4321acb617faf934af59d928b0b047e2b ]

This fixes responding with an invalid result caused by checking the
wrong size of CID which should have been (cmd_len - sizeof(*req)) and
on top of it the wrong result was use L2CAP_CR_LE_INVALID_PARAMS which
is invalid/reserved for reconf when running test like L2CAP/ECFC/BI-03-C:

> ACL Data RX: Handle 64 flags 0x02 dlen 14
      LE L2CAP: Enhanced Credit Reconfigure Request (0x19) ident 2 len 6
        MTU: 64
        MPS: 64
        Source CID: 64
< ACL Data TX: Handle 64 flags 0x00 dlen 10
      LE L2CAP: Enhanced Credit Reconfigure Respond (0x1a) ident 2 len 2
!        Result: Reserved (0x000c)
         Result: Reconfiguration failed - one or more Destination CIDs invalid (0x0003)

Fiix L2CAP/ECFC/BI-04-C which expects L2CAP_RECONF_INVALID_MPS (0x0002)
when more than one channel gets its MPS reduced:

> ACL Data RX: Handle 64 flags 0x02 dlen 16
      LE L2CAP: Enhanced Credit Reconfigure Request (0x19) ident 2 len 8
        MTU: 264
        MPS: 99
        Source CID: 64
!       Source CID: 65
< ACL Data TX: Handle 64 flags 0x00 dlen 10
      LE L2CAP: Enhanced Credit Reconfigure Respond (0x1a) ident 2 len 2
!        Result: Reconfiguration successful (0x0000)
         Result: Reconfiguration failed - reduction in size of MPS not allowed for more than one channel at a time (0x0002)

Fix L2CAP/ECFC/BI-05-C when SCID is invalid (85 unconnected):

> ACL Data RX: Handle 64 flags 0x02 dlen 14
      LE L2CAP: Enhanced Credit Reconfigure Request (0x19) ident 2 len 6
        MTU: 65
        MPS: 64
!        Source CID: 85
< ACL Data TX: Handle 64 flags 0x00 dlen 10
      LE L2CAP: Enhanced Credit Reconfigure Respond (0x1a) ident 2 len 2
!        Result: Reconfiguration successful (0x0000)
         Result: Reconfiguration failed - one or more Destination CIDs invalid (0x0003)

Fix L2CAP/ECFC/BI-06-C when MPS < L2CAP_ECRED_MIN_MPS (64):

> ACL Data RX: Handle 64 flags 0x02 dlen 14
      LE L2CAP: Enhanced Credit Reconfigure Request (0x19) ident 2 len 6
        MTU: 672
!       MPS: 63
        Source CID: 64
< ACL Data TX: Handle 64 flags 0x00 dlen 10
      LE L2CAP: Enhanced Credit Reconfigure Respond (0x1a) ident 2 len 2
!       Result: Reconfiguration failed - reduction in size of MPS not allowed for more than one channel at a time (0x0002)
        Result: Reconfiguration failed - other unacceptable parameters (0x0004)

Fix L2CAP/ECFC/BI-07-C when MPS reduced for more than one channel:

> ACL Data RX: Handle 64 flags 0x02 dlen 16
      LE L2CAP: Enhanced Credit Reconfigure Request (0x19) ident 3 len 8
        MTU: 84
!       MPS: 71
        Source CID: 64
!        Source CID: 65
< ACL Data TX: Handle 64 flags 0x00 dlen 10
      LE L2CAP: Enhanced Credit Reconfigure Respond (0x1a) ident 2 len 2
!       Result: Reconfiguration successful (0x0000)
        Result: Reconfiguration failed - reduction in size of MPS not allowed for more than one channel at a time (0x0002)

Link: https://github.com/bluez/bluez/issues/1865
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/l2cap.h |  2 ++
 net/bluetooth/l2cap_core.c    | 63 +++++++++++++++++++++++++----------
 2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 00e182a22720a..9820ccc379f1c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -493,6 +493,8 @@ struct l2cap_ecred_reconf_req {
 #define L2CAP_RECONF_SUCCESS		0x0000
 #define L2CAP_RECONF_INVALID_MTU	0x0001
 #define L2CAP_RECONF_INVALID_MPS	0x0002
+#define L2CAP_RECONF_INVALID_CID	0x0003
+#define L2CAP_RECONF_INVALID_PARAMS	0x0004
 
 struct l2cap_ecred_reconf_rsp {
 	__le16 result;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 07b493331fd78..e705b4a171dec 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5294,14 +5294,14 @@ static inline int l2cap_ecred_reconf_req(struct l2cap_conn *conn,
 	struct l2cap_ecred_reconf_req *req = (void *) data;
 	struct l2cap_ecred_reconf_rsp rsp;
 	u16 mtu, mps, result;
-	struct l2cap_chan *chan;
+	struct l2cap_chan *chan[L2CAP_ECRED_MAX_CID] = {};
 	int i, num_scid;
 
 	if (!enable_ecred)
 		return -EINVAL;
 
-	if (cmd_len < sizeof(*req) || cmd_len - sizeof(*req) % sizeof(u16)) {
-		result = L2CAP_CR_LE_INVALID_PARAMS;
+	if (cmd_len < sizeof(*req) || (cmd_len - sizeof(*req)) % sizeof(u16)) {
+		result = L2CAP_RECONF_INVALID_CID;
 		goto respond;
 	}
 
@@ -5311,42 +5311,69 @@ static inline int l2cap_ecred_reconf_req(struct l2cap_conn *conn,
 	BT_DBG("mtu %u mps %u", mtu, mps);
 
 	if (mtu < L2CAP_ECRED_MIN_MTU) {
-		result = L2CAP_RECONF_INVALID_MTU;
+		result = L2CAP_RECONF_INVALID_PARAMS;
 		goto respond;
 	}
 
 	if (mps < L2CAP_ECRED_MIN_MPS) {
-		result = L2CAP_RECONF_INVALID_MPS;
+		result = L2CAP_RECONF_INVALID_PARAMS;
 		goto respond;
 	}
 
 	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
+
+	if (num_scid > L2CAP_ECRED_MAX_CID) {
+		result = L2CAP_RECONF_INVALID_PARAMS;
+		goto respond;
+	}
+
 	result = L2CAP_RECONF_SUCCESS;
 
+	/* Check if each SCID, MTU and MPS are valid */
 	for (i = 0; i < num_scid; i++) {
 		u16 scid;
 
 		scid = __le16_to_cpu(req->scid[i]);
-		if (!scid)
-			return -EPROTO;
+		if (!scid) {
+			result = L2CAP_RECONF_INVALID_CID;
+			goto respond;
+		}
 
-		chan = __l2cap_get_chan_by_dcid(conn, scid);
-		if (!chan)
-			continue;
+		chan[i] = __l2cap_get_chan_by_dcid(conn, scid);
+		if (!chan[i]) {
+			result = L2CAP_RECONF_INVALID_CID;
+			goto respond;
+		}
 
-		/* If the MTU value is decreased for any of the included
-		 * channels, then the receiver shall disconnect all
-		 * included channels.
+		/* The MTU field shall be greater than or equal to the greatest
+		 * current MTU size of these channels.
 		 */
-		if (chan->omtu > mtu) {
-			BT_ERR("chan %p decreased MTU %u -> %u", chan,
-			       chan->omtu, mtu);
+		if (chan[i]->omtu > mtu) {
+			BT_ERR("chan %p decreased MTU %u -> %u", chan[i],
+			       chan[i]->omtu, mtu);
 			result = L2CAP_RECONF_INVALID_MTU;
+			goto respond;
 		}
 
-		chan->omtu = mtu;
-		chan->remote_mps = mps;
+		/* If more than one channel is being configured, the MPS field
+		 * shall be greater than or equal to the current MPS size of
+		 * each of these channels. If only one channel is being
+		 * configured, the MPS field may be less than the current MPS
+		 * of that channel.
+		 */
+		if (chan[i]->remote_mps >= mps && i) {
+			BT_ERR("chan %p decreased MPS %u -> %u", chan[i],
+			       chan[i]->remote_mps, mps);
+			result = L2CAP_RECONF_INVALID_MPS;
+			goto respond;
+		}
+	}
+
+	/* Commit the new MTU and MPS values after checking they are valid */
+	for (i = 0; i < num_scid; i++) {
+		chan[i]->omtu = mtu;
+		chan[i]->remote_mps = mps;
 	}
 
 respond:
-- 
2.51.0


