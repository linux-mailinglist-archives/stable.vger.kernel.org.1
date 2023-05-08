Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35A66FA3AC
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjEHJua (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjEHJu3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DB21FABA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:50:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16A6B621BC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B9EC4339B;
        Mon,  8 May 2023 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539426;
        bh=8EyKzg7INrINCuQ2spPvyNvb0YxJAi1Ix1xbtE3Gj8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=blymnnCmejaYTB4gJhtILGVWa9+ltRfiUmUCcKAr68y9eNvELGniJMkMbRqOXhd5C
         4cEY58DshzHffAXTSA12LqIl+jgm/aaTX4NmkKrx6IiA1P4LVD30hP6C4B47pNO6kN
         r4wnkrnGiX35DqASLNM1m1/EVwMlH3hZBRCy6dHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Asbach <asbachb.kernel@impl.it>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 013/611] platform/x86: thinkpad_acpi: Add missing T14s Gen1 type to s2idle quirk list
Date:   Mon,  8 May 2023 11:37:35 +0200
Message-Id: <20230508094422.103528089@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Benjamin Asbach <asbachb.kernel@impl.it>

[ Upstream commit 9a469c6dfab38326f99f105386db84230be09ee3 ]

>From the commit message adding the first s2idle quirks:

> Lenovo laptops that contain NVME SSDs across a variety of generations have
> trouble resuming from suspend to idle when the IOMMU translation layer is
> active for the NVME storage device.
>
> This generally manifests as a large resume delay or page faults. These
> delays and page faults occur as a result of a Lenovo BIOS specific SMI
> that runs during the D3->D0 transition on NVME devices.

Add the DMI ids for another variant of the T14s Gen1, which also needs
the s2idle quirk.

Link: https://lore.kernel.org/all/20220503183420.348-1-mario.limonciello@amd.com/
Link: https://bbs.archlinux.org/viewtopic.php?pid=2084655#p2084655
Signed-off-by: Benjamin Asbach <asbachb.kernel@impl.it>
Tested-by: Benjamin Asbach <asbachb.kernel@impl.it>
Link: https://lore.kernel.org/r/20230331232447.37204-1-asbachb.kernel@impl.it
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/thinkpad_acpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 2a48a2d880d86..d1ec31086e9ba 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -4481,6 +4481,14 @@ static const struct dmi_system_id fwbug_list[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "20UH"),
 		}
 	},
+	{
+		.ident = "T14s Gen1 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20UJ"),
+		}
+	},
 	{
 		.ident = "P14s Gen1 AMD",
 		.driver_data = &quirk_s2idle_bug,
-- 
2.39.2



