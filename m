Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DCC7A3894
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbjIQThh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbjIQThM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:37:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A5126
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:37:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C734AC433C8;
        Sun, 17 Sep 2023 19:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979427;
        bh=8Wsit7tyI74peB+m7IuosVhR/TOj6wcY6BIOQUtftuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KNb4cr+UJ1wx6dCjSBHGJoBjb+etWBqD+jo5Ib93yXTSu9Z4YrPS4dRHLScRfmMVq
         RnQtCCUj4qog5QDYM5ykZjAbL2Kd3kmAcOre9vc07blzGtePEUwWopZceCIrBLLqsM
         z4b9Rvm/vB732MLWac7L5q2eezgEJ+kNkI7wUaB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5.10 283/406] xtensa: PMU: fix base address for the newer hardware
Date:   Sun, 17 Sep 2023 21:12:17 +0200
Message-ID: <20230917191108.773134372@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit 687eb3c42f4ad81e7c947c50e2d865f692064291 upstream.

With introduction of ERI access control in RG.0 base address of the PMU
unit registers has changed. Add support for the new PMU configuration.

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/xtensa/include/asm/core.h  |    9 +++++++++
 arch/xtensa/kernel/perf_event.c |   17 +++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

--- a/arch/xtensa/include/asm/core.h
+++ b/arch/xtensa/include/asm/core.h
@@ -26,4 +26,13 @@
 #define XCHAL_SPANNING_WAY 0
 #endif
 
+#ifndef XCHAL_HW_MIN_VERSION
+#if defined(XCHAL_HW_MIN_VERSION_MAJOR) && defined(XCHAL_HW_MIN_VERSION_MINOR)
+#define XCHAL_HW_MIN_VERSION (XCHAL_HW_MIN_VERSION_MAJOR * 100 + \
+			      XCHAL_HW_MIN_VERSION_MINOR)
+#else
+#define XCHAL_HW_MIN_VERSION 0
+#endif
+#endif
+
 #endif
--- a/arch/xtensa/kernel/perf_event.c
+++ b/arch/xtensa/kernel/perf_event.c
@@ -13,17 +13,26 @@
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 
+#include <asm/core.h>
 #include <asm/processor.h>
 #include <asm/stacktrace.h>
 
+#define XTENSA_HWVERSION_RG_2015_0	260000
+
+#if XCHAL_HW_MIN_VERSION >= XTENSA_HWVERSION_RG_2015_0
+#define XTENSA_PMU_ERI_BASE		0x00101000
+#else
+#define XTENSA_PMU_ERI_BASE		0x00001000
+#endif
+
 /* Global control/status for all perf counters */
-#define XTENSA_PMU_PMG			0x1000
+#define XTENSA_PMU_PMG			XTENSA_PMU_ERI_BASE
 /* Perf counter values */
-#define XTENSA_PMU_PM(i)		(0x1080 + (i) * 4)
+#define XTENSA_PMU_PM(i)		(XTENSA_PMU_ERI_BASE + 0x80 + (i) * 4)
 /* Perf counter control registers */
-#define XTENSA_PMU_PMCTRL(i)		(0x1100 + (i) * 4)
+#define XTENSA_PMU_PMCTRL(i)		(XTENSA_PMU_ERI_BASE + 0x100 + (i) * 4)
 /* Perf counter status registers */
-#define XTENSA_PMU_PMSTAT(i)		(0x1180 + (i) * 4)
+#define XTENSA_PMU_PMSTAT(i)		(XTENSA_PMU_ERI_BASE + 0x180 + (i) * 4)
 
 #define XTENSA_PMU_PMG_PMEN		0x1
 


