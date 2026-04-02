Return-Path: <stable+bounces-233015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIZDES5tzmmpngYAu9opvQ
	(envelope-from <stable+bounces-233015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:20:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D54389924
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 764533044D05
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDEE311968;
	Thu,  2 Apr 2026 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="geidmGZx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762AA2E2DF3;
	Thu,  2 Apr 2026 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135875; cv=none; b=AS8zFZriKR2+lfsOjyKNjRpzMHkyWns090Fu0IqTT2jjAct0wDu7JAOy3QtmhbOP1rp7+IVNh5AafFUNSIBGIhE/kFkq/d5VQYB9x8xndBB7zz8VpdMSpF3rsplk6x6Of0LUinvRGXMIXAHR5qcnNT9Rw2LykIB/zY/+ZVmbogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135875; c=relaxed/simple;
	bh=W/ix3oBvnd3Zk0kkrCxkU6t2rR/tTDor0IDokLQIy1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVxGrGpTyTKIjTC6+2+19Y5lXuJ8TZKnS+ux+W1JoR2qR3Zoju3iIWcbOHi3kR0+2G0cPV5j5YMlpDKwGRk6UmkChZwEUWvChYbypLFx3ZeZACOOLHlS61Gv0+pHY2mz+1Mc05NlFBlEtWw+wK3fMxaC2xHmT7GE67H/AgBQi+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=geidmGZx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775135875; x=1806671875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W/ix3oBvnd3Zk0kkrCxkU6t2rR/tTDor0IDokLQIy1c=;
  b=geidmGZxUwK1AFV8hFSDlZRQb51mL5vYYA0gZm2VYvcdh6+eXQqcV4so
   arkFikUD3v/D6cUDw9gtfx2ay9uLnjy5cB2kHM/vRwBxE+EhvrYnV+lHp
   8DkYMBb8i/sSQIqUitasaKXJNotCJha9eRZmlnFfkEsLaNVzq4NHE0NC6
   pGUUxMNiJ0fPPkp+tUCJm07DhSY2DBZaPW383wnY5YDC3Ysqz0q+nDwIj
   IMg4bBw9XIaxZibT3wkAGmNI0ReVN5xze01t/LebzEqfWDIh+cQ+Ed2vj
   btbnio0ZmIRoaK1siodH0NbN6O1hzSFOFr7AiyigE20yy5eqV2EgfPsIx
   w==;
X-CSE-ConnectionGUID: G4fp00/tRk2xoYgo5oLY+w==
X-CSE-MsgGUID: PS4V86XeQP6q+8oeRDx/Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="87650948"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="87650948"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 06:17:55 -0700
X-CSE-ConnectionGUID: Ge6LLmQQSG+U+v6bo6gv8A==
X-CSE-MsgGUID: ScbjQH1gR6uJSNYtFLghrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="227241601"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mnyman-desk.intel.com) ([10.245.245.50])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 06:17:53 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 25/25] usb: xhci: Make usb_host_endpoint.hcpriv survive endpoint_disable()
Date: Thu,  2 Apr 2026 16:13:42 +0300
Message-ID: <20260402131342.2628648-26-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402131342.2628648-1-mathias.nyman@linux.intel.com>
References: <20260402131342.2628648-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.intel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233015-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathias.nyman@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 48D54389924
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michal Pecio <michal.pecio@gmail.com>

xHCI hardware maintains its endpoint state between add_endpoint()
and drop_endpoint() calls followed by successful check_bandwidth().
So does the driver.

Core may call endpoint_disable() during xHCI endpoint life, so don't
clear host_ep->hcpriv then, because this breaks endpoint_reset().

If a driver calls usb_set_interface(), submits URBs which make host
sequence state non-zero and calls usb_clear_halt(), the device clears
its sequence state but xhci_endpoint_reset() bails out. The next URB
malfunctions: USB2 loses one packet, USB3 gets Transaction Error or
may not complete at all on some (buggy?) HCs from ASMedia and AMD.
This is triggered by uvcvideo on bulk video devices.

The code was copied from ehci_endpoint_disable() but it isn't needed
here - hcpriv should only be NULL on emulated root hub endpoints.
It might prevent resetting and inadvertently enabling a disabled and
dropped endpoint, but core shouldn't try to reset dropped endpoints.

Document xhci requirements regarding hcpriv. They are currently met.

Fixes: 18b74067ac78 ("xhci: Fix use-after-free regression in xhci clear hub TT implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 1 -
 include/linux/usb.h     | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6d27c471d4da..a54f5b57f205 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3292,7 +3292,6 @@ static void xhci_endpoint_disable(struct usb_hcd *hcd,
 		xhci_dbg(xhci, "endpoint disable with ep_state 0x%x\n",
 			 ep->ep_state);
 done:
-	host_ep->hcpriv = NULL;
 	spin_unlock_irqrestore(&xhci->lock, flags);
 }
 
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 04277af4bb9d..27e95eade121 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -54,7 +54,8 @@ struct ep_device;
  * @eusb2_isoc_ep_comp: eUSB2 isoc companion descriptor for this endpoint
  * @urb_list: urbs queued to this endpoint; maintained by usbcore
  * @hcpriv: for use by HCD; typically holds hardware dma queue head (QH)
- *	with one or more transfer descriptors (TDs) per urb
+ *	with one or more transfer descriptors (TDs) per urb; must be preserved
+ *	by core while BW is allocated for the endpoint
  * @ep_dev: ep_device for sysfs info
  * @extra: descriptors following this endpoint in the configuration
  * @extralen: how many bytes of "extra" are valid
-- 
2.43.0


