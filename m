Return-Path: <stable+bounces-168771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DAEB2368E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F64680421
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06712FF14D;
	Tue, 12 Aug 2025 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U5+ftDEB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1332FDC49;
	Tue, 12 Aug 2025 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025276; cv=none; b=uvyLizgCr0tEx87ub+LRYjleAzEOLGYXsL//utowAdbTPFhxzV1he+LrcT6xmkELRAABZr2vzhkixLRLsbJBpzxoUbgKHhKCLkA4mhvtYzbPBt3RSNHI7n/AjcNX/0rGbpi3zD22M7W4Q/xN9Ci/q9AWyD7RYVHjqNDrZPLJKHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025276; c=relaxed/simple;
	bh=5tfEzmTyTHTLt8Zti9HFId5A1ZN4yo+A9kreRrRHoTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1vzV8a8JwoiE/ggXChtz2qQPBifC2QTG4yyJi8L9lQ34ZbAEHWlG4hWHQ/Dxlfn3BqbgIN3hYy+QxA0DBMN9zgIFDQfDWgX9N4D+aW7sz/e/oPj25JMsGrHvpnlioGPnb2aw5IBrmOYw3kZ8kdphmaKwE+JfychnnyN2vY2a7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U5+ftDEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5A2C4CEF0;
	Tue, 12 Aug 2025 19:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025276;
	bh=5tfEzmTyTHTLt8Zti9HFId5A1ZN4yo+A9kreRrRHoTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5+ftDEBX6r8clOe629lSsOtR2iWpseIXjGe0TRE/y8MsMuNTbXhvNufj3uyDPGiQ
	 8p5pSDTH9saKm4G0FE5GCJvZ1wDQYYEr80Le+29jkwxDS5FsCST73ziw/C1zpFrxOE
	 l0mROOXh1ttMcuedZve2RDjdh+PZKLds0RdEUaDk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH 6.16 621/627] USB: gadget: f_hid: Fix memory leak in hidg_bind error path
Date: Tue, 12 Aug 2025 19:35:16 +0200
Message-ID: <20250812173455.503888407@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuhao Jiang <danisjiang@gmail.com>

commit 62783c30d78aecf9810dae46fd4d11420ad38b74 upstream.

In hidg_bind(), if alloc_workqueue() fails after usb_assign_descriptors()
has successfully allocated the USB descriptors, the current error handling
does not call usb_free_all_descriptors() to free the allocated descriptors,
resulting in a memory leak.

Restructure the error handling by adding proper cleanup labels:
- fail_free_all: cleans up workqueue and descriptors
- fail_free_descs: cleans up descriptors only
- fail: original cleanup for earlier failures

This ensures that allocated resources are properly freed in reverse order
of their allocation, preventing the memory leak when alloc_workqueue() fails.

Fixes: a139c98f760ef ("USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
Link: https://lore.kernel.org/r/20250623094844.244977-1-danisjiang@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_hid.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1278,18 +1278,19 @@ static int hidg_bind(struct usb_configur
 
 	if (!hidg->workqueue) {
 		status = -ENOMEM;
-		goto fail;
+		goto fail_free_descs;
 	}
 
 	/* create char device */
 	cdev_init(&hidg->cdev, &f_hidg_fops);
 	status = cdev_device_add(&hidg->cdev, &hidg->dev);
 	if (status)
-		goto fail_free_descs;
+		goto fail_free_all;
 
 	return 0;
-fail_free_descs:
+fail_free_all:
 	destroy_workqueue(hidg->workqueue);
+fail_free_descs:
 	usb_free_all_descriptors(f);
 fail:
 	ERROR(f->config->cdev, "hidg_bind FAILED\n");



