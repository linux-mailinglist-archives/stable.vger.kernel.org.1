Return-Path: <stable+bounces-249511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIgAM+MzDGrdZAUAu9opvQ
	(envelope-from <stable+bounces-249511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:56:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D913F57BB75
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40E653012C6D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4403FAE1D;
	Tue, 19 May 2026 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/kSDcW4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949CD39659E
	for <stable@vger.kernel.org>; Tue, 19 May 2026 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183442; cv=none; b=DsIQkumI7D0u8YCxbaoEwGc3iGhNgylknizA69DJjKwS7lmD4jjJk65OFamT5v58VCcYbrkCnb01fsbETo7LQUoV/xqedRZy51vxdXv8aB2OmFUC2yf/BiFxCGnLFDskCpGiIlkkGW7YR9fqYptLwOGCT+r8ZYXwmNiCvUXNPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183442; c=relaxed/simple;
	bh=EMFQpsk30BMRi0bLZuZU/W6xXRMwgyEz2GZEs2uL07A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaV/REDv2De7H9rG2+Sa60AYHzN+fCVCYUnBVw6qj4p3ArepFZKRtisnZ1mR1Y7ct0fbnwmpmM53bojwncw60lQfEN+aM/2XmCmA9jytDEzKUwZiXGmokTfpt51FxEEJWLK4SairAd3N1jodKEZTCtTRMxsVwXnVvBITZnBSKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/kSDcW4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779183442; x=1810719442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EMFQpsk30BMRi0bLZuZU/W6xXRMwgyEz2GZEs2uL07A=;
  b=a/kSDcW4MyXTlGgKypyI8RkAw5Tt5CB1qp57Pj5zFY6/5vBoEBaJfrEp
   1GR+0YhukdVeLmVkeasq5qQgqHkV1mzTdUoLfDsnM2/rEwH3uLOpGH/dI
   eAnyjgB81C7xc/Dr9jWuKSEVJG9aMfYOkrrhgUQDVv4CcJtdBVOhanD0z
   uFjrQP51V0VHpgGSX5M+/oulWZ4WzCVpmps3dOiVk4e8A167A70skCo8F
   dBM3BG/Rz0MSLjs40MpNEe9lNLQ93nfr/z4rjHuTFhYEgqcQS5LyMeQpC
   J6fPKipDz7Nr1yxE8kyme/nMRs44lDcJMdm1Q7md1smZ6OF6MOmue7muP
   w==;
X-CSE-ConnectionGUID: YgQW2y92Q3O4nwAsf7a/ew==
X-CSE-MsgGUID: 7+Q/yag9QzeEzp/YqtIwrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="83912908"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="83912908"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:37:21 -0700
X-CSE-ConnectionGUID: FL9hIjasS1WioCzvh6IwhA==
X-CSE-MsgGUID: CVJ/0aKkSEK+yr7A0nlztw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="241551550"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:37:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Xifer <xiferdev@gmail.com>,
	jodeliukas@gmail.com,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH 05/10] m68k/PCI: Remove unnecessary second application of align
Date: Tue, 19 May 2026 12:36:28 +0300
Message-ID: <20260519093633.16395-6-ilpo.jarvinen@linux.intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[leemhuis.info,gmail.com,linux.intel.com,google.com,linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249511-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,intel.com:dkim,msgid.link:url,linux.intel.com:mid]
X-Rspamd-Queue-Id: D913F57BB75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 4dd6e1aa35dcf616805eaf330bd731fd8f0da6d1 upstream.

Aligning res->start by align inside pcibios_align_resource() is unnecessary
because caller of pcibios_align_resource() is __find_resource_space() that
aligns res->start with align before calling pcibios_align_resource().

Aligning by align in case of IORESOURCE_IO && start & 0x300 cannot ever
result in changing start either because 0x300 bits would have not survived
the earlier alignment if align was large enough to have an impact.

Thus, remove the duplicated aligning from pcibios_align_resource().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Greg Ungerer <gerg@linux-m68k.org>
Link: https://patch.msgid.link/20260324165633.4583-6-ilpo.jarvinen@linux.intel.com
---
 arch/m68k/kernel/pcibios.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
index 1415f6e4e5ce..7e286ee1976b 100644
--- a/arch/m68k/kernel/pcibios.c
+++ b/arch/m68k/kernel/pcibios.c
@@ -36,8 +36,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	if ((res->flags & IORESOURCE_IO) && (start & 0x300))
 		start = (start + 0x3ff) & ~0x3ff;
 
-	start = (start + align - 1) & ~(align - 1);
-
 	return start;
 }
 
-- 
2.47.3


