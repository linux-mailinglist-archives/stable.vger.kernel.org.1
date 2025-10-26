Return-Path: <stable+bounces-189900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F81C0B7ED
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 00:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FB484ED1A1
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 23:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81012D2495;
	Sun, 26 Oct 2025 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAK++Ewd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EAC3016F7
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761522639; cv=none; b=Btr4d8kv50apy6FPS5wGIa7zaEHmi89HaV4k9VDgN1iQ+PZUm/btRBPZCZi9z0TG9ikoYB8iYqDj56LDO75IxP4+AhCjbX6lh8YKkm3qkTiOKgWd/XhC9jodX8DFpH0Yq8WNf+z5yxTbF+8m+D0D5Srww6l12V8VBVHEVIh5z9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761522639; c=relaxed/simple;
	bh=qKfPeZrLeIQT3zL6u1if18AJg5d/3IKa6uwIDUrzDZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOvp/tOort+UzJNdroLZ+6Cg1TYujiCfa2yb+hzchNxrBVjTmLEp+7RwvmDcDl/G9Nax0/twYI76/RgO8WoGGz/xrhUaGBBXGRBRzJI7oh0jDQ2i8G2hLt5DslhgJvX43tfzKvq9RuqcHF6MLe0FR2BxElgEgltNq01WOrGJlmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAK++Ewd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A4EC4CEF7;
	Sun, 26 Oct 2025 23:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761522639;
	bh=qKfPeZrLeIQT3zL6u1if18AJg5d/3IKa6uwIDUrzDZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAK++EwdDBN9VJAl8AS6eMC9SXgqpkfMA5aZBdclAF2pQX85rcwvXHc7gMsSLcJ+Y
	 v9G9pZBbHdlACb8bYzY/0qkZUYV6HR3lb1Kd58A9mmccqNc96AaC+gsipM2yf3cSNe
	 05a6EihpmsUJ8wgdAKgQjAV29GHMlb2MPG2SNn6PcP7XAe3jEtqrH3FtlFezanxZNc
	 N7HVhinyhjF0nNkX18IRc2LUYHuwFzibh/is2hetJdaQpeekLpN7saKpSnDGpZRbrt
	 W5v+N630INI6pyC4TAEB4hGLtBpR/rvbikbafaN/Lvs/y9EO963QBT0MD1ePrXsKd+
	 h4fj4niMdNFrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 3/3] vmw_balloon: indicate success when effectively deflating during migration
Date: Sun, 26 Oct 2025 19:50:28 -0400
Message-ID: <20251026235028.289288-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026235028.289288-1-sashal@kernel.org>
References: <2025102655-unequal-disown-9615@gregkh>
 <20251026235028.289288-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 4ba5a8a7faa647ada8eae61a36517cf369f5bbe4 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/vmw_balloon.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 6df51ee8db621..cc1d18b3df5ca 100644
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
-- 
2.51.0


