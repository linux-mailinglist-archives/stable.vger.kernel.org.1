Return-Path: <stable+bounces-245415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MhnIjfcAmrJyAEAu9opvQ
	(envelope-from <stable+bounces-245415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:52:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F031451C388
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84AE63042918
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 07:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE9847CC97;
	Tue, 12 May 2026 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SgNI8xyH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91B41D7E5C
	for <stable@vger.kernel.org>; Tue, 12 May 2026 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572177; cv=none; b=rKs3KjeI381NuYyrosqsPZ65dDyqar2Inif1cSVYsEUl8sGLs1qEbKCIheyKE6OpiUKLZmKlSYjFofEcOYk/2vQPQZ4SxTkUDmG/yNQ36qT60C453fjhKmsVoE+ObrQv+5LQApI/wZgunU48DFYBa5Z5dbnhhAfqVRQ3KmGPvC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572177; c=relaxed/simple;
	bh=ygaH+2wsFcmG/zLT9vuTLDnDQTwm/pe2WCSsYbTR67A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b23fFN5z34jX6Q/RqmKF3sMt/FBQJBeCEManThGvzlnvArAv0NQ4XO6VGpvNahog1+LMKxjf65Pee07TQG3Kvh3WiFV/P8u/RzSONRvd1/wGs6a4b0om8qX2jXSP9KcpWo/no4Z7+K/3wy6MgzcyjYQZMa/+aiB6al02p5MRv80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SgNI8xyH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba6ca20ceeso57995765ad.2
        for <stable@vger.kernel.org>; Tue, 12 May 2026 00:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778572174; x=1779176974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UR6rLERhiUgj6UCn2Pmol6DViHNRfs8NhBRMn+AmWuM=;
        b=SgNI8xyH16c23MyQQW1H7nDX+hDs4VMwAowv2GUbFd5BBZXBoLvAtvr1fQt/pE+Gzz
         eSDvkwia+5MXVyua5x16SjXkOybBL2pIGhe91+/t3SuXJkFmJettpYHdZiP1F5f/bYKB
         tcUXmeZrnly36zCy9HZHDnpaOsb5gN/ZDUVFSNYhg4i11Zblnc3ukB2RELpekvasti0b
         vbAvo3ppkVsMcKpRxs2pQTSN3+5u92cPH2xByN90kFW6Tc1JIEsGLI4pAiSrjm1M1S4E
         3k+0I8D9OfXZwcsPhUfxooyBwW4C6Xqt/NP67mGpq+fXkiYqWzqDefQWTK+6YqzKCKVO
         4bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778572174; x=1779176974;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UR6rLERhiUgj6UCn2Pmol6DViHNRfs8NhBRMn+AmWuM=;
        b=DWpWybTLWk6Rm/lJLCxhnlwzFQ7Nl2wVpmqswj6b/u2/6+Um18dTrJhmQCW3+XqLug
         THarPKErvX3TQAH+GlY4cc6M53pY7Wf5/BSYM/8cYeDIT1BPDa30/vniulxCiGhVTdpx
         z1b1O+WdU3k1iO6INiyIIKOGA9qZ9SK6IRHaRiN00WoMsR2X91lVnoh/uECGh2qVEkLm
         1nfh/hx6GfagV0/81WxCpgqOf6HVt4Hymo93JXXt9L9V6YI2xQQ9UGHLpjtQcvsVAp45
         eaUeFjlL7ELHRKBD7AAdQHbY8YixUZ1mBXiTpW99m5Q9oSJbR2RFEA9BVzmbSmraNJy3
         VD3w==
X-Forwarded-Encrypted: i=1; AFNElJ9LDMZipqJHQkq/CCLXWDTJU6/MIEgIpf/5s+vQH5KfFNpp6xKGcGfNIebGaOC7UZfoL1GLtHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx72qcHL6F/DXkOB+opsIjBiN/6byieM3usLXZbTFIO6PgeekAF
	sxCqVWWT3BwT9uLFiVj5S+lt8NBsuM+q2ThkqrG6o9qGh9jEBdQBEFNPb/8bKtGYrVp8Q8DD/Fd
	PuQ/aUE3+2YWkVQ8okOwY
X-Received: from plhu11.prod.google.com ([2002:a17:903:124b:b0:2ba:792a:18a7])
 (user=richardycc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:287:b0:2ae:803e:6c12 with SMTP id d9443c01a7336-2bd010f4ccfmr21818475ad.6.1778572174022;
 Tue, 12 May 2026 00:49:34 -0700 (PDT)
Date: Tue, 12 May 2026 07:49:18 +0000
In-Reply-To: <af6ZT9oR7GGmMFSC@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <af6ZT9oR7GGmMFSC@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512074918.2606208-1-richardycc@google.com>
Subject: [PATCH v3] zram: fix use-after-free in zram_writeback_endio
From: Richard Chang <richardycc@google.com>
To: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>
Cc: bgeffon@google.com, liumartin@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Richard Chang <richardycc@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F031451C388
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245415-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardycc@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

A crash was observed in zram_writeback_endio due to a NULL pointer
dereference in wake_up. The root cause is a race condition between the
bio completion handler (zram_writeback_endio) and the writeback task.

In zram_writeback_endio, wake_up() is called on &wb_ctl->done_wait after
releasing wb_ctl->done_lock. This creates a race window where the
writeback task can see num_inflight become 0, return, and free wb_ctl
before zram_writeback_endio calls wake_up().

CPU 0 (zram_writeback_endio)     CPU 1 (writeback_store)
============================     ============================
                                 zram_writeback_slots
                                   zram_submit_wb_request
                                   zram_submit_wb_request
                                   wait_event(wb_ctl->done_wait)
spin_lock(&wb_ctl->done_lock);
list_add(&req->entry, &wb_ctl->done_reqs);
spin_unlock(&wb_ctl->done_lock);
wake_up(&wb_ctl->done_wait);
                                   zram_complete_done_reqs
spin_lock(&wb_ctl->done_lock);
list_add(&req->entry, &wb_ctl->done_reqs);
spin_unlock(&wb_ctl->done_lock);
                                   while (num_inflight) > 0)
                                     spin_lock(&wb_ctl->done_lock);
                                     list_del(&req->entry);
                                     spin_unlock(&wb_ctl->done_lock);
                                     // num_inflight becomes 0
                                     atomic_dec(num_inflight);

                                 // Leave zram_writeback_slots
                                 // Free wb_ctl
                                 release_wb_ctl(wb_ctl);
// UAF crash!
wake_up(&wb_ctl->done_wait);

This patch fixes this race by using RCU. By protecting wb_ctl with
rcu_read_lock() in zram_writeback_endio and using kfree_rcu() to free
it, we ensure that wb_ctl remains valid during the execution of
zram_writeback_endio.

Fixes: f405066a1f0d ("zram: introduce writeback bio batching")
Cc: stable@vger.kernel.org
Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Richard Chang <richardycc@google.com>
---
V2: use RCU to manage the wb_ctl lifetime
V3: add stable tag

 drivers/block/zram/zram_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aebc710f0d6a..07111455eecf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -33,6 +33,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/part_stat.h>
 #include <linux/kernel_read_file.h>
+#include <linux/rcupdate.h>
 
 #include "zram_drv.h"
 
@@ -504,6 +505,7 @@ struct zram_wb_ctl {
 	wait_queue_head_t done_wait;
 	spinlock_t done_lock;
 	atomic_t num_inflight;
+	struct rcu_head rcu;
 };
 
 struct zram_wb_req {
@@ -847,7 +849,7 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
 		release_wb_req(req);
 	}
 
-	kfree(wb_ctl);
+	kfree_rcu(wb_ctl, rcu);
 }
 
 static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
@@ -964,11 +966,13 @@ static void zram_writeback_endio(struct bio *bio)
 	struct zram_wb_ctl *wb_ctl = bio->bi_private;
 	unsigned long flags;
 
+	rcu_read_lock();
 	spin_lock_irqsave(&wb_ctl->done_lock, flags);
 	list_add(&req->entry, &wb_ctl->done_reqs);
 	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
 
 	wake_up(&wb_ctl->done_wait);
+	rcu_read_unlock();
 }
 
 static void zram_submit_wb_request(struct zram *zram,
-- 
2.54.0.563.g4f69b47b94-goog


