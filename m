Return-Path: <stable+bounces-249565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOrQOv9RDGqmfAUAu9opvQ
	(envelope-from <stable+bounces-249565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:05:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A31E57E4AB
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC81730CD79D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E926C481FA5;
	Tue, 19 May 2026 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="XB3b9wLY"
X-Original-To: stable@vger.kernel.org
Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDF8352014;
	Tue, 19 May 2026 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191483; cv=none; b=G/d6mLoVngcJywrq8qGfpnaekK+5FfmQZfaV72VwmWmAa9rnbkqK53VHRifFYM8zRvKAUY6KC1THj37iLREDxXxHvwWdIpi0foDcGAgnSLprox3bdlzYgXjbnXmrt9HNIKcFbbL8BCe5XL/SzB8N845vHFv8MIQ+t9s8wRyL+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191483; c=relaxed/simple;
	bh=paM6vdPGJA7P+/dgFbqX2Qi9b+I3osbE2ZVrd4bDiHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eHOx16Ae6rJQDhlC+EcUxVsIX7NJ7pwQYH9jKagT8M59fmHn5Yy1VSQkigCQLv6GH2cV65x4xJHFTkiwgQDgvfHTbgeBYCpf2gxP+JXclgDI/J5ByxhzB4lAuALMDbTv/KSOhBBH1/3TvU+WFjcwLrc359fMNb6LmMprJmi/9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=XB3b9wLY; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1779190911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PEXucm4+KvhT3oPCGhF+lrQv1vgkPmwJXzkJIzEa/A=;
	b=XB3b9wLYOArOYHetq2Wti57zfMnE4rRgkSCCk/I9VKtUa3iJ7uWYrIT/YuGvY56+iixDhr
	VF4vgY2t0hP84RCca+/EIrShtyoc3t/7Avietv+cxFapU+kzdOh9A2Cc5QEf0lEfqQwLJW
	7sKmrZyhiaWAyokcU8V+U4lI07D6ueDFyND1x1/QK4xolsQ1vI1IqT5QaQrV81R4DXRsmM
	/y7RMcTkcviuG12ULQ9zmeGiLbRxd7GoUgHXxA+PkvVLK4QUh/WlokL7IjGRp6ZGUbiVVi
	L3r3obDA1kd7oG2tPJJEbKwBNgE1kVdqq1wnyLTE8LUXLMH1Y6a5K/sOJzzQZQ==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Date: Tue, 19 May 2026 18:41:39 +0700
Subject: [PATCH 1/2] usb: typec: ucsi: Check if power role change actually
 happened before handling
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-ucsi-fix-2-v1-1-6f1239535187@qtmlabs.xyz>
References: <20260519-ucsi-fix-2-v1-0-6f1239535187@qtmlabs.xyz>
In-Reply-To: <20260519-ucsi-fix-2-v1-0-6f1239535187@qtmlabs.xyz>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>, stable@vger.kernel.org
X-Spamd-Bar: -------
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qtmlabs.xyz,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qtmlabs.xyz:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249565-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qtmlabs.xyz:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[myrrhperiwinkle@qtmlabs.xyz,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:url,qtmlabs.xyz:email,qtmlabs.xyz:mid,qtmlabs.xyz:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6A31E57E4AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The CrOS EC may send a connector status change event with the power
direction changed flag set even if the power direction hasn't actually
changed after initiating a SET_PDR command internally [1]. In practice
this happens on every system suspend due to other changes performed by
the EC [2][3][4], causing suspend to fail.

Fix this by checking if the power role change actually happened before
handling it.

[1]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=1689;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
[2]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=3923;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
[3]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=5094;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794
[4]: https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/ec/zephyr/subsys/pd_controller/pdc_power_mgmt.c;l=2229;drc=2d5a1cffce4e5ac8a39442cb3b764d2d5e1cf794

Cc: stable@vger.kernel.org
Fixes: 7616f006db07 ("usb: typec: ucsi: Update power_supply on power role change")
Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
---
 drivers/usb/typec/ucsi/ucsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 5b7ad9e99cb9..e19b656609e4 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1277,7 +1277,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 						  work);
 	struct ucsi *ucsi = con->ucsi;
 	u8 curr_scale, volt_scale;
-	enum typec_role role;
+	enum typec_role role, prev_role;
 	u16 change;
 	int ret;
 	u32 val;
@@ -1288,6 +1288,8 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 		dev_err_once(ucsi->dev, "%s entered without EVENT_PENDING\n",
 			     __func__);
 
+	prev_role = UCSI_CONSTAT(con, PWR_DIR);
+
 	ret = ucsi_get_connector_status(con, true);
 	if (ret) {
 		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
@@ -1304,7 +1306,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	change = UCSI_CONSTAT(con, CHANGE);
 	role = UCSI_CONSTAT(con, PWR_DIR);
 
-	if (change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
+	if ((change & UCSI_CONSTAT_POWER_DIR_CHANGE) && role != prev_role) {
 		typec_set_pwr_role(con->port, role);
 		ucsi_port_psy_changed(con);
 

-- 
2.54.0


