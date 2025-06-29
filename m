Return-Path: <stable+bounces-158840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 906EFAECC9B
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 14:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB7D1890EB4
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 12:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1691DE3A5;
	Sun, 29 Jun 2025 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uXgRYiyW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00AEEA9
	for <stable@vger.kernel.org>; Sun, 29 Jun 2025 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751201137; cv=none; b=QwLQoQIxscN1ozBEmc00fb2zSYUWctLYXRO458rx1/iQwf7dy30SMoZy1Q6wrpuwnYkIO8UAXMOsLkRTNvV9wAr27Pu3yUb9n+Nfh4KDUYrnDcVSqsuczj1fY14VQZjo9ntpUlgx+doeUb8rQ0Wuq0goDgBc+sd34UZviFej5EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751201137; c=relaxed/simple;
	bh=r3K3ak18tKhWZ8bdbK51CuJLEqNjkqxxUpnB1ITWVyM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gVF+/DEAVlba+XzyIAApEMDD7xofW01IVX6nronrGxnaFSrjWPoiniuYHS/jl4Zp9oj42gEx6tNy97gkLaQKwLes1fdoaSqvcPS6oWjbrT/Mm9evSaaCkGZ839UETQg16+nUQQ0t/I/lGJINCKobQkx3f0Tn1NHlrvc7pz2OUzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uXgRYiyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4046EC4CEEB;
	Sun, 29 Jun 2025 12:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751201136;
	bh=r3K3ak18tKhWZ8bdbK51CuJLEqNjkqxxUpnB1ITWVyM=;
	h=Subject:To:Cc:From:Date:From;
	b=uXgRYiyWSgQGj1pyKHqVmKXd2RXUXL2RLFB3CIKiFn4E265BVTHh9kYmvB9BUo2Ux
	 5ACQ4uyBjbQzusQLSB5gLRxDrnfd0P28eHwcPR7bKzWrBVT0flOyTCxPYFogq+STjL
	 mjCSc7nyA57XXdCzUmiAqN1oKK/+45wkZHclRg4U=
Subject: FAILED: patch "[PATCH] io_uring/rsrc: don't rely on user vaddr alignment" failed to apply to 6.12-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk,david@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Jun 2025 14:42:02 +0200
Message-ID: <2025062902-emphasize-calzone-a702@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 3a3c6d61577dbb23c09df3e21f6f9eda1ecd634b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062902-emphasize-calzone-a702@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a3c6d61577dbb23c09df3e21f6f9eda1ecd634b Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Tue, 24 Jun 2025 14:40:34 +0100
Subject: [PATCH] io_uring/rsrc: don't rely on user vaddr alignment

There is no guaranteed alignment for user pointers, however the
calculation of an offset of the first page into a folio after coalescing
uses some weird bit mask logic, get rid of it.

Cc: stable@vger.kernel.org
Reported-by: David Hildenbrand <david@redhat.com>
Fixes: a8edbb424b139 ("io_uring/rsrc: enable multi-hugepage buffer coalescing")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/io-uring/e387b4c78b33f231105a601d84eefd8301f57954.1750771718.git.asml.silence@gmail.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 0c09e38784c9..afc67530f912 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -734,6 +734,7 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
 
 	data->nr_pages_mid = folio_nr_pages(folio);
 	data->folio_shift = folio_shift(folio);
+	data->first_folio_page_idx = folio_page_idx(folio, page_array[0]);
 
 	/*
 	 * Check if pages are contiguous inside a folio, and all folios have
@@ -827,7 +828,11 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	if (coalesced)
 		imu->folio_shift = data.folio_shift;
 	refcount_set(&imu->refs, 1);
-	off = (unsigned long) iov->iov_base & ((1UL << imu->folio_shift) - 1);
+
+	off = (unsigned long)iov->iov_base & ~PAGE_MASK;
+	if (coalesced)
+		off += data.first_folio_page_idx << PAGE_SHIFT;
+
 	node->buf = imu;
 	ret = 0;
 
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 0d2138f16322..25e7e998dcfd 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -49,6 +49,7 @@ struct io_imu_folio_data {
 	unsigned int	nr_pages_mid;
 	unsigned int	folio_shift;
 	unsigned int	nr_folios;
+	unsigned long	first_folio_page_idx;
 };
 
 bool io_rsrc_cache_init(struct io_ring_ctx *ctx);


