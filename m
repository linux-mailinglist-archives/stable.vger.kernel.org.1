Return-Path: <stable+bounces-249512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCtiBv8wDGpuZAUAu9opvQ
	(envelope-from <stable+bounces-249512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:44:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD1B57B84D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1352C30D8EB2
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FEE410D3E;
	Tue, 19 May 2026 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tg3ptR1l"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3153DFC62
	for <stable@vger.kernel.org>; Tue, 19 May 2026 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183450; cv=none; b=Rpe8icxMY11CSEBmHoxn4odfERs9dVlEnfJOHyfAl2rhuIOLfBbNM51vwWDyKDBgX/0DosndcWq5API+MxZeuzDuziIiChBDzPRiMYVh+mRlRlLQn8NRaLfDRRsHgzGl7LdHQdrsK7j4c41Hovdx88PgXEf8XrdY0DBxzlC76Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183450; c=relaxed/simple;
	bh=LgG46YNffY1fBwUJU49fMVUg/kvgA/sc0iEvvYDh53I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6hLPnVUYNA9It+TQmJtUN9Qj3xvMj67clEs7DF1No9RWQusoak7vqLrO0eiSwKWsACawEz0XyJb+072QEuAIigUVlpWteyMVHSCD9wqaf7OQr8v6SxQEFh6SMHJhrU3TcdPKNslbnQfRyITbzmIZkUXsiDFrGE5OElBhJ5ZyNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tg3ptR1l; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779183450; x=1810719450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LgG46YNffY1fBwUJU49fMVUg/kvgA/sc0iEvvYDh53I=;
  b=Tg3ptR1lc7bq74bWPQ3BsbVrQ27aiBkuoKDAOnUGKZCSrWmHWdoRTITz
   QCxXwzAqYL7W09mVZT/G6j+8nSULPDhkCQD/j/3Ci8zFwqIZfEtXGZjTt
   3+de49qJ2RySil5cQyPwaSRW77BLpA1FBjYPJgikxFL6tbOYBJA/70AWF
   UWAvvctOLmGtEFMbxXWP+jplrRKThEe4Op7IWBBugFrPXwdno90a64O5c
   xh8I6t+jN6PK318X9letXdxPFI4FuX78ra+xIft13MIKdjrnkwLcAWuOK
   pBWae89Afvg2IdrGeAkblFyL5dkr/f5g5joudib9+7d8477hPmIiODYYk
   w==;
X-CSE-ConnectionGUID: ZT1MC17BT3+fEHqoeOuD4A==
X-CSE-MsgGUID: OkfnnICMSGG/GryBbDCdhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="83912916"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="83912916"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:37:29 -0700
X-CSE-ConnectionGUID: tU5WAZktR+yFQ03iP3mhXw==
X-CSE-MsgGUID: n/DmBlx5TlmpwavkYtleig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="241551564"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:37:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Xifer <xiferdev@gmail.com>,
	jodeliukas@gmail.com,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 06/10] MIPS: PCI: Remove unnecessary second application of align
Date: Tue, 19 May 2026 12:36:29 +0300
Message-ID: <20260519093633.16395-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519093633.16395-1-ilpo.jarvinen@linux.intel.com>
References: <20260519093633.16395-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249512-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[leemhuis.info,gmail.com,linux.intel.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,msgid.link:url,linux.intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7AD1B57B84D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 3fa40d305ba185882479ee90ff71b9034622bf85 upstream.

Aligning res->start by align inside pcibios_align_resource() is unnecessary
because caller of pcibios_align_resource() is __find_resource_space() that
aligns res->start with align before calling pcibios_align_resource().

Aligning by align in case of IORESOURCE_IO && start & 0x300 cannot ever
result in changing start either because 0x300 bits would have not survived
the earlier alignment if align was large enough to have an impact.

Thus, remove the duplicated aligning from pcibios_align_resource().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20260324165633.4583-7-ilpo.jarvinen@linux.intel.com
---
 arch/mips/pci/pci-generic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
index f4957c26efc7..aaa1d6de8bef 100644
--- a/arch/mips/pci/pci-generic.c
+++ b/arch/mips/pci/pci-generic.c
@@ -32,8 +32,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	if (res->flags & IORESOURCE_IO && start & 0x300)
 		start = (start + 0x3ff) & ~0x3ff;
 
-	start = (start + align - 1) & ~(align - 1);
-
 	host_bridge = pci_find_host_bridge(dev->bus);
 
 	if (host_bridge->align_resource)
-- 
2.47.3


