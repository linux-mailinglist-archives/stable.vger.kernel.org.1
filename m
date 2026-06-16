Return-Path: <stable+bounces-264400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7su/Dh91MWo+jwUAu9opvQ
	(envelope-from <stable+bounces-264400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:09:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC2E691BAD
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:09:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Upx2vcUq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264400-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264400-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 463EC3010BB9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A21453498;
	Tue, 16 Jun 2026 16:01:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8884657F4;
	Tue, 16 Jun 2026 16:01:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625687; cv=none; b=ouFQzdxCupJTlXP548hmBOV8PgIpcgGa7bdU8JQy0HHC8iO7KaUL/MmW5VxVCKSxsKwHXm7hfwGgbtFISQfZTMsaZM9rwz57ASXy+JT363/yGMjGEv/d6RsDqrt8pYX7xc4pgGJh+RsDEt3FzEBSiU+TK81JDrEqgFp0g+gocAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625687; c=relaxed/simple;
	bh=yWZQ9Zzvo4ze2rISTioBZItG+1BMSu0fz+9GzwD273k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecLN4R28ZSYc1pO83RlsxJDMnkUqeK+AkI6qvXs6vKMu4j5yMJUAXVV2H95PqLEEwU1nbD4sNEGo96I7huO8ZbRsI6RNEZVGi9loSGr3NdDmQw3pgEzU1gHD/LPtC7FwOPe54G3+i1VnwJI0suVs3Ia5Y0XM2+V7Ktkb9agE1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Upx2vcUq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FA31F000E9;
	Tue, 16 Jun 2026 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625686;
	bh=fNGw/nexpVTFo8Drau6MTQMqO8io0EDU6KQ9hhF9TqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Upx2vcUqrQ9Iig5IxC43Tia49BjZ9wOgvo4NRSmzogRHCD+v9HJlWAD1xWM90ECdr
	 6kUtoEwJl8IYYmbxlJDB6LHrwmDA20XtXS7YSAPiBLp8kyM2yuq66l5+fNq1yAYUlb
	 W+f1CQ7Ny9sdhtp+3oNdlU53dW50pFfCVHzWOFg0=
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
Subject: [PATCH 6.18 189/325] zram: fix use-after-free in zram_bvec_write_partial()
Date: Tue, 16 Jun 2026 20:29:45 +0530
Message-ID: <20260616145107.323521970@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-264400-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,chromium.org:email,lst.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BC2E691BAD

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1915,7 +1915,7 @@ static int zram_bvec_write_partial(struc
 	if (!page)
 		return -ENOMEM;
 
-	ret = zram_read_page(zram, page, index, bio);
+	ret = zram_read_page(zram, page, index, NULL);
 	if (!ret) {
 		memcpy_from_bvec(page_address(page) + offset, bvec);
 		ret = zram_write_page(zram, page, index);



