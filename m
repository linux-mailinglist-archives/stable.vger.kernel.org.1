Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39257D3199
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjJWLK7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjJWLK6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:10:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE1FC5
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:10:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493FCC433C9;
        Mon, 23 Oct 2023 11:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059453;
        bh=05RB0ks7ucXzpxe95g1LKHt3rlFXlBknE1wTSDoYlQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NgScqaSbye/EPR66CRyyT1/kLF3NLb/fPFNrfWYzZK6sbReyK4C5/B8NbR9Deg17k
         yaOICcSQETHAizHUKEt+TpVI6zYPRK6QlUIMRd/s+K9Cv8qVglXKyT0wevwc+7cXcJ
         Nql3Bz2JX0KcCCVaXzCBZdzdn2ohxlW+bSYE3MDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.5 183/241] ACPI: bus: Move acpi_arm_init() to the place of after acpi_ghes_init()
Date:   Mon, 23 Oct 2023 12:56:09 +0200
Message-ID: <20231023104838.343797271@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hanjun Guo <guohanjun@huawei.com>

commit d5921c460e543228d100daf67dac7a03dfaaa40a upstream.

acpi_agdi_init() in acpi_arm_init() will register a SDEI event, so
it needs the SDEI subsystem to be initialized (which is done in
acpi_ghes_init()) before the AGDI driver probing.

In commit fcea0ccf4fd7 ("ACPI: bus: Consolidate all arm specific
initialisation into acpi_arm_init()"), the acpi_agdi_init() was
called before acpi_ghes_init() and it causes following failure:

| [    0.515864] sdei: Failed to create event 1073741825: -5
| [    0.515866] agdi agdi.0: Failed to register for SDEI event 1073741825
| [    0.515867] agdi: probe of agdi.0 failed with error -5
| ...
| [    0.516022] sdei: SDEIv1.0 (0x0) detected in firmware.

Fix it by moving acpi_arm_init() to the place of after
acpi_ghes_init().

Fixes: fcea0ccf4fd7 ("ACPI: bus: Consolidate all arm specific initialisation into acpi_arm_init()")
Reported-by: D Scott Phillips <scott@os.amperecomputing.com>
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: D Scott Phillips <scott@os.amperecomputing.com>
Cc: 6.5+ <stable@vger.kernel.org> # 6.5+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1387,10 +1387,10 @@ static int __init acpi_init(void)
 	acpi_init_ffh();
 
 	pci_mmcfg_late_init();
-	acpi_arm_init();
 	acpi_viot_early_init();
 	acpi_hest_init();
 	acpi_ghes_init();
+	acpi_arm_init();
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();


