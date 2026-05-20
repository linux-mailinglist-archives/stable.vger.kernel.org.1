Return-Path: <stable+bounces-250049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLg6MkEMDmo35wUAu9opvQ
	(envelope-from <stable+bounces-250049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:32:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31432598681
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC81D341EDC4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABB93D7D8C;
	Wed, 20 May 2026 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VZl/IgHw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591883D6673;
	Wed, 20 May 2026 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294409; cv=none; b=ExLOcgo3aKlQ7n8MJDzsQxr41O6VmnF8X+fJvE+pjhzJ+J9rEVAiCkTESZ9KeYZSu0vaW9Nzcrb6JDufw27bfdlOjbrk4GtcfGIUP3UneEgQLM2Hvfn7AoEkVfXSSHtyicrDl1ka+wobW0eENXwLyrf7qs1nylyaly1F/nHw8eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294409; c=relaxed/simple;
	bh=5lLdM8QOIrCV7axhVVn4xMewfuq1DO23QYXVGcpujTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCCKt60rIQz09WQL98hhpRxqZI7DBVKZzTdLSqj11M1IvXAKiBfZTtGW0K2eku8ja6iY9rmvEhs4tcfDwJU61ujwiAnoJU88Nt/6ywVFwmzTht/4LUNeGkQG8yWWq7LBujToMWI8aZjqL8ZKieoRabnQVSVLX4HW7Kpaazm6EF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VZl/IgHw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904CE1F000E9;
	Wed, 20 May 2026 16:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294408;
	bh=8LwrXCyXQLjN8Bq8qn7ZybpDe5un5QmLDKShWXFQpY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VZl/IgHwdqSL2nzVECQu8hjyIoknjLzYIZQgEXyCUse51jkSnvl7BWBqM96WbWLEW
	 Y1ovmlAJpyXOPi0dPpnpngY8Mq/35VTaq3Xi/mTzt7MBd22acr0WNwFUaxVBi6r+hN
	 umC8YRH44+uoHmjF70hQjs4ofCHR2hpKJbXcbHnU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0028/1146] ACPI: x86: cmos_rtc: Improve coordination with ACPI TAD driver
Date: Wed, 20 May 2026 18:04:38 +0200
Message-ID: <20260520162149.020760583@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250049-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 31432598681
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 6cee29ad9d7e400d39ae0b1a54447fedcb62eecd ]

If a CMOS RTC (PNP0B00/PNP0B01/PNP0B02) device coexists with an ACPI
TAD (timer and event alarm device, ACPI000E), the ACPI TAD driver will
attempt to install the CMOS RTC address space hanlder that has been
installed already and the TAD probing will fail.

Avoid that by changing acpi_install_cmos_rtc_space_handler() to return
zero and acpi_remove_cmos_rtc_space_handler() to do nothing if the CMOS
RTC address space handler has been installed already.

Fixes: 596ca52a56da ("ACPI: TAD: Install SystemCMOS address space handler for ACPI000E")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/2415111.ElGaqSPkdT@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/cmos_rtc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/cmos_rtc.c b/drivers/acpi/x86/cmos_rtc.c
index 977234da9fc11..45db7e51cbe60 100644
--- a/drivers/acpi/x86/cmos_rtc.c
+++ b/drivers/acpi/x86/cmos_rtc.c
@@ -24,6 +24,8 @@ static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
 	{}
 };
 
+static bool cmos_rtc_space_handler_present __read_mostly;
+
 static acpi_status acpi_cmos_rtc_space_handler(u32 function,
 					       acpi_physical_address address,
 					       u32 bits, u64 *value64,
@@ -59,6 +61,9 @@ int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
 {
 	acpi_status status;
 
+	if (cmos_rtc_space_handler_present)
+		return 0;
+
 	status = acpi_install_address_space_handler(handle,
 						    ACPI_ADR_SPACE_CMOS,
 						    acpi_cmos_rtc_space_handler,
@@ -68,6 +73,8 @@ int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
 		return -ENODEV;
 	}
 
+	cmos_rtc_space_handler_present = true;
+
 	return 1;
 }
 EXPORT_SYMBOL_GPL(acpi_install_cmos_rtc_space_handler);
@@ -76,6 +83,9 @@ void acpi_remove_cmos_rtc_space_handler(acpi_handle handle)
 {
 	acpi_status status;
 
+	if (cmos_rtc_space_handler_present)
+		return;
+
 	status = acpi_remove_address_space_handler(handle,
 						   ACPI_ADR_SPACE_CMOS,
 						   acpi_cmos_rtc_space_handler);
@@ -87,7 +97,13 @@ EXPORT_SYMBOL_GPL(acpi_remove_cmos_rtc_space_handler);
 static int acpi_cmos_rtc_attach(struct acpi_device *adev,
 				const struct acpi_device_id *id)
 {
-	return acpi_install_cmos_rtc_space_handler(adev->handle);
+	int ret;
+
+	ret = acpi_install_cmos_rtc_space_handler(adev->handle);
+	if (ret < 0)
+		return ret;
+
+	return 1;
 }
 
 static struct acpi_scan_handler cmos_rtc_handler = {
-- 
2.53.0




