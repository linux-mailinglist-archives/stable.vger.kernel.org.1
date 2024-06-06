Return-Path: <stable+bounces-49245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F93D8FEC7B
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C111F29971
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1F619B3C9;
	Thu,  6 Jun 2024 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LFdvaKCh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C919AD5C;
	Thu,  6 Jun 2024 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683372; cv=none; b=Fmdl1BiuT7JKbmvgEHwnrPz0j1jpZK6Hiz2EuUht0Fe1xbzQMGWywdp9e2heaXo9V4i1zEMO1tDA4LR/nqZ4aEoPS5gVUbsB8GKAQQttNiCLET675yK7iqY5nNAfMKUITozRUSEG+39Ol0n6k2N4mnUsUSvJbavnESwxTUZwl/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683372; c=relaxed/simple;
	bh=Zd5LAgAfQZojQdKpaDkuTOl44iPSmhsv9mHH6tGHjfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdVG3BHovKiTj3XAlXh5cLvQLuaQGfEA1kZk5HjajWhKCz+wLmGvfGJUldCx1jfIIK1/AZVVm6228wedkJoxkrcsPtREccnlcxjpGD+8OhMCDf4gaOaPw/G3Ux9YBPNJbUrzav3sAKcvkLuuEAp/dxOmF0md84Kc4HxhEuCJKGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LFdvaKCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD345C4AF07;
	Thu,  6 Jun 2024 14:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683371;
	bh=Zd5LAgAfQZojQdKpaDkuTOl44iPSmhsv9mHH6tGHjfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LFdvaKChVeaFuDMnl9RHu6JKAtq0tdhUY2raLCnIQe7X6LsM7gHzzN3xUErun/JCs
	 UKD5G+Ppi43A3IeiITgO+Opg0ZZZkY3FtOelwUbPbAGsByaKPX3Zad+LRF5sEc7VGP
	 /4gVEP3FBPuypoGEMAHuvAOy5bnxCr05d6pyGl5w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 313/744] media: v4l2-subdev: Fix stream handling for crop API
Date: Thu,  6 Jun 2024 15:59:45 +0200
Message-ID: <20240606131742.457081795@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 34d7bf1c8e59f5fbf438ee32c96389ebe41ca2e8 ]

When support for streams was added to the V4L2 subdev API, the
v4l2_subdev_crop structure was extended with a stream field, but the
field was not handled in the core code that translates the
VIDIOC_SUBDEV_[GS]_CROP ioctls to the selection API. Fix it.

Fixes: 2f91e10ee6fd ("media: subdev: add stream based configuration")
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 31752c06d1f0c..ee159b4341abc 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -664,6 +664,7 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
 		memset(&sel, 0, sizeof(sel));
 		sel.which = crop->which;
 		sel.pad = crop->pad;
+		sel.stream = crop->stream;
 		sel.target = V4L2_SEL_TGT_CROP;
 
 		rval = v4l2_subdev_call(
@@ -688,6 +689,7 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
 		memset(&sel, 0, sizeof(sel));
 		sel.which = crop->which;
 		sel.pad = crop->pad;
+		sel.stream = crop->stream;
 		sel.target = V4L2_SEL_TGT_CROP;
 		sel.r = crop->rect;
 
-- 
2.43.0




