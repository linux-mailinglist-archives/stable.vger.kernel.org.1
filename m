Return-Path: <stable+bounces-78413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8521998B983
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7B328468B
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7C219D08C;
	Tue,  1 Oct 2024 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UExQGk8P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E0B1C693
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778227; cv=none; b=iUCppf/5G/XQp1HPHnYjCtha96g8forcdlPETYLO5PVNbvhKTlcISsko56sapDCWaymviKJpb072uZQ39ljz6uy6Hc8mHlossSTEJXuvzbMHG0hFliCG/ROhK3vQdFfi9kPgYluI2mu38CIe39TH9JRQYy+3FTYr2K3JjHvouDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778227; c=relaxed/simple;
	bh=pDwdsBNoA5E6GUnhk3/DPgVQbNf1CYz34RvWdhgx0gs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oCSIFnVeERiFYcyF1IJKyTd/89XkFBKGdcD7CCzojM4YNqkpNBExw23DrZKAlFd045r4TEPbR2ucN9EonCjNFhlnj8muudzKRvKZpfPRTceNCLUMAZLG5cbXDXkVKl63uJd+jcUYMMRt185bROE0PNPKFL4A0v3jG9VyruCWJ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UExQGk8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20007C4CEC6;
	Tue,  1 Oct 2024 10:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727778225;
	bh=pDwdsBNoA5E6GUnhk3/DPgVQbNf1CYz34RvWdhgx0gs=;
	h=Subject:To:Cc:From:Date:From;
	b=UExQGk8PyHZJOdhyeiaSThz1aCt8DVmIBxs2zo4SQV7OgBd4sM3v8Sm5IS/PlGHx9
	 V3N0vSABvj9xXNOEMiE0Rw/8/WttZrWLF1IXXn8VS7Bnohbbqen7LP7W8SadcaB0gr
	 w6UdGvObxtBZN+MnCLP06gu5YjUE735sG7xLbTaY=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks" failed to apply to 6.10-stable tree
To: lk@c--e.de,christian@heusel.eu,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,icaliberdev@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:23:32 +0200
Message-ID: <2024100131-prankster-karma-b617@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7fa6b25dfb43dafc0e16510e2fcfd63634fc95c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100131-prankster-karma-b617@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

7fa6b25dfb43 ("usb: typec: ucsi: Fix busy loop on ASUS VivoBooks")
4f322657ade1 ("usb: typec: ucsi: Call CANCEL from single location")
65ba8cef0416 ("usb: typec: ucsi: Fix a deadlock in ucsi_send_command_common()")
584e8df58942 ("usb: typec: ucsi: extract common code for command handling")
e1870c17e550 ("usb: typec: ucsi: inline ucsi_read_message_in")
5e9c1662a89b ("usb: typec: ucsi: rework command execution functions")
467399d989d7 ("usb: typec: ucsi: split read operation")
13f2ec3115c8 ("usb: typec: ucsi: simplify command sending API")
a7d2fa776976 ("usb: typec: ucsi: move ucsi_acknowledge() from ucsi_read_error()")
f7697db8b1b3 ("Merge 6.10-rc6 into usb-next")

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


