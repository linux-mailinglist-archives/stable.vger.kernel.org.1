Return-Path: <stable+bounces-203392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3945CDD3A0
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 03:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA95330142E4
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 02:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1191C26FDA8;
	Thu, 25 Dec 2025 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnKOlKKP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82F926AAAB;
	Thu, 25 Dec 2025 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766629849; cv=none; b=ErMW9SzzPi9SIST/zOgP4pzosLl3PN/M717epVkDLxMgkUvLTjcuNMScOPCuA73dkXLrl3ZOyu0lffvW45faJe3J2xb9jTUpImt+MsFOuGpL4y5wHLrD9w9wtuaP0ESGCXWG6Qcv51ywTeaY0cs9ptU7HSYtMOB5WGgRdmnI2SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766629849; c=relaxed/simple;
	bh=eAX9UEANbnhjK8d5CURObQKfqWquwN6z8606mMzlq4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKXe0g7N+nzxtbEEhJ8/Qyq9FtQLV1HMD6cPF7upBjONwBQuLI8Vg1/TS8eKOyGLvjxMid+X5BSxEmep9VpZOqFu/+M4nGxASpku0uWvh8Uw3KUKJe5BNFfq+4hlOoRfu97Vs5CdmowwjRtjvE3JmVf75Iyu+qqzfbEHGgR5Tvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnKOlKKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8F5C19422;
	Thu, 25 Dec 2025 02:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766629849;
	bh=eAX9UEANbnhjK8d5CURObQKfqWquwN6z8606mMzlq4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QnKOlKKPM/iXDA0ZpwIGk0cmg3wxuxetRyiKSYiUvLjRqQ1nPgtsBsSSnC17hv0HL
	 J+I9BF2EmigRhUqjDIoHO8sMY1R3TZGdK1/PeDFL6M3hmKKyQymrvDRXmdq2tyt/rg
	 +CVgPId/WRYPM1M+97LwmgRF9O8IbaosT5lCq6/ZKwCpLJQfjtulVf7pu+nie3e1es
	 VzgTQ26eoW7tbkbpAvtiv3isgZTUaFKmC8mYttzgip3DFLG1iZxmvsHXsoFTy+klS8
	 Xom+krn1o2Z9orbIIMg6AW5qwK9Wte89CX2mA7ewghLhwh7yAdRaxdM5PIZllA1ruZ
	 Neg9rtHU60SxA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/4] mm/damon/sysfs-scheme: cleanup quotas subdirs on scheme dir setup failure
Date: Wed, 24 Dec 2025 18:30:36 -0800
Message-ID: <20251225023043.18579-4-sj@kernel.org>
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

When a DAMOS-scheme DAMON sysfs directory setup fails after setup of
quotas/ directory, subdirectories of quotas/ directory are not cleaned
up. As a result, DAMON sysfs interface is nearly broken until the system
reboots, and the memory for the unremoved directory is leaked.

Cleanup the directories under such failures.

Fixes: 1b32234ab087 ("mm/damon/sysfs: support DAMOS watermarks")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index e198234f0763..7f14e0d3e7a0 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2199,7 +2199,7 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 		goto put_dests_out;
 	err = damon_sysfs_scheme_set_watermarks(scheme);
 	if (err)
-		goto put_quotas_access_pattern_out;
+		goto rmdir_put_quotas_access_pattern_out;
 	err = damos_sysfs_set_filter_dirs(scheme);
 	if (err)
 		goto put_watermarks_quotas_access_pattern_out;
@@ -2224,7 +2224,8 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 put_watermarks_quotas_access_pattern_out:
 	kobject_put(&scheme->watermarks->kobj);
 	scheme->watermarks = NULL;
-put_quotas_access_pattern_out:
+rmdir_put_quotas_access_pattern_out:
+	damon_sysfs_quotas_rm_dirs(scheme->quotas);
 	kobject_put(&scheme->quotas->kobj);
 	scheme->quotas = NULL;
 put_dests_out:
-- 
2.47.3

