Return-Path: <stable+bounces-204711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F490CF3451
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4369F30049C0
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEC033859C;
	Mon,  5 Jan 2026 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="thpkYOLT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BBA338586
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611203; cv=none; b=MecyZnQPrSm8DO1Pma1KQeGe9/zCY3HM5njs13TPNbpY3l0/ohIH5qk5L/H103pQWJPPAwZqDj4vn8PEk6WFLGLhv7oil7kNO9ykHrdoP+vFfx9KgLhyJtgFG7tIWCKeKhK9i2rxT9+ru93jcaQSbU3U2p3EQW/PSFUmm7rv1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611203; c=relaxed/simple;
	bh=iQHQfkhSjgnaW77r9nWwZQm7YaxzmR8+AxuayIZiC/g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dushkrXALOmKK9rfzEyLNq8iyi4zpIfNx4zYm3eA1UO7Aa/eT2Esn1I9g2kGl2/3/BnKlLyTjWxyG1Gp2ZHcwBmJg9OOTicwZEqbJOoqp6wYxqE1EP45v6GjVb0etmLzFvkZ2+qWxB+eVuIIv/89OBWEFEp4Ah3kgGoKweGR/iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=thpkYOLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41914C116D0;
	Mon,  5 Jan 2026 11:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611202;
	bh=iQHQfkhSjgnaW77r9nWwZQm7YaxzmR8+AxuayIZiC/g=;
	h=Subject:To:Cc:From:Date:From;
	b=thpkYOLTCtVqT8gcgFGVh3A3PPndIr1O5xH+dlX2SVVqvFnMkwcR/2fqBZ6dQsHyf
	 X46DWTSIzY/z+tQTMtfSJCneWz/t5CT26uQxtWmQK7NOlyC3vTPk0ZEbyP1yLPLwXb
	 ED/0FJn488ZW4bL0OqTir1WRhz01bAvf018XS+TE=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle alloc failures in" failed to apply to 6.6-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:06:39 +0100
Message-ID: <2026010539-very-stylized-a9ea@gregkh>
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
git cherry-pick -x 4f835f4e8c863985f15abd69db033c2f66546094
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010539-very-stylized-a9ea@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f835f4e8c863985f15abd69db033c2f66546094 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:20:03 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: handle alloc failures in
 damon_test_ops_registration()

damon_test_ops_registration() is assuming all dynamic memory allocation in
it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-10-sj@kernel.org
Fixes: 4f540f5ab4f2 ("mm/damon/core-test: add a kunit test case for ops registration")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.19+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 10618cdd188e..96c8f1269f44 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -320,6 +320,9 @@ static void damon_test_ops_registration(struct kunit *test)
 	struct damon_operations ops = {.id = DAMON_OPS_VADDR}, bak;
 	bool need_cleanup = false;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
 	/* DAMON_OPS_VADDR is registered only if CONFIG_DAMON_VADDR is set */
 	if (!damon_is_registered_ops(DAMON_OPS_VADDR)) {
 		bak.id = DAMON_OPS_VADDR;


