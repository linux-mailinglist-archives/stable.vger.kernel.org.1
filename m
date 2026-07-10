Return-Path: <stable+bounces-273253-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7aTQMpEFUWpT+AIAu9opvQ
	(envelope-from <stable+bounces-273253-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 16:45:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3377673BDDC
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 16:45:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YnWkHOIg;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273253-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273253-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 183E2302C5F3
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7039334CFD3;
	Fri, 10 Jul 2026 14:39:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F370348C5A
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 14:38:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694340; cv=none; b=Iz+9vi5rOk7jY3neLVRiX0T5iavnR4PcTnWOjo2SQue4zIpw+9teqsAPyS5f4tsGvIOI0HqPzc+JE9GdYHNShBt4/9jmbSQmw3N02F6tWotta4osn7HOLk1a3emSTrez6JJpPsfJocrwPcGlABD3ScGDgPVbNW+s6cfe19O/8s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694340; c=relaxed/simple;
	bh=OkM6+rxKYutuPxBBB9XM/0xrzFcRCdD4ktOFJtiUc/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuKi7tJZYH+KbNcdQtD2/xWGdAeI4Rm37rpChcfKVoatC4b03CP3/I2kOsay7dl+oDXej7FZHIZD7Q3muwUmU+9BAeP8Gs55xCmj57Um0dzJcddz5lN76Y+3HVxRkbD9fYytYjaPkl8o57vrbtpa15sHB5/pYXxsL+LvKQLQCxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnWkHOIg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CF61F000E9;
	Fri, 10 Jul 2026 14:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783694338;
	bh=D0tMYkyUjS4cBSwZHMNSq8l4+rNcWd6J1RLbo1q+RxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YnWkHOIgEO5j9ztFYRrDA9mU5AcklaWanePTFyp87XGyyEDrP8gipeCGgX8uLkdiA
	 fA3lFKoDKRYjhDar9fntTL68qzgj+0gdUjls7Zt4s9d1Mg7IKHa3j5gW4gF0LSXjSH
	 dm7xPijEd9f9Dq3W8VF63PS/dlfh+DFze+9H/svn4G5UTeGcyKjc/TccXmA79EyuzB
	 XHo3lSTBF9GaAohCquHa+FGcKVK5ah1veWn7RrnP8jdsp1xmJTccN+WDtfEtKHG/MU
	 X7ocQQcB3DHx/vquaPuqGUV/T6NtXtfDQLlXxeud35zGm9A8lctuzg+Gm1+0KNEgUt
	 hOm5OyhVnpLbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ACPI: NFIT: core: Fix acpi_nfit_init() error cleanup
Date: Fri, 10 Jul 2026 10:38:56 -0400
Message-ID: <20260710143856.184042-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070918-egotistic-sculptor-67ad@gregkh>
References: <2026070918-egotistic-sculptor-67ad@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:rafael.j.wysocki@intel.com,m:dave.jiang@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273253-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3377673BDDC

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 38bf27511ef41bffebd157ec3eba41fc89ba59cd ]

If acpi_nfit_init() fails after adding the acpi_desc object to the
acpi_descs list, that object is never removed from that list because
the acpi_nfit_shutdown() devm action is not added for the NFIT device
in that case.  Next, the acpi_nfit_init() failure causes
acpi_nfit_probe() to fail, the acpi_desc object is freed, and a
dangling pointer is left behind in the acpi_descs.  Any subsequent
ACPI Machine Check Exception will trigger nfit_handle_mce() which
iterates over acpi_descs and so a use-after-free will occur.

Moreover, if acpi_nfit_probe() returns 0 after installing a notify
handler for the NFIT device and without allocating the acpi_desc
object and setting the NFIT device's driver data pointer, the
acpi_desc object will be allocated by acpi_nfit_update_notify()
and acpi_nfit_init() will be called to initialize it.  Regardless
of whether or not acpi_nfit_init() fails in that case, the
acpi_nfit_shutdown() devm action is not added for the NFIT device
and acpi_desc is never removed from the acpi_descs list.  If the
acpi_desc object is freed subsequently on driver removal, any
subsequent ACPI MCE will lead to a use-after-free like in the
previous case.

To address the first issue mentioned above, make acpi_nfit_probe()
call acpi_nfit_shutdown() directly on acpi_nfit_init() failures and
to address the other one, add a remove callback to the driver and
make it call acpi_nfit_shutdown().  Also, since it is now possible to
pass NULL to acpi_nfit_shutdown() or the acpi_desc object passed to it
may not have been initialized, add checks against NULL for acpi_desc and
its nvdimm_bus field to that function and make acpi_nfit_unregister()
clear the latter after unregistering the NVDIMM bus.

Fixes: a61fe6f7902e ("nfit, tools/testing/nvdimm: unify common init for acpi_nfit_desc")
Fixes: fbabd829fe76 ("acpi, nfit: fix module unload vs workqueue shutdown race")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: All applicable <stable@vger.kernel.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://patch.msgid.link/1963615.tdWV9SEqCh@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index e420f773d67443..035384b919c1f7 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3445,6 +3445,8 @@ static void acpi_nfit_unregister(void *data)
 	struct acpi_nfit_desc *acpi_desc = data;
 
 	nvdimm_bus_unregister(acpi_desc->nvdimm_bus);
+	/* The nvdimm_bus object may have been freed, so clear the pointer. */
+	acpi_desc->nvdimm_bus = NULL;
 }
 
 int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, void *data, acpi_size sz)
@@ -3669,7 +3671,10 @@ static void acpi_nfit_put_table(void *table)
 void acpi_nfit_shutdown(void *data)
 {
 	struct acpi_nfit_desc *acpi_desc = data;
-	struct device *bus_dev = to_nvdimm_bus_dev(acpi_desc->nvdimm_bus);
+	struct device *bus_dev;
+
+	if (!acpi_desc || !acpi_desc->nvdimm_bus)
+		return;
 
 	/*
 	 * Destruct under acpi_desc_lock so that nfit_handle_mce does not
@@ -3684,6 +3689,7 @@ void acpi_nfit_shutdown(void *data)
 	mutex_unlock(&acpi_desc->init_mutex);
 	cancel_delayed_work_sync(&acpi_desc->dwork);
 
+	bus_dev = to_nvdimm_bus_dev(acpi_desc->nvdimm_bus);
 	/*
 	 * Bounce the nvdimm bus lock to make sure any in-flight
 	 * acpi_nfit_ars_rescan() submissions have had a chance to
@@ -3751,13 +3757,14 @@ static int acpi_nfit_add(struct acpi_device *adev)
 				sz - sizeof(struct acpi_table_nfit));
 
 	if (rc)
-		return rc;
-	return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
+		acpi_nfit_shutdown(acpi_desc);
+
+	return rc;
 }
 
 static int acpi_nfit_remove(struct acpi_device *adev)
 {
-	/* see acpi_nfit_unregister */
+	acpi_nfit_shutdown(dev_get_drvdata(&adev->dev));
 	return 0;
 }
 
-- 
2.53.0


