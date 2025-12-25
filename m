Return-Path: <stable+bounces-203393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1F6CDD38F
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 03:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB39930155B6
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 02:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4141E2737F4;
	Thu, 25 Dec 2025 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRWk/C6B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28526ED41;
	Thu, 25 Dec 2025 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766629850; cv=none; b=o1WbXQFiozthuLjmVHH76yREv5BDEP3j/8+28I4qyFZpcvAZ2xUuFVYkPdijm38X3BPl/Ctsl9WrqTXyeToWprrN3UdtpX8Ns8xBR52VbLia7TxRmzVYIqQ8ckzNQu7XZFSDOmZD4fldeIQTbdR4TwRW4yvHJ2/EozTRoxSJ94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766629850; c=relaxed/simple;
	bh=Sx0CCPkN1ZKSx9TC6izh6KVTqV3LFSqvwNdLWbM+vgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZR7ADE9Tta5F/niC9w3ue88VaCZ9b8yJNM5XYEH59q6Uke9OrRr8KXYSW1jbOZKQK2wYAYOtVndW1XQ0TvN8kVOeYuH5UteRE1mFdYGzY/9218tGlY6cnYZURmbsoQH+7iXQjraA9WkC2mZG1QPGBI1yfe1G8hEos9YT7VaMGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRWk/C6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BB6C116D0;
	Thu, 25 Dec 2025 02:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766629849;
	bh=Sx0CCPkN1ZKSx9TC6izh6KVTqV3LFSqvwNdLWbM+vgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRWk/C6BM9l8y9MbU7j9gAiyc2ySgM/NtdR6845qDKPmniln4UXdTR8njdowCh4ul
	 1CJGNmOkJ0pJUhEYrlWgt3BcpL50u2tgAhzR3gahZtafU2sDQ8luDSj0tUpjLPLCur
	 2H9nJPleBXgUQOnrdPFlQgt82kVj5cfKYKKbdSh1FrJbWPtlFwWB5mIFc6X1Ze2IGe
	 X3zMlccmkKtz0acpwiqgQ1SUb0xjCM+867p6oZjrHi7XvFDkzoyokYWS4SMDapq0n7
	 syFda+EOT3rM+Dva8HDBypBVicEWurJLKYeUrsFsn0uJTXBxv0lqD6CcT9lCK+qSn5
	 ofxMjZNTvr2Pg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/4] mm/damon/sysfs-scheme: cleanup access_pattern subdirs on scheme dir setup failure
Date: Wed, 24 Dec 2025 18:30:37 -0800
Message-ID: <20251225023043.18579-5-sj@kernel.org>
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
access_pattern/ directory, subdirectories of access_pattern/ directory
are not cleaned up. As a result, DAMON sysfs interface is nearly broken
until the system reboots, and the memory for the unremoved directory is
leaked.

Cleanup the directories under such failures.

Fixes: 9bbb820a5bd5 ("mm/damon/sysfs: support DAMOS quotas")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 7f14e0d3e7a0..19bc2288cd68 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2193,7 +2193,7 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 		return err;
 	err = damos_sysfs_set_dests(scheme);
 	if (err)
-		goto put_access_pattern_out;
+		goto rmdir_put_access_pattern_out;
 	err = damon_sysfs_scheme_set_quotas(scheme);
 	if (err)
 		goto put_dests_out;
@@ -2231,7 +2231,8 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 put_dests_out:
 	kobject_put(&scheme->dests->kobj);
 	scheme->dests = NULL;
-put_access_pattern_out:
+rmdir_put_access_pattern_out:
+	damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
 	kobject_put(&scheme->access_pattern->kobj);
 	scheme->access_pattern = NULL;
 	return err;
-- 
2.47.3

