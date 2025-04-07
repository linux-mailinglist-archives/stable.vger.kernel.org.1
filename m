Return-Path: <stable+bounces-128610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EFDA7EBFA
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 21:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9DE446C1A
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C9E2561A8;
	Mon,  7 Apr 2025 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OronrtRV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99822561A6;
	Mon,  7 Apr 2025 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049491; cv=none; b=OA+1Q7+oRyXvN9+eCyEoo1ZihSUXSqT+q9Jz8Eg8mZU64hDQ8NgJ4bsxyOVyL3mf3PX3ZAchNALSPX/n/fBcOeMiRZgK6x2LOwLP17WTeMH8AEBxW1OxAtkK/J6hyQJBr9TWoe/9G7/o0mhwLxsRe+zABMYcf7h9QLEuB3CEo+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049491; c=relaxed/simple;
	bh=vImFDlR8xdmIIxfCoScDB3r2PkO8QPmRlF6vkGAIrvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YTxJhBHkHpSjXmgG/9cNJfA/4U8PsUX3Zni6I1vB5GEbEwByKYEdPlsxefyFL/E/gS2mmWGApXZuWetey4Kj3DlsbsmXC+Hkqdwu1JoY9YT2w9IxB8vsXnqMPUKzcRPT0puRcKnWqJdE+/ud/aBAg2KCEJTIKy/e+RopNbv1zAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OronrtRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2122AC4CEEE;
	Mon,  7 Apr 2025 18:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049491;
	bh=vImFDlR8xdmIIxfCoScDB3r2PkO8QPmRlF6vkGAIrvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OronrtRVKCdFo3tIexDVE2R08UFrRnxTIvi2qKR952r3cv9PQD8oNNzJS2IB/KWkN
	 lDzfrmLgoOM9A9n64IHmWgRwXNR/6j96TLJLeu9IUd7nZLgYm5e2Zya0iEeMeIiKmu
	 ci+A23WgM4SRKu1xYEj9cOLKsdOyCrXn77zcXYvGsilw2ueRYciQiWSDSb0HjsmZ0c
	 eD2lT1CUaPA7mMp/Z4lhjSmibqsKUtZgWljwwvSSE4/veStSPLVb29CYB978DGOK5N
	 8jRQQYHlDB69GfyqV+eGdBEfHqA7yhM74cuhVZCAaccXJrJ7zBPM3Esva5cIEfh4mx
	 QS+iFA+DduduA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 13/31] usb: xhci: Complete 'error mid TD' transfers when handling Missed Service
Date: Mon,  7 Apr 2025 14:10:29 -0400
Message-Id: <20250407181054.3177479-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
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
index 965bffce301e2..af6c4c4cbe1cc 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2789,7 +2789,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		xhci_dbg(xhci,
 			 "Miss service interval error for slot %u ep %u, set skip flag\n",
 			 slot_id, ep_index);
-		return 0;
+		break;
 	case COMP_NO_PING_RESPONSE_ERROR:
 		ep->skip = true;
 		xhci_dbg(xhci,
@@ -2837,6 +2837,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
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


