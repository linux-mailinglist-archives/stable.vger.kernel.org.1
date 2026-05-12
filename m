Return-Path: <stable+bounces-245495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HYrLLYmA2p21AEAu9opvQ
	(envelope-from <stable+bounces-245495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:10:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 045C3520D11
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC7813206FD8
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB6937206C;
	Tue, 12 May 2026 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KyDOiM+x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBD94C956E
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589939; cv=none; b=Pwz5QZEUHAtJ2owgTvb14spIqZqRMgaf80knRVDZMKECM4KA/CTqYwwqGKpbQfRWMmfT7B5U91Macnjd/V7dje7USsWO2Vi3BgM99n+P/L+957W0joouV21h2HN3fJu8g6iRGL+wOgTy1+C6ksSu8I5/7O+nOuK+5VUK1orhFbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589939; c=relaxed/simple;
	bh=i2cgnkQ4ZkWiNMft4N0Otti38rutggr38T86zhkQmNA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lv8wg/a0128PDzZZwWlu4i4950rE6FVz4OPUuKqyjg35IEROrHn548RU73wS0dlPa9YhpleI2F30PlNK4qDWe+9u0IMJHKv6X3ZV1R9xax3bQGuNcgn94P7Nbk1ret8P4UYU3FBjLpJgnersfkKnXPhX8WktZHpE0hlv2o7iJPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KyDOiM+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E543C2BCB0;
	Tue, 12 May 2026 12:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778589939;
	bh=i2cgnkQ4ZkWiNMft4N0Otti38rutggr38T86zhkQmNA=;
	h=Subject:To:Cc:From:Date:From;
	b=KyDOiM+xjIctzeo7Xo9yFGWmvpJl1fMPWGmsGMMsbtc5Mx3kqGBaZbzx8LJLmcCZ9
	 mqQHkfzmO/Veu3rCLHYd9wzHaYumYzi/1o3op7iFVlbgNscTun3WCqWyTr8sKjAg0L
	 LDrH2i1+22mWWhs8aJUmvAdjh3PbVmXaCorW7a2A=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_conn: fix potential UAF in create_big_sync" failed to apply to 6.12-stable tree
To: devnexen@gmail.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:42:30 +0200
Message-ID: <2026051230-precook-activate-fb0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 045C3520D11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245495-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0beddb0c380bed5f5b8e61ddbe14635bb73d0b41
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051230-precook-activate-fb0b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0beddb0c380bed5f5b8e61ddbe14635bb73d0b41 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Sun, 12 Apr 2026 21:29:16 +0100
Subject: [PATCH] Bluetooth: hci_conn: fix potential UAF in create_big_sync

Add hci_conn_valid() check in create_big_sync() to detect stale
connections before proceeding with BIG creation. Handle the
resulting -ECANCELED in create_big_complete() and re-validate the
connection under hci_dev_lock() before dereferencing, matching the
pattern used by create_le_conn_complete() and create_pa_complete().

Keep the hci_conn object alive across the async boundary by taking
a reference via hci_conn_get() when queueing create_big_sync(), and
dropping it in the completion callback. The refcount and the lock
are complementary: the refcount keeps the object allocated, while
hci_dev_lock() serializes hci_conn_hash_del()'s list_del_rcu() on
hdev->conn_hash, as required by hci_conn_del().

hci_conn_put() is called outside hci_dev_unlock() so the final put
(which resolves to kfree() via bt_link_release) does not run under
hdev->lock, though the release path would be safe either way.

Without this, create_big_complete() would unconditionally
dereference the conn pointer on error, causing a use-after-free
via hci_connect_cfm() and hci_conn_del().

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Cc: stable@vger.kernel.org
Co-developed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3a0592599086..96e345fcf303 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2130,6 +2130,9 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 	u32 flags = 0;
 	int err;
 
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
 	if (qos->bcast.out.phys == BIT(1))
 		flags |= MGMT_ADV_FLAG_SEC_2M;
 
@@ -2204,11 +2207,24 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	if (err == -ECANCELED)
+		goto done;
+
+	hci_dev_lock(hdev);
+
+	if (!hci_conn_valid(hdev, conn))
+		goto unlock;
+
 	if (err) {
 		bt_dev_err(hdev, "Unable to create BIG: %d", err);
 		hci_connect_cfm(conn, err);
 		hci_conn_del(conn);
 	}
+
+unlock:
+	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
@@ -2336,10 +2352,11 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 BT_BOUND, &data);
 
 	/* Queue start periodic advertising and create BIG */
-	err = hci_cmd_sync_queue(hdev, create_big_sync, conn,
+	err = hci_cmd_sync_queue(hdev, create_big_sync, hci_conn_get(conn),
 				 create_big_complete);
 	if (err < 0) {
 		hci_conn_drop(conn);
+		hci_conn_put(conn);
 		return ERR_PTR(err);
 	}
 


