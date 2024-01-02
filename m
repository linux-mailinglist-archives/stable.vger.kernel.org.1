Return-Path: <stable+bounces-9191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EDA821D6B
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 15:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039361F22C34
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B77E101CF;
	Tue,  2 Jan 2024 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPkZ4ZGy"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD591172D
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704204507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JpAu6h+HZXArju44AbXVGnOwWcQV+dpsQ3lrBqSYO/k=;
	b=MPkZ4ZGyrO7gVxo76RMk672rJCgehzxppDkZ4IlNBkiuaBSvJqv6NcpxOIcw8zJir3XjCx
	0+XJ1ErkLATo8egfjRh3Ue+PlWWCmN0O4HJPk/Yl0b2UibZBv9z5rgdDB7KnF302MdfljW
	5LBvJISVaY2SVd6jQz22WsXTRVMkxBE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-Vb-Af4DNNEecCNvVDYv6yQ-1; Tue,
 02 Jan 2024 09:08:25 -0500
X-MC-Unique: Vb-Af4DNNEecCNvVDYv6yQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5075B1C0512A;
	Tue,  2 Jan 2024 14:08:25 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4812B3C25;
	Tue,  2 Jan 2024 14:08:25 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 32E2D30C1C03; Tue,  2 Jan 2024 14:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 2F6AE3FB50;
	Tue,  2 Jan 2024 15:08:25 +0100 (CET)
Date: Tue, 2 Jan 2024 15:08:25 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: gregkh@linuxfoundation.org
cc: snitzer@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] dm-integrity: don't modify bio's immutable
 bio_vec in" failed to apply to 5.15-stable tree
In-Reply-To: <2023123001-profusely-reassign-059b@gregkh>
Message-ID: <7617f0c7-669d-e33e-60cb-b216789014b2@redhat.com>
References: <2023123001-profusely-reassign-059b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1



On Sat, 30 Dec 2023, gregkh@linuxfoundation.org wrote:

> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Hi

Here I'm sending backport of the patch 
b86f4b790c998afdbc88fe1aa55cfe89c4068726 for the stable branches 4.19 to 
5.15.

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
@@ -1762,11 +1762,12 @@ static void integrity_metadata(struct wo
 		sectors_to_process = dio->range.n_sectors;
 
 		__bio_for_each_segment(bv, bio, iter, dio->bio_details.bi_iter) {
+			struct bio_vec bv_copy = bv;
 			unsigned pos;
 			char *mem, *checksums_ptr;
 
 again:
-			mem = (char *)kmap_atomic(bv.bv_page) + bv.bv_offset;
+			mem = (char *)kmap_atomic(bv_copy.bv_page) + bv_copy.bv_offset;
 			pos = 0;
 			checksums_ptr = checksums;
 			do {
@@ -1775,7 +1776,7 @@ again:
 				sectors_to_process -= ic->sectors_per_block;
 				pos += ic->sectors_per_block << SECTOR_SHIFT;
 				sector += ic->sectors_per_block;
-			} while (pos < bv.bv_len && sectors_to_process && checksums != checksums_onstack);
+			} while (pos < bv_copy.bv_len && sectors_to_process && checksums != checksums_onstack);
 			kunmap_atomic(mem);
 
 			r = dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio->metadata_offset,
@@ -1796,9 +1797,9 @@ again:
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


