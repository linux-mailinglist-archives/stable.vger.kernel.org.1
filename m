Return-Path: <stable+bounces-264686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kRlPOPV7MWomkgUAu9opvQ
	(envelope-from <stable+bounces-264686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:38:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF16692494
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:38:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=p6IpzbG+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264686-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264686-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CF9D31AF6B9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660BB46AEDB;
	Tue, 16 Jun 2026 16:28:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEAA44E037;
	Tue, 16 Jun 2026 16:28:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627300; cv=none; b=vEJNYV2IPh0CFXT7QGDmhdoObjRPdSXdVECzODkRRvFqdznnnC7npAbR0VnWM3/BOxGU0mYngxaPOX29/VDHouVnkumnxZ0lNOdzSiAcqHinUWREwm50TbcUi5tXCjd7fXWGluJ0oU8HrHZkap0T9M1A7Yco7iXtikLl8er41ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627300; c=relaxed/simple;
	bh=aklafguPbIqyh5qUMP04wbVxtJEM8tHN4DvRAr5O4uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKK8uARzW3dx4sfB7bRFcmxdI6AwFnwdbThduq+M6nSc1HUBbRMjH5opCkqivkkTVJnQDQlCp8thf0e11egBQ5zob1b1lS3ZdbFNgiMW0Q1QnEQ1NMf9nIu/zVUf5wT6gcr9d/WMSm150WloS3d1bR3JqZozkZ29GHT0BD6+NY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p6IpzbG+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E767D1F000E9;
	Tue, 16 Jun 2026 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627298;
	bh=Qt+dbm62CwYGvwHV0SF47v/PMePhSfHvKb7/jsjmdgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=p6IpzbG+T8lUUFRHFY7pvreeW/qwhEP7S6kYbnmmOsQgKtISz1yFjhkCR5B8p45eL
	 EXichnSHATUc/2e4e+eBRmyLVApEjPWjlg1aK8kdmmjTenc3tSQispombm66Iv1e4M
	 LXFBDSnWLEVFVB7JDfhnmDDGrnOGvayHtyHPC9SI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Cunlong Li <shenxiaogll@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Yisheng Xie <xieyisheng1@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 151/261] zram: fix use-after-free in zram_bvec_write_partial()
Date: Tue, 16 Jun 2026 20:29:49 +0530
Message-ID: <20260616145052.077793534@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,lst.de,chromium.org,gmail.com,kernel.dk,kernel.org,huawei.com,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-264686-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:hch@lst.de,m:senozhatsky@chromium.org,m:shenxiaogll@gmail.com,m:axboe@kernel.dk,m:minchan@kernel.org,m:xieyisheng1@huawei.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,huawei.com:email,lst.de:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kernel.dk:email,linux-foundation.org:email,chromium.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BF16692494

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cunlong Li <shenxiaogll@gmail.com>

commit 732fd9f0b9c1cdc6dfd77162ded60df005182cc0 upstream.

zram_read_page() picks the sync or async backing device read path based on
whether the parent bio is NULL.  zram_bvec_write_partial() passes its
parent bio down, so for ZRAM_WB slots the read is dispatched
asynchronously and zram_read_page() returns 0 while the bio is still in
flight.  The caller then runs memcpy_from_bvec(), zram_write_page() and
__free_page() on the buffer, leaving the async read to write into a freed
page.

zram_bvec_read_partial() was switched to NULL in commit 4e3c87b9421d
("zram: fix synchronous reads") for the same reason; the write_partial
counterpart was missed.

Link: https://lore.kernel.org/20260528-zram-v3-1-cab86eef8764@gmail.com
Fixes: 8e654f8fbff5 ("zram: read page from backing device")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/zram/zram_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1661,7 +1661,7 @@ static int zram_bvec_write_partial(struc
 	if (!page)
 		return -ENOMEM;
 
-	ret = zram_read_page(zram, page, index, bio);
+	ret = zram_read_page(zram, page, index, NULL);
 	if (!ret) {
 		memcpy_from_bvec(page_address(page) + offset, bvec);
 		ret = zram_write_page(zram, page, index);



