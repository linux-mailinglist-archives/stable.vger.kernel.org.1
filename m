Return-Path: <stable+bounces-40833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8325D8AF93F
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE601F24B4B
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EDB1442F5;
	Tue, 23 Apr 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L/U9tLtc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7C8143889;
	Tue, 23 Apr 2024 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908493; cv=none; b=EMuvHzCPQ2dHJ64clFCzz5PLSdnD22J0GFzQKp32XGIBLYrypxrBpM8DGTaV7Djfxilb9rgVK2LwLKYVzjUA+oI3NfZe37LS7GXLZamSukF0pHOl6/huRhfUypfU0BiKdrSu3lKhrhap2P5XkTT6eZZLCr3MsSRfeB7s3QR6OVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908493; c=relaxed/simple;
	bh=xt1XYWUpT8WfGWmmTI9pH0c06iBFH/WMBICdGapAU/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WocPdkamEJ13BRkPYKEmZlu5hDg0R/+bDfr09oyGs1UV95uEJXii2gyfC2PN9PBYJAzFdF3JaKPhnJRKfwsC7St2XTpJiA2rdiJ5qoKO1RkFX/b1cQ484wviK5NlFZ7/kNdjESU/ODNJe3W/cn/MLPniWw3lfLXAMQv8HDh1Gw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L/U9tLtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7EAC32781;
	Tue, 23 Apr 2024 21:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908493;
	bh=xt1XYWUpT8WfGWmmTI9pH0c06iBFH/WMBICdGapAU/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/U9tLtcu5EaxrIhJXf2z8scl/4el98zmKEHusvhOZnYY6+Izxa7zVV2lnjjhgOXh
	 2nhv7Pf/28hhs3Vgrw9CwV3fB6Y2YmFVFeQyAgn20tQFDS++rKmEBhX/ny38SyiL1F
	 XDfAmWByinKrcJUxEyOSEb46hzGxYAeza5CUOpqM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sanath S <Sanath.S@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.8 070/158] thunderbolt: Reset topology created by the boot firmware
Date: Tue, 23 Apr 2024 14:38:12 -0700
Message-ID: <20240423213858.235538979@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
References: <20240423213855.824778126@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanath S <Sanath.S@amd.com>

commit 59a54c5f3dbde00b8ad30aef27fe35b1fe07bf5c upstream.

Boot firmware (typically BIOS) might have created tunnels of its own.
The tunnel configuration that it does might be sub-optimal. For instance
it may only support HBR2 monitors so the DisplayPort tunnels it created
may limit Linux graphics drivers. In addition there is an issue on some
AMD based systems where the BIOS does not allocate enough PCIe resources
for future topology extension. By resetting the USB4 topology the PCIe
links will be reset as well allowing Linux to re-allocate.

This aligns the behavior with Windows Connection Manager.

We already issued host router reset for USB4 v2 routers, now extend it
to USB4 v1 routers as well. For pre-USB4 (that's Apple systems) we leave
it as is and continue to discover the existing tunnels.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/domain.c |    5 +++--
 drivers/thunderbolt/icm.c    |    2 +-
 drivers/thunderbolt/nhi.c    |   19 +++++++++++++------
 drivers/thunderbolt/tb.c     |   26 +++++++++++++++++++-------
 drivers/thunderbolt/tb.h     |    4 ++--
 5 files changed, 38 insertions(+), 18 deletions(-)

--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -423,6 +423,7 @@ err_free:
 /**
  * tb_domain_add() - Add domain to the system
  * @tb: Domain to add
+ * @reset: Issue reset to the host router
  *
  * Starts the domain and adds it to the system. Hotplugging devices will
  * work after this has been returned successfully. In order to remove
@@ -431,7 +432,7 @@ err_free:
  *
  * Return: %0 in case of success and negative errno in case of error
  */
-int tb_domain_add(struct tb *tb)
+int tb_domain_add(struct tb *tb, bool reset)
 {
 	int ret;
 
@@ -460,7 +461,7 @@ int tb_domain_add(struct tb *tb)
 
 	/* Start the domain */
 	if (tb->cm_ops->start) {
-		ret = tb->cm_ops->start(tb);
+		ret = tb->cm_ops->start(tb, reset);
 		if (ret)
 			goto err_domain_del;
 	}
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -2144,7 +2144,7 @@ static int icm_runtime_resume(struct tb
 	return 0;
 }
 
-static int icm_start(struct tb *tb)
+static int icm_start(struct tb *tb, bool not_used)
 {
 	struct icm *icm = tb_priv(tb);
 	int ret;
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1221,7 +1221,7 @@ static void nhi_check_iommu(struct tb_nh
 		str_enabled_disabled(port_ok));
 }
 
-static void nhi_reset(struct tb_nhi *nhi)
+static bool nhi_reset(struct tb_nhi *nhi)
 {
 	ktime_t timeout;
 	u32 val;
@@ -1229,11 +1229,11 @@ static void nhi_reset(struct tb_nhi *nhi
 	val = ioread32(nhi->iobase + REG_CAPS);
 	/* Reset only v2 and later routers */
 	if (FIELD_GET(REG_CAPS_VERSION_MASK, val) < REG_CAPS_VERSION_2)
-		return;
+		return false;
 
 	if (!host_reset) {
 		dev_dbg(&nhi->pdev->dev, "skipping host router reset\n");
-		return;
+		return false;
 	}
 
 	iowrite32(REG_RESET_HRR, nhi->iobase + REG_RESET);
@@ -1244,12 +1244,14 @@ static void nhi_reset(struct tb_nhi *nhi
 		val = ioread32(nhi->iobase + REG_RESET);
 		if (!(val & REG_RESET_HRR)) {
 			dev_warn(&nhi->pdev->dev, "host router reset successful\n");
-			return;
+			return true;
 		}
 		usleep_range(10, 20);
 	} while (ktime_before(ktime_get(), timeout));
 
 	dev_warn(&nhi->pdev->dev, "timeout resetting host router\n");
+
+	return false;
 }
 
 static int nhi_init_msi(struct tb_nhi *nhi)
@@ -1331,6 +1333,7 @@ static int nhi_probe(struct pci_dev *pde
 	struct device *dev = &pdev->dev;
 	struct tb_nhi *nhi;
 	struct tb *tb;
+	bool reset;
 	int res;
 
 	if (!nhi_imr_valid(pdev))
@@ -1365,7 +1368,11 @@ static int nhi_probe(struct pci_dev *pde
 	nhi_check_quirks(nhi);
 	nhi_check_iommu(nhi);
 
-	nhi_reset(nhi);
+	/*
+	 * Only USB4 v2 hosts support host reset so if we already did
+	 * that then don't do it again when the domain is initialized.
+	 */
+	reset = nhi_reset(nhi) ? false : host_reset;
 
 	res = nhi_init_msi(nhi);
 	if (res)
@@ -1392,7 +1399,7 @@ static int nhi_probe(struct pci_dev *pde
 
 	dev_dbg(dev, "NHI initialized, starting thunderbolt\n");
 
-	res = tb_domain_add(tb);
+	res = tb_domain_add(tb, reset);
 	if (res) {
 		/*
 		 * At this point the RX/TX rings might already have been
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -2628,7 +2628,7 @@ static int tb_scan_finalize_switch(struc
 	return 0;
 }
 
-static int tb_start(struct tb *tb)
+static int tb_start(struct tb *tb, bool reset)
 {
 	struct tb_cm *tcm = tb_priv(tb);
 	int ret;
@@ -2669,12 +2669,24 @@ static int tb_start(struct tb *tb)
 	tb_switch_tmu_configure(tb->root_switch, TB_SWITCH_TMU_MODE_LOWRES);
 	/* Enable TMU if it is off */
 	tb_switch_tmu_enable(tb->root_switch);
-	/* Full scan to discover devices added before the driver was loaded. */
-	tb_scan_switch(tb->root_switch);
-	/* Find out tunnels created by the boot firmware */
-	tb_discover_tunnels(tb);
-	/* Add DP resources from the DP tunnels created by the boot firmware */
-	tb_discover_dp_resources(tb);
+
+	/*
+	 * Boot firmware might have created tunnels of its own. Since we
+	 * cannot be sure they are usable for us, tear them down and
+	 * reset the ports to handle it as new hotplug for USB4 v1
+	 * routers (for USB4 v2 and beyond we already do host reset).
+	 */
+	if (reset && usb4_switch_version(tb->root_switch) == 1) {
+		tb_switch_reset(tb->root_switch);
+	} else {
+		/* Full scan to discover devices added before the driver was loaded. */
+		tb_scan_switch(tb->root_switch);
+		/* Find out tunnels created by the boot firmware */
+		tb_discover_tunnels(tb);
+		/* Add DP resources from the DP tunnels created by the boot firmware */
+		tb_discover_dp_resources(tb);
+	}
+
 	/*
 	 * If the boot firmware did not create USB 3.x tunnels create them
 	 * now for the whole topology.
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -487,7 +487,7 @@ struct tb_path {
  */
 struct tb_cm_ops {
 	int (*driver_ready)(struct tb *tb);
-	int (*start)(struct tb *tb);
+	int (*start)(struct tb *tb, bool reset);
 	void (*stop)(struct tb *tb);
 	int (*suspend_noirq)(struct tb *tb);
 	int (*resume_noirq)(struct tb *tb);
@@ -750,7 +750,7 @@ int tb_xdomain_init(void);
 void tb_xdomain_exit(void);
 
 struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize);
-int tb_domain_add(struct tb *tb);
+int tb_domain_add(struct tb *tb, bool reset);
 void tb_domain_remove(struct tb *tb);
 int tb_domain_suspend_noirq(struct tb *tb);
 int tb_domain_resume_noirq(struct tb *tb);



