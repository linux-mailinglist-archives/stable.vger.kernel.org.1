Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753B07BDDB9
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376976AbjJINMw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376990AbjJINMm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:12:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BBC213E
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:11:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1D2C433CB;
        Mon,  9 Oct 2023 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857089;
        bh=qqvxmQxI3Eb12Ank7Z/TtATJ3SgNQqZSzlmqccTLvIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F58JHSM5dA9XBvta32OjmoBmbavQ39nCmh2IVH2NDrX83G5+oY23QSNPn+SxNWBD7
         XUBufPlK1YWD+GQ0tjJhrUG27tM8CMdFtTRM2kv/dTaOG9l+qrsGhgS9dHOYyNIprb
         lxdRCyfmyWVl5Hx+4dFIuCrqKShATK7ICeHDzydA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 066/163] rtla/timerlat_aa: Fix negative IRQ delay
Date:   Mon,  9 Oct 2023 15:00:30 +0200
Message-ID: <20231009130125.872123498@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Bristot de Oliveira <bristot@kernel.org>

[ Upstream commit 6c73daf26420b97fb8b4a620e4ffee5c1f9d44d1 ]

When estimating the IRQ timer delay, we are dealing with two different
clock sources: the external clock source that timerlat uses as a reference
and the clock used by the tracer. There are also two moments: the time
reading the clock and the timer in which the event is placed in the
buffer (the trace event timestamp).

If the processor is slow or there is some hardware noise, the difference
between the timestamp and the external clock, read can be longer than the
IRQ handler delay, resulting in a negative time.

If so, set IRQ to start delay as 0. In the end, it is less near-zero and relevant
then the noise.

Link: https://lore.kernel.org/lkml/a066fb667c7136d86dcddb3c7ccd72587db3e7c7.1691162043.git.bristot@kernel.org

Fixes: 27e348b221f6 ("rtla/timerlat: Add auto-analysis core")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/tracing/rtla/src/timerlat_aa.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index dec5b4c4511e1..baf1efda0581d 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -338,7 +338,23 @@ static int timerlat_aa_irq_handler(struct trace_seq *s, struct tep_record *recor
 		taa_data->timer_irq_start_time = start;
 		taa_data->timer_irq_duration = duration;
 
-		taa_data->timer_irq_start_delay = taa_data->timer_irq_start_time - expected_start;
+		/*
+		 * We are dealing with two different clock sources: the
+		 * external clock source that timerlat uses as a reference
+		 * and the clock used by the tracer. There are also two
+		 * moments: the time reading the clock and the timer in
+		 * which the event is placed in the buffer (the trace
+		 * event timestamp). If the processor is slow or there
+		 * is some hardware noise, the difference between the
+		 * timestamp and the external clock read can be longer
+		 * than the IRQ handler delay, resulting in a negative
+		 * time. If so, set IRQ start delay as 0. In the end,
+		 * it is less relevant than the noise.
+		 */
+		if (expected_start < taa_data->timer_irq_start_time)
+			taa_data->timer_irq_start_delay = taa_data->timer_irq_start_time - expected_start;
+		else
+			taa_data->timer_irq_start_delay = 0;
 
 		/*
 		 * not exit from idle.
-- 
2.40.1



