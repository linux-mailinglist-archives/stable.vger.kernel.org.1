Return-Path: <stable+bounces-9192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5F7821D6F
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 15:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1AE1C22233
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 14:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81367101FB;
	Tue,  2 Jan 2024 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TILvDLU5"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B668101D5
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704204646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oBg9zO8LMPh/hqPHeXBwu+rh33K3WnQIm65IPufY/3s=;
	b=TILvDLU5QGdPibvkkdHn1DM7MdM6VBqsVQcTMu874mcYVDkOP+VnVec1lxmdvXj2rZF/KC
	Eb1MGiepfE+b9c/c2DfqTqUC18526cWvMEllzncB1jlzXeYf1lIXKqY4aJ/CZ8F1XUGi4E
	50ZSvnQHScprUApz/OFWbQj/P/vQvYY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-zObiPc1COzWJnagyBQGIGw-1; Tue,
 02 Jan 2024 09:10:43 -0500
X-MC-Unique: zObiPc1COzWJnagyBQGIGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE41C29AC00E;
	Tue,  2 Jan 2024 14:10:42 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B8D8051D5;
	Tue,  2 Jan 2024 14:10:42 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id A4A0330C1C03; Tue,  2 Jan 2024 14:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id A1B513FB50;
	Tue,  2 Jan 2024 15:10:42 +0100 (CET)
Date: Tue, 2 Jan 2024 15:10:42 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: gregkh@linuxfoundation.org
cc: snitzer@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] dm-integrity: don't modify bio's immutable
 bio_vec in" failed to apply to 4.14-stable tree
In-Reply-To: <2023123006-koala-satirical-e348@gregkh>
Message-ID: <39b21411-d7f4-5e47-9d4-5ef99bc4967f@redhat.com>
References: <2023123006-koala-satirical-e348@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5



On Sat, 30 Dec 2023, gregkh@linuxfoundation.org wrote:

> 
> The patch below does not apply to the 4.14-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Hi

Here I'm sending backport of the patch
b86f4b790c998afdbc88fe1aa55cfe89c4068726 for the stable branch 4.14.

commit b86f4b790c998afdbc88fe1aa55cfe89c4068726
Author: Mikulas Patocka <mpatocka@redhat.com>
Date:   Tue Dec 5 16:39:16 2023 +0100

    dm-integrity: don't modify bio's immutable bio_vec in integrity_metadata()
    
    __bio_for_each_segment assumes that the first struct bio_vec argument
    doesn't change - it calls "bio_advance_iter_single((bio), &(iter),
    (bvl).bv_len)" to advance the iterator. Unfortunately, the dm-integrity
    code changes the bio_vec with "bv.bv_len -= pos". When this code path
    is taken, the iterator would be out of sync and dm-integrity would
    report errors. This happens if the machine is out of memory and
    "kmalloc" fails.
    
    Fix this bug by making a copy of "bv" and changing the copy instead.
    
    Fixes: 7eada909bfd7 ("dm: add integrity target")
    Cc: stable@vger.kernel.org      # v4.12+
    Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
    Signed-off-by: Mike Snitzer <snitzer@kernel.org>

---
 drivers/md/dm-integrity.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: linux-stable/drivers/md/dm-integrity.c
===================================================================
--- linux-stable.orig/drivers/md/dm-integrity.c
+++ linux-stable/drivers/md/dm-integrity.c
@@ -1257,11 +1257,12 @@ static void integrity_metadata(struct wo
 			checksums = checksums_onstack;
 
 		__bio_for_each_segment(bv, bio, iter, dio->orig_bi_iter) {
+			struct bio_vec bv_copy = bv;
 			unsigned pos;
 			char *mem, *checksums_ptr;
 
 again:
-			mem = (char *)kmap_atomic(bv.bv_page) + bv.bv_offset;
+			mem = (char *)kmap_atomic(bv_copy.bv_page) + bv_copy.bv_offset;
 			pos = 0;
 			checksums_ptr = checksums;
 			do {
@@ -1270,7 +1271,7 @@ again:
 				sectors_to_process -= ic->sectors_per_block;
 				pos += ic->sectors_per_block << SECTOR_SHIFT;
 				sector += ic->sectors_per_block;
-			} while (pos < bv.bv_len && sectors_to_process && checksums != checksums_onstack);
+			} while (pos < bv_copy.bv_len && sectors_to_process && checksums != checksums_onstack);
 			kunmap_atomic(mem);
 
 			r = dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio->metadata_offset,
@@ -1290,9 +1291,9 @@ again:
 			if (!sectors_to_process)
 				break;
 
-			if (unlikely(pos < bv.bv_len)) {
-				bv.bv_offset += pos;
-				bv.bv_len -= pos;
+			if (unlikely(pos < bv_copy.bv_len)) {
+				bv_copy.bv_offset += pos;
+				bv_copy.bv_len -= pos;
 				goto again;
 			}
 		}


