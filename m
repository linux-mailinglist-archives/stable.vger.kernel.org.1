Return-Path: <stable+bounces-123739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49DBA5C73C
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6F73A3611
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9014325EF80;
	Tue, 11 Mar 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TbDSPVsw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D79E25EF82;
	Tue, 11 Mar 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706823; cv=none; b=A4nTykQPb6c1/BZG6ilaT6B6+qu5pHMOFWu1BC4o5dLPMEaLZEIQGW5fcsnThT2t/YNLAvp/t7qf7DoNWcY+0BtSjIP07cr88msMGliqUbMSlN+R7sRUNiA0EimaL4z4SQiC2ZLDGSxaMyvSPxLb5VY/CtcXJ340d4Fo+uvDTik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706823; c=relaxed/simple;
	bh=jhkR5atgZXKMCCpmR3x4VemZGbiJqEDhF9i7BBg/CQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQqOfxPu6KL9fRjavfvvdKjOBXCGgIXJNDa22lv1QQqlyf7HvdEeir9zpQT6758gyYsPEqAln+0v7a557Vmj4j3zxaxFXYY19y3y2KhVKMb0EtsQLSACyTmhSf8PNBU3iHiVA/FazcFvS/Cn8OGrqQjwa0sMMknd61NtezoR6L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TbDSPVsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACFAC4CEF4;
	Tue, 11 Mar 2025 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741706823;
	bh=jhkR5atgZXKMCCpmR3x4VemZGbiJqEDhF9i7BBg/CQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbDSPVswffyfMu1UtIw5Q6J87ILajimYtDt5JOH9//NrUnrRAj5TGJvx3UYIHTP5+
	 AascXKL4Cg1I3MSCDOUihJM+/6QCWh4UtukdqKJ5o/4mgt/8pb1We0hNveaYHT9c+7
	 kV+aaxk4Vq3py4Q41QocrPJH8VgZ2I9pk0+QyiVw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hardik Gajjar <hgajjar@de.adit-jv.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 149/462] usb: xhci: Add timeout argument in address_device USB HCD callback
Date: Tue, 11 Mar 2025 15:56:55 +0100
Message-ID: <20250311145804.238052172@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hardik Gajjar <hgajjar@de.adit-jv.com>

[ Upstream commit a769154c7cac037914ba375ae88aae55b2c853e0 ]

- The HCD address_device callback now accepts a user-defined timeout value
  in milliseconds, providing better control over command execution times.
- The default timeout value for the address_device command has been set
  to 5000 ms, aligning with the USB 3.2 specification. However, this
  timeout can be adjusted as needed.
- The xhci_setup_device function has been updated to accept the timeout
  value, allowing it to specify the maximum wait time for the command
  operation to complete.
- The hub driver has also been updated to accommodate the newly added
  timeout parameter during the SET_ADDRESS request.

Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
Reviewed-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20231027152029.104363-1-hgajjar@de.adit-jv.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1e0a19912adb ("usb: xhci: Fix NULL pointer dereference on certain command aborts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/hub.c       |  2 +-
 drivers/usb/host/xhci-mem.c  |  2 ++
 drivers/usb/host/xhci-ring.c | 11 ++++++-----
 drivers/usb/host/xhci.c      | 23 ++++++++++++++++-------
 drivers/usb/host/xhci.h      |  9 +++++++--
 include/linux/usb/hcd.h      |  5 +++--
 6 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index edf61091f202b..6e1e2493507d9 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4662,7 +4662,7 @@ static int hub_set_address(struct usb_device *udev, int devnum)
 	if (udev->state != USB_STATE_DEFAULT)
 		return -EINVAL;
 	if (hcd->driver->address_device)
-		retval = hcd->driver->address_device(hcd, udev);
+		retval = hcd->driver->address_device(hcd, udev, USB_CTRL_SET_TIMEOUT);
 	else
 		retval = usb_control_msg(udev, usb_sndaddr0pipe(),
 				USB_REQ_SET_ADDRESS, 0, devnum, 0,
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 006e1b15fbda9..8740bd443f138 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1779,6 +1779,8 @@ struct xhci_command *xhci_alloc_command(struct xhci_hcd *xhci,
 	}
 
 	command->status = 0;
+	/* set default timeout to 5000 ms */
+	command->timeout_ms = XHCI_CMD_DEFAULT_TIMEOUT;
 	INIT_LIST_HEAD(&command->cmd_list);
 	return command;
 }
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 32c039027d7fe..100f392cd1dfc 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -288,9 +288,10 @@ void xhci_ring_cmd_db(struct xhci_hcd *xhci)
 	readl(&xhci->dba->doorbell[0]);
 }
 
-static bool xhci_mod_cmd_timer(struct xhci_hcd *xhci, unsigned long delay)
+static bool xhci_mod_cmd_timer(struct xhci_hcd *xhci)
 {
-	return mod_delayed_work(system_wq, &xhci->cmd_timer, delay);
+	return mod_delayed_work(system_wq, &xhci->cmd_timer,
+			msecs_to_jiffies(xhci->current_cmd->timeout_ms));
 }
 
 static struct xhci_command *xhci_next_queued_cmd(struct xhci_hcd *xhci)
@@ -334,7 +335,7 @@ static void xhci_handle_stopped_cmd_ring(struct xhci_hcd *xhci,
 	if ((xhci->cmd_ring->dequeue != xhci->cmd_ring->enqueue) &&
 	    !(xhci->xhc_state & XHCI_STATE_DYING)) {
 		xhci->current_cmd = cur_cmd;
-		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
+		xhci_mod_cmd_timer(xhci);
 		xhci_ring_cmd_db(xhci);
 	}
 }
@@ -1687,7 +1688,7 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 	if (!list_is_singular(&xhci->cmd_list)) {
 		xhci->current_cmd = list_first_entry(&cmd->cmd_list,
 						struct xhci_command, cmd_list);
-		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
+		xhci_mod_cmd_timer(xhci);
 	} else if (xhci->current_cmd == cmd) {
 		xhci->current_cmd = NULL;
 	}
@@ -4203,7 +4204,7 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 	/* if there are no other commands queued we start the timeout timer */
 	if (list_empty(&xhci->cmd_list)) {
 		xhci->current_cmd = cmd;
-		xhci_mod_cmd_timer(xhci, XHCI_CMD_DEFAULT_TIMEOUT);
+		xhci_mod_cmd_timer(xhci);
 	}
 
 	list_add_tail(&cmd->cmd_list, &xhci->cmd_list);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 19914d08fc0dd..908445cff24f8 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4116,12 +4116,18 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	return 0;
 }
 
-/*
- * Issue an Address Device command and optionally send a corresponding
- * SetAddress request to the device.
+/**
+ * xhci_setup_device - issues an Address Device command to assign a unique
+ *			USB bus address.
+ * @hcd: USB host controller data structure.
+ * @udev: USB dev structure representing the connected device.
+ * @setup: Enum specifying setup mode: address only or with context.
+ * @timeout_ms: Max wait time (ms) for the command operation to complete.
+ *
+ * Return: 0 if successful; otherwise, negative error code.
  */
 static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
-			     enum xhci_setup_dev setup)
+			     enum xhci_setup_dev setup, unsigned int timeout_ms)
 {
 	const char *act = setup == SETUP_CONTEXT_ONLY ? "context" : "address";
 	unsigned long flags;
@@ -4178,6 +4184,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	}
 
 	command->in_ctx = virt_dev->in_ctx;
+	command->timeout_ms = timeout_ms;
 
 	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
 	ctrl_ctx = xhci_get_input_control_ctx(virt_dev->in_ctx);
@@ -4306,14 +4313,16 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 	return ret;
 }
 
-static int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev)
+static int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev,
+			       unsigned int timeout_ms)
 {
-	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ADDRESS);
+	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ADDRESS, timeout_ms);
 }
 
 static int xhci_enable_device(struct usb_hcd *hcd, struct usb_device *udev)
 {
-	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY);
+	return xhci_setup_device(hcd, udev, SETUP_CONTEXT_ONLY,
+				 XHCI_CMD_DEFAULT_TIMEOUT);
 }
 
 /*
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 6304e9b00ecc6..efce7f40dd949 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -815,6 +815,8 @@ struct xhci_command {
 	struct completion		*completion;
 	union xhci_trb			*command_trb;
 	struct list_head		cmd_list;
+	/* xHCI command response timeout in milliseconds */
+	unsigned int			timeout_ms;
 };
 
 /* drop context bitmasks */
@@ -1558,8 +1560,11 @@ struct xhci_td {
 	unsigned int		num_trbs;
 };
 
-/* xHCI command default timeout value */
-#define XHCI_CMD_DEFAULT_TIMEOUT	(5 * HZ)
+/*
+ * xHCI command default timeout value in milliseconds.
+ * USB 3.2 spec, section 9.2.6.1
+ */
+#define XHCI_CMD_DEFAULT_TIMEOUT	5000
 
 /* command descriptor */
 struct xhci_cd {
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 4cd545402a634..4ff23d3ad3d98 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -385,8 +385,9 @@ struct hc_driver {
 		 * or bandwidth constraints.
 		 */
 	void	(*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
-		/* Returns the hardware-chosen device address */
-	int	(*address_device)(struct usb_hcd *, struct usb_device *udev);
+		/* Set the hardware-chosen device address */
+	int	(*address_device)(struct usb_hcd *, struct usb_device *udev,
+				  unsigned int timeout_ms);
 		/* prepares the hardware to send commands to the device */
 	int	(*enable_device)(struct usb_hcd *, struct usb_device *udev);
 		/* Notifies the HCD after a hub descriptor is fetched.
-- 
2.39.5




