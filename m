Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5C878DB19
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 20:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbjH3Si3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 14:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245243AbjH3OyD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 10:54:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF3A198
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 07:54:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2FBA615B4
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 14:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA2AC433C9;
        Wed, 30 Aug 2023 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693407240;
        bh=lMmRYNqlhOrbWWKzhwoZ59JMj/Hi+w+yaGvFMQYy3+8=;
        h=Subject:To:Cc:From:Date:From;
        b=U2b2CqgUwC6N8O5SH0Mob2P8oP8H3wH9cudnlYYUTqm+3G+v9EmIFvFahIP/ELAYY
         jfschSeuY1jiolRKLq5KqJKHVR78mRAiRTxiv23ipNmMBu6ehLUU6OpTFtXlv3BXH/
         3Ydlr96vCVWvZeA+RkuLp+/kwIjrbfxZwqLkKw2U=
Subject: FAILED: patch "[PATCH] ACPI: thermal: Drop nocrt parameter" failed to apply to 4.19-stable tree
To:     mario.limonciello@amd.com, rafael.j.wysocki@intel.com,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 30 Aug 2023 16:53:47 +0200
Message-ID: <2023083047-alive-reburial-8310@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 5f641174a12b8a876a4101201a21ef4675ecc014
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023083047-alive-reburial-8310@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

5f641174a12b ("ACPI: thermal: Drop nocrt parameter")
f86b15a1e654 ("ACPI: thermal: Clean up printing messages")
7f49a5cb94e6 ("ACPI: thermal: switch to use <linux/units.h> helpers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f641174a12b8a876a4101201a21ef4675ecc014 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Wed, 12 Jul 2023 12:24:59 -0500
Subject: [PATCH] ACPI: thermal: Drop nocrt parameter

The `nocrt` module parameter has no code associated with it and does
nothing.  As `crt=-1` has same functionality as what nocrt should be
doing drop `nocrt` and associated documentation.

This should fix a quirk for Gigabyte GA-7ZX that used `nocrt` and
thus didn't function properly.

Fixes: 8c99fdce3078 ("ACPI: thermal: set "thermal.nocrt" via DMI on Gigabyte GA-7ZX")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1457995fd41..2de235d52fac 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6243,10 +6243,6 @@
 			-1: disable all critical trip points in all thermal zones
 			<degrees C>: override all critical trip points
 
-	thermal.nocrt=	[HW,ACPI]
-			Set to disable actions on ACPI thermal zone
-			critical and hot trip points.
-
 	thermal.off=	[HW,ACPI]
 			1: disable ACPI thermal control
 
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index f9f6ebb08fdb..3163a40f02e3 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -82,10 +82,6 @@ static int tzp;
 module_param(tzp, int, 0444);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.");
 
-static int nocrt;
-module_param(nocrt, int, 0);
-MODULE_PARM_DESC(nocrt, "Set to take no action upon ACPI thermal zone critical trips points.");
-
 static int off;
 module_param(off, int, 0);
 MODULE_PARM_DESC(off, "Set to disable ACPI thermal support.");
@@ -1094,7 +1090,7 @@ static int thermal_act(const struct dmi_system_id *d) {
 static int thermal_nocrt(const struct dmi_system_id *d) {
 	pr_notice("%s detected: disabling all critical thermal trip point actions.\n",
 		  d->ident);
-	nocrt = 1;
+	crt = -1;
 	return 0;
 }
 static int thermal_tzp(const struct dmi_system_id *d) {

