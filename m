Return-Path: <stable+bounces-270009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nrwqJJrxQ2rPlwoAu9opvQ
	(envelope-from <stable+bounces-270009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 18:40:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 119986E68C2
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 18:40:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=Bkxv30rV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270009-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270009-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DBC13084530
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49FA3BF69A;
	Tue, 30 Jun 2026 16:36:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F93C1F4B;
	Tue, 30 Jun 2026 16:36:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837374; cv=none; b=vFqLH8TmNeV4HbdQHnfKqSfQ3bqBA1tcfCARU0F30iWf6JDvwZOvqBbBgKKqrzYFasLliAitMxlVGIfgtiK1N4V5u0mQ8EDUvsQUCpy/QOYjVdMieNBV6r98J1mdlrzuQwvnEYVXFlUrJZJyJ6I0GpZwqssmI6iB+2+75eG9sYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837374; c=relaxed/simple;
	bh=jSXtZwX8wGU6A+SLoLUWb62qvHYm1mFhWzV/Usjn5b0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PFr/vUqaR8N0vqLc1talFFZWnKiKSO7lQed30CJKSXKBCMtN067OCmAfsGOUlbZQTTYRo+lIX5q0E4+gq8IPy3rCWHdObwxQRLSk4EUuiHFxVJ5Sz516A28MAxaWk98iC+AmYhxbQUjNe4b4Y2Fyr+Gun2Oxyrz+lwMvbTSHslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Bkxv30rV; arc=none smtp.client-ip=52.42.203.116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1782837371; x=1814373371;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=obB6GcD3XGCFaFF5qXegeE2H89/URxhWi0kvTbP7Weo=;
  b=Bkxv30rVl2UkBWq8uenDtz/RlP5+NhJWivXUQTvnDJsnemgTXoAMia+Z
   iTWGNcfkWK5xWEDKtMnsugV389a0BAFIMzrQXCsAQc/GMSSkoYiYbpY4W
   Ehn6G/IkuiVYQEsubSko0zGu+jBP4BEOiQtSqq1oyiR9+LAxJoLQhXe6t
   kle6qa20aIEtV/ws858Xg/3P49/HOflb2ok361b2KCZPYUWW87S6KMLcr
   XF1jOR3ic7f0ZxXRpDDaeTJllp8oKgqIxgbVFHTSiCexf+GYZyF3lcGak
   3BGWDggMz5+AKEgk9oxZqjw33EWL4aw59xV2kc1wZy5cecDrMysMlLPjg
   A==;
X-CSE-ConnectionGUID: +VIS0TIjSGaOZACwOKYFvw==
X-CSE-MsgGUID: MwhZuYPtSsGjFvgZyMWqbQ==
X-IronPort-AV: E=Sophos;i="6.24,234,1774310400"; 
   d="scan'208";a="22805587"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 16:36:08 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:11691]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.145:2525] with esmtp (Farcaster)
 id 22942dda-be76-48dd-8824-92e6ab10d786; Tue, 30 Jun 2026 16:36:08 +0000 (UTC)
X-Farcaster-Flow-ID: 22942dda-be76-48dd-8824-92e6ab10d786
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 30 Jun 2026 16:36:07 +0000
Received: from c889f3b07a0a.amazon.com (10.106.83.21) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 30 Jun 2026 16:36:06 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: <stable@vger.kernel.org>
CC: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
	<linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yuto Ohnuki
	<ytohnuki@amazon.com>
Subject: [PATCH 6.1.y] ext4: add bounds check for inline data length in ext4_read_inline_page
Date: Tue, 30 Jun 2026 17:35:53 +0100
Message-ID: <20260630163552.47781-2-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-11.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270009-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ytohnuki@amazon.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ytohnuki@amazon.com,stable@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iloc.bh:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ytohnuki@amazon.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 119986E68C2

[ Upstream commit 356227096eb66e41b23caf7045e6304877322edf ]

ext4_read_inline_page() does not validate that the inline data length
fits within a page before copying data. If the inline size exceeds
PAGE_SIZE due to filesystem corruption, this could lead to a kernel
memory write beyond the page boundary.

Add a bounds check after computing len, returning -EFSCORRUPTED if the
value exceeds PAGE_SIZE.

The upstream commit replaced a BUG_ON(len > PAGE_SIZE) in
ext4_read_inline_folio(). In 6.1 and earlier, the function is still named
ext4_read_inline_page() and the BUG_ON was never present, so this patch
adds the bounds check directly.

Fixes: 46c7f254543d ("ext4: add read support for inline data")
Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
 fs/ext4/inline.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index a1fb99d2b472..c0c1e8652707 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -518,6 +518,14 @@ static int ext4_read_inline_page(struct inode *inode, struct page *page)
 		goto out;
 
 	len = min_t(size_t, ext4_get_inline_size(inode), i_size_read(inode));
+	if (len > PAGE_SIZE) {
+		ext4_error_inode(inode, __func__, __LINE__, 0,
+				 "inline size %zu exceeds PAGE_SIZE", len);
+		ret = -EFSCORRUPTED;
+		brelse(iloc.bh);
+		goto out;
+	}
+
 	kaddr = kmap_atomic(page);
 	ret = ext4_read_inline_data(inode, kaddr, len, &iloc);
 	flush_dcache_page(page);
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




