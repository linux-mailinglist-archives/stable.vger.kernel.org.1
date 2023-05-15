Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1369B7036F4
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243834AbjEORP0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243836AbjEORPH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:15:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FBBE73D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:13:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C61F762B9D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADB4C433EF;
        Mon, 15 May 2023 17:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170818;
        bh=ikKV2xl2ahfI89HUFw/8UK9sHrDATs065fJzH3n/uc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wfSfRPSeB9RpjcjQk4vJOxczoCxseQ7GAhVdJ+15UoPD+wG+Tg6B55qJqmpnSoIT0
         /0K6CHifwlc/kdh81ckgX1ATnjeLOSYO1vJNpMj+V6II7iSOisz6n3CEPbC2KaSGPA
         9Oqxr+O7mQiiTiRc3r2VcHWP/gleHt7IstIZxFPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 004/242] ASoC: codecs: constify static sdw_slave_ops struct
Date:   Mon, 15 May 2023 18:25:30 +0200
Message-Id: <20230515161721.938839080@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

[ Upstream commit 65b7b869da9bd3bd0b9fa60e6fe557bfbc0a75e8 ]

The struct sdw_slave_ops is not modified and sdw_driver takes pointer to
const, so make it a const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230124163953.345949-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 84822215acd1 ("ASoC: codecs: wcd938x: fix accessing regmap on unattached devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt1316-sdw.c     | 2 +-
 sound/soc/codecs/rt1318-sdw.c     | 2 +-
 sound/soc/codecs/rt711-sdca-sdw.c | 2 +-
 sound/soc/codecs/rt715-sdca-sdw.c | 2 +-
 sound/soc/codecs/wcd938x-sdw.c    | 2 +-
 sound/soc/codecs/wsa881x.c        | 2 +-
 sound/soc/codecs/wsa883x.c        | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt1316-sdw.c b/sound/soc/codecs/rt1316-sdw.c
index e6294cc7a9954..45a3eff31915b 100644
--- a/sound/soc/codecs/rt1316-sdw.c
+++ b/sound/soc/codecs/rt1316-sdw.c
@@ -584,7 +584,7 @@ static int rt1316_sdw_pcm_hw_free(struct snd_pcm_substream *substream,
  * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
  * port_prep are not defined for now
  */
-static struct sdw_slave_ops rt1316_slave_ops = {
+static const struct sdw_slave_ops rt1316_slave_ops = {
 	.read_prop = rt1316_read_prop,
 	.update_status = rt1316_update_status,
 };
diff --git a/sound/soc/codecs/rt1318-sdw.c b/sound/soc/codecs/rt1318-sdw.c
index f85f5ab2c6d04..c6ec86e97a6e7 100644
--- a/sound/soc/codecs/rt1318-sdw.c
+++ b/sound/soc/codecs/rt1318-sdw.c
@@ -697,7 +697,7 @@ static int rt1318_sdw_pcm_hw_free(struct snd_pcm_substream *substream,
  * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
  * port_prep are not defined for now
  */
-static struct sdw_slave_ops rt1318_slave_ops = {
+static const struct sdw_slave_ops rt1318_slave_ops = {
 	.read_prop = rt1318_read_prop,
 	.update_status = rt1318_update_status,
 };
diff --git a/sound/soc/codecs/rt711-sdca-sdw.c b/sound/soc/codecs/rt711-sdca-sdw.c
index 88a8392a58edb..e23cec4c457de 100644
--- a/sound/soc/codecs/rt711-sdca-sdw.c
+++ b/sound/soc/codecs/rt711-sdca-sdw.c
@@ -338,7 +338,7 @@ static int rt711_sdca_interrupt_callback(struct sdw_slave *slave,
 	return ret;
 }
 
-static struct sdw_slave_ops rt711_sdca_slave_ops = {
+static const struct sdw_slave_ops rt711_sdca_slave_ops = {
 	.read_prop = rt711_sdca_read_prop,
 	.interrupt_callback = rt711_sdca_interrupt_callback,
 	.update_status = rt711_sdca_update_status,
diff --git a/sound/soc/codecs/rt715-sdca-sdw.c b/sound/soc/codecs/rt715-sdca-sdw.c
index c54ecf3e69879..38a82e4e2f952 100644
--- a/sound/soc/codecs/rt715-sdca-sdw.c
+++ b/sound/soc/codecs/rt715-sdca-sdw.c
@@ -172,7 +172,7 @@ static int rt715_sdca_read_prop(struct sdw_slave *slave)
 	return 0;
 }
 
-static struct sdw_slave_ops rt715_sdca_slave_ops = {
+static const struct sdw_slave_ops rt715_sdca_slave_ops = {
 	.read_prop = rt715_sdca_read_prop,
 	.update_status = rt715_sdca_update_status,
 };
diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 1bf3c06a2b622..33d1b5ffeaeba 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -191,7 +191,7 @@ static int wcd9380_interrupt_callback(struct sdw_slave *slave,
 	return IRQ_HANDLED;
 }
 
-static struct sdw_slave_ops wcd9380_slave_ops = {
+static const struct sdw_slave_ops wcd9380_slave_ops = {
 	.update_status = wcd9380_update_status,
 	.interrupt_callback = wcd9380_interrupt_callback,
 	.bus_config = wcd9380_bus_config,
diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 6c8b1db649b89..046843b57b038 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1101,7 +1101,7 @@ static int wsa881x_bus_config(struct sdw_slave *slave,
 	return 0;
 }
 
-static struct sdw_slave_ops wsa881x_slave_ops = {
+static const struct sdw_slave_ops wsa881x_slave_ops = {
 	.update_status = wsa881x_update_status,
 	.bus_config = wsa881x_bus_config,
 	.port_prep = wsa881x_port_prep,
diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 58fdb4e9fd978..693e988f30c0f 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1073,7 +1073,7 @@ static int wsa883x_port_prep(struct sdw_slave *slave,
 	return 0;
 }
 
-static struct sdw_slave_ops wsa883x_slave_ops = {
+static const struct sdw_slave_ops wsa883x_slave_ops = {
 	.update_status = wsa883x_update_status,
 	.port_prep = wsa883x_port_prep,
 };
-- 
2.39.2



