Return-Path: <stable+bounces-235083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPXtHAuq1mlKHAgAu9opvQ
	(envelope-from <stable+bounces-235083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:18:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC683C2BBF
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC060318BCFB
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F46C3D8918;
	Wed,  8 Apr 2026 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WGsiAR9i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026BD3D75C9;
	Wed,  8 Apr 2026 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674526; cv=none; b=Jv+A2VsG+LpwArBuBWerKi+pOtfPKBpnoprGbscF6ZjzFGz9mI2l0B58+MwS0MHKXos9Fpaeq9IjqfXINOBhIhdcdDeks/9oVvUBj8ZhxvXCIEzp1kUu63jsLyWaa9YSUbHTetvraK3CV82UTfk6lT+UoSAuo9MQgd6grGZIEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674526; c=relaxed/simple;
	bh=sr2wAI7uIz2qxYcSZT3l2zxEa9xLOO17LXk1LbVfMno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S33uOhOf8PH57nODoVBoTcyyGeg72eTKv1HZGKAg5uW+GxYwxtIZWMa0idKHGfitDPsd3dItGHq20e1ZzrQ1r6bfkyicPOl4NqedwoifouRVVycJheDm2t9ucI6H65XGivH2l7xPR5z7CFgq9AlmNfSOitrqK21WokkLjUMQVrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WGsiAR9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481C3C19421;
	Wed,  8 Apr 2026 18:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674525;
	bh=sr2wAI7uIz2qxYcSZT3l2zxEa9xLOO17LXk1LbVfMno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WGsiAR9iotGfZlvARFGDEzEiIJTCiYcpBSELv7ew7yxJBUDlqA979UResgPmEmvEg
	 wqJsXCYEM9veqd+rStcgLTD6qjqfGLvDFSW4T97ZHnyrt/OtLmweCEe0iMpsdJUVl8
	 jpmUcFepD6rK70ASiSm17nCd28POjw0TiM+LQ7to=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 104/311] Bluetooth: hci_event: fix potential UAF in hci_le_remote_conn_param_req_evt
Date: Wed,  8 Apr 2026 20:01:44 +0200
Message-ID: <20260408175943.296545259@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235083-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,iki.fi:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAC683C2BBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit b255531b27da336571411248c2a72a350662bd09 ]

hci_conn lookup and field access must be covered by hdev lock in
hci_le_remote_conn_param_req_evt, otherwise it's possible it is freed
concurrently.

Extend the hci_dev_lock critical section to cover all conn usage.

Fixes: 95118dd4edfec ("Bluetooth: hci_event: Use of a function table to handle LE subevents")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 467710a42d453..3869ff3b8bea6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6767,25 +6767,31 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
 	latency = le16_to_cpu(ev->latency);
 	timeout = le16_to_cpu(ev->timeout);
 
+	hci_dev_lock(hdev);
+
 	hcon = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!hcon || hcon->state != BT_CONNECTED)
-		return send_conn_param_neg_reply(hdev, handle,
-						 HCI_ERROR_UNKNOWN_CONN_ID);
+	if (!hcon || hcon->state != BT_CONNECTED) {
+		send_conn_param_neg_reply(hdev, handle,
+					  HCI_ERROR_UNKNOWN_CONN_ID);
+		goto unlock;
+	}
 
-	if (max > hcon->le_conn_max_interval)
-		return send_conn_param_neg_reply(hdev, handle,
-						 HCI_ERROR_INVALID_LL_PARAMS);
+	if (max > hcon->le_conn_max_interval) {
+		send_conn_param_neg_reply(hdev, handle,
+					  HCI_ERROR_INVALID_LL_PARAMS);
+		goto unlock;
+	}
 
-	if (hci_check_conn_params(min, max, latency, timeout))
-		return send_conn_param_neg_reply(hdev, handle,
-						 HCI_ERROR_INVALID_LL_PARAMS);
+	if (hci_check_conn_params(min, max, latency, timeout)) {
+		send_conn_param_neg_reply(hdev, handle,
+					  HCI_ERROR_INVALID_LL_PARAMS);
+		goto unlock;
+	}
 
 	if (hcon->role == HCI_ROLE_MASTER) {
 		struct hci_conn_params *params;
 		u8 store_hint;
 
-		hci_dev_lock(hdev);
-
 		params = hci_conn_params_lookup(hdev, &hcon->dst,
 						hcon->dst_type);
 		if (params) {
@@ -6798,8 +6804,6 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
 			store_hint = 0x00;
 		}
 
-		hci_dev_unlock(hdev);
-
 		mgmt_new_conn_param(hdev, &hcon->dst, hcon->dst_type,
 				    store_hint, min, max, latency, timeout);
 	}
@@ -6813,6 +6817,9 @@ static void hci_le_remote_conn_param_req_evt(struct hci_dev *hdev, void *data,
 	cp.max_ce_len = 0;
 
 	hci_send_cmd(hdev, HCI_OP_LE_CONN_PARAM_REQ_REPLY, sizeof(cp), &cp);
+
+unlock:
+	hci_dev_unlock(hdev);
 }
 
 static void hci_le_direct_adv_report_evt(struct hci_dev *hdev, void *data,
-- 
2.53.0




