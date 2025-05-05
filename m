Return-Path: <stable+bounces-141380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2E7AAB6C9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021F91C22D54
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DCC339569;
	Tue,  6 May 2025 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKEU2hEa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBEE3754C9;
	Mon,  5 May 2025 22:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485963; cv=none; b=d+BN6Md4AVFg4FrR6TBJZ2IdJMt3FWtld5+ius8lBV21ECCzislyyFIBWjKG8Y1flaY7CryqMXMDK5BQzEXTDXTnOAhfwjiSxN8ofNJdVDzLP4hZbg6U5w4Tx0FuPl7Sn4Z1F2w9sgAzVLRgKs/Q8fy4hQPa/BvWh1lI3RX94is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485963; c=relaxed/simple;
	bh=3XBLW0df5ozYwym4QZGDLk68vugvH6vNuS8z03Nn780=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F+BGQhzXpPptmO9L7lCOX6EeDaDajXqi0b5bCZ9h+/qRPfwl1RT0NGvcydsLcLgbyC1ryPTgDaM+FmppNALm74n6vW3OIiPqnxAy4QenO8wSEOzOOQdXQTl0/lHuJN99QfLxjsQPQXFr9N1ISzvOazKsAzZFPnuChzrpFyETqBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKEU2hEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74563C4CEE4;
	Mon,  5 May 2025 22:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485962;
	bh=3XBLW0df5ozYwym4QZGDLk68vugvH6vNuS8z03Nn780=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BKEU2hEaBVQtsEAoIXzh0/hJVknMMGLyqVSLpxmKaLVjJ+J1bm9WZ6Mmze1t9OxES
	 YJKuLI7RKAmNf+AKpDC6PtsZF57z2HVnAYEpW/TtXzZC/AUUkpuZa00XTA6vSrdSpf
	 8lJMsePIRnpob7TGdM7zc3jLTTc06+/246SCtr8/5yZRrolLbqJNnFSh0rPTd54BKO
	 t55exyLE1s5Ko9TxVs/IWEOHd6x7ExF9AEStvxI6pf+Dae4Q1ZcBQOXgd8FnnGVFyz
	 TWa8QV8NsDSOdUaq0HXYYZZZP7b6uvLCF7q+Sm4nww/CHfFpNYN5m76FqPozw6cF7X
	 bclNIpu88vSfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 088/294] usb: xhci: Don't change the status of stalled TDs on failed Stop EP
Date: Mon,  5 May 2025 18:53:08 -0400
Message-Id: <20250505225634.2688578-88-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index cb94439629451..54f068cc75343 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1180,7 +1180,14 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
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
@@ -1191,8 +1198,11 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
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


