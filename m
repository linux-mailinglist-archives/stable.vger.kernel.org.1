Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4C076162C
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbjGYLhP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjGYLhL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:37:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7219F1FD8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:36:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06B5A616A9
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF82EC433C8;
        Tue, 25 Jul 2023 11:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285013;
        bh=RUnDs38rEXzt4nBIUhcjnV7MnUM6Lf5+ejGIqcpVrpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MNKS/13LABxLmUubRaU0caSxRCuZmgFLsQtqb28pPUoX3hbLQvKiNO4ARfeNtNRIB
         BHQyix3irjTI7hWWK7fymcBsCCBzVmbHst3sDp2gfVfiScZYrgTUfnecG/lBMCBkC3
         TyaCUwYvI+OR1YQUx8TiRBocwPjw7XIBixFQPuwY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Colin Cross <ccross@android.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <groeck@chromium.org>,
        Ian Rogers <irogers@google.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 052/313] watchdog/perf: more properly prevent false positives with turbo modes
Date:   Tue, 25 Jul 2023 12:43:25 +0200
Message-ID: <20230725104523.332795895@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 4379e59fe5665cfda737e45b8bf2f05321ef049c ]

Currently, in the watchdog_overflow_callback() we first check to see if
the watchdog had been touched and _then_ we handle the workaround for
turbo mode.  This order should be reversed.

Specifically, "touching" the hardlockup detector's watchdog should avoid
lockups being detected for one period that should be roughly the same
regardless of whether we're running turbo or not.  That means that we
should do the extra accounting for turbo _before_ we look at (and clear)
the global indicating that we've been touched.

NOTE: this fix is made based on code inspection.  I am not aware of any
reports where the old code would have generated false positives.  That
being said, this order seems more correct and also makes it easier down
the line to share code with the "buddy" hardlockup detector.

Link: https://lkml.kernel.org/r/20230519101840.v5.2.I843b0d1de3e096ba111a179f3adb16d576bef5c7@changeid
Fixes: 7edaeb6841df ("kernel/watchdog: Prevent false positives with turbo modes")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Colin Cross <ccross@android.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tzung-Bi Shih <tzungbi@chromium.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/watchdog_hld.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582ca..1e8a49dc956e2 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -114,14 +114,14 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	/* Ensure the watchdog never gets throttled */
 	event->hw.interrupts = 0;
 
+	if (!watchdog_check_timestamp())
+		return;
+
 	if (__this_cpu_read(watchdog_nmi_touch) == true) {
 		__this_cpu_write(watchdog_nmi_touch, false);
 		return;
 	}
 
-	if (!watchdog_check_timestamp())
-		return;
-
 	/* check for a hardlockup
 	 * This is done by making sure our timer interrupt
 	 * is incrementing.  The timer interrupt should have
-- 
2.39.2



