Return-Path: <stable+bounces-203390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E248CDD38E
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 03:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 586303021FAD
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 02:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BD326A1C4;
	Thu, 25 Dec 2025 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv7oM6Fu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675CE257859;
	Thu, 25 Dec 2025 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766629849; cv=none; b=Ya80YUzpk0dvgu2cllrKujrPxxU0A+qS4N2OV+tR1nLxNvji3ZVcvee29Qk+9m9SpKZVIRQJWuX/IO5ZBg1asGLql4uuG66x/WoFGZ3FQHzEAWGglgxkQIsBnORgVIHMGgqbGATpKnFqFaBiJ29VBd+J0EUIVHNkLzoWh4jKG0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766629849; c=relaxed/simple;
	bh=m1g5uoH2P6wU5+w9MpROfiHCEcAhvKwueo5z8pV/iIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esd7zllZRp7txuGN5lFwffyf/L9pjaajPoEM0Pjtm6qKZ+LLcXQqx4WHeoViH72tjKmGlq9Ow0SUYO/TAfVZareO0QKKvAikWnrtV+mfw1496E/zuuGe37hbG9xCJc5p1O8sgcejuIgCV1A65DsZqPbnUqwQHDTX58NHOylSyBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv7oM6Fu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5334C16AAE;
	Thu, 25 Dec 2025 02:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766629848;
	bh=m1g5uoH2P6wU5+w9MpROfiHCEcAhvKwueo5z8pV/iIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hv7oM6FuFVBFimNiN0++SlKU0Babvo1q/s0diD8J21TRCQTPHl9iI0Ed1VuwpLcC6
	 VoizBokSE4cNvmfNPlU0YLNhEsw6kzOipsfotF71PzIYrVDrls9il1BUf7XZVtS961
	 6flx6XDCsDddpb9kuoKWiUoYIRB4mYSGVJbSYMSBmu0DY+y2HH5/FfKIpBh5m9I3Ct
	 PenhSknzyZ5LgUnxheh3MdhASObRZkkqAqEPB9c2Va54t/4OfN/U9l8mqOMNI02fDb
	 M+tOxuMuOfLrrEJN3e3si4WfbsISRy0vQWn/YigCyM+4UyhmOP7ik1FY9y5tC+2IEE
	 fWGN8vwZPYB6A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 15 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/4] mm/damon/sysfs: cleanup intervals subdirs on attrs dir setup failure
Date: Wed, 24 Dec 2025 18:30:34 -0800
Message-ID: <20251225023043.18579-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251225023043.18579-1-sj@kernel.org>
References: <20251225023043.18579-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When attrs/ DAMON sysfs directory setup is failed after setup of
intervals/ directory, intervals/intervals_goal/ directory is not cleaned
up.  As a result, DAMON sysfs interface is nearly broken until the
system reboots, and the memory for the unremoved directory is leaked.

Cleanup the directory under such failures.

Fixes: 8fbbcbeaafeb ("mm/damon/sysfs: implement intervals tuning goal directory")
Cc: <stable@vger.kernel.org> # 6.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e2bd2d7becdd..a669de068770 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -792,7 +792,7 @@ static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
 	nr_regions_range = damon_sysfs_ul_range_alloc(10, 1000);
 	if (!nr_regions_range) {
 		err = -ENOMEM;
-		goto put_intervals_out;
+		goto rmdir_put_intervals_out;
 	}
 
 	err = kobject_init_and_add(&nr_regions_range->kobj,
@@ -806,6 +806,8 @@ static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
 put_nr_regions_intervals_out:
 	kobject_put(&nr_regions_range->kobj);
 	attrs->nr_regions_range = NULL;
+rmdir_put_intervals_out:
+	damon_sysfs_intervals_rm_dirs(intervals);
 put_intervals_out:
 	kobject_put(&intervals->kobj);
 	attrs->intervals = NULL;
-- 
2.47.3

