Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A416FA80F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjEHKhT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjEHKhD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:37:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E16322F74
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CDFC627D4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E569C433EF;
        Mon,  8 May 2023 10:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542220;
        bh=37Et6PbHvCGIsocBUxddF/q1eEzwLg/W60V58U66AO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wA2d2wKR8Ke7WJ/QEr1rvHsqE98rdNgNjNFS+SZ9qnZN3wfGdmDcdgSqOql/xwM4e
         dJJKso3J02qYmXcMkQE1WDhofizkWPGR14r9FBfLPKvX4/E2nzWPmtPrG/Fa7yxOtX
         DrK6eWAlJhEF7gvHksvHkvDbsOQWM1D+tiMDz3J0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 365/663] wifi: iwlwifi: debug: fix crash in __iwl_err()
Date:   Mon,  8 May 2023 11:43:11 +0200
Message-Id: <20230508094439.987600019@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 634c7b1bd08ca322537ab389f8cbd7bb543b5e45 ]

In __iwl_err(), if we rate-limit the message away, then
vaf.va is still NULL-initialized by the time we get to
the tracing code, which then crashes. When it doesn't
get rate-limited out, it's still wrong to reuse the old
args2 that was already printed, which is why we bother
making a copy in the first place.

Assign vaf.va properly to fix this.

Fixes: e5f1cc98cc1b ("iwlwifi: allow rate-limited error messages")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230413102635.e27134c6bcd4.Ib3894cd2ba7a5ad5e75912a7634f146ceaa569e2@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/iwl-debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
index ae4c2a3d63d5b..3a3c13a41fc61 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2011, 2021 Intel Corporation
+ * Copyright (C) 2005-2011, 2021-2022 Intel Corporation
  */
 #include <linux/device.h>
 #include <linux/interrupt.h>
@@ -57,6 +57,7 @@ void __iwl_err(struct device *dev, enum iwl_err_mode mode, const char *fmt, ...)
 	default:
 		break;
 	}
+	vaf.va = &args;
 	trace_iwlwifi_err(&vaf);
 	va_end(args);
 }
-- 
2.39.2



