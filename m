Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C967B88B6
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjJDSSi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjJDSSd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:18:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4F7CE
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:18:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C38C433C8;
        Wed,  4 Oct 2023 18:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443509;
        bh=YQ5Llo4HaPgoVNGV8XNfKXYGYBCSVKUxhLDWUsVUgb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RzEXTMM85vRG5ielkSRRb9ORjHDAV9N4bAxmqZHSwFbzuja8779cAhEn8isswqrgq
         lkPAvSskl4nQdex3vteJcwKMCVOfm91ry9hj2dUorV2OwB+SoOfiezgwIkNrOG7w2W
         QBRrLmUm0kp38GMeCAQVORi3RSIEX2F8heJqjAnc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 181/259] ASoC: cs42l42: Ensure a reset pulse meets minimum pulse width.
Date:   Wed,  4 Oct 2023 19:55:54 +0200
Message-ID: <20231004175225.600855555@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 41dac81b56c82c51a6d00fda5f3af7691ffee2d7 ]

The CS42L42 can accept very short reset pulses of a few microseconds
but there's no reason to force a very short pulse.
Allow a wide range for the usleep_range() so it can be relaxed about
the choice of timing source.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20230913150012.604775-2-sbinding@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs42l42.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 2fefbcf7bd130..914cdd737fa3b 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2280,6 +2280,10 @@ int cs42l42_common_probe(struct cs42l42_private *cs42l42,
 
 	if (cs42l42->reset_gpio) {
 		dev_dbg(cs42l42->dev, "Found reset GPIO\n");
+
+		/* Ensure minimum reset pulse width */
+		usleep_range(10, 500);
+
 		gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
 	}
 	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
-- 
2.40.1



