Return-Path: <stable+bounces-273278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yRLSIX0aUWq1/QIAu9opvQ
	(envelope-from <stable+bounces-273278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 18:14:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ECA73C814
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 18:14:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=glEjiHOZ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273278-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-273278-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE9EE300516F
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA80E421F17;
	Fri, 10 Jul 2026 16:14:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DD63B47FB
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 16:14:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700087; cv=none; b=FW7QmApZ/86GD7dP7YP04uRvNgnWSop6f8AbfBg29fkVX2LDqybrcCr1PrhyHeTEuK5bVHphcQeXc4Lm5J+hgm3IcZ6pHdWh1+/x34hjc9kbyFgmqnxaO0fwU486HrYikzIThjMspo+JgHi7zLwJ8QIHkFSSzL+hZrYXkqKrDco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700087; c=relaxed/simple;
	bh=HGljDp10yLJFTSe4NR93wprSoEhK2vt/88j59g0+heg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxXVXO1LElW1hT8Mcab/aVon+YbKGJeujbtjIEJKD93BCnwSHvJKjcX7VHk8mn9s9X+ML/djhugPwlv0nPlRX0I1fe+9xtB5i8hMhBHRBMZRVPu32MyRxyurzIbtCrQy9DdqVeFkSA6g4qQfE8dQao4nqmo2lBXvRuHMaAJlvCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glEjiHOZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E818A1F00A3A;
	Fri, 10 Jul 2026 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783700085;
	bh=n0JWGO9iyT/vGxjRp2F+TkLO7ILnu/jyqQTi/3qSHG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=glEjiHOZcncQIXBNWAZ3fN4fhdciumLVwYLp8SIoV72V+cN0L9UkJeDFYsbomZL3x
	 maVVL8cYH3IL62myG8AmNmd7VMrwghh0Ht1yCgKDzxrRNXtwnJPkGqx1n4Mzr0rLdy
	 e8HSNNiVbAo4SfZKVi8ZjgbWDlm3o5XxK4URUgVjASVXJu38ikwMtFhOCIy3h2ZdHB
	 F9K4sObisLOk/iiHWPPFp8TEpHMmX0CVBuLrUpGhFxIOd8b6cNdUjgyX05vcxSCtJ+
	 imu3yCidrMt+MXNV3Tkq6Rx3eUbUupg2mlJe/UGSZLgTBGeNOGyUyGZ9D6T/7NlTDj
	 hmW0yJNy/oTnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] ACPI: bus: Introduce devm_acpi_install_notify_handler()
Date: Fri, 10 Jul 2026 12:14:39 -0400
Message-ID: <20260710161442.293558-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710161442.293558-1-sashal@kernel.org>
References: <2026070931-shakily-implicit-64be@gregkh>
 <20260710161442.293558-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:rafael.j.wysocki@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273278-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82ECA73C814

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit ca70ce555a1eb8edf5fb1d5575f1fe19c9ae17f4 ]

Introduce devm_acpi_install_notify_handler() for installing an ACPI
notify handler managed by devres that will be removed automatically on
driver detach.

It installs the notify handler on the device object in the ACPI
namespace that corresponds to the owner device's ACPI companion, if
present (an error is returned if the owner device doesn't have an ACPI
companion).

Currently, there is no way to manually remove the notify handler
installed by it because none of its users brought on subsequently
will need to do that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ rjw: Kerneldoc comment refinement ]
Link: https://patch.msgid.link/2268031.irdbgypaU6@rafael.j.wysocki
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 18a00ed0e718 ("ACPI: NFIT: core: Fix possible deadlock and missing notifications")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/bus.c      | 66 +++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  2 ++
 2 files changed, 68 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 6234055d259846..8730d46a6b273c 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -622,6 +622,72 @@ void acpi_dev_remove_notify_handler(struct acpi_device *adev,
 }
 EXPORT_SYMBOL_GPL(acpi_dev_remove_notify_handler);
 
+struct acpi_notify_handler_devres {
+	acpi_notify_handler handler;
+	u32 handler_type;
+};
+
+static void devm_acpi_notify_handler_release(struct device *dev, void *res)
+{
+	struct acpi_notify_handler_devres *dr = res;
+
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(dev), dr->handler_type,
+				       dr->handler);
+}
+
+/**
+ * devm_acpi_install_notify_handler - Install an ACPI notify handler for a
+ * 				      managed device
+ * @dev: Device to install a notify handler for
+ * @handler_type: Type of the notify handler
+ * @handler: Handler function to install
+ * @context: Data passed back to the handler function
+ *
+ * This function performs the same function as acpi_dev_install_notify_handler()
+ * called for the ACPI companion of @dev with the same @handler_type, @handler,
+ * and @context arguments, but the ACPI notify handler installed by it will be
+ * automatically removed on driver detach.
+ *
+ * Callers should ensure that all resources used by @handler have been allocated
+ * prior to invoking this function, in which case those resources should be
+ * devres-managed so that they won't be released before the notify handler
+ * removal.  Otherwise, special synchronization between @handler and the
+ * management of those resources is required.
+ *
+ * When the request fails, an error message is printed.  Don't add extra error
+ * messages at the call sites.
+ *
+ * Return: 0 on success or a negative error number.
+ */
+int devm_acpi_install_notify_handler(struct device *dev, u32 handler_type,
+				     acpi_notify_handler handler, void *context)
+{
+	struct acpi_notify_handler_devres *dr;
+	struct acpi_device *adev;
+	int ret;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return dev_err_probe(dev, -ENODEV, "No ACPI companion in %s()\n", __func__);
+
+	dr = devres_alloc(devm_acpi_notify_handler_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	ret = acpi_dev_install_notify_handler(adev, handler_type, handler, context);
+	if (ret) {
+		devres_free(dr);
+		return dev_err_probe(dev, ret, "Failed to install an ACPI notify handler\n");
+	}
+
+	dr->handler = handler;
+	dr->handler_type = handler_type;
+	devres_add(dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_acpi_install_notify_handler);
+
 /* Handle events targeting \_SB device (at present only graceful shutdown) */
 
 #define ACPI_SB_NOTIFY_SHUTDOWN_REQUEST 0x81
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b2e377b7f3373d..2aa34fcc10a157 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -625,6 +625,8 @@ int acpi_dev_install_notify_handler(struct acpi_device *adev,
 void acpi_dev_remove_notify_handler(struct acpi_device *adev,
 				    u32 handler_type,
 				    acpi_notify_handler handler);
+int devm_acpi_install_notify_handler(struct device *dev, u32 handler_type,
+				     acpi_notify_handler handler, void *context);
 extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
 extern int register_acpi_notifier(struct notifier_block *);
 extern int unregister_acpi_notifier(struct notifier_block *);
-- 
2.53.0


