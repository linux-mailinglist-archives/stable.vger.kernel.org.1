Return-Path: <stable+bounces-255331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHK4OOefGGpAlggAu9opvQ
	(envelope-from <stable+bounces-255331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:04:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3D35F7CA3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 880E1302EA86
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE3F3164B7;
	Thu, 28 May 2026 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pl0Dk4Ii"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85012F260C;
	Thu, 28 May 2026 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998610; cv=none; b=b/D913DFHa4PD2NCcLAlbgETLBC+arJRNiImjoNJjNsW/LOeR9czcrgfd35sXiJicgJe64gDKKo5CTf0qB5m6KYq8fceWd2vnM/j8df58M1oADt+xZcJl0fDdgo8SZj1vuZxQKak3oUBQ5HUJa+n/VitQt1632Izg2TcQI5QFW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998610; c=relaxed/simple;
	bh=wWyK9adq24okqCDSzpIVQi1KdrHUz3B4hP1N2Ndy/yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9LDi1YIUeEV1ZSQSR4g6gsSTe276CxOIa/HpQnHrMk521/nT87FImELL6ReWW4p/OHpbuzx0TmHivLNVZCaCsI79GKQqLzl/5E6+KFn2JDhofdcovoB/6ZVcJ9aJkLtlOZpKutI/5Bv7IAjPph0K0fcqIIrsxCg/mmIE+2BruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pl0Dk4Ii; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E281F000E9;
	Thu, 28 May 2026 20:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998609;
	bh=1ETdE9otAToC1P9Lchukd734Abj7ltKRqb5NXGK49xA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pl0Dk4IiOk5pP7pHqHIcDkUvktGdVjIi0qsCujWQCPV5ncNP4ah+JSf3VWOVhrD0d
	 8vbfd8K1XGgtbR00MoJFXSxUpviI91EYjMWmJsVY7vP21fDTXnRQISZQfArhxB0hMe
	 asDPGHEm/HUgynZA3J9SnTdz/3nZw21pwUyaHzls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 198/461] firmware: arm_ffa: Keep framework RX release under lock
Date: Thu, 28 May 2026 21:45:27 +0200
Message-ID: <20260528194652.816404886@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255331-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 9B3D35F7CA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index e15fda86b6bce..23623b61f2682 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1492,25 +1492,22 @@ static void handle_fwk_notif_callbacks(u32 bitmap)
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




