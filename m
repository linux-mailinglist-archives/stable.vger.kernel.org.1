Return-Path: <stable+bounces-235776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHp5JDbv2mnn7AgAu9opvQ
	(envelope-from <stable+bounces-235776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 03:02:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5BC3E2445
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 03:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38B68301DE08
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 01:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F07925782D;
	Sun, 12 Apr 2026 01:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR0t2LJe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E718EB0
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 01:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775955754; cv=none; b=ASs9+LPrymrf5f53yYzzxR2qGu5KSbSrE+QmZc/zKaDGlPbuTlVaXIRAMf2lkDyf++s/LEbEOQAadYaVCQbMKMIdcDjaSwVCr33WUoZr1l24LndsWCk1zThtN/SYjUAt/NgjTJuYOrRfSTBARYBl3Y0WgiCU4Mt8dpPpUo8bAfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775955754; c=relaxed/simple;
	bh=QiZ18xropE8dpdf5zHcg/w0+hrA+L0O9j6a4rqKqJyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUDgzbAwOCc9KMha1QNSpbwtRMVT4SCgTLNnmyvCAQWpsptNuUE8zPNrzcQ/Gmg2iuSgGkhkoFv5OBluhHD37KaFOWqoP961rpbSv1BLO7Wd5N8+WXkWQxMjeBOaSECG6slHjddnNeBThrlyYkSflerAgZHrbs45eRSVsCQsoaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WR0t2LJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA55C2BCB3;
	Sun, 12 Apr 2026 01:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775955754;
	bh=QiZ18xropE8dpdf5zHcg/w0+hrA+L0O9j6a4rqKqJyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WR0t2LJepnvUX3pcenwhG5XPpTXrJiaflUWV8E6SmBW34qn7ckV1AV7Bsk3BtspXq
	 EHCSM+I7ZHFBj2UBS8SrNFVDooPAVG7jjggWXITXdKsBOtKrkRA7pUaJA6gaLVbiw2
	 /1xgBpvO5OWIlVFn4b+gf0CxIWdlhWL5FqVynxklkUM/DrSmMz1xYMDOiXM5f7z+EY
	 yQH1VsigTrzD39IzxzpGTjDyo1YzpEkX2OfBY26zyXllXCvB9KDItpqsCJeWfGeNTD
	 Xni2/a/5zwfSQKYXDTISdVNNT5lhDmoyrUmlQxtACkt+3T79XuBHzB9Wy1Co01EdFT
	 gS+4SHaR/JzfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] ACPI: EC: Evaluate _REG outside the EC scope more carefully
Date: Sat, 11 Apr 2026 21:02:30 -0400
Message-ID: <20260412010230.1904734-3-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-235776-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 2C5BC3E2445
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 71bf41b8e913ec9fc91f0d39ab8fb320229ec604 ]

Commit 60fa6ae6e6d0 ("ACPI: EC: Install address space handler at the
namespace root") caused _REG methods for EC operation regions outside
the EC device scope to be evaluated which on some systems leads to the
evaluation of _REG methods in the scopes of device objects representing
devices that are not present and not functional according to the _STA
return values. Some of those device objects represent EC "alternatives"
and if _REG is evaluated for their operation regions, the platform
firmware may be confused and the platform may start to behave
incorrectly.

To avoid this problem, only evaluate _REG for EC operation regions
located in the scopes of device objects representing known-to-be-present
devices.

For this purpose, partially revert commit 60fa6ae6e6d0 and trigger the
evaluation of _REG for EC operation regions from acpi_bus_attach() for
the known-valid devices.

Fixes: 60fa6ae6e6d0 ("ACPI: EC: Install address space handler at the namespace root")
Link: https://lore.kernel.org/linux-acpi/1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2298938
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2302253
Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Cc: All applicable <stable@vger.kernel.org>
Link: https://patch.msgid.link/23612351.6Emhk5qWAg@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c       | 11 +++++++++--
 drivers/acpi/internal.h |  1 +
 drivers/acpi/scan.c     |  2 ++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index d0ce8ec19df5a..d00fd26c274f2 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1512,12 +1512,13 @@ static bool install_gpio_irq_event_handler(struct acpi_ec *ec)
 static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 			       bool call_reg)
 {
-	acpi_handle scope_handle = ec == first_ec ? ACPI_ROOT_OBJECT : ec->handle;
 	acpi_status status;
 
 	acpi_ec_start(ec, false);
 
 	if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
+		acpi_handle scope_handle = ec == first_ec ? ACPI_ROOT_OBJECT : ec->handle;
+
 		acpi_ec_enter_noirq(ec);
 		status = acpi_install_address_space_handler_no_reg(scope_handle,
 								   ACPI_ADR_SPACE_EC,
@@ -1531,7 +1532,7 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 	}
 
 	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
-		acpi_execute_reg_methods(scope_handle, ACPI_UINT32_MAX, ACPI_ADR_SPACE_EC);
+		acpi_execute_reg_methods(ec->handle, ACPI_UINT32_MAX, ACPI_ADR_SPACE_EC);
 		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
 	}
 
@@ -1749,6 +1750,12 @@ static int acpi_ec_remove(struct acpi_device *device)
 	return 0;
 }
 
+void acpi_ec_register_opregions(struct acpi_device *adev)
+{
+	if (first_ec && first_ec->handle != adev->handle)
+		acpi_execute_reg_methods(adev->handle, 1, ACPI_ADR_SPACE_EC);
+}
+
 static acpi_status
 ec_parse_io_ports(struct acpi_resource *resource, void *context)
 {
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 219c02df9a08c..4e742b5ee6790 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -210,6 +210,7 @@ int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 			      acpi_handle handle, acpi_ec_query_func func,
 			      void *data);
 void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit);
+void acpi_ec_register_opregions(struct acpi_device *adev);
 
 #ifdef CONFIG_PM_SLEEP
 void acpi_ec_flush_work(void);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9e8f38e525893..d1c81ad9b2f67 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2198,6 +2198,8 @@ static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
 	if (device->handler)
 		goto ok;
 
+	acpi_ec_register_opregions(device);
+
 	if (!device->flags.initialized) {
 		device->flags.power_manageable =
 			device->power.states[ACPI_STATE_D0].flags.valid;
-- 
2.53.0


