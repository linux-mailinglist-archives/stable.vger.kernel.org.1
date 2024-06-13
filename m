Return-Path: <stable+bounces-50772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE95906C94
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA115B20DE5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4656F144D2B;
	Thu, 13 Jun 2024 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ME4WIS/n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05145143861;
	Thu, 13 Jun 2024 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279340; cv=none; b=DZf3TDG1xdw+mfcEnxJwLRuFZrTNyq6ntl8nftJ+TR7ZsW8uu1N0oodB6bTFnmxsHO6oxP12GPJydhoLd10wLclgj3H7a/DFKyzLsyduVcvY1s707o3/GiZzJYtDA8QlFqMJ/ePS/jSJjfA/zAygJ1iufYcc0IUIXdtcRZRX0+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279340; c=relaxed/simple;
	bh=j1yjCuzjsZEDJa4452ZfCZr9f7hKeiDzOxr/rd9w79w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASdG967DPg9jORKV8g7JPJYZGs3YsBrGf9vGrBOw4OgYw4yQ2JWdZysSwdVX0sgXm2gxFZTFQEaoD216e5jrLNXDQsQDdZIRVrpntbRsf3GY8A7XYqvxWGkbU6VUipTLmt9hoOQ9zzzwxzi+r/ccQ4ZQXIr32JVgHUGUMaURBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ME4WIS/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846ADC2BBFC;
	Thu, 13 Jun 2024 11:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279339;
	bh=j1yjCuzjsZEDJa4452ZfCZr9f7hKeiDzOxr/rd9w79w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ME4WIS/nSd+bG86EjBhN4RlF34qpCy00/zwIHTurRb01GI/vQbnXEJkGVQXh90kzZ
	 DcQt8sSVgQ4K5ssUJsXj1u6tiJRw689KbS6SyUZc3WOfkZYam4xyRnGyaQWOybq0sW
	 xAGkUrAV+SFdiaaGWgNfk0jr/OVT7vNdO6YOSYyQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 6.9 042/157] media: v4l: async: Fix notifier list entry init
Date: Thu, 13 Jun 2024 13:32:47 +0200
Message-ID: <20240613113229.052781373@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
References: <20240613113227.389465891@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Stein <alexander.stein@ew.tq-group.com>

commit 6d8acd02c4c6a8f917eefac1de2e035521ca119d upstream.

struct v4l2_async_notifier has several list_head members, but only
waiting_list and done_list are initialized. notifier_entry was kept
'zeroed' leading to an uninitialized list_head.
This results in a NULL-pointer dereference if csi2_async_register() fails,
e.g. node for remote endpoint is disabled, and returns -ENOTCONN.
The following calls to v4l2_async_nf_unregister() results in a NULL
pointer dereference.
Add the missing list head initializer.

Fixes: b8ec754ae4c5 ("media: v4l: async: Set v4l2_device and subdev in async notifier init")
Cc: <stable@vger.kernel.org> # for 6.6 and later
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-async.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -563,6 +563,7 @@ void v4l2_async_nf_init(struct v4l2_asyn
 {
 	INIT_LIST_HEAD(&notifier->waiting_list);
 	INIT_LIST_HEAD(&notifier->done_list);
+	INIT_LIST_HEAD(&notifier->notifier_entry);
 	notifier->v4l2_dev = v4l2_dev;
 }
 EXPORT_SYMBOL(v4l2_async_nf_init);
@@ -572,6 +573,7 @@ void v4l2_async_subdev_nf_init(struct v4
 {
 	INIT_LIST_HEAD(&notifier->waiting_list);
 	INIT_LIST_HEAD(&notifier->done_list);
+	INIT_LIST_HEAD(&notifier->notifier_entry);
 	notifier->sd = sd;
 }
 EXPORT_SYMBOL_GPL(v4l2_async_subdev_nf_init);



