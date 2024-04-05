Return-Path: <stable+bounces-36008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE097899542
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C091F239D4
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C81B22EF2;
	Fri,  5 Apr 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DiyyBN8W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D51803D
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298389; cv=none; b=WZa2wfRgmWbpO6DJ5fP2Ler6avm5HtgnIVZMhRxwCHazYvQUvQDFlfPHJtU+r5Czlt3gjMWOWaDQnjJ946X8Ih60F6SFspxjBDuFdIgCYTNeCvawzEVk//C/bBxe9DQ+SW9oBiU3RGn/iA8TZ66FAtaJxLM874VpdsA477Q+A80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298389; c=relaxed/simple;
	bh=IrZA9YTfqvPNhBeBQ0krCedb3iIHweu3ZP7Uo1TjWKY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ssxq7g9CSLPXcCKZ6PTJGVmWih2n5vOSO1Iv5dT66MIA/up7OpRw+ZAaTds3aIcppBZlq+lu2Bm9NwI+WTWDPAOkB5IvHV2IagSbNuGa6egCvcm4CVyMhB7r0ev7njn3cYgEECORndQRsHs/p7DMaa/LSzavn9nBM337jR3/l9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DiyyBN8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768BCC433F1;
	Fri,  5 Apr 2024 06:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712298388;
	bh=IrZA9YTfqvPNhBeBQ0krCedb3iIHweu3ZP7Uo1TjWKY=;
	h=Subject:To:Cc:From:Date:From;
	b=DiyyBN8WIckBuhkhIrgRU4HZjAhEzMhDEzCRWpNzFFJio94X8q7Bbg8cHeZx05g50
	 gwK9lUVUEzJuP4iDbAVLub7eArIQOcmQf14rVtPoNB4yciYliES0aKh1vO+QvbOzTl
	 /9Pmr+03EUp/wNXNnpKaSIXTzOF+ndPdpW/6dncA=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_sync: Fix not checking error on" failed to apply to 6.1-stable tree
To: luiz.von.dentz@intel.com,linux@leemhuis.info
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 08:26:18 +0200
Message-ID: <2024040518-subpanel-jockey-8b89@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6946b9c99bde45f3ba74e00a7af9a3458cc24bea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040518-subpanel-jockey-8b89@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6946b9c99bde45f3ba74e00a7af9a3458cc24bea Mon Sep 17 00:00:00 2001
From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date: Tue, 26 Mar 2024 12:43:17 -0400
Subject: [PATCH] Bluetooth: hci_sync: Fix not checking error on
 hci_cmd_sync_cancel_sync

hci_cmd_sync_cancel_sync shall check the error passed to it since it
will be propagated using req_result which is __u32 it needs to be
properly set to a positive value if it was passed as negative othertise
IS_ERR will not trigger as -(errno) would be converted to a positive
value.

Fixes: 63298d6e752f ("Bluetooth: hci_core: Cancel request on command timeout")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Reported-and-tested-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/all/08275279-7462-4f4a-a0ee-8aa015f829bc@leemhuis.info/

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1690ae57a09d..a7028d38c1f5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2874,7 +2874,7 @@ static void hci_cancel_cmd_sync(struct hci_dev *hdev, int err)
 	cancel_delayed_work_sync(&hdev->ncmd_timer);
 	atomic_set(&hdev->cmd_cnt, 1);
 
-	hci_cmd_sync_cancel_sync(hdev, -err);
+	hci_cmd_sync_cancel_sync(hdev, err);
 }
 
 /* Suspend HCI device */
@@ -2894,7 +2894,7 @@ int hci_suspend_dev(struct hci_dev *hdev)
 		return 0;
 
 	/* Cancel potentially blocking sync operation before suspend */
-	hci_cancel_cmd_sync(hdev, -EHOSTDOWN);
+	hci_cancel_cmd_sync(hdev, EHOSTDOWN);
 
 	hci_req_sync_lock(hdev);
 	ret = hci_suspend_sync(hdev);
@@ -4210,7 +4210,7 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 
 	err = hci_send_frame(hdev, skb);
 	if (err < 0) {
-		hci_cmd_sync_cancel_sync(hdev, err);
+		hci_cmd_sync_cancel_sync(hdev, -err);
 		return;
 	}
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 639090b9f4b8..8fe02921adf1 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -617,7 +617,10 @@ void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
 	bt_dev_dbg(hdev, "err 0x%2.2x", err);
 
 	if (hdev->req_status == HCI_REQ_PEND) {
-		hdev->req_result = err;
+		/* req_result is __u32 so error must be positive to be properly
+		 * propagated.
+		 */
+		hdev->req_result = err < 0 ? -err : err;
 		hdev->req_status = HCI_REQ_CANCELED;
 
 		wake_up_interruptible(&hdev->req_wait_q);


