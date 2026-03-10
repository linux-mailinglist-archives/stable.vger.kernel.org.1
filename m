Return-Path: <stable+bounces-224541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mESvKDpjsGloigIAu9opvQ
	(envelope-from <stable+bounces-224541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:30:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A29422566A6
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13E95301C5AF
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826E03128B0;
	Tue, 10 Mar 2026 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johannes-moeller.dev header.i=@johannes-moeller.dev header.b="Ujb1eEvO"
X-Original-To: stable@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88D2E6CD8
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167410; cv=none; b=aBKS3yhUBAlFMtUkDR9WTBuPNLp28gtgSD3r6KaRQK9MwgZYLr4mqlXAtf5O+ti7WDhQYgH8H+wEVBZEESuVSCJEgKvDREarjvPLHwXKg9ol+Stq4CPNdkZtun6xQ3fF9tjRIEqxmyBRf8+1EyZdo21kW/lnC2YdV4eoo05RwSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167410; c=relaxed/simple;
	bh=Q82pOOBE83e/q/m6f1OSGwQNAP+n7WowzUryYjeqrsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OymRrkDYrPwxKdZr1ycX/sfq4cBCl/8EUvAaGkdTdks5OEJ6rdfQh/3Iyk6G3cFfRudFOD35uYZsHNLYBkrZ2940FbaCEcQT6BW9vfN0SFvQfZam2tObrMH5mzJYxGCznakRAw8dzr6RIa/sRCPkiRlgD3jnzCRz0Dd0BpZ7kpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=johannes-moeller.dev; spf=fail smtp.mailfrom=johannes-moeller.dev; dkim=pass (2048-bit key) header.d=johannes-moeller.dev header.i=@johannes-moeller.dev header.b=Ujb1eEvO; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=johannes-moeller.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=johannes-moeller.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=johannes-moeller.dev; s=protonmail; t=1773167389; x=1773426589;
	bh=XJkQp5Wbj4iNMSJZmrOx0V0Aa05ZAU2aZ27gcUy+XHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ujb1eEvOlnVBtM+VH012y+UPScJfh+ZyTRJG3Jg9PPCkW8287WJDvPMMYT5E760bO
	 LJxmG1gcvzYurdyQvEb03U2BGay3aTY/6qhzU+lecTll4IWA8UE1Ag6bsPsTUKT2In
	 BUgdzjF+5j+mwyZpC7XImVZ+ycAODwnPJMD0Cnn0YH4eu6w8ElmyzvHFC9ovTtxYTa
	 +DlL3vk68hM7gjwcC8pu+PZeA+p1YvBtdNMVA8bYnDghHkYmSxD8t1IqgZivOgB+Ui
	 MzZLDXtWCRLUVcIpU6C0FCKz0e3WSUtra9YE3Jmi3L5Kgomy7fuV1hw/3ChcRQDDsw
	 cjP6YSgPcFk6A==
X-Pm-Submission-Id: 4fVj8p0BP0z2ScX9
From: =?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>
To: security@kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	w@1wt.eu,
	=?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix stack buffer overflow in deferred ECRED connection response
Date: Tue, 10 Mar 2026 19:28:31 +0100
Message-ID: <20260310182831.131781-1-research@johannes-moeller.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <abBJTIQolY8l0fxW@1wt.eu>
References: <abBJTIQolY8l0fxW@1wt.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A29422566A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[johannes-moeller.dev:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224541-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[johannes-moeller.dev];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,1wt.eu,johannes-moeller.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[research@johannes-moeller.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[johannes-moeller.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

l2cap_ecred_rsp_defer() appends channel SCIDs to
rsp_flex->dcid[rsp->count++] without checking rsp->count against
L2CAP_ECRED_MAX_CID.  The dcid[] flexible array member is backed by a
stack-allocated structure with room for only L2CAP_ECRED_MAX_CID (5)
entries.

Per-request validation in l2cap_ecred_conn_req() limits a single
L2CAP_ECRED_CONN_REQ to at most 5 SCIDs, but multiple requests can
reuse the same attacker-controlled signaling identifier.  When
__l2cap_ecred_conn_rsp_defer() later walks all channels with that
ident, the callback writes past the fixed backing array.  For LE links
(SCIDs 0x0040..0x007f) the maximum overwrite is 118 bytes past the end
of the buffer.

Add a bounds check in l2cap_ecred_rsp_defer() that cleans up excess
channels, and reject incoming requests in l2cap_ecred_conn_req() when
channels are already pending for the same ident.

Fixes: da49b602f7f7 ("Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED connections")
Cc: stable@vger.kernel.org
Signed-off-by: Lukas Johannes Möller <research@johannes-moeller.dev>
---
 net/bluetooth/l2cap_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ad98db9632fd..a0b56fb0afb0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3833,6 +3833,12 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
 	    !test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
 		return;
 
+	if (rsp->count >= L2CAP_ECRED_MAX_CID) {
+		chan->ident = 0;
+		l2cap_chan_del(chan, ECONNRESET);
+		return;
+	}
+
 	/* Reset ident so only one response is sent */
 	chan->ident = 0;
 
@@ -5132,6 +5138,15 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
+	/* Check if incoming channels are already pending for this ident */
+	list_for_each_entry(chan, &conn->chan_l, list) {
+		if (chan->ident == cmd->ident &&
+		    !test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags)) {
+			result = L2CAP_CR_LE_INVALID_PARAMS;
+			goto unlock;
+		}
+	}
+
 	result = L2CAP_CR_LE_SUCCESS;
 
 	for (i = 0; i < num_scid; i++) {

base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
-- 
2.43.0


