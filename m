Return-Path: <stable+bounces-249510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOt7FlAvDGq0XwUAu9opvQ
	(envelope-from <stable+bounces-249510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:37:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A71857B66C
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07658300D4E1
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC6E39659E;
	Tue, 19 May 2026 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EoAlRcz8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CEB3E0254
	for <stable@vger.kernel.org>; Tue, 19 May 2026 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183434; cv=none; b=uJdLW+sz2+ck0rzCZ9bY7TXLuUlrgqjgL2an668O1YCitCScIUlMQaZLJV1SeDrZWg4Pp6qQ1wXSqSBADeiMwmFzbWIe63d2NADmlsUIJcXBvnu16hXyzvwKkSq49hP57ei5Ucdj/JjXpl2KnhzYKEDaG340JYYx7bWjiprDWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183434; c=relaxed/simple;
	bh=6tk9RavnCb1DB3F65XJEYlc+BAu1O4h0m0DMjVmSQwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMqF0kNmi+YrJ+WW1I8H2ZBZNza/UAhb51jAOA/plGCse7N3CFAzdFUspeUunAQbDBXyyknWrGm3Tncuv39y8WuYvMmMEUdVhW1YQmbi06HGC/dqI3GO9VzfSEaIl0e0w6+FEj9LbCSBjDT6ro4bWo71XBDwZYeDyCEwjegEVj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EoAlRcz8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779183434; x=1810719434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6tk9RavnCb1DB3F65XJEYlc+BAu1O4h0m0DMjVmSQwQ=;
  b=EoAlRcz8227C9inq+/ZbuBFEi3E3tBbT6hAFdZI4o4NsITe940CYCG2d
   70pUxjsVQV6ugzcIbuWTjls0PleKtdqh/ASd8V8+BjTqlGePX8qqLoNFk
   X5SuxtcsxACh+1ur7hlYHJlvCRMcmgnns65Y2TQad1e23benjPocgDzOt
   tu5ZcpIafvmZ8ytPT9YkY4+1kqL4xNwAtlAXzm4gmEv04/7urJzSZQitc
   ig4SPlhIqYcsDv3dysJUsAMS4Muhp9CKjVsVY5Z754XgKI0iwqx/v33nU
   0UxZU1EZqMviJPK5A4RhVTb01i2ur0c0MUlHv/kyPQTxhAjWcq0Xqr/ng
   g==;
X-CSE-ConnectionGUID: aBroCChyQ7+ptJ8oNCA6KA==
X-CSE-MsgGUID: FRQPtkF2Ra2eK2yGSlekOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="83912899"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="83912899"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:37:13 -0700
X-CSE-ConnectionGUID: 95kUlXLeR9CZYkArpEgwww==
X-CSE-MsgGUID: pOMomt7pSh2tL91N64ugsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="241551507"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:37:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Xifer <xiferdev@gmail.com>,
	jodeliukas@gmail.com,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 04/10] ARM/PCI: Remove unnecessary second application of align
Date: Tue, 19 May 2026 12:36:27 +0300
Message-ID: <20260519093633.16395-5-ilpo.jarvinen@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249510-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 5A71857B66C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 0734cb2412f5fdc06fac6c1e6f3046085a4fdf23 upstream.

Aligning res->start by align inside pcibios_align_resource() is unnecessary
because caller of pcibios_align_resource() is __find_resource_space() that
aligns res->start with align before calling pcibios_align_resource().

Aligning by align in case of IORESOURCE_IO && start & 0x300 cannot ever
result in changing start either because 0x300 bits would have not survived
the earlier alignment if align was large enough to have an impact.

Thus, remove the duplicated aligning from pcibios_align_resource().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20260324165633.4583-5-ilpo.jarvinen@linux.intel.com
---
 arch/arm/kernel/bios32.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 5b9b4fcd0e54..cedb83a85dd9 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -571,8 +571,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	if (res->flags & IORESOURCE_IO && start & 0x300)
 		start = (start + 0x3ff) & ~0x3ff;
 
-	start = (start + align - 1) & ~(align - 1);
-
 	host_bridge = pci_find_host_bridge(dev->bus);
 
 	if (host_bridge->align_resource)
-- 
2.47.3


