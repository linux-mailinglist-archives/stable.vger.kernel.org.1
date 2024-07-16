Return-Path: <stable+bounces-60004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7802F932CF3
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E7BB213D8
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC5419DFB3;
	Tue, 16 Jul 2024 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gmHfzpmw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0E1DA4D;
	Tue, 16 Jul 2024 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145564; cv=none; b=Cqudh7HBMPl1vCCUT2rZoQS/p3oJ6k+Eoh6uESlHXySTwW9GEfkFP7ezFAOP73YrRyUUEkpBR83kVUz6hzbrlWOz1ukyGKERao5Z0YEoq2CABRomlW7cDKUB/rFp8T0pNIeavfQjPMgg7FODYuCA6LwsYMdOQ8Q9JEOjfR8KcSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145564; c=relaxed/simple;
	bh=BiTu1aSh/gYGxaGECDoVBlzJkW5LqI+wdI+Z7Lx5dC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umHs7CfjbHSXYx2cNSx8VRRfnYIFZONy2Rfybw6MDAAtwRlDL7DuP1bDFgGFQQNMp8uPIFgPqYZy117w51i0WoGQODsItP3mL1vjjb3IYi1K+rtZCS/ynPDKpO88E+FPhn6JripMjc4tR3LodhX2Ov8nJ4CzjVoMFK+p3U6UBLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gmHfzpmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13348C116B1;
	Tue, 16 Jul 2024 15:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145564;
	bh=BiTu1aSh/gYGxaGECDoVBlzJkW5LqI+wdI+Z7Lx5dC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gmHfzpmw6eUtRn3Qz5AzeaoeY2RWEDo7/lcyFcO3uYf4G1g+LjX58pLxFDT3TUu+B
	 2YSCT0zCIFFUlYLGanEWD4f8uIfPd+FJwsC2zIdsyLlDjSLl92pY7yj0NMppdpu2BS
	 3dTfM3H8+/03G0ETEwPbBcsMaf1ykS9V6Qe5oDVI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Baokun Li <libaokun1@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jia Zhu <zhujia.zj@bytedance.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 011/121] cachefiles: add missing lock protection when polling
Date: Tue, 16 Jul 2024 17:31:13 +0200
Message-ID: <20240716152751.754071133@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152751.312512071@linuxfoundation.org>
References: <20240716152751.312512071@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jingbo Xu <jefflexu@linux.alibaba.com>

[ Upstream commit cf5bb09e742a9cf6349127e868329a8f69b7a014 ]

Add missing lock protection in poll routine when iterating xarray,
otherwise:

Even with RCU read lock held, only the slot of the radix tree is
ensured to be pinned there, while the data structure (e.g. struct
cachefiles_req) stored in the slot has no such guarantee.  The poll
routine will iterate the radix tree and dereference cachefiles_req
accordingly.  Thus RCU read lock is not adequate in this case and
spinlock is needed here.

Fixes: b817e22b2e91 ("cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Link: https://lore.kernel.org/r/20240628062930.2467993-10-libaokun@huaweicloud.com
Acked-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/daemon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 06cdf1a8a16f6..89b11336a8369 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -366,14 +366,14 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 
 	if (cachefiles_in_ondemand_mode(cache)) {
 		if (!xa_empty(&cache->reqs)) {
-			rcu_read_lock();
+			xas_lock(&xas);
 			xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
 				if (!cachefiles_ondemand_is_reopening_read(req)) {
 					mask |= EPOLLIN;
 					break;
 				}
 			}
-			rcu_read_unlock();
+			xas_unlock(&xas);
 		}
 	} else {
 		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
-- 
2.43.0




