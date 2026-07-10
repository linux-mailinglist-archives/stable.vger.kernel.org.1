Return-Path: <stable+bounces-273238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M4K4LDD1UGo69AIAu9opvQ
	(envelope-from <stable+bounces-273238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 15:35:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D105773B4D9
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 15:35:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W0SRhNcZ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273238-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273238-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10DF93024CA1
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 13:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BB319DF4F;
	Fri, 10 Jul 2026 13:34:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A1E314A83
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 13:34:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690480; cv=none; b=BAhZgbAkVhHRLvtzsKdcdb8wNC71EiM1uin09vjkmfDDl6ATGcDrfIpzJ97ngfj+w0sXZ3NgzZNWIKebufg+nOkM2GkDwsw9hdGmq4e9g2l1r7ubi1fQ6LkuiERWnTXxo1ybOt3rFy6zCn/ZtvnOAH4qp+Yo9IN6bTagFSCOHkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690480; c=relaxed/simple;
	bh=CmM9v96osf/ERQ3Rjd73mar/R1vPs0q/ZM1EB31QTCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlXAgfmIfOmmRiXrA0FKB7eb/c6ksMfHFE0vDWxc5EOWesRSbQqmCnSzLSoPAG3aYKN3HmwsA8csd1xAc7XjUnxmd+6JS4JZ6GL5pUawQEASLHkKxBecPM5Gwfp40dcoapvJJ4ENbQlVUaO4WN1WPVzdK45lphZI4WwAOI/SnLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0SRhNcZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34A41F000E9;
	Fri, 10 Jul 2026 13:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783690478;
	bh=FfJVZ7e6aoiGjTzLwsnXTzhDXEJ5e76XzGJULiwrVbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W0SRhNcZiH7NrTml2LWwkmXNBq9fpkWhQhJMRG0lIJMXSsG9y4VkGMCtDhxRd0S7r
	 Oz/0595zafjxXBN8zVpG+taiVLI/b1fLze7fdr6bFxUtWN6z9yX3ZSCK6iHqo2kU1h
	 f4b3OdBWvEwwIR1j6UFDs9DZpEJ2llzzgfOfmogyPaxmXaZO/iE3x7JXpm5nltrf8M
	 khvATcDBOUjDQX+JETSJT0yxK2Rq11gQKtb+AtCOBDiXdLBe+Z9vh/gAkHE0EP3gqk
	 qUsskuVjHj/mdWtCi3SzQc+O70L83VptJek2ocBNPK2GBcA0oZbZVdtWd49LFZsHVz
	 MxorAPknGdEZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoze Xie <royenheart@gmail.com>,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] rust: block: fix GenDisk cleanup paths
Date: Fri, 10 Jul 2026 09:34:36 -0400
Message-ID: <20260710133436.82387-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070953-laurel-zeppelin-239b@gregkh>
References: <2026070953-laurel-zeppelin-239b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:royenheart@gmail.com,m:stable@kernel.org,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:a.hindborg@kernel.org,m:n05ec@lzu.edu.cn,m:axboe@kernel.dk,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273238-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lzu.edu.cn,kernel.dk];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email,msgid.link:url,vger.kernel.org:from_smtp,kernel.dk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D105773B4D9

From: Haoze Xie <royenheart@gmail.com>

[ Upstream commit 2957771379fa335103a4b539db57bb2271e12142 ]

GenDiskBuilder::build() still has fallible work after
__blk_mq_alloc_disk(), but its error path only recovers the
foreign queue data. That leaks the temporary gendisk and
request_queue until later teardown. If the caller moved the last
Arc<TagSet<T>> into build(), the leaked queue can retain blk-mq
state after the tag set is dropped.

Fix the pre-registration failure path by dropping the temporary
gendisk reference with put_disk() before recovering queue_data,
so disk_release() can tear down the owned queue.

Also pair GenDisk::drop() with put_disk() after del_gendisk().
Once a Rust GenDisk has been added with device_add_disk(),
del_gendisk() only unregisters it; the final gendisk reference
still has to be dropped to complete the release path.

Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Link: https://patch.msgid.link/b70aff9a920cc42110fe5cf454c3099561863519.1780063368.git.royenheart@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ no queue-data recovery or recover_data.dismiss() in 6.12 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/block/mq/gen_disk.rs | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 8cd47ddd1dbb5f..c4095984444057 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -6,7 +6,7 @@
 //! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
 
 use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
-use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
+use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc, types::ScopeGuard};
 use crate::{error, static_lock_class};
 use core::fmt::{self, Write};
 
@@ -139,6 +139,12 @@ pub fn build<T: Operations>(
         // SAFETY: `gendisk` is a valid pointer as we initialized it above
         unsafe { (*gendisk).fops = &TABLE };
 
+        let cleanup_failure = ScopeGuard::new_with_data(gendisk, |gendisk| {
+            // SAFETY: `gendisk` came from `__blk_mq_alloc_disk()` above and
+            // has not been added to the VFS on this cleanup path.
+            unsafe { bindings::put_disk(gendisk) };
+        });
+
         let mut raw_writer = RawWriter::from_array(
             // SAFETY: `gendisk` points to a valid and initialized instance. We
             // have exclusive access, since the disk is not added to the VFS
@@ -161,6 +167,8 @@ pub fn build<T: Operations>(
             },
         )?;
 
+        cleanup_failure.dismiss();
+
         // INVARIANT: `gendisk` was initialized above.
         // INVARIANT: `gendisk` was added to the VFS via `device_add_disk` above.
         Ok(GenDisk {
@@ -192,5 +200,10 @@ fn drop(&mut self) {
         // initialized instance of `struct gendisk`, and it was previously added
         // to the VFS.
         unsafe { bindings::del_gendisk(self.gendisk) };
+
+        // SAFETY: By type invariant, `self.gendisk` was added to the VFS, so
+        // `put_disk()` must follow `del_gendisk()` to drop the final gendisk
+        // reference and trigger the remaining release path.
+        unsafe { bindings::put_disk(self.gendisk) };
     }
 }
-- 
2.53.0


