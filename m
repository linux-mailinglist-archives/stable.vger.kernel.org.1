Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC35713D0D
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjE1TVX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjE1TVW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:21:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566A8A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:21:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2D9761B0D
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10E4C433EF;
        Sun, 28 May 2023 19:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301680;
        bh=J2LPz9DRRovs+mSnt/Zr/PIg1UYidc4u/Q0GZgj6oAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UKwdimJcWfSiEDl6PJi/kt+DlhRYbYz2YOXjqfCNPrLjzRyhfDDGzjih0ktpuKfUv
         5CmxhPSCY8cknLxT5338YSQIxYBmTq8Kjv7GqWV1f7705hfB/Ay8iBPB6NphBJ0cA5
         5gVPagEQzHmi30W/+Mm2ikbP6LfeKil15ClEaV7I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 4.19 126/132] power: supply: sbs-charger: Fix INHIBITED bit for Status reg
Date:   Sun, 28 May 2023 20:11:05 +0100
Message-Id: <20230528190837.719684181@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
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
@@ -29,7 +29,7 @@
 #define SBS_CHARGER_REG_STATUS			0x13
 #define SBS_CHARGER_REG_ALARM_WARNING		0x16
 
-#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(1)
+#define SBS_CHARGER_STATUS_CHARGE_INHIBITED	BIT(0)
 #define SBS_CHARGER_STATUS_RES_COLD		BIT(9)
 #define SBS_CHARGER_STATUS_RES_HOT		BIT(10)
 #define SBS_CHARGER_STATUS_BATTERY_PRESENT	BIT(14)


