Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C8F7BDF92
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377076AbjJINb3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377078AbjJINb3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:31:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E86B6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:31:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95355C433C7;
        Mon,  9 Oct 2023 13:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858287;
        bh=zC/bwarjffb1wH+FyFZTvIuumW3FjgkxT42dBH4VefI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRScla58yr76M89RTWG+qLF0UE4efZmfkk3TgIvpOxWElronDxjymBm7704+VO093
         teTV5Dj4dtpTI/cBV97xh8w/o/jzbXDZ0/Ptw4JFPyCxNS4pTkxdXTA2Q0zi8pTgb8
         xSc644Te7QbdmAXltBk/OJEcPDf9wVyj3EcXH+10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 047/131] xtensa: add default definition for XCHAL_HAVE_DIV32
Date:   Mon,  9 Oct 2023 15:01:27 +0200
Message-ID: <20231009130117.749513950@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

[ Upstream commit 494e87ffa0159b3f879694a9231089707792a44d ]

When variant FSF is set, XCHAL_HAVE_DIV32 is not defined. Add default
definition for that macro to prevent build warnings:

arch/xtensa/lib/divsi3.S:9:5: warning: "XCHAL_HAVE_DIV32" is not defined, evaluates to 0 [-Wundef]
    9 | #if XCHAL_HAVE_DIV32
arch/xtensa/lib/modsi3.S:9:5: warning: "XCHAL_HAVE_DIV32" is not defined, evaluates to 0 [-Wundef]
    9 | #if XCHAL_HAVE_DIV32

Fixes: 173d6681380a ("xtensa: remove extra header files")
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: lore.kernel.org/r/202309150556.t0yCdv3g-lkp@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/include/asm/core.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/xtensa/include/asm/core.h b/arch/xtensa/include/asm/core.h
index 5975b244b7b80..02c93e08d5925 100644
--- a/arch/xtensa/include/asm/core.h
+++ b/arch/xtensa/include/asm/core.h
@@ -6,6 +6,10 @@
 
 #include <variant/core.h>
 
+#ifndef XCHAL_HAVE_DIV32
+#define XCHAL_HAVE_DIV32 0
+#endif
+
 #ifndef XCHAL_HAVE_EXCLUSIVE
 #define XCHAL_HAVE_EXCLUSIVE 0
 #endif
-- 
2.40.1



