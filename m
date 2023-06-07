Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D49726F1F
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjFGUzi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjFGUze (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:55:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7503C1BE4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 086BE64801
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204FEC4339B;
        Wed,  7 Jun 2023 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171332;
        bh=AEgLpSXR2JytEFrd0+1cvpNsE8QXoxiVVhkuzKyF3J4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wCR1qfb5HXR1ZEsVuqWW90meLSk6CQghHgIO68rdmyKmbni48SRr4UpcWy1bMJWrN
         /DuPYt9kVxFg5EwPV4S25QEPIe5Tmbm8OMVLwfmPq+dlNPiVAzfOLPv78MAboqIuMA
         mmTgWZ3+SmGDfIGTF3IwYAgXGR33GDcE+MLu7yhM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 48/99] media: mn88443x: fix !CONFIG_OF error by drop of_match_ptr from ID table
Date:   Wed,  7 Jun 2023 22:16:40 +0200
Message-ID: <20230607200901.753943745@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit ae11c0efaec32fb45130ee9886689f467232eebc ]

The driver will match mostly by DT table (even thought there is regular
ID table) so there is little benefit in of_match_ptr (this also allows
ACPI matching via PRP0001, even though it might not be relevant here).
This also fixes !CONFIG_OF error:

  drivers/media/dvb-frontends/mn88443x.c:782:34: error: ‘mn88443x_of_match’ defined but not used [-Werror=unused-const-variable=]

Link: https://lore.kernel.org/linux-media/20230312131318.351173-28-krzysztof.kozlowski@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-frontends/mn88443x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/mn88443x.c b/drivers/media/dvb-frontends/mn88443x.c
index fff212c0bf3b5..05894deb8a19a 100644
--- a/drivers/media/dvb-frontends/mn88443x.c
+++ b/drivers/media/dvb-frontends/mn88443x.c
@@ -800,7 +800,7 @@ MODULE_DEVICE_TABLE(i2c, mn88443x_i2c_id);
 static struct i2c_driver mn88443x_driver = {
 	.driver = {
 		.name = "mn88443x",
-		.of_match_table = of_match_ptr(mn88443x_of_match),
+		.of_match_table = mn88443x_of_match,
 	},
 	.probe    = mn88443x_probe,
 	.remove   = mn88443x_remove,
-- 
2.39.2



