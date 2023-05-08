Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0326FA605
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjEHKPW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjEHKPU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:15:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7166B1FF1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:15:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F19636246C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162FAC433D2;
        Mon,  8 May 2023 10:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540918;
        bh=R35TOCD5/AImE9JcPW5JHgmoxxXW/TS0osNgU9G0TiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=woizfE9oOrxnrjmlZF07mt4saxx1hvzx3pYbmDV9L8AwcBw7RLOZEAHVh8UfKTw+o
         jY4qyQJQ62NNm21W5YBrSZSuXXud8yL1gNee0hQWkfKV0zDym/SpWY0RjcJClJB2zT
         3QXNGRqNFtx0jpQyYHsi5217qeauh9suQMwkWb/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 520/611] timekeeping: Fix references to nonexistent ktime_get_fast_ns()
Date:   Mon,  8 May 2023 11:46:02 +0200
Message-Id: <20230508094438.928830919@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 158009f1b4a33bc0f354b994eea361362bd83226 ]

There was never a function named ktime_get_fast_ns().
Presumably these should refer to ktime_get_mono_fast_ns() instead.

Fixes: c1ce406e80fb15fa ("timekeeping: Fix up function documentation for the NMI safe accessors")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/06df7b3cbd94f016403bbf6cd2b38e4368e7468f.1682516546.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/timekeeping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f72b9f1de178e..221c8c404973a 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -526,7 +526,7 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
  * partially updated.  Since the tk->offs_boot update is a rare event, this
  * should be a rare occurrence which postprocessing should be able to handle.
  *
- * The caveats vs. timestamp ordering as documented for ktime_get_fast_ns()
+ * The caveats vs. timestamp ordering as documented for ktime_get_mono_fast_ns()
  * apply as well.
  */
 u64 notrace ktime_get_boot_fast_ns(void)
@@ -576,7 +576,7 @@ static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
 /**
  * ktime_get_real_fast_ns: - NMI safe and fast access to clock realtime.
  *
- * See ktime_get_fast_ns() for documentation of the time stamp ordering.
+ * See ktime_get_mono_fast_ns() for documentation of the time stamp ordering.
  */
 u64 ktime_get_real_fast_ns(void)
 {
-- 
2.39.2



