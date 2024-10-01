Return-Path: <stable+bounces-78411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95D498B982
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07231C22ED5
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A8B192D74;
	Tue,  1 Oct 2024 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UqQMhNXI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECBE3209
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778214; cv=none; b=c+ok73YxOAeu27DJ48Wrkchm9yhOWTycI1NV5Hm2ZL0hE0sFbC/+hJZkoxxuQY49sMf7k0tudOZPadPtV8bD03+Bc0FvpT6UarTneYAbj2h+uX/C8gBTgNlzQCICQpUTzG4JlcNv02vM5G3Bcu4FtDCgEFlURODrCxcPnkBlZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778214; c=relaxed/simple;
	bh=aqNh4oa4r0nXxIhE3v2bt5bRXp6JsMo+D1G0wKTDypU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jV82H3e5/MSx4BC3AvIYExWZdKyc2DqsmcE6yC+JzGHbidljBhkNwZWiSaENcI8TFZTFQIjtn7y0AiALMVLU1yJ+2vIChZZ+8cmmDYItloBB7fIABcVD2cWmRi4fRDj8/c5coOs38hgOQbBu7N5VQGAgvw615BkIIpFchjou0WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UqQMhNXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BA3C4CEC6;
	Tue,  1 Oct 2024 10:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727778213;
	bh=aqNh4oa4r0nXxIhE3v2bt5bRXp6JsMo+D1G0wKTDypU=;
	h=Subject:To:Cc:From:Date:From;
	b=UqQMhNXIEJAxJsYUTUQXMyWnJxOhDfo9NZ31kQrCHp9QDFZhtesVxMDiaf3rqpbEt
	 kx43OxpJeE/YQ3garP9bii0wvc8xfXz7O653HpW9z1gw71Hqa8rZlmL7/GJb9kvr64
	 yWVzOYQbxC2swLYMpNOEx1zAXkQP4YCFl6/t3+8o=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks" failed to apply to 6.11-stable tree
To: lk@c--e.de,christian@heusel.eu,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,icaliberdev@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:23:31 +0200
Message-ID: <2024100130-skinhead-glandular-2ffc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 7fa6b25dfb43dafc0e16510e2fcfd63634fc95c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100130-skinhead-glandular-2ffc@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:

7fa6b25dfb43 ("usb: typec: ucsi: Fix busy loop on ASUS VivoBooks")
4f322657ade1 ("usb: typec: ucsi: Call CANCEL from single location")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7fa6b25dfb43dafc0e16510e2fcfd63634fc95c2 Mon Sep 17 00:00:00 2001
From: "Christian A. Ehrhardt" <lk@c--e.de>
Date: Thu, 12 Sep 2024 09:41:32 +0200
Subject: [PATCH] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks

If the busy indicator is set, all other fields in CCI should be
clear according to the spec. However, some UCSI implementations do
not follow this rule and report bogus data in CCI along with the
busy indicator. Ignore the contents of CCI if the busy indicator is
set.

If a command timeout is hit it is possible that the EVENT_PENDING
bit is cleared while connector work is still scheduled which can
cause the EVENT_PENDING bit to go out of sync with scheduled connector
work. Check and set the EVENT_PENDING bit on entry to
ucsi_handle_connector_change() to fix this.

Finally, check UCSI_CCI_BUSY before the return code of ->sync_control.
This ensures that the command is cancelled even if ->sync_control
returns an error (most likely -ETIMEDOUT).

Reported-by: Anurag Bijea <icaliberdev@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
Bisected-by: Christian Heusel <christian@heusel.eu>
Tested-by: Anurag Bijea <icaliberdev@gmail.com>
Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
Cc: stable@vger.kernel.org
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240912074132.722855-1-lk@c--e.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 35dce4057c25..e0f3925e401b 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -38,6 +38,10 @@
 
 void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
 {
+	/* Ignore bogus data in CCI if busy indicator is set. */
+	if (cci & UCSI_CCI_BUSY)
+		return;
+
 	if (UCSI_CCI_CONNECTOR(cci))
 		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
 
@@ -103,15 +107,13 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 		return -EINVAL;
 
 	ret = ucsi->ops->sync_control(ucsi, command);
-	if (ret)
-		return ret;
-
-	ret = ucsi->ops->read_cci(ucsi, cci);
-	if (ret)
-		return ret;
+	if (ucsi->ops->read_cci(ucsi, cci))
+		return -EIO;
 
 	if (*cci & UCSI_CCI_BUSY)
 		return ucsi_run_command(ucsi, UCSI_CANCEL, cci, NULL, 0, false) ?: -EBUSY;
+	if (ret)
+		return ret;
 
 	if (!(*cci & UCSI_CCI_COMMAND_COMPLETE))
 		return -EIO;
@@ -1197,6 +1199,10 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	mutex_lock(&con->lock);
 
+	if (!test_and_set_bit(EVENT_PENDING, &ucsi->flags))
+		dev_err_once(ucsi->dev, "%s entered without EVENT_PENDING\n",
+			     __func__);
+
 	command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
 
 	ret = ucsi_send_command_common(ucsi, command, &con->status,


