Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8225476145D
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjGYLSa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbjGYLSa (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:18:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1536C9D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A86A46168E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D02C433C7;
        Tue, 25 Jul 2023 11:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283908;
        bh=r5TGTdH7mxxzpLE9k30A4xAA9hO3ftAiVfRg5qcH6Wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ihK72I+de3OFwWSwrsnZdY89+ca1U3gZlHRDxjbNwC2LownYI+CVDKMzJpCqDUEqX
         a1O/ghEF2b5MxUaA5+idPpKVjNK5yebFVPCTqxNfhbQMhACQHBcXw7qEo1ahBGnzen
         zjJYFHu2eg5jekIhUhL8fHVGnxX8bDvMmhiJSxSw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Robert Hancock <robert.hancock@calian.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 166/509] clk: si5341: Add sysfs properties to allow checking/resetting device faults
Date:   Tue, 25 Jul 2023 12:41:45 +0200
Message-ID: <20230725104601.332129943@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Robert Hancock <robert.hancock@calian.com>

[ Upstream commit 9b13ff4340dff30f361462999a6a122fcc4e473f ]

Add sysfs property files to allow viewing the current and latched states of
the input present and PLL lock bits, and allow resetting the latched fault
state. This allows manual checks or automated userspace polling for faults
occurring after initialization.

Signed-off-by: Robert Hancock <robert.hancock@calian.com>
Link: https://lore.kernel.org/r/20210325192643.2190069-10-robert.hancock@calian.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: 2560114c06d7 ("clk: si5341: return error if one synth clock registration fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-si5341.c | 96 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 64d962c54bba5..5175b3024f060 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -1450,6 +1450,94 @@ static int si5341_clk_select_active_input(struct clk_si5341 *data)
 	return res;
 }
 
+static ssize_t input_present_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct clk_si5341 *data = dev_get_drvdata(dev);
+	u32 status;
+	int res = regmap_read(data->regmap, SI5341_STATUS, &status);
+
+	if (res < 0)
+		return res;
+	res = !(status & SI5341_STATUS_LOSREF);
+	return snprintf(buf, PAGE_SIZE, "%d\n", res);
+}
+static DEVICE_ATTR_RO(input_present);
+
+static ssize_t input_present_sticky_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct clk_si5341 *data = dev_get_drvdata(dev);
+	u32 status;
+	int res = regmap_read(data->regmap, SI5341_STATUS_STICKY, &status);
+
+	if (res < 0)
+		return res;
+	res = !(status & SI5341_STATUS_LOSREF);
+	return snprintf(buf, PAGE_SIZE, "%d\n", res);
+}
+static DEVICE_ATTR_RO(input_present_sticky);
+
+static ssize_t pll_locked_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct clk_si5341 *data = dev_get_drvdata(dev);
+	u32 status;
+	int res = regmap_read(data->regmap, SI5341_STATUS, &status);
+
+	if (res < 0)
+		return res;
+	res = !(status & SI5341_STATUS_LOL);
+	return snprintf(buf, PAGE_SIZE, "%d\n", res);
+}
+static DEVICE_ATTR_RO(pll_locked);
+
+static ssize_t pll_locked_sticky_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct clk_si5341 *data = dev_get_drvdata(dev);
+	u32 status;
+	int res = regmap_read(data->regmap, SI5341_STATUS_STICKY, &status);
+
+	if (res < 0)
+		return res;
+	res = !(status & SI5341_STATUS_LOL);
+	return snprintf(buf, PAGE_SIZE, "%d\n", res);
+}
+static DEVICE_ATTR_RO(pll_locked_sticky);
+
+static ssize_t clear_sticky_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct clk_si5341 *data = dev_get_drvdata(dev);
+	long val;
+
+	if (kstrtol(buf, 10, &val))
+		return -EINVAL;
+	if (val) {
+		int res = regmap_write(data->regmap, SI5341_STATUS_STICKY, 0);
+
+		if (res < 0)
+			return res;
+	}
+	return count;
+}
+static DEVICE_ATTR_WO(clear_sticky);
+
+static const struct attribute *si5341_attributes[] = {
+	&dev_attr_input_present.attr,
+	&dev_attr_input_present_sticky.attr,
+	&dev_attr_pll_locked.attr,
+	&dev_attr_pll_locked_sticky.attr,
+	&dev_attr_clear_sticky.attr,
+	NULL
+};
+
 static int si5341_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
@@ -1676,6 +1764,12 @@ static int si5341_probe(struct i2c_client *client,
 		goto cleanup;
 	}
 
+	err = sysfs_create_files(&client->dev.kobj, si5341_attributes);
+	if (err) {
+		dev_err(&client->dev, "unable to create sysfs files\n");
+		goto cleanup;
+	}
+
 	/* Free the names, clk framework makes copies */
 	for (i = 0; i < data->num_synth; ++i)
 		 devm_kfree(&client->dev, (void *)synth_clock_names[i]);
@@ -1695,6 +1789,8 @@ static int si5341_remove(struct i2c_client *client)
 	struct clk_si5341 *data = i2c_get_clientdata(client);
 	int i;
 
+	sysfs_remove_files(&client->dev.kobj, si5341_attributes);
+
 	for (i = 0; i < SI5341_MAX_NUM_OUTPUTS; ++i) {
 		if (data->clk[i].vddo_reg)
 			regulator_disable(data->clk[i].vddo_reg);
-- 
2.39.2



