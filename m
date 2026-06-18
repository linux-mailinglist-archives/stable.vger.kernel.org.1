Return-Path: <stable+bounces-267114-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8OZLCSjbM2oyHQYAu9opvQ
	(envelope-from <stable+bounces-267114-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 13:48:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AD269FD1F
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 13:48:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=govfU7Tw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267114-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267114-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41DC0304021F
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 11:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2D3909BF;
	Thu, 18 Jun 2026 11:47:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C63A4512;
	Thu, 18 Jun 2026 11:47:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781783245; cv=none; b=LPFNtQzECCyVM4E6/VjOv3LQe0o6VzhOfPU0d1/iWJtLHTcNXiMwAwYytfSILlGKMsGflJa6nmPhi6qvXji/fntiPBC2WCF9Eegc1R4w+YtUE/mVtaKs+NZq/R4rZb8kVjYq2+/w6bs8PRAziomcz7ubaDoSXtDGYUPq55RkdTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781783245; c=relaxed/simple;
	bh=krX3vOHKKYDfCJ2C72Te2orh3dOC+JfeAco3j26tHr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEliltLgnBReEDqwrl1lKSgyGgSMmpXwop0mcefEEzlEj+/+Z5IjvvR8r/KbNCqlsle2XKvhwovScs+ybPMR8OGUolS6Ykcu+JBwHvtUbe7ZVD2eBzfBdWojDIgw8OQXikw1odhVJXOLdjspNc7PiVcTgCnA1Dmo6aDcDRnpEpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.at; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=govfU7Tw; arc=none smtp.client-ip=35.83.148.184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1781783243; x=1813319243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oElYL6oVEuIYPddtfTJXY4Wg38bh4zf8Eyj6VtnF63I=;
  b=govfU7TwLt1q4njTsPw83qvOI2B0xHHwcHlJh11s3bEcqSEUCkvNZ8ST
   sSo0n7hRZo/f4pbz3L1xi6x7VdgVW7DKtrXN/8XPMBosB4OHvwvTITGjz
   YHuyQb6QJiz+FXhZrZ8ZuUsWEFXJaE9Z5MVBGhyxqlqCTSXeWfZCU27Sx
   Cl6J5FDT/IHf9RHVvcEx2oHcEL1KgHP2/M9wHQZMGaoYt9KucW89Lixsx
   5b7lZeR6Uk02son//kkOTkGMx+v3bd0FXMsPN8Ajkw3LWhRWjSM7itw+E
   AVhZqUXOwu9P1HlxBrq4PPdL6tj1Nrb6mxlBZyfMDGL+cxfCkx9zmIfyr
   Q==;
X-CSE-ConnectionGUID: 1rxeT0gATfGgCxwX9YnFXg==
X-CSE-MsgGUID: abiBY07QQuO0jPT8t7Wg+g==
X-IronPort-AV: E=Sophos;i="6.24,211,1774310400"; 
   d="scan'208";a="21801244"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 11:47:21 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:6925]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.143:2525] with esmtp (Farcaster)
 id 12479002-0460-43b5-8f0e-44ec61e0340a; Thu, 18 Jun 2026 11:47:20 +0000 (UTC)
X-Farcaster-Flow-ID: 12479002-0460-43b5-8f0e-44ec61e0340a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 18 Jun 2026 11:47:20 +0000
Received: from bcd0741a98fd.amazon.com (10.1.213.12) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 18 Jun 2026 11:47:19 +0000
From: Michael Tautschnig <tautschn@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Michael Tautschnig <tautschn@amazon.com>
Subject: [PATCH v2] staging: vme_user: bound slave read/write to the kern_buf size
Date: Thu, 18 Jun 2026 13:47:09 +0200
Message-ID: <20260618114709.72499-1-tautschn@amazon.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614195318.40397-1-tautschn@amazon.com>
References: <20260614195318.40397-1-tautschn@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267114-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:linux-staging@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:tautschn@amazon.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tautschn@amazon.com,stable@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,get_maintainer.pl:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tautschn@amazon.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79AD269FD1F

The SLAVE-path helpers buffer_to_user() and buffer_from_user() copy
'count' bytes into/out of the fixed-size kern_buf (size_buf ==
PCI_BUF_SIZE == 0x20000, 128 KiB) using *ppos as the offset, without
bounding *ppos + count against size_buf.

vme_user_write()/vme_user_read() only clamp count to the VME window size
(image_size = vme_get_size(resource)), which VME_SET_SLAVE sets from the
user-supplied slave.size -- validated against the VME address space (up
to VME_A32_MAX = 4 GiB), not against PCI_BUF_SIZE.  When the window
exceeds 128 KiB, a write()/read() copies past the kern_buf allocation.

Clamp count against size_buf in both helpers, with an early return when
*ppos is already at/after the buffer end.  *ppos is >= 0 here (the caller
rejects negative offsets), so size_buf - *ppos cannot wrap.  This mirrors
the existing clamp in the MASTER-path helpers resource_to_user() /
resource_from_user(), and matches the read()/write() convention of a
short transfer at end-of-buffer.

Found by static analysis (CodeQL taint tracking + CBMC bounded model
checking) and confirmed dynamically under KASAN with the vme_fake bridge:

  BUG: KASAN: slab-out-of-bounds in _copy_from_user+0x2d/0x80
  Write of size 262144 at addr ffff888004100000 by task trigger/68
    _copy_from_user+0x2d/0x80
    vme_user_write+0x13e/0x240 [vme_user]
    vfs_write+0x1b8/0x7a0
    ksys_write+0xb8/0x150

Fixes: f00a86d98a1e ("Staging: vme: add VME userspace driver")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Tautschnig <tautschn@amazon.com>
---
v1 -> v2:
 - Cc the staging list and LKML per get_maintainer.pl (v1 reached only
   Greg KH).
 - Switch the added comment to normal (non-networking) kernel style.
 - Keep the clamp + early return: this matches the read()/write()
   short-transfer / EOF convention already used by vme_user_read() /
   vme_user_write() (which clamp count and return 0 past the window) and
   by the MASTER-path resource_*() helpers (which clamp count to
   size_buf).  Documented that *ppos >= 0 here, so the subtraction is
   wrap-free.

Link to v1: https://lore.kernel.org/all/20260614195318.40397-1-tautschn@amazon.com/

 drivers/staging/vme_user/vme_user.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
index 11e25c2f6b0a..a472a38ef613 100644
--- a/drivers/staging/vme_user/vme_user.c
+++ b/drivers/staging/vme_user/vme_user.c
@@ -156,6 +156,17 @@ static ssize_t buffer_to_user(unsigned int minor, char __user *buf,
 {
 	void *image_ptr;
 
+	/*
+	 * The slave window (image_size) can exceed the fixed kern_buf
+	 * (size_buf == PCI_BUF_SIZE), so bound the copy to kern_buf.
+	 * *ppos is >= 0 here (checked by the caller), so the
+	 * subtraction below cannot wrap.
+	 */
+	if (*ppos >= image[minor].size_buf)
+		return 0;
+	if (count > image[minor].size_buf - *ppos)
+		count = image[minor].size_buf - *ppos;
+
 	image_ptr = image[minor].kern_buf + *ppos;
 	if (copy_to_user(buf, image_ptr, (unsigned long)count))
 		return -EFAULT;
@@ -168,6 +179,17 @@ static ssize_t buffer_from_user(unsigned int minor, const char __user *buf,
 {
 	void *image_ptr;
 
+	/*
+	 * The slave window (image_size) can exceed the fixed kern_buf
+	 * (size_buf == PCI_BUF_SIZE), so bound the copy to kern_buf.
+	 * *ppos is >= 0 here (checked by the caller), so the
+	 * subtraction below cannot wrap.
+	 */
+	if (*ppos >= image[minor].size_buf)
+		return 0;
+	if (count > image[minor].size_buf - *ppos)
+		count = image[minor].size_buf - *ppos;
+
 	image_ptr = image[minor].kern_buf + *ppos;
 	if (copy_from_user(image_ptr, buf, (unsigned long)count))
 		return -EFAULT;
-- 
2.34.1



Amazon Development Center Austria GmbH
Brueckenkopfgasse 1
8020 Graz
Oesterreich
Sitz in Graz
Firmenbuchnummer: FN 439453 f
Firmenbuchgericht: Landesgericht fuer Zivilrechtssachen Graz




