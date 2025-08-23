Return-Path: <stable+bounces-172536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AAEB32659
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 03:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ACF3B60591
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 01:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0331F03D5;
	Sat, 23 Aug 2025 01:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5x/pLLw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0137117B50A
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 01:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755914355; cv=none; b=dFiFqhqrUt0fUgHwCRVAkChv0vBU73SKxzrSvFDTgh3pbeOqEQRCEA8v50386pdOlhuHzVdQYOyZioxh/9W2MWkF1rv9ScGeoeAvZLM3ENWt3xM7i4vnCplw9DkPbM5o2NPe+v63dZNv6shTaZl7iYJN5hfAswK6i0MdNHY6pLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755914355; c=relaxed/simple;
	bh=7I4xZB5+2uFwXAoFmdQfjOU6f9vr5m0RbDhrJWa2RNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJcRC7PdNoXMbsMjWlUByaReOR0m7B8esb/qN+7GWnb3r4VnN/UeZp2vpH9o2eGHj6vp16xgZRFTsxyJLbaDISyQhT9ptQF/i4dSodjGUhwqcwwc1RbMdVMA1VB8kqg2Jwpo9YKaDIrMN813IqyVUxqHs4wZQMoWtTdfdQ4RotI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5x/pLLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A832C4CEF4;
	Sat, 23 Aug 2025 01:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755914354;
	bh=7I4xZB5+2uFwXAoFmdQfjOU6f9vr5m0RbDhrJWa2RNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5x/pLLwCaLWYy7YM5TC/Y7KvFBjQDZHJ8QF4TKhfd6UIvRM0VipgKGi/XIrrBSLq
	 FRsu/X+avZywffHWY6rrbwvWdx4B8hIxovkTvaWi66iF6yQVssE5ZNujOHYOGhniIq
	 RVWzWQqVvrZFAPsLZgg/tEhKtBnVEgdT8MmWIVX3G4mJz+hsEWPuLlxMNImr0s05Lr
	 BdICWKEQdcz/L39ftf8Yz7XNJTqz8ujEm8OkG7Vczqz/+BZuU48t2qunVriNloYiw4
	 bLzatH0RdsEyp6REywsxBG88EZdyWnFU791B65inJqIzZ9kWYO9rW0g3ydUrT0h3HV
	 ZXaEW+/V5J//g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/2] media: v4l2-ctrls: always copy the controls on completion
Date: Fri, 22 Aug 2025 21:59:11 -0400
Message-ID: <20250823015912.1675214-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082154-botany-sandstone-7eeb@gregkh>
References: <2025082154-botany-sandstone-7eeb@gregkh>
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
index 7ac7a5063fb2..4e64d9e61381 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -3529,8 +3529,19 @@ v4l2_ctrls_find_req_obj(struct v4l2_ctrl_handler *hdl,
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
@@ -3541,8 +3552,8 @@ v4l2_ctrls_find_req_obj(struct v4l2_ctrl_handler *hdl,
 	if (!ret)
 		ret = v4l2_ctrl_request_bind(req, new_hdl, hdl);
 	if (ret) {
+		v4l2_ctrl_handler_free(new_hdl);
 		kfree(new_hdl);
-
 		return ERR_PTR(ret);
 	}
 
@@ -4113,8 +4124,25 @@ void v4l2_ctrl_request_complete(struct media_request *req,
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


