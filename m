Return-Path: <stable+bounces-268240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CBuvJIeBPGplowgAu9opvQ
	(envelope-from <stable+bounces-268240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 03:16:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 169816C2193
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 03:16:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=XTPlXxD3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268240-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268240-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B66B301EF58
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 01:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ED5314A8E;
	Thu, 25 Jun 2026 01:16:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7842B2D7;
	Thu, 25 Jun 2026 01:16:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782350210; cv=none; b=Zrpi5OLoJL/WoYMHGAoSdR3AbNtpG+3FqI/gF9/1z05u2thyRV6hQIimtQ3bbiv5MXF4eW23+sKRvtfyZ+iYtgb7gMeAh1oFKy1lLhiBSl5lCX4uU/xpku2dKusgUxfkClsG9M58pmETOPrncFnkdJYgAtmDCPof4HEy39JiBmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782350210; c=relaxed/simple;
	bh=bWjgzOiss5rncFwrFsXra0zcfyL6qXVwPOqWWql6Pgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IOdZJMxfrL+cWEfzhKsIs6dtjyOipkBl0VbJyQr1GeU0mxoY6nk9qd70W+AeSzgsWxuIuIhJF1So4cKQMVRkM/zHmfE3KIf6vnyG7BA5DVmmLbp/UE1zKIurc2uEHGcL9rj7evuquA3e469s0K4gxJSgutwMIgrNBsV8j0sS8Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XTPlXxD3; arc=none smtp.client-ip=117.135.210.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GU
	6I1Ll3K1QM1UvrFJ6ycsSbd981EIeymAe7fRZaVAs=; b=XTPlXxD3VG0XITwiIp
	EZYjR4iVOflmRpZqZd5SWJaEOsLnb8DmjtbkIpy4q1vi5Nc6fDvJ8gXcqgWvD2B6
	mljRPuxu3gw/YSOYiTTBIA11s1hYNuGUKlnTG/j9fSc7zIpxxnjbxXBYtYoGmx1M
	mp24LakG5c7sVtM+HGnJWes9U=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3Xwu3gDxqOQ4NEQ--.52354S2;
	Thu, 25 Jun 2026 09:13:29 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	bleung@chromium.org,
	abelvesa@kernel.org,
	myrrhperiwinkle@qtmlabs.xyz,
	jthies@google.com,
	johan@kernel.org,
	pooja.katiyar@intel.com,
	yuanhsinte@chromium.org,
	quic_linyyuan@quicinc.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: typec: ucsi: destroy work queue on fwnode_usb_role_switch_get() fails
Date: Thu, 25 Jun 2026 09:13:26 +0800
Message-Id: <20260625011326.3411572-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3Xwu3gDxqOQ4NEQ--.52354S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWfCrW8Ww43JF4Utr4rAFb_yoW8WF45pr
	Zakw4jqw18JF43WanrK3WDWF1Yg3W8JFy7Jr4Iqw18KrsxJw4DXw18tFyYgF15WFZ7WFnI
	yFWDJrykua4DurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piyE_tUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7hn3Zmo8gLn91QAA3h
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:heikki.krogerus@linux.intel.com,m:gregkh@linuxfoundation.org,m:bleung@chromium.org,m:abelvesa@kernel.org,m:myrrhperiwinkle@qtmlabs.xyz,m:jthies@google.com,m:johan@kernel.org,m:pooja.katiyar@intel.com,m:yuanhsinte@chromium.org,m:quic_linyyuan@quicinc.com,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268240-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 169816C2193

Call destroy_workqueue() if fwnode_usb_role_switch_get() fails
to destroy the work queue con->wq.

Fixes: 3c162511530c ("usb: typec: ucsi: Wait for the USB role switches")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
 - Use a common err_destroy_workqueue error path. Thanks, Heikki!
---
 drivers/usb/typec/ucsi/ucsi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 61cb24ed820f..4503661b85d5 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1663,9 +1663,12 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 
 	cap->fwnode = ucsi_find_fwnode(con);
 	con->usb_role_sw = fwnode_usb_role_switch_get(cap->fwnode);
-	if (IS_ERR(con->usb_role_sw))
-		return dev_err_probe(ucsi->dev, PTR_ERR(con->usb_role_sw),
-			"con%d: failed to get usb role switch\n", con->num);
+	if (IS_ERR(con->usb_role_sw)) {
+		ret = PTR_ERR(con->usb_role_sw);
+		dev_err(ucsi->dev, "con%d: failed to get usb role switch\n",
+			con->num);
+		goto err_destroy_workqueue;
+	}
 
 	/* Delay other interactions with the con until registration is complete */
 	mutex_lock(&con->lock);
@@ -1803,7 +1806,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 	fwnode_handle_put(cap->fwnode);
 out_unlock:
 	mutex_unlock(&con->lock);
-
+err_destroy_workqueue:
 	if (ret && con->wq) {
 		destroy_workqueue(con->wq);
 		con->wq = NULL;
-- 
2.25.1


