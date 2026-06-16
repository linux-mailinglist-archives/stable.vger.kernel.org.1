Return-Path: <stable+bounces-264996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XkYfCFaBMWqElAUAu9opvQ
	(envelope-from <stable+bounces-264996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:01:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3D8692A83
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:01:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BuqqTLqo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264996-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-264996-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1220E30DADEE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC32A47AF6F;
	Tue, 16 Jun 2026 16:56:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91693478E45
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 16:55:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628960; cv=none; b=EvYtfp1ZeP5OjBxPiyVwCTAMK80CmKzWbFznq5S57dEW7Om5nRXpOCVe6pNWfkH/4T0lR/mXpDlcWBv+vE4MPlXPPerawbCmUOF47lT6LbMqDij8GTcEtYNSyXXr4FJlSYtu9cqcJlteOO7MfIPb/BpQDTLVnXyvtDc8Swp00Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628960; c=relaxed/simple;
	bh=+L61YVI/UzHosdMdDao1u0equ7xUrsf4xUcdakFXRTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0PN8Le89+PDjfMR5IGtrkp7ixSW2KEgUlB5QxBvgGzRX+LPG3p7M2Wlj4UOKRgA6kyjUnzyGkqtJuBPEHXX+5USLCMKLr8f9Iltqzag/j4mp5u462RecKOunRIXO4MN13fGiSWXYGd7IKuGosvl5aQRdZB26/WrdONbk/Pj5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuqqTLqo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69EF1F00A3A;
	Tue, 16 Jun 2026 16:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781628959;
	bh=gsXqEi0Pna1I/n0mLJM7Hpshv6GCzUY8F5t9ogDVyr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BuqqTLqodUBKV8l7V68v3yP8NMZcQ1+CNZT7GAK+0b9RZkdqkyL3TATSHjQUWV06t
	 5fdan3qh0O4VQbCN9F7Ez4Y/ZOmQTb/trpnYJbsBTIS7Urk7OrNyxaEKM5BM53MxrT
	 /dOr/n3S+TKE/rgyVqW+8DcEqwk2vF/yGjmsi0kN6X0ROtrFb3BLorEAxswzZRZk+R
	 8mNO04CdKskEHg2OwQu+YsVjK/ntgEo+HAIepX/UzOcyGgT2O6HIESGEGw/TaeI/jz
	 133H46MpJCNWTcX3qDPg3Tnxyxe9MX0Izht55goz3xgvoXGBdXWqRF1rKEGLhayHhG
	 LPii2kfOQ9bXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Long Li <longli@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] hv: utils: handle and propagate errors in kvp_register
Date: Tue, 16 Jun 2026 12:55:57 -0400
Message-ID: <20260616165557.3366587-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061557-scraggly-diligent-2098@gregkh>
References: <2026061557-scraggly-diligent-2098@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264996-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:thorsten.blum@linux.dev,m:longli@microsoft.com,m:wei.liu@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E3D8692A83

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 3fcf923302a8f5c0dc3af3d2ca2657cb5fae4297 ]

Make kvp_register() return an error code instead of silently ignoring
failures, and propagate the error from kvp_handle_handshake() instead of
returning success.

This propagates both kzalloc_obj() and hvutil_transport_send() failures
to kvp_handle_handshake() and thus to kvp_on_msg().

Fixes: 245ba56a52a3 ("Staging: hv: Implement key/value pair (KVP)")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/hv_kvp.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 62795f6cbb0019..8b409a3d41f048 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -93,7 +93,7 @@ static void kvp_send_key(struct work_struct *dummy);
 static void kvp_respond_to_host(struct hv_kvp_msg *msg, int error);
 static void kvp_timeout_func(struct work_struct *dummy);
 static void kvp_host_handshake_func(struct work_struct *dummy);
-static void kvp_register(int);
+static int kvp_register(int);
 
 static DECLARE_DELAYED_WORK(kvp_timeout_work, kvp_timeout_func);
 static DECLARE_DELAYED_WORK(kvp_host_handshake_work, kvp_host_handshake_func);
@@ -127,24 +127,26 @@ static void kvp_register_done(void)
 	hv_poll_channel(kvp_transaction.recv_channel, kvp_poll_wrapper);
 }
 
-static void
+static int
 kvp_register(int reg_value)
 {
 
 	struct hv_kvp_msg *kvp_msg;
 	char *version;
+	int ret;
 
 	kvp_msg = kzalloc(sizeof(*kvp_msg), GFP_KERNEL);
+	if (!kvp_msg)
+		return -ENOMEM;
 
-	if (kvp_msg) {
-		version = kvp_msg->body.kvp_register.version;
-		kvp_msg->kvp_hdr.operation = reg_value;
-		strcpy(version, HV_DRV_VERSION);
+	version = kvp_msg->body.kvp_register.version;
+	kvp_msg->kvp_hdr.operation = reg_value;
+	strcpy(version, HV_DRV_VERSION);
 
-		hvutil_transport_send(hvt, kvp_msg, sizeof(*kvp_msg),
-				      kvp_register_done);
-		kfree(kvp_msg);
-	}
+	ret = hvutil_transport_send(hvt, kvp_msg, sizeof(*kvp_msg),
+				    kvp_register_done);
+	kfree(kvp_msg);
+	return ret;
 }
 
 static void kvp_timeout_func(struct work_struct *dummy)
@@ -186,9 +188,8 @@ static int kvp_handle_handshake(struct hv_kvp_msg *msg)
 	 */
 	pr_debug("KVP: userspace daemon ver. %d connected\n",
 		 msg->kvp_hdr.operation);
-	kvp_register(dm_reg_value);
 
-	return 0;
+	return kvp_register(dm_reg_value);
 }
 
 
-- 
2.53.0


