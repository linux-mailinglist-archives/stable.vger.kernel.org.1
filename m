Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F049E7D31BE
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjJWLMk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjJWLMh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:12:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECF2DD
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:12:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF9CC433C8;
        Mon, 23 Oct 2023 11:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059555;
        bh=WJ6bRM+hB52EvqDbs7VfNPE/LYIpBFVLrWOA8eqQxBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iloQV43oT99QcxOfubJWlRvM0DlBPje0tcnnOBvzftDqYkf80yfMu6rTuDDX8tx8o
         08EPREqBXoUF1caiAVKzi1BSIa15ah5gdgm8dPiLMh+W+xLi7UkDDAP1Mx1LeYqL1q
         mFYBbcWNDOvWn/JlG+zAPHH1UKRNkF5+pgU9L08g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 217/241] ASoC: cs42l42: Fix missing include of gpio/consumer.h
Date:   Mon, 23 Oct 2023 12:56:43 +0200
Message-ID: <20231023104839.141749554@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit d6cbc6a3a856a7d8047316d81e2e039e44432acb ]

The call to gpiod_set_value_cansleep() in cs42l42_sdw_update_status()
needs the header file gpio/consumer.h to be included.

This was introduced by commit 2d066c6a7865 ("ASoC: cs42l42: Avoid stale
SoundWire ATTACH after hard reset")

and caused error:
    sound/soc/codecs/cs42l42-sdw.c:374:4: error: implicit declaration of
    function ‘gpiod_set_value_cansleep’;
    did you mean gpio_set_value_cansleep’?

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2d066c6a7865 ("ASoC: cs42l42: Avoid stale SoundWire ATTACH after hard reset")
Link: https://lore.kernel.org/r/20231011134853.20059-1-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs42l42-sdw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs42l42-sdw.c b/sound/soc/codecs/cs42l42-sdw.c
index 974bae4abfad1..94a66a325303b 100644
--- a/sound/soc/codecs/cs42l42-sdw.c
+++ b/sound/soc/codecs/cs42l42-sdw.c
@@ -6,6 +6,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-- 
2.42.0



