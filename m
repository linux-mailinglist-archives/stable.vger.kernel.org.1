Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30D2703518
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243156AbjEOQzk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243160AbjEOQzV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:55:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F3549D1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:55:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45F90629E1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A73C433EF;
        Mon, 15 May 2023 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169719;
        bh=UJsRPEDycWg25Bhh4Bhj9yGVkyTzFDvF01blEKrjWJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kc8HJxKFqBzirMcHdffyTgj2UCNBiTtHkvrVa+vy1qN+nrk/Moe2eqDVrzW4ytDjy
         R/isZL1zMYilEXO2XPqtjjrCjyvi50loia4VliubQm4Xp3ittQ8I/dlp8hSua0mBwq
         Aph5ZLVjXwG2CdZLf7yUq3WvqbVSHrxRzY6xM0Ms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Pearson <mpearson-lenovo@squebb.ca>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.3 147/246] platform/x86: thinkpad_acpi: Add profile force ability
Date:   Mon, 15 May 2023 18:25:59 +0200
Message-Id: <20230515161726.966835245@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Pearson <mpearson-lenovo@squebb.ca>

commit 1684878952929e20a864af5df7b498941c750f45 upstream.

There has been a lot of confusion around which platform profiles are
supported on various platforms and it would be useful to have a debug
method to be able to override the profile mode that is selected.

I don't expect this to be used in anything other than debugging in
conjunction with Lenovo engineers - but it does give a way to get a
system working whilst we wait for either FW fixes, or a driver fix
to land upstream, if something is wonky in the mode detection logic

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Link: https://lore.kernel.org/r/20230505132523.214338-2-mpearson-lenovo@squebb.ca
Cc: stable@vger.kernel.org
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/thinkpad_acpi.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10318,6 +10318,7 @@ static atomic_t dytc_ignore_event = ATOM
 static DEFINE_MUTEX(dytc_mutex);
 static int dytc_capabilities;
 static bool dytc_mmc_get_available;
+static int profile_force;
 
 static int convert_dytc_to_profile(int funcmode, int dytcmode,
 		enum platform_profile_option *profile)
@@ -10580,6 +10581,21 @@ static int tpacpi_dytc_profile_init(stru
 	if (err)
 		return err;
 
+	/* Check if user wants to override the profile selection */
+	if (profile_force) {
+		switch (profile_force) {
+		case -1:
+			dytc_capabilities = 0;
+			break;
+		case 1:
+			dytc_capabilities = BIT(DYTC_FC_MMC);
+			break;
+		case 2:
+			dytc_capabilities = BIT(DYTC_FC_PSC);
+			break;
+		}
+		pr_debug("Profile selection forced: 0x%x\n", dytc_capabilities);
+	}
 	if (dytc_capabilities & BIT(DYTC_FC_MMC)) { /* MMC MODE */
 		pr_debug("MMC is supported\n");
 		/*
@@ -11641,6 +11657,9 @@ MODULE_PARM_DESC(uwb_state,
 		 "Initial state of the emulated UWB switch");
 #endif
 
+module_param(profile_force, int, 0444);
+MODULE_PARM_DESC(profile_force, "Force profile mode. -1=off, 1=MMC, 2=PSC");
+
 static void thinkpad_acpi_module_exit(void)
 {
 	struct ibm_struct *ibm, *itmp;


