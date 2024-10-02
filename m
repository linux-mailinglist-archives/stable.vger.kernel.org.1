Return-Path: <stable+bounces-79995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ACD98DB41
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1971F21003
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD991D1511;
	Wed,  2 Oct 2024 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZArUVY3y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B91D1D095D;
	Wed,  2 Oct 2024 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879077; cv=none; b=YuNlweJWaOmDO71jbrOav8DfBVYghiS162+qMtgdxSBHbZKSv6IR/X4mB5GkgqoJupasQTJGnii+XFCNhF7HiZhskArnxAB/xvWI14+DhXhMXMpbD80VVTzMdo6/rFJqkbAM7Y9Cwd8LIB9xcOjB/C5PB54YAn5+32W760Z0LW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879077; c=relaxed/simple;
	bh=qqamdNA0KHzagOrE0W69OKTBnLnGbk1R41AO5EOkGYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnYJmRCDS9Rc+PpWyoyLRbDSh86R/aDZy4JuC43/FAyKd8W9pVAKy9Cmu9VlneRblkee3aACyxxTXku0H6aXll2uGq6jC0Pqxznh1/cZVklVpNZkFdloC3mCKgPzMME/OlghjVGIl2kkf3JMBs1wSArceLX///yuUOaU6kxUhJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZArUVY3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96CFC4CEC2;
	Wed,  2 Oct 2024 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879077;
	bh=qqamdNA0KHzagOrE0W69OKTBnLnGbk1R41AO5EOkGYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZArUVY3y9LWbmYkAPWAbNyaBl9bgIf3kUSRkBlCAtraBD2go8NzoDgj5cClyWj3Y6
	 1BKcGJdWeXyoGORiRsck8997ywm0loBVtSrkYgwxOXwPF0d/hWIDzz/Qa1lxOY59Si
	 rWI0EvvAwr273G2FtFAzrfox9VEAhoykw8Wi5ZGg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	SeongJae Park <sj@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.10 630/634] mm/damon/vaddr: protect vma traversal in __damon_va_thre_regions() with rcu read lock
Date: Wed,  2 Oct 2024 15:02:10 +0200
Message-ID: <20241002125835.991175751@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liam R. Howlett <Liam.Howlett@oracle.com>

commit fb497d6db7c19c797cbd694b52d1af87c4eebcc6 upstream.

Traversing VMAs of a given maple tree should be protected by rcu read
lock.  However, __damon_va_three_regions() is not doing the protection.
Hold the lock.

Link: https://lkml.kernel.org/r/20240905001204.1481-1-sj@kernel.org
Fixes: d0cf3dd47f0d ("damon: convert __damon_va_three_regions to use the VMA iterator")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/b83651a0-5b24-4206-b860-cb54ffdf209b@roeck-us.net
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/vaddr.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -126,6 +126,7 @@ static int __damon_va_three_regions(stru
 	 * If this is too slow, it can be optimised to examine the maple
 	 * tree gaps.
 	 */
+	rcu_read_lock();
 	for_each_vma(vmi, vma) {
 		unsigned long gap;
 
@@ -146,6 +147,7 @@ static int __damon_va_three_regions(stru
 next:
 		prev = vma;
 	}
+	rcu_read_unlock();
 
 	if (!sz_range(&second_gap) || !sz_range(&first_gap))
 		return -EINVAL;



