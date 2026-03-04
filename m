Return-Path: <stable+bounces-223148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLiBIxC0qGliwgAAu9opvQ
	(envelope-from <stable+bounces-223148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:37:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07484208B64
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B82BA302D0A4
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 22:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6049439B953;
	Wed,  4 Mar 2026 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcsfaZfV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC110388364;
	Wed,  4 Mar 2026 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663816; cv=none; b=AHkcbpOCnyCJj+pMhy6trbHEJ2+lFnFsvV/4uV2FUyELNfLw7tODZlAYlTvxMmEZQUfDVGRcfHjauya3r521zNLIlZ4qGNmAyx56yWiOBeqBM39J3LhIGmMt3Zzw18lWg+Gtq1Nss/miHDGGqrHUFAEsp9tABO60bI75TYTL4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663816; c=relaxed/simple;
	bh=zVfwVW1ZvEg1HDS0ueE8egZmHPncPRGRVbpUiU/gNj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aH+PvAhpqbavob2B+5icz6QVfG+7BxDzRzuiKY1ivf6GlXyCt0xZF1JwWJ9wZmDy1itSWYS51ZobqGSKFQH7Wz64L1gYeC1GseBZvvqTykwskOPiNTiW7TlrEeEI4khig1BoU4tWPM/pjV9e2e3U/OKdqWSVrfwWlqsM5Tma6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcsfaZfV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772663815; x=1804199815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zVfwVW1ZvEg1HDS0ueE8egZmHPncPRGRVbpUiU/gNj0=;
  b=EcsfaZfVvXj+bfLxixLpDW2VFdf8pXIVeu4W6hEd7vINkeZ3E2jsZ9KV
   DlOX+Bfly0d7AtgzRw7Ijs+fRq8yMs3FDGvpcczrSOny9lkDgdgpOiuuS
   E2xxRi1u1Nk+g6NifOtPk/PkUGKw/fFjWyGJjgwrmhuMQDSD5q6cKCD2n
   yIlizn18IusDprDTaEwnCzQvDNGlRmKwlBeYkHH+hm0/CMTR8wFDKYmR9
   BPh0VskfjUnSYOnuvDtRMGgGRFefQ3Z8jVHQj2yZ/fPJaHG0DXJ6VqdOU
   5ih1F0aykJZiaR5ImhNxvgBzFXTodFi+RSTo2jbetyB5i5CAZeQEhEjMI
   w==;
X-CSE-ConnectionGUID: 76iRKHNSRN6mLiDguWfacg==
X-CSE-MsgGUID: QhNzbZ3XTciQijqFsNY1oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="72938933"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="72938933"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 14:36:54 -0800
X-CSE-ConnectionGUID: nTbagU2rS/CHxXsJH9p9Ug==
X-CSE-MsgGUID: gf6cmxsxQqK9NrSJ0BfbuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="223148886"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO mnyman-desk.intel.com) ([10.245.245.180])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 14:36:53 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Zilin Guan <zilin@seu.edu.cn>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 1/3] usb: xhci: Fix memory leak in xhci_disable_slot()
Date: Thu,  5 Mar 2026 00:36:37 +0200
Message-ID: <20260304223639.3882398-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304223639.3882398-1-mathias.nyman@linux.intel.com>
References: <20260304223639.3882398-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 07484208B64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223148-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mathias.nyman@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.intel.com:mid,intel.com:dkim,intel.com:email,seu.edu.cn:email]
X-Rspamd-Action: no action

From: Zilin Guan <zilin@seu.edu.cn>

xhci_alloc_command() allocates a command structure and, when the
second argument is true, also allocates a completion structure.
Currently, the error handling path in xhci_disable_slot() only frees
the command structure using kfree(), causing the completion structure
to leak.

Use xhci_free_command() instead of kfree(). xhci_free_command() correctly
frees both the command structure and the associated completion structure.
Since the command structure is allocated with zero-initialization,
command->in_ctx is NULL and will not be erroneously freed by
xhci_free_command().

This bug was found using an experimental static analysis tool we are
developing. The tool is based on the LLVM framework and is specifically
designed to detect memory management issues. It is currently under
active development and not yet publicly available, but we plan to
open-source it after our research is published.

The bug was originally detected on v6.13-rc1 using our static analysis
tool, and we have verified that the issue persists in the latest mainline
kernel.

We performed build testing on x86_64 with allyesconfig using GCC=11.4.0.
Since triggering these error paths in xhci_disable_slot() requires specific
hardware conditions or abnormal state, we were unable to construct a test
case to reliably trigger these specific error paths at runtime.

Fixes: 7faac1953ed1 ("xhci: avoid race between disable slot command and host runtime suspend")
CC: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index c36ab323d68e..ef6d8662adec 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4146,7 +4146,7 @@ int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id)
 	if (state == 0xffffffff || (xhci->xhc_state & XHCI_STATE_DYING) ||
 			(xhci->xhc_state & XHCI_STATE_HALTED)) {
 		spin_unlock_irqrestore(&xhci->lock, flags);
-		kfree(command);
+		xhci_free_command(xhci, command);
 		return -ENODEV;
 	}
 
@@ -4154,7 +4154,7 @@ int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id)
 				slot_id);
 	if (ret) {
 		spin_unlock_irqrestore(&xhci->lock, flags);
-		kfree(command);
+		xhci_free_command(xhci, command);
 		return ret;
 	}
 	xhci_ring_cmd_db(xhci);
-- 
2.43.0


