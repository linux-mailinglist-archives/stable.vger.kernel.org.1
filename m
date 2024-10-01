Return-Path: <stable+bounces-78414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8257F98B985
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48C71C2255C
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48B8192D74;
	Tue,  1 Oct 2024 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aDb9vbX6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F193209
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778228; cv=none; b=jBy9aysqYn/Wv5eFPVO4KamGuHqIFbS7f8I63DbijcDlnpTO5v28SpPPQUShEarofu4xLOZE5VDkAvIcI8Hs8boVObEiI7myDDQWvqdErG96pIMdu7tH/wE3gNG+cNe1pThixojwhD6R39MwB3lnl/NLN5vRmzIRRqDn/95xQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778228; c=relaxed/simple;
	bh=NQqhqEQ78I1OPHDX9bqiX9hBEiea9xs8IiUmLgws4hc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gfadPe5kTJX7sv+UkcfeI9Nr1K8RKV/HfegoUC8jF3TX5z248pmcSgsdnGx64oKn6Vd6131nix9FKAw3WCRUv8NuMP52zO/g1uVanfinM8qHFeaLOL0OVBlSVKuGiUK2YJ30n5ipkqIHq2LoDhLCASBjGZXKPUlbsLBFRQ65H40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aDb9vbX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0986DC4CEC6;
	Tue,  1 Oct 2024 10:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727778228;
	bh=NQqhqEQ78I1OPHDX9bqiX9hBEiea9xs8IiUmLgws4hc=;
	h=Subject:To:Cc:From:Date:From;
	b=aDb9vbX6ugxXZ4Zlu/ufdUdVnDW9ydzHBE35UaEJ2mK5PFo/gwZ/K6dX1SD/jclN0
	 L3z4f0S8xP09Oa8oLPZGwBMrceaWWE0Ot+SepLJVh6dwj48nQUietBMQ0HnLJ3CzSO
	 KzhkIzPKcylxV4TYCA0BnvXjP89u1Yu7nF7+9jfA=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks" failed to apply to 6.1-stable tree
To: lk@c--e.de,christian@heusel.eu,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,icaliberdev@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:23:33 +0200
Message-ID: <2024100133-preteen-skipper-f95d@gregkh>
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
git cherry-pick -x 7fa6b25dfb43dafc0e16510e2fcfd63634fc95c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100133-preteen-skipper-f95d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


