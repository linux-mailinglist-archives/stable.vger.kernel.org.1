Return-Path: <stable+bounces-216165-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKPwNVstj2kPKwEAu9opvQ
	(envelope-from <stable+bounces-216165-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:55:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4588D136BCD
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF17C30829B9
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B729C35F8D4;
	Fri, 13 Feb 2026 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VjA93csp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7954723;
	Fri, 13 Feb 2026 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990851; cv=none; b=DBGTZxuEkXiCfiipSibLG2Pgl0QYAovJ+cbNBtfMndpiI6seghuD25qeH2JPFM+fxLMyoyXzxaY3Xbi2VlcOWfMniVNtiMbZw4yJhI7YqBg9sKOoyURfd9C2BDONhuqhi29tK0bHrursoo54Nx22WXR5Ciky2051XwBPDWlqGTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990851; c=relaxed/simple;
	bh=HPvI2NOyD9ft2wxbxYQeGVRaTYqXPC7azW7FiRcxM64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byKQpNLIZppsr8zqdIfYnLWYEjiDI4tWem0ZE0Uuzoz6AAASI4oFiwg3HYDroh8OJeeZjI0Jdcw5GiXGQN+L+FhRQ8iSfu4iR67OY8YRSEG5OsMyGbGaGoYvvkv3U0UjHlxKa1+aDKLdcT2/irrZTWmRFwb/YLyTbcIM+fiXE68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VjA93csp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9259C116C6;
	Fri, 13 Feb 2026 13:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990851;
	bh=HPvI2NOyD9ft2wxbxYQeGVRaTYqXPC7azW7FiRcxM64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VjA93cspsuG95qzgZ9IqbHVfOTA8smkkHdaFgKKskFWS9Kx6OAxfBELmhtTM7EG1A
	 G3weacMAAlmY8HL1eaK9IlGDgm29yhZgRXrKeU7opisBWkezxliLT/kdjgZn93pkJK
	 0hY8DVuN0KgsVJHhrxuJ17k0VpsJaLH9aZ0G9TMc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6.18 44/49] erofs: fix UAF issue for file-backed mounts w/ directio option
Date: Fri, 13 Feb 2026 14:48:28 +0100
Message-ID: <20260213134710.476983411@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134708.885500854@linuxfoundation.org>
References: <20260213134708.885500854@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216165-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 4588D136BCD
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

commit 1caf50ce4af096d0280d59a31abdd85703cd995c upstream.

[    9.269940][ T3222] Call trace:
[    9.269948][ T3222]  ext4_file_read_iter+0xac/0x108
[    9.269979][ T3222]  vfs_iocb_iter_read+0xac/0x198
[    9.269993][ T3222]  erofs_fileio_rq_submit+0x12c/0x180
[    9.270008][ T3222]  erofs_fileio_submit_bio+0x14/0x24
[    9.270030][ T3222]  z_erofs_runqueue+0x834/0x8ac
[    9.270054][ T3222]  z_erofs_read_folio+0x120/0x220
[    9.270083][ T3222]  filemap_read_folio+0x60/0x120
[    9.270102][ T3222]  filemap_fault+0xcac/0x1060
[    9.270119][ T3222]  do_pte_missing+0x2d8/0x1554
[    9.270131][ T3222]  handle_mm_fault+0x5ec/0x70c
[    9.270142][ T3222]  do_page_fault+0x178/0x88c
[    9.270167][ T3222]  do_translation_fault+0x38/0x54
[    9.270183][ T3222]  do_mem_abort+0x54/0xac
[    9.270208][ T3222]  el0_da+0x44/0x7c
[    9.270227][ T3222]  el0t_64_sync_handler+0x5c/0xf4
[    9.270253][ T3222]  el0t_64_sync+0x1bc/0x1c0

EROFS may encounter above panic when enabling file-backed mount w/
directio mount option, the root cause is it may suffer UAF in below
race condition:

- z_erofs_read_folio                          wq s_dio_done_wq
 - z_erofs_runqueue
  - erofs_fileio_submit_bio
   - erofs_fileio_rq_submit
    - vfs_iocb_iter_read
     - ext4_file_read_iter
      - ext4_dio_read_iter
       - iomap_dio_rw
       : bio was submitted and return -EIOCBQUEUED
                                              - dio_aio_complete_work
                                               - dio_complete
                                                - dio->iocb->ki_complete (erofs_fileio_ki_complete())
                                                 - kfree(rq)
                                                 : it frees iocb, iocb.ki_filp can be UAF in file_accessed().
       - file_accessed
       : access NULL file point

Introduce a reference count in struct erofs_fileio_rq, and initialize it
as two, both erofs_fileio_ki_complete() and erofs_fileio_rq_submit() will
decrease reference count, the last one decreasing the reference count
to zero will free rq.

Cc: stable@kernel.org
Fixes: fb176750266a ("erofs: add file-backed mount support")
Fixes: 6422cde1b0d5 ("erofs: use buffered I/O for file-backed mounts by default")
Signed-off-by: Chao Yu <chao@kernel.org>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/fileio.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -10,6 +10,7 @@ struct erofs_fileio_rq {
 	struct bio bio;
 	struct kiocb iocb;
 	struct super_block *sb;
+	refcount_t ref;
 };
 
 struct erofs_fileio {
@@ -42,7 +43,8 @@ static void erofs_fileio_ki_complete(str
 		}
 	}
 	bio_uninit(&rq->bio);
-	kfree(rq);
+	if (refcount_dec_and_test(&rq->ref))
+		kfree(rq);
 }
 
 static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
@@ -66,6 +68,8 @@ static void erofs_fileio_rq_submit(struc
 	revert_creds(old_cred);
 	if (ret != -EIOCBQUEUED)
 		erofs_fileio_ki_complete(&rq->iocb, ret);
+	if (refcount_dec_and_test(&rq->ref))
+		kfree(rq);
 }
 
 static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
@@ -76,6 +80,7 @@ static struct erofs_fileio_rq *erofs_fil
 	bio_init(&rq->bio, NULL, rq->bvecs, ARRAY_SIZE(rq->bvecs), REQ_OP_READ);
 	rq->iocb.ki_filp = mdev->m_dif->file;
 	rq->sb = mdev->m_sb;
+	refcount_set(&rq->ref, 2);
 	return rq;
 }
 



