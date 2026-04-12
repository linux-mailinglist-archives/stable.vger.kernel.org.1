Return-Path: <stable+bounces-235775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDxlGTDv2mnn7AgAu9opvQ
	(envelope-from <stable+bounces-235775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 03:02:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0355C3E243E
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 03:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA976301A71C
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 01:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C754621257E;
	Sun, 12 Apr 2026 01:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIrE7jv/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB518EB0
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 01:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775955753; cv=none; b=NH/qae8bbhbUNHyTLpZdJVUuIyEholPAmmklhKUpdalRV9E5CVK/M7N+oXDHoqqbLkAMOk9xuZr/ydfZ4D5vaDLdimGvSyQr3sIO5Oxi01FvFELC5v2h9AfgjETPsoikA2XL+7jdvJs/+oE5/EZQHdykkkcEpzwbHxlBz3dDD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775955753; c=relaxed/simple;
	bh=VFNzmc9yxnn2y7vFULqQDgmgyv95x/tccfqWMXU7YDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ik0rPD1aruRmbfI2EVTewo9VG89xKS/dosRQcNDa+Nar50Q9QyfkfGlp9PWlogaURS7XIh4Rr1udMBpGge+nyZdaoilD7X5iOMxn8bj/mS7cRsquQPNQHQYNMceLrQZVT18n6xDcSqS4BA52J1O9cuHLLtYwQZft4ngjUTxTfPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIrE7jv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13E5C2BCB1;
	Sun, 12 Apr 2026 01:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775955753;
	bh=VFNzmc9yxnn2y7vFULqQDgmgyv95x/tccfqWMXU7YDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIrE7jv/48n6c4nSEQ83Ypu/5vlE/5ouTaYv8ywDRn/iaKW8GvPlIt5tKX3qTJyjl
	 4OvBieB5HmEdocnSCWI95joCyH3hNBBW+2J65LK6HrzWG/8mCTrqtcXH2V6VY/sEma
	 voCo/9KrrAVfS8yAFJvu8A23P3gnhsz35IaPXYD4wVaGlqd2dt0m0ZEB9E5JPWgILx
	 sDaCY6sjV6+D0oSfSAUeMfCimaW52xgLczotelT15xjRxVzN4tGvrKdKyNSGefyi/i
	 DShEIt8rFD5kLRLb0bseAuZOrCQI8+6tzsvyG+bqpP1kGXygJlshXhpfipG8XL5pKl
	 XrodB4QcOFJSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] ACPICA: Add a depth argument to acpi_execute_reg_methods()
Date: Sat, 11 Apr 2026 21:02:29 -0400
Message-ID: <20260412010230.1904734-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412010230.1904734-1-sashal@kernel.org>
References: <2026040842-swagger-sharpie-884e@gregkh>
 <20260412010230.1904734-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-235775-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 0355C3E243E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit cdf65d73e001fde600b18d7e45afadf559425ce5 ]

A subsequent change will need to pass a depth argument to
acpi_execute_reg_methods(), so prepare that function for it.

No intentional functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Cc: All applicable <stable@vger.kernel.org>
Link: https://patch.msgid.link/8451567.NyiUUSuA9g@rjwysocki.net
Stable-dep-of: 71bf41b8e913 ("ACPI: EC: Evaluate _REG outside the EC scope more carefully")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/acevents.h |  2 +-
 drivers/acpi/acpica/evregion.c |  6 ++++--
 drivers/acpi/acpica/evxfregn.c | 10 +++++++---
 drivers/acpi/ec.c              |  2 +-
 include/acpi/acpixf.h          |  1 +
 5 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 922f559a3e590..aab04e5c7b41c 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -188,7 +188,7 @@ acpi_ev_detach_region(union acpi_operand_object *region_obj,
 		      u8 acpi_ns_is_locked);
 
 void
-acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
+acpi_ev_execute_reg_methods(struct acpi_namespace_node *node, u32 max_depth,
 			    acpi_adr_space_type space_id, u32 function);
 
 acpi_status
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index fd6471e764f1a..ee04eea450894 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -65,6 +65,7 @@ acpi_status acpi_ev_initialize_op_regions(void)
 						acpi_gbl_default_address_spaces
 						[i])) {
 			acpi_ev_execute_reg_methods(acpi_gbl_root_node,
+						    ACPI_UINT32_MAX,
 						    acpi_gbl_default_address_spaces
 						    [i], ACPI_REG_CONNECT);
 		}
@@ -665,6 +666,7 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
  * FUNCTION:    acpi_ev_execute_reg_methods
  *
  * PARAMETERS:  node            - Namespace node for the device
+ *              max_depth       - Depth to which search for _REG
  *              space_id        - The address space ID
  *              function        - Passed to _REG: On (1) or Off (0)
  *
@@ -676,7 +678,7 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
  ******************************************************************************/
 
 void
-acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
+acpi_ev_execute_reg_methods(struct acpi_namespace_node *node, u32 max_depth,
 			    acpi_adr_space_type space_id, u32 function)
 {
 	struct acpi_reg_walk_info info;
@@ -710,7 +712,7 @@ acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 	 * regions and _REG methods. (i.e. handlers must be installed for all
 	 * regions of this Space ID before we can run any _REG methods)
 	 */
-	(void)acpi_ns_walk_namespace(ACPI_TYPE_ANY, node, ACPI_UINT32_MAX,
+	(void)acpi_ns_walk_namespace(ACPI_TYPE_ANY, node, max_depth,
 				     ACPI_NS_WALK_UNLOCK, acpi_ev_reg_run, NULL,
 				     &info, NULL);
 
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index e94e6631502c1..0689eb3fceaf9 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -85,7 +85,8 @@ acpi_install_address_space_handler_internal(acpi_handle device,
 	/* Run all _REG methods for this address space */
 
 	if (run_reg) {
-		acpi_ev_execute_reg_methods(node, space_id, ACPI_REG_CONNECT);
+		acpi_ev_execute_reg_methods(node, ACPI_UINT32_MAX, space_id,
+					    ACPI_REG_CONNECT);
 	}
 
 unlock_and_exit:
@@ -261,6 +262,7 @@ ACPI_EXPORT_SYMBOL(acpi_remove_address_space_handler)
  * FUNCTION:    acpi_execute_reg_methods
  *
  * PARAMETERS:  device          - Handle for the device
+ *              max_depth       - Depth to which search for _REG
  *              space_id        - The address space ID
  *
  * RETURN:      Status
@@ -269,7 +271,8 @@ ACPI_EXPORT_SYMBOL(acpi_remove_address_space_handler)
  *
  ******************************************************************************/
 acpi_status
-acpi_execute_reg_methods(acpi_handle device, acpi_adr_space_type space_id)
+acpi_execute_reg_methods(acpi_handle device, u32 max_depth,
+			 acpi_adr_space_type space_id)
 {
 	struct acpi_namespace_node *node;
 	acpi_status status;
@@ -294,7 +297,8 @@ acpi_execute_reg_methods(acpi_handle device, acpi_adr_space_type space_id)
 
 		/* Run all _REG methods for this address space */
 
-		acpi_ev_execute_reg_methods(node, space_id, ACPI_REG_CONNECT);
+		acpi_ev_execute_reg_methods(node, max_depth, space_id,
+					    ACPI_REG_CONNECT);
 	} else {
 		status = AE_BAD_PARAMETER;
 	}
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 230fe6463cc1f..d0ce8ec19df5a 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1531,7 +1531,7 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 	}
 
 	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
-		acpi_execute_reg_methods(scope_handle, ACPI_ADR_SPACE_EC);
+		acpi_execute_reg_methods(scope_handle, ACPI_UINT32_MAX, ACPI_ADR_SPACE_EC);
 		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
 	}
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 754efb4e63307..fb821b5e88e61 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -666,6 +666,7 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			     void *context))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_execute_reg_methods(acpi_handle device,
+						     u32 nax_depth,
 						     acpi_adr_space_type
 						     space_id))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-- 
2.53.0


