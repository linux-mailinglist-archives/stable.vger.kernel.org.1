Return-Path: <stable+bounces-189795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4644BC0AA11
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F81188462E
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9014A1E9B22;
	Sun, 26 Oct 2025 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DeqQDRW9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50381C2E0
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488938; cv=none; b=kYpg91mKe5/BQ+O7i0KqoM7foDC8N5xf+rJLiEmCjgcD4MfPAEKetAxA/6RcI2gEPQlTj5BeGCw1eMFRWNhoPHGvt1bwvTzTRtZcU5VycuZac/ectHpDtOT0Mg5z+O53Oy+RfijXIlLdTPNiSd8MrwqoSyn5zgpZZPEqf2a0P7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488938; c=relaxed/simple;
	bh=LO+gtL56gNxZnvIKS4O2cbSPoAAbH7zoGln5XPHi5Ac=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nMk+doVmowE6Fbxjfz2zT3UWUnK/HMncOU2iserlUMO+vFfIRWcRZkGz/jrVCENICwsgu581b/hpUlra+S8XM5ZKnfl8hk51iaKiiCowNtYUasfDSNEMfYxM80ryCJpyW4T0HPWObhoAV3busBWurFEIpz/92lJaZ8sMXPoJZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DeqQDRW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FD1C4CEE7;
	Sun, 26 Oct 2025 14:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761488938;
	bh=LO+gtL56gNxZnvIKS4O2cbSPoAAbH7zoGln5XPHi5Ac=;
	h=Subject:To:Cc:From:Date:From;
	b=DeqQDRW9VnPTeI0c6gcSqBAVta6RLF2ejaEjLQRkeWCkkUH+apb0sGpt4qEc15DpY
	 9iArPPJOGwg3P9IYkWHnUf5hSxSYwu69f3VLaWeA940fvfxpwWl3AHWs/HnNeG5BAs
	 VTHnciAjKiLCQu/Mg/7GhoxBCNVWwLie3kotwOzs=
Subject: FAILED: patch "[PATCH] vmw_balloon: indicate success when effectively deflating" failed to apply to 6.17-stable tree
To: david@redhat.com,akpm@linux-foundation.org,arnd@arndb.de,bcm-kernel-feedback-list@broadcom.com,gregkh@linuxfoundation.org,jerrin.shaji-george@broadcom.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 26 Oct 2025 15:28:55 +0100
Message-ID: <2025102655-unequal-disown-9615@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x 4ba5a8a7faa647ada8eae61a36517cf369f5bbe4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102655-unequal-disown-9615@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4ba5a8a7faa647ada8eae61a36517cf369f5bbe4 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 14 Oct 2025 14:44:55 +0200
Subject: [PATCH] vmw_balloon: indicate success when effectively deflating
 during migration

When migrating a balloon page, we first deflate the old page to then
inflate the new page.

However, if inflating the new page succeeded, we effectively deflated the
old page, reducing the balloon size.

In that case, the migration actually worked: similar to migrating+
immediately deflating the new page.  The old page will be freed back to
the buddy.

Right now, the core will leave the page be marked as isolated (as we
returned an error).  When later trying to putback that page, we will run
into the WARN_ON_ONCE() in balloon_page_putback().

That handling was changed in commit 3544c4faccb8 ("mm/balloon_compaction:
stop using __ClearPageMovable()"); before that change, we would have
tolerated that way of handling it.

To fix it, let's just return 0 in that case, making the core effectively
just clear the "isolated" flag + freeing it back to the buddy as if the
migration succeeded.  Note that the new page will also get freed when the
core puts the last reference.

Note that this also makes it all be more consistent: we will no longer
unisolate the page in the balloon driver while keeping it marked as being
isolated in migration core.

This was found by code inspection.

Link: https://lkml.kernel.org/r/20251014124455.478345-1-david@redhat.com
Fixes: 3544c4faccb8 ("mm/balloon_compaction: stop using __ClearPageMovable()")
Signed-off-by: David Hildenbrand <david@redhat.com>
Cc: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 6df51ee8db62..cc1d18b3df5c 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1737,7 +1737,7 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 {
 	unsigned long status, flags;
 	struct vmballoon *b;
-	int ret;
+	int ret = 0;
 
 	b = container_of(b_dev_info, struct vmballoon, b_dev_info);
 
@@ -1796,17 +1796,15 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 		 * A failure happened. While we can deflate the page we just
 		 * inflated, this deflation can also encounter an error. Instead
 		 * we will decrease the size of the balloon to reflect the
-		 * change and report failure.
+		 * change.
 		 */
 		atomic64_dec(&b->size);
-		ret = -EBUSY;
 	} else {
 		/*
 		 * Success. Take a reference for the page, and we will add it to
 		 * the list after acquiring the lock.
 		 */
 		get_page(newpage);
-		ret = 0;
 	}
 
 	/* Update the balloon list under the @pages_lock */
@@ -1817,7 +1815,7 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 	 * If we succeed just insert it to the list and update the statistics
 	 * under the lock.
 	 */
-	if (!ret) {
+	if (status == VMW_BALLOON_SUCCESS) {
 		balloon_page_insert(&b->b_dev_info, newpage);
 		__count_vm_event(BALLOON_MIGRATE);
 	}


