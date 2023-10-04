Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA8A7B8A41
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244352AbjJDSdi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244366AbjJDSdh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:33:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F17A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:33:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682A7C433CA;
        Wed,  4 Oct 2023 18:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444413;
        bh=KnghT6rmA1Bue9GdZ3gjRPSAGenzRyymNt5wWUBISc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qs3oEriQ6iky+OC5d4gfhqgZOdRdZ31Nxo2v/E3c7V25EbP49yCKraZKZMWNoBX9e
         PXHaWolYDekhCMc5+RadjZqKXhSxtLfzrCu36of0c5k9HSEk6iS7nuJzYrm6IrN5Qv
         3Y42Hdlp9J2O+nmMVGP3tgADUGd7xJCAi7MR8vbk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 213/321] ASoC: cs42l42: Dont rely on GPIOD_OUT_LOW to set RESET initially low
Date:   Wed,  4 Oct 2023 19:55:58 +0200
Message-ID: <20231004175239.116746732@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit a479b44ac0a0ac25cd48e5356200078924d78022 ]

The ACPI setting for a GPIO default state has higher priority than the
flag passed to devm_gpiod_get_optional() so ACPI can override the
GPIOD_OUT_LOW. Explicitly set the GPIO low when hard resetting.

Although GPIOD_OUT_LOW can't be relied on this doesn't seem like a
reason to stop passing it to devm_gpiod_get_optional(). So we still pass
it to state our intent, but can deal with it having no effect.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20230913150012.604775-3-sbinding@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs42l42.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 56d2857a4f01c..dc93861ddfb02 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2321,6 +2321,12 @@ int cs42l42_common_probe(struct cs42l42_private *cs42l42,
 	if (cs42l42->reset_gpio) {
 		dev_dbg(cs42l42->dev, "Found reset GPIO\n");
 
+		/*
+		 * ACPI can override the default GPIO state we requested
+		 * so ensure that we start with RESET low.
+		 */
+		gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
+
 		/* Ensure minimum reset pulse width */
 		usleep_range(10, 500);
 
-- 
2.40.1



