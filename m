Return-Path: <stable+bounces-110797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAE7A1CD13
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B9D1885E37
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25502191F6D;
	Sun, 26 Jan 2025 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUy7svlh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65361917D8;
	Sun, 26 Jan 2025 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737909939; cv=none; b=oGDa5UAjce1rqqe6sJbyurjDeFHNqC3Iwm6CtXlRupEoVPSJECMDrzunsXF5+f1BWosnoz8kIUKZT5Y9KWFJZpb/orqZGANeeZSHxThhjlcxfp6mOPozgjJC6iG6WNBqpoIsMcnR2rgpXZwyjYqRjo4NWE8MgqQ3CuXgF3vXaZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737909939; c=relaxed/simple;
	bh=9VzH5aG2tjjUbqdni80bhk9ykOGOWpDhEBI+wkaVa0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=izkCuneGieoWQ95GAT1b8ADu+1JRKu/oPu6lge7qUwfz0H3WNvkMvXQ7g2uruKXZGvRJ6Bie5YscJN/D0+avQ8Y64otXBRzHJ0RUMKZf3IMqc1B7KnyQdqv9toWrxKGPE1Atql2ZLA/OgdoqHKrPCxyaFefUCecpuPc5Yq8fiN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUy7svlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8774AC4CED3;
	Sun, 26 Jan 2025 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737909939;
	bh=9VzH5aG2tjjUbqdni80bhk9ykOGOWpDhEBI+wkaVa0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUy7svlhu2DTPHgA+uwCt1/9l363VJ6tVcc7+YmCYWxBf14/+liq6gt4DT/RmhPI7
	 E3+gQGG87g0aTuO7kO1tGS6ai0ATmUBpC8btjOC/NPRfGhv3kvDaGIeypS3ynjxqqp
	 YUZm0JIpTbsNgwq4LduZcdi6bTKClZZoF0lmRF6YsH7m/ygE2VwXvQ2+M8UpaMEE1R
	 y49csaL1+d26SxKs3wYhyiDhOQyTIEnYacw0FOL9O2QH56AguVBEFhKV46o8rVw02O
	 0F+YCJgCZXLOEiWc3+pcUGJGGWbQPgkOflfe4EnpZ/DOBhRfs41h3wMw9vsIIMiA9G
	 KqnETewadBTNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 7/8] i3c: mipi-i3c-hci: Add Intel specific quirk to ring resuming
Date: Sun, 26 Jan 2025 11:45:22 -0500
Message-Id: <20250126164523.963930-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126164523.963930-1-sashal@kernel.org>
References: <20250126164523.963930-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

[ Upstream commit ccdb2e0e3b00d13df90ac7a0524dd855173f1171 ]

MIPI I3C HCI on Intel hardware requires a quirk where ring needs to stop
and set to run again after resuming the halted controller. This is not
expected from the MIPI I3C HCI specification and is Intel specific.

Add this quirk to generic aborted transfer handling and execute it only
when ring is not in running state after a transfer error and attempted
controller resume. This is the case on Intel hardware.

It is not fully clear to me what is the ring running state in generic
hardware in such case. I would expect if ring is not running, then stop
request is a no-op and run request is either required or does the same
what controller resume would do.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20241231115904.620052-1-jarkko.nikula@linux.intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/mipi-i3c-hci/dma.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index e8e56a8d20573..491dfe70b6600 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -758,9 +758,26 @@ static bool hci_dma_irq_handler(struct i3c_hci *hci)
 			complete(&rh->op_done);
 
 		if (status & INTR_TRANSFER_ABORT) {
+			u32 ring_status;
+
 			dev_notice_ratelimited(&hci->master.dev,
 				"ring %d: Transfer Aborted\n", i);
 			mipi_i3c_hci_resume(hci);
+			ring_status = rh_reg_read(RING_STATUS);
+			if (!(ring_status & RING_STATUS_RUNNING) &&
+			    status & INTR_TRANSFER_COMPLETION &&
+			    status & INTR_TRANSFER_ERR) {
+				/*
+				 * Ring stop followed by run is an Intel
+				 * specific required quirk after resuming the
+				 * halted controller. Do it only when the ring
+				 * is not in running state after a transfer
+				 * error.
+				 */
+				rh_reg_write(RING_CONTROL, RING_CTRL_ENABLE);
+				rh_reg_write(RING_CONTROL, RING_CTRL_ENABLE |
+							   RING_CTRL_RUN_STOP);
+			}
 		}
 		if (status & INTR_WARN_INS_STOP_MODE)
 			dev_warn_ratelimited(&hci->master.dev,
-- 
2.39.5


