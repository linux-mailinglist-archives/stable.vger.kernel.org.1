Return-Path: <stable+bounces-144572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE03AB95BF
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 08:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AC59E2009
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 06:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55860220694;
	Fri, 16 May 2025 06:03:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7543D69;
	Fri, 16 May 2025 06:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747375406; cv=none; b=F/GR/LQM79BMJTYWHse9mTByex1L+FpH/RLTDSiEmax4yWCEEldOpBji/zjEmYEMiq3wiXwIT4YekWvUP60FtvfASmmsf5aq9ZgxnKTNw0ufj7tijTRK+4jsgRilterNMXtvzXKSxG/sZuQ4peNYUNWLpk3dZmqJLKaiHxvjy9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747375406; c=relaxed/simple;
	bh=oOpjNen7QUYebQBY79f3YikSpSsA8ABTeD0DigpqGZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6uVcgm9wMBA7zaL5ylwMIoNctwN/rD0c+gsO/5KckRzTPM8NgSbk6CWJTrJNJ2kQwgJWcaHPGgucQ3myCDjSH8kOpNCGAfGBSCRGItVVMGe5f5r60kPfqUJBSxjgtMRESIL4rEzWQhJjdsiOl6RI5q46u6GVobLZ9k6d6u5AzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-3f-6826d52339f8
Date: Fri, 16 May 2025 15:03:09 +0900
From: Byungchul Park <byungchul@sk.com>
To: Gavin Guo <gavinguo@igalia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	osalvador@suse.de, akpm@linux-foundation.org,
	mike.kravetz@oracle.com, kernel-dev@igalia.com,
	stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	Florent Revest <revest@google.com>, Gavin Shan <gshan@redhat.com>,
	kernel_team@skhynix.com
Subject: Re: [PATCH] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
Message-ID: <20250516060309.GA51921@system.software.com>
References: <20250513093448.592150-1-gavinguo@igalia.com>
 <20250514064729.GA17622@system.software.com>
 <075ae729-1d4a-4f12-a2ba-b4f508e5d0a1@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <075ae729-1d4a-4f12-a2ba-b4f508e5d0a1@igalia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LhesuzUFf5qlqGwdRVAhZz1q9hs1iy9gyz
	xctd25gsnn7qY7E49+I7k8XlXXPYLO6t+c9q8XF/sMWynQ9ZLM5MK7LonvmD1WLBxkeMDjwe
	CzaVekyY3c3msenTJHaPEzN+s3gsbJjK7PHx6S0Wj/f7rrJ5bD5d7fF5k1wAZxSXTUpqTmZZ
	apG+XQJXxsMurYLjYhXnjnUwNzBOEOpi5OSQEDCR2HW9nQXGvrDxBpjNIqAqsXzuCzYQm01A
	XeLGjZ/MILaIgLLEhykHgWq4OJgFTjBJXJy3iB0kISyQInHtwDawZl4BC4nj+5YzgxQJCcxh
	lLh59Ss7REJQ4uTMJ2BFzAJaEjf+vWTqYuQAsqUllv/jAAlzCthJ3O/ewwRiiwItO7DtOBPI
	HAmB12wSDX9eMEJcKilxcMUNlgmMArOQjJ2FZOwshLELGJlXMQpl5pXlJmbmmOhlVOZlVugl
	5+duYgTGy7LaP9E7GD9dCD7EKMDBqMTD63BdNUOINbGsuDL3EKMEB7OSCO/1LOUMId6UxMqq
	1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYzVAn3rz9saqB4VPHhR
	69aq/lCb7L021tseR7eqdHkwLN/+zaXHRyV/zqufE0Q3SVgVFpxnOnzoxWoPnuybs6J/346T
	ZUp3tni2+yfHgSwPn9un2i/KcVVMf5oSdEqA7UdPyn+HDq5/tm/d6zZZft7/5Xreug4Bq2+2
	i4vN1NaqT41sY9Le7abEUpyRaKjFXFScCAAsr5bMkwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC5WfdrKt8VS3DoFXZYs76NWwWS9aeYbZ4
	uWsbk8XTT30sFudefGeyODz3JKvF5V1z2CzurfnPavFxf7DFsp0PWSzOTCuy6J75g9ViwcZH
	jA68Hgs2lXpMmN3N5rHp0yR2jxMzfrN4LGyYyuzx8ektFo/3+66yeSx+8YHJY/Ppao/Pm+QC
	uKK4bFJSczLLUov07RK4Mh52aRUcF6s4d6yDuYFxglAXIyeHhICJxIWNN1hAbBYBVYnlc1+w
	gdhsAuoSN278ZAaxRQSUJT5MOQhUw8XBLHCCSeLivEXsIAlhgRSJawe2gTXzClhIHN+3nBmk
	SEhgDqPEzatf2SESghInZz4BK2IW0JK48e8lUxcjB5AtLbH8HwdImFPATuJ+9x4mEFsUaNmB
	bceZJjDyzkLSPQtJ9yyE7gWMzKsYRTLzynITM3NM9YqzMyrzMiv0kvNzNzECQ39Z7Z+JOxi/
	XHY/xCjAwajEw+twXTVDiDWxrLgy9xCjBAezkgjv9SzlDCHelMTKqtSi/Pii0pzU4kOM0hws
	SuK8XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbGQwbXnn4RcGZydr7ReDpuw/s3agHMT+61uXC6
	sr//J37grZbO8rfO7oFVLYvelnSau+mbc+Ve+bnngFXu3kvhB1M9mi1r03eHiwcqrJ8l28aq
	5XghatGDp0qWS2Q3W3PWP1/z0Z9vAfeqVeFbog98d8n471S5PyPp0cJzd5/cOm7l6P702JvJ
	SizFGYmGWsxFxYkA9ttclnkCAAA=
X-CFilter-Loop: Reflected

On Wed, May 14, 2025 at 04:10:12PM +0800, Gavin Guo wrote:
> Hi Byungchul,
> 
> On 5/14/25 14:47, Byungchul Park wrote:
> > On Tue, May 13, 2025 at 05:34:48PM +0800, Gavin Guo wrote:
> > > The patch fixes a deadlock which can be triggered by an internal
> > > syzkaller [1] reproducer and captured by bpftrace script [2] and its log
> > 
> > Hi,
> > 
> > I'm trying to reproduce using the test program [1].  But not yet
> > produced.  I see a lot of segfaults while running [1].  I guess
> > something goes wrong.  Is there any prerequisite condition to reproduce
> > it?  Lemme know if any.  Or can you try DEPT15 with your config and
> > environment by the following steps:
> > 
> >     1. Apply the patchset on v6.15-rc6.
> >        https://lkml.kernel.org/r/20250513100730.12664-1-byungchul@sk.com
> >     2. Turn on CONFIG_DEPT.
> >     3. Run test program reproducing the deadlock.
> >     4. Check dmesg to see if dept reported the dependency.
> > 
> > 	Byungchul
> 
> I have enabled the patchset and successfully reproduced the bug. It
> seems that there is no warning or error log related to the lock. Did I
> miss anything? This is the console log:
> https://drive.google.com/file/d/1dxWNiO71qE-H-e5NMPqj7W-aW5CkGSSF/view?usp=sharing

My bad.  I think I found the problem that dept didn't report it.  You
might see the report with the following patch applied on the top, there
might be a lot of false positives along with that might be annoying tho.

Some of my efforts to suppress false positives, suppressed the real one.

Do you mind if I ask you to run the test with the following patch
applied?  It'd be appreciated if you do and share the result with me.

	Byungchul

---
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f31cd68f2935..fd7559e663c5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1138,6 +1138,7 @@ static inline bool trylock_page(struct page *page)
 static inline void folio_lock(struct folio *folio)
 {
 	might_sleep();
+	dept_page_wait_on_bit(&folio->page, PG_locked);
 	if (!folio_trylock(folio))
 		__folio_lock(folio);
 }
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index b2fa96d984bc..4e96a6a72d02 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -931,7 +931,6 @@ static void print_circle(struct dept_class *c)
 	dept_outworld_exit();
 
 	do {
-		tc->reported = true;
 		tc = fc;
 		fc = fc->bfs_parent;
 	} while (tc != c);
diff --git a/kernel/dependency/dept_unit_test.c b/kernel/dependency/dept_unit_test.c
index 88e846b9f876..496149f31fb3 100644
--- a/kernel/dependency/dept_unit_test.c
+++ b/kernel/dependency/dept_unit_test.c
@@ -125,6 +125,8 @@ static int __init dept_ut_init(void)
 {
 	int i;
 
+	return 0;
+
 	lockdep_off();
 
 	dept_ut_results.ecxt_stack_valid_cnt = 0;
--

