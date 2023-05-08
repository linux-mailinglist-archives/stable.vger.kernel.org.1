Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084FA6FA4A8
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjEHKB6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjEHKBw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:01:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F0F2EB1B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AD88622C6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124CDC433D2;
        Mon,  8 May 2023 10:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540098;
        bh=wfX0+h+jeC4VLTDOYNx9zH+y+RHDeA/6f15VGTUiyR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGs8AlssrwmVg7v2eLfXrm39gP7/9deR3Cc5uEw2au4Vd6QPxPcqIkm/tt/w4pkLe
         rbpYK7nY1ISruKgl3mshOfBnWksESyswbMqM/G+P4jRGQOpFNy1D71zdp8zplkf9B9
         ewNZVaENqUbYbyikEqn4+GcV64c4CrZV1C82jsRg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 237/611] platform/x86/amd: pmc: Hide SMU version and program attributes for Picasso
Date:   Mon,  8 May 2023 11:41:19 +0200
Message-Id: <20230508094430.105357131@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

[ Upstream commit 5ec9ee0d464750d72972d5685edf675824e259a1 ]

As the command to get version isn't supported on Picasso, we shouldn't
be exposing this into sysfs either.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2449
Fixes: 7f1ea75d499a ("platform/x86/amd: pmc: Add sysfs files for SMU")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230409185348.556161-3-Shyam-sundar.S-k@amd.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 5ff284b6c3eb4..7c9cadf1e59bd 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -422,12 +422,31 @@ static ssize_t smu_program_show(struct device *d, struct device_attribute *attr,
 static DEVICE_ATTR_RO(smu_fw_version);
 static DEVICE_ATTR_RO(smu_program);
 
+static umode_t pmc_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
+
+	if (pdev->cpu_id == AMD_CPU_ID_PCO)
+		return 0;
+	return 0444;
+}
+
 static struct attribute *pmc_attrs[] = {
 	&dev_attr_smu_fw_version.attr,
 	&dev_attr_smu_program.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(pmc);
+
+static struct attribute_group pmc_attr_group = {
+	.attrs = pmc_attrs,
+	.is_visible = pmc_attr_is_visible,
+};
+
+static const struct attribute_group *pmc_groups[] = {
+	&pmc_attr_group,
+	NULL,
+};
 
 static int smu_fw_info_show(struct seq_file *s, void *unused)
 {
-- 
2.39.2



