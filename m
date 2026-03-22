Return-Path: <stable+bounces-227831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCvfJ4nxv2moAwQAu9opvQ
	(envelope-from <stable+bounces-227831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:41:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF072E97FD
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E112F300D968
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B07B346E50;
	Sun, 22 Mar 2026 13:41:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEC732D7FF;
	Sun, 22 Mar 2026 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774186870; cv=none; b=uI6RuFQd/d0XU4YS+VNlJIdAjZzAlsSJNmMGnpAjGbNBS9UWoeSeEn+EWxaOQYS1PcwQ61MnnuqpgORYYmx+8xJMgEEDChY5BSxPZ13HkqSY7Ot/HbwhR6GtBNLVbLxtEE71mYHxmdySaxn78QERyCG0QY8GN2P31KGazCMxhec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774186870; c=relaxed/simple;
	bh=eCEkiN58Xyxy1hwGJsCam4Mju4eWxjo/7smrhQqR7BA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sq1oi8oenxpb7KYz5z7pBxl1d0Wd9W2tuwBQql7uEVV3v6tvXX4GoLMkI1fEYMY8NZFcUbpFD7G9kctV6onA/xtr4dE31fZQTFzulEXyImGgnPsET+tnlL33M/9+NO7WMpg4IJ2EDGUg550svz8v+WON92Gb+v90LYSF/epoMFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3112FC19424;
	Sun, 22 Mar 2026 13:41:06 +0000 (UTC)
From: colyli@fnnas.com
To: axboe@kernel.org
Cc: linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	Mingzhe Zou <mingzhe.zou@easystack.cn>,
	stable@vger.kernel.org,
	Coly Li <colyli@fnnas.com>
Subject: [PATCH v2] bcache: fix cached_dev.sb_bio use-after-free and crash
Date: Sun, 22 Mar 2026 21:41:02 +0800
Message-ID: <20260322134102.480107-1-colyli@fnnas.com>
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
	TAGGED_FROM(0.00)[bounces-227831-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[fnnas.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[colyli@fnnas.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,easystack.cn:email,fnnas.com:email,fnnas.com:mid]
X-Rspamd-Queue-Id: EFF072E97FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mingzhe Zou <mingzhe.zou@easystack.cn>

In our production environment, we have received multiple crash reports
regarding libceph, which have caught our attention:

```
[6888366.280350] Call Trace:
[6888366.280452]  blk_update_request+0x14e/0x370
[6888366.280561]  blk_mq_end_request+0x1a/0x130
[6888366.280671]  rbd_img_handle_request+0x1a0/0x1b0 [rbd]
[6888366.280792]  rbd_obj_handle_request+0x32/0x40 [rbd]
[6888366.280903]  __complete_request+0x22/0x70 [libceph]
[6888366.281032]  osd_dispatch+0x15e/0xb40 [libceph]
[6888366.281164]  ? inet_recvmsg+0x5b/0xd0
[6888366.281272]  ? ceph_tcp_recvmsg+0x6f/0xa0 [libceph]
[6888366.281405]  ceph_con_process_message+0x79/0x140 [libceph]
[6888366.281534]  ceph_con_v1_try_read+0x5d7/0xf30 [libceph]
[6888366.281661]  ceph_con_workfn+0x329/0x680 [libceph]
```

After analyzing the coredump file, we found that the address of
dc->sb_bio has been freed. We know that cached_dev is only freed when it
is stopped.

Since sb_bio is a part of struct cached_dev, rather than an alloc every
time.  If the device is stopped while writing to the superblock, the
released address will be accessed at endio.

This patch hopes to wait for sb_write to complete in cached_dev_free.

It should be noted that we analyzed the cause of the problem, then tell
all details to the QWEN and adopted the modifications it made.

Signed-off-by: Mingzhe Zou <mingzhe.zou@easystack.cn>
Fixes: cafe563591446 ("bcache: A block layer cache")
Cc: stable@vger.kernel.org # 3.10+
Signed-off-by: Coly Li <colyli@fnnas.com>
---
Change log,
v2, fix emiail address type to stable kerenl.
v1, initial version.

 drivers/md/bcache/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 64bb38c95895..6627a381f65a 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1373,6 +1373,13 @@ static CLOSURE_CALLBACK(cached_dev_free)
 
 	mutex_unlock(&bch_register_lock);
 
+	/*
+	 * Wait for any pending sb_write to complete before free.
+	 * The sb_bio is embedded in struct cached_dev, so we must
+	 * ensure no I/O is in progress.
+	 */
+	closure_sync(&dc->sb_write);
+
 	if (dc->sb_disk)
 		folio_put(virt_to_folio(dc->sb_disk));
 
-- 
2.47.3


