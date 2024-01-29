Return-Path: <stable+bounces-16649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB57840DD7
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5EEC1F2CF15
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4021C15D5A1;
	Mon, 29 Jan 2024 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Gbmj/WE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B715956D;
	Mon, 29 Jan 2024 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548176; cv=none; b=jtGYhsUiYZcqwA/kEGMM9jZouP9hRR1eRFJrBvGX4dJ5IgvR9zsErsEnLGDGlCg357DlcKGYTJh3+LjMss/1nITZdv2jHOKVoJ7YOaCsvYhtDWz8hYOiPeZRF+a3jlF9+jhNNefCmlr1JazXyMFyWq90ps2c8aNm8W9wzm14mww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548176; c=relaxed/simple;
	bh=T/Lk9hTqE7UwUkuvYcBOOEf9ZEtvyDwGbkUG3HmoovY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krxKyxjUlaIqymDabR3ZQ8bTX6g0etuD/IiL80R+DzqNi9mSY6MvTtA+W/DhI+YT3n+d+hBZUdvAsX/j2ASl/dj5UG7w89Rw4R7XwC/499cYmCzqlA+5+BvF4YF6nZtosGBKy2Jv32vSQMOSdumqAIqQgF8Oyuc8PJymYkmajYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Gbmj/WE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE352C433F1;
	Mon, 29 Jan 2024 17:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548175;
	bh=T/Lk9hTqE7UwUkuvYcBOOEf9ZEtvyDwGbkUG3HmoovY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Gbmj/WERZz4zy65wf9C9ANngEFVt/4SmJKCwVPHxcawdI7XJc11+yOYmmzJF+X+V
	 7XZqwkeFtIWtOIkj8tSygqA7rSBi87d3dN5DLV42HkrGAqOREiXv/qtvvxD0HWBKeg
	 Ji+W6N6Tcp1Qf3IpmqOlvU6G2qvcDUWPRAh1+1uI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 221/346] tsnep: Fix XDP_RING_NEED_WAKEUP for empty fill ring
Date: Mon, 29 Jan 2024 09:04:12 -0800
Message-ID: <20240129170022.883506995@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gerhard Engleder <gerhard@engleder-embedded.com>

[ Upstream commit 9a91c05f4bd6f6bdd6b8f90445e0da92e3ac956c ]

The fill ring of the XDP socket may contain not enough buffers to
completey fill the RX queue during socket creation. In this case the
flag XDP_RING_NEED_WAKEUP is not set as this flag is only set if the RX
queue is not completely filled during polling.

Set XDP_RING_NEED_WAKEUP flag also if RX queue is not completely filled
during XDP socket creation.

Fixes: 3fc2333933fd ("tsnep: Add XDP socket zero-copy RX support")
Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 456e0336f3f6..9aeff2b37a61 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -1762,6 +1762,19 @@ static void tsnep_rx_reopen_xsk(struct tsnep_rx *rx)
 			allocated--;
 		}
 	}
+
+	/* set need wakeup flag immediately if ring is not filled completely,
+	 * first polling would be too late as need wakeup signalisation would
+	 * be delayed for an indefinite time
+	 */
+	if (xsk_uses_need_wakeup(rx->xsk_pool)) {
+		int desc_available = tsnep_rx_desc_available(rx);
+
+		if (desc_available)
+			xsk_set_rx_need_wakeup(rx->xsk_pool);
+		else
+			xsk_clear_rx_need_wakeup(rx->xsk_pool);
+	}
 }
 
 static bool tsnep_pending(struct tsnep_queue *queue)
-- 
2.43.0




