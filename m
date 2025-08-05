Return-Path: <stable+bounces-166652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56034B1BB6E
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 22:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8414B180A4A
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 20:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458CF25B309;
	Tue,  5 Aug 2025 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d1hSdT2a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E622288EE;
	Tue,  5 Aug 2025 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754425778; cv=none; b=OPm7h4F4Z9ZlRPD6BlUIohZ4cWfjZYOUDzIwmNJJt4kWOBKHxEo71J6K92RLXWgmdgy9miO/fGNgpRYqE+WST8zZVdxozHC+OKe4tCqP8le4IAqHAFou/j8KG29mVU1cU+TfiJdjbWVjEzt0RKOd9snDFBDCPb4/2SjyJXArTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754425778; c=relaxed/simple;
	bh=f/+4E8HnXsguvA2rB6nwciDVUy+Pkhr+GZVkcmb1pWE=;
	h=Date:To:From:Subject:Message-Id; b=tEV2BOye7+RQZFyYdwnei1migmvVsUyMQXOSpJ0viW2epXTDXFijZMBA3+QlzoPRSnhvQjgVIhAhtYqriboCKe4vp1cU1SIGBI4QDXXNfF80ecDWIbuaKsiob6AHe/HExWvWxWmaelvRJfkw3qk+MBrWjGK9LApPK2Kw4Zl9ZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d1hSdT2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727D7C4CEF0;
	Tue,  5 Aug 2025 20:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754425777;
	bh=f/+4E8HnXsguvA2rB6nwciDVUy+Pkhr+GZVkcmb1pWE=;
	h=Date:To:From:Subject:From;
	b=d1hSdT2aHFVtHRjSh6vRSXajhy9MWzALECBW0mRWIC0MGGb78yJRtzzOAYV+cTeiT
	 ckp3gTtDvW82wyBqM3LuRcP3J6qN53/RNl6D24aCgOtiAusff9IQ5SA8rgevRjHnBc
	 s/IzcMUhWgDeaW00U59SD/DHmPJ82yDT7MBE2cU8=
Date: Tue, 05 Aug 2025 13:29:36 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,catalin.marinas@arm.com,longman@redhat.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-kmemleak-avoid-soft-lockup-in-__kmemleak_do_cleanup.patch removed from -mm tree
Message-Id: <20250805202937.727D7C4CEF0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm/kmemleak: avoid soft lockup in __kmemleak_do_cleanup()
has been removed from the -mm tree.  Its filename was
     mm-kmemleak-avoid-soft-lockup-in-__kmemleak_do_cleanup.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Waiman Long <longman@redhat.com>
Subject: mm/kmemleak: avoid soft lockup in __kmemleak_do_cleanup()
Date: Mon, 28 Jul 2025 15:02:48 -0400

A soft lockup warning was observed on a relative small system x86-64
system with 16 GB of memory when running a debug kernel with kmemleak
enabled.

  watchdog: BUG: soft lockup - CPU#8 stuck for 33s! [kworker/8:1:134]

The test system was running a workload with hot unplug happening in
parallel.  Then kemleak decided to disable itself due to its inability to
allocate more kmemleak objects.  The debug kernel has its
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE set to 40,000.

The soft lockup happened in kmemleak_do_cleanup() when the existing
kmemleak objects were being removed and deleted one-by-one in a loop via a
workqueue.  In this particular case, there are at least 40,000 objects
that need to be processed and given the slowness of a debug kernel and the
fact that a raw_spinlock has to be acquired and released in
__delete_object(), it could take a while to properly handle all these
objects.

As kmemleak has been disabled in this case, the object removal and
deletion process can be further optimized as locking isn't really needed. 
However, it is probably not worth the effort to optimize for such an edge
case that should rarely happen.  So the simple solution is to call
cond_resched() at periodic interval in the iteration loop to avoid soft
lockup.

Link: https://lkml.kernel.org/r/20250728190248.605750-1-longman@redhat.com
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/kmemleak.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/mm/kmemleak.c~mm-kmemleak-avoid-soft-lockup-in-__kmemleak_do_cleanup
+++ a/mm/kmemleak.c
@@ -2184,6 +2184,7 @@ static const struct file_operations kmem
 static void __kmemleak_do_cleanup(void)
 {
 	struct kmemleak_object *object, *tmp;
+	unsigned int cnt = 0;
 
 	/*
 	 * Kmemleak has already been disabled, no need for RCU list traversal
@@ -2192,6 +2193,10 @@ static void __kmemleak_do_cleanup(void)
 	list_for_each_entry_safe(object, tmp, &object_list, object_list) {
 		__remove_object(object);
 		__delete_object(object);
+
+		/* Call cond_resched() once per 64 iterations to avoid soft lockup */
+		if (!(++cnt & 0x3f))
+			cond_resched();
 	}
 }
 
_

Patches currently in -mm which might be from longman@redhat.com are



