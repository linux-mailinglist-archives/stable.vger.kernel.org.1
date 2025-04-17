Return-Path: <stable+bounces-133876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1899FA927F0
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B399019E711A
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC008255E34;
	Thu, 17 Apr 2025 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A8fltnpq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B96259C8D;
	Thu, 17 Apr 2025 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914413; cv=none; b=n2jz2dPNNp/kiAg2nrtmicAaNCWvbB7IgO+My0jw+sIe7mF3i6De1ek24x8LCgZK+z2NOhxvQxKHMIJKFDfnhaMRDIP0FYyZxz5l3Oxoebv1xLVpVhXoSfZhuQgzxamUnMYBQ5NouuL8eJlmPUFOCSRuKcvBxb3GhFiS2IxmIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914413; c=relaxed/simple;
	bh=HJLOsgiZFwrA9wGFtPPa3CMwj1U4JCqtSefZFF7BD7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rh8Nxu7bCfAwm+i68944rfvUSpV99HzfPePYlGsgWQiUyzWDmdPgYE69yyHYsiCfWZ0e84Awyb2gYmUFc8clYJP1zpIlkQzxU9qR/0F4ZgRjD3+H59cqvv2r+ZQFUsPJshBuFbjcuHq8p2bb7Dlc6snFjaQT7K5fFeTXgJ8nzH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A8fltnpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033B2C4CEE4;
	Thu, 17 Apr 2025 18:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914413;
	bh=HJLOsgiZFwrA9wGFtPPa3CMwj1U4JCqtSefZFF7BD7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8fltnpqxiY+kDnmxrjEjbkZU3OeAKj0E8CXqtiT3rOxi67+YHx85sLfo0UW+ZkXs
	 ANZ9o5bQEjJT1JzYgOEMaN/cp0CrmRpy54EMDEdtnxXl8zIHrwCyqAzC9VVTsVBBEj
	 VeR+TFEriekJ4SmGOzMb13pNsW7p8EF63LfJLBFY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Majewski <mattwmajewski@gmail.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.13 206/414] media: vim2m: print device name after registering device
Date: Thu, 17 Apr 2025 19:49:24 +0200
Message-ID: <20250417175119.730666089@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Majewski <mattwmajewski@gmail.com>

commit 143d75583f2427f3a97dba62413c4f0604867ebf upstream.

Move the v4l2_info() call displaying the video device name after the
device is actually registered.

This fixes a bug where the driver was always displaying "/dev/video0"
since it was reading from the vfd before it was registered.

Fixes: cf7f34777a5b ("media: vim2m: Register video device after setting up internals")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Majewski <mattwmajewski@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/test-drivers/vim2m.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/media/test-drivers/vim2m.c
+++ b/drivers/media/test-drivers/vim2m.c
@@ -1314,9 +1314,6 @@ static int vim2m_probe(struct platform_d
 	vfd->v4l2_dev = &dev->v4l2_dev;
 
 	video_set_drvdata(vfd, dev);
-	v4l2_info(&dev->v4l2_dev,
-		  "Device registered as /dev/video%d\n", vfd->num);
-
 	platform_set_drvdata(pdev, dev);
 
 	dev->m2m_dev = v4l2_m2m_init(&m2m_ops);
@@ -1343,6 +1340,9 @@ static int vim2m_probe(struct platform_d
 		goto error_m2m;
 	}
 
+	v4l2_info(&dev->v4l2_dev,
+		  "Device registered as /dev/video%d\n", vfd->num);
+
 #ifdef CONFIG_MEDIA_CONTROLLER
 	ret = v4l2_m2m_register_media_controller(dev->m2m_dev, vfd,
 						 MEDIA_ENT_F_PROC_VIDEO_SCALER);



