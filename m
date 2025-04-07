Return-Path: <stable+bounces-128715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D36CA7EB16
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5FE3BB42C
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADA726A098;
	Mon,  7 Apr 2025 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+zx7Eyu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BBF26A08D;
	Mon,  7 Apr 2025 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049728; cv=none; b=lCAkloZgrOe7apua1G/zpeYMt5OI6oEGlomTbnRo/g0mYXBOy5Oioc2248mtUBHfdAgww4p5euS6RPiH5voDfP+bWQrQTm4D2kOVwExzhXK50p1H4aTTdg7OAv9oSMedpEEkLnV+YYcs5+b4RagHtAcLEub1yXBnOzZ5tsX1BSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049728; c=relaxed/simple;
	bh=dlAVSdPC3gdo0xSdD512JDODGKlgdZHRHSK77HcqrdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEjlHt5EUMlebPtPS7r1vy20VnDX7/+CO8o5Ioo/MNMJ02P0EJS7pc8WAqir2y7edAbUw83nzBQ907TZtpl5RRfRVA4QOSbpHKyXOe1SlBPBVI3RENeqhT1Q8dyoiaWbuvq/cpETNEe4R2EheggwWKadkkwyJMTWmKhJ6sWDZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+zx7Eyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C20C4CEE7;
	Mon,  7 Apr 2025 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049728;
	bh=dlAVSdPC3gdo0xSdD512JDODGKlgdZHRHSK77HcqrdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f+zx7EyuexnrrXtMYJPmHb79m761fYBmqswRoHO3fFwa7qy49ycGZzpUIMQ5bi2BE
	 6ouJmbrLw/JkCR2lfMXzyP9jg93TcEbr8z3D2wi7MrblXfX3EGG+js0DpVcBX8sk72
	 wumtZj6dUwL8nNFyrcY4tfmUAn3M2LeN1JVq45NFOIqpUq8ohymdgYFqFcCanwplHM
	 H5z/9sZQh+sHT1iDqtriPqWwoBMJutoWpAs7XbLBkQv0n0uYLKazhaqMYqe11q4gyV
	 Sd5yQGqWEOh6tdTrGldv2A3mFr3TsccauXj6f7rjxCltSwOef5napndnvz2jxiMrjN
	 lMSn0hfeB/Ohw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 6/8] usb: xhci: Avoid Stop Endpoint retry loop if the endpoint seems Running
Date: Mon,  7 Apr 2025 14:15:12 -0400
Message-Id: <20250407181516.3183864-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181516.3183864-1-sashal@kernel.org>
References: <20250407181516.3183864-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index 64bf50ea62a49..cd94b0a4e0211 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1183,16 +1183,19 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
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
 			if (!command)
-- 
2.39.5


