Return-Path: <stable+bounces-242915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLSzBLxc+GnatQIAu9opvQ
	(envelope-from <stable+bounces-242915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:45:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B22D4BA744
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8085E3005EB2
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37962E6CB3;
	Mon,  4 May 2026 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U6OVXNAS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E1289E13
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884343; cv=none; b=pxG78shH8txAFp/1x20Xe0dRbdgn104Fk0wFpBpoyQu5DNenwjh4TeMwWyZZcnAe/fvCZNr/RECAU42WqG9KO/XeCXghh2kR3ed9VHuFMzdWiJIR/NT0l8miKFMdGcO3Iy4Z3CS6kE+AkkUaXXUZAzj37hqwwIJ+rrkW6Z4ySYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884343; c=relaxed/simple;
	bh=L/40mcABEYuNZ88OU0p1kTwUBwH8ZERmZ/hgMUozE2Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CIaSt96Z2YXKzmZctiQW9JKFLkJ947o/w8qOobYIddPe43bMDTgIoUA8wVhM3aEutGyB1ifByGpoWISgeyzG0yZiSPAm50D+Z0apFok83ZFBGwemcrYOoGAkp2kVGCOWT48cG/mg1fJeQLt3mwLJU3NVd9MpY/B/zjQEg+G5o1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U6OVXNAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADB7C2BCB8;
	Mon,  4 May 2026 08:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777884343;
	bh=L/40mcABEYuNZ88OU0p1kTwUBwH8ZERmZ/hgMUozE2Y=;
	h=Subject:To:Cc:From:Date:From;
	b=U6OVXNASBaIcF5LWVn7KdJi4XSLlS9LvLWnd8C7sJpdj/ie8tl0DU17vZyDyVY1Vs
	 bqZlgCFhEaeUnbV21fhy0WIV4YCyB3hbUn2GSzyEGD2yv3x0gZAU76EStGU+JiejvM
	 nwL1Ki72NuPyVm5m/C5W2/tluhTCwVUxQ7CQwlww=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_event: fix potential UAF in SSP passkey" failed to apply to 5.15-stable tree
To: shuvampandey1@gmail.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:45:41 +0200
Message-ID: <2026050440-overlaid-handpick-7fc8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9B22D4BA744
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242915-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,intel.com:email,gregkh:email]


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 85fa3512048793076eef658f66489112dcc91993
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050440-overlaid-handpick-7fc8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 85fa3512048793076eef658f66489112dcc91993 Mon Sep 17 00:00:00 2001
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Thu, 9 Apr 2026 00:32:30 +0545
Subject: [PATCH] Bluetooth: hci_event: fix potential UAF in SSP passkey
 handlers

hci_conn lookup and field access must be covered by hdev lock in
hci_user_passkey_notify_evt() and hci_keypress_notify_evt(), otherwise
the connection can be freed concurrently.

Extend the hci_dev_lock critical section to cover all conn usage in both
handlers.

Keep the existing keypress notification behavior unchanged by routing
the early exits through a common unlock path.

Fixes: 92a25256f142 ("Bluetooth: mgmt: Implement support for passkey notification")
Cc: stable@vger.kernel.org
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 83248085dd4f..b2ee6b6a0f56 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5495,9 +5495,11 @@ static void hci_user_passkey_notify_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "");
 
+	hci_dev_lock(hdev);
+
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (!conn)
-		return;
+		goto unlock;
 
 	conn->passkey_notify = __le32_to_cpu(ev->passkey);
 	conn->passkey_entered = 0;
@@ -5506,6 +5508,9 @@ static void hci_user_passkey_notify_evt(struct hci_dev *hdev, void *data,
 		mgmt_user_passkey_notify(hdev, &conn->dst, conn->type,
 					 conn->dst_type, conn->passkey_notify,
 					 conn->passkey_entered);
+
+unlock:
+	hci_dev_unlock(hdev);
 }
 
 static void hci_keypress_notify_evt(struct hci_dev *hdev, void *data,
@@ -5516,14 +5521,16 @@ static void hci_keypress_notify_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "");
 
+	hci_dev_lock(hdev);
+
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (!conn)
-		return;
+		goto unlock;
 
 	switch (ev->type) {
 	case HCI_KEYPRESS_STARTED:
 		conn->passkey_entered = 0;
-		return;
+		goto unlock;
 
 	case HCI_KEYPRESS_ENTERED:
 		conn->passkey_entered++;
@@ -5538,13 +5545,16 @@ static void hci_keypress_notify_evt(struct hci_dev *hdev, void *data,
 		break;
 
 	case HCI_KEYPRESS_COMPLETED:
-		return;
+		goto unlock;
 	}
 
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_user_passkey_notify(hdev, &conn->dst, conn->type,
 					 conn->dst_type, conn->passkey_notify,
 					 conn->passkey_entered);
+
+unlock:
+	hci_dev_unlock(hdev);
 }
 
 static void hci_simple_pair_complete_evt(struct hci_dev *hdev, void *data,


