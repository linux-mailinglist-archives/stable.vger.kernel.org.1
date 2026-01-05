Return-Path: <stable+bounces-204696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C13CF3331
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CF27306A915
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0F832F745;
	Mon,  5 Jan 2026 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Od8Hkywl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E6C33064C
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611103; cv=none; b=VGxSf/+PCoKlrwCuwBuEV1XSIriCBB0jlCbuGzSt06YKO/3QzT3t3xP/RStfdLR2pwuLRNVao/tSx+lF6+1OE3FohLotkN1mdykhSUR8x3zRBPLDVieY0kZX23tyu5lZuUNHPLhX6Y3aYaSlAbBRsJqayLTC2ndgjBH0Aj19BG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611103; c=relaxed/simple;
	bh=a/zpZ8MeKVAxGHSQIo2fif7vbOgtefjcXOrYNJWGTBs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EWPgJfGEDFGQUEHhc5CFqE02cPpoJ51u8kYFqeApDv4U7mg+ZRljGC/LoQheDgByLn3DMfBljSjjyNqKCD9ZU50dNuyNz/k/qBBxFBIL+B4tmXXhkBCosEzvxlJ57QaBDuHV/Zf/dc+FTSZhZ9IAXkqvW0HcKLmiZzDON4laB0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Od8Hkywl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C518CC19424;
	Mon,  5 Jan 2026 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611103;
	bh=a/zpZ8MeKVAxGHSQIo2fif7vbOgtefjcXOrYNJWGTBs=;
	h=Subject:To:Cc:From:Date:From;
	b=Od8HkywlThaz+SW6gmiH8KnNYwtsH6qQod5v5IMJLu7D2BW2RCGdjHZYQvMTb9VGR
	 uu5snhLOvvNQg8EP0uQa7f8bOrvHoBmdvxxe+0g/0Ugu68L5Bj3ef+6sSsekYgf9JE
	 XonYGzAs/hwF/gA1AWpiucEdkKNM/ZdFVgQZ4WWw=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle alloc failures on" failed to apply to 6.6-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:05:00 +0100
Message-ID: <2026010500-pamperer-electable-b002@gregkh>
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
git cherry-pick -x 0998d2757218771c59d5ca59ccf13d1542a38f17
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010500-pamperer-electable-b002@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0998d2757218771c59d5ca59ccf13d1542a38f17 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:20:01 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: handle alloc failures on
 dasmon_test_merge_regions_of()

damon_test_merge_regions_of() is assuming all dynamic memory allocation in
it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-8-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index e8219fd23318..98f2a3de7cea 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -248,8 +248,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	int i;
 
 	t = damon_new_target();
+	if (!t)
+		kunit_skip(test, "target alloc fail");
 	for (i = 0; i < ARRAY_SIZE(sa); i++) {
 		r = damon_new_region(sa[i], ea[i]);
+		if (!r) {
+			damon_free_target(t);
+			kunit_skip(test, "region alloc fail");
+		}
 		r->nr_accesses = nrs[i];
 		r->nr_accesses_bp = nrs[i] * 10000;
 		damon_add_region(r, t);


