Return-Path: <stable+bounces-59339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F0793132D
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 13:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F6A1C21869
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 11:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9850E189F5C;
	Mon, 15 Jul 2024 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HZjT8w2I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C48189F5B
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043421; cv=none; b=qBSAokF1o+RVf6YkPPQvNw+CVsWuRUexEwH9URU+BtI+5nUMoTa5kJOKiS9cKziXvd8D+GSbDTtisMr58E355Uvj2gUk17rvbClIK9uljp++HbJ9Sdj/A4LWUvVDhLoGOj6RFzBnqizJkkivLDCrLGSm6x8s4mYE4h2mbzPAqiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043421; c=relaxed/simple;
	bh=PUEr48ziNf75ANzMTwbRYlW34XKC2VVG9Hz6u8ehJys=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PWO9xk6bEO6xC6uPjNJmqNxY73jcpWIZslAaLFb5ePJBlNRST9wrjWa7NOSeh9pzVrDJR1myxJAbMP56dcEwa+aC6j710/C70opZuyQjyaHO1ZwmXS9Y3K0wefWANYaVZzDUW5EpmxEz9NMnfAK+DvihzZm/dNgZa2c5VcdLMVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HZjT8w2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE584C32782;
	Mon, 15 Jul 2024 11:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721043421;
	bh=PUEr48ziNf75ANzMTwbRYlW34XKC2VVG9Hz6u8ehJys=;
	h=Subject:To:Cc:From:Date:From;
	b=HZjT8w2IyFwrZ0kMhfgS3RXFE7KYZJLBMCTViwF8L84l+4sXoMkk/N1gc9lm9Bxi2
	 B8ysQbADIUrAwxptNbgBGLBntgld4QJSaho7n1ldy5waPHYlICeQCqzKDLQlxSc4E8
	 JeiXKT7Ftj0lVN03NRJehEZm6ymBga1Fc/zd2xIk=
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix potential race in" failed to apply to 6.9-stable tree
To: linmiaohe@huawei.com,akpm@linux-foundation.org,muchun.song@linux.dev,osalvador@suse.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 13:36:58 +0200
Message-ID: <2024071558-unbundle-resize-a6d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x 5596d9e8b553dacb0ac34bcf873cbbfb16c3ba3e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071558-unbundle-resize-a6d4@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

5596d9e8b553 ("mm/hugetlb: fix potential race in __update_and_free_hugetlb_folio()")
bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
51718e25c53f ("mm: convert arch_clear_hugepage_flags to take a folio")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5596d9e8b553dacb0ac34bcf873cbbfb16c3ba3e Mon Sep 17 00:00:00 2001
From: Miaohe Lin <linmiaohe@huawei.com>
Date: Mon, 8 Jul 2024 10:51:27 +0800
Subject: [PATCH] mm/hugetlb: fix potential race in
 __update_and_free_hugetlb_folio()

There is a potential race between __update_and_free_hugetlb_folio() and
try_memory_failure_hugetlb():

 CPU1					CPU2
 __update_and_free_hugetlb_folio	try_memory_failure_hugetlb
					 folio_test_hugetlb
					  -- It's still hugetlb folio.
  folio_clear_hugetlb_hwpoison
  					  spin_lock_irq(&hugetlb_lock);
					   __get_huge_page_for_hwpoison
					    folio_set_hugetlb_hwpoison
					  spin_unlock_irq(&hugetlb_lock);
  spin_lock_irq(&hugetlb_lock);
  __folio_clear_hugetlb(folio);
   -- Hugetlb flag is cleared but too late.
  spin_unlock_irq(&hugetlb_lock);

When the above race occurs, raw error page info will be leaked.  Even
worse, raw error pages won't have hwpoisoned flag set and hit
pcplists/buddy.  Fix this issue by deferring
folio_clear_hugetlb_hwpoison() until __folio_clear_hugetlb() is done.  So
all raw error pages will have hwpoisoned flag set.

Link: https://lkml.kernel.org/r/20240708025127.107713-1-linmiaohe@huawei.com
Fixes: 32c877191e02 ("hugetlb: do not clear hugetlb dtor until allocating vmemmap")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2afb70171b76..fe44324d6383 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1725,13 +1725,6 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		return;
 	}
 
-	/*
-	 * Move PageHWPoison flag from head page to the raw error pages,
-	 * which makes any healthy subpages reusable.
-	 */
-	if (unlikely(folio_test_hwpoison(folio)))
-		folio_clear_hugetlb_hwpoison(folio);
-
 	/*
 	 * If vmemmap pages were allocated above, then we need to clear the
 	 * hugetlb flag under the hugetlb lock.
@@ -1742,6 +1735,13 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
+	/*
+	 * Move PageHWPoison flag from head page to the raw error pages,
+	 * which makes any healthy subpages reusable.
+	 */
+	if (unlikely(folio_test_hwpoison(folio)))
+		folio_clear_hugetlb_hwpoison(folio);
+
 	folio_ref_unfreeze(folio, 1);
 
 	/*


