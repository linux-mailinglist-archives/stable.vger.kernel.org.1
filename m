Return-Path: <stable+bounces-128702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C21FA7EAAE
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 805EA7A5C9C
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE1F268696;
	Mon,  7 Apr 2025 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFeO3wx4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0742E268691;
	Mon,  7 Apr 2025 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049703; cv=none; b=KOA+hiH5nO6kocP8522TZi2VUwsWjU6+hj8PKX6zU/7Mi/q+EYK2/OwjEmd7PukZM/I1h6eadcHrQRwMLYnRxynivisY2JcQ2ActH7uMOCi9oyVuTX03p/sjPeJwY7V4ioPrASU/xQrLXxi7doon2KMoYBPo90A2e/gWSqxPGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049703; c=relaxed/simple;
	bh=wNUDbfwJYQbd1Jat2or1zq3hWtSHa3bKhbg3eaj0StE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rI66c46ofbF5xcUfonEJz79Cuyvbldmpl+AAvIyix4jYMInD70hkCQXqxauzDmFPviY0FcL3ZHKo5NcR5tAgb5Rg77jFz6O4PnNL/NrZlY1l3LIpI6rDObE+xttEcPLfGNwXyuBRN+cmIVUmSzI+9m94tShuv8UgdwRirWqOPXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFeO3wx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8A7C4CEE7;
	Mon,  7 Apr 2025 18:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049702;
	bh=wNUDbfwJYQbd1Jat2or1zq3hWtSHa3bKhbg3eaj0StE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFeO3wx4nAUfO5Nq6IdMEN5SkIAb4MNkz3YZWq7oblAJYomnZQJ2IGP6S+kopVXf4
	 NHZCBzRNrSrOCVfz01uH0drVCTgMX+qYSswZ8AZ0XRxBFSvsU2a/KVY741Ymf9X5qs
	 ew5U03HIbVH4qgKmYROyq9dDAHc/onXl8gNM3PB9YDgaaOtrxDO5A0Cyzfqr+CZrge
	 qxvCu4mvl4Wzkl/Dfa1mcWCfzekN5Xb0YOf7Ymy5TWvoIrAiR6xm7uCIpVio6piCRk
	 ykIF+r6HLhKR8npXPE8f7+XzuGWMCo9xIJpVJeMO44n0XKUMiY6JF6IYCCjqiw7SQD
	 w/GhaEgJ0aOcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/13] usb: xhci: Avoid Stop Endpoint retry loop if the endpoint seems Running
Date: Mon,  7 Apr 2025 14:14:41 -0400
Message-Id: <20250407181449.3183687-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181449.3183687-1-sashal@kernel.org>
References: <20250407181449.3183687-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.133
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

[ Upstream commit 28a76fcc4c85dd39633fb96edb643c91820133e3 ]

Nothing prevents a broken HC from claiming that an endpoint is Running
and repeatedly rejecting Stop Endpoint with Context State Error.

Avoid infinite retries and give back cancelled TDs.

No such cases known so far, but HCs have bugs.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250311154551.4035726-4-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 85a2b3ca05075..0862fdd3e5682 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1175,16 +1175,19 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 			 * Stopped state, but it will soon change to Running.
 			 *
 			 * Assume this bug on unexpected Stop Endpoint failures.
-			 * Keep retrying until the EP starts and stops again, on
-			 * chips where this is known to help. Wait for 100ms.
+			 * Keep retrying until the EP starts and stops again.
 			 */
-			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
-				break;
 			fallthrough;
 		case EP_STATE_RUNNING:
 			/* Race, HW handled stop ep cmd before ep was running */
 			xhci_dbg(xhci, "Stop ep completion ctx error, ctx_state %d\n",
 					GET_EP_CTX_STATE(ep_ctx));
+			/*
+			 * Don't retry forever if we guessed wrong or a defective HC never starts
+			 * the EP or says 'Running' but fails the command. We must give back TDs.
+			 */
+			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
+				break;
 
 			command = xhci_alloc_command(xhci, false, GFP_ATOMIC);
 			if (!command) {
-- 
2.39.5


