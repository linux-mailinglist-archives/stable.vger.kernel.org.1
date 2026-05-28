Return-Path: <stable+bounces-255799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAbHGpumGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:33:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B878F5F8F34
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59FE73101767
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC52732A3FF;
	Thu, 28 May 2026 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v/7t1/Ka"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55662E7379;
	Thu, 28 May 2026 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999915; cv=none; b=rIGzUBWiKzLlC0OGz+S/fObgDb8RtyCP8vNlrGS0W7y2ZAe4Q5DzH1fgqHtDkxhMoQmzRxSBCnyxpM6RDREtKccse7BQOup6xLXEqzszXNSUVjXQhIjIVCFIaxCng3CGFA7QEogLhl8QFPdb5IcKtXx4Ixaw3GxtI+LMhjB7HdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999915; c=relaxed/simple;
	bh=PBwggOUXmDq44fDG0Ehl1cmTxJjpdj8VMCSOZWmgdQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4arW3y78WBSjNsd5JKv9vBX1jIe+FdIn5XbiWkt7itlYH9CH+UCMAuevZK0AFqd/WocFBnGma+qNODZXxcvchfpPQdEAXHvUjnD+6NXZHC7w2x6ha8SUz2iL4+HI/O0rRp+gI1dKcWaBabuWzo6Gx5lzSqGyZnHOI0IImvxR0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v/7t1/Ka; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D93F1F000E9;
	Thu, 28 May 2026 20:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999914;
	bh=6jLSDX3e3Mw0tHMsRlbjn5vCjnc4FFQrmvkzRK8OkPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=v/7t1/Kak3HI4Pc09pPMTticUILsdqmzYllJlLHxChhtK6ek7j4CZkHxpM+ArSWUE
	 0pAxq5OdTNn8k28AOcKHJsYpzWQsCJR1CE6akoruMT9jpG4hc+zMpRbfIbOjxJ9aIi
	 0UA6F7oJjCYdV/MePTeG2Qvwl0OTu6/C7oLtD3D0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 190/377] firmware: arm_ffa: Validate framework notification message layout
Date: Thu, 28 May 2026 21:47:08 +0200
Message-ID: <20260528194643.914439432@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255799-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[msgid.link:server fail,sea.lore.kernel.org:server fail,linuxfoundation.org:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B878F5F8F34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudeep Holla <sudeep.holla@kernel.org>

[ Upstream commit 4a1cc9e96b311d2609a6f963a5e35bd4ae730d97 ]

Framework notifications carry an indirect message in the shared RX
buffer. Validate the reported offset and size before using them, reject
zero-length payloads, and ensure that any non-header payload starts at
the UUID field rather than in the middle of the message header.

Use the validated offset and size values for both kmemdup() and the UUID
parsing path so malformed firmware data cannot drive an out-of-bounds
read or an oversized allocation.

Fixes: 285a5ea0f542 ("firmware: arm_ffa: Add support for handling framework notifications")
Link: https://patch.msgid.link/20260428-ffa_fixes-v2-8-8595ae450034@kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index c6a9bf3497cf7..f96bb84af55e3 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1483,21 +1483,35 @@ static void handle_fwk_notif_callbacks(u32 bitmap)
 	int notify_id = 0, target;
 	struct ffa_indirect_msg_hdr *msg;
 	struct notifier_cb_info *cb_info = NULL;
+	size_t min_offset = offsetof(struct ffa_indirect_msg_hdr, uuid);
 
 	/* Only one framework notification defined and supported for now */
 	if (!(bitmap & FRAMEWORK_NOTIFY_RX_BUFFER_FULL))
 		return;
 
 	scoped_guard(mutex, &drv_info->rx_lock) {
+		u32 offset, size;
+
 		msg = drv_info->rx_buffer;
-		buf = kmemdup((void *)msg + msg->offset, msg->size, GFP_KERNEL);
+		offset = msg->offset;
+		size = msg->size;
+
+		if (!size || (offset != min_offset && offset < sizeof(*msg)) ||
+		    offset > drv_info->rxtx_bufsz ||
+		    size > drv_info->rxtx_bufsz - offset) {
+			pr_err("invalid framework notification message\n");
+			ffa_rx_release();
+			return;
+		}
+
+		buf = kmemdup((void *)msg + offset, size, GFP_KERNEL);
 		if (!buf) {
 			ffa_rx_release();
 			return;
 		}
 
 		target = SENDER_ID(msg->send_recv_id);
-		if (msg->offset >= sizeof(*msg))
+		if (offset >= sizeof(*msg))
 			uuid_copy(&uuid, &msg->uuid);
 		else
 			uuid_copy(&uuid, &uuid_null);
-- 
2.53.0




