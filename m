Return-Path: <stable+bounces-105745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799AE9FB180
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD30918833D8
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08B91B0F2E;
	Mon, 23 Dec 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NyCSsQwf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36E189B94;
	Mon, 23 Dec 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734969998; cv=none; b=Tp89t8W/XVCGfMgVmEtaWgUR3NsSE1QMOZzNAuH8/d8JSaLsBwBNeHnWxI0Uneskw7+/obCnG7EEcHjl4oq2uQ+ikr3qVxV3QmkPevXUSX7cXFXKbuB23vDIIYBSPaRgcEiID5/MgBbCrqkseZxqxTPng7pLLO5AQ3kYE30EwYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734969998; c=relaxed/simple;
	bh=7yH6SpUiQv7n2bvwZDryvnymHuqi/lA4kJR8C6P/beA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNtuTaFrdzrYq/s5hdX1yBMVtJ1N6aeMnu2tG07cfQv2G3LAOtTM8ZNWEgm23WcPJtSoKGpjlYUh6l3CWZ69tT6CSY3xCxFuKcDFItvxJ8qZL4TazVqYGroCEAnMd0vyZdILKV7pqEKnb1O+6Q/McDN/IGz6exzCNaoMOaeFgbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NyCSsQwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11DFC4CED3;
	Mon, 23 Dec 2024 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734969998;
	bh=7yH6SpUiQv7n2bvwZDryvnymHuqi/lA4kJR8C6P/beA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NyCSsQwfKsP5zQRHUrP+VNciZa1mtFWJTduJbim4Om3Jh/nHLt8ewUiyQ4dm3wnmN
	 CT4mgUeGxkvAcxjpHp3zR6DAFfbhSzGam8fpekA13CFRSltPuf8FM1S5M6TfbC6UiE
	 xYfERziiRoUI6aNO8rdYBqELZB4RDHLdJpBPiZdI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aaron Rainbolt <arainbolt@kfocus.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.12 083/160] thunderbolt: Improve redrive mode handling
Date: Mon, 23 Dec 2024 16:58:14 +0100
Message-ID: <20241223155411.905971358@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>
References: <20241223155408.598780301@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 24740385cb0d6d22ab7fa7adf36546d5b3cdcf73 upstream.

When USB-C monitor is connected directly to Intel Barlow Ridge host, it
goes into "redrive" mode that basically routes the DisplayPort signals
directly from the GPU to the USB-C monitor without any tunneling needed.
However, the host router must be powered on for this to work. Aaron
reported that there are a couple of cases where this will not work with
the current code:

  - Booting with USB-C monitor plugged in.
  - Plugging in USB-C monitor when the host router is in sleep state
    (runtime suspended).
  - Plugging in USB-C device while the system is in system sleep state.

In all these cases once the host router is runtime suspended the picture
on the connected USB-C display disappears too. This is certainly not
what the user expected.

For this reason improve the redrive mode handling to keep the host
router from runtime suspending when detect that any of the above cases
is happening.

Fixes: a75e0684efe5 ("thunderbolt: Keep the domain powered when USB4 port is in redrive mode")
Reported-by: Aaron Rainbolt <arainbolt@kfocus.org>
Closes: https://lore.kernel.org/linux-usb/20241009220118.70bfedd0@kf-ir16/
Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/tb.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -2059,6 +2059,37 @@ static void tb_exit_redrive(struct tb_po
 	}
 }
 
+static void tb_switch_enter_redrive(struct tb_switch *sw)
+{
+	struct tb_port *port;
+
+	tb_switch_for_each_port(sw, port)
+		tb_enter_redrive(port);
+}
+
+/*
+ * Called during system and runtime suspend to forcefully exit redrive
+ * mode without querying whether the resource is available.
+ */
+static void tb_switch_exit_redrive(struct tb_switch *sw)
+{
+	struct tb_port *port;
+
+	if (!(sw->quirks & QUIRK_KEEP_POWER_IN_DP_REDRIVE))
+		return;
+
+	tb_switch_for_each_port(sw, port) {
+		if (!tb_port_is_dpin(port))
+			continue;
+
+		if (port->redrive) {
+			port->redrive = false;
+			pm_runtime_put(&sw->dev);
+			tb_port_dbg(port, "exit redrive mode\n");
+		}
+	}
+}
+
 static void tb_dp_resource_unavailable(struct tb *tb, struct tb_port *port)
 {
 	struct tb_port *in, *out;
@@ -2909,6 +2940,7 @@ static int tb_start(struct tb *tb, bool
 	tb_create_usb3_tunnels(tb->root_switch);
 	/* Add DP IN resources for the root switch */
 	tb_add_dp_resources(tb->root_switch);
+	tb_switch_enter_redrive(tb->root_switch);
 	/* Make the discovered switches available to the userspace */
 	device_for_each_child(&tb->root_switch->dev, NULL,
 			      tb_scan_finalize_switch);
@@ -2924,6 +2956,7 @@ static int tb_suspend_noirq(struct tb *t
 
 	tb_dbg(tb, "suspending...\n");
 	tb_disconnect_and_release_dp(tb);
+	tb_switch_exit_redrive(tb->root_switch);
 	tb_switch_suspend(tb->root_switch, false);
 	tcm->hotplug_active = false; /* signal tb_handle_hotplug to quit */
 	tb_dbg(tb, "suspend finished\n");
@@ -3016,6 +3049,7 @@ static int tb_resume_noirq(struct tb *tb
 		tb_dbg(tb, "tunnels restarted, sleeping for 100ms\n");
 		msleep(100);
 	}
+	tb_switch_enter_redrive(tb->root_switch);
 	 /* Allow tb_handle_hotplug to progress events */
 	tcm->hotplug_active = true;
 	tb_dbg(tb, "resume finished\n");
@@ -3079,6 +3113,12 @@ static int tb_runtime_suspend(struct tb
 	struct tb_cm *tcm = tb_priv(tb);
 
 	mutex_lock(&tb->lock);
+	/*
+	 * The below call only releases DP resources to allow exiting and
+	 * re-entering redrive mode.
+	 */
+	tb_disconnect_and_release_dp(tb);
+	tb_switch_exit_redrive(tb->root_switch);
 	tb_switch_suspend(tb->root_switch, true);
 	tcm->hotplug_active = false;
 	mutex_unlock(&tb->lock);
@@ -3110,6 +3150,7 @@ static int tb_runtime_resume(struct tb *
 	tb_restore_children(tb->root_switch);
 	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
 		tb_tunnel_restart(tunnel);
+	tb_switch_enter_redrive(tb->root_switch);
 	tcm->hotplug_active = true;
 	mutex_unlock(&tb->lock);
 



