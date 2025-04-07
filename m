Return-Path: <stable+bounces-128670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58ABA7EA93
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34C14422B2
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859DB2638B0;
	Mon,  7 Apr 2025 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCXe4RJz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E643263899;
	Mon,  7 Apr 2025 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049634; cv=none; b=eNzKCMAwMX9IHwIDzSfgF8c3ux+RCmXkgG7OINX78pOwKRRRCLwJHg0UjsQnpLNSUrY9G3/ixgGTlOf9nA1DW9v+tzMYKGuvs1uWA5EVlxIEC+TizVdoizcHHIXjcZeNaz8PjmwTAZN35INHV3nQwOpJkDJXVUIghB3aTyHqmj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049634; c=relaxed/simple;
	bh=FndIuhZ/0fONktWpv2Ex8iquaYlWyiOug52Rxt6CBdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=myzbGXFOamEpJ2Qkx0qz35nIOjPi0DEEaenTFeonowZUqDiEweh189+21qQceTQ+/5IYfnQWMgclLxW5PJKDJbYSpnKLMBjkw8/gqGc9JcItT62ErfW9J6VxNt35Z43Hx5svBo+9QFkIUsYJuhTleUpU0Qa6427+WsnZCG++BfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCXe4RJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A53CC4CEEA;
	Mon,  7 Apr 2025 18:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049634;
	bh=FndIuhZ/0fONktWpv2Ex8iquaYlWyiOug52Rxt6CBdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GCXe4RJzHVTazADBnAKy+ttEfXgQF32t4GjJmLkpWtn1Fef3jWEqNk+h2hNXUHzkW
	 bYP/M/qcXXacIHqqu4fipL1Q7dxLG9tqUxBjprpRykFlxkBl/8umlCH5YXOP7EtUl5
	 vxHNO6+AwFDD44CjuttWheJvvwsl4hP/3YhCg8Zr9bhdYc6942DBA/B35j+TeLMOuH
	 3Boff/F8UtSdasLxfmRafUwJkN4RqH0lTHmUIt+x/alLCg6mz0c9WFPBLB73z8/ydW
	 Zd4xEW4f4D2odsnlwlBjq8t0soDkR7q5WZyQP4nf47Je5VcG9fTz3pWJzA1Oc4dpx8
	 vWQJXDn3mWPjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 12/22] usb: xhci: Avoid Stop Endpoint retry loop if the endpoint seems Running
Date: Mon,  7 Apr 2025 14:13:22 -0400
Message-Id: <20250407181333.3182622-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181333.3182622-1-sashal@kernel.org>
References: <20250407181333.3182622-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.22
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
index 30b5862f9667a..b5c4cf83eeb29 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1190,16 +1190,19 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
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


