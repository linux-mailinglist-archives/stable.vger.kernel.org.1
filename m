Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B8B713FD3
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjE1Tte (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjE1Tt3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:49:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ECE9B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:49:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 110936201D
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308BCC433D2;
        Sun, 28 May 2023 19:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303367;
        bh=0qtbxcdGWP0QtyzSBLTJhlMnLc+/ENc2JkSDgjIQd6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/aMCOXYZaEtePe7ziqAGq8FYdahwrSoH5B7i+56+YZtdv6rQ6DRCFkwkENVNeYfH
         SdyIWQ3d+BnbwuxJLcJjcDrCT/oezXdhr+VnNo86TzZoP+6l/3juhOLUsH+QN7LfZM
         fNfuS1RV88oOAxcbNINjoSKsj/39tMGhVT/EbgEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 5.15 48/69] power: supply: sbs-charger: Fix INHIBITED bit for Status reg
Date:   Sun, 28 May 2023 20:12:08 +0100
Message-Id: <20230528190830.174941471@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daisuke Nojiri <dnojiri@chromium.org>

commit b2f2a3c9800208b0db2c2e34b05323757117faa2 upstream.

CHARGE_INHIBITED bit position of the ChargerStatus register is actually
0 not 1. This patch corrects it.

Fixes: feb583e37f8a8 ("power: supply: add sbs-charger driver")
Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/sbs-charger.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -24,7 +24,7 @@
 #define SBS_CHARGER_REG_STATUS			0x13
 #define SBS_CHARGER_REG_ALARM_WARNING		0x16
 
-#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(1)
+#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(0)
 #define SBS_CHARGER_STATUS_RES_COLD		BIT(9)
 #define SBS_CHARGER_STATUS_RES_HOT		BIT(10)
 #define SBS_CHARGER_STATUS_BATTERY_PRESENT	BIT(14)


