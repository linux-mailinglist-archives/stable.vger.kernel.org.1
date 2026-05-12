Return-Path: <stable+bounces-246663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEYMDNuOA2qM7QEAu9opvQ
	(envelope-from <stable+bounces-246663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:34:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8C75294C3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C04430F8961
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C357D3CC33C;
	Tue, 12 May 2026 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b="NSzlILHS"
X-Original-To: stable@vger.kernel.org
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CAD3C9EF8
	for <stable@vger.kernel.org>; Tue, 12 May 2026 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617618; cv=none; b=UviHo0zaJVBQcfrNW8FYNBiXQzcii4FwwtMhu9i4sils059QP1hpS6FktIzq5FU2+fg/uKn6Yj3AXIdL/M+wBMybnoCQWh+I+53i0XhMMq1+6b6BuCM/caGhWSA6RBh+f6imJhZLnb4XKlKyJHQgl/f7xqp21qh98iUd7d00Pdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617618; c=relaxed/simple;
	bh=isRXKxL0q1oc209W6uQUczP4eb2xyKf6+5fC3UTV5Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mz3wtC+oRj966EAORIFVrS/fUVzigK9nhGPMTEHndr7ZIe1/TuqXw2F0M+8rNoCKwHmLRo2Im0n37/QS5fpi3xB/gV6a8Mm5Tb3AWobaXsCTUZTG7+meW//7C+1co5ESpJuerQW5wbVWhd6hdwvXaBIW04a819WURCdH9ojubBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh; spf=pass smtp.mailfrom=gibson.sh; dkim=pass (2048-bit key) header.d=gibson.sh header.i=@gibson.sh header.b=NSzlILHS; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gibson.sh
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gFSms2GkqzxcL
	for <stable@vger.kernel.org>; Tue, 12 May 2026 22:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gibson.sh;
	s=20260228; t=1778617613;
	bh=s7u6TuEJ24aqktW/yoYHaCvxZsxRD1OEAJRsO0CmXcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NSzlILHS5VoRHpfj52hnMm+xJ2P3t1YNj6JLGgWvGB2MY6QoHQEx8eQ5qyZfYpz9Z
	 brDdqCQb+sx9DVGyEAhBU2mGfusBqGrPQ8OWDZfT7fvwwZ9BdhAOohYQuBj3UpKLtT
	 0jzXI6Jbd1bZMUf4sG/+eXpkO47IMCpAVxRTVZsUXXG3HipJBEPP7sj0t5njHyzlh2
	 qmI+A7+UpxLlYBL8aIaJ8MzCigJXBkcHiWfF6EhM+eQsapfAW0JQNJcpf+5zno1gg0
	 hAfA9nQhicX6x/e1WUz2tZuchs5JY70n0HaUu2aCp5QhQpkA4PAWjwDjMFbqwSRCMD
	 L+fWUwURMy3Fw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gFSmr6TyFzCvy
	for <stable@vger.kernel.org>; Tue, 12 May 2026 22:26:52 +0200 (CEST)
Received: from unknown by spiderdemon.horst.lan (DragonFly Mail Agent v0.13);
	Tue, 12 May 2026 22:26:52 +0200
From: Daniel Gibson <daniel@gibson.sh>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>
Cc: Daniel Gibson <daniel@gibson.sh>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/5] platform/x86/amd/pmc: Add delay_suspend module parameter
Date: Tue, 12 May 2026 22:26:43 +0200
Message-ID: <20260512202645.1549111-4-daniel@gibson.sh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260512202645.1549111-1-daniel@gibson.sh>
References: <20260512202645.1549111-1-daniel@gibson.sh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Rspamd-Queue-Id: EB8C75294C3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gibson.sh:s=20260228];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gibson.sh:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246663-lists,stable=lfdr.de];
	DMARC_NA(0.00)[gibson.sh];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@gibson.sh,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Enabling the new delay_suspend module parameter delays suspend for
2.5 seconds which is known to help for some AMD-based Lenovo Laptops
that otherwise failed to send/receive events for key presses or the
lid switch after s2idle. Apparently the EC needs to do some things
in the background before suspend or it gets into a bad state.

There are many reports of AMD-based laptops (mostly but not exclusively
IdeaPads) about similar issues on the web; this parameter gives
affected users an easy way to try out if their issues have the same
root cause and to work around them until their specific device is added
to the quirks list.

The parameter description has a note encouraging users to report
their device so it can be added to the quirks list, inspired by a
similar request in parameter descriptions of the ideapad-laptop module.

The module parameter can be set to "1" to explicitly enable it,
"0" to disable it even on devices that are assumed to be affected,
or -1 (the default) to enable it if the device is assumed to be affected
(according to fwbug_list[])

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221383
Signed-off-by: Daniel Gibson <daniel@gibson.sh>
Cc: stable@vger.kernel.org
---
 drivers/platform/x86/amd/pmc/pmc.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 6bafd8661d68..2d3d180c15d2 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -16,6 +16,7 @@
 #include <linux/bits.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/limits.h>
@@ -89,6 +90,11 @@ static bool disable_workarounds;
 module_param(disable_workarounds, bool, 0644);
 MODULE_PARM_DESC(disable_workarounds, "Disable workarounds for platform bugs");
 
+static int delay_suspend = -1;
+module_param(delay_suspend, int, 0644);
+MODULE_PARM_DESC(delay_suspend,
+		 "Delays s2idle by 2.5 seconds to work around buggy ECs, often causing keyboard issues after suspend. 0: don't delay, 1: do delay, -1 (default): let amd_pmc decide. If you need this please report this to: platform-driver-x86@vger.kernel.org");
+
 static struct amd_pmc_dev pmc;
 
 static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
@@ -625,8 +631,23 @@ static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
 	 *
 	 * See https://bugzilla.kernel.org/show_bug.cgi?id=221383
 	 */
-	if (!disable_workarounds && amd_pmc_quirk_need_suspend_delay(pdev)) {
-		dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
+	if (amd_pmc_quirk_need_suspend_delay(pdev)) {
+		/*
+		 * delay_suspend=1 force-enables this, otherwise it can be
+		 * disabled with disable_workarounds or delay_suspend=0
+		 */
+		if (delay_suspend == 1 || (delay_suspend == -1 && !disable_workarounds)) {
+			dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
+			return true;
+		}
+		dev_info(pdev->dev, "Not delaying suspend because of module parameter, even though your device is assumed to need it!\n");
+	} else if (delay_suspend == 1) {
+		dev_info(pdev->dev, "Delaying suspend by 2.5s because delay_suspend=1. If this solves problems on your machine, please report this whole line to: platform-driver-x86@vger.kernel.org so it can be automatically detected as affected in the future. System Vendor: \"%s\" Product Name: \"%s\" Product Family: \"%s\" Board Vendor: \"%s\" Board Name: \"%s\"\n",
+			 dmi_get_system_info(DMI_SYS_VENDOR),
+			 dmi_get_system_info(DMI_PRODUCT_NAME),
+			 dmi_get_system_info(DMI_PRODUCT_FAMILY),
+			 dmi_get_system_info(DMI_BOARD_VENDOR),
+			 dmi_get_system_info(DMI_BOARD_NAME));
 		return true;
 	}
 	return false;
-- 
2.48.1


