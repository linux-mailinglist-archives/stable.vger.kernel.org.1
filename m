Return-Path: <stable+bounces-125929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 937FBA6DED2
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2D016B5A9
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D1025FA13;
	Mon, 24 Mar 2025 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rAs7zD9w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD038143736
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830421; cv=none; b=k6ZaA3jbqIvuDCbjHNp4pNpiUZa7dF+q13TVjd6Ev1sK2Ht8jClbSNkn73W/ihRmsWG5wRvrqJ89YQnIQ7pncrtdeNrrwokpTT1Io8PUELt44l/mjkpzfHDybt2qh9NFMtP6BTze1TS9Ioum5pO/Mo6zLJ7iVGkCiPtH+vbNOmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830421; c=relaxed/simple;
	bh=LapOABVf2whraWJzpt4ChqhKL1CqgD028VmLHI6UAZI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S7oGdGojZ+vWjtAFZnvQkKbQWCau7OjJDcT9waDnZpwsn7Gti6/lD6XzF/MBaUuA8TVexzl6kzPYfYSuG3mFXaEsBZuWUZJfK69I88qpTa1OiIB3ZYL8SEJKd2EJeWuz8iI+PXvSc/xznF6v8GirmGBpb/mPOvni2aHb7idFUWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rAs7zD9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186ADC4CEDD;
	Mon, 24 Mar 2025 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830420;
	bh=LapOABVf2whraWJzpt4ChqhKL1CqgD028VmLHI6UAZI=;
	h=Subject:To:Cc:From:Date:From;
	b=rAs7zD9wZ+ZvvEfn8ezbLgI/PB71AXN6/FmP9Ps/k1/kxT1lWy0EbVmbMHsZmYEC6
	 ysa5bCo5hoKphPD8z20TKLMrPaMaX/kgkcLeJDVUWzTKoMDDDtLXQKQjFV3ByHeuPm
	 KecBBGGox1eJeRPFOe/kZOYc1orBR6EgUIi6C0NE=
Subject: FAILED: patch "[PATCH] mm/page_alloc: fix memory accept before watermarks gets" failed to apply to 6.6-stable tree
To: kirill.shutemov@linux.intel.com,akpm@linux-foundation.org,ashish.kalra@amd.com,david@redhat.com,farrah.chen@intel.com,mgorman@techsingularity.net,pankaj.gupta@amd.com,rick.p.edgecombe@intel.com,rppt@kernel.org,stable@vger.kernel.org,thomas.lendacky@amd.com,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:32:17 -0700
Message-ID: <2025032417-prior-uncooked-bf1f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 800f1059c99e2b39899bdc67a7593a7bea6375d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032417-prior-uncooked-bf1f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 800f1059c99e2b39899bdc67a7593a7bea6375d8 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Mon, 10 Mar 2025 10:28:55 +0200
Subject: [PATCH] mm/page_alloc: fix memory accept before watermarks gets
 initialized

Watermarks are initialized during the postcore initcall.  Until then, all
watermarks are set to zero.  This causes cond_accept_memory() to
incorrectly skip memory acceptance because a watermark of 0 is always met.

This can lead to a premature OOM on boot.

To ensure progress, accept one MAX_ORDER page if the watermark is zero.

Link: https://lkml.kernel.org/r/20250310082855.2587122-1-kirill.shutemov@linux.intel.com
Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Reported-by: Farrah Chen <farrah.chen@intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: Thomas Lendacky <thomas.lendacky@amd.com>
Cc: <stable@vger.kernel.org>	[6.5+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 94917c729120..542d25f77be8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7004,7 +7004,7 @@ static inline bool has_unaccepted_memory(void)
 
 static bool cond_accept_memory(struct zone *zone, unsigned int order)
 {
-	long to_accept;
+	long to_accept, wmark;
 	bool ret = false;
 
 	if (!has_unaccepted_memory())
@@ -7013,8 +7013,18 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
 	if (list_empty(&zone->unaccepted_pages))
 		return false;
 
+	wmark = promo_wmark_pages(zone);
+
+	/*
+	 * Watermarks have not been initialized yet.
+	 *
+	 * Accepting one MAX_ORDER page to ensure progress.
+	 */
+	if (!wmark)
+		return try_to_accept_memory_one(zone);
+
 	/* How much to accept to get to promo watermark? */
-	to_accept = promo_wmark_pages(zone) -
+	to_accept = wmark -
 		    (zone_page_state(zone, NR_FREE_PAGES) -
 		    __zone_watermark_unusable_free(zone, order, 0) -
 		    zone_page_state(zone, NR_UNACCEPTED));


