Return-Path: <stable+bounces-8727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6AC820471
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 11:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41ACA282242
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 10:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD97C20EA;
	Sat, 30 Dec 2023 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ob842dBS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970372561
	for <stable@vger.kernel.org>; Sat, 30 Dec 2023 10:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3F3C433C7;
	Sat, 30 Dec 2023 10:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703933952;
	bh=jIORobKuGgvPw6tqYk6vUBq0/pTO+6qRqqqUzNgrrrc=;
	h=Subject:To:Cc:From:Date:From;
	b=Ob842dBSWlnhmZsOzGN1BG8cPAiOB0dGsEQ9b1sZ5CvocMp6R8kty39FpjwaVxzQa
	 5oHWB7Pa440hRLvGOB3jENNMAlkcafZLj/QJfqjkKwlYwyKQdtMRJ0DZ0Qxpsh5q9O
	 KDrUYpuDW3AlDX7s8D3sF4p5RdzmJt7RStPQB1sY=
Subject: FAILED: patch "[PATCH] dm-integrity: don't modify bio's immutable bio_vec in" failed to apply to 4.19-stable tree
To: mpatocka@redhat.com,snitzer@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Dec 2023 10:59:04 +0000
Message-ID: <2023123004-pureblood-slug-3312@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x b86f4b790c998afdbc88fe1aa55cfe89c4068726
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023123004-pureblood-slug-3312@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

b86f4b790c99 ("dm-integrity: don't modify bio's immutable bio_vec in integrity_metadata()")
86a3238c7b9b ("dm: change "unsigned" to "unsigned int"")
7533afa1d27b ("dm: send just one event on resize, not two")
5cd6d1d53a1f ("dm integrity: Remove bi_sector that's only used by commented debug code")
22c40e134c4c ("dm cache: Add some documentation to dm-cache-background-tracker.h")
86e4d3e8d183 ("dm-crypt: provide dma_alignment limit in io_hints")
c3adefb5baf3 ("Merge tag 'for-6.0/dm-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b86f4b790c998afdbc88fe1aa55cfe89c4068726 Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 5 Dec 2023 16:39:16 +0100
Subject: [PATCH] dm-integrity: don't modify bio's immutable bio_vec in
 integrity_metadata()

__bio_for_each_segment assumes that the first struct bio_vec argument
doesn't change - it calls "bio_advance_iter_single((bio), &(iter),
(bvl).bv_len)" to advance the iterator. Unfortunately, the dm-integrity
code changes the bio_vec with "bv.bv_len -= pos". When this code path
is taken, the iterator would be out of sync and dm-integrity would
report errors. This happens if the machine is out of memory and
"kmalloc" fails.

Fix this bug by making a copy of "bv" and changing the copy instead.

Fixes: 7eada909bfd7 ("dm: add integrity target")
Cc: stable@vger.kernel.org	# v4.12+
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index e85c688fd91e..c5f03aab4552 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1755,11 +1755,12 @@ static void integrity_metadata(struct work_struct *w)
 		sectors_to_process = dio->range.n_sectors;
 
 		__bio_for_each_segment(bv, bio, iter, dio->bio_details.bi_iter) {
+			struct bio_vec bv_copy = bv;
 			unsigned int pos;
 			char *mem, *checksums_ptr;
 
 again:
-			mem = bvec_kmap_local(&bv);
+			mem = bvec_kmap_local(&bv_copy);
 			pos = 0;
 			checksums_ptr = checksums;
 			do {
@@ -1768,7 +1769,7 @@ static void integrity_metadata(struct work_struct *w)
 				sectors_to_process -= ic->sectors_per_block;
 				pos += ic->sectors_per_block << SECTOR_SHIFT;
 				sector += ic->sectors_per_block;
-			} while (pos < bv.bv_len && sectors_to_process && checksums != checksums_onstack);
+			} while (pos < bv_copy.bv_len && sectors_to_process && checksums != checksums_onstack);
 			kunmap_local(mem);
 
 			r = dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio->metadata_offset,
@@ -1793,9 +1794,9 @@ static void integrity_metadata(struct work_struct *w)
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


