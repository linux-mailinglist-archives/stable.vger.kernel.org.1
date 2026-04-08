Return-Path: <stable+bounces-233910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKL6J8lb1mk1EggAu9opvQ
	(envelope-from <stable+bounces-233910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:44:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B64F3BD1F0
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC6DF30733B9
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1536E3BC691;
	Wed,  8 Apr 2026 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f+uXdw4D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC7134676F
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655593; cv=none; b=i2ODat0iZDxMo/cgQ4APrY7Bv0/wpzHGqpS8UrL4wi1NCbBmyxrmVc95/6PYGB+kUp6Cvvm/oyf7ZbMab4Sm3KOYTJ99msbcJVv0XTKUkT/ZKz13yzF1WICd+R2XImFvGDndTREBGVrGHbeybWBtzh8KnJVoiUTVhCTdtaTjxsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655593; c=relaxed/simple;
	bh=P+w+mabdqYSa4SO6cxSwg1/fTJ6xpMqnlyywTHyKqe4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YurbOeZkyzROzm+alqnMaFxXK4oxZra25rrwb1xO1vRs+NaEZawQcDZn9yDnJqdpeMuTgFaklLv4Z7mqkhqLtMGcCpmwQ4wG2G95IFXekhRpUECQnz3lXJCxTuu8+aU923zkI0vZKrYLglggSkiwgffypBJuzanhjQkh6GYMUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f+uXdw4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32649C19421;
	Wed,  8 Apr 2026 13:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775655593;
	bh=P+w+mabdqYSa4SO6cxSwg1/fTJ6xpMqnlyywTHyKqe4=;
	h=Subject:To:Cc:From:Date:From;
	b=f+uXdw4DWM+bMx6gUb+yEUN9GWEUKXnHUUrknIVQ7VMmPravu/e8vby0EOVh1D4cu
	 7K+t025t0J86H126jx9vUGK5YO5jtrohqfAth40wAHFM5yGmtVvfX9T0sONFpveuNC
	 s2I51JPE4MH5TgEyngL9SSTuOz/n0IM5WYLrpO7o=
Subject: FAILED: patch "[PATCH] ACPI: EC: Evaluate _REG outside the EC scope more carefully" failed to apply to 5.10-stable tree
To: rafael.j.wysocki@intel.com,hdegoede@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 15:39:43 +0200
Message-ID: <2026040843-fragrance-brigade-0696@gregkh>
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
	TAGGED_FROM(0.00)[bounces-233910-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,msgid.link:url,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2B64F3BD1F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 71bf41b8e913ec9fc91f0d39ab8fb320229ec604
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040843-fragrance-brigade-0696@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 71bf41b8e913ec9fc91f0d39ab8fb320229ec604 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Mon, 12 Aug 2024 15:16:21 +0200
Subject: [PATCH] ACPI: EC: Evaluate _REG outside the EC scope more carefully

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

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index d9c12db80f11..38d2f6e6b12b 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1487,12 +1487,13 @@ static bool install_gpio_irq_event_handler(struct acpi_ec *ec)
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
@@ -1506,7 +1507,7 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 	}
 
 	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
-		acpi_execute_reg_methods(scope_handle, ACPI_UINT32_MAX, ACPI_ADR_SPACE_EC);
+		acpi_execute_reg_methods(ec->handle, ACPI_UINT32_MAX, ACPI_ADR_SPACE_EC);
 		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
 	}
 
@@ -1721,6 +1722,12 @@ static void acpi_ec_remove(struct acpi_device *device)
 	}
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
index 601b670356e5..aadd4c218b32 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -223,6 +223,7 @@ int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 			      acpi_handle handle, acpi_ec_query_func func,
 			      void *data);
 void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit);
+void acpi_ec_register_opregions(struct acpi_device *adev);
 
 #ifdef CONFIG_PM_SLEEP
 void acpi_ec_flush_work(void);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 59771412686b..22ae7829a915 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2273,6 +2273,8 @@ static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
 	if (device->handler)
 		goto ok;
 
+	acpi_ec_register_opregions(device);
+
 	if (!device->flags.initialized) {
 		device->flags.power_manageable =
 			device->power.states[ACPI_STATE_D0].flags.valid;


