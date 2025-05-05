Return-Path: <stable+bounces-140523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D47AAA99C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9512188EE93
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8502D165E;
	Mon,  5 May 2025 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdsrFeQM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F6029AAF4;
	Mon,  5 May 2025 22:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485050; cv=none; b=O9TfjDZJbQ543fcWkmkdlgkdcWrhsN7tyPkZM9GqlaozaGhWMHCYE6fN4/O3+wHKVAf9YvFiM3Z43Avjr3AsLQAZGpP+dCTAXl3JvvqPZc2dgDvNnrXFF3Db4ZKfzCodEUaB5INmc2oGtccMqGzHL8abEWnA9GWAfNyPc7IQVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485050; c=relaxed/simple;
	bh=a3QzQ1hg2SV2WrVAJY6TwiYvWvPfuFP+s0Y2RBN2kPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fujrG/KftZN7pjUy+JVH5Vg31E4lSii+FvofzEe+5v62UgSMMHgtlwaLQLLt3KreXXXNiX6sSXKyWjvyepY7W68vo7UTCAh16aUKM+SJFAxzvW2R4Dz+bwD7C9sQDoW0KcimzfYKo+E0E29TR6vSAMfmm6+ndvQohVKYTu0vRTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdsrFeQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE06C4CEED;
	Mon,  5 May 2025 22:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485050;
	bh=a3QzQ1hg2SV2WrVAJY6TwiYvWvPfuFP+s0Y2RBN2kPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gdsrFeQMsBS7n06mhbbuoFfDCpWDo8rfH+dQr91NCtsrB9oQ0czLg4ORdu4gzIdUz
	 cI6DdbwmjjAjLUb2TxlMLRs/tRMcbCj8xqgfMexuLXli5Mt/qnYIEI3P8zXdVZ/q6B
	 pDHfc35HeGa9mAv+ft4MMgyK1rsdHyEIe8mJivk1Vo9xJpEKlgzM2d+fY1ol4Xh2Z2
	 zdcm9NNPaOrAOnc3W5Poomr2dZxgDY5Nek5jm/nTyOMYKGqItUJlI/GQbUH8Ifvniq
	 urskdsXvk14+I7P6GxQGeFu0EsMyYV2S8UoxOyiqZHZH2wX2LiFWyzfT0JIqVntzNU
	 vW3cz23Mqntiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 142/486] usb: xhci: Don't change the status of stalled TDs on failed Stop EP
Date: Mon,  5 May 2025 18:33:38 -0400
Message-Id: <20250505223922.2682012-142-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 3e70e4f6bf083..fbc8419a54730 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1156,7 +1156,14 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
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
@@ -1167,8 +1174,11 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
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


