Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B92879BEB8
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345657AbjIKVVu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239787AbjIKO2l (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:28:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C309BF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:28:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14753C433CB;
        Mon, 11 Sep 2023 14:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442516;
        bh=RfOXefkb/ViyT7bHHFPcyY542dVq93YXHY10GlDpZA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XCSZE70mkjVIQLVk8yQUtMWHxYKWuPDwavqAcBgTVN8MQF32YDotFOdHzIvCZm5M6
         3fcq6XaeubiSYdFHInHfMYQOId0yWkAF4qDmUjMvBPFz6OWKhVxlBO6OFzWStalUO5
         BNJEtK9sIEqw0yiDXrpR8WRUzw8/y3dIEAWUv+ew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kalle Valo <kvalo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 051/737] Revert "wifi: ath6k: silence false positive -Wno-dangling-pointer warning on GCC 12"
Date:   Mon, 11 Sep 2023 15:38:30 +0200
Message-ID: <20230911134651.893327767@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kalle Valo <kvalo@kernel.org>

[ Upstream commit a1ce186db7f0e449f35d12fb55ae0da2a1b400e2 ]

This reverts commit bd1d129daa3ede265a880e2c6a7f91eab0f4dc62.

The dangling-pointer warnings were disabled kernel-wide by commit 49beadbd47c2
("gcc-12: disable '-Wdangling-pointer' warning for now") for v5.19. So this
hack in ath6kl is not needed anymore.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230724100823.2948804-1-kvalo@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath6kl/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/Makefile b/drivers/net/wireless/ath/ath6kl/Makefile
index a75bfa9fd1cfd..dc2b3b46781e1 100644
--- a/drivers/net/wireless/ath/ath6kl/Makefile
+++ b/drivers/net/wireless/ath/ath6kl/Makefile
@@ -36,11 +36,6 @@ ath6kl_core-y += wmi.o
 ath6kl_core-y += core.o
 ath6kl_core-y += recovery.o
 
-# FIXME: temporarily silence -Wdangling-pointer on non W=1+ builds
-ifndef KBUILD_EXTRA_WARN
-CFLAGS_htc_mbox.o += $(call cc-disable-warning, dangling-pointer)
-endif
-
 ath6kl_core-$(CONFIG_NL80211_TESTMODE) += testmode.o
 ath6kl_core-$(CONFIG_ATH6KL_TRACING) += trace.o
 
-- 
2.40.1



