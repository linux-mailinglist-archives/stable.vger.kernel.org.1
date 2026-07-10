Return-Path: <stable+bounces-273279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O2qVNlAbUWrZ/QIAu9opvQ
	(envelope-from <stable+bounces-273279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 18:18:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 390A173C853
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 18:18:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KgQ09nXG;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273279-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273279-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56F473011133
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 16:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A85143B485;
	Fri, 10 Jul 2026 16:14:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C04C2D3A7C
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 16:14:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700088; cv=none; b=bIutYQD/yql6JQx+/IF9at3M/2DpUWoyv+ss1uocaOIbw2I9X+LpRxDKe+Xx9hP1gMN4/tVVykviEGb5WZhAUL5RlWN62oAqRlgHgl1eSElAIARdMbopqYOPz1KYESVurDIkrODUtkhy6Oa4rC4k+l4q+/OobbLCPqZzYL4ZptY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700088; c=relaxed/simple;
	bh=NeBg2VvmXgixgYRuexqKOnA5X/542EqwWrWqFoofkmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiGflZz0g+G2uOb9pRI5pFkLPmpOlp2vOiYEzLtuo1gH0HxKaikeYWwkIuehLrp1OKmLDSIx7GbhEi6m7lYHqtY8ZhzrrJEX2XtKVaRhjxp3ufyDwwA4evV6EwuOHckW1pCxJLiBd3dQxVbg79CTd5a6268LKM6cdidGrw9Bd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgQ09nXG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BC91F00A3E;
	Fri, 10 Jul 2026 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783700086;
	bh=qa4LELX69F4XtF93RPNd7sbtcTAq0uhF9aJUFjQZtc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KgQ09nXGyBB1NkZRIg6syTEDWV9C72zyFWIvfX7Tu1dIIoQPKlm1b7jAsT0K6ZC6W
	 /QFT6gtAmgHhRq/5CkXPdudZPfiVxRzNk+cXSiCte2xHH8IVoN3YvMiWO4bBrPxhqp
	 R1QNrEJ565NTyzF0BJH4xIQxcIlLXvuD90WShoM4wx7ccbTsnlflsIkaTflD6wZLA8
	 8j7Xt7h3btHTZHIJt5sWCvumVF4HmTRlf8m0D3/8YJxdTmjlCtmMMWOUJnfSkKncDd
	 n7V74Sy6RF6H4a41exSSVzic/Qx7mqsJaWfX8l6RXFzpt05BrE07QsGfA7o03T+9Mg
	 kfceiqUJqLFRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] ACPI: NFIT: core: Use devm_acpi_install_notify_handler()
Date: Fri, 10 Jul 2026 12:14:40 -0400
Message-ID: <20260710161442.293558-3-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-273279-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:rafael.j.wysocki@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 390A173C853

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 198541ad53c0d0d891fedea4098f9953a0f566c0 ]

Now that devm_acpi_install_notify_handler() is available, use it in
acpi_nfit_probe() instead of a custom devm action removing an ACPI
notify handler installed via acpi_dev_install_notify_handler().

Also drop the explicit ACPI_COMPANION() check against NULL that is
not necessary any more becuase devm_acpi_install_notify_handler()
carries out an equivalent check internally and use ACPI_HANDLE() to
retrieve the platform device's ACPI handle.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/3048737.e9J7NaK4W3@rafael.j.wysocki
Stable-dep-of: 18a00ed0e718 ("ACPI: NFIT: core: Fix possible deadlock and missing notifications")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 3eb56b77cb6d93..c00cb8661b0b52 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3283,19 +3283,11 @@ static void acpi_nfit_put_table(void *table)
 
 static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *adev = data;
-
-	device_lock(&adev->dev);
-	__acpi_nfit_notify(&adev->dev, handle, event);
-	device_unlock(&adev->dev);
-}
-
-static void acpi_nfit_remove_notify_handler(void *data)
-{
-	struct acpi_device *adev = data;
+	struct device *dev = data;
 
-	acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-				       acpi_nfit_notify);
+	device_lock(dev);
+	__acpi_nfit_notify(dev, handle, event);
+	device_unlock(dev);
 }
 
 void acpi_nfit_shutdown(void *data)
@@ -3338,13 +3330,8 @@ static int acpi_nfit_add(struct acpi_device *adev)
 	acpi_size sz;
 	int rc = 0;
 
-	rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-					     acpi_nfit_notify, adev);
-	if (rc)
-		return rc;
-
-	rc = devm_add_action_or_reset(dev, acpi_nfit_remove_notify_handler,
-					adev);
+	rc = devm_acpi_install_notify_handler(dev, ACPI_DEVICE_NOTIFY,
+					      acpi_nfit_notify, dev);
 	if (rc)
 		return rc;
 
@@ -3375,7 +3362,7 @@ static int acpi_nfit_add(struct acpi_device *adev)
 	acpi_desc->acpi_header = *tbl;
 
 	/* Evaluate _FIT and override with that if present */
-	status = acpi_evaluate_object(adev->handle, "_FIT", NULL, &buf);
+	status = acpi_evaluate_object(ACPI_HANDLE(dev), "_FIT", NULL, &buf);
 	if (ACPI_SUCCESS(status) && buf.length > 0) {
 		union acpi_object *obj = buf.pointer;
 
-- 
2.53.0


