Return-Path: <stable+bounces-166921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D75EB1F5B8
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 19:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743F6189D1BF
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 17:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161DA277CA0;
	Sat,  9 Aug 2025 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8nbYeg1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81741D618C;
	Sat,  9 Aug 2025 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754761721; cv=none; b=mXN89AK+SJyuHqSfywBL/FUqBrUEAFhpVJg29uCWgVsAiYRj7bSqQWYs14FGXJHpoT/E6UQL4DPkFPvvsiVkBF1fCeWphpb566+h3Tnn7fwfbGki0nLNd48UzPdpfxGz6ebZGUERbEWjAVC65VJXHukJhgBLsN5JQu0U2eDzySc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754761721; c=relaxed/simple;
	bh=aKDkF5RSgXGbhrjBrkjvDv3sHb1LUhd6gxPgYdPrLoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=drqQ2JdFnOVdyTb+K8U4W1tkBJDYavfNRFb5LA1kX4NB0oq8cISmytMmfZfXO1B6p2XSKIYn9oHBrPMxRwTEAWXmYPfXnv+MspHaybemUCiolLlUcAz8f3mhG+Hmn/lHprJP62wyRjm75YfoYOYXOqicRJUvPFbx2vUntKArTqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8nbYeg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B059C4CEE7;
	Sat,  9 Aug 2025 17:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754761721;
	bh=aKDkF5RSgXGbhrjBrkjvDv3sHb1LUhd6gxPgYdPrLoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8nbYeg1V3Bj9tiIH2hWtnSPho7Srv+KMTxfn8pnWyK6hdtiMxPK++yQ1KeQzD8eQ
	 a5piVkWP0R/tTqmdZvX1FRART50cKQqY+k4aaFndhzGuiooUZ5AEC0/UPqG1aBQhy3
	 IrizXo+tBDtE50v3H01dpCeW5NDq8x9ZYYk+GF3QsId5hMsTSjA9Lj9qt8M/ebSm9H
	 tvkKqiLd3e60qwo0HfrYiXBEHt/6q5vc776usWnQx3iSbKMLQSqq2KttmIOrQ1X/0z
	 ufPH6tli8Nb4LqKCQ4aWzu69tqHVpFozRoDsnbiaGFgZ8ZX/e+ZMvnZJQoJEHFoofl
	 eRucwiUvXLBoA==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/core: fix commit_ops_filters by using correct nth function
Date: Sat,  9 Aug 2025 10:48:38 -0700
Message-Id: <20250809174838.71485-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250809130756.637304-1-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  9 Aug 2025 22:07:56 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> damos_commit_ops_filters() incorrectly uses damos_nth_filter() which
> iterates core_filters. As a result, performing a commit unintentionally
> corrupts ops_filters.
> 
> Add damos_nth_ops_filter() which iterates ops_filters. Use this function
> to fix issues caused by wrong iteration.
> 
> Also, add test to verify that modification is right way.

As I mentioned on v1 thread, please drop the test part, for ease of
backporting.

> 
> Fixes: 3607cc590f18 ("mm/damon/core: support committing ops_filters") # 6.15.x
> Cc: stable@vger.kernel.org
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
> Changes from v1 [1]:
> 1. Fix code and commit message style.
> 2. Merge patch set into one patch.
> 3. Add fixes and cc section for backporting.
> 
> [1] https://lore.kernel.org/damon/20250808195518.563053-1-ekffu200098@gmail.com/
> 
> ---
> I tried to fix your all comments, but maybe i miss something. Then
> please let me know; I'll fix it as soon as possible.
> 
> ---
>  mm/damon/core.c                               | 14 +++-
>  tools/testing/selftests/damon/Makefile        |  1 +
>  .../damon/sysfs_no_op_commit_break.py         | 72 +++++++++++++++++++
>  3 files changed, 86 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/damon/sysfs_no_op_commit_break.py
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 883d791a10e5..19c8f01fc81a 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -862,6 +862,18 @@ static struct damos_filter *damos_nth_filter(int n, struct damos *s)
>  	return NULL;
>  }
>  
> +static struct damos_filter *damos_nth_ops_filter(int n, struct damos *s)
> +{
> +	struct damos_filter *filter;
> +	int i = 0;
> +
> +	damos_for_each_ops_filter(filter, s) {
> +		if (i++ == n)
> +			return filter;
> +	}
> +	return NULL;
> +}
> +
>  static void damos_commit_filter_arg(
>  		struct damos_filter *dst, struct damos_filter *src)
>  {
> @@ -925,7 +937,7 @@ static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
>  	int i = 0, j = 0;
>  
>  	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
> -		src_filter = damos_nth_filter(i++, src);
> +		src_filter = damos_nth_ops_filter(i++, src);
>  		if (src_filter)
>  			damos_commit_filter(dst_filter, src_filter);
>  		else
> diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
> index 5b230deb19e8..44a4a819df55 100644
> --- a/tools/testing/selftests/damon/Makefile
> +++ b/tools/testing/selftests/damon/Makefile
> @@ -17,6 +17,7 @@ TEST_PROGS += reclaim.sh lru_sort.sh
>  TEST_PROGS += sysfs_update_removed_scheme_dir.sh
>  TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
>  TEST_PROGS += sysfs_memcg_path_leak.sh
> +TEST_PROGS += sysfs_no_op_commit_break.py
>  
>  EXTRA_CLEAN = __pycache__
>  
> diff --git a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
> new file mode 100755
> index 000000000000..fbefb1c83045
> --- /dev/null
> +++ b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
> @@ -0,0 +1,72 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import json
> +import os
> +import subprocess
> +import sys
> +
> +import _damon_sysfs
> +
> +def dump_damon_status_dict(pid):
> +    try:
> +        subprocess.check_output(['which', 'drgn'], stderr=subprocess.DEVNULL)
> +    except:
> +        return None, 'drgn not found'
> +    file_dir = os.path.dirname(os.path.abspath(__file__))
> +    dump_script = os.path.join(file_dir, 'drgn_dump_damon_status.py')
> +    rc = subprocess.call(['drgn', dump_script, pid, 'damon_dump_output'],
> +        stderr=subprocess.DEVNULL)
> +
> +    if rc != 0:
> +        return None, f'drgn fail: return code({rc})'
> +    try:
> +        with open('damon_dump_output', 'r') as f:
> +            return json.load(f), None
> +    except Exception as e:
> +        return None, 'json.load fail (%s)' % e
> +
> +def main():
> +    kdamonds = _damon_sysfs.Kdamonds(
> +        [_damon_sysfs.Kdamond(
> +            contexts=[_damon_sysfs.DamonCtx(
> +                schemes=[_damon_sysfs.Damos(
> +                    ops_filters=[
> +                        _damon_sysfs.DamosFilter(
> +                            type_='anon',
> +                            matching=True,
> +                            allow=True,
> +                        )
> +                    ]
> +                )],
> +            )])]
> +    )
> +
> +    err = kdamonds.start()
> +    if err is not None:
> +        print('kdamond start failed: %s' % err)
> +        exit(1)
> +
> +    before_commit_status, err = \
> +        dump_damon_status_dict(kdamonds.kdamonds[0].pid)
> +    if err is not None:
> +        print(err)

Adding more context would be nice, e.g.,

    print('before-commit status dump failed: %s' % err)

> +        exit(1)
> +
> +    kdamonds.kdamonds[0].commit()
> +
> +    after_commit_status, err = \
> +        dump_damon_status_dict(kdamonds.kdamonds[0].pid)
> +    if err is not None:
> +        print(err)

Adding more context would be nice, e.g.,

    print('after-commit status dump failed: %s' % err)

> +        exit(1)
> +
> +    if before_commit_status != after_commit_status:
> +        print(f'before: {json.dump(before_commit_status, indent=2)}')
> +        print(f'after: {json.dump(after_commit_status, indent=2)}')
> +        exit(1)
> +
> +    kdamonds.stop()
> +
> +if __name__ == '__main__':
> +    main()
> -- 
> 2.43.0

Other than above two trivial comments, nothing stands out to me.


Thanks,
SJ

