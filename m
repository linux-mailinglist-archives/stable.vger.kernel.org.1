Return-Path: <stable+bounces-172537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABC2B32658
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 03:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418D7567752
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 01:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349081EB5FD;
	Sat, 23 Aug 2025 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnwuXE90"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52FC2C190
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 01:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755914356; cv=none; b=jYiV1mI2kct7w3CwY4q61HdEagMEtV3NEBTo5coEAdubWhcMNWcYP7K27yLXRT9B3lwA/4PwCOTLbkloOVXZ9LXceqWlLgPF4lbUHxKU4JbId5kjVqgd7DVvJrLLPx8lCJMcgE5pkAOtHYVd9u7sqSs53TcBX42I/sk8MD+cJ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755914356; c=relaxed/simple;
	bh=Ybd/ToQ9HImEFkZrkjQE69OGrqQgolrf0YNCp5yOL8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0qzEshb3/p7Lj9wycgjXLIswjR7cw2XK3RjIPtuVUpnWtOwdRuIJHumteih1iR6m6nx7BrWnh9NNF8knvutJvoXFWKpmc10b2SEnkDRICYdw0qErpdnXUAhPZwuqUDy2h8KSDbvxz0CFbnn3OIQY15nblnLaPddXsVr2WvPqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnwuXE90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65FAC4CEED;
	Sat, 23 Aug 2025 01:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755914355;
	bh=Ybd/ToQ9HImEFkZrkjQE69OGrqQgolrf0YNCp5yOL8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cnwuXE90XcuhnbnJYjBmETQbg0jBRtiHYfW6JCIUbpjzJZE1QCDX+Bbtgia+oZ0BB
	 19RZU89RoG5E+wf1DMcu0rM4snv7b4YNEAB/QjlEhG9Ev97zpLdxS0aRRyPds08lZe
	 /PjSZVgAQWAVaGJy+cAncD7ZfPDqwPOl41kou9dKrjRgdTISxVfv+Ug71018vEE/mZ
	 kHwfalE1T+rPOXDmNevnxb/BhjXoKWiLy/LlHGiJS6gz8mgA2OkpGHgNc+hmupwCvr
	 F3+y6JkCNwOz+MjVZsVdh5CkBBN7DdfNEWQ7V7XY5ZQKm5d1qTPkmipJ4s6DnpO4+D
	 ESQvCWYfPXYAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 2/2] media: v4l2-ctrls: Don't reset handler's error in v4l2_ctrl_handler_free()
Date: Fri, 22 Aug 2025 21:59:12 -0400
Message-ID: <20250823015912.1675214-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823015912.1675214-1-sashal@kernel.org>
References: <2025082154-botany-sandstone-7eeb@gregkh>
 <20250823015912.1675214-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 5a0400aca5fa7c6b8ba456c311a460e733571c88 ]

It's a common pattern in drivers to free the control handler's resources
and then return the handler's error code on drivers' error handling paths.
Alas, the v4l2_ctrl_handler_free() function also zeroes the error field,
effectively indicating successful return to the caller.

There's no apparent need to touch the error field while releasing the
control handler's resources and cleaning up stale pointers. Not touching
the handler's error field is a more certain way to address this problem
than changing all the users, in which case the pattern would be likely to
re-emerge in new drivers.

Do just that, don't touch the control handler's error field in
v4l2_ctrl_handler_free().

Fixes: 0996517cf8ea ("V4L/DVB: v4l2: Add new control handling framework")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Hans Verkuil <hverkuil@xs4all.nl>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
[ v4l2-ctrls.c => v4l2-ctrls-core.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 4e64d9e61381..d17b40bebf6f 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -2187,7 +2187,6 @@ void v4l2_ctrl_handler_free(struct v4l2_ctrl_handler *hdl)
 	kvfree(hdl->buckets);
 	hdl->buckets = NULL;
 	hdl->cached = NULL;
-	hdl->error = 0;
 	mutex_unlock(hdl->lock);
 	mutex_destroy(&hdl->_lock);
 }
-- 
2.50.1


