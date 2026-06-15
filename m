Return-Path: <stable+bounces-263230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bYoYAHMLMGqtMQUAu9opvQ
	(envelope-from <stable+bounces-263230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:25:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFB56871E7
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:25:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=mjYt8fsy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263230-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263230-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B2C5301D58A
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603753F8246;
	Mon, 15 Jun 2026 14:23:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D83F7A83
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:23:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533400; cv=none; b=hYG6Jgur6msDdih4tBtDiq7GqQwCizm10rAa+1iOfgev6LzXKYZ5o7SEls/5S64hYYLc3svW0bh82lvN2Z5W4/0cXx0eLUhixWdC5f58BzCvs72SKwAGqTcQcIu3rYl160cckHxaDuMmNVPkpkaL6I8qA7m8hcIt5eaQR1eEGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533400; c=relaxed/simple;
	bh=2fAa7ZGRCruFH2ei2ZnF/tdGCzo7pvmRrsSK2nGVuHw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rjR3wbfMlZYnglPOA3IG4O/j64fY473CnJCcBKHHGoRNQ4508J4cwQ8jd9wye6oyoYCkFLnx6JQxl6YlXx6MgFUKxhKDlvk14pvCj8m5UwAVWAhzFhvI6c/DETOrxyFmtAZUp6QQVIHpU3wqA0X9A2Ou0Jb0LxhYeRBOXE6t7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mjYt8fsy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B401F000E9;
	Mon, 15 Jun 2026 14:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533398;
	bh=S4iaJF1VsAxeuVL0+CJ6xx1XpFZjhC9XlSlSRU7WVWs=;
	h=Subject:To:Cc:From:Date;
	b=mjYt8fsygYpaniO0nQDrKDbDp7ljgGxvx+nsT9T9RHf47np4G3TimlLYyzJCsq4He
	 UxBCJtKmD3xSk+yUG9c3kKNBNaYdZFtScJoeFH0Mz3qqhzEEIUfPgW5wkBRWqdj1Gv
	 vvq/wCUtD96oWdsghY4Bpri8dkUCnmdAm8Qcccws=
Subject: FAILED: patch "[PATCH] RDMA/umem: Fix truncation for block sizes >= 4G" failed to apply to 5.15-stable tree
To: jgg@ziepe.ca,jgg@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:21:11 +0200
Message-ID: <2026061511-anchor-wriggly-5b25@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263230-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:jgg@nvidia.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gregkh:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAFB56871E7


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 15fe76e23615f502d051ef0768f86babaf08746c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061511-anchor-wriggly-5b25@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 15fe76e23615f502d051ef0768f86babaf08746c Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Mon, 1 Jun 2026 13:52:31 -0300
Subject: [PATCH] RDMA/umem: Fix truncation for block sizes >= 4G

When the iommu is used the linearization of the mapping can give a single
block that is very large split across multiple SG entries.

When __rdma_block_iter_next() reassembles the split SG entries it is
overflowing the 32 bit stack values and computed the wrong DMA addresses
for blocks after the truncation.

Use the right types to hold DMA addresses.

Link: https://patch.msgid.link/r/1-v1-88303e9e509f+f7-ib_umem_types_jgg@nvidia.com
Cc: stable@vger.kernel.org
Fixes: a808273a495c ("RDMA/verbs: Add a DMA iterator to return aligned contiguous memory blocks")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/infiniband/core/iter.c b/drivers/infiniband/core/iter.c
index 8e543d100657..3ed351e8fcf6 100644
--- a/drivers/infiniband/core/iter.c
+++ b/drivers/infiniband/core/iter.c
@@ -19,8 +19,8 @@ EXPORT_SYMBOL(__rdma_block_iter_start);
 
 bool __rdma_block_iter_next(struct ib_block_iter *biter)
 {
-	unsigned int block_offset;
-	unsigned int delta;
+	dma_addr_t block_offset;
+	dma_addr_t delta;
 
 	if (!biter->__sg_nents || !biter->__sg)
 		return false;


