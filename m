Return-Path: <stable+bounces-176983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2D8B3FD0B
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B4C18961A0
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2A72F5324;
	Tue,  2 Sep 2025 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+Y9uhxq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF092F5315;
	Tue,  2 Sep 2025 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810402; cv=none; b=qig50qHLlH3SPfajH6Dko+gedfJQ1r7XhbqVz36/viC6Dh2zLC+nrxbdXj19AYBKjwotAbEmjrXdUYD29DUcIcBsl1hJr80OIkUhqr/7mBt8QXrpjSiuPWb42k81F94SXry+0kQ8hZEaeEA8b69lfF3SkXz2uB0UwGYGWmyQYE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810402; c=relaxed/simple;
	bh=uAHxGn4/rHTrVBm7NBXS+g9pX3xfb9FmMbRVSxzG05E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAL+5oC5T2F6JmnvOnEe7svQdXt8dNYZdmNPWQqO5xwtCgPu2eXDUIOrR/ULH+Q5EBPgDQ/3qTy8ISDIaZyCUeUwQrfSSf7xuxWI8UngOnW7OqAJkGkTtvpCgYyek8Jqkw+a/YFAdigcKUZ8kYQaOg6hYKZRp+WrV7kBTYDkFiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+Y9uhxq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756810401; x=1788346401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uAHxGn4/rHTrVBm7NBXS+g9pX3xfb9FmMbRVSxzG05E=;
  b=m+Y9uhxqc2lZgeqAOLSu1ezOOyVWc1Hvfee3Vm2381oggLZCENc4YeDy
   F4P58rFqTXY525met8fLiZLM7mYftH944Vc/11RNMQJ5wOG/3CKNlASn9
   tRG4EEImn2UpHcrfzfbUe8n84g24fAupqEwV0H2OXL50uRRdXf3RBUKL5
   DkkD/sihGc8o1IGz+f3BGIFdHJDkqkm5sLkon0qIDuc+AFiEb1El5bTC9
   YYgNfRJNMTwOaQyIYfBtF8pNhD9TrWheQq3v7viKxaoSEyCGU8f4e51v8
   g2eCCyBhJlUjUqGk/NvOYLKtL6nKywM34f9rNZ9ex8Ewu3vvntEkkStlY
   Q==;
X-CSE-ConnectionGUID: vxHtLwYbSEKhWHFgz9BRGw==
X-CSE-MsgGUID: jUjNFP4USD6VhJdl/mnVlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="76678015"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="76678015"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 03:53:21 -0700
X-CSE-ConnectionGUID: kbGVSMwlSzOVhOvzKoxzag==
X-CSE-MsgGUID: nQsKODBWQV6gg80ng6e9gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171609569"
Received: from johunt-mobl9.ger.corp.intel.com (HELO mnyman-desk.intel.com) ([10.245.245.90])
  by fmviesa008.fm.intel.com with ESMTP; 02 Sep 2025 03:53:19 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] xhci: dbc: Fix full DbC transfer ring after several reconnects
Date: Tue,  2 Sep 2025 13:53:05 +0300
Message-ID: <20250902105306.877476-3-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250902105306.877476-1-mathias.nyman@linux.intel.com>
References: <20250902105306.877476-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/usb/host/xhci-dbgcap.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index d0faff233e3e..63edf2d8f245 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -462,6 +462,25 @@ static void xhci_dbc_ring_init(struct xhci_ring *ring)
 	xhci_initialize_ring_info(ring);
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
@@ -885,7 +904,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			dev_info(dbc->dev, "DbC cable unplugged\n");
 			dbc->state = DS_ENABLED;
 			xhci_dbc_flush_requests(dbc);
-
+			xhci_dbc_reinit_ep_rings(dbc);
 			return EVT_DISC;
 		}
 
@@ -895,7 +914,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			writel(portsc, &dbc->regs->portsc);
 			dbc->state = DS_ENABLED;
 			xhci_dbc_flush_requests(dbc);
-
+			xhci_dbc_reinit_ep_rings(dbc);
 			return EVT_DISC;
 		}
 
-- 
2.43.0


