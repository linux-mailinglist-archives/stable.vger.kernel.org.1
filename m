Return-Path: <stable+bounces-255752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPtrK7qnGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:38:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED6D5F92C9
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76D45307FAA2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AD22F39B4;
	Thu, 28 May 2026 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X1GgIyJw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92342E7379;
	Thu, 28 May 2026 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999784; cv=none; b=UqO4Cppsx2VqMXwDD8UaIDbd5w0ovuUL5U+rKmk+Rq6t2lGrBxl2WTICHnX84xXlo23w0py4kl8oWPAXp41r3Vq+Nbphbri8X5vdmCzg0xgY9V+eB/BjZifSb7aAwKadRD/adX8fpFZ/m/QBRn1EGGMTz2XRuYLSceUOEcxF2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999784; c=relaxed/simple;
	bh=p2GEqp29OGcEP0mp8bhGLIYkeLrcmlJtxCaDUX1RIbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6gq2jkuFi9cw+XlO1mZ75mQyrR1a/Gq/mGxpsbgM31vrJhDI9GmV8O4h6rYw9tl3e+/lZhYd32TReMCaI0vpsX4PpTFKUQ5y9Wm4gU+o6onQ1lP7AY6hxKDbNFxZjp2so6q4ox7r/rrjfIOvF52cykpYocU/7NK2iDNIQn0w+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X1GgIyJw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5316D1F000E9;
	Thu, 28 May 2026 20:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999783;
	bh=ABgjEr5wfHajZztHrZjShektjImsq5IFZmT8Ubh/BTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X1GgIyJwNzFG5Urqjr1ypxXzcgV/CNc70vL64OdFdHgIjStwozgewodUl7FrrE+dg
	 m4zB1QzuGNP1DjPdknQGwwzKPGBDZN410SBGj5Le3cbh3nkTbasPijXDFAYTmL4cBn
	 NAI1sYVRYTJurRlEyPpF2pZFzTrSLJ0dJjum1I+4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 189/377] firmware: arm_ffa: Keep framework RX release under lock
Date: Thu, 28 May 2026 21:47:07 +0200
Message-ID: <20260528194643.887082810@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-255752-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2ED6D5F92C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudeep Holla <sudeep.holla@kernel.org>

[ Upstream commit 2af18f8e36b277730527cacc2256b1332f56aa28 ]

The framework notification handler drops rx_lock before issuing
FFA_RX_RELEASE, leaving a window where another RX-buffer user can
start a new FF-A transaction before ownership has actually been
returned to firmware.

Move the FFA_RX_RELEASE calls so they execute while rx_lock is still
held on both the kmemdup() failure path and the normal success path.
While doing that, switch the handler to scoped_guard() to keep the
critical section explicit.

Fixes: 285a5ea0f542 ("firmware: arm_ffa: Add support for handling framework notifications")
Link: https://patch.msgid.link/20260428-ffa_fixes-v2-7-8595ae450034@kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index e597a9cf64dc9..c6a9bf3497cf7 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1488,25 +1488,22 @@ static void handle_fwk_notif_callbacks(u32 bitmap)
 	if (!(bitmap & FRAMEWORK_NOTIFY_RX_BUFFER_FULL))
 		return;
 
-	mutex_lock(&drv_info->rx_lock);
+	scoped_guard(mutex, &drv_info->rx_lock) {
+		msg = drv_info->rx_buffer;
+		buf = kmemdup((void *)msg + msg->offset, msg->size, GFP_KERNEL);
+		if (!buf) {
+			ffa_rx_release();
+			return;
+		}
 
-	msg = drv_info->rx_buffer;
-	buf = kmemdup((void *)msg + msg->offset, msg->size, GFP_KERNEL);
-	if (!buf) {
-		mutex_unlock(&drv_info->rx_lock);
-		return;
+		target = SENDER_ID(msg->send_recv_id);
+		if (msg->offset >= sizeof(*msg))
+			uuid_copy(&uuid, &msg->uuid);
+		else
+			uuid_copy(&uuid, &uuid_null);
+		ffa_rx_release();
 	}
 
-	target = SENDER_ID(msg->send_recv_id);
-	if (msg->offset >= sizeof(*msg))
-		uuid_copy(&uuid, &msg->uuid);
-	else
-		uuid_copy(&uuid, &uuid_null);
-
-	mutex_unlock(&drv_info->rx_lock);
-
-	ffa_rx_release();
-
 	read_lock(&drv_info->notify_lock);
 	cb_info = notifier_hnode_get_by_vmid_uuid(notify_id, target, &uuid);
 	read_unlock(&drv_info->notify_lock);
-- 
2.53.0




