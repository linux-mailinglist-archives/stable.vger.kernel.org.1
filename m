Return-Path: <stable+bounces-35415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEDF8943D6
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9461C210A2
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC68482EF;
	Mon,  1 Apr 2024 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dKsG+GRZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7CC40876;
	Mon,  1 Apr 2024 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991324; cv=none; b=YsONbL7c5BN092Oi5FApEPj9Sxs2nagwzIU/+yWuBJc6VQXQOZAMUgJeeHlhFdytQkde/JSt57N4zqLkCgZLWBkt/m4ZFoh0OInxoDRNTkgU9qtxHGUgDlVrKBOEycMQZ8wMiheTNAhN00CY2TfthGlx/EH1+rlrP0eONWQDLFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991324; c=relaxed/simple;
	bh=oNHF8zJPe052ivrIukUexQz6vbWqYUtSfglxdYLM48c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2ZbUldgsdPxYlwzESCL4WQ7CtLTGdiE7gEkKPhyW/m8KgpMZxS434OKtlmGuxQNbBtcMKutdSChokGyB5o7scZokqobcTWkZQw/3i3RQdojj5z7Kjw2aZHVZESZxcGrXMujkos8r2RrJj+e9V5hOpLtzOQv1NGDOVuPmIixVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dKsG+GRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D01C433F1;
	Mon,  1 Apr 2024 17:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711991324;
	bh=oNHF8zJPe052ivrIukUexQz6vbWqYUtSfglxdYLM48c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dKsG+GRZFCj3xs1xFmxyvoUfimFbgSyZVsaPl0K4PuXJbMMgWuL7ZtIPZtTKsptvV
	 KxSoIxmWmoaiGSoqYegd54gxeXdLhbJTtU3rv1GphIMESBKxcGThmfeeydHviyy7ss
	 tIK0h0OvP9JyhaU833U4MXc/zbfuEVagPI6Nf1Bk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH 6.1 230/272] Bluetooth: hci_sync: Fix not checking error on hci_cmd_sync_cancel_sync
Date: Mon,  1 Apr 2024 17:47:00 +0200
Message-ID: <20240401152538.152978701@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit 1c3366abdbe884be62e5a7502b4db758aa3974c6 upstream.

hci_cmd_sync_cancel_sync shall check the error passed to it since it
will be propagated using req_result which is __u32 it needs to be
properly set to a positive value if it was passed as negative othertise
IS_ERR will not trigger as -(errno) would be converted to a positive
value.

Fixes: 63298d6e752f ("Bluetooth: hci_core: Cancel request on command timeout")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Reported-and-tested-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes: https://lore.kernel.org/all/08275279-7462-4f4a-a0ee-8aa015f829bc@leemhuis.info/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_core.c |    6 +++---
 net/bluetooth/hci_sync.c |    5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2838,7 +2838,7 @@ static void hci_cancel_cmd_sync(struct h
 	cancel_delayed_work_sync(&hdev->ncmd_timer);
 	atomic_set(&hdev->cmd_cnt, 1);
 
-	hci_cmd_sync_cancel_sync(hdev, -err);
+	hci_cmd_sync_cancel_sync(hdev, err);
 }
 
 /* Suspend HCI device */
@@ -2858,7 +2858,7 @@ int hci_suspend_dev(struct hci_dev *hdev
 		return 0;
 
 	/* Cancel potentially blocking sync operation before suspend */
-	hci_cancel_cmd_sync(hdev, -EHOSTDOWN);
+	hci_cancel_cmd_sync(hdev, EHOSTDOWN);
 
 	hci_req_sync_lock(hdev);
 	ret = hci_suspend_sync(hdev);
@@ -4169,7 +4169,7 @@ static void hci_send_cmd_sync(struct hci
 
 	err = hci_send_frame(hdev, skb);
 	if (err < 0) {
-		hci_cmd_sync_cancel_sync(hdev, err);
+		hci_cmd_sync_cancel_sync(hdev, -err);
 		return;
 	}
 
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -678,7 +678,10 @@ void hci_cmd_sync_cancel_sync(struct hci
 	bt_dev_dbg(hdev, "err 0x%2.2x", err);
 
 	if (hdev->req_status == HCI_REQ_PEND) {
-		hdev->req_result = err;
+		/* req_result is __u32 so error must be positive to be properly
+		 * propagated.
+		 */
+		hdev->req_result = err < 0 ? -err : err;
 		hdev->req_status = HCI_REQ_CANCELED;
 
 		wake_up_interruptible(&hdev->req_wait_q);



