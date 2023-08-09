Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7F67759B0
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjHILCq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjHILCo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:02:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E493C26BA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:02:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B88B6313B
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3BDC433C7;
        Wed,  9 Aug 2023 11:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578958;
        bh=cbszPOScgMv7dTvAKfrpJMZ3J5fwdSsHNmNvFWw+LN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4+lD3e6ijhC6HYJFT3AHzX+zAE8yVQ0LUzPPoFcMrINsIQQwuztVjQR9IxdBK5xQ
         b4XFtAqHk3y/H4YdKFXuz5x+DAGuK3cLib51rulpdAzYNFPscWp27sRcfBSRckACiK
         AqekZfiQYjYtCZO9PsP6oHWhFElNFms0WBC7N/5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 025/204] memstick r592: make memstick_debug_get_tpc_name() static
Date:   Wed,  9 Aug 2023 12:39:23 +0200
Message-ID: <20230809103643.411652659@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 434587df9f7fd68575f99a889cc5f2efc2eaee5e ]

There are no other files referencing this function, apparently
it was left global to avoid an 'unused function' warning when
the only caller is left out. With a 'W=1' build, it causes
a 'missing prototype' warning though:

drivers/memstick/host/r592.c:47:13: error: no previous prototype for 'memstick_debug_get_tpc_name' [-Werror=missing-prototypes]

Annotate the function as 'static __maybe_unused' to avoid both
problems.

Fixes: 926341250102 ("memstick: add driver for Ricoh R5C592 card reader")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20230516202714.560929-1-arnd@kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memstick/host/r592.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index d52c89b2a1d58..a2dbf3331689f 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -47,12 +47,10 @@ static const char *tpc_names[] = {
  * memstick_debug_get_tpc_name - debug helper that returns string for
  * a TPC number
  */
-const char *memstick_debug_get_tpc_name(int tpc)
+static __maybe_unused const char *memstick_debug_get_tpc_name(int tpc)
 {
 	return tpc_names[tpc-1];
 }
-EXPORT_SYMBOL(memstick_debug_get_tpc_name);
-
 
 /* Read a register*/
 static inline u32 r592_read_reg(struct r592_device *dev, int address)
-- 
2.39.2



