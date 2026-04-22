Return-Path: <stable+bounces-240348-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHE6CZno6Gl4RgIAu9opvQ
	(envelope-from <stable+bounces-240348-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:26:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A34447DF5
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD89530B9972
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933AC33987F;
	Wed, 22 Apr 2026 15:21:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A945331203
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871290; cv=none; b=bYf+aVZWQmLiaSdJcNUjwMaU4x0kNtUr5JTLKJJWPh7lQKbLmPcgCfkQuv/gyZA1BY9KQm1chaBnIW8DDqGG5ZSpqqPf+JtNucF3ljNx/cXJFEk065rBLFGH6JDcQxpNnNkDfEnL9f9/cJrip/R3UrVGNo3VQbHmwuybWqns5oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871290; c=relaxed/simple;
	bh=YPB5tA+EAgxAuQetKNnPte/y4maHeb/3UUyvG/aeaKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DUxuXZrt/DYshhzufYZFkczZBuK5LXQEWUGFqjNzR9SuX++9zMdpmAU6tBxv5EHvG+Rrww8TcICv6yQmVhuzGwY3XQ73C36IgqCc9rKfDh3zwKM7FJr744TnjXQWWp1kQCbp6kIrFB7tw0NG7X2kB8iO2oOayI3lRniDfGx2mrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0CAC2BCB2;
	Wed, 22 Apr 2026 15:21:27 +0000 (UTC)
From: colyli@fnnas.com
To: stable@vger.kernel.org
Cc: Mingzhe Zou <mingzhe.zou@easystack.cn>,
	Coly Li <colyli@fnnas.com>,
	stable@vger.kerenl.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] bcache: fix uninitialized closure object
Date: Wed, 22 Apr 2026 23:21:13 +0800
Message-ID: <20260422152113.70337-1-colyli@fnnas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240348-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[fnnas.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[colyli@fnnas.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,easystack.cn:email,kerenl.org:email,fnnas.com:mid,fnnas.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 74A34447DF5
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


