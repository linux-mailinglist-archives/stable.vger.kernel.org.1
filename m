Return-Path: <stable+bounces-243392-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC3QCYmp+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243392-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:13:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E43C74BED73
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB1B3301570F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FC23AA4F8;
	Mon,  4 May 2026 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xrv9i8Sn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7E40DFD4;
	Mon,  4 May 2026 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903765; cv=none; b=iOEpU3cUzeo7VTRbswIOt+uIHl3AlmiOjZh/fCkiURKXie7LTxpJQI4TYL3xKVXX2FUVgbjfnDyH3Rgs+n2Rq5agnabFm8GMuWxJuYY7xn4vzrW99oN2UFB/NASFHm6LY5FeyGoWCNDRRO2zGhqftHfOTiUejtk1yseyVBRWbaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903765; c=relaxed/simple;
	bh=ySTLiwQZy0i6oGAwOdKsvH5ZKUDe9aisydXA7ybl+IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0RIT1TsCwivsZc2K9lmc7fZ34XHxILgxNfGq93Ehmf9yhRAuRX0eEGR0+aECPDvhXnbEOZf9PsLhW2qFKIMGOMmeSeyIvkLJcF1Rg+1I1dE2dNwsYBjw6L0/LWAArcHF+jFPRjHwTaaxD95WFCYFyQstMgD5rbyK5Yfk0ZlE0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xrv9i8Sn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3396AC2BCB8;
	Mon,  4 May 2026 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903765;
	bh=ySTLiwQZy0i6oGAwOdKsvH5ZKUDe9aisydXA7ybl+IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xrv9i8SnszLUnMuKd7cI1OgQQsNPxwhXr8wSYakSb1ln7of6KcLTvbFcx2uNHxFPr
	 gNAUbNC9XmVFFRcrFh4RpCvYGGGM8ZBIQMDDRcWc8WtTEiWDQE+dAFw6Bjolzxbc12
	 an1N0/llqxWVqfH4K8O8zqZGbHyol9W++JQymkrQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
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
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18 021/275] fs: afs: revert mmap_prepare() change
Date: Mon,  4 May 2026 15:49:21 +0200
Message-ID: <20260504135143.725105434@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: E43C74BED73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_FROM(0.00)[bounces-243392-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,linux.intel.com,foss.st.com,zeniv.linux.org.uk,arndb.de,gmail.com,ladisch.de,redhat.com,microsoft.com,suse.cz,google.com,lwn.net,oracle.com,auristor.com,suse.com,bootlin.com,suse.de,nod.at,arm.com,ti.com,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

commit fbfc6578eaca12daa0c09df1e9ba7f2c657b49da upstream.

Partially reverts commit 9d5403b1036c ("fs: convert most other
generic_file_*mmap() users to .mmap_prepare()").

This is because the .mmap invocation establishes a refcount, but
.mmap_prepare is called at a point where a merge or an allocation failure
might happen after the call, which would leak the refcount increment.

Functionality is being added to permit the use of .mmap_prepare in this
case, but in the interim, we need to fix this.

Link: https://lkml.kernel.org/r/08804c94e39d9102a3a8fbd12385e8aa079ba1d3.1774045440.git.ljs@kernel.org
Fixes: 9d5403b1036c ("fs: convert most other generic_file_*mmap() users to .mmap_prepare()")
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/afs/file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index f609366fd2ac..74d04af51ff4 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -19,7 +19,7 @@
 #include <trace/events/netfs.h>
 #include "internal.h"
 
-static int afs_file_mmap_prepare(struct vm_area_desc *desc);
+static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
 
 static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 static ssize_t afs_file_splice_read(struct file *in, loff_t *ppos,
@@ -35,7 +35,7 @@ const struct file_operations afs_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= afs_file_read_iter,
 	.write_iter	= netfs_file_write_iter,
-	.mmap_prepare	= afs_file_mmap_prepare,
+	.mmap		= afs_file_mmap,
 	.splice_read	= afs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fsync		= afs_fsync,
@@ -492,16 +492,16 @@ static void afs_drop_open_mmap(struct afs_vnode *vnode)
 /*
  * Handle setting up a memory mapping on an AFS file.
  */
-static int afs_file_mmap_prepare(struct vm_area_desc *desc)
+static int afs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(desc->file));
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	int ret;
 
 	afs_add_open_mmap(vnode);
 
-	ret = generic_file_mmap_prepare(desc);
+	ret = generic_file_mmap(file, vma);
 	if (ret == 0)
-		desc->vm_ops = &afs_vm_ops;
+		vma->vm_ops = &afs_vm_ops;
 	else
 		afs_drop_open_mmap(vnode);
 	return ret;
-- 
2.54.0




