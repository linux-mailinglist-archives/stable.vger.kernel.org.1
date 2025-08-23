Return-Path: <stable+bounces-172534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D653B32642
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 03:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CFEF7A9816
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 01:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD6B17C21C;
	Sat, 23 Aug 2025 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avsQ4ivx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B41613D521
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 01:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755913583; cv=none; b=JJUd07Hv8ymiAq7OQKKtStNgvzlJJ+E9dNscXN2qw4/+fcHnnsEg2fMCAojyH2png0xXN4QgjCt8vbEiP+C+hTrmFW61h1OeDUV/Itfpp6z+ip61JUrDaLkMXfwx3CL4XDFs53+D1LbXaPYdWIdytuGVwejfCPg1HfqGkAp7qtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755913583; c=relaxed/simple;
	bh=LfndtzMFxMwXB8gIDivmnDq1D9lKeIS5F3FeHNcN9uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vB0YV8p/ZT0phNUtFBJR9o/6mUM/acTw+xrWb3eO6RgOsEKJ5OiIDgP/4Sd5RvjoU5nRE+tz2GglmeWEUnoBB52Vrc7CrPSjr6m+5/l1M+12nSBXvO1wXK0LfnFUVizzrChl9igjx4B6TLr1K/G++oIvwixl3XGV6A3oekOATDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avsQ4ivx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24111C4CEED;
	Sat, 23 Aug 2025 01:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755913582;
	bh=LfndtzMFxMwXB8gIDivmnDq1D9lKeIS5F3FeHNcN9uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=avsQ4ivxR0Vxy43vcI+eAGmKZg3DuKy0yivAy5E11pBRC07WazLIU3oaZ+BQSSj6v
	 lQXX9OyihNlIY7pErfUZsivhwoWbOfqy/Thxp5unoKplcQAItnoOMI5g0ba0azs+wD
	 6bbfMXmvbb6sll5L2m/nNhi1ZlkkJt4vJxidtZRewqLgs8Amr4tzMX6XS4A+iD1SxT
	 P7Y/6GypBhU6AUyIA7H8upYEH7U8DPe3VeuIGLT9R4id7or1M8aoUEVQi4GtxuVLGQ
	 q1ZQbJ6TgTGPhprdrA8VNCjf8mpk+HzrQM+HiNt252GIiadeFWHiiV6bWcQodg98o5
	 CQafk/+uLDihw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] media: v4l2-ctrls: always copy the controls on completion
Date: Fri, 22 Aug 2025 21:46:18 -0400
Message-ID: <20250823014619.1670865-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082153-curliness-sitting-639b@gregkh>
References: <2025082153-curliness-sitting-639b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit c3bf5129f33923c92bf3bddaf4359b7b25ecb4ba ]

When v4l2_ctrl_request_complete() is called and there is no control
handler object found in the request, then create such an object so
that all controls at completion state can be stored and are available
to userspace.

Otherwise any attempt by userspace to read the completed request data
will fail.

If allocating the control handler object failed, then indicate that
by returning ENOMEM when attempting to get the controls from the
completed request instead of returning ENOENT.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: 5a0400aca5fa ("media: v4l2-ctrls: Don't reset handler's error in v4l2_ctrl_handler_free()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 36 ++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 41f8410d08d6..a84136f76d8e 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -3767,8 +3767,19 @@ v4l2_ctrls_find_req_obj(struct v4l2_ctrl_handler *hdl,
 	obj = media_request_object_find(req, &req_ops, hdl);
 	if (obj)
 		return obj;
+	/*
+	 * If there are no controls in this completed request,
+	 * then that can only happen if:
+	 *
+	 * 1) no controls were present in the queued request, and
+	 * 2) v4l2_ctrl_request_complete() could not allocate a
+	 *    control handler object to store the completed state in.
+	 *
+	 * So return ENOMEM to indicate that there was an out-of-memory
+	 * error.
+	 */
 	if (!set)
-		return ERR_PTR(-ENOENT);
+		return ERR_PTR(-ENOMEM);
 
 	new_hdl = kzalloc(sizeof(*new_hdl), GFP_KERNEL);
 	if (!new_hdl)
@@ -3779,8 +3790,8 @@ v4l2_ctrls_find_req_obj(struct v4l2_ctrl_handler *hdl,
 	if (!ret)
 		ret = v4l2_ctrl_request_bind(req, new_hdl, hdl);
 	if (ret) {
+		v4l2_ctrl_handler_free(new_hdl);
 		kfree(new_hdl);
-
 		return ERR_PTR(ret);
 	}
 
@@ -4369,8 +4380,25 @@ void v4l2_ctrl_request_complete(struct media_request *req,
 	 * wants to leave the controls unchanged.
 	 */
 	obj = media_request_object_find(req, &req_ops, main_hdl);
-	if (!obj)
-		return;
+	if (!obj) {
+		int ret;
+
+		/* Create a new request so the driver can return controls */
+		hdl = kzalloc(sizeof(*hdl), GFP_KERNEL);
+		if (!hdl)
+			return;
+
+		ret = v4l2_ctrl_handler_init(hdl, (main_hdl->nr_of_buckets - 1) * 8);
+		if (!ret)
+			ret = v4l2_ctrl_request_bind(req, hdl, main_hdl);
+		if (ret) {
+			v4l2_ctrl_handler_free(hdl);
+			kfree(hdl);
+			return;
+		}
+		hdl->request_is_queued = true;
+		obj = media_request_object_find(req, &req_ops, main_hdl);
+	}
 	hdl = container_of(obj, struct v4l2_ctrl_handler, req_obj);
 
 	list_for_each_entry(ref, &hdl->ctrl_refs, node) {
-- 
2.50.1


