Return-Path: <stable+bounces-71104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 428A09611A7
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734541C234B8
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AE81C68BD;
	Tue, 27 Aug 2024 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VUA2wOYF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94681BC9E3;
	Tue, 27 Aug 2024 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772113; cv=none; b=GHymKZaB4gJzcgSQFgDoT6zB3NrH/7fogFcWldZ3ZyntrI+G5JAeMHPJGNaprl4n7yTlR7K9vZdw6N1EYwHyE1mSvrqrql5TPW5783z11wJcu1tWBvgjw6WDfFtfEKZVqQPu9QiTbS2gE6dPy8XWyustg7Dt4ylnE4IMCVyrWNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772113; c=relaxed/simple;
	bh=dq0FsvhSUB6Vpvk7UdvcgP2X2lJb8GjKIwRbcMcC4W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R19Ga7VoFB/QBwHnprlG575Sfeld60dAhqwVaKO8qsNBSbARKxXSWpZz01t6P4qdg4kgUKzt5r96+MAa1pvsfe+LQZxBzItVcQS73f5GNVQ6WYhL+2bir2T4o/82PBQf2g0ZkdZwzsAmdROtiejYsy1iLbvyLG8E6w/tjHiNexk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VUA2wOYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE75C4FE08;
	Tue, 27 Aug 2024 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772113;
	bh=dq0FsvhSUB6Vpvk7UdvcgP2X2lJb8GjKIwRbcMcC4W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUA2wOYFc6Oodc9Ro5XCNRuWccrHqj8Kh3zVr3zX6T9YWjHtbyF2NJvUHQgSveBQh
	 bNH6WXDHonJ1YMJnqgPhhpLBfcAxg4zbb7gEWLbAKqZmCYCm0bzb/ELGvNSXkyt6ZU
	 FG8kzFB7JRemYHGj25s5O0fw6TMXuwqWuQyi2zcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 118/321] cgroup: Avoid extra dereference in css_populate_dir()
Date: Tue, 27 Aug 2024 16:37:06 +0200
Message-ID: <20240827143842.734988379@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamalesh Babulal <kamalesh.babulal@oracle.com>

[ Upstream commit d24f05987ce8bf61e62d86fedbe47523dc5c3393 ]

Use css directly instead of dereferencing it from &cgroup->self, while
adding the cgroup v2 cft base and psi files in css_populate_dir(). Both
points to the same css, when css->ss is NULL, this avoids extra deferences
and makes code consistent in usage across the function.

Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 489c25713edcb..455f67ff31b57 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1751,13 +1751,13 @@ static int css_populate_dir(struct cgroup_subsys_state *css)
 
 	if (!css->ss) {
 		if (cgroup_on_dfl(cgrp)) {
-			ret = cgroup_addrm_files(&cgrp->self, cgrp,
+			ret = cgroup_addrm_files(css, cgrp,
 						 cgroup_base_files, true);
 			if (ret < 0)
 				return ret;
 
 			if (cgroup_psi_enabled()) {
-				ret = cgroup_addrm_files(&cgrp->self, cgrp,
+				ret = cgroup_addrm_files(css, cgrp,
 							 cgroup_psi_files, true);
 				if (ret < 0)
 					return ret;
-- 
2.43.0




