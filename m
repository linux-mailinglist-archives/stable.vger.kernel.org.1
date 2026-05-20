Return-Path: <stable+bounces-249997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKi4BtXPDWr53QUAu9opvQ
	(envelope-from <stable+bounces-249997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:14:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C18F5590982
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22AD0318B691
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAE33F7884;
	Wed, 20 May 2026 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P/N2v9AO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD493F23C5
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289034; cv=none; b=FRxz+XsObXwIgjvN93oOK03wRNlyirnSbrVLzduympMrhMYY/rtfEonzvDJLpyxwjK9QV8cc5tca+AAj8gvFiegg+mlpkBWEvEu9LZjordudFekBIOtkBee6pHwLrwJEbi3zMdsP/JTH5fvk0E2HEYjPJX9gtLvsZM8fobQMqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289034; c=relaxed/simple;
	bh=hiebvDRds/XB0zDwYelLWjHAHKIjqX0gU1uRmqceE+Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TDlJH7NwIFUzbEWqqVRZTrNTLan3WYDFgZezBZbNBjn14nE9840PLiPl+1RYd1NU6sSVggStWI9XK1RMqWlbShA3LLSR1JyQW7tevb24SwZKQohFsa9whZ1hdkHpUs3gs+nuh3fK54LeS2p4S4gM4X9Wgcj7l1yTX6qDumKywmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P/N2v9AO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18341F000E9;
	Wed, 20 May 2026 14:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779289033;
	bh=ZlEr3oGd9VBpQwV7FI2oZwmbtsYEN2ohh26VChdCDSM=;
	h=Subject:To:Cc:From:Date;
	b=P/N2v9AOOtj2YCsMyeuWOGbzJLiBFm37xbbLzcKMsEDBaU/vxO03YSXMMSTx02zX6
	 Ez8pJH7qa1zh/HTpYXAQ6gR4L4t2GZpGTsK0fV5BLD2CCZZ+LWyvfQsTjQcoLxMvS3
	 8leiFTl/C3LnBuiSAOvqETYuMrXTwIeyTrz7AVcA=
Subject: FAILED: patch "[PATCH] platform/x86/intel/tpmi/plr: Prevent fault during unbind" failed to apply to 6.18-stable tree
To: srinivas.pandruvada@linux.intel.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:56:34 +0200
Message-ID: <2026052034-uncoated-rekindle-cc2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249997-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C18F5590982
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 14473e8c4e97d51eff9b2f384ae696f7a32f182b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052034-uncoated-rekindle-cc2a@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 14473e8c4e97d51eff9b2f384ae696f7a32f182b Mon Sep 17 00:00:00 2001
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Thu, 30 Apr 2026 08:11:03 -0700
Subject: [PATCH] platform/x86/intel/tpmi/plr: Prevent fault during unbind
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver faults when intel vsec driver is unbound from PCI driver
interface. For example:

echo 0000:00:03.1 > /sys/bus/pci/drivers/intel_vsec/unbind

This is caused by accessing plr->dbgfs_dir after vsec_tpmi driver is
removed. Here vsec_tpmi driver is the parent. On unbind, the parent
device remove callback is called first which here will remove debugfs
interface. Hence plr->dbgfs_dir is no longer valid.

Register notifier for TPMI_CORE_EXIT and make this pointer to NULL,
so that debugfs_remove_recursive() is not called with bad plr->dbgfs_dir
pointer.

After notifier is returned the vsec_tpmi driver will call remove debugfs
by calling debugfs_remove_recursive().

Fixes: 811f67c51636 ("platform/x86/intel/tpmi: Add new auxiliary driver for performance limits")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stable@vger.kernel.org
Link: https://patch.msgid.link/20260430151103.1549733-4-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/intel/plr_tpmi.c b/drivers/platform/x86/intel/plr_tpmi.c
index 05727169f49c..8faecc311038 100644
--- a/drivers/platform/x86/intel/plr_tpmi.c
+++ b/drivers/platform/x86/intel/plr_tpmi.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/seq_file.h>
 #include <linux/sprintf.h>
 #include <linux/types.h>
@@ -60,6 +61,8 @@ struct tpmi_plr {
 	struct tpmi_plr_die *die_info;
 	int num_dies;
 	struct auxiliary_device *auxdev;
+	struct notifier_block nb;
+	struct mutex lock;	/* Protect access to dbgfs_dir */
 };
 
 static const char * const plr_coarse_reasons[] = {
@@ -255,6 +258,30 @@ static ssize_t plr_status_write(struct file *filp, const char __user *ubuf,
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(plr_status);
 
+static int intel_plr_notify(struct notifier_block *self, unsigned long action, void *data)
+{
+	struct tpmi_plr *plr = container_of(self, struct tpmi_plr, nb);
+
+	if (action == TPMI_CORE_EXIT) {
+		guard(mutex)(&plr->lock);
+		plr->dbgfs_dir = NULL;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int intel_plr_register_notifier(struct notifier_block *nb)
+{
+	nb->notifier_call = intel_plr_notify;
+	nb->priority = 0;
+	return tpmi_register_notifier(nb);
+}
+
+static void intel_plr_unregister_notifier(struct notifier_block *nb)
+{
+	tpmi_unregister_notifier(nb);
+}
+
 static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
 {
 	struct oobmsm_plat_info *plat_info;
@@ -282,10 +309,18 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
 	if (!plr)
 		return -ENOMEM;
 
+	err = devm_mutex_init(&auxdev->dev, &plr->lock);
+	if (err)
+		return err;
+
+	intel_plr_register_notifier(&plr->nb);
+
 	plr->die_info = devm_kcalloc(&auxdev->dev, num_resources, sizeof(*plr->die_info),
 				     GFP_KERNEL);
-	if (!plr->die_info)
-		return -ENOMEM;
+	if (!plr->die_info) {
+		err = -ENOMEM;
+		goto err_notify;
+	}
 
 	plr->num_dies = num_resources;
 	plr->dbgfs_dir = debugfs_create_dir("plr", dentry);
@@ -326,6 +361,9 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
 
 err:
 	debugfs_remove_recursive(plr->dbgfs_dir);
+err_notify:
+	intel_plr_unregister_notifier(&plr->nb);
+
 	return err;
 }
 
@@ -333,6 +371,9 @@ static void intel_plr_remove(struct auxiliary_device *auxdev)
 {
 	struct tpmi_plr *plr = auxiliary_get_drvdata(auxdev);
 
+	intel_plr_unregister_notifier(&plr->nb);
+
+	guard(mutex)(&plr->lock);
 	debugfs_remove_recursive(plr->dbgfs_dir);
 }
 


