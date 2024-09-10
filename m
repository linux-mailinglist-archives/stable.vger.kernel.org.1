Return-Path: <stable+bounces-74891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDF09731FA
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8BF1F29374
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C8F1A073B;
	Tue, 10 Sep 2024 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BDtXiGmE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915311A0716;
	Tue, 10 Sep 2024 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963136; cv=none; b=ZA8pWnMb3eVVDB5TEQOvNNZDgFGxEbEdYSeVJKw4Shx/nh6D28s0AVgUao2gBuDPqNSct2iSuzMU9q5FStAj98ddKXadS8n4gaYafYtmH6Gs3qrUMW3/9Rbci+d+JOKz88nrJx6MO7+mupaJp+YoDROlJcxjVqnQJWajRBtCXyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963136; c=relaxed/simple;
	bh=GfKvcRgbsk3P/BpPLTRrWuMMHvWUJGGwb6Luhxx2cv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrUC95HvyKHzHXSL6CBeKxCH5Qu2ArJwj4AFyo6Ll3b3SdDHjpkiN/3CJemUfYDTiQ9MfDQkLOT1P46LP9d/lDAXmHbvnjKOWjNWRCiRiqsb+10QkOdJTYOQ6M8/yC5H643eApd6BJOgURKojSysd5LhKO70M8Dn1CRZSLyw1l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BDtXiGmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62E0C4CECD;
	Tue, 10 Sep 2024 10:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963136;
	bh=GfKvcRgbsk3P/BpPLTRrWuMMHvWUJGGwb6Luhxx2cv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDtXiGmEmBK91EhYFD4dFrWUvGkj84OpxAmka5e1kWkXswljHB6iyhbVRBgA8cDAk
	 LFt6WLlpVQotZtWfSr46wgOrxv7IbwZlNrLDCXKsnVQWiJ14bpoK8OShZk2jpGkwbO
	 BPulps/APAZCur8czbjWAVB1mpoaEAuR5qN3RQjY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacky Bai <ping.bai@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Ye Li <ye.li@nxp.com>,
	Jason Liu <jason.hui.liu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 6.1 148/192] clocksource/drivers/imx-tpm: Fix return -ETIME when delta exceeds INT_MAX
Date: Tue, 10 Sep 2024 11:32:52 +0200
Message-ID: <20240910092604.065269380@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092557.876094467@linuxfoundation.org>
References: <20240910092557.876094467@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacky Bai <ping.bai@nxp.com>

commit 5b8843fcd49827813da80c0f590a17ae4ce93c5d upstream.

In tpm_set_next_event(delta), return -ETIME by wrong cast to int when delta
is larger than INT_MAX.

For example:

tpm_set_next_event(delta = 0xffff_fffe)
{
        ...
        next = tpm_read_counter(); // assume next is 0x10
        next += delta; // next will 0xffff_fffe + 0x10 = 0x1_0000_000e
        now = tpm_read_counter();  // now is 0x10
        ...

        return (int)(next - now) <= 0 ? -ETIME : 0;
                     ^^^^^^^^^^
                     0x1_0000_000e - 0x10 = 0xffff_fffe, which is -2 when
                     cast to int. So return -ETIME.
}

To fix this, introduce a 'prev' variable and check if 'now - prev' is
larger than delta.

Cc: stable@vger.kernel.org
Fixes: 059ab7b82eec ("clocksource/drivers/imx-tpm: Add imx tpm timer support")
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20240725193355.1436005-1-Frank.Li@nxp.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clocksource/timer-imx-tpm.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -83,10 +83,10 @@ static u64 notrace tpm_read_sched_clock(
 static int tpm_set_next_event(unsigned long delta,
 				struct clock_event_device *evt)
 {
-	unsigned long next, now;
+	unsigned long next, prev, now;
 
-	next = tpm_read_counter();
-	next += delta;
+	prev = tpm_read_counter();
+	next = prev + delta;
 	writel(next, timer_base + TPM_C0V);
 	now = tpm_read_counter();
 
@@ -96,7 +96,7 @@ static int tpm_set_next_event(unsigned l
 	 * of writing CNT registers which may cause the min_delta event got
 	 * missed, so we need add a ETIME check here in case it happened.
 	 */
-	return (int)(next - now) <= 0 ? -ETIME : 0;
+	return (now - prev) >= delta ? -ETIME : 0;
 }
 
 static int tpm_set_state_oneshot(struct clock_event_device *evt)



