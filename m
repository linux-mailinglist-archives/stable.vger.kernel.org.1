Return-Path: <stable+bounces-241820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIGRD+KY8WnHigEAu9opvQ
	(envelope-from <stable+bounces-241820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:36:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D216C48F71E
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D586630330BB
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 05:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C037B221F39;
	Wed, 29 Apr 2026 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8AxRF/v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8476D154425
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777440989; cv=none; b=QiIpdLHSs9BEkEDy+edFhtV0+i1HEZ7tuijS0dWjyxhSiGcAA4uwjgrc99Y5FU/61JJDxFoiAUp4iL4tYFZ4S7G8BG71GjuOAWGqhDPghIWCu6KWmTQB9XcMvE+tFU8Igndpx0pjLPY7kyZlxUeS8ENHvKeEEIOuzBWYzNxPvGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777440989; c=relaxed/simple;
	bh=2KLYQ+/nzcxFy3oHDOjcuC2Zhda82OP3HdqVhiEL/Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZF9rQVISGMbEIKtp9RMmc8SbOcauMyREGqW9etBtySszCoSE2U1xd+2SE1ObEg6eQ1wFd0JdOADEajf3jfZTcoBluHa/xzEY8EYLI6vkxm5MBMpX0FS8qrCCfZzX3sddf7ewvf5NhCzGi5N/F9rHkv2pnb8JIFw5bqz7wnthfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8AxRF/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1882EC2BCC4;
	Wed, 29 Apr 2026 05:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777440989;
	bh=2KLYQ+/nzcxFy3oHDOjcuC2Zhda82OP3HdqVhiEL/Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X8AxRF/vhk6838X2yVI/pCJM2peXtcFAOeEJXdOgTf1UnGASbaLd6ijkfm5B4PUJg
	 Oxv46ZjiRMhsUmUwRJna3flp5W5m+MY7yzqoI2JzPWZ7K77y6w7mY6TWB8iRBikieF
	 wOytqBcGICacqVn/YuJaaA9bHL4nCOL0U8Y/nxd9/tRi2kRwm0AmdtdNsEBM5pf8j7
	 TQhY0zb8i2qJWJ+efqDD6T96By3Zv0UrFlaIjgjCVIKOY/s+yOjT/gMWLb4i7pwqep
	 ggT+589uLH6ti8NFarhgzzyu1bZT8KfWY/loqGJDTjmvx9URTQ5wBZbmiUA1y21WMR
	 jqzZF2qCSYQ1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Bodo Stroesser <bostroesser@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Clemens Ladisch <clemens@ladisch.de>,
	David Hildenbrand <david@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Long Li <longli@microsoft.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Richard Weinberger <richard@nod.at>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Wei Liu <wei.liu@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 2/2] mm: avoid deadlock when holding rmap on mmap_prepare error
Date: Wed, 29 Apr 2026 01:36:20 -0400
Message-ID: <20260429053620.3394030-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429053620.3394030-1-sashal@kernel.org>
References: <2026042747-cardinal-pellet-094f@gregkh>
 <20260429053620.3394030-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D216C48F71E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,foss.st.com,zeniv.linux.org.uk,arndb.de,gmail.com,ladisch.de,redhat.com,microsoft.com,linuxfoundation.org,suse.cz,google.com,lwn.net,oracle.com,auristor.com,suse.com,bootlin.com,suse.de,nod.at,arm.com,ti.com,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_FROM(0.00)[bounces-241820-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.975];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>

[ Upstream commit f96e1d5f15b7c854a6a9ec1225d68a12fe7dcda6 ]

Commit ac0a3fc9c07d ("mm: add ability to take further action in
vm_area_desc") added the ability for drivers to instruct mm to take actions
after the .mmap_prepare callback is complete.

To make life simpler and safer, this is done before the VMA/mmap write lock
is dropped but when the VMA is completely established.

So on error, we simply munmap() the VMA.

As part of this implementation, unfortunately a horrible hack had to be
implemented to support some questionable behaviour hugetlb relies upon -
that is that the file rmap lock is held until the operation is complete.

The implementation, for convenience, did this in mmap_action_finish() so
both the VMA and mmap_prepare compatibility layer paths would have this
correctly handled.

However, it turns out there is a mistake here - the rmap lock cannot be
held on munmap, as free_pgtables() -> unlink_file_vma_batch_add() ->
unlink_file_vma_batch_process() takes the file rmap lock.

We therefore currently have a deadlock issue that might arise.

Resolve this by leaving it to callers to handle the unmap.

The compatibility layer does not support this rmap behaviour, so we simply
have it unmap on error after calling mmap_action_complete().

In the VMA implementation, we only perform the unmap after the rmap lock is
dropped.

This resolves the issue by ensuring the rmap lock is always dropped when
the unmap occurs.

Link: https://lkml.kernel.org/r/d44248be9da68258b07c2c59d4e73485ee0ca943.1774045440.git.ljs@kernel.org
Fixes: ac0a3fc9c07d ("mm: add ability to take further action in vm_area_desc")
Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bodo Stroesser <bostroesser@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: David Hildenbrand <david@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Long Li <longli@microsoft.com>
Cc: Marc Dionne <marc.dionne@auristor.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Richard Weinberger <richard@nod.at>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/util.c | 12 +++++++-----
 mm/vma.c  | 13 ++++++++++---
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 62ddf9eabb1f6..e2a51e3cfb249 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1186,7 +1186,13 @@ int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 		return err;
 
 	set_vma_from_desc(vma, &desc);
-	return mmap_action_complete(vma, &desc.action);
+	err = mmap_action_complete(vma, &desc.action);
+	if (err) {
+		const size_t len = vma_pages(vma) << PAGE_SHIFT;
+
+		do_munmap(current->mm, vma->vm_start, len, NULL);
+	}
+	return err;
 }
 EXPORT_SYMBOL(compat_vma_mmap);
 
@@ -1279,10 +1285,6 @@ static int mmap_action_finish(struct vm_area_struct *vma,
 	 * invoked if we do NOT merge, so we only clean up the VMA we created.
 	 */
 	if (err) {
-		const size_t len = vma_pages(vma) << PAGE_SHIFT;
-
-		do_munmap(current->mm, vma->vm_start, len, NULL);
-
 		if (action->error_hook) {
 			/* We may want to filter the error. */
 			err = action->error_hook(err);
diff --git a/mm/vma.c b/mm/vma.c
index cae154a43f555..3f55bc42e7be5 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2708,9 +2708,9 @@ static int call_action_complete(struct mmap_state *map,
 				struct mmap_action *action,
 				struct vm_area_struct *vma)
 {
-	int ret;
+	int err;
 
-	ret = mmap_action_complete(vma, action);
+	err = mmap_action_complete(vma, action);
 
 	/* If we held the file rmap we need to release it. */
 	if (map->hold_file_rmap_lock) {
@@ -2718,7 +2718,14 @@ static int call_action_complete(struct mmap_state *map,
 
 		i_mmap_unlock_write(file->f_mapping);
 	}
-	return ret;
+
+	if (err) {
+		const size_t len = vma_pages(vma) << PAGE_SHIFT;
+
+		do_munmap(current->mm, vma->vm_start, len, NULL);
+	}
+
+	return err;
 }
 
 static unsigned long __mmap_region(struct file *file, unsigned long addr,
-- 
2.53.0


