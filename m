Return-Path: <stable+bounces-233907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCUkBb1b1mmNEggAu9opvQ
	(envelope-from <stable+bounces-233907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:44:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 863063BD1D1
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6457C304D717
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 13:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86133CF042;
	Wed,  8 Apr 2026 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o+2Ih96J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF7E33A717
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655561; cv=none; b=VFU1QjD8bF2nrerqetdSL1rZG8nI2AAj6AI4X3ZFLeEyrrxsaLhyPArfa3Q/6IozxQytyuea2TwbRnmYe4/idLZlwsex+qodCdbB5TA63vVkNZBe5AbZ3776wbeVx4kCPCbMnDzg5ryEi/GJ9+UTUVqjeVo6I92IB/OJTXlfid8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655561; c=relaxed/simple;
	bh=MCp1X4m+yzev9US6+M8vfZKlI6oaOgbTvUHfpVI/6ag=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b3TXjJ+ioF3beDshu4RlOMDISP5T4VL985gLLN/eg52qYv4fQiM5z3saHbrmKdhACIvRf+VfQiXeoTC5tAS0ZWHHWhbw283MbN56F2oskfmzDZrO0ToAyNX0B3VB4pk5ozLDlQECUdpm0mWsdssUGt2YKWhZ2TgubGEOs6kOljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o+2Ih96J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFE1C19421;
	Wed,  8 Apr 2026 13:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775655561;
	bh=MCp1X4m+yzev9US6+M8vfZKlI6oaOgbTvUHfpVI/6ag=;
	h=Subject:To:Cc:From:Date:From;
	b=o+2Ih96JEWfWQ6ujeOiWJCFy3ummW6Q5wHfvqTXcfN/cApTf2cbwQ8cP0M8ZygIIx
	 gu8CJ972eGZ+Jz2TatbNiL2V+kzLzyF3u78xxCg+DjtCxaiCSBZTwEJyM9ClEhlVjp
	 fd8MatH1IjWoYynDbvYiFUHBJHEyoipyLgaQRsXE=
Subject: FAILED: patch "[PATCH] ACPI: EC: Evaluate orphan _REG under EC device" failed to apply to 5.10-stable tree
To: rafael.j.wysocki@intel.com,vitaly.torshyn@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 15:39:18 +0200
Message-ID: <2026040818-figure-machinist-4ce8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233907-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[intel.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 863063BD1D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0e6b6dedf16800df0ff73ffe2bb5066514db29c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040818-figure-machinist-4ce8@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0e6b6dedf16800df0ff73ffe2bb5066514db29c2 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Wed, 12 Jun 2024 16:15:55 +0200
Subject: [PATCH] ACPI: EC: Evaluate orphan _REG under EC device

After starting to install the EC address space handler at the ACPI
namespace root, if there is an "orphan" _REG method in the EC device's
scope, it will not be evaluated any more.  This breaks EC operation
regions on some systems, like Asus gu605.

To address this, use a wrapper around an existing ACPICA function to
look for an "orphan" _REG method in the EC device scope and evaluate
it if present.

Fixes: 60fa6ae6e6d0 ("ACPI: EC: Install address space handler at the namespace root")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218945
Reported-by: VitaliiT <vitaly.torshyn@gmail.com>
Tested-by: VitaliiT <vitaly.torshyn@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index ddd072cbc738..2133085deda7 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -191,6 +191,10 @@ void
 acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 			    acpi_adr_space_type space_id, u32 function);
 
+void
+acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *node,
+				  acpi_adr_space_type space_id);
+
 acpi_status
 acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function);
 
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 18fdf2bc2d49..dc6004daf624 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -20,10 +20,6 @@ extern u8 acpi_gbl_default_address_spaces[];
 
 /* Local prototypes */
 
-static void
-acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *device_node,
-				  acpi_adr_space_type space_id);
-
 static acpi_status
 acpi_ev_reg_run(acpi_handle obj_handle,
 		u32 level, void *context, void **return_value);
@@ -818,7 +814,7 @@ acpi_ev_reg_run(acpi_handle obj_handle,
  *
  ******************************************************************************/
 
-static void
+void
 acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *device_node,
 				  acpi_adr_space_type space_id)
 {
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 3197e6303c5b..624361a5f34d 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -306,3 +306,57 @@ acpi_execute_reg_methods(acpi_handle device, acpi_adr_space_type space_id)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_execute_reg_methods)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_execute_orphan_reg_method
+ *
+ * PARAMETERS:  device          - Handle for the device
+ *              space_id        - The address space ID
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Execute an "orphan" _REG method that appears under an ACPI
+ *              device. This is a _REG method that has no corresponding region
+ *              within the device's scope.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_execute_orphan_reg_method(acpi_handle device, acpi_adr_space_type space_id)
+{
+	struct acpi_namespace_node *node;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_execute_orphan_reg_method);
+
+	/* Parameter validation */
+
+	if (!device) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Convert and validate the device handle */
+
+	node = acpi_ns_validate_handle(device);
+	if (node) {
+
+		/*
+		 * If an "orphan" _REG method is present in the device's scope
+		 * for the given address space ID, run it.
+		 */
+
+		acpi_ev_execute_orphan_reg_method(node, space_id);
+	} else {
+		status = AE_BAD_PARAMETER;
+	}
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_execute_orphan_reg_method)
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 68dd17f96f63..299ec653388c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1507,6 +1507,9 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 
 	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
 		acpi_execute_reg_methods(scope_handle, ACPI_ADR_SPACE_EC);
+		if (scope_handle != ec->handle)
+			acpi_execute_orphan_reg_method(ec->handle, ACPI_ADR_SPACE_EC);
+
 		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
 	}
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 94d0fc3bd412..80dc36f9d527 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -662,6 +662,10 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_execute_reg_methods(acpi_handle device,
 						     acpi_adr_space_type
 						     space_id))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
+			    acpi_execute_orphan_reg_method(acpi_handle device,
+							   acpi_adr_space_type
+							   space_id))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_remove_address_space_handler(acpi_handle
 							      device,


