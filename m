Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99187726AD3
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjFGUUb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjFGUUV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C47269F
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:19:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C155E6439E
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D985EC433D2;
        Wed,  7 Jun 2023 20:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169190;
        bh=6pgBzRyY6zxM5N/5wd8n8ptxAtgtPYjCtkr+Lx3NBPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xUQltHeQCya5JR3NHvmcsnvUpCvGPEpnmYf/7bN9hLO+TTooATja39+i+YvGhUYlU
         KcGpYzNAc+Fp3TS0DTegTCeEXZ5gAGuir1/Q6kpvl/tPMPLZEc2MYaf6nKF0A+uaAZ
         fa2oPZXsnIvvbbpFBvlClJsY6QGuZ3z7GtZhJAO0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nathan Chancellor <natechancellor@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 49/61] regulator: da905{2,5}: Remove unnecessary array check
Date:   Wed,  7 Jun 2023 22:16:03 +0200
Message-ID: <20230607200852.083543445@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200835.310274198@linuxfoundation.org>
References: <20230607200835.310274198@linuxfoundation.org>
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

From: Nathan Chancellor <natechancellor@gmail.com>

commit 5a7d7d0f9f791b1e13f26dbbb07c86482912ad62 upstream.

Clang warns that the address of a pointer will always evaluated as true
in a boolean context:

drivers/regulator/da9052-regulator.c:423:22: warning: address of array
'pdata->regulators' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (pdata && pdata->regulators) {
                  ~~ ~~~~~~~^~~~~~~~~~
drivers/regulator/da9055-regulator.c:615:22: warning: address of array
'pdata->regulators' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (pdata && pdata->regulators) {
                  ~~ ~~~~~~~^~~~~~~~~~

Link: https://github.com/ClangBuiltLinux/linux/issues/142
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/da9052-regulator.c |    2 +-
 drivers/regulator/da9055-regulator.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -421,7 +421,7 @@ static int da9052_regulator_probe(struct
 	config.dev = &pdev->dev;
 	config.driver_data = regulator;
 	config.regmap = da9052->regmap;
-	if (pdata && pdata->regulators) {
+	if (pdata) {
 		config.init_data = pdata->regulators[cell->id];
 	} else {
 #ifdef CONFIG_OF
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -612,7 +612,7 @@ static int da9055_regulator_probe(struct
 	config.driver_data = regulator;
 	config.regmap = da9055->regmap;
 
-	if (pdata && pdata->regulators) {
+	if (pdata) {
 		config.init_data = pdata->regulators[pdev->id];
 	} else {
 		ret = da9055_regulator_dt_init(pdev, regulator, &config,


