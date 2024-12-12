Return-Path: <stable+bounces-101116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCDD9EEA65
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75635280D13
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6132D217707;
	Thu, 12 Dec 2024 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p0UA36lE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136FF21766D;
	Thu, 12 Dec 2024 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016415; cv=none; b=RCpfx6CWOcYdrCL3Bhm6N+v+KU4tIZ7xCJujMKBGa0TZFgRq7J3NwBrUZYw+/z0kWuz02ZdHWssotQMibZEdfnpF3q4Q8NkWFj8ZU7qyPFFQEqP/1IeO29YAvaU5rl861ukI/J1A8kBpDIzpcU6Djini5rAM3IfMLxPGVTsMKm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016415; c=relaxed/simple;
	bh=nbYBYQeX6Vx9TS5XyJKadgqip5Z5TSDAqkB0INzEhLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9wM7/45IVdrMOzW0tiPUwGf0RA5/y4JT2gneSW7ZjG1Onu7pxN804SYTrhL6IFfu4OYperrzH4dIyZtylG2+BTqeEzZr9s6zRPfrUh3kojZZBEUx2oVCWhyj25WHLDIX1P2B302O7qrZ5s+PNrIjsdVAnl5t3djVnpuJMq94zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p0UA36lE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E82C4CED0;
	Thu, 12 Dec 2024 15:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734016414;
	bh=nbYBYQeX6Vx9TS5XyJKadgqip5Z5TSDAqkB0INzEhLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0UA36lEln7LN6eRbwTDztKMVJbV3UR7+vHFnyzSaSY21hVWGwbXs5nY3UG2FcsAq
	 qbYhh8d5nnfO5fk+0lMiB3rmjfYsMBwxY/QGiS8VE9K1j2YF5MNJ7hTSLXLvRxPlxJ
	 1U1JmW42Zet8ITz6SzJxoXAWozM4sqEk5ij4+s+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anders Blomdell <anders.blomdell@gmail.com>,
	Philippe Troin <phil@fifi.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 162/466] Revert "readahead: properly shorten readahead when falling back to do_page_cache_ra()"
Date: Thu, 12 Dec 2024 15:55:31 +0100
Message-ID: <20241212144313.202242815@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit a220d6b95b1ae12c7626283d7609f0a1438e6437 upstream.

This reverts commit 7c877586da3178974a8a94577b6045a48377ff25.

Anders and Philippe have reported that recent kernels occasionally hang
when used with NFS in readahead code.  The problem has been bisected to
7c877586da3 ("readahead: properly shorten readahead when falling back to
do_page_cache_ra()").  The cause of the problem is that ra->size can be
shrunk by read_pages() call and subsequently we end up calling
do_page_cache_ra() with negative (read huge positive) number of pages.
Let's revert 7c877586da3 for now until we can find a proper way how the
logic in read_pages() and page_cache_ra_order() can coexist.  This can
lead to reduced readahead throughput due to readahead window confusion but
that's better than outright hangs.

Link: https://lkml.kernel.org/r/20241126145208.985-1-jack@suse.cz
Fixes: 7c877586da31 ("readahead: properly shorten readahead when falling back to do_page_cache_ra()")
Reported-by: Anders Blomdell <anders.blomdell@gmail.com>
Reported-by: Philippe Troin <phil@fifi.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Tested-by: Philippe Troin <phil@fifi.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/readahead.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -453,8 +453,7 @@ void page_cache_ra_order(struct readahea
 		struct file_ra_state *ra, unsigned int new_order)
 {
 	struct address_space *mapping = ractl->mapping;
-	pgoff_t start = readahead_index(ractl);
-	pgoff_t index = start;
+	pgoff_t index = readahead_index(ractl);
 	unsigned int min_order = mapping_min_folio_order(mapping);
 	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
 	pgoff_t mark = index + ra->size - ra->async_size;
@@ -517,7 +516,7 @@ void page_cache_ra_order(struct readahea
 	if (!err)
 		return;
 fallback:
-	do_page_cache_ra(ractl, ra->size - (index - start), ra->async_size);
+	do_page_cache_ra(ractl, ra->size, ra->async_size);
 }
 
 static unsigned long ractl_max_pages(struct readahead_control *ractl,



