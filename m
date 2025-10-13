Return-Path: <stable+bounces-185538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DB3BD6AD2
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A95404A9A
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0706F2F1FD7;
	Mon, 13 Oct 2025 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEjM3GAQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA48E258ED9;
	Mon, 13 Oct 2025 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396171; cv=none; b=NnoMOkhCaW0o20r8dfB4r/yQ7V7N2Z53Fm8qfWpDQ37Apyhe9Tltm8l5qvEyEVYkQb8JmZMtqjdWJAS/tT8g0TGpjBUgoqkBZCD1lceZHOPGMWyNCRQI2oOLYrQLo0hwtZLd3Hsb3Y2jpwYoWMoTgBxtDNqfTmeep1ZOmiJtHD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396171; c=relaxed/simple;
	bh=Cua3qviviuVa04rddf6GNGue7II0SECS9CuumQef0vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMkQStYVyT+pqEZYaR4uMsIKHJCULS+ZVr6fZL32vHChWTD0lIRhDwA1fz4ugoBeUZrHipbTVhUte6oPnHuhZQVWaZOvJPKAjfTzISPc5YPMKMWmefXRNAqeKCfcFvs3SxtXpZ8vEvJliv7DLlWpOdMgysHULAoeEpWeWOpG6M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEjM3GAQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760396170; x=1791932170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cua3qviviuVa04rddf6GNGue7II0SECS9CuumQef0vg=;
  b=XEjM3GAQoTgpcjze046JMLW+/cugPJrGtM77lXZS9nsmCWrnQ+twB7jM
   K/MGux4H9kClGBMXDLF0qX9MZvipkCbe+eW8p2BEnT/VbDCBH/1K8fu0C
   vVZiIN+hop0Pl8SJY20nJd5Nldl7MISja+sTOiw2CKtUbUHXfPBxTtwzm
   uxkp0owLEn94ml4ObZOjoCeB0qGD/CVH/+5cwu6zruVLEe8zC4uSqJWav
   BYnGVt5U2YJk7qBEtP2NAi+4IfF4ZrMNcORWTp0XP2wXZTXHlPqyJj6q9
   or7B7QoDu4xUXDmGsjKh1kGBcVS2cuqHNZoXOxH1YSHjiRnlVqU5rL/9s
   A==;
X-CSE-ConnectionGUID: rordwOiaQ7+45/ZYVK+wXg==
X-CSE-MsgGUID: ILfQH5tdRte5AxIjOWh+HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="66202525"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="66202525"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:56:05 -0700
X-CSE-ConnectionGUID: xapqbc9UQ7maa4p9kyROtA==
X-CSE-MsgGUID: iTIWXGe1Rd69Rx5RCdOJ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="185742308"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO mnyman-desk.home) ([10.245.244.60])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 15:56:04 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
Subject: [PATCH 2/3] xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races with stall event
Date: Tue, 14 Oct 2025 01:55:41 +0300
Message-ID: <20251013225542.504072-3-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013225542.504072-1-mathias.nyman@linux.intel.com>
References: <20251013225542.504072-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DbC may add 1024 bogus bytes to the beginneing of the receiving endpoint
if DbC hw triggers a STALL event before any Transfer Blocks (TRBs) for
incoming data are queued, but driver handles the event after it queued
the TRBs.

This is possible as xHCI DbC hardware may trigger spurious STALL transfer
events even if endpoint is empty. The STALL event contains a pointer
to the stalled TRB, and "remaining" untransferred data length.

As there are no TRBs queued yet the STALL event will just point to first
TRB position of the empty ring, with '0' bytes remaining untransferred.

DbC driver is polling for events, and may not handle the STALL event
before /dev/ttyDBC0 is opened and incoming data TRBs are queued.

The DbC event handler will now assume the first queued TRB (length 1024)
has stalled with '0' bytes remaining untransferred, and copies the data

This race situation can be practically mitigated by making sure the event
handler handles all pending transfer events when DbC reaches configured
state, and only then create dev/ttyDbC0, and start queueing transfers.
The event handler can this way detect the STALL events on empty rings
and discard them before any transfers are queued.

This does in practice solve the issue, but still leaves a small possible
gap for the race to trigger.
We still need a way to distinguish spurious STALLs on empty rings with '0'
bytes remaing, from actual STALL events with all bytes transmitted.

Cc: stable@vger.kernel.org
Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
Tested-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 63edf2d8f245..023a8ec6f305 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -892,7 +892,8 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			dev_info(dbc->dev, "DbC configured\n");
 			portsc = readl(&dbc->regs->portsc);
 			writel(portsc, &dbc->regs->portsc);
-			return EVT_GSER;
+			ret = EVT_GSER;
+			break;
 		}
 
 		return EVT_DONE;
@@ -954,7 +955,8 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			break;
 		case TRB_TYPE(TRB_TRANSFER):
 			dbc_handle_xfer_event(dbc, evt);
-			ret = EVT_XFER_DONE;
+			if (ret != EVT_GSER)
+				ret = EVT_XFER_DONE;
 			break;
 		default:
 			break;
-- 
2.43.0


