Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E306FA7B1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbjEHKdq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbjEHKdV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:33:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916D124A91
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F27B626E0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33FEC433EF;
        Mon,  8 May 2023 10:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541958;
        bh=NvZOH3SM8whi9sYi9WH1vtF6BVr6lVQ+rE+TZiKhW4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9yhehiRoSrJ1hRvyat6MBBJvnzg5Pll7Z+yO1NhX7GbtEKnxklnvXfml8COtTOnJ
         pKChBy/NowqHIy2A5fSFlgKiXS7hKXcLiyIrYsICmDJnpvVek/f43RHZrlbQ0833w9
         uZANaYJu9hF7LijDt8TIBWLf0cZrm3TGRI3ZbV50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 249/663] platform/x86/amd: pmc: Dont dump data after resume from s0i3 on picasso
Date:   Mon,  8 May 2023 11:41:15 +0200
Message-Id: <20230508094436.340826447@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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
index bc8397635428e..976bd01644a5e 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -809,6 +809,14 @@ static void amd_pmc_s2idle_check(void)
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
@@ -821,7 +829,7 @@ static void amd_pmc_s2idle_restore(void)
 		dev_err(pdev->dev, "resume failed: %d\n", rc);
 
 	/* Let SMU know that we are looking for stats */
-	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_DUMP_DATA, 0);
+	amd_pmc_dump_data(pdev);
 
 	rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_S2IDLE_RESTORE);
 	if (rc)
-- 
2.39.2



