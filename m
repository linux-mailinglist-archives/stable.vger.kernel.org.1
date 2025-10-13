Return-Path: <stable+bounces-185276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C454FBD5299
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C9C5566C1E
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC60630C612;
	Mon, 13 Oct 2025 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wyr1JOKO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DAF21D596;
	Mon, 13 Oct 2025 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369833; cv=none; b=VO/Wzg6zdCxa8/rHlVs5TWXdEsQVGZDZV2EHZ5naGA/jbZZT7oLkQ1sRblveRwGiu/fjYJczPA9q/I0CSOR0BW6Kzdn5v05hgNpRAJTKfl67fSqJnrfzN9F7Pk4aI9IPh6KcM3256HoC6QI/rxSt6vP2P2DoEkRSzOUNlSewr1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369833; c=relaxed/simple;
	bh=aISvUd5eMubMnuTUNXZRpsulJDAwNzFTO1J5wFRISlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwCHz5AvC7ZgW3LPBazRx54s8I7tPU6PR/HZre1/sR3FmHf3IvRTtpc5OUzw6U85tthStvNjpQEAoN2V+tDZKLUeGiRyscoVD0KjV58MBcu5ZTu/0mo9MZ2+i+ZMk1kZEpH8izvlwdvyojSxxPkiwYxKIQXtdD51ONl1+giLD0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wyr1JOKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1682C4CEE7;
	Mon, 13 Oct 2025 15:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760369833;
	bh=aISvUd5eMubMnuTUNXZRpsulJDAwNzFTO1J5wFRISlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wyr1JOKO4M4nZGxEmtdQHDemPCdpceMztGd+k1QF0VZXa9uw46NajtRjxFsO7/V2m
	 L6ZywPJ/JXWijUFqCJu0QoT4zkRPayHQiOhw4NeDjH9dpCU/WqYPAn0i1Qaia7kH3t
	 JI3TeXw1J/IBRBTImdJvrFjdVHohLxMwiAGx8+Vw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 385/563] Revert "usb: xhci: Avoid Stop Endpoint retry loop if the endpoint seems Running"
Date: Mon, 13 Oct 2025 16:44:06 +0200
Message-ID: <20251013144425.222103412@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Pecio <michal.pecio@gmail.com>

[ Upstream commit 08fa726e66039dfa80226dfa112931f60ad4c898 ]

This reverts commit 28a76fcc4c85dd39633fb96edb643c91820133e3.

No actual HW bugs are known where Endpoint Context shows Running state
but Stop Endpoint fails repeatedly with Context State Error and leaves
the endpoint state unchanged. Stop Endpoint retries on Running EPs have
been performed since early 2021 with no such issues reported so far.

Trying to handle this hypothetical case brings a more realistic danger:
if Stop Endpoint fails on an endpoint which hasn't yet started after a
doorbell ring and enough latency occurs before this completion event is
handled, the driver may time out and begin removing cancelled TDs from
a running endpoint, even though one more retry would stop it reliably.

Such high latency is rare but not impossible, and removing TDs from a
running endpoint can cause more damage than not giving back a cancelled
URB (which wasn't happening anyway). So err on the side of caution and
revert to the old policy of always retrying if the EP appears running.

[Remove stable tag as we are dealing with theoretical cases -Mathias]

Fixes: 28a76fcc4c85d ("usb: xhci: Avoid Stop Endpoint retry loop if the endpoint seems Running")
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250917210726.97100-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-ring.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 4f8f5aab109d0..6309200e93dc3 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1262,19 +1262,16 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 			 * Stopped state, but it will soon change to Running.
 			 *
 			 * Assume this bug on unexpected Stop Endpoint failures.
-			 * Keep retrying until the EP starts and stops again.
+			 * Keep retrying until the EP starts and stops again, on
+			 * chips where this is known to help. Wait for 100ms.
 			 */
+			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
+				break;
 			fallthrough;
 		case EP_STATE_RUNNING:
 			/* Race, HW handled stop ep cmd before ep was running */
 			xhci_dbg(xhci, "Stop ep completion ctx error, ctx_state %d\n",
 					GET_EP_CTX_STATE(ep_ctx));
-			/*
-			 * Don't retry forever if we guessed wrong or a defective HC never starts
-			 * the EP or says 'Running' but fails the command. We must give back TDs.
-			 */
-			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
-				break;
 
 			command = xhci_alloc_command(xhci, false, GFP_ATOMIC);
 			if (!command) {
-- 
2.51.0




