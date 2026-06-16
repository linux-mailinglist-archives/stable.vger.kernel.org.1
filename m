Return-Path: <stable+bounces-265063-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OAHoGjuEMWqdlQUAu9opvQ
	(envelope-from <stable+bounces-265063-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:13:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3506692E0E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:13:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ud26Nobj;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265063-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265063-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88EEB32B58C2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3944657CF;
	Tue, 16 Jun 2026 17:01:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F55C43E4BC
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 17:01:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629289; cv=none; b=pjgKpRpAvlnqQ6FdICje3KvGhGPrS9Uv1kHeXPlW4iYWMnvq8FRkaYmG8jZO2HEwl1t+BrSCB73kzd1L/mqCYkXNhh5Qgl+VqMpCQjIztorTd64I+NLalpUi1VJm+0XglXA8mRvFw9w+6a8FsAb9joJKWH0VxrodvBfEboRc6YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629289; c=relaxed/simple;
	bh=sRO32Nws6B/xQoRqaeIWnb6n7Hg4q/oIxmARgeZ5F1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5c269/Dd8xcUfOw8kRiUGQhnuXzDNVjPllTkr5E8YvOQV2QEe5TtkXcJ90eWDIvJou1oa4SSkBy7poYQAIjeNJ+YMiF2fw//iLKPkgrC2KSulziTi26b6nN5F6detwJokirITH4Jc1A+VIh8ac6QN/22h59eWixMXAWSJNXuJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ud26Nobj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD191F000E9;
	Tue, 16 Jun 2026 17:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781629287;
	bh=rb3o+O/RaY5zLsgupgwLYtGG7y6qHbxQ3K+rPM5tLFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ud26NobjPRzZsVhksk8qrIBrnWDfFWDUD+wAHpGTMrZUiFGbZnWtUxa8cQiMMHpzX
	 rgYMA1WTJixBTZQze75QGfqaAEzmkYIj+kIdN3wA2OveVb0LhBFhkn3vFL0VPLWC4J
	 JXcaDWbtRtlCeBbVTo3d387MxklYgHh0ZEoo00Ri1mktwkJph/MDFFZopg80ZUxutr
	 yeJUEcoWb9N6TJW+peEDgmDCLHd7yjsZ5Z7f0ALZAbRcRHeNZhAUXEN63DZp6YKUEJ
	 RW2VJ+xtwA8jPpHp8u66I/1aVB4njlxXNUfPrLyg0mpGx6tkQ76j1t1RdsSW7IpLPq
	 VeQAtx4Q2z8rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Long Li <longli@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] hv: utils: handle and propagate errors in kvp_register
Date: Tue, 16 Jun 2026 13:01:25 -0400
Message-ID: <20260616170125.3368588-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061559-curled-seventh-d76a@gregkh>
References: <2026061559-curled-seventh-d76a@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265063-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3506692E0E

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
index 77017d9518267c..8019ef2cdcf2a3 100644
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


