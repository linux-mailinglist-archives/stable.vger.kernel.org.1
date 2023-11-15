Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A717DD54C
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376567AbjJaRtM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376521AbjJaRtK (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:49:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7F3F4
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:49:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5965C433CA;
        Tue, 31 Oct 2023 17:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774542;
        bh=eJC+CvqeTWkLLFVTr50LAmd8scizRWCW0WSbwxKRFxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQgmJJNIG2jlKOv8WwQuuYmspzDpdXEXwNu4JKs3ClUrf39F4/AOrj1L6Wt9T+UaS
         isGALGqkBrv638BEo/j2AFMu2s5Bnf3T2Cf0UQoYeUKnCPL4tmVNWUz0ClkJVaIJWn
         0QK0R0pt+jUj+iMw2CL+oB+7dq6eJaUH8C+Rbvb4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Khazhismel Kumykov <khazhy@google.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.5 081/112] blk-throttle: check for overflow in calculate_bytes_allowed
Date:   Tue, 31 Oct 2023 18:01:22 +0100
Message-ID: <20231031165903.873194815@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Khazhismel Kumykov <khazhy@chromium.org>

commit 2dd710d476f2f1f6eaca884f625f69ef4389ed40 upstream.

Inexact, we may reject some not-overflowing values incorrectly, but
they'll be on the order of exabytes allowed anyways.

This fixes divide error crash on x86 if bps_limit is not configured or
is set too high in the rare case that jiffy_elapsed is greater than HZ.

Fixes: e8368b57c006 ("blk-throttle: use calculate_io/bytes_allowed() for throtl_trim_slice()")
Fixes: 8d6bbaada2e0 ("blk-throttle: prevent overflow while calculating wait time")
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20231020223617.2739774-1-khazhy@google.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-throttle.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -723,6 +723,12 @@ static unsigned int calculate_io_allowed
 
 static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
 {
+	/*
+	 * Can result be wider than 64 bits?
+	 * We check against 62, not 64, due to ilog2 truncation.
+	 */
+	if (ilog2(bps_limit) + ilog2(jiffy_elapsed) - ilog2(HZ) > 62)
+		return U64_MAX;
 	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
 }
 


