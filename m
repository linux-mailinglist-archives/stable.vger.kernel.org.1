Return-Path: <stable+bounces-263232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3M0GIJwLMGrEMQUAu9opvQ
	(envelope-from <stable+bounces-263232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:26:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A75268722D
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:26:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ClwZjikx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263232-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263232-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F105B3010BFE
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB92B3F1674;
	Mon, 15 Jun 2026 14:24:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A962C3EF0CD
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:24:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533454; cv=none; b=gPM/vD10NldF8KW1jlM3K7iSvU0xr41baY1ZHKKpQxsIBMC0ML3WWlFf1WOyMoCAzmtVbaJzeItXwq32Sf3hLMWrVkSJ7gi64unYaJcrGLvddkyGspuebSDOz+agaOMhxhrxggzxoMUedEa6c7HDNiEKlpMdeYW1aIzsNeY2mzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533454; c=relaxed/simple;
	bh=KPMGE72tfeEOCpV+XImlmTbBDbUScbun/9bh/q9XbBY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=No2oYRn8B4lYiX74z9mvWe0NzipI+KyPIui21yw3TFls/qKUsN12GgmKGsj94kXCNhp0fTHKKnNoR90vRziLZmFBlWGgA2WJU8mGb4QrgTLkvhokDCcBDBoFcIPQ2faaa/v4QXbAv4v7s4lg+f7Srj2qShCfmJX4TtX5qOEG4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ClwZjikx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403961F000E9;
	Mon, 15 Jun 2026 14:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533453;
	bh=NpS1yqU12wj0z1iWbBVBWX8ovmvxRcKp6Ev2aGlcuUg=;
	h=Subject:To:Cc:From:Date;
	b=ClwZjikxBE2mEWUrKPUj00ATC9ijpDuoq75uk2OfLpFZ7ambJUtEFGMxWZykwaqHz
	 rmH9WoAoQ6HjO8eAyPL40nnAPgvcHxnQUotQ/CRwr89gIG25wV3YzpAZS+oUvpvgTZ
	 XyzG7AgiZKlCv+TNyTCskoPIWPr+tQHrt+jC/bUY=
Subject: FAILED: patch "[PATCH] zram: fix use-after-free in zram_bvec_write_partial()" failed to apply to 6.1-stable tree
To: shenxiaogll@gmail.com,akpm@linux-foundation.org,axboe@kernel.dk,hch@lst.de,minchan@kernel.org,senozhatsky@chromium.org,stable@vger.kernel.org,xieyisheng1@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:21:35 +0200
Message-ID: <2026061535-fraying-pronto-cba0@gregkh>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263232-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:shenxiaogll@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:hch@lst.de,m:minchan@kernel.org,m:senozhatsky@chromium.org,m:stable@vger.kernel.org,m:xieyisheng1@huawei.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org,kernel.dk,lst.de,kernel.org,chromium.org,vger.kernel.org,huawei.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,linux-foundation.org:email,gregkh:mid,huawei.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,chromium.org:email,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,lst.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A75268722D


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 732fd9f0b9c1cdc6dfd77162ded60df005182cc0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061535-fraying-pronto-cba0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 732fd9f0b9c1cdc6dfd77162ded60df005182cc0 Mon Sep 17 00:00:00 2001
From: Cunlong Li <shenxiaogll@gmail.com>
Date: Thu, 28 May 2026 10:48:44 +0800
Subject: [PATCH] zram: fix use-after-free in zram_bvec_write_partial()

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

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 07111455eecf..e11ee1ed3832 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2337,7 +2337,7 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
 	if (!page)
 		return -ENOMEM;
 
-	ret = zram_read_page(zram, page, index, bio);
+	ret = zram_read_page(zram, page, index, NULL);
 	if (!ret) {
 		memcpy_from_bvec(page_address(page) + offset, bvec);
 		ret = zram_write_page(zram, page, index);


