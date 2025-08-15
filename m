Return-Path: <stable+bounces-169732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3534B282E9
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 187F24E0EE4
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 15:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7042C15B9;
	Fri, 15 Aug 2025 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nmdH/Eiu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1123B2C0F9B
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271591; cv=none; b=kXokHkTK/kkpx0yCPDbPcofU/Katq7+jujXvHImkMJBN7RhDqBGhyY8v1WYRO2KAuoJOfaQqd8eYK81/uoO4Hr8NM3viO9IPbjqVTWbWKM8QEeWzamJ9Gk7ujDMfchGtVh34o+UmhjgOXmFXFhgK5ECQyw0p0ht7p8sfOY26hBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271591; c=relaxed/simple;
	bh=onUEwVah4EjiiupKmsGRJ6JrFLLoTwDV3cZFP2nsRzw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L+pGASqA8ROxKYBJ4fsSZErnulMEcRnhOrFvtQ1a+BBwULYmLzhDDC+BMFAPCfhuJNbn4tk1Dr6qE2+rcgl3lFAyebFFw95WLupWUZ92Z0Y2Oruf97mJ0dlCXB5gJcsFrN2ZI5mAnTAgnM5MhTbiSFY2iQodZ98qLO0Oy5U1OXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nmdH/Eiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B58C4CEF4;
	Fri, 15 Aug 2025 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755271590;
	bh=onUEwVah4EjiiupKmsGRJ6JrFLLoTwDV3cZFP2nsRzw=;
	h=Subject:To:Cc:From:Date:From;
	b=nmdH/EiuceMEoV5pZYN/2A+Jn2vU19j4uusgnECcl74dLNrHrAyvXr7rLNyuHztSK
	 Cmskcwd8fQGBlhlhasq0ZLBbo/duqJp8tIrXTfa4BQaNc0nE7yAKOr6FMVizPXY/AD
	 apCxVtpQj+myrD45U94IT6qFL0LHXlbcPvoC5vOA=
Subject: FAILED: patch "[PATCH] io_uring/zcrx: account area memory" failed to apply to 6.15-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Aug 2025 17:26:27 +0200
Message-ID: <2025081527-unflawed-matrimony-2057@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 262ab205180d2ba3ab6110899a4dbe439c51dfaa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081527-unflawed-matrimony-2057@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 262ab205180d2ba3ab6110899a4dbe439c51dfaa Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Wed, 16 Jul 2025 22:04:09 +0100
Subject: [PATCH] io_uring/zcrx: account area memory

zcrx areas can be quite large and need to be accounted and checked
against RLIMIT_MEMLOCK. In practise it shouldn't be a big issue as
the inteface already requires cap_net_admin.

Cc: stable@vger.kernel.org
Fixes: cf96310c5f9a0 ("io_uring/zcrx: add io_zcrx_area")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/4b53f0c575bd062f63d12bec6cac98037fc66aeb.1752699568.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 7d7396ce876c..dabce3ee0e8b 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -158,6 +158,23 @@ static int io_zcrx_map_area_dmabuf(struct io_zcrx_ifq *ifq, struct io_zcrx_area
 				    area->mem.dmabuf_offset);
 }
 
+static unsigned long io_count_account_pages(struct page **pages, unsigned nr_pages)
+{
+	struct folio *last_folio = NULL;
+	unsigned long res = 0;
+	int i;
+
+	for (i = 0; i < nr_pages; i++) {
+		struct folio *folio = page_folio(pages[i]);
+
+		if (folio == last_folio)
+			continue;
+		last_folio = folio;
+		res += 1UL << folio_order(folio);
+	}
+	return res;
+}
+
 static int io_import_umem(struct io_zcrx_ifq *ifq,
 			  struct io_zcrx_mem *mem,
 			  struct io_uring_zcrx_area_reg *area_reg)
@@ -180,6 +197,13 @@ static int io_import_umem(struct io_zcrx_ifq *ifq,
 	if (ret)
 		return ret;
 
+	mem->account_pages = io_count_account_pages(pages, nr_pages);
+	ret = io_account_mem(ifq->ctx, mem->account_pages);
+	if (ret < 0) {
+		mem->account_pages = 0;
+		return ret;
+	}
+
 	mem->pages = pages;
 	mem->nr_folios = nr_pages;
 	mem->size = area_reg->len;
@@ -357,6 +381,9 @@ static void io_zcrx_free_area(struct io_zcrx_area *area)
 		io_zcrx_unmap_area(area->ifq, area);
 	io_release_area_mem(&area->mem);
 
+	if (area->mem.account_pages)
+		io_unaccount_mem(area->ifq->ctx, area->mem.account_pages);
+
 	kvfree(area->freelist);
 	kvfree(area->nia.niovs);
 	kvfree(area->user_refs);
diff --git a/io_uring/zcrx.h b/io_uring/zcrx.h
index 89015b923911..109c4ca36434 100644
--- a/io_uring/zcrx.h
+++ b/io_uring/zcrx.h
@@ -15,6 +15,7 @@ struct io_zcrx_mem {
 	struct page			**pages;
 	unsigned long			nr_folios;
 	struct sg_table			page_sg_table;
+	unsigned long			account_pages;
 
 	struct dma_buf_attachment	*attach;
 	struct dma_buf			*dmabuf;


