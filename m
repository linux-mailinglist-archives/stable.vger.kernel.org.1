Return-Path: <stable+bounces-249992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHofBfPNDWoF3gUAu9opvQ
	(envelope-from <stable+bounces-249992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:06:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B205907E1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAD903070840
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B85C3EFFC0;
	Wed, 20 May 2026 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rrpO2Mox"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4A3EFFA7
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288776; cv=none; b=kLdpKYo7wWRDkHS1g1aXjj2qdYfkuxn39j29P8R/KijPhUviNEDrOVQJ8bGjX/Zg/YWInU942GHKp6ku3U1VZsTeXOJ5q/gJvDnKLVscoAuTB5nKVMZAwCgLrvvS9jjBK69FrVtj3QUsnoRC+umGFtQKaLkTBUgUz3XNXq3Jj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288776; c=relaxed/simple;
	bh=1evbBnpMOFqCKNOuNLsldpcz7neZlYYiZKyJunIDXxw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UZEKvbWlMVlyu8rQ2rSOAqvzLF6ikUr6tdlZbnerDJ/SK5bMBhnwgRk6oOqclp8jbf77myagI2GBMssXwXrriOKD1m/H2mv8LNuQal4+fvqv8oxhmEGeWEM3n/674wUIWQcwV7lfdXyvTY4XDn7Dbf+19b5auan4WDcjkt30+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rrpO2Mox; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1B81F000E9;
	Wed, 20 May 2026 14:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288774;
	bh=OrONXMoEQAHGVYT9eookthi/sCLFbcFtYLRy0NnBYIY=;
	h=Subject:To:Cc:From:Date;
	b=rrpO2Mox+mo5GwC4fnaxgBhVD9MBFOdtUYLpRY0SzzYLGDXSdGwmbA6qqggxPxEtK
	 gv0siv+weutvz9iGgRv/MGHtVE3nFm/XLii1TEti+AP0iq4jeM0bLfdNpU36qpQSH0
	 DXL+jWmhdhoLlmJo/iL3OOdTv3phh/Qwmne41BNg=
Subject: FAILED: patch "[PATCH] platform/x86: intel: Add notifiers support" failed to apply to 7.0-stable tree
To: srinivas.pandruvada@linux.intel.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:52:22 +0200
Message-ID: <2026052022-busily-olympics-f8a9@gregkh>
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
	TAGGED_FROM(0.00)[bounces-249992-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,gregkh:email,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: A1B205907E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 57c347a2e2473bfb5c1f1132a3209c55efbe640b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052022-busily-olympics-f8a9@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

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


