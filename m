Return-Path: <stable+bounces-172535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6357BB32643
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 03:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D21173531
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 01:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4B1C84B2;
	Sat, 23 Aug 2025 01:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6FoPF/3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158313D521
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755913584; cv=none; b=C7KkAJtvJ7YR3MCBZGSvy7oAioM9pvTu8KAvt5F3Cra0HxxuCZnFJPAeMO7k4xYMl/f8xUjq4Pfcqh05mv602iQWSBo1fERutbjtb/wyHPJzLlYm7T3PIG/Y9x0lujap5Ltb8rS9bsPlBstjoB2GVaIwC8gpY42nxxZ5u5p7axs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755913584; c=relaxed/simple;
	bh=W9tG26ISs+KjWlswxDZmoanlh/iSWeLbmX50/GZR6rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twED+yFVlFi80SIicGKgaaWE6aIxghyL4YaFSV61S6DvACpOcAaIp4p1dO3SK2Oq+we73ycm4GRTbqev+6bgoCsFOxNHXDLRII5mgHGE0/2AtVRzX4+irnw98bF0teObUjCMgBFbPMz2XaVeSdn9SxN1uR7vgxyEaKu9aJPArqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6FoPF/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA96DC4CEF4;
	Sat, 23 Aug 2025 01:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755913583;
	bh=W9tG26ISs+KjWlswxDZmoanlh/iSWeLbmX50/GZR6rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n6FoPF/3aweVF3ktST4O6/fJxzkG4QB7+kseu7ci8gIYydMDxi1INb0/PPCOdqp17
	 QWgGECCS61tU9euI6yw33FDU2DmWpR7ZWlLn8a+BGBEXl04gSN6WYu8ixxlOIqLgV3
	 UlbL3lgh1cPZ/dXh9NPLOUf2yt1WZJyN3kPXFPAh5dx/uGzXmG9HXWLND8r9/ooBrR
	 07plajLxjOpBcAYn0/7UmTFjw6sWrljlIGPeEaZCQkEXGZoa9d+WCIOhd9W6eQ7N68
	 5G6KMe+7PZ06t/vDqH4ZKpLaIbpfqfl2RCgg96951cHxcSTToEnBBkAamgxU4sdcQ8
	 dhX4H/N6CC/BQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] media: v4l2-ctrls: Don't reset handler's error in v4l2_ctrl_handler_free()
Date: Fri, 22 Aug 2025 21:46:19 -0400
Message-ID: <20250823014619.1670865-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823014619.1670865-1-sashal@kernel.org>
References: <2025082153-curliness-sitting-639b@gregkh>
 <20250823014619.1670865-1-sashal@kernel.org>
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
index a84136f76d8e..e754bb2a8a4e 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -2388,7 +2388,6 @@ void v4l2_ctrl_handler_free(struct v4l2_ctrl_handler *hdl)
 	kvfree(hdl->buckets);
 	hdl->buckets = NULL;
 	hdl->cached = NULL;
-	hdl->error = 0;
 	mutex_unlock(hdl->lock);
 	mutex_destroy(&hdl->_lock);
 }
-- 
2.50.1


