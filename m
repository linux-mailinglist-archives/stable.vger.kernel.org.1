Return-Path: <stable+bounces-180388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBFEB7FA2A
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BFF3B32B7
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED3333C765;
	Wed, 17 Sep 2025 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cziQ3/lO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC3B24A06A
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117301; cv=none; b=DGWRRCo+BBaXh9i/qq8YUDQ95XrJWwu7yG1gcl+FFYW/kJi0SPOU9XwDJmaVny9cGGQGBwoJNnflneaGRhd86mGAliUp6UMOczLPfqHrrXRaxhpQTxlF1BxXONpvKjGeSUlh+sM5eEdoyjILeMV/LbmIAaDSHWRjla/KBNPmId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117301; c=relaxed/simple;
	bh=+SutMvXOVkXoqHMjowP8BtNPk00o5OshkDL/g7qMKuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3gEtRriYTHwvfqT9dFNvYBqUAs32SAtLfQf9LdMJG5GsJY6tZiWu60F1QiBhRIXA4HZhVkhj7Z0/MS8VninOcqoGu5TmZCBw8crh2K6mPwodFrGtLquY4QtxLcHfK8qM4yHD9xMlBZeeUZZqnXXul8xcPW0wj3m3xcZ7YsuO/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cziQ3/lO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5B3C4CEF0;
	Wed, 17 Sep 2025 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758117301;
	bh=+SutMvXOVkXoqHMjowP8BtNPk00o5OshkDL/g7qMKuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cziQ3/lOJTinFIBqYBxWLuBjptHli65nRZGStBZvLoi7RNX19CVSp2pwQg8LW/Hww
	 YEzJrSHjso94yQ7lLktUHKB88m6FuTh/v4VRXXpNF+ZWbn4VjE/VWcO3/ioPaV0ZSA
	 nqPSYv6C9naogaPoP1H6ZGCzPYQxSuITKnEnmzg4oEb7DAlQModY7Atzeg35ctozdC
	 /2MahPRwxHuMCM0BOookVa8difNoUuDl/FH+AWMJe2SHqmGeu3ZSgQdZb4YrGnFsyF
	 BLEIDCoLcsABwCw5JPqPqkoGLnd3wHZTNKUVXqOqsI4NZhibLF3CFsVh6z9QyDfT7W
	 PPiPdKE3WYwiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] xhci: dbc: Fix full DbC transfer ring after several reconnects
Date: Wed, 17 Sep 2025 09:54:57 -0400
Message-ID: <20250917135457.565439-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917135457.565439-1-sashal@kernel.org>
References: <2025091739-chaste-kilometer-da82@gregkh>
 <20250917135457.565439-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit a5c98e8b1398534ae1feb6e95e2d3ee5215538ed ]

Pending requests will be flushed on disconnect, and the corresponding
TRBs will be turned into No-op TRBs, which are ignored by the xHC
controller once it starts processing the ring.

If the USB debug cable repeatedly disconnects before ring is started
then the ring will eventually be filled with No-op TRBs.
No new transfers can be queued when the ring is full, and driver will
print the following error message:

    "xhci_hcd 0000:00:14.0: failed to queue trbs"

This is a normal case for 'in' transfers where TRBs are always enqueued
in advance, ready to take on incoming data. If no data arrives, and
device is disconnected, then ring dequeue will remain at beginning of
the ring while enqueue points to first free TRB after last cancelled
No-op TRB.
s
Solve this by reinitializing the rings when the debug cable disconnects
and DbC is leaving the configured state.
Clear the whole ring buffer and set enqueue and dequeue to the beginning
of ring, and set cycle bit to its initial state.

Cc: stable@vger.kernel.org
Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250902105306.877476-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-dbgcap.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 0f921df7a09e4..764657070883c 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -447,6 +447,25 @@ static void xhci_dbc_ring_init(struct xhci_ring *ring)
 	xhci_initialize_ring_info(ring, 1);
 }
 
+static int xhci_dbc_reinit_ep_rings(struct xhci_dbc *dbc)
+{
+	struct xhci_ring *in_ring = dbc->eps[BULK_IN].ring;
+	struct xhci_ring *out_ring = dbc->eps[BULK_OUT].ring;
+
+	if (!in_ring || !out_ring || !dbc->ctx) {
+		dev_warn(dbc->dev, "Can't re-init unallocated endpoints\n");
+		return -ENODEV;
+	}
+
+	xhci_dbc_ring_init(in_ring);
+	xhci_dbc_ring_init(out_ring);
+
+	/* set ep context enqueue, dequeue, and cycle to initial values */
+	xhci_dbc_init_ep_contexts(dbc);
+
+	return 0;
+}
+
 static struct xhci_ring *
 xhci_dbc_ring_alloc(struct device *dev, enum xhci_ring_type type, gfp_t flags)
 {
@@ -871,7 +890,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			dev_info(dbc->dev, "DbC cable unplugged\n");
 			dbc->state = DS_ENABLED;
 			xhci_dbc_flush_requests(dbc);
-
+			xhci_dbc_reinit_ep_rings(dbc);
 			return EVT_DISC;
 		}
 
@@ -881,7 +900,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			writel(portsc, &dbc->regs->portsc);
 			dbc->state = DS_ENABLED;
 			xhci_dbc_flush_requests(dbc);
-
+			xhci_dbc_reinit_ep_rings(dbc);
 			return EVT_DISC;
 		}
 
-- 
2.51.0


