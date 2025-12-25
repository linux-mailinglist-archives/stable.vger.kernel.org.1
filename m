Return-Path: <stable+bounces-203389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6A0CDD388
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 03:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4F973018F6A
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 02:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C34D25FA29;
	Thu, 25 Dec 2025 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUXab2yI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F23A1E89;
	Thu, 25 Dec 2025 02:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766629849; cv=none; b=ghuyCaqvwYudlp8JlIFyhAND3h6ix7dZ3HkvHHAw8Jk2AQZOD7gL9SiV1MmAtx8E2OOtphgkWRj1GIE2Z86lqDdo1jxIYj0LSsw+BHRsbeDz3TAiDsXTnLvB6xlv2GJrLUFN1Jl4f511EA8Uo/VXYI5GC3t5Wtfxrwx3h0eAEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766629849; c=relaxed/simple;
	bh=LLOqG5vJD2kR91TBM/mg3jWQ7kJeBAaIMsgcTlsWvik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IVgvUca/LV9xcE63i3Kc8gzxAiPIAlBkHzUzrgp414MFK1DeBbgBRCR3yJhRM6ir01hJ9zUs1UPeAFE24IWlB7ShJi2wc2OZKCYkNVMZgiEYsRt2qdUixwNMcQ51wbhZvBMgUSq07FXmX3P2yDKH0X55sKllmte1b2gpgXymrVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUXab2yI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E81C4CEF7;
	Thu, 25 Dec 2025 02:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766629848;
	bh=LLOqG5vJD2kR91TBM/mg3jWQ7kJeBAaIMsgcTlsWvik=;
	h=From:To:Cc:Subject:Date:From;
	b=RUXab2yIuBOMci7cc9iezVq72mrNsBVZb7cEhAbu1Qf9jSt0ZNxESa93MDIVT7htp
	 UCXXjO1UCr7Vz+4EaYLSb68bFBwONozQyyZkrEgvUtIPvYn5lzqAPFr2kZkLRSfX6b
	 MKXtdBremFdJtkl4zPGiaaGUFh0Az01m+hCNwsXrVu7vrwJB04wQMrQm9YQXPkopwq
	 xxPl24wcX3bTsuu47IKz5mFLQaZdu1paz4Khm90Qe9Uz/KuIAJeLno04ag35dUvaNy
	 +3mQZAxzoozySxXbgVkI/yHAuQyD41p3+tAndprYVLImmIgRaJq8nZMqsBUnj+Zcb5
	 Eo4AH32/22J3g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/4] mm/damon/sysfs: free setup failures generated zombie sub-sub dirs
Date: Wed, 24 Dec 2025 18:30:33 -0800
Message-ID: <20251225023043.18579-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some DAMON sysfs directory setup functions generates its sub and sub-sub
directories.  For example, 'monitoring_attrs/' directory setup creates
'intervals/' and 'intervals/intervals_goal/' directories under
'monitoring_attrs/' directory.  When such sub-sub directories are
successfully made but followup setup is failed, the setup function
should recursively clean up the subdirectories.

However, such setup functions are only dereferencing sub directory
reference counters.  As a result, under certain setup failures, the
sub-sub directories keep having non-zero reference counters.   It means
the directories cannot be removed like zombies, and the memory for the
directories cannot be freed.

The user impact of this issue is limited due to the following reasons.

When the issue happens, the zombie directories are still taking the
path.  Hence attempts to generate the directories again will fail,
without additional memory leak.  This means the upper bound memory leak
is limited.  Nonetheless this also implies controlling DAMON with a
feature that requires the setup-failed sysfs files will be impossible
until the system reboots.

Also, the setup operations are quite simple.  The certain failures would
hence only rarely happen, and are difficult to artificially trigger.

SeongJae Park (4):
  mm/damon/sysfs: cleanup intervals subdirs on attrs dir setup failure
  mm/damon/sysfs: cleanup attrs subdirs on context dir setup failure
  mm/damon/sysfs-scheme: cleanup quotas subdirs on scheme dir setup
    failure
  mm/damon/sysfs-scheme: cleanup access_pattern subdirs on scheme dir
    setup failure

 mm/damon/sysfs-schemes.c | 10 ++++++----
 mm/damon/sysfs.c         |  9 ++++++---
 2 files changed, 12 insertions(+), 7 deletions(-)


base-commit: 6d039da6a260dd7919bebc70ebb65d250bb9c24e
-- 
2.47.3

