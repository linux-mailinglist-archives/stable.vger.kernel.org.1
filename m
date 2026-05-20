Return-Path: <stable+bounces-252880-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHGDNjT/DWo95QUAu9opvQ
	(envelope-from <stable+bounces-252880-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:36:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7EB596C23
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11B2D3136BA5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCADA33DEE5;
	Wed, 20 May 2026 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DurXGUkB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62466333441;
	Wed, 20 May 2026 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301830; cv=none; b=WkzyE7E/SsuEBhP5p5qHB1G6E+Ez0YYrjdBDYhrgdknoPka4Un6PTwvRU3jSJFWddWW/S5lth8jkdIBggeu14T/7FI0r1BCNWoTmXLj4/zC+VRc7ftCFxWWEXOWMlzBcoW3sZjr7B3tnlEh17JlMibrGuRqMZh0H3zKSFq3IhSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301830; c=relaxed/simple;
	bh=aPoXF8o8VtQ3Q0crKR9wRNsO6BAvI01TJnXwGKvDNow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Da2QiBS2nQo6AijwIYtoOxtzHvCH+dE9A2IRGYWDuQMPTjR39OvelxxBd5TS5lf445FA21Tkgxkwk5YdjDRemKL7dRhEWJtiYNAtW0ismbDhDHAkih4x4P8MXy0xnWP6u4TNa7syEqZSxZI65ED8K7o7Gty7LZQtKmGV5tH5EZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DurXGUkB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C771A1F000E9;
	Wed, 20 May 2026 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301829;
	bh=TN3+XlR2FNWvTOlg/oC6g0xQtuEp9+Is+mg/bsRKMBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DurXGUkBWYLeSFouE4Gxki5xhpVOYH+VmO9azr9ZGLbYCmB+xdo78GifM+AR/2uQk
	 09Zeuf22/JQzNoEfdpGeMshWa1ihKM+SmEzJm7ubgURMkH1+50cMloWZN7r9eQDu5s
	 qHf8cElUTZX/A5d7kl5bcXgVfsky9/VN0cyLMO6c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 008/508] ACPI: x86: cmos_rtc: Clean up address space handler driver
Date: Wed, 20 May 2026 18:17:11 +0200
Message-ID: <20260520162058.763603853@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252880-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8D7EB596C23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit ba0b236736dde4059bdcb8e99beaa50d6e5b6e7e ]

Make multiple changes that do not alter functionality to the CMOS RTC
ACPI address space handler driver, including the following:

 - Drop the unused .detach() callback from cmos_rtc_handler.

 - Rename acpi_cmos_rtc_attach_handler() to acpi_cmos_rtc_attach().

 - Rearrange acpi_cmos_rtc_space_handler() to reduce the number of
   redundant checks and make white space follow the coding style.

 - Adjust an error message in acpi_install_cmos_rtc_space_handler()
   and make the white space follow the coding style.

 - Rearrange acpi_remove_cmos_rtc_space_handler() and adjust an error
   message in it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/5094429.31r3eYUQgx@rafael.j.wysocki
Stable-dep-of: 6cee29ad9d7e ("ACPI: x86: cmos_rtc: Improve coordination with ACPI TAD driver")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_cmos_rtc.c | 61 +++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/acpi_cmos_rtc.c b/drivers/acpi/acpi_cmos_rtc.c
index 9b55d1593d160..65e89e23c5c84 100644
--- a/drivers/acpi/acpi_cmos_rtc.c
+++ b/drivers/acpi/acpi_cmos_rtc.c
@@ -24,31 +24,35 @@ static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
 	{}
 };
 
-static acpi_status
-acpi_cmos_rtc_space_handler(u32 function, acpi_physical_address address,
-		      u32 bits, u64 *value64,
-		      void *handler_context, void *region_context)
+static acpi_status acpi_cmos_rtc_space_handler(u32 function,
+					       acpi_physical_address address,
+					       u32 bits, u64 *value64,
+					       void *handler_context,
+					       void *region_context)
 {
-	int i;
+	unsigned int i, bytes = DIV_ROUND_UP(bits, 8);
 	u8 *value = (u8 *)value64;
 
 	if (address > 0xff || !value64)
 		return AE_BAD_PARAMETER;
 
-	if (function != ACPI_WRITE && function != ACPI_READ)
-		return AE_BAD_PARAMETER;
+	guard(spinlock_irq)(&rtc_lock);
+
+	if (function == ACPI_WRITE) {
+		for (i = 0; i < bytes; i++, address++, value++)
+			CMOS_WRITE(*value, address);
 
-	spin_lock_irq(&rtc_lock);
+		return AE_OK;
+	}
 
-	for (i = 0; i < DIV_ROUND_UP(bits, 8); ++i, ++address, ++value)
-		if (function == ACPI_READ)
+	if (function == ACPI_READ) {
+		for (i = 0; i < bytes; i++, address++, value++)
 			*value = CMOS_READ(address);
-		else
-			CMOS_WRITE(*value, address);
 
-	spin_unlock_irq(&rtc_lock);
+		return AE_OK;
+	}
 
-	return AE_OK;
+	return AE_BAD_PARAMETER;
 }
 
 int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
@@ -56,11 +60,11 @@ int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
 	acpi_status status;
 
 	status = acpi_install_address_space_handler(handle,
-			ACPI_ADR_SPACE_CMOS,
-			&acpi_cmos_rtc_space_handler,
-			NULL, NULL);
+						    ACPI_ADR_SPACE_CMOS,
+						    acpi_cmos_rtc_space_handler,
+						    NULL, NULL);
 	if (ACPI_FAILURE(status)) {
-		pr_err("Error installing CMOS-RTC region handler\n");
+		pr_err("Failed to install CMOS-RTC address space handler\n");
 		return -ENODEV;
 	}
 
@@ -70,26 +74,25 @@ EXPORT_SYMBOL_GPL(acpi_install_cmos_rtc_space_handler);
 
 void acpi_remove_cmos_rtc_space_handler(acpi_handle handle)
 {
-	if (ACPI_FAILURE(acpi_remove_address_space_handler(handle,
-			ACPI_ADR_SPACE_CMOS, &acpi_cmos_rtc_space_handler)))
-		pr_err("Error removing CMOS-RTC region handler\n");
+	acpi_status status;
+
+	status = acpi_remove_address_space_handler(handle,
+						   ACPI_ADR_SPACE_CMOS,
+						   acpi_cmos_rtc_space_handler);
+	if (ACPI_FAILURE(status))
+		pr_err("Failed to remove CMOS-RTC address space handler\n");
 }
 EXPORT_SYMBOL_GPL(acpi_remove_cmos_rtc_space_handler);
 
-static int acpi_cmos_rtc_attach_handler(struct acpi_device *adev, const struct acpi_device_id *id)
+static int acpi_cmos_rtc_attach(struct acpi_device *adev,
+				const struct acpi_device_id *id)
 {
 	return acpi_install_cmos_rtc_space_handler(adev->handle);
 }
 
-static void acpi_cmos_rtc_detach_handler(struct acpi_device *adev)
-{
-	acpi_remove_cmos_rtc_space_handler(adev->handle);
-}
-
 static struct acpi_scan_handler cmos_rtc_handler = {
 	.ids = acpi_cmos_rtc_ids,
-	.attach = acpi_cmos_rtc_attach_handler,
-	.detach = acpi_cmos_rtc_detach_handler,
+	.attach = acpi_cmos_rtc_attach,
 };
 
 void __init acpi_cmos_rtc_init(void)
-- 
2.53.0




