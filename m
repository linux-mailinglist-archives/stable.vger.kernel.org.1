Return-Path: <stable+bounces-36007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9C2899541
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90051F22647
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECAF22616;
	Fri,  5 Apr 2024 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q8JGO9iQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA2E224DC
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298385; cv=none; b=X9izBFXQ67m1Zk2KkGg9w5RSj4RilDOBnqO+jXhTNY/PA17WqEbvciaGtlPzorlSrCZn0MOXq6UVcMLtk6m1BCxD0mKrUO65Lyf7BWQ3uOwEfyd2S6JG3MJNj7krSSKKrG9ST6BLFK6PibQYs5lk8ZtdUBCQ7g3v0qeFyBifV1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298385; c=relaxed/simple;
	bh=p4CqC53ksaToXseHH8ZPjRGLZPK7/Je1VJoK2zheeJk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JD7e7vmuXa2AfewgCYeLhYJWrHzRdTn+dFHMlIbGtub6OnTCVuxcbbsypgQ4iKYZlfeO5WRZNjcOPyAqZ4xAuJ+ffIqTwfShIDjOPZbVodxIOE94TnlvCyiNfBW/qUKK1G0HSmd71vzj3qqUkU6i3I9J3foxJlHEu+i6lMKp9NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q8JGO9iQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF337C433F1;
	Fri,  5 Apr 2024 06:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712298385;
	bh=p4CqC53ksaToXseHH8ZPjRGLZPK7/Je1VJoK2zheeJk=;
	h=Subject:To:Cc:From:Date:From;
	b=Q8JGO9iQOZACCrqLfHe8ocS4VXsoTki1SjU8DiU0kPfM4v8V6eiuuF7EaFRMU+B+v
	 QFYaDDNeGnYE6Dicot7yjqQZ2U2/sFy0/nWygjhYWnIaYmqyboPycQ0jAqQ4p0rOZ3
	 xS40Yjh9rV3uWBWSUI5kBxEEQ28l3eGNtaNHQhb4=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_sync: Fix not checking error on" failed to apply to 6.8-stable tree
To: luiz.von.dentz@intel.com,linux@leemhuis.info
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 08:26:17 +0200
Message-ID: <2024040517-sharpener-displace-6491@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x 6946b9c99bde45f3ba74e00a7af9a3458cc24bea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040517-sharpener-displace-6491@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

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


