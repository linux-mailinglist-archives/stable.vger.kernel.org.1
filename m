Return-Path: <stable+bounces-263036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WBegFSVDLmoJrgQAu9opvQ
	(envelope-from <stable+bounces-263036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 07:59:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD166806EC
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 07:59:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=svSEUoI9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263036-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263036-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E4F530039B1
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 05:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFCE2F12C5;
	Sun, 14 Jun 2026 05:58:57 +0000 (UTC)
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D7247291
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 05:58:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781416737; cv=none; b=GuUQCX7oC6rH/AF9kEybGs3HZPN84f4baozdo8LaMZnu2nEvOZyxtbDxmmPmp9iEIsGlCdzIBAfkuiJxygRyqy5tewOiSqEQIkg40f8vfNS+5LpvKaaCD6/+u4acMifNyTe18ZAuQkWFJdl/QRBvcw/68WlMNksHLbWYuOoERMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781416737; c=relaxed/simple;
	bh=WigLtDoz9P5xOWeO1sIGVaWprT6I3bRvOzuXMvoae/c=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=F1jwJOl0vvdUACQgiR9GSMbO5Fs7CJ0eoeJJ+p0WY+JYz3BU23bSk9ZuB18XgwHooWfNAHjcItfWYMhYEyQZNLuq2L+JRtmGI6zdGeLVW0UhLrYFmWbS/TgJGZCoVq5SsaCmN4rPjrFtphCJjLqonof0p7inVit/seW9WjGPS3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=svSEUoI9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D40F1F000E9;
	Sun, 14 Jun 2026 05:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781416736;
	bh=niLDSFX1Jf4mBTX+gjYhl8Sr2gx/8KCdDYMl7+38Z6Y=;
	h=Subject:To:From:Date;
	b=svSEUoI9225blr0/SODOo4Q+gukkTO5G/3ov8X2T/IzfQt4DjMP5N6S0Di3ZjMKFu
	 n+QmZ61BiPQtsrHCn+ugs/XGVCO4w4elh72BTAZ02JoaLld6CL9/94wYH5l37vS4gA
	 EQ/kXSAnhGwIkSKplpuZ6TkkOe1U8Y/08tAQNdVo=
Subject: patch "iio: buffer: hw-consumer: free scan_mask on buffer release" added to char-misc-testing
To: ustc.gu@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jic23@kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 07:57:21 +0200
Message-ID: <2026061421-enviable-fancy-05c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263036-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,intel.com,kernel.org,analog.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ustc.gu@gmail.com,m:Stable@vger.kernel.org,m:andriy.shevchenko@intel.com,m:jic23@kernel.org,m:nuno.sa@analog.com,m:ustcgu@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gregkh:mid,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,analog.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCD166806EC


This is a note to let you know that I've just added the patch titled

    iio: buffer: hw-consumer: free scan_mask on buffer release

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 6325d6e2204327965b849c0a16efb6ac9202e5a8 Mon Sep 17 00:00:00 2001
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 27 Apr 2026 19:11:39 +0800
Subject: iio: buffer: hw-consumer: free scan_mask on buffer release
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The scan_mask lifetime changed in commit 9a2e1233d38c ("iio: buffer:
hw-consumer: remove redundant scan_mask flexible array").

Before that change, the scan mask storage was embedded in struct
hw_consumer_buffer, so iio_hw_buf_release() could free the whole
allocation with a single kfree(hw_buf).

That commit moved the scan mask to a separate bitmap_zalloc() allocation
stored in buffer.scan_mask, but left iio_hw_buf_release() unchanged.

Free the scan mask in iio_hw_buf_release() before freeing the buffer
wrapper.

Fixes: 9a2e1233d38c ("iio: buffer: hw-consumer: remove redundant scan_mask flexible array")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/buffer/industrialio-hw-consumer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index 700528c9a0a4..10e912bbf0c5 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -40,6 +40,8 @@ static void iio_hw_buf_release(struct iio_buffer *buffer)
 {
 	struct hw_consumer_buffer *hw_buf =
 		iio_buffer_to_hw_consumer_buffer(buffer);
+
+	bitmap_free(buffer->scan_mask);
 	kfree(hw_buf);
 }
 
-- 
2.54.0



