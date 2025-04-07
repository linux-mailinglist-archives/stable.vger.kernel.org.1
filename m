Return-Path: <stable+bounces-128644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D88FAA7EA47
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E3A3BFDF1
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD92F25D53A;
	Mon,  7 Apr 2025 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E29q/BNd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6518D25D52E;
	Mon,  7 Apr 2025 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049573; cv=none; b=k5f1gyVCplJMsFzATtFnIF6KZKOQA4HVe4mZKRHcaoUQ/xyVh0ZPIoceK7FBhNdEfogPo5imGGz82sRajXEegz8TmFxAtMbvIRjRTUNJAKH+zGdumIixJY1TC+3yHVPy+V9z4SBtTeBt0fK1GYr3oUmhQkFI0abwJPM6HBPZ/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049573; c=relaxed/simple;
	bh=ippgrXsqyDk3dUu61tN7ZaEf1whrsfy0bG9nMnm5cVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XrjS+PhJrmVwDbKvYt9h2vTBNn7Sqbuk6FEheYva3brY1FbBU/cOuZfBO1RPqp1do3/NBfidJcRZIt8YqXjGDgHmttviuNkYh7idegQlOr/HoAixa6DbhiIlXeVwbVp+6LgcQ+BE6Dr7uoQFVDZPzmPMnyRmbAjGlhF6IgMjnSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E29q/BNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE71C4CEEA;
	Mon,  7 Apr 2025 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049573;
	bh=ippgrXsqyDk3dUu61tN7ZaEf1whrsfy0bG9nMnm5cVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E29q/BNdWsg4zgYoBM5h6W7yYMF3TlBmE+du5G3k9umQZS6qKf33AS58MHPcOyJHe
	 JatC+eRuilBdR6kwL2sXP7FEn7CVahoRQ9vfFgh1Y2h2h5AsSPHZHqw7quduKe7TLd
	 YNli9gwFJ6RlrS+n040Z1OdaH1PKm4MPDByIhH6jbCQZCln4V+vMhv0age4yidCt8H
	 pRLrCDxyQ1G8coYKUS5dZaR6+l3/1G4ieznJqgtusk2dCwu+xnfzLz8JxljUmgZV25
	 pSJ5BZ0I2dmfOcHobVM+RZKazBfvEbVu+ubheRcQ3fnxBx/Oa1BVJIqlicmEeCoQ67
	 eICiqpOIg8xow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 15/28] usb: xhci: Avoid Stop Endpoint retry loop if the endpoint seems Running
Date: Mon,  7 Apr 2025 14:12:05 -0400
Message-Id: <20250407181224.3180941-15-sashal@kernel.org>
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
index a77d8e4977223..453d755601a8b 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1197,16 +1197,19 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
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


