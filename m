Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776D97039DD
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244605AbjEORq3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244599AbjEORqL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:46:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3961B120BA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:44:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA25D62E95
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77A4C433EF;
        Mon, 15 May 2023 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172657;
        bh=X2ZQBkmNO4tFyqHEhbe8mX3cVuiFc3Tmpkey0gyQouA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hdvU3OdJuDUbU25xxPBq/jElbj+phLwooS7QjGmCQqT1ZpIOhsQjuhpi2ICUusQW6
         pizR7VlKQ+7LG9clzuqLJreT4iWD7MRq+YHeyCG011ZJoo/h83BheVq5RvGVd6Rnew
         n4I0xcishChitLhSvGcNoTozpvAGq/tdYV95LYbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 197/381] iio: light: max44009: add missing OF device matching
Date:   Mon, 15 May 2023 18:27:28 +0200
Message-Id: <20230515161745.730748753@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit b29c49026c3c05a11f845dba17cad0b3ba06836d ]

The driver currently matches only via i2c_device_id, but also has
of_device_id table:

  drivers/iio/light/max44009.c:545:34: error: ‘max44009_of_match’ defined but not used [-Werror=unused-const-variable=]

Fixes: 6aef699a7d7e ("iio: light: add driver for MAX44009")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230312153429.371702-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/max44009.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
index 801e5a0ad496b..f3648f20ef2c0 100644
--- a/drivers/iio/light/max44009.c
+++ b/drivers/iio/light/max44009.c
@@ -528,6 +528,12 @@ static int max44009_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+static const struct of_device_id max44009_of_match[] = {
+	{ .compatible = "maxim,max44009" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max44009_of_match);
+
 static const struct i2c_device_id max44009_id[] = {
 	{ "max44009", 0 },
 	{ }
@@ -537,18 +543,13 @@ MODULE_DEVICE_TABLE(i2c, max44009_id);
 static struct i2c_driver max44009_driver = {
 	.driver = {
 		.name = MAX44009_DRV_NAME,
+		.of_match_table = max44009_of_match,
 	},
 	.probe = max44009_probe,
 	.id_table = max44009_id,
 };
 module_i2c_driver(max44009_driver);
 
-static const struct of_device_id max44009_of_match[] = {
-	{ .compatible = "maxim,max44009" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, max44009_of_match);
-
 MODULE_AUTHOR("Robert Eshleman <bobbyeshleman@gmail.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MAX44009 ambient light sensor driver");
-- 
2.39.2



