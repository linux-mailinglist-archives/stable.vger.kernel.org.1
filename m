Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD579C0BC
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjIKVGK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240889AbjIKO4g (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:56:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4A9DC
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:56:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98317C433C8;
        Mon, 11 Sep 2023 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444192;
        bh=jrdoy20h52hpT2CUWwUfOIkZthP0MB+dhCUPezQa8NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zLhtc4Om+QWABKGBxk8En7eUtvuHS7sxFwUKn5gPBTBuEPzDIQ8T05W4Dk82Y8O7b
         8vRlpZGmqavgtZP7Fq5IoWMEI1etqv8yBjy1e74pbcPs2+2/gfvPIOOZh+X4zv6RSi
         JoG2YYsNwUbQfpJ4Xp/nFp4k9Q1c5ciurhUrfgc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "=?UTF-8?q?N=C3=ADcolas=20F . =20R . =20A . =20Prado?=" 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 614/737] thermal/drivers/mediatek/lvts_thermal: Disable undesired interrupts
Date:   Mon, 11 Sep 2023 15:47:53 +0200
Message-ID: <20230911134707.682189036@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit 487bf099e85b724c824f5fafaf93c6749c4d2120 ]

Out of the many interrupts supported by the hardware, the only ones of
interest to the driver currently are:
* The temperature went over the high offset threshold, for any of the
  sensors
* The temperature went below the low offset threshold, for any of the
  sensors
* The temperature went over the stage3 threshold

These are the only thresholds configured by the driver through the
OFFSETH, OFFSETL, and PROTTC registers, respectively.

The current interrupt mask in LVTS_MONINT_CONF, enables many more
interrupts, including data ready on sensors for both filtered and
immediate mode. These are not only not handled by the driver, but they
are also triggered too often, causing unneeded overhead. Disable these
unnecessary interrupts.

The meaning of each bit can be seen in the comment describing
LVTS_MONINTST in the IRQ handler.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230706153823.201943-5-nfraprado@collabora.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 80abd10596d85..0fa90ac6ed41f 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -63,7 +63,7 @@
 #define LVTS_HW_FILTER				0x2
 #define LVTS_TSSEL_CONF				0x13121110
 #define LVTS_CALSCALE_CONF			0x300
-#define LVTS_MONINT_CONF			0x9FBF7BDE
+#define LVTS_MONINT_CONF			0x8300318C
 
 #define LVTS_INT_SENSOR0			0x0009001F
 #define LVTS_INT_SENSOR1			0x001203E0
-- 
2.40.1



