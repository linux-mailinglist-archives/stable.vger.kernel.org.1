Return-Path: <stable+bounces-176834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5B2B3E133
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 13:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615071A81B46
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 11:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CE031195B;
	Mon,  1 Sep 2025 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VjFiCT0w"
X-Original-To: stable@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984ED313547;
	Mon,  1 Sep 2025 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725021; cv=none; b=XdNae1BB3AvoFv8KgW/0lQwj11i8wtfJUVSUEdqNq7I0OjQHa3CpldkNOf2UPwJq86939ePbMJKNW4pXoiXdmh3/b81G0qoRSCrBfLN80PJCj2xozl90XENhE2jTdHZxTCDAnTPzuYUUWEWSzkq7GCSTGm/57Wx1B1rrKt9j4yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725021; c=relaxed/simple;
	bh=+UHCy7dao63ySYPGWMTvsxuWkt6E2KEnTIw8lhu5j5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dqg0oDTJELEDet0Rii8X4ifMNWgPhkpwSvlfTQfG36mg2YaGg1hCqCPhOBUS3wWB6z5Q2Znemd0EhtUg3nJfBeJVSTIT4gaPzl28VAXz+aaiZk6IEgod7+3E6gp5ENjYwTHGyBlG4JkIii1bylmNDEYX4N3IiluExjcZaQf+DEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VjFiCT0w; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756725014; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=2+5CubNWcmQ4tKQGllscaqN5xA93y5xyzPP40mFbmOA=;
	b=VjFiCT0wRGHaMapK+RWlhrJWrvzjRGgI8ro+POy5PYwm19Wy2Lnq319CnmCNpltk8k4ED/++6JM31hT5hNd3rIiGByfIAZUCSGtzHfFGQtLXs/R7yFx/xs7RqVOUokYFNTwtgnqCjm+tRQfFWQSKUc4/hTRZHU9WMUC9+hf+Mpg=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wn23mIs_1756724995 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 01 Sep 2025 19:10:12 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Ruan Shiyang <ruansy.fnst@fujitsu.com>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  lkp@intel.com,
  akpm@linux-foundation.org,  y-goto@fujitsu.com,  mingo@redhat.com,
  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  mgorman@suse.de,  vschneid@redhat.com,  Li Zhijian
 <lizhijian@fujitsu.com>,  Vlastimil Babka <vbabka@suse.cz>,  Ben Segall
 <bsegall@google.com>,  stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: memory-tiering: fix PGPROMOTE_CANDIDATE counting
In-Reply-To: <20250901090122.124262-1-ruansy.fnst@fujitsu.com> (Ruan Shiyang's
	message of "Mon, 1 Sep 2025 17:01:22 +0800")
References: <20250729035101.1601407-1-ruansy.fnst@fujitsu.com>
	<20250901090122.124262-1-ruansy.fnst@fujitsu.com>
Date: Mon, 01 Sep 2025 19:09:55 +0800
Message-ID: <878qiya0os.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ruan Shiyang <ruansy.fnst@fujitsu.com> writes:

> Goto-san reported confusing pgpromote statistics where the
> pgpromote_success count significantly exceeded pgpromote_candidate.
>
> On a system with three nodes (nodes 0-1: DRAM 4GB, node 2: NVDIMM 4GB):
>  # Enable demotion only
>  echo 1 > /sys/kernel/mm/numa/demotion_enabled
>  numactl -m 0-1 memhog -r200 3500M >/dev/null &
>  pid=$!
>  sleep 2
>  numactl memhog -r100 2500M >/dev/null &
>  sleep 10
>  kill -9 $pid # terminate the 1st memhog
>  # Enable promotion
>  echo 2 > /proc/sys/kernel/numa_balancing
>
> After a few seconds, we observeed `pgpromote_candidate < pgpromote_success`
> $ grep -e pgpromote /proc/vmstat
> pgpromote_success 2579
> pgpromote_candidate 0
>
> In this scenario, after terminating the first memhog, the conditions for
> pgdat_free_space_enough() are quickly met, and triggers promotion.
> However, these migrated pages are only counted for in PGPROMOTE_SUCCESS,
> not in PGPROMOTE_CANDIDATE.
>
> To solve these confusing statistics, introduce PGPROMOTE_CANDIDATE_NRL to
> count the missed promotion pages.  And also, not counting these pages into
> PGPROMOTE_CANDIDATE is to avoid changing the existing algorithm or
> performance of the promotion rate limit.
>
> Link: https://lkml.kernel.org/r/20250729035101.1601407-1-ruansy.fnst@fujitsu.com
> Co-developed-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Ruan Shiyang <ruansy.fnst@fujitsu.com>
> Reported-by: Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>
> Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

LGTM, feel free to add my

Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>

in the future versions.

[snip]

---
Best Regards,
Huang, Ying

