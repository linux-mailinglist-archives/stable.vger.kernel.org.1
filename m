Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B44679BB38
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355599AbjIKWBX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbjIKOaI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:30:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61986F0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:30:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6636EC433C8;
        Mon, 11 Sep 2023 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442602;
        bh=6mBGLz6skFIWwJTM4BUVUQShaH3tMrsgsut2+Rb+WdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qlvQThWE/7scBF89VFUcflOuFeqB8296EKlkF1ONbIOZ3xNCRUuFpl7bAPP1PaFkI
         Qa/ZkK8hv2dDSsKZiEKYz76HvzyhjeEFObJrQRoN+vsRTdBuaI80ylXhDtnuqwNUTf
         MlwNIdwMDuxWCxTKibiWt+M30IZe8FjVulCMqaqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 082/737] ASoC: cs35l56: Add an ACPI match table
Date:   Mon, 11 Sep 2023 15:39:01 +0200
Message-ID: <20230911134652.800450741@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Trimmer <simont@opensource.cirrus.com>

[ Upstream commit e8500a70270334b9abad72fea504ef38a2952274 ]

An ACPI ID has been allocated for CS35L56 ASoC devices so that they can
be instantiated from ACPI Device entries.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20230817112712.16637-3-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l56-i2c.c | 9 +++++++++
 sound/soc/codecs/cs35l56-spi.c | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/sound/soc/codecs/cs35l56-i2c.c b/sound/soc/codecs/cs35l56-i2c.c
index 295caad262243..c613a2554fa31 100644
--- a/sound/soc/codecs/cs35l56-i2c.c
+++ b/sound/soc/codecs/cs35l56-i2c.c
@@ -62,10 +62,19 @@ static const struct i2c_device_id cs35l56_id_i2c[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cs35l56_id_i2c);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cs35l56_asoc_acpi_match[] = {
+	{ "CSC355C", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, cs35l56_asoc_acpi_match);
+#endif
+
 static struct i2c_driver cs35l56_i2c_driver = {
 	.driver = {
 		.name		= "cs35l56",
 		.pm = &cs35l56_pm_ops_i2c_spi,
+		.acpi_match_table = ACPI_PTR(cs35l56_asoc_acpi_match),
 	},
 	.id_table	= cs35l56_id_i2c,
 	.probe_new	= cs35l56_i2c_probe,
diff --git a/sound/soc/codecs/cs35l56-spi.c b/sound/soc/codecs/cs35l56-spi.c
index 996aab10500ee..302f9c47407a4 100644
--- a/sound/soc/codecs/cs35l56-spi.c
+++ b/sound/soc/codecs/cs35l56-spi.c
@@ -59,10 +59,19 @@ static const struct spi_device_id cs35l56_id_spi[] = {
 };
 MODULE_DEVICE_TABLE(spi, cs35l56_id_spi);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cs35l56_asoc_acpi_match[] = {
+	{ "CSC355C", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, cs35l56_asoc_acpi_match);
+#endif
+
 static struct spi_driver cs35l56_spi_driver = {
 	.driver = {
 		.name		= "cs35l56",
 		.pm = &cs35l56_pm_ops_i2c_spi,
+		.acpi_match_table = ACPI_PTR(cs35l56_asoc_acpi_match),
 	},
 	.id_table	= cs35l56_id_spi,
 	.probe		= cs35l56_spi_probe,
-- 
2.40.1



