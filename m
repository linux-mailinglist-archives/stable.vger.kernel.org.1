Return-Path: <stable+bounces-155005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38635AE162B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3E3166C23
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFE670825;
	Fri, 20 Jun 2025 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CsFPrSx4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003821883C
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408498; cv=none; b=uWaSXBzQgt7qfmG7rbtfigIfsjz8ebzV7vj9YWcbqlSEGtUD2gMVIfBVkvgdHRliBCuRkiXRUP7rPvu0HvfEoRzGGJYjUG8/92UWKU1AXwbV6v/QYzemCTCLfA7HG+miADCxaGYPRTm0usEXECywCCOmJZtHCtx8vWxVCbNNFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408498; c=relaxed/simple;
	bh=zDnsygKFtqmrXQaW4rnnhgHIj7RYuYK7I8BP3FQAaVE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XyczMdvV0+qjdTgzVhGTM81wSMMqD6ZegQQ9vr31iHbECFVhNmuLsX+z/bV+nn3JCvX2c0d2mfG1UriZl5Z7hcJC6sAm08fgCVzwoS0GKAT6msRFHeZXbeT+tjJsfZnSl3Xr4zyGlnMPngXfUy4tLFVBVw9qSFDldcjo4rS7h8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CsFPrSx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBF2C4CEE3;
	Fri, 20 Jun 2025 08:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750408497;
	bh=zDnsygKFtqmrXQaW4rnnhgHIj7RYuYK7I8BP3FQAaVE=;
	h=Subject:To:Cc:From:Date:From;
	b=CsFPrSx4v9F21AwDMakEqZKbgy8JIp14A6sUSRGzeD5ESBLSZPcAtegDuxwr1AGu5
	 bYXGSSx//Cm6EnvDBHQgXkDS3hExid4uxc3p3oYaF61LTmdEI46Xhfa5B6eSKhx90h
	 y4gFE+1gxqNm+pc9mg3GGUclzQoVshrlvAIgF4ss=
Subject: FAILED: patch "[PATCH] soc: qcom: pmic_glink_altmode: fix spurious DP hotplug events" failed to apply to 6.6-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,clayton@craftyguy.net,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 10:34:54 +0200
Message-ID: <2025062054-daybreak-aspirin-4458@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5090ac9191a19c61beeade60d3d839e509fab640
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062054-daybreak-aspirin-4458@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5090ac9191a19c61beeade60d3d839e509fab640 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Mon, 24 Mar 2025 14:24:48 +0100
Subject: [PATCH] soc: qcom: pmic_glink_altmode: fix spurious DP hotplug events

The PMIC GLINK driver is currently generating DisplayPort hotplug
notifications whenever something is connected to (or disconnected from)
a port regardless of the type of notification sent by the firmware.

These notifications are forwarded to user space by the DRM subsystem as
connector "change" uevents:

    KERNEL[1556.223776] change   /devices/platform/soc@0/ae00000.display-subsystem/ae01000.display-controller/drm/card0 (drm)
    ACTION=change
    DEVPATH=/devices/platform/soc@0/ae00000.display-subsystem/ae01000.display-controller/drm/card0
    SUBSYSTEM=drm
    HOTPLUG=1
    CONNECTOR=36
    DEVNAME=/dev/dri/card0
    DEVTYPE=drm_minor
    SEQNUM=4176
    MAJOR=226
    MINOR=0

On the Lenovo ThinkPad X13s and T14s, the PMIC GLINK firmware sends two
identical notifications with orientation information when connecting a
charger, each generating a bogus DRM hotplug event. On the X13s, two
such notification are also sent every 90 seconds while a charger remains
connected, which again are forwarded to user space:

    port = 1, svid = ff00, mode = 255, hpd_state = 0
    payload = 01 00 00 00 00 00 00 ff 00 00 00 00 00 00 00 00

Note that the firmware only sends on of these when connecting an
ethernet adapter.

Fix the spurious hotplug events by only forwarding hotplug notifications
for the Type-C DisplayPort service id. This also reduces the number of
uevents from four to two when an actual DisplayPort altmode device is
connected:

    port = 0, svid = ff01, mode = 2, hpd_state = 0
    payload = 00 01 02 00 f2 0c 01 ff 03 00 00 00 00 00 00 00
    port = 0, svid = ff01, mode = 2, hpd_state = 1
    payload = 00 01 02 00 f2 0c 01 ff 43 00 00 00 00 00 00 00

Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
Cc: stable@vger.kernel.org	# 6.3
Cc: Bjorn Andersson <andersson@kernel.org>
Reported-by: Clayton Craft <clayton@craftyguy.net>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Clayton Craft <clayton@craftyguy.net>
Link: https://lore.kernel.org/r/20250324132448.6134-1-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index bd06ce161804..7f11acd33323 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -218,21 +218,29 @@ static void pmic_glink_altmode_worker(struct work_struct *work)
 {
 	struct pmic_glink_altmode_port *alt_port = work_to_altmode_port(work);
 	struct pmic_glink_altmode *altmode = alt_port->altmode;
+	enum drm_connector_status conn_status;
 
 	typec_switch_set(alt_port->typec_switch, alt_port->orientation);
 
-	if (alt_port->svid == USB_TYPEC_DP_SID && alt_port->mode == 0xff)
-		pmic_glink_altmode_safe(altmode, alt_port);
-	else if (alt_port->svid == USB_TYPEC_DP_SID)
-		pmic_glink_altmode_enable_dp(altmode, alt_port, alt_port->mode,
-					     alt_port->hpd_state, alt_port->hpd_irq);
-	else
-		pmic_glink_altmode_enable_usb(altmode, alt_port);
+	if (alt_port->svid == USB_TYPEC_DP_SID) {
+		if (alt_port->mode == 0xff) {
+			pmic_glink_altmode_safe(altmode, alt_port);
+		} else {
+			pmic_glink_altmode_enable_dp(altmode, alt_port,
+						     alt_port->mode,
+						     alt_port->hpd_state,
+						     alt_port->hpd_irq);
+		}
 
-	drm_aux_hpd_bridge_notify(&alt_port->bridge->dev,
-				  alt_port->hpd_state ?
-				  connector_status_connected :
-				  connector_status_disconnected);
+		if (alt_port->hpd_state)
+			conn_status = connector_status_connected;
+		else
+			conn_status = connector_status_disconnected;
+
+		drm_aux_hpd_bridge_notify(&alt_port->bridge->dev, conn_status);
+	} else {
+		pmic_glink_altmode_enable_usb(altmode, alt_port);
+	}
 
 	pmic_glink_altmode_request(altmode, ALTMODE_PAN_ACK, alt_port->index);
 }


