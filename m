Return-Path: <stable+bounces-118090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DFAA3BA17
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B653420AB4
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341FF1DE883;
	Wed, 19 Feb 2025 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dp8nNTTl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0071C760D;
	Wed, 19 Feb 2025 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957206; cv=none; b=EgE0xmDWvm5ZsEo9v/sTbQFyX7bAng731+pCbNv0Fzju/0Gh5FailqNDzKc4qT7GEHty7Krf65cR9gS/JFdOjC3LOuAXFDCLzxJxSQqx6RxR3WYQFHndVjuanjW/mT9acE+Vx7ogJNFGFuef7ARJX77wh/NusvZkRNbpkwh0It4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957206; c=relaxed/simple;
	bh=poiaEGPulsO+OmZ01T5CqV4/j4xqc/gFD8mjJ/ok8UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhlPn2cXBdfX/8dO52M0WFdt1R0fAevpBDouHvQpbf4t6yK3QK+SXo5u33DFThDoHJNjJ4CIqD175KRKq7jqSZBwodiMVoJcslWSbj8nv1vg7mrSHVlM5N5l9wg0NwTjQrl/JBtVKQvlDOqEtFQWNkDQ/e551TtloXRDPt2rN4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dp8nNTTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636E1C4CED1;
	Wed, 19 Feb 2025 09:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739957206;
	bh=poiaEGPulsO+OmZ01T5CqV4/j4xqc/gFD8mjJ/ok8UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dp8nNTTlptIjRcau7dg2HM63WhE4/jaTtnJCjZF588nZFtLocerpJdR7poC9drZCB
	 q43+uA5mHW+j0Y3im6fZh+CMDJRo6M9tmnBN3tBuL/kWlMjM4ZEQhFhXf/x59bvA/T
	 zoj/4NPuBgx6fXInxLktWkh7B8BlAX2zHSjTDYkA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Simek <michal.simek@amd.com>,
	stable@kernel.org,
	Peter Korsgaard <peter@korsgaard.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6.1 445/578] rtc: zynqmp: Fix optional clock name property
Date: Wed, 19 Feb 2025 09:27:29 +0100
Message-ID: <20250219082710.502861598@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Michal Simek <michal.simek@amd.com>

commit 2a388ff22d2cbfc5cbd628ef085bdcd3b7dc64f5 upstream.

Clock description in DT binding introduced by commit f69060c14431
("dt-bindings: rtc: zynqmp: Add clock information") is talking about "rtc"
clock name but driver is checking "rtc_clk" name instead.
Because clock is optional property likely in was never handled properly by
the driver.

Fixes: 07dcc6f9c762 ("rtc: zynqmp: Add calibration set and get support")
Signed-off-by: Michal Simek <michal.simek@amd.com>
Cc: stable@kernel.org
Reviewed-by: Peter Korsgaard <peter@korsgaard.com>
Link: https://lore.kernel.org/r/cd5f0c9d01ec1f5a240e37a7e0d85b8dacb3a869.1732723280.git.michal.simek@amd.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-zynqmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index 625f708a7caf..f39102b66eac 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -318,8 +318,8 @@ static int xlnx_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* Getting the rtc_clk info */
-	xrtcdev->rtc_clk = devm_clk_get_optional(&pdev->dev, "rtc_clk");
+	/* Getting the rtc info */
+	xrtcdev->rtc_clk = devm_clk_get_optional(&pdev->dev, "rtc");
 	if (IS_ERR(xrtcdev->rtc_clk)) {
 		if (PTR_ERR(xrtcdev->rtc_clk) != -EPROBE_DEFER)
 			dev_warn(&pdev->dev, "Device clock not found.\n");
-- 
2.48.1




