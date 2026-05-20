Return-Path: <stable+bounces-252851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO7oH/UpDmpq6gUAu9opvQ
	(envelope-from <stable+bounces-252851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:39:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC00559B274
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 137313534BEC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA773F8706;
	Wed, 20 May 2026 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0iFsShtx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB683DA5B6;
	Wed, 20 May 2026 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301756; cv=none; b=AU87mwo3gzaaA3kMGAn1ry0jRodm1W/OKzyhutCVwl4IeDHvTpRd/ReXECnTJgMWDD4/DE528Decqj5dRttxPS0u3SU2axcUBs37Y0mc6uyrCFcOupHPWbKkqymKr23YqLzhb+76NPakJAfUxY7hMN+NkQy2fFj14PiGGlj+kEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301756; c=relaxed/simple;
	bh=kOTJsKsULHbhuLKRzQMBU7Yc7tBmmxYPLZTcyroYwyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms/RiS/gK/KwYuad/PkWomPus2Z/hFV63VCJss+oUu09xCHFEolNBq8c/Eac60hdOgYuQ1SydG1YjlsxmbSuvsduWhEpuQ0tmlXqM9/e4SHdUraEX1JC/zUzYsevPdpJVyAN/UheAMocxaG8I/rFt/yPtrh2FfeFOQw5bk8NVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0iFsShtx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01F71F000E9;
	Wed, 20 May 2026 18:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301755;
	bh=Y0+ZqQRgWoQd4HmXOx7F9sSIzh+GuLSMfCdWoSpJA5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0iFsShtxcrOt96p/+OH856JduEJRLY4DcN/VdqGtUd2VYODzBIo5crStmzUTw/W7R
	 e1JT3xxnH1BFStgEaMmDYGosM18PHa7hPJ3pAsv1VV2sVRIWCgPBslLuJPj2eSMlCt
	 NpoxlV838sQbneMSooFmWcDlv2HpYeRCFcA5gS5w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yi Zhang <yi.zhang@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 001/508] blk-cgroup: wait for blkcg cleanup before initializing new disk
Date: Wed, 20 May 2026 18:17:04 +0200
Message-ID: <20260520162058.609606751@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252851-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kernel.dk:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,lst.de:email]
X-Rspamd-Queue-Id: DC00559B274
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 3dbaacf6ab68f81e3375fe769a2ecdbd3ce386fd ]

When a queue is shared across disk rebind (e.g., SCSI unbind/bind), the
previous disk's blkcg state is cleaned up asynchronously via
disk_release() -> blkcg_exit_disk(). If the new disk's blkcg_init_disk()
runs before that cleanup finishes, we may overwrite q->root_blkg while
the old one is still alive, and radix_tree_insert() in blkg_create()
fails with -EEXIST because the old blkg entries still occupy the same
queue id slot in blkcg->blkg_tree. This causes the sd probe to fail
with -ENOMEM.

Fix it by waiting in blkcg_init_disk() for root_blkg to become NULL,
which indicates the previous disk's blkcg cleanup has completed.

Fixes: 1059699f87eb ("block: move blkcg initialization/destroy into disk allocation/release handler")
Cc: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260311032837.2368714-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-cgroup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 75e9d5a9d707c..40c9d5805b88b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -24,6 +24,7 @@
 #include <linux/backing-dev.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/wait_bit.h>
 #include <linux/atomic.h>
 #include <linux/ctype.h>
 #include <linux/resume_user_mode.h>
@@ -618,6 +619,8 @@ static void blkg_destroy_all(struct gendisk *disk)
 
 	q->root_blkg = NULL;
 	spin_unlock_irq(&q->queue_lock);
+
+	wake_up_var(&q->root_blkg);
 }
 
 static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
@@ -1459,6 +1462,18 @@ int blkcg_init_disk(struct gendisk *disk)
 	bool preloaded;
 	int ret;
 
+	/*
+	 * If the queue is shared across disk rebind (e.g., SCSI), the
+	 * previous disk's blkcg state is cleaned up asynchronously via
+	 * disk_release() -> blkcg_exit_disk(). Wait for that cleanup to
+	 * finish (indicated by root_blkg becoming NULL) before setting up
+	 * new blkcg state. Otherwise, we may overwrite q->root_blkg while
+	 * the old one is still alive, and radix_tree_insert() in
+	 * blkg_create() will fail with -EEXIST because the old entries
+	 * still occupy the same queue id slot in blkcg->blkg_tree.
+	 */
+	wait_var_event(&q->root_blkg, !READ_ONCE(q->root_blkg));
+
 	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
 	if (!new_blkg)
 		return -ENOMEM;
-- 
2.53.0




