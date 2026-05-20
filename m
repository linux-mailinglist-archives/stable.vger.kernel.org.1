Return-Path: <stable+bounces-249955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ9+CIfHDWr93AUAu9opvQ
	(envelope-from <stable+bounces-249955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:39:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F6658FC5D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60A25303A629
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A913ECBC8;
	Wed, 20 May 2026 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D1i6k/0i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B401D3EA94A
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287881; cv=none; b=pCxdMVq1I621socJuiTTKZNVEnJ/J6YhksYvcqi9c8BdJd7zBWWw7sfDd+Q2yEC0DUarcdQmMXFDOaacvDppao66KvzT1SiAu96Rpf9yM3MHAjA6QTAn30SwPmWquJ2Em4e3CfYGP+VIOEzNA/6lN+V+5+AvnZnvY9w4QYGCuc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287881; c=relaxed/simple;
	bh=wIMeRIip10ZzOfZo0Zpm/FdvWwKLy3Ej2Sgd5MhZ7Zs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ks1UpKo+/Ffra3nRpbUpeQfg9Cg3++AOTk0QK2+7JQMlJRdcBKjgeI0CvZL1LjY5Jfuo6fBXHEZxdTW4GCIOACXAvez8pQHOxZctinp0A5SnFpUdh2Y/ilP35UHt12zQDtXPGvdQEbbgZsNr3nQ2TNyV5ipbfQkyvH34Tjv28KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D1i6k/0i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6C81F000E9;
	Wed, 20 May 2026 14:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779287880;
	bh=KZo3TaykI8ESfMz9gHt/d1klE/pgzsbnKC5Fn0nK7bs=;
	h=Subject:To:Cc:From:Date;
	b=D1i6k/0io9+1DTf5FmAu59C90bMYOCESuUg2mRpeprArX4WHXx1YWjKpP5q/bk/Fu
	 iiPuTpdWdHFr1X93DvCCouZ3UBSQBdDm9ACtqYLsPKP3ydnQdGxak5SlqmqhGL87cQ
	 cS8yaCpbHahpW8/XiVlkKdtMHsaIee1NnzbiQUZQ=
Subject: FAILED: patch "[PATCH] platform/x86: intel: Add notifiers support" failed to apply to 6.12-stable tree
To: srinivas.pandruvada@linux.intel.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:38:03 +0200
Message-ID: <2026052003-opal-bling-9542@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249955-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,gregkh:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: A9F6658FC5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 57c347a2e2473bfb5c1f1132a3209c55efbe640b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052003-opal-bling-9542@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 57c347a2e2473bfb5c1f1132a3209c55efbe640b Mon Sep 17 00:00:00 2001
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Thu, 30 Apr 2026 08:11:02 -0700
Subject: [PATCH] platform/x86: intel: Add notifiers support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In some cases a driver using services of vsec_tpmi driver requires some
processing before vsec_tpmi exits. For example a children using debugfs
can't use debugfs as this will be deleted by the vsec_tpmi driver.

This is the case when unbind using PCI driver interface. In this case
the remove callback of vsec_tpmi driver is called first, then remove
callback of its children.

Add support of blocking chain notifiers support. Notify on successful probe
and before clean up in the remove callback.

Fixes: 811f67c51636 ("platform/x86/intel/tpmi: Add new auxiliary driver for performance limits")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stable@vger.kernel.org
Link: https://patch.msgid.link/20260430151103.1549733-3-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/intel/vsec_tpmi.c b/drivers/platform/x86/intel/vsec_tpmi.c
index a38014e81e85..16fd7aa41f20 100644
--- a/drivers/platform/x86/intel/vsec_tpmi.c
+++ b/drivers/platform/x86/intel/vsec_tpmi.c
@@ -56,6 +56,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/pci.h>
 #include <linux/security.h>
 #include <linux/sizes.h>
@@ -188,6 +189,20 @@ struct tpmi_feature_state {
 /* Used during auxbus device creation */
 static DEFINE_IDA(intel_vsec_tpmi_ida);
 
+static BLOCKING_NOTIFIER_HEAD(tpmi_notify_list);
+
+int tpmi_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&tpmi_notify_list, nb);
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_register_notifier, "INTEL_TPMI");
+
+int tpmi_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&tpmi_notify_list, nb);
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_unregister_notifier, "INTEL_TPMI");
+
 struct oobmsm_plat_info *tpmi_get_platform_data(struct auxiliary_device *auxdev)
 {
 	struct intel_vsec_device *vsec_dev = auxdev_to_ivdev(auxdev);
@@ -832,6 +847,8 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 		return ret;
 	}
 
+	blocking_notifier_call_chain(&tpmi_notify_list, TPMI_CORE_INIT, auxdev);
+
 	return 0;
 }
 
@@ -845,6 +862,8 @@ static void tpmi_remove(struct auxiliary_device *auxdev)
 {
 	struct intel_tpmi_info *tpmi_info = auxiliary_get_drvdata(auxdev);
 
+	blocking_notifier_call_chain(&tpmi_notify_list, TPMI_CORE_EXIT, auxdev);
+
 	debugfs_remove_recursive(tpmi_info->dbgfs_dir);
 }
 
diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index 94c06bf214fb..15f02422e9ca 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -28,6 +28,12 @@ enum intel_tpmi_id {
 	TPMI_INFO_ID = 0x81,	/* Special ID for PCI BDF and Package ID information */
 };
 
+#define TPMI_CORE_INIT	0
+#define TPMI_CORE_EXIT	1
+
+int tpmi_register_notifier(struct notifier_block *nb);
+int tpmi_unregister_notifier(struct notifier_block *nb);
+
 struct oobmsm_plat_info *tpmi_get_platform_data(struct auxiliary_device *auxdev);
 struct resource *tpmi_get_resource_at_index(struct auxiliary_device *auxdev, int index);
 int tpmi_get_resource_count(struct auxiliary_device *auxdev);


