Return-Path: <stable+bounces-247418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCmNG0HLBmrynwIAu9opvQ
	(envelope-from <stable+bounces-247418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:29:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE96A54A939
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 380F7308DB96
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE73C39A06F;
	Fri, 15 May 2026 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L9YnikN3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E0A311942
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829740; cv=none; b=J1rbJLHDJrvlXCrhazUE7vjnHmj50ALj1McY1kJv2SCXf/FW+SQrQSw6gI5Yn8dBd3HMI4veIKna+Zpzpb6dLzHTruix9vOGWFVLhFJwUU+e/FB6smovzcM3hoT3GQOHy2BryvsMxXSWEHU7PDrYr5ZrvlFJ2pt0Us1hFfgJ6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829740; c=relaxed/simple;
	bh=zjiG0UvInq7BUBfxCJvD0yPdpO9K2BJE+RXgqDp+57A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CRwL7UzqjQCq72KWj+iuayCSlx6yZ+e3gDcNAT3UI9ruQI60pIoijomChOFD6gHwO9v6mtMbS8NmXcHURjDDUaPPi4BIy3MQtRwvedeOMFFDly3RpdpXr/XKovm79cN5GFV5atIUSgKaTdmcp49i5bN+KP8+VgDNAyUTBFvO+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L9YnikN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED950C2BCB8;
	Fri, 15 May 2026 07:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778829740;
	bh=zjiG0UvInq7BUBfxCJvD0yPdpO9K2BJE+RXgqDp+57A=;
	h=Subject:To:Cc:From:Date:From;
	b=L9YnikN3Ex4fr3ZVitEke/lrNZfkmmcctBHtv6Ogpue3J1xlDj2+25aFuAcPyqF1I
	 SOigd6npU4I47zxLr3WeWjxjE/wFl9msnKzLo6MNliUPffFkymb7RHMawApH58OL2N
	 t7/pGyPKt04WJwwA+PaMIiD6pcpYLmAYrrodoVFg=
Subject: FAILED: patch "[PATCH] media: i2c: ov08d10: fix runtime PM handling in probe" failed to apply to 6.6-stable tree
To: matthias.fend@emfend.at,hverkuil+cisco@kernel.org,p.zabel@pengutronix.de,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 09:22:16 +0200
Message-ID: <2026051516-overfull-bouncy-d0bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE96A54A939
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247418-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[emfend.at:email,gregkh:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email,intel.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 35c7046be2be5e60be8128facb359a47f39e99cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051516-overfull-bouncy-d0bc@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 35c7046be2be5e60be8128facb359a47f39e99cd Mon Sep 17 00:00:00 2001
From: Matthias Fend <matthias.fend@emfend.at>
Date: Tue, 24 Mar 2026 11:41:35 +0100
Subject: [PATCH] media: i2c: ov08d10: fix runtime PM handling in probe

Set the device's runtime PM status and enable runtime PM before registering
the async sub-device. This is needed to avoid the case where the device is
runtime PM resumed while runtime PM has not been enabled yet.

Remove the related, non-driver-specific comment while at it.

Fixes: 7be91e02ed57 ("media: i2c: Add ov08d10 camera sensor driver")
Cc: stable@vger.kernel.org
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Matthias Fend <matthias.fend@emfend.at>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/i2c/ov08d10.c b/drivers/media/i2c/ov08d10.c
index 43ec2a1f2fcf..5b02f61e359f 100644
--- a/drivers/media/i2c/ov08d10.c
+++ b/drivers/media/i2c/ov08d10.c
@@ -1430,6 +1430,9 @@ static int ov08d10_probe(struct i2c_client *client)
 		goto probe_error_v4l2_ctrl_handler_free;
 	}
 
+	pm_runtime_set_active(ov08d10->dev);
+	pm_runtime_enable(ov08d10->dev);
+
 	ret = v4l2_async_register_subdev_sensor(&ov08d10->sd);
 	if (ret < 0) {
 		dev_err(ov08d10->dev, "failed to register V4L2 subdev: %d",
@@ -1437,17 +1440,13 @@ static int ov08d10_probe(struct i2c_client *client)
 		goto probe_error_media_entity_cleanup;
 	}
 
-	/*
-	 * Device is already turned on by i2c-core with ACPI domain PM.
-	 * Enable runtime PM and turn off the device.
-	 */
-	pm_runtime_set_active(ov08d10->dev);
-	pm_runtime_enable(ov08d10->dev);
 	pm_runtime_idle(ov08d10->dev);
 
 	return 0;
 
 probe_error_media_entity_cleanup:
+	pm_runtime_disable(ov08d10->dev);
+	pm_runtime_set_suspended(ov08d10->dev);
 	media_entity_cleanup(&ov08d10->sd.entity);
 
 probe_error_v4l2_ctrl_handler_free:


