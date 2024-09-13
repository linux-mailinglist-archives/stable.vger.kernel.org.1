Return-Path: <stable+bounces-76064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D47978005
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320691F225F2
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9751DA0EA;
	Fri, 13 Sep 2024 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mc7ovDbI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389641DA0E4
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230777; cv=none; b=uEy4DqDkfDKryD8Akm6QBjBJpk35+uJqc/FYH1AF6clE7HsC1oeGPqGDLqlSgrkHZcihGl0n/B9YlAbb4EpKAwkEEMr6ddmoKGwfNiPMvrYEcPMHB1h4YmRO2GBa9UPVMiiIuR1zvLBxdQym0lPoM3sgDumLE/ssOhzjQY7Uv2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230777; c=relaxed/simple;
	bh=yM03gfEktJbW5L44a9YNAC6+21WoLWFqjlANUXxPPzg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mGxixK2ZV7iPgCVetczL/l2eDhxDD6Bs37P8pWX6sHkbKC0mm4yWDaDnR4h4wvfyhypv9Dn3DWcEZJmnzWOc9939atvg2j5F6DNrnZlrsvh0UVFczxr0lmizLeOYmyNlyxrK/YYrD/fiiKeU4jW9+GYpcGuQD5Y3gdvR+u8uxBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mc7ovDbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B187C4CEC0;
	Fri, 13 Sep 2024 12:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726230776;
	bh=yM03gfEktJbW5L44a9YNAC6+21WoLWFqjlANUXxPPzg=;
	h=Subject:To:Cc:From:Date:From;
	b=Mc7ovDbIna585w3K5EFpgZyr5nap0P2P9D8mdnsubiHCnonART+C38hrJxLAqWXP4
	 paS/tWjjPaxHOBezsA4zq5v8Hldb/eGYnDLMqGVbBYi9bFQY/zP6M0tlogSmoMIJWl
	 5hVtUZ1h3XqWAyAXxwV0O4+bhDlqXR6hHa/D8x4M=
Subject: FAILED: patch "[PATCH] platform/x86: panasonic-laptop: Fix SINF array out of bounds" failed to apply to 5.4-stable tree
To: hdegoede@redhat.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 13 Sep 2024 14:32:45 +0200
Message-ID: <2024091345-sweep-flashback-a85d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x f52e98d16e9bd7dd2b3aef8e38db5cbc9899d6a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024091345-sweep-flashback-a85d@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

f52e98d16e9b ("platform/x86: panasonic-laptop: Fix SINF array out of bounds accesses")
f1fba0860962 ("platform/x86: panasonic-laptop: remove redundant assignment of variable result")
25dd390c6206 ("platform/x86: panasonic-laptop: Add sysfs attributes for firmware brightness registers")
468f96bfa3a0 ("platform/x86: panasonic-laptop: Add support for battery charging threshold (eco mode)")
ed83c9171829 ("platform/x86: panasonic-laptop: Resolve hotkey double trigger bug")
e3a9afbbc309 ("platform/x86: panasonic-laptop: Add write support to mute")
008563513348 ("platform/x86: panasonic-laptop: Fix sticky key init bug")
80373ad0edb5 ("platform/x86: panasonic-laptop: Fix naming of platform files for consistency with other modules")
0119fbc0215a ("platform/x86: panasonic-laptop: Split MODULE_AUTHOR() by one author per macro call")
f1aaf914654a ("platform/x86: panasonic-laptop: Replace ACPI prints with pr_*() macros")
d5a81d8e864b ("platform/x86: panasonic-laptop: Add support for optical driver power in Y and W series")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f52e98d16e9bd7dd2b3aef8e38db5cbc9899d6a4 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 9 Sep 2024 13:32:25 +0200
Subject: [PATCH] platform/x86: panasonic-laptop: Fix SINF array out of bounds
 accesses
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The panasonic laptop code in various places uses the SINF array with index
values of 0 - SINF_CUR_BRIGHT(0x0d) without checking that the SINF array
is big enough.

Not all panasonic laptops have this many SINF array entries, for example
the Toughbook CF-18 model only has 10 SINF array entries. So it only
supports the AC+DC brightness entries and mute.

Check that the SINF array has a minimum size which covers all AC+DC
brightness entries and refuse to load if the SINF array is smaller.

For higher SINF indexes hide the sysfs attributes when the SINF array
does not contain an entry for that attribute, avoiding show()/store()
accessing the array out of bounds and add bounds checking to the probe()
and resume() code accessing these.

Fixes: e424fb8cc4e6 ("panasonic-laptop: avoid overflow in acpi_pcc_hotkey_add()")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240909113227.254470-1-hdegoede@redhat.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index cf845ee1c7b1..39044119d2a6 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -773,6 +773,24 @@ static DEVICE_ATTR_RW(dc_brightness);
 static DEVICE_ATTR_RW(current_brightness);
 static DEVICE_ATTR_RW(cdpower);
 
+static umode_t pcc_sysfs_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+
+	if (attr == &dev_attr_mute.attr)
+		return (pcc->num_sifr > SINF_MUTE) ? attr->mode : 0;
+
+	if (attr == &dev_attr_eco_mode.attr)
+		return (pcc->num_sifr > SINF_ECO_MODE) ? attr->mode : 0;
+
+	if (attr == &dev_attr_current_brightness.attr)
+		return (pcc->num_sifr > SINF_CUR_BRIGHT) ? attr->mode : 0;
+
+	return attr->mode;
+}
+
 static struct attribute *pcc_sysfs_entries[] = {
 	&dev_attr_numbatt.attr,
 	&dev_attr_lcdtype.attr,
@@ -787,8 +805,9 @@ static struct attribute *pcc_sysfs_entries[] = {
 };
 
 static const struct attribute_group pcc_attr_group = {
-	.name	= NULL,		/* put in device directory */
-	.attrs	= pcc_sysfs_entries,
+	.name		= NULL,		/* put in device directory */
+	.attrs		= pcc_sysfs_entries,
+	.is_visible	= pcc_sysfs_is_visible,
 };
 
 
@@ -941,12 +960,15 @@ static int acpi_pcc_hotkey_resume(struct device *dev)
 	if (!pcc)
 		return -EINVAL;
 
-	acpi_pcc_write_sset(pcc, SINF_MUTE, pcc->mute);
-	acpi_pcc_write_sset(pcc, SINF_ECO_MODE, pcc->eco_mode);
+	if (pcc->num_sifr > SINF_MUTE)
+		acpi_pcc_write_sset(pcc, SINF_MUTE, pcc->mute);
+	if (pcc->num_sifr > SINF_ECO_MODE)
+		acpi_pcc_write_sset(pcc, SINF_ECO_MODE, pcc->eco_mode);
 	acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, pcc->sticky_key);
 	acpi_pcc_write_sset(pcc, SINF_AC_CUR_BRIGHT, pcc->ac_brightness);
 	acpi_pcc_write_sset(pcc, SINF_DC_CUR_BRIGHT, pcc->dc_brightness);
-	acpi_pcc_write_sset(pcc, SINF_CUR_BRIGHT, pcc->current_brightness);
+	if (pcc->num_sifr > SINF_CUR_BRIGHT)
+		acpi_pcc_write_sset(pcc, SINF_CUR_BRIGHT, pcc->current_brightness);
 
 	return 0;
 }
@@ -963,8 +985,12 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 
 	num_sifr = acpi_pcc_get_sqty(device);
 
-	if (num_sifr < 0 || num_sifr > 255) {
-		pr_err("num_sifr out of range");
+	/*
+	 * pcc->sinf is expected to at least have the AC+DC brightness entries.
+	 * Accesses to higher SINF entries are checked against num_sifr.
+	 */
+	if (num_sifr <= SINF_DC_CUR_BRIGHT || num_sifr > 255) {
+		pr_err("num_sifr %d out of range %d - 255\n", num_sifr, SINF_DC_CUR_BRIGHT + 1);
 		return -ENODEV;
 	}
 
@@ -1020,11 +1046,14 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, 0);
 	pcc->sticky_key = 0;
 
-	pcc->eco_mode = pcc->sinf[SINF_ECO_MODE];
-	pcc->mute = pcc->sinf[SINF_MUTE];
 	pcc->ac_brightness = pcc->sinf[SINF_AC_CUR_BRIGHT];
 	pcc->dc_brightness = pcc->sinf[SINF_DC_CUR_BRIGHT];
-	pcc->current_brightness = pcc->sinf[SINF_CUR_BRIGHT];
+	if (pcc->num_sifr > SINF_MUTE)
+		pcc->mute = pcc->sinf[SINF_MUTE];
+	if (pcc->num_sifr > SINF_ECO_MODE)
+		pcc->eco_mode = pcc->sinf[SINF_ECO_MODE];
+	if (pcc->num_sifr > SINF_CUR_BRIGHT)
+		pcc->current_brightness = pcc->sinf[SINF_CUR_BRIGHT];
 
 	/* add sysfs attributes */
 	result = sysfs_create_group(&device->dev.kobj, &pcc_attr_group);


