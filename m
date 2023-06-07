Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CEF726D5D
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjFGUl2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbjFGUl1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:41:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FE02683
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B09E664619
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A7DC433D2;
        Wed,  7 Jun 2023 20:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170477;
        bh=YBOV6kOD7vee+sNC5jOSf0IUd61uv5hmDufyNE8r9Z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eSnHsSU7QTuAOrBCGmwA2Iuh0QM2PFZn8c2kdWfkSqFQkqRArnfm8QT+qeCQBpVnK
         viGyEUa5I/r00bK9+QqZNmnXHj1VUloTTNn0yjnoTbOIY8POtSYA8xcWrWbEZKUhsQ
         A+K1IW05DoQf09t9s7uv158fauSNrqAMvAV6yH1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 100/225] media: mn88443x: fix !CONFIG_OF error by drop of_match_ptr from ID table
Date:   Wed,  7 Jun 2023 22:14:53 +0200
Message-ID: <20230607200917.648273602@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
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
index 452571b380b72..5a024870979de 100644
--- a/drivers/media/dvb-frontends/mn88443x.c
+++ b/drivers/media/dvb-frontends/mn88443x.c
@@ -798,7 +798,7 @@ MODULE_DEVICE_TABLE(i2c, mn88443x_i2c_id);
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



