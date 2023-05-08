Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C016FAAFA
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjEHLIR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjEHLH4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:07:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FA946A3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A05962ADB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0EBC433D2;
        Mon,  8 May 2023 11:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544061;
        bh=XyXJ0CZ+MoviMyJ0ipmDHvopLCPbmTzZKoad3ENSqLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TwDqLA5oudP+LFK5bcwsg9truxKyeMYzPr5zv4xaJv84YZldPJhvaSVPnv7vTQE09
         EcC17kiKuXFwLKG9eMAZgbHkaeh28fdBKt6IJYGDHueRmGL9a6mzMIe7W1nJIjzrGG
         3m1/taM5QLfi0tBAJa/qeDjxeM63CVs8KMR3q0cs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 290/694] platform/x86/amd: pmc: Dont dump data after resume from s0i3 on picasso
Date:   Mon,  8 May 2023 11:42:05 +0200
Message-Id: <20230508094441.696184112@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 7abc3618b65304d409d9489d77e4a8f047842fb7 ]

This command isn't supported on Picasso, so guard against running it
to avoid errors like `SMU cmd unknown. err: 0xfe` in the logs.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2449
Fixes: 766205674962 ("platform/x86: amd-pmc: Add support for logging SMU metrics")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230409185348.556161-4-Shyam-sundar.S-k@amd.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 6aa10192a3f3b..d6527dea62b8a 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -834,6 +834,14 @@ static void amd_pmc_s2idle_check(void)
 		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
 }
 
+static int amd_pmc_dump_data(struct amd_pmc_dev *pdev)
+{
+	if (pdev->cpu_id == AMD_CPU_ID_PCO)
+		return -ENODEV;
+
+	return amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_DUMP_DATA, 0);
+}
+
 static void amd_pmc_s2idle_restore(void)
 {
 	struct amd_pmc_dev *pdev = &pmc;
@@ -846,7 +854,7 @@ static void amd_pmc_s2idle_restore(void)
 		dev_err(pdev->dev, "resume failed: %d\n", rc);
 
 	/* Let SMU know that we are looking for stats */
-	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_DUMP_DATA, 0);
+	amd_pmc_dump_data(pdev);
 
 	rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_S2IDLE_RESTORE);
 	if (rc)
-- 
2.39.2



