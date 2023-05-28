Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A761713E3F
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjE1Tdl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjE1Tdj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ADEA3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18D3261DD2
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3466EC433D2;
        Sun, 28 May 2023 19:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302417;
        bh=0cFuVe62TUdFTUcmqFWj2tVetyVOeWgFydTmT08ljmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a8NFh91h26qZqIXGVFq/bxzW0JfjvuDo/kEJN3D3wLf+JBAyPfFAQd1i5Ln+m89h3
         KRT+iHRNcoGJ3F95G8Xoci3psQNQsAqOT7Dh+3ts2TzVHbHkqtIi8GwWZ5msvX/DUa
         GjZMAx99oyX2Us7Vfbl9N4cEpqBT+p/3chvQX2cA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev
Subject: [PATCH 6.3 121/127] regulator: mt6359: add read check for PMIC MT6359
Date:   Sun, 28 May 2023 20:11:37 +0100
Message-Id: <20230528190840.183167516@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sen Chu <sen.chu@mediatek.com>

commit a511637502b1caa135046d0f8fdabd55a31af8ef upstream.

Add hardware version read check for PMIC MT6359

Signed-off-by: Sen Chu <sen.chu@mediatek.com
Fixes: 4cfc96547512 ("regulator: mt6359: Add support for MT6359P regulator")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com
Link: https://lore.kernel.org/r/20230518040646.8730-1-sen.chu@mediatek.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/mt6359-regulator.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/regulator/mt6359-regulator.c
+++ b/drivers/regulator/mt6359-regulator.c
@@ -951,9 +951,12 @@ static int mt6359_regulator_probe(struct
 	struct regulator_config config = {};
 	struct regulator_dev *rdev;
 	struct mt6359_regulator_info *mt6359_info;
-	int i, hw_ver;
+	int i, hw_ver, ret;
+
+	ret = regmap_read(mt6397->regmap, MT6359P_HWCID, &hw_ver);
+	if (ret)
+		return ret;
 
-	regmap_read(mt6397->regmap, MT6359P_HWCID, &hw_ver);
 	if (hw_ver >= MT6359P_CHIP_VER)
 		mt6359_info = mt6359p_regulators;
 	else


