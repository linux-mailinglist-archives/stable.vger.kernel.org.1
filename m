Return-Path: <stable+bounces-26789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D04871FF7
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 14:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E8228132D
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAADC85959;
	Tue,  5 Mar 2024 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AwM//288"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBEF5A7A4;
	Tue,  5 Mar 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644897; cv=none; b=P8X5vKYn19VdnfVV5QZ6KQqjeB98ZyCZdLDVIRuhuKFxEJEyOfSbhsBNOO6FKm+JECqO4H7hvb3rH8lEHTjK1rwbPySvl0xmV111Gs89/glnzfhO2dAnRe6PGD7ipDMFgx1zFzo+CGcaCxvNUDIz64J6T4I35STWlLnKrOyZ6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644897; c=relaxed/simple;
	bh=qDpjpYkw5UPpZoJDM2L88WFpRkuHhrtmTOYFPMCQDIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cVdeQk0d6bG2NREY5YIOiMoMkEeaL1A/bIl4vHDXC5akttkZivVlwplTueskUdbNu0OUJ5MDMkDhwaVmm/X3GAhubyYeEHnYbJIvVpPT4lSqkp4E4TDunDmCDWSjEmiPfH3tqvg9K4PbPwmNkPL0oSpXpVZs0kYaX2Zd9r1luRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AwM//288; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709644896; x=1741180896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qDpjpYkw5UPpZoJDM2L88WFpRkuHhrtmTOYFPMCQDIA=;
  b=AwM//288HFq8mtq3ULbd3WD+Tbh5QsBY4kLkaM7EumTsgfSYFMo4DcRX
   A5UsGDPC9/PqRTcrQ4nKk9R0GMs9mui/hU4jLivPulqxFt1RcfSYV8Bfa
   1brB3N9ioeGTKvb7kQdBPKuTV/c82mQbLaO5aUaTV04htD0Ls87DqazsL
   fYlwH0oJvINSDXxALYpgHUi1gNktWUguL+GyV+GS+g71/5qKWlj/A+Nad
   jmkDuVVyO9LBYmu2feXJ1Wl8/71Ywbh0B19Hv/180ORCxFZuFGRFA0pwJ
   2pTNLbU3iqj/SjJghNUg/EBbKuC004mjYfUXI2Ps74fzGyiOtUOVPCd7A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4357347"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4357347"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 05:21:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937042311"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="937042311"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2024 05:21:33 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Chris Yokum <linux-usb@mail.totalphase.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] xhci: Fix failure to detect ring expansion need.
Date: Tue,  5 Mar 2024 15:23:12 +0200
Message-Id: <20240305132312.955171-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240305132312.955171-1-mathias.nyman@linux.intel.com>
References: <20240305132312.955171-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ring expansion checker may incorrectly assume a completely full ring
is empty, missing the need for expansion.

This is due to a special empty ring case where the dequeue ends up
ahead of the enqueue pointer. This is seen when enqueued TRBs fill up
exactly a segment, with enqueue then pointing to the end link TRB.
Once those TRBs are handled the dequeue pointer will follow the link
TRB and end up pointing to the first entry on the next segment, past
the enqueue.

This same enqueue - dequeue condition can be true if a ring is full,
with enqueue ending on that last link TRB before the dequeue pointer
on the next segment.

This can be seen when queuing several ~510 small URBs via usbfs in
one go before a single one is handled (i.e. dequeue not moved from first
entry in segment).

Expand the ring already when enqueue reaches the link TRB before the
dequeue segment, instead of expanding it when enqueue moves into the
dequeue segment.

Reported-by: Chris Yokum <linux-usb@mail.totalphase.com>
Closes: https://lore.kernel.org/all/949223224.833962.1709339266739.JavaMail.zimbra@totalphase.com
Tested-by: Chris Yokum <linux-usb@mail.totalphase.com>
Fixes: f5af638f0609 ("xhci: Fix transfer ring expansion size calculation")
Cc: stable@vger.kernel.org # v6.5+
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index f0d8a607ff21..4f64b814d4aa 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -326,7 +326,13 @@ static unsigned int xhci_ring_expansion_needed(struct xhci_hcd *xhci, struct xhc
 	/* how many trbs will be queued past the enqueue segment? */
 	trbs_past_seg = enq_used + num_trbs - (TRBS_PER_SEGMENT - 1);
 
-	if (trbs_past_seg <= 0)
+	/*
+	 * Consider expanding the ring already if num_trbs fills the current
+	 * segment (i.e. trbs_past_seg == 0), not only when num_trbs goes into
+	 * the next segment. Avoids confusing full ring with special empty ring
+	 * case below
+	 */
+	if (trbs_past_seg < 0)
 		return 0;
 
 	/* Empty ring special case, enqueue stuck on link trb while dequeue advanced */
-- 
2.25.1


