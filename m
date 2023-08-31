Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2400778EBBD
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 13:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjHaLNM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 07:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbjHaLNL (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 07:13:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EA410F8
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:12:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E915AB8226C
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594D0C433C7;
        Thu, 31 Aug 2023 11:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693480367;
        bh=ikLy3LMC87NCzYFMV2089d3qbZS68zfwvclYIyQThec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2GsK7Du0rLdIZnvGoAjeTDzjzBV4M2c7mzoqx6vK1umeOVpNH4MMRHXFOCV6dBT8B
         Bqaxkr98lWYEw9p5NmVJwe1n4Q54R6IbQ9sAYiUorWW6/gl6ZXQ4vF7Lf+Kjhxo8eF
         21JiUICg1EyjvGxo+G8mJFMxpi6b5+hO+j+NxZvY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.4 1/9] ACPI: thermal: Drop nocrt parameter
Date:   Thu, 31 Aug 2023 13:11:28 +0200
Message-ID: <20230831111127.736363489@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831111127.667900990@linuxfoundation.org>
References: <20230831111127.667900990@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 5f641174a12b8a876a4101201a21ef4675ecc014 upstream.

The `nocrt` module parameter has no code associated with it and does
nothing.  As `crt=-1` has same functionality as what nocrt should be
doing drop `nocrt` and associated documentation.

This should fix a quirk for Gigabyte GA-7ZX that used `nocrt` and
thus didn't function properly.

Fixes: 8c99fdce3078 ("ACPI: thermal: set "thermal.nocrt" via DMI on Gigabyte GA-7ZX")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/kernel-parameters.txt |    4 ----
 drivers/acpi/thermal.c                          |    6 +-----
 2 files changed, 1 insertion(+), 9 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6240,10 +6240,6 @@
 			-1: disable all critical trip points in all thermal zones
 			<degrees C>: override all critical trip points
 
-	thermal.nocrt=	[HW,ACPI]
-			Set to disable actions on ACPI thermal zone
-			critical and hot trip points.
-
 	thermal.off=	[HW,ACPI]
 			1: disable ACPI thermal control
 
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -59,10 +59,6 @@ static int tzp;
 module_param(tzp, int, 0444);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.");
 
-static int nocrt;
-module_param(nocrt, int, 0);
-MODULE_PARM_DESC(nocrt, "Set to take no action upon ACPI thermal zone critical trips points.");
-
 static int off;
 module_param(off, int, 0);
 MODULE_PARM_DESC(off, "Set to disable ACPI thermal support.");
@@ -1143,7 +1139,7 @@ static int thermal_act(const struct dmi_
 static int thermal_nocrt(const struct dmi_system_id *d) {
 	pr_notice("%s detected: disabling all critical thermal trip point actions.\n",
 		  d->ident);
-	nocrt = 1;
+	crt = -1;
 	return 0;
 }
 static int thermal_tzp(const struct dmi_system_id *d) {


