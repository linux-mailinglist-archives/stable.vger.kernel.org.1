Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CB5703790
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244016AbjEORWv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244018AbjEORWg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:22:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8A376B2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38EF162BEC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5BEC4339B;
        Mon, 15 May 2023 17:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171236;
        bh=v0LR2KYR8PyyF39lOMybbrGeHTn4QIJZBer4850tj4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1iOhxvMnValwFOPjrUJBfTjFaRSTXQyynCDsmEXUiohsM/JEheQPeshscqjcUq/V
         q27HBK6tsSc2pB44/wpX8G30m9+zs7JqTv0jM2zrgYNCaAx2M/UzWpKteaRTxzoHrn
         OAb6vXGOTdTdaK/VeeKCPyvXPhK+u5hMBOo2p+CU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Pearson <mpearson-lenovo@squebb.ca>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.2 145/242] platform/x86: thinkpad_acpi: Fix platform profiles on T490
Date:   Mon, 15 May 2023 18:27:51 +0200
Message-Id: <20230515161726.249615394@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

commit 0c0cd3e25a5b64b541dd83ba6e032475a9d77432 upstream.

I had incorrectly thought that PSC profiles were not usable on Intel
platforms so had blocked them in the driver initialistion. This broke
platform profiles on the T490.

After discussion with the FW team PSC does work on Intel platforms and
should be allowed.

Note - it's possible this may impact other platforms where it is advertised
but special driver support that only Windows has is needed. But if it does
then they will need fixing via quirks. Please report any issues to me so I
can get them addressed - but I haven't found any problems in testing...yet

Fixes: bce6243f767f ("platform/x86: thinkpad_acpi: do not use PSC mode on Intel platforms")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2177962
Cc: stable@vger.kernel.org
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Link: https://lore.kernel.org/r/20230505132523.214338-1-mpearson-lenovo@squebb.ca
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/thinkpad_acpi.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10593,11 +10593,6 @@ static int tpacpi_dytc_profile_init(stru
 				dytc_mmc_get_available = true;
 		}
 	} else if (dytc_capabilities & BIT(DYTC_FC_PSC)) { /* PSC MODE */
-		/* Support for this only works on AMD platforms */
-		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
-			dbg_printk(TPACPI_DBG_INIT, "PSC not support on Intel platforms\n");
-			return -ENODEV;
-		}
 		pr_debug("PSC is supported\n");
 	} else {
 		dbg_printk(TPACPI_DBG_INIT, "No DYTC support available\n");


