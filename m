Return-Path: <stable+bounces-172646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712E5B329F1
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 17:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC673BE2C8
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE352080E8;
	Sat, 23 Aug 2025 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lNx6fmJ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A76193077
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964610; cv=none; b=WLWJ6106TGF8y/GEv3gcPK0S9wo9LGoPB4UI//dVVjnihNQvBK0CW/0TQoya97LmMC5EuxD6EsAat6XJRpcF2URmOzRA7iB459YqGAKRdGPgYjCTux1AKtBY0a4I/u4/Q/Og95Jn99YIJtkmJTvVhO3e60UvBd3gSFE7QewNjfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964610; c=relaxed/simple;
	bh=RS2bsg2yCpC5FB7PlHkDC+o1lIaAzSTBlLRGO9evvJU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZUIN+ubkqi2/4FgumzdsoBlv5Cd/lmrjTBi/5CNgoe3Jn4f500JxBm0/SqzbSP+bdzj0zCdsDSP9kRovgVR8nGXcy7EyWL0gecCWJNtu4X85vP2kOrcVm53J0xmwHc6+ihd0Pl32VVhXM2ldpYYasHEpgLn68di3+75NJq3rAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lNx6fmJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362EEC4CEE7;
	Sat, 23 Aug 2025 15:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755964609;
	bh=RS2bsg2yCpC5FB7PlHkDC+o1lIaAzSTBlLRGO9evvJU=;
	h=Subject:To:Cc:From:Date:From;
	b=lNx6fmJ/XbH5sqcA3of0nDIMu7+d//+tAPqdt/KpM+bRHvruz4txQxQOE4/O/RHvd
	 F0GWpxjdA+1rKt4xmBmAPhk3P5r4Q6xv0kda/DRFGgYOAQ6/I7zLGyodJzrbhyYp2j
	 BzJtKBArD6tFQ0FFwIWkagSDDAsQLRYN49FzWTek=
Subject: FAILED: patch "[PATCH] usb: typec: maxim_contaminant: re-enable cc toggle if cc is" failed to apply to 6.6-stable tree
To: amitsd@google.com,badhri@google.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 17:56:46 +0200
Message-ID: <2025082346-facedown-granddad-9758@gregkh>
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
git cherry-pick -x a381c6d6f646226924809d0ad01a9465786da463
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082346-facedown-granddad-9758@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a381c6d6f646226924809d0ad01a9465786da463 Mon Sep 17 00:00:00 2001
From: Amit Sunil Dhamne <amitsd@google.com>
Date: Fri, 15 Aug 2025 11:31:52 -0700
Subject: [PATCH] usb: typec: maxim_contaminant: re-enable cc toggle if cc is
 open and port is clean

Presently in `max_contaminant_is_contaminant()` if there's no
contaminant detected previously, CC is open & stopped toggling and no
contaminant is currently present, TCPC.RC would be programmed to do DRP
toggling. However, it didn't actively look for a connection. This would
lead to Type-C not detect *any* new connections. Hence, in the above
situation, re-enable toggling & program TCPC to look for a new
connection.

Also, return early if TCPC was looking for connection as this indicates
TCPC has neither detected a potential connection nor a change in
contaminant state.

In addition, once dry detection is complete (port is dry), restart
toggling.

Fixes: 02b332a06397e ("usb: typec: maxim_contaminant: Implement check_contaminant callback")
Cc: stable <stable@kernel.org>
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
Link: https://lore.kernel.org/r/20250815-fix-upstream-contaminant-v2-2-6c8d6c3adafb@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
index 818cfe226ac7..af8da6dc60ae 100644
--- a/drivers/usb/typec/tcpm/maxim_contaminant.c
+++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
@@ -329,6 +329,39 @@ static int max_contaminant_enable_dry_detection(struct max_tcpci_chip *chip)
 	return 0;
 }
 
+static int max_contaminant_enable_toggling(struct max_tcpci_chip *chip)
+{
+	struct regmap *regmap = chip->data.regmap;
+	int ret;
+
+	/* Disable dry detection if enabled. */
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL,
+				 FIELD_PREP(CCLPMODESEL,
+					    LOW_POWER_MODE_DISABLE));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL1, CCCONNDRY, 0);
+	if (ret)
+		return ret;
+
+	ret = max_tcpci_write8(chip, TCPC_ROLE_CTRL, TCPC_ROLE_CTRL_DRP |
+			       FIELD_PREP(TCPC_ROLE_CTRL_CC1,
+					  TCPC_ROLE_CTRL_CC_RD) |
+			       FIELD_PREP(TCPC_ROLE_CTRL_CC2,
+					  TCPC_ROLE_CTRL_CC_RD));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(regmap, TCPC_TCPC_CTRL,
+				 TCPC_TCPC_CTRL_EN_LK4CONN_ALRT,
+				 TCPC_TCPC_CTRL_EN_LK4CONN_ALRT);
+	if (ret)
+		return ret;
+
+	return max_tcpci_write8(chip, TCPC_COMMAND, TCPC_CMD_LOOK4CONNECTION);
+}
+
 bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect_while_debounce,
 				    bool *cc_handled)
 {
@@ -345,6 +378,12 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
 	if (ret < 0)
 		return false;
 
+	if (cc_status & TCPC_CC_STATUS_TOGGLING) {
+		if (chip->contaminant_state == DETECTED)
+			return true;
+		return false;
+	}
+
 	if (chip->contaminant_state == NOT_DETECTED || chip->contaminant_state == SINK) {
 		if (!disconnect_while_debounce)
 			msleep(100);
@@ -377,6 +416,12 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
 				max_contaminant_enable_dry_detection(chip);
 				return true;
 			}
+
+			ret = max_contaminant_enable_toggling(chip);
+			if (ret)
+				dev_err(chip->dev,
+					"Failed to enable toggling, ret=%d",
+					ret);
 		}
 	} else if (chip->contaminant_state == DETECTED) {
 		if (!(cc_status & TCPC_CC_STATUS_TOGGLING)) {
@@ -384,6 +429,14 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
 			if (chip->contaminant_state == DETECTED) {
 				max_contaminant_enable_dry_detection(chip);
 				return true;
+			} else {
+				ret = max_contaminant_enable_toggling(chip);
+				if (ret) {
+					dev_err(chip->dev,
+						"Failed to enable toggling, ret=%d",
+						ret);
+					return true;
+				}
 			}
 		}
 	}


