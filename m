Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F099E6FA8F5
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbjEHKql (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbjEHKqU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:46:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8526A2A9D8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F4179628C0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FD7C433EF;
        Mon,  8 May 2023 10:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542766;
        bh=HcVHmsYf0WHbDYdxMfdo34ht14fDlnotCj2cU3dTJdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IwUGSb5nmIYkqVxTJ5v/Cvr7lopCrkyfxmIobSjcfHkCyysPKLtns8esazZ5y6xUA
         I77Hi26qod1bsLL9PMX0giRG9nAUQn5YrZYFyN+46QIgDSRqTiCkOB7D2sOoH33zgw
         KAvvjGk3qVSFHd3eQroXxnR284p5hUOBinV6C9fk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 541/663] power: supply: generic-adc-battery: fix unit scaling
Date:   Mon,  8 May 2023 11:46:07 +0200
Message-Id: <20230508094446.556951265@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Sebastian Reichel <sre@kernel.org>

[ Upstream commit 44263f50065969f2344808388bd589740f026167 ]

power-supply properties are reported in µV, µA and µW.
The IIO API provides mV, mA, mW, so the values need to
be multiplied by 1000.

Fixes: e60fea794e6e ("power: battery: Generic battery driver using IIO")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 66039c665dd1e..0af536f4932f1 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -135,6 +135,9 @@ static int read_channel(struct gab *adc_bat, enum power_supply_property psp,
 			result);
 	if (ret < 0)
 		pr_err("read channel error\n");
+	else
+		*result *= 1000;
+
 	return ret;
 }
 
-- 
2.39.2



