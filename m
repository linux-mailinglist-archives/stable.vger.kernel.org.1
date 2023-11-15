Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212197ED2D7
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjKOUom (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjKOUol (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:44:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6142CA1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:44:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B0AC433C7;
        Wed, 15 Nov 2023 20:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081078;
        bh=uhRcVbE6/Kbvf0t0/6P9HME4JYAEw4OQJkgYF+q59yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSgMcR6AFu8WL2IucOwjUR8VoHyONbbzvHqZpdudS4IYL/r0PLq4Ko1d9CcNZCUs1
         T5vdweGqg5boezICQiVK7ziNkpSxFdwqfezcp6LSrxbBhKalyRMKvxT6pKQvPzN6mX
         LqePQPoNRsE7G937J5hahcvyvOEYBIfZJm+GcnR8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 08/88] can: dev: move driver related infrastructure into separate subdir
Date:   Wed, 15 Nov 2023 15:35:20 -0500
Message-ID: <20231115191426.694692619@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191426.221330369@linuxfoundation.org>
References: <20231115191426.221330369@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 3e77f70e734584e0ad1038e459ed3fd2400f873a ]

This patch moves the CAN driver related infrastructure into a separate subdir.
It will be split into more files in the coming patches.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/r/20210111141930.693847-3-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Stable-dep-of: fe5c9940dfd8 ("can: dev: can_restart(): don't crash kernel if carrier is OK")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/Makefile               | 7 +------
 drivers/net/can/dev/Makefile           | 7 +++++++
 drivers/net/can/{ => dev}/dev.c        | 0
 drivers/net/can/{ => dev}/rx-offload.c | 0
 4 files changed, 8 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/can/dev/Makefile
 rename drivers/net/can/{ => dev}/dev.c (100%)
 rename drivers/net/can/{ => dev}/rx-offload.c (100%)

diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 44922bf29b6a0..93e11f1fee5c6 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -7,12 +7,7 @@ obj-$(CONFIG_CAN_VCAN)		+= vcan.o
 obj-$(CONFIG_CAN_VXCAN)		+= vxcan.o
 obj-$(CONFIG_CAN_SLCAN)		+= slcan.o
 
-obj-$(CONFIG_CAN_DEV)		+= can-dev.o
-can-dev-y			+= dev.o
-can-dev-y			+= rx-offload.o
-
-can-dev-$(CONFIG_CAN_LEDS)	+= led.o
-
+obj-y				+= dev/
 obj-y				+= rcar/
 obj-y				+= spi/
 obj-y				+= usb/
diff --git a/drivers/net/can/dev/Makefile b/drivers/net/can/dev/Makefile
new file mode 100644
index 0000000000000..cba92e6bcf6f5
--- /dev/null
+++ b/drivers/net/can/dev/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_CAN_DEV)		+= can-dev.o
+can-dev-y			+= dev.o
+can-dev-y			+= rx-offload.o
+
+can-dev-$(CONFIG_CAN_LEDS)	+= led.o
diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev/dev.c
similarity index 100%
rename from drivers/net/can/dev.c
rename to drivers/net/can/dev/dev.c
diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/dev/rx-offload.c
similarity index 100%
rename from drivers/net/can/rx-offload.c
rename to drivers/net/can/dev/rx-offload.c
-- 
2.42.0



