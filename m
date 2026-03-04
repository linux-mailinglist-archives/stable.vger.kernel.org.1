Return-Path: <stable+bounces-223149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFJZNBG0qGliwgAAu9opvQ
	(envelope-from <stable+bounces-223149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:37:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F120208B6C
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94293302BBF0
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 22:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C039A061;
	Wed,  4 Mar 2026 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5FXP7Gr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C35839A06F;
	Wed,  4 Mar 2026 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663818; cv=none; b=gPoV13dGyd3F4D1++EV7uJQb9IbSZecV7fOtLUgqDP9Fknwjg0Z48IX3IY4dm/tsbqxYC50tuQPvUB3EvN0oAy6bPL0oh6WRtnRxzpLkE4EpvjxM1vf20U9hDK8nS00qe1CaezD9ThuJQK6f/nrNxvcNDGnx5SUowvwfbvxEvHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663818; c=relaxed/simple;
	bh=p+sZSkpVhe969HNvFWRoJTOCLoD6fc4aCIrdjexb2Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7zJqs+itY5GZIPnGY5Phgyll/oc63xJ6qv0Lfb4VVvSKedSRKSqzlzFkxOiihbDNns5vB7gaWg4krPtgdDx/QTh5l4ZKhJi6Y8lBtTr17gNYsN+0B1IG6ebZjF7t0iQ8+Hw/51AXFRV5P/JuUakC8GJfPcJjrUj8Hr6KLjfpGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5FXP7Gr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772663816; x=1804199816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p+sZSkpVhe969HNvFWRoJTOCLoD6fc4aCIrdjexb2Ho=;
  b=c5FXP7GrrSqC+SveNoJtJrYJ6v/fMRCyKc1a2mgBVnp2ya4EmPkk3L/N
   tFYWxHJ7naCsNXxVQlR92YFQkcRias6FVxFDxyRNXF4FnEXkIKElEL6dL
   1nPbkHoniJzaZlFhJS9Unou9H8BJ85zDCtFARPXOtp369GmzhlEsR40Xu
   GwRXRmHMs0Qf1E2jIrB/yPluebjlk8hMG9ylXotVTZo5BzbYXoIsqQBM/
   BeFRFpQTllAWHuYUhfUSh+pc9AzC7eX6VdwMtp5ik4LCYHxDyRlB733R+
   bQMW79nL+FmpHjoj8FaizFVvjAhifR+pvy4HrRGNtljksjNNFRmURahoO
   g==;
X-CSE-ConnectionGUID: bECSKwRtReGDy/ESOO5bOQ==
X-CSE-MsgGUID: SnFhfuZnSxKni0SDL11Gzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="72938937"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="72938937"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 14:36:56 -0800
X-CSE-ConnectionGUID: 3vEP9JYrSJyN9KgU6mhuzA==
X-CSE-MsgGUID: FsSuXEc/S9Cktckh+7QK8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="223148890"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO mnyman-desk.intel.com) ([10.245.245.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 14:36:54 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Dayu Jiang <jiangdayu@xiaomi.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 2/3] usb: xhci: Prevent interrupt storm on host controller error (HCE)
Date: Thu,  5 Mar 2026 00:36:38 +0200
Message-ID: <20260304223639.3882398-3-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304223639.3882398-1-mathias.nyman@linux.intel.com>
References: <20260304223639.3882398-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7F120208B6C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-223149-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathias.nyman@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:email]
X-Rspamd-Action: no action

From: Dayu Jiang <jiangdayu@xiaomi.com>

The xHCI controller reports a Host Controller Error (HCE) in UAS Storage
Device plug/unplug scenarios on Android devices. HCE is checked in
xhci_irq() function and causes an interrupt storm (since the interrupt
isn’t cleared), leading to severe system-level faults.

When the xHC controller reports HCE in the interrupt handler, the driver
only logs a warning and assumes xHC activity will stop as stated in xHCI
specification. An interrupt storm does however continue on some hosts
even after HCE, and only ceases after manually disabling xHC interrupt
and stopping the controller by calling xhci_halt().

Add xhci_halt() to xhci_irq() function where STS_HCE status is checked,
mirroring the existing error handling pattern used for STS_FATAL errors.

This only fixes the interrupt storm. Proper HCE recovery requires resetting
and re-initializing the xHC.

CC: stable@vger.kernel.org
Signed-off-by: Dayu Jiang <jiangdayu@xiaomi.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 9315ba18310d..1cbefee3c4ca 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3195,6 +3195,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 
 	if (status & STS_HCE) {
 		xhci_warn(xhci, "WARNING: Host Controller Error\n");
+		xhci_halt(xhci);
 		goto out;
 	}
 
-- 
2.43.0


