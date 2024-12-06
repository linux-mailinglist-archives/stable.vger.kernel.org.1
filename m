Return-Path: <stable+bounces-99678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7A49E72CA
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1B1287224
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C47C207E13;
	Fri,  6 Dec 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gIsDDsNi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1151527AC;
	Fri,  6 Dec 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497984; cv=none; b=aS14hp9FasciVQgVROuwuKPoNgSMZCz1YWGeusgZMHxCX+Z2BELQdBm8DJiQEWj2Z5Xl3CC4dMaWZYSFKrZ9oFXeHzLntF9YVoq7sJwm7SzIijtO75dumu+4Kj/UZBZObddB2PH+mL2E+Uv8WjqrTv+NGGjfsjK6dVTVhSxJVFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497984; c=relaxed/simple;
	bh=U+ALeBYwxOqs8gvwzQ8NViuDDKQGrJYoVMlSf7DzRMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJcxwQwqFIcCvs4Zm41t79OnNeyT3GdoMNnps6CIc6IPIoENOqlMZyVCcN8RhBR/rVcSTdAOqajh4WWw5O37AeFPm2f2vOOUhjApPSUvYgR5rA+ns+sYbRIk69xw2SunhZlFnLgkVKdf+f6n541Tm72IONqmQ2kAwzgePNzSoQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gIsDDsNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4052BC4CED1;
	Fri,  6 Dec 2024 15:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497983;
	bh=U+ALeBYwxOqs8gvwzQ8NViuDDKQGrJYoVMlSf7DzRMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIsDDsNieuZKh3lRfl1uLQRvJoJKWKs2w/AempjedUzY5JIlYPae2g+tdP2zkW5Bd
	 PHAthpUG9RPZcvfMO37xrBRGdVR/qw5yuhNsSbgU0Y/DtabW4XxRb7OC+q9VHdELix
	 b2m5PHuvxP/J0/46A3JJ6ixZ35WGjjy41roaDETo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kiran K <kiran.k@intel.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 420/676] Bluetooth: MGMT: Fix possible deadlocks
Date: Fri,  6 Dec 2024 15:33:59 +0100
Message-ID: <20241206143709.754033107@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit a66dfaf18fd61bb75ef8cee83db46b2aadf153d0 ]

This fixes possible deadlocks like the following caused by
hci_cmd_sync_dequeue causing the destroy function to run:

 INFO: task kworker/u19:0:143 blocked for more than 120 seconds.
       Tainted: G        W  O        6.8.0-2024-03-19-intel-next-iLS-24ww14 #1
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 task:kworker/u19:0   state:D stack:0     pid:143   tgid:143   ppid:2      flags:0x00004000
 Workqueue: hci0 hci_cmd_sync_work [bluetooth]
 Call Trace:
  <TASK>
  __schedule+0x374/0xaf0
  schedule+0x3c/0xf0
  schedule_preempt_disabled+0x1c/0x30
  __mutex_lock.constprop.0+0x3ef/0x7a0
  __mutex_lock_slowpath+0x13/0x20
  mutex_lock+0x3c/0x50
  mgmt_set_connectable_complete+0xa4/0x150 [bluetooth]
  ? kfree+0x211/0x2a0
  hci_cmd_sync_dequeue+0xae/0x130 [bluetooth]
  ? __pfx_cmd_complete_rsp+0x10/0x10 [bluetooth]
  cmd_complete_rsp+0x26/0x80 [bluetooth]
  mgmt_pending_foreach+0x4d/0x70 [bluetooth]
  __mgmt_power_off+0x8d/0x180 [bluetooth]
  ? _raw_spin_unlock_irq+0x23/0x40
  hci_dev_close_sync+0x445/0x5b0 [bluetooth]
  hci_set_powered_sync+0x149/0x250 [bluetooth]
  set_powered_sync+0x24/0x60 [bluetooth]
  hci_cmd_sync_work+0x90/0x150 [bluetooth]
  process_one_work+0x13e/0x300
  worker_thread+0x2f7/0x420
  ? __pfx_worker_thread+0x10/0x10
  kthread+0x107/0x140
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x3d/0x60
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1b/0x30
  </TASK>

Tested-by: Kiran K <kiran.k@intel.com>
Fixes: f53e1c9c726d ("Bluetooth: MGMT: Fix possible crash on mgmt_index_removed")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/mgmt.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f84912552d294..1175248e4bec4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1510,7 +1510,8 @@ static void mgmt_set_discoverable_complete(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "err %d", err);
 
 	/* Make sure cmd still outstanding. */
-	if (cmd != pending_find(MGMT_OP_SET_DISCOVERABLE, hdev))
+	if (err == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_SET_DISCOVERABLE, hdev))
 		return;
 
 	hci_dev_lock(hdev);
@@ -1684,7 +1685,8 @@ static void mgmt_set_connectable_complete(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "err %d", err);
 
 	/* Make sure cmd still outstanding. */
-	if (cmd != pending_find(MGMT_OP_SET_CONNECTABLE, hdev))
+	if (err == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_SET_CONNECTABLE, hdev))
 		return;
 
 	hci_dev_lock(hdev);
@@ -1917,7 +1919,7 @@ static void set_ssp_complete(struct hci_dev *hdev, void *data, int err)
 	bool changed;
 
 	/* Make sure cmd still outstanding. */
-	if (cmd != pending_find(MGMT_OP_SET_SSP, hdev))
+	if (err == -ECANCELED || cmd != pending_find(MGMT_OP_SET_SSP, hdev))
 		return;
 
 	if (err) {
@@ -3782,7 +3784,8 @@ static void set_name_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	if (cmd != pending_find(MGMT_OP_SET_LOCAL_NAME, hdev))
+	if (err == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_SET_LOCAL_NAME, hdev))
 		return;
 
 	if (status) {
@@ -3957,7 +3960,8 @@ static void set_default_phy_complete(struct hci_dev *hdev, void *data, int err)
 	struct sk_buff *skb = cmd->skb;
 	u8 status = mgmt_status(err);
 
-	if (cmd != pending_find(MGMT_OP_SET_PHY_CONFIGURATION, hdev))
+	if (err == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_SET_PHY_CONFIGURATION, hdev))
 		return;
 
 	if (!status) {
@@ -5848,13 +5852,16 @@ static void start_discovery_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct mgmt_pending_cmd *cmd = data;
 
+	bt_dev_dbg(hdev, "err %d", err);
+
+	if (err == -ECANCELED)
+		return;
+
 	if (cmd != pending_find(MGMT_OP_START_DISCOVERY, hdev) &&
 	    cmd != pending_find(MGMT_OP_START_LIMITED_DISCOVERY, hdev) &&
 	    cmd != pending_find(MGMT_OP_START_SERVICE_DISCOVERY, hdev))
 		return;
 
-	bt_dev_dbg(hdev, "err %d", err);
-
 	mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode, mgmt_status(err),
 			  cmd->param, 1);
 	mgmt_pending_remove(cmd);
@@ -6087,7 +6094,8 @@ static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct mgmt_pending_cmd *cmd = data;
 
-	if (cmd != pending_find(MGMT_OP_STOP_DISCOVERY, hdev))
+	if (err == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_STOP_DISCOVERY, hdev))
 		return;
 
 	bt_dev_dbg(hdev, "err %d", err);
@@ -8032,7 +8040,8 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, void *data,
 	u8 status = mgmt_status(err);
 	u16 eir_len;
 
-	if (cmd != pending_find(MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev))
+	if (err == -ECANCELED ||
+	    cmd != pending_find(MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev))
 		return;
 
 	if (!status) {
-- 
2.43.0




