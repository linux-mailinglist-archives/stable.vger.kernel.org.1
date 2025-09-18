Return-Path: <stable+bounces-170889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A15AB2A6A4
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0923F176EC9
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A28B261B9C;
	Mon, 18 Aug 2025 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i8VqEKgg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EB3235C01;
	Mon, 18 Aug 2025 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524129; cv=none; b=ir54zq4yZJkC62e5eYmNVJy8Ad8H3VnbpvvH0BkL9dhoYUEEJB3CARrIQx8+b919b3fD719M6/N11HicvCXz3OkEwCrJLHLqTZPN442L269eARYe84ikxEmMDU41Tlak61GN9QIO2s4HaUDdUpsvgFCqER937JUbVtg0x3MuuGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524129; c=relaxed/simple;
	bh=V5fD5tce/8mLE6uFooP288AGo/b1MfPSaRuygRqHswo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXMSsOCjWTF7AIEbj6zLdVzKNBo43zsW4zy5Fi+Ei+N3rG3qfeMS4NUOF9+P79P2m5pYH6eU+W2lJaf2kOikh/o9YxqEa1BmpA07m2Dt90aZhYuyJHh5+/HDd9tWPn079KMj7Vq4U9RkmqapxJZly7dwfXmC2hQHAXh7/p4GYcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i8VqEKgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC56C4CEEB;
	Mon, 18 Aug 2025 13:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524129;
	bh=V5fD5tce/8mLE6uFooP288AGo/b1MfPSaRuygRqHswo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i8VqEKggfsel1xGbF3q+3zz7y5Cs2Oa3/4VH3oTdpmIhgfh2AlLWi6qkPtHh00qHW
	 UhN9PAcDWygVh3Md0wSLVMaH0mJq/Mdk8rdkr+E4U+Y88kMLqfFBo6Lft21ijhSpjn
	 f3ws6PVj1Miuo91oTNA4iINKKAzTLV4ZS1khYe/Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 377/515] media: tc358743: Increase FIFO trigger level to 374
Date: Mon, 18 Aug 2025 14:46:03 +0200
Message-ID: <20250818124512.938540912@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

[ Upstream commit 86addd25314a1e77dbdcfddfeed0bab2f27da0e2 ]

The existing fixed value of 16 worked for UYVY 720P60 over
2 lanes at 594MHz, or UYVY 1080P60 over 4 lanes. (RGB888
1080P60 needs 6 lanes at 594MHz).
It doesn't allow for lower resolutions to work as the FIFO
underflows.

374 is required for 1080P24 or 1080P30 UYVY over 2 lanes @
972Mbit/s, but >374 means that the FIFO underflows on 1080P50
UYVY over 2 lanes @ 972Mbit/s.

Whilst it would be nice to compute it, the required information
isn't published by Toshiba.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/tc358743.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index d4700d45c113..2c56832e0065 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -1979,8 +1979,19 @@ static int tc358743_probe_of(struct tc358743_state *state)
 	state->pdata.refclk_hz = clk_get_rate(refclk);
 	state->pdata.ddc5v_delay = DDC5V_DELAY_100_MS;
 	state->pdata.enable_hdcp = false;
-	/* A FIFO level of 16 should be enough for 2-lane 720p60 at 594 MHz. */
-	state->pdata.fifo_level = 16;
+	/*
+	 * Ideally the FIFO trigger level should be set based on the input and
+	 * output data rates, but the calculations required are buried in
+	 * Toshiba's register settings spreadsheet.
+	 * A value of 16 works with a 594Mbps data rate for 720p60 (using 2
+	 * lanes) and 1080p60 (using 4 lanes), but fails when the data rate
+	 * is increased, or a lower pixel clock is used that result in CSI
+	 * reading out faster than the data is arriving.
+	 *
+	 * A value of 374 works with both those modes at 594Mbps, and with most
+	 * modes on 972Mbps.
+	 */
+	state->pdata.fifo_level = 374;
 	/*
 	 * The PLL input clock is obtained by dividing refclk by pll_prd.
 	 * It must be between 6 MHz and 40 MHz, lower frequency is better.
-- 
2.39.5




