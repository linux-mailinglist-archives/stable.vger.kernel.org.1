Return-Path: <stable+bounces-128639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BDFA7EA2B
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4593BF574
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C56222171B;
	Mon,  7 Apr 2025 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUG3iYju"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3655B25B691;
	Mon,  7 Apr 2025 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049566; cv=none; b=RkjFVAVdfjIDYiL4DE/t+SwILBlcY36uk3GmRCp20fzaDc21UiTqUDTN5+pfh/m1xuaQ8G0xCTef6lz70dcK5EzZx/1EjF5m45PLNCVD/VXtp6RDtsIquwP3KcxRRIph9M0QzAM1/FlbmM1Ft7L8iW2D4NJJbfZuEuZN9HKkg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049566; c=relaxed/simple;
	bh=kPrdwgMN+RYVoBmG2xG/4h31sUoVwYV2Vp5uijqzFyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ECyPKdV2x33mNqaMWpPA1B/Pt/levErd2iH6Y4EvXvv5INzm36BCME5qNgEzi9yplf6ETBHVXIfB5VuCQGSus+82bB2nJlaKiNYI7eiJo1j1KkmPK+LaThicATUs1xt+X5+yX4H62esAlM7zsG+WsFU4lgJjupMuiwAWmoS/aBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUG3iYju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDCCC4CEDD;
	Mon,  7 Apr 2025 18:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049566;
	bh=kPrdwgMN+RYVoBmG2xG/4h31sUoVwYV2Vp5uijqzFyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUG3iYju9fDbmNq3XrWMbOFV1fvBFM7mRngjEmY2D7W1l4M2dxy7kV1sOiKkHhHlT
	 32UqIOoUOoh/FJ2OMSjMj7ApZuQKb1sw8ki+fdK+eYp/PP0SQeQ50MW7tdN7NBMyx1
	 kKLi7RIQcR0kXxbsayOEecul85QD35bqtpJp99RoLxFzqXq+WjyQYS36hgMShp4ioR
	 tndp/21lF6vl6U5HK9fwDn3xn/ChBlIi0wOsDLDja6M70hiPzlqZIJhoH6PnUSnzgI
	 s4iyAKxZLpiurCM5zDBDyYkm7sjdExEOnfukjk7hjfx48H5yCLAgtA0yUgD0yB4cFV
	 PGrNG6n2orqog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 10/28] usb: xhci: Complete 'error mid TD' transfers when handling Missed Service
Date: Mon,  7 Apr 2025 14:12:00 -0400
Message-Id: <20250407181224.3180941-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181224.3180941-1-sashal@kernel.org>
References: <20250407181224.3180941-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

[ Upstream commit bfa8459942822bdcc86f0e87f237c0723ae64948 ]

Missed Service Error after an error mid TD means that the failed TD has
already been passed by the xHC without acknowledgment of the final TRB,
a known hardware bug. So don't wait any more and give back the TD.

Reproduced on NEC uPD720200 under conditions of ludicrously bad USB link
quality, confirmed to behave as expected using dynamic debug.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250306144954.3507700-5-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index dfe1a676d487c..e24d0c7cead50 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2786,7 +2786,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		xhci_dbg(xhci,
 			 "Miss service interval error for slot %u ep %u, set skip flag\n",
 			 slot_id, ep_index);
-		return 0;
+		break;
 	case COMP_NO_PING_RESPONSE_ERROR:
 		ep->skip = true;
 		xhci_dbg(xhci,
@@ -2834,6 +2834,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		xhci_dequeue_td(xhci, td, ep_ring, td->status);
 	}
 
+	/* Missed TDs will be skipped on the next event */
+	if (trb_comp_code == COMP_MISSED_SERVICE_ERROR)
+		return 0;
+
 	if (list_empty(&ep_ring->td_list)) {
 		/*
 		 * Don't print wanings if ring is empty due to a stopped endpoint generating an
-- 
2.39.5


