Return-Path: <stable+bounces-240350-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNRtBl7t6GkdRwIAu9opvQ
	(envelope-from <stable+bounces-240350-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:46:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F77448159
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64987303C4DA
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 15:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42F127603C;
	Wed, 22 Apr 2026 15:42:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD8223AB9D
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872562; cv=none; b=Vv5xLBg/d8iFwXvnjs3VjU1umnEvdM7VGUT6HdMGsW9eaYIm9RNQ9eH/1F5fF0Zs/hEOHO5hVTg9t43Vz3OHIuuJ6Rx25X1Ecy64I52hj6/FJB09Qzq/5gGOTfUZULHL14vvdahKDfabGmcN63a4Y8sxfPwN0funqZb2JQjrje0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872562; c=relaxed/simple;
	bh=YPB5tA+EAgxAuQetKNnPte/y4maHeb/3UUyvG/aeaKI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SX/BLAB7v/wyJNTVue70LZy4C/IAQ3opWfTlF0RqDbdSv+Hx9Z1u16omLSJCEnMpcQq3H0AxP1egTumxssxqSeNKJgoOA/Nh8Cv0Q/BeS02Cxor2O7raRuXW7uF4ZVImskAVOhFVftx8rX64b1L/Bk4jTXJjvVnHC4blu2l+4y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9631CC19425
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 15:42:41 +0000 (UTC)
From: colyli@fnnas.com
To: stable@vger.kernel.org
Subject: [PATCH] bcache: fix uninitialized closure object
Date: Wed, 22 Apr 2026 23:42:38 +0800
Message-ID: <20260422154238.246436-1-colyli@fnnas.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240350-lists,stable=lfdr.de];
	DMARC_NA(0.00)[fnnas.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_NEQ_ENVFROM(0.00)[colyli@fnnas.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	FROM_NO_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[easystack.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,kerenl.org:email,fnnas.com:mid,fnnas.com:email,kernel.dk:email]
X-Rspamd-Queue-Id: 95F77448159
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mingzhe Zou <mingzhe.zou@easystack.cn>

In the previous patch ("bcache: fix cached_dev.sb_bio use-after-free and
crash"), we adopted a simple modification suggestion from AI to fix the
use-after-free.

But in actual testing, we found an extreme case where the device is
stopped before calling bch_write_bdev_super().

At this point, struct closure sb_write has not been initialized yet.
For this patch, we ensure that sb_bio has been completed via
sb_write_mutex.

Signed-off-by: Mingzhe Zou <mingzhe.zou@easystack.cn>
Signed-off-by: Coly Li <colyli@fnnas.com>
Link: https://patch.msgid.link/20260403042135.2221247-1-colyli@fnnas.com
Fixes: fec114a98b87 ("bcache: fix cached_dev.sb_bio use-after-free and crash")
Cc: stable@vger.kerenl.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/md/bcache/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 6627a381f65a..97d9adb0bf96 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1376,11 +1376,12 @@ static CLOSURE_CALLBACK(cached_dev_free)
 	/*
 	 * Wait for any pending sb_write to complete before free.
 	 * The sb_bio is embedded in struct cached_dev, so we must
 	 * ensure no I/O is in progress.
 	 */
-	closure_sync(&dc->sb_write);
+	down(&dc->sb_write_mutex);
+	up(&dc->sb_write_mutex);
 
 	if (dc->sb_disk)
 		folio_put(virt_to_folio(dc->sb_disk));
 
 	if (dc->bdev_file)
-- 
2.47.3


