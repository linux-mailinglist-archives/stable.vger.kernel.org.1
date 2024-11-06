Return-Path: <stable+bounces-90980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AEC9BEBE9
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A92B1F23CD6
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6252C1F9EBF;
	Wed,  6 Nov 2024 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="biyITeqS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4A1E0B7B;
	Wed,  6 Nov 2024 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897385; cv=none; b=sXBOWp3802OogD06fidwq7yiz8tq7CbPm6K9Mk4fugMSk2IHUy0v+vThVLAgmz2EAQA9AF4NP9t6AAdfxfHdPTnbK2WR9urNQrJkZ0W+N6M8727bgz3oanc5QMo8T77HYDZiUtmDaKiftA01ukw4T7qGM/Bk8sa5n1AMbw0xhjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897385; c=relaxed/simple;
	bh=sJWoqSMYAseeYyOKm7AM7Ix6lwdvyEcQHeRRWlRfFfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GsyHefqkYmj0j/ZUUsyboSt6uHUow/be9KVIgqWvV6plMMJju0sUcOm7xb7YMCJ0owULne9wxYuJmgt1+ydxuB1HNHG+kVCD9DQTeQ2Q0PscP7mbYarEUWBUGzyqLgMQkUhZB9EnAsHJTlRyHQkWLo7MvJWW1wvIb7LN6q6B/kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=biyITeqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BFAC4CECD;
	Wed,  6 Nov 2024 12:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897385;
	bh=sJWoqSMYAseeYyOKm7AM7Ix6lwdvyEcQHeRRWlRfFfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=biyITeqSpoLpsgAeZgia6Kfi53BxXyHkQpvSSuNVBiYNk5n30ROHBjY6ACqgBkKH9
	 lgws+c7MAH2NcGAZF38wo2zCkGN4LmORMgBM361GU8M06BA1Z5SjWTf/MJMot1kWWI
	 6Pb3QKmPWqepvz2w8vyKJEv9EtSlPD1bITu95R2s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 006/151] cgroup: Fix potential overflow issue when checking max_depth
Date: Wed,  6 Nov 2024 13:03:14 +0100
Message-ID: <20241106120309.015631273@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiu Jianfeng <xiujianfeng@huawei.com>

[ Upstream commit 3cc4e13bb1617f6a13e5e6882465984148743cf4 ]

cgroup.max.depth is the maximum allowed descent depth below the current
cgroup. If the actual descent depth is equal or larger, an attempt to
create a new child cgroup will fail. However due to the cgroup->max_depth
is of int type and having the default value INT_MAX, the condition
'level > cgroup->max_depth' will never be satisfied, and it will cause
an overflow of the level after it reaches to INT_MAX.

Fix it by starting the level from 0 and using '>=' instead.

It's worth mentioning that this issue is unlikely to occur in reality,
as it's impossible to have a depth of INT_MAX hierarchy, but should be
be avoided logically.

Fixes: 1a926e0bbab8 ("cgroup: implement hierarchy limits")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 660817c125e73..b927f0623ac77 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5697,7 +5697,7 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 {
 	struct cgroup *cgroup;
 	int ret = false;
-	int level = 1;
+	int level = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
 
@@ -5705,7 +5705,7 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 		if (cgroup->nr_descendants >= cgroup->max_descendants)
 			goto fail;
 
-		if (level > cgroup->max_depth)
+		if (level >= cgroup->max_depth)
 			goto fail;
 
 		level++;
-- 
2.43.0




