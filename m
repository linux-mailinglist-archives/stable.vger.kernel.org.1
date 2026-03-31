Return-Path: <stable+bounces-231769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKPtJuD6y2lsNAYAu9opvQ
	(envelope-from <stable+bounces-231769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:48:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2306C36D295
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DE4B31D9354
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F091426694;
	Tue, 31 Mar 2026 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z1mgh7Kr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4440710B;
	Tue, 31 Mar 2026 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975021; cv=none; b=QK3C7HEELsOuXTQhYIPSRuMvF3rGgCjax9EoYt72woxisx+WJLBB5H/NkcbZ8gmIZyv4f5nZoGNY0QXgkyyL9UNwIWNzyMwxX08ll9MyO8idcVAZprNf76jfY066MqWn3Hhz+KBd8fhf7GJHvm0aTvHiR9IvNr8pPStdyqrOyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975021; c=relaxed/simple;
	bh=KdKYkK4KwUa6ADG54+mtu0nyKydSuDfsfcUz5i5uAIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkOIMnPKrJu5fERGWEgcm9etpYiU/q/K1TtmUFsejd1dLsH95dd92yE5K2UG2a50p1kEWshyBBaSi09ly7WEGChWCodkXHkphbbvZkNmdG56Sl9qyDEkrt+NtsjgK7KEOMzVfAcDw1qs2s5nE1JmkT5u7+/NoFV8qdTdcYUgsjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z1mgh7Kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35CDC19423;
	Tue, 31 Mar 2026 16:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975021;
	bh=KdKYkK4KwUa6ADG54+mtu0nyKydSuDfsfcUz5i5uAIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z1mgh7Krcu+5L+ZQikZjVu7ob3F6jGk9aRMcUK11Af7tqv927tqGQlliiTbV4ojxp
	 u/MIc1GtocxakJ0n+M9EriCfUPqjhN9mfB50XkDtPzIglzrVmwgCzYRFw+lZFu/7o8
	 ns+WXBSZ7+fM7mExaZr8T9SEHnc/0qZG5QCQ++lg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cen Zhang <zzzccc427@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 134/342] Bluetooth: btintel: serialize btintel_hw_error() with hci_req_sync_lock
Date: Tue, 31 Mar 2026 18:19:27 +0200
Message-ID: <20260331161803.938378952@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231769-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 2306C36D295
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cen Zhang <zzzccc427@gmail.com>

[ Upstream commit 94d8e6fe5d0818e9300e514e095a200bd5ff93ae ]

btintel_hw_error() issues two __hci_cmd_sync() calls (HCI_OP_RESET
and Intel exception-info retrieval) without holding
hci_req_sync_lock().  This lets it race against
hci_dev_do_close() -> btintel_shutdown_combined(), which also runs
__hci_cmd_sync() under the same lock.  When both paths manipulate
hdev->req_status/req_rsp concurrently, the close path may free the
response skb first, and the still-running hw_error path hits a
slab-use-after-free in kfree_skb().

Wrap the whole recovery sequence in hci_req_sync_lock/unlock so it
is serialized with every other synchronous HCI command issuer.

Below is the data race report and the kasan report:

  BUG: data-race in __hci_cmd_sync_sk / btintel_shutdown_combined

  read of hdev->req_rsp at net/bluetooth/hci_sync.c:199
  by task kworker/u17:1/83:
   __hci_cmd_sync_sk+0x12f2/0x1c30 net/bluetooth/hci_sync.c:200
   __hci_cmd_sync+0x55/0x80 net/bluetooth/hci_sync.c:223
   btintel_hw_error+0x114/0x670 drivers/bluetooth/btintel.c:254
   hci_error_reset+0x348/0xa30 net/bluetooth/hci_core.c:1030

  write/free by task ioctl/22580:
   btintel_shutdown_combined+0xd0/0x360
    drivers/bluetooth/btintel.c:3648
   hci_dev_close_sync+0x9ae/0x2c10 net/bluetooth/hci_sync.c:5246
   hci_dev_do_close+0x232/0x460 net/bluetooth/hci_core.c:526

  BUG: KASAN: slab-use-after-free in
   sk_skb_reason_drop+0x43/0x380 net/core/skbuff.c:1202
  Read of size 4 at addr ffff888144a738dc
  by task kworker/u17:1/83:
   __hci_cmd_sync_sk+0x12f2/0x1c30 net/bluetooth/hci_sync.c:200
   __hci_cmd_sync+0x55/0x80 net/bluetooth/hci_sync.c:223
   btintel_hw_error+0x186/0x670 drivers/bluetooth/btintel.c:260

Fixes: 973bb97e5aee ("Bluetooth: btintel: Add generic function for handling hardware errors")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btintel.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 9d29ab811f802..5e0a05edcbfd1 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -251,11 +251,13 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 
 	bt_dev_err(hdev, "Hardware error 0x%2.2x", code);
 
+	hci_req_sync_lock(hdev);
+
 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Reset after hardware error failed (%ld)",
 			   PTR_ERR(skb));
-		return;
+		goto unlock;
 	}
 	kfree_skb(skb);
 
@@ -263,18 +265,21 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Retrieving Intel exception info failed (%ld)",
 			   PTR_ERR(skb));
-		return;
+		goto unlock;
 	}
 
 	if (skb->len != 13) {
 		bt_dev_err(hdev, "Exception info size mismatch");
 		kfree_skb(skb);
-		return;
+		goto unlock;
 	}
 
 	bt_dev_err(hdev, "Exception info %s", (char *)(skb->data + 1));
 
 	kfree_skb(skb);
+
+unlock:
+	hci_req_sync_unlock(hdev);
 }
 EXPORT_SYMBOL_GPL(btintel_hw_error);
 
-- 
2.51.0




