Return-Path: <stable+bounces-18233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E848481E9
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181AF1C23812
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B2918B14;
	Sat,  3 Feb 2024 04:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TOW0eyxz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337D042AB1;
	Sat,  3 Feb 2024 04:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933646; cv=none; b=a21gkQLNT998lAV5/+/533WhLQhSmQ0CPIgB8e5niRP4tdAdp4NuICF+3gnWpBFYD3qgJR8HMe5I/AsO/+gt2TmCkMWWnOr20u23iOXxBOdnJ67qpiA+4CE/7RPuijCw9gRy4ZkyQIp1WiYMIJccDZbq5eIHThmgN8RRNs50Cj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933646; c=relaxed/simple;
	bh=tIjV3+VOrX2uvQFIBQe3vfdZD/0uO5TjK2CbLJ0Isbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZcwJhOuVY/SB/WN9IS5TnHQX9E43BSdgcoW0MGlOUsdM88rQuAXRtCHtjvDa3sGvcz55cnmQMroxOFlOGeifIsFynOgAtmiljT9U2rsDbiB3fomlYLKvufM6XgIuOMaSj/Uumz/5uSFePGUZSei1oyf2TDK3btHyRG2WQFrupQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TOW0eyxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9228C43399;
	Sat,  3 Feb 2024 04:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933646;
	bh=tIjV3+VOrX2uvQFIBQe3vfdZD/0uO5TjK2CbLJ0Isbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOW0eyxzOLlhiJV2Rb57j4v3KUFwrvs8GJnZ0lEQHqlWGBQY081hERbsXkQQf9q/j
	 zFqi89uANKbmi96CKXHdecRpUPxjuy3qGvxL8zNlEc51sRHxXDZy2XDuewKn9ogqjw
	 NS2h08prnI7/yaECCJ2wnTeJ6hdatm6Q+G/IpxsY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Xiaowu.ding" <xiaowu.ding@jaguarmicro.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 228/322] mailbox: arm_mhuv2: Fix a bug for mhuv2_sender_interrupt
Date: Fri,  2 Feb 2024 20:05:25 -0800
Message-ID: <20240203035406.576420464@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiaowu.ding <xiaowu.ding@jaguarmicro.com>

[ Upstream commit ee01c0b4384d19ecc5dfa7db3fd4303f965c3eba ]

Message Handling Unit version is v2.1.

When arm_mhuv2 working with the data protocol transfer mode.
We have split one mhu into two channels, and every channel
include four channel windows, the two channels share
one gic spi interrupt.

There is a problem with the sending scenario.

The first channel will take up 0-3 channel windows, and the second
channel take up 4-7 channel windows. When the first channel send the
data, and the receiver will clear all the four channels status.
Although we only enabled the interrupt on the last channel window with
register CH_INT_EN,the register CHCOMB_INT_ST0 will be 0xf, not be 0x8.
Currently we just clear the last channel windows int status with the
data proctol mode.So after that,the CHCOMB_INT_ST0 status will be 0x7,
not be the 0x0.

Then the second channel send the data, the receiver read the
data, clear all the four channel windows status, trigger the sender
interrupt. But currently the CHCOMB_INT_ST0 register will be 0xf7,
get_irq_chan_comb function will always return the first channel.

So this patch clear all channel windows int status to avoid this interrupt
confusion.

Signed-off-by: Xiaowu.ding <xiaowu.ding@jaguarmicro.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/arm_mhuv2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
index c6d4957c4da8..0ec21dcdbde7 100644
--- a/drivers/mailbox/arm_mhuv2.c
+++ b/drivers/mailbox/arm_mhuv2.c
@@ -553,7 +553,8 @@ static irqreturn_t mhuv2_sender_interrupt(int irq, void *data)
 	priv = chan->con_priv;
 
 	if (!IS_PROTOCOL_DOORBELL(priv)) {
-		writel_relaxed(1, &mhu->send->ch_wn[priv->ch_wn_idx + priv->windows - 1].int_clr);
+		for (i = 0; i < priv->windows; i++)
+			writel_relaxed(1, &mhu->send->ch_wn[priv->ch_wn_idx + i].int_clr);
 
 		if (chan->cl) {
 			mbox_chan_txdone(chan, 0);
-- 
2.43.0




