Return-Path: <stable+bounces-249513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNibAi8xDGrdZAUAu9opvQ
	(envelope-from <stable+bounces-249513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:45:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8663857B8BC
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BADDC30BE88B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EB440DFDE;
	Tue, 19 May 2026 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RR9jX1GF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B824611CA
	for <stable@vger.kernel.org>; Tue, 19 May 2026 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183458; cv=none; b=fYneFxMhkhuY49LO4BDsNFenrMieZB3+vV4bI+4fQko2jMzf+8T1HDQLeecKmhuNVGs3RqXowkfYdkRY1HhlscsNGsAld1bacpHZXYyrnGwyoCUZprN+RHFzbzAN1DrVDrMtH+nmqoRRJpe36w22NuC+I67lnE9ivTwpgATu1oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183458; c=relaxed/simple;
	bh=3JNGmrbtmpPVQmqv/WV57QXC7O22+ZCcSK5gVLRkh3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ia1ZcSsRz540t/qFyy3voweCZD9UhwvhUArbgrmHx5X2iJpWrPCKMYL1SZbHCmvoJaceQREQdoyr4gCMKQJqFNBrKh4H1W6G3forqdsErYQGgy11vsix7Nnad4P21QYV7JWFv2D18Gjdcb/6GHOQBwkWAoDLzGeoIlpvk3DQplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RR9jX1GF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779183457; x=1810719457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3JNGmrbtmpPVQmqv/WV57QXC7O22+ZCcSK5gVLRkh3U=;
  b=RR9jX1GFL9ePKYI4YuzhoVQBBXhSbWEw5By5fgUF4MIeQg5cxU1yzrE2
   ulOug1Mic0wSbovwEoB2t6ndD3itdBZXz0YpzY9JwKyPSnUBJhhF4ju1C
   Q7+dy2z5shrB1dbxf872cOP7AqUvnt1KClD4tHxLbgUOeXXzZ7EuEdrWA
   31dyCP2ZNK/chb3miR3wiAssAswTP3MQTa/f22JksIj7b0k+C47LD03bZ
   Na1QR2GmiWK90YaM99V8f00RArQdv1f3sismu7PjDySr7PBJyLjPY5vZ7
   UvvSfrMvonQaaulwpwpAGdYTq1TIYaXJxwpk5HACbS+RXkd62Scboi4pF
   g==;
X-CSE-ConnectionGUID: OwP9Qr2uQ42UrPlojSZV+Q==
X-CSE-MsgGUID: nhhE2tHTTUGm8jUw8T6TLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="83912924"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="83912924"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:37:36 -0700
X-CSE-ConnectionGUID: vke8+PtiRxORTqTzGJMBPg==
X-CSE-MsgGUID: HdwGyW2sShiHDbnWOgsbxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="241551581"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:37:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Xifer <xiferdev@gmail.com>,
	jodeliukas@gmail.com,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 07/10] parisc/PCI: Clean up align handling
Date: Tue, 19 May 2026 12:36:30 +0300
Message-ID: <20260519093633.16395-8-ilpo.jarvinen@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249513-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:dkim,msgid.link:url,linux.intel.com:mid]
X-Rspamd-Queue-Id: 8663857B8BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 38ec53e16fe51c427bd1c7ed50be2bcc3db4f01a upstream.

Caller of pcibios_align_resource() (__find_resource_space()) already aligns
the start address by 'alignment' so aligning is only necessary if align >
alignment.

Change also to use ALIGN() instead of open-coding.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20260324165633.4583-8-ilpo.jarvinen@linux.intel.com
---
 arch/parisc/kernel/pci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
index f99b20795d5a..f50be1a63c4c 100644
--- a/arch/parisc/kernel/pci.c
+++ b/arch/parisc/kernel/pci.c
@@ -8,6 +8,7 @@
  * Copyright (C) 1999-2001 Hewlett-Packard Company
  * Copyright (C) 1999-2001 Grant Grundler
  */
+#include <linux/align.h>
 #include <linux/eisa.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -200,7 +201,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t alignment)
 {
-	resource_size_t mask, align, start = res->start;
+	resource_size_t align, start = res->start;
 
 	DBG_RES("pcibios_align_resource(%s, (%p) [%lx,%lx]/%x, 0x%lx, 0x%lx)\n",
 		pci_name(((struct pci_dev *) data)),
@@ -209,11 +210,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 
 	/* If it's not IO, then it's gotta be MEM */
 	align = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
-
-	/* Align to largest of MIN or input size */
-	mask = max(alignment, align) - 1;
-	start += mask;
-	start &= ~mask;
+	if (align > alignment)
+		start = ALIGN(start, align);
 
 	return start;
 }
-- 
2.47.3


