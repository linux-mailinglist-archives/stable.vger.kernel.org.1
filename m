Return-Path: <stable+bounces-186407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DABBE972D
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FCAE740757
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D27B2DC78A;
	Fri, 17 Oct 2025 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fS2RZIxd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2DF337100;
	Fri, 17 Oct 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713153; cv=none; b=ZQuX3d7ZieeN7e8qTtHtunIUYa32iKJQ2VRtSNtQSPLhNCLprlP0z40YihCwtMnVYne9RM6ZEEbkXW9iVqH1+EnsjQsgT8yb/sR0hAaIfOYCRXRVJ7LO/iuqSXX7rZQy24CzR5mioD1meJ9oDdJU/1GByivVBvSQdWc/PbUqlKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713153; c=relaxed/simple;
	bh=yQX1PQKGtBxfqOx64pnzEIcG07r9GM93ixiUjGwXVYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fegutILUKr5uvzDssHgd5pZOvD7A4T4Dc72VWkHn3TP9nTwtkwsiXfy6iPdeGGAnSFs2/80HSZnN/5ibzqmZkLdTPX4V4qNTJ44jDdrxdxblNFGkvd+/gl+uB5K2E7DmdPe68QZOAU45/TraqT/v9XxeGBftp8haR+kgt2qPAcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fS2RZIxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E41C4CEE7;
	Fri, 17 Oct 2025 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760713153;
	bh=yQX1PQKGtBxfqOx64pnzEIcG07r9GM93ixiUjGwXVYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fS2RZIxdpcRLdxXZqu7H2pXlenSbc9FfXvD5dtSJ26O50AjYrECSYbkz+kgsRHoth
	 pI/9uB46NQyu6CQ5b5IWNF5KAe48XoT4VNdrLOaVACTsaOTl4i1DaKIgIrNr/lBnRV
	 DW/7nYCpF2ZEBgcOMKoHsNG09mU+3qBH3MZ0tRok=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.1 067/168] media: lirc: Fix error handling in lirc_register()
Date: Fri, 17 Oct 2025 16:52:26 +0200
Message-ID: <20251017145131.494871803@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145129.000176255@linuxfoundation.org>
References: <20251017145129.000176255@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Ma Ke <make24@iscas.ac.cn>

commit 4f4098c57e139ad972154077fb45c3e3141555dd upstream.

When cdev_device_add() failed, calling put_device() to explicitly
release dev->lirc_dev. Otherwise, it could cause the fault of the
reference count.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: a6ddd4fecbb0 ("media: lirc: remove last remnants of lirc kapi")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/rc/lirc_dev.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -735,11 +735,11 @@ int lirc_register(struct rc_dev *dev)
 
 	cdev_init(&dev->lirc_cdev, &lirc_fops);
 
+	get_device(&dev->dev);
+
 	err = cdev_device_add(&dev->lirc_cdev, &dev->lirc_dev);
 	if (err)
-		goto out_ida;
-
-	get_device(&dev->dev);
+		goto out_put_device;
 
 	switch (dev->driver_type) {
 	case RC_DRIVER_SCANCODE:
@@ -763,7 +763,8 @@ int lirc_register(struct rc_dev *dev)
 
 	return 0;
 
-out_ida:
+out_put_device:
+	put_device(&dev->lirc_dev);
 	ida_free(&lirc_ida, minor);
 	return err;
 }



