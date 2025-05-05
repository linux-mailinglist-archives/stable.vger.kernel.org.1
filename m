Return-Path: <stable+bounces-139923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C92AAA24A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197E7463045
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B69280A2B;
	Mon,  5 May 2025 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3HsDTT8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810AC2D9DB3;
	Mon,  5 May 2025 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483679; cv=none; b=YEtr9dO8j7KsA1ltCaE3r8HFDSCITPCmDL7cyb+sHO8QRqE8p80K/aMly72D27m5COEg/zuuleNds7vHxAS5HQeub41OGpITuqmu6XMCe0QkOOJ3V715zKUZTqvNviO8icEC88EYMwMZzjEA1BURMGFir03AfpLP1WyAeKwr2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483679; c=relaxed/simple;
	bh=b54dqsFumr5Yso7ZFZ6/cuPUwEVdYQ6xmWyqhUrhH4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=savis6svPN35joZ9ICXJkh+2FQ3fc6FkHy7cUuEmQna9P7nOWhJfqqvVubRCdKFx8Ydh0NVHPft/EJqRg90pvH+0aoqGyfPzdXLjtjfWcKP9FerlcAHpeiF1nMbiu6KZ2plNxGRAdhXxqjcR/u0mLKT80YHbXHUSIh0DnH/enlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3HsDTT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7955DC4CEE4;
	Mon,  5 May 2025 22:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483679;
	bh=b54dqsFumr5Yso7ZFZ6/cuPUwEVdYQ6xmWyqhUrhH4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3HsDTT8/1DYGMsXSvRSrMqOfxojs6GhE6TZnkEXBvg30n6MJpWuJTjt9bQX5TJ1J
	 d2ePWHbQOp+aEwmgEDKubG3zDqXPZSm7Ar4DoQ8BgyNTNvNfDfMQVdQXgkfefj0Qze
	 ptjnG2OdX1ssbvbjnTF+F7DSsnL4NVRv8ddieY1+tP5SKgcwjvMpZDwjIjcu4KHOKO
	 cVLn8xiJ8+HAYPZrsrQB89ps0bbQsMx6KkEmYR5OX5tdH/3H3j56BxLhCz2slYft4T
	 oNIYTqzvf5cj7iFTq78i+g05FTy5+bWdz0D+yKIHzkLJPTxBcekNOn6HGu0jtz1mZg
	 WrsbInIlpzp6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 176/642] usb: xhci: Don't change the status of stalled TDs on failed Stop EP
Date: Mon,  5 May 2025 18:06:32 -0400
Message-Id: <20250505221419.2672473-176-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

[ Upstream commit dfc88357b6b6356dadea06b2c0bc8041f5e11720 ]

When the device stalls an endpoint, current TD is assigned -EPIPE
status and Reset Endpoint is queued. If a Stop Endpoint is pending
at the time, it will run before Reset Endpoint and fail due to the
stall. Its handler will change TD's status to -EPROTO before Reset
Endpoint handler runs and initiates giveback.

Check if the stall has already been handled and don't try to do it
again. Since xhci_handle_halted_endpoint() performs this check too,
not overwriting td->status is the only difference.

I haven't seen this case yet, but I have seen a related one where
the xHC has already executed Reset Endpoint, EP Context state is
now Stopped and EP_HALTED is set. If the xHC took a bit longer to
execute Reset Endpoint, said case would become this one.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250311154551.4035726-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 5a0e361818c27..073b0acd8a742 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1164,7 +1164,14 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 	 */
 		switch (GET_EP_CTX_STATE(ep_ctx)) {
 		case EP_STATE_HALTED:
-			xhci_dbg(xhci, "Stop ep completion raced with stall, reset ep\n");
+			xhci_dbg(xhci, "Stop ep completion raced with stall\n");
+			/*
+			 * If the halt happened before Stop Endpoint failed, its transfer event
+			 * should have already been handled and Reset Endpoint should be pending.
+			 */
+			if (ep->ep_state & EP_HALTED)
+				goto reset_done;
+
 			if (ep->ep_state & EP_HAS_STREAMS) {
 				reset_type = EP_SOFT_RESET;
 			} else {
@@ -1175,8 +1182,11 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 			}
 			/* reset ep, reset handler cleans up cancelled tds */
 			err = xhci_handle_halted_endpoint(xhci, ep, td, reset_type);
+			xhci_dbg(xhci, "Stop ep completion resetting ep, status %d\n", err);
 			if (err)
 				break;
+reset_done:
+			/* Reset EP handler will clean up cancelled TDs */
 			ep->ep_state &= ~EP_STOP_CMD_PENDING;
 			return;
 		case EP_STATE_STOPPED:
-- 
2.39.5


