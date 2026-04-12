Return-Path: <stable+bounces-235774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zZ7XNyzv2mnn7AgAu9opvQ
	(envelope-from <stable+bounces-235774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 03:02:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6823E2437
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 03:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A35CC3019078
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 01:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D2513D8B1;
	Sun, 12 Apr 2026 01:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otSol57w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A3518EB0
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 01:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775955753; cv=none; b=TVZJiyS6gCKiji9Zl00UCl73H+1I5Ge2nEs22ZW2izESi16fv9rI/Nk+ArF+b+zF/ztedFeIQOlRznYxCiAwwsrJftOgEgK1JXROP6zauQwkFizy5TX6zm2qquuGeWnK48ZLplONPVdzOeocxJx/fvqgUJIc/RSpqsdHUMxpIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775955753; c=relaxed/simple;
	bh=9jVK/CYNz55ah+e0TgOLh8zr0WbtWNOeCCzuXC99LV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWltRswuukD/BiOBkFr49f5U5aVkDVeXdWblJbQ+U8hGd6GgQ97eRMQ2QEG+J8EUSDVGazawfBTP0yEf/FRpT0uSqn6Uz/VDyH24pfOzlut1RBziFOPnFHSZOkcZCYAmwlYfIQEISAoSsSjUfbxwEFmKSNZE3oi1JiZCR5okka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otSol57w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18188C116C6;
	Sun, 12 Apr 2026 01:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775955752;
	bh=9jVK/CYNz55ah+e0TgOLh8zr0WbtWNOeCCzuXC99LV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=otSol57w2gOLSng+9eJsO0TZ2m6NDyO8LxTR1EKQFCUiuYkv4opWnpGeH5GLRO9Ie
	 TV+gzd8sCZ4hCDQ98MxUe8Gk92SvtZS3f8hh8fGI0FcB3nJVlZKbMfcVDCdWitfQwn
	 7wDemVhTRuBAkKTJA5pfDhUBG5WYLJrRXawzHjcNKqneOWJJIlpC+MZFu/XcwyxwWk
	 jrqUJXtC+RJmtmO6JUagPc8/IJH41RUapIKdRah556kFtPx6SBOSZEOq/lBprWy91o
	 gznjnr6e5sbwrpsE8Dkmk3ynk/RolB5Gsf7W9mhbPzBrX1yymw+FiIt2UYmytASONC
	 PlnFQRA+z/A8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] Revert "ACPI: EC: Evaluate orphan _REG under EC device"
Date: Sat, 11 Apr 2026 21:02:28 -0400
Message-ID: <20260412010230.1904734-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040842-swagger-sharpie-884e@gregkh>
References: <2026040842-swagger-sharpie-884e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235774-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 3A6823E2437
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 779bac9994452f6a894524f70c00cfb0cd4b6364 ]

This reverts commit 0e6b6dedf168 ("Revert "ACPI: EC: Evaluate orphan
_REG under EC device") because the problem addressed by it will be
addressed differently in what follows.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Cc: All applicable <stable@vger.kernel.org>
Link: https://patch.msgid.link/3236716.5fSG56mABF@rjwysocki.net
Stable-dep-of: 71bf41b8e913 ("ACPI: EC: Evaluate _REG outside the EC scope more carefully")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/acevents.h |  4 ---
 drivers/acpi/acpica/evregion.c |  6 +++-
 drivers/acpi/acpica/evxfregn.c | 54 ----------------------------------
 drivers/acpi/ec.c              |  3 --
 include/acpi/acpixf.h          |  4 ---
 5 files changed, 5 insertions(+), 66 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index e4d4a4e744a4f..922f559a3e590 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -191,10 +191,6 @@ void
 acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 			    acpi_adr_space_type space_id, u32 function);
 
-void
-acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *node,
-				  acpi_adr_space_type space_id);
-
 acpi_status
 acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function);
 
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 3c9e4a6f24aa3..fd6471e764f1a 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -20,6 +20,10 @@ extern u8 acpi_gbl_default_address_spaces[];
 
 /* Local prototypes */
 
+static void
+acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *device_node,
+				  acpi_adr_space_type space_id);
+
 static acpi_status
 acpi_ev_reg_run(acpi_handle obj_handle,
 		u32 level, void *context, void **return_value);
@@ -807,7 +811,7 @@ acpi_ev_reg_run(acpi_handle obj_handle,
  *
  ******************************************************************************/
 
-void
+static void
 acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *device_node,
 				  acpi_adr_space_type space_id)
 {
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index a56d4dd51835e..e94e6631502c1 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -304,57 +304,3 @@ acpi_execute_reg_methods(acpi_handle device, acpi_adr_space_type space_id)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_execute_reg_methods)
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_execute_orphan_reg_method
- *
- * PARAMETERS:  device          - Handle for the device
- *              space_id        - The address space ID
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Execute an "orphan" _REG method that appears under an ACPI
- *              device. This is a _REG method that has no corresponding region
- *              within the device's scope.
- *
- ******************************************************************************/
-acpi_status
-acpi_execute_orphan_reg_method(acpi_handle device, acpi_adr_space_type space_id)
-{
-	struct acpi_namespace_node *node;
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(acpi_execute_orphan_reg_method);
-
-	/* Parameter validation */
-
-	if (!device) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
-
-	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Convert and validate the device handle */
-
-	node = acpi_ns_validate_handle(device);
-	if (node) {
-
-		/*
-		 * If an "orphan" _REG method is present in the device's scope
-		 * for the given address space ID, run it.
-		 */
-
-		acpi_ev_execute_orphan_reg_method(node, space_id);
-	} else {
-		status = AE_BAD_PARAMETER;
-	}
-
-	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
-	return_ACPI_STATUS(status);
-}
-
-ACPI_EXPORT_SYMBOL(acpi_execute_orphan_reg_method)
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 0c8920161bec0..230fe6463cc1f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1532,9 +1532,6 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 
 	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
 		acpi_execute_reg_methods(scope_handle, ACPI_ADR_SPACE_EC);
-		if (scope_handle != ec->handle)
-			acpi_execute_orphan_reg_method(ec->handle, ACPI_ADR_SPACE_EC);
-
 		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
 	}
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 42fba1d0d6335..754efb4e63307 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -668,10 +668,6 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_execute_reg_methods(acpi_handle device,
 						     acpi_adr_space_type
 						     space_id))
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			    acpi_execute_orphan_reg_method(acpi_handle device,
-							   acpi_adr_space_type
-							   space_id))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_remove_address_space_handler(acpi_handle
 							      device,
-- 
2.53.0


