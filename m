Return-Path: <stable+bounces-236871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DZLtHkMd3WlhaAkAu9opvQ
	(envelope-from <stable+bounces-236871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:43:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E81B73EFA0E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BBD530511B4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C5227466A;
	Mon, 13 Apr 2026 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KIezOHUY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA713AF2;
	Mon, 13 Apr 2026 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098007; cv=none; b=lZuCfUr02wusXXkQ8ja9OJ5F3+hx9UNv9cLK7Y2FBmQ85p+17zaIBqM9nadc+fQNqyC//6+JuleJtBmgvZTYaLrRQgr8e/d/NiRBNeEjbYEZ+iCA9OZP8Y1l6VlCQzPj7QF1Y5497U+zuz94oaOWtYHinhoMuzzFM53yhG4nc8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098007; c=relaxed/simple;
	bh=86AWJEXrgZrl4bWdWUZKQD6YqfDW9hVwwP+8UzEYvco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYHFrhibEzAOvWU0pWKOk7cL8raGrWjOxuIAkstZ8U36gK9VID44BZQ/s2qb5JRdzCGNiINdv3zJsM2ixkQTP0TF9fyErMlh8wb88y1T7rTOuyCqU/cGGhm+hHB0gVthFTC709QhY/o8nQFq8ufHyUOy4bIxX41Z41BBzysPMkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KIezOHUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A926CC2BCB3;
	Mon, 13 Apr 2026 16:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098007;
	bh=86AWJEXrgZrl4bWdWUZKQD6YqfDW9hVwwP+8UzEYvco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KIezOHUYYGRsTPfpn5F7a4tTfLdHwhsDnU8vw5K3I/bhqLSdcIMSpAgClGnvxO3Wy
	 wtCtr708wV/9o01yC2EWFIbMACLMYbU+jfUjbyUVVflJ/tBcev7EHE9HMTHdjYFg1s
	 jp3y/PWXK38kj1ITW+aU7xuBpIjIEjGF+gSLB9E4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 357/570] ACPICA: include/acpi/acpixf.h: Fix indentation
Date: Mon, 13 Apr 2026 17:58:08 +0200
Message-ID: <20260413155843.857010159@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236871-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: E81B73EFA0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 7a9d74e7e403cb2e60d4d00c05f2f3ab2a33d0c3 ]

A bunch of the functions declared in include/acpi/acpixf.h have their
name aligned a space after the '(' of e.g. the
`ACPI_EXTERNAL_RETURN_STATUS(acpi_status` line above rather then being
directly aligned after the '('.

This breaks applying patches generated from the ACPICA upstream git,
remove the extra space before the function-names and all the arguments
to fix this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: f6484cadbcaf ("ACPI: EC: clean up handlers on probe failure in acpi_ec_setup()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/acpi/acpixf.h | 120 +++++++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 9d45a6001bc00..2cf4c90730d6b 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -587,82 +587,82 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_install_initialization_handler
 			    (acpi_init_handler handler, u32 function))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_install_sci_handler(acpi_sci_handler
-							  address,
-							  void *context))
-ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_remove_sci_handler(acpi_sci_handler
-							 address))
+				acpi_install_sci_handler(acpi_sci_handler
+							 address,
+							 void *context))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_install_global_event_handler
-				 (acpi_gbl_event_handler handler,
-				  void *context))
+				acpi_remove_sci_handler(acpi_sci_handler
+							address))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_install_fixed_event_handler(u32
-								  acpi_event,
-								  acpi_event_handler
-								  handler,
-								  void
-								  *context))
+				acpi_install_global_event_handler
+				(acpi_gbl_event_handler handler,
+				 void *context))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_remove_fixed_event_handler(u32 acpi_event,
+				acpi_install_fixed_event_handler(u32
+								 acpi_event,
 								 acpi_event_handler
-								 handler))
-ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_install_gpe_handler(acpi_handle
-							  gpe_device,
-							  u32 gpe_number,
-							  u32 type,
-							  acpi_gpe_handler
-							  address,
-							  void *context))
+								 handler,
+								 void
+								 *context))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_install_gpe_raw_handler(acpi_handle
-							      gpe_device,
-							      u32 gpe_number,
-							      u32 type,
-							      acpi_gpe_handler
-							      address,
-							      void *context))
+				acpi_remove_fixed_event_handler(u32 acpi_event,
+								acpi_event_handler
+								handler))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-				 acpi_remove_gpe_handler(acpi_handle gpe_device,
+				acpi_install_gpe_handler(acpi_handle
+							 gpe_device,
 							 u32 gpe_number,
+							 u32 type,
 							 acpi_gpe_handler
-							 address))
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			     acpi_install_notify_handler(acpi_handle device,
-							 u32 handler_type,
-							 acpi_notify_handler
-							 handler,
+							 address,
 							 void *context))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				acpi_install_gpe_raw_handler(acpi_handle
+							     gpe_device,
+							     u32 gpe_number,
+							     u32 type,
+							     acpi_gpe_handler
+							     address,
+							     void *context))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				acpi_remove_gpe_handler(acpi_handle gpe_device,
+							u32 gpe_number,
+							acpi_gpe_handler
+							address))
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			     acpi_remove_notify_handler(acpi_handle device,
+			    acpi_install_notify_handler(acpi_handle device,
 							u32 handler_type,
 							acpi_notify_handler
-							handler))
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			     acpi_install_address_space_handler(acpi_handle
-								device,
-								acpi_adr_space_type
-								space_id,
-								acpi_adr_space_handler
-								handler,
-								acpi_adr_space_setup
-								setup,
-								void *context))
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			     acpi_remove_address_space_handler(acpi_handle
+							handler,
+							void *context))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
+			    acpi_remove_notify_handler(acpi_handle device,
+						       u32 handler_type,
+						       acpi_notify_handler
+						       handler))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
+			    acpi_install_address_space_handler(acpi_handle
 							       device,
 							       acpi_adr_space_type
 							       space_id,
 							       acpi_adr_space_handler
-							       handler))
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			     acpi_install_exception_handler
-			     (acpi_exception_handler handler))
-ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			     acpi_install_interface_handler
-			     (acpi_interface_handler handler))
+							       handler,
+							       acpi_adr_space_setup
+							       setup,
+							       void *context))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
+			    acpi_remove_address_space_handler(acpi_handle
+							      device,
+							      acpi_adr_space_type
+							      space_id,
+							      acpi_adr_space_handler
+							      handler))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
+			    acpi_install_exception_handler
+			    (acpi_exception_handler handler))
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
+			    acpi_install_interface_handler
+			    (acpi_interface_handler handler))
 
 /*
  * Global Lock interfaces
-- 
2.53.0




