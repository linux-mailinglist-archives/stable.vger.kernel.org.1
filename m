Return-Path: <stable+bounces-271810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id enz6JEPMR2rrfQAAu9opvQ
	(envelope-from <stable+bounces-271810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:50:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5F770399B
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:50:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=e5eUxjXY;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271810-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271810-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64E57307ADD0
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CE53E5EC6;
	Fri,  3 Jul 2026 14:40:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B15353A6B;
	Fri,  3 Jul 2026 14:40:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089653; cv=none; b=Ypjh0nvf5uJdgbhnrwtVBoBRKj7XCOVmd8XRYD3XVjKLF/8kJVAX76ehw4DOfOOlpZgMZVA34GOn63jEHoMAjbyffRwXF9dLBzbEqMBokmN12+wOxRFnF4aV0Ie/jspFIGWLWYYJO+zlG7Z8slRRQEnPxhLSuOj/SpkBIp7Jy9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089653; c=relaxed/simple;
	bh=xGlbHLIAIs3xWVITZ3Z94u6mufEY9EG6Sr3u7rhNc0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRTuH1KsvaugfFPLBtk960cl7m7fCqCnO2nh/QI2tfmWlbQnYvx8MHA2W1PL1wpSwWpOJPA7bfAzo2Xu0p7iAQYcOcwAwneRgggNfEkmD6ZoWcX2L3s9E/QKVh8sMHZWZWnsIwHhb84yC2Pp7RSBHdhm18foAAkt/VkTsrEw2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5eUxjXY; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783089648; x=1814625648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xGlbHLIAIs3xWVITZ3Z94u6mufEY9EG6Sr3u7rhNc0c=;
  b=e5eUxjXY4tG3sbKNbgP7JM6PCN+r76yMnRG48daRXBQQHcz8HrZAMIaC
   cdyH9kpHrPELDn/Eix5jOtzYc8OZMDp9rlIgzznTXYA9Pb+Z5RuzhIxwi
   wow/XpkvqU8FQHL6BEY6mgjazh7AfLUqrPWBN3p4XHJ8DqEq8gM+/0/M1
   CgKfoTVKMuI8NcpGGgFHfXKfWixqL/NNRNqKlvLlYmyRQzJfwVE7ehwdo
   p8lYbUJqBYfose9HASf0lJTbgl8gpr8tQHT1CjyOB8vkFsO9aHAXC8QgZ
   jeWZ6RkKpTaLKgtIK2PF39KrZflHYO24TxBUvAABqzqMB5+NOSQ1YLsXj
   Q==;
X-CSE-ConnectionGUID: n+9/atVDQNuHj6LbfkTO1w==
X-CSE-MsgGUID: HskfJgXPSGeM4VL57qfkwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="101388360"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="101388360"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 07:40:47 -0700
X-CSE-ConnectionGUID: +ohs6DX8S4O4vyH94cCl2A==
X-CSE-MsgGUID: bILxJkqjQeGLAU4F+uHHnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="252662613"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO mnyman-desk.intel.com) ([10.245.245.154])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 07:40:45 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Xu Rao <raoxu@uniontech.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 1/2] xhci: sideband: fix ring sg table pages leak
Date: Fri,  3 Jul 2026 17:40:32 +0300
Message-ID: <20260703144033.483286-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703144033.483286-1-mathias.nyman@linux.intel.com>
References: <20260703144033.483286-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271810-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:raoxu@uniontech.com,m:stable@vger.kernel.org,m:mathias.nyman@linux.intel.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mathias.nyman@linux.intel.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathias.nyman@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.intel.com:mid,linux.intel.com:from_mime,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E5F770399B

From: Xu Rao <raoxu@uniontech.com>

xhci_ring_to_sgtable() allocates a temporary pages array and
uses it to build the returned sg_table with
sg_alloc_table_from_pages().

The error paths free the pages array, but the success path
returns the sg_table without freeing it. This leaks the temporary
array every time a sideband client gets an endpoint or event ring
buffer.

Free the pages array after sg_alloc_table_from_pages() succeeds.
The returned sg_table has its own scatterlist entries and does not
depend on the temporary array after construction.

Fixes: de66754e9f80 ("xhci: sideband: add initial api to register a secondary interrupter entity")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-sideband.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index 23153e136d4b..a5deeee4d5dc 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -58,6 +58,8 @@ xhci_ring_to_sgtable(struct xhci_sideband *sb, struct xhci_ring *ring)
 	if (sg_alloc_table_from_pages(sgt, pages, n_pages, 0, sz, GFP_KERNEL))
 		goto err;
 
+	kvfree(pages);
+
 	/*
 	 * Save first segment dma address to sg dma_address field for the sideband
 	 * client to have access to the IOVA of the ring.
-- 
2.43.0


