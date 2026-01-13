Return-Path: <stable+bounces-208292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D3ED1B1B1
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 20:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 066AD3026AD2
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 19:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B89230DEDD;
	Tue, 13 Jan 2026 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Y7Irkn5S"
X-Original-To: stable@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8831327D;
	Tue, 13 Jan 2026 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333722; cv=none; b=sD4jY7aTV/uHEfbugQZ/3naZWFGvVb5/ecHzLwz/ukdpov9+/xQHHnj0kmy8lP4SJyqyOv0L0kdIR+QzzNTIXHXnn64qq5sQ2dpq7BMxvUj75Ggdlag5usrcLqbbXgbPNXl+O80sNwFa1Vee7Hn3x49eZ+xhWv/vwttWvzR2nkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333722; c=relaxed/simple;
	bh=bTp2Vjo4mw/wCtFQXi3331QEgeDTFtRFmfRf0623Zr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lvkulqr6iTZ5cBmKHB/xwfJxhl4H7a/UlrXhCh/cW6VQGs9CMpbQPsyn8FZR/dB17m+UILa0LKE+WhN2RWBNAa60yH+bVL6IECgW9pgMG0LNepJOKW9yfYezOLBb8pHzCmWP6TaAXc8Zi6iIbSpv0sctkII3hPsXArd2X72efYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Y7Irkn5S; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1768333719;
	bh=FnQ6Xj9eoyZHqA1dE1GyFR6lhfMRam/O2mY67l2o+yY=;
	h=From:To:Cc:Subject:Date:From;
	b=Y7Irkn5SAfMbS6XllRAOy38YzIKPePFRJxrmK5s/LlwoBiKjexTQsXLqkDvG4V/H9
	 XlrU7L6s6UHwIbnKcoEST9xs24ZMEBbAksgKDYxi6O+hcFqU1Gdzlj5y31k28IQHbX
	 LSTeK5oD4u4tz180kv1jIN6Nh7BtJKTqyx4GNmd6aYsvBQ9I42SFWhZCF3VuNgHKuo
	 eQCrVk3Yh3G0omKKLElaM87Jf/Kh9jNEXWiZG2vhooOzVy6tD5jYEWxhAQrNQDaJGd
	 C5qtL6gUYat8Id5+6CNaBnkKszN5bR+71dNi7CBQBa8h0rhL6/ImQHZc5m4VNK0LcF
	 hNSfuGwcinaKA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4drKYg2L7PzlTP;
	Tue, 13 Jan 2026 14:48:39 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>,
	christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: [PATCH v1 0/1] mm: Fix OOM killer and proc stats inaccuracy on large many-core systems
Date: Tue, 13 Jan 2026 14:47:33 -0500
Message-Id: <20260113194734.28983-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

This patch modifies the OOM killer and all proc RSS stats to use the
precise for-each-possible-cpu sum to fix the inaccuracy issues. This
approach was suggested by Michal Hocko as a straightforward fix for the
inaccuracy issue by using more precise (but slower) RSS stats sum.

With this, the hierarchical per-cpu counters become a simple
optimization rather than a bug fix. I will post a new version
of the HPCC soon which will be based on this patch.

Feedback is welcome!

Thanks,

Mathieu

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Martin Liu <liumartin@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: christian.koenig@amd.com
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <liam.howlett@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-mm@kvack.org
Cc: stable@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: Yu Zhao <yuzhao@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>

Mathieu Desnoyers (1):
  mm: Fix OOM killer and proc stats inaccuracy on large many-core
    systems

 fs/proc/task_mmu.c | 14 +++++++-------
 include/linux/mm.h |  5 -----
 2 files changed, 7 insertions(+), 12 deletions(-)

-- 
2.39.5

