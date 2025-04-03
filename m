Return-Path: <stable+bounces-127632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 222A7A7A6D6
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99694175ECE
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CFC250BE7;
	Thu,  3 Apr 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WwYvEv0L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058E2505D2;
	Thu,  3 Apr 2025 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693917; cv=none; b=buyZlzYn32PEdW+6hHuCR8tXNc+wOkiXw1QmNCzSJo+wn/44k8Lb2bkV3oCST9oHXi8CqRq+T9hYbJLMb3qaHwYWzK3Dx0KhuMeE2pgQkwZv1JRMBZ9B27vqPRWkCKAH3XRDFCZ7mD7qnZyT4ENLgFjv2TLgGu/0mpK9PL5IuVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693917; c=relaxed/simple;
	bh=ozywYTnve/tiLrnEv7JmJUhW84iWBrvOryK1KL1z5d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ci8BMb/A08R/sge9Ord/HRIqRjSQnbEBwufOzupYgFe+R7r9CHoCKVZodjlsAdDuhXFNnHJSxGOaSIACJ3539aVboZbcdIYp0oQZEIQBUKUn5J/oprJBBlhNVQD/PgPlPfGCZxe2x9wLtjK8xgho45QCe23xgJA8aDkFsOtq2IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WwYvEv0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B21C4CEE7;
	Thu,  3 Apr 2025 15:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743693916;
	bh=ozywYTnve/tiLrnEv7JmJUhW84iWBrvOryK1KL1z5d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WwYvEv0LMBKB84yAV0pPB1iNg1ILPLwFhlQxXgKhjwq5pQEr5riWNR5Wp7S2SzOEj
	 aO9JfsOXJm592xmAfbH2H55CZ5I69Bn1nbEUWlGRJwu6w5yCRGbsQFzcbcq2tRDxl5
	 3iW6QF7HXv2JU9m5BuphWaaHq3JfBcWLNSGooHkY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
	William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH 6.13 10/23] counter: microchip-tcb-capture: Fix undefined counter channel state on probe
Date: Thu,  3 Apr 2025 16:20:27 +0100
Message-ID: <20250403151622.570707085@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403151622.273788569@linuxfoundation.org>
References: <20250403151622.273788569@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: William Breathitt Gray <wbg@kernel.org>

commit c0c9c73434666dc99ee156b25e7e722150bee001 upstream.

Hardware initialize of the timer counter channel does not occur on probe
thus leaving the Count in an undefined state until the first
function_write() callback is executed. Fix this by performing the proper
hardware initialization during probe.

Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
Reported-by: Csókás Bence <csokas.bence@prolan.hu>
Closes: https://lore.kernel.org/all/bfa70e78-3cc3-4295-820b-3925c26135cb@prolan.hu/
Link: https://lore.kernel.org/r/20250305-preset-capture-mode-microchip-tcb-capture-v1-1-632c95c6421e@kernel.org
Signed-off-by: William Breathitt Gray <wbg@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/counter/microchip-tcb-capture.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -368,6 +368,25 @@ static int mchp_tc_probe(struct platform
 			channel);
 	}
 
+	/* Disable Quadrature Decoder and position measure */
+	ret = regmap_update_bits(regmap, ATMEL_TC_BMR, ATMEL_TC_QDEN | ATMEL_TC_POSEN, 0);
+	if (ret)
+		return ret;
+
+	/* Setup the period capture mode */
+	ret = regmap_update_bits(regmap, ATMEL_TC_REG(priv->channel[0], CMR),
+				 ATMEL_TC_WAVE | ATMEL_TC_ABETRG | ATMEL_TC_CMR_MASK |
+				 ATMEL_TC_TCCLKS,
+				 ATMEL_TC_CMR_MASK);
+	if (ret)
+		return ret;
+
+	/* Enable clock and trigger counter */
+	ret = regmap_write(regmap, ATMEL_TC_REG(priv->channel[0], CCR),
+			   ATMEL_TC_CLKEN | ATMEL_TC_SWTRG);
+	if (ret)
+		return ret;
+
 	priv->tc_cfg = tcb_config;
 	priv->regmap = regmap;
 	counter->name = dev_name(&pdev->dev);



