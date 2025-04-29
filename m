Return-Path: <stable+bounces-138269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CFEAA173D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11A117A4910
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE8E24BD02;
	Tue, 29 Apr 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PNIdko3Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF131D7E35;
	Tue, 29 Apr 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948719; cv=none; b=JPrlYRocjEL6tgJhiqM0Dlnj1+t7qFV7DILr5gg9Y9N8cs5pc+r0vk6CaC23Gu1eMVDZ+Z8PgECLlGWBBB4+SmNOOHoMMYZ/WRANQYctR2Am88qf7EsJ9uJ+Dml2Ekp+HH8E+ZrT59S7Y7lsjN594ho5dm3HHIvJzxcN0EnqiZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948719; c=relaxed/simple;
	bh=O7wQPOKvoBJJaqTfF3CKJNw6mffg4EF8oMuDiU3Mcl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/JA5KA3MGlQhOkYCoA1aujOgnc3tFde+WvrNKhWDxmwrvikKwJQRHmzYhO6dxnxfXj+bJMaBG94wOy5X1Q96u8cgzh0gL8HhuFSoORdZAAP0xxAO7ISwWD12MjUTcJuHUiaYc+TEhwTJGpXOyACwkSOYN19gxOl1TwRj30vvNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PNIdko3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E9AC4CEE3;
	Tue, 29 Apr 2025 17:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948719;
	bh=O7wQPOKvoBJJaqTfF3CKJNw6mffg4EF8oMuDiU3Mcl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PNIdko3YYfpkYv+uBA5b/I8GP+OWwgOmlqqiHWS4kC5mNquVBwmbKfZWn8UYv+uF8
	 JZSiZl/kzfpzblR9bHY8GYSeDjUzLSKU0S9u5sYg1bKBxZJ7eLNRKUIkAg82/Ly/IO
	 MFOzUfv37oCgkXaIT4JWGgo/lBP9a4wpiuuFKNcw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Majewski <mattwmajewski@gmail.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.15 061/373] media: vim2m: print device name after registering device
Date: Tue, 29 Apr 2025 18:38:58 +0200
Message-ID: <20250429161125.634608500@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1321,9 +1321,6 @@ static int vim2m_probe(struct platform_d
 	vfd->v4l2_dev = &dev->v4l2_dev;
 
 	video_set_drvdata(vfd, dev);
-	v4l2_info(&dev->v4l2_dev,
-		  "Device registered as /dev/video%d\n", vfd->num);
-
 	platform_set_drvdata(pdev, dev);
 
 	dev->m2m_dev = v4l2_m2m_init(&m2m_ops);
@@ -1350,6 +1347,9 @@ static int vim2m_probe(struct platform_d
 		goto error_m2m;
 	}
 
+	v4l2_info(&dev->v4l2_dev,
+		  "Device registered as /dev/video%d\n", vfd->num);
+
 #ifdef CONFIG_MEDIA_CONTROLLER
 	ret = v4l2_m2m_register_media_controller(dev->m2m_dev, vfd,
 						 MEDIA_ENT_F_PROC_VIDEO_SCALER);



